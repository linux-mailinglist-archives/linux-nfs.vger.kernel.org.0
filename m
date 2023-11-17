Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2A7EFB3B
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 23:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjKQWOq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 17:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQWOp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 17:14:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89764D51
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 14:14:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1627DC433C7
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 22:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700259281;
        bh=Rp9TVcpXba2368iPXgufI/Nj9Hri4vnuWp5nRa9Nt4o=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=HgcTCuUDqyTJ5bFgZ0TGkEIPG6qNnptBS6YxyiAFd1Fj2/QQeAdUqV0iiHLxo4iAP
         tUcpIWkBahm28woIUTkSnoK7FyoxFbfnGQoAgS/kxgvaUXRU5EYnhxTBS2l19DKqQ6
         Hpsf2Pc+H3QGK9Eq0Deif1JRNLBPU9evVD7FtB2hkWKm/lrZo5b+3uTtgfB84Kd0sw
         xqEJw4P7vVyHmDVtwxK6h3Yv4/BgJ9XW1Is4VW5S+yqfhDZMw9ZlFz6DfzDpCe9hUe
         GfqUg2wKkaVCxmzghQX0JZyDbFo2tl40byp4Oksmqt1KwxxMLXPiOePVQ5X3irN/6j
         XZK6gPIHd7zQQ==
Subject: [PATCH v2 3/4] NFSD: Modify NFSv4 to use nfsd_read_splice_ok()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 17 Nov 2023 17:14:40 -0500
Message-ID: <170025928004.4577.15734797736094788262.stgit@bazille.1015granger.net>
In-Reply-To: <170025895725.4577.18051288602708688381.stgit@bazille.1015granger.net>
References: <170025895725.4577.18051288602708688381.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Avoid the use of an atomic bitop, and prepare for adding a run-time
switch for using splice reads.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    7 +++++--
 fs/nfsd/nfs4xdr.c  |   13 ++++++++-----
 fs/nfsd/xdr4.h     |    1 +
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6f2d4aa4970d..14712fa08f76 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -970,8 +970,11 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * To ensure proper ordering, we therefore turn off zero copy if
 	 * the client wants us to do more in this compound:
 	 */
-	if (!nfsd4_last_compound_op(rqstp))
-		clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	if (!nfsd4_last_compound_op(rqstp)) {
+		struct nfsd4_compoundargs *argp = rqstp->rq_argp;
+
+		argp->splice_ok = false;
+	}
 
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ec4ed6206df1..ea7c8e32d3ba 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2524,8 +2524,9 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	svc_reserve(argp->rqstp, max_reply + readbytes);
 	argp->rqstp->rq_cachetype = cachethis ? RC_REPLBUFF : RC_NOCACHE;
 
+	argp->splice_ok = nfsd_read_splice_ok(argp->rqstp);
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
-		clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
+		argp->splice_ok = false;
 
 	return true;
 }
@@ -4378,12 +4379,13 @@ static __be32
 nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  union nfsd4_op_u *u)
 {
+	struct nfsd4_compoundargs *argp = resp->rqstp->rq_argp;
 	struct nfsd4_read *read = &u->read;
-	bool splice_ok = test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
-	unsigned long maxcount;
 	struct xdr_stream *xdr = resp->xdr;
-	struct file *file;
 	int starting_len = xdr->buf->len;
+	bool splice_ok = argp->splice_ok;
+	unsigned long maxcount;
+	struct file *file;
 	__be32 *p;
 
 	if (nfserr)
@@ -5204,9 +5206,10 @@ static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read)
 {
-	bool splice_ok = test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
+	struct nfsd4_compoundargs *argp = resp->rqstp->rq_argp;
 	struct file *file = read->rd_nf->nf_file;
 	struct xdr_stream *xdr = resp->xdr;
+	bool splice_ok = argp->splice_ok;
 	unsigned long maxcount;
 	__be32 nfserr, *p;
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 80e859dc84d8..415516c1b27e 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -840,6 +840,7 @@ struct nfsd4_compoundargs {
 	u32				minorversion;
 	u32				client_opcnt;
 	u32				opcnt;
+	bool				splice_ok;
 	struct nfsd4_op			*ops;
 	struct nfsd4_op			iops[8];
 };


