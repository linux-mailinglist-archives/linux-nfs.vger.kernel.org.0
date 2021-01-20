Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B6E2FD665
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391610AbhATRDU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391591AbhATRBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKFsOhTznFM6N9AwV6ZGfLquZjyVley8z2wFoVGINKM=;
        b=KLN+x2jvoQ5fwtoK6tKpopWZe5SNFlQ5T2Ug53tK0sANRQXT7NYRHvtfd1p+Q1oFJ0sTCC
        NOvOWJucp6WalgjsHfywYiQSF3vkHIEd8JJ2Bu+rjP4FO6Pd00V1dVqrBBDx4TnLoYAMEH
        v6X9joE0sK1m8TAAh3iXRi7tV3Tk5is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-dzEqNj69OLOavYZZU8Hh3Q-1; Wed, 20 Jan 2021 11:59:55 -0500
X-MC-Unique: dzEqNj69OLOavYZZU8Hh3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 196FD8030A2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E053E5D6DC
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:54 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 7982710E3EEB; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 02/10] NFSv4: Send GETATTR with READDIR
Date:   Wed, 20 Jan 2021 11:59:46 -0500
Message-Id: <2c57b6f0405c48e4789e9afc56b12f1f64b796b1.1611160120.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For each batch of entries, track whether the directory has changed.  We can
use this information to better manage the cache when reading long
directories.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs42proc.c        |  2 +-
 fs/nfs/nfs4proc.c         | 27 +++++++++++++++++++--------
 fs/nfs/nfs4xdr.c          |  6 ++++++
 include/linux/nfs_fs_sb.h |  5 +++++
 include/linux/nfs_xdr.h   |  2 ++
 5 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index f3fd935620fc..576296728889 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1011,7 +1011,7 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 		.src_offset = src_offset,
 		.dst_offset = dst_offset,
 		.count = count,
-		.dst_bitmask = server->cache_consistency_bitmask,
+		.dst_bitmask = server->cache_consistency_bitmask_nl,
 	};
 	struct nfs42_clone_res res = {
 		.server	= server,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2f4679a62712..5a2ea98dc1a6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3654,7 +3654,7 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 	if (calldata->arg.fmode == 0 || calldata->arg.fmode == FMODE_READ) {
 		/* Close-to-open cache consistency revalidation */
 		if (!nfs4_have_delegation(inode, FMODE_READ)) {
-			calldata->arg.bitmask = NFS_SERVER(inode)->cache_consistency_bitmask;
+			calldata->arg.bitmask = NFS_SERVER(inode)->cache_consistency_bitmask_nl;
 			nfs4_bitmask_adjust(calldata->arg.bitmask, inode, NFS_SERVER(inode), NULL);
 		} else
 			calldata->arg.bitmask = NULL;
@@ -3882,7 +3882,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
 		server->cache_consistency_bitmask[1] &= FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
-		server->cache_consistency_bitmask[2] = 0;
+		server->cache_consistency_bitmask[2] = res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL;
+
+		memcpy(server->cache_consistency_bitmask_nl, server->cache_consistency_bitmask, sizeof(server->cache_consistency_bitmask));
+		server->cache_consistency_bitmask_nl[2] = 0;
 
 		/* Avoid a regression due to buggy server */
 		for (i = 0; i < ARRAY_SIZE(res.exclcreat_bitmask); i++)
@@ -4451,7 +4454,7 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 		res.fattr = nfs_alloc_fattr();
 		if (res.fattr == NULL)
 			return -ENOMEM;
-		args.bitmask = server->cache_consistency_bitmask;
+		args.bitmask = server->cache_consistency_bitmask_nl;
 	}
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (!status) {
@@ -4980,14 +4983,19 @@ static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
 		.rpc_resp = &res,
 		.rpc_cred = nr_arg->cred,
 	};
-	int			status;
+	int			status = -ENOMEM;
 
 	dprintk("%s: dentry = %pd2, cookie = %llu\n", __func__,
 		nr_arg->dentry, (unsigned long long)nr_arg->cookie);
 	if (!(server->caps & NFS_CAP_SECURITY_LABEL))
-		args.bitmask = server->attr_bitmask_nl;
+		args.bitmask = server->cache_consistency_bitmask_nl;
 	else
-		args.bitmask = server->attr_bitmask;
+		args.bitmask = server->cache_consistency_bitmask;
+
+	res.dir_attr = nfs_alloc_fattr();
+	if (res.dir_attr == NULL)
+		goto out;
+	res.server = NFS_SERVER(dir);
 
 	nfs4_setup_readdir(nr_arg->cookie, nr_arg->verf, nr_arg->dentry, &args);
 	res.pgbase = args.pgbase;
@@ -5000,6 +5008,9 @@ static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
 
 	nfs_invalidate_atime(dir);
 
+	nfs_refresh_inode(dir, res.dir_attr);
+	nfs_free_fattr(res.dir_attr);
+out:
 	dprintk("%s: returns %d\n", __func__, status);
 	return status;
 }
