Return-Path: <linux-nfs+bounces-10422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D2A4CA6E
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7603A86CA
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8819923F271;
	Mon,  3 Mar 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7vjiK5Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF323ED72;
	Mon,  3 Mar 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022777; cv=none; b=Ohe7zpR0Io5Mz48/g9tFO4WuX54zzeKnJtptnuipk/8RnxpaVTsfiMasDvu4MeqRDV2kQpzA8oXGXxTM2lPBMaK2xMRD/uoC2vttVbma3W+cpaKloe4jSc3HvDwsx9D2UNk3zIZINSEv7OIklHWezR9TXhAYX0QncMegeNwclc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022777; c=relaxed/simple;
	bh=5ps/lRcV8mI+EOJr2ILZlLxZ6dG3Q0LGDfar6CNuxvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYiKtUZ3d4rfOD5uwEk8mgMwUrEX08P6sjk8oqBUn5yaNCYqXfVFjfUDKOlKJIYvbeWNL0XMoDQrlKclMCf3ShI24EYRhqr5kojHzXWh41Po2CTmxydDIuF+3hIqK58l14xVTcJdOc5td1xUJRi8f10tHG4lWNiBd3K96Rjgs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7vjiK5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36929C4CEE9;
	Mon,  3 Mar 2025 17:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022776;
	bh=5ps/lRcV8mI+EOJr2ILZlLxZ6dG3Q0LGDfar6CNuxvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K7vjiK5Q0F9Wc/vEbhtmSYUuPqgsP+zJ6yqKyb7Dfnq33OXVDJArCjdlc30at7EJz
	 VEyAn8ecFiMzfnJV2xNT8+mJuyd9yLJSSQs8pvopycZNRuhkUz4KiqNv6bOKDE+Eqm
	 FUBk64dbSheEfcdg2ZS4lpOPZdKFTGxjOPeivH3prgOjj1Emf7k7ouHorxyfoZWuuI
	 0LBelWdbpechROnNrqXtNeltNbesgAAXz8FxO4hLouhXWLL4lnc4l1kluzcVRHK6ao
	 7I95edxRrohzd9OHuGyAYOx7AgyLZ/x4lYOjFYycNFPdL/l0gWKj6NAR41lxsfmekn
	 j4xFL3q98vLEQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Mar 2025 12:26:00 -0500
Subject: [PATCH 2/5] nfsd: remove unneeded forward declaration of
 nfsd4_mark_cb_fault()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-nfsd-cleanup-v1-2-14068e8f59c5@kernel.org>
References: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
In-Reply-To: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=585; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5ps/lRcV8mI+EOJr2ILZlLxZ6dG3Q0LGDfar6CNuxvg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnxeY1aBmU10/MDzC9Tjl3rVg5+8MYHehwRU4bh
 I5CY8ZDR36JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8XmNQAKCRAADmhBGVaC
 FV41D/oDFim3x2p+rsL0MRYrb1vapxGhhs60e9v9AfZgYuWKAhKm/yED9tCFppA6e/Y5wWlxhTt
 hO8Q9lkEFhCPM+cjf2nWoXiE79Uut5LavqrPEldnDt/gEXxWWtETtV8If19McCR5LSf90I1Facy
 YZYSt2BAao6X9jX0t62BEOMQTCye6L9uw+vKyJR20di/blwmQhJU96YewtXOwZ7RmCjfnV19C2E
 rXuyGStvtetxKow6SWFQzwwhGWWEYyvl8sU4Gl7KG8Lu4Kc2wPtP9e6b5Jj+LZ7jUFQaDOtQUTd
 ne1X6lpZu3EREIZPKMa0bum4NcfZp5BEQe6UDLHeFX4+cixQkj/wqSKWQjR3DwZjmwCZBwg2Llq
 6eyRCyLA3WzbQCoDSA39kukd/fdNB9Q/WT3xZCduzNdsLY41QNLC+mmvWaxOT+4txcW4QUpJpvJ
 kMuqdfZR/xKt+70Om7qEHPf0P/HKgL17aym814vKfURFrJ3Raaer0vb5kYPlBiSGcslhV5/Ujlv
 3b2XM+To/AQteIXy7xprPjr81Yyzsqp0Vu/FIwYU9LC0yryAX/kH5YUj+T25aDxgZDkSt6OLQDa
 ghUs9tyeWti/pcuYta5oOX57pQrh+6iwcxxzlrP6d198eTA4WxMqZKYRo8eKcCFWZCqcsfaKOyN
 zK299LcvdAYO9Iw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This isn't needed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index ab81774bf1d2766272e610f5d081f7c04d9b5933..ccb00aa93be01961fb182eb05470a7bd8e642256 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -46,8 +46,6 @@
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
-static void nfsd4_mark_cb_fault(struct nfs4_client *clp);
-
 #define NFSPROC4_CB_NULL 0
 #define NFSPROC4_CB_COMPOUND 1
 

-- 
2.48.1


