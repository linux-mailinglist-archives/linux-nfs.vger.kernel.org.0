Return-Path: <linux-nfs+bounces-1398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A383C806
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61976B229CC
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA300129A8D;
	Thu, 25 Jan 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihIWLL47"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6727129A8C
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200191; cv=none; b=ebXfWt5zxpynyPOFT7tdFxK32wSTJnncHbNqgHa5Qlp3MjtVv75+SJJfRg16sIjcaJ55vXsxBEzJkecq7Odo1J71ewLEIPj0Kwq5cCqdzsX8O9y5hnQ1fEYIWvm/kCj/UKTbCcx+F4jLb02U1gXsYg2DmolwnT+dN7jSklR2Wj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200191; c=relaxed/simple;
	bh=ew6rJvn++WxXwaCqxrMp1ipSOssALPhsQhScx9b3X2M=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4k5zllqgB40uLo91v62958zreVSV9eAVHCgjVk5Vdx/CyKsNEabgvdXmMpLdJFQBPHp0gJjGJJq3bLDaaW7UcdrTcbB2YfePnSdFFVmwhT9kbjGMKbJRlBWTROMLKHJpgMxEWTXXBWv7dXjztI/Ck6999gVJL66BFS5wrrRZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihIWLL47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22603C433C7
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200191;
	bh=ew6rJvn++WxXwaCqxrMp1ipSOssALPhsQhScx9b3X2M=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=ihIWLL471WT47GxjlATJnMl7COB0V5APnIFCZs9iOiWgcap5XlyWJLmgS4XjB97yl
	 2x+q2sNChaVM1B0/+uzKKmSk1pDchfJkC8YMSvug7EB7PdOSoVEs348caVVyf2NMOE
	 sYIMcG5QMngiGvUqcwOncEe9OCqGA6CMRC7e4ckqFx3aYIG+z14YabZWZHi5L+GUKC
	 QRho558NAvZM76jQ5LbOgnjwAQSEX6V0iwOoR0K/YVHe3JU8+/itIhaQ+g9wxBm1dc
	 agpZHGj9PhmQP+fnxc/zxzIkXYh379qKCsTH1Zq3sDucZP3F+gZBeRRzYBpZ7auAk4
	 /szwtrmfpeP9g==
Subject: [PATCH RFC 11/13] NFSD: Remove BUG_ON in nfsd4_process_cb_update()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:50 -0500
Message-ID: 
 <170620019007.2833.17281344766250004438.stgit@manet.1015granger.net>
In-Reply-To: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
References: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Don't kill the kworker thread, and don't panic while cl_lock is
held. There's no need for scorching the earth here.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index dc308569bc31..46ecb3ec0f8f 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1362,8 +1362,9 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 	 * Only serialized callback code is allowed to clear these
 	 * flags; main nfsd code can only set them:
 	 */
-	BUG_ON(!(clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK));
+	WARN_ON(!(clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK));
 	clear_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
+
 	memcpy(&conn, &cb->cb_clp->cl_cb_conn, sizeof(struct nfs4_cb_conn));
 	c = __nfsd4_find_backchannel(clp);
 	if (c) {



