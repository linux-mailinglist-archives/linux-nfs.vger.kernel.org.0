Return-Path: <linux-nfs+bounces-23194-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3mzoDwffT2r2pQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23194-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:48:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B5733F6D
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:48:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OgVX4LzH;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23194-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23194-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04EFA308273E
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E464195B9;
	Thu,  9 Jul 2026 17:40:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FD4195A2
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 17:40:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618844; cv=none; b=h60WZzfjaWputIrrcQqZL5xY2ASQ366+4XXmPVaIyhlERmoJvhG6warKwyhnE5+e9rpQrqkS7iDhcAWkw7+PyzVfMCXVrRbL9SDp/lu/5djA8Ka4ey8Rx+ecmlIHZQA8FML7ot5RIuEHSaSuGTYwgVsn3dP4xqKMExwfMFTjTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618844; c=relaxed/simple;
	bh=2dHiX9K9N1XhNHlSCHuXeZyxOgeEQ5iVsxfCL7wiY14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eO38Foo788dG3fTtNg/cI7GROU9I0lqNxw0a/7x76CbEM2NxSrxU19AKVMl7cusIoODINOYqutdn8He21oReaX5aB5GJd7AyK0lWthZSccJq/pz++WxStmeuSYZFIJAOiuqA3QnOYSmKd0Ab6bBCvNuS3vkDXZtKpcd4a2Pk3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgVX4LzH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD7F1F00A3A;
	Thu,  9 Jul 2026 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618841;
	bh=b1GqpNG8R3ZRG1igKqv7/ZY6LjpF9V2NifLAplQuilU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OgVX4LzH3kEXv1y5sE6KyZYgd0xit9bLmkgDAO6smr9bdqhT8dM9N0R7aV2RgJxgb
	 SulvnuPquqatHoFxVUwp00n8AhvUXjJuIn5fAGT9JRslZxhrmQN6qEiTiSB1jqiO6U
	 58J9mIW6Crec7JQ0xz4g7dqh/sZmY1TFcHZ2vJLSLRy6jaP9vFloaH7kDlzUGd6SIC
	 1xLvTlNYPhG9yHpL5ToyirBHc2iPpy31fxbbgMBce5+OLkoDOHiqFEosN8laah2Qxk
	 wBeYVTzyc/BcUTTsikaTgXPKZzNd3fhRyg4ssAOg6A944gqUu54z4z8HpowC0Ru8+D
	 +4AKO+zmme5WA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 09 Jul 2026 13:40:26 -0400
Subject: [PATCH v4 3/9] NFSD: Prevent client use-after-free during admin
 state revocation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-cel-v4-3-1d519d9be0cb@kernel.org>
References: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
In-Reply-To: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969; i=cel@kernel.org;
 h=from:subject:message-id; bh=2dHiX9K9N1XhNHlSCHuXeZyxOgeEQ5iVsxfCL7wiY14=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqT90VDOTFOGLBbD+iWnDSU6eXqgt7Hk4WD/omq
 3IJaPOIIKaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak/dFQAKCRAzarMzb2Z/
 l8rVEACKLWSo4mqw1ICz5dncSsDM5Y4/3PnsAoIswXlrqEn1zo1Z7qraWFOudfX4tCJkTS3LxCF
 rwnILfJ5nWU/4VZDNZ+mQJYTdK2eJlpaMp688ZRNyYIkBwe5WduLyUSTCbf4yequphGC/RTnVLp
 unoMxLwvyuOLBjJdlbEHBhQVKQJp4QuwleKFlD8ScL+vCJiEOT+cuLTqs9CUiE0MYa2WSxfXA2O
 tdc/1pgW4WbK8xS+2VoRWPaIp8zKDTCGQGt00ntRxNpRldkYdfLk3LuzJNgX3c3pcPo7cvPVQu1
 F8L3jkT9aQPgCmuha2gN27wmCMk5YvuQ/S34k/FFnuECIF9UAQMnv+dmMmtYtnQCXAl3AjZAp0z
 o0EUES+np4sSYnKYFk9ttLR8yKZEGKvLiKf8w/XX35dJ2Z45s2/8iQxqyxWfJZ9TTElMhiY0Div
 0yqJhgRCG5iGSC15J5+a1Jf+gdQMKBYjcq9+YrL6mc3u6Xi+NE7DUiosXyzCUq/UJEjuWNyWRT3
 Dkr+Tx+ujoHRL3bRhld72vbJcm+VwOnyiPPhccaVM1nzy7fYrwc+aYodiQA+v/17+t7V+OsVKrN
 YLI3L4dq+WsExBgTdl9mHwBwwkz7gQdBF2m05zHPkQxZPxb4LT0++AZAR4SON/dG3AcLqyBbNup
 EjEv+cElAMGu+Lg==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23194-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 754B5733F6D

A stateid holds only a bare pointer to its nfs4_client; a stateid
reference does not pin it.  The client survives only because
__destroy_client() drains its stateids before free_client() runs.

nfsd4_revoke_states() drops nn->client_lock across revoke_one_stid(),
which dereferences the client to revoke a stateid and read
clp->cl_minorversion.  A teardown racing the dropped lock can free
the client first.

Pinning cl_rpc_users under client_lock blocks the DESTROY_CLIENTID and
EXCHANGE_ID teardown, which refuses while cl_rpc_users is non-zero.
force_expire_client() ignores it: once its wait for cl_rpc_users to
reach zero has passed, a later pin goes unnoticed.

Under client_lock, skip a client whose cl_time is already zero --
force_expire_client() clears it there before waiting -- otherwise pin
cl_rpc_users before dropping the lock.  The walk then either sees the
expiry and skips, or pins in time for that wait to cover the revoke.

Fixes: 1c13bf9f2e3c ("nfsd: allow lock state ids to be revoked and then freed")
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index efeb2a2e9c8f..565fa2ff5ba5 100644
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
@@ -3394,6 +3407,11 @@ static void force_expire_client(struct nfs4_client *clp)
 
 	trace_nfsd_clid_admin_expired(&clp->cl_clientid);
 
+	/*
+	 * cl_time is cleared under client_lock before the wait so a
+	 * revocation walk pinning cl_rpc_users under it either skips
+	 * this client or is seen by this wait_event().
+	 */
 	spin_lock(&nn->client_lock);
 	clp->cl_time = 0;
 	spin_unlock(&nn->client_lock);

-- 
2.54.0


