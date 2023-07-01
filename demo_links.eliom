[%%shared
(* This file was generated by Ocsigen Start.
   Feel free to use it, modify it, and redistribute it as you wish. *)
(* Static files demo *)

open Eliom_content.Html.F]

(* Service for this demo *)
let%server service =
  Eliom_service.create
    ~path:(Eliom_service.Path ["demo-static-files"])
    ~meth:(Eliom_service.Get Eliom_parameter.unit) ()

(* Make service available on the client *)
let%client service = ~%service
(* Name for demo menu *)
let%shared name () = [%i18n Demo.S.links_and_static_files]
(* Class for the page containing this demo (for internal use) *)
let%shared page_class = "os-page-demo-links"

(* An example of external service: *)
let%server ocsigen_service =
  Eliom_service.extern ~prefix:"http://ocsigen.org" ~path:[]
    ~meth:(Eliom_service.Get Eliom_parameter.unit) ()

(* Make service available on the client *)
let%client ocsigen_service = ~%ocsigen_service

(* Page for this demo *)
let%shared page () =
  Lwt.return
    [ h1 [%i18n Demo.links_and_static_files]
    ; h2 [%i18n Demo.services]
    ; p
        [%i18n
          Demo.services_1
            ~f1:[code [txt "h42n42_services.eliom"]]
            ~f2:[code [txt "h42n42_handlers.eliom"]]
            ~f3:[code [txt "h42n42.eliom"]]]
    ; h2 [%i18n Demo.links_and_forms]
    ; p
        [%i18n
          Demo.links_and_forms_1
            ~t1:
              [a ~service:Os_services.main_service [%i18n Demo.internal_link] ()]
            ~t2:[a ~service:ocsigen_service [%i18n Demo.external_service] ()]]
    ; h2 [%i18n Demo.static_files]
    ; p
        [%i18n
          Demo.static_files_1
            ~static:[code [txt "static"]]
            ~static_dir:[code [txt "static_dir"]]]
    ; img
        ~a:[a_class ["demo-static-img"]]
        ~alt:"local_img"
        ~src:
          (Eliom_content.Html.F.make_uri
             ~absolute:false (* We want local file on mobile app *)
             ~service:(Eliom_service.static_dir ())
             ["images"; "ocsigen.png"])
        ()
    ; p [%i18n Demo.static_files_2]
    ; img
        ~a:[a_class ["demo-static-img"]]
        ~alt:"distant_img"
        ~src:
          (Eliom_content.Html.F.make_uri
           (* We want a distant file:
                   keep the default value of ~absolute *)
             ~service:(Eliom_service.static_dir ())
             ["images"; "ocsigen.png"])
        () ]
