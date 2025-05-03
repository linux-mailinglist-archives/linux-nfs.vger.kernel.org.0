Return-Path: <linux-nfs+bounces-11412-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29660AA8272
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386D35A478C
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE76A27F74F;
	Sat,  3 May 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFe/Am74"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC927F744;
	Sat,  3 May 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302385; cv=none; b=hYhcWCBhwiltVZIW4HxWUtkpuPXm/kOOY0Y5O4cY641Ted7LXHANJBTdDaIk61tpHNondPPuQGlCHBxVfb2Z77+/NCSCZoiyuQCyXJb0VSj9uv5O42JwQicAhb+Mewf6VQw19wNPACBM4OCrGa9QicMgtI/RbZv3cN1bKYEAfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302385; c=relaxed/simple;
	bh=eIdlLrqSSEsRlrpUoIgud3gIcOveQpIm5RZIgyAET9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ler3WGLqzKYvKjbbC8Su2lRXIOOsiGe1l4onSc/k7EIbKxGdJrAfWNeJJF5qIAkJY0Owoj5efv1KdKeb/H5JFPYg0mRcOAZNHzjXrZat19lbqoH2KNt2c9NDq4k3YKUhErgL6hjXYfBh5OFGT3fNX5jMJ0b2vOGAFuNmKuqm6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFe/Am74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725EFC4CEEF;
	Sat,  3 May 2025 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302385;
	bh=eIdlLrqSSEsRlrpUoIgud3gIcOveQpIm5RZIgyAET9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFe/Am748jdfaf6bPYLwB9lM2JKNMYoUjWaIHhDsfOB0V3wuAPbC7gRK6lr7jjIPX
	 7SBS5cWVJzqvGpNEScdvBDE9t8kytqT7C6vEQmCovqqn2E66MA6jlgOVr22lbYwTrg
	 xtMvmf+VITgrJ91FaBvXp1aAJAhvhdNvG8FM8wstYChJzeN89B5bFXGsP9W3eWEsEc
	 mW52DIZzjNcaXwjiPpTCsEkZII3GbLT8+B2KRC11eahCkwB6aSGl7dI65vxtYL5TU0
	 G7FWt0IWmXN1h//f9tsVId7SU1NO2UZXxIrsStQ/nVCK898eRm21CSSq4HtUZ2xj3w
	 19EANFvDsuMmA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 04/18] nfsd: add a tracepoint to nfsd_lookup_dentry
Date: Sat,  3 May 2025 15:59:22 -0400
Message-ID: <20250503195936.5083-5-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Replace the dprintk in nfsd_lookup_dentry() with a trace point.
nfsd_lookup_dentry() is called frequently enough that enabling this
dprintk call site would result in log floods and performance issues.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 23 +++++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b435276a1aaa..661a870d62f5 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2394,6 +2394,29 @@ TRACE_EVENT(nfsd_vfs_setattr,
 	)
 )
 
+TRACE_EVENT(nfsd_vfs_lookup,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		const char *name,
+		unsigned int len
+	),
+	TP_ARGS(rqstp, fhp, name, len),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_CALL_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__string_len(name, name, len)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_CALL_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
+		__entry->xid, __entry->fh_hash, __get_str(name)
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9e0a858d2129..657ba0c2da14 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -246,7 +246,7 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry		*dentry;
 	int			host_err;
 
-	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name);
+	trace_nfsd_vfs_lookup(rqstp, fhp, name, len);
 
 	dparent = fhp->fh_dentry;
 	exp = exp_get(fhp->fh_export);
-- 
2.49.0


