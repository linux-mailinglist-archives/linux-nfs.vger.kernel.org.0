Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220104599CC
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhKWBfi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:35:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57954 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBfi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:35:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A030212B6;
        Tue, 23 Nov 2021 01:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0Xy/1b4cpwQuEFLudNsCPNFcEJ/FPxUX2iQ0iVXkQo=;
        b=X/H1HHeBBvqsvLP9mGqgzCKbFmseLIuV0dDYAxKTRFym77c6JkHIe28A0E84+LAur5Uri+
        MAdgDC5Ni/XmmfVZp6PRyqb/M4ffaBX0y3rwbXhEUuDctEkAXknix3AnKxQasAYaS5zzif
        xq/jFqAVifnjzWrIEE22CmdbfGqp5ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0Xy/1b4cpwQuEFLudNsCPNFcEJ/FPxUX2iQ0iVXkQo=;
        b=Ij7d/g9RuNW61U9CbX738O2bE8cp9n6YCKWnhpeDvn8Y9E7/aXIl3K8Qdgwn3SkB75BKtI
        6EgJbOu+bTHx+WDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20BFC13BD4;
        Tue, 23 Nov 2021 01:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NHl5M6xEnGEqdAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:32:28 +0000
Subject: [PATCH 16/19] SUNRPC: move the pool_map definitions (back) into svc.c
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097550.7284.16154772439269087144.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
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


