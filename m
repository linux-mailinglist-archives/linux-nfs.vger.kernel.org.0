Return-Path: <linux-nfs+bounces-22909-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kc7gD/ZzRWokAgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22909-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:09:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 935356F14D7
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:09:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Bew+8c68;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22909-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22909-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CEEC30FE7DF
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E435E1A6;
	Wed,  1 Jul 2026 19:57:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49E431E7B;
	Wed,  1 Jul 2026 19:57:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935832; cv=none; b=V3Z5ndT/CQPsIBx81w6priggUHTqdN+zOpferQ9jnHDexBsK2cz433ULSnC5B6tNx+NxNRPh8IgXOyr0faDVhVHrwfjtbUFlWoK1xmsYv9P0HDF5UGJ5jhw+7DTPFNOYc4x2FKTFgV7MZaumPfWldLWVfPSCvRqKg9yBNAnDr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935832; c=relaxed/simple;
	bh=wlGvZyIYKFZSRSrzenlC/yPHHmXLQ4zEetEmpyOgjuA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VodXNbcuOeNxQZGhG95319D0vKucrrcHUPkCKL+QtED46ZeZ09ws4KfU1InrrzzgN6ae72jSnS6y9zjZmiPE6i+kjDeB3OYxElc7MzqAuQh+bG0v/CxsGIGuG6c3NYQPFhKPVppt0BgiOz2bv+Ix2I2lDnJs1hjkKiNjsXaGWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bew+8c68; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E711F000E9;
	Wed,  1 Jul 2026 19:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935831;
	bh=/WR7rHFgE8bLY5tYkDvk/w9+dBkbf5i4SwJO4cztbhE=;
	h=From:Subject:Date:To:Cc;
	b=Bew+8c68l0z7gvUDL0AD2iw/PQM2K4hgFuAJMK9SN2v/doGGMJze18O+/+VKvfUtn
	 Dz2jALCDNXU+sJa94B16Do1lJ0o/wZaBj+84PmudvGECc/wu0IghrCs9CBe4CUQRfT
	 qoCfEUrF4pvQyz7ZU4AyqJ2zofSN7E2Z8Ml4CtG+M1BiMTmYmaiCHkBrcNVbZOjkXc
	 LuJxVGTkn8iTKKa9IKfMtDKVadC4cXSS/0ljZJJPHULdIefjUFhYGgu0DTlSSOntSw
	 oWR/m0Ko/lJiFjlY3lzIOkp2/z6qa+OtnuKrV8yDvmBKn0l7pfykLTmLip+ABTNcao
	 gj/rUGdDj7OrA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/4] sunrpc: hardcode pool_mode to pernode, remove other
 modes
Date: Wed, 01 Jul 2026 15:56:55 -0400
Message-Id: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQ6CMAyA4VchO1uzdWOIJ9/DeBBWYBEZ2ZRoC
 O/u4KJG4vFv2q8jC+QtBbZPRuZpsMG6LobaJKxszl1NYE1shhw1Vygh3Dvfl9A718LVGQJJuki
 1RG5KxeJZ76myj4U8nmI3Ntycfy4fBjFP/2CDAAFFViEnmWYqLw4X8h21W+drNmsDvgWN6YqAU
 VBVKrDQJIh2P4L8FPIVQQIHk6POdNwwlfkSpml6AQuORnI1AQAA
