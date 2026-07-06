Return-Path: <linux-nfs+bounces-23013-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kBb/KqcES2rfKwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23013-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:28:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2064270BE9A
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:28:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Pb3+wptH;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23013-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23013-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8F83027134
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 01:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB721322B6D;
	Mon,  6 Jul 2026 01:26:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9232ED3A
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 01:26:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301162; cv=none; b=LVhhvLkSe6jy/ukTw1UzY0th7FlueLz75pEisigM4vzNdzHTf2QQ3eTCWCtODDFwBWL9Th1p1SMxvzC9PC+LNPqUoZ4c7i1t6qvBlkAnGRqdItpF/6Zll/FyhIO5jEfiwJIrxtY5jUwBZAQD+Ms/ld029NHOkGFSzz9OhnKcOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301162; c=relaxed/simple;
	bh=YjcghFrNEJMP3EcXP4NqScL6wYnwtAurW/JF8mkNWgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iiX338NPdE0+Rx0XvnY+H6P6N4kI7MO9Y6EBXRbtyOg9AA9NKrIZt5jYWNhZeDVHzzcTRdo245ZF9YXu+Y23ACSI3a+1wIbYbj2AbUE+wasdPNBI9VXxLlGkuCPcYUSXntfEPAYt1jeKVVUis+gtybv7p5uFMjIvOAhpd/DV+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb3+wptH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E1C1F00A3E;
	Mon,  6 Jul 2026 01:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783301161;
	bh=lhb5N8cSMQu1GXXz4EaamZsv9Qyl6f2eU9Mr5NnQFGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Pb3+wptHzImxwRSkIPSmoqBzfbUauJO+BMnAhl4MaEeEJm2aBz1fckQk0l+aSBhcl
	 RRvMI1fkcRE3TS8/tOmOlWMgi91HfEU2q9tJoV+QXPggN+uJYNGxbGtXLvwWzzLIXT
	 vS8+gij2sR18lJgRPvG6syfjp9Y++vCNXltU3bmTgcpElEdCWAJNKs1VLIq0mP5TLA
	 RgoKdAkUnt/o1TDozCO/2suUIIKsS2tZ8g8XLlRHX/Zb8gItDhe3njsz3fhkBXyjZT
	 3VIf65ai7HL2y7sucYtS1+i/ZI8vNEZxvzhEtFKjrgJFMmodXbN3P1xsw1fVP05kH6
	 o/gYGvsF0scGQ==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 05 Jul 2026 21:25:39 -0400
Subject: [PATCH v2 3/6] NFSD: Prevent client use-after-free during admin
 state revocation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-cel-v2-3-d88c3b68e8bc@kernel.org>
References: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
In-Reply-To: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2991; i=cel@kernel.org;
 h=from:subject:message-id; bh=YjcghFrNEJMP3EcXP4NqScL6wYnwtAurW/JF8mkNWgM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqSwQmExcv+Y8leN7eX97Bb4ifampC/+BeJXKuF
 0EucPomTNaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaksEJgAKCRAzarMzb2Z/
 l5GlEACTDdhkbQs94xmGswf6i/T+1Q6Ac4L+mCRMAXZlK6Q7yLrKB1yJAgN4a045PelcKaWIg+8
 M8Z4MHGPEX7mT4GbAiQSrS/AzOx07Y+meoGDO95XI3fDfvuw7RHxGMvaSRnlrt8L1Fk4lZSrruK
 P/ydSurjp8LZYc8jzQQHDmFdRAQEjZ/e68rJtLXeTMPvout2GSWIojm37KyHY+CPK8lvmshiGeA
 IGHiW5IrguSwLnUBL0gKUnwfdvxIHO219CLvMNPxbNnlW8BeniakLGIqkQEkdwTrl9rmFgdkcxB
 ck42vgWi8OwCtRVneTapIkeyT9as7NT1e887QhXpx6vvdM7f9HN8nLH3tU60KH9H57MiXZFI6bU
 Ezfo2KfYFAPPB62EybI1taRG46sYdh3XTuowKOWzmwHyON6LLNRtHJN6VSNdwJbr+QV5ojaQrgM
 zSm7NmYqxhpGh8FXbgu50X/tMVS8b8kOrLOmYCprfyHx8DpUs6pdYwWmTJfnfiWR6uTT3eb+vBL
 FzZRIqQ7UqNf5JnOBmhSK37KoHsr3OSdSA0BUReb04ko4v9Z3ouAjPp1SBohsELz6w4nzJzwHDo
 4gsRhFOQJrs5C1m4WNjJ9nyBllPprkYfcQ9siKeEZuOQYWVPpBY9gw+4RZmFbNfPaPIkhzVKpP8
 Sue7xqsGxRKgVtg==
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
	TAGGED_FROM(0.00)[bounces-23013-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2064270BE9A

A stateid stores only a bare pointer to its owning nfs4_client; a
reference on the stateid does not keep the client alive.  The client
outlives its stateids only because __destroy_client() drains them
before free_client() runs.

nfsd4_revoke_states() drops nn->client_lock across revoke_one_stid(),
which revokes the delegation, open, lock, or layout stateid and
dereferences its client -- revoke_delegation() and revoke_ol_stid()
both reacquire clp->cl_lock.  The stateid reference it holds does not
pin the client, so a teardown racing the dropped lock can run
__destroy_client() and free the client first.  The subsequent read of
clp->cl_minorversion is exposed the same way.

A DESTROY_CLIENTID or superseding EXCHANGE_ID reaches teardown through
mark_client_expired_locked(), which refuses while cl_rpc_users is
non-zero, so pinning the client under client_lock holds those paths
off.  force_expire_client() does not consult cl_rpc_users: it zeroes
cl_time under client_lock, waits once for cl_rpc_users to reach zero,
then unhashes and frees.  A pin taken after that wait goes unnoticed,
so the walk must also skip a client that is already expiring.

Under client_lock, skip a client whose cl_time is zero and otherwise
pin it with cl_rpc_users before dropping the lock.  cl_time is set
under the same lock, so the walk either sees the expiry and skips, or
pins early enough that force_expire_client() waits for the revoke and
the cl_minorversion update to finish.

Fixes: 1c13bf9f2e3c ("nfsd: allow lock state ids to be revoked and then freed")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index efeb2a2e9c8f..cdb62b3bf718 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1965,9 +1965,19 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 		struct nfs4_client *clp;
 	retry:
 		list_for_each_entry(clp, head, cl_idhash) {
-			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
-								  sc_types);
+			struct nfs4_stid *stid;
+
+			/*
+			 * force_expire_client() ignores cl_rpc_users once
+			 * its wait_event() has passed, so pinning cannot
+			 * keep an already-expiring client alive; the
+			 * expiry path revokes its states instead.
+			 */
+			if (is_client_expired(clp))
+				continue;
+			stid = find_one_sb_stid(clp, sb, sc_types);
 			if (stid) {
+				atomic_inc(&clp->cl_rpc_users);
 				spin_unlock(&nn->client_lock);
 				revoke_one_stid(nn, clp, stid);
 				nfs4_put_stid(stid);
@@ -1980,6 +1990,9 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 					 */
 					nn->nfs40_last_revoke =
 						ktime_get_boottime_seconds();
+				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
+				    is_client_expired(clp))
+					wake_up_all(&expiry_wq);
 				goto retry;
 			}
 		}

-- 
2.54.0


