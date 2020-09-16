Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F030126C704
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 20:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgIPSPZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 14:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727824AbgIPSPE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 14:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600280102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6UnNlOYpanNlZdupp7e84OafUkKZpzeNPRa0LsuTYtE=;
        b=GRpobmA6dsli64CJheQ3MJ8SMc5Bp5fZIt5NMPy7N6uOditbV1a9k/ZTrJaaqR2i6TUWtm
        uxZ7kSVCvkjh5E1PZH4uzB/QIlh7EU/3b7YLEPxSQDbjpCwjJpFMdj/LAMClbBD/A2eMz1
        xa8S1BZBG2dOruqtAlM2b1jk5q1i25M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-sys-7lSMMC2ybEP1VxtQuA-1; Wed, 16 Sep 2020 08:52:58 -0400
X-MC-Unique: sys-7lSMMC2ybEP1VxtQuA-1
Received: by mail-qv1-f72.google.com with SMTP id t7so4476426qvz.5
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 05:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UnNlOYpanNlZdupp7e84OafUkKZpzeNPRa0LsuTYtE=;
        b=YnGOnXElbdMa6daIidz/z7UceUdtKnleXvXryIGuNJ2d3kpNAIHiJJGwyd+jAmKCiG
         uwOGtvg+ir2nHkXrHSMGEjChZbuxa1vrjvzGVI3BCtt+z72f3NdorD0d2cHeqI1XHzwQ
         G+PJJTSQsFRpBUJ0RmvewFUsQ1d74FJH2EGdVq2Z7Fb9AJoFbC+NPznXDcFHdLe6sc01
         8YRSc9Vw72rMZ3lM9erL4pwzWJVAc4vCkBLCkpedVjpevC0AXSrFQfhAzFnLi+glvOHo
         I+qwkhfqZY3wSvZ7blZw0e7G4OgjSKxgjJm6vsfz7W9G2I2+BXDCGbQZV/Wuy3txgwDf
         zHig==
X-Gm-Message-State: AOAM531vU9nIQEk/fN9yEE6asAkBtVFXnJ94qRFUGoHxY5mcPL4kHWPt
        be5/TzD6+tvGPiK/yHSlO6uP9tgVoB5CfxK1sdIk3eN0+aWjdRuBfWdQ2qvZbStM4RGA4JPXiob
        zkZh4/OXavwsvG6UeyEXaIBhHzCxTvV28O+yY
X-Received: by 2002:ac8:376d:: with SMTP id p42mr10250733qtb.288.1600260777226;
        Wed, 16 Sep 2020 05:52:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWE+ho8hO3eqYZExQtYfhu/4Im8aObe+BQAMSsxVjvAyUcgKL8JoONQHytbGlqz/scP+r6CwabyPl2mCsmgeI=
X-Received: by 2002:ac8:376d:: with SMTP id p42mr10250690qtb.288.1600260776754;
 Wed, 16 Sep 2020 05:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <S1725851AbgIKKt5/20200911104957Z+185@vger.kernel.org>
 <a38a1249-c570-9069-a498-5e17d85a418a@gmch.uk> <f06f86ef-08bd-3974-3d92-1fbda700cc11@RedHat.com>
 <f7b9c8b4-29a6-2f28-b1d9-739c546fd557@gmch.uk>
In-Reply-To: <f7b9c8b4-29a6-2f28-b1d9-739c546fd557@gmch.uk>
From:   Kenneth Dsouza <kdsouza@redhat.com>
Date:   Wed, 16 Sep 2020 18:22:45 +0530
Message-ID: <CAA_-hQJ4KfvSm042oW5Lw46mPdQR0XmAS4m2VHC1aatHbJLrrQ@mail.gmail.com>
Subject: Re: mount.nfs4 and logging
To:     Chris Hall <linux-nfs@gmch.uk>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I had come across a similar issue in the past.
I had debugged the issue by checking what mount options were passed by
doing the below:

