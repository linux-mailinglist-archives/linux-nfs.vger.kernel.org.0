Return-Path: <linux-nfs+bounces-23143-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e1cpE2ZVTWoJygEAu9opvQ
	(envelope-from <linux-nfs+bounces-23143-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:37:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D5671F47A
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:37:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZZ4Bx4LZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23143-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23143-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5773031834
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D1533F582;
	Tue,  7 Jul 2026 19:31:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7F2BE035
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 19:31:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452702; cv=none; b=dEeMMu/xv9WFb0btFFdBl8VfwBOG3KvlAzCtSpYaLKSmLs352Tg3UKs3gZ685Ta/Ixo7LsmjXqtc60HD4OGGJTdQs6CEMfYcW5dlU2gGGevi2zguj7ie/LBua/oFicfpgwW6OMBntfi+kOMYU1fzz4mhLjcByqTaiHs9KNUIcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452702; c=relaxed/simple;
	bh=Zalc5XP8I7dqlPWWN5zd303nLHV5CJFLrncfBVaMHhc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WkIn+C4rN8YXAk9wEnZ/ATUtIjVKI8Roz0triaIzkiktHFXHWVoPKOM/vI5E3r5XmL4fIy/uCZQfAjv1OjcTbHMhq2GFTYhnoSqPSLE8p9dP0LKZMxPEdBwi8EuUfMjsD6M5gfgAhXw8COsD9gHAdRdhTOhHfNRq/jGEDFY1znI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ4Bx4LZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5451F000E9;
	Tue,  7 Jul 2026 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452700;
	bh=pLYep/kWeVa7tsjk789+NzviKrnjxU0pVLWDJREDtsg=;
	h=From:Subject:Date:To:Cc;
	b=ZZ4Bx4LZp8BeWRLcNVPg5qMq+Venl6CbQZQE7YPOoEzqILDj2xiKRww4SeTb2WHwP
	 EJXZ620/ykg3gJ2wMsQ/7s8SGio3h1vKuwS4uuz181GgK6UIThawYVz9WngsszBY/g
	 A0wNFqwzvrRXjJGtmkVKP1EkLzXayCWEw6npd6gPG/NEzhhLAKM/Vcz5EE1NgkVprw
	 7QrOpFPZO2XFP2AbVclqCqGcAwHmDslCzVrSuDxjPzD0tK2SSckVrL3sQFEfOR6V83
	 8ITg43We9Y/9cQOuysNJYfCLdL6pF0cC6BCSS0pBJBHPPmM7vwI+1Eytmg4QppqvMk
	 T02YZLE5Y3Zig==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v3 0/9] NFSD: Fix UAFs in client teardown and state
 revocation
Date: Tue, 07 Jul 2026 15:31:20 -0400
Message-Id: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOwQ6CMBBEf4Xs2TW1RGg8+R+GQ7ssUCXFdCvRE
 P5diiePb3ZmdhYQjp4FLsUCkWcvfgoblIcCaLChZ/TtxqCVrlStzkg8YnWiE9WKrFUlbM5n5M6
 /95Zb82N5uTtTytHscFYYXbSBhiyFTlpMLMmHPp8HL2mKn33FrHPN/8NZo8LWGCpdZdg4uj44B
 h6PU+yhWdf1C6x42PLIAAAA
