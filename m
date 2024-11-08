Return-Path: <linux-nfs+bounces-7804-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D0D9C2831
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AECB22C50
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BFE1E3DC8;
	Fri,  8 Nov 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUgu1Rq3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE918F54
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109220; cv=none; b=f/QXJn4SRA4B77A/krmZJgjAqGgcZb265ApM14FRMykUir3ZgaQ+TB5kqPJAZ1LHmL+8Cv/kBRbFg4d1O3E4ehMAQbDaw5wrMrD8DrRN92sDErKxIJ9XxWjvS8sE6OvPCxytKmoyrUpSHZD8YWM7rWFzMaetOz0iJO41SSVPECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109220; c=relaxed/simple;
	bh=rS8Vb+2wUBiz+5WD6JzP4ncWfdtNJzKRa3JbIgo9h3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMTQduDjcFZhlX8LysqbZmblqqxawj6tbSfpJu53/b2g9UEh+d7ozq+ZM8Pf13n0nik2ybzRJG7AwTvSnmCTgIeeYNR0dgupBhiEgYBzvlcr0nGzjEZM9gXChjinFHyI4LGao+hhtG0rzTahBCpmCJb6VAukz+pVluagFqg4grs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUgu1Rq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3912CC4CECE;
	Fri,  8 Nov 2024 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109220;
	bh=rS8Vb+2wUBiz+5WD6JzP4ncWfdtNJzKRa3JbIgo9h3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUgu1Rq3Drig4eNb4Mzh1ZhwynYcoec3kHg1kpiRlzh9j+wj2BMwQxupH0NO562ch
	 /5Uuj9ABXc0Dgmwi8VaWIs3gI/cF6KGU1vfXN/d/0xdTL/j+/raN+KPXuCIZjuS0VY
	 vZdGxDNUdlKRTiNjJJaB0H02SSOGRuT07MNYt9Ne9bB60+Kch7V7Xzo/8ZeUWblpCy
	 WuMW7hb2d3BAuIBagw/celBpV7ieN9HA6Pb/IiZAzbbzhDfsfjv6VDg3CRlJtRTiW/
	 4n4w7e/sSqRDdZ3D4BvnNiPoi2Z11EeDQPzdwzJ5h8mLpV6RPzKxGhsxi7FWD4JtTu
	 8WlXQPD8KTJsw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 12/19] nfsd: update percpu_ref to manage references on nfsd_net
Date: Fri,  8 Nov 2024 18:39:55 -0500
Message-ID: <20241108234002.16392-13-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Holding a reference on nfsd_net is what is required, it was never
actually about ensuring nn->nfsd_serv available.

Move waiting for outstanding percpu references from
nfsd_destroy_serv() to nfsd_shutdown_net().

By moving it later it will be possible to invalidate localio clients
during nfsd_file_cache_shutdown_net() via __nfsd_file_cache_purge().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/nfssvc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 49e2f32102ab..6ca554042426 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -436,6 +436,10 @@ static void nfsd_shutdown_net(struct net *net)
 
 	if (!nn->nfsd_net_up)
 		return;
+
+	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
+	wait_for_completion(&nn->nfsd_serv_confirm_done);
+
 	nfsd_export_flush(net);
 	nfs4_state_shutdown_net(net);
 	nfsd_reply_cache_shutdown(nn);
@@ -444,7 +448,10 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+
+	wait_for_completion(&nn->nfsd_serv_free_done);
 	percpu_ref_exit(&nn->nfsd_serv_ref);
+
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
 }
@@ -526,11 +533,6 @@ void nfsd_destroy_serv(struct net *net)
 
 	lockdep_assert_held(&nfsd_mutex);
 
-	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
-	wait_for_completion(&nn->nfsd_serv_confirm_done);
-	wait_for_completion(&nn->nfsd_serv_free_done);
-	/* percpu_ref_exit is called in nfsd_shutdown_net */
-
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_serv = NULL;
 	spin_unlock(&nfsd_notifier_lock);
-- 
2.44.0


