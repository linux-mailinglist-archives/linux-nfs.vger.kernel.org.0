Return-Path: <linux-nfs+bounces-23150-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNTCLClUTWrOyQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23150-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:31:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5353671F3D2
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KiKe3jaF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23150-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23150-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B90D4301A454
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CA138F920;
	Tue,  7 Jul 2026 19:31:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2A321420
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 19:31:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452708; cv=none; b=V2cVlqKZM3DR2cN6vnk3w0sjHvoDHxPu1M6x+R2ZaJ3yQuqID8YaZxB3RIOR6218itW7EFnO3QiiVCkQVOcC4lzTyMnDDxRHiLLaEI1BMVIeKmTb57BTXh+ActG0eG1i7hyCrPXwQktujT4iYYKDI3KoJn3VXAeiG0nA8zfQCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452708; c=relaxed/simple;
	bh=7eLmnMwK8q+eAHwq7CBhow5JoNUl5reblYb9N9juiZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YsB65Mu3Yt2g2GuNsAWFs+YaqSPyKwONHbbK5y0EHmpdX4xX1UOveCwIXqOlUm0WIi3Pc8PpMfCRG2z3o3eFhXsGeKiiOR5IVz1kX/wCsZoXRnNw14FcDVQYW2tur/d1gsJJLL28ajf5OaJJH3/WYT+U/tiEHirY77rVPQNv+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiKe3jaF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF33A1F00A3E;
	Tue,  7 Jul 2026 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452706;
	bh=DtMo+OTDVTaohTD7fLBtUExcgy3ncWSmLJKUAhryAug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KiKe3jaFsUc4B6uya/SYnPGS1lyWjxB/rAiSZsSLaabeuvIsE0mrBmN3zpWcSzF1t
	 WGSeeYOl9K1NRrn3FxMNNkFuBFQSxHEYU34z4hAgnOOpkoiDm/rD83hDIjIwlUK9ol
	 1iwbSemIzSNTyRG3c1z1kGRxXyfNJBM0y6p4MmPE5tP8qJ87AFuioUPkRpAKR7f5YU
	 4jt+KVzWZMIBOj8cclYWpQHlOBRJA15FdTVVf1AGNN7hxwZbk425ZoXGwH/EB645Dk
	 uMgjTeG6GZVfywznFQhraSyZanZb/8Rleh7TFUTpZlsZ+RhcWld/EGSfo4ZvbjTMup
	 uXUuGhqv+E1JQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 07 Jul 2026 15:31:27 -0400
Subject: [PATCH v3 7/9] NFSD: Prevent client use-after-free during
 blocked-lock reaping
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-cel-v3-7-7c0cc16fd54f@kernel.org>
References: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
In-Reply-To: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2984; i=cel@kernel.org;
 h=from:subject:message-id; bh=7eLmnMwK8q+eAHwq7CBhow5JoNUl5reblYb9N9juiZw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqTVQbwYFOjllGBw/8GX0O92kst7+fzfAdmjKh2
 +AZ2oyhfZmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak1UGwAKCRAzarMzb2Z/
 lyOAD/9a6vptOoucIvPXi1T+jI8ZGqS7oWFWKRVony1B+2K9v1PhEgQ/phgp2OnkFuJlLmOAkvK
 ghWsfq61SE1fQ51AqjPhfE2L8963qraRiTeAvjL0Tz1i3HKxn0cEyh6h/F+qcfzbj73nyzlvwrd
 pcSJ8WzvqcHZypK/XAkAxyPC77sGKGkp8KwiisEvO1QQcU0HI0ve6kiXuIyY3a51wNYBy137/jN
 IFjfLKvh6Zi5FNtIIjZsQCiJk7fduJ910bO/8a56oRLK+rGhTWSJUIvFqH6mwk3/oXUUPlBzeun
 cs198yUWEb4OFKunoD6ktRET8HSp75FO2xoDkvkTZEpwXuwb5ZbSMGiHjIA1cvQL3Y9WqgqOaE3
 g+oqfvqWBly4ab7V93hz1TOhK8ATgDrBYxrDbZt8HzTZ5bYvd5T6rwTE6PhdZ3ocix4nWPYuev9
 zf0qHYBAHxvux3L01aCFV4ED7a09VPkzGpMu4qhUSNqfubNHOHhlksAKkXJ21OljPIg55I2ueZ1
 1DZRuARmNZDd4NBw9POMMuKRcTXPSRNwWSG+eXI0se3mCEiKdQhPMWNjdnpgkFYAAW/slgu+Vig
 wMrd4IfluEgNJPqNr9/dhyGINUkTpeGkrU86t/dcbAGiu4YRiLGLYFfGW5sh20TPfkz1SUG1PYs
 yeWlyKILe+291kA==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23150-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5353671F3D2

