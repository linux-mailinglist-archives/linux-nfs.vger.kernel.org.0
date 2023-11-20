Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C687F0AA6
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 03:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjKTCvg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 21:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjKTCvg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 21:51:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1239E5
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 18:51:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94BC21F750;
        Mon, 20 Nov 2023 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700448690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a4gTkK5E7icEiVDIXTWSd3StAxSMhGuK1+QLJGkFThA=;
        b=1gy43RhWpqhC9oyF6a98prAPGa4udCLx1/Asa9DBnNAYBpbpYDjzpe8GLWynXIzuhdvQYF
        2Kkt8iM9DBC9VfARfnbIltZqEoNN4BYIgHVdbwch66juc1DrYCPRK2jjX9j45C39uSrBuM
        zg4JubV2MT4LUMKYMKiW0WAsThBPEP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700448690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a4gTkK5E7icEiVDIXTWSd3StAxSMhGuK1+QLJGkFThA=;
        b=PKzP0y6eTmwXQv0g2ZBsHB+REnMNukSol86vDBdlX++w1ZuHUvsx5EbVE2oalCYZVm0j6G
        Ngoz7B4bLJ4Qt+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A58CB138E3;
        Mon, 20 Nov 2023 02:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ysRTFrHJWmW1QAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 20 Nov 2023 02:51:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH nfs-utils] exportfs: remove warning if neither subtree_check
 or no_subtree_check is given