# LIBMOUNT_DEBUG=0xffff mount -t nfs nfs-server:/example /mnt  -o
vers=4.0 | less
:
19709: libmount:      CXT: [0x556249623030]: fixed options [rc=0]:
vfs: 'rw' fs: 'vers=4.0,mountvers=4' user: '(null)', optstr:
'rw,vers=4.0,mountvers=4' <----
19709: libmount:      CXT: [0x556249623030]: preparing source path
19709: libmount:      CXT: [0x556249623030]: preparing target path
19709: libmount:      CXT: [0x556249623030]: final target '/mnt'
19709: libmount:      CXT: [0x556249623030]: FS type: nfs [rc=0]
mount.nfs: Protocol not supported <----

The mountvers option is only applicable for nfsv3 and is not supported
for nfsv4. Whenever mount command is called explicitly with mount.nfs4
or vers=4.0,4.1 or 4.2 it will fail.
I finally removed the setting from /etc/nfsmount.conf to fix the issue.
I had a patch to add debugging to make the end user aware of what was
going wrong.

[PATCH] mount.nfs: Do not retry if Mountd related options are passed for nfs4

When Mountd related options are passed with mount.nfs4
or -t nfs vers=4 we fallback and retry with below version.
As these options are not supported we should fail at first
try and error out.

This patch also adds mountport to the unsupported list for NFSv4.

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 utils/mount/stropts.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index 901f995a..cad64bd8 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -86,6 +86,7 @@ extern int nfs_mount_data_version;
 extern char *progname;
 extern int verbose;
 extern int sloppy;
