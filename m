Return-Path: <linux-nfs+bounces-22497-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wOOJOkEUK2o12QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22497-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:02:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEDF674E81
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:02:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c35puhwJ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22497-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22497-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B3603147575
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006EB388862;
	Thu, 11 Jun 2026 20:01:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C8385D67;
	Thu, 11 Jun 2026 20:01:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208070; cv=none; b=py9j9YKTeycYKPr+dzWqbJW8VF8YS0x5S0Ldv+JNwQ7zghDBvGMDAoJAtxMzsbxDBhSOLAAmoZOQEsGdCgbvDDypRNesLNbqp32EKy345MiZLhqOJpL67W8aIgoCanpmvl+dawZKreS6hgaFjmnKvxhiJiZToxYA4i5w8RfukrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208070; c=relaxed/simple;
	bh=7i/jygUOjgBpSsR1sXXG7rsXOsu30p4zyydQ3gZHiCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4sP5k+OkUKDPMxreKGu1AIGAH3gnAP+TRC2e3faKOGYzYpR6KKr9X4wBs/1+Z/9qCYlrZW2NQ0K5PIvvIPruahchuPQMP/RpjSA8u1XcTRLwAVC+vniOwMzmevoDiF0DLsegvtQkLn1X7C+vdclcB9uRZv8yukjZrgoMvEn1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c35puhwJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47831F000E9;
	Thu, 11 Jun 2026 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208069;
	bh=sYS0pOY3O5FJffkpguiMcujriyVX10KqbFnMWYew9gg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c35puhwJ+fVejfdvndOpBBWIx12bnCkmjYr4BApNuEL2tqJ6P8XyPAqk5Z5UMSgY2
	 zmDOZBJjHTky2vJXlXN27F5dhJNR6lLOJ7f+Y53SRtCWGdRPPY7YMcEnQ1oO/pwdos
	 o22K2GvGv/mAzfdfW4s9dlaQkTOQN+XyttMzm/InI9hp0qlyk4IaVZ7oNVu3qaTki0
	 mBA8ZYVXdZwmIqfNy6miJtuLnpE4zNWANNN9DPhL4VFvrFaXCBRQttEzDNVFYRX5Qr
	 CqoTLlJfV4gXkYaNzSMTXYorB7eejeN2jFn6NYMUxMGf2ozV8tQ8E061zEAECx8KQv
	 pLmVX7P2ms4SQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:46 -0400
Subject: [PATCH v2 03/21] nfsd: fix netlink dumpit error handling for
 rpc_status_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-3-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7i/jygUOjgBpSsR1sXXG7rsXOsu30p4zyydQ3gZHiCs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP92kHPK+qKwHuhxbkgmm0sPpdqHSqEmmPH/
 JSziv6K8HuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT/QAKCRAADmhBGVaC
 FawrD/4rzNrPZP/45iW/3ZthO6bd09TmGzIoUOaWKtoHKE9lMGY+iNlMGaakZnD9l02ylgcqpSy
 YND/r4Ifi9Z1H0bQ3YeJgDJSUZQzhmfkc09QFUO03r21TDKsUGwMOtgp6PQaz8yqL8UtHkW0a/h
 5mDTKmRLEMFfeT6vDmuPVxPwqcREv4Er0oSOHhlDR1EPlXyyIVDkeqWjmzhybjP63Oe06RxgSuZ
 jZNFnMSlWpFXHgtKYTb051UeWmWta+0kMIIXYZ0vCnLRXG9FFl0nEW7+JzVvwQ2YjhCrLu/jqlI
 g/XVJStyGdcDawFQ7pWKCfzcoWvMN/pIW0/XA7lPMpM5kEbeRmGN6MpB4u1o3c4FewCimuxM3Cv
 OMYNkZExdJmrS3VzHtgYm21liyd5HxeItAz9YHVcavWFyvIfvy4sp0Of6FtRMOnrXltDRkTullZ
 0MUnwbiWKS0Wa1NWe6BwWdShqc5T9V0pkVioibMd6Zda9FNB6R4nbQeSz6jOhSGz7VInPwgcau9
 l4N/Le0wzh4EV+SrXR8wVldUaWRvlODu62aG7ZgTtAQgvaBQFh271aFdLLvXiGxL1UHpL9WoFqz
 vOpneqMGnVkXoUTwvKWs7VjgsyEQXnRJC9P0gtq8qtwSrWqVkX2kSiNNXQpF/2KB8Ftvwslwefd
 8PB0omCStxC74ug==
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
	TAGGED_FROM(0.00)[bounces-22497-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FEDF674E81

nfsd_genl_rpc_status_compose_msg() returns -ENOBUFS on nla_put failure
without calling genlmsg_cancel(), leaving a partial message in the skb.
The caller then propagates -ENOBUFS directly, which the netlink dump
infrastructure treats as a fatal error, aborting the entire dump.

The correct netlink dump convention is:
 - Cancel any partial message with genlmsg_cancel()
 - If prior messages were added to the skb (skb->len > 0), save the
   current iterator position and return skb->len to paginate
 - Only return a negative errno when no messages fit at all

Fix compose_msg to cancel the partial message on all nla_put failure
paths, and fix the caller to paginate when possible rather than
returning a fatal error.

Fixes: ac18892ea3f7 ("NFSD: add rpc_status netlink support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a4b5b1467fe2..ab10692ee937 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1452,7 +1452,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	    nla_put_s64(skb, NFSD_A_RPC_STATUS_SERVICE_TIME,
 			ktime_to_us(genl_rqstp->rq_stime),
 			NFSD_A_RPC_STATUS_PAD))
-		return -ENOBUFS;
+		goto out_cancel;
 
 	switch (genl_rqstp->rq_saddr.ss_family) {
 	case AF_INET: {
@@ -1468,7 +1468,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 				 s_in->sin_port) ||
 		    nla_put_be16(skb, NFSD_A_RPC_STATUS_DPORT,
 				 d_in->sin_port))
-			return -ENOBUFS;
+			goto out_cancel;
 		break;
 	}
 	case AF_INET6: {
@@ -1484,7 +1484,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 				 s_in->sin6_port) ||
 		    nla_put_be16(skb, NFSD_A_RPC_STATUS_DPORT,
 				 d_in->sin6_port))
-			return -ENOBUFS;
+			goto out_cancel;
 		break;
 	}
 	}
@@ -1492,10 +1492,14 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	for (i = 0; i < genl_rqstp->rq_opcnt; i++)
 		if (nla_put_u32(skb, NFSD_A_RPC_STATUS_COMPOUND_OPS,
 				genl_rqstp->rq_opnum[i]))
-			return -ENOBUFS;
+			goto out_cancel;
 
 	genlmsg_end(skb, hdr);
 	return 0;
+
+out_cancel:
+	genlmsg_cancel(skb, hdr);
+	return -ENOBUFS;
 }
 
 /**
@@ -1587,8 +1591,14 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 
 			ret = nfsd_genl_rpc_status_compose_msg(skb, cb,
 							       &genl_rqstp);
-			if (ret)
+			if (ret) {
+				if (skb->len) {
+					cb->args[0] = i;
+					cb->args[1] = rqstp_index - 1;
+					ret = skb->len;
+				}
 				goto out;
+			}
 		}
 	}
 

-- 
2.54.0


