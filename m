Return-Path: <linux-nfs+bounces-13029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A6B03716
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 08:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE4D1747C2
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2532253A7;
	Mon, 14 Jul 2025 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Muy42ywc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C369BE4A
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474662; cv=none; b=Slyn//a/RIjnu/CYfcmS8DilrZlE7p6MrVBGVMYyZbK9MSTyroiKr2nLUbPV2TaCuyeRFHqDNDOl4kRiOKOOLSkD/iWKIPtVIynq73UWktGn6fMNQwdAVyI/4qgqpyVmiWU2UhGE6P7Uw9UJGIOw3zsHMtzsam/nae6JCpL95iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474662; c=relaxed/simple;
	bh=ByVRIDBJqQ5/EPNKiSMS/4rVu5PXAweiWmd63ChiquY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOcdb5hCC/po2eud3mGwHpRA/rNTC3LsfrePJ8YtN1VE0Sr9GgICjZvZV8N8HJynqZ45hSXNKMsOQfUzAxIJL8KjLH1QuMHhcrixBByPDxEtYsKIbTjxodGqLu7NcHWLm0/VShN9zjcm7Uno1XrTbzKC4lJP8Xq2iDR+ZXxQvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Muy42ywc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DYFHpRz4cgmJapo7ZSrhtPfCBI7JPRjyP5bKiL53jyU=; b=Muy42ywcFotXV8b84xHZzA6GFa
	1YdSpn9iAlCtdlTBr824E6bLEAumYiZpWWykZuWbsnIxo1blL872Buqt4qMpLzcrVJP3bbBlmz1aM
	hRhiBK9uICZHax7WSEH8aSWx+EORU8AfIB1Wn2ZZCsiPhrXx/ouH6w95nBl01rn9xQMX/mA1Xwq2X
	e5qWv5ca8Hr68W8LNHGVPa09I2yGqekZUp3tlLZZlhqgPVqhEBsmRsw0/eMv9LJ0mXyF6VY+q9chL
	cHKIyOn9PR9qUfi4dsarWj4He1jB8BqPrNFAOzobY7j4dFi6zX6LoNx8LmuZa9i+S37fFl6x2vh3G
	9PHcSm5Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubCiJ-00000001LzB-3Wqm;
	Mon, 14 Jul 2025 06:31:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: add a clientid mount option
Date: Mon, 14 Jul 2025 08:30:46 +0200
Message-ID: <20250714063053.1487761-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714063053.1487761-1-hch@lst.de>
References: <20250714063053.1487761-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a mount option to set a clientid, similarly to how it can be
configured through the per-netfs sysfs file.  This allows for easy
testing of behavior that relies on the client ID likes locks or
delegations with having to resort to separate VMs or containers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/client.c           | 12 ++++++++++++
 fs/nfs/fs_context.c       | 12 ++++++++++++
 fs/nfs/internal.h         |  2 ++
 fs/nfs/nfs4client.c       |  1 +
 fs/nfs/nfs4proc.c         |  7 ++++++-
 include/linux/nfs_fs_sb.h |  1 +
 6 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 47258dc3af70..1a55debab6e5 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -181,6 +181,12 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_nconnect = cl_init->nconnect;
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
 	clp->cl_net = get_net_track(cl_init->net, &clp->cl_ns_tracker, GFP_KERNEL);
+	if (cl_init->clientid) {
+		err = -ENOMEM;
+		clp->clientid = kstrdup(cl_init->clientid, GFP_KERNEL);
+		if (!clp->clientid)
+			goto error_free_host;
+	}
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	seqlock_init(&clp->cl_boot_lock);
@@ -193,6 +199,8 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_xprtsec = cl_init->xprtsec;
 	return clp;
 
+error_free_host:
+	kfree(clp->cl_hostname);
 error_cleanup:
 	put_nfs_version(clp->cl_nfs_mod);
 error_dealloc:
@@ -254,6 +262,7 @@ void nfs_free_client(struct nfs_client *clp)
 	put_nfs_version(clp->cl_nfs_mod);
 	kfree(clp->cl_hostname);
 	kfree(clp->cl_acceptor);
