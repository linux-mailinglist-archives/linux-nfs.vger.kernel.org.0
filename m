Return-Path: <linux-nfs+bounces-11394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD959AA813B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EF317F7CD
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A337527A93D;
	Sat,  3 May 2025 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmiMk4wL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893227A933;
	Sat,  3 May 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285109; cv=none; b=SJQ+norQCIkQnQl/80nVxG4vRCDjMjIKhd8N+EzZ0XoklMVIBOQoTDIuWRPwt0anBIMTTj4sndVqoHwGOQg45AkaGXFDjwbcFDQbTh0jnuMvpRPqiBUk4NFT6goTavUFCYhafvgxN+vwHx+iBfwKUWeVFRgtMQtMWkUTdhmON9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285109; c=relaxed/simple;
	bh=uxFrc19C+PvwWMPxhNCI24ZWWHy6CbxGQF0jn16lEKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oV2L5I7iu1EuJFkBYQR1Y43ztg/jbrjJBGBOc4jgw7TfdW9E+IKhDvimkRRB8a3paQgzmYza5D/GEd9OxEe6fCg3peVvJK4odJpYHJcg0PmhuE8Aq8GUrkssXd4js7+p+/KyArP9XbvhSlHMmqYi4gzxHGDbyHaranBF2EFC3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmiMk4wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AECEC4CEE9;
	Sat,  3 May 2025 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285108;
	bh=uxFrc19C+PvwWMPxhNCI24ZWWHy6CbxGQF0jn16lEKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YmiMk4wLswV9JdAt40mwNSVSxqPO4xU+tiBGF90Xv96g+Il+Rk8it3EmxMgBcCh44
	 GkaddRYrr9RuaIWNXok4BrR8qc8yULBEyz1LNdSTfbs+08GBc0JxnRnlixQsO0Z5Zo
	 6kOxJGZ39Jq76sJTJEkVUJTkSQJtU2DLeASFUl86F46dHoPE5PcHOipyH+h9F6w746
	 jyM61twE3TQVdy84wqzpQRw9zbwt6EZYergjVfo2c1/212gO1HZDoINkDh8aSr4nE1
	 D9fubRf1r8a57R1yaazdvSY6N+z2AquJXGGpoqFq2Gk6OkbT2OoSPFxKn9P9+DjFad
	 qp5z8TSYvwljQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:20 -0400
Subject: [PATCH v3 04/17] nfsd: add nfsd_vfs_create tracepoints
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-4-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uxFrc19C+PvwWMPxhNCI24ZWWHy6CbxGQF0jn16lEKI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIs9SUr4mN37fEith1m3H949MBnrXkKIjl+x
 ygqvWrehvaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLAAKCRAADmhBGVaC
 FTAWD/9gc38q3nHVO/tITHdd1oJFANjTSsyIxdLW3YpU4XgOpc3lIqhlJ1PnzwD6pFrX6bKPpLQ
 4HlE750VqByfIG+pWmtUfyBar0Wbi8YpGJPSVjrOWDzlDP4s84qwkfUfeT8jbZ+UYgipTfk3gwK
 OJ9xKKLqzy0vX0JJffMjMQXMYx+Y0uWf/gXl6R7OzolCeBX3QEWi5ljfF5qYGet1x5KxoKC/tl0
 Q+jht9iAC7o2+OJA0JTayx7le4G2JIUpnsJf+x+3RqBmYqnGr26t3QAmZPuAY192zBeA6ALy4yo
 jw8AeteeZZEUwF01vAwA5r9qrnPAkWbAFQ2qujgn5vTtnohXgQHNnhFsGgU7gPK02H8GY4jwWbx
 d/7Zucrhg9Ub0FhTcVAcPlKylweLk4/7z+F6xqniq0s5bnyFxdslZmv6ru8pDyTw0sgfP4tCXEJ
 TgCurRdN5Y1CnQ3Z2DDBOZpsGMo8JFHrLtV0kL5XXNGTr3FPrMmpHjT2cq2A6USC4xsEZ9zPQOR
 VILjSy4Qaap1cPwYkrxypCRAh74DzJ+F99D5rrKGJ+IbWNArxWd694EFP6vH//d3qt67S3Vy1lQ
 RiYpL/5IwPT1awWOfzXtGtCL6BVUvVmNAsy9qaLlBjQNFnPMqH9sAgUNARrfQCM29yZSR2w5OiH
 KclC+hkPbWGmHZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c |  3 +++
 fs/nfsd/trace.h    | 25 +++++++++++++++++++++++++
 fs/nfsd/vfs.c      |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..5d2b081072e8c2e286c6815c34e5e58d4be15067 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -14,6 +14,7 @@
 #include "xdr3.h"
 #include "vfs.h"
 #include "filecache.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -266,6 +267,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 status;
 	int host_err;
 
+	trace_nfsd_vfs_create(rqstp, fhp, S_IFREG, argp->name, argp->len);
+
 	if (isdotent(argp->name, argp->len))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 382849d7c321d6ded8213890c2e7075770aa716c..752d81629e04f805536295f00a16721f57272fbe 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2391,6 +2391,31 @@ TRACE_EVENT(nfsd_lookup_dentry,
 	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
 		  __entry->xid, __entry->fh_hash, __get_str(name))
 );
+
+TRACE_EVENT(nfsd_vfs_create,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp,
+		 umode_t type,
+		 const char *name,
+		 unsigned int len),
+	TP_ARGS(rqstp, fhp, type, name, len),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__field(umode_t, type)
+		__string_len(name, name, len)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->type = type;
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x type=%s name=%s",
+		  __entry->xid, __entry->fh_hash,
+		  show_fs_file_type(__entry->type), __get_str(name))
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 276fbb572ead90fd07cde6922a697e07148926de..888572727d332dafd3e520f4801c4b0ca4e5c96c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1574,6 +1574,8 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_vfs_create(rqstp, fhp, type, fname, flen);
+
 	if (isdotent(fname, flen))
 		return nfserr_exist;
 

-- 
2.49.0


