Return-Path: <linux-nfs+bounces-21981-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEGvFY7TFWrRcgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21981-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 19:08:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3F5DA5AB
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 19:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 074BB3042249
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA7D3C5832;
	Tue, 26 May 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb5CKRdF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF538CFE7;
	Tue, 26 May 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813545; cv=none; b=rVU/5R6glPkkb5l7Hweyad0/x4u74r+JXy2ER4SIT2rILFCz4i2v9UNnP+CdMLHWydXQKLLvL8ZHURi0rPKUVIfsI1Rzq20kPU8r/YRJVn5kfKMUWTde8SIQngYwgDKECKgSEx+2EFHWL0sZsWwOt7g2S9vJJkG/Ey4TSTa+Rpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813545; c=relaxed/simple;
	bh=sfItHrXMrp/IfU6OGFso7zpsqYfru7gMH1hXlM+p6D4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SKQNoWzUAguQzSTBzVuj6GkmvQv892SW0+twthv0o0gFdzzquVypUR7G0KOx1ch3QNi/wKdhLr4KT2/f53S+MXRNmZ8PrBVHHSs6tMPHaXtVYF9utVD0Ls13h2A30kweEb3v8QVXqStRlsjXJFhpUDm/EcF8H/EoxUOYaAlno+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb5CKRdF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30F81F000E9;
	Tue, 26 May 2026 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813544;
	bh=K8S8VoI0VPRUKv7R5iSevFOc3PL1XpPbcZEnMURVdck=;
	h=From:Subject:Date:To:Cc;
	b=Jb5CKRdFgOz4P5KPV4hUyIGW6Oc/PPlE3mpWa7ma9ScpWG77IiLBwmcfHUBNua6iJ
	 pPugjxcrDPywFjUAfHmVf4YjQgii49WICsGOnnpXeT0khwB/+tZRJ2vmqeZvTqRvIK
	 z2tZDnMMdRJ0dNYUWyFXeiw3WAxeeVnbvGxFZpl7gAVsM/DRJboeriQ/QBngbFs5Hs
	 eJHWG+B3fzob12koQ1PVYsVpfEOe/hjXPBgqhEDGD4Xo3TYaB7wPF406bHaUL6JpvD
	 Hy9nfs63xJaKP64FdZhz0xSAenohPKwDRxWtJyS+elzF/vA2TizgoUYDl4ecmtky84
	 0RDPzwG6cqFZA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfsd: callback channel fixes
Date: Tue, 26 May 2026 12:38:44 -0400
Message-Id: <20260526-cb_recall_any_callback_running_stuck-v1-0-310011a028f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QrCMAwAf2Xk2UJs2Sz+ikjpsmyGjSipE2Xs3
 62+3b3cbVDYhAucmw2MX1LkrlWOhwbolnViJ0N18Og7bH3nqE/GlJclZf2kH/SZ5mSrquiUynO
 l2Z3GEDFiCOgj1NTDeJT3f3O57vsXuLNz+HYAAAA=
X-Change-ID: 20260526-cb_recall_any_callback_running_stuck-7f3808033028
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=585; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sfItHrXMrp/IfU6OGFso7zpsqYfru7gMH1hXlM+p6D4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFcyjdX7uy7NTwpBMy0YY+QW2kXwM9k3RQWs3M
 9EKeezxlkeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahXMowAKCRAADmhBGVaC
 FVzqEAC5G5W287RQb8s6u9ygAHZ0oiYjYOVmVTVRDOXV6kK/t26O1hKxpcyuOg2gN8iDDxmNJLS
 wZ6xHacsyE1agjqHUlvESsBRemvAnR6Ol7gIkfWodCjPc2ZOUFQBShkv2nconQasOfy2sWxpU7q
 U7hWAO2GXB0eo40bxqjwplExn5RJ57cYTkK2Y8/DDb4htqlyFPcRM7Nz9JC2GjkiDX4mfGMomDK
 T1UWi5wus07Y6/kGHswv+FoFktZvFYwuWuEXD+Arc9AIm487SXQFYPaqOR88yZ3TmPu22FNP5kT
 6l22ysoUeNS8OaWwCS4eL7sAySt0EgrgKR8ja8ekvvMy2LEiHqUO4uFe1LPWqFVsJJZzFJ+3Ue9
 Grj/R+xF60qgn6AL3Uocmrwp2CirYDcmLJNxjX4VXaCjYwUbb+WyiaCDmQLW4prD1ufmlEky0R0
 EzgveL3UWpiiP9O5bVHIFcQc5YiZr1LBR//xSsRxsmaru97NUg0Poi6Y7AxbQTHWQhpl+hYq7o8
 m1f5VEjBB9+tRwWbY3MBPqsNKuEsiM5ivjoPbhwBXfAitk+GbYjAc1K+7YU36n3scyj5l7Ly6ff
 sYdR93FJtxU0KQP6YptRv1QI5ZpJwGXCwbMgyo/PQu2G439pxkxVQwalg+jmz3kubViWOvK74oe
 tPsiXMezJyS9OFQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21981-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AEE3F5DA5AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some fixes for the callback channel machinery. These problems were
mostly found via agentic scans.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfsd: defer setting NFSD4_CALLBACK_RUNNING in deleg_reaper
      nfsd: clear CALLBACK_RUNNING on failed delegation recall queue

 fs/nfsd/nfs4state.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
---
base-commit: 97bac3c7a039675d7ae71fbdf3a7c39e840339b6
change-id: 20260526-cb_recall_any_callback_running_stuck-7f3808033028

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


