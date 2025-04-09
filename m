Return-Path: <linux-nfs+bounces-11062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9115A82818
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7510116999D
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76442690F2;
	Wed,  9 Apr 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhHV4TWS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06122690EA;
	Wed,  9 Apr 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209194; cv=none; b=P7tktLLXKbg4txxNK0CvBca2ioV1cTml1Gv+01fAwMBFSsaw0AJH5WOclITBmSIUEttcQmVER4nPzOD94Ugj/6aXMB1/VMlYD2ELdv7Ftx5A1+ThJPuS9N51CGG6NUvOpZYDJ9GmlHw07p2w7Iwc8Nz+jXbPQYEp5tAKy7+L7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209194; c=relaxed/simple;
	bh=Sdnd2opBtjKfoFj7GGoGQ7TJ00oq35lF08cJzcpjlbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGsPtoyjLwVZ2ygJ1ybK+KKoEmF69lnmuANtU5XF7P9CD/J4mhSTp2rEj08FEnELtpFLIv29eMS9AS95Uw1uDrNUqqx694e1XaobZzBOPn2JwFXYMIpRO1NpiHUU8eMbdv906PGmKB3K36HRkTJa1XzJA8opdUw6OFefjORzM3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhHV4TWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B525C4CEE9;
	Wed,  9 Apr 2025 14:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209194;
	bh=Sdnd2opBtjKfoFj7GGoGQ7TJ00oq35lF08cJzcpjlbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LhHV4TWSKBqGElCJkEEckqHxr2i+wzEp9c8Chjb9eYQY218tILPSSwZOlEv5fYnW7
	 PARK2KxVr0IZCO//lcnf7RFM63EQf96l0qBgRf1R0XRYpdU/U/xCMqpFcro2A8a4wi
	 5hI4ygkbyxZ5qN2KZ9vvIPfpkbg/1DZJ7G2WDdO/x+LzBt5WazxC6VVc+cBQ8SIvHY
	 Y0e3P52ZthSQa/Jhzlmgs7KiwE5uAHo+G7HVw3cD4NMWrixbp96t/sC68xCsPNQDiD
	 W+M2bRMaFeho0l+tKWnY0yUfMJhS1Bl3IaU3qoMRHbu9zW2KYr+jxI3TLERtHpz/Ml
	 Pbm6zUPljxgjg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:34 -0400
Subject: [PATCH v2 12/12] nfsd: add tracepoint for getattr events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-12-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4039; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Sdnd2opBtjKfoFj7GGoGQ7TJ00oq35lF08cJzcpjlbg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUbHJqE+dfm4cDgvCCbEocQFbL40/UlMOL1Q
 pl1RSic2ciJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGwAKCRAADmhBGVaC
 FXCdD/9zoAbyuXP4f+JGDNQqifBpwjeDrWdGLVHpwT41hcK5wBE7LxuiEB81rJwdOwcgv5T0Zh8
 QA9w4JEmLP+V8PNs56R87HcB0JjQGwPhyiHd8aRj1Zd031iB2OsZvwwJXa5uEdUTzo4sOFHmfum
 8vy2+qk80s5UvKtqweONskmZd0/pCJtr7BcncmkYLKp3AG/swJscki3iR2tgV604JJB1zZWi/zp
 hjHcAnIkdwCbc1ZoiryagG0aLQbk8G1Q/y8om7yC5BI5y93+YVih8zuqtYJdNvyD/kKYPcXOkB2
 4UWT4luBNRrr46FqtwGy06k2EughSXEHaOSbnLBhIcCYIiD1oxcbhvyt2HFYgGZjU155Vj0Cnx1
 lGEx4KQiqRy0XOPmRHEmT1VbzJlAJA9IT6SwKitrmvOvR+SX8wndmaypCHOYhJqAQUvXcnBtIJp
 6Cm2ug5i45S++q549GyrOdYlyDYpQvHCnm6VNMNdmQ1+IZs2f2Zhbj3HKzX/mMA0LRLiYI0Cn1y
 TJbMvKXOuSW+ArcxQdg+xKgBw/+AeVQjILXhvGG7Ku8ihf5kg8KC6KXFTou2yCXRkdXHiptexiF
 pNOIJx1ffW7uxzXP8hWZJ1gXZwfbkqWmEMWqi0HqElqhOi+TxcGgReo852BhNMxpCCGVvx2pMEj
 wJE+FD0fWV0TRmA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...including STATFS on v2 and FSSTAT on v3. Also, remove the dprintks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c |  6 ++----
 fs/nfsd/nfs4proc.c |  2 ++
 fs/nfsd/nfsproc.c  |  4 ++--
 fs/nfsd/trace.h    | 27 +++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b9ed55a4cdd740bc0aa84b7cbc0e37906d55d666..d2c6902ca9e2496d90ddf13e96b119e415c23cfc 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -70,8 +70,7 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: GETATTR(3)  %s\n",
-		SVCFH_fmt(&argp->fh));
+	trace_nfsd3_proc_getattr(rqstp, &argp->fh);
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = fh_verify(rqstp, &resp->fh, 0,
@@ -665,8 +664,7 @@ nfsd3_proc_fsstat(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: FSSTAT(3)   %s\n",
-				SVCFH_fmt(&argp->fh));
+	trace_nfsd3_proc_fsstat(rqstp, &argp->fh);
 
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
 	fh_put(&argp->fh);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8dd1233693dc82febe300f6f2714059c718909bc..1b2cf5a2d8265659edaa7177bc778f74c1a532a3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -955,6 +955,8 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_getattr *getattr = &u->getattr;
 	__be32 status;
 
+	trace_nfsd4_getattr(rqstp, &cstate->current_fh);
+
 	status = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_NOP);
 	if (status)
 		return status;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index ce3f1ca636f79687e65077effcc0588639d9366d..35b9f79f077adce4499c7f52244d69da8f5090c4 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -55,7 +55,7 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
+	trace_nfsd_proc_getattr(rqstp, &argp->fh);
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = fh_verify(rqstp, &resp->fh, 0,
@@ -631,7 +631,7 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: STATFS   %s\n", SVCFH_fmt(&argp->fh));
+	trace_nfsd_proc_statfs(rqstp, &argp->fh);
 
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats,
 				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 1d48a37dd33fb4c6e338534d576bcc8fd1a8f54d..ffe16a7ab1f24db999763bcc220e31cf8035d412 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2606,6 +2606,33 @@ DEFINE_NFSD_VFS_READDIR_EVENT(nfsd3_proc_readdir);
 DEFINE_NFSD_VFS_READDIR_EVENT(nfsd3_proc_readdirplus);
 DEFINE_NFSD_VFS_READDIR_EVENT(nfsd4_readdir);
 
+DECLARE_EVENT_CLASS(nfsd_vfs_getattr_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp),
+	TP_ARGS(rqstp, fhp),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x",
+		  __entry->xid, __entry->fh_hash)
+);
+
+#define DEFINE_NFSD_VFS_GETATTR_EVENT(__name)					\
+	DEFINE_EVENT(nfsd_vfs_getattr_class, __name,				\
+		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp),	\
+		     TP_ARGS(rqstp, fhp))
+
+DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd_proc_getattr);
+DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd_proc_statfs);
+DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd3_proc_getattr);
+DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd3_proc_fsstat);
+DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd4_getattr);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.49.0


