Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF875322E86
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Feb 2021 17:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhBWQOv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Feb 2021 11:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhBWQOs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Feb 2021 11:14:48 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA26C061574
        for <linux-nfs@vger.kernel.org>; Tue, 23 Feb 2021 08:14:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l12so26550395edt.3
        for <linux-nfs@vger.kernel.org>; Tue, 23 Feb 2021 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:content-disposition:content-transfer-encoding;
        bh=VD1CR0c7AeBse5VGKsXG0lU96VdUbYs2Y8HWAyBjyGo=;
        b=UnYpmfI2LCP6THlRn+3Wr9CB+x7qWmpGqb8Br5I9wJvFsLMYiw9yysPLZ2kJXNh9dz
         3tTnFBhHMsKsXT75afAnDB5zmUUfCKAGqOQYELq8/epEIl6f6Wna+UJ3FiWH1ZgMszEt
         /xGZEuXy3mXTl18mqgTBbioSjSfH7ZoMth1Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:in-reply-to:content-disposition
         :content-transfer-encoding;
        bh=VD1CR0c7AeBse5VGKsXG0lU96VdUbYs2Y8HWAyBjyGo=;
        b=qBy21zY7fPlsJRTzMrVAabB9my5f/GhzwQMZM3ZZhj/RV7QG22t8WzpbjRB0yz2RBG
         np3Rpx6SF8xZNQdctti55UwWQJ2taBC8A5NP0C4tQn+eKq3zB/rBsiyFOgbm0RkyaBcI
         oGVEICImIWn9jAld77rV8z7azYQ74hSrF07gbg6HM66yZekfiFBir6oCTCY6mFAkzp6n
         gET2zv3RnHi1HCqEKAKMfyxhLtPNKIuxd1YPshzMd/PDL+R2tkrZHlayXji4ZHNzhGDO
         e3Wf7dKXI3D1UhfdrqoaRkmkeDZe8xAcBG5MgksndeY52F9wVX7S7OBv154lVCZcO5sw
         xitQ==
X-Gm-Message-State: AOAM531INcrxMFn0w2aofgR1LnEDefnW0GimatDCITR9BGcVw7mSWsQP
        ytBVW8tNwunhkxT6RlHCzqN5lLXSLPgLATPqwEzfE6L6aDOm1tBZNFcu2vLBBcw3K3VNutiK3Rq
        xX4SqAFuQqRiezwxj3BmDeQ==
X-Google-Smtp-Source: ABdhPJxSGDuOV8WELfYWZeC/f1Ml6jqSsEUI1l7pkBhsr1P7V1oudDuIjPyvZg0qucQwt+aR8qjFGQ==
X-Received: by 2002:a50:b765:: with SMTP id g92mr29061590ede.317.1614096845165;
        Tue, 23 Feb 2021 08:14:05 -0800 (PST)
Received: from tuedko18.puzzle-itc.de ([2a02:8070:88b7:3700:455a:a1d7:a314:2cc8])
        by smtp.gmail.com with ESMTPSA id a5sm3697615ejr.10.2021.02.23.08.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 08:14:04 -0800 (PST)
Date:   Tue, 23 Feb 2021 17:13:51 +0100
From:   Daniel Kobras <kobras@puzzle-itc.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] exportd: server-side gid management
Message-ID: <20210223161351.zzz62kuxn5bdfkqf@tuedko18.puzzle-itc.de>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210219200815.792667-3-steved@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210219200815.792667-3-steved@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ported manage-gids option from mountd

Signed-off-by: Daniel Kobras <kobras@puzzle-itc.de>
---
Hi Steve!

Option --manage-gids should still be useful with NFSv4 and AUTH_SYS, but=20
commit 15dc0bead10d20c31e72ca94ce21eb66dc3528d5 does not allow to actually
control the global variable manage_gids from exportd. I assume something
like the following was intended?

Kind regards,

Daniel

 nfs.conf                  |  1 +
 utils/exportd/exportd.c   |  8 +++++++-
 utils/exportd/exportd.man | 16 ++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/nfs.conf b/nfs.conf
