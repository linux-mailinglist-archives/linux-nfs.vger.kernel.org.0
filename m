Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9332600606
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 06:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJQEg5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 00:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJQEg4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 00:36:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC064DF27
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 21:36:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 128so9456131pga.1
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 21:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/LMhTjBXfOSQYuKy628IGKMzBVDP6Ogyg5S+aM7180=;
        b=js3ziIta2PQd/DuB1wQ+aOfVXuEc7HBGePcVX0a215qz6gpR1kJeqALxC2606Fz3hH
         EW1j02cN1IneliLCHnNVy/I3CSoUaG8t42o6Fah2NPRdM1nXbmICTo0tGfIusXHymJjh
         xGCsy4YhjHh6UBg0FEGX0rOgblGC8R4kV+Zwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/LMhTjBXfOSQYuKy628IGKMzBVDP6Ogyg5S+aM7180=;
        b=1gezajpEoejK2fq1GqJm0TfB6m11SDKNKgEP+X6yqusn+cCE4dy+nCB/Vs2SXVAcFb
         gSvgf2ZABanERs8v825Hfx51rc68z628ricjnSpmgbXQoU1x0q+qYGdgEg7WpVqqqGbP
         DsIEgOHisVV/iAVSdvnUBttgV8L/P/vI9DnZZ288Lvg3I5hi/wIFMLZU9Oj3FhqjrjbZ
         7oDrCtGStSKVG0tk6WK09mWhJY8e+eFcoVuaBoPkqcH1U+4sgZ1Sg41eVYApgud9W0tx
         WE3Vf571zWZhyssA2+Oj6PAmA3lJU7UNHHw91HuCiWYjDKIO8LNF83Ldyn6iBwnitLRY
         8SaQ==
X-Gm-Message-State: ACrzQf0xAwhjCEHTWJeYY+0zUbHnRAd/yikqQex7ysah7fBnYczlDsNV
        z6X6LTQylp8a6RMRtn6o2WTBiA==
X-Google-Smtp-Source: AMsMyM6m7B+599Iyuid6pXQukJaR/SNf6tD3mPxsm71Qoz5TJwWWG/w8YVJtJBIwCiBxmJiTVyTImg==
X-Received: by 2002:a63:fa4d:0:b0:43c:7fa:95f7 with SMTP id g13-20020a63fa4d000000b0043c07fa95f7mr8935584pgk.48.1665981413159;
        Sun, 16 Oct 2022 21:36:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm5557943plg.197.2022.10.16.21.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 21:36:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <yujie.liu@intel.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Dave Jones <davej@codemonkey.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] NFS: Avoid memcpy() run-time warning for struct sockaddr overflows
