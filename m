Return-Path: <linux-nfs+bounces-13498-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3703B1E782
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 13:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B8316A616
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415CF2750EC;
	Fri,  8 Aug 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li/V7z2r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1517D274FEB;
	Fri,  8 Aug 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653272; cv=none; b=gFCvlAHGHiyLr79mdBRbCg8jqNckz4HekCG/BKUG10mCfmCUBmNArtnfOfwL3ghNdruXFoHguoc9Falrk+240IRt1nAQgI0cYmytyGyXVeEVOyTb29kNlPTdSXrmrX6fEPFNo9p8gtyIWMWfxs+/a0hXd7AgBD3ccKwiC4mm2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653272; c=relaxed/simple;
	bh=QlG+731peChM/wrFbsUQ3tB9V1jiBwoxRHe1UOwigpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqGATJgPMZgOO/uoPdXo7APGwAotj23gkLBCDuiTugbZZITOJa9MNva7nrjsmfYLzl1eeTcZu87lSnODl0UhrRIw2EYwCkymDCTgnGzrKrH/4BXU3BhU2QlNFuvslPMa+Bq29uXJNpg/t+vWGPaRFrdEUTMXVLRI8eHF+u6N6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li/V7z2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52840C4CEFB;
	Fri,  8 Aug 2025 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653271;
	bh=QlG+731peChM/wrFbsUQ3tB9V1jiBwoxRHe1UOwigpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Li/V7z2rw/BqeULhcajKFHebx7pCs3MkT1dB/fbcu4euYeQ8yM6mrOPLBay/QxEIS
	 SoKBmR3hQsfTzWhYychutAcW5H6NteIgipZYsD6gG/vpAp3D2uCUNQ0kfXClXtiJTb
	 XVuRsNGPDnR6KhFSWQ5jGsLbRoNvCcr7Y2xLE+f5IsNWIJ2YkHYITZFU3idp5fck0i
	 w+arJXhJBhaBB7srUE6plY3S/eYVIypTeS0KFPXb5sco8kxoKgi47TIRdPSlVXvG0i
	 EEcFDdFzpY6G5wyCSrEBZRK1Zpa1GdSdI9nygzSNlq0llG2tLLL7QUm6wf5D9nVMGv
	 by2ykVmh4cu9Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 08 Aug 2025 07:40:33 -0400
Subject: [PATCH 4/5] nfs: more in-depth tracing of writepage events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-nfs-tracepoints-v1-4-f8fdebb195c9@kernel.org>
References: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
In-Reply-To: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3601; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QlG+731peChM/wrFbsUQ3tB9V1jiBwoxRHe1UOwigpU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoleJUZd9Cipil3WDG+n0jgMbvPscoT4WTjPp5n
 6L0B5XEPHqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJXiVAAKCRAADmhBGVaC
 FQF8EACkWoALnSLZyBM7q5mBVICxNHWbs91hRh318vQibPn5VsgVVTqz8eYQmvQqiwI4ORdnvz1
 SKHtFcaouu4Zwqz1QhqSeZLrzdKGpaIMl2yI3jptDLd+jpjjIsP5X5Ok3OTTomVaXDC986CTPIR
 nG++vP5ZRM4x3AGmxB8PRu+jt4z72qu+emIALEpFrcChgphzqKICc0pk/XGDq6iOfQ8GrrTt6fi
 FoiHd+xjl2KO/S+roCGIYBXxZGErBpvREVLymbTrArA9EkYjKzGHfII9qBcbF4Olg6IgrWv71EK
 9clWfhsYho6tezfKOY9p9U1TTogieR/Sb/HPOSh9A8cwNyayg96ibwgJzeIGJkeIVQAZPzReyzo
 7SOT7PeCJOBokFfjvFZPF4+sfop9GFc1zhthAelwXz3VLjSox9Dhk944dXTqSS0K2ENdXM+1vDm
 0QcMOSDiMsF//s53ldKU2NFbb3GQHW+QrZDUEN7tqJGiRl5i2nN4ui+QpntR56WXX/C9egUyXd5
 slrssx4kYOvhrPT6Nxm7meDoAn/5/ZtGy9FFfkFW5l1MlT4y5Gh4eYJca9HGKThmx0OJp0j0jnp
 HRiyaDUF4bqhDofu6Nmo4dLRtPg0HwWsLW+iBn872/wzjZCXowfmegvPTJcYaa1/Pwur/g96LPh
 7ylIXvkvRNESr6g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add tracepoints to nfs_writepage_setup() and nfs_do_writepage().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfstrace.h | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/write.c    |  2 ++
 2 files changed, 68 insertions(+)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index b90eed094e639a532463cb5a3f6ba32c64431a6a..63dec30226153a78dd9017fdb1104ba3301f7372 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -44,6 +44,23 @@
 			{ BIT(NFS_INO_LAYOUTSTATS), "LAYOUTSTATS" }, \
 			{ BIT(NFS_INO_ODIRECT), "ODIRECT" })
 
