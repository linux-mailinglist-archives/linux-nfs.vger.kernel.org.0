Return-Path: <linux-nfs+bounces-3616-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F59900BB7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 20:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A98C1C21DB6
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BD1197A90;
	Fri,  7 Jun 2024 18:06:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91417582
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783567; cv=none; b=Db7q1/9llI1d3sNU+LBkemX+nmLCGPPIgu2wXXMJPZ16VQqjkU4RdE2nAzrIS5ioYzQtf94De0V5mo6Z/5vaRekK0MTxlaLm/U/6Q5OAfwPpuAA9yuBKvKNcBaZIgxTXCREf0NHOH/pT4R33jyiZNlfRkGfs4tZVXUQzZbhFJTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783567; c=relaxed/simple;
	bh=b4L5nnaRLFkGD5090XEx0mMNvG8CVe8HUWE8FlZS8u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAkJUwK3ayZ7c5daCgnSUVQ1asuielBxziHoRbOQ8a8w1JoP4qTRxq+x1VLDnNQnYzJdVk3hooCRUv7I8WiImHEAM1CRX43crFpD16nvxGe+8MJ/gT8CslcerkE5uwmUJfh7/CCPqEvoTZaS3uVRRxQiYX1kcvPJ+0i3ZxYUaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5babfde1c04so374914eaf.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 11:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717783563; x=1718388363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTyjQnWXU/VUektGFWk3gptg4HhF5fJ8j9Hl7ufm6B0=;
        b=cOB+wVY0s92Zp91zJ56a/O5cSb+socRp1QY8deiC8x3qVqt16BY/B4QbMy/mfLro34
         /+3i0Z2TTJxLTdRvcGWjMFelipWZmGSt2JToQy/98oLDPaJ+Nj8C1Mu4kU+2elFruodF
         9nuXqsGzNWetxrN3yAaUvTfwBysZEAn4rWeK2WH8cPtnlVIgsh1ElB6Dd+uXECBmHW4t
         mjC4EwilGmO2tiFQHHLD9rw/TuYpfTLhkpE8P28v5EVpPZbOJqwRMRHw9DC0Zuf+wDUX
         Nk4HfoEgNRKoeaHgPwle2PJ2GLZJERK8YgxoAtnHzb2l9zq18sucoqApH7ozmSsLHVJw
         3ihQ==
X-Gm-Message-State: AOJu0Yx9UjxrnJED4SP7jI2z9rdekqyoIuhEe7X6JafwQbIaBLY5KiE+
	qkQMbTX0rFU7xcrZ6i98adXO40axKPJh5eIUsuTnUS4Vdhm68QMb/ZuJVeE/LMJfLBvBp9z9by2
	2bTNMaQ==
X-Google-Smtp-Source: AGHT+IE7zQqSuj+MjM8AKoIxtobYeTgKqWgwqoaYxNrYFDtXuHyeDPMayA7bpt2jYcf/YsBiBw1BGQ==
X-Received: by 2002:a05:6358:c6a4:b0:19f:1343:7f0a with SMTP id e5c5f4694b2df-19f1f719dd6mr271248355d.0.1717783563359;
        Fri, 07 Jun 2024 11:06:03 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038ab428bsm14371631cf.53.2024.06.07.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 11:06:02 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:06:01 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: [for-6.11 PATCH 30/29] nfs/nfsd: ensure localio server always uses
 its network namespace
Message-ID: <ZmNMCejlYlDgfA1Q@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>

Pass the stored cl_nfssvc_net from the client to the server as first
argument to nfsd_open_local_fh() to ensure the proper network
namespace is used for localio.

Otherwise, before this commit, the nfs_client's network namespace was
used (as extracted from the client's cl_rpcclient). This is clearly
not going to allow proper functionality if the client and server
happen to have disjoint network namespaces.

Elected to not rename the nfsd_uuid_t structure despite it growing a
non-uuid member. Can revisit later.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c            |  1 +
 fs/nfs/localio.c           |  7 +++++--
 fs/nfs_common/nfslocalio.c | 15 +++++++++------
 fs/nfsd/localio.c          |  9 +++++----
 fs/nfsd/nfssvc.c           |  1 +
 fs/nfsd/vfs.h              |  3 ++-
 include/linux/nfs_fs_sb.h  |  1 +
 include/linux/nfslocalio.h | 10 ++++++----
 8 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 3d356fb05aee..16636c68148f 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -171,6 +171,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 
 	INIT_LIST_HEAD(&clp->cl_superblocks);
 	clp->cl_rpcclient = clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+	clp->cl_nfssvc_net = NULL;
 	clp->nfsd_open_local_fh = NULL;
 
 	clp->cl_flags = cl_init->init_flags;
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index fb1ebc9715ff..1c970763bcc5 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -187,6 +187,7 @@ static bool nfs_local_server_getuuid(struct nfs_client *clp, uuid_t *nfsd_uuid)
 void nfs_local_probe(struct nfs_client *clp)
 {
 	uuid_t uuid;
+	struct net *net = NULL;
 
 	if (!localio_enabled)
 		return;
@@ -202,8 +203,9 @@ void nfs_local_probe(struct nfs_client *clp)
 		if (!nfs_local_server_getuuid(clp, &uuid))
 			return;
 		/* Verify client's nfsd, with specififed uuid, is local */
-		if (!nfsd_uuid_is_local(&uuid))
+		if (!nfsd_uuid_is_local(&uuid, &net))
 			return;
+		clp->cl_nfssvc_net = net;
 		break;
 	default:
 		return; /* localio not supported */
@@ -229,7 +231,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 	if (mode & ~(FMODE_READ | FMODE_WRITE))
 		return ERR_PTR(-EINVAL);
 
-	status = clp->nfsd_open_local_fh(clp->cl_rpcclient, cred, fh, mode, &filp);
+	status = clp->nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_rpcclient,
+					cred, fh, mode, &filp);
 	if (status < 0) {
 		dprintk("%s: open local file failed error=%d\n",
 				__func__, status);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index c454c4100976..086e09b3ec38 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -12,29 +12,32 @@ MODULE_LICENSE("GPL");
 /*
  * Global list of nfsd_uuid_t instances, add/remove
  * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
- * Reads are protected RCU read lock (see below).
+ * Reads are protected by RCU read lock (see below).
  */
 LIST_HEAD(nfsd_uuids);
 EXPORT_SYMBOL(nfsd_uuids);
 
 /* Must be called with RCU read lock held. */
-static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid)
+static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid,
+				struct net **netp)
 {
 	nfsd_uuid_t *nfsd_uuid;
 
 	list_for_each_entry_rcu(nfsd_uuid, &nfsd_uuids, list)
-		if (uuid_equal(&nfsd_uuid->uuid, uuid))
+		if (uuid_equal(&nfsd_uuid->uuid, uuid)) {
+			*netp = nfsd_uuid->net;
 			return &nfsd_uuid->uuid;
+		}
 
 	return &uuid_null;
 }
 
