Return-Path: <linux-nfs+bounces-11396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBA6AA8141
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90393B73C3
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB727B51E;
	Sat,  3 May 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf1sQn6l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D927B518;
	Sat,  3 May 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285111; cv=none; b=VBPCLSKNUNOQ25Q/VKr9e3KNXhVtpyVWbWyEb29SMoJUuVWWUpVk6f4A30AKVNdMoW4vnrRBrWimQUSIvPjxhTtKkVX5G4s+j2PTd0YoG4aTP/uiVgq/b3o0Lx3F5sn0MxIUsbam+aYLjHeK+nd/blLFvTZPRclSKH923l2VwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285111; c=relaxed/simple;
	bh=A/Z+V7YuEZM2hHJlWez6oCBvrLrVohVfh5nLP7nLD2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcc4cRGXP2zW+FKBUCC78FZFgYN59vO823efgnCPZwK1jxj77wTSHTVU83PSQutbZzPOiR7Su6sRIjXEdXRjTHHbMMm0k+xDqZp/StyAdZZcHnBw8W5eO1VnegHvoxCDI0af8liH4WgFtCxZGcPc/BZyZGTNJFgqYIutQIki7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf1sQn6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F9C4AF0C;
	Sat,  3 May 2025 15:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285111;
	bh=A/Z+V7YuEZM2hHJlWez6oCBvrLrVohVfh5nLP7nLD2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rf1sQn6lIo0oycsx7fh0DqSY+32+BhoFO2YHK+dkuHVdGmdEr22ZJ0tHwo7sn09Un
	 kaB9O4KKW1D2Jf8GwcpNEMV1Uc5ewOesunCJcasPlRfOu/5rCVRP3Fu/aDrkUgoaRL
	 i9kKiiEtUA/R3y031EVDsuQGq7XtorOmi8b4gKtpVye9I/WUr0PCPrlqGPDsGqtAtu
	 hk7PAAEWEK9vxmj2wzWj5HoBOX+Vzlf4xi8R1dOAMucu5ernMfiFByLDvaFUXL171G
	 T1cPB010KxFMr9JFV1o1sVTwf4VWZs3l4OU2FfxB3bta1Iu4TdnHnzDtm8oPB3w8G8
	 nHeoImRijNnaA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:22 -0400
Subject: [PATCH v3 06/17] nfsd: add tracepoint to nfsd_link()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-6-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=A/Z+V7YuEZM2hHJlWez6oCBvrLrVohVfh5nLP7nLD2E=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIt8Av+xa/bqYbWwsovu+UEFx12uHBt6FDZn
 3qaSnJ8DmqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLQAKCRAADmhBGVaC
 FdlBD/4psFrxlmX2wFDPwQCCfsmiyEDoQ9sWdjM24QYaIes7xH6zoKEsj7itD2d8iw3nBP/KLT/
 3RGrzeCUEfL8+HOAINZDvmUh0glpeQw43Wu/0Yoi51xELJa9K1Tdk//X8qKEXcPbbFKIEEPVkRy
 jBNpWKzgk5GAqfI82dJFNvUKaj8VAP+B9kFugubHNdxeJQ3KEPgFvGwtaiOzan5IYsJzTl4hKgx
 XkRkRo+kq7oU8tSdGZh6Rnaq+1+1vlw/C1kg5Gpa6uJ9qAnYVm1/api9zaQKKUXBNQtiv8diypa
 1wSM2i2y3BqdBGhVYey8gbVZiL6RvRJYXyCMMO8MpuiyQUOWeNAgA9Uwk4+VvULoNn9tc4y2/zY
 DceQQhH2ZLPh6UNBO7nSx3S038Wn+W28vUAX69/z+TGq9JdvMXAHmRo/OTrQE4/YZu8hwJ+n9UL
 akT9EEjg6gFQC8u1oyF1Gbh/gPxXXBaRwQxuw+jV9GWyXqejRliq79cKja8bvy38xIPfC2ELzn/
 xLenY+RRF/Poyt30xf5emU8LqT7PP+FclAremA7E50vVkAnRk/qCH3CkgOgOQRLrOUhL3P5vQsL
 z8XaJjmdqRmqsTq5lKPZtg2UvP/+mANkCsoqLTTqzDtNB782fW78ssj/WJevLdV7twNy+4zLSQr
 pkSZW2Q4xfEHbVQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 24 ++++++++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 9f604eb23f6304d11223733cee38871a4c39001f..17c09d8a52041205ff4edd47fbd4d31135e97f85 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2439,6 +2439,30 @@ TRACE_EVENT(nfsd_vfs_symlink,
 		  __entry->xid, __entry->fh_hash,
 		  __get_str(name), __get_str(tgt))
 );
+
+TRACE_EVENT(nfsd_vfs_link,
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
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 44e9260410b2d9dc7e07b5af7a74b63bd0175998..d949860d2aac998efb1b74218d0657a73a0d3fc6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1746,6 +1746,8 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_vfs_link(rqstp, ffhp, tfhp, name, len);
+
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_CREATE);
 	if (err)
 		goto out;

-- 
2.49.0


