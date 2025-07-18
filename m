Return-Path: <linux-nfs+bounces-13149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D07B09D89
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 10:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46FA1894E6E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751794C9D;
	Fri, 18 Jul 2025 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NIhS21kT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E611DE8BE
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826523; cv=none; b=bJREhwIggQ0vy5CDo+pr89ogJ5C233NInLubYGlQ7dCXxXsAjrR3Aw74Ke2ykFfAA7qBLFuXzS+Vmg/ReU5pBGj4QGzuVKzr3DYae055jUTcWmujftNxyFwbumN+C3D8R4H4Ndc7VpgStLbYDvEHmoDFpFJolxcSs6NFNyJ9yCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826523; c=relaxed/simple;
	bh=eKUb7zLsii2CSITtn8+jonAtCjncDTPASXNIo3vwVzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR7dhtEgFvmKRgcGtJyETSD4EBnVIUmem29+y4ptS5KGQN9BO4f6X/DXG7xpFzOiF81fpAS7fab8AnqZXFDQd8qQ1ov1FJuExhWtTNiI+1O40Jt6Ykj3ioujP1EKolDjuN/V2sGZ70MvcLHnoEmi6ePgZr3z3AB9gp0LZbbYzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NIhS21kT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hHS2Ne1IAPkd38Lgbrly8el+F2zNtIrp8wPB7D103e0=; b=NIhS21kTgZNrW00CGdlUBnYDtT
	Oh/uzQ4kpfuod2t0QVRc3huXObXOx7y7dZJOi52VanO973NLpS5ALvG8RnSpGWEVk71Ls+EGEzpAl
	oWKEdfA5GmA56WK576j6/7TgcNn8LyPwBhYOAnlrF2yR2egAIIvdBX4DLRvO3m1VVRFJvZGl98cU+
	Cvth/JXwZ6x4LnbarapQxV/dPZluZ87O6NikgIYWr/rkob7fmVd8IlrsxN3FGjkZoY6WuNdwY2jGW
	ccpIEMzvC+gHXn+4C8DrWXDljYb0s7uAU4xuYM0hxaPjtTxDSi66qXX2mO4J7j75q74PSX269XVGd
	J+hcTClw==;
Received: from [2001:4bb8:2dd:a44:6557:72e7:fc8:56bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucgFV-0000000BzuV-0OyM;
	Fri, 18 Jul 2025 08:15:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 3/5] NFS: move the delegation_watermark module parameter
Date: Fri, 18 Jul 2025 10:14:48 +0200
Message-ID: <20250718081509.2607553-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718081509.2607553-1-hch@lst.de>
References: <20250718081509.2607553-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Keep the module_param_named next to the variable declaration instead of
somewhere unrelated, following the best practice in the rest of the
kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 568d2e6d65fa..5f85966d7709 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -29,6 +29,7 @@
 
 static atomic_long_t nfs_active_delegations;
 static unsigned nfs_delegation_watermark = NFS_DEFAULT_DELEGATION_WATERMARK;
+module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
 
 static void __nfs_free_delegation(struct nfs_delegation *delegation)
 {
@@ -1573,5 +1574,3 @@ bool nfs4_delegation_flush_on_close(const struct inode *inode)
 	rcu_read_unlock();
 	return ret;
 }
-
-module_param_named(delegation_watermark, nfs_delegation_watermark, uint, 0644);
-- 
2.47.2


