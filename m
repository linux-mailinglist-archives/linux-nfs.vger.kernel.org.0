Return-Path: <linux-nfs+bounces-7240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB89A2603
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C83288032
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664FA1DEFC5;
	Thu, 17 Oct 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUJ1lv3T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DFC1BFE18
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177444; cv=none; b=BwhsWA8wbzv59lADP79bj6GV0M7c7gRpXo0GlKOl3iug5NBKq+OLC1bkV8mJDSA38VB2rZVgALzdy5E/2sd6r01a+kLRRd3MaMAc57z1TEw5qMgMJP7rZGX0Rkds/zB6Bt9Jm81vCJQVk3HXT6EbW1Hr9LH7zs0RqgEPWAFu36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177444; c=relaxed/simple;
	bh=INOvrRQ2nEStYrTRoT6EBZaxcYt3nHpVbCKTdPVgRoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQsNtvNIjfO1tEj2I1Bo35CxOTDxC2jyz1sMlGtKqTwl+OIN2pnQcU6vHn7oVGFr7vR8tdlcrCYeXUxgeZydyf4yxDtRe9S29DFUcNfmZkKBstSK9xITZaESCiwueKSJAwDSdgYl/t5FE4aNgqF2Yz0jP59QvOkPsY6i5F1ykb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUJ1lv3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D784C4CEC7;
	Thu, 17 Oct 2024 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177443;
	bh=INOvrRQ2nEStYrTRoT6EBZaxcYt3nHpVbCKTdPVgRoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUJ1lv3TFqyO8AJqBwvVKBunoUMX2vB0RY73ieBHGsoPLv5iwehYuy+572TTaZ0mI
	 C4zgRkcHg0nY0hp01I4E6Q5qPDgODYQRNf4g6EqVrIHcWmCeJFTzQehIcYvl+F5r2z
	 ASFrjpOVissYreYrqChvMjzm0N9DYhcNu6LJk3nszQ5few63kpNJs/YVy+TNaM8/xo
	 1X9r96eI8AtslgEGtaL3IBhLDduw6YWvAldlmdUwqpr34QjvoXMBQEPaIVMd5JxNTz
	 +8As53+OHgKf5A5sz4jq/SC0guTTodStzY8o4UcI7ZDaeqB5qEyLA0IzApGFo4YIlf
	 zgDGlotFLL7xA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 5/6] NFSD: Remove unused values from nfsd4_encode_components_esc()
Date: Thu, 17 Oct 2024 11:03:55 -0400
Message-ID: <20241017150349.216096-13-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017150349.216096-8-cel@kernel.org>
References: <20241017150349.216096-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=chuck.lever@oracle.com; h=from:subject; bh=ZYXV9qGHPRX0N4UmLA6tqeoLkMAw7NxRZLBBKL0Ydy8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnESdb84VD6Kf3TYPK/cs3clqYigagNbenx5dPc 74lGWfryr2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxEnWwAKCRAzarMzb2Z/ lwXWD/4t0MduoV0w6F586TVkEseoG+WInjxiJkkB1edwdU88lC9U6gz3ZMS7vO1dZPL1uVUze+z 5I6E1oZPHO9VsrNSaj33e+I2+x4tDgsudipvKkaYdaXegu+jyBaqI9Nw/fIWxRYbfSnTofTCEw/ gfzTL6z/n8N54yGAFdcPetpbSjeR1+olIsQWEnsnZUPuLUu9+of0R/qfGTsMVooJeKl1khW5Sdl Acd3iKSexUny+DXIwLw5pW42FBGfJR/yKH0aGO/BlA1EDKP3gylOGQmvbBi4BR2JKLVSuIVXXfJ GyGaRGo5KuqyMhI7HYXyG8AuHj+IhMrrRlhxGSOnkeSkWmTfudk2SrtovGvL4aR5AisVQ8ur/C+ fjjkGyK32lD9g8guN1DP/W5Vi+uGIoIe0epYNXpBQe5fKdRQAOf8Vw4QcZF/Ihx++VpuOODZDAG n498G3ylRaYel8JXz2lHzbSTVhD0OFwfChCHNC1wbWyTOqvKzg5FakmOh8CGcFw2S18IThZvob3 TdPzEsck2ERfYFyszCiwpKRbVEVxaZZM0J5yolJXbaBQzLnYStQ4ZXIOcWxQ40Jd/IVTB+9LqhZ MkYbJlMWndxE/4Emn2gCbSwauienzbKrZUr1ocwNs0H9w8rccZDEkJIYkGRePAy3SEC0QmT1IJS UIs33mlUz2U9eKQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up. The computed value of @p is saved each time through the
loop but is never used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6633fa06bc91..59de516edc2d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2673,13 +2673,10 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
 
 		strlen = end - str;
 		if (strlen) {
-			p = xdr_reserve_space(xdr, strlen + 4);
-			if (!p)
+			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
 				return nfserr_resource;
-			p = xdr_encode_opaque(p, str, strlen);
 			count++;
-		}
-		else
+		} else
 			end++;
 		if (found_esc)
 			end = next;
-- 
2.46.2


