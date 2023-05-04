Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9F6F7769
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjEDUuL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjEDUtu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:49:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2A8423C
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD01E639FB
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 20:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E75C433EF;
        Thu,  4 May 2023 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233237;
        bh=BOg+RXnaM1HWtT4oc7eRXJdklZqYq0mCXJAgXZOH+Zw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Pa67KEfuaPBd5Mburdu6YtQ+VUO771Rp+upQ7ahYp8FWhD5+BVmuer35lLR+dEU/5
         KpLQiDWF0NoxVsZVJ+ObM098kWqqIVromsXW6WTpWg3g1jVMFvYaa1lJzIEhY9JmVQ
         0tEZRKUy0xPik5VaQ9I4v0P2VJRG5teRJJb0NDy6AeX4QBt6mgLmLmPMhKCJ5nDde6
         qj3yqHuLeMM4Lbq5xaaNjDOxZYtuLoopgvqYSC74eredCfBzS80xvDefg2gjkkYLWS
         RaJZFuW2Beck79AaXDwH2NPI4N51Lqp6SpUHhmxBvnQbNFqFZEWZ1ubDm7/VKaFb+W
         Y8SeKwyzGWpBQ==
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 04 May 2023 16:47:16 -0400
Subject: [PATCH 6/6] NFSv4.2: SETXATTR should update ctime
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-xattr-ctime-v1-6-ac3fc5a00942@Netapp.com>
References: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
In-Reply-To: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4203;
 i=Anna.Schumaker@Netapp.com; h=from:subject:message-id;
 bh=hDPbfC3g0DZCj0YbYegv/OqwOUIzuY7OyvJ7CaEibFk=;
 b=owEBbQKS/ZANAwAIAdfLVL+wpUDrAcsmYgBkVBnRafqQeexkOm6LSpuf/3gu1wQXmyznIQxk3
 O38Wus0PzCJAjMEAAEIAB0WIQSdnkxBOlHtwtTsoSnXy1S/sKVA6wUCZFQZ0QAKCRDXy1S/sKVA
 600ND/93sHXqgCB7IEA0yU+nR1ezoRcHCj0Wy8WFcDMr3LkSYg8t+Kbt+KJfr3jnh9EpB8nA8E3
 ls6OBG9sRlIg38YmD4+WJtQ89j4IJsESuMQm7kN+3WA/62PBzgwa9TmDuFhe/KmFBm46BvxKwkR
 jlKdQi6DtbUNjPy0Q9PxCRijhLa1DzAPBzOGCdc2+wdG36ua3kyX94NonLp6yugr1wjIFlFNQgn
 a/2AxIiyJ2swBHVjMrmQbeclKMPNwMV5JKOV5uijFDjlbe7F23cFTTCMGBu671pVqiPzs7FdOeh
 /p3ZZ5f+AoMX8UJphrg/gyRINcamAMisdJuNWf9DdfDUprQ2weUlgiyLeLmdvtbw+Vc0FbYM0xc
 n8dXOJUxbeYMlD7XKyyf74+cReyzf+M2ys43UYmOqMJCETkzTS4Dv5bv6NMETLKDafQp6iA9nmD
 QmFZ3dRvXWuMQp2fNdF2jpGFLIJy+Kl/czom4l9l1pi0TMP8S6K2s/zLHtcIrTD3NAhiKP+aZ4/
 VuDL8Plu3ZZiZVOHP14+u729bc3q9rHgyZMskwbK1kr45kgFyj2cLS1DYwyededABb4DZu48gSZ
 zZ+itE1MnDnU7hjMUCmepTMJAylVqfSQyxu473V+140TFDd/d0lLwvfdRwROdU1XGGpyQn9mAoY
 8iVWD4AaxGiRLdg==
X-Developer-Key: i=Anna.Schumaker@Netapp.com; a=openpgp;
 fpr=9D9E4C413A51EDC2D4ECA129D7CB54BFB0A540EB
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Otherwise, `stat` will report a stale value to users.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42proc.c      | 25 +++++++++++++++++++++----
 fs/nfs/nfs42xdr.c       | 11 ++++++++---
 include/linux/nfs_xdr.h |  3 +++
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 93e306bf4430..63802d195556 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1190,15 +1190,19 @@ static int _nfs42_proc_setxattr(struct inode *inode, const char *name,
 				const void *buf, size_t buflen, int flags)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
