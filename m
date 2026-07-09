Return-Path: <linux-nfs+bounces-23193-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mpFlDATfT2r1pQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23193-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:48:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCF1733F68
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:48:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HEG2IFBc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23193-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23193-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12EA730825E5
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D014195AA;
	Thu,  9 Jul 2026 17:40:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059F4195B7
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 17:40:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618843; cv=none; b=R7iKgphyaWfbrH+c0g8gcUfQuUYMVGttk20u77goBGilj4OOttPbjq9NtbPfg8UIO4+sjfPf8UGpKOsPaTFG/I3eWMq7yCV7ZNihmwu+G42ga7OwSM5pSeyjxtN4wMLOFBNTFszLpU0phylLpewYtwcKD0L/J7FJUBoCpoAHbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618843; c=relaxed/simple;
	bh=g00rAC1Ng8s0ZfTIS3tOFLDXXZ/A4//EF06iPJvatd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUYVAtK3Wi6i/YXPRZkqFHnEEOHp8dR3fhBDwfIGQIFzdx5Ag7H+j9L+lwxH+71dj2i+tzXKzW6loFRBqIGJhg0Slf6AINgFXx6fy4ztvyBcgCtQy/ioR2LTYY5Je6w6WYsARiTQMtOpLtFEfZ/Id2k7pP1U/KW61jIqgXOaNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEG2IFBc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E451F000E9;
	Thu,  9 Jul 2026 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618842;
	bh=hWdtR3m2Wpf37AoHQ0Uma2/MaUspOcIjEf4PJ/Evoo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HEG2IFBcNUeZ3W32RAPsU1P9SGqT6deW9gDGy2B8ssB48fZW69SfACRJVGGTeVLqj
	 uTKqN2dGtjd1x5i1KHdCPHZkz7oSrqoS7txnSJG12MZXobqiWMHIAwe9gxsXf0Lyyy
	 4IrT+rc4XwQJG6iRW+oJTknUMnYEHYzze4b7/9KOd8o3H+TaK3rXMntpB/IbskkPVd
	 YnnxdrlGiuyY4+xWWRz/cqShvHqSdgNUkKhL9/3FgNThZvNoDs15zvwC9TYLQi8rax
	 DkDvA2IpBLzgPzkAo8edpXlcHl1nl1K55EVn/irSsCtInl37u8tju2kKooje2XVZfW
	 Sm0uaEUyzGgpQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 09 Jul 2026 13:40:28 -0400
Subject: [PATCH v4 5/9] NFSD: Prevent client use-after-free during NFSv4.0
 revoked-state cleanup
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-cel-v4-5-1d519d9be0cb@kernel.org>
References: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
In-Reply-To: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=cel@kernel.org;
 h=from:subject:message-id; bh=g00rAC1Ng8s0ZfTIS3tOFLDXXZ/A4//EF06iPJvatd0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqT90V1YGC+ssVVuPSLxh4iuIKA7PkZf3D4qr+4
 fvzW6AVz6SJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak/dFQAKCRAzarMzb2Z/
 l9/CEADCJ/ljt0pBouki24VIUYIFVMjIa9+Cjxzhh4Mvc4595QGsMZ+Jve9W0MZdY0WI7E1Vwwv
 OCuEZf8azYzUyffxehPC1TpmJGA4g0ZYW2C4smN0oMSR9FECBpFDJomV5dKVjONOMQGS8m7C/wN
 FTGDpWD1FKc2ez3rG2PekuDDC/1zp9ui+qDJxox+4whac62Hx/lR3JO3b1YfgH6fRsDcjKgUHDA
 7fCWMEKwwQ4uqo4c8tFJamFr70IgxTjR+vt7PaxsfvAWDgdIQvW2l+ymiNZMBVMvkzhpOAfHPNC
 +EXiOiZKpCvECUUNQSfCVQd/dU2U0DssqzoILpV26h3jLpN1bfJC/cuFsnrKxRJRsu1bxzv6yhy
 lEM+EeHAHdiZDdpcSjE7ICiC3wyQy7+XSrWjMiyP13AF9+SmE50p7ybJXaiPkMoHHDVIv8vRuxa
 6o42iFObRBV4nY9gleWezA33Eic4Rav3ClSVtxPZaZ3/catg0aOj1XjyKX1EUV07RaDDtSvplW0
 mtf5XyFn7fmWulXGuDE3c7CEHLGJ+S30B+LSKWKd9yDhJxRqnd/O1Z0WL7kbB8qqVhJykjAIX2M
 izmv1vjuq042ISBKpKHpEQNM1N7EqdWRrqNAIm5/JFigmfMRVUErxYmNzMCtrTeAP5kQBf2wFyS
 5FzdtgPjVY0+KIg==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23193-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FCF1733F68

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


