Return-Path: <linux-nfs+bounces-4270-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6874A9153C1
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C2D287203
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013619DF80;
	Mon, 24 Jun 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh9YbCGD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068D17BCC
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246479; cv=none; b=TnjLR8GTswcCAqURKWXV9d2GlVwmWLSTEvVYTBwp53RmkvhFmWVjDBpVSgLv6AoEiT8K6zbL5UUhlpfG9ipM7t+3VPmr2Pml18lfqIbsyllBvmyu0zKzwKk9i/HMyQ0paF3j4H8g/vhbAXnBakm7NxA2Cx6KrnEBa/yaTvlVc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246479; c=relaxed/simple;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/bqDMLk73uA29Ka4mJ6MSK0N6kFZA07Cr78gKJT9/eQH6Vm0IhCf5/TP6uB90McACZPmfvV7hyVaJ1eegtjNQve4NkxzB2kFAdVzAXLWpvzbF36lTPYGBHvmYNJOp6kPF2ZZKuuikAILScJd1kRGw7CPZaTRFEKkqwSCGGU0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh9YbCGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4946DC2BBFC;
	Mon, 24 Jun 2024 16:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246479;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nh9YbCGDhIcmv9br8WyK4700+sD60ODfbdNBh1KPMzcZ5DnCYN8szvW2ez7bZf3nn
	 CuFjCcfFzMfGltzTm1jXO5AAZTYrlGb/Q5IqjqanTkMyrxuqhJz9I9/erWhZqsbp8R
	 fUfp/r0n2xNczc0S3lZrwCVE8Skn/EqVuQVbB7ct4JRq3xyRc65LBPfOJOuzecT6Zq
	 Kn/lbYSrRUuvUd00c5uuDxV0bVxm/xyiTEt4JkdZZ3h7ITOgMJrH3XL0axhC9U0e3K
	 FoxHoAbf9KnOhKN8v+ZBFXIDN4TMxrPFAEqFdb8zwwV7Kt4zH4Swm5ZPETFMG3CL0F
	 92nYkW45ksD/w==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v7 12/20] SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
Date: Mon, 24 Jun 2024 12:27:33 -0400
Message-ID: <20240624162741.68216-13-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624162741.68216-1-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed for the LOCALIO protocol's GETUUID RPC which takes a
void arg.  The LOCALIO protocol spec in rpcgen syntax is:

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

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 net/sunrpc/clnt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cfd1b1bf7e35..2d7f96103f08 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1894,7 +1894,6 @@ call_allocate(struct rpc_task *task)
 		return;
 
 	if (proc->p_proc != 0) {
-		BUG_ON(proc->p_arglen == 0);
 		if (proc->p_decode != NULL)
 			BUG_ON(proc->p_replen == 0);
 	}
-- 
2.44.0


