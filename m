Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27614C1462
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbiBWNlJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 08:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbiBWNlI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 08:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8B10AC065
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645623639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orXhI6SXyypSX1JBBjrp4e1ep+yrNv2FjfbJmeW8+58=;
        b=DeipjoVR7sdRq+f+XsQNVrqbNECHO49ZxueF5LSiOEZ6J1p9iDMr/43w1+f8lwpOlygNDN
        CIbywqTsZIUJM5RFsKKh+p246PVVXwQilTJNd92ZakkQefSprSD07vj9mQ2nI2tziQC4A8
        6Dlmg6oa/pXuELMY5u0yDClMpFS5nsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-875VWFbrNNSQn9ye5xlMxQ-1; Wed, 23 Feb 2022 08:40:37 -0500
X-MC-Unique: 875VWFbrNNSQn9ye5xlMxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F72C1854E26
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 569CF2B4D2
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id EC83010C30F1; Wed, 23 Feb 2022 08:40:35 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/8] NFSv4: Send GETATTR with READDIR
Date:   Wed, 23 Feb 2022 08:40:29 -0500
Message-Id: <eedb07d14a96caef1de663a436a326b2c5012ab4.1645623510.git.bcodding@redhat.com>
In-Reply-To: <d759b6df8acd82b8d44e2afcf11a7a94dcf85ba6.1645623510.git.bcodding@redhat.com>
References: <d759b6df8acd82b8d44e2afcf11a7a94dcf85ba6.1645623510.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For each batch of entries, track whether the directory has changed.  We can
use this information to better manage the cache when reading long
directories.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs42proc.c        |  2 +-
 fs/nfs/nfs4proc.c         | 29 +++++++++++++++++++++--------
 fs/nfs/nfs4xdr.c          |  6 ++++++
 include/linux/nfs_fs_sb.h |  5 +++++
 include/linux/nfs_xdr.h   |  2 ++
 5 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 882bf84484ac..3ab54228b2ed 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1082,7 +1082,7 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 	if (!res.dst_fattr)
 		return -ENOMEM;
 
-	nfs4_bitmask_set(dst_bitmask, server->cache_consistency_bitmask,
+	nfs4_bitmask_set(dst_bitmask, server->cache_consistency_bitmask_nl,
 			 dst_inode, NFS_INO_INVALID_BLOCKS);
 
 	status = nfs4_call_sync(server->client, server, msg,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 73a9b6de666c..45285447c077 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3665,7 +3665,7 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 		/* Close-to-open cache consistency revalidation */
 		if (!nfs4_have_delegation(inode, FMODE_READ)) {
 			nfs4_bitmask_set(calldata->arg.bitmask_store,
-					 server->cache_consistency_bitmask,
+					 server->cache_consistency_bitmask_nl,
 					 inode, 0);
 			calldata->arg.bitmask = calldata->arg.bitmask_store;
 		} else
@@ -3905,7 +3905,12 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
 		server->cache_consistency_bitmask[1] &= FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
-		server->cache_consistency_bitmask[2] = 0;
+		server->cache_consistency_bitmask[2] = res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL;
+
+		memcpy(server->cache_consistency_bitmask_nl, server->cache_consistency_bitmask, sizeof(server->cache_consistency_bitmask));
+		server->cache_consistency_bitmask_nl[2] = 0;
+
+
 
 		/* Avoid a regression due to buggy server */
 		for (i = 0; i < ARRAY_SIZE(res.exclcreat_bitmask); i++)
@@ -4576,7 +4581,7 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 		res.fattr = nfs_alloc_fattr();
 		if (res.fattr == NULL)
 			return -ENOMEM;
-		args.bitmask = server->cache_consistency_bitmask;
+		args.bitmask = server->cache_consistency_bitmask_nl;
 	}
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (!status) {
@@ -5098,14 +5103,19 @@ static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
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
+	res.server = server;
 
 	nfs4_setup_readdir(nr_arg->cookie, nr_arg->verf, nr_arg->dentry, &args);
 	res.pgbase = args.pgbase;
@@ -5118,6 +5128,9 @@ static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
 
 	nfs_invalidate_atime(dir);
 
+	nfs_refresh_inode(dir, res.dir_attr);
+	nfs_free_fattr(res.dir_attr);
+out:
 	dprintk("%s: returns %d\n", __func__, status);
 	return status;
 }
@@ -5583,7 +5596,7 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 		hdr->res.fattr = NULL;
 	} else {
 		nfs4_bitmask_set(hdr->args.bitmask_store,
-				 server->cache_consistency_bitmask,
+				 server->cache_consistency_bitmask_nl,
 				 hdr->inode, NFS_INO_INVALID_BLOCKS);
 		hdr->args.bitmask = hdr->args.bitmask_store;
 	}
@@ -6622,7 +6635,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 	data->args.fhandle = &data->fh;
 	data->args.stateid = &data->stateid;
 	nfs4_bitmask_set(data->args.bitmask_store,
-			 server->cache_consistency_bitmask, inode, 0);
+			 server->cache_consistency_bitmask_nl, inode, 0);
 	data->args.bitmask = data->args.bitmask_store;
 	nfs_copy_fh(&data->fh, NFS_FH(inode));
 	nfs4_stateid_copy(&data->stateid, stateid);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index b7780b97dc4d..1cd0d49ef992 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -469,10 +469,12 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
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
@@ -2529,6 +2531,7 @@ static void nfs4_xdr_enc_readdir(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_compound_hdr(xdr, req, &hdr);
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
+	encode_getfattr(xdr, args->bitmask, &hdr);
 	encode_readdir(xdr, args, req, &hdr);
 
 	rpc_prepare_reply_pages(req, args->pages, args->pgbase,
@@ -6769,6 +6772,9 @@ static int nfs4_xdr_dec_readdir(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
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
index ca0959e51e81..04bc827e4367 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -213,6 +213,11 @@ struct nfs_server {
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
index 728cb0c1f0b6..fbb8b7695c30 100644
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
2.31.1

