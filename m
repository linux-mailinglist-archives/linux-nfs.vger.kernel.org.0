Return-Path: <linux-nfs+bounces-4907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ACF931346
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 13:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F342844C1
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3F18A934;
	Mon, 15 Jul 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVvJ3xzI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9D18A92F
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043789; cv=none; b=h1LrJ+gXXfIPbjq6sBPTqVzKUiOnSPFpSPrYONc44i+GPWsx9x/q/3gGekj2xFAws8R15viWRX/8Nq/3X3V+AQP0rIlz1aVBxxrH4itrPJwzhVhpA2ljhLlgSNxIWcKIiE9vpMEF6JcRwO6i/t7NKBsOrUKk9E97Iqz6HD8yO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043789; c=relaxed/simple;
	bh=/BSuJm+MAetEJfC0LjEPtEMpvCSWMNsiRNTFX5ygVYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dDMPukwSTaa61jMoFH8odKF48WydD5fWZbMSdO6Fr55A5qZCfFK3PTAIA2GKgMTJGnbpYe5zW6NZbZ7FcsZ+hEBt79LiJTHQ2SmF6+Dg8yfhiF7HeFBdnfGah80pheGc/Mv8A6YKksvVRipX2Kckund1HYpnfghurc+RZ125ej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVvJ3xzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1296BC32782;
	Mon, 15 Jul 2024 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721043788;
	bh=/BSuJm+MAetEJfC0LjEPtEMpvCSWMNsiRNTFX5ygVYk=;
	h=From:Subject:Date:To:Cc:From;
	b=DVvJ3xzIq5NcPPI2nAdIZ9zxKpIiNLLfDJ1cV/SPUJfggwrnGPVS7soHReuAeoySO
	 dkU0+o97LJjqQgOwhYsgAN21vPheCiunQNVSigr5iI1hrTsm3gLSboFujtaqexpfh3
	 o/UXeBRWc0kOdt1P2utM6gNl2x2A6B2RqICtONWs9L58vteRtaP0O+tCJdpXkeXdKR
	 TXO4kP7ibkq20m0dcYV0Y4YmJbpcOJ8wc4bG8TIzj63Je2woBi/Zh2FClazUQPutp5
	 cigUPEpD5oblVpCuI623d/Uo+G2++Lfeh0zvAGYxyZB74leND0iQM9co3D9OGS4N4i
	 gB7HnLkVMRWJQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfsdctl: fix default threads and clean up compiler
 warnings
Date: Mon, 15 Jul 2024 07:43:00 -0400
Message-Id: <20240715-nfsdctl-v1-0-c09c314f540d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQLlWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NT3by04pTkkhzd5MREU5OkFCMLC9M0JaDqgqLUtMwKsEnRsbW1AB5
 BYzpZAAAA
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/BSuJm+MAetEJfC0LjEPtEMpvCSWMNsiRNTFX5ygVYk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlQtGQkstbbcO7CEOqgB+EZ7pSyqwuvC7OWNVF
 t4gi4Vb2fKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpULRgAKCRAADmhBGVaC
 FdlUD/9jaPNsl93Dq7eNG9zTj7fiQZQY+WTpndcvFPh//xpavQjE+VvaFbSqnM+feK7kVlhUEd+
 PLRcYmPh6Se6U5PcK5rHQW08V1uwGPixSN7oAcNxnvcpJ8rUgA5h5ZbcfS3aVTrQSJD017HV3oX
 0XxXETc5I/tmUNF5JBTI5BZohGvwQ7V/Eo65XP3vw9xrg+w/a7jBzGh3eu1aMhU53AXJBjQwflt
 /i8PPuCuaZQNZeGFnfPhi+C4aQHVVoTpGlex8DCK2UMbMG/6cNNA/2MXwP0ZV7IhmphoLnXIAaQ
 SXT+uf0QIRvZEqWv99NAyXiSUB+gnMCzohRyspRVLvMXAUyyHmh8P4HiYP9BzR5GtId+8K3QHMi
 SEbRO97B8YMTg1g3N2Y8HvLS/i9d4L9bJ8a5wZb/1mGWsnK9c2nGdDB18a46+LcyKw/RqUnHBKt
 CDJTkZD2j0FW2TGHU6ZvhvM66tbPEpkH3j0YO3r1tLx9RRsb35j0gAbnOlyWZHAudaIfSYk/xs1
 431hAoSfoUXJU5WglnpIPcn3OmHRRgsoJlX0CFgZn3ZN08usWUH8Pb+Xx+VkwF5fLZoj/XJm4NS
 S8S48sYtgV0Hex+WiTHScFow5EBCdIIYCVErnJyY2vlbEQRHn7hiS02v17vt+R6mPWSxhYmOPpb
 yK+wYLpYWisLBAg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Steve noticed while playing with the nfsdctl patches that I had goofed
setting the default number of threads when it wasn't specified in
nfs.conf. The first patch fixes that. The second patch cleans up a bunch
of compiler warnings that I missed in the original submission.

Both should apply cleanly on top of the v5 nfsdctl series [1] that I
sent last month.

[1]: https://lore.kernel.org/linux-nfs/20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfsdctl: make "autostart" default to 16 threads
      nfsdctl: fix compiler warnings

 utils/nfsdctl/nfsdctl.c | 80 ++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 47 deletions(-)
---
base-commit: 44dd12f5a715b419d83f81657ea68ea435f6c248
change-id: 20240715-nfsdctl-caa54bd2885f

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


