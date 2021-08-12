Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0150F3EA57C
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhHLNWn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 09:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237556AbhHLNTw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 09:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628774366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaV466qKmDbX32CqXDpoabTK+1tGIC5BVkeekLUlF5I=;
        b=KeUztBo+6+MKv4PEHYzMy1j96+/BuNpiAGoQOdj+Liv10qZ3Q8gpHpjFpjA+OmkUu6taES
        dfgXpPpz/aaEGYQVPgN0LzQLv/SYUo/LWhdc2N1ZVmFbSxrOXsvvZOCDc1TqYTDOes2RyW
        d17xjJDGik0bi2GR6vXpdmAyDWzSa6s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-bhgs66-VNO6jmJB53BmjUg-1; Thu, 12 Aug 2021 09:19:24 -0400
X-MC-Unique: bhgs66-VNO6jmJB53BmjUg-1
Received: by mail-wm1-f72.google.com with SMTP id t12-20020a05600c198c00b002e6bf2ee83dso149011wmq.1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 06:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SaV466qKmDbX32CqXDpoabTK+1tGIC5BVkeekLUlF5I=;
        b=IVXMlOXGRVitxHooDZhlgGzuqFsSgz3+2lOXHKVC61cVJtOGEWsDg7MpcPLibFE/kP
         Vm0A1UGqiw/lGaNkbXXABNcp89o60v/meL+TR9Sg/wwIt3+edlO4DTe3lRhKo+IfI+R3
         FbZAcfz/KnVEEZN9Pk0qZaWJalG24oUOJr1sdOygJVKUNJ62vBlWaKCojSg7OCh04ww0
         DFnVSvjGNrpxiqOFpJVR4hqgTXNbuhScpbxyYnP5/x60zLM2bYwyTa6vOOl+Uz6voXYc
         DWwZrMqQxfH4IoBnvxXqlQ1jfPwckC7cUCf1kBrhqgAxGcBk2J5MpoIHYZm04JPluey+
         cVdQ==
X-Gm-Message-State: AOAM532G3XsJZI2eSMlsWAbEOywQuY15xMtN8XwlnJGgrIh7ryP7lcir
        wiYIPKLIu6pH/Vd6b2LKbrV/zr3CwZDcacbbu1V6ZVUMLGk0aEKHLJ4hexivQQutNxNzF3RsMdT
        QagWrn1jws3vLTKzESCLg
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr3991461wmj.72.1628774363399;
        Thu, 12 Aug 2021 06:19:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+Ot3d6cN9/6Bqx2BnVuZEH2FzpeR6Pi1KUal1sz01qSt3jbElf/EOkJduuATZjeNrEOyKow==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr3991439wmj.72.1628774363210;
        Thu, 12 Aug 2021 06:19:23 -0700 (PDT)
Received: from ajmitchell.remote.csb ([95.145.245.173])
        by smtp.gmail.com with ESMTPSA id u23sm9546627wmc.24.2021.08.12.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 06:19:22 -0700 (PDT)
Message-ID: <76b96fa95dfb6c53f28cae6b622f71559d8bfe6c.camel@redhat.com>
Subject: Re: [PATCH 2/4] nfs-utils: Fix mem leaks in gssd
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Date:   Thu, 12 Aug 2021 14:19:21 +0100
In-Reply-To: <CAN-5tyEbTKQg7dNgNQGi0ysiWZnZmOKQgU5u2hy7ejfHoNZxuQ@mail.gmail.com>
References: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
         <b8b806a99bd53ef9a1e8892f167ea919c52af730.camel@redhat.com>
         <CAN-5tyEbTKQg7dNgNQGi0ysiWZnZmOKQgU5u2hy7ejfHoNZxuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2021-08-06 at 15:12 -0400, Olga Kornievskaia wrote:
> On Fri, Aug 6, 2021 at 12:23 PM Alice Mitchell <ajmitchell@redhat.com
> > wrote:
> > Also fix the modification of a returned config value which
> > should be treated as const.
> > 
> > Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
> > ---
> >  utils/gssd/gssd.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> > index 4113cba..0815665 100644
> > --- a/utils/gssd/gssd.c
> > +++ b/utils/gssd/gssd.c
> > @@ -1016,7 +1016,7 @@ read_gss_conf(void)
> >                 keytabfile = s;
> >         s = conf_get_str("gssd", "cred-cache-directory");
> >         if (s)
> > -               ccachedir = s;
> > +               ccachedir = strdup(s);
> >         s = conf_get_str("gssd", "preferred-realm");
> >         if (s)
> >                 preferred_realm = s;
> > @@ -1070,7 +1070,7 @@ main(int argc, char *argv[])
> >                                 keytabfile = optarg;
> >                                 break;
> >                         case 'd':
> > -                               ccachedir = optarg;
> > +                               ccachedir = strdup(optarg);
> 
> Is it possible that there will be a value in both config file and
> command line args. If we are strdup-ing in both we'll be over-
> writting
> and leaking memory?
> 
> Why do we need to malloc it at all? Is it ever malloc-ed now (and
> considered a leak)? I think in both cases it uses static memory and
> doesnt require freeing.

in both cases the string pointed to gets modified by a later strtok()
and so will be modifying the original of argv or a conf parameter,
which i presume is why there was ccacherdir_copy to avoid doing that,
but it was never properly utilised.

i guess strtok truncating those strings doesnt actually *hurt* anything
right now, its just a case of unexpected side-effects should anyone
later try to reuse them.

> 
> >                                 break;
> >                         case 't':
> >                                 context_timeout = atoi(optarg);
> > @@ -1133,7 +1133,6 @@ main(int argc, char *argv[])
> >         }
> > 
> >         if (ccachedir) {
> > -               char *ccachedir_copy;
> >                 char *ptr;
> > 
> >                 for (ptr = ccachedir, i = 2; *ptr; ptr++)
> > @@ -1141,8 +1140,7 @@ main(int argc, char *argv[])
> >                                 i++;
> > 
> >                 ccachesearch = malloc(i * sizeof(char *));
> > -               ccachedir_copy = strdup(ccachedir);
> > -               if (!ccachedir_copy || !ccachesearch) {
> > +               if (!ccachesearch) {
> 
> ccachedir_copy is the only leak here.
> 
> >                         printerr(0, "malloc failure\n");
> >                         exit(EXIT_FAILURE);
> >                 }
> > @@ -1274,6 +1272,8 @@ main(int argc, char *argv[])
> > 
> >         free(preferred_realm);
> >         free(ccachesearch);
> > +       if (ccachedir)
> > +               free(ccachedir);
> > 
> >         return rc < 0 ? EXIT_FAILURE : EXIT_SUCCESS;
> >  }
> > --
> > 2.27.0
> > 
> > 

