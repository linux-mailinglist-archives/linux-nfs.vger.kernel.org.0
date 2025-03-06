Return-Path: <linux-nfs+bounces-10506-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4158A54AE6
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 13:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B042416D6E2
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1B20E319;
	Thu,  6 Mar 2025 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl75Zl7D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155DD20E30A;
	Thu,  6 Mar 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264716; cv=none; b=IrvCLOiYsiftmJECv/VdKAyHxKv6x8LnDDFCGns19K/D9RMGvpyWAnHdw9eYr6jDRExnO407X5ppZ4/xv5n03QQQFQPZ4EBIsDSWKfybOm+816s2i0flB1hussT6MDK3EKOdWeI4KdOf5OxXJFTVv13iCNtx0b1CAC9iru5gQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264716; c=relaxed/simple;
	bh=l94euaVl8GxBtZu2zgPXV0MuIFNOPdoJJNkFxgc1pP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpWWyNVjidDELiF3qoemM9zQ6pbjf4hAyYL2JnV3Xu57v9IKjWx7Zfp/Qfk+LVxseJgJf9n9m7L6t9YmcQY4ld2ZlyYOBi3jq5lO7XIC4KzXdtiEDN2W08rUpgDaye0GupoI0UkZebVb7JqVbopixYY/ddul9m2QiJJ3CdBAHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl75Zl7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253D0C4CEEE;
	Thu,  6 Mar 2025 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741264714;
	bh=l94euaVl8GxBtZu2zgPXV0MuIFNOPdoJJNkFxgc1pP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sl75Zl7DPv5dUA9y3DUXMWsuudpr97g2t4qm5VAM9mtYQ86CKPjRcT3iekcgDXu/J
	 KZU+n67DQaJXAsdl3YZlrjA53ThMHCvUU4rmZlvSiqezrxSlq06pT5eTtKSK2LhRLD
	 RT627SrIWLBJAop3KYHPPnnPi1HL7gB0X6EF1tyQfoEgcEtwYnrY/Dzzc69czU4zUp
	 sYIA4RJ1dmnNL6FHkj0qoH2xjx0l14fD7EOxfAyDRm0pF0XcmPTGtO2xcDbKkuIaLm
	 ptzs8tiA7unPZJllskq9v3aCJOjeo3gM3sB4f3WerfA/i3f/CwHuIUfs1Z1aW9pAYG
	 COVovqctvzPHg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 06 Mar 2025 07:38:14 -0500
Subject: [PATCH 2/4] nfsd: add a tracepoint for nfsd_setattr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-nfsd-tracepoints-v1-2-4405bf41b95f@kernel.org>
References: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
In-Reply-To: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Sargun Dillon <sargun@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3206; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=l94euaVl8GxBtZu2zgPXV0MuIFNOPdoJJNkFxgc1pP0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnyZdFMugoBKetmmJe09DSMrKrLFoNVxnguUZ8A
 dcnk47sjoOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8mXRQAKCRAADmhBGVaC
 FWVhEAC0mRRQYap+gSU8KNMDxEvQ8KuEXcxfpN0scW/10eIL3bH4I5xFgtgTBFZ1nz2ceXxSEef
 YLfug41xz5gb3pgcQskUFHpiBAI5GJ6Z2vdRVad3RZLraBuOLic9Kr2AvEe4xUie6mE/CnpWG4S
 NcOZGCePkLcK6YwRuJ17aQRdyY9lvKWqOkjOXsgXE5c2A1SRY+mM56zU2fSPbShUVnELOqKzvEL
 wHDJSKQURyVBnfOZfT51X8v4s3SEm96AUE1OieUDy9/LYXGnmij8TNqPP4NtOq6buCh2bdl56Da
 68BfkjeUxtck/K4TXwc9OaTwysCG0BF0u1QVjV7jWXxHPhx1mLAAq93Dt5l4s6bFFSA0J9tp4vp
 nPuqcR6SrsjiEHqFi/8no6RBhD55AoDogowyplUuqk5BtiB0Ng54HEDzcQp4UfyaUNRsk7BBhM2
 ygdBhxOfD//4bvFE4oeDR3gLzP+CQB8QXfjIYPWEhC609woafGVIG3nkQq6zBGZdlIky89FgVd0
 XuIx93yo9dovoz53tj2NdWQs1rXsWlO31jhoc/ge6SPlAOLLYEEHHwgpL+zaxDoUtuffUSWVLWF
 eohsP73fc/F1imoJE69pxkcX31zG8fNhrJ7A9RSH3kFfXgswAbBOI/0eowTme0SACoDuFiUAXS8
 tEGKySBtVYEAPYg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Turn Sargun's internal kprobe based implementation of this into a normal
