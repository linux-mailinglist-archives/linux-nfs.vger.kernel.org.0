Return-Path: <linux-nfs+bounces-23236-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /r78Il37UGr49QIAu9opvQ
	(envelope-from <linux-nfs+bounces-23236-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:02:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BFA73B8D4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:02:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KzjLBZ0S;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23236-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23236-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDF13305DE6B
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129FF32B138;
	Fri, 10 Jul 2026 14:00:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AA319871;
	Fri, 10 Jul 2026 14:00:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692028; cv=none; b=u/vwp4KSXADurDQVOU4gyKM71pg7GeI49j4IIeAUXlo0BwIF5PFALVF2xklXDYnEW+y1XcDSkXFp3Kh8ttjGaXk9udogUnYJy+6aNm8P9lBQeL3FrPZkIRO8SyZsyRJInX+oaS6cjryTYpqbxfCHZjgzVdvQ0srd4YPDGs4Hymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692028; c=relaxed/simple;
	bh=GxJvjXtiR7eEOp06uNYPWPOn0UpTEVuLFO0Lu+rWrK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfPcRRxJgQy5X4SoM6jRyzWYX7P4+xJ7BuaOtFZkxaXJMW0yD2uvwZGJa8oxBnteNumZtl7QPTw+WtHPYfaD3DeoD/gEIBsLZkvtjVZoSET5ACx0hUCNoaXtqO5/2LNzPFWKKakEV+3vLf5kC1uG1LtaoP6W+I0C3u55e1WQz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzjLBZ0S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF8F1F00A3F;
	Fri, 10 Jul 2026 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692026;
	bh=GGh4d/NZmelqfygPTYIZ7C/JabRyp9RVSEKvPbeIe8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KzjLBZ0SQXMkDbeBm2tjBoOp7JV5rx4KSo73verZwe+F4d63KlE/VQVANRHb2d0ZY
	 0xgk7ecdJqeeM1g3fkpsb36cWIpAO95M2P4Hdy0VzCIeZAVFltof6NkGWnqC9lfGAO
	 zSu1aRYlvHXeqAdfGIoSamkZ+9IwwmC94JAoeQgajwG4iMqgd7/+Ju00fsW2UBTqVP
	 aHhAXYGho3ecGxKDuQyH8NqLaoDfMeDVDky1S59TAnynvnsl5omL8okdSNYyhqU7MN
	 MPXDbWlDxFL5AbKvBjStiBGnvlSjNRe7poV7wJc4fYNzxrLq4Bsx6RiypQz+5dfCqU
	 2JxGloaHuBY5Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Jul 2026 10:00:09 -0400
Subject: [PATCH v3 05/10] nfsd: check client ownership when cancelling a
 copy-notify stateid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-nfsd-testing-v3-5-a0ff7db6aa3e@kernel.org>
References: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
In-Reply-To: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GxJvjXtiR7eEOp06uNYPWPOn0UpTEVuLFO0Lu+rWrK8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqUPrz/C27z01jVpmJHNwEOGOx8ru9fQipSnYRa
 +ma/d4TIRaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCalD68wAKCRAADmhBGVaC
 FcmTEACAeTIR6vhnaT+LYA1gFYTIB5MBBWTNoEUpTMBWzJCsO6lAeMZJASspEus6l+zvDRsiOAz
 ahLMPe9BFWMiyVuNvrcbjziLWLgWqINoC36ycVPON92McIsdG9kkrtvWydHpzlt2OKwKyWauFhX
 5fUp1OFUINplWWX2B9dcPtgv+nW0EMsK+hLLBsyjUrXPD+sFhZgr6uRcWyDh6swO1oMiyXj7UUG
 464LVJHHTDhemVzWHVii1rSSS+wj6G8LdDZxcZmgzbLEAk1dFWtumnNBzc5IrrGZQYr9xNAEhj2
 seCGO8mEhhlBayhjk2zaez25xh0qmU1Vd+CWuDK/UAGSoeEB5+92A52PCZYWghvFLIgt5kBbFYF
 3AUMukge6CQzYoGTBCiJU07V050MS4oQfEOJBT7miIfhyfGjg2orKDnL2YT2f6u1TOOYOELvyPo
 Zd8Vsi1wFVM/aDpoeSmTbsBc36b9KsXzKeE9k3KqGpmiImc5V/XwhlEKaZXVXtnWgnBCzLm7Xj8
 VZ4uImCEKlxCT+FcryM787Gm4s9J+/6fyPI1FAg6u7gnT80T43RHeXd7Uh0au8CHGZJQFhrTqq2
 78Mj2H8LzQOMwi9TnHR4Z3Fecf/BcxoHMnchSWbu3JrSJ9+Xoo1LRh9TpBmwNsHXOr9CZ7YQxwF
 3W7HUPYsyuhCtCA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23236-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9BFA73B8D4

On the OFFLOAD_CANCEL path (clp != NULL), manage_cpntf_state() freed the
target cpntf state without checking ownership. The lookup key
st->si_opaque.so_id is allocated cyclically (guessable) and the embedded
clientid is the fixed per-net nn->s2s_cp_cl_id, so any authenticated
NFSv4.2 client could cancel and free another client's copy-notify
stateid.

Compare the creating clientid recorded in state->cp_p_clid against the
requesting client's cl_clientid and return nfserr_bad_stateid on a
mismatch instead of freeing the entry.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9ae0f18121ef..b3fe163a148d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7905,10 +7905,20 @@ __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 			state = NULL;
 			goto unlock;
 		}
-		if (!clp)
+		if (!clp) {
 			refcount_inc(&state->cp_stateid.cs_count);
-		else
+		} else if (memcmp(&clp->cl_clientid, &state->cp_p_clid,
+				  sizeof(clientid_t))) {
+			/*
+			 * OFFLOAD_CANCEL: only the creating client may cancel.
+			 * so_id is guessable, so without this check any client
+			 * could free another's cpntf state.
+			 */
+			state = NULL;
+			goto unlock;
+		} else {
 			_free_cpntf_state_locked(nn, state);
+		}
 	}
 unlock:
 	spin_unlock(&nn->s2s_cp_lock);

-- 
2.55.0


