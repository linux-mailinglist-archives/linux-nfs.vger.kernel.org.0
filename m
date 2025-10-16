Return-Path: <linux-nfs+bounces-15288-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747BBBE3CC9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339125E0099
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE72E2EE5;
	Thu, 16 Oct 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3u9O4nJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA9442C
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622601; cv=none; b=CnH0mRO3/Oky+syl5zk+3dS0pnkWE7ZAHER6+lkHiPhr3YciZl4Th+UsBkBCdzpJTAB7/ODdiZpotY8WX6Fy6Iakk7XpaWHqjnRGSjXtQjlW7ZLGbWc6iWU2IAJptlfZk/d5yqLlKx38/cR8OoVdSIT4FM5ryl99y0DPrLXGYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622601; c=relaxed/simple;
	bh=BQQrO1+SUf2erEDj/EgWLKKfj3H5Az7bZetjqymvvhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TucB9MeSfbw9rQW3GPIXZb8BC56nDQG+fvigX2eWnqrm3b1xbr73BFWKFx9RNdCdh+qCdfLMCALalF6lB0A5j+DVptDraolPrImZfT3pFUTHiU8CcfBb3OWu+FRQE9vwgoTeKLWz7vU15m4Y5oRNU2l9FS9baJCaXpxC9xtInww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3u9O4nJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE19C4CEF1;
	Thu, 16 Oct 2025 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622601;
	bh=BQQrO1+SUf2erEDj/EgWLKKfj3H5Az7bZetjqymvvhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3u9O4nJGmeN2Pa6fhzOk2dUNpFk24OCpOeNRMoONhZ3jheG4Q/hBkVZ2VaWs7zQr
	 bLwia806lXik6Lux0FuaF89n4a2haNPyzGTy4XVH4VzT+hF6zXi/Iz+Y01NVCLizT9
	 iuFG+zJuyhIrn5TtQqsybLHDioeZhcwK/+bE98vSw7i52164PsHfGSMHQxL6p52MvS
	 rh3LAltvtToFJaAT583H+YZvCMcmevkIc+/nJBFkMNr5dpUfZBen1AHK2nnKBifnvY
	 ll3rPxpCO1rfneoI4M413Uc+MmlNKw2buqlpIWh4WDdoM6VAdMN+BH5KtP+SF1SB01
	 e1K30LSoUjPpQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v5 1/4] NFSD: Skip close replay processing if XDR encoding fails
Date: Thu, 16 Oct 2025 09:49:55 -0400
Message-ID: <20251016134958.14050-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016134958.14050-1-cel@kernel.org>
References: <20251016134958.14050-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The replay logic added by commit 9411b1d4c7df ("nfsd4: cleanup
handling of nfsv4.0 closed stateid's") cannot be done if encoding
failed due to a short send buffer; there's no guarantee that the
operation encoder has actually encoded the data that is being copied
to the replay cache.

Reported-by: <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/c3628d57-94ae-48cf-8c9e-49087a28cec9@oracle.com/T/#t
Fixes: 9411b1d4c7df ("nfsd4: cleanup handling of nfsv4.0 closed stateid's")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 230bf53e39f7..85b773a65670 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5937,8 +5937,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 		 */
 		warn_on_nonidempotent_op(op);
 		xdr_truncate_encode(xdr, op_status_offset + XDR_UNIT);
-	}
-	if (so) {
+	} else if (so) {
 		int len = xdr->buf->len - (op_status_offset + XDR_UNIT);
 
 		so->so_replay.rp_status = op->status;
-- 
2.51.0


