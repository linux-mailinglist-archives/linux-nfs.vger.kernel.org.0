Return-Path: <linux-nfs+bounces-11058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C65A8280E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CB71BC2D09
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1077267B88;
	Wed,  9 Apr 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTTuPrCc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE7267B7D;
	Wed,  9 Apr 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209189; cv=none; b=hnvyRQwFCkm6qn1KHl7vHRK/ox8fLpLWcqqG66xomyRdwk00VCmEIS+x9TnX20qpPUBjGv3q1oU3MUMqd2VSvmyCgTMqYGFUzQ0vpKZsOJtZ1sa6P84z7SIuI+7+GJWYlcIbMwbqSmYtOn/MAzGsLkKOgRTbNQQeanzqUSbP+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209189; c=relaxed/simple;
	bh=BQLvPi5adL0wTtZSKVY7dNZq7GWhrzHDPslTRMLDCZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpNy66h2kMJn8cPzX2sy4bo6p5ucsK/affgpwKKdE4u4Fhfa265MWjmeIWzApXISOQ1sZBlLxrElMeiP1NHQx3WR0djkMhMiKBbV4boeLu0tU+iOnvLRTpRyeT8z8De0MQzcK3+WYfQ40UEKmcQj3d3WO4HUsOkRdAgFh30/GaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTTuPrCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEF8C4CEE7;
	Wed,  9 Apr 2025 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209189;
	bh=BQLvPi5adL0wTtZSKVY7dNZq7GWhrzHDPslTRMLDCZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OTTuPrCcD3MU+xlHx5csmDDmzZFk6kx9lhQH3O74SO1OcBfj/LdMYUDUjCJMTZUyz
	 OSHYBmAS6EwpBvovFgqBTcsCvvp9BzP3hg8wPNJONpjuFyZGIF5bKi4e5w/eaH+VN+
	 yfidYCEUKIVm4QKBdLgf9ElzWL1yVFW+7z1uoxf6MzhDWTpnztMr02XLFPYzMHu//x
	 XHCL5TrzwqEkygvKcFwhyJIij7ql12x/I90jrjpULulP0sekc34APM/dC5ca7hG8tw
	 ivcr/PEUk6XpOhtliubYUI5e8IowKYmoP1ia2jWaCFxeZxlHxrNiPIBvwrt3UzVpAV
	 F5hUIMKxO2y+w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:30 -0400
Subject: [PATCH v2 08/12] nfsd: add tracepoints for hardlink events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-8-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3960; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BQLvPi5adL0wTtZSKVY7dNZq7GWhrzHDPslTRMLDCZM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUbOH5ZxnvvfUd490wSsweIgCzLwzty4dXjs
 kt29Z2ATO+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGwAKCRAADmhBGVaC
 FVK1D/912/NCdBc/qNMMlZoaLK7/ZGfWHFbLEdvI8aPGsNWfo+pzhVetamRlpz5gWd930mlJwgN
 KlGe/H6lo6QopgTZKXWDfSCVCxfMSJVVubz2YhKw9kwnyj/7umUsCioid6OwD9dDdb8pYaTu016
 w3f05NzVbFJgeoLwUEp88tnFASHRfGkmd0D5eLWfl+WeRj4pjgr5gQLTu8P0S8el20Grt7Wu8f0
 FqdTIywPUYgTNvQtANKMMxOK2/zuWoT1SpCF+9b4zv16rDLn4Q3zxm+RZPTwqy7ah8wj9nOX4AO
 Zu+cxH36Ul9A5U+5FVbrcvr9oD9vJRd/5tO0hWthVgkz0+K+/Kn3z6dnfKjByfIa8ltw6NblVMT
 nU8kvs7C1wBvd4GWUwjHCuZT0lgQEVveIW9C1s/LtnagunhQKA5+xK0mgm7djnQ6cIoyStzi0L5
 Z+PusxOAnacQWzIuJ1nm0VhckG9IWhXOJQPWktuCPDJ8h1Ur2RwMbBZk8HA/6un3bMdpy3yK9lo
 UxqW377MiSOQnhFAjlxnqRX+oSBnoJBCMbPMf1QjElWvt6G3V74j33xkjs3efLpZG0AUS+RtUTP
 WBq5OVG0H1tc1U5WpNbY6eWm1vmAYMAtCqMheO/IrmDYenv7a0CLVZOOoa50G0Dd2cWzSJM/32O
 4I3cr54okMF3a3A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and remove the legacy dprintks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c |  7 +------
 fs/nfsd/nfs4proc.c |  3 +++
 fs/nfsd/nfsproc.c  |  7 +------
 fs/nfsd/trace.h    | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 587fc92597e7c77d078e871b8d12684c6b5efa2d..97aaf98d0af7dc565b21937ecca4852dd9253221 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -564,12 +564,7 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 	struct nfsd3_linkargs *argp = rqstp->rq_argp;
 	struct nfsd3_linkres  *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: LINK(3)     %s ->\n",
