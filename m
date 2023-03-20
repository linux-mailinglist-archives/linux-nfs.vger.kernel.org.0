Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC06C14A7
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 15:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjCTOY5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCTOY4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 10:24:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331A41B2C0
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 07:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2F566153E
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 14:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D18BC43327;
        Mon, 20 Mar 2023 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322294;
        bh=nKcSbFia0hUMTIU86VEUoGxOltB+53xHdJrLnfiwx2o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OU/ZkmDZe8NrkJVdijHoUpBZTaYesxl48HXVZuv6I1M3ees4nPxytbpH326nfOhIz
         m+VDG9INb0a0OoIYQSGit/THVvdKNhYIphAzOs/EJZoc4EIEC+IOts3nUmvtFweTbG
         vOGJgnhaQtfPfBZ3o6VD9pS4vIqCytpCcdjpqLBY3BORvA/EykPOJYQE2rhAxWy+3T
         94yuLAiemlMKsdrXo06uvEDSp6RpmP0TZKcGF3tPnU/YWLjHHCLY39YziV/mYboEQR
         wq0NwMYjT42jMKVmuPMY2qfB3bCX8bVk/ik2NYsEshVxgEaAJE+yqoSEHxm9eRm6Fo
         8AF+JxueVv9lg==
Subject: [PATCH RFC 5/5] NFSD: Handle new xprtsec= export option
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Mon, 20 Mar 2023 10:24:53 -0400
Message-ID: <167932229302.3131.3108041458819604050.stgit@manet.1015granger.net>
In-Reply-To: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
References: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Enable administrators to require clients to use transport layer
security when accessing particular exports.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/export.h |   11 +++++++++++
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 668c7527b17e..171ebc21bf07 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -439,7 +439,6 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
 		return -EINVAL;
 	}
 	return 0;
-
 }
 
 #ifdef CONFIG_NFSD_V4
@@ -546,6 +545,31 @@ static inline int
 secinfo_parse(char **mesg, char *buf, struct svc_export *exp) { return 0; }
 #endif
 
+static int xprtsec_parse(char **mesg, char *buf, struct svc_export *exp)
+{
+	unsigned int i, mode, listsize;
+	int err;
+
+	err = get_uint(mesg, &listsize);
+	if (err)
+		return err;
+	if (listsize > 3)
+		return -EINVAL;
+
+	exp->ex_xprtsec_modes = 0;
+	for (i = 0; i < listsize; i++) {
+		err = get_uint(mesg, &mode);
+		if (err)
+			return err;
+		mode--;
+		if (mode > 2)
+			return -EINVAL;
+		/* Ad hoc */
+		exp->ex_xprtsec_modes |= 1 << mode;
+	}
+	return 0;
+}
+
 static inline int
 nfsd_uuid_parse(char **mesg, char *buf, unsigned char **puuid)
 {
@@ -608,6 +632,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 	exp.ex_client = dom;
 	exp.cd = cd;
 	exp.ex_devid_map = NULL;
+	exp.ex_xprtsec_modes = NFSEXP_XPRTSEC_ALL;
 
 	/* expiry */
 	err = -EINVAL;
@@ -650,6 +675,8 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 				err = nfsd_uuid_parse(&mesg, buf, &exp.ex_uuid);
 			else if (strcmp(buf, "secinfo") == 0)
 				err = secinfo_parse(&mesg, buf, &exp);
+			else if (strcmp(buf, "xprtsec") == 0)
+				err = xprtsec_parse(&mesg, buf, &exp);
 			else
 				/* quietly ignore unknown words and anything
 				 * following. Newer user-space can try to set
@@ -663,6 +690,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 		err = check_export(&exp.ex_path, &exp.ex_flags, exp.ex_uuid);
 		if (err)
 			goto out4;
+
 		/*
 		 * No point caching this if it would immediately expire.
 		 * Also, this protects exportfs's dummy export from the
@@ -824,6 +852,7 @@ static void export_update(struct cache_head *cnew, struct cache_head *citem)
 	for (i = 0; i < MAX_SECINFO_LIST; i++) {
 		new->ex_flavors[i] = item->ex_flavors[i];
 	}
+	new->ex_xprtsec_modes = item->ex_xprtsec_modes;
 }
 
 static struct cache_head *svc_export_alloc(void)
@@ -1035,9 +1064,26 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 {
-	struct exp_flavor_info *f;
-	struct exp_flavor_info *end = exp->ex_flavors + exp->ex_nflavors;
+	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
+	struct svc_xprt *xprt = rqstp->rq_xprt;
+
+	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
+		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
+			goto ok;
+	}
+	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
+		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
+		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
+			goto ok;
+	}
+	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
+		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
+		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
+			goto ok;
+	}
+	goto denied;
 
+ok:
 	/* legacy gss-only clients are always OK: */
 	if (exp->ex_client == rqstp->rq_gssclient)
 		return 0;
@@ -1062,6 +1108,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return 0;
 
+denied:
 	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
 }
 
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index d03f7f6a8642..61e1e8383c3d 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -77,8 +77,19 @@ struct svc_export {
 	struct cache_detail	*cd;
 	struct rcu_head		ex_rcu;
 	struct export_stats	ex_stats;
+	unsigned long		ex_xprtsec_modes;
 };
 
+enum {
+	NFSEXP_XPRTSEC_NONE	= 0x01,
+	NFSEXP_XPRTSEC_TLS	= 0x02,
+	NFSEXP_XPRTSEC_MTLS	= 0x04,
+};
+
+#define NFSEXP_XPRTSEC_ALL	(NFSEXP_XPRTSEC_NONE | \
+				 NFSEXP_XPRTSEC_TLS | \
+				 NFSEXP_XPRTSEC_MTLS)
+
 /* an "export key" (expkey) maps a filehandlefragement to an
  * svc_export for a given client.  There can be several per export,
  * for the different fsid types.


