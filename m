Return-Path: <linux-nfs+bounces-2674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBF289A303
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 19:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815201C22BA0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC408171652;
	Fri,  5 Apr 2024 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE+d1t8/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4922200CB;
	Fri,  5 Apr 2024 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336458; cv=none; b=IGoKnBHtK317mnTVFjt7aJCK0xnDdQmCYhl790cG7zdhp/SpRyV5p+VoYqCXEumHax7ar8prrUUBxfnMTfnmy9KJwBAb9lAF/UlbTxvaDAf687APm1Nq5VHsPLUtlBI8uTZplPKuSymbNsrzz/g02JOaDsnEGsHLY0bW6gRrFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336458; c=relaxed/simple;
	bh=CT4KbWmp4a2wM7xpgM64qDlkfPI7YHfSuBZdBpdtbm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PSES8ntwK2+TZ+Eydp3KBxFAfuhBcHDSI8zNo7OHmonliAok62S2XaTS/KCc1ek4y8NuS4wnWh+XLOgwy/Pq/iCHbY9zPmSVdz5PpdlmHlKSVO5rGYV+SU70RK+MIry4pojr3l2Wumnr7Yx0Q0Dvmfdd9iRz7WZLobMJOyzqd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE+d1t8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849C5C433C7;
	Fri,  5 Apr 2024 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336458;
	bh=CT4KbWmp4a2wM7xpgM64qDlkfPI7YHfSuBZdBpdtbm0=;
	h=From:Date:Subject:To:Cc:From;
	b=hE+d1t8/HdSpQfGk3nd4Sa8XiXoARvTOPA6d6Y5aj0OebxYYRH1Mc0Gn0ROMM3tRa
	 OkKAnL9/bYB7S4bCuOfI1YWxMED8IDkBCtq5l+49m4tjKOQAheEHbcHRXUhbozx6iY
	 CBkEf7gcTw9gSqXsTup6houVUAdlkwbWCnX/h0gCWx0ehlDESqTTf5f1pU6gdpXMAs
	 eBC22gXCbfAmCM5L2A8/rvBPB8NNUbgcthUwFYOWciVSsppP9ZY+TlrgmvJs8gH563
	 toeRtouUKQkNjMIzpgd3O6jLsSREAwBsRqSnGn2pkdWjf34ty/fI3nvefSr+q/HeiM
	 Y0XlStBCiF2XQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Apr 2024 13:00:39 -0400
Subject: [PATCH] nfsd: hold a lighter-weight client reference over
 CB_RECALL_ANY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-rhel-31513-v1-1-40633463f9da@kernel.org>
X-B4-Tracking: v=1; b=H4sIADYuEGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwNT3aKM1BxdY0NTQ2NdAyOLxCSzNEMTI1MjJaCGgqLUtMwKsGHRsbW
 1ABi1EA5cAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Vladimir Benes <vbenes@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CT4KbWmp4a2wM7xpgM64qDlkfPI7YHfSuBZdBpdtbm0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmEC5EnKCr5VyEwsY2Qgz7d5DwE5TiB4eovrwsa
 eh0uvPwGP+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZhAuRAAKCRAADmhBGVaC
 FWncD/44BegUyx3yei7jnayS9YfB54oRi/9enY0gC4PjCSKl1S1KKnRmtHX4qpJ2oszuxiVFLnq
 G1yDRUfxgzVoHD74Y8vvxjid0/FJnb95FN/XVHcw9KeA0AjktexD5L5WzUh3Hjw1BLu0kTu3SVT
 FdM0XanHttRcFF7ROGSMubbUI7XiPM4D2Wl1IFOkfavfODqd9YY+TwNNpABAuNHL8IgncX4SegI
 aQjN4boLoWoCxMX1gfSIutnHrFrloH8M6b/gSGPpfqJhr4G6qtd9OjfvjpfUFULj3zd6cKwJKem
 m4aTiSg6Y0nP2B14nTMtDFN2UV3FwlDUK0ycvDehGM9gJUZWEVI8XGtYv74v7Q+BXoGyudgIQGr
 6yO0ayc9FkX/3Kre+CVVs2w2lSIst2ilzRcyfGvHvdXatzYEcH4vhwHQPROJ5/6HBMlV4qlzupD
 GAiwbMGfOyyXlIM93Y1CUFHAcdVqSF8A2wfLoO/wo1kfRj3OUwuQlT4dOXbwhpPlB0TYNXgL6Wl
 UvTr8nb2td17xVA0OBEnHqR5sEQJSs7hJS9H0NEPTdBtULefIyGSKT5mGcMi1WWQ+CsTFHgNd0O
 J5Y7qaTWRrLpLdAsSEZaKEj7eDSO0y0NL2Ukd+u+dDh1UmrDVnZe/hsfGVbB08tN7oi47xxWrDe
 /HJYaG45FWBZSoQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently the CB_RECALL_ANY job takes a cl_rpc_users reference to the
client. While a callback job is technically an RPC, this has the effect
of preventing the client from being unhashed.

If nfsd decides to send a CB_RECALL_ANY just as the client reboots, we
can end up in a situation where the callback can't complete on the (now
dead) callback channel, but the new client also can't connect because
the old client can't be unhashed.

The job is only holding a reference to the client so it can clear a flag
in the client after it completes. This patch attempts to alleviate this
by having the job instead hold a reference to the cl_nfsdfs.cl_ref.

Typically we only take that sort of reference when dealing with the
nfsdfs info files, but it should work appropriately here too.

Reported-by: Vladimir Benes <vbenes@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This patch seems to break the livelock in my testing. It's not the
prettiest fix, but it's narrowly targeted and should be appropriate for
6.9-rc. Longer term, I think we need to rework how the nfs4_clients
refcounts are managed, but that's a larger project.

Many thanks to Vladimir for all his help with tracking this down!
---
 fs/nfsd/nfs4state.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5fcd93f7cb8c..4311d608a297 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3042,12 +3042,9 @@ static void
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
 
 static int
@@ -6613,10 +6610,12 @@ deleg_reaper(struct nfsd_net *nn)
 				clp->cl_ra_time < 5)) {
 			continue;
 		}
-		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
-		atomic_inc(&clp->cl_rpc_users);
+		if (!kref_get_unless_zero(&clp->cl_nfsdfs.cl_ref))
+			continue;
+
+		list_add(&clp->cl_ra_cblist, &cblist);
 		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 		clp->cl_ra_time = ktime_get_boottime_seconds();
 	}

---
base-commit: 05258a0a69b3c5d2c003f818702c0a52b6fea861
change-id: 20240405-rhel-31513-028ab6f14252

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


