Return-Path: <linux-nfs+bounces-88-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A427FA43D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889F31C20BB3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619E31A7F;
	Mon, 27 Nov 2023 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYktRpsQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526F31A79
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 15:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8A3C433C8;
	Mon, 27 Nov 2023 15:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701098309;
	bh=C2Ly/BA8U0gudLtdBTvQ4bMvrFcHNsue71WgvBOyVck=;
	h=From:Date:Subject:To:Cc:From;
	b=DYktRpsQOS/RdFQi4DbxGetgENG8stPwYmwppUoXsBYsRcTqkx4NUVwXIQYZAKQGX
	 a1VsQ4VnaSTodSLWkbTuewNwVbsnkTrUbHyCnEDC470yTZuXKG5yJzFq2DFQo9NoMg
	 jBETWt8aV1pB/x8qmd3Qim2Xnejil0qyPxxhU/EnArBsmUy/fsztn9NeF4+6SEb4Rf
	 wGVqkSnqv6Q9soLkVDyxj/sbl274PWVz4afAFXDPbhvu/TO3PV0TCmiHiAdTk772NA
	 vx5js6wXg1HB9qPvfWg2SwYsuocxjJXOwxN4MGvZH1wpsIT8ZkdmpfmeTtKYHBES5V
	 BQD0jZdzmW+EQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 27 Nov 2023 10:18:27 -0500
Subject: [PATCH] autoconf: don't build nfsdcltrack by default
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-master-v1-1-5786ec1c6d38@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEKzZGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQyNz3dzE4pLUIl3T1DTDZEPTlETLZBMloOKCotS0zAqwQdGxtbUA8Dn
 4U1gAAAA=
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=C2Ly/BA8U0gudLtdBTvQ4bMvrFcHNsue71WgvBOyVck=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlZLNFuse4YM86Qj8bSz4IU5Q3ihkPlH9mg5noI
 6wxE2wNDgSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZWSzRQAKCRAADmhBGVaC
 FVsKD/9r3ntXGotl3WK8HWYKJjxpKFxXHcRpyyQqiIyeuqzl5cNLcDQHu/2T4N0sW/Zfu+8xA/h
 AjyEXYHcb0bxXEOZAV+rvB6IrerMK47bD9G4x7H1yRdMSKJ1Kpfb0t6nCZShU5Hy9fMEl0pDZWJ
 wzHbapmwm3Oemg3+kmO1rBgwnMBlYtRHqc+XNBUkjttJvqnhROBXDPQQ187Qih6kXryo9yhBpzQ
 24a0/L5cyN/pvyIRZRYtltvdf55ti1CFvukaoTNoQi8Uw1CYku8COeSCl1w2iwke3zsjadQUubz
 uHW6MVIXhjeveMZI0w4yBicImzj4FGXv+3cwDFFpLSUC699Yoh29Sn4ZnKkr+ijdH3LNSWOUaN/
 bTyJ9yCX/6uCtAUF2cfoX1FfPCpo3Kb9Ju3rxOPz3BtyECEKLkjWix78ERvVgzcuT8e+fRqlKkG
 mStu9ImkzIZop2ucuVUL6mQHqb9X4CZSxRGRMyBPmoO56YgdtSq922d+kQ+C5OXcT3l2d77qbVp
 WsqUfj46Cybk/a3h9YAjg0pIRCByVCYflwGrS1/Ih73ZiOEP2dfyU14SsT8G4PmArh1aZHqGHF+
 eH10QudUli/TxlwCv3B7qeQJzgtV08HfQCj49ygrPD5jF/BP9vRQWIIiNe0JXqw5mB75fSdkBBw
 3UAw/s8LUeWRrwA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that we've started the process to remove legacy v4 client tracking
methods, let's stop building nfsdcltrack by default.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 93a1202807ea..62c833cc2409 100644
--- a/configure.ac
+++ b/configure.ac
@@ -248,9 +248,9 @@ AC_ARG_ENABLE(nfsrahead,
 	fi
 
 AC_ARG_ENABLE(nfsdcltrack,
-	[AS_HELP_STRING([--disable-nfsdcltrack],[disable NFSv4 clientid tracking programs @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-nfsdcltrack],[enable NFSv4 clientid tracking programs @<:@default=no@:>@])],
 	enable_nfsdcltrack=$enableval,
-	enable_nfsdcltrack="yes")
+	enable_nfsdcltrack="no")
 
 AC_ARG_ENABLE(nfsv4server,
 	[AS_HELP_STRING([--enable-nfsv4server],[enable support for NFSv4 only server  @<:@default=no@:>@])],

---
base-commit: cc5cccbb9f24a2324f50a5cb4c29d83fdf6b1f90
change-id: 20231127-master-5ef1c15da9c4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


