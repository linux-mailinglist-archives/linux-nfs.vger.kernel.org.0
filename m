Return-Path: <linux-nfs+bounces-23148-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qjtOMnpVTWoTygEAu9opvQ
	(envelope-from <linux-nfs+bounces-23148-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:37:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63171F49C
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:37:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aYm3lPQH;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23148-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23148-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D27030E1073
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE039EF0C;
	Tue,  7 Jul 2026 19:31:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91133148D9
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 19:31:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452705; cv=none; b=YRPMai5d2/jKmT1JKwDKglkXJK46eQwmRwO1tao85yfIUvyCMoq1hKRdLAXzwa+4edCC3tdMpEVuQPxigKJ8JhIBqTQFqOuQq9OYtvbuwD0CZbH3p68VZGzYAkJvlviUF7MB18VSHgV5xqoJvzYPtX4IzwRPrRH2RBBNr8eaiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452705; c=relaxed/simple;
	bh=g00rAC1Ng8s0ZfTIS3tOFLDXXZ/A4//EF06iPJvatd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGkMvuFk/+7HS83WSXqXcXvMeLXDPlUFKV7XRlnGzbU28ncAhK1lIEOlXumfMZQv1qB/afV9RpxMRwG/8K5cdtlYv67dJcUbukPdYY4s06ywysw5FsYu5hOQx7uzO2jgCYtGxz7GiKdFjaTyi7uu1Zdm9oz9VzfkPNH63/D+n30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYm3lPQH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416751F00A3A;
	Tue,  7 Jul 2026 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452704;
	bh=hWdtR3m2Wpf37AoHQ0Uma2/MaUspOcIjEf4PJ/Evoo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aYm3lPQHhqzsy1NDoS9pvomlLDkUIO6WxxwTm70l7eSGUUz1VsKLdGLnOfQt965zt
	 5R4vlt0BFg+Kxc+DcyrcvMw92WmWU0ebS6yv6QVdRgcJEPls6J6x/9zx+Ak5bz3wsm
	 0jNJ7pw6va82UH/AZGlqH/EL8dV71WnPVwxqBWnDkbxOh1PhzBdnnygmgqF4brMeDo
	 LgsTpxkGKFPhP9P8ll8rk6i5D9muqHmunTr98lackNGhc1iIVmZrRmXzskjhYZPlIt
	 IA+GhhMz121YKTD4u7BV8NV8X0xSquS/pOkf4O0NctpD9mnEyvH61b/gYPB9DpqUO3
	 Xou7DXLK20K5Q==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 07 Jul 2026 15:31:25 -0400
Subject: [PATCH v3 5/9] NFSD: Prevent client use-after-free during NFSv4.0
 revoked-state cleanup
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-cel-v3-5-7c0cc16fd54f@kernel.org>
References: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
In-Reply-To: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=cel@kernel.org;
 h=from:subject:message-id; bh=g00rAC1Ng8s0ZfTIS3tOFLDXXZ/A4//EF06iPJvatd0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqTVQbzegYYbcVmYF2al9x+96zaqyhGmkid078o
 2UnGwAJmhiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak1UGwAKCRAzarMzb2Z/
 l1aJD/41DPuLpHzHiBlV8hbl2qgVq9agL7j7EOE6WomOUGDo9rAalLs7q1SoG69k+p1smy5sdq8
 pIdXtX8plKqCVvYcBnBorj5iET1D/UFahlx903s/Anr0DmiPkz2o/SAhsuAjnZwpwd0/jMIrEjX
 6GLwhSUM5RtphSX1ag7M5nhIRkZQzucfUbiWySsN6USIyRRHlpmqmwKexz3FlGGGdDmKA5sZZ/i
 rGZ+njQUAxRxS8DBrfyi5FA0+KCFCjhkCH/LY/QOWTRiorHhR9eEznr8Pq8qBBLJkwSQRLhqvYD
 PixSsKLuVfmrX48vfdNKPukKBu7U9wPOJISD0G7vR6AT53ZBPnUq0gdRN+vYjxFZgws0wodJqso
 3Z+kCJCl0SwOzUfXxPCvOeeMxXWV3uq8IdF0Bq/UmRRxo3fnFRN0/w36AWtpwADH80LVRjFHWH8
 YDw25GLEfDikJqC3EdQEdzG3a15aSH0dtZIAK9dDJD41+8uPv8m17alUkUUYZcDqhObpm7tvme1
 d3OUG5i0F9Q4c5fqz18NRWQspNOGCr5Sduc/ffsNwixXcPPlmlvEv/5SfWlAd4kgcC+bsi85wOA
 +Qw343/ZhIf59nrA7xu+KhGXM0waW5NhiigsloLZbP09iQo7QibbsLVUugWAYMpAh9+hRvc0Znq
 tLrMMulHJ1ZLxcQ==
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
	TAGGED_FROM(0.00)[bounces-23148-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E63171F49C

nfs40_clean_admin_revoked() takes a stateid reference under
clp->cl_lock, drops nn->client_lock, and calls
nfsd4_drop_revoked_stid(), which dereferences the stateid's client
through s->sc_client->cl_lock.  The stateid reference does not pin the
client, so a teardown racing the dropped lock can free the client
while nfsd4_drop_revoked_stid() is still using it.

This cleanup runs from the laundromat, so a periodic sweep can race
force_expire_client() driven by a write to the clients/<id>/ctl file.

Skip a client that is already expiring and otherwise pin it with
cl_rpc_users under client_lock before dropping the lock, matching
nfsd4_revoke_states().

Fixes: d688d8585e6b ("nfsd: allow admin-revoked NFSv4.0 state to be freed.")
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9de535a2a4bb..445a0f40d5ff 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7452,16 +7452,22 @@ static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
 
 		if (atomic_read(&clp->cl_admin_revoked) == 0)
 			continue;
+		if (is_client_expired(clp))
+			continue;
 
 		spin_lock(&clp->cl_lock);
 		idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
 			if (stid->sc_status & SC_STATUS_ADMIN_REVOKED) {
 				refcount_inc(&stid->sc_count);
+				atomic_inc(&clp->cl_rpc_users);
 				spin_unlock(&nn->client_lock);
 				/* this function drops ->cl_lock */
 				nfsd4_drop_revoked_stid(stid);
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
+				if (atomic_dec_and_test(&clp->cl_rpc_users) &&
+				    is_client_expired(clp))
+					wake_up_all(&expiry_wq);
 				goto retry;
 			}
 		spin_unlock(&clp->cl_lock);

-- 
2.54.0


