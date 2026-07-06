Return-Path: <linux-nfs+bounces-23010-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6gKREJcES2rdKwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23010-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:27:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B333770BE92
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 03:27:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=esotjwRo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23010-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23010-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1102C3024A6E
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 01:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60AC17A2FB;
	Mon,  6 Jul 2026 01:26:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDF3314B9
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 01:25:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301160; cv=none; b=GvHYXW0mjTsnLyA6kKDkYqovAIzxkaK7iVAAXtKskDoqkQsO8xEeES8RyrZrYpfuAz7v/5voZoaRyEB2LFGOszmBlnTtDswN23jGS6fgYDe6S3/k3kxA0QdnzwG+YRWsHaxm8JCW/AW9/yMK8y7tQou6jzZHEELWlDxsAHyzBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301160; c=relaxed/simple;
	bh=swX1AkbhmhRZRH3AnkbByYaquXBWoxhZgGeo6Si6MIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hRePVp0OWmD8Zrh137QopkO8Ddk0CWXqLBddJuTJbV8DxRK8N97uQ6ct7toV8pIY+Oe7Qj2FT173FpCnErSKLVszGglia1T1GiuWl1g75tmpSTBDF0KCctF2SWf788GcjJFxnjF7kH6bFCeLQ1b0lUXpSSW/qtCW+8kTlqxInPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esotjwRo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFF51F000E9;
	Mon,  6 Jul 2026 01:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783301159;
	bh=vZ4nn2h42RK9iAFKMX9gMFgz4E8WEtaS91PPcUZe8KI=;
	h=From:Subject:Date:To:Cc;
	b=esotjwRovDJRLMYLgeQrn468h4ZtgV8abbApyNRypmbv4siAvoHd9jkEih4Efk05H
	 qZZclhkqddARJVWF+5n75G+CblXgheROV8DF0SnhiP58W8DB317YTG0E9GE8XPGBxx
	 AKlF2RTMEbGqJH1Bcehe2g35CxPg8Nnb6lHU3tC9KlTQYIuWDGuZzmw24rZ6Wqs8lO
	 w8nA+GtdZGRIagdtWEi05rmfzC3Q1W7RwrpvEgQ6F90ppISqomUievw5g32i9kpQ2T
	 fMMae1f8f8qo7iDzzXK+XC8NRdqZpiySK9OKAoBsgXCCQ2y32VLAm3Yu79nXE9LwIj
	 dBNJBH0yHjf2w==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v2 0/6] NFSD: Fix UAFs in client teardown and state
 revocation
Date: Sun, 05 Jul 2026 21:25:36 -0400
Message-Id: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2UBXcQN/RXxIs2yLSJSmijD27
 7b6eC7n3A1csorDudsgy1tdH1YhHjrglWwR1KkyxBCHMIYTstxx6LnnMTBROEI1n1lm/fxeLtc
 /+yvdhEtLm5HIBVMm47VNNvuERbyoLbDvXy+u7HGGAAAA
X-Change-ID: 20260705-cel-61c1c70caa03
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Wolfgang Walter <linux@stwm.de>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=cel@kernel.org;
 h=from:subject:message-id; bh=swX1AkbhmhRZRH3AnkbByYaquXBWoxhZgGeo6Si6MIg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqSwQb1ZN4XOlfERMtr49QIZu1In33CpU4CCGKe
 L/heQP9ji2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaksEGwAKCRAzarMzb2Z/
 l6nQEACzYYUprGrHALz6Il93D5y10832B3Y1A8bySi692hA3ukZpiXg+a5pBXcZ9ky1ZFIEfWZW
 9N7GvhJk8nhtdFPLC69nts65iVPYjUm0RrilZktd7DVengYBVcaaA5Ux00hI2CVvUK0FWoS/6zd
 jzgQKTvvkBnNJn1WEIyHnjoQ6trCoVd8sDFd6qzNhQNuqSBO3XP0n9NOXCEnl44XjQ1OrK6FT3p
 HKDy9YSvASnH6PcGJ/FXvgf3kfx8BIKvqDZAmL3ADCEasc7qcIK+3CB9eBN6iV0JBy4mnemBxJB
 IAst5Eo2G7MPunEZ6DJ3y9mg4gStM82mdOW3LOPSEYxx5kPnoTD6foLixCUEaja8E++qPwWoVeZ
 XMC/Uc4sk9R5oDjSu7DJ1UuYnDzQ4jkWhXfqa3CJ7KoRwIl7fI9jExzA8XThwHF8Jk8Dz0WPdzc
 2Hj/zPYpjsAToLhaB/TYdX9BBUTRNQ8IPpw9eZnaMWdXJRu4I2O6wMXI6Cc5+EL4Eye2ckoLCgR
 IUw9OIvHklUeejcfKDZBKvoH+A2/AlEvv0DEIilCcVE+JLh/BQ0oX5fAYf0orh421//S2KX5Xf5
 iY2Gs8QnsiUMj3EBcGOQyuntiyimqaDfmQGlEpYf/Y9LmY6V7m8fhXzRkuNcKYBIYyd8uwEiODj
 b/qMqgY9SPZc+lA==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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
	TAGGED_FROM(0.00)[bounces-23010-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux@stwm.de,m:cel@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B333770BE92

A NULL-pointer dereference reported during NFSv4 client teardown
(patch 1) proved to be one instance of a broader lifetime bug in
NFSD's state-revocation machinery. This series fixes the reported
crash and the sibling races found by auditing the same pattern, then
consolidates the fixes.

A stateid, and a bare lock owner reachable through the client's owner
hash, hold only a raw pointer to the owning nfs4_client; a reference
on the stateid or owner does not keep the client alive. The client
outlives its state solely because __destroy_client() drains that state
before free_client() runs. Several paths break that invariant. The
laundromat unhashes an expired delegation before revoke_delegation()
re-links it, leaving it momentarily on no client-reachable list
(patch 2). nfsd4_revoke_states() and its export and NFSv4.0
admin-revoke siblings drop nn->client_lock and then dereference the
client again (patches 3-5). __destroy_client() walks the owner hash
and frees blocked locks with no reference held (patch 1).

---
Changes since v1:
- Add matching UAF fixes in several other paths

---
Chuck Lever (6):
      NFSD: Prevent lock owner use-after-free during client teardown
      NFSD: Prevent client use-after-free during delegation revoke
      NFSD: Prevent client use-after-free during admin state revocation
      NFSD: Prevent client use-after-free during export state revocation
      NFSD: Prevent client use-after-free during NFSv4.0 revoked-state cleanup
      NFSD: Consolidate the revocation-path client unpin

 fs/nfsd/netns.h     |   6 ++-
 fs/nfsd/nfs4state.c | 108 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 94 insertions(+), 20 deletions(-)
---
base-commit: ee6ae4a6bf3565b880dfb420017337475dfbc9ea
change-id: 20260705-cel-61c1c70caa03

Best regards,
--  
Chuck Lever


