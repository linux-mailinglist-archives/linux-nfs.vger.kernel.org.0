Return-Path: <linux-nfs+bounces-5872-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D224F962EAE
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8791F21BF8
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045B71A707C;
	Wed, 28 Aug 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHawMpDd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A961A4F15
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866819; cv=none; b=qwRaxFZcpf9NRzDLuLOBnq03Rt2x/KiQBNvSE459pQUpqBmpXm8h8fVaVL5Kc5eIH/kW8DE1+VMsDs9aBPfeqZ53BT/y+4yK282ksMn64oHpq2wPK/vk3zDsStYZemSY1eGWLyRCEw+azPNsu+Tlrcz7mKJvZ6aWh5OQ8v3fuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866819; c=relaxed/simple;
	bh=aWby0vCjyBSrR859hrjshOQRlTr+PjLYxD+LzePGeBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jv1Z64mgLkN+uKrT8sm/bNbIBgjGRXqCl6bYzwBMEBjFlsy/hfehVYNnw2626eODkkrnehw/vKYC3/H6noBoT51pUGCY54R5v8wQn2qd/sYK/TahFwEtP8lYxpxjgm7s1rqboDibKR41dI0eU6vWOCZsGyLcUi0FPUT4Xg1JdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHawMpDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC60C4CEC1;
	Wed, 28 Aug 2024 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866819;
	bh=aWby0vCjyBSrR859hrjshOQRlTr+PjLYxD+LzePGeBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHawMpDdLPSlLoec1bQX4+bBVdJ0JBgOH7vYrz0bAut3Cs8mmF0XKFON9A3Axb80T
	 X9lOi3n/bvB73PFM4LqNqm8TLPgFrS5lFwn6+17rxVHnIPLZr9ka8awz0W0JgP3+D2
	 af5XgOCE+BzJ8yTngb3anRWysZSplTTWM4Bp5ff//Fpk4xasjQng5xFLpF/QkgKdn9
	 J6etZamhkvBnOkK7ls5BAwNDYsBVM2vtr8AK9ZSMxQ0o2qzPEC3P2xhbVh3eLBvIs8
	 3lqY1SO5PduMJVx2XKujvoHWrRGCg5tzlujTG9xi+JdhlGrYfYv4+XBHFcKLqqQk3t
	 pb3XL4h9mC1gA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 6/7] NFSD: Document callback stateid laundering
Date: Wed, 28 Aug 2024 13:40:08 -0400
Message-ID: <20240828174001.322745-15-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828174001.322745-9-cel@kernel.org>
References: <20240828174001.322745-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; i=chuck.lever@oracle.com; h=from:subject; bh=Uo1EwGHvb06X0rSppHPe7oD//N8B4eumMYNYPONhYyI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmz2D6cPVBj9+oiKXxPRwXrOqbGvVwr7DEZz2y1 7KPsLj2i5eJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZs9g+gAKCRAzarMzb2Z/ lymJD/9kQxAj0F7ATY3kWi/CTk+7PfIfbBTQyOUvULNkx8ceM05afOlAgITzUaNHvbO/+pmanKb 4g/y1d224H0Tj+dQjB7JkMeomWQoKAalIafShSBUq/zzUJbgErfZGn4/pC7xD67p92bplm5edvB a3YYMIFT1pOH2XDhg22jxtGr38yD//WFPNU4ueE8bJBzoWVB1qkO8BZ7riPe4uOJrgmBmV+GlCv JxkTJfqX2MpzrtTbS5pL7gwX9eeBmuWbyVg8aXSpxxYdTHH+ABQTqUqXtL3ADUxMIp/c3mVl8H8 Co0dWYZXYd4aJJ5wGiTO44Yq/vkG8W3duxKipGu4A0gRLD1yeCdNrJmwYgfGlGaY7lwqoX3SUir mnwFVtsJyWNeXbqqCZhZIujwf7dFww5Q68IPJcgwa/reDLW5lUPhy0WeMMg9rfrD0UxgGy0AOoJ Ob/wCdkDzXlEaPuTKHVWQ1usZnaKKudYGRTHEf9wCAy2q+mRmRBmgVgM5+uxYHs8PCKswUbknuD 378JUGvTTZ5Zjdp2p4gMHwA3piWAP4GCh3Q2FEiq8GREpu6hsksTLvKchOBaz6sJ4HTowXXeFP5 A1dLaE08KvuPtC9HZsO23izEVyodMrRXkptgQonIEWE3Nrg7J7ZAMPWwVFaqYphjW/0y6CEAi3r /HGSrZiq9YTBQGA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSD removes COPY callback stateids after once lease period. This
practice keeps the list of callback stateids limited to prevent a
DoS possibility, but doesn't comply with the spirit of RFC 7862
Section 4.8, which says:

> A copy offload stateid will be valid until either (A) the client or
> server restarts or (B) the client returns the resource by issuing an
> OFFLOAD_CANCEL operation or the client replies to a CB_OFFLOAD
> operation.

Note there are no BCP 14 compliance keywords in this text, so NFSD
is free to ignore this stateid lifetime guideline without becoming
non-compliant.

Nevertheless, this behavior variance should be explicitly documented
in the code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index aaebc60cc77c..437b94beb115 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6324,6 +6324,29 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+/*
+ * RFC 7862 Section 4.8 says that, if the client hasn't replied to a
+ * CB_OFFLOAD, that COPY callback stateid will live until the client or
+ * server restarts. To prevent a DoS resulting from a pile of these
+ * stateids accruing over time, NFSD purges them after one lease period.
+ */
+static void nfs4_launder_cpntf_statelist(struct nfsd_net *nn,
+					 struct laundry_time *lt)
+{
+	struct nfs4_cpntf_state *cps;
+	copy_stateid_t *cps_t;
+	int i;
+
+	spin_lock(&nn->s2s_cp_lock);
+	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
+		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
+		if (cps->cp_stateid.cs_type == NFS4_COPYNOTIFY_STID &&
+				state_expired(lt, cps->cpntf_time))
+			_free_cpntf_state_locked(nn, cps);
+	}
+	spin_unlock(&nn->s2s_cp_lock);
+}
+
 /* Check if any lock belonging to this lockowner has any blockers */
 static bool
 nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
@@ -6495,9 +6518,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 		.cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease,
 		.new_timeo = nn->nfsd4_lease
 	};
-	struct nfs4_cpntf_state *cps;
-	copy_stateid_t *cps_t;
-	int i;
 
 	if (clients_still_reclaiming(nn)) {
 		lt.new_timeo = 0;
@@ -6505,14 +6525,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	}
 	nfsd4_end_grace(nn);
 
-	spin_lock(&nn->s2s_cp_lock);
-	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
-		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
-		if (cps->cp_stateid.cs_type == NFS4_COPYNOTIFY_STID &&
-				state_expired(&lt, cps->cpntf_time))
-			_free_cpntf_state_locked(nn, cps);
-	}
-	spin_unlock(&nn->s2s_cp_lock);
+	nfs4_launder_cpntf_statelist(nn, &lt);
+
 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
 	nfs4_process_client_reaplist(&reaplist);
 
-- 
2.46.0


