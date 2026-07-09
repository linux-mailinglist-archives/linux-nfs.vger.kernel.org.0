Return-Path: <linux-nfs+bounces-23197-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lY9ZIBTfT2r/pQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23197-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:49:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8255C733F74
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:49:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=awkniwID;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23197-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23197-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BA9330838CA
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 17:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149D24195A0;
	Thu,  9 Jul 2026 17:40:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC64195A1
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 17:40:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618846; cv=none; b=L6SWqwvRUh4r+ZXiV7cRfAbGaox+Ripdkxzje0hd6CirT/jZN0Ap1kgh8bPPcg9xOqh3VZKNjPNc7WBMmSCmJYR9liXHCUzmoLrd1Iq4RSNZu6tJEa6C4O1L3J5ZyuB3xT9YB73X5a4MDm7zO8AujlWOqXqT/JgDl2boOZdIQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618846; c=relaxed/simple;
	bh=7o2U8Cx6yOwoilcKjBrQS13/IIvFmFyGXMDZw0FSu1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkU+nMgyJnuJyzNrDLy/OeZCF6KzoMTAjXkJ1bE87OieROhQ2Qxjfo6wPIZw3WjdtMgVOXoe9/5/eNGTHQrk3mixYfNYuJ/RVBnq+eVKKj9qSG4WzYQQaCFtLyyAADlLF0qa1eFkoMM32GN5S9BwSB89UdGiTCVhxwrVVMWOohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awkniwID; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB4E1F000E9;
	Thu,  9 Jul 2026 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618844;
	bh=Wnhvk173j5CMo87oefXBHcFkS8mcYI1bcdFLa4rh8Fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=awkniwIDYXwa6YYZ/gWoKUYF2egdJAVgO32RHqBuSzK4Ib586XtvCa9fJ5lkLAUiy
	 HhCS1Zr+RDOGVTiogeRekE85JrsMm2Y6ZzbUluJEBDLjZ1+8TKFbBP31bl+PODV7hG
	 ZXr4ZpdsLHHpcE9xvZOa6D5PwtAMAakKjLG4HWJdmEh3IYlduf7iB4wdri7XsgAm/D
	 KGrZ2T+iEfhq2YNzlQorVAznq8TUMkrLbA1RVgxWrsC3AifoxGbnEKpuTylRID2xOq
	 zcdMupG0fqpxemeIZ7UpBz0wVPoL0GyxfmB4sIlFzFcRJ3QE3cjI8g340fTnwLrLjY
	 fUMnKX+EhQXMw==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 09 Jul 2026 13:40:31 -0400
Subject: [PATCH v4 8/9] NFSD: Prevent client use-after-free during
 close_lru reaping
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-cel-v4-8-1d519d9be0cb@kernel.org>
References: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
In-Reply-To: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=cel@kernel.org;
 h=from:subject:message-id; bh=7o2U8Cx6yOwoilcKjBrQS13/IIvFmFyGXMDZw0FSu1c=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqT90WeRRxATc1XPfjZWVizPz0wpp8Uq6Ai+aop
 5GmEY3q1guJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak/dFgAKCRAzarMzb2Z/
 lwHSD/9WiWpnBcgwfEYu88iUYLFaRfmSoFkI0XKCHqQZRO/goJbDhamwE4cOj5a1p4zDywZ4Jzo
 XknQjOn9aUFEO8xwvqxhNOOSrucz0TCNVe4TMNuuOll8aJGv7dzx8vY7SghD+jmiE+Cz2iCZk3u
 cKhIODSsV7uI85UcpoL6lzK/YqUcgwsa9xuHP18PjhYXb5A+qRiHpKakI66YP3RlmzG+ACkTYSg
 ndP52Aiy9Ubv7GXq22G3fYLcOlOjUHoQyU78p5GQpn3a6gxxGwpGND/fS6Z5v8Eb5hhR6IlA1mA
 g6iXoDBFO/5CTAhNSrL6EtsSOHeQ7Mx/KrV+VmFabfqp/Pak7WevKZ3llwUQ2xjUyKsazrtjP9f
 gscNRi+TY7p6dT86wG22eFpIWHENLojRqyZA3zdiYcqXPWzHoVTv6OeyP0wtTOhsiy+1ObK0RPg
 gqKi9Jv5xjrcPEQ0+Qnqost503hrkMTnpF4P5K5Tui7UNbC+ANRbASZ9cBZmt/OxqPc98CPNVLZ
 2mjOZYmWFETpH3q56Z3261vYS2OvdTyVBBDxLr1B92VYPcXqrlFyadiXUzp4ukSlHToA1Mcsm2K
 VpBesPeNtVYZlevZknTpebDIiXHrSh4DB+Jdk6UmMX3mafATjgmcLkqrT0eO/4A3/MESbxfQg9E
 +7E2afN+c8TNNRw==
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
	TAGGED_FROM(0.00)[bounces-23197-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8255C733F74

An nfs4_openowner left on nn->close_lru after its final CLOSE keeps
its last closed stateid in oo_last_closed_stid, holding only a raw
pointer to its nfs4_client. The laundromat reaps timed-out entries,
drops nn->client_lock, and calls nfs4_put_stid(), which dereferences
the client through cl_lock. Nothing pins the client across that
window, so a concurrent force_expire_client() can free it and
nfs4_put_stid() reads freed memory. __destroy_client() hits the same
race, walking clp->cl_openowners without cl_lock.

Pin the client with cl_rpc_users before dropping client_lock, and
skip clients already expiring. __destroy_client() then cleans up its
own close_lru entries through release_last_closed_stateid(), so
teardown no longer races the laundromat.

Fixes: 217526e7ecc9 ("nfsd: protect the close_lru list and oo_last_closed_stid with client_lock")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4acd02f1642c..20556b8f186a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7581,11 +7581,16 @@ nfs4_laundromat(struct nfsd_net *nn)
 		if (!state_expired(&lt, oo->oo_time))
 			break;
 		list_del_init(&oo->oo_close_lru);
+		clp = oo->oo_owner.so_client;
+		if (is_client_expired(clp))
+			continue;
 		stp = oo->oo_last_closed_stid;
 		oo->oo_last_closed_stid = NULL;
+		atomic_inc(&clp->cl_rpc_users);
 		spin_unlock(&nn->client_lock);
 		nfs4_put_stid(&stp->st_stid);
 		spin_lock(&nn->client_lock);
+		put_client_no_renew_locked(clp);
 	}
 	spin_unlock(&nn->client_lock);
 

-- 
2.54.0


