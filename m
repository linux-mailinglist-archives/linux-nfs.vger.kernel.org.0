Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D0672504
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjARRc1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjARRcH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:32:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2B456EFD
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:31:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D043EB81E10
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC61C433F0;
        Wed, 18 Jan 2023 17:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674063101;
        bh=tHUoDe+UiNuLd1wUzBbJUcrJ//0mAOo7aXIr5Vwu1o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AN20NHHQ2/KV8s8G6VVF2DmlSSIjcxUunPHfeeGEd92MaGjp+KGrgnqMrt0qRtfgL
         6vptc0cITLOLL5gulfXLnar9YcWTd0AYRyhDGdpLCCqw5oUcp1w5FNL4pE0odo5bWl
         p7N55ZxxEdNIvoNFRpQtVt9Dh7WxhwIutP+k0K+43R91PGU1RWj9W+Sjd9XKLQB6l+
         yZpSusw2jcJrO1Bp3MKPszOR6i8+Hfnpv5XArBLeeouXCp4LNE4jE4mb5zWlYTmm5S
         dl14QHNF4xIM8AZHHjdSl7MFrdl8DfIgKnFrENsZ1pfCkR0QSstAmKmFmdPXs3hRx5
         RzoUr2NNHAzSw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/6] nfsd: don't take nfsd4_copy ref for OP_OFFLOAD_STATUS
Date:   Wed, 18 Jan 2023 12:31:34 -0500
Message-Id: <20230118173139.71846-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118173139.71846-1-jlayton@kernel.org>
References: <20230118173139.71846-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We're not doing any blocking operations for OP_OFFLOAD_STATUS, so taking
and putting a reference is a waste of effort. Take the client lock,
search for the copy and fetch the wr_bytes_written field and return.

Also, make find_async_copy a static function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 35 ++++++++++++++++++++++++-----------
 fs/nfsd/state.h    |  2 --
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 62b9d6c1b18b..731c2b22f163 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1823,23 +1823,34 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	goto out;
 }
 
-struct nfsd4_copy *
-find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
+static struct nfsd4_copy *
+find_async_copy_locked(struct nfs4_client *clp, stateid_t *stateid)
 {
 	struct nfsd4_copy *copy;
 
-	spin_lock(&clp->async_lock);
+	lockdep_assert_held(&clp->async_lock);
+
 	list_for_each_entry(copy, &clp->async_copies, copies) {
 		if (memcmp(&copy->cp_stateid.cs_stid, stateid, NFS4_STATEID_SIZE))
 			continue;
-		refcount_inc(&copy->refcount);
-		spin_unlock(&clp->async_lock);
 		return copy;
 	}
-	spin_unlock(&clp->async_lock);
 	return NULL;
 }
 
+static struct nfsd4_copy *
+find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
+{
+	struct nfsd4_copy *copy;
+
+	spin_lock(&clp->async_lock);
+	copy = find_async_copy_locked(clp, stateid);
+	if (copy)
+		refcount_inc(&copy->refcount);
+	spin_unlock(&clp->async_lock);
+	return copy;
+}
+
 static __be32
 nfsd4_offload_cancel(struct svc_rqst *rqstp,
 		     struct nfsd4_compound_state *cstate,
@@ -1924,22 +1935,24 @@ nfsd4_fallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	nfsd_file_put(nf);
 	return status;
 }
+
 static __be32
 nfsd4_offload_status(struct svc_rqst *rqstp,
 		     struct nfsd4_compound_state *cstate,
 		     union nfsd4_op_u *u)
 {
 	struct nfsd4_offload_status *os = &u->offload_status;
-	__be32 status = 0;
+	__be32 status = nfs_ok;
 	struct nfsd4_copy *copy;
 	struct nfs4_client *clp = cstate->clp;
 
-	copy = find_async_copy(clp, &os->stateid);
-	if (copy) {
+	spin_lock(&clp->async_lock);
+	copy = find_async_copy_locked(clp, &os->stateid);
+	if (copy)
 		os->count = copy->cp_res.wr_bytes_written;
-		nfs4_put_copy(copy);
-	} else
+	else
 		status = nfserr_bad_stateid;
+	spin_unlock(&clp->async_lock);
 
 	return status;
 }
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e94634d30591..d49d3060ed4f 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -705,8 +705,6 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
 
 void put_nfs4_file(struct nfs4_file *fi);
-extern struct nfsd4_copy *
-find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
 extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
 				 struct nfs4_cpntf_state *cps);
 extern __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
-- 
2.39.0

