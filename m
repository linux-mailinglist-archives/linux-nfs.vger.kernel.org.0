Return-Path: <linux-nfs+bounces-7170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A07199D87D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112B728236E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66061D0940;
	Mon, 14 Oct 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTpj7ZQj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826261CB330
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939038; cv=none; b=RsOIn6s7yz1ET2chxOLk9xGp+WGyDCi059n/kqyuly+cXNMMJg5zmJZ7Nd5oeVD2zUJHo7jj/XqRZRaLaKxUCpwwHsKjUx7qVSsbPobseKRb98wa8AOswMiyeF0NRbpMKBkEHUiKumCRn22DYhy9Dq4FGSF20j0arhf7jxWUbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939038; c=relaxed/simple;
	bh=2BXxrWKpMPGnMRHVrSRtF2BcozckmBpLyaogBCC9fIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iD+PG0gKAa6hURlCrrPFXyublwm2uUWffHI7ouA23P9iyzO+XyZ/JZXSzIVsiA/+gLiqxNOg+WFR6rsNTVLoG5mpJXQWWxmMjGpp1Wn9WZO4fm+niHma7M1izqjj6bSmDZhFNqfu0lSW3n9NRNLGKbvx8SotgMp2vUr7tYj7/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTpj7ZQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0D1C4CEC3;
	Mon, 14 Oct 2024 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939038;
	bh=2BXxrWKpMPGnMRHVrSRtF2BcozckmBpLyaogBCC9fIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XTpj7ZQj5otQwQNjtzah7gPNAkw0UyUfIEBUIW9HAxoeOJdukchlGYJQhxtHskKDK
	 flBtEHU/RO7CYAGtzD7jPWjaUmyTcYn0ZNeMccE24EQo+8b6uxsPUhaH2wehYStkGq
	 2vs8nVudJXgo90MeTFNI5yrzD08RUAUPO0eIqK/I4oBWESNDa37jBaG+XMq9l26C0k
	 A4FHuMPXeXQjjYu/byg4kk8P6LzdGM07/BUeqIu4KQ9KIPHOZbVGQn5as+U+EDe/lZ
	 RJlUUKjlf4BuWxCfeAS8tZZq6t8bzcgX4TC7YwCd8oeeKCLxf9XgVfueXYlFBnNeQJ
	 BBaySjWgeDgPA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 16:50:22 -0400
Subject: [PATCH pynfs v2 2/7] DELEG2: fix write delegation test to open the
 file RW
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-cb_getattr-v2-2-3782e0d7c598@kernel.org>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2BXxrWKpMPGnMRHVrSRtF2BcozckmBpLyaogBCC9fIQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDYQbSfO9+HyPs+VPFG7F/4TiT0xCdcDrv5bc7
 INfHzQ/RgmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw2EGwAKCRAADmhBGVaC
 FQYtEADGv7wH1zg6f87ITi9rBop+iSGph8OrP5ea0cqQIbF5ORb8ftkizp+2nF5QUNX5rJFhaka
 TDzkfVFNoRPMjdpr6n7MBc6aH787Wly8Wl9tmqSZKr+Z+W8BK7JzydzlODWzBq7TiCxYRWSsWs1
 ZIEqPnrB2e6iN5q1Zw54mBAvCE9QVd2cmFONt9sUQonEOzJuPNEI29VhampbXqSzUiayTrecyt5
 e1I7qa2n+Rp698cyXk3CwdGSeYdZSW1cv6s++y3UhU7In7Fl/Lh+A4XeKxHTRfcRQpVYNHMyGjM
 0C/iLYuDN8Y5FjnswFT7blVgEl6mk+kHqKKfDh5jdcNw8+reo6co7t/tIZHOWW9o9WMfT8UryFR
 FiHeLypcWyBn43U9GRIVdX5AMkVNZaBoABTQX3JtIR8e0mzY4krmxAIedDUoFDpZHyVxt9fOBOU
 De814MN1VbQftZMSougpc/M//x72GQ5EGil23eccRlDLQkwLuVqdrxwoYdWTowkYH+gQblJD21E
 0dRfoGW2Lvcz8sjXsyQAO4a5GEBPwXXT2p12xOliy8hzeCZNtH1jFoRoYGMuADRlgBYBi4RcVCg
 OySRhnHtEFSlbwjc7jbpPC6fx9KDEjyKOBDN4eLzznS2XLxx+vSDiVV5IPr1G0zNGbJDQIhRLe6
 Bo4fEMsh/jjzKCA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The Linux NFS server currently will only grant a write delegation on a
r/w open, so this test fails to get a delegation there. The test should
work just as well with a r/w open.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_delegation.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index a25a042578b49d005f4f7ea741e623b44c0a0e2a..80b0da28fbad85429fc1f4c0e759be82b0cc5c08 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -79,7 +79,7 @@ def testWriteDeleg(t, env):
     FLAGS: writedelegations deleg
     CODE: DELEG2
     """
-    _testDeleg(t, env, OPEN4_SHARE_ACCESS_WRITE,
+    _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ|OPEN4_SHARE_ACCESS_WRITE,
        OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG, OPEN4_SHARE_ACCESS_READ)
 
 def testAnyDeleg(t, env):

-- 
2.47.0