+	__u32 bitmask[NFS_BITMASK_SZ];
 	struct page *pages[NFS4XATTR_MAXPAGES];
 	struct nfs42_setxattrargs arg = {
 		.fh		= NFS_FH(inode),
+		.bitmask	= bitmask,
 		.xattr_pages	= pages,
 		.xattr_len	= buflen,
 		.xattr_name	= name,
 		.xattr_flags	= flags,
 	};
-	struct nfs42_setxattrres res;
+	struct nfs42_setxattrres res = {
+		.server		= server,
+	};
 	struct rpc_message msg = {
 		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_SETXATTR],
 		.rpc_argp	= &arg,
@@ -1210,13 +1214,22 @@ static int _nfs42_proc_setxattr(struct inode *inode, const char *name,
 	if (buflen > server->sxasize)
 		return -ERANGE;
 
+	res.fattr = nfs_alloc_fattr();
+	if (!res.fattr)
+		return -ENOMEM;
+
 	if (buflen > 0) {
 		np = nfs4_buf_to_pages_noslab(buf, buflen, arg.xattr_pages);
-		if (np < 0)
-			return np;
+		if (np < 0) {
+			ret = np;
+			goto out;
+		}
 	} else
 		np = 0;
 
+	nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask,
+			 inode, NFS_INO_INVALID_CHANGE);
+
 	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
 	    &res.seq_res, 1);
 	trace_nfs4_setxattr(inode, name, ret);
@@ -1224,9 +1237,13 @@ static int _nfs42_proc_setxattr(struct inode *inode, const char *name,
 	for (; np > 0; np--)
 		put_page(pages[np - 1]);
 
-	if (!ret)
+	if (!ret) {
 		nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
+		ret = nfs_post_op_update_inode(inode, res.fattr);
+	}
 
+out:
+	kfree(res.fattr);
 	return ret;
 }
 
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 215b8700e504..95234208dc9e 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -212,11 +212,13 @@
 #define NFS4_enc_setxattr_sz		(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
-					 encode_setxattr_maxsz)
+					 encode_setxattr_maxsz + \
+					 encode_getattr_maxsz)
 #define NFS4_dec_setxattr_sz		(compound_decode_hdr_maxsz + \
 					 decode_sequence_maxsz + \
 					 decode_putfh_maxsz + \
-					 decode_setxattr_maxsz)
+					 decode_setxattr_maxsz + \
+					 decode_getattr_maxsz)
 #define NFS4_enc_listxattrs_sz		(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
@@ -720,6 +722,7 @@ static void nfs4_xdr_enc_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
 	encode_setxattr(xdr, args, &hdr);
+	encode_getfattr(xdr, args->bitmask, &hdr);
 	encode_nops(&hdr);
 }
 
@@ -1579,8 +1582,10 @@ static int nfs4_xdr_dec_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	status = decode_putfh(xdr);
 	if (status)
 		goto out;
-
 	status = decode_setxattr(xdr, &res->cinfo);
+	if (status)
+		goto out;
+	status = decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 29a1b39794bf..12bbb5c63664 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1528,6 +1528,7 @@ struct nfs42_seek_res {
 struct nfs42_setxattrargs {
 	struct nfs4_sequence_args	seq_args;
 	struct nfs_fh			*fh;
+	const u32			*bitmask;
 	const char			*xattr_name;
 	u32				xattr_flags;
 	size_t				xattr_len;
@@ -1537,6 +1538,8 @@ struct nfs42_setxattrargs {
 struct nfs42_setxattrres {
 	struct nfs4_sequence_res	seq_res;
 	struct nfs4_change_info		cinfo;
+	struct nfs_fattr		*fattr;
+	const struct nfs_server		*server;
 };
 
 struct nfs42_getxattrargs {

-- 
2.40.1

