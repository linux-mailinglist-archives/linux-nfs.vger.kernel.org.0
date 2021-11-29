Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC62C460E3B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhK2FAX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 00:00:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42634 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbhK2E6X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:58:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDD1C1FD45;
        Mon, 29 Nov 2021 04:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0Xy/1b4cpwQuEFLudNsCPNFcEJ/FPxUX2iQ0iVXkQo=;
        b=0bx8kXHH9bDTNxBeBLLA9LNefBkFXF5FvFDvhe50hPwTJ76sH422BE0NKP7Hl3fPOLVgKj
        aodA0JYecar/NqGaHf67N9aJmOoPcEkxMzi8bfUBeEoxsN0GlMS7eW58Jyg5par4k6jSbY
        PMtTbjYqhQ2RvX55Grw1YpKSB+X0ezA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0Xy/1b4cpwQuEFLudNsCPNFcEJ/FPxUX2iQ0iVXkQo=;
        b=ttmFBvxQ+DqQVxJQ97yjYnmUrRm76Y12Ohr9P8jRQVjHOomrgGVcn7Y6EVHO2XtHpgEnJb
        tjj0jrI40tS79MCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE889133FE;
        Mon, 29 Nov 2021 04:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ER80GuhcpGFMbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:54:00 +0000
Subject: [PATCH 17/20] SUNRPC: move the pool_map definitions (back) into svc.c
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148563.32298.112655599730856597.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These definitions are not used outside of svc.c, and there is no
evidence that they ever have been.  So move them into svc.c
and make the declarations 'static'.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h |   25 -------------------------
 net/sunrpc/svc.c           |   31 +++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 0b38c6eaf985..d69e6108cb83 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -494,29 +494,6 @@ struct svc_procedure {
 	const char *		pc_name;	/* for display */
 };
 
-/*
- * Mode for mapping cpus to pools.
- */
-enum {
-	SVC_POOL_AUTO = -1,	/* choose one of the others */
-	SVC_POOL_GLOBAL,	/* no mapping, just a single global pool
-				 * (legacy & UP mode) */
-	SVC_POOL_PERCPU,	/* one pool per cpu */
-	SVC_POOL_PERNODE	/* one pool per numa node */
-};
-
-struct svc_pool_map {
-	int count;			/* How many svc_servs use us */
-	int mode;			/* Note: int not enum to avoid
-					 * warnings about "enumeration value
-					 * not handled in switch" */
-	unsigned int npools;
-	unsigned int *pool_to;		/* maps pool id to cpu or node */
-	unsigned int *to_pool;		/* maps cpu or node to pool id */
-};
-
-extern struct svc_pool_map svc_pool_map;
-
 /*
  * Function prototypes.
  */
@@ -533,8 +510,6 @@ void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
-unsigned int	   svc_pool_map_get(void);
-void		   svc_pool_map_put(void);
 struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 			const struct svc_serv_ops *);
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 5513f8c9a8d6..f0dd9ef7e0cd 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -41,14 +41,35 @@ static void svc_unregister(const struct svc_serv *serv, struct net *net);
 
 #define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
 
+/*
+ * Mode for mapping cpus to pools.
+ */
+enum {
+	SVC_POOL_AUTO = -1,	/* choose one of the others */
+	SVC_POOL_GLOBAL,	/* no mapping, just a single global pool
+				 * (legacy & UP mode) */
+	SVC_POOL_PERCPU,	/* one pool per cpu */
+	SVC_POOL_PERNODE	/* one pool per numa node */
+};
+
 /*
  * Structure for mapping cpus to pools and vice versa.
  * Setup once during sunrpc initialisation.
  */
-struct svc_pool_map svc_pool_map = {
+
+struct svc_pool_map {
+	int count;			/* How many svc_servs use us */
+	int mode;			/* Note: int not enum to avoid
+					 * warnings about "enumeration value
+					 * not handled in switch" */
+	unsigned int npools;
+	unsigned int *pool_to;		/* maps pool id to cpu or node */
+	unsigned int *to_pool;		/* maps cpu or node to pool id */
+};
+
+static struct svc_pool_map svc_pool_map = {
 	.mode = SVC_POOL_DEFAULT
 };
-EXPORT_SYMBOL_GPL(svc_pool_map);
 
 static DEFINE_MUTEX(svc_pool_map_mutex);/* protects svc_pool_map.count only */
 
@@ -222,7 +243,7 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
  * vice versa).  Initialise the map if we're the first user.
  * Returns the number of pools.
  */
-unsigned int
+static unsigned int
 svc_pool_map_get(void)
 {
 	struct svc_pool_map *m = &svc_pool_map;
@@ -257,7 +278,6 @@ svc_pool_map_get(void)
 	mutex_unlock(&svc_pool_map_mutex);
 	return m->npools;
 }
-EXPORT_SYMBOL_GPL(svc_pool_map_get);
 
 /*
  * Drop a reference to the global map of cpus to pools.
@@ -266,7 +286,7 @@ EXPORT_SYMBOL_GPL(svc_pool_map_get);
  * mode using the pool_mode module option without
  * rebooting or re-loading sunrpc.ko.
  */
-void
+static void
 svc_pool_map_put(void)
 {
 	struct svc_pool_map *m = &svc_pool_map;
@@ -283,7 +303,6 @@ svc_pool_map_put(void)
 
 	mutex_unlock(&svc_pool_map_mutex);
 }
-EXPORT_SYMBOL_GPL(svc_pool_map_put);
 
 static int svc_pool_map_get_node(unsigned int pidx)
 {


