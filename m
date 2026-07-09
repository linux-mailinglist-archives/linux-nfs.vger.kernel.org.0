Return-Path: <linux-nfs+bounces-23203-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PW1EMmrvT2qiqgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23203-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:58:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297C734A68
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:58:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YLrnG0lN;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23203-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23203-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D96A7310039E
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24D4499B6;
	Thu,  9 Jul 2026 18:47:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB230449994;
	Thu,  9 Jul 2026 18:47:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622874; cv=none; b=OXw1tYY45Z9M7jy4L+8FM1dQCBlcR85Fy3IHD3LH2Spq6OxdeixElGg1ndgUiDDBxwVC8D7LQvpqtGUAc//PkO0tcTZmwUiuBDKgTljo7zid9W6qhP4qwb6KjJIKNM/NlPXp2MLX5pB+Sm6Y/EL5RVxmqQ0UJlqPVC8TfUDcwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622874; c=relaxed/simple;
	bh=euwPAKHA3wb/+Q4INBRKXpnBNEmiu2iWAYLwCeRLAjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvF3xoZ/3izK5MAFMOQjBqJxBpTTZOy1sw3As+/R2CjIfuFcPbFI3dcSJrRjJssFMaXoz3tzxa6E/tTMunR+6enfVc+8EGqEUlrfQoZTsTtR3lwtF9X1E+hP/6gWyPlgAA1hDRw21XUKyr8ivWUAnb7d4uahEXklqxz1h7lMddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLrnG0lN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4381F00A3F;
	Thu,  9 Jul 2026 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622872;
	bh=rEqDiorRxXw2E2kN6vRBdOKsv+l6CCDYOVRjsUt5JRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YLrnG0lNEeVovC6VeCTo7yUqGh5wdV45bCnGPm77PK3UIijf7oAjQqus7Jqydz/68
	 yMHX9aE2sTbbM5e7rmPvb4R84ZozESpMXhrbgggF1Ew7mqU0NFxR/h6PwxGTwAqDaL
	 2t3y+hFXJT2AV6UOsmy9cM15ZK7653ZfE5NwYaBKQ9sYv2fTxkqj0IFamtymrIzTSs
	 zA3Y5kUktCy8ii9fgkR0AydbsHXaSHNp0NR+9qsFNZOl2kt9Bm7F1BKyFEuTp+QxQ1
	 Q4HyC96+Lvs1XhGfPfrZjAZutWTow0PYpqdI7kd8k102SHEv3CteOf1I5VVTL/Z+1e
	 JcIhXR3LpfBuw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 14:47:38 -0400
Subject: [PATCH v2 01/10] nfsd: fix cpntf publish race in
 nfs4_init_cp_state
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nfsd-testing-v2-1-0a1ba233bf87@kernel.org>
References: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
In-Reply-To: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4441; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ECqWdBpcSt8LFQmmuHoL+FvzlMsKAshD+0WW57qV6jY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT+zU/CtvPzFJWfWUQ6sFqgonUBnyfIFbpAoOD
 IZCqBv0fUeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/s1AAKCRAADmhBGVaC
 FfzMEAChiqjZ0nQd6sALBhsJAomQCUQ1X0u/ns7iM07D80eDBADgBoFMNc/wZckKbksL7JxjxaM
 7kIjwk2WpPtlc8G/eVNwmkcflQUOA08b1XP+ftWAHnK4twzwEo2hHCV5vH5FXMTD2PMwrwQg9l0
 4TSFsmYaKEw/Oz5xWYBmBEddaOJatucOxHPKWb4ZYSLQoYmyeYmdKTLCVDlAeJW8G7C24SHqMx8
 bSYpSG0dqUSlC5E6GsWsBnxQ4C0m8hUuzHptJuXVJ3DTVhgREQ8aXDSNR+SkJR6TQAfnYMUiHAH
 07Q+AP1559+7s5Fg523CvyFULf7REgh3a5kAS7LXeYqAjP11vHvDqImYd7BX1yIHLXSZ0BzlODY
 vHgr3vdX2nAgCHQFOVBkp9jbkB8wp6v3CUDvmKcwPxWC/xKvfF46tfXpehZyWEtEhQMu34ijZSs
 DekYx2+4j3bBadbNpJbvMIvN7HVktTbWuN3wZRuCApkenkMZDMMhcqWregMvbRzY3oAwA3lNO0s
 T99uoD8n5HANq46Ldp0xhxLheih6M5F1N9fbxlj/wJFZuDmdWGaaRoXvQE2NB0rCxV4N3qtLDlZ
 g5KFwwT+uJ67LivXwcH0vOe5SV0BqIF3ap8IETsuSLzV11TB1enFrC/cEHVIh8LRY0NeRw7zHld
 9YfQxKAmp/TFeYA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23203-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4297C734A68

