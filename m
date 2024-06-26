Return-Path: <linux-nfs+bounces-4348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539BE918E76
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7616B223A3
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD54919068D;
	Wed, 26 Jun 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0+wl2me"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E4F190670;
	Wed, 26 Jun 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426488; cv=none; b=p9oZz30H0GrLsP7VUU0itZQdxAp1JKKPFPvfpj7/dWF2lBqL5A+EC4FMibaJ7Lw3ITbM2jY+mLOCILrW579JQ/MszeRgHlRRmO+jpzJhVVDiOmB9blMK5biaFxMU6d8wFwDWHD9mT+5dBMyTcoviRXj6smk67tGsL4Mki5mHSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426488; c=relaxed/simple;
	bh=75dKJKIcfqVCCpuSxkTGFgX7Iozwogg8rV3YwmWJHAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyyJLuXLZstCW00fM4dRu5QjDRVzZmvwg2eQ/U9rfbyWhU4loEZfBW4MpL/rMhCrPrKNkoBMtcgiCGa2hfuWvnLspxmts97L5Nm+BVMpyFN5iKUCGXu89xtB/LxQ6MdNfBslDUS7EgbZJMQo/NaEqrqcpWGiE40uYUk9tqICI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0+wl2me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1D7C4AF07;
	Wed, 26 Jun 2024 18:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426488;
	bh=75dKJKIcfqVCCpuSxkTGFgX7Iozwogg8rV3YwmWJHAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0+wl2meRTcMRhseuzuzrZBhICDE271fPETk6UD3RWLETmFNK9kepoOh//vL/F5No
	 BTHy9v3ub+Mno67cJDIw6oIWRbnHlZsXbLciPBJq735d/4iO5zYSF0mj0AH3lRr1k/
	 x62dhnkf84GeFEj2njwbnTs6broIBVWdWKT+9NsPKGdZdMLtECG/+0yaGwwJOf7siy
	 igJUO00MSf38kblDJoigrjpCg9ov9Tfjk/oTlWlqbNiiAcfrokQeCj+57Lk1g1UoZ9
	 Zgvnt2WIGj0e3Fy/wD3Cpp1YMJPa6OUmJ19Jhljhi3fyIK1e1arblcBeXjj2I8R9hq
	 t6v6DlgX6QdnA==
From: cel@kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<stable@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10 4/5] SUNRPC: Fix svcxdr_init_encode's buflen calculation
Date: Wed, 26 Jun 2024 14:27:44 -0400
Message-ID: <20240626182745.288665-5-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240626182745.288665-1-cel@kernel.org>
References: <20240626182745.288665-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 1242a87da0d8cd2a428e96ca68e7ea899b0f4624 ]

Commit 2825a7f90753 ("nfsd4: allow encoding across page boundaries")
added an explicit computation of the remaining length in the rq_res
XDR buffer.

The computation appears to suffer from an "off-by-one" bug. Because
buflen is too large by one page, XDR encoding can run off the end of
the send buffer by eventually trying to use the struct page address
in rq_page_end, which always contains NULL.

Fixes: bddfdbcddbe2 ("NFSD: Extract the svcxdr_init_encode() helper")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f0e09427070c..00303c636a89 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -579,7 +579,7 @@ static inline void svcxdr_init_encode(struct svc_rqst *rqstp)
 	xdr->end = resv->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
 	buf->len = resv->iov_len;
 	xdr->page_ptr = buf->pages - 1;
-	buf->buflen = PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages);
+	buf->buflen = PAGE_SIZE * (rqstp->rq_page_end - buf->pages);
 	buf->buflen -= rqstp->rq_auth_slack;
 	xdr->rqst = NULL;
 }
-- 
2.45.1


