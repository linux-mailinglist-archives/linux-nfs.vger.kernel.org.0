Return-Path: <linux-nfs+bounces-20912-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCcSBvcn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20912-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295E413AAE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E04063106EC0
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECF202963;
	Thu, 16 Apr 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7HmSWZy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7A30FF1D
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363305; cv=none; b=WLXwP7OggoGH56Ydv/AmBnjRwdJZBqarmMmBuTGZPHYOxSe+NJ+Xp5P1tms6cd3VM/+8/6kp35Sp2c6A69jKnPnW9KBUkq79hC8UoUEJGMz4XhQs+4CqxN5NjcoYCVKtBrmLOYyjGCTYPfaeTy/ffp6Z4avuDkFQ5Q5gi9AlctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363305; c=relaxed/simple;
	bh=ebGfXNpszR7ByCP7KFxyH3vXu3YeeQv+SE8/h8GHw7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwV0qtfpy4+rdfH/yEU1cLh8tTKA1zcVMfAdL8ZA4xX4NtzKxkBjFnaCFZBQ9JcF4vTY70klYnrJyOGratySShKNoiw4YWyoLUQ2BIMBFsiHnx/KD3YswVAImrOJ/IYO7HMeGtPvM4IRZ3gCMy/3LNGOspUxZsebSy43hf7GEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7HmSWZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86984C2BCB5;
	Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363304;
	bh=ebGfXNpszR7ByCP7KFxyH3vXu3YeeQv+SE8/h8GHw7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G7HmSWZy58pe1GQURSMlGxKsef0MBIgWzi/0rACfcBKvMVT0hAsHSi/PzYT4N5kKI
	 hGNg2AOoGpQFdzH3xoq6OPw0Mc9OUa31NDCXgMDj5dlh0relicJk0DsHuMfHmK6zhB
	 i7LqhTyj7WLJSwCBhJNOUXTv1ZoWm0gI1cipPMuLryA6a+dHVEoXyaTlkryy0LzE4F
	 OKDrVxWw2bt3ecm0yZfFfMcMXFoucsyl5J7jI0eT/QibdkkE4N2+GRkfmM9KYxLruz
	 k6kktHg6q627UXMJlaU4hzQPZKHhFp4yfyN7Htf0QnhHeiwa27e6dGB8z2ab4XjShc
	 4SJdNqDfCv+Fw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:42 -0700
Subject: [PATCH pynfs v2 10/25] server41tests: test no notifications
 without GFLAG_EXTEND
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-10-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ebGfXNpszR7ByCP7KFxyH3vXu3YeeQv+SE8/h8GHw7E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScgWX4BCutLcseK9tnT+XctzWvmlcl1kxzmo
 hu9WJxNFHWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIAAKCRAADmhBGVaC
 FbA9D/9jOCMealsKZA8bGjkVmPp+xzz9rJS+SzfYISh7NjqhyFxZ8YOtd1n681qu+86S/PyIHE8
 4OBswqLpjC9IQfXFWkoV7yaUJ6YXYwUcoKHLgf+1GzEr0cxZPKMdTXSXsyaClxA8ftS8ssM6GSu
 UuiihM73auZuwmLW8wvZkNjpeh9psPpcAZnv/jk2MEdDzNpkqwjXr26tNKll2XL0su53m44IF5E
 hNdbBWsHReG0F66y58Vg+JoKQyjkuiZhpbAqrNlObtIcQNnmj5r10hPqpWfs6C6ORsfRvpbIvUK
 o+6nK+uSVlLNo4Lw1v9PN/UwDTbFYU/NniG8l9GDICqnP211aVS+12hps3/tHeo6SkLY9G6LUhK
 C3EEWb+FBQSxmc1R2tCsdMo42M21Rf6WwXXCDNSFNipD8P+DyWCKOavoQUWbwOQJAq3FnZX4tMo
 i3lXHeu0a4Oey3Iz3OoFM6GYbj+4tXqAoFIvbMeHm1/NVMlQtmB+RMzyweCmdp8CoPnw3TYc8YF
 9LJZr9WbnrY8N0mtnKEot6z+vVIvRhaOpYM919sdLX5QvdIvSE6QhxJYSN+RU5bw1Wfxiw4nB7u
 sxfzymkfS14KjnboZQSKAUzPFPxMiP4klsVebKh4Gv5I7Gm5Tt8kdSkUUVz294xqGALsIV78XOW
 4giLOBCq1QQZ0Iw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20912-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6295E413AAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Request a dir delegation with NOTIFY4_ADD_ENTRY but without
NOTIFY4_GFLAG_EXTEND. Verify the server issues a CB_RECALL
instead of CB_NOTIFY when a file is created.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 808323b89ffa..7d1e664a7923 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -267,3 +267,33 @@ def testDirDelegLinkRecall(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegNoGflag(t, env):
+    """Verify recall instead of notification without NOTIFY4_GFLAG_EXTEND
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG7
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [NOTIFY4_ADD_ENTRY], cb)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim) ]
+    slot = sess2.compound_async(open_op)
+    completed = cb.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)
+
+    if cb.got_notify:
+        fail("Got CB_NOTIFY without GFLAG_EXTEND")
+    if not cb.got_recall:
+        fail("Expected CB_RECALL without GFLAG_EXTEND, but didn't get one")

-- 
2.53.0