From: Chris Mason <clm@meta.com>

nfs4_alloc_init_cpntf_state() published the new cpntf entry into the
s2s_cp_stateids IDR (with cs_type set) in one s2s_cp_lock section, then
took the lock again to list_add() it onto p_stid->sc_cp_list. In the gap
the entry is reachable by so_id but cp_list is still {NULL,NULL} from
kzalloc. A racing OFFLOAD_CANCEL (so_id is echoed to the client as
cnr_stateid, so any NFSv4.2 client can drive it) reaches
manage_cpntf_state() -> _free_cpntf_state_locked() and does list_del() on
the zeroed list_head, oopsing the server.

Fold the cs_type assignment and the list_add() into the same critical
section as idr_alloc_cyclic(), so a concurrent lookup either misses the
entry or sees a fully linked cp_list. INIT_LIST_HEAD() the entry after
allocation and switch _free_cpntf_state_locked() to list_del_init() so a
stale unlink is a no-op. nfs4_init_copy_state() passes NULL p_stid and
skips the list_add, preserving NFS4_COPY_STID semantics.

Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a4398dc861a5..b8946db3ebaa 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -944,7 +944,7 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
  * Create a unique stateid_t to represent each COPY.
  */
 static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
-			      unsigned char cs_type)
+			      unsigned char cs_type, struct nfs4_stid *p_stid)
 {
 	int new_id;
 
@@ -954,19 +954,37 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&nn->s2s_cp_lock);
 	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, stid, 0, 0, GFP_NOWAIT);
-	stid->cs_stid.si_opaque.so_id = new_id;
-	stid->cs_stid.si_generation = 1;
+	if (new_id >= 0) {
+		stid->cs_stid.si_opaque.so_id = new_id;
+		stid->cs_stid.si_generation = 1;
+		/*
+		 * Publish cs_type and link onto the parent stid's
+		 * sc_cp_list inside the same critical section that
+		 * installed the entry into nn->s2s_cp_stateids. A
+		 * concurrent manage_cpntf_state() either fails the
+		 * idr_find() (entry not yet visible) or observes a
+		 * fully linked cp_list, so list_del_init() in
+		 * _free_cpntf_state_locked() is always well-defined.
+		 */
+		stid->cs_type = cs_type;
+		if (p_stid) {
+			struct nfs4_cpntf_state *cps =
+				container_of(stid, struct nfs4_cpntf_state,
+					     cp_stateid);
+
+			list_add(&cps->cp_list, &p_stid->sc_cp_list);
+		}
+	}
 	spin_unlock(&nn->s2s_cp_lock);
 	idr_preload_end();
 	if (new_id < 0)
 		return 0;
-	stid->cs_type = cs_type;
 	return 1;
 }
 
 int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
 {
-	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID);
+	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID, NULL);
 }
 
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
@@ -977,13 +995,17 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 	cps = kzalloc_obj(struct nfs4_cpntf_state);
 	if (!cps)
 		return NULL;
+	/*
+	 * Initialize cp_list so any stale unlink (e.g. on an
+	 * entry that never reached its parent's sc_cp_list)
+	 * degrades to a benign self-unlink via list_del_init().
+	 */
+	INIT_LIST_HEAD(&cps->cp_list);
 	cps->cpntf_time = ktime_get_boottime_seconds();
 	refcount_set(&cps->cp_stateid.cs_count, 1);
-	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
+	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID,
+				p_stid))
 		goto out_free;
-	spin_lock(&nn->s2s_cp_lock);
-	list_add(&cps->cp_list, &p_stid->sc_cp_list);
-	spin_unlock(&nn->s2s_cp_lock);
 	return cps;
 out_free:
 	kfree(cps);
@@ -7854,7 +7876,7 @@ _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 	WARN_ON_ONCE(cps->cp_stateid.cs_type != NFS4_COPYNOTIFY_STID);
 	if (!refcount_dec_and_test(&cps->cp_stateid.cs_count))
 		return;
-	list_del(&cps->cp_list);
+	list_del_init(&cps->cp_list);
 	idr_remove(&nn->s2s_cp_stateids,
 		   cps->cp_stateid.cs_stid.si_opaque.so_id);
 	kfree(cps);

-- 
2.55.0


