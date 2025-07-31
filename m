Return-Path: <linux-nfs+bounces-13330-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E7B16D3A
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3CA3A867F
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532012586EE;
	Thu, 31 Jul 2025 08:11:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E11B0439;
	Thu, 31 Jul 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949471; cv=none; b=moYhmURP0EvDUBi0mPk390GtEWE+5ns7qNVA9SaoqEbbj8yU/jfYQPp6ILx07c4iv2iK0P7vWJFfNsCODnvcBLwKtmZcpYHdarJnM3kgiCCqBQXVP8YOi5DWZlu6bNIs7rs0lh0QloQmFNs3U+Zf2sDMtZWYdYo3G35TrPKTGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949471; c=relaxed/simple;
	bh=fXBMkxJ+KJTdQtYjvheXTqi2RPfTidPvXNiQGzaIgpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V3KuPXIxhlaAr0Eho2MKSEohb/VT8cbxj9j2pSoQGOIV7MJHped1u8szFqlUipb3ZVbnijj811NpIdaCPVeu35D1IupP0g4tyAe9mgRx1sQDybKrg3dP6fJPlrQlWSUDsuP+blAGM23xIIYniDj0NGmj3ZsXHK6hzP8tTUPXijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] nfs/localio: use read_seqbegin() rather than read_seqbegin_or_lock()
Date: Thu, 31 Jul 2025 16:10:38 +0800
Message-ID: <20250731081038.3478-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc14.internal.baidu.com (172.31.51.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The usage of read_seqbegin_or_lock() in nfs_copy_boot_verifier()
is wrong. "seq" is always even and thus "or_lock" has no effect.

nfs_copy_boot_verifier() just copies 8 bytes and is supposed to be
very rare operation, so we do not need the adaptive locking in this case.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/nfs/localio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 510d0a1..bd5fca2 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -500,14 +500,13 @@ nfs_copy_boot_verifier(struct nfs_write_verifier *verifier, struct inode *inode)
 {
 	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 	u32 *verf = (u32 *)verifier->data;
-	int seq = 0;
+	unsigned int seq;
 
 	do {
-		read_seqbegin_or_lock(&clp->cl_boot_lock, &seq);
+		seq = read_seqbegin(&clp->cl_boot_lock);
 		verf[0] = (u32)clp->cl_nfssvc_boot.tv_sec;
 		verf[1] = (u32)clp->cl_nfssvc_boot.tv_nsec;
-	} while (need_seqretry(&clp->cl_boot_lock, seq));
-	done_seqretry(&clp->cl_boot_lock, seq);
+	} while (read_seqretry(&clp->cl_boot_lock, seq));
 }
 
 static void
-- 
2.9.4


