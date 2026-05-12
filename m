Return-Path: <linux-nfs+bounces-21545-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE2wIMZxA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21545-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE12527A9D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B167A32F25BE
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A236C9C2;
	Tue, 12 May 2026 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgVQURBH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4536C5A1
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609645; cv=none; b=llQwYhpfeFdi7a+5AWobHD589itB0rM3q+VWioPnmcA5qQi1Q0lzj6ztS7jOOeip/V3ghXWv8Z1mAbyUtXnBzpuPmaIS7aEKjHWSIKZ384Kdj2lbtrzkuYFrMYcbLZ3B/9WK2lrKXwIOwPNruRb70HVAu5uLL+Qpq6qPna+HMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609645; c=relaxed/simple;
	bh=J2pmGnim6Ng4edpnQ2sAkkOpF4i04B64WU1QU+/iMKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrkCRbmBVgN4Cgk9+p2DNtoT97NUYSdg+y3fkukvKWt6VCiu8/Z9lpaj5aD/sYzClJQbzYv1+44uTT21yVtbqje2g3RtwUodkYbfsbrM4iYumxgcLY7pc2OLFbJZtkcU9Pfb1LLQ0W4YGjXGEAnnRvTDxG5nTZ5HAxZoxIqKoDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgVQURBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F75C2BCF6;
	Tue, 12 May 2026 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609644;
	bh=J2pmGnim6Ng4edpnQ2sAkkOpF4i04B64WU1QU+/iMKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mgVQURBHdDyAfzE0Fnk2h1OHf00UEnRZt9A/iwChW42htEnUX1LWr9N7bArzIumGy
	 OPzbX0NMCnfBLe2YKcdThv/FeQY3jpwsfWBf50IJGfpTgR28bQmYnITTd/RFWiF3s6
	 lsYfK+p1XBw5gpT4bBg6zIEoKLbM34FoGdzhqkTwgT6+NqKsWezVBt/yD6yP4RbzlE
	 x8O7w2at7M1V6WnTTkRumiyJm6yOLF8OdtEyo1r2aVMIRoahre+tKiJQgL3XXPv57O
	 OBPGVoWEbu304+Bu4xEBVPAUUR5lhRldxSt32Qz3U7dPZAw9asxgAI8tiFQPEh5glr
	 uesc3FUI9hmmA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:40 -0400
Subject: [PATCH 05/38] lockd: Do not monitor when looking up the LOCK_MSG
 callback host
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-5-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=yitGsyNq2KRv+EPJmD8kECDr/EQmOQGAvxDIB3y8/MM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23kKJA7CnYJ/WFbtzPmOuTVSuO4ub6h+ineM
 ztmCJZ80WKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 l14pEACZWU6QDLyPljmmqCHsWQVSODbujpys+8dqxezr0bZYnwmiH9cNhBqjBTYGFhGQ1GCQRpp
 9BIVtUhwCLpab6QiQ6TXgDkDCgb33K5OIv2XJPM+QQTRqnGyUgESejBff6tjO+tj7igCXoT363i
 ZPiH8XYiI1W47wdrkFforPcQOpm0yXGWlYeivdgpFZQvIf1nRiRQ7Ip2wmgqHz8lvpQr8+ndkG1
 I1kKtFKZnnt019DPvApPNcnBDlAsF1ogyO6Prb9niSlQwNzUGAUUXtOoYZiJ1qSYf8NKeXd+xGG
 1Qv2VXtFWEVLoQqrp5+vAaDbPXzPUuQ9y0pJb9xoTZZUk5RgL5wLc3QiuPfMXLwAZVUUrO5LMYz
 082fNrDOXSP/Ji5iB1lUZceWkHAm49NEruP6nrkTNr81WK6JpRcUSheQSIU2wv25sNyvJC7zo/V
 9h80ydJNtYbrGEOs9ppMD6KiNJeHHe7Ew/2HH0c2Mj0UDYbSfKHU29Bwt7phg6BBFHPeaZT+4tA
 XNj062k6TsCPdkbBUYxYaKi1Sye69locDNFi2ciwK9mL3ddkgWmUaOzLfaMVK+kcoM1JTsPBTis
 ABOIf48jYTMMdKqtnyt3do/m7M8aUHXSMQfhVTkj5dW1JIMWTQ7KMooDF+UCD6VUbOWaLX5dvYa
 1AF71yoN19mx1QQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: EFE12527A9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21545-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

A LOCK_MSG handler that fails to obtain a host returns
rpc_system_err, which causes the dispatcher to send an RPC-level
error rather than an NLM LOCK_RES denial. Before the xdrgen
conversion, the outer host lookup was unmonitored, so an NSM
upcall failure was reported back to the client through LOCK_RES
with status nlm_lck_denied_nolocks generated by the inner helper.

The xdrgen conversion replaced the unmonitored lookup with
nlm4svc_lookup_host(..., true). When nsm_monitor() fails, the
outer lookup now returns NULL, so the procedure short-circuits to
rpc_system_err and __nlm4svc_proc_lock_msg() never runs. The
client therefore receives no LOCK_RES, regressing the legacy
behavior.

The inner helper still performs a monitored lookup while building
the LOCK_RES, so the outer call only needs an unmonitored host
reference for the callback path. Pass false here to restore the
previous semantics.

Fixes: b2be4e28c23a ("lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 886b56317e5f..e3a6d69c1fa6 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -698,7 +698,7 @@ static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
 	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
 	struct nlm_host *host;
 
-	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, true);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 

-- 
2.54.0


