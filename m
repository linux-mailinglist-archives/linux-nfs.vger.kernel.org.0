Return-Path: <linux-nfs+bounces-22421-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rwboLldVKGpbCQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22421-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:03:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1831F663274
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:03:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eT0tezs9;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22421-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22421-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DF0B3079CAB
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA84F797F;
	Tue,  9 Jun 2026 17:48:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551EF4F7971;
	Tue,  9 Jun 2026 17:48:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027295; cv=none; b=afc0vKITUTZGgC85i0j4MWEoM4nbC/K5qaYXnsEO4juUorFDsXc8T0q2mhU+b9DBIX6dSVbNcLjQVznAXGfIlByZIFh9ATdTh7Nm0HTg0v6sOokMg3vLqitEk8sRRPvW8HgHDxE/enNid3S0TNssr6oR7WOXdOjpel9c6xeqVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027295; c=relaxed/simple;
	bh=OYisog8Kx3y4MnJjV/foiQQqsloh/a8MHBJXRKT5rFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyBNLSiP6sbdGjnqJ/KQvmQjPLflKaWUzj8GqUuL4kSLf8v9jihyMGNZLEc/7+lGMin5gkdw0tgFX8QDlu2sZtKa/1lPIKZ0FgAc5As7nbSOwY4QaCua3GNPR3RLuZotGYJdSwMo2MTuMIHJw+d7oeWce+hY4jaS7AVB5AZZAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT0tezs9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268A11F00898;
	Tue,  9 Jun 2026 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027294;
	bh=gAqfHUM127N+azYQA54XtiqTmulZM8PTFlQDj7h6rT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eT0tezs9k5LdD/YyEgs/XM7UySCplyxuwg+j+4WnnfyPLmnhtohZHNn5qTczMKGZS
	 q0XrjFEM7MExDP89Ri6wXBXDFjTZkbaFsALsyYJZzwFqYrCLkiXuqXgUq1Y8C42fDA
	 4Z3CML7GJ2H8mF5TfVyR4yu03pSCW6MHthjUq/6qZdWMK4Ci/ISIlhHc8QDvTX2SQn
	 ux/ILimyJcVu8uwzGwhr/CyOI2JfqofelrN6bhu61wZCcHp4EOKn/3IVK50XobxNF9
	 WRyR1lgSrDOG8kb77Gp9MkNCtBxLBh2CnrEKoIZDCwNDDSP5wvHmz7/l4PobySf9Jq
	 6+XcCwiRdgVwg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:35 -0400
Subject: [PATCH 14/19] nfsd: use test_and_clear_bit for somebody_reclaimed
 to prevent lost update
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-14-e83acead2ae8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OYisog8Kx3y4MnJjV/foiQQqsloh/a8MHBJXRKT5rFQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG8FOL1b8Xh0QF0PK4yx7nJCQpJkGmX5tnWH
 ueXsBASK3CJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRvAAKCRAADmhBGVaC
 FaAxD/4p+C9KcrmdQ9jwhRqyXwHF4FS5f7oDGSFqYkbkaIbnHaj8vWnnKVfKSY0d7FJUEH6N10I
 kOb//N5SBwCCcklRsltMpd+ey8fUvDQ2zzW/pkCmCh1uMVFx28oUIf7zGD9PzuBkpGKiv19i1Pi
 cmmKfqnjJZ6sx59vcuVxKb+IFbqWBr6UcQ9hd4WHzjH8QHIJDx6cKZ7J4cxZ7F6ete5EqVy8KdT
 HjdbFBvoecFOZ6eDlio4oIStjTeYT/4xjnmk0E93iz5rAn7Ebb6AdfHId9/RiwfjMcHjFzic7mE
 vTSl2CoAhr8Gad4Y9uDbgvGx6zinOf3I2PSqe5pISKTpWfLcDvHtUPxM1JHZ2PjjJUuyRqYUM/Y
 yv47d3a0+RNZCd8r5hJz0tQj2BSNtdsISz50wPd/SR4slSb84FNdWa0R3KHcT3x40HrNbolSjAT
 Gjln7+Zu8wyfDjddxGrnpK+LZPoiJ/4GOzlm79qiOk2mqqhX+N+l9+aDGWqd7JV25MCmXEdnczp
 oDgDdaF4MDpFGXJosTnnFuU4+EMowywj6PEsfJZwB1DvrXsRjNZpc11OXcJZ/2JTllQ+8lW9YOP
 j+kwTKDcvzQSRgWnYSg3lEt3rn5fhxMGSnkp6CB9uZn7A1LYRpCe8Cp/fmEdMeUGjsw9u8dBBOH
 1s9uCNAQ7fixuKQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22421-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1831F663274

clients_still_reclaiming() uses separate test_bit() and clear_bit()
calls on NFSD_NET_SOMEBODY_RECLAIMED. A concurrent set_bit() from
the OPEN or LOCK reclaim path arriving between the test and clear
is silently lost, causing the next laundromat tick to end grace
prematurely.

Replace with test_and_clear_bit() to make the read-and-clear atomic.

Fixes: 8c67a210c90c ("nfsd: convert nfsd_net boolean flags to unsigned long flags word")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6e47330c6365..fddef6f8db7c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6837,9 +6837,8 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 		if (atomic_read(&nn->nr_reclaim_complete) == size)
 			return false;
 	}
-	if (!test_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags))
+	if (!test_and_clear_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags))
 		return false;
-	clear_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
 	/*
 	 * If we've given them *two* lease times to reclaim, and they're
 	 * still not done, give up:

-- 
2.54.0


