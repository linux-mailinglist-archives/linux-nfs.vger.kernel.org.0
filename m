Return-Path: <linux-nfs+bounces-13104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB07B076DE
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBFC584BFF
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ED91A8F6D;
	Wed, 16 Jul 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2Qsspdb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC861A5B96
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672422; cv=none; b=q7WI2jjGbRi2R03Q/IpzdVdp991Jn/OrPyZ2CsOfgrM78Ciyc4HUOSsMtBUi4FZ4/KIEMeyNS00nBIJ4l9B9tlKYfKdsMD5OwRehiA1rmdLNbJdFXYZxWrhkdOVwo6p/awMcw+m8yIuUct6UDA073/iu+cOX7vsDCvDZhIv1utI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672422; c=relaxed/simple;
	bh=/Zp4raXpHUs+NOATp4qH6C1sb23KLcmTtKCtnCYnCas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cH+4HND0UbOa6VmXEFEmglqO6uAN0Rjed2PZTU4kBorXPoC2hvK5KkZrhjvsTR5bRetoOUQr+0VkvsMy1yG1G8JiLJQsKxTs7zcLta7tolwXBdTI88+Vg9R9UVxQEigKA6WYSTrmsck2CEG/umTG+6DOLDtac/RgZ1wUYJgvhVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W2Qsspdb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CuDEslFqN4J9sEf1rdMA7G58By8L+darqpM4h17uRsA=; b=W2QsspdbhTe6HOr8kkuD09BiDd
	Gq0MvUe85S3wfHGGZRsUQ4IreDplaL9l/5LPLGBI7X/d+5U1Ol142lKaKbebRcMmiqkwrlV+XE1YW
	tbav2YhI0DdcXQxMkD220LG+AwTLloI+TTFlElyiKMnLAm0NmtIL5ETCsWRvKHHxhwgIZK/KY2qUd
	OM3mSFx2yMy1VB+OfZPte2gMr14lgcgaMQU8OUZKVGZ2XpQ/J0Lo9avmIdzL836M6UNgc7UrXB7b0
	kXXEcPFmKkI0jMgdYri4fRsy9SLkEbv+9cDI8ULA0GPLOylOXeGBFJJM535aQ5QxviLAnWiPFgtT/
	BErUs66A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2A0-00000007n7R-11OT;
	Wed, 16 Jul 2025 13:27:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: use a hash for looking up delegation v2
Date: Wed, 16 Jul 2025 15:26:30 +0200
Message-ID: <20250716132657.2167548-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

currently recalling delegations has to walk the server->delegations
list, and then take the lock for each delegation.  This can take a lot of
time and has adverse effects to the rest of the system due to the number
atomic operations, cache lines touched and a long RCU critical section.

This series first converts the delegation watermark to be per-server, as
all the state guarded by it is per-server and the commit message adding
it talks about server side overhead as well, and then adds a very simple
hash for finding the delegation for a given file handle in
nfs_delegation_find_inode_server.

With this hash sample microbenchmarks that cause delegation recalls in
reverse list order are sped up ~5 percent, although the time is still
very variable due to other factors.

Changes since v1:
 - only allocate the delegation hash for v4 mounts

Diffstat:
 fs/nfs/client.c           |   15 +++++-
 fs/nfs/delegation.c       |  110 ++++++++++++++++++++++++++++------------------
 fs/nfs/delegation.h       |    3 +
 fs/nfs/nfs4client.c       |   10 +++-
 include/linux/nfs_fs_sb.h |    3 +
 5 files changed, 96 insertions(+), 45 deletions(-)

