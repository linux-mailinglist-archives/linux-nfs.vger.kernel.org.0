Return-Path: <linux-nfs+bounces-13034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136EDB03D1E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D02516EC25
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDFF24501B;
	Mon, 14 Jul 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fCM8RM5I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651E1DE892
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491818; cv=none; b=UJxx/L11QDP6JWtN46Xl1zMQ338Rvr9Y/qvGbtJPnhuWOO3tB/O3+tZjo8lNA7gewfchwPX5dBIDNA33W9VrPutEQRjCa2YGhxdMDckv8zmRa1dmN8iMbztZc9IBjNe3w0fia/wYiIhUGEJ91jCEYHwvo4IucW5FUTpTzuVT600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491818; c=relaxed/simple;
	bh=NOs3XZMYt06deTATof/VMImIrrWR3Vvbdp+nXiWa8wU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjUfY/l0yLMa7AC95g1ndHaFVWDBLqKKLCTntYQF8mbxaVplRoJZGE1fIQ7SVEkfUgV9mqi4Z/nfy0yWw+0dcplNxnwz33pVIjFl8wVzQ3GFakp6opzr+6EaaFeQdnR1K4mTREfTO/GTIWuT789FWLWAfn41Mj/Hp0Bjl+BIgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fCM8RM5I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Uww+LWbbl4eZ48xodj5NJgb7h5u2SJd/UvvTCMKguyU=; b=fCM8RM5IgrU8ZVxe2OMu3a8IX3
	Av5Y1HepkZla3ttSK1+ne7mxoGkQwuDRlqCWPySZbxQQdriMEyUo1Aa0hQMB/KwdR+5RdijgRAybs
	fwmmHe5PmE24SzRAe5slIQkQKaGq6Kv6qHN/ocvhG7uR5e38OSQiCRDVOFti95ew0uDkh/i02gfuM
	IEp9JApERuaI9zw7P3mV1GxNh9o3YbDku/MYWqqCQPzoNLBJjr8HcivZg9I1jauO7t1oPJwuGKXlA
	3Aio0kE597UAQVUEpCGwP56eyDRUomuRYAGXsEdUwV+urN8wLngF3ZbXLwa5fXnffv5SCIvVq4vrz
	hxUdIiGQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHB2-000000020q0-0WZM;
	Mon, 14 Jul 2025 11:16:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: use a hash for looking up delegation
Date: Mon, 14 Jul 2025 13:16:27 +0200
Message-ID: <20250714111651.1565055-1-hch@lst.de>
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

Diffstat:
 fs/nfs/client.c           |   24 +++++++++--
 fs/nfs/delegation.c       |   99 ++++++++++++++++++++++++++--------------------
 fs/nfs/delegation.h       |    3 +
 include/linux/nfs_fs_sb.h |    3 +
 4 files changed, 82 insertions(+), 47 deletions(-)

