Return-Path: <linux-nfs+bounces-12186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A70EAD1504
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 00:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634133A8BD7
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jun 2025 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678AD1898F8;
	Sun,  8 Jun 2025 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2IzDdPD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB713C8FF
	for <linux-nfs@vger.kernel.org>; Sun,  8 Jun 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749420536; cv=none; b=rUAdqjGZDIsjQh+h/6Ebmnn/lnzxr9IDynjWxMrnIqgAnCzdYn/86oZ/byn58hDy/AaQrEOrv+gGClT7EeflIweGqbPJDV/sCt0PuUZeMw9jbLCgmETQGNnJ2S8u55NMblwX7S4Y0Kuk9bYc7KqdKcgY8ZzDFY2kjcI3rmCCNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749420536; c=relaxed/simple;
	bh=vsZ+Qi8qCCvNTDx0hi14ye8/lXFEA2eH1F07ktmC8sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLN/O3NktSYKF4Dvl2mF6qvon9H7MoERbMXo+UHVC5nnfUm2lX5IceJbe5+/22A7pdyTf6ulW7hxKHlYrb5JWPDrcKwjQG8HgzLVIyLaL77iir8ERLPvUD8niqXUxAHYWhtvjyZt1rLlZQGTpl501o8N+oE0igcKSK0Pu/x53jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2IzDdPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3516AC4CEEE;
	Sun,  8 Jun 2025 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749420534;
	bh=vsZ+Qi8qCCvNTDx0hi14ye8/lXFEA2eH1F07ktmC8sg=;
	h=From:To:Cc:Subject:Date:From;
	b=W2IzDdPDNgEn4+caFZAAgTSyzxIFyqHnB9SP1gmobKXvJPO8O7m2BNSPCAfWqYVnT
	 epuJES/v4KEaGuIWUhO+9XWwvfFl83rvGIZW6algdo0njIq4p/B0TvPFJCErE+6S7b
	 jdqszOWBAA+/vSa2OsAiQ8CvdWhpSy0d6MZJR8eCmK9x4HN/YxaaqhxGmrSfige58m
	 9JiC7bXTZWJmw4lCJlm+BEbjUbBp5iOsK1BNCr73Kn0btruS3x7NcXo83I4nqkj4JG
	 +safM8bAm0MSSxHVLIoyVE2zWrbLeCi9poXf81pwZ29coEvzwkOvciFkCAI02S0ysc
	 hhF8vcHfMcHwg==
From: Chuck Lever <cel@kernel.org>
To: reviews@web.codeaurora.org
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] NFSD: Avoid corruption of a referring call list
Date: Sun,  8 Jun 2025 18:08:51 -0400
Message-ID: <20250608220851.2230459-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The new code neglects to remove a freshly-allocated RCL from the
callback's referring call list when no matching referring call is
found.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202505171002.cE46sdj5-lkp@intel.com/
Fixes: 4f3c8d8c9e10 ("NFSD: Implement CB_SEQUENCE referring call lists")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c | 1 +
 1 file changed, 1 insertion(+)

I don't recall seeing this on the mailing list. Targeting this
one for nfsd-fixes.


diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index ccb00aa93be0..e00b2aea8da2 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1409,6 +1409,7 @@ void nfsd41_cb_referring_call(struct nfsd4_callback *cb,
 out:
 	if (!rcl->__nr_referring_calls) {
 		cb->cb_nr_referring_call_list--;
+		list_del(&rcl->__list);
 		kfree(rcl);
 	}
 }
-- 
2.49.0


