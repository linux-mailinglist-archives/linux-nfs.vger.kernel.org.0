Return-Path: <linux-nfs+bounces-9557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1C3A1AB51
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC47188BD21
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369001F9A99;
	Thu, 23 Jan 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVk5dzX5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2F1F8F0B;
	Thu, 23 Jan 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663946; cv=none; b=i0syrGGv82R6gC3dyLSuMQyt7dnaBbNnHk/xGexsR90ym+xx5MbB4Frxe3T77ddUDTHfX8UJl905tymWGZeWYmRx7epGzSux8Z2qo4qB4YFgx9tfFAbbWN8Tjfx/IEt5lcaY9bHCpvfz2/wzixUJ2OOWdWJeomNW9m769TXm++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663946; c=relaxed/simple;
	bh=ockLZn4Wj4+UFq2I+PBHFVIp8J4MqrK3CVytoiuF8Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLKn05iQkgHUcMZMUYDLz3oSOakiDRGsHnuPjz0iu/oKkyE9tAy31eTpYlnLf2WZLLud8ArGMwq2uz/anN0YM3eKNCdQwrCVXklN02zG6pErbVFscwwNQMid99yOv6OFk+lAcWww6tLfHecyXC7nrpAAAXL3WQX5tInsWqISLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVk5dzX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01CCC4CEDF;
	Thu, 23 Jan 2025 20:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663945;
	bh=ockLZn4Wj4+UFq2I+PBHFVIp8J4MqrK3CVytoiuF8Y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rVk5dzX5e6Vv6NWPtfV07JNLfA+qTOzFhAYg+17peTOKSGcPB21GiMY3Hi+QMAtJM
	 Atd/WzJ5AKh/5JLqCdpmgMXXdqPTWWc5923zHaYfYLesbCsOLK8vyC25vq4Ky751Qb
	 wzKUIB0sgLKA0qQ4Dzho7IaAH02zrvCePfSEL+LaLNQqCUXKNh2DiE9sYot9NIHAWz
	 2regnVnIskxQoP9fRFdhAtsmBlo4GF0EJUOv080BTvXxp5Ah5rx5KOlYhXkcX5UQGO
	 NsrWKdw3YfdnQgIoed1ExfoMRlxti/mShjCv2MYbMuZUBQhCHvaH6YM/wRMYRLB0DQ
	 x2rh/CDD5JyXw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Jan 2025 15:25:23 -0500
Subject: [PATCH 6/8] nfsd: remove unneeded forward declaration of
 nfsd4_mark_cb_fault()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-nfsd-6-14-v1-6-c1137a4fa2ae@kernel.org>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
In-Reply-To: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ockLZn4Wj4+UFq2I+PBHFVIp8J4MqrK3CVytoiuF8Y8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkqW8JZNgIpglrhCfR1LpiucFHu7heTgCchFWk
 h7NuY8/+oWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5KlvAAKCRAADmhBGVaC
 FSyND/oCc/L4dmJgktRBlXU2+vAc4l6UVJ0K7GoQV5duROMaf8eG0Rp3BtzvoM1hIa86/1fi7nZ
 zaEumT7oWDZtKLA4bcpvTMJt37M3Up+x/gzjKwdXcyxJU7p4CJQck43kGEVBwX6u3xMPQVHNoIf
 c2mKLK0YYkRgGIlkNQ+HHRLCs1PWd3QCgoOYelbdlbFxm61+uTAiDUk7h831TId+Rw0tw6wsvIH
 rVe67+X91NVCWHnDurD1v2k90nYer1MJX6nDW1XTNzjit8yh2qRiEQCak6sKoi0kAVno6SqDNFq
 eB5K29zN3rgf32GRPiRdCD6lsQ/rnLCdiUMpJHXIybgiKHaFr1AdqPR0uGtfckgaGRrD+HrPjbQ
 egA26l7V+NerEh53l8F1QgJkk0q+xR+3BJ1J1AwNM36LGwm3JNhye6uH9y4K93I0C+1H6aAoJaY
 AceM/Bi/a2Qt4vpM2ujQ/fQCuVDHdVAPwOpsCET3JA7LHADkg8VpAQ5BpWDDryLeBO/9Y6w2IN2
 eqg3p+H1bKRKZqTbVpTUL+5fprO4tYesLT6cpat00g79m2Sc2gyaDuRSZB3EO6IntcLeFdc+3iH
 ujswKmQ5vhWsEYEUy0aa8HJfaFEWMEBEIYC5bEGMFBhJHJCL2klx34UedaWbxIz7MFG6D2r0gbP
 zcXVCLY6oRP3bTw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This isn't needed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 258bda1193f664f048e7b802082c8307b0a88821..6e0561f3b21bd850b0387b5af7084eb05e818231 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -45,9 +45,6 @@
 #include "nfs4xdr_gen.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
-
-static void nfsd4_mark_cb_fault(struct nfs4_client *clp);
-
 #define NFSPROC4_CB_NULL 0
 #define NFSPROC4_CB_COMPOUND 1
 

-- 
2.48.1


