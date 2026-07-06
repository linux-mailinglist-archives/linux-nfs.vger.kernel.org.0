Return-Path: <linux-nfs+bounces-23011-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n0JOK5wES2reKwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23011-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:27:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753C70BE95
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:27:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QRTsbDxs;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23011-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23011-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DCB53016CAA
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 01:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FD817A2FB;
	Mon,  6 Jul 2026 01:26:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B7322B6D
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 01:26:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301161; cv=none; b=NlQZIXv8q3nToq5x0EPxjaQjQ1yfzu0VZNOpVGZiXeTTXtOUVn+sL+qfIQx8SYFJDGNlqwsWCBCmjFusDDsjDSqrRIz72wgPJxRY6LY2ojogUmJ1UggacDaFinM7l0rxnEhy56zA5WYpZK9goF3+78vYjKfgRsNcrLorgrmSY8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301161; c=relaxed/simple;
	bh=sPMlGAlzQOTdelgvYO7D1q5J5d/f4LL5dBKYxTxtb+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4KB44oLWdE94U5tXXZdSpstBCXwUAx8FaukiupUeDWnqoC2M4c6L7KGXrAXXWdLmDDdGkuEPfgBdyn923btknHiqLr+2R+SLQCDaE96M1WxQZNb7R4Sogw0PbOVMieVJJxPA5zze8xAW+aKKCNiN4yTewQq5aiDSHTUSk115OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRTsbDxs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA021F00A3D;
	Mon,  6 Jul 2026 01:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783301159;
	bh=SxQAcatazlWzfE478KoxuXqy+jBGuzlZirS+OSd96Fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QRTsbDxsHMM17ujp4YETmzK+dd0IbpFFzrTqWEdU/UBDjXMcYVlP8qwpCAcRkJj8k
	 aS0Fj6dyF1J1hc2Tjizn5aMEqu5skHIirqq+i2+JeWsADMf309SBSh0rWOOcIpg81v
	 vLpiOgSjS3MbIX8/ClECln1ev5mLIWnYoleFGNrRcSBSOzvatJ08DkGORmFWgJAuJf
	 iz5mab5I7S/J+N4xBYVGogsk6OQEBqfnJGTU/QLtw1hvtdmtWhWwsjD/d0mKx0nDb8
	 uAjpBLuoVlI9vKJ7rfLRWYQhHrR8tRRed77Hd8lkNCRYfvEnBq8Gf6oaHKKLf77mSi
	 am6P1DVX19DtQ==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 05 Jul 2026 21:25:37 -0400
Subject: [PATCH v2 1/6] NFSD: Prevent lock owner use-after-free during
 client teardown
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-cel-v2-1-d88c3b68e8bc@kernel.org>
References: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
In-Reply-To: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Wolfgang Walter <linux@stwm.de>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=cel@kernel.org;
 h=from:subject:message-id; bh=sPMlGAlzQOTdelgvYO7D1q5J5d/f4LL5dBKYxTxtb+I=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqSwQl3sNXs7J4L+Rv6JSHojjlvjSvGrpuaWEIb
 Kolqky7AWaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaksEJQAKCRAzarMzb2Z/
 l1jOEACNNettdty9q6gUE3EoZn1qy/IyZ85Ko67WTZHbGElUhsPhD8qCloJxvbZkkQNZpKHAgAw
 5fhBA1gfZUoHPYX8jv3oASPwYY9ronNxNcqWUJnlm9BbbaVH/bynvNJOurRnSYKSHDvfQKytCZn
 6EwAYIrZHbM1F3y4jvZfQBGrex0q76SS5afR/JQT0RsYIY7RDP3xmQUaU5uO8zdpSn1Aje+hLg2
 qK7F5eafHYCCcy2KmM7D17FKkMn6U7HVdAq4bUsXqwe1Gk0QEWq0mn7hSJIJ0bJyRCRl8whZxO9
 dolHWeTuWgu8RXZOX3cePMxmxnqFRoofhsggm0U5EJ7rU9Ba0cQdbqISsFxrx2k8SvSMwAoFrC7
 8l3AmHF63WnLe+X7T/+0AKe9SCKlsoVETwI6yhtJrWJQyjp/vYWjulARXpnxPqSV0xoIei3LDqG
 11A1hHtBex3aB54NLHSem/FZOyVnJEg3Uulsm5B3ra7pzke4lUR0KULMFAl5zZKODMAMHmvpqJP
 +u4EJmkDgTQEdgLuWlTMr75iTuaHxICvqCzz5rcOC8d9cnq1jpq3sZYZMxfVSypapMxWzvih5Y8
 6EMk8SVzLXMv7/q5G4njqGCtTyRcpuYF8d1kqdJE5zKmYFeYEkzV3lJ1kHh0ZhnvYN7HnmuzlyO
 VuvUKYy5hC4EsYg==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23011-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux@stwm.de,m:cel@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2753C70BE95

