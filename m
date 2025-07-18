Return-Path: <linux-nfs+bounces-13146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B307EB09D86
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EC816FAE3
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73034145346;
	Fri, 18 Jul 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yAtRqI8z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8B1F8AC5
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826515; cv=none; b=ToilRFIXT+9bLkzr/Q2azrEz48i+HQnD36U0iUtggzQ/IwdohvFB3AU4YFRgSkAOiXiD1EkOmwBsE8bSKJOOV5Y27ZkU3eWUqeElnDdYg7QoRAqtXFakI2Anqsgr0zlJ7Vl742aWC0DkbM6l5yOIbhP5hrBc6ztbFjRuSRFIERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826515; c=relaxed/simple;
	bh=o3YULVY7CqhCA5/Go9SZzGQ3z55o97Wuy5fLDcyYnJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYzQCkUInICPo76aFnP5mP37LmK7cT1iktVUGIvCpWVS984+SmY88QNB/mXbzIUA785Cjl/2OnJ407CI1dXIOwG12Yp4eBTHxry/bS4Wgzt5UOXKWpPQy2XRH+YMmQH1sTMQ5VTyM6Y7b3FSusE6Rmo8Zo5SZ7vYOCW3dFurTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yAtRqI8z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1i8UEnLt36b6ZqCe5eL9sAc9XO2ALEnxVU+/LKn98Vw=; b=yAtRqI8zV5PlfdouExuDJcjNSR
	We4BLrYRUblzz7a6dJxDvbgc9A3i1hS53y3Uy32qQYpAPd6jCKrLWvNUIjnQBGELtgQqtCbsYIl8w
	P2tNM95+h/wEYqU/4nrB0fmtHlKcXilCzBjsQdTPLxUa0uUcvCY7X6oEtqZsSDVI/oz8HAJV6kPa2
	ybcWXJt008Oc/KWafa/msr8I+TYLR0LLikIThRQKai+e12wpbM15cHHp1JVuSWcguVQxmZ6M76aOy
	9YPSJB2JkR33VDTT/SNBKLzRN5Gzs/JU3i5lZwKeMUpu1U1FHViWVxef47XsQq1RqItxPhkDlS7Oe
	cEgNQWOA==;
Received: from [2001:4bb8:2dd:a44:6557:72e7:fc8:56bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucgFM-0000000Bzru-33vS;
	Fri, 18 Jul 2025 08:15:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: use a hash for looking up delegation v3
Date: Fri, 18 Jul 2025 10:14:45 +0200
Message-ID: <20250718081509.2607553-1-hch@lst.de>
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

Changes since v2:
 - keep the hash allocation for cloning inside the nfsv4 module

Changes since v1:
 - only allocate the delegation hash for v4 mounts

Diffstat:
 fs/nfs/client.c           |    1 
 fs/nfs/delegation.c       |  110 ++++++++++++++++++++++++++++------------------
 fs/nfs/delegation.h       |    3 +
 fs/nfs/nfs4client.c       |   14 +++--
 fs/nfs/nfs4proc.c         |   22 ++++++++-
 include/linux/nfs_fs_sb.h |    3 +
 6 files changed, 106 insertions(+), 47 deletions(-)