-				SVCFH_fmt(&argp->ffh));
-	dprintk("nfsd:   -> %s %.*s\n",
-				SVCFH_fmt(&argp->tfh),
-				argp->tlen,
-				argp->tname);
+	trace_nfsd_proc_link(rqstp, &argp->ffh, &argp->tfh, argp->tname, argp->tlen);
 
 	fh_copy(&resp->fh,  &argp->ffh);
 	fh_copy(&resp->tfh, &argp->tfh);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e22596a2e311861be1e4f595d77547be04634ce7..7dffae2f16d9fa8dea043b7bf300eaca52c0aa7c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -977,6 +977,9 @@ nfsd4_link(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_link *link = &u->link;
 	__be32 status;
 
+	trace_nfsd4_link(rqstp, &cstate->save_fh, &cstate->current_fh,
+			 link->li_name, link->li_namelen);
+
 	status = nfsd_link(rqstp, &cstate->current_fh,
 			   link->li_name, link->li_namelen, &cstate->save_fh);
 	if (!status)
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 0674ed6b978f6caa1325a9271f2fde9b3ef60945..b40b5ab1d3b17dd8974fcaeda3ac7c26baee67cf 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -481,12 +481,7 @@ nfsd_proc_link(struct svc_rqst *rqstp)
 	struct nfsd_linkargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: LINK     %s ->\n",
-		SVCFH_fmt(&argp->ffh));
-	dprintk("nfsd:    %s %.*s\n",
-		SVCFH_fmt(&argp->tfh),
-		argp->tlen,
-		argp->tname);
+	trace_nfsd_proc_link(rqstp, &argp->ffh, &argp->tfh, argp->tname, argp->tlen);
 
 	resp->status = nfsd_link(rqstp, &argp->tfh, argp->tname, argp->tlen,
 				 &argp->ffh);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 850dbf1240b234b67dd7d75d6903c0f49dc01261..9ff919a08f424bfe023cf91244fe08effbdf993e 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2465,6 +2465,41 @@ DECLARE_EVENT_CLASS(nfsd_vfs_symlink_class,
 DEFINE_NFSD_VFS_SYMLINK_EVENT(nfsd_proc_symlink);
 DEFINE_NFSD_VFS_SYMLINK_EVENT(nfsd3_proc_symlink);
 DEFINE_NFSD_VFS_SYMLINK_EVENT(nfsd4_symlink);
+
+DECLARE_EVENT_CLASS(nfsd_vfs_link_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *sfhp,
+		 struct svc_fh *tfhp,
+		 const char *name,
+		 unsigned int namelen),
+	TP_ARGS(rqstp, sfhp, tfhp, name, namelen),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, sfh_hash)
+		__field(u32, tfh_hash)
+		__string_len(name, name, namelen)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->sfh_hash = knfsd_fh_hash(&sfhp->fh_handle);
+		__entry->tfh_hash = knfsd_fh_hash(&tfhp->fh_handle);
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x src_fh=0x%08x tgt_fh=0x%08x name=%s",
+		  __entry->xid, __entry->sfh_hash, __entry->tfh_hash,
+		  __get_str(name))
+);
+
+#define DEFINE_NFSD_VFS_LINK_EVENT(__name)					\
+	DEFINE_EVENT(nfsd_vfs_link_class, __name,				\
+		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *sfhp,	\
+			      struct svc_fh *tfhp, const char *name,		\
+			      unsigned int namelen),				\
+		     TP_ARGS(rqstp, sfhp, tfhp, name, namelen))
+
+DEFINE_NFSD_VFS_LINK_EVENT(nfsd_proc_link);
+DEFINE_NFSD_VFS_LINK_EVENT(nfsd3_proc_link);
+DEFINE_NFSD_VFS_LINK_EVENT(nfsd4_link);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.49.0


