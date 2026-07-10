Return-Path: <linux-nfs+bounces-23231-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6V+nLQL9UGp39gIAu9opvQ
	(envelope-from <linux-nfs+bounces-23231-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:09:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1680873B9EE
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:09:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="U4GkVJ/Q";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23231-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23231-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E4B530477E5
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6282BDC28;
	Fri, 10 Jul 2026 14:00:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCE22DB78C;
	Fri, 10 Jul 2026 14:00:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692023; cv=none; b=rPza+7gwCPMF/1G//KUvV2lSox0K44j+9RaUxFqiOPMNcd3rbYoox1DTCBzc+xKplAhZv/cMZPGsU/jctvUeAnaOcd8OjOuhuW/UeSYHhkyUgWEjx9bJSUSa9i1EaMYtSq5iwCsHW76tvon7t9mek5HiLxy3o+34PyiR+LjcDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692023; c=relaxed/simple;
	bh=QPt+IimTqDFgymJN5oJf2AlkCQtrWCNLlMFUzk0KI4Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ar83wjgBrTPjQNUAFg48a5gcamkHM59thokBJtgW6+SvZ026GcN1yanrw8A1eNAdJ8cPFe5TyDy7/9zwrxaeytjpjYJ+Eitu9eTvN32pEP1kYQwTd9bmhjAmZWnOCxxNAhSSoioXVA7izCauNBsANkP52uliadci/0goVij1yDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4GkVJ/Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8544F1F000E9;
	Fri, 10 Jul 2026 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692022;
	bh=Wpq0sXsoJXmV+Vhp7sFBedgd51dK5O+/ymbBfVbBXhc=;
	h=From:Subject:Date:To:Cc;
	b=U4GkVJ/QHy0CEtan8xLkLcX/M873nc/BDpxPitHJd7xvRH2fbdbw8dIhLLysAPi7g
	 rLsQjk0GrjWP0efQljMYu+hFzPVUnOubSb/Frk1btjOPX92DaIG8a/jB3H1ydT4PVI
	 E59aDHjIoQJ3toV72/ro5iHzJzxRlk2pHw84d+TKNEEhnuN5cVGHntQZf++FAZ0Zhn
	 frandT4xiFH6xwpuqS2msPFt/XrnS+8o8vhJFO6XCnSRkQipzNmRHUDDujEzxYQCn8
	 eyfnkVew25a2D7TgUyyppgHTkWkN8ZwEPv4yS6epI5kL0JYs65pV9L9xrplmGgqOGd
	 y8qpajYN/BaHA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 00/10] nfsd: copy offload fixes
Date: Fri, 10 Jul 2026 10:00:04 -0400
Message-Id: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMywrCMBCF4VcpszaSTHqJrnwPcdHYSTsoqSQlK
 KXvbtqNKLg8B75/hkiBKcKxmCFQ4sijz0PvCrgOre9JcJc3oMRa1lgK72InJooT+16YUh+cVLX
 WCiGTRyDHzy13vuQ9cJzG8NrqSa3vn1BSQgprTKXJIlJZnW4UPN33Y+hhLSX86EYefjRmLVtlW
 9TaOtN86WVZ3hJJ+WDnAAAA