index bebb2e3d..e69ec16d 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -31,6 +31,7 @@
 #
 [exportd]
 # debug=3D"all|auth|call|general|parse"
+# manage-gids=3Dn
 # state-directory-path=3D/var/lib/nfs
 # threads=3D1
 [mountd]
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 7130bcbf..0d7782be 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -42,6 +42,7 @@ static struct option longopts[] =3D
 	{ "foreground", 0, 0, 'F' },
 	{ "debug", 1, 0, 'd' },
 	{ "help", 0, 0, 'h' },
+	{ "manage-gids", 0, 0, 'g' },
 	{ "num-threads", 1, 0, 't' },
 	{ NULL, 0, 0, 0 }
 };
@@ -174,6 +175,7 @@ usage(const char *prog, int n)
 {
 	fprintf(stderr,
 		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n"
+"	[-g|--manage-gids]\n"
 "	[-s|--state-directory-path path]\n"
 "	[-t num|--num-threads=3Dnum]\n", prog);
 	exit(n);
@@ -188,6 +190,7 @@ read_exportd_conf(char *progname, char **argv)
=20
 	xlog_set_debug(progname);
=20
+	manage_gids =3D conf_get_bool("exportd", "manage-gids", manage_gids);
 	num_threads =3D conf_get_num("exportd", "threads", num_threads);
=20
 	s =3D conf_get_str("exportd", "state-directory-path");
@@ -214,7 +217,7 @@ main(int argc, char **argv)
 	/* Read in config setting */
 	read_exportd_conf(progname, argv);
=20
-	while ((c =3D getopt_long(argc, argv, "d:fhs:t:", longopts, NULL)) !=3D E=
OF) {
+	while ((c =3D getopt_long(argc, argv, "d:fghs:t:", longopts, NULL)) !=3D =
EOF) {
 		switch (c) {
 		case 'd':
 			xlog_sconfig(optarg, 1);
@@ -222,6 +225,9 @@ main(int argc, char **argv)
 		case 'f':
 			foreground++;
 			break;
+		case 'g':
+			manage_gids =3D 1;
+			break;
 		case 'h':
 			usage(progname, 0);
 			break;
diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
index 1d65b5e0..d7884562 100644
--- a/utils/exportd/exportd.man
+++ b/utils/exportd/exportd.man
@@ -51,6 +51,21 @@ spawns.  The default is 1 thread, which is probably enou=
gh.  More
 threads are usually only needed for NFS servers which need to handle
 mount storms of hundreds of NFS mounts in a few seconds, or when
 your DNS server is slow or unreliable.
+.TP
+.BR \-g " or " \-\-manage-gids
+Accept requests from the kernel to map user id numbers into lists of
+group id numbers for use in access control.  An NFS request will
+normally (except when using Kerberos or other cryptographic
+authentication) contain a user-id and a list of group-ids.  Due to a
+limitation in the NFS protocol, at most 16 groups ids can be listed.
+If you use the
+.B \-g
+flag, then the list of group ids received from the client will be
+replaced by a list of group ids determined by an appropriate lookup on
+the server. Note that the 'primary' group id is not affected so a
+.B newgroup
+command on the client will still be effective.  This function requires
+a Linux Kernel with version at least 2.6.21.
 .SH CONFIGURATION FILE
 Many of the options that can be set on the command line can also be
 controlled through values set in the
@@ -63,6 +78,7 @@ configuration file.
 Values recognized in the
 .B [exportd]
 section include=20
+.BR manage-gids ", and"
 .B debug=20
 which each have the same effect as the option with the same name.
 .SH FILES
--=20
2.25.1


--=20
Puzzle ITC Deutschland GmbH
Sitz der Gesellschaft: Eisenbahnstra=DFe 1, 72072=20
T=FCbingen

Eingetragen am Amtsgericht Stuttgart HRB 765802
Gesch=E4ftsf=FChrer:=20
Lukas Kallies, Daniel Kobras, Mark Pr=F6hl

