Return-Path: <linux-nfs+bounces-15697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF772C0F225
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AB6425097
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB053191BF;
	Mon, 27 Oct 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiBGmPTv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757E3148A5
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579999; cv=none; b=Qn+vf0prELn9TKV1m8foGyiXp+cVcL12W1vtpKl6oNVwagl7WZj5wkc0cul/YbX8uTJAl4hV5JeR6mLNq6zaFvOgPIhSCzXdsYH1nzyvrSJHUXzzgPdAF35BvysdR4IVguVmCm+F7DbWQ8je+iTJJ3wp4QCOMC17IwY6qAWcz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579999; c=relaxed/simple;
	bh=0BGOG3vt9rZrmia7TsZrcMkXBa/idQS9ZzIQkuAd6Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9w+17CZyltoQ2q+9NvazuoMh5Atr9UoAZXcClG/VunsnTAkFW6lcq8SfcNz5q0tb8gYfViCawp5yXFYvhrDi4Grvmu65lmLHL85dEgKj4xcDYQpr+vdutAm9WurTIyic1GRJf1dz63nmNEZb/IBQWpcj/NOl1mUgNAySjfLJn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiBGmPTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9693C4CEF1;
	Mon, 27 Oct 2025 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761579998;
	bh=0BGOG3vt9rZrmia7TsZrcMkXBa/idQS9ZzIQkuAd6Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IiBGmPTv2KV6SkJgVFBXGFSWWz/lajq50Vd6AOaCUqdGj/nbves5qhpbqvFYbsieh
	 TZzOrN1ekcVu5H1MmOmEWLTEE3m0PF5SbpNMdkfo/Dk/0k4y1Bp8dcf5TZ/IE2Uyv6
	 WelCjcNriijR0lN9RpW0HDoQ/Tl0VQ19y6TjGGJj/mfhWoP/Zxw8P5qajEidZ6sh4l
	 QnbLDUA9pSGPejZ+CGWpHbX5SkFzyY6UFSbhOt9yMv1LUaeaTfQwmXPi2BzJlyWyWJ
	 ykX7RdBjmaBQVzSdL8uc73jq85vLgTVPYsEsRSIShkhQkb+F23UefXSmELV0Y5Ia99
	 f/+F2m2nzKSvA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v8 05/12] NFSD: Remove alignment size checking
Date: Mon, 27 Oct 2025 11:46:23 -0400
Message-ID: <20251027154630.1774-6-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027154630.1774-1-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Noted that the NFS client's LOCALIO code still retains this check.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 30094d8f489e..80bc105eb0b6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1269,8 +1269,6 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
 
 	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
 		return false;
-	if (unlikely(dio_blocksize > PAGE_SIZE))
-		return false;
 	if (unlikely(len < dio_blocksize))
 		return false;
 
-- 
2.51.0


