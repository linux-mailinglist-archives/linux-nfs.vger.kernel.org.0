Return-Path: <linux-nfs+bounces-15629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B50C09C95
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Oct 2025 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2DCC50076F
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Oct 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910030F932;
	Sat, 25 Oct 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auytd7Bg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314FC303A1E;
	Sat, 25 Oct 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409566; cv=none; b=jrtBGg94ATmGGWTLMjvVvlx+SYIQpRlFcJSs6bsLGpwVSNH1tCGrbQuxFh/e2rsqTxJXbuWQwrJjgUOcpTWKklHmcMMofxiInNVeP49yI/XbF7BJE4vT4M7dsmv+mBkw4rj8WzurZSl0Ie6+dNVIf2wF4dzuA5isA+AZj4QMGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409566; c=relaxed/simple;
	bh=KdCwY02XAI2rWBJxdnCMdyzWYd4+LCpAMiSnoQoCINQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPj3Q8BO1eofbEYzSebaXvY3kDiURNNBTc1ENorJdlPTi6dPGQ09e3fs2dPF2gHBeRARBqpU2gW4bJKfXZy5x9sU5zVrJ8QueWkt/CMg6whiBQmzQS2T0r69SLM4eilgowOl2eaBgGOgf3tXq9C1lBI+FhR1BaZpzaX3dg/Ci0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auytd7Bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ED6C4CEF5;
	Sat, 25 Oct 2025 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409563;
	bh=KdCwY02XAI2rWBJxdnCMdyzWYd4+LCpAMiSnoQoCINQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auytd7Bge3hpP+ORabjZPpLV9tZCpqYLM5AlyRGNTameIS6m8L6TN/7anJQ2+9DFs
	 4+yh1Dp2vo7ubULz2FDVF/n96QMl8zUhmicEIFa378+0PozPxvweyAIgQCcSSx3MKw
	 QRhV9F2inngc4bNs0DmeYQulApTpBDWB+b0Pyei01h77bwgnkOCJAlH0vHQBVUZuED
	 H+LAbQIxG48Kuc2jElpS605AviEMmWVUnZKRvyfaE14LSWbuOJv4vVXs8OiSMylbui
	 yQAK548JYS918tCSJWIDAx1UNGfPGV8Vyl3rK18qdEH7HzZexmrlvi5Dp8lDzTDEBd
	 iRI/C1+z7CDyQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] NFSv4: handle ERR_GRACE on delegation recalls
Date: Sat, 25 Oct 2025 11:59:59 -0400
Message-ID: <20251025160905.3857885-368-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <okorniev@redhat.com>

[ Upstream commit be390f95242785adbf37d7b8a5101dd2f2ba891b ]

RFC7530 states that clients should be prepared for the return of
NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
**Key Points**
- The change at `fs/nfs/nfs4proc.c:7876-7880` extends the recall retry
  loop so that `-NFS4ERR_GRACE` is treated exactly like
  `-NFS4ERR_DELAY`, matching RFC 7530’s requirement that non-reclaim
  requests retry during the server’s grace period; without it we
  prematurely exit the loop.
- When the old code bailed out on `-NFS4ERR_GRACE`, control returned up
  the stack, causing `nfs_delegation_claim_locks()` to propagate
  `-EAGAIN` (`fs/nfs/delegation.c:176-178`), which in turn made
  `nfs_end_delegation_return()` fall into the client-recovery path or
  abort the delegation (`fs/nfs/delegation.c:584-596`), disrupting
  otherwise healthy delegations after a server restart.
- Other lock paths already retry on `-NFS4ERR_GRACE` (see
  `fs/nfs/nfs4proc.c:7594-7604`), so this patch simply aligns the
  delegation-recall path with existing, well-tested behaviour and
  prevents unnecessary recovery storms.
- The fix is tiny, localized to the NFS client delegation logic, and
  carries minimal regression risk while addressing a real-world failure
  mode observed during grace periods; it is an ideal candidate for
  stable backporting.

 fs/nfs/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 611e6283c194f..4de3e4bd724b7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7872,10 +7872,10 @@ int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state,
 		return err;
 	do {
 		err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
-		if (err != -NFS4ERR_DELAY)
+		if (err != -NFS4ERR_DELAY && err != -NFS4ERR_GRACE)
 			break;
 		ssleep(1);
-	} while (err == -NFS4ERR_DELAY);
+	} while (err == -NFS4ERR_DELAY || err == -NFSERR_GRACE);
 	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
 }
 
-- 
2.51.0


