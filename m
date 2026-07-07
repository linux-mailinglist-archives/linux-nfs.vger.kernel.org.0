Return-Path: <linux-nfs+bounces-23151-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pUeUJytUTWrPyQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23151-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:31:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6171F3D7
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:31:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GVDpBlW3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23151-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23151-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF4CF3016B64
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030239D3FD;
	Tue,  7 Jul 2026 19:31:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C962BE035
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 19:31:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452708; cv=none; b=A1zjYPvhIRT8NQSQPvNkDzNJAh+B02xPX9jN2Fwym0/6i8W4RDdZVVJok7X5DKQKAVeNsZQ1CNv8FoAZAaz4sJUg96ghTlwnpQ6Trc/d1ETrogecixp6NoQ3GkfDaYU/aLnBJ3Orxlin9BQD6amnRQdg+L87RUVVL921gTem818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452708; c=relaxed/simple;
	bh=7o2U8Cx6yOwoilcKjBrQS13/IIvFmFyGXMDZw0FSu1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/SMJ4BE/XIKPtxC9k/dlWnsbVR5KpJnP1rgrUn46osUjhZvJgDMsoIb8HsGKr9D53uIafAEz0FPLV4VyBFUKA2xoZZRmXwV1n1dknSJDhqg30NRmqEWqQhZVReodc3p+MMQyoHv5ZQb8ePruxPQON/BlJt7BG1oKtRFKb9RUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVDpBlW3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E911F000E9;
	Tue,  7 Jul 2026 19:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452707;
	bh=Wnhvk173j5CMo87oefXBHcFkS8mcYI1bcdFLa4rh8Fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GVDpBlW3kh5DoM5LKL4SqFN75Bg8OP3jx021dSG3DvS3zW0so4HDSE3vanA6NHgAH
	 BLxWg+iHKi0D3tOwYpYS/RouBNRQ7N/Hr1I7JC6v+1FCez+gHeNVyit1kLLNozqMq1
	 iNh3OgOAS6Pk/7RrHCovidQ71h5pLn1DWWA+QpLpTnTg7orPtmAw/shK9915eHS13I
	 hRzc6AZfd34nBeqZzlT4jyxNO7R+NDdVp6Eqq1iusDuTFc0coD5LulIVJBqFw2raf5
	 AtVZek4hxJAGswxgjM8tZFC72hvxqboyIAuXUejU0g8d9SQ073QfrBb2BNcSU1BAVO
	 JMfuAEC7VVbSQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 07 Jul 2026 15:31:28 -0400
Subject: [PATCH v3 8/9] NFSD: Prevent client use-after-free during
 close_lru reaping
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-cel-v3-8-7c0cc16fd54f@kernel.org>
References: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
In-Reply-To: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=cel@kernel.org;
 h=from:subject:message-id; bh=7o2U8Cx6yOwoilcKjBrQS13/IIvFmFyGXMDZw0FSu1c=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqTVQcMEEOvidfb2AOJkVuVd+TdQLh2tcFuKxPR
 dIT1Cq6RcKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak1UHAAKCRAzarMzb2Z/
 lw99EACn8zjrB2o2t+Nwf2L16UqYRXeKg77/AM6PaNlCbQ04PqxJWOY59HMA1JEr4JpBTnRnvAY
 d5Eii26SzHQeaEMxy+1PAOG6S0WrbIg3hlm1ChR3sR5RlhGFoo3YH1e9sTpvs/ICSw1sHLLcD99
 bFL9vSZTE1Fk65m81qtiFXu6l0xTzxH+i9mZ/mAC6K7D/5JdWJGCyiUjPmdl94Unh5RZzsQ6dJq
 UYGpTC6RMoZLTA9BopFArFL/Eyn/RmSyYKQpYDOVgrxePyp5B950kyw1mrfNHK76wXsAgR31Dds
 vuR50E+dl8zpB+jOkx1ZfBlMX0h4rwcKOZ+zyWwfjaXY6vS6DsadN6rvRJwaXJtLiv3z4qn/nbY
 OTqfXAzanZcemy3rSZj0dmx3nVZtbL8gOPIpIWAJ/8nPJsY9Lfc86GCeH/hoLAHM0EbALI1/Ipk
 qgr8gQFP969jE5HQYEa0zr1qhAky33Nc7n3mzRAPZh+ZzTaqDDIcFPLrpLDwDBWRhbqgGVOxWvS
 tGzP6OmAClmPB2LMqkn3E/1EEaQVYZ/LOkurlxO1ENQjGFO8kxeDN17SSOFv8+nL4pTb9JZcQYg
 fJrbliydCKSNqI3X3CxMB65V4MLQ53E+2QdMr/iwvdMvJZl5BKnHBSAuL/auHaHbzjwoTMNYWvX
 sz9+N36LCItkPUg==
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
	TAGGED_FROM(0.00)[bounces-23151-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55B6171F3D7

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


