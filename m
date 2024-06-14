Return-Path: <linux-nfs+bounces-3822-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C7908942
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 12:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587A71C265C1
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6520B1946A7;
	Fri, 14 Jun 2024 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wcjp3WhV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA031946B9;
	Fri, 14 Jun 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359417; cv=none; b=G3pGarfBFbN+OEEtZ56qpTS2KfpvJyRo+MqMfows2Z/ejsiikqSGb+6EGpogG2aPeezGtAc5m/1UdJN56JjR8Sfy0MQZjrsuaS1T2szO09N00eA6TB9R4cbLEMLQRg2chJ+tKR4Nz5DNGdUhje7fjZLmP5Xszlwe+TThuBPg6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359417; c=relaxed/simple;
	bh=LrtkEuvKffls++VLZGvU+odWuHFgeu13Obm1nGKPmcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ebu0+9F0zkfXEhGBEbmXlUBMwId/l+dmZopncEeW5QfwC2naxGbRs+vJpKWeDdA1saacxq+bPxyV8QihumQkFYKIZW+cG83FhGqp9vu5d2J3FwOyOGiGuTbaVN2GMkCTWsEXZpwr2bibAVhskR11XDNteNBo6FWv9urHOqYwgsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wcjp3WhV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FStQe0rOw4ovI+CUc36E/SQiQptY2BV5r14yvxvD/o8=; b=wcjp3WhVk78M5sPQVxfA8WojUN
	z48Q4IpxtprJCyho9D71S9CReioWmnl7v2h9kyQHZXyrSHYnjIMFgmLnRFH3uMV+hX3fpZRyZ2f+7
	kuKBR7gBriGaMAshc60VvfaoIFsrzU70w0OAGIy1V5HHLkuEiKHKa9Z+wlK1WpyNSIQ38b+IWR2Cl
	QdIG6+n6UgZWfquOXvYUL7xE1zgUToJula4U1pipmEwOhGlHWnHudJ1Y4x5FVuzf6VD9Kt6L8z9NQ
	oaT1kgD+PPdK5cPbdXJ5UAQjxigbvjCgZEb5Ra6lf16c21CxneLxOfRLBdcUZDdzKQIeaUNrFm9K1
	FYbNi2uQ==;
Received: from 2a02-8389-2341-5b80-6543-87c9-27d1-cd7c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6543:87c9:27d1:cd7c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI3mQ-00000002Kh1-1Wya;
	Fri, 14 Jun 2024 10:03:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Steve French <sfrench@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
Date: Fri, 14 Jun 2024 12:03:25 +0200
Message-ID: <20240614100329.1203579-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614100329.1203579-1-hch@lst.de>
References: <20240614100329.1203579-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

As of Linux 6.10-rc the MM can swap out larger than page size chunks.
NFS has all code ready to handle this, but has a VM_BUG_ON that
triggers when this happens.  Simply remove the VM_BUG_ON to fix this
use case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/direct.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index bb2f583eb28bf1..90079ca134dd3c 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -141,8 +141,6 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
 
-	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
-
 	if (iov_iter_rw(iter) == READ)
 		ret = nfs_file_direct_read(iocb, iter, true);
 	else
-- 
2.43.0


