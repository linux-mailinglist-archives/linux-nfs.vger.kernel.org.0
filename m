Return-Path: <linux-nfs+bounces-22411-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PuB0Jd5SKGqwCAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22411-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:52:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51722663151
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:52:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bANRYTHD;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22411-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22411-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89DBF30C598D
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA74DA55E;
	Tue,  9 Jun 2026 17:47:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200054D8DA7;
	Tue,  9 Jun 2026 17:47:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027274; cv=none; b=aojWSHS1wz32aiBn5/C3m+8kzOiRVSmwyVomOZ2A6JgHXj8D0OJm79o98T8ZRkq/As2C5B2CmDPBnQzp7y7sNEfjcPvEsBHM382XxxgEClsSvf64dtWX7rwN9J0SOCkENV7uEbzrmkg2VCWQZV2gCHTictEsvIZHYFQ+ashar00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027274; c=relaxed/simple;
	bh=7i/jygUOjgBpSsR1sXXG7rsXOsu30p4zyydQ3gZHiCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rstGBRVm1aS/kZ4yJO0KsIM4LQN2A+9MGYlE2kgoSKEQ7cevfHWjnwNIXNB67RB5EX2i2QkrzIcdcuZCcaqbwPLrRKvkkRjCxi+h/avoE0aLYMTgHrcajxmVNxDzlr6aLZzpu41TKx/kzJbywwDkvS5884OjoQ43rt+NuWb6WHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bANRYTHD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01B01F00898;
	Tue,  9 Jun 2026 17:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027272;
	bh=sYS0pOY3O5FJffkpguiMcujriyVX10KqbFnMWYew9gg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bANRYTHD468XNdkiyGCI2YjQiYgRj09hEj5ajqaJ54xLDX2Sp+7myInPeTpJeST8L
	 ITpRQSlprzJ4fQcoTU1dyDxixw6KSRtyLSBdWuAbNoWG8yJV5l2ENA1AoB6b418jlt
	 i0X2v+D8xZ87T/l8DN4eqES1tO8xu9O62HrEUoV3Bu/HOInUGw9vWof3/9hPVEjvg7
	 GLkUAr2OHNbzULdGrgtnr2pOl0otxCvo8cji+AtsdCeFiV0dM5iKFFIZBYRr+J4QZw
	 XyENoWI1BGo8fZWf0khETbtQ1xZ/FfPmnHb2uRxoi9s39c07HnDwuEAPHsAGmJEBBy
	 jGid7+CF8mbFQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:25 -0400
Subject: [PATCH 04/19] nfsd: fix netlink dumpit error handling for
 rpc_status_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-4-e83acead2ae8@kernel.org>
References: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
In-Reply-To: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Benjamin Coddington <bcodding@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7i/jygUOjgBpSsR1sXXG7rsXOsu30p4zyydQ3gZHiCs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG68cFSUXVAd071PiXERCfN3aLRh2APFsb+3
 8HDAL3z0iGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRugAKCRAADmhBGVaC
 FZf2D/wJoDj6+KqTrPavUmGocc4U3uZNXJkRoBfsug3oI+QabjtF96eco8nCPN927dIweeioiOI
 j13U6XpdMaOMLX5MoGP/8QG0XdHyN0hzMBYXE5nUFHRgmPHu8U2mGg5GS9atkQBmTaldhUIFxZx
 h7hlp8TNL+xflIDMRqyUsVlaQCNBw/zfnDZFIGeJ7MluiQ3BFJ62rdeCGJE+mUBHDkaHw0bp4Q8
 m1XeLcwhk3kbqxvr6d8j+iq29bBPbcLXNYznIeqTXm3U4fK5uGqBbzjkWYnTB4fX9XsOpOPiMxx
 /7ffeKnYzKEU7ZfEbdaAvlHfZYq9ytGRw8wyjLE4a0b9vgaBIA2Mc/wCZwSQlaHWkKb83xpMAX9
 ZvysBabpTfzKDYoAQ9gVyfBeQPiZRdNHZ/2Lm7pTyxWuwoZfJ114zIwWCwARrLFkQ7CMjdGp9Ul
 3JxT8BlOB5sOC5aPOIe1MfaKyU5Z2f/UNe1niqCx93pIP4r5FGgKR2sCbth1qZhbscGAUyT3IKH
 qJlIHSMpzLqFvJU4SP+qMtVDwhslFRhFl7rNQA9QtUQYvd9spLfQegwq/xo4go1yzYFWDDf6xe5
 UQm/x/wWwuBmcwtg2Z0QaOTPJJhjcAjih6jtdvq8vmmwf1uBFYCFcQWeXgTmKDbLKbZfsi2Rh+C
 hQPChPmpZZpLZRg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22411-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51722663151

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


