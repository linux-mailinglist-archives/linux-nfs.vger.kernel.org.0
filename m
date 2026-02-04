Return-Path: <linux-nfs+bounces-18697-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGngJX87g2ngjwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18697-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 13:28:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA55DE5CAE
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A8923002B68
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04813ACEF4;
	Wed,  4 Feb 2026 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNP0cVsq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA05314A7A
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208122; cv=none; b=ogpfVi4tXcuIvBq0htn+epyLIiq+1vTZg1gDm2o5PWdhEAecE7j9z28dgIcSJaJ10K6Mo66XITGWlEkpvDweQFrE/uNSw5unEcZrvXwXyjmLKC4wgUfnW1Bb264vTR8ISE9uwAj60fivKlL/SBkoT4/75hD9pG8YkJyDM0VSmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208122; c=relaxed/simple;
	bh=MebNB7kxXYHJC9vusRnw8YUM+zyJCnTwYu80MnDFkSs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J4rzsJOdREqaqIs9akYo31XBhxpl3o3YDCUjOQJZ7zyIlMdAhFSbnwhvqLrqcluAi9/8KI7eADxBxG/36+Qfc/XLXaemHuAfAHJ5hnqHHKrUv/MUwtq9CvRQvfUvo5wD0bk3a4kUiaUR2/diNE4GiwSt3KWbkSQU/fIezQW/SkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNP0cVsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84874C4CEF7;
	Wed,  4 Feb 2026 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770208122;
	bh=MebNB7kxXYHJC9vusRnw8YUM+zyJCnTwYu80MnDFkSs=;
	h=From:Subject:Date:To:Cc:From;
	b=cNP0cVsqE9K+0jczyqF4MVugeG7FPEOBJouHcdYZxNfz0etXtXaUTuOmUjY2pjOXv
	 KCoyojeJ1qEVwzPHvKJA6Jhv7OnKQbkfEECidXsAO8MxhfDrEWP0c9mCzt2tnbOgnZ
	 vTIDB6JSolP7cZ2+Is+4axkEGDFgzQKIX9xIb5UkON1ZzPZgHtFHmCe8j8+L6FnoYe
	 6yVVwterPPu0Ug1GnBluEXCEpXxuZPrLc2jR2e0FT/hJ+AUg+4F5iSfOv9A/i/cwYp
	 4AdovmUJRv9mEeGIQfkbys33YFte2NoTol6BLwY4Q4IQHk5tS5BDXuiJl6MfQO6Chh
	 yCdUUcbg8D4ew==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH nfs-utils 0/3] nfsdctl: properly handle older kernels that
 don't support min-threads
Date: Wed, 04 Feb 2026 07:28:25 -0500
Message-Id: <20260204-minthreads-v1-0-9f348608f884@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0auUrC3EKv6uIi6KRg1olUZFKL27x
 eVbzAQQ8kwCnQrg6WHhwyXkmYJxtW4hzVMyGDQVGiz0zu5aPdlJdIlmpKbGtiKEFJyeZn7/WQ9
 uFn1fvAkMMX66QqyfZwAAAA==
X-Change-ID: 20260203-minthreads-402ce87096e0
To: Steve Dickson <steved@redhat.com>
Cc: Ben Coddington <bcodding@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MebNB7kxXYHJC9vusRnw8YUM+zyJCnTwYu80MnDFkSs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpgztzUW3gVtkaNwlv9GohKlDBQUh3CqRnVPzA7
 Yn38RZFRzKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYM7cwAKCRAADmhBGVaC
 FZLxEACduKBkSj31Gh6mM1wMy69JgZu6Sw/D/MjZpNd4FsfwEpZgbms0Pud1iKA+maAwP4mFXFk
 CWBikokUdYTDIs55NogIjstPOuAem1crqtEU3/6uAQMmmghsOoIFUS3ZvwhVmKJ4R0uzk8NOE8B
 Zq8ZLoAxt8lPg8ShvUwK+yP++TdE4TbgnotdxCCRF1Rx+r36qnaHh2632I7QK4W/G1cD+OQBl9S
 RqiT44R1eE/H/bTI1SCU/RHQ/ysGeIJBLsW3aTX1EKYp+g5yejFhGIzOa1T68VdNy0xX+VMeaD3
 e3wN7rJ5mjVZJ6ez7VCGbkW6yuMnImG4Rt+gtpBkZc/1nEh/xpULD74LAOQC/OUIe3TPaHU4sZJ
 QMf62EzIRRFBhckN/6BXmG5kAzHVHP61FH+nSEQJbzw96iE5gR+l3FHg8Wp47HwG+gZhzZGTcfS
 M7Esle7gh/ZC0OVjrv5z8zWv0dmWUDONT5yaeCo/PJ9KstaoLDE4kglMnP29uGgnKLMw+ZR/N7L
 8a1wxJyuwuY2OoanWVAV25ajyCbi+OBqg8N0l0zn5Q7HqrsjsFqpJXCRe+nI9L3QYzPwDoGhqse
 uK1Kr9RVJ1+90sBwOgDZWBHdrvUx6Y5kUbOyGknLukyHkNj+FUHDslwaLmJKXVKcvuTFTVQ4mpd
 0yjYPoyw6vXbvKw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18697-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA55DE5CAE
X-Rspamd-Action: no action

Ben reported a problem with using new userland with old kernel. If he
tried to send down a setting that the kernel doesn't support, it returns
-EINVAL to the call.

This patch series adds a mechanism for nfsdctl to tell what attributes
are supported by the "threads" command. If can then use that to
determine whether to pass down the min-threads attribute or report an
error or warning.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfsdctl: only resolve netlink family names once
      nfsdctl: query netlink policy before sending the minthreads attribute to kernel
      nfsdctl: remove unneeded newlines from xlog() format strings

 utils/nfsdctl/nfsdctl.c | 193 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 168 insertions(+), 25 deletions(-)
---
base-commit: 8f54511aefe1455161a6c4406ed8c770139f61e3
change-id: 20260203-minthreads-402ce87096e0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


