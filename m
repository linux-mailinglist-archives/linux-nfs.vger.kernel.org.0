Return-Path: <linux-nfs+bounces-4460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA3691D768
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 07:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC87286904
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 05:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A5D2B9BF;
	Mon,  1 Jul 2024 05:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aMif3uK4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7796E1A269
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 05:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811632; cv=none; b=Dmi9YVmnmff1GlDSP3rYxIctlTxPOF52aa2xcWboz6LHsEzwTa038ymXDu9fCWft9zOWJzSu9FiR10hoisKRyTFCqtWc/GW8Jek2EpuCc77JkGmfDs7snJHO6/R6+TLRW2P8bHl7SsToqiFRQG6LUwf4C+sK6GQSok7u8HegHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811632; c=relaxed/simple;
	bh=mxCIUcDsefdQSYIEzHjBp5FHr6hrJ3mxLjaQZeZ0zAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyYS4kc7vk9Ch9JDcLolWwRW6y60lvXCgVU9fvObgUW6Lg9jAZ3cgf1/2ZsEBKmMBQGwqr3L38C5cGTTjFRNRfJ3TXRMcN2bgumIwZtpjKuZxJyFzdp7hazmRZouZSPKqpbc1dv8NUZeS1AjqmHIc+k38GmMPhF3f8MufpBZ0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aMif3uK4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ocoDJT0riVDkm1LXbTBXmmtP10v+j2ubU8thb/h3FsM=; b=aMif3uK4YehAYa/GV080HJn1Qy
	MIL5nYxc/092JtFnQJoz2cE87AM0R7yvog+MppxSGsh9+jUaMQMmWjU+8jxtD5yP4f/N3a5P45qML
	IqjOuDhfl98p/DGnxxeGIz4V3MaihoU1OHfLaqUgvAMf700qev0hG4vLMqO+X3YZOyY8Eh6Yzvtfr
	rpjyv8CUasEDhD7FLUAx/hN2VmZVt8VIJ94skmhusb7EGiM1BVP6zDAVNsRShRWi/YoFRtK70b7uf
	Ppmfc2aKy3tbeSSVqxl+v1aJIoD+0CZ1sf8i2br6awXH09cimPHe7NJmX1tPPmqQ1Y/7uLmI3Bv5a
	vVQBcILw==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9ZG-00000001kA7-1lkT;
	Mon, 01 Jul 2024 05:27:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: NFS buffered write cleanup
Date: Mon,  1 Jul 2024 07:26:47 +0200
Message-ID: <20240701052707.1246254-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series cleans up the nfs_page handling in the buffer write path.

The first patch was already sent independently but hasn't been picked up
and this included here again.

The last patch fixes a bug where a request could get incorrectly reused.
It would require the flexfiles layout and odd I/O timings, and without
a flexfiles server I can't actually hit it.  I'd appreciate a careful
review of that one.

The series is against Trond's testing branch.

Diffstat:
 fs/nfs/file.c                  |    6 
 fs/nfs/filelayout/filelayout.c |    1 
 fs/nfs/fscache.c               |    2 
 fs/nfs/internal.h              |    8 -
 fs/nfs/pagelist.c              |  117 ---------------
 fs/nfs/pnfs.h                  |   22 --
 fs/nfs/pnfs_nfs.c              |   47 ------
 fs/nfs/read.c                  |    2 
 fs/nfs/write.c                 |  316 ++++++++++++++++++-----------------------
 include/linux/nfs_page.h       |    7 
 10 files changed, 157 insertions(+), 371 deletions(-)

