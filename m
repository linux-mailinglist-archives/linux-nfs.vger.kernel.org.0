Return-Path: <linux-nfs+bounces-22913-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 33txDgt0RWopAgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22913-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:09:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B96066F14EA
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:09:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="VMSFt/IY";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22913-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22913-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E50A831114EB
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA613B42CC;
	Wed,  1 Jul 2026 19:57:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D203B635A;
	Wed,  1 Jul 2026 19:57:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935836; cv=none; b=E05qP8qBidLlzyjROL8zwzv9bfsuXYsbXBlN3RCqhnY9Zg4UT4Vw30XIUna8882bGIb5u2iumXYYE2wrsZeRckkoQgSQlLNHuJsSWLj2RUDGMKeNUOqUVRMIiexZ4aFRwBT7gxLRmNhOld8Q2Moo4wwTxZ+4D+2LlaWtJHhw0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935836; c=relaxed/simple;
	bh=EYTh4PtiMjp6Af2MDQOdPPDxC3pzBTRXCilJfUcKiO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f35M6MyzR4cj917HYXpyhvXgkx3FN+Miz33SRUe+k6WM4Z+9MUNquWyhB2moAEpM2qvulkLXcYMZT/fh2+nanJ56VTuw5Rwk2NTdi6IevhlKvgXUFyJ1ypTtzj2Ty1Lx+KJwuESwcLm6NHUwuKctAT7AeHlswWpdaz7JGMXbjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMSFt/IY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43DB1F00A3E;
	Wed,  1 Jul 2026 19:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935835;
	bh=APfeKDhhE+sgJkQ4EpMX/3Xpg3iOR06NMs+7rydh88Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VMSFt/IYRdP/rA58t8UeJDI8rgRsTgPpj9cEpOpnN1E1GzEEByJByh+bokB05dk/8
	 dmSc2S6graO4HDw8/y/+3RiEOA8zSeTEHjmnryRpIploevPx0+i4qIJbakkvn/lvnE
	 ZvOA65gWe72hVH2GnxdDpeyveT9T0okhxtz5Idrs3kN/UGRfVuRkUN4nGox1PyHLqD
	 gOQYrTXLYgx4qa7hSabrGXlDttV3gQuSodqPRbkYOwOleuld1AsxxndKgJy6zGQ6mT
	 H3lqVxFp2wGXfBPjaC6fHyNi8+tpHOFkpCDzg/gC06PX8VU8TWbeOwDqZw8UYXoXh5
	 k5hnc6834hL3g==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 01 Jul 2026 15:56:59 -0400
Subject: [PATCH v4 4/4] sunrpc: eliminate a modulus operation from the
 enqueueing codepath
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-sunrpc-pool-mode-v4-4-b3d867e4c8f9@kernel.org>
References: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
In-Reply-To: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EYTh4PtiMjp6Af2MDQOdPPDxC3pzBTRXCilJfUcKiO0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqRXEWCBKDtORPkDi6eQHYZI628CyEFSaJu3SWO
 U5RRNvh4/OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakVxFgAKCRAADmhBGVaC
 FcLTEADQufAOnRkFx6QSZRe6SF5ggrDPChm3UnYOAGaauLN4AVLatikH3UWrlAlQ2uWNKQcQmb9
 2TQNHTk6iZj8FwqmsHWOSYR41flJDNNGNrjTFrvkSLjh4QeJb7+EEOeL+6nKMs4789cVLnYQOJf
 ezK07H58qJLGKUnia0Y0rTVAChoFy2hhgoHI0yPNr0t0eTDAG4KbDQfKv+BcbfVPKcWnIOhi/40
 vg3PS9dK/P46I8qtDLG89CVOCbrJc7qMTntD/TAWbPnjQ1uEhR0thXT3L8iCHbgfyKSU2EaYC/4
 nC2f8N3/vHH8gCkJ4woO2fj+2raHN183fK6wClksI4EyLso2LhGZgK++IFS2q6SXSQUKkhyRgKl
 9cgps6f/VX9THmj9BrG0m3uaVndkrse/miVSrYR6HG/O5JXC1ofdQazq2zarfg4gtEb+wNIYtbb
 kTjlwl1rQwxBWRi1JxNhqbFn6r/vv/gPkvVTNXkJzf9OJ5k4UvQfRCKxxQt9MwrdO1rWYOFwDFc
 wueqOfHaf424eMFR6oJocg9gYBs1dHcVgRcUPh5dKCHRmqBpaHjxb5dQPO+DqbkhmjsThHlqLMc
 UGzinTDIqkJD6TmJ0ag5mZR4r+0xkbP+vB+eI4zCf7r1RlRi89VfgwLXcwvX8ZuQkm32UC5+Yoc
 eIU8wC1ekT9PoMg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22913-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B96066F14EA

Currently we do this to determine the pool to enqueue on:

    pidx = m->to_pool[cpu_to_node(raw_smp_processor_id())] % serv->sv_nrpools;

...but a modulus is rather expensive. Replace this instead with an
explicit check for running off the end of the array.

This situation should never occur, but if it does, just fall back to
pool 0.

This trades a ~20-30 cycle operation that isn't pipelined and
monopolizes the divider for a ~1 cycle well-predicted branch.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ae93a6f51087..ed841ea09079 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -252,7 +252,9 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 	if (serv->sv_nrpools <= 1)
 		return serv->sv_pools;
 
-	pidx = m->to_pool[cpu_to_node(raw_smp_processor_id())] % serv->sv_nrpools;
+	pidx = m->to_pool[cpu_to_node(raw_smp_processor_id())];
+	if (pidx >= serv->sv_nrpools)
+		pidx = 0;
 
 	/*
 	 * Threads are spread evenly across the pools, but when there are

-- 
2.54.0


