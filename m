Return-Path: <linux-nfs+bounces-10426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C3DA4CA18
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14F3177297
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73EE24168E;
	Mon,  3 Mar 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd2F2hyo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF787241671;
	Mon,  3 Mar 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022779; cv=none; b=e/G07GY8rSMmMpID0AydlxM4ETYuGjMBR7d0M6X5Oz6Bo/8um2Wgv8nhSEkZQgsgteradwOLKDZOA0yAWqjPCPHHGDuXbkBKt6c2pAcVBZjexRAVK8O2HPHs44qR/KTDG/vOhSv13nTo8YR4oNsXkhkndL+2ghLlt8ZiLlGWEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022779; c=relaxed/simple;
	bh=gTD+8LQiPe09wmSKttRLRjWr3KGL3poPlvrnygqxXWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSP4zuNPrIXbKBGmlm55U1R6FL3Ykf34EJMuseAE3iLScoNlGHRDcdaToSwypM8kTnEHlUqO3H7oWZZx+kVlUFxA08zm7nmENQT+KJ2CgF/bsdTrWFwMYNwT07AsYbyDPTJzH5lgM8WwNXV4XJaRUxLxNHxdlDtcNH9Rq/A+dkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd2F2hyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F121FC4CEE6;
	Mon,  3 Mar 2025 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022779;
	bh=gTD+8LQiPe09wmSKttRLRjWr3KGL3poPlvrnygqxXWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rd2F2hyo5vLpZtBlUe0qODEt21u6M5aDl3WpxW7Noz31Y7Pt2m2hTIvLrt7Pl5jZ4
	 cwZsuzCvpq9dVXClNP7PJBarPU/Fpjtpp/5ii3Qdkme3moN0zMetbYfsUzVMRzAxaO
	 qXuI+dl3664a+8fqwrtqsCF/xi1tj7gbrmf3gvkgjboOVovNIss8HOZXwf3Bj8s9Oa
	 yHys+RfiuDD6ZB5kddPCQOwULDEVjxprWePWPnuIoJbzzlTxSITnboC/1x6vD20Qpv
	 S1dqFf1sLhr87LQrLU/BwLsnw43GZmhXBSJnbA8KLR9AVkMfDntXWvTLKWHns1Ureh
	 6jfNPK7F0fsZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Mar 2025 12:26:03 -0500
Subject: [PATCH 5/5] nfsd: use a long for the count in
 nfsd4_state_shrinker_count()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-nfsd-cleanup-v1-5-14068e8f59c5@kernel.org>
References: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
In-Reply-To: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gTD+8LQiPe09wmSKttRLRjWr3KGL3poPlvrnygqxXWs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnxeY2imXWq1pMPKaiX6eH1alev3H5J7YiMI+Wl
 XjlIRwEr8KJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8XmNgAKCRAADmhBGVaC
 FZV2EACfaphCJXUSUarWKsWVvZA1UTZJUJjQShT47sKIJxU1gpScLDbmMfUOuPxGXHd88IUXypd
 kwGp4e0Tcl6GFfJZMLX5GjILKlXsYpcOGx2nvteM8gFSxwnpQWbkN0Uh9mpo4mthMgQgDtc5neX
 UtCO/VyLfmMJQve5ZZwuSM7s1rLzILkEuBqGcAjN1m9LWeld1yippsaV197h+ISBpn4+dyEYASE
 tHnSkYNP7L/90YbHY61zVJrrauD8KH3FqMQ9OkF2r+T73DcKtGdJIOAQs+7cCcLxSx/lU422w/6
 MGbfW30ZNzO0QJqbDIjbRugBwWMUZJnLZG66CBVFOrKBl4PMei83LCGZk5p0fcgHVFObqTWr8B2
 k7OCxGaF2y3cW+CQBVJldGlEciElcCD0Ge6S2vDmVRDgWcSqAS23juXGSvc+/eq8sVNMBcZY7Ri
 DIFSsn+3C75J/Ajm0GbRHupbkmS/fDrEODYmT1JE7wJdnqpbONwY0J1NuijB2A0obVp9+DyGA48
 6PVNNA/rU2YssHm38Q4kyn3Q3cZXWveriZNYaYG+bPyOXw6qXca9+oNl1sfJBw31MQ3xjhpVFoF
 3SIsV+I/0hdOkLBIg5DbxHLbEVgNNwF5plDglZ1v9ldlK1MXIfFkEbFkjwK3oNqSbi0YAV39qGu
 i6Dc1siB2lfKONA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If there are no courtesy clients then the return value from the
atomic_long_read() could overflow an int. Use a long to store the value
instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1f3e9d42fcd784ea8d101ad3549702a30dfe9058..aa0afd1b19a254686ef1f15f5f11db1c79d69096 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4819,7 +4819,7 @@ nfsd4_init_slabs(void)
 static unsigned long
 nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	int count;
+	long count;
 	struct nfsd_net *nn = shrink->private_data;
 
 	count = atomic_read(&nn->nfsd_courtesy_clients);

-- 
2.48.1


