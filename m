Return-Path: <linux-nfs+bounces-13234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B305B111C1
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C2F3A6175
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E92ED847;
	Thu, 24 Jul 2025 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAOGw54z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4D2ECE8D
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385471; cv=none; b=Tf9R98ArXK3BS4dIZ64cK5t/Ga+gFB3ZMeZ5cBQBcLHSL0iiUx9o8fDyHZm57eov7fWkfYU5aRct1LvbUcKf9CQ0To8egnsVxRb46PxyDjlhnL+jp6SBJnWNE5DXYopXx0QuRnpDXNa4ZeIbZ4084ChSXNH3bgUR6MkvCeUb/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385471; c=relaxed/simple;
	bh=0XRN9vNHynLjP9TWP8Rg1PwwLS9c/5Tb8/53FPQALtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3CX4tQKybPzN9xXX1irurpSKVf5NmZXtCwf6ZXbSfZ6vboO8Ifko7XS5/fIyJHvaFt9vCBHPhKEdippz6EH5i15XJDVDJRcs/XLUz8HYjT+jXcge+nhaHqzTRJo4HtB9lwnJFHa2gboWgCoiXXFNA7B1ILYhh1/Hq855+kVGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAOGw54z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB78C4CEED;
	Thu, 24 Jul 2025 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385471;
	bh=0XRN9vNHynLjP9TWP8Rg1PwwLS9c/5Tb8/53FPQALtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAOGw54zXTRbd3vtoQUJrz17MA5CY4RpC7VJfB3/IcefrnZeWOOh8YKy4aSsQnlCZ
	 LDOPXZknKHkBBuvMH8kMOU6vMJKZoLB85PM1hppruLjimPtlHFfbaGfk8ID1DFffxW
	 Cf97qzetHzdGOQ9W5rn0WxDFR3SVxpGKk2wBdMEpKp5EM2YA0sHsb3ZLA1i6d5rJ92
	 u9yWh69BTbApcQ9sq9KKa2AqaqZK9s3gEiPElPPA1D1e8rirL+4Th9vQU9rFmF6ErM
	 K8bshLaf9Hq8A+JTqJqdUSo8g0/qw72T1Vsm6FKuyBTP645bGQVc0J9GyYLt/PRcvz
	 T6hc39RafdsTA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 05/13] NFSD: filecache: only get DIO alignment attrs if NFSD_IO_DIRECT enabled
Date: Thu, 24 Jul 2025 15:30:54 -0400
Message-ID: <20250724193102.65111-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250724193102.65111-1-snitzer@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/filecache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index aad5f924d101..01db2aed82d6 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1058,8 +1058,12 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
 	struct kstat stat;
 	__be32 status;
 
-	/* Currently only need to get DIO alignment info for regular files */
-	if (!S_ISREG(inode->i_mode))
+	/* Currently only need to get DIO alignment info for regular files
+	 * IFF NFSD_IO_DIRECT is enabled for nfsd_io_cache_{read,write}.
+	 */
+	if (!S_ISREG(inode->i_mode) ||
+	    (nfsd_io_cache_read != NFSD_IO_DIRECT &&
+	     nfsd_io_cache_write != NFSD_IO_DIRECT))
 		return nfs_ok;
 
 	status = fh_getattr(fhp, &stat);
-- 
2.44.0