+#define nfs_show_wb_flags(v) \
+	__print_flags(v, "|", \
+			{ BIT(PG_BUSY), "BUSY" }, \
+			{ BIT(PG_MAPPED), "MAPPED" }, \
+			{ BIT(PG_FOLIO), "FOLIO" }, \
+			{ BIT(PG_CLEAN), "CLEAN" }, \
+			{ BIT(PG_COMMIT_TO_DS), "COMMIT_TO_DS" }, \
+			{ BIT(PG_INODE_REF), "INODE_REF" }, \
+			{ BIT(PG_HEADLOCK), "HEADLOCK" }, \
+			{ BIT(PG_TEARDOWN), "TEARDOWN" }, \
+			{ BIT(PG_UNLOCKPAGE), "UNLOCKPAGE" }, \
+			{ BIT(PG_UPTODATE), "UPTODATE" }, \
+			{ BIT(PG_WB_END), "WB_END" }, \
+			{ BIT(PG_REMOVE), "REMOVE" }, \
+			{ BIT(PG_CONTENDED1), "CONTENDED1" }, \
+			{ BIT(PG_CONTENDED2), "CONTENDED2" })
+
 DECLARE_EVENT_CLASS(nfs_inode_event,
 		TP_PROTO(
 			const struct inode *inode
@@ -1457,6 +1474,55 @@ TRACE_EVENT(nfs_writeback_done,
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs_page_class,
+		TP_PROTO(
+			const struct nfs_page *req
+		),
+
+		TP_ARGS(req),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(const struct nfs_page *__private, req)
+			__field(loff_t, offset)
+			__field(unsigned int, count)
+			__field(unsigned long, flags)
+		),
+
+		TP_fast_assign(
+			const struct inode *inode = folio_inode(req->wb_folio);
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->req = req;
+			__entry->offset = req_offset(req);
+			__entry->count = req->wb_bytes;
+			__entry->flags = req->wb_flags;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x req=%p offset=%lld count=%u flags=%s",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid, __entry->fhandle,
+			__entry->req, __entry->offset, __entry->count,
+			nfs_show_wb_flags(__entry->flags)
+		)
+);
+
+#define DEFINE_NFS_PAGE_EVENT(name) \
+	DEFINE_EVENT(nfs_page_class, name, \
+			TP_PROTO( \
+				const struct nfs_page *req \
+			), \
+			TP_ARGS(req))
+
+DEFINE_NFS_PAGE_EVENT(nfs_writepage_setup);
+DEFINE_NFS_PAGE_EVENT(nfs_do_writepage);
+
 DECLARE_EVENT_CLASS(nfs_page_error_class,
 		TP_PROTO(
 			const struct inode *inode,
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 60138026053b992434c6fadc7bc53ebb5d8e8545..b5632f18813bee4e6a45cae3651399c753631958 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -646,6 +646,7 @@ static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
+	trace_nfs_do_writepage(req);
 	nfs_folio_set_writeback(folio);
 	WARN_ON_ONCE(test_bit(PG_CLEAN, &req->wb_flags));
 
@@ -1146,6 +1147,7 @@ static int nfs_writepage_setup(struct nfs_open_context *ctx,
 	req = nfs_setup_write_request(ctx, folio, offset, count);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+	trace_nfs_writepage_setup(req);
 	/* Update file length */
 	nfs_grow_file(folio, offset, count);
 	nfs_mark_uptodate(req);

-- 
2.50.1


