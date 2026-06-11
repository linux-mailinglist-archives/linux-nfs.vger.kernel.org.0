Return-Path: <linux-nfs+bounces-22449-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xu0HH4AWKmozigMAu9opvQ
	(envelope-from <linux-nfs+bounces-22449-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C756D66DBAE
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="T/fXaqwU";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22449-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22449-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F2C630B7261
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1FA18787A;
	Thu, 11 Jun 2026 01:59:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7A17A2EA
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 01:59:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143161; cv=none; b=fffOy5co/GUbGw2FV7SBYJyKn7M04NTp9bJbH4WV67jB9QG+RQYyaZgDto94V46MY+RB5dZiyho8flXlpwmQRl3h6ioOeNuZVAkBIQU0RO0al03+JQLQR+5N/PUpbUc9yXVlCw9EdVtOhBD9RsINr63foCJ3mDioMGkaBovwCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143161; c=relaxed/simple;
	bh=WeqonWM3g00s0RagzEiz0LADwf744G4e17DXhPM3YIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CEpfNOTx0vPPA+pFxPuWgnL1e3PzRFAt799GofNaE2jrEUUR179i5dy++RghEC1vNDYzreh1dem/xxwkLiBD5NJ644x1s+IWmGY5zwQMHPbg3jfROmBZnQ0bM6vOYoRMCTk0MhJOvFkc8VKBnZ1I4jNEO/tFcBr1v3f+tyB46wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/fXaqwU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E0C1F00898;
	Thu, 11 Jun 2026 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781143160;
	bh=ajQNLYdkSaZJS8vJNnTXOY2a9uiNoBQDaOdNxRB5jYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T/fXaqwUbz7QRTJ7cINsi4FVmhyH3gTUY2hMH1NG4LgdEuzrFHxGvYY1FhjPdJDnn
	 RoyeSvZX9GTQpx7/+lVcdFe0ma/WA1we0X/1c7QkBFPfjlQ5TyEo40xsKDPaIXJ1vk
	 WlgN+/eOiUQfl+YXg4tVGrlDko7XLTjVKUEiRuPWgnDo9dr9ha8mW4gWYFI2hU1mjs
	 3VbKu+j/s0VipYXeaT2MEjhoicSMeQBKEtIsZs0L5cYkH+jHBHtpdVUd3vleWrR7tD
	 l3bBiHn44uqGzYLioO/BcXqDBjMFym4pTedtPVuuhcw4vlMJwVoMtLAnYPD41ixaOk
	 K6YCTDyN2L7vg==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 10 Jun 2026 21:58:54 -0400
Subject: [PATCH 2/5] NFSD: Count slot 0 in nfsd_total_target_slots
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-nfsd-slot-growth-clamp-v1-2-7b966700df0b@kernel.org>
References: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
In-Reply-To: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, 
 Jonathan Flynn <jonathan.flynn@hammerspace.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4768; i=cel@kernel.org;
 h=from:subject:message-id; bh=WeqonWM3g00s0RagzEiz0LADwf744G4e17DXhPM3YIs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqKhZ1bgFbJtB/YSQAAlggcCWEHCVlXBATq8b1f
 GxPWQuU7AiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaioWdQAKCRAzarMzb2Z/
 lybzD/9Vtbcu1DGN5O/rdaOOS7lAA8Uy958A5Uzo8GlbdnhakHCft7o/qFSWvzpMk6ekktMf1TS
 j6ZyxoNXgh+b+cj3/vXKWRqjR6jp+gROSsKHTE7cX+ZsKyjxyqVye6PsQBQfPqJHd5y+6jDziBE
 KPTlooWxfkwoyK2YdQsgWSqDMK9ba3nH3rKaS4UQfmWD1rI5YarZjgrjsPAeB1xKNntfnJx2eWh
 DeRuk2XieIkqfxib2SLQo6PGjF6xZYWYbLLEr2pYc7x8An442N0H6QiIYUbAr4VG1j2wYYJ7psx
 BvCDsxLlKicB3v2Eb+VWNn2o/Z1Ph5p97YnwZNfKLnDsHe7YaNjqWRG0Fhp0lNIq6H5VH1MfxCM
 sqQOtVbl0yXb1EWL1HAxhDcaANimEy0LmilgUXh8Ma5q23lJwXTYrlDhdt1uH6+l3JG/poKB9o2
 2b2pDrgiMYqC0JK5BeE/PZfSQ5f7ZZsxIvzQXrGg2q3mQGtfoVWjHoGl36194zM46CGg9/mcbd6
 3wfmQdCAl7Ib0knXC24R0D88Cift4iVKwJHot8x7l6dAwfhRI60VmTwHz5HZotkJy2gvgeODHEr
 9B9GsaJ0TFkEJVBtdQZocFWsq8z4tE2GbsaF4OCNh0tg0clIccGu19RuuXU9abhigTUkZF6c7I9
 QsaSv3RwGV13pew==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22449-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:bcodding@hammerspace.com,m:jonathan.flynn@hammerspace.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C756D66DBAE

nfsd_total_target_slots sums "target_slots - 1" across sessions
rather than the full target. Its sole consumer, the NFSv4.1 session
slot shrinker's count callback, must report only reclaimable slots,
and slot 0 is never reclaimable while a session is active. That
correction is open-coded where a session's full target enters and
leaves the counter, as "i - 1" on alloc and "from ?: 1" on free,
and reads as an unexplained fudge.

Give nfsd_total_target_slots the full-target meaning its name
implies, and move the reclaimability correction to the single place
that consumes it: nfsd_slot_count() subtracts nfsd_total_sessions, a
new tally of the sessions on nfsd_session_list. One correction at the
consumer is clearer than repeating it wherever a session's target
enters or leaves the counter.

The reclaimable figure the shrinker sees is unchanged: slot 0 was
never reclaimable and still is not. The change only relocates the
minus-slot-0 correction.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6837b63d9864..f2c92e7eee6a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1952,12 +1952,10 @@ gen_sessionid(struct nfsd4_session *ses)
 static struct shrinker *nfsd_slot_shrinker;
 static DEFINE_SPINLOCK(nfsd_session_list_lock);
 static LIST_HEAD(nfsd_session_list);
-/* The sum of "target_slots-1" on every session.  The shrinker can push this
- * down, though it can take a little while for the memory to actually
- * be freed.  The "-1" is because we can never free slot 0 while the
- * session is active.
- */
+/* The sum of "target_slots" on every session, slot 0 included. */
 static atomic_t nfsd_total_target_slots = ATOMIC_INIT(0);
+/* Session count, subtracted from the sum to exclude slot 0. */
+static atomic_t nfsd_total_sessions = ATOMIC_INIT(0);
 
 static void
 free_session_slots(struct nfsd4_session *ses, int from)
@@ -1981,9 +1979,10 @@ free_session_slots(struct nfsd4_session *ses, int from)
 	}
 	ses->se_fchannel.maxreqs = from;
 	if (ses->se_target_maxslots > from) {
-		int new_target = from ?: 1;
-		atomic_sub(ses->se_target_maxslots - new_target, &nfsd_total_target_slots);
-		ses->se_target_maxslots = new_target;
+		int delta = ses->se_target_maxslots - from;
+
+		atomic_sub(delta, &nfsd_total_target_slots);
+		ses->se_target_maxslots = from ?: 1;
 	}
 }
 
