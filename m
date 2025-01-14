Return-Path: <linux-nfs+bounces-9212-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F135A113DB
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 23:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A301646CD
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E776921322C;
	Tue, 14 Jan 2025 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLmFVGEY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6E21322A
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736892568; cv=none; b=cIu+7TQGc3qdWpX+nsjbaF/1I/q1xS0vdVfF7CnT5hsRIuRTfPehWynDEqKMk/cn8iSGFNeIdoUnUmgTyxjkHpm02hEwU+x+5wO4E08nH9tIYFKUSoIhDUq+Z+mZQxoXTXBUF5f3B/LBmQUKy7FkxqAJf/yjSyk1ihUlqawTnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736892568; c=relaxed/simple;
	bh=DwyFGCnrhKdQeRJ+1mWDTChh5xduV8xuhC1f3dsve5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esWtwmsrRW3q6RBbdSWqCIpbhrct2S4jzchI0Oc3lGX/7syH/b1q6GA85EF2zbf6oL+zOZOnqAtsrURe84m8hK9CIRdZ0MFS/afIR8jVKl6ev2LBR6WLQEC+xIuXmJpMkHvg9wPgD99zmfCQlpE3N/UKFY7kKeIR/cZEVAk8IKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLmFVGEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B5DC4CEDD;
	Tue, 14 Jan 2025 22:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736892567;
	bh=DwyFGCnrhKdQeRJ+1mWDTChh5xduV8xuhC1f3dsve5E=;
	h=From:To:Cc:Subject:Date:From;
	b=VLmFVGEYNjYEEQieRY3MYwIYryjd0bYZBpxXBHAJH7O9b09V1UGV4MK5irwYIIyvr
	 gABNm2bGYyfkxWhbtGnO2621kJiB7Go3nLUmsrrIsE1k17a1lcSGHiuJb40mwcdDzw
	 jDppr5u6mdHWikArUZemxNMy1iRxliYvmHadkWnpZ4aUrTOT2R4fySfg/VhaC9aYvT
	 9nl0US+zFn497Dm1cUJB57wnP0yy4Ki5jkkBVx7Ap4ACNvp95U/Ko3CQsWvFuchbye
	 NU3HarlCe81RcFwDtBLIKRkWUPBeIXb/wJFzWzFzitP9HgrGoS7iaQ6+a6MxA8WzIP
	 B0Y0Tc1KQAPzw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up
Date: Tue, 14 Jan 2025 17:09:24 -0500
Message-ID: <20250114220924.2437687-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSD sends CB_RECALL_ANY to clients when the server is low on
memory or that client has a large number of delegations outstanding.

We've seen cases where NFSD attempts to send CB_RECALL_ANY requests
to disconnected clients, and gets confused. These calls never go
anywhere if a backchannel transport to the target client isn't
available. Before the server can send any backchannel operation, the
client has to connect first and then do a BIND_CONN_TO_SESSION.

This patch doesn't address the root cause of the confusion, but
there's no need to queue up these optional operations if they can't
go anywhere.

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b7a0cfd05401..9ef32b19198c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6867,7 +6867,8 @@ deleg_reaper(struct nfsd_net *nn)
 				clp->cl_ra_time < 5)) {
 			continue;
 		}
-		list_add(&clp->cl_ra_cblist, &cblist);
+		if (clp->cl_cb_state == NFSD4_CB_UP)
+			list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
 		kref_get(&clp->cl_nfsdfs.cl_ref);
-- 
2.47.0


