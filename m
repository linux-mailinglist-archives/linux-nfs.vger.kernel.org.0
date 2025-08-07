Return-Path: <linux-nfs+bounces-13482-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1AEB1DB9D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E73914E190A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00226E705;
	Thu,  7 Aug 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRdRlHq5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663026F45A
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583953; cv=none; b=ot3tvqysBQAGsBss4wFbVIAWTX0Ct17aJN0/bAfiUXYSJmbTTVOQPqCNPc9vyftk11sy78JwKpZq90GmJjx3wuEs0Du06QvIu6B+zNV4fvKmm6HjUI1qF6ukaaeeh+CPS429EQFmquqg4NSnWquQYgvVEI2vEn9QkfRthnvBbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583953; c=relaxed/simple;
	bh=x5C5PkZMQhMtJpXjPsDBF5RMxKW0USiLwxKGCu8dYjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwPWjaHi4PET+7zm9AAJXWCDsfnUSp2kT+kbaBeUMHAtsZCIZWbHYPZzSiSF5c2q2d2XnDPPtHqyva/2/O2fsgppyJQK7d2ow/oMWKNbPzcR3zFT8Ico5kIhyYY+y9cFgV6rBL61EuJOd8Y3NaSwiOx2sY+3a6WWsGDhJ2rQ+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRdRlHq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7E1C4CEF1;
	Thu,  7 Aug 2025 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583953;
	bh=x5C5PkZMQhMtJpXjPsDBF5RMxKW0USiLwxKGCu8dYjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRdRlHq5IfSXsI6DyMX+ecIImvPiLwuy4wJY1/r4jUPH1C9iu+Z7BcAsR6bkWy9ki
	 zb9f6/91eupL/EiSxRC2MnzX0GsHRvXzXMJp6JvYGVVJ97isFr8hgGToUpWp3qq7Fj
	 WjMknZ2zwA+drxpo2KGbXmyJTUajvNKsH93eMFVhCyOpWh6l548HaGNLjzs5ixW3lj
	 4vCo8EBWZu/gpji0SZXMo8Xg55RfbAtBNzyzoafIIBsygAGoStcwmYCx+y4bMejDbM
	 acSwOoPjshpDFfIUcA3lUn8Iab8Gm2iUZ/4NNAUfYT5tYXChQMIAM9hG/vFY8WLufW
	 Rk1CNuCcFnoDQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 5/7] NFSD: filecache: only get DIO alignment attrs if NFSD_IO_DIRECT enabled
Date: Thu,  7 Aug 2025 12:25:42 -0400
Message-ID: <20250807162544.17191-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250807162544.17191-1-snitzer@kernel.org>
References: <20250807162544.17191-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/filecache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 5447dba6c5da0..5601e839a72da 100644
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


