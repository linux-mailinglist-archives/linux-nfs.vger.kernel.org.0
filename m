Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10E055701A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jun 2022 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377330AbiFWBs3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jun 2022 21:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377325AbiFWBs2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jun 2022 21:48:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCAF43499
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:48:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C5D6C1F91F;
        Thu, 23 Jun 2022 01:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655948902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xedQ8D0jKuXePhGrcorna7M3d38UWpXxq8EzrkuYHQY=;
        b=n4V21ewdQ2To8mPN69TUHSAB1NCWAKvjGvC6P3FkDqp/TkWLwAOMWE7niAFrRF438OYeVi
        pp5CsfrA2pRZSZY6yygD1VYwfTs/ktMjQ61xZFOCaHw5aWBzpwZCESsPOW2yxOeOaY6uOJ
        KJblbBg/IB5NNULJoTGGdr8W1jaU/3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655948902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xedQ8D0jKuXePhGrcorna7M3d38UWpXxq8EzrkuYHQY=;
        b=QAlmVfQHBSi0YBG3VcLG+H3XcnHASUJ1UqV+rSveuNVynQJUaw94+7wvgudKomE0kDlKfI
        RPSqvnOypZrSyEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 835EE13461;
        Thu, 23 Jun 2022 01:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +UrmD2XGs2LsWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 23 Jun 2022 01:48:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: [PATCH nfs-utils] configure: make modprobe.d directory configurable.
Date:   Thu, 23 Jun 2022 11:48:16 +1000
Message-id: <165594889671.4786.9612372524810600367@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Debian seems to prefer /lib/modprobe.d - at lease sometimes.

So allow
  ./configure --with-modprobedir=3D/lib/modprobe.d
to work, but default to /usr/lib/modprobe.d

Signed-off-by: NeilBrown <neilb@suse.de>
---
 configure.ac        | 12 ++++++++++++
 systemd/Makefile.am |  6 ++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index a13f36915a35..4403335bcaa9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,6 +71,18 @@ AC_ARG_WITH(systemd,
 	AM_CONDITIONAL(INSTALL_SYSTEMD, [test "$use_systemd" =3D 1])
 	AC_SUBST(unitdir)
=20
+modprobedir=3D/usr/lib/modprobe.d
+AC_ARG_WITH(modprobedir,
+	[AS_HELP_STRING([--with-modprobedir@<:@=3Dmodprobe-dir-path@:>@],[install m=
odprobe config files @<:@Default: /usr/lib/modprobe.d@:>@])],
+	if test "$withval" !=3D "no" ; then
+		modprobedir=3D$withval
+	else
+		modprobedir=3D
+	fi
+	)
+	AM_CONDITIONAL(INSTALL_MODPROBEDIR, [test -n "$modprobedir"])
+	AC_SUBST(modprobedir)
+
 AC_ARG_ENABLE(nfsv4,
 	[AS_HELP_STRING([--disable-nfsv4],[disable support for NFSv4 @<:@default=3D=
no@:>@])],
 	enable_nfsv4=3D$enableval,
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 63a50bf2c07e..7b5ab84bd793 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -82,5 +82,7 @@ install-data-hook: $(unit_files) $(modprobe_files)
 else
 install-data-hook: $(modprobe_files)
 endif
-	mkdir -p $(DESTDIR)/usr/lib/modprobe.d
-	cp $(modprobe_files) $(DESTDIR)/usr/lib/modprobe.d/
+if INSTALL_MODPROBEDIR
+	mkdir -p $(DESTDIR)$(modprobedir)
+	cp $(modprobe_files) $(DESTDIR)$(modprobedir)
+endif
--=20
2.36.1