X-Change-ID: 20260423-sunrpc-pool-mode-3e6b56320dc4
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wlGvZyIYKFZSRSrzenlC/yPHHmXLQ4zEetEmpyOgjuA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqRXEQ8aB2pXJLna5jiWpiTPLZg6OD/2R9ztzK1
 yApbjFLydCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakVxEAAKCRAADmhBGVaC
 FQ32D/91ta+mS8KmG7j+TZpAgWro7iyjwKjwYRpD9/D+lJYxw+UsFxFSKlBEy06l6YRGyuawL8V
 aqfUY9YToL3/ZxqIeR9KBgXz70rmwgpafcHFoZauBgZWwc3RKHOu+d+hlLSf0qaEyH3l7rSHqWm
 WB7uU0Ol3RSBVAEC2pw/FSfvaxZMiKSfYd7S3m9Y+X7SMxGBZEp3Cx51Nw+zlrF4q7bCBpOh3i2
 +B22syIt/1+bzwCiOHGshF3NI3BWqLgt5vVAN7RM4nVgWL2zn91+StgyBP+2L10PeGX9HwD3Mbi
 zZ5zn5+uW4Qh8Cq6MY8uMWL3MccQu/XiggwIdehWdR3HzR31QHMAHxUAuyGw52NTWa+0kKuN6UX
 MZNrJnMuuFajTaBG+0CjaR4ddkvHEpT0PvO3xCzwPvq+Z39W76M1e1FGizfyjMTd8jMTkG5cjN4
 roRbYGwSIeD+KyZmhTbw2J7nSa5hkw5gLltWi4VHL9GEAB+D+6K40ENz4VLJ7AGKEY6BeH73PlE
 NXoCbTQIp9ycqHchFnk6c9xR8h3njx3V1Deqjp9GorDwM1M12ITAiCrGMDxyeHNZMZeEw4XT2oz
 fZFtgDSzC6jP2+nr3xCkwan5c1VL1gTi8KbM6zo9OYNuV4MkS3qlP6rt7XL8+L2UxcpoD0wfj19
 YtW2RrPZsAeo1kQ==
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
	TAGGED_FROM(0.00)[bounces-22909-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 935356F14D7

This version drops the 5/4 follow-on patch that I had sent after the
original series, and changes the second patch to not allow unpooled
services to consult the map.

Patches #1 and #3 address what is a shortcoming of the existing code --
namely that the server can be configured to schedule RPCs to pools with
no threads in them.

The first patch addresses this problem: if the chosen pool has no
threads, then choose another that does.

The third patch tries to prevent this situation in the
auto-thread-placement case by ensuring that each populated node has at
least one thread.

The last patch is a performance micro-optimization. The old code used a
modulus (actually two) to determine the pool (and prevent potentially
overrunning the array). This trades that for a less cpu-intensive method
of finding the pool to use.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v4:
- Drop 5/4 RCU patch
- Only let pooled services consult the map
- Comment and commit log fixes
- Link to v3: https://lore.kernel.org/r/20260629-sunrpc-pool-mode-v3-0-d92676606dfd@kernel.org

Changes in v3:
- Add patch to ensure that we don't route requests to empty pools
- When auto-distributing threads, always create at least one thread per populated pool
- Use sysfs_match_string for the module parameter
- Reword deprecation printk to be more vague about removal
- Explicitly set m_count == 0 in svc_pool_map_get()
- Optimize svc_pool_for_cpu() by eliminating modulus ops
- Link to v2: https://lore.kernel.org/r/20260625-sunrpc-pool-mode-v2-1-4f512b6e1ee8@kernel.org

Changes in v2:
- Accept any previously-accepted setting for pool_mode
- Link to v1: https://lore.kernel.org/r/20260423-sunrpc-pool-mode-v1-1-b7f20e35749b@kernel.org

---
Jeff Layton (4):
      sunrpc: route to a populated pool in svc_pool_for_cpu()
      sunrpc: hardcode pool_mode to pernode, remove other modes
      sunrpc: guarantee a thread per CPU-bearing node when auto-distributing
      sunrpc: eliminate a modulus operation from the enqueueing codepath

 Documentation/admin-guide/kernel-parameters.txt |  20 +-
 net/sunrpc/svc.c                                | 302 ++++++++----------------
 2 files changed, 104 insertions(+), 218 deletions(-)
---
base-commit: f8eb95335cc219493427f976460cf4b7e9641e92
change-id: 20260423-sunrpc-pool-mode-3e6b56320dc4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


