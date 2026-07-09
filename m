Return-Path: <linux-nfs+bounces-23221-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XNGaHHnyT2rWqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23221-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6F8734CB2
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kWIkTWol;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23221-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23221-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5ADA3071A73
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3039BFFA;
	Thu,  9 Jul 2026 19:02:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BC3B995B
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623774; cv=none; b=MvCeKg43DD6z1JnoKIyygMWQm94ElT3M8QR46n/1CHGbTEpPpzw1PGDKDaa4BCmFM35g3QgAK2Y9fTpFsDhYMsuayVCKxXwi2n4ShfnHbQhwzlSNgfnXQczHhAJk4XHERUTOpOZFhgcE46Y/edJ0Vj7OxUsE1RqrQtkMhZ4UqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623774; c=relaxed/simple;
	bh=4wnWt6q0hqCSeWHpeLVZ/fEu0ZroGdBtRkxnSdWa1Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GdUz31RNCsnRUpjzJ17rYswk1xdF1B8Jf/wvH6ZcH74eQ23ocpZJN0Yqmk9CP8BhMxlsTszlagkX65MIrWxJGlTejltohcYHKOOxwJ6LDWnqe0PhS5qDfeeRIEoxmv+YjwbSpYarOnPsm5yFLovrnAJQQIQs9dPRzelJ5pJgecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWIkTWol; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8541B1F000E9;
	Thu,  9 Jul 2026 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623773;
	bh=bVjGRpcFWpA1TWYlifWZkT82D9SMRx5SVY461CPSOrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kWIkTWolMHhzVRtGTZzVf9UU/uE7MIy/GFZ65cAuq3h0rkWuaAXyimRHLhIDoPNzt
	 6vhEcgI2SKnyJ3XUJen1gV2qfFmRLPIF6iki6/fK69mL2RxwkS04YoMwPz7x8Q9qgB
	 m0NSuMFjqOg38wD9lYq6e658xuzyefgNfjLruAGIJ6hmnpJaggW7GNVNl0VEfiqZBo
	 BbHykA79UyUidQVUe5Z5Q88heIN7RbkjKDHs8FkRzjK1LhjG+uck0uomYCCvuPAIT/
	 pt+5u0UHAq6g3EzqQlE52VO/Q2NzEwgbBMfgnrg2L19baUkxy3bMy/pYhK/zfC2ZQI
	 JeK3mhg+EpZAA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:36 -0400
Subject: [PATCH pynfs 08/13] server41tests: test OFFLOAD_STATUS with
 fabricated stateid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-copy-v1-8-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4wnWt6q0hqCSeWHpeLVZ/fEu0ZroGdBtRkxnSdWa1Tc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BTV9S0rKxGiIn7irw54avEdSHXFWKAsk5ys
 32WXfsW5Q+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wUwAKCRAADmhBGVaC
 FQZvEACeTS0j1nJjggY+kgsiCPcwCVMEpWOG3tMSWObdLXxougf/gr6OhWy5U9YRmPnjOTcDooX
 AXILRAJ6b2Aat1POKkvrxK5qK0HD6Fy+Y8SDCIRmgFyzdeu6ocVtRfIJvwszOoT9em7qrM1qFEB
 QZr9YdTNJUR9+Hguyu1q8FyewEcGC/prPnjxOJzCgCGaxOFbEy3UBqzw1L7WfagThq+0kJxxLQp
 VqS9xWagMJpvp2g3xe6RnjhEEzEGuZIB0HM/J61XEBxzBhmgBg2zNdz5AfeQWhvKVY/Z0eJx+il
 kvH2JWlZdwsPU4YsuZNqeFXdhCrHwo+zI5an1tTQvezTtzQ4BAMqHKILcApAYJ/lmWsTLa+0M1R
 qV2s7R8pweW0NJpdqH4JWNeAEVPkmcDzFB3DsqB8tMTrP/J0eLI2g5PU8G6I73e32Zq9mFczrbf
 TPBmQcjR7wxe9PtD6VhX9hqNVeKDAn2sqBYEuMYsv90PBNnWx8tw80gK/6Qe593iDRgToK7O/dy
 iLio72gNvqXDWBJwDwJ0n3DEjoHvWjA0/SkKH7FOgfOMzOVKe4GbYYbmxVcUgQUlQgCRFFNRFuT
 KqUI+C2VXkIg2uqV2HsNWSUdy6N3ei0A984TsQUmhWGdsmZnbRhkO0ghPYo6bY3SkgNPXTfW3Aj
 qazrieHQeKFKkiw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23221-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C6F8734CB2

Add testOffloadStatusNoState (COPY10) which sends OFFLOAD_STATUS with
a fabricated stateid and verifies the server returns
NFS4ERR_BAD_STATEID.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_copy.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/nfs4.1/server41tests/st_copy.py b/nfs4.1/server41tests/st_copy.py
index 6be3c70ccfab..bec92e8d86b2 100644
--- a/nfs4.1/server41tests/st_copy.py
+++ b/nfs4.1/server41tests/st_copy.py
@@ -287,3 +287,16 @@ def testCopyBadDestStateid(t, env):
     res = _do_copy(sess, src_fh, src_stateid, dst_fh, _bad_stateid(),
                    count=4, synchronous=1)
     check(res, NFS4ERR_BAD_STATEID, msg="COPY with bad dest stateid")
+
+def testOffloadStatusNoState(t, env):
+    """OFFLOAD_STATUS with a fabricated stateid should fail
+
+    FLAGS: copy
+    CODE: COPY10
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    src_fh, _stateid = _create_and_open(sess, env.testname(t))
+
+    ops = [op.putfh(src_fh), op.offload_status(_bad_stateid())]
+    res = sess.compound(ops)
+    check(res, NFS4ERR_BAD_STATEID, msg="OFFLOAD_STATUS with bad stateid")

-- 
2.55.0


