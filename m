Return-Path: <linux-nfs+bounces-12932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C84AFD017
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B84C1AA1D94
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216A214228;
	Tue,  8 Jul 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvJUYEaV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0E2E4269
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990802; cv=none; b=BUoUPpiZqit+IMWgnpr5g/NOagMkOk9COGPPdrj5ElNJXkH1TcOJxRX/o6Rtz0tVk6YbqbkZ1nJu0kSayyjooFFLIpn3bl8U/pk2jhUtdvzw6w6wozpLyaiVeRRCHlMsSXlPm5+lSmMvZYlHXorMUdASq2Fi4cBYYGLLiwDohlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990802; c=relaxed/simple;
	bh=ahmzE36HYW6wJVfPUoS5kJGyl6LNnaJZf5Oe4hRtmpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB2S4uD83evSAelafX1eBGORjuDRKefXgASG2pLXdgrgtkx4jk8piGFI3aNzTOM2D+7dplPHfhbVt6L0n7qwDUV5PMkzVIAaBvu/EST3xmNKwUQ+ZsmyXHhPm7KVAhutg8XYEM+qej9NJuOTEUJ+ySSzlkbfwXMMtj9HAvpk07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvJUYEaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7D3C4CEED;
	Tue,  8 Jul 2025 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990802;
	bh=ahmzE36HYW6wJVfPUoS5kJGyl6LNnaJZf5Oe4hRtmpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvJUYEaVTBtC3midjXAv6de8jxlYoSBLAsxvDzFM9LyC5vXh2Ossq9AotcBim3T1R
	 xvZaP/hfpJK7MGP5m1w88MSxXjA88XQYURUYOhAFBgEODq5GolpxJ3owQ8RRySwHin
	 +mZK290kfRFPeH0hFwfZqV6tKIdNhGDn4GOpUsl4JKSlY90olO1/tkK4DZn7Uq7GHt
	 tPVGt8xNPsAwmVZpfZnyVO3ElggIm/YbGQYNGKdIJhy5I0E4/RJgaK9sFJiJY7BnQc
	 VjjL3avdCMlWkkfn1PUy0DmHhpddgJTJ4tlEQZLcdpQtDfMpuKcYbfM7oT9iiI4RKD
	 PWxA7Nefr4nKw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	snitzer@kernel.org
Subject: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length checking in iov_iter_aligned_bvec
Date: Tue,  8 Jul 2025 12:06:15 -0400
Message-ID: <20250708160619.64800-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250708160619.64800-1-snitzer@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iov_iter_aligned_bvec() is strictly checking alignment of each element
of the bvec to arrive at whether the bvec is aligned relative to
dma_alignment and on-disk alignment.  Checking each element
individually results in disallowing a bvec that in aggregate is
perfectly aligned relative to the provided @len_mask.

Relax the on-disk alignment checking such that it is done on the full
extent described by the bvec but still do piecewise checking of the
dma_alignment for each bvec's bv_offset.

This allows for NFS's WRITE payload to be issued using O_DIRECT as
long as the bvec created with xdr_buf_to_bvec() is composed of pages
that respect the underlying device's dma_alignment (@addr_mask) and
the overall contiguous on-disk extent is aligned relative to the
logical_block_size (@len_mask).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 lib/iov_iter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index bdb37d572e97..b2ae482b8a1d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -819,13 +819,14 @@ static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
 	unsigned skip = i->iov_offset;
 	size_t size = i->count;
 
+	if (size & len_mask)
+		return false;
+
 	do {
 		size_t len = bvec->bv_len;
 
 		if (len > size)
 			len = size;
-		if (len & len_mask)
-			return false;
 		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
 			return false;
 
-- 
2.44.0


