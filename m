Return-Path: <linux-nfs+bounces-7236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC06A9A25FF
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F75EB26818
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABD11DED66;
	Thu, 17 Oct 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDbx38bU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF51DED65
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177440; cv=none; b=qTawBfcBKb1F7Ela6LW6c52kRRe2QVc19H8jsrYOaddydc6bPC0PSIfD3eIStFSRvvAJENGi6ROAiusTpUx7QEzNPa9mHRhQfQdT/fSoMZybepbTBhzmVFIGgDR5RpHXoRajIMrRcLipLfPuOl33OHCF3SNGDckfqSm/3JSxKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177440; c=relaxed/simple;
	bh=GkvPIInt1TiBXv5GCp/6ODc696Yg0xkMCVC5oOpZx/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQLhpv78YkwJ8tLGljVJ0aor/TtC5UivdonfJl8st6VSsa6YKcRpe+by6jcQJ0SFL+BvsvzCAEq3gMWtLj0Y/PAYKd86NGrHRTiWK5bp/WOB9QV8Mv1qo7b7jvb3wgPCnNhGF0/3NkKvby4MhkyRoMmzO6CvkqeWJG45qtg5q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDbx38bU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91330C4CED1;
	Thu, 17 Oct 2024 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177440;
	bh=GkvPIInt1TiBXv5GCp/6ODc696Yg0xkMCVC5oOpZx/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDbx38bUHm8vbDJIG05lSF2jfrFe+H/8FN9QjEx7ftQ1dybNHf/Gf0mZzaF2aEp6h
	 uvRJSyEfby2Oru+o/f0ZCSDEPafERShOLhpV1qh0YOEdeMsefg+kBU5cjzkNcelVM5
	 NMKfk+LzY3dVbUVd2w1Fq5YoKIZiF9KopdEHDgk/M8kornUkGvtcyuojlZujixkkRq
	 g4DkZ9+tkgevM1ZMXPhVElMwEMCEJk22NsD4B0HKZsJFnoLugHcJg7wKMunRoui9nF
	 cZbqVktLV7R+eyTwfYM2AOfcLejWoLqte26eNCUoyF6CpvfydReUTJtNHNKkJFmd9p
	 1Etv4Jiczmxlw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/6] NFSD: Remove dead code in nfsd4_create_session()
Date: Thu, 17 Oct 2024 11:03:51 -0400
Message-ID: <20241017150349.216096-9-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017150349.216096-8-cel@kernel.org>
References: <20241017150349.216096-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=chuck.lever@oracle.com; h=from:subject; bh=HiKnVMaySyz6rrdk3Q60xo/GI5a9WaZEM6Y6nxFB3Mo=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnESdbWG9pIF1HdzWaYvUvQzwzC3pxLRbypPOwe P276PCVkmOJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxEnWwAKCRAzarMzb2Z/ l9fTD/0aSAytd7kgiKB7ajgTCa718GmVEZGQ6xnozsWSFfrE5+7xbeFMFHx9tq04u+fy8H2anfN nWKz0B2YPGg+IFwgRtgklYpz7Ld07d+aUES6Bbb5IS6ove/+5tGouDpd7DXgqhFmuhWQlEywjGE o5jUTMKPi5QN2clL7XXKuPOxaRwVUCD1XT8CYsPUgkbPQ9iwdKKGFNdgMODrAHo8P2EAOwO4igf kEE4w3BDcNOHAy7iCSEm24P3VcbhMKsRabqOPIGZf5eY+1IV8IuixFaows6gQH3WokQjhdfo+qp n54XQbVoCQkAzqAXAi/a4/AsavLZLCf0NZtwTsIq3fK/3aDdsSW/PypbLRucvXS+rCV+pzP6PKH d7a1hpxTXm/zk3LXRed/5EABwhnyVOKFjNWAm3tmsn5HEw6Vy6JigPNjE/HsUHmy5CAp7CxLBCT qYJqNuUhh9xmNxdcimy18xfI4cg8M5zScELahuFaXfFF6CEXYKpmd9TXKuyBZsdgCJDz1+jmIxs HOQIk4hgSraYThJIIA+tjSfTT3mTSHCsZeiYRliRiH0C4jPzjL7N0+XI9zDsd4nJZTC5kNH3Q98 P8pzP8heae+L7GpkpvjWj3PDJ+KM6e/KTNxVBoRKW5GYnl+MZTSc99wFScWVzFzQyDDf2xa8Fdn sjrbrG3nLCP3T/g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up. AFAICT, there is no way to reach the out_free_conn label
with @old set to a non-NULL value, so the expire_client(old) call
is never reached and can be removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2b21f2113c6e..3b16468ecbe7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3927,7 +3927,6 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	return status;
 
 out_expired_error:
-	old = NULL;
 	/*
 	 * Revert the slot seq_nr change so the server will process
 	 * the client's resend instead of returning a cached response.
@@ -3942,8 +3941,6 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 out_free_conn:
 	spin_unlock(&nn->client_lock);
 	free_conn(conn);
-	if (old)
-		expire_client(old);
 out_free_session:
 	__free_session(new);
 out_release_drc_mem:
-- 
2.46.2


