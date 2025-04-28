Return-Path: <linux-nfs+bounces-11334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26089A9FA7F
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 22:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9636D4663AB
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0EA1DEFE9;
	Mon, 28 Apr 2025 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IveTORDH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF11B3937;
	Mon, 28 Apr 2025 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871882; cv=none; b=SEboNuGSeTcUJ+6oSymfy/a5mCz6IT7US8oxM5Wwm5OfcpBp4KsluL51Ve5NPwrzDjlJxu/ty2MkFQLF7W0SWeM/xrAx7mqGPTbGx/zbFqWgW4I19wbNZe+2kLPeQD81pu0UNll+TYlE3Me76FYgse7Oemfye2rIkrh+hIQK1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871882; c=relaxed/simple;
	bh=xptNENGGtclKBVRuB92L5LlI26MH8Q/AAe6oNcqgf3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VsO+GHL/EHyUlEO3RK5yZ+n+y9GwFEk9c7uLDh1FuOs8Za9lzq5P3RXlI6LVAnxmyeKOqEgljfCugLwknxLcN+0HsZQXzKWwtyqadDlO1nTW3cpenww2/wMlKDFtUgIwnCTpha94XWx6F1K6XfNCeX19sm6vBpWSsOVGYeDABmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IveTORDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44BBC4CEEE;
	Mon, 28 Apr 2025 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745871881;
	bh=xptNENGGtclKBVRuB92L5LlI26MH8Q/AAe6oNcqgf3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IveTORDHv/soZjIb7NsUu1IJ1AarcVDSPlFJnLlmJuXqL5NqCc5LlszMhktDslPsh
	 32WtKYRGJO8b1KKQ7kKsXbGRl57GtdIzaem9FW7af3mpu0RlfpM+av1i5Bu+0zmF1r
	 t/MZeTxOmcO2WeICpdjnVhlfxCnXPjtfsEoYj5EtXLmbLyqMsIYRDwnBjLud+M9GfL
	 ChxjA4MRamcoi+PxoQikM6+WFlq1b9zXav3CVP17Vt32yWJ3xkXxu3QIE2Fl9XR7cT
	 yEiQGzR41vmwX2c3VI9hPSOxHfVUnKFQHbFcE4SHPTgu/dH5sjHChPLhPm/Jvi2UZ3
	 kAe6GIHjOOKcg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 28 Apr 2025 13:24:38 -0700
Subject: [PATCH RFC 1/2] nfs: free leftover lsegs before freeing a layout
 in pnfs_put_layout_hdr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-nfs-6-16-v1-1-2d45b80facef@kernel.org>
References: <20250428-nfs-6-16-v1-0-2d45b80facef@kernel.org>
In-Reply-To: <20250428-nfs-6-16-v1-0-2d45b80facef@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Chris Mason <clm@fb.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xptNENGGtclKBVRuB92L5LlI26MH8Q/AAe6oNcqgf3E=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoD+QII4ZFNWmKKwPdRPKRSZZXHX7yILZQOXAHB
 tGVvTTBi/2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaA/kCAAKCRAADmhBGVaC
 FfysEACjaNN2BHkxxsIgTT4ioaEHV5Vdcyldc8toITSF+zJVNGq54s/tgiZfBgMIKNRiUiCUxlp
 P9IAdoG8UZ0hba7Y4sYoWVNF2zFfE3nIB1P9x234NCpZnx7OB0wtm79ONVp436q5/ZWON4p07J9
 R2f3cy8a9I+g/FtElBWOstKld4uuR0te/L3HZQs7fsbNA3zI/q8kGKVFGfVXDHLYJMGdS7boJdo
 atyd2nvsS3Wg35Dv9/MmtF28xFKLeIiywsey+HiosqO2bpSQLdcLIdg9p5Glysx1UdpkjyxFpFi
 MRKgJ/BdaR2KXStPBW59T2TIXmWoK9Ccs7dxeiASxFCNDMY10/6tqUtlZuYeinUE9RvkdmDd6VT
 aF5Il3aPyuqePs9hhJdhq6ADCsxZ9maczt/+muE6QVBWnWpN4Jkn7rTrCwTMkHw8m/FVI60Bou6
 q8on2YReYiyV8u9rl0214ssSErL/s8Fylpw1PGd4s3b2RrpS3GD3GG5dAnhsrq0MxrM+S7SBkEP
 XIBZVFm8AbbpypVuOW0Rq//bYTI0z7ohG6y4yokth7RNal+gzwk+BuU97FhkQUTrjFCepmf6c8b
 55ZPNDTa2UGpFbekx3gHPFeiI4igW1uc2xGtl6kVDu1qhj1ZWKu3Pk0U2y+I5UfExRH7skVc2hI
 5oFR6yYS3/B0pkg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Entries on the plh_return_segs list have already had their refcount go
to zero, and are only hanging around so that a LAYOUTRETURN can be
issued.

If there are still leftover lsegs on the plh_return_segs list when the
last pnfs_layout_hdr reference is put, then that means that the
layoutreturn just before the final refcount_dec_and_lock() has failed,
or that new lsegs have somehow raced onto plh_return_segs.

In either case, nothing else will be aware of the entries on that list,
since there are no more outstanding references. On the last
pnfs_layout_put(), do a final call to pnfs_mark_layout_stateid_invalid()
to shuffle any leftover segments to a tmp_list. Then free that list
after dropping the i_lock.

Reported-by: Omar Sandoval <osandov@osandov.com>
Closes: https://lore.kernel.org/linux-nfs/Z_ArpQC_vREh_hEA@telecaster/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/pnfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 5f582713bf05eb72eb34b2e2c06d1edcd3c258d3..0bcb5a4bd420c157069ee63457518b206223b7cb 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -307,6 +307,7 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 {
 	struct inode *inode;
 	unsigned long i_state;
+	LIST_HEAD(tmp_list);
 
 	if (!lo)
 		return;
@@ -316,9 +317,11 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 	if (refcount_dec_and_lock(&lo->plh_refcount, &inode->i_lock)) {
 		if (!list_empty(&lo->plh_segs))
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
+		pnfs_mark_layout_stateid_invalid(lo, &tmp_list);
 		pnfs_detach_layout_hdr(lo);
 		i_state = inode->i_state;
 		spin_unlock(&inode->i_lock);
+		pnfs_free_lseg_list(&tmp_list);
 		pnfs_free_layout_hdr(lo);
 		/* Notify pnfs_destroy_layout_final() that we're done */
 		if (i_state & (I_FREEING | I_CLEAR))

-- 
2.49.0


