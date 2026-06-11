Return-Path: <linux-nfs+bounces-22495-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HXEQOwsUK2of2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22495-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:01:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD2674E59
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:01:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U5lavhh5;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22495-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22495-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADD8F3034C5E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400B36F907;
	Thu, 11 Jun 2026 20:01:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEDB3672B8;
	Thu, 11 Jun 2026 20:01:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208068; cv=none; b=mQ0hYj5UOFVDtFapjKbn+QIlZ57AURSdRzjyDbLVWoRd2A5SkMtXoYyZxo+vBE9lyhKPYLyKI/JBV/zAm2MycnQSl13HtrOfX3mHI4RmWB2LXKiPSx/o76Itgnkf5PobKnrr6kNo8++zwSQPPGw36ehVuasbYwrPrFKiUa7+olU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208068; c=relaxed/simple;
	bh=0zVSMKuIenVnVpy2Q3C9APLyKF0iawqJthV9fr+HXKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAOI3M4N0iKF6fd+rcZ/EW6ksFWJ5sQLo+/aDplF6iq9wG1EqgaU6ZVSPuftzIpqcdvkm25OtP9Fk9rEqS5Q/8I92XCn78uNQwWl7AvioqYawvbzA4Hjm2s+vQw3z65ZquXYWuU9JJ8B65jBAcx82KIVUY6F7lByW+lST9N6nbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5lavhh5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5781F00A3E;
	Thu, 11 Jun 2026 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208067;
	bh=dGIYHSoSgcfqdopVWrafKZi9HKgDYhLdhUGzfdrh3FI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U5lavhh5/HY6xUOrgzbt2cMW8qUNdDyZ8YvRb5VhISh0lmkcz8xsv8HVDaYnAZLzl
	 t/OSESGK6PFZnf7lIsSr9pqrwb+ayLYCrcNOyjOx4uPJX9g5g46ecGIwCnJp5mAm3k
	 bTye0DDlbYoBtKu4k8WURKyWyYwgwwXbhMS1D43z6vIZgt0Oiyf/R681ImhPOf1so4
	 RwJSk27LfuYSpLLjkCjXqVuxunyG93FSLzWLiJu7gcjFHa8adiKSWZIauJvy3PEh/8
	 pvGA5+nKf9yjo1/ybRLoiyDf5k6dCKil1viyiVkIh7bmEFHlRaDgOiNP3zO/y9YGgB
	 oinibJ57Au4gA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:44 -0400
Subject: [PATCH v2 01/21] nfsd: clear opcnt on compound arg release to
 prevent OOB read
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-1-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0zVSMKuIenVnVpy2Q3C9APLyKF0iawqJthV9fr+HXKA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP8LVFL5jpFal3FmhHuLU/xb9qIKAbmCcZnb
 pP3jLWV5ZiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT/AAKCRAADmhBGVaC
 FfW9D/9YbhSNW8MMaonw6TKk0HpR3zaLl/H8bfT41GToMXITZwRP0lTEkC+g015SrXUEHFKVEID
 h09cWgodQOtNWTryYEJlaobGch8qVnJroyZHgKTxRJtGhB/txctjzTAf83yNpaig5rOUiNp7RSU
 m23Pywz6fMSsBaa7LmiB4UH/rbz/1/l3DtC5WQ26VMFS405yT/A1rfKPDIoCFjKGp1joYCL1O0h
 fXclncxN0P560jf+Z5ufVjM0t8QzZ0Qd6S0ig2w7sH9zbTwfGCyspneCQ+QuAfNRwz/5AZfqshW
 U7iXxmPyE2sYbq8+npzhAjr8BMGJQgrA76rnjxnBr5VSaMAkIvMumVT0FomjJ1gOjaUH2N8+685
 tR6ZDT3odz2CzYNJA1fzrMgu5eRnevzuINrTI8MfBGb6DeH9bWablOXpp0EbWzEYU48Rmg1P/of
 4+HzX6dpKxG3B3AEkXZs4/JbOYLBltyExR2pJ9R+2Ryigueg4XomrqKOAlm3oz8I/swbWOqwvmB
 FOwxFraDYJmVbixcxdciGF7AndWAellyzjTIoni9P8abkdpf3AyLDDnV82rrD+olVZ8NUOYh7Lv
 C+ToiWYxHYSRgMnKXGuPoHONtP7tew+YTmgcCGH3vYX5DtBqmuhdKZmWUJx1oNawEGgimxJ7+QG
 ik5At50ik2cVJXg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22495-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4DD2674E59

nfsd4_release_compoundargs() resets args->ops to the inline iops[8]
array when the dynamically-allocated ops buffer is freed, but leaves
args->opcnt at its original value (which can be up to 200 for NFSv4.1+
compounds).

If rq_status_counter is stuck at an odd value (which can happen when
nfsd_dispatch() hits an error path after setting it odd), the RPC
status dumpit handler reads min(opcnt, 16) entries from args->ops[].
Since iops only has 8 elements and is the last field in struct
nfsd4_compoundargs, reading indices 8-15 accesses adjacent slab memory
and leaks it to userspace via netlink.

Zero opcnt unconditionally in nfsd4_release_compoundargs() so stale
compound metadata is never exposed through the status interface.

Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b9037d99b564..1e4a51926910 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -6440,6 +6440,7 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 		args->ops = args->iops;
 		kvfree_rcu_mightsleep(old_ops);
 	}
+	args->opcnt = 0;
 	while (args->to_free) {
 		struct svcxdr_tmpbuf *tb = args->to_free;
 		args->to_free = tb->next;

-- 
2.54.0


