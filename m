Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139FC6AFF1E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCHGvJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 01:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCHGvI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 01:51:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115469663F
        for <linux-nfs@vger.kernel.org>; Tue,  7 Mar 2023 22:51:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1B2A1FE35;
        Wed,  8 Mar 2023 06:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678258265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mkJEZICCxjXWmHIRmNb6FkKO3a0ok1tZB6pRDdUA8FA=;
        b=vZJP0eJKOMYc7OiXAYmx8cmSmBRJnh6QxloEUalaYDUrQLesRAdCiIO4iIWdkhpu0lHojm
        tqVwrd/k4MwpZe3KEy6h/NxeuzEOC6NUuTX4POG4wNxV4gXSDUjXV040UT0X/hI/q2J1HP
        TVJUfU4u2Fk3YaDnxKggE3aGqfo3hsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678258265;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mkJEZICCxjXWmHIRmNb6FkKO3a0ok1tZB6pRDdUA8FA=;
        b=TV2s/9jEC5uwBOr4XtLwhTpvYJS6S4T6uobBkIyiXOk4+4BwKGXK+SZzAHr+ld4xAKJoiR
        HPlgLvdIrCjlh2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DBFE1348D;
        Wed,  8 Mar 2023 06:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZcqTNVcwCGR/YQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 08 Mar 2023 06:51:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] SUNRPC: return proper error from get_expiry()
Date:   Wed, 08 Mar 2023 17:51:00 +1100
Message-id: <167825826081.8008.16276753342643583003@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


The get_expiry() function currently returns a timestamp, and uses the
special return value of 0 to indicate an error.

Unfortunately this causes a problem when 0 is the correct return value.

On a system with no RTC it is possible that the boot time will be seen
to be "3".  When exportfs probes to see if a particular filesystem
supports NFS export it tries to cache information with an expiry time of
"3".  The intention is for this to be "long in the past".  Even with no
RTC it will not be far in the future (at most a second or two) so this
is harmless.
But if the boot time happens to have been calculated to be "3", then
get_expiry will fail incorrectly as it converts the number to "seconds
since bootime" - 0.

To avoid this problem we change get_expiry() to report the error quite
separately from the expiry time.  The error is now the return value.
The expiry time is reported through a by-reference parameter.

Reported-by: Jerry Zhang <jerry@skydio.com>
Tested-by: Jerry Zhang <jerry@skydio.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/export.c                  | 13 ++++++-------
 fs/nfsd/nfs4idmap.c               |  8 ++++----
 include/linux/sunrpc/cache.h      | 15 ++++++++-------
 net/sunrpc/auth_gss/svcauth_gss.c | 12 ++++++------
 net/sunrpc/svcauth_unix.c         | 12 ++++++------
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 668c7527b17e..6da74aebe1fb 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -123,11 +123,11 @@ static int expkey_parse(struct cache_detail *cd, char *=
mesg, int mlen)
=20
 	/* OK, we seem to have a valid key */
 	key.h.flags =3D 0;
-	key.h.expiry_time =3D get_expiry(&mesg);
-	if (key.h.expiry_time =3D=3D 0)
+	err =3D get_expiry(&mesg, &key.h.expiry_time);
+	if (err)
 		goto out;
=20
-	key.ek_client =3D dom;=09
+	key.ek_client =3D dom;
 	key.ek_fsidtype =3D fsidtype;
 	memcpy(key.ek_fsid, buf, len);
=20
@@ -610,9 +610,8 @@ static int svc_export_parse(struct cache_detail *cd, char=
 *mesg, int mlen)
 	exp.ex_devid_map =3D NULL;
=20
 	/* expiry */
-	err =3D -EINVAL;
-	exp.h.expiry_time =3D get_expiry(&mesg);
-	if (exp.h.expiry_time =3D=3D 0)
+	err =3D get_expiry(&mesg, &exp.h.expiry_time);
+	if (err)
 		goto out3;
=20
 	/* flags */
@@ -624,7 +623,7 @@ static int svc_export_parse(struct cache_detail *cd, char=
 *mesg, int mlen)
 		if (err || an_int < 0)
 			goto out3;
 		exp.ex_flags=3D an_int;
