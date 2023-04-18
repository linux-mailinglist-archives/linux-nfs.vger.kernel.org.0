Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823886E701F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 01:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDRX55 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 19:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDRX55 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 19:57:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC446449F
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 16:57:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 961CC1FD77;
        Tue, 18 Apr 2023 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681862274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mf2HAOM5KmRtIP/VLefkHfomNEDVrpzZoJiwtt2EBFU=;
        b=IZnLhVWhoZzK/MO/l4BFyuP/Rd9TF3CXOMVdUSibkW66WKs9bB3hKZPbadn86BCAqjn31D
        uL+tjZXzXirZzwVu3BII4Mv2cfvGTtYOJhVeA2UkVgezlY/juO94nlSy74gRhrESuB6/9a
        pe29JOqRqcairxKQOrOvm4MCUq9eizY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681862274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mf2HAOM5KmRtIP/VLefkHfomNEDVrpzZoJiwtt2EBFU=;
        b=VTrFPFS5y9WpYR4GXgAWkRmpgAxly7J78fZnlZGZIBl23LRRKKFGi/3GELCkITkPrQKEit
        wtGi7rIsGIj60hAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F200613413;
        Tue, 18 Apr 2023 23:57:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BonMJ4AuP2SjbwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Apr 2023 23:57:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-nfs <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Subject: [nfs-utils PATCH v2] mountd: don't advertise krb5 for v4root when not
 configured.
Date:   Wed, 19 Apr 2023 09:57:49 +1000
Message-id: <168186226971.24821.9774040849376889413@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


If /etc/krb5.keytab does not exist, then krb5 cannot work, so
advertising it as an option for v4root is pointless.
Since linux commit 676e4ebd5f2c ("NFSD: SECINFO doesn't handle
unsupported pseudoflavors correctly") this can result in an unhelpful
warning if the krb5 code is not built, or built as a module which is not
installed.

[  161.668635] NFS: SECINFO: security flavor 390003 is not supported
[  161.668655] NFS: SECINFO: security flavor 390004 is not supported
[  161.668670] NFS: SECINFO: security flavor 390005 is not supported

So avoid advertising krb5 security options when krb5.keytab cannot be
found.

Note that testing for /etc/krb5.keytab is what we already do in a couple
of systemd unit file to determine if krb5 is enabled.

Link: https://lore.kernel.org/linux-nfs/20170104190327.v3wbpcbqtfa5jy7d@codem=
onkey.org.uk/
Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/v4root.c         |  2 ++
 support/include/pseudoflavors.h |  1 +
 support/nfs/exports.c           | 14 +++++++-------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/support/export/v4root.c b/support/export/v4root.c
index fbb0ad5f5b81..03805dcb4e6d 100644
--- a/support/export/v4root.c
+++ b/support/export/v4root.c
@@ -66,6 +66,8 @@ set_pseudofs_security(struct exportent *pseudo)
=20
 		if (!flav->fnum)
 			continue;
+		if (flav->need_krb5 && access("/etc/krb5.keytab", F_OK) !=3D 0)
+			continue;
=20
 		i =3D secinfo_addflavor(flav, pseudo);
 		new =3D &pseudo->e_secinfo[i];
diff --git a/support/include/pseudoflavors.h b/support/include/pseudoflavors.h
index deb052b130e6..1f16f3f796f3 100644
--- a/support/include/pseudoflavors.h
+++ b/support/include/pseudoflavors.h
@@ -8,6 +8,7 @@
 struct flav_info {
 	char    *flavour;
 	int     fnum;
+	int	need_krb5;
 };
=20
 extern struct flav_info flav_map[];
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 2c8f0752ad9d..010dfe423d6f 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -36,13 +36,13 @@
   (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREE=
CHECK)
=20
 struct flav_info flav_map[] =3D {
-	{ "krb5",	RPC_AUTH_GSS_KRB5	},
-	{ "krb5i",	RPC_AUTH_GSS_KRB5I	},
-	{ "krb5p",	RPC_AUTH_GSS_KRB5P	},
-	{ "unix",	AUTH_UNIX		},
-	{ "sys",	AUTH_SYS		},
-	{ "null",	AUTH_NULL		},
-	{ "none",	AUTH_NONE		},
+	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
+	{ "krb5i",	RPC_AUTH_GSS_KRB5I,	1},
+	{ "krb5p",	RPC_AUTH_GSS_KRB5P,	1},
+	{ "unix",	AUTH_UNIX,		0},
+	{ "sys",	AUTH_SYS,		0},
+	{ "null",	AUTH_NULL,		0},
+	{ "none",	AUTH_NONE,		0},
 };
=20
 const int flav_map_size =3D sizeof(flav_map)/sizeof(flav_map[0]);
--=20
2.40.0

