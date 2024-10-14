Return-Path: <linux-nfs+bounces-7171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0171499D87E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 22:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A118B1F21932
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162651D0E08;
	Mon, 14 Oct 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUNfklcI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FE1D0BA4
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939039; cv=none; b=Nmpeig4GFAUbsFV4aAvo+P6Z2ItAoprcjYEvDg1HauJQKsq7VaAv1dTA+3kxsUpKXIl0Wz7PSeJ4NTW96vrYh6XD/3lNXBJqi5IS9nrnSfenDxcGamkJlzlQwEhvqeP+yhLiuLgFjRH0VyiVPQxN1OcGolBDmxm8+NGjZFr/WEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939039; c=relaxed/simple;
	bh=vsCQE++9fNtDNhdGuW+pt5FaA1rPidzMAV8yqW4+ndg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrBjeOaM/BpCfRZSjlgN0lZZtlMKpZVZ9PcrLJnXpFD+9DTqZq0E4P+7FIXxMSTAWO2kdiSaC7//jRF72fYhmLNfIlXrzeLRH/m0yU0DF4iOqnFiy+MBibX+aUfeowQ1ypnI63OdRx+2ZK9m6rDHILW3a/P19K2BTrxLrsncXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUNfklcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449D8C4CECF;
	Mon, 14 Oct 2024 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939038;
	bh=vsCQE++9fNtDNhdGuW+pt5FaA1rPidzMAV8yqW4+ndg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SUNfklcIObq/5GhmbzXAeFsRBw/VkjatFQbLMjYEjZs8XWbgiyBVaL/Bga42FZqvo
	 uCoyiuaXZAEWqMYIsT6G0BfQQgGRBLpyWs51wfzykZ14KLMmeP0CJe7NoDfoUI1SdM
	 QU5yO7Bx+2XauvlRmF2NFrT0xUXr5LP/4BbQco+O8m1luQRwntvOr5OecH/+dBettD
	 Q4P1WuRGPoX4QCj1PaWz4mos5b/5tGP24Kw0FhKvBzEVY9pn2nM/krPKfP4xeW7hW8
	 GFQISOKVjFRCmQqxQkQLLouvmtU6dOB0jo8aAeweDcH4MkuqPzQ+FbA8TKE3hrPaNG
	 d8GkB++AEhdQw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 16:50:23 -0400
Subject: [PATCH pynfs v2 3/7] pynfs: update maintainer info
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-cb_getattr-v2-3-3782e0d7c598@kernel.org>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vsCQE++9fNtDNhdGuW+pt5FaA1rPidzMAV8yqW4+ndg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDYQbrQ1S4TnpJgMAjWcjEZrkOX07iIidi5TaH
 Zr9yBjEkZeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw2EGwAKCRAADmhBGVaC
 FT/FD/9i/w4G2Tj9v1XyvH+4S8wjVJ7zHk7EbH9DDoDQH6paXDWiXQkh2IrZSq+XML8oz0V7X1s
 9efF3/JWIV93R/JEEqzgC+2JxC80j0yU57pWsdIl8fOeyODz9wB+hmSUuhDACW/vxFFifsTA8lB
 do2zT/agE+rk6xpkC1Lu3kSEC94M9+0GxjbB9w2Yb6UpZ6HGDz/3gHyrORVOi8Z7aHcTJK8x0n9
 FmiN3NsjUeKYJKqTa9wWtHiD59QlCWZfi6R9xhcoVVxt/tRKWe0B7/j3wAz0cTdXI9Wly2Try3C
 tABTWhvdBAi0QTuI55jNmsPIpkzX8d5bFMZmxt8V3CfSKk0laoiZ6MdLv0NvIZqyT9X0wkk8Kqw
 2Fl7m+0Wg3EmEGZveyIitMKhYfdboVuvxrtEIf5QxG+zQ19+i1/kLSfnbLjXLAEKcrKRMujHCRJ
 KSkg8m6pKHOjItZZRFbAQ/LguodfqAKG5C9JQMC2GAMfX5xV8JXNvRDSPReaOrXFPyYZJ/HQn+f
 NKz3KQv93P1Ik/asXVa9eeBq0DGyPZyL8X6ZDc3zqs6rUAvHezWaoVjNqTwyAmU8DdtqA/TTnEq
 wT5EdlHtFYWdm7skE8VH/T9UvN2+jz/dE1mUacD4LNFzeh9m1qVEvz8jwjvmavJN8FDsij6qN/x
 2SS4Q8RlDpCadOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Calum is the new maintainer. Update the CONTRIBUTING doc.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 CONTRIBUTING | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/CONTRIBUTING b/CONTRIBUTING
index 220b3e0629aa658e3235ab5d0a7c13e271480cd5..d15b2b8278797b18c91fad740290c9355a5f3d29 100644
--- a/CONTRIBUTING
+++ b/CONTRIBUTING
@@ -1,15 +1,15 @@
 Check out the latest source code from
 
-	git://git.linux-nfs.org/projects/bfields/pynfs.git
+	git://git.linux-nfs.org/projects/cdmackay/pynfs.git
 
 Commit your changes.  Please make sure each commit is individually
 correct and does only one thing.
 
-When you're done, send the resulting patches to bfields@fieldses.org and
+When you're done, send the resulting patches to calum.mackay@oracle.com and
 cc the linux-nfs@vger.kernel.org mailing list, using something like:
 
 	git format-patch origin..
-	git send-email --to="bfields@fieldses.org" \
+	git send-email --to="calum.mackay@oracle.com" \
 			--cc="linux-nfs@vger.kernel.org 0*
 
 We generally follow similar processes to the Linux kernel, so

-- 
2.47.0


