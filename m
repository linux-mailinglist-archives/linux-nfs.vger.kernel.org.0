Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E0E55342A
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jun 2022 16:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350518AbiFUOG1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jun 2022 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiFUOG0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jun 2022 10:06:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3414D08
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 07:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C6161589
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 14:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08841C3411C
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 14:06:23 +0000 (UTC)
Subject: [PATCH 2/2] NFSD: Instrument fh_verify()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 21 Jun 2022 10:06:23 -0400
Message-ID: <165582038305.1716.14058727871663228662.stgit@klimt.1015granger.net>
In-Reply-To: <165582017204.1716.2642742597692008742.stgit@klimt.1015granger.net>
References: <165582017204.1716.2642742597692008742.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Capture file handles and how they map to local inodes. In particular,
NFSv4 PUTFH uses fh_verify() so we can now observe which file handles
are the target of OPEN, LOOKUP, RENAME, and so on.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c |    5 +++--
 fs/nfsd/trace.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c29baa03dfaf..5e2ed4b2a925 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -331,8 +331,6 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	struct dentry	*dentry;
 	__be32		error;
 
-	dprintk("nfsd: fh_verify(%s)\n", SVCFH_fmt(fhp));
-
 	if (!fhp->fh_dentry) {
 		error = nfsd_set_fh_dentry(rqstp, fhp);
 		if (error)
@@ -340,6 +338,9 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	}
 	dentry = fhp->fh_dentry;
 	exp = fhp->fh_export;
+
+	trace_nfsd_fh_verify(rqstp, fhp, type, access);
+
 	/*
 	 * We still have to do all these permission checks, even when
 	 * fh_dentry is already set:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a60ead3b227a..8467fd8f94c2 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -171,6 +171,52 @@ TRACE_EVENT(nfsd_compound_encode_err,
 		__entry->opnum, __entry->status)
 );
 
+#define show_fs_file_type(x) \
+	__print_symbolic(x, \
+		{ S_IFLNK,		"LNK" }, \
+		{ S_IFREG,		"REG" }, \
+		{ S_IFDIR,		"DIR" }, \
+		{ S_IFCHR,		"CHR" }, \
+		{ S_IFBLK,		"BLK" }, \
+		{ S_IFIFO,		"FIFO" }, \
+		{ S_IFSOCK,		"SOCK" })
+
+TRACE_EVENT(nfsd_fh_verify,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		umode_t type,
+		int access
+	),
+	TP_ARGS(rqstp, fhp, type, access),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
+		__sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(void *, inode)
+		__field(unsigned long, type)
+		__field(unsigned long, access)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
+		__assign_sockaddr(server, &rqstp->rq_xprt->xpt_local,
+		       rqstp->rq_xprt->xpt_locallen);
+		__assign_sockaddr(client, &rqstp->rq_xprt->xpt_remote,
+				  rqstp->rq_xprt->xpt_remotelen);
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->inode = d_inode(fhp->fh_dentry);
+		__entry->type = type;
+		__entry->access = access;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x inode=%p type=%s access=%s",
+		__entry->xid, __entry->fh_hash, __entry->inode,
+		show_fs_file_type(__entry->type),
+		show_nfsd_may_flags(__entry->access)
+	)
+);
 
 DECLARE_EVENT_CLASS(nfsd_fh_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,


