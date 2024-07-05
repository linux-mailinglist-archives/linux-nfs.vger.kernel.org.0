Return-Path: <linux-nfs+bounces-4647-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2CD928C7B
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 18:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92C0B21341
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39514AD2B;
	Fri,  5 Jul 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uDy5LO4E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703D13A88B
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198307; cv=none; b=tgMYAmJ/XPIY/Y1NJPT3HBTtyMxEREwAsxzA9NhCaOn56kIPR94ZwlJiBuyOJy9K2TQBRJ18w0CPjOR4fcJg+79KYzw6ap1iw4dHrr8rbJPvxK1ARvo2xGX9ab64b0zYbyF/OtXAHXCVDpwyO+ovvkMKEpjxdpfyDPubJ9C84mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198307; c=relaxed/simple;
	bh=9WO+kF59MDYze6xu1cAbLZZCaXEiem1wt5MxMdWCynY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbUrjwQ/bnqG/iOLxzG6rcXGupbkfhltpW0wPw6ltkWSb2WZSHY+uthhp377MaCPOmTgkB/wxe7nZsAYPvMzEJHGbkTEKArXt+P46BPYdpGVUG5tMZLjgCSP7YZrmR6ZN4hnITUL2ELK5Wdef3kCBBLFQufyYBoMyWS+qYW0cjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uDy5LO4E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WloEZcA/EXYYLdP8Wof5sPfRQEE8cLtzbQaKG8novyw=; b=uDy5LO4EfwFQ+99xgTfiQhbfO7
	qUNbxQl5Cb+dCh4pCcY7KFuR7gI7eTC5AwWE2U+66Cc7v0ITBnl+kaHkC35Kzz7AiyXN5OnhFFkCq
	I1roSiAUgep0HvRnCb2QRi3/4bmTqBkPD4GAis1XvFC4tNbyW1xhE72B3rUyQkWJoPJLbStnoyITu
	qKY36F8kyx0Lfn0pKv5blb/JsZp99RrHe0qlNJqe6q5OaPoDSzUA+y+cmMchIpS76Yv1qKIKiK1c0
	viqRqQUEbVQ2jfgMMmNN+wWK3QUCqQvOu8Yo+0Y3kEHZP511kbW1+TlJrcLPlxnEGt5F3Deo5MEMQ
	95Lb3qVA==;
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPm9w-0000000GSHA-2SkG;
	Fri, 05 Jul 2024 16:51:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nfs/blocklayout: add support for NVMe
Date: Fri,  5 Jul 2024 18:51:41 +0200
Message-ID: <20240705165141.2248305-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Look for the udev generated persistent device name for NVMe devices
in addition to the SCSI ones and the Redhat-specific device mapper
name.

This is the client side implementation of RFC 9561 "Using the Parallel
NFS (pNFS) SCSI Layout to Access Non-Volatile Memory Express (NVMe)
Storage Devices".

Note that the udev rules for nvme are a bit of a mess and udev will only
create a link for the uuid if the NVMe namespace has one, and not the
NGUID.  As the current RFCs don't support UUID based identifications this
means the layout can't be used on such namespaces out of the box.  A
small tweak to the udev rules can work around it, and as the real fix I
will submit a draft to the IETF NFSv4 working group to support UUID-based
identifiers for SCSI and NVMe.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/blocklayout/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 221781fb9cf14b..6252f44479457b 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -404,6 +404,8 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	bdev_file = bl_open_path(v, "dm-uuid-mpath-0x");
 	if (IS_ERR(bdev_file))
 		bdev_file = bl_open_path(v, "wwn-0x");
+	if (IS_ERR(bdev_file))
+		bdev_file = bl_open_path(v, "nvme-eui.");
 	if (IS_ERR(bdev_file)) {
 		pr_warn("pNFS: no device found for volume %*phN\n",
 			v->scsi.designator_len, v->scsi.designator);
-- 
2.43.0


