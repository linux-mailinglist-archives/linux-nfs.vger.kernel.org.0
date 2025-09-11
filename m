Return-Path: <linux-nfs+bounces-14296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4FDB53708
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7AE1611FF
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016CA3469F5;
	Thu, 11 Sep 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdYL3/17"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B13469EF
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603529; cv=none; b=hXwLgAvXa8rP6cSOK6kwOzm1qMo8ArfoXayI1HLdQxIJwanyuOq06VRTilo63LjMmoR2vZLFTWSRzcK7OXKHTWe8w3zu8f7WcaJGJi15tqWHxzqbjyjTsbGzWHT0XJDV+sTNUha8qKhZnByNdIo1tjfjKqQq9lAxUTr4rPt7dyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603529; c=relaxed/simple;
	bh=bpmXx5pmqlBhiTyYGHQjoA73KelUEZNC8HwS8K+Jx9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1AHX66x1TP/aRWJfFwTG/1MUCZjx91sRdJbeUoBw/+lY957RWYA01FSXI5tndfKpa353I+uvbDsWBHJvU9hXaNGHu8xSRXAf3yIa/z/7wtYl9ZpYGBfQJheU0fDN/vQxQ+vonuyeUplmRV36fBQGGO+T4jpaMTTngpLf3jnqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdYL3/17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF157C4CEF0;
	Thu, 11 Sep 2025 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757603529;
	bh=bpmXx5pmqlBhiTyYGHQjoA73KelUEZNC8HwS8K+Jx9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=rdYL3/17PswjhQVeEbYa4q3tVJvGF7gp0uNeny4020XHbHxb5DLUSmg+iFu2ESF1h
	 O6NtAPVCUVjT3xjHnW+AA5qDLzEci3D4osOP95vruvQoiU2H+gT/wbSpUwRvjTygoR
	 kAvWaxuu0pKDBZKveqhy6xU+HBFoSPlqdlxlwoJmoN7u8MZ6PURyzxZ8yxDlmE8t6B
	 06JL8v7SfJ/3I6W91fClx7NtsGWpj5QS1MIcl6mHx+JXUF/gycjuBy0pfv9OKcXPRs
	 vfc1pfLi+bDzNDu2jh/wYtgPIz03qIJhniBexxWW+n9y2BJL15qJXuKD/FdhiAuaj7
	 mPq/hhcykTgkA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Thomas Haynes <loghyr@hammerspace.com>
Subject: [PATCH v1] NFSD: Define a proc_layoutcommit for the FlexFiles layout type
Date: Thu, 11 Sep 2025 11:12:06 -0400
Message-ID: <20250911151206.15921-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Avoid a crash if a pNFS client should happen to send a LAYOUTCOMMIT
operation on a FlexFiles layout.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/152f99b2-ba35-4dec-93a9-4690e625dccd@oracle.com/T/#t
Cc: Thomas Haynes <loghyr@hammerspace.com>
Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/flexfilelayout.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index c318cf74e388..0f1a35400cd5 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -125,6 +125,13 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
 	return 0;
 }
 
+static __be32
+nfsd4_ff_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
+		struct nfsd4_layoutcommit *lcp)
+{
+	return nfs_ok;
+}
+
 const struct nfsd4_layout_ops ff_layout_ops = {
 	.notify_types		=
 			NOTIFY_DEVICEID4_DELETE | NOTIFY_DEVICEID4_CHANGE,
@@ -133,4 +140,5 @@ const struct nfsd4_layout_ops ff_layout_ops = {
 	.encode_getdeviceinfo	= nfsd4_ff_encode_getdeviceinfo,
 	.proc_layoutget		= nfsd4_ff_proc_layoutget,
 	.encode_layoutget	= nfsd4_ff_encode_layoutget,
+	.proc_layoutcommit	= nfsd4_ff_proc_layoutcommit,
 };
-- 
2.50.0


