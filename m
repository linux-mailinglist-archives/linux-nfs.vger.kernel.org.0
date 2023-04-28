Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825DE6F1EED
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 21:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbjD1TwT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 15:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjD1TwS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 15:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ECB211E
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 12:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A4D96151E
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 19:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9159AC433D2;
        Fri, 28 Apr 2023 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682711536;
        bh=5RXRhTWACuxMk4kc+fmZGxwaAtqK4J1pVUUWkTgq4FU=;
        h=From:To:Cc:Subject:Date:From;
        b=LRLBmHYW4c7EP5QV05fHkDR/xQ3KIqfUSn3eLOZSmDqvONASekuhyjvv/0rZJH1Pt
         E6dSsSXolpT/UQLKzRKsKfeqiJO76nXN+BdiZafN9fHyQxq1Zpx7fhdGitk4CoxF8a
         uQyvgtRsCg8QCO5U1FpSIvVR7rEqusdZjxXlyAqPb/Kv7TPf4EFaalDIhpCYvVobmY
         /LFyn5TGv/9Pliwyup0yMxL2ijriKa0ADdk50/5sFora+MWNgK16xn6EPDZaCJHE0J
         OpM615Bm6awL+4+mATBXK3VDd/f7bnNSxEzKCcIK3MWgapJvqKv4zhqOAAW6FBmf5z
         MTzASBkmsW6CA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v2] NFSv4.2: Rework scratch handling for READ_PLUS
Date:   Fri, 28 Apr 2023 15:52:15 -0400
Message-Id: <20230428195215.234246-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Instead of using a tiny, static scratch buffer, we should use a kmalloc()-ed
buffer that is allocated when checking for read plus usage. This lets us
use the buffer before decoding any part of the READ_PLUS operation
instead of setting it right before segment decoding, meaning it should
be a little more robust.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c       |  4 ++--
 fs/nfs/nfs4proc.c       | 17 ++++++++++++-----
 include/linux/nfs_xdr.h |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index d80ee88ca996..a6df815a140c 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1122,7 +1122,6 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	uint32_t segments;
 	struct read_plus_segment *segs;
 	int status, i;
-	char scratch_buf[16];
 	__be32 *p;
 
 	status = decode_op_hdr(xdr, OP_READ_PLUS);
@@ -1143,7 +1142,6 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	if (!segs)
 		return -ENOMEM;
 
-	xdr_set_scratch_buffer(xdr, &scratch_buf, sizeof(scratch_buf));
 	status = -EIO;
 	for (i = 0; i < segments; i++) {
 		status = decode_read_plus_segment(xdr, &segs[i]);
@@ -1348,6 +1346,8 @@ static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
 	struct compound_hdr hdr;
 	int status;
 
+	xdr_set_scratch_buffer(xdr, res->scratch, sizeof(res->scratch));
+
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
 		goto out;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5607b1e2b821..18f25ff4bff7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5439,6 +5439,8 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
 
 static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
+	if (hdr->res.scratch)
+		kfree(hdr->res.scratch);
 	if (!nfs4_sequence_done(task, &hdr->res.seq_res))
 		return -EAGAIN;
 	if (nfs4_read_stateid_changed(task, &hdr->args))
@@ -5452,17 +5454,22 @@ static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 }
 
 #if defined CONFIG_NFS_V4_2 && defined CONFIG_NFS_V4_2_READ_PLUS
-static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
+static bool nfs42_read_plus_support(struct nfs_pgio_header *hdr,
 				    struct rpc_message *msg)
 {
 	/* Note: We don't use READ_PLUS with pNFS yet */
-	if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds_clp)
+	if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds_clp) {
 		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS];
+		hdr->res.scratch = kmalloc(32, GFP_KERNEL);
+		return hdr->res.scratch != NULL;
+	}
+	return false;
 }
 #else
-static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
+static bool nfs42_read_plus_support(struct nfs_pgio_header *hdr,
 				    struct rpc_message *msg)
 {
+	return false;
 }
 #endif /* CONFIG_NFS_V4_2 */
 
@@ -5472,8 +5479,8 @@ static void nfs4_proc_read_setup(struct nfs_pgio_header *hdr,
 	hdr->timestamp   = jiffies;
 	if (!hdr->pgio_done_cb)
 		hdr->pgio_done_cb = nfs4_read_done_cb;
-	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
-	nfs42_read_plus_support(hdr, msg);
+	if (!nfs42_read_plus_support(hdr, msg))
+		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
 }
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e86cf6642d21..2fd973d188c4 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -670,6 +670,7 @@ struct nfs_pgio_res {
 		struct {
 			unsigned int		replen;		/* used by read */
 			int			eof;		/* used by read */
+			void *			scratch;	/* used by read */
 		};
 		struct {
 			struct nfs_writeverf *	verf;		/* used by write */
-- 
2.40.0

