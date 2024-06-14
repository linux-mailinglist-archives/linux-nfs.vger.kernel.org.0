Return-Path: <linux-nfs+bounces-3829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F00908C24
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CC2289B9E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B8199E90;
	Fri, 14 Jun 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLYIQ+d5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37D1990C2;
	Fri, 14 Jun 2024 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369956; cv=none; b=HD673VR/47ul3uXUkZDh4R8FHYLv3RTG0aCJicB1U5OCOc8CzLPw+Hiz1XunB6Ch6Vv/ynVIU9zAChlFfNo66rVthqrmm+Y4eGMPZWiA1WA2BLr/aU+uOp5vHImzLaAmrgspv3db3KefWJyKJu73xXUG0E69oEMsFzeDKbGj8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369956; c=relaxed/simple;
	bh=72YwQ/7+JDf4h/iYndf9k40v1XEkmlBBOisQcZ77H1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GeD26KlBVt37HWhbqx/KHJSUPgYQrP9rY9M8GicsDZUwr257lf0tjKPJ0nWNKN+NUsTyjstH2lhXXsbTpOnDQnA67VtO0jwbptw7uv0M9b0BzJVaLXTDi1GOfGTc+9KLruZDfvPB/J/RK/UhX5JLkeAGRePkTYYBsAJJkkMz4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLYIQ+d5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39A1C2BD10;
	Fri, 14 Jun 2024 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718369955;
	bh=72YwQ/7+JDf4h/iYndf9k40v1XEkmlBBOisQcZ77H1A=;
	h=From:Date:Subject:To:Cc:From;
	b=PLYIQ+d5xIZ7PmFNaN1cYMs0XRZyn6wslfWglXTdxOBYanhqE9bVxqKot10ZQnE32
	 h4aBUoa6GFiUBWVe+hlWxhwP9bHduoLHu71HH0/FzlJbFSxJJUcM31/ZjddCxaGIjM
	 thHFpSIQYRhq5Yos46dF7KPrgo96/HD8ydTnOu9MKoaLhyhJ6rh8Lf5cZXN7leWiHW
	 HSR6PqNivCzOQCPbNJz4jpNCU6D26IZNbq25AeEoOF+YU24QtfrJhBWvK5oOtY/+Nt
	 R8aZERgk2cef6lW1wSDC+uWahBpx/YAM6dVatZHTTZl83tNiftFOv0CFG8fQOo7lru
	 r7fmRSlpnmDzw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 14 Jun 2024 08:59:10 -0400
Subject: [PATCH] nfsd: fix error handling bug in nfsd_nl_pool_mode_get_doit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-nfsd-next-v1-1-d360eea79d0b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ0+bGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MT3by04hTdvNSKEt0U0zSzpKSUNAMj8xQloPqCotS0zAqwWdGxtbU
 ArPBQS1sAAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=72YwQ/7+JDf4h/iYndf9k40v1XEkmlBBOisQcZ77H1A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmbD6i98vkm1783UDy76Wu3K7VmDJyApKpxSjY/
 VFk09Yks2KJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmw+ogAKCRAADmhBGVaC
 FTL9EADBYcNMnm3fO12t6XrT67eLIM59SZBrffA7Wwr2D4JfJPfVMAK37Mf7HtIQlBUXwsnzRQP
 0Zzeb1ZU1f5jiQsmCLv1Mahse9wk/p1MgLArGyn5bgp2U+YGcrAgyIFVzsX31Bu12v1puxLC56S
 7GiBgbhwPNlOrIKYcFgT4GqxrrDCAUaQkPaGXUfvjol+geJTVxTxw4Ik+CBGHGQThx4vrqDBscQ
 vwplvv3BBs1N149HqJbhlZ6MF5XyRtH1y0UmY2xoN+G60vvmPP3J5ZcGBN6fBzLJfatoBZaMGTJ
 vh9p4IqYCaV4c/xXUYqjo2rfMDBDWSmFcVhAk7UuU5HN0M68AfLi0gJg+4/d6PfeFoEqhxYw9MP
 8zA5d6aFIBjzpuv1URUkm2+0L9RrY+SeFlH03fZojxQ5qShfBf4GTcPeUpxGjXMI7TeaGLjMuWH
 nV8xAaqJ+GUzt3tud59LnZhpiUdjBBoMCmipO46mliVVK67cfWBdPSXrDAcVmKtWy7X/fx5Za50
 y6pdjo0Ti9bXhrjSmROAzyRcQZVd4Tt76HNH6MgwzPivdlKmxsiEb9W3B1poA2d1KcwaHnCUBKw
 nQ64x9NUDb6PTfy+gcw16DHZmiCCqtPdlA1ifeyv27hZ111W8cHZ2VQO7jAg5JaRF4gzEIapsMj
 5qvhv7R9zEgRaUQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Jakub pointed out, I meant to use a bitwise or after the call to
nla_put_string. Also move the sunrpc_get_pool_mode call up in the
function, which simplifies the error handling a bit.

Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Technically, I think the logical or works just as well as a bitwise or
here, but this is cleaner and maybe slightly more efficient. Chuck,
it's probably best to squash this into 84a570328ee.
---
 fs/nfsd/nfsctl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 187e9be77b78..e5d2cc74ef77 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2214,6 +2214,9 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
 	void *hdr;
 	int err;
 
+	if (sunrpc_get_pool_mode(buf, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+		return -ERANGE;
+
 	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
@@ -2223,11 +2226,7 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!hdr)
 		goto err_free_msg;
 
-	err = -ERANGE;
-	if (sunrpc_get_pool_mode(buf, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
-		goto err_free_msg;
-
-	err = nla_put_string(skb, NFSD_A_POOL_MODE_MODE, buf) ||
+	err = nla_put_string(skb, NFSD_A_POOL_MODE_MODE, buf) |
 	      nla_put_u32(skb, NFSD_A_POOL_MODE_NPOOLS, nfsd_nrpools(net));
 	if (err)
 		goto err_free_msg;

---
base-commit: 84a570328eefd4df2e201deb5d43d152e0aca55a
change-id: 20240614-nfsd-next-d5f6bbdf027d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


