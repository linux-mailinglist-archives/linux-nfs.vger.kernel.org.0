Return-Path: <linux-nfs+bounces-5491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C28AA959B7F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017B01C21742
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5221531E7;
	Wed, 21 Aug 2024 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUJtzSbY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331711D131E;
	Wed, 21 Aug 2024 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242593; cv=none; b=o4V493Dx2aUggMXedFNAQzAF/xQXva6nFsjTovgAfnkP75Uru9y503jCyN2lo2yWPm99NnNFpSGgS+7UHM9+7c4fpI9brNiRRGYFsRoreV7RnTuOwyo5kblNIAopMedwmIFJqa6jyT/RmA8YgC/62ZMESXIwz+GnkyIiIP3JISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242593; c=relaxed/simple;
	bh=2mU8ioxVN/5wGjGdS99fbZED3sKqLT8/LSb5k5ZqHnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FEn70/DO//bxdhOZQU8IQahtLt7B8NrbPYIlUlAwYy9lP5pyVBtdYMqyCeDtG60dHyCFOsqC3B2+7gZSHG7Czay6nitUHho7w5KgKi4WP2q0N42aXPXyrol5zSXLKoNsR2tZkvNr/wG0lcH621AfTOpdjmWFFqJk5iBRX6leNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUJtzSbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25113C32782;
	Wed, 21 Aug 2024 12:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724242592;
	bh=2mU8ioxVN/5wGjGdS99fbZED3sKqLT8/LSb5k5ZqHnA=;
	h=From:Date:Subject:To:Cc:From;
	b=sUJtzSbYTQCCYDq/EPfUshAiZ9CzdW2MnkI3kl4YparDktsa3wOAYYrU7bN82WN81
	 BsIph4PlpT6ONxeTutO5nyxEPy/35mm1/Gq+kkNa/mxx2tP4Cw3ac/qmeK7QsBZz3W
	 BFzrAoNzp4CRGtUbNKbLcNrqJIzrcOpc+lNPFgw+agrGu9RkkUY1mxJ3s7MVodNRh3
	 tKTRjJzdewuwIu7MHboqJsEPevguI5k1Q23+zms2xsTSbj3XpJK5zXp1b8CdXfbqGi
	 DFt5QiYyOFBaaAXeVff4boFgdgAhgEzE0xqNlxQSp+sHCZkxRhv/9gB6ecRYEIcnwn
	 p8FFyh6vhSbKg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 21 Aug 2024 08:16:16 -0400
Subject: [PATCH] nfs: fix bitmap decoder to handle a 3rd word
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-nfs-6-11-v1-1-ce61f5fc7587@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI/axWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyND3by0Yl0zXUNDXUMLi6Qkk1TDNMOUFCWg8oKi1LTMCrBR0bG1tQA
 OSpSSWgAAAA==
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Lance Shelton <lance.shelton@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2mU8ioxVN/5wGjGdS99fbZED3sKqLT8/LSb5k5ZqHnA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmxdqZGZFnWcvfNESeb2efxuFh+7bVAj1gXg4I+
 T1jFRDDXGiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsXamQAKCRAADmhBGVaC
 Fe2HD/0aKPevZVsgbuTceWeJL7hTWSodMeAQNtJS8WGGl26wep1IddzsP0DS4qxf2U8KkU4FWFR
 LVbF4ABjB6RMcFiM20mg03M8AuhyALLrlDG/2FOgOWy+upLBSdzeCU+FM+YjhZXLskXXKGSXHdI
 XEWBv3Nj2Ct+AvP2BFmZoq7+gWKvBQoIrl6FMHflL/C5kLLIIGkjJGKJ6nYQ2Y11rmD+/anHvqj
 QyxUlDjPqSojn7r2D39LTHxniOfaB6Zq2LQuqfqhCBEqZsFuPi3fSIRxUtGtYwD5eeL9aaKdgJi
 Mccd2MlsIls3lGyjeGeUUB8gLKzSnoUJ38+RqW67foVWmxLgzOJWEdOHDY5+O178g7Qc7gP6jCK
 UvD/kC2ZGfc7eGcvW/xRDykly7NHMC94RGWnrwoZKYEgc5zdw/Wb8U7jHH/V/pHG0sTnIOnnZlI
 SQWxtdg2XV/vfTZt4DANB+hxn1wqQQ7GkysTCELb/CNiMRlsOAB+EmR6CeIp3IA/OoSWrwNQfxL
 tahIsRJMWtYvmd7Yq/qgeDlMM5mvo9SYWOuMbaSFIoy3brTofM24Q3HHGMeoDbUNlLw08z84ADq
 HnBpmoFCK49DLtNL+AHycQqP363YBFR117tb8m/hwF2IvpmgRDjweV4jGVFE1QA+as/+B0huvBT
 L+Md2ABT8yVpHwA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

It only decodes the first two words at this point. Have it decode the
third word as well. Without this, the client doesn't send delegated
timestamps in the CB_GETATTR response.

Fixes: 43df7110f4a9 ("NFSv4: Add CB_GETATTR support for delegated attributes")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Found this while working on the delstid patches for nfsd.
---
 fs/nfs/callback_xdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 29c49a7e5fe1..246470306172 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -118,7 +118,9 @@ static __be32 decode_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
 	if (likely(attrlen > 0))
 		bitmap[0] = ntohl(*p++);
 	if (attrlen > 1)
-		bitmap[1] = ntohl(*p);
+		bitmap[1] = ntohl(*p++);
+	if (attrlen > 2)
+		bitmap[2] = ntohl(*p);
 	return 0;
 }
 

---
base-commit: b311c1b497e51a628aa89e7cb954481e5f9dced2
change-id: 20240821-nfs-6-11-188bb4e1f1dd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


