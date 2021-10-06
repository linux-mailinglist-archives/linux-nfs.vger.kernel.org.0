Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15C423612
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 04:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhJFCsd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 22:48:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48804 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJFCsc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 22:48:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D880202F4;
        Wed,  6 Oct 2021 02:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633488400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YZ2ioczNAtJdIGbHvmTylqqAMnUhlTXCVicVxzX+WlM=;
        b=snAUFTaMo0/YIqiPgI8IQ97RCNA8F6YpBlVEpRP4yr7/gLb+MWU+up9d4osxCHFVVxVQTs
        heRHnh8HnrRnSnsIGPrzNCCgrHjE5++ktv8NSEnhCYMTp4ZJVI1KtXRjnvwFezhfRWXoVc
        FohwZUH1/2RynrF1dGVg5KzK4KJSu7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633488400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YZ2ioczNAtJdIGbHvmTylqqAMnUhlTXCVicVxzX+WlM=;
        b=+l/Dd6RvaDSU0UnhkWllJcq09u4GWvysJjI2nleT9l9h6vTTwXoqql80mJuAxSZCUGy8hZ
        f1FQfi6IMVEOkWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C703713DF5;
        Wed,  6 Oct 2021 02:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ft2mIA8OXWHyMAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Oct 2021 02:46:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH nfs-utils] Add --disable-sbin-override for when /sbin is a symlink
Date:   Wed, 06 Oct 2021 13:46:36 +1100
Message-id: <163348839674.31063.11636602028086354852@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


mount.nfs* umount.nfs* and nfsdcltrack are currently always installed in
/sbin.

Many distros are moving to a "merged /usr" where /sbin and others are
symlinks into /usr/sbin or similar.  In these cases it is inelegant to
install in /sbin (i.e. install through a symlink).

So we add "--disable-sbin-override" as a configure option.  This causes
the same sbindir to be used for *mount.nfs* and nfsdcltrack as for other
system binaries.

Note that autotools notices if we simply define "sbindir=3D/sbin"
inside an "if CONFIG_foo" clause, gives a warning, and defeats our
intent.

So instead, we use the @CONFIG_SBIN_OVERRIDE_TRUE@ prefix to find
the new declaration when we don't want it.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 configure.ac                  | 6 ++++++
 utils/mount/Makefile.am       | 8 +++++---
 utils/nfsdcltrack/Makefile.am | 9 ++++++---
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index bc2d0f02979c..93626d62be40 100644
--- a/configure.ac
+++ b/configure.ac
@@ -187,6 +187,12 @@ else
 	enable_libmount=3Dno
 fi
=20
+AC_ARG_ENABLE(sbin-override,
+	[AC_HELP_STRING([--disable-sbin-override],
+		[Don't force nfsdcltrack and mount helpers into /sbin: always honour --sbi=
ndir])],
+	enable_sbin_override=3D$enableval,
+	enable_sbin_override=3Dyes)
+	AM_CONDITIONAL(CONFIG_SBIN_OVERRIDE, [test "$enable_sbin_override" =3D "yes=
"])
 AC_ARG_ENABLE(junction,
 	[AC_HELP_STRING([--enable-junction],
 			[enable support for NFS junctions @<:@default=3Dno@:>@])],
diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
index ad0be93b1def..3101f7abd7f4 100644
--- a/utils/mount/Makefile.am
+++ b/utils/mount/Makefile.am
@@ -1,8 +1,10 @@
 ## Process this file with automake to produce Makefile.in
=20
-# These binaries go in /sbin (not /usr/sbin), and that cannot be
-# overridden at config time.
-sbindir =3D /sbin
+# These binaries go in /sbin (not /usr/sbin), unless CONFIG_SBIN_OVERRIDE
+# is disabled as may be appropriate when /sbin is a symlink.
+# Note that we don't use "if CONFIG_SBIN_OVERRIDE" as that
+# causes autotools to notice the override and disable it.
+@CONFIG_SBIN_OVERRIDE_TRUE@sbindir =3D /sbin
=20
 man8_MANS	=3D mount.nfs.man umount.nfs.man
 man5_MANS	=3D nfs.man
diff --git a/utils/nfsdcltrack/Makefile.am b/utils/nfsdcltrack/Makefile.am
index 2f7fe3de6922..769e4a455fcf 100644
--- a/utils/nfsdcltrack/Makefile.am
+++ b/utils/nfsdcltrack/Makefile.am
@@ -1,8 +1,11 @@
 ## Process this file with automake to produce Makefile.in
=20
-# These binaries go in /sbin (not /usr/sbin), and that cannot be
-# overridden at config time. The kernel "knows" the /sbin name.
-sbindir =3D /sbin
+# These binaries go in /sbin (not /usr/sbin) as the kernel "knows" the
+# /sbin name.  If /sbin is a symlink, CONFIG_SBIN_OVERRIDE can be
+# disabled to install in /usr/sbin anyway.
+# Note that we don't use "if CONFIG_SBIN_OVERRIDE" as that
+# causes autotools to notice the override and disable it.
+@CONFIG_SBIN_OVERRIDE_TRUE@sbindir =3D /sbin
=20
 man8_MANS	=3D nfsdcltrack.man
 EXTRA_DIST	=3D $(man8_MANS)
--=20
2.33.0

