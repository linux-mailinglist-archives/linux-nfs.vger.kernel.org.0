Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45A6E9B22
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjDTR4f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjDTR4e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 13:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D12690
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 10:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB806151A
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 17:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E0BC433EF;
        Thu, 20 Apr 2023 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682013392;
        bh=/SbfuxzidwhfKSqhs5xHtJb0tWqZEYnOHpFcd9eNzqo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JTrdkP1kWDcjtNr3pyHf218GtGuX8Khvl7NEB2KebOEtVXV+34H+DlQ//InWaIYMF
         4qy2zyC2wGm5ShsSgTyb+WALEaqIzSGYq5YrsWPC/ULsIVVqhwfKrPf0/LuZ+5I5M8
         ZbfGTP7pDmuGJlrSdy0NCArp5XS+7rIllZDLFnQqfR1olrGeXqyiiqqzm0AQQN27Su
         SFsHvWBOe08uMORpR5m9amRjGFmfxBvYPrOw3zeMTms0xcjBCTCOcYUzHNgA1Y/246
         7QkmnkBh7Hjds4gyjbE/q51Ec5DY22C/bSAFeuFdZXczi13SHBZazy4kGjCgbSqdec
         LsTM81vEWzOug==
Subject: [PATCH v1 2/2] NFSD: Handle new xprtsec= export option
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Thu, 20 Apr 2023 13:56:31 -0400
Message-ID: <168201339129.6370.5280916277494986894.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: <168201329016.6370.17351667274885826598.stgit@91.116.238.104.host.secureserver.net>
References: <168201329016.6370.17351667274885826598.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/nfsd/export.c                 |   51 ++++++++++++++++++++++++++++++++++++--
 fs/nfsd/export.h                 |    1 +
 include/uapi/linux/nfsd/export.h |   13 ++++++++++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 6da74aebe1fb..ae85257b4238 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -439,7 +439,6 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
 		return -EINVAL;
 	}
 	return 0;
-
 }
 
 #ifdef CONFIG_NFSD_V4
@@ -546,6 +545,29 @@ static inline int
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
+	if (listsize > NFSEXP_XPRTSEC_NUM)
+		return -EINVAL;
+
+	exp->ex_xprtsec_modes = 0;
+	for (i = 0; i < listsize; i++) {
+		err = get_uint(mesg, &mode);
+		if (err)
+			return err;
+		if (mode > NFSEXP_XPRTSEC_MTLS)
+			return -EINVAL;
+		exp->ex_xprtsec_modes |= mode;
+	}
+	return 0;
+}
+
 static inline int
 nfsd_uuid_parse(char **mesg, char *buf, unsigned char **puuid)
 {
@@ -608,6 +630,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 	exp.ex_client = dom;
 	exp.cd = cd;
 	exp.ex_devid_map = NULL;
+	exp.ex_xprtsec_modes = NFSEXP_XPRTSEC_ALL;
 
 	/* expiry */
 	err = get_expiry(&mesg, &exp.h.expiry_time);
@@ -649,6 +672,8 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 				err = nfsd_uuid_parse(&mesg, buf, &exp.ex_uuid);
 			else if (strcmp(buf, "secinfo") == 0)
 				err = secinfo_parse(&mesg, buf, &exp);
+			else if (strcmp(buf, "xprtsec") == 0)
+				err = xprtsec_parse(&mesg, buf, &exp);
 			else
 				/* quietly ignore unknown words and anything
 				 * following. Newer user-space can try to set
@@ -662,6 +687,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 		err = check_export(&exp.ex_path, &exp.ex_flags, exp.ex_uuid);
 		if (err)
 			goto out4;
+
 		/*
 		 * No point caching this if it would immediately expire.
 		 * Also, this protects exportfs's dummy export from the
@@ -823,6 +849,7 @@ static void export_update(struct cache_head *cnew, struct cache_head *citem)
 	for (i = 0; i < MAX_SECINFO_LIST; i++) {
 		new->ex_flavors[i] = item->ex_flavors[i];
 	}
+	new->ex_xprtsec_modes = item->ex_xprtsec_modes;
 }
 
 static struct cache_head *svc_export_alloc(void)
@@ -1034,9 +1061,26 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 
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
@@ -1061,6 +1105,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return 0;
 
+denied:
 	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
 }
 
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index d03f7f6a8642..2df8ae25aad3 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -77,6 +77,7 @@ struct svc_export {
 	struct cache_detail	*cd;
 	struct rcu_head		ex_rcu;
 	struct export_stats	ex_stats;
+	unsigned long		ex_xprtsec_modes;
 };
 
 /* an "export key" (expkey) maps a filehandlefragement to an
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index 2124ba904779..a73ca3703abb 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -62,5 +62,18 @@
 					| NFSEXP_ALLSQUASH \
 					| NFSEXP_INSECURE_PORT)
 
+/*
+ * Transport layer security policies that are permitted to access
+ * an export
+ */
+#define NFSEXP_XPRTSEC_NONE	0x0001
+#define NFSEXP_XPRTSEC_TLS	0x0002
+#define NFSEXP_XPRTSEC_MTLS	0x0004
+
+#define NFSEXP_XPRTSEC_NUM	(3)
+
+#define NFSEXP_XPRTSEC_ALL	(NFSEXP_XPRTSEC_NONE | \
+				 NFSEXP_XPRTSEC_TLS | \
+				 NFSEXP_XPRTSEC_MTLS)
 
 #endif /* _UAPINFSD_EXPORT_H */


