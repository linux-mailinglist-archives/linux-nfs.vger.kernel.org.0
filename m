Return-Path: <linux-nfs+bounces-11558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C39AAD9EC
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 10:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7539A4BDD
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA986223719;
	Wed,  7 May 2025 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FquN4ct/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81982223715;
	Wed,  7 May 2025 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746605394; cv=none; b=M49fD+gbD4RQ4PcgMYibhyrSD/wK3gUOmpPlJQeAGllW+Os90Nv5+9U+yYITExPGsKLFjcxzFw0DXCG06CHq23Sp4xXDT90zLNQREnymH2kty/wJolQLP3A8k4vBkBJ486mkUcmAUHqGEvLRcJp8USBdgTtei7/R3EYOhqiwbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746605394; c=relaxed/simple;
	bh=Ga7dnYONWW6pQTZBnKOZXPLB1qcUDrDxR0uOkbFmXA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4N5d8qnWylJ4R7AkTh4MBi8kIZFlW7UmSyXblU7c5rKlzvrYmnbelkgjMJVf3hoeABNQB5b0flz2mUOcbdmylj5PBpXn6wn+rSfyrW/p3vu4XDbftQFlp4t6Yt389Je/Jda4x7AnwsPKVLd7KRbDAXQOWMRFPtLS2aU/HhFVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FquN4ct/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MSvX0Iv4a/Ez4u16yOHWPS+nmuShukYzT/zA6sPHA34=; b=FquN4ct/ZEzEPbmQ07S9r3+xSL
	uwRbYswkikuCHuYH3t1lpgz/0ieKikXjWpfbQ0GFwPL6+RbJN522BgmgRjAKGeZ1iepdPEW4oy4eT
	SWFhFOsxqdPVPduerVdXm2e9Hz+WkdFqpbb+HoRHIM68PsU6DpMDvNBbXoM9V+pXRVBV5nTCF9KGH
	84UJ1FPO8NyqJXEdQTqacW5dtdjS7d6KAAVnvDO4HLHCLJrvn0xZcIB4VzkzqOJiU74gbrXKPn+yc
	TA4JoH/eak4CxIgpqjx+LHDtToYvwqoXcqwyeJ+treL75uGAcC14cCwgAzfPT0T49ktgCjB8IiHK7
	EabOgHYA==;
Received: from [2001:4bb8:2ae:8c08:f874:4a3:a9ae:2540] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZqi-0000000Efjo-2rWY;
	Wed, 07 May 2025 08:09:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: [PATCH 2/2] nfs: create a kernel keyring
Date: Wed,  7 May 2025 10:09:41 +0200
Message-ID: <20250507080944.3947782-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507080944.3947782-1-hch@lst.de>
References: <20250507080944.3947782-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Create a kernel .nfs keyring similar to the nvme .nvme one.  Unlike for
a userspace-created keyrind, tlshd is a possesor of the keys with this
and thus the keys don't need user read permissions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 119e447758b9..fb1fe1bdfe92 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2571,6 +2571,8 @@ static struct pernet_operations nfs_net_ops = {
 	.size = sizeof(struct nfs_net),
 };
 
+static struct key *nfs_keyring;
+
 /*
  * Initialize NFS
  */
@@ -2578,6 +2580,17 @@ static int __init init_nfs_fs(void)
 {
 	int err;
 
+	if (IS_ENABLED(CONFIG_NFS_V4)) {
+		nfs_keyring = keyring_alloc(".nfs",
+				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				     current_cred(),
+				     (KEY_POS_ALL & ~KEY_POS_SETATTR) |
+				     (KEY_USR_ALL & ~KEY_USR_SETATTR),
+				     KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
+		if (IS_ERR(nfs_keyring))
+			return PTR_ERR(nfs_keyring);
+	}
+
 	err = nfs_sysfs_init();
 	if (err < 0)
 		goto out10;
@@ -2653,6 +2666,8 @@ static void __exit exit_nfs_fs(void)
 	nfs_fs_proc_exit();
 	nfsiod_stop();
 	nfs_sysfs_exit();
+	if (IS_ENABLED(CONFIG_NFS_V4))
+		key_put(nfs_keyring);
 }
 
 /* Not quite true; I just maintain it */
-- 
2.47.2