@@ -2079,7 +2078,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	fattrs->maxreqs = i;
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
 	new->se_target_maxslots = i;
-	atomic_add(i - 1, &nfsd_total_target_slots);
+	atomic_add(i, &nfsd_total_target_slots);
 	new->se_cb_slot_avail = ~0U;
 	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
 				      NFSD_BC_SLOT_TABLE_SIZE - 1);
@@ -2207,9 +2206,10 @@ static void free_session(struct nfsd4_session *ses)
 static unsigned long
 nfsd_slot_count(struct shrinker *s, struct shrink_control *sc)
 {
-	unsigned long cnt = atomic_read(&nfsd_total_target_slots);
+	int cnt = atomic_read(&nfsd_total_target_slots) -
+		  atomic_read(&nfsd_total_sessions);
 
-	return cnt ? cnt : SHRINK_EMPTY;
+	return cnt > 0 ? cnt : SHRINK_EMPTY;
 }
 
 static unsigned long
@@ -2260,6 +2260,7 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
 
 	spin_lock(&nfsd_session_list_lock);
 	list_add_tail(&new->se_all_sessions, &nfsd_session_list);
+	atomic_inc(&nfsd_total_sessions);
 	spin_unlock(&nfsd_session_list_lock);
 
 	{
@@ -2333,6 +2334,7 @@ unhash_session(struct nfsd4_session *ses)
 	spin_unlock(&ses->se_client->cl_lock);
 	spin_lock(&nfsd_session_list_lock);
 	list_del(&ses->se_all_sessions);
+	atomic_dec(&nfsd_total_sessions);
 	spin_unlock(&nfsd_session_list_lock);
 }
 
@@ -2481,7 +2483,17 @@ unhash_client_locked(struct nfs4_client *clp)
 	spin_lock(&nfsd_session_list_lock);
 	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt) {
 		list_del_init(&ses->se_hash);
-		list_del_init(&ses->se_all_sessions);
+		/*
+		 * unhash_client_locked() can run more than once for a
+		 * client; the session stays on cl_sessions across calls.
+		 * The first pass empties se_all_sessions via
+		 * list_del_init(), so skip the decrement on later passes
+		 * to keep nfsd_total_sessions from being double-counted.
+		 */
+		if (!list_empty(&ses->se_all_sessions)) {
+			list_del_init(&ses->se_all_sessions);
+			atomic_dec(&nfsd_total_sessions);
+		}
 	}
 	spin_unlock(&nfsd_session_list_lock);
 	spin_unlock(&clp->cl_lock);

-- 
2.54.0


