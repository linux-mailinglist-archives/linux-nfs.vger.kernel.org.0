Return-Path: <linux-nfs+bounces-4433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD4691D2C3
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEE41C208D3
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A85815696F;
	Sun, 30 Jun 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCot81Bd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AA15696E
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719765486; cv=none; b=qFXi6Lp95y67BUe3KLYW84xGaMwykB21GKFYEgR3Tn6hyRaVWioJexo4z4wV0j2BUtQhfcTLYJXtNX75SOxrPUHbzF5MaEGvwItNfnZQdyJzZqEDjA6WA4vyDQ1w3JiuwPfXBZTrx2EliHf+1DVqw+1OYbO+ce8Z2KU7gI3B3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719765486; c=relaxed/simple;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCTwupk1r0zrcQKkRoTLywBhVVlSeiywUE4tt46DbMc0vDNxjIunapOcoZdJ4+z7yeoNUunghILyxWHFsJilEtiTWvdedgcoC+dJnVhoCYuXnAAnmAWXx3AnfNuMeS0LmnHrGjfc1M6F7UN8TsXftUQq2lD4BF3F14beUU/Cz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCot81Bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B905AC2BD10;
	Sun, 30 Jun 2024 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719765485;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCot81Bd0R11kPb2i9DTY3ybFmK5osI3JNpggTsCl1GXPauMJVAI0l8mf2Mroo39X
	 ZcdET8MfGxgJqE95+3ixcD+EgTkxOzldV558G9BlYfRMxzhjrhFmrg+hQOuwDQA4+A
	 9xY5bM93/RAikkau73LPCoLQVkHeMywFIa8N9nx81C0Y4ot2U+J5qaVvaL+T9PBpdf
	 KmRo6e0GZC3rxDVxc1TvedU9E9LQEU0lFortAHtGuXEClgmEGvEuOGNLMLBu1rTkfM
	 zdKXXicnE/XdRg9BrVSZSh+o56goosg+O2JGggOJCpQcNLAso5W1Zc5hPLvSyESXzY
	 QswpXNKmOh48w==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v10 17/19] SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
Date: Sun, 30 Jun 2024 12:37:39 -0400
Message-ID: <20240630163741.48753-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240630163741.48753-1-snitzer@kernel.org>
References: <20240630163741.48753-1-snitzer@kernel.org>
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


