Return-Path: <linux-nfs+bounces-11327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EBBA9F9B8
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0C03A655A
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657D2989AB;
	Mon, 28 Apr 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsbI6l8k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7142989A9;
	Mon, 28 Apr 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869039; cv=none; b=JgW/D2P/wuWMq7kX6sqfVhA56rs0lss0nSMPCMQ9tyGc1dI0j1u0rrUcDdsohQnm1yqloQ6wS812Fdkc/y1mnsahrDBsGnwWJmFjmx6JAJpFB6p48FAKWAKHIGw/aw55Enf/fMm7uuU9743W77iS/hG8VuLMIOSljvLAK/18q5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869039; c=relaxed/simple;
	bh=hTxhhFhFmpRgogV+UjGtgEdYxkdl1CPGTvVos3t08KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K49qK58A7qaOtgo/rg/MuXwlEE0+NcPM/j/26FAC4voLGpR8U6YCY18BPnjDeFc5ZB5qjgHuvkG+MlCeLYygTd6L6TiTRUaLXAge3DC6zn9QPbIT9vlPjKuQvKKBobaZKjuPuslE86nRXVASzimsFABUBYZ+PXByK6EzxvwcgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsbI6l8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC70C4CEE9;
	Mon, 28 Apr 2025 19:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869039;
	bh=hTxhhFhFmpRgogV+UjGtgEdYxkdl1CPGTvVos3t08KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsbI6l8kfSBUgEkCS3wS/0FoiRD4TrY5aPmtrZ+Tsc5WhoIddjPJKDn6u1eslVre9
	 v/UPNXKCvrMmSTdX93wrEkIia49IKNnA7OlFoqOH1zVsWWxAhu6UP5io/0x4iBS+F8
	 kLlmsM56Wo9dwj6sqWavuu4y662wH37K2qY0hl3A04cFfNoqQ0q3YJlJgDQ2DmB/Yl
	 qA0lYAZwvdFcIFN6f+YzFivQGPX/WpkzseYz6/LTK32gI2LvbDJkdjS9MsW6IRcwr5
	 b/216vhYHL76j43/bacqNoZ6DPDeRbQyB10X+02oT7SPFAjLwE9rDUJ6YTq+wTnYzV
	 cdZw8k8hXVbHA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 13/14] NFSD: Add a "default" block size
Date: Mon, 28 Apr 2025 15:37:01 -0400
Message-ID: <20250428193702.5186-14-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

We'd like to increase the maximum r/wsize that NFSD can support,
but without introducing possible regressions. So let's add a
default setting of 1MB. A subsequent patch will raise the
maximum value but leave the default alone.

No behavior change is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h   | 9 +++++++--
 fs/nfsd/nfssvc.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 2c85b3efe977..614971a700d8 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -44,9 +44,14 @@ bool nfsd_support_version(int vers);
 #include "stats.h"
 
 /*
- * Maximum blocksizes supported by daemon under various circumstances.
+ * Default and maximum payload size (NFS READ or WRITE), in bytes.
+ * The default is historical, and the maximum is an implementation
+ * limit.
  */
-#define NFSSVC_MAXBLKSIZE       RPCSVC_MAXPAYLOAD
+enum {
+	NFSSVC_DEFBLKSIZE       = 1 * 1024 * 1024,
+	NFSSVC_MAXBLKSIZE       = RPCSVC_MAXPAYLOAD,
+};
 
 struct readdir_cd {
 	__be32			err;	/* 0, nfserr, or nfserr_eof */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 9b3d6cff0e1e..692d2ef30db1 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -582,7 +582,7 @@ static int nfsd_get_default_max_blksize(void)
 	 */
 	target >>= 12;
 
-	ret = NFSSVC_MAXBLKSIZE;
+	ret = NFSSVC_DEFBLKSIZE;
 	while (ret > target && ret >= 8*1024*2)
 		ret /= 2;
 	return ret;
-- 
2.49.0