X-Change-ID: 20260624-nfsd-testing-8439f0163312
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2635; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QPt+IimTqDFgymJN5oJf2AlkCQtrWCNLlMFUzk0KI4Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqUPrt2XrIcGdDVbDqCwaswCoA2+n9fFvRZCf2w
 XRg9od5rAKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCalD67QAKCRAADmhBGVaC
 FRIkD/9basz9x9JNvxvHe52fZu3KJoOV7GHlq15YNc+fBW7I3Yf1x5avtUiqxofW9tnqp0C3blc
 ITU+mIeLhTQ92HJ7iFV0iwVimPsgLzBn3uyxAxsH+pdgd+gUY+MLrRfIktbzAmDtlLlJ/HNV/Dd
 wCm8ZB9DLvzA13rmffVpfloXYDA6B3HgGf7H3ED6UML0DkZ6VLRUGtX7aU69Hz1x9UoDHbBnbg2
 FcUKQ93Jrs0qp2VWmQ7acmIVWEdHDpVL0/4oaU4U5cECviEuj6DsBbVrPbdiWxETWt1zwpQH1cz
 VYQb16mlIgMRfYu9SitFTrB1LdZzHDUtwEddupZgd+2OvRC0U8I9v2kFmasR4cMPjgOEbFj21JE
 eg+Pcu96H8t2oW82SPdRWZjRKuicquLpz06ajjGccWc1wlUiKFhrCmNxxYud+whKHxX/0gSCy5i
 DgaaS+C819s/9wokKaWOngiXgAT03ffwlaQ6nPoc8xwrbdynkwBINZz41VjjJ035I9WTHKorV2l
 nilbhPExSLu0X+0FpfxGFxZPDeEjweIZGNGxbzDcNZbPaNPqnkXoSxgka0yWNShfEU7Ah/ESizs
 tUEHndEnXXsIM7sajboOMhLNNLrjA0zaKdvJxrZBdwg9rsszf8m3NmW9+BiWU4QdZK8YNM+yNMh
 s/7QTTxXHWkTpMg==
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
	TAGGED_FROM(0.00)[bounces-23231-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1680873B9EE

This version fixes a couple of problems noticed by Sashiko.

These patches fix bugs in inter-server copy offload code noticed by LLM
inspection. The first 3 were found via kres, and the next 4 fix problems
that were flagged in agentic review of those patches (and some via
testing).

The last 3 patches attempt to rework the code to be less problematic in
the future. It breaks up the nfsd4_copy object into two separate objects
with well-defined lifetimes, and then integrates the COPY stateids into
the normal nfs4_stid model. The idea is to bring clarity to the copy
object lifetimes that was the underlying cause of most of these bugs.

As part of this work, I've had Claude cook up a set of pynfs tests for
COPY that I'll post separately.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- Write new stateid to cp_res to prevent potential bad CB_OFFLOAD call
- Fix interim regression that could cause IDR leak
- Make comments much more terse
- Link to v2: https://lore.kernel.org/r/20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org

Changes in v2:
- Add new patches to fix neighboring bugs found via testing and LLM review
- Fix error return when given NL_NAME or NL_URL netlocs
- Split nfsd4_copy into transient and durable async copy objects
- Rework COPY stateids to use normal stateid infrastructure
- Link to v1: https://lore.kernel.org/r/20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org

---
Chris Mason (1):
      nfsd: fix cpntf publish race in nfs4_init_cp_state

Jeff Layton (9):
      nfsd: fix UAF in async copy cancel and shutdown
      nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
      nfsd: initialize copy-notify stateid before publishing it
      nfsd: check client ownership when cancelling a copy-notify stateid
      nfsd: revoke copy-notify stateids before dropping their reference
      nfsd: return NFS4ERR_NOTSUPP for unsupported netloc4 types
      nfsd: split nfsd4_copy into transient and durable async copy objects
      nfsd: make the copy offload stateid a first-class nfs4_stid
      nfsd: drop dead COPY-vs-COPYNOTIFY type handling from s2s stateid IDR

 fs/nfsd/nfs4proc.c  | 261 +++++++++++++++++++++++++++++++---------------------
 fs/nfsd/nfs4state.c | 187 ++++++++++++++++++++++++++++---------
 fs/nfsd/nfs4xdr.c   |  13 +++
 fs/nfsd/state.h     |   6 +-
 fs/nfsd/xdr4.h      |  30 ++++--
 5 files changed, 337 insertions(+), 160 deletions(-)
---
base-commit: bc7d6a41a6282da7c175c1638bdfef69c10f78d5
change-id: 20260624-nfsd-testing-8439f0163312

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


