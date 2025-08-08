Return-Path: <linux-nfs+bounces-13496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF671B1E77F
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 13:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C80175D08
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40C274B2F;
	Fri,  8 Aug 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBAWclNr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536A2749F9;
	Fri,  8 Aug 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653270; cv=none; b=qzWDLSa63HgjV+FO+4qOZ4aUzlgM56rsWMfhv6W///LGN1J5lgfWVxAv7oAaMoVVLfoHGMMt6QU6pqSHK0CU4Gv3HHiGclJVpuSaOSnR/XN6Sq5w7rYrsR+wXHrf7KblCi9IPg8qz9hr2GsOWnHYZTUSujLkoMg5Hr8UzJ7C724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653270; c=relaxed/simple;
	bh=NKy0RfPFFkVgZD4rrvhNYxdBB0f4tSuus4JTL++RErs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwdbN9bIU+2FbBdmsH0PPyo5s5YZvdgb6X7HbTEQNMpd31mayLVLCyWa1/CUeOLI3fYbFC/a1Eg6+quMo/dlTtK2q7jvuLOIHsa1B5wW2Azqr1ANW+AcAPX6rWh4BIaQXOlkuNUr3K0P6EsaFtt6d0nO2QnDI33yVTq7CC0GYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBAWclNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC8DC4CEED;
	Fri,  8 Aug 2025 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653270;
	bh=NKy0RfPFFkVgZD4rrvhNYxdBB0f4tSuus4JTL++RErs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EBAWclNrtSBj3ASpyuvxYzpXtzkb2fLBmMAfCR2q0vc611Wk89DI3GSRl0/mOQyS/
	 GfqHO3ql2wECdWg+9ZeCudBMhDSFxDa/5W1nSvFM8g9VxU4PmUiAHBnB5qdufXe7pt
	 JGsOgpS++rtzmiqxrWkhYKyU14Rjcyr9WN1a7MrbaUl0XnE6JlY41ruFw1q4kYwrOt
	 50ldK43h64kbyJXXd8PAdcq6DOenXWit3AlOpfKzt7jI9OVYZJiz/IxM2gCjjZhTPA
	 JWmN8b+F14MxIUTxAVExXG8X21Sg4FVuhSRjmikBQElJNCfTt4nyNJ1JkrshlGa24j
	 Cw1Fzz16u+YHQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 08 Aug 2025 07:40:31 -0400
Subject: [PATCH 2/5] nfs: add tracepoints to nfs_file_read() and
 nfs_file_write()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-nfs-tracepoints-v1-2-f8fdebb195c9@kernel.org>
References: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
In-Reply-To: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NKy0RfPFFkVgZD4rrvhNYxdBB0f4tSuus4JTL++RErs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoleJTirvbyq46rAoR8ifjyuWggazGWvVhOr7/N
 5TRJ9d+A3KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJXiUwAKCRAADmhBGVaC
 FVN0D/9hKKsd2uTFKcfYK6ynp514atSmaFEyR1IQXxl5qb1zYpbhIAdDzQurkDJQg1wpZb5P9so
 43ctOtwTeGZPZRAZrNtEKOGoijjHMcE6sRE+NjeHpBcD+1etywta6cUNS5hBmnZhIh+bHSgBp2r
 Ye4BnVFGGcfn/uMthVUb4wT7eDJuyKw74pnDN2I02OSgYhE0P2/43veExRIZc3CjgdFdw9pRfeJ
 9H5Q6bIVtughQ0lQoDaiW+cquO2QlreC7KMTyfJpWA/oG1+e4ekfDTecQsPR8pBG/2f/WH0Mk9P
 xRpetnJdSmZIW2TEtF3knFXqds3Uej0JWi1ji6WIbRKIx6un1NG0sodMl5AxG/JPxO2J19PcnSO
 usZcRNXjFh2lDveNGQQeSnAuYx9vRZR7X1bVgB0WEKFwk18fQF7SqQg6Y0IJos+Y/NEACgwRqJy
 GIjx3tK3dDl8d3/5odnGvs21jGPWqmQZ4DAfEMEDi8vh0vLR0YB6m6Qf9wcaHXaSTh00hj2wqTw
 HryVdXmIy0wSG7clycb0NM4fbD1IWAdKhVC7Aqw8bxTPrEFhBU9/3RlqNf5Nqo1rfzlQouuHjma
 YRCcURgIig2nGr+HziaVFQh8GafO/B6xMt+OG8A56zCOOQcUHN8LMs4XqD+DYvQCgvkvB+Y23l6
 05tjAEKl0aRIvlQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some tracepoints to the I/O submission codepaths.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/file.c     |  4 ++++
 fs/nfs/nfstrace.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 86e36c630f09eac84f42bbee18dcace415d680ca..1e89801abed626ea64cd79722fad8720b2485d32 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -160,6 +160,8 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t result;
 
+	trace_nfs_file_read(iocb, to);
+
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return nfs_file_direct_read(iocb, to, false);
 
@@ -656,6 +658,8 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	errseq_t since;
 	int error;
 
+	trace_nfs_file_write(iocb, from);
+
 	result = nfs_key_timeout_notify(file, inode);
 	if (result)
 		return result;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 9ebfb220e94a5389e633210519a9a1f21a052d76..d7d25cdf0060b3fa7c5889752a1bd193d0e8ca92 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1045,6 +1045,58 @@ DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_done);
 DEFINE_NFS_FOLIO_EVENT(nfs_invalidate_folio);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_launder_folio_done);
 
+DECLARE_EVENT_CLASS(nfs_kiocb_event,
+		TP_PROTO(
+			const struct kiocb *iocb,
+			const struct iov_iter *iter
+		),
+
+		TP_ARGS(iocb, iter),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(u64, version)
+			__field(loff_t, offset)
+			__field(size_t, count)
+			__field(int, flags)
+		),
+
+		TP_fast_assign(
+			const struct inode *inode = file_inode(iocb->ki_filp);
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->offset = iocb->ki_pos;
+			__entry->count = iov_iter_count(iter);
+			__entry->flags = iocb->ki_flags;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu offset=%lld count=%zu ki_flags=%s",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->version,
+			__entry->offset, __entry->count,
+			__print_flags(__entry->flags, "|", TRACE_IOCB_STRINGS)
+		)
+);
+
+#define DEFINE_NFS_KIOCB_EVENT(name) \
+	DEFINE_EVENT(nfs_kiocb_event, name, \
+			TP_PROTO( \
+				const struct kiocb *iocb, \
+				const struct iov_iter *iter \
+			), \
+			TP_ARGS(iocb, iter))
+
+DEFINE_NFS_KIOCB_EVENT(nfs_file_read);
+DEFINE_NFS_KIOCB_EVENT(nfs_file_write);
+
 TRACE_EVENT(nfs_aop_readahead,
 		TP_PROTO(
 			const struct inode *inode,

-- 
2.50.1


