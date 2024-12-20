Return-Path: <linux-nfs+bounces-8695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E0C9F9885
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83AB165333
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5A121CA0B;
	Fri, 20 Dec 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIKjOENb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6FF21CA09
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715423; cv=none; b=evYd0mU00uY9/LzZY7cskq4mH4syEaz/wkKbYhVfFstCy6TEbM60BFVzfTdjsimBxu4dG9swOtqscfZ/MfXmh2+s5jYKpYC9SOvzjMmpqlpglM4x3qt9Dk6Rph4VAAI+pe4lOZjP4bGRTLGxzRV9iU2EIF+/WKWp1OYgwIE13hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715423; c=relaxed/simple;
	bh=DR1icya+GTW1CbkUudnlqgM2fL8cY9yhPy9oV/6QO1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sP4U1sLXaMJkM+oq64M8eVThxrarvAt/WvOdyiVW+bNM7pPQa3WV04g8HUIHujbHszGntkdM+CU9O322ocWIug13cq8et0qxwRC32CgEAFhRBJsUEqm2izIhbr5Or4MoNt68uUp/4+018hzEzbnsL2V7UypU+Lx2QnU6KwFk/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIKjOENb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3278C4CECD;
	Fri, 20 Dec 2024 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734715423;
	bh=DR1icya+GTW1CbkUudnlqgM2fL8cY9yhPy9oV/6QO1I=;
	h=From:Date:Subject:To:Cc:From;
	b=NIKjOENb/dJODJhzFCgFwAwCMhoUfaIDy9Et+J+/38sMybmpoP9remrMy7kwJD0TI
	 vr1tR3i0UsvrZoRQTbE87VkTv4DPL9Yi0FMP9fU/sYjErIHuSzNAT0cb30oJbEkCeZ
	 fb/oejcqU3i5qi0xw9JNycwg8oUZCl4wghFGNKwO3zxqGA9BqpdhsvvL45Pl+Cf3zF
	 ON4+GWe/2QFv3qYWNNMTGqVGTpEv/912fA4/CXH60q2sv4UMQp8zNdFYpvM/bu8STR
	 l73rLBSS+pcLV6+QwtbjV6FTGV+4excc1GSd927NSbBZd5wEv8GG2JD+DB3p1Yz+nM
	 e/0Aj9LbABpUA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Dec 2024 12:23:36 -0500
Subject: [PATCH pynfs] CSESS22: increase the limit above latest knfsd limit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-master-v1-1-4627ad33175b@kernel.org>
X-B4-Tracking: v=1; b=H4sIABeoZWcC/x3MQQqAIBBA0avErBN0rKCuEi2ypppFJk5EEd49a
 fng818QikwCXfFCpIuFD59hygKmbfQrKZ6zATVWBlGrfZSTokJX2aa1iLXTkOMQaeH7H/UQHr8
 IDCl9ni/+618AAAA=
X-Change-ID: 20241220-master-2b43693225b0
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DR1icya+GTW1CbkUudnlqgM2fL8cY9yhPy9oV/6QO1I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnZageb6s5Y8NkXsqLPZslfCVIMaI5OxFDt48Kr
 euqpRbrzRaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ2WoHgAKCRAADmhBGVaC
 FRX1EACscCpOQNzQn3o0MLgPHQpJ+6FzBu7JygThQqJgkDNorSIoNZKJkN/6uz7AQcv/0/A3IjH
 yCYdmseRrpXUgCHlooY02W8rHVlAOg+ULAQaZhElcJHNNbV5co3tOLzKO8A9gLZ8L6t7bDq7yWI
 ZUVKFd05aAE2Xn7F7rDfPtPaBYfTN03rPvmXI61qbseKfJoFbsEcENQQJFCPmB2yORaAmOVHwkT
 oM1WNlqK14c7biStDwIYKkDOFE2JhkpUt7AFPjIzjPLDTSColmCt9PaS6XTnmS5qSlYzxMbJG5X
 8hsMI9orKHGtSc6d0X4WBa5U5dxd+9UjwAbh70uKa3uFDCuehZJ6FYyzOMXKOz/7B1rryOGtCda
 wmP0B6VJIe4SUQSw6pp/MGoZJsn6v8CGUppPBEwEs0NuQMZpmnO9SZ+d5fsJ6aSmqP/Sacj2vCw
 ArWptnVMm32M2OkmmeMydyXBUKwW+OovDS6TKkKg9MGBNWgzrf519VWnlB4X7RbAVKEqhp/tl8q
 fsCZjNi7dyNb26uIzS4PVOTqbrmbaQoxz4MqhygqE2UbQOyzKd+ddmBxCUM9RSi07zMyvsIN5OF
 JoQ10MaGtLUdn/GvwW1iEemOcDL/KWwPCy0aoB/IXNv27Xic5qzp2tNYX32VBWJ+x0KxOt8f46m
 1wGqqXYJtbifK1Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the latest code in Chuck's nfsd-testing branch, the limit on the
number of fore-channel session slots has been increased to 2048.
Increase the TOO_MANY_SLOTS variable to 2049.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Maybe we should increase this to a much higher number instead?  I half
wonder if we ought to just eliminate this test altogether. It seems sort
of arbitrary.
---
 nfs4.1/server41tests/st_create_session.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_create_session.py b/nfs4.1/server41tests/st_create_session.py
index 43166443ef6f86a6b44de70f3793bd93a330bc9d..740f8bf274c4eeb3ff9da20c0de241a31f80ac26 100644
--- a/nfs4.1/server41tests/st_create_session.py
+++ b/nfs4.1/server41tests/st_create_session.py
@@ -395,7 +395,7 @@ def testMaxreqs(t, env):
     """
     # Assuming this is too large for any server; increase if necessary:
     # but too huge will eat many memory for replay_cache, be careful!
-    TOO_MANY_SLOTS = 500
+    TOO_MANY_SLOTS = 2049
 
     c = env.c1.new_client(env.testname(t))
     # CREATE_SESSION with fore_channel = TOO_MANY_SLOTS

---
base-commit: fa786a7217128e6e5c9ef20da9dd6069f5f593e7
change-id: 20241220-master-2b43693225b0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


