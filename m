Return-Path: <linux-nfs+bounces-4349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C887918E75
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4F11F2555B
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A6190670;
	Wed, 26 Jun 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq5OWGrC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F4190499;
	Wed, 26 Jun 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426490; cv=none; b=OIAzGwPJ/dASp0RZaaaACi46PST58wMFs1VlF1PlY0nXwKX04Idn/k8y6thwF1YYuJSiBxMHpAoia8AYdIExeUcwKSazNuNeT4UWhe3QbPtAI0c8yXcBv5DvqW2Gd8tdUBbBjr6pi32nCABPSyJS2kEatkOHivcQhvG/qsbzbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426490; c=relaxed/simple;
	bh=ef4ueWSfF040KgBl1tE7HmECa+y32yBldqBElPP7X6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgGwj79rTsdIiFDeJ1aUT8mcMIgjgzkshn9b5elKXrR3YtAoz45RfeSg61Ba6QOXtCBy0EAKTONf1Y7uDoxW78TV0/jyvowkMH0wpG9veBdNg3LtfrE2NVM9B2uoXuKkboP0S77bqzAqeadO+826Tt1AJqfLboKbPc+UGmAoCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq5OWGrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51D0C32782;
	Wed, 26 Jun 2024 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426490;
	bh=ef4ueWSfF040KgBl1tE7HmECa+y32yBldqBElPP7X6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fq5OWGrC1gMnAdU33yrbeYKb5VswL1n2rQW1QyJE+OdmCnKSFtCJMWlCANg+CRW9K
	 eROAM7SFBP5CVuwwtqqkT/O3bdCGvqj97We0M3Az4iiSv0sDlnAPnYGQCB9kGX3bgV
	 sUGfLQIc2BnQ6OcRtpaWFhIXU7Nla04mSEHrN5yT4a+FPQsTLnwzLY15YAZozTwRyc
	 l1YQ3o3mhGcInl/i9YLXRlfGLRS0id+Cy8n4mAjvnDS4a0URLiabb8LudzdRBBoSE2
	 xyb/Lbfcejk6mjTEYJmyI6j1zoixQe68c0YuhqwgA1/DBH9B8KJMphUQcNW7+M6nuO
	 V8Unf1LEzlgmg==
From: cel@kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<stable@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Vladimir Benes <vbenes@redhat.com>
Subject: [PATCH 5.10 5/5] nfsd: hold a lighter-weight client reference over CB_RECALL_ANY
Date: Wed, 26 Jun 2024 14:27:45 -0400
Message-ID: <20240626182745.288665-6-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240626182745.288665-1-cel@kernel.org>
References: <20240626182745.288665-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 10396f4df8b75ff6ab0aa2cd74296565466f2c8d ]

Currently the CB_RECALL_ANY job takes a cl_rpc_users reference to the
client. While a callback job is technically an RPC that counter is
really more for client-driven RPCs, and this has the effect of
preventing the client from being unhashed until the callback completes.

If nfsd decides to send a CB_RECALL_ANY just as the client reboots, we
can end up in a situation where the callback can't complete on the (now
dead) callback channel, but the new client can't connect because the old
client can't be unhashed. This usually manifests as a NFS4ERR_DELAY
return on the CREATE_SESSION operation.

The job is only holding a reference to the client so it can clear a flag
after the RPC completes. Fix this by having CB_RECALL_ANY instead hold a
reference to the cl_nfsdfs.cl_ref. Typically we only take that sort of
reference when dealing with the nfsdfs info files, but it should work
appropriately here to ensure that the nfs4_client doesn't disappear.

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Reported-by: Vladimir Benes <vbenes@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 228560f3fd0e..8e84ddccce4b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2888,12 +2888,9 @@ static void
 nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	spin_lock(&nn->client_lock);
 	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
-	put_client_renew_locked(clp);
-	spin_unlock(&nn->client_lock);
+	drop_client(clp);
 }
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
@@ -6230,7 +6227,7 @@ deleg_reaper(struct nfsd_net *nn)
 		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
-		atomic_inc(&clp->cl_rpc_users);
+		kref_get(&clp->cl_nfsdfs.cl_ref);
 		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 		clp->cl_ra_time = ktime_get_boottime_seconds();
 	}
-- 
2.45.1


