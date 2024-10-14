Return-Path: <linux-nfs+bounces-7165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D078999D767
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 21:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F311C22562
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DCA1CFEB5;
	Mon, 14 Oct 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyMGV420"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8B1CF7DB;
	Mon, 14 Oct 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934035; cv=none; b=U94ezQSS2GGVVOOk07xCmN3yJFa+nomah/5n3ktIQU3+Nxl6FSCntcNLJKafITVnSBdwwvSUDItErROi9/cGTTZTZjwRlBn76piGo7f9zzNec4oZ+Nw/eZxw47V8nKmX3iOOexc4k3ik8s0k7wDLyVzRzanvuPw18obCGvC1uB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934035; c=relaxed/simple;
	bh=+hRQc9GgFAzsiBo9bvZ+7lG7RTwR60/+HrCAnl4d2hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFd9nS4E+73n3i4gcxAgzRZNef7yYCh4Fo9ZG6B/fX+YXqpv+kGCL2QpVz04jHUQd/OV8WvkOpL8TWeO3Zar6vo0ru/Na7e6YetO16VQrFionOJ+RvCejE/8FNAWSzvvYTawCVyF1FFcQSCT1wMhLBzBoys6kPnjiuSBBs5jU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyMGV420; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FCBC4CED2;
	Mon, 14 Oct 2024 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728934034;
	bh=+hRQc9GgFAzsiBo9bvZ+7lG7RTwR60/+HrCAnl4d2hc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XyMGV420zluBQjLWNJyQCEaxM/Yn1hMs/aMoyGvXvog/17wWGpyof+lNfrMWfr7OW
	 F4QcfMMovwQhIPT33doqBHersdYRArjqH11+ItS/03NYqrOi3HYvhUR+sCa1Z4jryk
	 I8cODYd8xd0yXKED5B7BbQIg1h7d4RsDqgvUaxw1HCTSVLqnmGO4jbpillNEx+WdiS
	 c8ns1pgZz2vZq/G7LeUS83cLcYvM4ER+HSE6Sn7V8TsQbU2a1a0DUfVBv9djQzoJN0
	 7J3ocRhx4LJa8G4RlYyN+4cqEXxmNKhQ/33LMGQku4pzMEEsffMuDQhWD21JtKLvGL
	 gJzB8uN6LarhQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 15:26:52 -0400
Subject: [PATCH 4/6] nfsd: prepare delegation code for handing out
 *_ATTRS_DELEG delegations
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-delstid-v1-4-7ce8a2f4dd24@kernel.org>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
In-Reply-To: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Thomas Haynes <loghyr@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6359; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+hRQc9GgFAzsiBo9bvZ+7lG7RTwR60/+HrCAnl4d2hc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDXCLLTppiQWIqY3TUYF7e6oPfkXP6ghaWONuP
 scItlNaQbqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw1wiwAKCRAADmhBGVaC
 FTAeEACCHWeT98PnyWP/nLiHE1T471Qe1rHX2FEEWx1Q9w3krqSuXV+7fEAHE0LYR4G3OI70Sej
 dG6eNtKioTx+rxIvLqDim9/H1XpDFTHqcM6lC/myLFdw/9mgCGNbjGyTPwR/ui5TtInZ4pcrj1k
 ua/gEGqgjltrUOQptmaoQORtNAYg364kMbn/YIgUNWoGAxYNjQAdQajwLifYRqGeEwWNY6bnopO
 VN7O1+nHSj0hWXnj/mEx77bNt18i0n6AEUOWColf86KutqpVaFM8dOzNEWBnTSZos2Ey6aKQRDY
 O0w7FoDLPgjWQGQGpjY8k3WvkTxsxmhsH1neK8NBR8lNupetby6qTIe2Rmkl9CIAb89DFdyT9/K
 bv1WrYARqJcqRJc+N90mweijoJqguiI1uBXE37+ueBcyvOd8fJOi9jHx6UzV7+mWwsCzXyuP9dq
 KwsXcDPI9MyHOnO/AWtK5CPCtleoD+lTkd98NjgfRMI5bYMfrC2GDlu/pRjXd/51ZOdZvQWgAe5
 GoFLxmH7d2ScAe4BWfGWeWxnDRv843R7WQHKLTwzCacWKOUr95kYH4T0BoAaYgbrS3P5iyKu+hG
 azFJ6uAwlEFy6IuI6nGogZHH8BbDesrxTXUCFdzVWhaAeBfDKas3U7AuBCIUMPfUaZQ/lRxpOHl
 zgY75K6QFjKjv3A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some preparatory code to various functions that handle delegation
types to allow them to handle the OPEN_DELEGATE_*_ATTRS_DELEG constants.
Add helpers for detecting whether it's a read or write deleg, and
whether the attributes are delegated.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 50 +++++++++++++++++++++++++++++++++-----------------
 fs/nfsd/nfs4xdr.c   |  2 ++
 fs/nfsd/state.h     | 16 ++++++++++++++++
 3 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fe74d8c0c61e76f635a3133a4c71b7fb7b622a48..62f9aeb159d0f2ab4d293bf5c0c56ad7b86eb9d6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2838,6 +2838,21 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	return 0;
 }
 
