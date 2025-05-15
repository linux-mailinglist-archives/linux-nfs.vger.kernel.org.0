Return-Path: <linux-nfs+bounces-11740-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B551AB854F
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 13:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13417B4448
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1AA298C1B;
	Thu, 15 May 2025 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nij17mPP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7618DB37;
	Thu, 15 May 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309881; cv=none; b=nG1/Us6XKBXMcxukHT4xY/rmqS/1D4HtW6vj2p3yM7d/hUDy0AMfUxcTNofS52qJU7o6EnDEpRyB9VPRaQa1tP+NWYG+qZzs67k6qBSOyehUEQlaBaga37eHyp109ecpxz5oQgqndcA4BZJB8EUXf/PxmwSg/mfdERj8coMcD1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309881; c=relaxed/simple;
	bh=jP7paHd7LNoN/5KAqXTABm5bflV2CA/bf/GK/hnXUd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brd4LjPWKjPA/8uW4VNiMpC5CKy0znWQHdudDThRhrH8kA13RWrzKpPtZjxdB8p/ybiD4otIXnaZ3POuIFlG7+FvSnkiz00GeCxUbYjN0vDsem9ExhBq+JbqmNldfCytCdz6hFtPFN129IhmKXogspeO25cUhntKcykgmNRTBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nij17mPP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wfkxdp+KQnBuhf6BMSRf0uTiVfQo7KnlquqGGtnwfoY=; b=nij17mPPp/jpUhAYq7cU3DApLH
	Fzzvld4p25eydAkP7lxBGWyL9GguDcQ5kGyymo/d6JrzuVA4GuJgrFP7ikiJqImQK8Aa67al+CpiU
	AyBsd/t0pEro/pBjjrLuMnKxxUFTkwwtEMVupt3ZeXQpGg8aYmCW/kQ4SD5BVz7T7jrjlnrj/8BMR
	daGKdgt43/19zHKUArtJsUtVyuA3iiH40acjQ2KEMBWsQaC3nKlR/OCSUj3ZcIAJADNFR9x1pKY1t
	8thCO7J/sp6+oCBl9H9C7DB3HRU17YcXKbnGWTcOyIWOGNc3tsbMZ6qZAG1/JNhUzpomBsrfMb65N
	BGA0bdwA==;
Received: from 2a02-8389-2341-5b80-81b5-a24e-41ab-85a6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:81b5:a24e:41ab:85a6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFX7O-00000000Sco-4BNd;
	Thu, 15 May 2025 11:51:19 +0000
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
Date: Thu, 15 May 2025 13:50:56 +0200
Message-ID: <20250515115107.33052-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515115107.33052-1-hch@lst.de>
References: <20250515115107.33052-1-hch@lst.de>
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
 fs/nfs/inode.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 119e447758b9..e7a519f5b6bc 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2571,6 +2571,35 @@ static struct pernet_operations nfs_net_ops = {
 	.size = sizeof(struct nfs_net),
 };
 
+#ifdef CONFIG_KEYS
+static struct key *nfs_keyring;
+
+static int __init nfs_init_keyring(void)
+{
+	nfs_keyring = keyring_alloc(".nfs",
+			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+			     current_cred(),
+			     (KEY_POS_ALL & ~KEY_POS_SETATTR) |
+			     (KEY_USR_ALL & ~KEY_USR_SETATTR),
+			     KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
+	return PTR_ERR_OR_ZERO(nfs_keyring);
+}
+
+static void __exit nfs_exit_keyring(void)
+{
+	key_put(nfs_keyring);
+}
+#else
+static inline int nfs_init_keyring(void)
+{
+	return 0;
+}
+
+static inline void nfs_exit_keyring(void)
+{
+}
+#endif /* CONFIG_KEYS */
+
 /*
  * Initialize NFS
  */
@@ -2578,6 +2607,10 @@ static int __init init_nfs_fs(void)
 {
 	int err;
 
+	err = nfs_init_keyring();
+	if (err)
+		return err;
+
 	err = nfs_sysfs_init();
 	if (err < 0)
 		goto out10;
@@ -2638,6 +2671,7 @@ static int __init init_nfs_fs(void)
 out9:
 	nfs_sysfs_exit();
 out10:
+	nfs_exit_keyring();
 	return err;
 }
 
@@ -2653,6 +2687,7 @@ static void __exit exit_nfs_fs(void)
 	nfs_fs_proc_exit();
 	nfsiod_stop();
 	nfs_sysfs_exit();
+	nfs_exit_keyring();
 }
 
 /* Not quite true; I just maintain it */
-- 
2.47.2


