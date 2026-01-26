Return-Path: <linux-nfs+bounces-18464-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH5xL7hZd2maeQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18464-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:10:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64886880A6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC553035A9A
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 12:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4565E334C1A;
	Mon, 26 Jan 2026 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omeNT6nM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F87230BE9;
	Mon, 26 Jan 2026 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429423; cv=none; b=IU4LWUJ9sl4eoaQn9E9qVh5j6gWJUSp3YPd+qfIa+8jC8Zf6QT2rZfOZMsY2FXs4XnBZjl+DRZX+VW3rREKLshVdC8mJHCDtweEKOwnGf2QhctCBKWSSRTBG9aJaJqIc/7rCjUM1vuOaExP3wu745y+A29nCEylUAw0OYZYmrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429423; c=relaxed/simple;
	bh=jRASq9oWNIGqSefvMErvSg1c4fbWyaJFpOFIGkv6+eM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uF+75mCDR87tTBkJ4vM4AzVzLRD8wrhINAypRlbW+3wthX+zMd74ViIPqVg65z3GSP3UGJXuUxGJcD7JqKOW8ivr7uymsEImW2m9wMpAH4zpMMVwmXiQEAy8MLNBE+AAqo78cT7dh9kFm8jELVbdaTvzlrYgQSc0wYxxIPHcZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omeNT6nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A39C19421;
	Mon, 26 Jan 2026 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769429423;
	bh=jRASq9oWNIGqSefvMErvSg1c4fbWyaJFpOFIGkv6+eM=;
	h=From:Subject:Date:To:Cc:From;
	b=omeNT6nMO/qe/Sswu1wqqzFBxxcVHKNeOdHHqld8YGq3so3ViX5g9F4T0AFuKHoia
	 kOF6ji//1U/8AYvj8fCzxHLst/pK0uzyDWo9Z1+R6M5aT6HqTiwD7nCAfSM/0P4uhK
	 oKuA1lyFQhVFQFUjmMl3i39KCCNfST2CtLuCuO6/M4ibgXfTkAEqgkLn2FraowIgUw
	 Ug2JHEdPjWBImdwWEkBRO64EUB6ki680lZdM+Sr751FPStUWVbhYfxphUjPaBM5TnS
	 ws774crMfd72kHh4srckbsO1oxjzE3IP3JGKeS63BJ0+MW6awXhjdqJ0LW5fL6Q62u
	 kUMYMhZBX8cGg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/2] nfsd: move delegated timestamps to being runtime
 disabled instead of compile time
Date: Mon, 26 Jan 2026 07:10:12 -0500
Message-Id: <20260126-delegts-v3-0-079f29927b83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WMwQ7CIBAFf6XZs5gFgaon/8N4aGFpiU1roCGah
 n+X9qLG47y8mQUiBU8RztUCgZKPfhoLHHYVmL4ZO2LeFgaBQiMXglkaqJsj4wpRY2Nqc2qgvB+
 BnH9upeutcO/jPIXXFk58Xf8biTNkEl3b8iMqpc3lTmGkYT+FDtZIEt+i+oiiiMYiSq5q10r9I
 +ac3/A6HZrYAAAA
X-Change-ID: 20260122-delegts-150060ac7c9a
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jRASq9oWNIGqSefvMErvSg1c4fbWyaJFpOFIGkv6+eM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpd1mp2XZp5KaMZ86sfKA86otulOAD1o3wRCbAA
 fSBn8r2rLiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXdZqQAKCRAADmhBGVaC
 FaFtEACcyppv1l7h14rvhLSHO8e1ba29gYHIcVT31MIJZMbGxwzx0DZfQY96oRjBiq2sHwMnZca
 l5aQPI52yCViecZjmoO0zI9haS64dCwY6Ls8TnXQpGzW1/j3V8/rjikBcopkId8WpSZYYYQaNqw
 jawZPZpVBzkgXZk7zoGYGFgHFeunMZcU/ycHlKetsaf6rDfG8cWP9jjqLmk+T8GQUaCDRoiudLD
 Ofq4V9cH0FqXm8eik0zHQ5leZCq33XAf8zD/zk3G6lcNYMJY6kZnH8UQcTtrAKauOwdrZX/s8c5
 PljQpY9dB7L+esSI79A++49566Wi1uQsgKvk4zvXtGUBMv9sGWAYXrA4dSTzdI89nVXioo7L4jA
 iSqlySIUerMGsbFCTS6qNOl/A6zb37Dxd6i1B6zvDDq1PJEB6GleccapYeydkB0wd307+aHctEJ
 QDDhDb8TeqvjsGTYR7LG/4RpbJc9N91hSY7PBaH5tzbwoKTftdNzVbcTBzE4CbfcsNemydSAXxA
 uDDrUp3tJrRr7u2ULlLRTDMs8v3ysCjq/fGsRgMnG5r8lnFR4PH2L4jCX4UO+C/KbOctLzcHKCf
 BN1+JAF6asvIccAZlwgVlymlohIcyTg87zI+ali/T12iWrIqItWXlnhvPTkyaOLYfE+OWHeT3fE
 fz8YTU6pPuxLIIQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18464-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64886880A6
X-Rspamd-Action: no action

This version just updates the comments an changelogs per Claude's
recommendations.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- add comment over nfsd4_want_deleg_timestamps()
- add info to changelog about how to disable delegated timestamps at runtime
- Link to v2: https://lore.kernel.org/r/20260125-delegts-v2-0-cd004157fb46@kernel.org

Changes in v2:
- Don't create debugfs file when CONFIG_NFSD_V4 is disabled
- Link to v1: https://lore.kernel.org/r/20260122-delegts-v1-0-40fbb180556c@kernel.org

---
Jeff Layton (2):
      nfsd: add a runtime switch for disabling delegated timestamps
      nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option

 fs/nfsd/Kconfig     | 10 ----------
 fs/nfsd/debugfs.c   |  4 ++++
 fs/nfsd/nfs4state.c | 15 ++++++++-------
 fs/nfsd/nfsd.h      |  1 +
 4 files changed, 13 insertions(+), 17 deletions(-)
---
base-commit: 2a1dde6dd823e94e0768e929566dd65cd74ca793
change-id: 20260122-delegts-150060ac7c9a

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