-bool nfsd_uuid_is_local(const uuid_t *uuid)
+bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp)
 {
 	const uuid_t *nfsd_uuid;
 
 	rcu_read_lock();
-	nfsd_uuid = nfsd_uuid_lookup(uuid);
+	nfsd_uuid = nfsd_uuid_lookup(uuid, netp);
 	rcu_read_unlock();
 
 	return !uuid_is_null(nfsd_uuid);
@@ -51,7 +54,7 @@ EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
  * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
  */
 
-extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+extern int nfsd_open_local_fh(struct net *, struct rpc_clnt *rpc_clnt,
 			const struct cred *cred, const struct nfs_fh *nfs_fh,
 			const fmode_t fmode, struct file **pfilp);
 
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index c4324a0fff57..0ff9ea6b8944 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -35,10 +35,10 @@ nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
 }
 
 static struct svc_rqst *
-nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred *cred)
+nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
+			const struct cred *cred)
 {
 	struct svc_rqst *rqstp;
-	struct net *net = rpc_net_ns(rpc_clnt);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int status;
 
@@ -122,7 +122,8 @@ nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred *cred)
  * dependency on knfsd. So, there is no forward declaration in a header file
  * for it.
  */
-int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+int nfsd_open_local_fh(struct net *net,
+			 struct rpc_clnt *rpc_clnt,
 			 const struct cred *cred,
 			 const struct nfs_fh *nfs_fh,
 			 const fmode_t fmode,
@@ -139,7 +140,7 @@ int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
 	/* Save creds before calling into nfsd */
 	save_cred = get_current_cred();
 
-	rqstp = nfsd_local_fakerqst_create(rpc_clnt, cred);
+	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred);
 	if (IS_ERR(rqstp)) {
 		status = PTR_ERR(rqstp);
 		goto out_revertcred;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 72ed4ed11c95..f63cdeef9c64 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -473,6 +473,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 #endif
 #if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
+	nn->nfsd_uuid.net = net;
 	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
 #endif
 	nn->nfsd_net_up = true;
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 91c50649a8c7..af07bb146e81 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -160,7 +160,8 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 
 void		nfsd_filp_close(struct file *fp);
 
-int		nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+int		nfsd_open_local_fh(struct net *net,
+				   struct rpc_clnt *rpc_clnt,
 				   const struct cred *cred,
 				   const struct nfs_fh *nfs_fh,
 				   const fmode_t fmode,
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index f5760b05ec87..f47ea512eb0a 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -132,6 +132,7 @@ struct nfs_client {
 	struct timespec64	cl_nfssvc_boot;
 	seqlock_t		cl_boot_lock;
 	struct rpc_clnt *	cl_rpcclient_localio;	/* localio RPC client handle */
+	struct net *	        cl_nfssvc_net;
 	nfs_to_nfsd_open_t	nfsd_open_local_fh;
 };
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index b8df1b9f248d..c9592ad0afe2 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/uuid.h>
 #include <linux/nfs.h>
+#include <net/net_namespace.h>
 
 /*
  * Global list of nfsd_uuid_t instances, add/remove
@@ -23,13 +24,14 @@ extern struct list_head nfsd_uuids;
 typedef struct {
 	uuid_t uuid;
 	struct list_head list;
+	struct net *net; /* nfsd's network namespace */
 } nfsd_uuid_t;
 
-bool nfsd_uuid_is_local(const uuid_t *uuid);
+bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp);
 
-typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *,
-				  const struct nfs_fh *, const fmode_t,
-				  struct file **);
+typedef int (*nfs_to_nfsd_open_t)(struct net *, struct rpc_clnt *,
+				const struct cred *, const struct nfs_fh *,
+				const fmode_t, struct file **);
 
 nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
 void put_nfsd_open_local_fh(void);
-- 
2.44.0


