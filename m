Return-Path: <linux-nfs+bounces-13834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF60B2FD9B
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 17:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1455BAC2EDD
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D14469D;
	Thu, 21 Aug 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHfT+d31"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E652E3B0E
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788005; cv=none; b=PKyBCVOFvYcNmNjiuXztcb3H0BztyBLXf4kA83f/IcevPKBKzbnZNp9CWqdXlHLYHkqTAFP5lNa8ZFWVNReG1w2gedO88ZQZbocL6Rhpu92ztoWqRC9Fizf5gli22brYZhAlH3CcbUmGsygIfQ62xEwRv1GFR8kzT+H0Dt2QVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788005; c=relaxed/simple;
	bh=+V11fON58tjDlXSVxAIObR0hMTPppVOEnzaVXz3aZ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAYgrMnIIwV6iKHjegd2EC0tuak4tgcm8JA/F2aymrlAM+r3NsTL6acfaAE6c5OX4LhQ1mjTNoD6mhuLOca/+kSp8FNuMFihmikOqc0ZwgWFyIqaqQLnAwzrhcQFWrkK77IUhBmsW1kYQ3teR8kYAh/5viudhp8SnxeuxN5Dzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHfT+d31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8B4C4CEF4;
	Thu, 21 Aug 2025 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788005;
	bh=+V11fON58tjDlXSVxAIObR0hMTPppVOEnzaVXz3aZ0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHfT+d31OwKS26fqLlz8mWgzOigDhhJ8t+OufiZfiq5iZJfftU5Z6e/Q9Bzzj6oSc
	 OfNtQGcePIKG1Qd0ZsgztIQY7OdZUbyWtWMh8PycyzTACWJTwcP18a4RF7dSmQGwKa
	 85k40BcLZ/6eBH1NHqmGEwaYR+XH1uazuPcewEBehQz1DqRAuYxBHnTvtxW4pcmRGI
	 ULeqW4GhQCcGvEgQGpZJwcp1Czdps/L09774Ll0V/YPmzYzggLtb5O+b/FgvbGI20S
	 AE4tt5j0LbPZ/LaqEjZJ6SLKr1DgCNM5R4zzu7flN13foy0OnjpNqye4jVyOJSqj4E
	 KK1gW72hmJbGw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/2] NFSD: Reduce DRC bucket size
Date: Thu, 21 Aug 2025 10:53:21 -0400
Message-ID: <20250821145321.7662-3-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250821145321.7662-1-cel@kernel.org>
References: <20250821145321.7662-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The common case is that a DRC lookup will not find the XID in the
bucket. Reduce the amount of pointer chasing during the lookup by
keeping fewer entries in each hash bucket.

Changing the bucket size constant forces the size of the DRC hash
table to increase, and the height of each bucket r-b tree to be
reduced.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index d929c8c63bd9..ab13ee9c7fd8 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -27,7 +27,7 @@
  * cache size, the idea being that when the cache is at its maximum number
  * of entries, then this should be the average number of entries per bucket.
  */
-#define TARGET_BUCKET_SIZE	64
+#define TARGET_BUCKET_SIZE	8
 
 struct nfsd_drc_bucket {
 	struct rb_root rb_head;
-- 
2.50.0


