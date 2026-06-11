Return-Path: <linux-nfs+bounces-22452-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IWbXDYkWKmo2igMAu9opvQ
	(envelope-from <linux-nfs+bounces-22452-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B4166DBBA
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZZ9LG+w2;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22452-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22452-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B4430B224D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9217A2EA;
	Thu, 11 Jun 2026 01:59:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611DEFC0A
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 01:59:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143164; cv=none; b=MOACj6FciooLbdkNKVNgG2LHCrZ/vpgcUWnssJVK+7gVRXSqCOiW2YfcFQYjzqXuezxSyQ/SYFIQr5i3DVDf8RUpE4rHVr30eCpRWiSByFsC91ygzpGCejl3jzQoEZluWY1ubyJcby3VBW9hFcYNd9pRSvwvkm9A9ZUt08EjULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143164; c=relaxed/simple;
	bh=kjnObErbq9m3R0HToh985uy6+gzAdML7Gw2ZRKmpuLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyMD1PTKNqnyZOU1Kvz3gDCT+Y9drZ8UU3xhfOgltN7YzCnNFdsRHx/aPupmDZwaepYA2JanrD+IIoVEnIRy2fnSKAim7NvSVDjO3u9/GioSTpebK7Hx47yL6wLAiI3uvaT5SjiQVeyoGA3EOL7ofig3UpYzBGrw5NJH+vvlFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ9LG+w2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42671F00893;
	Thu, 11 Jun 2026 01:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781143163;
	bh=tTJOFk3jL9tb+Fv2YsTYXq5+NCliDESzUkAqKD+0X4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZZ9LG+w2j4AzHsiTjevOS95CNhQ1bH54eS5fXc4s5w9s5wp6JJYMv3GJpswWuJBpZ
	 LrG4fMAXsS5a07fNW/sS822zbY/dqxbArz6XNuaG8jylQjqxVW+XvxKn1x+1+ET85i
	 cvQcYXrbyIKYjYgEJ+zO2a9767Lg9EyQPlOXY45tOFnNwC2vGp6aysupzpAmVH4Bo9
	 VfDdQICaC2cRrUy0hu9I63pXsTMyL8dDlUIKtS1IwcMsNak2S9VOLx7I53iiPSUiqg
	 DoZyfLOVzawTNIp4wE5uxuEosGzLfLiA55bqp3IDYWvUO3CH+OA72DeQ4Qu/WjSPeH
	 KbR84qVrD/uSg==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 10 Jun 2026 21:58:57 -0400
Subject: [PATCH 5/5] NFSD: Bound on-demand DRC slot growth by the thread
 ceiling
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-nfsd-slot-growth-clamp-v1-5-7b966700df0b@kernel.org>
References: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
In-Reply-To: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, 
 Jonathan Flynn <jonathan.flynn@hammerspace.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5081; i=cel@kernel.org;
 h=from:subject:message-id; bh=kjnObErbq9m3R0HToh985uy6+gzAdML7Gw2ZRKmpuLg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqKhZ2HK0cU1am1x36XG0DmLUz+YVERMa6o19c/
 xv8TO+jWBuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaioWdgAKCRAzarMzb2Z/
 lwf8EAC2O5RJrqOwlHA9C0UrU1jon649wZkdvoBMCdD1hUllKuT6pWidh7BJGU7Yl7lbPxpe6AM
 CXU5Q2Vu/tiEb5f9wqh5UrLiiHPJ0UsJ000o8TlhGXuEoV+ZhuJ6Nx6EwFBkHg3+Tv5BxqIb4Gz
 FYvMM1Kzip72pUi0qAeu3F1e5UO321VsVmwRpCJAE0/oRZWXh62OeQPyLFXkcH9+MU/tLUyRISR
 4ZzJ+IB5IMl/JVDw8kvmnwQrUpEaXHrBmpD8+zRgWtz4TmNe8lkU01rPlVxuzjxPBbacCW0yCiv
 7pfslqO8I8H/psJDh1ch4Smw/tE91tnjDiq+5P6mW4D6/Ew4jVRD+gnSwOTxVPhrvfHTvrwHghS
 Qsq7rWo4/B71V5cff936FzyFUAl8ZwaUpsJPSKbnkWgqX21ODlsjm3Z9tSqnBKWVVKGU3x5yQKT
 3XJNDLw8hiNx0/DtibXHGTxksQtjiuYejNoYLWpmSTHGCIVe2Sgr3NEjp5+rmkKxRtAC2m8dkRg
 N4odfs+LsXWKyLWIYpucFSB3Uj7oCKPc4F5XCkYCgtn9BL7Q9m6hftknf1fa5o/8EXz+Qbuekhu
 S+Pfx7tSptgq3ozZVbrxUNK9xwodM8WIJmTDFlmbotry+lkd7vAWINUp8L0F7uMMuRCs41rY5fk
 fhvzwY9kLpMS9Ig==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22452-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:bcodding@hammerspace.com,m:jonathan.flynn@hammerspace.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: C1B4166DBBA

When a client uses its highest session slot, nfsd4_sequence() grows
the session's slot table by 20%, up to NFSD_MAX_SLOTS_PER_SESSION, on
the theory that a client at its ceiling can put more requests in
flight. The heuristic keys only on the client's appetite, so its
incentive runs backwards: the client that keeps every slot busy --
already the largest consumer of the thread pool -- is the one the
server rewards with still more slots. A single session's table can
climb toward 2048 slots even on a server with far fewer threads to
run them.

A slot stays occupied for a full round trip -- request out, server
processing, reply back -- but ties up an nfsd thread only during the
processing. When the round trip is short, one slot per thread keeps the
pool busy and further slots add only backlog. Across a high-RTT link
more slots are in flight than the pool serves at any instant, so there
extra slots do raise throughput by masking link latency -- but that
is the client's call to make by sizing its session at CREATE_SESSION,
not a reason for the server to grow every busy session toward 2048. Cap
on-demand growth at the thread ceiling, the point past which added
slots stop buying concurrency on a short round trip, so a table stops
climbing once it can keep every thread busy.

Apply the cap per session rather than across the namespace. A session
cannot use another session's slots, so one client's table size has no
bearing on what a second client may grow to. A shared per-namespace
budget would also misbehave at the floor: every active session holds
one slot that cannot be reclaimed, so once the session count reaches
the thread ceiling those floors alone exhaust the budget, pinning the
one busy client small while most of the pool sits idle. NFSD sizes
its pool dynamically, so compare against svc_serv_maxthreads(), the
configured maximum, rather than the running thread count, which
tracks recent load and would deny a client resuming from idle the
slots it needs to ramp up.

This removes a perverse incentive without becoming slot admission
control. A client still sizes its sessions directly at CREATE_SESSION,
bounded by NFSD_MAX_SLOTS_PER_SESSION, and a client determined to
monopolize threads can do so through that path regardless of this
change. Enforcing per-client fairness against thread starvation
belongs in the dispatch layer, not in slot accounting.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7ce8462e3697..2925603aa58b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4541,15 +4541,26 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * gently try to allocate another 20%.  This allows
 	 * fairly quick growth without grossly over-shooting what
 	 * the client might use.
+	 *
+	 * Bound that growth by the service's thread ceiling:
+	 * slots beyond the nfsd thread count cannot raise this
+	 * client's throughput, only deepen its backlog.  Cap each
+	 * session independently, since a session cannot use
+	 * another's slots; a shared budget would let idle sessions
+	 * pin an active client small.  Compare against the
+	 * configured maximum, not the running thread count, so a
+	 * client resuming from idle can grow back before the pool
+	 * scales up.
 	 */
 	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
-	    session->se_target_maxslots >= session->se_fchannel.maxreqs &&
-	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
+	    session->se_target_maxslots >= session->se_fchannel.maxreqs) {
 		int s = session->se_fchannel.maxreqs;
-		int cnt = DIV_ROUND_UP(s, 5);
+		int ceiling = min_t(int, NFSD_MAX_SLOTS_PER_SESSION,
+				    svc_serv_maxthreads(rqstp->rq_server));
+		int cnt = min(DIV_ROUND_UP(s, 5), ceiling - s);
 		void *prev_slot;
 
-		do {
+		while (cnt-- > 0) {
 			/*
 			 * GFP_NOWAIT both allows allocation under a
 			 * spinlock, and only succeeds if there is
@@ -4557,13 +4568,14 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			 */
 			slot = nfsd4_alloc_slot(&session->se_fchannel, s,
 						GFP_NOWAIT);
+			if (!slot)
+				break;
 			prev_slot = xa_load(&session->se_slots, s);
-			if (xa_is_value(prev_slot) && slot) {
+			if (xa_is_value(prev_slot)) {
 				slot->sl_seqid = xa_to_value(prev_slot);
 				slot->sl_flags |= NFSD4_SLOT_REUSED;
 			}
-			if (slot &&
-			    !xa_is_err(xa_store(&session->se_slots, s, slot,
+			if (!xa_is_err(xa_store(&session->se_slots, s, slot,
 						GFP_NOWAIT))) {
 				s += 1;
 				session->se_fchannel.maxreqs = s;
@@ -4572,9 +4584,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				session->se_target_maxslots = s;
 			} else {
 				kfree(slot);
-				slot = NULL;
+				break;
 			}
-		} while (slot && --cnt > 0);
+		}
 	}
 
 out:

-- 
2.54.0


