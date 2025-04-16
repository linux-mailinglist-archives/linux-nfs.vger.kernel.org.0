Return-Path: <linux-nfs+bounces-11147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9D0A907C0
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 17:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC423163249
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96200210184;
	Wed, 16 Apr 2025 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nylwrd3F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018C20FA9D
	for <linux-nfs@vger.kernel.org>; Wed, 16 Apr 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817338; cv=none; b=TIDtgqMaTwlLApJb1jXCvWY/horCrfLItsBWWKK4TgfhoYktTWy7m++BGixIu6E9p7n48Phx6Z4Rkcf8BWb+S/Y+k8aPyA+hZPX5ElZS5mo4HLnOQzICHzWfW/VpgJMKkaZ1sn1S+YLsIadRI3xnDKDvmyuxEmidKEK7H1EiIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817338; c=relaxed/simple;
	bh=a7c24YskoRhrOlXLdcYdq2jSomg4IxSlDhQRW3N0SfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHhwX4C68FUPEZT9HIc3GHCkA3dT7szyfUO4aI44p1vjYFkKU6WsxpMsEkiui8cnnJ45Pkrtvwt1I4iv9JGdC3+ylHwwcdNcVIBs1gVCymXsFtrJ7XjVn2dPKrFxYMDhqHHsor2ECeaUMpAq991/+AUotN6hZthKo0AzfEacl2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nylwrd3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6B5C4CEE4;
	Wed, 16 Apr 2025 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744817337;
	bh=a7c24YskoRhrOlXLdcYdq2jSomg4IxSlDhQRW3N0SfU=;
	h=From:To:Cc:Subject:Date:From;
	b=nylwrd3FkiZiR+BM4JkQFpZU906nWB1/mhMANhmSIPNvwTYwX1gpva1E4rIUAeLDl
	 bGtNdCNzkkAd/Tr8pdf3G+aTXYRAWi8CSOg+sj4NHNkghis1L9ReztZJen3fXzo69w
	 9L/XQwR5sHJGMLbRLrkoKRh44BI0J3w5QNW05xCN2YJUAPPnOQ9GqS6rQzk0nCrlnm
	 9uqVlo9UJoBFIueQ7//opt3npWKyI+7JfhveJ3E9oQFJ2LhCjq5+YCYQ02jvhFMxFF
	 olUvOpPtnGl2ZMJy90qYn0YfpWtcWAzJqA6CnsrVKZBe/IzTpCuCfLFOhvNrywsl1y
	 13VIuQQ6dJ57w==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/2] Move rq_vec[] and rq_bvec[] out of svc_rqst
Date: Wed, 16 Apr 2025 11:28:52 -0400
Message-ID: <20250416152854.15269-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In order to make RPCSVC_MAXPAYLOAD larger (or variable in size), we
need to do something clever with the payload arrays embedded in
struct svc_rqst. Here's one way of dealing with two of them.

My preference is to keep these arrays allocated all the time because
allocating them on demand increases the risk of a memory allocation
failure during a large I/O. This is a quick-and-dirty approach that
might be replaced once NFSD is converted to use large folios.

The downside of this design choice is that it pins a few pages per
NFSD thread (and that's the current situation already). But note
that because RPCSVC_MAXPAGES is 259, each array is just over a page
in size, making the allocation waste quite a bit of memory beyond
the end of the array due to power-of-2 allocator round up. This gets
worse as the MAXPAGES value is doubled or quadrupled.

I plan to look at rq_pages[] next.

Chuck Lever (2):
  sunrpc: Replace the rq_bvec array with dynamically-allocated memory
  sunrpc: Replace the rq_vec array with dynamically-allocated memory

 fs/nfsd/nfs4proc.c         |  2 +-
 fs/nfsd/vfs.c              |  2 +-
 include/linux/sunrpc/svc.h |  4 ++--
 net/sunrpc/svc.c           | 14 +++++++++++++-
 net/sunrpc/svcsock.c       |  7 +++----
 5 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.49.0


