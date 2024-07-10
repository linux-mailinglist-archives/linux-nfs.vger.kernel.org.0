Return-Path: <linux-nfs+bounces-4769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0EB92D240
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 15:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2341C2266A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFAD192480;
	Wed, 10 Jul 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REHhfGcu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8101922C1;
	Wed, 10 Jul 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616788; cv=none; b=YkI2zVPkXVriyqo/id4gp0uL8JJf1DUNVRgZKZ12dRrZh6HH9jwXmSA21JBHw/1y+EcfyoWabSmoYxRPKkDSWvrdL/QBR/nMwWtmOxHl+l6QZf842WVt8RcTFGF1DwZSbAsqHz+Yx0pZpPEVh6PWEH/yLFPT11i0W5gRgSKIM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616788; c=relaxed/simple;
	bh=c35CfLJcGNAisGpu6esFSKnBAYC3NzNx56l4H9qM9zE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sOCgPjHk/mbMCd/+ypr2RnAAOYsHWkxBa/FB5Q/7QE1Iq8arJYliaSRC4yJORNiSwdpgbD9X5YuPlQqu02pN9uRJI9GOsMOy17e3GKbS/7u5n1Gu+Zco9zcQ0Y07PwVZIyWvItQ/N4DD+mAveb05aMlG9oj3T0B23BkS9vJ0xLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REHhfGcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8BFC32781;
	Wed, 10 Jul 2024 13:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720616787;
	bh=c35CfLJcGNAisGpu6esFSKnBAYC3NzNx56l4H9qM9zE=;
	h=From:Subject:Date:To:Cc:From;
	b=REHhfGcu/+DoyR76imt2kpoZLBOszANA/mxc4PM2PtlvuTjZdvtkmCHcmBPuf30gw
	 zZXCVUzTgzno5RJErOJLBBUlMT1D198j8huHohbswGoj3My2E2hdSIg0PPgEwGB1FY
	 ufb5BoKefVQO4fxxl1toCVGxnUB4C6YmFPwS2WidWuHIzLOerCo+3QUifXoApMkjlZ
	 DK5im56fw4TKTfyMLQGzHawo9Uw6NZUkdjNz2ZZPje+L4cwnUcp8DI0GBGDhsxVrCT
	 GK35VsIW1LWeCxILlSSxDqmnddLcel5kgbUeUTJ/BVzXhTBait3Y+w1lvhUcH0XsnU
	 bchsEQjQ78C2A==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfsd: plug some filecache refcount leaks
Date: Wed, 10 Jul 2024 09:05:30 -0400
Message-Id: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqHjmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MD3by04hTdvNSKEl0Dw1SjxLSU1KQkY0MloPqCotS0zAqwWdGxtbU
 AUuiZAFsAAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Youzhong Yang <youzhong@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=c35CfLJcGNAisGpu6esFSKnBAYC3NzNx56l4H9qM9zE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjodOl3Ot7CcRVujpSIdO3UjhLcDr6cWqob2Gj
 eNeE7bqJ6GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo6HTgAKCRAADmhBGVaC
 FYFdD/4q/ePN5uO59LK63rmrEpLTVl3BwoVZOwQg2yMmKAseh76R0Gmu+c5gLliLL8lBpgbrz5Z
 3cPnf5Bw9C6rtCD79jN7WOrH7s2L3zA8lv+dW6bYKaeqnVU3qCboD6DKjHaPSFjzaxBl4yBufl+
 fgwU8oNM4bGR4taph8K3R6dZj3n+NdRkjvkbzLcvpIOdZ4cHiYfeqjbwo0kyOs9frP/mVlzuS0P
 5e4duwKIoPeLKIwVsPSuvA82aJsTVBko+CCVbfF/z4DSQ16KPpQvaWW3Y90RvlraPl2E1zIk112
 Br9SlSBOA3C2aNNb68xZ1tD+7///ELJzyImkjHBZO+pqLsz4K8EhrXVfCpiO7+/AWpB3f935QVk
 CqbBBo7CP0idj7n2mBX2e7pl+pxNXaqd9tY1SFoNbknjYZzOTs+IBEUa+stSiHEGk1ZEZz8wnUu
 saiGGzjdZuVih+Zg17YQCppqziRBwx+8xlTnQ2zrQ6Ekm74ELFEr4oEeZkqyKZJFEUMM2yM99ti
 i7X/9OyENnfPMQVrRURAy+bTMo6WA3FrHpSmKwKhUUvZGPL1FAe8X1Qj6/AXL8Uje+pEziaX97N
 uJ+gwRVd17nATksYi7i1vyD7paL6eEWx+ZNNQEj1ODKtEMG9GLjtA4zMs5lH2gmgCkvRqJXUAgw
 LytHDHFAx+j0YJg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Youzhong Yang sent an email to the list (along with some draft patches)
that indicated some nfsd_file refcount leaks. I went crawling over the
filecache code (again) and found a couple of places where we didn't put
references when we should. I'm not sure if it'll fix the problem they
reported, but they are bugs.

Plus, let's start counting nfsd_file allocations. The last patch adds
support for this.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfsd: fix refcount leak when failing to hash nfsd_file
      nfsd: fix refcount leak when file is unhashed after being found
      nfsd: count nfsd_file allocations

 fs/nfsd/filecache.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)
---
base-commit: 24decb225ed20a5ba46a79f4609e109cb0e4a359
change-id: 20240710-nfsd-next-01e2afdebb31

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


