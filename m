Return-Path: <linux-nfs+bounces-22281-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RqntNWaxIWqFLQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22281-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:09:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1364234B
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:09:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dkum1JGv;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22281-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22281-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFD53300F5F2
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6E495504;
	Thu,  4 Jun 2026 17:06:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB11495516;
	Thu,  4 Jun 2026 17:06:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592809; cv=none; b=Vsygk7irYesxZz06NyobZGTCbuTh8Ba73oLH+tLlYgcliLjl8C1UG9+PEnBSd2VCwXGJGd+2X7SnJF9YKSZpyVdocHgfvLxFE7k/yoyKGEvGwIww1xINVnx2arSSPHz/VP+XoJzu/u6F7zGmPJesuN1Ste1QvcCEIjRg4JpaQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592809; c=relaxed/simple;
	bh=y602FwVPDfFkTbomTE/nL90MVbJZjga0nDcvGmHbT5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XCR0Hm7ofjscLQLuy4CMbG1y/eBbcORAMlFJGWH54yX7hTcC3S5zC/11IJsaRPr36qEg/6CEDIq2pXiUHMSzxYFliR7L9CrY3VNlz+wqBt91EeWIN8ZZ/k36hVx++nlJkc/BrYPT/sdO5l3XrW8ap7pFKXVU+tZeUlpE1/BdVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkum1JGv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9FE1F00893;
	Thu,  4 Jun 2026 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780592806;
	bh=lHODA2CZkaiM/pf0VZyBPbSXTZCn1FBJwG05WiKa7Xg=;
	h=From:Subject:Date:To:Cc;
	b=dkum1JGvjDw99rae+eFomodgg3Fr0F3kIJVancZIbKjXk78AqlNkMGDmdj6TYnlCd
	 JMgRtxtlPhM4avXrKK71Z347FZB3uSh/lls33m5WIHOarpoUlOmEM1h+zR8Um/dFxa
	 JE77jj4sB7lPGK8FHFfpyGmOPyzlBMNMUW2YuPL6ouUJqIhPmpLV6FtSfOBGdgez4g
	 3ToS/2AzpEgdplN7slNjhgrLGkGYHyQzrsdBDHlZuhwHm1xsPfREG9F2zmx1NKYHMq
	 bSLXhc5iwDJM6lBXIKbJSQ3TYiFHgkIJd8u73AEeN1FrJOREikvq6EQ38RjKQqjfvw
	 SkoQUeHukcEzw==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/8] Harden xprtrdma connect and reply handling
Date: Thu, 04 Jun 2026 13:06:32 -0400
Message-Id: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMTQrDIBBGrxJmXcGaVEqvUrrQcZIYiMpoQiDk7
 tV2+b6fd0Im9pTh1Z3AtPvsY6hwv3WAswkTCe8qg5JKSy0HcSQu7FYjmEaMWyjCKfPEXj907wa
 ov1Qbf/yc78+f82YXwtJEbWFNJmHZBJxblIjHyGtFguv6Amok9EKTAAAA
