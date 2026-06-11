Return-Path: <linux-nfs+bounces-22507-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7XLzINYUK2pa2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22507-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:04:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A766674EE7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:04:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NcDY5JGe;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22507-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22507-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 089E4303EB52
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4CF39C00D;
	Thu, 11 Jun 2026 20:01:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0AA399D02;
	Thu, 11 Jun 2026 20:01:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208080; cv=none; b=QkaNsUsPa1Aje80t6qYPqpzuq1QqoTLFWYa2BrHk+Vd58TbvrTWpvTXgoyXyLo++5SRIkJ9ljkDVVEYN2Gw73HDl5RJ4BbkjByo328s3I6m97RWHT7nzT074O7/3f12rPXBt6OmzVET/kVInJR+J7lK4DofzNkd6T01KYG1Vsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208080; c=relaxed/simple;
	bh=ObOGEjHCl1wun8r56sq9dpP6f5wb+X2IB0QE7bxxQ6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dcef0gB5AsbXyAbIJGhcBpI7wGR/hRKP0UHgWm7dyN1r6qlJAKs3CU5rhlCcwzAGXWJbCP8k6uY8qHA8lpO7XYKYhAoeG7nq+LgAhkPCauM8yyav5KFL4DjeKUW6D6oRgD9LEmRH4iEU3K/tlqTK7k+9y4Hi3lnMhfvl2s9s40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcDY5JGe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDF61F000E9;
	Thu, 11 Jun 2026 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208079;
	bh=qypWEmKDc8VPRsvEvcw+R0/AveIIbPpTIb6zRvH5aFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NcDY5JGexxDAvBFZxAhCddSGRooNNmBLUBpamVQhvg/jlNPxhuz2bJJsvVjfQyOAW
	 9hgJouWl8li5+7JPcyiXdUi33EIXrgvcSgmAtb9OL9VgFUAJHSG3QXNDTCvM4nTxWl
	 l8s36Tj+tDL/bVg7Rxcr8lXIvva17rl1BL9TbcxVhHhLKNW/rNpjl6+yN5IXHfo6Oj
	 uoJzzoi2XAnrvxoEh4SlrNrH+qrMzm5egeRnJvWA0T8zGOmWlm8aUESHKJCRiXqcZS
	 NJF0B4euxsdMhLDXciGQXkO1i5mITq0AJwYvodMtKloKfjH77S4YTcoZx059iQP5lo
	 fYj1c5AWQwtFA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:56 -0400
Subject: [PATCH v2 13/21] nfsd: use test_and_clear_bit for
 somebody_reclaimed to prevent lost update
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-13-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ObOGEjHCl1wun8r56sq9dpP6f5wb+X2IB0QE7bxxQ6c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP/nslqwdxhNw96Ytm8e0AWYWfNjP/qLajOA
 kb0IeCCigKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT/wAKCRAADmhBGVaC
 FaHoEACfLTnNqO0Le+7ber3Mw1XvhNNvFjniTXdsZmT/vhpxHCVsVL4bK8tNQXFpq+FOZCUp9U8
 NwexMtcH7UfE8QxTUpZ+nKPzCa4lxAdcqp764byFlfxPaZdGlwpg8B43cb2Ckp3kErVFJ0PGN3T
 vd1aMZS4MlaN40pWORWwmvDJ5Euxhwc+o8pnWY1uJgXPK6JkW4weFg+xljowFbDNkKJROAkQV3e
 ouWl2dJd+WUO+fwj9nhWx5ra8s+U3X6z9rafa+jj+Sgys+YCrB/m+7QI7y2mThfPlT4izHsFUMC
 VxvqqwE7+fLV/7k6IaczLjoRUy80ICZzaWjKpEdRv8l3dX3xgmu2CZhbPURCSnyyEGUohBl3QXk
 iI0EHZ4z5ZB3sVnMx1QNXpnpGDslJ5Sq9mJKKCPs2W2Rq7AaPhFfxT++NecYnjhfW0I+vEhOKNb
 efKyHLAKXYAcJZYwJsraFdT9YA8SLYbsBH7844urR06uyomxv40PPqPxk7Vbk8CVA1zzVprzwkW
 J7qrBys9HnR7Z/yhG7BsYz0oOlRvMATO6v4kG5W4rxcJO1maKHr7KppFQnjQvPpLYbdOYryw9nk
 tIA4CEixJaFZrwzFKI3AxFzAYmOZJiAnpIZnz2l+22gCLipKWmpku3K+c3zBoHXPMM7q6yloz/E
 8DMqUKM3LfuNYpA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
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
	TAGGED_FROM(0.00)[bounces-22507-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A766674EE7

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
index 17cb3b0ad956..0735a3bafa58 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6884,9 +6884,8 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
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


