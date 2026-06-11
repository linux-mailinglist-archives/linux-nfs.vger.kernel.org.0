Return-Path: <linux-nfs+bounces-22506-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NbXaJcUUK2pX2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22506-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:04:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA308674ED3
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:04:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nedK7ZD9;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22506-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22506-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE4D5303C8C8
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DA39A048;
	Thu, 11 Jun 2026 20:01:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1A396B96;
	Thu, 11 Jun 2026 20:01:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208079; cv=none; b=Wea9Z/dqjJes6a4P5xYPbMw8UBHtPcEXatSikt7ieMl0fX7V7bhgJzDId3m7C6g9sq0C/uxgK1mgvsjvj1FifG5kcqbVgjVorwnqmvBL2KIucPsxTzIyH2q3E9GZfKwOHtiB3ThcD9ZTehycNBu5kWa8z9QsTGgX2Co4/RlgWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208079; c=relaxed/simple;
	bh=k1+3nNvybCP2yPtyB/iqPbzHMIb7mWCQduxORvppmO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oyvZ32FcoTkrDFxAJNSgL2JeMXCmsseyhBCnHy7uaanVWoFzBdLBwiYgZizcZzh9DfF1AQdGoFtiC4NMT2HsJJlmZXpmeHFf9iBVM0OYIbQTfOIXrMFfI8Katdm56PAfHu6iGLEIe88MboZON2lwnqoeH7uFVdrp9uXVba+2tfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nedK7ZD9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC88E1F00A3D;
	Thu, 11 Jun 2026 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208078;
	bh=N6IBf5i8l38pg5QZkxVqRRie2URayKFy7anBJCBznGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nedK7ZD9q2bAjXeuhqstPDDFcR6iVRYC77h0BaPpUO0+sYJHFSFlKSxLfMCYOv9e1
	 VgARWHcMU+5i/C/zh/D/ho6mXq3kip+M9lIsG95UeWA0+y5VR9nTEGXSLTUUwvNS1J
	 5XKfh6EKmFIgYVKZySLPGlJmBLefNIA/Sh+plEbPl00OtkHuvv+MtDMieb2WgsfDEE
	 5GdrUYB4AXSqk7uRdLlCC28eoDG2YT2CyxkwHrtnst5GXGuDvkBdzb9w03YcwoGjl3
	 regZgIHvpfMsaMQ0jRCO+5O4NXUIxWfgEV5MK8nUlD76euty8YLr9qEQ57emT3bq2K
	 qLipO7QCBRzzA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:55 -0400
Subject: [PATCH v2 12/21] nfsd: fix clock domain mismatch in
 clients_still_reclaiming()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-nfsd-testing-v2-12-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=k1+3nNvybCP2yPtyB/iqPbzHMIb7mWCQduxORvppmO8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP/4C6jV/rNtGsv8taqRTYnxsxK44DeM7zl4
 5QuzmuJIMeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT/wAKCRAADmhBGVaC
 FTj1EAC3yVJQX18BOQMo+GDeuYpNRhZLKDOir1crFRmhnacAYVjk9M+OF3yPoyFUW8KXoms7u99
 vUOEt+Taf7t+xyEQ7VS39C1C9f7dAdrHDh8P+txonhwqThyGh0xQkoPCJzH1I4T2hSY+KgLRhLU
 N6ItwHeAOxlBaefbwTsAclTsx+xbCrhhvufi95T3uv4WziUKZanD6rkRoynSH7GbQAskSZSSLAE
 8SobCOdUcJev8RWP7+gEbaoaTg+PqXh02TuVfHFoxoy6fjEvSEynPw99qPB7SaFIdR/lD0EQ5Zb
 6ZYDqZJ+C6ad0+223r+BkeCS/ItaOAVwc0WwG27QmN7aLULzVdmUn/quwpk0sZHeay0XYGDPhVS
 8tVfCfwXHwuOvGfF4fbyLPVURlHvv/Obl4wwi48C+eVYer2JS9Whiiz6Z1k+IEJSP2j3E6g6tn5
 a3X4h5t0wBoJ2iVJUh6fDQfuwgr+lPpW/MP488UNhjVEOuVA8vBjQx3vsLLEUPJ9XK4IxttUr8J
 /JtGxefCmaAhBuxHfDCHo/zHVsXP7fIclVYTdxybIxkpHpWeFYodA+NUHDF7IpALMAAnVUGSHNu
 XwNr+JnLyxK6mR7iAODHljyvYC/hHT6/VdJbU4xldVL0GQW30TrmzjmSsiUilm8HLhAeJ4sQJ8C
 ZU83W08CualTzcg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
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
	TAGGED_FROM(0.00)[bounces-22506-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA308674ED3

clients_still_reclaiming() computes a deadline from nn->boot_time
(CLOCK_REALTIME, ~1.7 billion) but compares it against
ktime_get_boottime_seconds() (CLOCK_BOOTTIME, seconds since boot).
The comparison is always false — it would take ~54 years of uptime
for BOOTTIME to exceed the REALTIME-derived deadline.

This means any client can hold the server in grace indefinitely by
sending CLAIM_PREVIOUS OPEN requests, blocking all non-reclaim
operations for all other clients.

Add boot_time_bt (CLOCK_BOOTTIME) alongside the existing boot_time
and use it for the deadline computation. boot_time (CLOCK_REALTIME)
is preserved for its cl_boot clientid-nonce role.

Fixes: 20b7d86f29d3 ("nfsd: use boottime for lease expiry calculation")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/netns.h     | 1 +
 fs/nfsd/nfs4state.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 5c33c96da28e..03724bef10a7 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -78,6 +78,7 @@ struct nfsd_net {
 	struct lock_manager nfsd4_manager;
 	unsigned long flags;
 	time64_t boot_time;
+	time64_t boot_time_bt;	/* same instant in CLOCK_BOOTTIME */
 
 	struct dentry *nfsd_client_dir;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3dc0c0f6eb5d..17cb3b0ad956 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6870,7 +6870,7 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	time64_t double_grace_period_end = nn->boot_time +
+	time64_t double_grace_period_end = nn->boot_time_bt +
 					   2 * nn->nfsd4_lease;
 
 	if (test_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags))
@@ -9245,6 +9245,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
+	nn->boot_time_bt = ktime_get_boottime_seconds();
 	clear_bit(NFSD_NET_GRACE_ENDED, &nn->flags);
 	clear_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags);
 	nn->nfsd4_manager.block_opens = true;

-- 
2.54.0


