Return-Path: <linux-nfs+bounces-15157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A796BD0841
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 19:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40BB14E69CD
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87052ECD14;
	Sun, 12 Oct 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVRcffvC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121F2594BD
	for <linux-nfs@vger.kernel.org>; Sun, 12 Oct 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288870; cv=none; b=sbQ1Tcp8XAoAugdisntNFAXQLiWPCCq6pFSpNDU/McTunPH0zms6q3b2CywfQgJkrBfBh+R8z7qFOExCIgVb3lNVNU0+BfBV0o9Kk8X+PP+SoBvzXgRBh6yTTK5SW66dAKYuv1WuXca+rNb2lmF3hrNpzX46z73SY92hcqlUaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288870; c=relaxed/simple;
	bh=/JRwex5wgWDo2FlVwvsd8xBhlg8sSRfx9QuzhAkeFZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te4olVIXp3CII6/QKxqxIPMBcXPWoWvN+FALe21BmwCAEwCDpM3BS1aZbBAxOaxSJE0/ctuDpJ21cLS3ROj0RiyhB0ZPYfve68j3Iwp+7AmTpowAdo0IeDzpnX2d6LjPY2eLv/gcdoueryvHxcd3+r0Bm3eWc85VpjO/ko/JNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVRcffvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F6CC4CEF8;
	Sun, 12 Oct 2025 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760288870;
	bh=/JRwex5wgWDo2FlVwvsd8xBhlg8sSRfx9QuzhAkeFZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVRcffvCuB/6y8C27jshaFdz2UnUmw1fVa2lTg0yfkL+lv6U6pgzcdHMOee1ve6lp
	 Flx0pClQRgwSvgGTS9+KKMfi8BQjr6w1Y8Erm9MzPAiixvgfdB1jvExAOorG9jnayk
	 JLifB0v9f6eutaiHxRhU+iv3AY1S0r2pH+1TfWTqlmcuRwSXq62XITqzJuQhXKyfKG
	 9LeO2sdf8iqEBn2yYt2AB7fhBrxXgQ7ciJVmdZXZy22YJs9mtqx0TO7QPh6qr8z0nG
	 K3XF3YLgQtfZPSvMt5W+0z0cfHryby/yBhoqz7d5F7sPRdq95vv2d9LHR1+a0rGsXc
	 jdSmvlpcGcA5A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v4 1/4] NFSD: Skip close replay processing if XDR encoding fails
Date: Sun, 12 Oct 2025 13:07:43 -0400
Message-ID: <20251012170746.9381-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012170746.9381-1-cel@kernel.org>
References: <20251012170746.9381-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The close replay logic added by commit 9411b1d4c7df ("nfsd4: cleanup
handling of nfsv4.0 closed stateid's") cannot be done if encoding
failed due to a short send buffer; there's no guarantee that the
operation encoder has actually encoded the data that is being copied
to the replay cache.

Reported-by: <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/c3628d57-94ae-48cf-8c9e-49087a28cec9@oracle.com/T/#t
Fixes: 9411b1d4c7df ("nfsd4: cleanup handling of nfsv4.0 closed stateid's")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


