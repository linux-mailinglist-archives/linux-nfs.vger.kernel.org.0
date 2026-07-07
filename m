Return-Path: <linux-nfs+bounces-23144-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GtUVFSFUTWrHyQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23144-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:31:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B858871F3C5
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:31:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YKm2J7+A;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23144-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23144-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30F6A3013B8F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC0F2D8391;
	Tue,  7 Jul 2026 19:31:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B63148D9
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 19:31:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452703; cv=none; b=BFN/mVvtqVVH8T7nVoJzaCoo55JLJaezYkWRwiNrtGHrcvxEFFxsUyUZc9JsItXIrZsbw1GTOg0w7H3mK/e0ewfzTCuLZvwE4lfzYwAJb0r3aee6Yu3Z+guxXumgSHjBEcRer03aP09GTlh67CW3h70eBk6o9MEhxKskZ6zLHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452703; c=relaxed/simple;
	bh=Bnz0DH+LSldhHkcyXR2kaynlY6v1355RFkpwxlsqFnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5VDpFU/V3Y7S0HI9w06FIDHasZY+7u7b4TWMG1yqyQv8uEXnne0+/fAukMAEqn8Vo1k8bupdc2eaoP3lzjMcxM3drPrKSVa/l1prES21jYlLOR7I+7UVkD6woqEttzGX1jsQ/ibzoppjkulXtdOHW1p8Avf53MYfxSiv9QnKic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKm2J7+A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232711F00A3D;
	Tue,  7 Jul 2026 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452701;
	bh=T4mQmBtcEZgche4SQCCmXZcj0Cp2O6lYsK3HIu6Ohu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YKm2J7+A5jblGJLU/M2kq8QzEiowY/5Bo5cfGDr0R39F8WTTnlx5czvulmLQwhzmz
	 en0b1mH9XvfEIdllFLXrnT190Eo14KlDE4adLufvyloUCVffOOB4xoYRaqMpG7TuWp
	 2OoPSMPPSsqdGyAnoHxtm6959fPdYs2ojlrSFKmotSoI0Zaf/uTeLJ7oHgqLlaXZMd
	 IQJZ2RIG0G3jwt6QkjzjmSfWrh6wuA/QYX4JE4NgJyUIAWVnCIWtIbbMpoHi2cbID0
	 soK/XpHfF5aYTlKVlE1iO1fXKn1tOmEH0XiPNk1loMJm874QiTLKvnrkBoL5K+qSU1
	 oZrMOSoEdCBow==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 07 Jul 2026 15:31:21 -0400
Subject: [PATCH v3 1/9] NFSD: Prevent lock owner use-after-free during
 client teardown
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-cel-v3-1-7c0cc16fd54f@kernel.org>
References: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
In-Reply-To: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Wolfgang Walter <linux@stwm.de>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595; i=cel@kernel.org;
 h=from:subject:message-id; bh=Bnz0DH+LSldhHkcyXR2kaynlY6v1355RFkpwxlsqFnk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqTVQbiLODR1MO327wkvxJINP5YjaKMquwHeqTS
 e25nbo3as2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak1UGwAKCRAzarMzb2Z/
 lyzcD/9lp247YHgQk/3T9lfYCJDSbr8LCKU3Ph5Jvj117BWbE37Hv92ScdFye6a+shUe1TUok0Q
 iykDq6plMK+C8d5v5S2dy+4iDzsFIIHqJH6ovRCbq8VdKJt69rbq8KH4hGOD7g5OqItAWgA07WT
 9IXvqJ6BRx4tTERhoBzzEGTwiHXo1bVy8flUVe3EakMItZewA7Bz1mqYbG2654proIjSqz6nJX+
 hQPIlOAUE8t8vmr7m/1+vDoZKWBkqzjksPD5HI88lNBkRuJJKIXbdr2LCgU6x80ysLWxR/P7tjV
 gT3FZ3VNO4rUBoPe+UTsj964iG46LY7BAceWB+DVKzzzLp3DxZhCTOFjtPitDZbSZEITeBhDYR7
 CPycK/KY+ct4y1shyM3Zrjcgyzn5sIvZoGS+WzQLzTvkwWtHZ8gYZuWknpjCMgrPM2M5xykM0m6
 yX0nbS19saoyn/aakGhqYAYk8QYf9NbvHY0/KPAjGZEKy8sqMhzpQQvlPRYO3D1LOp1nZx5cBWQ
 F4l2DB1exCGBbwvce+pwzQpdbbsm0y14qdg3ohJjG8nHVZGIWh3z25tSEIGB8NR54tXprK4QhJD
 MPkh694sk7WkrpfDk/zrEL7BR4nJmSZSTiYGzVTedFjN+mZfLc/6knbNIdwbnXiFCKo15b0fBoW
 IAdJ8sn5ZsKabCw==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23144-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux@stwm.de,m:cel@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,stwm.de:email,brown.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B858871F3C5

__destroy_client() releases a client's open owners, but a lock owner
whose only reference is a blocked lock (nbl) stays on
cl_ownerstr_hashtbl.  client_has_state() does not count a bare owner,
so DESTROY_CLIENTID can reach __destroy_client() with such owners
present.

__destroy_client() then walks the table, calling remove_blocked_locks()
on each owner without a reference.  Freeing a blocked lock drops the
owner reference held via flc_owner.  The per-net laundromat reaps
blocked locks from nn->blocked_locks_lru independently of client state.
The two paths share blocked_locks_lock only for the list splice, not
the owner's lifetime.  The laundromat therefore frees the owner as
__destroy_client() dereferences it, a NULL dereference in
remove_blocked_locks().

nfsd4_release_lockowner() holds a reference across the same call;
__destroy_client() does not.  Hold cl_lock across the walk, taking a
reference and unhashing each owner, then drop it before
remove_blocked_locks() and nfs4_put_stateowner(), which take
blocked_locks_lock and cl_lock.

Reported-by: Wolfgang Walter <linux@stwm.de>
Closes: https://lore.kernel.org/linux-nfs/6eccafaaaa60651ef091257c3439c46b@stwm.de/
Fixes: 68ef3bc31664 ("nfsd: remove blocked locks on client teardown")
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


