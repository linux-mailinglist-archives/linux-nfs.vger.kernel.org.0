Return-Path: <linux-nfs+bounces-10127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ACFA3628A
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 17:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A974172947
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8A726738D;
	Fri, 14 Feb 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmCj+IYy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB99267713
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548673; cv=none; b=Jvooi3imgKl7v6/WTy8SxeXtdwkZuBjhIMXK8/YnObuiobOJFWKzEYDv4S0r8epFDWjT13TNxjc3FPY2fUc62XLbRl/yubW7Q4WXfc0eYCJ/7uafOapaQxtKmkOuboap0TCEecxjjJcbJdkN6/wYwm8mri1TWmWLnJ6+1IkNWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548673; c=relaxed/simple;
	bh=w9P2crVu2h7w1/R0YW9Pa5PD5aCncf6NJpqcuJWLb70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkmMafCckrvGBZkKYtv0H699XgVxCA1PdY688XlKC+ZeY6VOGdtgyJvX9fkt/bYIOxZ3y7Qbqu2xF56ozcnNdYAqz/7ohFnfusQG/ijCrN2g74WM51VO7ixxIBc1CpK9cAhtEBrZVRxY7ZjP7RX5zfe3MpiLbbUKLHkGAmvXb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmCj+IYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E773C4CEDD;
	Fri, 14 Feb 2025 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548673;
	bh=w9P2crVu2h7w1/R0YW9Pa5PD5aCncf6NJpqcuJWLb70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmCj+IYy/zgZLwRO4Hlmp4716vr1cd16ayq8Bp45EvKrDwn333ljF1iD/MLG7XTBS
	 +X7RzbVcOaWgrLXaj32CO1QC2KcET3BGTC+XbrH07ot1DmLFviVYYZLMIuot7EQOUv
	 WBm/85P9Q6cxyjlHkmEorYQgD3WVMlMbFYP6CqjUkODihTLxFE2whOw6+mVasSJsb0
	 DdjmpWDRIIA1ZaONfmgm7Nvg2BXLZOwD3g9tXcSpxxVqMXDT17cAkl8CjQMtgeox/n
	 N1vZwDuqqkFLmOqPHr2TWlsACPh5Ama2IOVu9ZDA/aO+6W/PkByvkA8Qw7Le4qotfW
	 9fH72GfanzSxg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [RFC PATCH 3/3] NFSD: Use a referring call list for CB_OFFLOAD
Date: Fri, 14 Feb 2025 10:57:46 -0500
Message-ID: <20250214155746.18016-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250214155746.18016-1-cel@kernel.org>
References: <20250214155746.18016-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Help the client resolve the race between the reply to an
asynchronous COPY reply and the associated CB_OFFLOAD callback by
planting the session, slot, and sequence number of the COPY in the
CB_SEQUENCE contained in the CB_OFFLOAD COMPOUND.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 9 +++++++++
 fs/nfsd/xdr4.h     | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d09a96cbec1e..48b3f5948640 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1713,6 +1713,7 @@ static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
 			return 0;
 		}
 	}
+	nfsd41_cb_destroy_referring_call_list(cb);
 	return 1;
 }
 
@@ -1845,6 +1846,9 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 
 	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
 		      NFSPROC4_CLNT_CB_OFFLOAD);
+	nfsd41_cb_referring_call(&cbo->co_cb, &cbo->co_referring_sessionid,
+				 cbo->co_referring_slotid,
+				 cbo->co_referring_seqno);
 	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
 			      &cbo->co_fh, copy->cp_count, copy->nfserr);
 	nfsd4_run_cb(&cbo->co_cb);
@@ -1961,6 +1965,11 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
+		memcpy(async_copy->cp_cb_offload.co_referring_sessionid.data,
+		       cstate->session->se_sessionid.data,
+		       NFS4_MAX_SESSIONID_LEN);
+		async_copy->cp_cb_offload.co_referring_slotid = cstate->slot_idx;
+		async_copy->cp_cb_offload.co_referring_seqno = cstate->slot->sl_seqid;
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
 		if (IS_ERR(async_copy->copy_task))
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 561894ff4b01..e2e6e6d2393d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -677,6 +677,10 @@ struct nfsd4_cb_offload {
 	__be32			co_nfserr;
 	unsigned int		co_retries;
 	struct knfsd_fh		co_fh;
+
+	struct nfs4_sessionid	co_referring_sessionid;
+	u32			co_referring_slotid;
+	u32			co_referring_seqno;
 };
 
 struct nfsd4_copy {
-- 
2.47.0


