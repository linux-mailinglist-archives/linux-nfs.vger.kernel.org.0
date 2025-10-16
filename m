Return-Path: <linux-nfs+bounces-15297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749FEBE4203
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B8319C3C07
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823F3054C4;
	Thu, 16 Oct 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmPsRt0H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539412727E0
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627356; cv=none; b=qOEKXVd8VBUfnKXpP3opNUBuEIUPZtifltSz/ajxl4iG+0jK35c54GrYRxzB0vNMXqSgVxeY7yAnrMLdih2rY3dkqXnglte3cBXPTc2VxKGs5JaDOkXhFPqJQ+oFyn6nRqs6pEh0Cv+/Z8NTZVl42E5cs4T3rOhw9KOlSiFTdU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627356; c=relaxed/simple;
	bh=f0QiGy7asL71WFQjG2DXC+2KMLkjHBa583eCffp0xDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrbJp/5aHLhBD9qYJIVU9sYv+Hye07YVT7Nt3xhqj5sVpjEmFy+OAQq/ngB9WJ8N2+tY5kei7FRm1lU53rYpqSyKTXbI2QU0/NUGwuFIQ2PMDbxUUeoB40QVYN/sL2rvIUkvFavhdN6Lsr96YOy11W9AuRldw+COTyFtfPjR9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmPsRt0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1B5C4CEF1;
	Thu, 16 Oct 2025 15:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760627355;
	bh=f0QiGy7asL71WFQjG2DXC+2KMLkjHBa583eCffp0xDw=;
	h=From:To:Cc:Subject:Date:From;
	b=AmPsRt0HmViu+OUXJ0fYa2cHrBn4zPuGNJGK34BTOgGILysg0NT7IkYAdmO+uJ44G
	 7Mubg5vj5h0Z9R2TaJKKjn+iHHOJ51yrtEd9sc5Fby85K9KJyiZqKfXxvUF17WAKih
	 VPh3R4QYrPsUNCbxt5cNaoYeKtQm3r8iz/GE/19RBSy+XxeLm3MgbFIFW7jL8+xIbc
	 qakNtR+4C2OKMeVYaRfDWz258/saIiJI4KdIHnxqLoMXOg0H4rUSrToSqFEAPacJQJ
	 Db83bMg+589K92CqdNS1fOOxp4DVbl4GMUdx9zT6YnTs1y4mY1fLkbvU/Ovqxu3/iX
	 80rHJGEUgz0Kw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	ebiggers@kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Revert "SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it"
Date: Thu, 16 Oct 2025 11:09:13 -0400
Message-ID: <20251016150913.17092-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Geert reports:
> This is now commit d8e97cc476e33037 ("SUNRPC: Make RPCSEC_GSS_KRB5
> select CRYPTO instead of depending on it") in v6.18-rc1.
> As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-enabled in
> defconfigs that didn't enable it before.

Revert while we work out a proper solution and then test it.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-nfs/b97cea29-4ab7-4fb6-85ba-83f9830e524f@kernel.org/T/#t
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index 984e0cf9bf8a..a570e7adf270 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -18,10 +18,9 @@ config SUNRPC_SWAP
 
 config RPCSEC_GSS_KRB5
 	tristate "Secure RPC: Kerberos V mechanism"
-	depends on SUNRPC
+	depends on SUNRPC && CRYPTO
 	default y
 	select SUNRPC_GSS
-	select CRYPTO
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH
 	help
-- 
2.51.0


