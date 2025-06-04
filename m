Return-Path: <linux-nfs+bounces-12095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D6ACE1DF
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431AA3A8E62
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8F42AA9;
	Wed,  4 Jun 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnHwdpRf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19A18E1F;
	Wed,  4 Jun 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052880; cv=none; b=jlb7d+YVg1vFJxZDjOh8hVz8L4Ffqcce74lDhDeVr/VUWUYTO5JLRi+7mcwbEV7Kicoh8KSjROeW4A0erLSE4kBHr9HTfMEwtYI4CoVCMh3i5hO9xxlNDBcxSe1w83BnOgDOwuBz5uEw8X1FIapo78/N3Zo4nThdyHetFNWwARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052880; c=relaxed/simple;
	bh=aXDdtMeuURnJgZ1pn/LA8wH4VbiUiRq8LX3VuJ+8ubc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W3t2xSsHIKjD/gR3quDHK2qfpVa0PPLzypM2PT9OlvbTvfMcppamVHzYWqt1jiPAa7j0R1Xs3cpKFLf7Lkge/Q4D1JhcnKO8+I1wlna6COfTJ6uTF5U7RYdB9XHagr4JvfIAVbrdkaY7rMjyoJR7KW5OLUUrfPmkoAu4uFhN28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnHwdpRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DAEC4CEED;
	Wed,  4 Jun 2025 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749052880;
	bh=aXDdtMeuURnJgZ1pn/LA8wH4VbiUiRq8LX3VuJ+8ubc=;
	h=From:Date:Subject:To:Cc:From;
	b=YnHwdpRf2ROUtKw5ELAY3EKIIakhuOwNeGkaXfS2qAEnxTExvn9DcxSl/BORcu6y4
	 u0WfUjAd78yI1IqusiTR79Ftr5SHOvegqwvTDt3CO4z81yjP+gj2EvoMLHuVvPK9Kh
	 /v6fVCdKQ8f5LCWRpJD5bv8RGYrvv/IlmvRveT6Ux9+sW8REO9uBi4jt0dTFhrrL01
	 1RVe48eMVYM5aIbDjORxKeyD1nPMHYqwTcUPq3Yn35dnogH+P1WQs7ZppAbmWAyZr2
	 x0e7Q45osMLkMS83eauoC11Ue9sfwisTek7jbo4cGlnL6j/dFifqBFYNE62/e2WcZv
	 4atbngQXIq3oQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Jun 2025 12:01:10 -0400
Subject: [PATCH] nfsd: handle get_client_locked() failure in
 nfsd4_setclientid_confirm()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-testing-v1-1-e28a8e161e4f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMVtQGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwMT3ZLU4pLMvHRdixRLC4u0NBMLA3MzJaDqgqLUtMwKsEnRsbW1AJb
 LeptZAAAA
X-Change-ID: 20250604-testing-8d988ff48076
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: lei lu <llfamsec@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aXDdtMeuURnJgZ1pn/LA8wH4VbiUiRq8LX3VuJ+8ubc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoQG3JNHdO7p7llzbxU8vfhPF3MuwPrNlJR8bfd
 qgNKdTSnU+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaEBtyQAKCRAADmhBGVaC
 Fd86D/4ml9mfn7bHWKYbPZ+4Y2cHHVWgbBW/NcIvqu2MC0XaI6yYvpRT2OwdzuSgsC4rF2D6svK
 rUVJf35/obWy5ZPN49jBVP7BgBbSWBnCquWTde7LHabm1BfWGg2Ji8+Fxys3/Fjg7tZ9+Pwt6ay
 Ra0CxiGZylNv+4nvvtcuTJfdboq/lyMyIeZHHGvk5hKzydW3v6i9DSPvfNZmCC+Aibj92qB+R50
 UfxA54F+NLd//dg6jYOHR1+atlkB9Grp9dL1dOMc/akDSYv59/0ywnq2zKpX1FCqslMv3rP3nDE
 fVkqoMmKAv2otybrve9dC7R0ey9+s7ogdKgGqh+xlT5pQmv0RyOZzEldmRJZPmAv1GbMyTI3miB
 UuL1jM+NOE5YgsKg73A/PJk6HLeEfxyFalom1puH38MTNfzknCZj8gB6O+6wCjnfTW2f62qMi1+
 xLcveTC6120YWlKBIzvxwEtG7supVqMykmvEEYKmRZuIwNY40QXBLQPEyd4aTVN80TLDNQblvSw
 axKckiNg3Iloa4/eneMJkM/vLtANw8xEFxA9ZFo7Kl+zkF+QmTGq2R2kJpbT1v2k4py8k0eVRa/
 evHu2FjnlcbLh/8Z8G2FNf3PhBhzNG5tiVZRJaCcnB13XmdNTxDgqhuP/aLV6z/BjIkqSEqj+89
 2+PVl0KKnfdqo/A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Lei Lu recently reported that nfsd4_setclientid_confirm() did not check
the return value from get_client_locked(). a SETCLIENTID_CONFIRM could
race with a confirmed client expiring and fail to get a reference. That
could later lead to a UAF.

Fix this by getting a reference early in the case where there is an
extant confirmed client. If that fails then treat it as if there were no
confirmed client found at all.

In the case where the unconfirmed client is expiring, just fail and
return the result from get_client_locked().

Reported-by: lei lu <llfamsec@gmail.com>
Closes: https://lore.kernel.org/linux-nfs/CAEBF3_b=UvqzNKdnfD_52L05Mqrqui9vZ2eFamgAbV0WG+FNWQ@mail.gmail.com/
Fixes: d20c11d86d8f ("nfsd: Protect session creation and client confirm using client_lock")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I ran this vs. pynfs and it seemed to do OK. lei lu, can you test this
patch vs. your reproducer and tell us whether it fixes it?
---
 fs/nfsd/nfs4state.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5694987f86fadab985e55cce6261ad680e83b69..d61a7910dde3b8536b8715c2eebd1f1faec95f8f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4697,10 +4697,16 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 	}
 	status = nfs_ok;
 	if (conf) {
-		old = unconf;
-		unhash_client_locked(old);
-		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
-	} else {
+		if (get_client_locked(conf) == nfs_ok) {
+			old = unconf;
+			unhash_client_locked(old);
+			nfsd4_change_callback(conf, &unconf->cl_cb_conn);
+		} else {
+			conf = NULL;
+		}
+	}
+
+	if (!conf) {
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
 		if (old) {
 			status = nfserr_clid_inuse;
@@ -4717,10 +4723,14 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 			}
 			trace_nfsd_clid_replaced(&old->cl_clientid);
 		}
+		status = get_client_locked(unconf);
+		if (status != nfs_ok) {
+			old = NULL;
+			goto out;
+		}
 		move_to_confirmed(unconf);
 		conf = unconf;
 	}
-	get_client_locked(conf);
 	spin_unlock(&nn->client_lock);
 	if (conf == unconf)
 		fsnotify_dentry(conf->cl_nfsd_info_dentry, FS_MODIFY);

---
base-commit: 5abc7438f1e9d62e91ad775cc83c9594c48d2282
change-id: 20250604-testing-8d988ff48076

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


