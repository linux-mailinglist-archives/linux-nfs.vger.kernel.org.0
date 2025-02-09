Return-Path: <linux-nfs+bounces-9979-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C773A2DDBE
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 13:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B095C3A684F
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4831DE889;
	Sun,  9 Feb 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7wzWN1D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29551DE880;
	Sun,  9 Feb 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104296; cv=none; b=mLvwODxU2ylO5RqJLcK1ZOpJxiaOv9z/jLiR8o5HBw1h92WMrTvHvE6v3DrhA+vCAfmLXg6R2M2pt9f/Xt38+uQ3jxh4/8xlspMuNwXuGoe9/uRCfT7QvB/trOnpPwdScqJmsqFcJcbljEYXt1dSBhb6SBmFGf9XlTE1r6B10kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104296; c=relaxed/simple;
	bh=om0AQQbo0fmc6z93AqUy2dNGBvmD49MIdAneT+a4+ZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDsRSpjNgd+8k0nNZed4ZMKgEU7gkVkwtnZOaD1Yr5KydHzOeyLA/U0LmfHHPUCDjcCqmrly2blX6lA7iPiTJo/iQV9F0lulDYOg7scTqz9Wj6QHn/ESIcY/ZL/7bYBN25+ffeycyxDgrOZmqRDckakvGYXacHVwfRPJWA5vwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7wzWN1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67543C4CEE2;
	Sun,  9 Feb 2025 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739104296;
	bh=om0AQQbo0fmc6z93AqUy2dNGBvmD49MIdAneT+a4+ZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o7wzWN1D9zRCbZZ5o0v0YrJ6q7aHjCgaX9OHWrECbkDsJ7/TgxulxKQzlW0x1D1WS
	 +F/rMSLXjGqBIoxc2i+CKnU8ruV7ZjOvJ+Uejwt9rU/c+QbCc2bKALG3QcKn3SXu0q
	 i9ZO+2a6hd9DViutxUjud0c8yLZSJUV5RhKdQrTyv0tavvK5GbNy07Hwy9Gynjig/t
	 upRluTXJdV3LiJ45gbRMdTKnHxxDHnfraTxsWiwfS7N7M0M11XgNbYIDiFagpgu94O
	 mut8cqfPIlkM7mxlRGxrEi7Y/U+g5GLB/T5q3so1bHXiIa2BUIH8ybaxcDDyxHbKRW
	 7X+puYAfXn4WA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 09 Feb 2025 07:31:24 -0500
Subject: [PATCH v6 3/7] nfsd: always release slot when requeueing callback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-nfsd-6-14-v6-3-396dd1bed647@kernel.org>
References: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
In-Reply-To: <20250209-nfsd-6-14-v6-0-396dd1bed647@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=om0AQQbo0fmc6z93AqUy2dNGBvmD49MIdAneT+a4+ZY=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGeooCOgbx46o8uwYGz3bNxPIAL0+BCvWnIF1TMXC19eaGdLT
 YkCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJnqKAjAAoJEAAOaEEZVoIVDkIP/2Gh
 oeQ9bcbSj6D06Y8of5vWIMFQPT3VBkXIM2xt1ZtSOIJiRaqExiR/ba97P6zgrePkWzUjWBP4eKM
 yUxDVq/y0kknXYTq/jFaGdGAKNdeO3iHMqeyI7l28Tgvd02K15e3B/RrUClUApa6LXgHPoKWUh2
 Boop4xn+1Bi7IHDocS5P3XfsBYiG3VGa/N/mkd7+f5hP8pstFw1XI0JLlSk9G6DdEwa0ykWJMS/
 2pMFgWWX+EbV/nLLwjhUOth20aX9DSbZa3FntavbNZNnlYp2NKJCBqEUXUU8O3uZRhZzDrQQaCi
 NPfu1i8xAbcLFrjA0Gza6feCtgkSy/xqnSfjGfXauPyXGTpRxc7dAUBRJ0RG4nVekt92/0NMTj3
 8+Cfaauicbb/mhJIQOEYb34DxNnPEeLLKOxxFpIOH6+NHGbQtxXj4n47rnO6GMzro2Y2Z7/GKtK
 A7vo3E3rog+GRYPQfNoiM3O3NVwjx2LVRJSzBMVpFD1OimKL2eg1pXP5yy8TljsRCMOF1x8/b8J
 j5K20UwDYV4QbXIgPhyBEyzoDGYuZjh+6nvIBUSvdysajT/WGj6bR6fb3xVpwhFH7K7xYOAhD2R
 NkAdJjqHARwkadmRLNPtAKApTkpHUnrNKo2or/2s6js8hfoee5q3X/HS7zw5QwaY3hQO6iF77Un
 SQnpK
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If the callback is going to be requeued to the workqueue, then release
the slot. The callback client and session could change and the slot may
no longer be valid after that point.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f983d2879bd3fe4c5aa2b0381f968fac753d79dc..7596d0f7dcad44f462ca483979b9c9138ab5dbaf 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1405,6 +1405,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	rpc_restart_call_prepare(task);
 	goto out;
 requeue:
+	nfsd41_cb_release_slot(cb);
 	nfsd4_requeue_cb(task, cb);
 	return false;
 }

-- 
2.48.1