+	kfree(clp->clientid);
 	kfree_rcu(clp, rcu);
 }
 EXPORT_SYMBOL_GPL(nfs_free_client);
@@ -339,6 +348,9 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
 		if (clp->cl_xprtsec.policy != data->xprtsec.policy)
 			continue;
 
+		if (data->clientid && data->clientid != clp->clientid)
+			continue;
+
 		refcount_inc(&clp->cl_count);
 		return clp;
 	}
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9e94d18448ff..fe9ecdc8db3c 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -98,6 +98,7 @@ enum nfs_param {
 	Opt_xprtsec,
 	Opt_cert_serial,
 	Opt_privkey_serial,
+	Opt_clientid,
 };
 
 enum {
@@ -225,6 +226,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_string("xprtsec",	Opt_xprtsec),
 	fsparam_s32("cert_serial",	Opt_cert_serial),
 	fsparam_s32("privkey_serial",	Opt_privkey_serial),
+	fsparam_string("clientid",	Opt_clientid),
 	{}
 };
 
@@ -1031,6 +1033,14 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			goto out_invalid_value;
 		}
 		break;
+	case Opt_clientid:
+		if (!param->string || strlen(param->string) == 0 ||
+		    strlen(param->string) > NFS4_CLIENT_ID_UNIQ_LEN - 1)
+			goto out_of_bounds;
+		kfree(ctx->clientid);
+		ctx->clientid = param->string;
+		param->string = NULL;
+		break;
 
 		/*
 		 * Special options
@@ -1650,6 +1660,7 @@ static int nfs_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 	ctx->nfs_server.hostname	= NULL;
 	ctx->fscache_uniq		= NULL;
 	ctx->clone_data.fattr		= NULL;
+	ctx->clientid			= NULL;
 	fc->fs_private = ctx;
 	return 0;
 }
@@ -1670,6 +1681,7 @@ static void nfs_fs_context_free(struct fs_context *fc)
 		kfree(ctx->fscache_uniq);
 		nfs_free_fhandle(ctx->mntfh);
 		nfs_free_fattr(ctx->clone_data.fattr);
+		kfree(ctx->clientid);
 		kfree(ctx);
 	}
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 69c2c10ee658..1a392676d27c 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -86,6 +86,7 @@ struct nfs_client_initdata {
 	struct xprtsec_parms xprtsec;
 	unsigned long connect_timeout;
 	unsigned long reconnect_timeout;
+	const char *clientid;
 };
 
 /*
@@ -115,6 +116,7 @@ struct nfs_fs_context {
 	unsigned short		mountfamily;
 	bool			has_sec_mnt_opts;
 	int			lock_status;
+	char			*clientid;
 
 	struct {
 		union {
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 2e623da1a787..3ab5cc985224 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1153,6 +1153,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 		.xprtsec = ctx->xprtsec,
 		.nconnect = ctx->nfs_server.nconnect,
 		.max_connect = ctx->nfs_server.max_connect,
+		.clientid = ctx->clientid,
 	};
 	int error;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ef2077e185b6..ad53bc4ef50c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6487,6 +6487,11 @@ nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
 
 	buf[0] = '\0';
 
+	if (clp->clientid) {
+		strscpy(buf, clp->clientid, buflen);
+		goto out;
+	}
+
 	if (nn_clp) {
 		rcu_read_lock();
 		id = rcu_dereference(nn_clp->identifier);
@@ -6497,7 +6502,7 @@ nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
 
 	if (nfs4_client_id_uniquifier[0] != '\0' && buf[0] == '\0')
 		strscpy(buf, nfs4_client_id_uniquifier, buflen);
-
+out:
 	return strlen(buf);
 }
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d2d36711a119..73bed04529a7 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -128,6 +128,7 @@ struct nfs_client {
 	netns_tracker		cl_ns_tracker;
 	struct list_head	pending_cb_stateids;
 	struct rcu_head		rcu;
+	const char		*clientid;
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	struct timespec64	cl_nfssvc_boot;
-- 
2.47.2


