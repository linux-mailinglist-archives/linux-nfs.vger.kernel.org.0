Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5E117222
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2019 17:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIQty (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Dec 2019 11:49:54 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33255 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIQty (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Dec 2019 11:49:54 -0500
Received: by mail-ua1-f67.google.com with SMTP id v19so5134347uap.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Dec 2019 08:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwImp2kk8SqUb5MQwsMzIPq75nv9Iwc1vSy1cKc9AO4=;
        b=JUybQs7FgQYTYMhk/eGUifjLHg5k+3tUanEW73OPIAOa++J/zmt9mWisGVKYPpC2vo
         V/ijKIkClxE+I/C1Oo6BqN5N9oiQ2BfnzI/8/9lyRWWDyMxExIc5XcZ0xl6B93l2xuJE
         XUBmCSvk5JWvTcl0ygpo4UAanboUSOovAeXPzXmJwQIQwn4SoLgGML/eIEy56UC5a3pU
         thLQOD9efBERb2gP4cQb3CKZJq8SEyV5gaRv1FtsUDJNPjPUF4DNR+wKAx1rgvlVltm2
         IaCq2jP0wyfQi20aG271Y8mVaI0tH0Kqls/CAZle4JzT11YcWZQ+i7BVpuBghXkvJdji
         xP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwImp2kk8SqUb5MQwsMzIPq75nv9Iwc1vSy1cKc9AO4=;
        b=gZxWr+x7OCRbtP3dkojcPOOLHGlCEx7Ylw1xNu1jqQ7WmPPsc0edsUJFghBScrpz5s
         MIfcVnjMiUL4vu3d4VKD6RH+sTaNI3MZAdzD2u6wNjZZjghdDImWyh6ywjIe/9QMf/3B
         xIJ1JcxSDzeQ2prtryiOIjeS77+YsrlE0n8Y21HL7t4BbJzCCYA7mkd/cgdxzZOLqkY9
         7M/n3vD9dYcS0Jq1dXomIWEwpZeKrntVAI0EAvwAhacurdon9Qml40mKg9WSA7b3/0i/
         7zCsPV5aEGLwlzZJAdyNcErk+e8kS5bLTiJImSx0fAnAd6a3NfwpEQ8T8vc1NKCa0lK/
         ctDQ==
X-Gm-Message-State: APjAAAWiz+5Y5sq+kcYX1pW8Yq+IbXZBbUhJRDJ6uz4lsyWyhOvgwn1H
        wygKj7eylgzzf7ZeHdscOKwKy5RNEAu3RWUjbtM=
X-Google-Smtp-Source: APXvYqzcZ9FEh/5QLZrJVgTwZOAXX/Lk+jdUCWZESouMAH9GUV4ocT3csGSJF15HLXKdT2ywybIH/2M5TVBpIZnJsQs=
X-Received: by 2002:a9f:3e45:: with SMTP id c5mr9301626uaj.65.1575910192936;
 Mon, 09 Dec 2019 08:49:52 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHJg4C5j72_CrCJhZ8hyzDe71Q9zw1USgmyxePg+3juZw@mail.gmail.com>
 <8c69eee5-9dc1-2a14-1bd2-cf812bdb39a4@RedHat.com>
In-Reply-To: <8c69eee5-9dc1-2a14-1bd2-cf812bdb39a4@RedHat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 9 Dec 2019 11:49:42 -0500
Message-ID: <CAN-5tyH-m=n2m8-qWbV-4iYJUhx4yMFz_uWUWAzYGArN5yxJaw@mail.gmail.com>
Subject: Re: gssd question/patch
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

On Mon, Dec 9, 2019 at 11:10 AM Steve Dickson <SteveD@redhat.com> wrote:
>
> Hey,
>
> On 12/6/19 1:29 PM, Olga Kornievskaia wrote:
> > Hi Steve,
> >
> > Question: Is this an interesting failure scenario (bug) that should be
> > fixed: client did a mount which acquired gss creds and stored in the
> > credential cache. Then say it umounts at some point. Then for some
> > reason the Kerberos cache is deleted (rm -f /tmp/krb5cc*). Now client
> > mounts again. This currently fails. Because gssd uses internal cache
> > to store creds lifetimes and thinks that tgt is still valid but then
> > trying to acquire a service ticket it fails (since there is no tgt).
> I'm unable reproduce the scenario....
>
> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
> (as kuser) kinit kuser
> (as kuser) touch /mnt/tmp/foobar
> (as root) umount /mnt/tmp/
> (as root) rm -f /tmp/krb5cc*
> (as root) mount -o sec=krb5 server:/home/tmp /mnt/tmp
> (as kuser) touch /mnt/tmp/foobar # which succeeds
>
> Where am I going wrong?

Not sure. Can you please post gssd verbose output?

Set up. Client kernel somewhat recent though the latest, but in
reality doesn't matter i think
gssd from nfs-utils commit 5a004c161ff6c671f73a92d818a502264367a896
"gssd: daemonize earlier"

[aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
192.168.1.72:/nfsshare /mnt
[aglo@localhost nfs-utils]$ touch /mnt/kerberos
[aglo@localhost nfs-utils]$ sudo umount /mnt
[aglo@localhost nfs-utils]$ sudo rm -fr /tmp/krb5cc*
[aglo@localhost nfs-utils]$ sudo mount -o vers=4.1,sec=krb5
192.168.1.72:/nfsshare /mnt
mount.nfs: access denied by server while mounting 192.168.1.72:/nfsshare

Here's the gssd error output: If you look at 1st "INFO: Credentials in
CC .... are good until..." is a lie as there isn't even a file there.

handle_gssd_upcall: 'mech=krb5 uid=0 enctypes=18,17,16,23,3,1,2' (nfs/clnt13)
krb5_use_machine_creds: uid 0 tgtname (null)
gssd_refresh_krb5_machine_credential: hostname=ipa84.gateway.2wire.net
ple=(nil) service=(null) srchost=(null)
Full hostname for 'ipa84.gateway.2wire.net' is 'ipa84.gateway.2wire.net'
Full hostname for 'ipa69.gateway.2wire.net' is 'ipa69.gateway.2wire.net'
No key table entry found for ipa69$@GATEWAY.2WIRE.NET while getting
keytab entry for 'ipa69$@GATEWAY.2WIRE.NET'
No key table entry found for IPA69$@GATEWAY.2WIRE.NET while getting
keytab entry for 'IPA69$@GATEWAY.2WIRE.NET'
No key table entry found for
root/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET while getting keytab
entry for 'root/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET'
Success getting keytab entry for 'nfs/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET'
INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_GATEWAY.2WIRE.NET'
are good until 1575945300
gssd_refresh_krb5_machine_credential: hostname=(null)
ple=0x7fa590000fa0 service=(null) srchost=(null)
INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_GATEWAY.2WIRE.NET'
are good until 1575945300
ERROR: GSS-API: error in gss_acquire_cred(): GSS_S_FAILURE
(Unspecified GSS failure.  Minor code may provide more information) -
No credentials cache found
WARNING: Failed while limiting krb5 encryption types for user with uid 0
WARNING: Failed to create machine krb5 context with cred cache
FILE:/tmp/krb5ccmachine_GATEWAY.2WIRE.NET for server
ipa84.gateway.2wire.net
WARNING: Machine cache prematurely expired or corrupted trying to
recreate cache for server ipa84.gateway.2wire.net
gssd_refresh_krb5_machine_credential: hostname=ipa84.gateway.2wire.net
ple=(nil) service=(null) srchost=(null)
Full hostname for 'ipa84.gateway.2wire.net' is 'ipa84.gateway.2wire.net'
Full hostname for 'ipa69.gateway.2wire.net' is 'ipa69.gateway.2wire.net'
No key table entry found for ipa69$@GATEWAY.2WIRE.NET while getting
keytab entry for 'ipa69$@GATEWAY.2WIRE.NET'
No key table entry found for IPA69$@GATEWAY.2WIRE.NET while getting
keytab entry for 'IPA69$@GATEWAY.2WIRE.NET'
No key table entry found for
root/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET while getting keytab
entry for 'root/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET'
Success getting keytab entry for 'nfs/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET'
INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_GATEWAY.2WIRE.NET'
are good until 1575945300
gssd_refresh_krb5_machine_credential: hostname=(null)
ple=0x7fa590000fa0 service=(null) srchost=(null)
INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_GATEWAY.2WIRE.NET'
are good until 1575945300
ERROR: GSS-API: error in gss_acquire_cred(): GSS_S_FAILURE
(Unspecified GSS failure.  Minor code may provide more information) -
No credentials cache found
WARNING: Failed while limiting krb5 encryption types for user with uid 0
WARNING: Failed to create machine krb5 context with cred cache
FILE:/tmp/krb5ccmachine_GATEWAY.2WIRE.NET for server
ipa84.gateway.2wire.net
ERROR: Failed to create machine krb5 context with any credentials
cache for server ipa84.gateway.2wire.net
doing error downcall


After applying my patch. While hard to see the difference but there
are not 2 INFO calls saying creds are good (as it actually gets the
tgt as well)
handle_gssd_upcall: 'mech=krb5 uid=0 service=*
enctypes=18,17,16,23,3,1,2' (nfs/clnt22)
krb5_use_machine_creds: uid 0 tgtname (null)
gssd_refresh_krb5_machine_credential: hostname=ipa84.gateway.2wire.net
ple=(nil) service=* srchost=(null)
Full hostname for 'ipa84.gateway.2wire.net' is 'ipa84.gateway.2wire.net'
Full hostname for 'ipa69.gateway.2wire.net' is 'ipa69.gateway.2wire.net'
No key table entry found for ipa69$@GATEWAY.2WIRE.NET while getting
keytab entry for 'ipa69$@GATEWAY.2WIRE.NET'
No key table entry found for IPA69$@GATEWAY.2WIRE.NET while getting
keytab entry for 'IPA69$@GATEWAY.2WIRE.NET'
No key table entry found for
root/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET while getting keytab
entry for 'root/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET'
Success getting keytab entry for 'nfs/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET'
gssd_get_single_krb5_cred: principal
'nfs/ipa69.gateway.2wire.net@GATEWAY.2WIRE.NET'
ccache:'FILE:/tmp/krb5ccmachine_GATEWAY.2WIRE.NET'
gssd_refresh_krb5_machine_credential: hostname=(null)
ple=0x7fed48000fa0 service=(null) srchost=(null)
INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_GATEWAY.2WIRE.NET'
are good until 1575945968
creating tcp client for server ipa84.gateway.2wire.net
DEBUG: port already set to 2049
creating context with server nfs@ipa84.gateway.2wire.net
doing downcall: lifetime_rec=36000 acceptor=nfs@ipa84.gateway.2wire.net

Normally when the ticket cache file is there. It's normal to have 2
INFO lines saying creds are good.

>
> steved.
>
> >
> > Here's my proposed fix (I can send as a patch if this agreed upon).
> >
> > diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> > index 0474783..3678524 100644
> > --- a/utils/gssd/krb5_util.c
> > +++ b/utils/gssd/krb5_util.c
> > @@ -121,6 +121,9 @@
> >  #include <krb5.h>
> >  #include <rpc/auth_gss.h>
> >
> > +#include <sys/types.h>
> > +#include <fcntl.h>
> > +
> >  #include "nfslib.h"
> >  #include "gssd.h"
> >  #include "err_util.h"
> > @@ -314,6 +317,25 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
> >         return err;
> >  }
> >
> > +/* check if the ticket cache exists, if not set nocache=1 so that new
> > + * tgt is gotten
> > + */
> > +static int
> > +gssd_check_if_cc_exists(struct gssd_k5_kt_princ *ple)
> > +{
> > +       int fd;
> > +       char cc_name[BUFSIZ];
> > +
> > +       snprintf(cc_name, sizeof(cc_name), "%s/%s%s_%s",
> > +               ccachesearch[0], GSSD_DEFAULT_CRED_PREFIX,
> > +               GSSD_DEFAULT_MACHINE_CRED_SUFFIX, ple->realm);
> > +       fd = open(cc_name, O_RDONLY);
> > +       if (fd < 0)
> > +               return 1;
> > +       close(fd);
> > +       return 0;
> > +}
> > +
> >  /*
> >   * Obtain credentials via a key in the keytab given
> >   * a keytab handle and a gssd_k5_kt_princ structure.
> > @@ -348,6 +370,8 @@ gssd_get_single_krb5_cred(krb5_context context,
> >
> >         memset(&my_creds, 0, sizeof(my_creds));
> >
> > +       if (!nocache && !use_memcache)
> > +               nocache = gssd_check_if_cc_exists(ple);
> >         /*
> >          * Workaround for clock skew among NFS server, NFS client and KDC
> >          * 300 because clock skew must be within 300sec for kerberos
> >
>
