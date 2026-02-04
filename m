Return-Path: <linux-nfs+bounces-18719-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG/GBrCAg2nsogMAu9opvQ
	(envelope-from <linux-nfs+bounces-18719-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 18:24:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 314E7EAF4F
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 18:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BDF7300292F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 17:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009DB349B15;
	Wed,  4 Feb 2026 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thvjEOfD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA731B107;
	Wed,  4 Feb 2026 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225834; cv=none; b=m/RNhx4uyjhAmY49I4gv5hkkIfylJcaFcO6mLo6bE6MOyBw5uQFiFkH0hHD5r1X3MHLKXDCsaCNX6psgaAMxWVH2KcaVm9ZerRj4+uPBMAFYRRlzIx4Z7oWMpiMvfuftKeQEAL/1OF+IFlkYhoxtXKMu9+wLuJ1mDGvF9iVybM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225834; c=relaxed/simple;
	bh=voSN/dV6tUmc8Q3z1BnFw6AyO/9VfT+byasGH5r7/S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VwUVva/wJdP2JysqJQegvdeb77wyntoPklnMWA9YVdDm/X/Ux6sdbryP2y1yCmcU4h4LicRXlAcKEzqKviBTX1AK7DH28ODwO38wmTi4feip9A5zSN5N9Bz6EImBKov3I4n9aEOl9U07B8h/DripjWYNX6FbkkwP53NOgaQsMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thvjEOfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B08C19423;
	Wed,  4 Feb 2026 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770225834;
	bh=voSN/dV6tUmc8Q3z1BnFw6AyO/9VfT+byasGH5r7/S0=;
	h=From:Date:Subject:To:Cc:From;
	b=thvjEOfD4JeQ46vi6NfsYrhhtsy0i+4yoeIRlAjZacOrFlpijx2M7uuMvAU2BtJUp
	 MjdzWPiFqrRuFvTHCbvmnPxtAXP8S7Nb+PaUwkdLR7pqxIEs87iemyvQVgl4BGiKrq
	 1sdYQ/IYWzx/GbY/ZJ4ntYe1SjuloYpgroMwQnqByb3hieDXHkBBLVJX4tw9cHmdwG
	 WBbWmtXk3O0d7TGP/y2OD19VoHyp2fVKs79kicfIP5q/AO+04FdYNHk0qGymfsQMa/
	 995FHnp3G+MTsAAbmjDnn2CRyqThdbiWNp8bqzQlKgyl0MdJ/Sb90h/g3C82BXzUnJ
	 XuhwVDft8bucA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Feb 2026 12:23:45 -0500
Subject: [PATCH] nfsd: report the requested maximum number of threads
 instead of number running
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-minthreads-v1-1-7480176baf35@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwMT3dzMvJKMotTElGJd8ySjVCMDS7PkFHNzJaCGgqLUtMwKsGHRsbW
 1AGvhFQ9cAAAA
X-Change-ID: 20260204-minthreads-7b2e2096cd77
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=voSN/dV6tUmc8Q3z1BnFw6AyO/9VfT+byasGH5r7/S0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpg4CpvrNqafBzoqH5DaXVF3NoAFAmDtcPFUszp
 WIZmcE+09yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYOAqQAKCRAADmhBGVaC
 FaPQD/43xyN5S2I7G/76N7zWYIRhMHeCUZbE1psRAwKlBvV+k6bA5l4byn3qLBQKYnFDy948D8w
 4IhoF1sJtfL8lNeywua2Pdvh4kKc/uh9YStpjtqTOaQxOPmUH402Z+BD6jQkApk21gXN7RYm2cs
 /H0EyaPSIp2OgG5T1cP50eN2dYQikZygVgUnb6vKKev+hdqxygXsDNIC6aOcPQ/nONxpzB5LYJb
 bNzjGXCItw1lvbbuyInNOgC4mMYXrrB4mcxH17bG8GBcrdpWn1Tit/kH3LVdBdKFz2su2Hh1Zde
 3Z/G1zIxlPKahqaXBV7j6b0Q7Sph4hnydJMdBTlSYKeJfWnw1CMiLWedPHuBwNTC+9gpt7Ah4f0
 G4atl5OEwElrwk756dNqQ2u2O4OMCt4XuNFg1dJ0DG8OTBDm4yKl+nYzp20WrUp4ywY8k+GrAQr
 txmwNee4Yiy0MkcKmHSSABJ6EAvMeRVozXE4X5M9q3/xYrxPcIi3qFnAxVTVYihwglM5f86lG8q
 CViP4ubSNjt0xp0M7n52gAPs2TjKlHIgNK5ioNpNgEXrhFRPmfBYA+o7VqGfMFTzy5UuuY+GcSy
 SVqFTQbyJujn8/I1O0Pq2tGd/XgBFQJpzdsTSF5HTkuP9vv/gjn/957kJ+bVwA3sDW7PB/b8FiW
 uQWgHTzYsxwwe8w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-18719-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 314E7EAF4F
X-Rspamd-Action: no action

The current netlink and /proc interfaces deviate from their traditional
values when dynamic threading is enabled, and there is currently no way
to know what the current setting is. This patch brings the reporting
back in line with traditional behavior.

Make these interfaces report the requested maximum number of threads
instead of the number currently running.

Fixes: d8316b837c2c ("nfsd: add controls to set the minimum number of threads per pool")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I think this is less surprising than the current behavior of what's in
Chuck's tree. We could also consider adding netlink attributes to report
the number of running threads, but you can get that info from ps too.
---
 fs/nfsd/nfsctl.c | 2 +-
 fs/nfsd/nfssvc.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 4d8e3c1a7be3b3a4e4f5248b27b60d6b3ae88d51..178c7646b2e25630b85de937d7ced18947c047f9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1700,7 +1700,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
 
 			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
-					  sp->sp_nrthreads);
+					  sp->sp_nrthrmax);
 			if (err)
 				goto err_unlock;
 		}
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 8184514c58de8e396795cd4714a04d66d9637f17..be0add971c2d994948c3e8fca19bcf6f3c75dfaf 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -239,12 +239,13 @@ static void nfsd_net_free(struct percpu_ref *ref)
 
 int nfsd_nrthreads(struct net *net)
 {
-	int rv = 0;
+	int i, rv = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	mutex_lock(&nfsd_mutex);
 	if (nn->nfsd_serv)
-		rv = nn->nfsd_serv->sv_nrthreads;
+		for (i = 0; i < nn->nfsd_serv->sv_nrpools; ++i)
+			rv += nn->nfsd_serv->sv_pools[i].sp_nrthrmax;
 	mutex_unlock(&nfsd_mutex);
 	return rv;
 }
@@ -673,7 +674,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 
 	if (serv)
 		for (i = 0; i < serv->sv_nrpools && i < n; i++)
-			nthreads[i] = serv->sv_pools[i].sp_nrthreads;
+			nthreads[i] = serv->sv_pools[i].sp_nrthrmax;
 	return 0;
 }
 

---
base-commit: dabff11003f9aaf293bd8f907a62f3366bd5e65f
change-id: 20260204-minthreads-7b2e2096cd77

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


