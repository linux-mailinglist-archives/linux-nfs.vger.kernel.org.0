Return-Path: <linux-nfs+bounces-15592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9E2C06C14
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C813B3C10
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0CB31C58E;
	Fri, 24 Oct 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2KqgEFQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6531B823
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316996; cv=none; b=ZOssMuXRmvb/M5uqxOkG3gCxU4jH8bAgYvNp6bF+og98+p9c11vEuHKabjULr/szmIiLQfs7B0VZoBnZUXDcGfz1+bvaAsrQFyE80mItTl6aCDmSyBT+KAJINi3NdkfslZbp8YHcHjhj4vFaNSlGYBrtYlsT8Q+092j2TxtyoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316996; c=relaxed/simple;
	bh=csC0DDYfVUi6q+ZU1n0urF1q6sXZZ+KzS0pbP9KoUm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS4AYnpGEXu5/+p34E2w4Ob87UvTNFeqQorbEusAuZXvbv10IQKI5X3Ku3HQJ19i7JOXodOlrIMQQKiGQsS0f7G1vs6s+hUNHh1eWkCvHmVtvnQ6nxovhAVusvUj1b86f33JP2leGcHFi/S4AczJG911CSI5YL1c8L0JaxESbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2KqgEFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F2DC4CEF1;
	Fri, 24 Oct 2025 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316996;
	bh=csC0DDYfVUi6q+ZU1n0urF1q6sXZZ+KzS0pbP9KoUm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2KqgEFQ5ILchjJI7KApiNN14Qz173IgMshCVJhnz5pPBq+zg+LlVDOvEPDhnjgmB
	 HPgW7eUJ4NGtUs/LV0Rz3PAgzdaF9ZLNktRZEa699Flo5hno0X6N6dFETNt68OI/qO
	 RAZ1F6XU9UDrJhvGUeOIhp1kvcOIj64TKRUDUKqeyw4HEUB4GjtAaDi9JZO07L2sqJ
	 AZ4LZgyb6iLMmcR0VvuO7dewssys/eTAj30sMEhAkVryXSJeDCmb5NeKT/Ju6+Bj49
	 3BjF0n7YAXBokcgd2QpxLqLw/bu8sbqrXxXfEWOeo7F3LwPGak/rYyLdaXq0XuuyCh
	 htayh4khnOJuw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v7 09/14] NFSD: Remove the len_mask check
Date: Fri, 24 Oct 2025 10:43:01 -0400
Message-ID: <20251024144306.35652-10-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024144306.35652-1-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Mike says:
> > Hey Mike, I'm trying to understand when nfsd_is_write_dio_possible()
> > would return true but nfsd_iov_iter_aligned_bvec() on the middle segment
> > would return false.
>
> It is always due to memory alignment (addr_mask check), never due to
> logical alignment (len_mask check).
>
> So we could remove the len_mask arg and the 'if (size & len_mask)'
> check from nfsd_iov_iter_aligned_bvec

Suggested-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 465d4d091f3d..f6810630bb65 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1285,15 +1285,12 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
 }
 
 static bool
-nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
-			   unsigned int len_mask)
+nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask)
 {
 	const struct bio_vec *bvec = i->bvec;
 	size_t skip = i->iov_offset;
 	size_t size = i->count;
 
-	if (size & len_mask)
-		return false;
 	do {
 		size_t len = bvec->bv_len;
 
-- 
2.51.0


