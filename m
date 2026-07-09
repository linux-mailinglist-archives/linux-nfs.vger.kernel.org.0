Return-Path: <linux-nfs+bounces-23198-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y7jFKZvdT2qcpQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23198-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:42:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300AD733EC4
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:42:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lLraV6jK;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23198-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23198-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B95D3050477
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A0B4195AB;
	Thu,  9 Jul 2026 17:40:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59F4195CD
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 17:40:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618846; cv=none; b=cXAVCDtL6dv13jk2+nQ+cQ0gI7MXPzN2CxmpaNWGMOJ/BcoUf8nKQnHxbIc3ZilZWPPYppdKLGyB/4eX6kaWmaFFXITV2xZ/PVS8W+GYVHvRvOT6t/TkvHhOXrCmpQZvHa6lMBOwMj2p4y4jhoB76tUWolws/31l93YtmTiFaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618846; c=relaxed/simple;
	bh=EqwgcZQiZBN6/nbg3hs/pubZmkCQFawO2A+sGp/A4Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLUadFiLOBg1vXuClGDdpp6PIHZ61a4+OyaAZU+JO3cGF84Abv7ArjiRmMQQpsOMZki7wza9gGyRVv4WwIqaf12d8y2UDY6K1gm58oqJNj7nu0wnuYqd2G/19K6IH8Udf8YDuFjlOwbmAoQeTjdiHJPShtp31Lv7EuIWRztVZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLraV6jK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18DA1F00A3F;
	Thu,  9 Jul 2026 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618845;
	bh=v7+E69bv0aGtGoOt+hE5CG8yYfQpqL5RcTPvarlbjho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lLraV6jKWY+ZjbQpbzxhbGOEQXkd+2CKiOzvs0wv8zAeIbJAdAlAouH+9hyhAF1Z7
	 RDfcd6uKPMelI/VmsDKiZdf7Fg7y5Fha6UCA3W14LlbFci7RiQKPGCc+nRjXgdohPp
	 3f05NRNdRhYkLDmZorQYut9VlNq4wrurXeRBfKxjIZ5lLHj8pwnnz+w3qTI5f3vUpO
	 oq9cBpI4jK/jMnFIcn9sjTxM7WA1p7oFDU0H4FiyGXOKipqX7pgEM0sybCGpnGFr79
	 OkFGjhfFcIOgFYT+TpTYfM1k/1J8VgB2LqxPFBfC8+3fM0QBzlzgfSJFtvFma5/PHG
	 Ul6IFmzOKy2Hw==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 09 Jul 2026 13:40:32 -0400
