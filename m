Return-Path: <linux-nfs+bounces-8333-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F13D9E276B
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 17:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258A1286D9C
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2021F8ADC;
	Tue,  3 Dec 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVLlb/BS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8051F8AD4
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243360; cv=none; b=hVOXnRFbhe/kP5vwKx1oQYDCWhYE7OVYnj+fgROIS+fDFnFEOxY5mlVfIBmdq2P7AbeU+XpaeDj/+dYvaHB1RY9MYQLKZmeyUGh1NhPKBCGo6XIqg4HyXOFmrs4IVhckjOAdagnHI0bwS5Y8hcwGC+cSY541H2qgR+JruMlRQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243360; c=relaxed/simple;
	bh=xjZby/G+1S0HtB+8hgO8Un9xUZQtgkwttk+DiH1A6IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt1J2P/yet7eSe0DD4nYyKeG0EMfxeoThIEjushYC1syPTR66yRes73RjBCOIDiKZwF969T/JqnwMQ9pwI9dTOI0vmjc1cWZio1CJX6goR875AXQJOyA9mHMQ8z6DzBR5VciArjtefVNEZakyaUALzIbtSg8jV3XZj5MiXcJe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVLlb/BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDB4C4CECF;
	Tue,  3 Dec 2024 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733243359;
	bh=xjZby/G+1S0HtB+8hgO8Un9xUZQtgkwttk+DiH1A6IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVLlb/BSVN7Zshyucg8OWNu9hwMwdv9wt8owVNrOoBOhkjDgXM16Xa4r4RGmtHh6U
	 +Vpup+YSQum+XU7Q7T0aPKLf2DpFnPdrRV9KA5XBaMkqRyB4K3/F4xVE4zglPg10hW
	 F2LZlCfvFPiHKcUtnDUgslEkvNkIGc+WO+y48qbXL32b0UG3sy0PqtuUnQUYfZy3N6
	 LbCF+qMEKA/FAyvk6f8HecfXIWwZ6UMm2L+HyV8ei6K4CGuxhZQjP7f44kfW5Vp1o0
	 Wvy+EQU1bR6VdEgcH6NnnODdR2m1u2AJz4LaALfMHlbmpptXJEKUM8bNbwA+EJQo3O
	 J+hU6qgilINSw==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 2/7] NFS: Fix typo in OFFLOAD_CANCEL comment
Date: Tue,  3 Dec 2024 11:29:11 -0500
Message-ID: <20241203162908.302354-11-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203162908.302354-9-cel@kernel.org>
References: <20241203162908.302354-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=546; i=chuck.lever@oracle.com; h=from:subject; bh=iMfLGnMC2GTPGqB77IBVlR2DJhMBFTN/oBgNP4k3UPU=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnTzHaiihnzZWIEfy5TkDaUouIstdQzlq5dvEdo RuUqDbv3wuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ08x2gAKCRAzarMzb2Z/ l6KfD/995YEkuRlkg89Ulyt8fzRgt2EiXuzjJ1PEtygMs83qF3MVqI4IW7e6Ql697MzsM8vd4Ci +li1+0E/GuEr7KabADX+eGv/UMzE4ook3cHqrv28NYB+9TR6yDJqWTOJZf6nG4WiLLl+UcOuUlI aTXhyTFZhPEC7WoCsMpwPSEf3c/HvRiv7S5AzmQCxEqzzT9DEnzCpXjEHQ5eYyMQVSOgyqdLaTo oPFVyP/Foyq71em8LFKWU6ufv+/SVcH5R71XQIJPjGjqeuyQBSPerYlgFG+RBUGDjJMHFNbGlj+ 12/IjbUW9ZCg5+gOvrxHu4jXbMoqh2TwGdentfpTTi5Rx6u7ngXz3ekMrIqn0TChovHNm7GNukn yMlwUGRlkEfMr25UF7vzAoIaAFANFMwGImL7AaPbZCq/CY/DAwdq2loiHkmWdbJr6X1ugfx+AHX v0OfyEbNLF1Fuy0vpQlV6H7ZkeeLtf5e9czBo+I0E/eG3EDAyl1YJev5z//7huhHZ2vZRm5op+A gynVkpCN9WtXFjYsrqMJN8G/GyzJ03XHGN87DoNhoML+2j0u4qYIyw7c/Mv8ifAT4jgO4oSW84U bYdB5udju/fKpoxRhFs2O9lXl0lC0s082H3NzOJ4/v0qoGuZKm2a72b28EF9QfIwile9gko0UDe Vm+mKOpik6Bk6hQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9e3ae53e2205..ef5730c5e704 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -549,7 +549,7 @@ static void nfs4_xdr_enc_copy(struct rpc_rqst *req,
 }
 
 /*
- * Encode OFFLOAD_CANEL request
+ * Encode OFFLOAD_CANCEL request
  */
 static void nfs4_xdr_enc_offload_cancel(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
-- 
2.47.0