-=09
+
 		/* anon uid */
 		err =3D get_int(&mesg, &an_int);
 		if (err)
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 5e9809aff37e..7a806ac13e31 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -240,8 +240,8 @@ idtoname_parse(struct cache_detail *cd, char *buf, int bu=
flen)
 		goto out;
=20
 	/* expiry */
-	ent.h.expiry_time =3D get_expiry(&buf);
-	if (ent.h.expiry_time =3D=3D 0)
+	error =3D get_expiry(&buf, &ent.h.expiry_time);
+	if (error)
 		goto out;
=20
 	error =3D -ENOMEM;
@@ -408,8 +408,8 @@ nametoid_parse(struct cache_detail *cd, char *buf, int bu=
flen)
 	memcpy(ent.name, buf1, sizeof(ent.name));
=20
 	/* expiry */
-	ent.h.expiry_time =3D get_expiry(&buf);
-	if (ent.h.expiry_time =3D=3D 0)
+	error =3D get_expiry(&buf, &ent.h.expiry_time);
+	if (error)
 		goto out;
=20
 	/* ID */
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index ec5a555df96f..518bd28f5ab8 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -300,17 +300,18 @@ static inline int get_time(char **bpp, time64_t *time)
 	return 0;
 }
=20
-static inline time64_t get_expiry(char **bpp)
+static inline int get_expiry(char **bpp, time64_t *rvp)
 {
-	time64_t rv;
+	int error;
 	struct timespec64 boot;
=20
-	if (get_time(bpp, &rv))
-		return 0;
-	if (rv < 0)
-		return 0;
+	error =3D get_time(bpp, rvp);
+	if (error)
+		return error;
+
 	getboottime64(&boot);
-	return rv - boot.tv_sec;
+	(*rvp) -=3D boot.tv_sec;
+	return 0;
 }
=20
 #endif /*  _LINUX_SUNRPC_CACHE_H_ */
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_=
gss.c
index acb822b23af1..bfaf584d296a 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -258,11 +258,11 @@ static int rsi_parse(struct cache_detail *cd,
=20
 	rsii.h.flags =3D 0;
 	/* expiry */
-	expiry =3D get_expiry(&mesg);
-	status =3D -EINVAL;
-	if (expiry =3D=3D 0)
+	status =3D get_expiry(&mesg, &expiry);
+	if (status)
 		goto out;
=20
+	status =3D -EINVAL;
 	/* major/minor */
 	len =3D qword_get(&mesg, buf, mlen);
 	if (len <=3D 0)
@@ -484,11 +484,11 @@ static int rsc_parse(struct cache_detail *cd,
=20
 	rsci.h.flags =3D 0;
 	/* expiry */
-	expiry =3D get_expiry(&mesg);
-	status =3D -EINVAL;
-	if (expiry =3D=3D 0)
+	status =3D get_expiry(&mesg, &expiry);
+	if (status)
 		goto out;
=20
+	status =3D -EINVAL;
 	rscp =3D rsc_lookup(cd, &rsci);
 	if (!rscp)
 		goto out;
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index b1efc34db6ed..9e7798a69051 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -225,9 +225,9 @@ static int ip_map_parse(struct cache_detail *cd,
 		return -EINVAL;
 	}
=20
-	expiry =3D get_expiry(&mesg);
-	if (expiry =3D=3D0)
-		return -EINVAL;
+	err =3D get_expiry(&mesg, &expiry);
+	if (err)
+		return err;
=20
 	/* domainname, or empty for NEGATIVE */
 	len =3D qword_get(&mesg, buf, mlen);
@@ -497,9 +497,9 @@ static int unix_gid_parse(struct cache_detail *cd,
 	uid =3D make_kuid(current_user_ns(), id);
 	ug.uid =3D uid;
=20
-	expiry =3D get_expiry(&mesg);
-	if (expiry =3D=3D 0)
-		return -EINVAL;
+	err =3D get_expiry(&mesg, &expiry);
+	if (err)
+		return err;
=20
 	rv =3D get_int(&mesg, &gids);
 	if (rv || gids < 0 || gids > 8192)
--=20
2.39.2