+static char *nfs4_show_deleg_type(u32 dl_type)
+{
+	switch (dl_type) {
+	case OPEN_DELEGATE_READ:
+		return "r";
+	case OPEN_DELEGATE_WRITE:
+		return "w";
+	case OPEN_DELEGATE_READ_ATTRS_DELEG:
+		return "ra";
+	case OPEN_DELEGATE_WRITE_ATTRS_DELEG:
+		return "wa";
+	}
+	return "?";
+}
+
 static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 {
 	struct nfs4_delegation *ds;
@@ -2851,8 +2866,7 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	nfs4_show_stateid(s, &st->sc_stateid);
 	seq_puts(s, ": { type: deleg, ");
 
-	seq_printf(s, "access: %s",
-		   ds->dl_type == OPEN_DELEGATE_READ ? "r" : "w");
+	seq_printf(s, "access: %s", nfs4_show_deleg_type(ds->dl_type));
 
 	/* XXX: lease time, whether it's being recalled. */
 
@@ -5433,7 +5447,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 static inline __be32
 nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
 {
-	if ((flags & WR_STATE) && (dp->dl_type == OPEN_DELEGATE_READ))
+	if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
 		return nfserr_openmode;
 	else
 		return nfs_ok;
@@ -5665,8 +5679,7 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
 	return clp->cl_minorversion && clp->cl_cb_state == NFSD4_CB_UNKNOWN;
 }
 
-static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
-						int flag)
+static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
 {
 	struct file_lease *fl;
 
@@ -5675,7 +5688,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
 	fl->c.flc_flags = FL_DELEG;
-	fl->c.flc_type = flag == OPEN_DELEGATE_READ ? F_RDLCK : F_WRLCK;
+	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
 	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
@@ -5862,7 +5875,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!dp)
 		goto out_delegees;
 
-	fl = nfs4_alloc_init_lease(dp, dl_type);
+	fl = nfs4_alloc_init_lease(dp);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -6062,14 +6075,14 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 					struct nfs4_delegation *dp)
 {
-	if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_READ_DELEG &&
-	    dp->dl_type == OPEN_DELEGATE_WRITE) {
-		open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
-		open->op_why_no_deleg = WND4_NOT_SUPP_DOWNGRADE;
-	} else if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG &&
-		   dp->dl_type == OPEN_DELEGATE_WRITE) {
-		open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
-		open->op_why_no_deleg = WND4_NOT_SUPP_UPGRADE;
+	if (deleg_is_write(dp->dl_type)) {
+		if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_READ_DELEG) {
+			open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
+			open->op_why_no_deleg = WND4_NOT_SUPP_DOWNGRADE;
+		} else if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG) {
+			open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
+			open->op_why_no_deleg = WND4_NOT_SUPP_UPGRADE;
+		}
 	}
 	/* Otherwise the client must be confused wanting a delegation
 	 * it already has, therefore we don't return
@@ -6080,11 +6093,14 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 /* Are we only returning a delegation stateid? */
 static bool open_xor_delegation(struct nfsd4_open *open)
 {
+	/* Was one requested? */
 	if (!(open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
 		return false;
-	if (open->op_delegate_type != OPEN_DELEGATE_READ &&
-	    open->op_delegate_type != OPEN_DELEGATE_WRITE)
+
+	/* Did we actually get a delegation? */
+	if (!deleg_is_read(open->op_delegate_type) && !deleg_is_write(open->op_delegate_type))
 		return false;
+
 	return true;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e95f6ba5cc65611b47d5d297584ff6e478d80a1f..1c9d9349e4447c0078c7de0d533cf6278941679d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4296,10 +4296,12 @@ nfsd4_encode_open_delegation4(struct xdr_stream *xdr, struct nfsd4_open *open)
 		status = nfs_ok;
 		break;
 	case OPEN_DELEGATE_READ:
+	case OPEN_DELEGATE_READ_ATTRS_DELEG:
 		/* read */
 		status = nfsd4_encode_open_read_delegation4(xdr, open);
 		break;
 	case OPEN_DELEGATE_WRITE:
+	case OPEN_DELEGATE_WRITE_ATTRS_DELEG:
 		/* write */
 		status = nfsd4_encode_open_write_delegation4(xdr, open);
 		break;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index c7c7ec21e5104761221bd78b31110d902df1dc9b..9d0e844515aa6ea0ec62f2b538ecc2c6a5e34652 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -190,6 +190,22 @@ struct nfs4_delegation {
 	struct nfs4_cb_fattr    dl_cb_fattr;
 };
 
+static inline bool deleg_is_read(u32 dl_type)
+{
+	return (dl_type == OPEN_DELEGATE_READ || dl_type == OPEN_DELEGATE_READ_ATTRS_DELEG);
+}
+
+static inline bool deleg_is_write(u32 dl_type)
+{
+	return (dl_type == OPEN_DELEGATE_WRITE || dl_type == OPEN_DELEGATE_WRITE_ATTRS_DELEG);
+}
+
+static inline bool deleg_attrs_deleg(u32 dl_type)
+{
+	return dl_type == OPEN_DELEGATE_READ_ATTRS_DELEG ||
+	       dl_type == OPEN_DELEGATE_WRITE_ATTRS_DELEG;
+}
+
 #define cb_to_delegation(cb) \
 	container_of(cb, struct nfs4_delegation, dl_recall)
 

-- 
2.47.0