Subject: [PATCH v4 9/9] NFSD: Release the export reference when reaping
 open stateids
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-cel-v4-9-1d519d9be0cb@kernel.org>
References: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
In-Reply-To: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=cel@kernel.org;
 h=from:subject:message-id; bh=EqwgcZQiZBN6/nbg3hs/pubZmkCQFawO2A+sGp/A4Ts=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqT90WT9Cu6ywnQZz7vhTKykZJgWCAznkBkdqxR
 6JxHDL1M02JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak/dFgAKCRAzarMzb2Z/
 lx5fD/0eANuM2ERFfUAdp7JRjH0WZFfsziYJgcnKAodWXShgk51c5kSI9evFXZWBJmvO/Z5Llk5
 5jZI0c+Q270fbujnVvTlo6oUvxjWkECJphwoIVVJydSDvdTP+YZfmRf/cFmV4m/8dOtyYEFCVr9
 hqKKn1msZk9B4k3iEZ2gky66TALYJQwzG93FyUYmPTO7dcwjumUiR+TCW8RlXmWOYSry3trWVcU
 CmiiKN/Zl1UXh161gm9KDADXGnk3uYRKytrmMYYWkQmbFu65Ht6eACiWfkVJ3k8Z6r+QLgf5tyf
 dNo6uCM7JBuiNUbBtazLJuubRwEXvD8HtgiTHC1zFymQDXM2zxCImPg0tixlrRXOgqbmsequLOJ
 Kh2lwg2JIPizXcAlLJIVMTvzUIhRPqv6GlJDXRfP1B6elQfhPAx/ffOdCwGbeYIYmkn1HN48f8m
 phaZTs0HSp3kzPaqQG2033Fpje2wk4lQ9Sd+8es2pjLBgS6sj0ktgjPiajwSqmjN3Km+QB2RsjL
 BNYw+rCFHTOGYp3UXgIvGFAzIOplma7oJVxR+7oaq9Xs6Y10DuDUhtuDQ52DH25Q+z7yM7oFEw7
 kXV/UTPx6UI6URciJ/tl43Zs9eB9oGmy9Xg52tM5ptBsTP35FYY8FTzld1O2HzhFR1R8RGQ7Pf4
 K/IQaSW20CP3mcQ==
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
	TAGGED_FROM(0.00)[bounces-23198-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:sashiko-bot@kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 300AD733EC4

nfs4_put_stid() releases the svc_export tracked in
nfs4_stid.sc_export, but free_ol_stateid_reaplist() frees open and
lock stateids by calling ->sc_free() directly, bypassing that path.
An open stateid takes an sc_export reference in nfs4_open() and a
lock stateid takes its own in init_lock_stateid(); both reach
free_ol_stateid_reaplist() through their normal teardown, the open
stateid via release_open_stateid() and the lock stateid via
nfsd4_release_lockowner(), each through put_ol_stateid_locked().
The reference is therefore never dropped, pinning the export and
blocking unmount for the lifetime of the stateid.

Release sc_export in free_ol_stateid_reaplist() the way
nfs4_put_stid() does. ->sc_free() runs once per stateid, and a
stateid reaches free_ol_stateid_reaplist() or nfs4_put_stid() but
never both, so the reference is dropped exactly once. Revoked
stateids reach this path with sc_export already cleared by
drop_stid_export(), so they are skipped rather than double-freed.

nfs4_put_stid() itself read sc_export before acquiring cl_lock.
drop_stid_export() clears that field and releases the reference
under cl_lock, so a concurrent revocation could drop the export in
the window between the read and the final put, releasing the same
reference twice. Read sc_export while cl_lock is held so the two
paths serialize and the reference is released exactly once.

Fixes: ba0cde5dc81d ("NFSD: Track svc_export in nfs4_stid")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260707-cel-v3-0-7c0cc16fd54f@kernel.org?part=9
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 20556b8f186a..e988dfebf75e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1272,9 +1272,9 @@ alloc_init_dir_deleg(struct nfs4_client *clp, struct nfs4_file *fp)
 void
 nfs4_put_stid(struct nfs4_stid *s)
 {
-	struct svc_export *exp = s->sc_export;
 	struct nfs4_file *fp = s->sc_file;
 	struct nfs4_client *clp = s->sc_client;
+	struct svc_export *exp;
 
 	might_lock(&clp->cl_lock);
 
@@ -1285,6 +1285,8 @@ nfs4_put_stid(struct nfs4_stid *s)
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
 	if (s->sc_status & SC_STATUS_ADMIN_REVOKED)
 		atomic_dec(&s->sc_client->cl_admin_revoked);
+	/* Read under cl_lock to serialize with drop_stid_export(). */
+	exp = s->sc_export;
 	nfs4_free_cpntf_statelist(clp->net, s);
 	spin_unlock(&clp->cl_lock);
 	s->sc_free(s);
@@ -1744,6 +1746,7 @@ static void
 free_ol_stateid_reaplist(struct list_head *reaplist)
 {
 	struct nfs4_ol_stateid *stp;
+	struct svc_export *exp;
 	struct nfs4_file *fp;
 
 	might_sleep();
@@ -1753,9 +1756,12 @@ free_ol_stateid_reaplist(struct list_head *reaplist)
 				       st_locks);
 		list_del(&stp->st_locks);
 		fp = stp->st_stid.sc_file;
+		exp = stp->st_stid.sc_export;
 		stp->st_stid.sc_free(&stp->st_stid);
 		if (fp)
 			put_nfs4_file(fp);
+		if (exp)
+			exp_put(exp);
 	}
 }
 

-- 
2.54.0


