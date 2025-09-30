Return-Path: <linux-nfs+bounces-14800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4059BACB54
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6F819270FC
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6A25D549;
	Tue, 30 Sep 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8+z4Zi1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65E25D21A
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232265; cv=none; b=Du0cSYpuo+hsyWA7Vic+JfPEGHuyZNbg8fTsQN7aimYaSmYxAojqnACQxx2a2nF7gq3ZEQyMtsAU5A5VOc+imwcwQdmCaOOL/ziuVGSF6uKNhdgd1kgepyGf2PJKzJ/86YKAQ370JfOO2xB8zFh5OQqdi5M82ze35Y0oYwts4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232265; c=relaxed/simple;
	bh=7wmLW5fRuLtcZQMxzggPskyFQyf7Ug60jVGNNtr9O1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EB0wCmjD923BswfUK2FlMwUVmdevpHdroDM+PD4X853N1tY6sS17z6XdxWAiVhmetx96hUvZAdwo/vOPfxky3YHzYqi65Gnph8D4d4eShjw8guR2tFR+5fXyEoA1MimO2kDa/JVoqGWCVntDeHsqaaoGny/+PUSG5sh4aiXMcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8+z4Zi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EA4C113D0;
	Tue, 30 Sep 2025 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232264;
	bh=7wmLW5fRuLtcZQMxzggPskyFQyf7Ug60jVGNNtr9O1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T8+z4Zi1b5cI01tvpGdzla9Q2cApkrENb8DqukIa+SwCBXYqDgEt6UQfBZP/55t6o
	 cEA6wO17TE6JptGZLQkBclCr+SH3SHPsnK/ZeI1ij3bpFJZwS1W/u5aAIXn01gJo/L
	 f3ip8pRjgIxRlOVX7VoWtsQM2+djsxKVqCAcpqGlUTyIO87NuJaLLyiEO+XGSYoXXu
	 MdfbvBYscjaKCDNBR/pcQ+3SqDL43lpBwtjgu2yAjtKjHHI6ESjCRgRF9tIQ+yH64S
	 EqJqXIPqtlCpIqU6vZeTDp0z87g8FNwF/mlpMHaQGGtFPUTcLarZjOn8KZM/YdzYUT
	 bH7cPprTHGSeg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 30 Sep 2025 07:37:35 -0400
Subject: [PATCH pynfs 1/7] nfs4.1: add proposed NOTIFY4_GFLAG_EXTEND flag
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-dir-deleg-v1-1-7057260cd0c6@kernel.org>
References: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
In-Reply-To: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7wmLW5fRuLtcZQMxzggPskyFQyf7Ug60jVGNNtr9O1s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo28EGxjO6rEckUgn7UKlTwgdy4hDLbzfYmZBJ8
 CX4ZoZDl8iJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNvBBgAKCRAADmhBGVaC
 FfK5D/47232gmMwG8842NREVk72Ah5yjF70fn7U3/VwEyr3a5nuhRllLbtumvV6bntaiQVT2git
 ax174pvtEis5Xqn4Gg8KTIggw7+/COOVmO34lsar6w9Eot7Jk1O2IAKVoPIIVI5NCCFdQGAqFU+
 LRUxBqvRfncl6OIpjyr71k4vBjsbsdI0ELFpfIMhcVemQtpnvaZVjOdNEpe2sOYb6EPLiZNxTOF
 x+jlrV6x3wupaTsFaFSdXCCZs7jYvn4RHNTPbPi0k5BhPoX69mailtjdkgvWLQP82qXX8zx5m8A
 S7998UcJ/bS4ZcZDyKHUZvheO4WJ87CmJfBz57GbP34dJDbAoR3kvAsfhtUUZRcJgZk09KGZfs6
 IrHCx7wRnK1n9t8UUGLXkDorBTJvHxUoXgfLF0mFr9twIaL/ixVTGKkHTT2tJ/QLoI71UcLZKiM
 nG1ORJ8liTkdcn0gxXoj5v6CDvDfEIGk1jry+oPlvuEYyz6y3Osvbn2GyzHfOWnBtBFqr2m7vHs
 WzpvpYrqx+EQhBvfm4X2buiic+zco/hYWxSbtcAX6QMe4uMsYCgB0i/XkSuf6kxZfgKqQvZtQSA
 8L6lxC0NDe5ToicTKz+bAxPqv6285oHSb18/2tb82yd9h5kldk2gyZAgZ99NhCLMN/ISiAybKIQ
 XA088CZioGOXZcg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/xdrdef/nfs4.x | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/xdrdef/nfs4.x b/nfs4.1/xdrdef/nfs4.x
index ee3da8aa7a342e4d3829f4b1b1f82543275199c5..f03eb538a2980156a8149f0b00cc9bf19c0a91b9 100644
--- a/nfs4.1/xdrdef/nfs4.x
+++ b/nfs4.1/xdrdef/nfs4.x
@@ -3611,7 +3611,8 @@ enum notify_type4 {
         NOTIFY4_REMOVE_ENTRY = 2,
         NOTIFY4_ADD_ENTRY = 3,
         NOTIFY4_RENAME_ENTRY = 4,
-        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
+        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+        NOTIFY4_GFLAG_EXTEND = 6 /* proposed in rfc8881bis */
 };
 
 /* Changed entry information.  */

-- 
2.51.0