static tracepoint.

Cc: Sargun Dillon <sargun@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 0d49fc064f7273f32c93732a993fd77bc0783f5d..117f7e1fd66a4838a048cc44bd5bf4dd8c6db958 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2337,6 +2337,60 @@ DEFINE_EVENT(nfsd_copy_async_done_class,		\
 DEFINE_COPY_ASYNC_DONE_EVENT(done);
 DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
 
+#define show_ia_valid_flags(x)					\
+	__print_flags(x, "|",					\
+			{ ATTR_MODE, "MODE" },			\
+			{ ATTR_UID, "UID" },			\
+			{ ATTR_GID, "GID" },			\
+			{ ATTR_SIZE, "SIZE" },			\
+			{ ATTR_ATIME, "ATIME" },		\
+			{ ATTR_MTIME, "MTIME" },		\
+			{ ATTR_CTIME, "CTIME" },		\
+			{ ATTR_ATIME_SET, "ATIME_SET" },	\
+			{ ATTR_MTIME_SET, "MTIME_SET" },	\
+			{ ATTR_FORCE, "FORCE" },		\
+			{ ATTR_KILL_SUID, "KILL_SUID" },	\
+			{ ATTR_KILL_SGID, "KILL_SGID" },	\
+			{ ATTR_FILE, "FILE" },			\
+			{ ATTR_KILL_PRIV, "KILL_PRIV" },	\
+			{ ATTR_OPEN, "OPEN" },			\
+			{ ATTR_TIMES_SET, "TIMES_SET" },	\
+			{ ATTR_TOUCH, "TOUCH"})
+
+TRACE_EVENT(nfsd_setattr,
+	TP_PROTO(const struct svc_rqst *rqstp, const struct svc_fh *fhp,
+		 const struct iattr *iap, const struct timespec64 *guardtime),
+	TP_ARGS(rqstp, fhp, iap, guardtime),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(s64, gtime_tv_sec)
+		__field(u32, gtime_tv_nsec)
+		__field(unsigned int, ia_valid)
+		__field(umode_t, ia_mode)
+		__field(uid_t, ia_uid)
+		__field(gid_t, ia_gid)
+		__field(loff_t, ia_size)
+	),
+	TP_fast_assign(__entry->xid = be32_to_cpu(rqstp->rq_xid);
+	       __entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+	       __entry->gtime_tv_sec = guardtime ? guardtime->tv_sec : 0;
+	       __entry->gtime_tv_nsec = guardtime ? guardtime->tv_nsec : 0;
+	       __entry->ia_valid = iap->ia_valid;
+	       __entry->ia_mode = iap->ia_mode;
+	       __entry->ia_uid = __kuid_val(iap->ia_uid);
+	       __entry->ia_gid = __kgid_val(iap->ia_gid);
+	       __entry->ia_size = iap->ia_size;
+
+	),
+	TP_printk(
+		"xid=0x%08x fh_hash=0x%08x ia_valid=%s ia_mode=%o ia_uid=%u ia_gid=%u guard_time=%lld.%u",
+		__entry->xid, __entry->fh_hash, show_ia_valid_flags(__entry->ia_valid),
+		__entry->ia_mode, __entry->ia_uid, __entry->ia_gid,
+		__entry->gtime_tv_sec, __entry->gtime_tv_nsec
+	)
+)
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 390ddfb169083535faa3a2413389e247bdbf4a73..d755cc87a8670c491e55194de266d999ba1b337d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -499,6 +499,8 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 	int		retries;
 
+	trace_nfsd_setattr(rqstp, fhp, iap, guardtime);
+
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
 		ftype = S_IFREG;

-- 
2.48.1


