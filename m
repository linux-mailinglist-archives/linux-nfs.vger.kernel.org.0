Return-Path: <linux-nfs+bounces-11395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDB6AA813F
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDB25A609F
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82FF27B507;
	Sat,  3 May 2025 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq6ZCecb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E927B501;
	Sat,  3 May 2025 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285110; cv=none; b=PWPm2yHkt1RGhP7kS3PGVJi/b9qc5Yg+tSvv/cjsxJxnKU3aWnLc1fM+q1rO35XxSxHyz27q8zxIaYFjPX8PORQ1yhTx+44QuQWRaLm8Svc7vRlygX/UE47+S7pg8du/oY1bqAMVpB66WXytpiZN/wfRRmyeYJfawzts/QC/CnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285110; c=relaxed/simple;
	bh=Lbbt3z52A02Fxr9pcVeoYi/CCQmH+05FB4t+Qi7+fsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyTYDF5PUOzOkw6B4B/y03e+zOg38sNhGggg2hcDgGHjblRr7Cx5fKuoh2bgSgq5sKtGj1iGxDh98wxmM1fv5OcmQGfM1th62FUPXQgJeEA8KxEwHLF0jl30ITP4YnVek8jBmKXrz46lpb8ciFmbrIpblxEGUIE5F6LoHKKmxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq6ZCecb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF32C4CEEB;
	Sat,  3 May 2025 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285109;
	bh=Lbbt3z52A02Fxr9pcVeoYi/CCQmH+05FB4t+Qi7+fsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sq6ZCecbY4OFCqOQSb6AakAGj95LWb2w937Uj8zZgeGSR0t/KtifZfB06zlEV7R2z
	 qnA/X30ruxIKP1cHUOuPP4btyJhC1G2IQVInOQTLwh/VeGkFAic7/EwOiWsja6qsLB
	 hAnhn9GPloKNhfoYmnyFI6Q0uryvUMOR932zgpaoP8Ikzaov1BpKxEaNVAB+enUJRw
	 UXjgLowN7yhwel7PJ7Bw9inn6ByStZ+KEweTWUp243Mvc9BHpB2BptMhkgTPNOiYBm
	 wlSq5HAoAlTv79XRqbFGYaC/zA/Mmk0+dvRvZgt+If972BTNgEU/WVMrsecUXnmaMB
	 cAQC0bbgaepmw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:21 -0400
Subject: [PATCH v3 05/17] nfsd: add tracepoint to nfsd_symlink
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-5-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Lbbt3z52A02Fxr9pcVeoYi/CCQmH+05FB4t+Qi7+fsQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjItpO+fW7eNAkaUsHuP3FI9m6ZwDKL/AFyoL
 EwzyXNvM2eJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLQAKCRAADmhBGVaC
 Ff+cEACmPw89L1i64cPzslAwz55+t2BitpjPc/qUDQy0EuSquoCVvA8zOi51ZnC/5E73WUveNar
 v6GRy14kJwoNHHYaA/sflJsDRHjCiir/0S26pbr1BbCBuinaBggZTd2Q72DHSMLY9zSa6igo7F3
 wCkJdCWRuCKVm7rFd5KjYwbULb9v96mhBpx2ccLBl6SprWpUyu7SfQ+glCJW4/+Q+4QMFkmBuyZ
 EPfRW0sw38WFh8SI6a3ErmL1uScqv16jm2v5Uj/0tfAsBSD9W52rbwKB0c0cXbN5c5n75dxe1mO
 oi/bi+RQ9vKsefMn5Rysz0enWbqQ6ic2RgC55uVYl6oA+GnfAoIaQqf688km4jGixuFW5GH7SRD
 m0rSKE9p+2SamBxZ3rnN9/RC2xxjxx+qMrWB/3XLrbKeOmSzRNqvg2LUJVxvEmMcuf5dQjVPz8K
 6BsqewfuV74vAsa1UzblNIDpgiRcGGM1fLF5FpetMc3bgR9VnDeMnBOMfYd8XYgBZqzzeI1igh1
 4XQHiQWWvTxYb37ZJpwihDwo7niEZ9GV2ujRHmuaXhC5kKrGCJH5RtnAn/t3FBbWEypKR1DnCa9
 z3YoBVIOJbQrADoGacUVmYfB5b+pr7e07j5dcQKkwV68q9dFRNzpLn1hWBWxi+QYoxVxBWfClAg
 DLErlA5tUO2gVGQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 23 +++++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 752d81629e04f805536295f00a16721f57272fbe..9f604eb23f6304d11223733cee38871a4c39001f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2416,6 +2416,29 @@ TRACE_EVENT(nfsd_vfs_create,
 		  show_fs_file_type(__entry->type), __get_str(name))
 );
 
+TRACE_EVENT(nfsd_vfs_symlink,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp,
+		 const char *name,
+		 unsigned int namelen,
+		 const char *tgt),
+	TP_ARGS(rqstp, fhp, name, namelen, tgt),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__string_len(name, name, namelen)
+		__string(tgt, tgt)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__assign_str(name);
+		__assign_str(tgt);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s target=%s",
+		  __entry->xid, __entry->fh_hash,
+		  __get_str(name), __get_str(tgt))
+);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 888572727d332dafd3e520f4801c4b0ca4e5c96c..44e9260410b2d9dc7e07b5af7a74b63bd0175998 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1676,6 +1676,8 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32		err, cerr;
 	int		host_err;
 
+	trace_nfsd_vfs_symlink(rqstp, fhp, fname, flen, path);
+
 	err = nfserr_noent;
 	if (!flen || path[0] == '\0')
 		goto out;

-- 
2.49.0