+int failure =0;

 struct nfsmount_info {
        const char              *spec,          /* server:/path */
@@ -756,13 +757,19 @@ static int nfs_do_mount_v4(struct nfsmount_info *mi,
        if (po_contains(options, "mounthost") ||
                po_contains(options, "mountaddr") ||
                po_contains(options, "mountvers") ||
+               po_contains(options, "mountport") ||
                po_contains(options, "mountproto")) {
        /*
         * Since these mountd options are set assume version 3
         * is wanted so error out with EPROTONOSUPPORT so the
         * protocol negation starts with v3.
         */
+               if (verbose) {
+                printf(_("%s: Unsupported nfs4 mount option passed '%s'\n"),
+                        progname, *mi->extra_opts);
+               }
                errno = EPROTONOSUPPORT;
+               failure = 1;
                goto out_fail;
        }

@@ -892,6 +899,8 @@ static int nfs_autonegotiate(struct nfsmount_info *mi)
        int result, olderrno;

        result = nfs_try_mount_v4(mi);
+       if (failure == 1 && errno == EPROTONOSUPPORT)
+               goto fall_back;
 check_result:
        if (result)
                return result;
-- 

On Wed, Sep 16, 2020 at 6:09 AM Chris Hall <linux-nfs@gmch.uk> wrote:
>
> On 14/09/2020 19:30, Steve Dickson wrote:
> > Hello,
> >
> > On 9/11/20 7:45 AM, Chris Hall wrote:
>
> >> I have a client and server configured for nfs4 only.
>
> > Would you mind sharing this configuration? Privately if
> > that works better...
>
> The client /etc/nfsmount.conf has:
>
>    [ NFSMount_Global_Options ]
>    Defaultvers=4
>    Nfsvers=4
>    Defaultproto=tcp
>    Proto=tcp
>
> and (now, see below) nothing else.
>
> FWIW, I guess setting the 'Defaultvers' and 'Defaultproto' is
> redundant... but does not appear to stop anything from working.
>
> Also FWIW, I gather that this is configuration for the client-side
> 'mount' of nfs exports, *only*.  I suppose it should be obvious that
> this has absolutely nothing to do with configuring (server-side)
> 'mountd'.  Speaking as a fully paid up moron-in-a-hurry, it has taken me
> a while to work that out :-(  [I suggest that the comments in the .conf
> files and the man-page could say that nfs.conf is server-side and
> nfsmount.conf is client-side -- just a few words, for the avoidance of
> doubt.]
>
> The server /etc/nfs.conf has only:
>
>    [nfsd]
>    debug=0
>    threads=8
>    host=cerberus2
>    port=1001
>    # grace-time=90
>    # lease-time=90
>    udp=n
>    tcp=y
>    vers2=n
>    vers3=n
>    vers4=y
>    vers4.0=y
>    vers4.1=y
>    vers4.2=y
>
> I wish I knew whether the 'vers4.X' settings make the slightest
> difference.  This server is my firewall, hence the funky port number.
>
> > I'm thinking that is a good direction to go towards
> > so maybe we make this configuration the default??
>
> I don't use nfs very much, but every time I have tangled with it I have
> come way limping :-(
>
> Given that NFSv4 is going on 20 years old now, I do wonder why the
> earlier versions are not treated a "legacy".  When trying to discover
> how to configure and use nfs I find I am still wading through stuff
> which does not apply to NFSv4.  Much of what the "wisdom of the
> Internet" has to offer seems firmly routed in the past, and often NFSv4
> is describe in terms of its difference from NFSv3 and v2.
>
> For example: I run nfs on my firewall machine so that I can configure it
> from elsewhere on the network.  Naturally, the firewall machine is
> firmly wrapped so that it may only be accessed by particular machines
> inside the network.  I also try to ensure that the absolute minimum
> number of daemons are running and the absolute minumum number of ports
> are open.  In that context, (a) is there a way to persuade 'systemctl
> start nfs-service' to be "nfs4 only", and to *not* start 'rpcbind' (and
> *not* open port 111), and (b) are rpc.idmapd, rpc.mountd and rpc.statd
> required for nfs4 ?  (ie, is nfsdcld sufficient ?)
>
> >> The configuration used to work.
> >>
> >> I have just upgraded from Fedora 31 to 32 on the client.  I now get:
> >>
> >>    # mount /foo
> >>    mount.nfs4: Protocol not supported
>
> > I've been trying to keep the versions the same... hopefully
> > nothing has broken in f31... ;-(
>
> Rest easy: my problem was entirely self inflicted -- it had nothing
> directly to do with the upgrade from Fedora 31 to 32.
>
> Since the client 'mount' and 'mount.nfs4' were not even attempting to
> speak to the server, I downloaded the source and the debug symbols and
> had a go at it with strace and gdb...
>
> ...and discovered that I had caused the problem by setting:
>
>    mountproto=tcp
>    mountvers=4
>
> in /etc/nfsmount.conf at the client end.  [Full disclosure: I am
> building a replacement for the server and was reviewing all
> configuration at both ends, updating Fedora all round and generally
> tidying up.]
>
> It turns out that mount.nfs4 takes a dim view of the existence of these
> settings and declines to do the mount(2) call; instead it sets
> errno=EPROTONOSUPPORT and returns as if the mount(2) had failed.  [See
> nfs_do_mount_v4() in stropts.c of utils/mount/.  I note in passing that
> it worries about "mounthost", "mountaddr", "mountvers" and "mountproto",
> where "mountaddr" is not mentioned in the man-page for nfs.  But it does
> not worry about "mountport", which is mentioned in the man-page.]
>
> Having checked carefully, I now know that mountport, mountproto,
> mounthost and mountvers are all "Options for NFS versions 2 and 3 only".
>   But I don't know if their presence with 'nfsvers=4' would cause
> mount(2) to fail.
>
> In any case, frankly, I think that mount is being singularly obtuse.
> Since it knows that these options do not apply, it could IMHO simply
> discard them.  If that's a step too far, it could produce a rather more
> informative message -- in particular *not* the standard system message
> for EPROTONOSUPPORT, which a quick search of POSIX.1-2017 tells me is
> returned only by socket() and socketpair() !
>
> Thanks,
>
> Chris
>

