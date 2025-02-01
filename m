Return-Path: <linux-nfs+bounces-9817-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E17A245F1
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 01:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0B63A87CE
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE619BBC;
	Sat,  1 Feb 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6AD3IAL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D8817C91
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370091; cv=none; b=FFrOBSwiuk3BcMgJf0c7898ThflvSfWHkDiX7XqFJZE9FltbTL7NXYYk5CmQp3VhopKFNXAUK5CwgOblrXRk/9KYtsITo8hS0vl7xNImUtRBw10Hgo3/kWqoc0JH+zf/D0FNHsQn0Gq4QVvBc1mc/AiN6KQVtwfX1bG+uwOnGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370091; c=relaxed/simple;
	bh=VuC02b5yS8ke6mLcq3O5RcDiTMROgA0M5SpWwePwFhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj/lUm/hvyeqrdQsZ2qnQU8SZ6tjpBka3HG62ZScCK4XjX28VH0tu7VuOsl2McLoePZybMgvOMduW16O3yX2kNpPACScW/y5Wco7LT9cqQIRcNHK1+mW4cvGuLsmSWr8/Lh0fkf9VLbH17XgbIxJwD2OCX9XvSKNYHJMQ/FioY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6AD3IAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D44C4CEE4;
	Sat,  1 Feb 2025 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738370091;
	bh=VuC02b5yS8ke6mLcq3O5RcDiTMROgA0M5SpWwePwFhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6AD3IALukk0HdYsYyHN5Dpn1JI96f+wbRxuc5KxL8Evd7QN2x0F9fs+8xXbxjp83
	 xHmNDnneOWEZYgkB4jTVCR5nV1HZo9dPOjhK4Q7SjuxV0Z0O6tXd2ywEl4fNm46x0r
	 3yhNsWSeprETLV0CvvZy58wajHcwQcn5to7Z56CFtDv4P90JWqkM9NyKKM1d7SsPld
	 3/yOWVoHbDBSu0D4uGOyVS4bGgkzjmEADtj7kuDjsAuH+H8t1eB7Ng/7HyVsP/uFuA
	 Gcg+4Oo1HXl6CVcw42rvklukonMzTXYJ63/1VVlAUSq+a6w1WkYYBEvkK7tCyKrop6
	 NR5TnVCtpNhsg==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH v4 1/7] NFS: CB_OFFLOAD can return NFS4ERR_DELAY
Date: Fri, 31 Jan 2025 19:34:41 -0500
Message-ID: <20250201003447.54614-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250201003447.54614-1-cel@kernel.org>
References: <20250201003447.54614-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 permits the callback service to respond to a CB_OFFLOAD
operation with NFS4ERR_DELAY. Use that instead of
NFS4ERR_SERVERFAULT for temporary memory allocation failure, as that
is more consistent with how other operations report memory
allocation failure.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
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