X-Change-ID: 20260705-cel-61c1c70caa03
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Wolfgang Walter <linux@stwm.de>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3329; i=cel@kernel.org;
 h=from:subject:message-id; bh=Zalc5XP8I7dqlPWWN5zd303nLHV5CJFLrncfBVaMHhc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqTVQTBIFGlo5Btdb6gbsvP5qGuzacCjPvoz8Fr
 5rZBNrqaIWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak1UEwAKCRAzarMzb2Z/
 lxD5D/9kuPSGGGA+FsZsLuX1U7Y1LTrmNiYdWdfEtDRlqZ8wPYJN8Ax+sujU2CUDFU/FxfGUSle
 BZJ4XuFpUTkquBwO+LT9DAA8FwbqDoXX3GNk2qFL5D6lKTMJNBxp/SIphHok2x9d9XUUtRI2jPa
 HCHiA+goZiEZjIAZvTq+ktCCqa3oP8XTCHwhQcUDpN3lRXmOcxU4ZheOA9+qc13KmA6fAI8iXxd
 XTLxfh2jGSV2ujCqvSbL2w0XcV5EBeV6fBWvd427eieXfdnNLc/HBbuAic2AQDZCWi04BORNb3j
 f4lbLlyz0YAE0cu9zzuFyueVIVaXPO/AGKFKuI5x7/2DDjQu2pFL8ypjR5FspdVH64xrPSL2re0
 LHJd/rPejMUJWhHzlXCr790Jh/tAOZ8LBPbBzqf1p4k8jhkxa4+/19QdxMrNeqfhukT6Wcc0XHg
 u+oPOrYoSzuDBBrmpwJnHtgSqoTr9jnU+NSHt2A8ZbjSCvxA3vpd6TFzSJRdaP0GGxXhI5LmiqZ
 ZrFuUXN0oZNDQNjeOPIwX9jmrXPcHgDQyvgX/BsygYLzTYrvbD3GRqgdVp3TfdjPp+0SxvoOvu+
 E8Vcr1BToZ8jLxI808vf/lvKQuB+EJgHpoUlEOf0t0sqEa1WC0OjUiYwek6/uVQ/fJtVs0QVEfj
 eYhVnFdjZUzgXiQ==
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
	TAGGED_FROM(0.00)[bounces-23143-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux@stwm.de,m:cel@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98D5671F47A

An NFSv4 stateid, and a bare lock owner reachable through the client's
owner hash, hold only a raw pointer to the owning nfs4_client. That
client outlives its state only because __destroy_client() drains every
stateid and owner before free_client() runs. A walk that dereferences
the client, or the owner, through one of those raw pointers after
dropping the lock that kept it reachable races a concurrent teardown
that can free it first. The NULL-pointer dereference reported during
client teardown was one such race; auditing the pattern found more
across the revocation and laundromat-reaping paths.

Where the racing object is the client, the fix is uniform: pin it with
cl_rpc_users across the window in which nn->client_lock is dropped.
Skipping a client that is already expiring is part of the correctness
argument, not cleanup. force_expire_client() stops consulting
cl_rpc_users once its wait has passed, so a pin taken then would not
hold the client; the walk must instead leave that client's state for
its own teardown to drain. Testing the expiry and taking the pin under
nn->client_lock is what makes the choice atomic against the expiry.

Pinning the client from these paths introduces a lock-order edge that
did not exist before: nn->client_lock now nests outside the inner
region of nn->deleg_lock and outside nn->blocked_locks_lock, both leaf
acquisitions everywhere else. The nesting is one-directional, and
netns.h records the deleg_lock relationship; a reaping path added later
must take nn->client_lock first.

Two changes sit apart from the lifetime races. The revocation and
reaping fixes left four open-coded copies of the pin-drop idiom,
consolidated here into put_client_no_renew() helpers (patch 6). The
same audit turned up an unrelated svc_export leak:
free_ol_stateid_reaplist() reaps open and lock stateids through
->sc_free() directly, bypassing the reference drop nfs4_put_stid()
performs, so the export stays pinned and blocks unmount (patch 9).

---
Changes in v2:
- Add matching UAF fixes in several other paths

---
Changes in v3:
- Fix client UAF in laundromat blocked-lock reaping (Neil)
- Fix client UAF in laundromat close_lru reaping (sashiko)
- Fix svc_export leak when reaping open stateids (sashiko)
- Link to v2: https://patch.msgid.link/20260705-cel-v2-0-d88c3b68e8bc@kernel.org

---
Chuck Lever (9):
      NFSD: Prevent lock owner use-after-free during client teardown
      NFSD: Prevent client use-after-free during delegation revoke
      NFSD: Prevent client use-after-free during admin state revocation
      NFSD: Prevent client use-after-free during export state revocation
      NFSD: Prevent client use-after-free during NFSv4.0 revoked-state cleanup
      NFSD: Consolidate the revocation-path client unpin
      NFSD: Prevent client use-after-free during blocked-lock reaping
      NFSD: Prevent client use-after-free during close_lru reaping
      NFSD: Release the export reference when reaping open stateids

 fs/nfsd/netns.h     |   6 ++-
 fs/nfsd/nfs4state.c | 145 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 128 insertions(+), 23 deletions(-)
---
base-commit: ee6ae4a6bf3565b880dfb420017337475dfbc9ea
change-id: 20260705-cel-61c1c70caa03

Best regards,
--  
Chuck Lever


