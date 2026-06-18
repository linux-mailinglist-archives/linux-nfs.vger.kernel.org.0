Return-Path: <linux-nfs+bounces-22673-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AGD0ItcjNGpaPgYAu9opvQ
	(envelope-from <linux-nfs+bounces-22673-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 18:59:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF866A1B82
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 18:59:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ldGdNUn1;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22673-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22673-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6C5E3059FEC
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C564343887;
	Thu, 18 Jun 2026 16:58:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61734388D;
	Thu, 18 Jun 2026 16:58:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801901; cv=none; b=eaADVHrMmI5k+JB9qzK8ujWxC3uPW3/EK9PJSFn75fWUvGssWlj/i1k3xStIQa2PpCM517iUO9WdVR+asnpNTG/u7PxPUFyA5mKwHeMHTGUx/aDWgnRULDaSRFa3pIY44JZdTaXZbt2U0ZhH4yKJDRUcU9mHagO0DqV+FnNqCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801901; c=relaxed/simple;
	bh=1hy8GsBfF5Qm55H4JbWI+zlGijgc64oFQmBHg2lPgRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqyuGJTA6GlNoityNHwXMm48/VzO9tvgmwHti8GNczdDRpw5tqjJ3U5gp44/VttIx76qx2CM6hWGgdVTUdcgAqfjAiL1Pa7n1Ud9f1kBBb1s6h3r3+bkY115Oy2bUvWHlNkJ7YLmFv6QhOY2BG1b2WyB4W/YyP6zpv9tz4Veb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldGdNUn1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F601F000E9;
	Thu, 18 Jun 2026 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781801900;
	bh=JWzcor2Zi0JVNOL1ygN5ZinfTDjx6btTmxsAgUsfew8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ldGdNUn1LByEvD0hTekCy4AjZAGqAF69Py5TGuJKtOV35sI6yDFhuU5mW/cvy1rDM
	 EKX1ab8pa3gYunEPr+a34lvZ2EU2LR470LLx9VFM/mjgqDaAVvsaZgh3l7sqfk5Kap
	 yt0GWerfhivaYMVBpPP8kDHPi3whI/8lcN6Gcp7WSpfAc3wbPQWhWxsrMpYYmxKsAF
	 KBGZJsrswCw4wNyjnp5dmXmpXzMCVBRND596XZELR8Usw66mv4C5pX5YMjmjFLgVkQ
	 V+owzIBwMIK/f49Fo3/EMpHjYC+dpBP2rbEFOUR4+cCj6zKGDOC66LkcJ0shLpcJXN
	 el7EzMab7GSKg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 18 Jun 2026 12:57:56 -0400
Subject: [PATCH v5 2/6] sunrpc: use per-net counts in svc_seq_show()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-exportd-netlink-v5-2-e9aef947af3d@kernel.org>
References: <20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org>
In-Reply-To: <20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1hy8GsBfF5Qm55H4JbWI+zlGijgc64oFQmBHg2lPgRQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNCOnWsFZi8Piwe1RjT3PQ7Vqt7etn+BZpCUJk
 LZSeKF7w6eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajQjpwAKCRAADmhBGVaC
 FR6EEACpWANTvdhb8cYqkDLg6+ujVn4tx3FSI+elQ6TVm85l+Vme5hr1CU4jou5r47wOIMvMS5C
 tgR/RGVDYgSP1jnmncrebSMPzxm8pyfdbDUR9vtXBWZ+rNgs3SyW0rpUqPhhiXpSEwQLVqGYVuu
 Gj9RlIJnkK7PEHUJZxfgs093dJdBfFxwwQ4vfYGcRmi6Pp+Wvw9soqw3AQsRnrVHtuiWeSdiaQI
 TxNCV5ixFGzqj/AeFgbmQPqbL8xvbhYyS8C1EQpXqin8+PetgtZbR5Ue0aQ+/7NOYw+R2YDhL5s
 hE1IdSVvotWPywBQTOYs/WK4R4qC0TIet6/9JSh2S9ey3OaA4F+9oR9qqnUyRRwymQ/UcBQRjl1
 R9wVSLF1HsabgRBAKBLpKShJcOFIbCmh6QMhwQXJGp7MxqIFrcOK1VqHJu1ZWti7abAR1a7EbsP
 GrSAllsSUcqtLvumjrO/Q5GSn6rhHz3ZZbTW4sFMBy0m+fehEYkE3Th4oUVunO75oMX7VIiHsX+
 XtlBSOudgFiX6+BU1gxLCE16iZqh2vd7aHbZCaAufDSwzoJqi3l7KknHnpUuHZuu5TgXCqfF/8U
 7wrEkO1KWyTbYsUf3PE6bYx+CTchhQ3PP/bpeXjG40fUSL4T66x+5r6/JCQDFyTtuTFvQEH+Gc5
 +I102PLfuifst0g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22673-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEF866A1B82

Update svc_seq_show() to read from the per-netns
statp->vs_count[] arrays instead of the global
svc_version->vs_count[].

The only caller is nfsd, which always allocates vs_count via
svc_stat_alloc_counts() in nfsd_net_init(), so the per-netns
arrays are always available.

This makes /proc/net/rpc/nfsd report per-network-namespace
procedure call counts.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 7093e18ac26c..d08711bee18e 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -108,7 +108,7 @@ void svc_seq_show(struct seq_file *seq, const struct svc_stat *statp)
 		for (j = 0; j < vers->vs_nproc; j++) {
 			count = 0;
 			for_each_possible_cpu(k)
-				count += per_cpu(vers->vs_count[j], k);
+				count += per_cpu(statp->vs_count[i][j], k);
 			seq_printf(seq, " %lu", count);
 		}
 		seq_putc(seq, '\n');

-- 
2.54.0


