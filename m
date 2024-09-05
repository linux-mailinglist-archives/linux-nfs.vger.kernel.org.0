Return-Path: <linux-nfs+bounces-6270-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B86F96E2CF
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DE81F2235A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4AF190045;
	Thu,  5 Sep 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh+WOa18"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E737818FC7C
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563428; cv=none; b=feakzc8HAwUU5JmKZUP2YLZ/IYxCdYIwbKgbSSoKeqxZ10krfHgyeTXPae7uSZy6XNlGdgfojSxeKKowV0YANq980d5eBO7KMU6T8OXJRSwOvf/opaCIWNCM1PV5ykfxubAxizQzrg4bcv78OEEpW2u3mSprFuzQTmryWPlYGpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563428; c=relaxed/simple;
	bh=v6Kr4aZMTqmzIOXKWJ8riLtR4R1j9G1RaF8LPR4sBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcF9IC2LAilFee9iBDYvsWlO6yCBEjtJ+Jkx6PCT3bHWmklAOY2gcaTqNzr6lnmkRRQqmSqGlA7rd25vv32UyyFtPWOdiApx/V4i/yO+A8EV0N/UJInD+Fih3K13Dt+Rrb0ru/X6BFovW7OYkv3cEXrwkp+d+f5GuK2tLafr+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh+WOa18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CDDC4CEC6;
	Thu,  5 Sep 2024 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563427;
	bh=v6Kr4aZMTqmzIOXKWJ8riLtR4R1j9G1RaF8LPR4sBk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kh+WOa18kOBZZM9FdF5xoqi6TFelazBVi0d5H/qHEoR4bwq+BYXlQRWaHnmrb9uGt
	 dVicAeFoq730RfZC+qnZSHcE70l3eR7NXoyHiz5if4hRaSsNroW2b7Ri9hS1gw4GJC
	 HsJp0ekcEd4G4XE8n+rYK9O+FF9Zn5qhBy+fUlsJ2LXaZpilohwpfmYBYrov098jr9
	 aEsguWuM3th6iCUg5wd2W/DADFreYVpBBWXp6rHvV3wn+/IpCRZ8USXbnShWLzpbex
	 q2vRQXxaCq7bBefqR9RSdgfvK0jlrG3d51Wy1j2/UL4ZbdlaWM1PX/HVWNh6I+ABmL
	 0g6d6bfDUy14A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 11/26] SUNRPC: remove call_allocate() BUG_ONs
Date: Thu,  5 Sep 2024 15:09:45 -0400
Message-ID: <20240905191011.41650-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove BUG_ON if p_arglen=0 to allow RPC with void arg.
Remove BUG_ON if p_replen=0 to allow RPC with void return.

The former was needed for the first revision of the LOCALIO protocol
which had an RPC that took a void arg:

    /* raw RFC 9562 UUID */
    typedef u8 uuid_t<UUID_SIZE>;

    program NFS_LOCALIO_PROGRAM {
        version LOCALIO_V1 {
            void
                NULL(void) = 0;

            uuid_t
                GETUUID(void) = 1;
        } = 1;
    } = 400122;

The latter is needed for the final revision of the LOCALIO protocol
which has a UUID_IS_LOCAL RPC which returns a void:

    /* raw RFC 9562 UUID */
    typedef u8 uuid_t<UUID_SIZE>;

    program NFS_LOCALIO_PROGRAM {
        version LOCALIO_V1 {
            void
                NULL(void) = 0;

            void
                UUID_IS_LOCAL(uuid_t) = 1;
        } = 1;
    } = 400122;

There is really no value in triggering a BUG_ON in response to either
of these previously unsupported conditions.

NeilBrown would like the entire 'if (proc->p_proc != 0)' branch
removed (not just the one BUG_ON that must be removed for LOCALIO's
immediate needs of returning void).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/clnt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 09f29a95f2bc..00fe6df11ab7 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1893,12 +1893,6 @@ call_allocate(struct rpc_task *task)
 	if (req->rq_buffer)
 		return;
 
-	if (proc->p_proc != 0) {
-		BUG_ON(proc->p_arglen == 0);
-		if (proc->p_decode != NULL)
-			BUG_ON(proc->p_replen == 0);
-	}
-
 	/*
 	 * Calculate the size (in quads) of the RPC call
 	 * and reply headers, and convert both values
-- 
2.44.0


