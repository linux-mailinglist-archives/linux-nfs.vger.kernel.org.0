Return-Path: <linux-nfs+bounces-16730-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF5DC88334
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 07:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28E854E251C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 06:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39146315D40;
	Wed, 26 Nov 2025 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ6W6Qh3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354125782D
	for <linux-nfs@vger.kernel.org>; Wed, 26 Nov 2025 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136893; cv=none; b=iGA9gEiCX1l9zKAZcbAqn1Hw4Vqk2DUB4h0ESnrSc75lMhmPRLbcgh4SM1t/DUfzue4H+sruCL5f7ebuXzQCGzePoXx/5x4B6wQ+Rc6DeJUc2JkX0TvbR+s5iHfacQyYDwMR4jh0+AnLcJDg1LiPDJe6N1EpWzKiEvxU8bnXtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136893; c=relaxed/simple;
	bh=7JW2UfJcPYun9ZRgJ1UuofKyZlZihlYW0VhYVPWow6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzA0J7ZRjqTwPA9Qvp4q9NZzeSWC2JbrNfE2FjOjMzYZjQ1arZ+VaOu63dZnhLdgA+jg7pWm0W++ZDEJWQj3l67yOvIvA8zLjfleJwE6Bstmve4Hpm48H0sIsE+mAMcHtrl68YB7OH3Y+o2Jp5JbTobKdqFUFo9/5aEC5HP7tBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ6W6Qh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1D4C113D0;
	Wed, 26 Nov 2025 06:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764136892;
	bh=7JW2UfJcPYun9ZRgJ1UuofKyZlZihlYW0VhYVPWow6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZ6W6Qh3FhS9Qg9ObV1ZCR/DUJ8+p7ruB8vGewziEqeWHnAULLhrIxv1SQuUP37cM
	 g+5BxqnnXAMwbWGYTPR/2blc60lt+4tU9gSHpBbmjBfr30vMmdRT9mDmMSypicQzYN
	 AeWwfXIZD4wJN8VD+eF7O3fUokDjw+4HicRTAYIJM8ADUHv2IzCO7/Ka8DJSQdMKJm
	 GOfH/I4ajWGaeLXOMy6N/liiFQyHaKdsKeWpLm7KkHNULkOgrsO6YTor7AS/dznTn6
	 XuNXjToCX2x1nox79qV85cSpdythefEXK5SUfbmqPKkRLRlI854xNjw0zVPAg52ESj
	 gy9eE/SmEdNkQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org,
	zlang@redhat.com
Subject: [PATCH v2 3/3] nfs/localio: remove 61 byte hole from needless ____cacheline_aligned
Date: Wed, 26 Nov 2025 01:01:27 -0500
Message-ID: <20251126060127.67773-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251126060127.67773-1-snitzer@kernel.org>
References: <20251126060127.67773-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct nfs_local_kiocb used ____cacheline_aligned on its iters[] array
and as the structure evolved it caused a 61 byte hole to form.  Fix
this by removing ____cacheline_aligned and reordering iters[] before
iter_is_dio_aligned[].

Fixes: 6a218b9c3183 ("nfs/localio: do not issue misaligned DIO out-of-order")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 560caa2e4238f..eeb05a0d8d260 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -43,8 +43,8 @@ struct nfs_local_kiocb {
 	size_t                  end_len;
 	short int		end_iter_index;
 	atomic_t		n_iters;
+	struct iov_iter		iters[NFSLOCAL_MAX_IOS];
 	bool			iter_is_dio_aligned[NFSLOCAL_MAX_IOS];
-	struct iov_iter		iters[NFSLOCAL_MAX_IOS] ____cacheline_aligned;
 	/* End mostly DIO-specific members */
 };
 
-- 
2.44.0