After __destroy_client() releases a client's open owners, a lock owner
whose only remaining reference is a blocked lock (nbl) is left on
cl_ownerstr_hashtbl.  client_has_state() does not account for a bare
lock owner, so DESTROY_CLIENTID can reach __destroy_client() with these
lock owners still present.

__destroy_client() then walks cl_ownerstr_hashtbl and calls
remove_blocked_locks() on each lock owner without holding a reference.
Freeing a blocked lock drops the lock owner reference held through the
file_lock's flc_owner, so the per-net laundromat, which reaps timed-out
blocked locks from nn->blocked_locks_lru independently of client state,
can free the same lock owner concurrently.  The two paths serialize on
blocked_locks_lock for the list splice only, not for the lock owner's
lifetime.  The laundromat can therefore free the lock owner while
__destroy_client() is about to dereference it, and the freed, zeroed
slab object produces a NULL dereference in remove_blocked_locks().

nfsd4_release_lockowner() holds a reference across the same call;
__destroy_client() does not.  Hold cl_lock across the walk, and
take a reference and unhash each lock owner before dropping the
lock, so the laundromat cannot reap a blocked lock and free the
lock owner underneath this loop.  cl_lock is released before
remove_blocked_locks() and nfs4_put_stateowner(), which take
blocked_locks_lock and cl_lock respectively.

Reported-by: Wolfgang Walter <linux@stwm.de>
Closes: https://lore.kernel.org/linux-nfs/6eccafaaaa60651ef091257c3439c46b@stwm.de/
Fixes: 68ef3bc31664 ("nfsd: remove blocked locks on client teardown")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a4398dc861a5..e000ed3e96e9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2758,14 +2758,24 @@ __destroy_client(struct nfs4_client *clp)
 		release_openowner(oo);
 	}
 	for (i = 0; i < OWNER_HASH_SIZE; i++) {
-		struct nfs4_stateowner *so, *tmp;
+		struct nfs4_stateowner *so;
 
-		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
-					 so_strhash) {
+		spin_lock(&clp->cl_lock);
+		while (!list_empty(&clp->cl_ownerstr_hashtbl[i])) {
+			so = list_first_entry(&clp->cl_ownerstr_hashtbl[i],
+					      struct nfs4_stateowner, so_strhash);
 			/* Should be no openowners at this point */
 			WARN_ON_ONCE(so->so_is_open_owner);
+			nfs4_get_stateowner(so);
+			unhash_lockowner_locked(lockowner(so));
+			spin_unlock(&clp->cl_lock);
+
 			remove_blocked_locks(lockowner(so));
+			nfs4_put_stateowner(so);
+
+			spin_lock(&clp->cl_lock);
 		}
+		spin_unlock(&clp->cl_lock);
 	}
 	nfsd4_return_all_client_layouts(clp);
 	nfsd4_shutdown_copy(clp);

-- 
2.54.0