A bare lock owner -- its only remaining reference a blocked lock on
nn->blocked_locks_lru -- holds a raw pointer to its nfs4_client but
no reference keeping the client alive. When the per-net laundromat
reaps such a lock, freeing the nbl drops the owner reference
held through flc_owner, and the final nfs4_put_stateowner()
takes the client's cl_lock. Because the laundromat detaches the
nbl first, __destroy_client() no longer finds it, so a concurrent
force_expire_client() can free the client before nfs4_put_stateowner()
runs, dereferencing cl_lock in freed memory.

Pin the client with cl_rpc_users before dropping
nn->blocked_locks_lock, and skip clients already expiring, whose
blocked locks __destroy_client() frees while holding an owner
reference. Take nn->client_lock outside nn->blocked_locks_lock.
Every other site holds nn->blocked_locks_lock as a leaf, acquiring
no further lock, so placing nn->client_lock outside it cannot form
a lock-order cycle.

Fixes: 7919d0a27f1e ("nfsd: add a LRU list for blocked locks")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 142ba7d80539..4acd02f1642c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -357,6 +357,16 @@ free_blocked_lock(struct nfsd4_blocked_lock *nbl)
 	kref_put(&nbl->nbl_kref, free_nbl);
 }
 
+/* A blocked lock's flc_owner is its nfs4_lockowner. */
+static struct nfs4_client *
+nbl_client(struct nfsd4_blocked_lock *nbl)
+{
+	struct nfs4_lockowner *lo;
+
+	lo = (struct nfs4_lockowner *)nbl->nbl_lock.c.flc_owner;
+	return lo->lo_owner.so_client;
+}
+
 static void
 remove_blocked_locks(struct nfs4_lockowner *lo)
 {
@@ -7591,22 +7601,29 @@ nfs4_laundromat(struct nfsd_net *nn)
 	 * indefinitely once the lock does become free.
 	 */
 	BUG_ON(!list_empty(&reaplist));
+	spin_lock(&nn->client_lock);
 	spin_lock(&nn->blocked_locks_lock);
-	while (!list_empty(&nn->blocked_locks_lru)) {
-		nbl = list_first_entry(&nn->blocked_locks_lru,
-					struct nfsd4_blocked_lock, nbl_lru);
+	list_for_each_safe(pos, next, &nn->blocked_locks_lru) {
+		nbl = list_entry(pos, struct nfsd4_blocked_lock, nbl_lru);
 		if (!state_expired(&lt, nbl->nbl_time))
 			break;
+		clp = nbl_client(nbl);
+		if (is_client_expired(clp))
+			continue;
+		atomic_inc(&clp->cl_rpc_users);
 		list_move(&nbl->nbl_lru, &reaplist);
 		list_del_init(&nbl->nbl_list);
 	}
 	spin_unlock(&nn->blocked_locks_lock);
+	spin_unlock(&nn->client_lock);
 
 	while (!list_empty(&reaplist)) {
 		nbl = list_first_entry(&reaplist,
 					struct nfsd4_blocked_lock, nbl_lru);
+		clp = nbl_client(nbl);
 		list_del_init(&nbl->nbl_lru);
 		free_blocked_lock(nbl);
+		put_client_no_renew(clp);
 	}
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	/* service the server-to-server copy delayed unmount list */

-- 
2.54.0


