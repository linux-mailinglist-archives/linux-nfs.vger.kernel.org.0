Return-Path: <linux-nfs+bounces-13026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4BCB03701
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 08:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DD13A2725
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B639217F55;
	Mon, 14 Jul 2025 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xMdBQt/6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFB126F0A
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474297; cv=none; b=UfLyglTeAQtWRLPvTljrwCrSG7ybDQuoYft54IySu2Bza+WrVw6Ao844Rn8ieNXFtnMVn58cbFWBdbk4wuCULqJs8I1g9dCV2MGtqcO9sUSQnsQVWUBUaoGnVcji90I3w0yVQW5yoaF2WYabUJqH3Vlp8n1G491H71/DeKHfuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474297; c=relaxed/simple;
	bh=W1kGcjE0oK8iie+UbnuO3lAmG7s0FTItfeCIP7xieA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CWekEIxUXUHA8okTiF0JXVFyNHmb/LR00x8o3SWelFSXgH6U6PybTqcdwob/Cj8i1djrmiJem0/jpe42j3biJ2SJ+24MfsW5iZniC2y/zTwt276gBLAIZgHjHlUylLi7OnVBizpnqc+BqC7HeLgkTG31XQ3UVaefaCkc8kV8Dt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xMdBQt/6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dXYXZWXU1Ez/sF/9rdydTqWoV4UTTxn4NZLi3hNs+0o=; b=xMdBQt/6KmJzQPI2pSXuu3Epya
	jzG44eBfx5JNBicjbAqIwWUy0xLGOE8SZRW+ok5S0njV5zIsADDqxfEhChgqHdd+AzF4LrsAsGJKG
	sapDen5Nx8aLDShV0hKEoTKZcqYx7uqgaFznrqpuqjXc9mOhW3VEcczMySdqnLyAHmJ1146d6RQtA
	LdG0BjHQFzkyy0HiJMbnNaykNA06dlKf2kqlsByjp3G3F2mL4fjNXJAZYHgchixdytkr5WxsNo16Q
	mtjdo6zrbIhlwxZjXcXbkd+joDdak0pwtfBsv/9Vc270qrcs6WkyJqbTuQmTbavrIkRhL6x3TxNYw
	4VsopDzA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubCcQ-00000001LAt-1fdm;
	Mon, 14 Jul 2025 06:24:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: drop __exit from nfs_exit_keyring
Date: Mon, 14 Jul 2025 08:24:50 +0200
Message-ID: <20250714062450.1468117-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Otherwise built-in NFS can lead to sectіon mismatches.

Fixes: 2c285621176c ("nfs: create a kernel keyring")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 60fa0c8ff04e..338ef77ae423 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2663,7 +2663,7 @@ static int __init nfs_init_keyring(void)
 	return PTR_ERR_OR_ZERO(nfs_keyring);
 }
 
-static void __exit nfs_exit_keyring(void)
+static void nfs_exit_keyring(void)
 {
 	key_put(nfs_keyring);
 }
-- 
2.47.2


