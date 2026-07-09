Return-Path: <linux-nfs+bounces-23189-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MS8sGfLeT2rmpQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23189-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:48:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D312733F59
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:48:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bR2b2qM6;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23189-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23189-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9320F3081203
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FDB4195A9;
	Thu,  9 Jul 2026 17:40:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4C4195A1
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 17:40:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618840; cv=none; b=eLd9fTRRVbnDuGCT6Z3PtAM3B59tybhrZQjD7eHsMlyV4Td3B5TSrKFTZVaIJK3Z5nyjNIWdrpMLVadW4a+BHml98BRE7LLhjapb1DvJSqiZ/admBkEEyMiBWo/4Ti5/tKvecHfnbeDbGawLF4TrncjCZXQ5op9DDlbncMNRFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618840; c=relaxed/simple;
	bh=jXSpqRl6bPNXBRaBy9xNaTkuLCsjyTvErYBvK5BXuKI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FR5p+my7YUfmFzdK8W5eeRO51SIVUofUVLAEbsYpWFAWTkgdhAwhCoIkoyXh12V+zRJsxCMjXWPjcCqku/IU20CbjBdK4W+vJS/TCWXknrw32qDMzT20fOlq12OwDlTsNLbL5X00XBAWKhLju1rTTNlA0+mhzraPxmQqPeUKPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR2b2qM6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9241F00A3A;
	Thu,  9 Jul 2026 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618838;
	bh=5FFRP31r2iqteEgzRMfwgRu4TW8LnPoB6cfcpNtA4mg=;
	h=From:Subject:Date:To:Cc;
	b=bR2b2qM65paVQFR/6YwVKQCnpQVboR7ITz5yhP6mmRZvNaOchjtPjfHjZlxakb4l6
	 0jjhSBeXDVmwMj/XFiEYNZ1qztADT10R1abkTivmovWAQAJLOl/govUfQI7ImYqsrm
	 Izm+FPvIlkI0ATQZim2DsYKVhlOZAG7TIVQ27ncxWqTYpW6Q0urQQz3kFtmm0g/DgC
	 lpXyC/+9kSkIHXpLz74DH7oj494WmFZ4mRKbF4jaVh7ju+7FVDIZ1AjZJaIJsbIKtA
	 uk/g5Q0WCGjGeRtiw8Bf4SZE5icu+uwWiwDMHenKmaM1t3+56Vt+DNjY8F7xM8s42c
	 FV77yIaYM+/cg==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH v4 0/9] NFSD: Fix UAFs in client teardown and state
 revocation
Date: Thu, 09 Jul 2026 13:40:23 -0400
Message-Id: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOwQ6DIBBEf8VwLg2iIump/9H0AMuqtAYbsKSN8
 d8LeqnH2Z03MwsJ6C0GcikW4jHaYCeXRH0qCAzK9UitSZpwxgVrWUMBRypKKKFloBSrSHK+PHb
 2s6Xc7rsOb/1AmDOaHVoFpNorB0M+uS4YOmOYrevze7Bhnvx3WxF5jjkWRk4ZNVJCpYVEqeH6R
 O9wPE++J7kxVv9Qu0NVglpgAKXoTFN3B2hd1x8iXkE6/QAAAA==
X-Change-ID: 20260705-cel-61c1c70caa03
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Wolfgang Walter <linux@stwm.de>, 
 Chuck Lever <cel@kernel.org>, sashiko-bot <sashiko-bot@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3482; i=cel@kernel.org;
 h=from:subject:message-id; bh=jXSpqRl6bPNXBRaBy9xNaTkuLCsjyTvErYBvK5BXuKI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqT90MTu8MVkTD/QXzPVuBGlRULhSBRz35tJUeK
 rwQElB21NeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak/dDAAKCRAzarMzb2Z/
 l9LvEACM9QhN5Qw5BhSmLMF8qLvuVvUWNFPbjmVcVYoAJlPoXg7K1/tj92kPGaYoHfpvePKefXr
 IkGTLaKwktCX7/ynbHqpIQXeijyPTB9DDjolimEqCgeZOEfj9rfYOVigQOV577xiLhKVShAIMif
 J9f+4rpSkHT7eNvpsCk43Mb6aoSrTtb4vHeHIT1zgqrhVF3/zSjwfZQX8AMGlOdYJlix5eYfpYO
 lv5UNHdtQXJCjbER8S97XeDFCpgstO1PLBzoNyN3bdX6c2lB2fMhTtgLSPbhMjyYQHmBbwkVdYr
 fJHrvFaYx+cYYN4W/pwTXEx+HcDvGO+PoJt3mCu+tL5MfP7V8C6ABIifmSIGHTQnT3lA19izLCx
 lt8Wt0AD0dQKO+Eg1epjpHei4JnEcTqqU6+xmAcsIB857VpbQGXJtpkaGI9wiMx0/TdEJgIt03H
 QnqSj3ynJ/SQ5vr0tWs0uwhttdecF+YLw2SsR7aNQZH+YVmQbe2kyDJVSHgoD7OdPUd/eW8OFXr
 +T4JuWz3TaoCw781I4HQTU+q9MYC0oAw9B+vRUIanp3j4szRX3ocRiJ43h6xjK3KqtP8n8/i/Dc
 QgzcCbroYL36lCATGXhHvwf0IJ3+WXNQevhlXdsiQaBONLjnkBLOsbor9b+4EDW+Au7b7+9vcBm
 0MMroqxKN1DeBcA==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23189-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux@stwm.de,m:cel@kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D312733F59

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
Changes in v4:
- Fix svc_export double put in nfs4_put_stid() (sashiko)
- Link to v3: https://patch.msgid.link/20260707-cel-v3-0-7c0cc16fd54f@kernel.org

Changes in v3:
- Fix client UAF in laundromat blocked-lock reaping (Neil)
- Fix client UAF in laundromat close_lru reaping (sashiko)
- Fix svc_export leak when reaping open stateids (sashiko)
- Link to v2: https://patch.msgid.link/20260705-cel-v2-0-d88c3b68e8bc@kernel.org

Changes in v2:
- Add matching UAF fixes in several other paths

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
 fs/nfsd/nfs4state.c | 149 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 131 insertions(+), 24 deletions(-)
---
base-commit: ee6ae4a6bf3565b880dfb420017337475dfbc9ea
change-id: 20260705-cel-61c1c70caa03

Best regards,
--  
Chuck Lever


