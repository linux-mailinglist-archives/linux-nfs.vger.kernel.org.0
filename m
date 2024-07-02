Return-Path: <linux-nfs+bounces-4554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B943B924396
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA741C237ED
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7401BD50D;
	Tue,  2 Jul 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrTKkJYJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF881BD4E4
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937735; cv=none; b=DNUCcoGs5NFedmdHgTYAzPz/0I9PV3jAIGy7vspZcZWkTeuF8a7XGhCmDG7wfnwnNkC+7UxCK+qXfXtqVKKai9KhOx86v0YsTgVUdr/07e0Mk5s+Yq29ZLjtOiwwbunI7L80LT58m5rCi6R+ib9bag9RJivrEkShODM958CQtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937735; c=relaxed/simple;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5qflcQLNjQdF9M2X8ac8PkIyCXVK7TwSzZjWfa1hDIzhQR/EzUIpIPRARoFzHqLpB3WveqeuihLouC/7+QCvKCS7yAqaBszxZKPv2BFb37dXdE3px/9nqvWQ6rHAioJQ6uv1KOhnSeKLXzqT7mqi2S6q6QJPmLLXAvC2vuSCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrTKkJYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093E7C116B1;
	Tue,  2 Jul 2024 16:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937735;
	bh=qE34YemZGEe9NkSzdbrQmELxaCXOmZqaZhtvaeoYnMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrTKkJYJBxohs0wYttLjFLZfkeohTUxleTvO4vceFi7sObERtBygSEb+akq0oaY4M
	 tUCLMB+wGD7uH8uvD8VqfT9LQoF/fFKDHnkS5fQoQT2di4bFHBjzseOMLBKx/pX2w0
	 l1PHYRWoeeWztKGhSC/p9JIRycyjvpcXTDrrmVUBkAbzcq9XALeWExtnGYR5IYqAki
	 W47b7fwNxxvH+7VzgMZzxeSLvhU4h09vNcY4fYGh/gYnL1mMIuYC4Qz3G4nRmUZi+0
	 o2IAbYzocuUvesfptXQorDhEuKXoWZL+sFTH9YK0YO60p/bMnqbAIX6DZB2VP1xncq
	 XVA95CDG2uWbA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v11 17/20] SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
Date: Tue,  2 Jul 2024 12:28:28 -0400
Message-ID: <20240702162831.91604-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240702162831.91604-1-snitzer@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
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