Date:   Mon, 20 Nov 2023 13:51:26 +1100
Message-id: <170044868651.19300.8600752002784382234@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 3.40
X-Spamd-Result: default: False [3.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


This warning was only ever intended as a transitional aid.
It doesn't serve any purpose any longer.  Let's remove it.

Also clean up some white-space issues.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/export.c  |  2 +-
 support/export/xtab.c    |  2 +-
 support/include/nfslib.h |  2 +-
 support/nfs/exports.c    | 43 +++++++++++++++++-----------------------
 4 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/support/export/export.c b/support/export/export.c
index 3e48c42def19..100912cb29c3 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -119,7 +119,7 @@ export_read(char *fname, int ignore_hosts)
 	int reexport_found =3D 0;
=20
 	setexportent(fname, "r");
-	while ((eep =3D getexportent(0,1)) !=3D NULL) {
+	while ((eep =3D getexportent(0)) !=3D NULL) {
 		exp =3D export_lookup(eep->e_hostname, eep->e_path, ignore_hosts);
 		if (!exp) {
 			if (export_create(eep, 0))
diff --git a/support/export/xtab.c b/support/export/xtab.c
index e210ca99d574..282f15bc79cd 100644
--- a/support/export/xtab.c
+++ b/support/export/xtab.c
@@ -47,7 +47,7 @@ xtab_read(char *xtab, char *lockfn, int is_export)
 	setexportent(xtab, "r");
 	if (is_export =3D=3D 1)
 		v4root_needed =3D 1;
-	while ((xp =3D getexportent(is_export=3D=3D0, 0)) !=3D NULL) {
+	while ((xp =3D getexportent(is_export=3D=3D0)) !=3D NULL) {
 		if (!(exp =3D export_lookup(xp->e_hostname, xp->e_path, is_export !=3D 1))=
 &&
 		    !(exp =3D export_create(xp, is_export!=3D1))) {
                         if(xp->e_hostname) {
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index bdbde78d9ebd..eff2a486307f 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -111,7 +111,7 @@ struct rmtabent {
  * configuration file parsing
  */
 void			setexportent(char *fname, char *type);
-struct exportent *	getexportent(int,int);
+struct exportent *	getexportent(int);
 void 			secinfo_show(FILE *fp, struct exportent *ep);
 void			xprtsecinfo_show(FILE *fp, struct exportent *ep);
 void			putexportent(struct exportent *xep);
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 15dc574cc21a..a6816e60d62e 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -59,7 +59,7 @@ static int	*squids =3D NULL, nsquids =3D 0,
=20
 static int	getexport(char *exp, int len);
 static int	getpath(char *path, int len);
-static int	parseopts(char *cp, struct exportent *ep, int warn, int *had_subt=
ree_opt_ptr);
+static int	parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_pt=
r);
 static int	parsesquash(char *list, int **idp, int *lenp, char **ep);
 static int	parsenum(char **cpp);
 static void	freesquash(void);
@@ -109,7 +109,7 @@ static void init_exportent (struct exportent *ee, int fro=
mkernel)
 }
=20
 struct exportent *
-getexportent(int fromkernel, int fromexports)
+getexportent(int fromkernel)
 {
 	static struct exportent	ee, def_ee;
 	char		exp[512], *hostname;
@@ -147,7 +147,7 @@ getexportent(int fromkernel, int fromexports)
 	 * we're not reading from the kernel.
 	 */
 	if (exp[0] =3D=3D '-' && !fromkernel) {
-		if (parseopts(exp + 1, &def_ee, 0, &has_default_subtree_opts) < 0)
+		if (parseopts(exp + 1, &def_ee, &has_default_subtree_opts) < 0)
 			return NULL;
=20
 		has_default_opts =3D 1;
@@ -185,20 +185,20 @@ getexportent(int fromkernel, int fromexports)
 	}
 	ee.e_hostname =3D xstrdup(hostname);
=20
-	if (parseopts(opt, &ee, fromexports && !has_default_subtree_opts, NULL) < 0=
) {
-                if(ee.e_hostname)
-                {
-                    xfree(ee.e_hostname);
-                    ee.e_hostname=3DNULL;
-                }
-                if(ee.e_uuid)
-                {
-                    xfree(ee.e_uuid);
-                    ee.e_uuid=3DNULL;
-                }
+	if (parseopts(opt, &ee, NULL) < 0) {
+		if(ee.e_hostname)
+		{
+			xfree(ee.e_hostname);
+			ee.e_hostname=3DNULL;
+		}
+		if(ee.e_uuid)
+		{
+			xfree(ee.e_uuid);
+			ee.e_uuid=3DNULL;
+		}
=20
 		return NULL;
-        }
+	}
 	/* resolve symlinks */
 	if (realpath(ee.e_path, rpath) !=3D NULL) {
 		rpath[sizeof (rpath) - 1] =3D '\0';
@@ -433,7 +433,7 @@ mkexportent(char *hname, char *path, char *options)
 	}
 	strncpy(ee.e_path, path, sizeof (ee.e_path));
 	ee.e_path[sizeof (ee.e_path) - 1] =3D '\0';
-	if (parseopts(options, &ee, 0, NULL) < 0)
+	if (parseopts(options, &ee, NULL) < 0)
 		return NULL;
 	return &ee;
 }
@@ -441,7 +441,7 @@ mkexportent(char *hname, char *path, char *options)
 int
 updateexportent(struct exportent *eep, char *options)
 {
-	if (parseopts(options, eep, 0, NULL) < 0)
+	if (parseopts(options, eep, NULL) < 0)
 		return 0;
 	return 1;
 }
@@ -632,7 +632,7 @@ void fix_pseudoflavor_flags(struct exportent *ep)
  * Parse option string pointed to by cp and set mount options accordingly.
  */
 static int
-parseopts(char *cp, struct exportent *ep, int warn, int *had_subtree_opt_ptr)
+parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
 {
 	int	had_subtree_opt =3D 0;
 	char 	*flname =3D efname?efname:"command line";
@@ -852,13 +852,6 @@ bad_option:
 	ep->e_nsqgids =3D nsqgids;
=20
 out:
-	if (warn && !had_subtree_opt)
-		xlog(L_WARNING, "%s [%d]: Neither 'subtree_check' or 'no_subtree_check' sp=
ecified for export \"%s:%s\".\n"
-				"  Assuming default behaviour ('no_subtree_check').\n"
-				"  NOTE: this default has changed since nfs-utils version 1.0.x\n",
-
-				flname, flline,
-				ep->e_hostname, ep->e_path);
 	if (had_subtree_opt_ptr)
 		*had_subtree_opt_ptr =3D had_subtree_opt;
=20
--=20
2.42.0