Date:   Sun, 16 Oct 2022 21:36:50 -0700
Message-Id: <20221017043107.never.457-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21163; h=from:subject:message-id; bh=sNUnTEPtsfqwG8Wst9Ezklh19eeBCAfsXg1nyaqS7EI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTNvhlqqbvR6zNYB/BIsoHlttFS1AsZvhOKajzd3D hUlAQbKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0zb4QAKCRCJcvTf3G3AJsy2D/ 4uHTFG8ZNlW8oj09P3zrQbBgvB3QOtsLXxidzEFwt8jdwOSLgdrCwzQK/ceBrzTznbZyIjcFpDhEjU gTXvXMZ4Abh/MnEUyOd2rDyHdKoRQvjc90qvPjkNtpZTTtivKbCh9p+sjyAKNgiqh0Ir1oqBAkG/Mj oC0N6d6gcb9LGd5A5Z3fHwjQe7OzCLkmhjqckGykq7iinH9n3cmgGGDtGBieIrmKPdH9s5eth95goX jQOQ1Mex5MH9GWpFUSnPhACyXao0I9zhyl9N3GBaAJcX4qfFCoBmxPuztpmWBzZH4ukRPEHyBv9Vnk TIXwI1cEnYPJp4eU5+YZJMXYNsKse6a9l5mLsCP1QPkLHgUX6AQMFouc+e89XdxH9g2NGCGE1t2TjI FlJf3ASsJ52SWtbtsK+BV6ro0l7SOEcOO3O8cgTPgHF06/XJdhFotfjRXlLENdRuCcA0SkV0RJQjDr eauM5xbTfCk/7F6O29c053Oz78yRDxAc1hTVOBl2eG0a0oeDPOtMngcHHp1oz4EIfsRaEAmISQlURY rIpJyPHnvobIu+RsnltMMf3zguop7pqQN1asVZ6M2tmPTr5dc5QlnWM0vR4RtInUCkvwcg/y19lq73 Zy/tvKx4kSO0rtcvwj8L6EpNlp2xmBCjt+IA3u+TZBHyoZ4Rwro3PFPzF8bA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The 'nfs_server' and 'mount_server' structures include a union of
'struct sockaddr' (with the older 16 bytes max address size) and
'struct sockaddr_storage' which is large enough to hold all the
supported sa_family types (128 bytes max size). The runtime memcpy()
buffer overflow checker is seeing attempts to write beyond the 16
bytes as an overflow, but the actual expected size is that of 'struct
sockaddr_storage'. Plumb the use of 'struct sockaddr_storage' more
completely through-out NFS, which results in adjusting the memcpy()
buffers to the correct union members. Avoids this false positive run-time
warning under CONFIG_FORTIFY_SOURCE:

  memcpy: detected field-spanning write (size 28) of single field "&ctx->nfs_server.address" at fs/nfs/namespace.c:178 (size 16)

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/all/202210110948.26b43120-yujie.liu@intel.com
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: expand to include all sockaddr destintations...
v1: https://lore.kernel.org/lkml/20221011065243.583650-1-keescook@chromium.org/
---
 fs/nfs/client.c        |  4 ++--
 fs/nfs/dns_resolve.c   |  7 ++++---
 fs/nfs/dns_resolve.h   |  2 +-
 fs/nfs/fs_context.c    | 14 +++++++-------
 fs/nfs/internal.h      | 14 +++++++-------
 fs/nfs/mount_clnt.c    |  4 ++--
 fs/nfs/namespace.c     |  2 +-
 fs/nfs/nfs3client.c    |  4 ++--
 fs/nfs/nfs4_fs.h       |  2 +-
 fs/nfs/nfs4client.c    | 18 +++++++++---------
 fs/nfs/nfs4namespace.c | 16 ++++++++--------
 fs/nfs/nfs4proc.c      |  4 ++--
 fs/nfs/pnfs_nfs.c      |  6 +++---
 fs/nfs/super.c         |  5 ++---
 14 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index da8da5cdbbc1..f50e025ae406 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -280,7 +280,7 @@ EXPORT_SYMBOL_GPL(nfs_put_client);
 static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *data)
 {
 	struct nfs_client *clp;
-	const struct sockaddr *sap = data->addr;
+	const struct sockaddr *sap = (struct sockaddr *)data->addr;
 	struct nfs_net *nn = net_generic(data->net, nfs_net_id);
 	int error;
 
@@ -666,7 +666,7 @@ static int nfs_init_server(struct nfs_server *server,
 	struct rpc_timeout timeparms;
 	struct nfs_client_initdata cl_init = {
 		.hostname = ctx->nfs_server.hostname,
-		.addr = (const struct sockaddr *)&ctx->nfs_server.address,
+		.addr = &ctx->nfs_server._address,
 		.addrlen = ctx->nfs_server.addrlen,
 		.nfs_mod = ctx->nfs_mod,
 		.proto = ctx->nfs_server.protocol,
diff --git a/fs/nfs/dns_resolve.c b/fs/nfs/dns_resolve.c
index e87d500ad95a..6603b5cee029 100644
--- a/fs/nfs/dns_resolve.c
+++ b/fs/nfs/dns_resolve.c
@@ -16,8 +16,9 @@
 #include "dns_resolve.h"
 
 ssize_t nfs_dns_resolve_name(struct net *net, char *name, size_t namelen,
-		struct sockaddr *sa, size_t salen)
+		struct sockaddr_storage *ss, size_t salen)
 {
+	struct sockaddr *sa = (struct sockaddr *)ss;
 	ssize_t ret;
 	char *ip_addr = NULL;
 	int ip_len;
@@ -341,7 +342,7 @@ static int do_cache_lookup_wait(struct cache_detail *cd,
 }
 
 ssize_t nfs_dns_resolve_name(struct net *net, char *name,
-		size_t namelen, struct sockaddr *sa, size_t salen)
+		size_t namelen, struct sockaddr_storage *ss, size_t salen)
 {
 	struct nfs_dns_ent key = {
 		.hostname = name,
@@ -354,7 +355,7 @@ ssize_t nfs_dns_resolve_name(struct net *net, char *name,
 	ret = do_cache_lookup_wait(nn->nfs_dns_resolve, &key, &item);
 	if (ret == 0) {
 		if (salen >= item->addrlen) {
-			memcpy(sa, &item->addr, item->addrlen);
+			memcpy(ss, &item->addr, item->addrlen);
 			ret = item->addrlen;
 		} else
 			ret = -EOVERFLOW;
diff --git a/fs/nfs/dns_resolve.h b/fs/nfs/dns_resolve.h
index 576ff4b54c82..fe3b172c4de1 100644
--- a/fs/nfs/dns_resolve.h
+++ b/fs/nfs/dns_resolve.h
@@ -32,6 +32,6 @@ extern void nfs_dns_resolver_cache_destroy(struct net *net);
 #endif
 
 extern ssize_t nfs_dns_resolve_name(struct net *net, char *name,
-		size_t namelen,	struct sockaddr *sa, size_t salen);
+		size_t namelen,	struct sockaddr_storage *sa, size_t salen);
 
 #endif
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 4da701fd1424..09833ec102fc 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -273,9 +273,9 @@ static const struct constant_table nfs_secflavor_tokens[] = {
  * Address family must be initialized, and address must not be
  * the ANY address for that family.
  */
-static int nfs_verify_server_address(struct sockaddr *addr)
+static int nfs_verify_server_address(struct sockaddr_storage *addr)
 {
-	switch (addr->sa_family) {
+	switch (addr->ss_family) {
 	case AF_INET: {
 		struct sockaddr_in *sa = (struct sockaddr_in *)addr;
 		return sa->sin_addr.s_addr != htonl(INADDR_ANY);
@@ -969,7 +969,7 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_fh *mntfh = ctx->mntfh;
-	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
+	struct sockaddr_storage *sap = &ctx->nfs_server._address;
 	int extra_flags = NFS_MOUNT_LEGACY_INTERFACE;
 	int ret;
 
@@ -1044,7 +1044,7 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 		memcpy(sap, &data->addr, sizeof(data->addr));
 		ctx->nfs_server.addrlen = sizeof(data->addr);
 		ctx->nfs_server.port = ntohs(data->addr.sin_port);
-		if (sap->sa_family != AF_INET ||
+		if (sap->ss_family != AF_INET ||
 		    !nfs_verify_server_address(sap))
 			goto out_no_address;
 
@@ -1200,7 +1200,7 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
 				 struct nfs4_mount_data *data)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
-	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
+	struct sockaddr_storage *sap = &ctx->nfs_server._address;
 	int ret;
 	char *c;
 
@@ -1314,7 +1314,7 @@ static int nfs_fs_context_validate(struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_subversion *nfs_mod;
-	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
+	struct sockaddr_storage *sap = &ctx->nfs_server._address;
 	int max_namelen = PAGE_SIZE;
 	int max_pathlen = NFS_MAXPATHLEN;
 	int port = 0;
@@ -1540,7 +1540,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->version		= nfss->nfs_client->rpc_ops->version;
 		ctx->minorversion	= nfss->nfs_client->cl_minorversion;
 
-		memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
+		memcpy(&ctx->nfs_server._address, &nfss->nfs_client->cl_addr,
 			ctx->nfs_server.addrlen);
 
 		if (fc->net_ns != net) {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index d914d609b85b..647fc3f547cb 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -69,7 +69,7 @@ static inline fmode_t flags_to_mode(int flags)
 struct nfs_client_initdata {
 	unsigned long init_flags;
 	const char *hostname;			/* Hostname of the server */
-	const struct sockaddr *addr;		/* Address of the server */
+	const struct sockaddr_storage *addr;	/* Address of the server */
 	const char *nodename;			/* Hostname of the client */
 	const char *ip_addr;			/* IP address of the client */
 	size_t addrlen;
@@ -180,7 +180,7 @@ static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
 
 /* mount_clnt.c */
 struct nfs_mount_request {
-	struct sockaddr		*sap;
+	struct sockaddr_storage	*sap;
 	size_t			salen;
 	char			*hostname;
 	char			*dirpath;
@@ -223,7 +223,7 @@ extern void nfs4_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(struct fs_context *);
 extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
-					struct sockaddr *sap, size_t salen,
+					struct sockaddr_storage *sap, size_t salen,
 					struct net *net);
 extern void nfs_free_server(struct nfs_server *server);
 extern struct nfs_server *nfs_clone_server(struct nfs_server *,
@@ -235,7 +235,7 @@ extern int nfs_client_init_status(const struct nfs_client *clp);
 extern int nfs_wait_client_init_complete(const struct nfs_client *clp);
 extern void nfs_mark_client_ready(struct nfs_client *clp, int state);
 extern struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
-					     const struct sockaddr *ds_addr,
+					     const struct sockaddr_storage *ds_addr,
 					     int ds_addrlen, int ds_proto,
 					     unsigned int ds_timeo,
 					     unsigned int ds_retrans,
@@ -243,7 +243,7 @@ extern struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 extern struct rpc_clnt *nfs4_find_or_create_ds_client(struct nfs_client *,
 						struct inode *);
 extern struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
-			const struct sockaddr *ds_addr, int ds_addrlen,
+			const struct sockaddr_storage *ds_addr, int ds_addrlen,
 			int ds_proto, unsigned int ds_timeo,
 			unsigned int ds_retrans);
 #ifdef CONFIG_PROC_FS
@@ -894,13 +894,13 @@ static inline bool nfs_error_is_fatal_on_server(int err)
  * Select between a default port value and a user-specified port value.
  * If a zero value is set, then autobind will be used.
  */
-static inline void nfs_set_port(struct sockaddr *sap, int *port,
+static inline void nfs_set_port(struct sockaddr_storage *sap, int *port,
 				const unsigned short default_port)
 {
 	if (*port == NFS_UNSPEC_PORT)
 		*port = default_port;
 
-	rpc_set_port(sap, *port);
+	rpc_set_port((struct sockaddr *)sap, *port);
 }
 
 struct nfs_direct_req {
diff --git a/fs/nfs/mount_clnt.c b/fs/nfs/mount_clnt.c
index c5e3b6b3366a..68e76b626371 100644
--- a/fs/nfs/mount_clnt.c
+++ b/fs/nfs/mount_clnt.c
@@ -158,7 +158,7 @@ int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans)
 	struct rpc_create_args args = {
 		.net		= info->net,
 		.protocol	= info->protocol,
-		.address	= info->sap,
+		.address	= (struct sockaddr *)info->sap,
 		.addrsize	= info->salen,
 		.timeout	= &mnt_timeout,
 		.servername	= info->hostname,
@@ -245,7 +245,7 @@ void nfs_umount(const struct nfs_mount_request *info)
 	struct rpc_create_args args = {
 		.net		= info->net,
 		.protocol	= IPPROTO_UDP,
-		.address	= info->sap,
+		.address	= (struct sockaddr *)info->sap,
 		.addrsize	= info->salen,
 		.timeout	= &nfs_umnt_timeout,
 		.servername	= info->hostname,
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 3295af4110f1..2f336ace7555 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -175,7 +175,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	}
 
 	/* for submounts we want the same server; referrals will reassign */
-	memcpy(&ctx->nfs_server.address, &client->cl_addr, client->cl_addrlen);
+	memcpy(&ctx->nfs_server._address, &client->cl_addr, client->cl_addrlen);
 	ctx->nfs_server.addrlen	= client->cl_addrlen;
 	ctx->nfs_server.port	= server->port;
 
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index b49359afac88..669cda757a5c 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -78,7 +78,7 @@ struct nfs_server *nfs3_clone_server(struct nfs_server *source,
  * the MDS.
  */
 struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
-		const struct sockaddr *ds_addr, int ds_addrlen,
+		const struct sockaddr_storage *ds_addr, int ds_addrlen,
 		int ds_proto, unsigned int ds_timeo, unsigned int ds_retrans)
 {
 	struct rpc_timeout ds_timeout;
@@ -98,7 +98,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 	char buf[INET6_ADDRSTRLEN + 1];
 
 	/* fake a hostname because lockd wants it */
-	if (rpc_ntop(ds_addr, buf, sizeof(buf)) <= 0)
+	if (rpc_ntop((struct sockaddr *)ds_addr, buf, sizeof(buf)) <= 0)
 		return ERR_PTR(-EINVAL);
 	cl_init.hostname = buf;
 
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 400a71e75238..cfef738d765e 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -281,7 +281,7 @@ struct rpc_clnt *nfs4_negotiate_security(struct rpc_clnt *, struct inode *,
 int nfs4_submount(struct fs_context *, struct nfs_server *);
 int nfs4_replace_transport(struct nfs_server *server,
 				const struct nfs4_fs_locations *locations);
-size_t nfs_parse_server_name(char *string, size_t len, struct sockaddr *sa,
+size_t nfs_parse_server_name(char *string, size_t len, struct sockaddr_storage *ss,
 			     size_t salen, struct net *net, int port);
 /* nfs4proc.c */
 extern int nfs4_handle_exception(struct nfs_server *, int, struct nfs4_exception *);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 7a5162afa5c0..3b9b53481309 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -889,7 +889,7 @@ nfs4_find_client_sessionid(struct net *net, const struct sockaddr *addr,
  */
 static int nfs4_set_client(struct nfs_server *server,
 		const char *hostname,
-		const struct sockaddr *addr,
+		const struct sockaddr_storage *addr,
 		const size_t addrlen,
 		const char *ip_addr,
 		int proto, const struct rpc_timeout *timeparms,
@@ -924,7 +924,7 @@ static int nfs4_set_client(struct nfs_server *server,
 		__set_bit(NFS_CS_MIGRATION, &cl_init.init_flags);
 	if (test_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status))
 		__set_bit(NFS_CS_TSM_POSSIBLE, &cl_init.init_flags);
-	server->port = rpc_get_port(addr);
+	server->port = rpc_get_port((struct sockaddr *)addr);
 
 	/* Allocate or find a client reference we can use */
 	clp = nfs_get_client(&cl_init);
@@ -960,7 +960,7 @@ static int nfs4_set_client(struct nfs_server *server,
  * the MDS.
  */
 struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
-		const struct sockaddr *ds_addr, int ds_addrlen,
+		const struct sockaddr_storage *ds_addr, int ds_addrlen,
 		int ds_proto, unsigned int ds_timeo, unsigned int ds_retrans,
 		u32 minor_version)
 {
@@ -980,7 +980,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 	};
 	char buf[INET6_ADDRSTRLEN + 1];
 
-	if (rpc_ntop(ds_addr, buf, sizeof(buf)) <= 0)
+	if (rpc_ntop((struct sockaddr *)ds_addr, buf, sizeof(buf)) <= 0)
 		return ERR_PTR(-EINVAL);
 	cl_init.hostname = buf;
 
@@ -1148,7 +1148,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 	/* Get a client record */
 	error = nfs4_set_client(server,
 				ctx->nfs_server.hostname,
-				&ctx->nfs_server.address,
+				&ctx->nfs_server._address,
 				ctx->nfs_server.addrlen,
 				ctx->client_address,
 				ctx->nfs_server.protocol,
@@ -1238,7 +1238,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 	rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
 	error = nfs4_set_client(server,
 				ctx->nfs_server.hostname,
-				&ctx->nfs_server.address,
+				&ctx->nfs_server._address,
 				ctx->nfs_server.addrlen,
 				parent_client->cl_ipaddr,
 				XPRT_TRANSPORT_RDMA,
@@ -1254,7 +1254,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 	rpc_set_port(&ctx->nfs_server.address, NFS_PORT);
 	error = nfs4_set_client(server,
 				ctx->nfs_server.hostname,
-				&ctx->nfs_server.address,
+				&ctx->nfs_server._address,
 				ctx->nfs_server.addrlen,
 				parent_client->cl_ipaddr,
 				XPRT_TRANSPORT_TCP,
@@ -1303,14 +1303,14 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
  * Returns zero on success, or a negative errno value.
  */
 int nfs4_update_server(struct nfs_server *server, const char *hostname,
-		       struct sockaddr *sap, size_t salen, struct net *net)
+		       struct sockaddr_storage *sap, size_t salen, struct net *net)
 {
 	struct nfs_client *clp = server->nfs_client;
 	struct rpc_clnt *clnt = server->client;
 	struct xprt_create xargs = {
 		.ident		= clp->cl_proto,
 		.net		= net,
-		.dstaddr	= sap,
+		.dstaddr	= (struct sockaddr *)sap,
 		.addrlen	= salen,
 		.servername	= hostname,
 	};
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index f2dbf904c598..9a98595bb160 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -164,16 +164,17 @@ static int nfs4_validate_fspath(struct dentry *dentry,
 	return 0;
 }
 
-size_t nfs_parse_server_name(char *string, size_t len, struct sockaddr *sa,
+size_t nfs_parse_server_name(char *string, size_t len, struct sockaddr_storage *ss,
 			     size_t salen, struct net *net, int port)
 {
+	struct sockaddr *sa = (struct sockaddr *)ss;
 	ssize_t ret;
 
 	ret = rpc_pton(net, string, len, sa, salen);
 	if (ret == 0) {
 		ret = rpc_uaddr2sockaddr(net, string, len, sa, salen);
 		if (ret == 0) {
-			ret = nfs_dns_resolve_name(net, string, len, sa, salen);
+			ret = nfs_dns_resolve_name(net, string, len, ss, salen);
 			if (ret < 0)
 				ret = 0;
 		}
@@ -331,7 +332,7 @@ static int try_location(struct fs_context *fc,
 
 		ctx->nfs_server.addrlen =
 			nfs_parse_server_name(buf->data, buf->len,
-					      &ctx->nfs_server.address,
+					      &ctx->nfs_server._address,
 					      sizeof(ctx->nfs_server._address),
 					      fc->net_ns, 0);
 		if (ctx->nfs_server.addrlen == 0)
@@ -483,14 +484,13 @@ static int nfs4_try_replacing_one_location(struct nfs_server *server,
 		char *page, char *page2,
 		const struct nfs4_fs_location *location)
 {
-	const size_t addr_bufsize = sizeof(struct sockaddr_storage);
 	struct net *net = rpc_net_ns(server->client);
-	struct sockaddr *sap;
+	struct sockaddr_storage *sap;
 	unsigned int s;
 	size_t salen;
 	int error;
 
-	sap = kmalloc(addr_bufsize, GFP_KERNEL);
+	sap = kmalloc(sizeof(*sap), GFP_KERNEL);
 	if (sap == NULL)
 		return -ENOMEM;
 
@@ -506,10 +506,10 @@ static int nfs4_try_replacing_one_location(struct nfs_server *server,
 			continue;
 
 		salen = nfs_parse_server_name(buf->data, buf->len,
-						sap, addr_bufsize, net, 0);
+					      sap, sizeof(*sap), net, 0);
 		if (salen == 0)
 			continue;
-		rpc_set_port(sap, NFS_PORT);
+		rpc_set_port((struct sockaddr *)sap, NFS_PORT);
 
 		error = -ENOMEM;
 		hostname = kmemdup_nul(buf->data, buf->len, GFP_KERNEL);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e2efcd26336c..4c4df7f213b6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3951,7 +3951,7 @@ static void test_fs_location_for_trunking(struct nfs4_fs_location *location,
 
 	for (i = 0; i < location->nservers; i++) {
 		struct nfs4_string *srv_loc = &location->servers[i];
-		struct sockaddr addr;
+		struct sockaddr_storage addr;
 		size_t addrlen;
 		struct xprt_create xprt_args = {
 			.ident = 0,
@@ -3974,7 +3974,7 @@ static void test_fs_location_for_trunking(struct nfs4_fs_location *location,
 						clp->cl_net, server->port);
 		if (!addrlen)
 			return;
-		xprt_args.dstaddr = &addr;
+		xprt_args.dstaddr = (struct sockaddr *)&addr;
 		xprt_args.addrlen = addrlen;
 		servername = kmalloc(srv_loc->len + 1, GFP_KERNEL);
 		if (!servername)
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 987c88ddeaf0..5d035dd2d7bf 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -821,7 +821,7 @@ static void nfs4_clear_ds_conn_bit(struct nfs4_pnfs_ds *ds)
 
 static struct nfs_client *(*get_v3_ds_connect)(
 			struct nfs_server *mds_srv,
-			const struct sockaddr *ds_addr,
+			const struct sockaddr_storage *ds_addr,
 			int ds_addrlen,
 			int ds_proto,
 			unsigned int ds_timeo,
@@ -882,7 +882,7 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 			continue;
 		}
 		clp = get_v3_ds_connect(mds_srv,
-				(struct sockaddr *)&da->da_addr,
+				&da->da_addr,
 				da->da_addrlen, da->da_transport,
 				timeo, retrans);
 		if (IS_ERR(clp))
@@ -951,7 +951,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				put_cred(xprtdata.cred);
 		} else {
 			clp = nfs4_set_ds_client(mds_srv,
-						(struct sockaddr *)&da->da_addr,
+						&da->da_addr,
 						da->da_addrlen,
 						da->da_transport, timeo,
 						retrans, minor_version);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index ee66ffdb985e..05ae23657527 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -822,8 +822,7 @@ static int nfs_request_mount(struct fs_context *fc,
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_mount_request request = {
-		.sap		= (struct sockaddr *)
-						&ctx->mount_server.address,
+		.sap		= &ctx->mount_server._address,
 		.dirpath	= ctx->nfs_server.export_path,
 		.protocol	= ctx->mount_server.protocol,
 		.fh		= root_fh,
@@ -854,7 +853,7 @@ static int nfs_request_mount(struct fs_context *fc,
 	 * Construct the mount server's address.
 	 */
 	if (ctx->mount_server.address.sa_family == AF_UNSPEC) {
-		memcpy(request.sap, &ctx->nfs_server.address,
+		memcpy(request.sap, &ctx->nfs_server._address,
 		       ctx->nfs_server.addrlen);
 		ctx->mount_server.addrlen = ctx->nfs_server.addrlen;
 	}
-- 
2.34.1

