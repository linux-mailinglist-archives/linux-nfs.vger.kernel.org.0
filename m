Return-Path: <linux-nfs+bounces-11562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359D8AADDD3
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385FD3A83C9
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99729257AF5;
	Wed,  7 May 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m3tuZIU5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB09221F13
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618988; cv=none; b=F+YCsyY5r8C+CEH/YCJ4GPIlO+WJLAmugWKaQGitw73Lf0lHa7kN2GRs0urqzbxCTwiQklADmWOQvPs197s/3t8li2l3sCLsFGLFIw+WuHDWsE7DDPgSMlL4WFpxd+e1XeFWZJc7MCiv/aoqU1n6EiWlYD0/kxugx2wmMTKSWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618988; c=relaxed/simple;
	bh=N4tCWRpDeB3jzqfM7DvdSbzG0Jl6dXu9+EVXkXNETYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xnb9FPOJA/6A6DhjctxPFEQYkqbo6GvzwND48zZ7Dfn2YH8RJNN19k1Q6KBgduRL9U0HBYhyQ8hb1mtTtRCpC+BDlr//XW8Jd2TiFFCxubQVr9iykytigNyvsSbIHq5zLRTZmYlbShezesyqXCCFkMjZl+oovLZA1MaQ8jvKCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m3tuZIU5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=j8SJLlNkcTb7bA2zHk9hOuqpWhHc770mAORCYl5oWWo=; b=m3tuZIU5vWvr7n1iNbIs4Y3C7f
	9NhNyRmlMih0nZvvP5LRHlgRLGR6t9SU121heNbnl+lKxhJbjoD6RbXovhYOCf7l87VbC6qFkW8kq
	FgQ42qvpNwX/aZSBineWSdh/Mtt25cRYAUQi1L+4ve6wHx4jR7HVDS4niAeI0cUQORyxRdpxralUU
	0DgKv5ZykE750a+Zvat1utXtM6xNpYEeTwDMsMRl76zY+2Dv9OqZWsqSwwScGA8ZV0X6WhSdCdi6z
	m1fTUduzzh2LbFBLR4KPjsPDDrzPw0FhpPHXg0fIZZQ47jysNovlAuFcdqNSkptwK2O+FSKSnQhc5
	xOzPcLfg==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdNt-0000000FHmn-2wKb;
	Wed, 07 May 2025 11:56:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: remove rq_vec
Date: Wed,  7 May 2025 13:55:49 +0200
Message-ID: <20250507115617.3995150-1-hch@lst.de>
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

this series remove the rq_vec field from the svc_rqst structure and
always uses the bvec array for VFS operations.

It doesn't integrate the bvec arrays used by the socket transport and
those of the VFS layer in nfsd yet, but it is a step toward that.

Diffstat:
 fs/nfsd/nfs3proc.c         |    5 ----
 fs/nfsd/nfs4proc.c         |    7 ------
 fs/nfsd/nfsproc.c          |    7 +-----
 fs/nfsd/vfs.c              |   49 ++++++++++++++++++++++++++++-----------------
 fs/nfsd/vfs.h              |    4 +--
 include/linux/sunrpc/svc.h |    3 --
 net/sunrpc/svc.c           |   40 ------------------------------------
 7 files changed, 37 insertions(+), 78 deletions(-)

