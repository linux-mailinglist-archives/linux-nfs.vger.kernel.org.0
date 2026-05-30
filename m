Return-Path: <linux-nfs+bounces-22099-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFQHLfnjGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22099-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:19:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B0F60CED0
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AC153038131
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754973BF676;
	Sat, 30 May 2026 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6f4QzEy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4983AF65C;
	Sat, 30 May 2026 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147175; cv=none; b=dTke8L2ckqAlvm1aC/onbGx0wt1GOvfGJRINruRwtABXM47INlkyc5Xpvr9zwPgPMRVAEYpuOmMGU4OcVCct/aFgM4YookpB7JGjlw7kK4E3kySkjPOI6HQL9xCR3SpFyfxJ1UuzWWsOAQPDSpD8unZC+TTfV4R47b2L+9hSmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147175; c=relaxed/simple;
	bh=K4pQil6EEQxcVQV+dvV6As3uZ3pP2sKiXvsjMGYS06A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+y5HisYZRp4XTe4iwhTtkERp25C3nHsgSUAj2yU/1YBo1vuAzumZTCZIs0amJlp8Xmo2LIYS2ybgQP1x1QfEu3A4t1QAxsCQOyjMlt1jTbQLpQzua9ustCPU57fhe2h1UDecY+cmNcICFkmElfSoUNjj6HUz7YnORraL0Vy964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6f4QzEy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51791F00898;
	Sat, 30 May 2026 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147174;
	bh=nrFvrNgc+rOLYbN4gcsqJjA+wO93cTh/W5ieXGGabak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N6f4QzEy2Jb6tcQoiokpmfBsckRsWOoG6vTXNxO+0rd+aQqTkyHVn/sG5e3ajnfC+
	 mPVeSQSpoAuk0LQyP3ByQbw6Lt796+bbPZCFRFcqrIMUQh82X98a2/qI/dFx/0uYel
	 bMElCn+soGXQqeIwhCCZmLPBHIxx5J8yystyXYP9MAckf4CjaClP3MxnZDCmJp9W7A
	 s5qV8I1lpQQvtCgbrH6kSMmcmLhW0cbq7ywbKX5kpEYbcBNWtwFf8KnfZsMjmR4krg
	 Ym9NddA4tGzzdldj0dQbRG2vbqWmYhLsc57c2bzkjeeYWDQoT5zpc96bkrcW/V38MH
	 JUiC4AM2yRmPg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:17 -0400
Subject: [PATCH v2 1/9] nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on
 racing delegation revoke
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-nfsd-fixes-v2-1-f27e8eb4d974@kernel.org>
References: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
In-Reply-To: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=K4pQil6EEQxcVQV+dvV6As3uZ3pP2sKiXvsjMGYS06A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPhXjjZvJzbMc8zZVo+KElrvOzq57vb4S4T3
 u7w26UXMIGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj4QAKCRAADmhBGVaC
 FQGvD/9GHGEVVerX+v92RQzFq7rL6zQOJwlKulpxEFbSOlpZ+CJyqBaB0m4rwMhfmY8G3+QWXgI
 Z5Mkm1SRfrxtM0wOh0YhBX32cKpWLp7xD0lLDhFzgZj3b7EosXzLF4RWPtkM9hP8l7Htd/dMRh9
 M2MdiqeIm9ckLJ9LnCY1ZrpHVrAKnaQuVfJFryUkGBUyMxoCqa0Bw/qk62Gti1iSd/vbgRAkVdI
 EtdxOTkU5NQNfQFmezNw62ZdDziIB57caeg/9QYulz4gOoATVMij110K6BWsJI8CEWbS4fezT+g
 thmgHVKnCMc+0fvA3bLfK+hKmzqq+DRfBkGSQyw/Pw/vY0NcRaXKAkSBb3lzeCET1cK6+6HGmtX
 jMWduqWVfMNmxnyb++EUNZokqPFLaQb/jg7zPGSxIAzu4jxamdv6Z0nClntYVTOTNOBRHud6duB
 LsFKYnrjJ2LYwynq4QDBP20s6erkDUcIFpo16jhSQnbBsBbO+jqkutxRClIp1br6sGuxNUsEjBa
 IFmEl4z6GA01VnrIodXIWatxkW7FsynfHHqC1X33H3C5Qo2eLMVClZkzszxpy2a/TMhsNOpDgkZ
 88KSghoUpgny4xOpYLSyKL5+6f0+3k/BbjX1nR2bWxbEgLWJWK16rNPrT6uFSn7IuFvOiEQU9gZ
 CWNh/1EpDHw7WuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22099-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35B0F60CED0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_alloc_layout_stateid reads fp->fi_deleg_file without holding
fi_lock when the parent stateid is a delegation. A concurrent delegation
revoke via the laundromat can clear fi_deleg_file under fi_lock, causing
nfsd_file_get() to return NULL and triggering the BUG_ON.

This race is client-reachable: two NFS clients can trigger it by having
one hold a delegation while another opens the same file to force a
recall. When the first client doesn't respond to the recall, the
laundromat revokes it. A concurrent LAYOUTGET from any client using the
delegation stateid hits the race window.

Fix this by taking the rcu_read_lock() around the fi_deleg_file read in
the SC_TYPE_DELEG path, and replacing the BUG_ON with a graceful error
return that cleans up the partially-initialized layout stateid.

Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls")
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 9ed2e3d65062..6c4e4fdd6c05 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -247,11 +247,17 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	nfsd4_init_cb(&ls->ls_recall, clp, &nfsd4_cb_layout_ops,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
-	if (parent->sc_type == SC_TYPE_DELEG)
-		ls->ls_file = nfsd_file_get(rcu_dereference_protected(fp->fi_deleg_file, 1));
-	else
+	if (parent->sc_type == SC_TYPE_DELEG) {
+		rcu_read_lock();
+		ls->ls_file = nfsd_file_get(rcu_dereference(fp->fi_deleg_file));
+		rcu_read_unlock();
+	} else {
 		ls->ls_file = find_any_file(fp);
-	BUG_ON(!ls->ls_file);
+	}
+	if (!ls->ls_file) {
+		nfs4_put_stid(stp);
+		return NULL;
+	}
 
 	ls->ls_fenced = false;
 	ls->ls_fence_delay = 0;

-- 
2.54.0