X-Change-ID: 20260604-xprtrdma-refcount-d2a8c36563d4
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chris Mason <clm@meta.com>, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=y602FwVPDfFkTbomTE/nL90MVbJZjga0nDcvGmHbT5Y=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbCdii6ZYD/E0+8MaFV0zT4HA6QDwED6XDhpH
 RkQ3oC7R9uJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiGwnQAKCRAzarMzb2Z/
 l8qAEACCrBVEW7nndrOL3ZETzCneT/5PImO4ztD+XUITaiyzK9oW6WxoAFjNsAxK4zFNVuT8kJp
 rLEdixaccVdZOLOeohc+JXP11IhZ4h1B8sJXoQ2uLGxrv4LmmmxTUYA07UXxlv+Dhh3qYANsg0p
 izTMNFZDAZOzTPXE4LXrc/k3eeA6wEyRYctmnnEz5DuDBFJD2qXNMGHR+ct1kSUvXXgJNPK1Epa
 afurtUA9sYd6Og6CWB4BkRmz/0bExuApRNvtq8bA+3UTdqCnioDsHtssB0j2DiXA/qxE1CvxucJ
 tPY09UNeDcZMYM+4bozFL4LXg4YwqnM5Jp09B/sxlaZkovbWIwoq95I+9BYWv/tcO/Ktvqn7SEQ
 PEOBBrcEDQXosxBQQWy10seoa0DVFY2QhgCU4hCGpZc92LV7REqSJiYHbpFTtHxIUBfxmzPS4bc
 z2YC7zD8wouUDDThjRMTBRsiJrfP4rgK7uazOhE6XzhnY3d9a43kdmyPH5sjdEYRbkRiGb/JYmi
 2rFRfm60h6Nrih82EsV/Rt9mH8BFYdeXnu9MW8+CG3bSkWjQbBwxeSMeS4rIIct2VGWw8PnVlot
 xjDV5a4tlFBj66W+mUaFBN8Q06PCds3budyQpfZxDXB2kWq5yUw8GAl744LUiSvlaEP1jlUbVQQ
 PEBG+RV0D6IFkDw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:clm@meta.com,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22281-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39C1364234B

This series is the result of an LLM-assisted review of the xprtrdma
code base, addressing eight defects in the xprtrdma connect and
reply-handling paths.

A design thread runs through the reply- and send-path fixes: in this
transport, WR-associated resources are reclaimed only by
completions. Each Receive completion consumes one posted Receive, so
every exit from rpcrdma_reply_handler() must either transfer
ownership of the rep or recycle it and post a replacement; exits
that do neither leak the rep and let a misbehaving peer drain the
Receive queue (patches 5 and 7). On the send side, a sendctx slot is
reclaimed only when a Send completion sweeps past it, so a
preparation failure that posts no Send WR has to rewind the ring
head explicitly instead of waiting for a completion that will never
arrive (patch 8).

One ordering constraint: the credit clamp moves ahead of every
branch that can reach the repost tail (patch 6) before the
malformed-reply exits are rerouted through that tail (patch 7). The
rerouted exits refill against rb_credits, the most recently accepted
credit grant, and the earlier clamp guarantees that value is bounded
by re_max_requests rather than taken raw from the wire.

Receive buffer sizing follows from state that outlives the
receive threshold is renegotiated on every connect, so a surviving
rep's receive buffer can be smaller than the new connection
requires. The series resizes undersized buffers at repost time
rather than freeing all reps at disconnect, which would reintroduce
the allocation churn that commit 0e13dd9ea8be removed (patch 4).

This series applied on top of 7.1-rc4 plus
https://lore.kernel.org/linux-nfs/20260526141405.39877-3-cel@kernel.org/

---
Chris Mason (3):
      xprtrdma: Fix ep kref imbalance on ADDR_CHANGE
      xprtrdma: Initialize re_id before removal registration
      xprtrdma: Fix bcall rep leak and unbounded peek

Chuck Lever (5):
      xprtrdma: Check frwr_wp_create() during connect
      xprtrdma: Resize reply buffers before reposting receives
      xprtrdma: Sanitize the reply credit grant after parsing
      xprtrdma: Repost Receive buffers for malformed replies
      xprtrdma: Return sendctx slot after Send preparation failure

 net/sunrpc/xprtrdma/rpc_rdma.c  | 29 ++++++++----
 net/sunrpc/xprtrdma/verbs.c     | 99 ++++++++++++++++++++++++++++++++++++-----
 net/sunrpc/xprtrdma/xprt_rdma.h |  2 +
 3 files changed, 111 insertions(+), 19 deletions(-)
---
base-commit: ed42a6289b2164998fc29370789dcff40ed50159
change-id: 20260604-xprtrdma-refcount-d2a8c36563d4

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


