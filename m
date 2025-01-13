Return-Path: <linux-nfs+bounces-9164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E109A0BC11
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148F2163C1D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC021C5D63;
	Mon, 13 Jan 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3it+4uQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE21C5D61
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782367; cv=none; b=cbT53EuDW5kNHwKpTFJS14KzU0KYGKIqs0qirrnnj561ZZJ4k9T4FAnzYFV/hgujGZt57/HlcwI6KCQJpZTJn7zrF9DPtD7Q7ouVVcSON5j2ib59LZLfxfKXJXZZj+GN0dcjmFkxI/7DSwaVdfOmKceKBoQzfNUTG0E40BMNkEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782367; c=relaxed/simple;
	bh=IkYQKu0ekNg3AM3qZGM6i634s0oQIoV7/1s0LxyIzHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDX83fQvz32ovJ+3cP8MoZKnI5LCmHf2d2fynT1Gjleh+60w7AEikB67HaUl14GXTmI9XBZuNQnyZlHgwyW1HNTK07bhaYoBnRulx0IVZY5cMq2uTUQjwLKpgvjHBhCH4uHKVRnaYolWZNZTn0JWuqa3svCfrx1x7W/6/2K6LX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3it+4uQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9A2C4CEE4;
	Mon, 13 Jan 2025 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782367;
	bh=IkYQKu0ekNg3AM3qZGM6i634s0oQIoV7/1s0LxyIzHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3it+4uQmzQ+MtDOPKV2GbLyyuVHLoQfBoro7DnmAyWbAQjiwPOuY+oll+JjovWXN
	 Il8/ba5QTc1QgL8MbdqaenuIrNe/Icuvr7LN2u4ESwsbtM0rOsnMx1+8PJzgAaMngV
	 IPPYC5LOYeXEOJNQNWByFVUqOnDD2I3B6b1cbMAxrWu4ZxUStkJS6pTDGvgL3GspOb
	 +Tnn0B1Q6HTKkPZ/K4qQlAYBGV0NJlXHmVHiR/a7paFcHZKj0ykxunVBi3mzry5Jbv
	 YR/cqBCxPOCvgscViikgBsB35+V5M43LGUlleVekcnfFGpuAZ9keFYnye7EJQlJexr
	 uDxM1eMwNOHcQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 1/7] NFS: CB_OFFLOAD can return NFS4ERR_DELAY
Date: Mon, 13 Jan 2025 10:32:36 -0500
Message-ID: <20250113153235.48706-10-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250113153235.48706-9-cel@kernel.org>
References: <20250113153235.48706-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=chuck.lever@oracle.com; h=from:subject; bh=UQXPAlUj4VLIOdz9PHZi/z9NMFIjPoUUk4StFgiNZVE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnhTIZFUTB2bFPhGkk3GO296msNyyyrvuP0MKdA ZwcaGfbSfSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ4UyGQAKCRAzarMzb2Z/ l+ZbD/9QJ/rvDSTjDsqw3BwCmcJBdx9ZLYXHzbRRKrVXHlpL9Th/wE+Bi8eKPSvQ7nPyTPMLSsq sA00DIPciYRSvrQ1zPKGjmSE+6gROE0rgU/ZUC7B2b1by06R66p/3Q68lSZioIdtapBwRnpASjt ag4cxkuHgw0cMt+NXVel+LofOOzd/MtKy16gnnKtEN4l1tPxoakKQX5sbTdv34PjZH7VM6zxy0j iS2mVrrf1BtSa5hP/8C7lI0Mj/3asqxa/hc+go80M36Oh7ewNK7qmuUKdVXx71HCZEARi6ZuiDc V8j6tZrKZJ6IV7+ccWBJ48RpTMymmzzoQonD5+FXrkIYCka4yVe4P7yy5HnsyUmtur1lgMxdXrG J4huwyt7UsIwS//3a6lb5jlgZbE2E/WeR3MoD9gRa3lAny1DE65XAxxnW7OOWfNaQmoAZHiA8gM a2I/yuAF9tY9ek2/AzYyl/Sb5mAFAl3taIVkhN8l+6jKtaedRd6XRox9JADUaFxu/f11ADAKYm1 bDjUgwDuko53VGK1FfqUzJeBwk5s6ChSI8i+i2xJbuxd6XEQHGxm3Pq3Ng+nhn6BY7JjYuURlNq ueZ0pBQXOrfotAygEuOdSqxkQs+Y0uCjV+tjcNfRQVtZhXC1CjdWprZvc/XCuFG3pVq063wr4w/ UxMdfBFJq4e6tEA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 permits the callback service to respond to a CB_OFFLOAD
operation with NFS4ERR_DELAY. Use that instead of
NFS4ERR_SERVERFAULT for temporary memory allocation failure, as that
is more consistent with how other operations report memory
allocation failure.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 7832fb0369a1..8397c43358bd 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -718,7 +718,7 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 
 	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
 	if (!copy)
-		return htonl(NFS4ERR_SERVERFAULT);
+		return cpu_to_be32(NFS4ERR_DELAY);
 
 	spin_lock(&cps->clp->cl_lock);
 	rcu_read_lock();
-- 
2.47.0


