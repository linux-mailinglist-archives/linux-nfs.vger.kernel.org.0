Return-Path: <linux-nfs+bounces-9956-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F17A2D01C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 22:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667FF3AA168
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742B1DDA00;
	Fri,  7 Feb 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx5QNiu8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6B1DC9A8;
	Fri,  7 Feb 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965255; cv=none; b=KpbKsbxDN2N7lhu8Jp01tp1kYTAlTArUJn7wOqrK8OUs9qpbLdva0zSKhT5GXjGiGbSzt/a9wmnIoGE1az/dH7nr7U3Tw7wLMDdbTM+yjpXPtGnhyVW7kmlEqIJLeV3BnVCHbc80HiLMBo09GYhRZJX1OZLOHRDJfr/qOTybChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965255; c=relaxed/simple;
	bh=YXJoT4BWpH3GRiMc2XyfNBEcE1+0tC/CS3n5yfVPGhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqfLdqL0KFaRVeOWwE4zz2Xpdd/S40lj2OWWbNQY+7bm7Uz/wNM0wsuBiiGKNq1RVzNnSg7qqfSZKs7PZnH13G+8E2zLwkkzKA46syOr5xAU8BG+g26LfWnSrmfB2Q8H4n7iuKn2HUhbF0x38MAjSKun36Al+Eom81o3Vrtttzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx5QNiu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44928C4AF09;
	Fri,  7 Feb 2025 21:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965255;
	bh=YXJoT4BWpH3GRiMc2XyfNBEcE1+0tC/CS3n5yfVPGhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bx5QNiu8OZk7oG888QpY2JInk+q9F0WMrPA1pYPrF/FkiOdH9GBEzJ8BFjk6v66Ry
	 auJqINygxXyUe7S3coNi594VJpHZeuOoEXtknRg6Ehlzh23XbUvqV04uy6Pmq8Bg6J
	 ZVqXCjcgAeQa3lLdpY+JpEdLnpcB1MOL6hMymRu4HX91SXXX29VPdaqX/C5PPtqEMF
	 jjbzn/YPawuclqzWNq3dA0WrpBsayTR83jPcs1f9+J9OAQ9yZZdxrAOT5QuhKZreHb
	 PpEE5bSPlKQSQv6Xw7zplJ26dJOymaXYg35klaAin9jSXeFRjxZUgZIWywTIozd5fx
	 y6VgOKXH8+7vQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 07 Feb 2025 16:53:52 -0500
Subject: [PATCH v5 5/7] nfsd: handle CB_SEQUENCE NFS4ERR_BADSLOT better
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-nfsd-6-14-v5-5-f3b54fb60dc0@kernel.org>
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
In-Reply-To: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YXJoT4BWpH3GRiMc2XyfNBEcE1+0tC/CS3n5yfVPGhM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpoEAxJvD3XkScIfFRkfDkG31HTWMZ/Z1AEKFs
 rhrpyqx8ICJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6aBAAAKCRAADmhBGVaC
 FfKPD/9rGaYsdWg5mUVUlmA83GYJ2wut7eb6+zM2bZuV850BCmfVmCsnPJuivyCaprTuCM9y/+P
 Bq9ZS+OQlZyV67t9dgHkfJ0wYR8Wg86tmmkDCdJVX7TCKgv+O+qVmR4gswWBinr+yhyc5RIaXjF
 by9JSAWSYa9pp2qElZ3QbhwcZ8eI2pGc6KE8zOO/K6QG0f3BXugvW/yYxA7Q0gA+5YzRm7TkDhW
 /Dri7DyUltat2nU/un5mDoL5+z6fLr5qTbCFPgT2cyDqhgNw9DHiUntn04QetCDrfWhnoNBTsU1
 0b8/q0gx2mG+2wtvDVcy35CUeZZyf4b2rbn+V5zqSz//4FBogLgjQytVyHNIEaGjdsWjzy2tPgd
 RHQ7XHKSicjBunFceOSKCDPfYV1x8iMmLsAl1zpLHzAeJWkiaNBDIg303IDIRj5vbX3XTehQ7mM
 zq0mSTbjvjNTrRqwqazj0NIlhEM2tziMbWlNfPZiH1o22Nybkc+AxZfNBk0Gee+ZnqMhqfF9cxz
 S01ZOAxhbnlus8khIlztYINlQ729tXiD7d80XpAlZ+3AJrdANI36VKusN5Ec3Yyb8TuF5+hhHda
 QKBSci/vF5EtPGEDMDWlMTVpPL0brJpJQh7eHILcfOgWsffBXVg6TZOQfGNZj9IW8stWt1Lw0gl
 LW4nSa3Aw/uow1w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently it just restarts the call, without getting a new slot.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d307ca1771bd1eca8f60b62a74170e71e5acf144..10067a34db3afff8d4e4383854ab9abd9767c2d6 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1394,6 +1394,14 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
+		/*
+		 * BADSLOT means that the client and server are out of sync
+		 * on the BC parameters. In this case, we want to mark the
+		 * backchannel faulty and then try it again, but leak the
+		 * slot so no one uses it.
+		 */
+		nfsd4_mark_cb_fault(cb->cb_clp);
+		cb->cb_held_slot = -1;
 		goto retry_nowait;
 	case -NFS4ERR_SEQ_MISORDERED:
 		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {

-- 
2.48.1


