Return-Path: <linux-nfs+bounces-17522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CA1CFC56D
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 08:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0E0300A1EE
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47970279794;
	Wed,  7 Jan 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itxBAnVs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C175230BCC
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770850; cv=none; b=fHPlRRrSQVPLUaEinLggEn8/v8IP0KgTQdiX+6J7YZbigjixSGoMQQOSDatUMR4Ocf7h/SKYeK7LP70Iwn2JiImf3/Txii5qp3uC5HycJvjfHsUMDXKa6fi0uP3NWEdo+nGrGuvwcNhrkIsGo3olgPmLbDh5i0aetkG1JL8Wf70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770850; c=relaxed/simple;
	bh=D2aehreeLknyQ+DMsmXYLj0ze01+q1GIcC4dfJYa/Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUjMCM7+5RBWQjcq+b5YlXtJQp+E7ph1ySRNReiHfjvdHBahL/50KzYh8DPXYkiAO0dLn4uGMXSXG3IOSg/D2D4B4KOS234HjyRWRBJWn/1683Z12jIZ+waSjj/xhYMd7TBs9ldfvwR4hZcDpBmnVa1MvgMiJPCdUwLQD+mlvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=itxBAnVs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nIqevnIeW0bBOWsNumsfaxpU684nK6wZeu5oy/t6+ko=; b=itxBAnVskVln9cMlZ+Xia1O64m
	YEfr5n6h6ZJHKa/XHLhHjppcUdHzq3wNNIVj3mutzm346pkfiGAxQxY+MF6VtjIN/+8EVbP4zz8aI
	b6mei3YSy2cFWMepPDVbsPi8hjTMmws8Gl7NUlIvnjCu8brOQvIIltf1N3dCRjp6OjXDxoWuhxDU3
	fg//3yYahOjHAvkSg+H69jx/n9GPvDttHelZQ30Dh/6EMYRUbgcmV3HKSS+PaTaKuVvm/9N7DSE09
	590vsCBgjAEBtmEQovHvH35F93HvPEcxtQthkvyo3CcVORP0Wi4gxyTXLMJ4IXUhUhXkCbX8/Pvxe
	7CEzmFbQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNwz-0000000EHjY-2BOv;
	Wed, 07 Jan 2026 07:27:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: add a LRU for delegations
Date: Wed,  7 Jan 2026 08:26:51 +0100
Message-ID: <20260107072720.1744129-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

currently the NFS client is rather inefficient at managing delegations
not associated with an open file.  If the number of delegations is above
the watermark, the delegation for a free file is immediately returned,
even if delegations that were unused for much longer would be available.
Also the periodic freeing marks delegations as not referenced for return,
even if the file was open and thus force the return on close.

This series reworks the code to introduce an LRU and return the least
used delegations instead.

For a workload simulating repeated runs of a python program importing a
lot of modules, this leads to a 97% reduction of on-the-wire operations,
and ~40% speedup even for a fast local NFS server.  A reproducer script
is attached.

You'll want to make sure the dentry caching fix posted by Anna in reply
to the 6.19 NFS pull is included for testing, even if the patches apply
without it.  Note that with this and also with the follow on patches the
baselines will still crash in some tests, and this series does not fix
that.

Changes since v1:
 - fix the nfsv4.0 hang

Diffstat:
 fs/nfs/callback_proc.c    |   13 -
 fs/nfs/client.c           |    3 
 fs/nfs/delegation.c       |  544 +++++++++++++++++++++++-----------------------
 fs/nfs/delegation.h       |    4 
 fs/nfs/nfs4proc.c         |   82 +++---
 fs/nfs/nfs4trace.h        |    2 
 fs/nfs/super.c            |   14 -
 include/linux/nfs_fs_sb.h |    8 
 8 files changed, 342 insertions(+), 328 deletions(-)