@@ -5465,7 +5476,7 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 		hdr->args.bitmask = NULL;
 		hdr->res.fattr = NULL;
 	} else {
-		hdr->args.bitmask = server->cache_consistency_bitmask;
+		hdr->args.bitmask = server->cache_consistency_bitmask_nl;
 		nfs4_bitmask_adjust(hdr->args.bitmask, hdr->inode, server, NULL);
 	}
 
@@ -6505,7 +6516,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 
 	data->args.fhandle = &data->fh;
 	data->args.stateid = &data->stateid;
-	data->args.bitmask = server->cache_consistency_bitmask;
+	data->args.bitmask = server->cache_consistency_bitmask_nl;
 	nfs4_bitmask_adjust(data->args.bitmask, inode, server, NULL);
 	nfs_copy_fh(&data->fh, NFS_FH(inode));
 	nfs4_stateid_copy(&data->stateid, stateid);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index ac6b79ee9355..02a3df42d61d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -459,10 +459,12 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define NFS4_enc_readdir_sz	(compound_encode_hdr_maxsz + \
 				encode_sequence_maxsz + \
 				encode_putfh_maxsz + \
+				encode_getattr_maxsz + \
 				encode_readdir_maxsz)
 #define NFS4_dec_readdir_sz	(compound_decode_hdr_maxsz + \
 				decode_sequence_maxsz + \
 				decode_putfh_maxsz + \
+				decode_getattr_maxsz + \
 				decode_readdir_maxsz)
 #define NFS4_enc_write_sz	(compound_encode_hdr_maxsz + \
 				encode_sequence_maxsz + \
@@ -2519,6 +2521,7 @@ static void nfs4_xdr_enc_readdir(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_compound_hdr(xdr, req, &hdr);
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
+	encode_getfattr(xdr, args->bitmask, &hdr);
 	encode_readdir(xdr, args, req, &hdr);
 
 	rpc_prepare_reply_pages(req, args->pages, args->pgbase,
@@ -6703,6 +6706,9 @@ static int nfs4_xdr_dec_readdir(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	if (status)
 		goto out;
 	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_getfattr(xdr, res->dir_attr, res->server);
 	if (status)
 		goto out;
 	status = decode_readdir(xdr, rqstp, res);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 38e60ec742df..8b20ff42c22d 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -211,6 +211,11 @@ struct nfs_server {
 						   of change attribute, size, ctime
 						   and mtime attributes supported by
 						   the server */
+	u32			cache_consistency_bitmask_nl[3];
+						/* V4 bitmask representing the subset
+						   of change attribute, size, ctime
+						   and mtime attributes supported by
+						   the server excluding label support */
 	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
 						   that are supported on this
 						   filesystem */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 3327239fa2f9..de12053ed4d3 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1139,6 +1139,8 @@ struct nfs4_readdir_res {
 	struct nfs4_sequence_res	seq_res;
 	nfs4_verifier			verifier;
 	unsigned int			pgbase;
+	struct nfs_fattr		*dir_attr;
+	const struct nfs_server *server;
 };
 
 struct nfs4_readlink {
-- 
2.25.4

