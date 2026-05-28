Return-Path: <linux-nfs+bounces-22053-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEdxCvy6GGoOmwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22053-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:00:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB0C5FAB31
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A988731B54BC
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288E367B62;
	Thu, 28 May 2026 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhoayxJY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF73644A4;
	Thu, 28 May 2026 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005333; cv=none; b=TpjlUy0njWRa9TzQsW8xwi5fYTLdXRTifusxRI+1RgVZrWYgpfHhS1AyWZIo4SYb8OLCmMqxyttY45IeDA2ou10AV4e2+KCdTy66Nv48HNepW+uPwZSaB8BsssDRE6d3jarG/4Y+ZBYpi5cs7hz/RKsTLINPwrYhjddvObzBn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005333; c=relaxed/simple;
	bh=bPsFkrpRs6hSWic3IFxHIrBk5YaT5H9qSNCV2LZkyhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvoAmdM2lm8Zj+ASmaIDlo3epwCujkuZmcj+P75CJHU9ZrBvBJ4zgDnkKL4QRRUuuAcKyXcUhe/W/0EUppBhxMgo8Ky6EKyFJQmcktPyBKhpCOZzS3G2zCh8mt192MkT3DoLWpk3UpJgWYZ8zOD+PTWS9+GU70hZSfZ1az9Jhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhoayxJY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35111F00A3C;
	Thu, 28 May 2026 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005330;
	bh=lPROnSbjSsIPlcTzwf+m0DG24gbchZyKCSA4wNPEkEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XhoayxJYWvjNzFDj1RrPUMhTIN3i6kF0kneyF9a0xUaQisE4/hQpcWY1uHg4rPOmu
	 sBrh06/Ho2TK7rfXimNWfm+lTzoaa+Z/GPHSlguOhAq4tiE9lIk4x7ianIY7eft+72
	 hYX73iTnprPPHU68rEY3+nt0dnmSLrb5ttZhTMA+hKnlHJdRRVV2hNRnqgo3/L8deK
	 NqR6L4QLmlEfwcQ3xn/5ocYUFULu9MQS44Cw/ljXXE55FkGiJ/RCqG2RzoTvOrGO/L
	 d9OwCosqJZ1+iCLiWjIYtzQlyNvTb9mQYudLW2MqoaekmtknEGEczjtYo3E24uoNAe
	 Bn1vgY9UFUURg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:14 -0400
Subject: [PATCH 03/10] nfsd: serialize nfsd4_end_grace() with atomic
 test-and-set
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-3-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3295; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=30FTxhGBSIxdJftpkF72BilKDBsAuHh6QS6iR1DtDR0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnKT1M8rClrrM6loRWP9OpKfa0KdwujZm9uO
 xMqS/z4JSSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5ygAKCRAADmhBGVaC
 FXTsD/9zgCjyhXFwqBjdcc/athv9WS3QVicB5KZD19rlPQtugNM7PjB85DdKmIzGaHFBaZJB6J/
 Jr2S0TUk43SqZJ+6Np9I/oTivI6pNfyp7s90m+bvzNdGjslCy3OlzNyo/VbOfgEfA/NqQD9Ht8U
 99I8KlJcfI0l1tgfPZyFsFBzukUL5xtww3LfnRyfkDz4y7kVwTruVaui6QvCpPEIwy1jFrPp8m2
 0Ydq+LjW/S0dPKXeB9BUdqeXGoGfdAngCiqi4SeLDjvEDRut2wlfxzEJL97k5MOHvtbdTMZUOSn
 Kd74dO9+GcJ5gqvOsFKAYhkujbUoHSwTvegxgeVRGbJA22jyu21rGoIYNAZpDNDfo4aqpOyGn4K
 5RjruGjPrBCb4tHZIVqih7uyqLKV2qa3aqEvnshQkFMzqE72yuhGuKZ/oZ7BxftfdV7bwVrKfQh
 +jbzuUow1jWKmzx1+280QcUUmzEJJXnBqGOCeB38KhYU0B2LBuLRovsbsmoOptejMZ/gu7DPxvV
 5f+R8Lk43TlvNI3B4aUbcLPi7A4OibY2tqIG2Loq2028GFZnx81xtdEfbHjSB32Luwe3pBphBLX
 KSJ8TbQitLA1+TDb+R60jki58gV9olDwb2o5yQagtc+PdwvElF4qUpiqUxqQXt2hMab15MtmvN4
 FuATUYISpzcSEbw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22053-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0BB0C5FAB31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd4_end_grace() guards its drain path with a plain bool:

    if (nn->grace_ended)
            return;
    nn->grace_ended = true;

The read and the write are independent, and nothing in struct
nfsd_net serializes them.  At least two contexts can reach this
code with no lock held:

    laundromat path
      laundry_wq kworker
        nfs4_laundromat()
          nfsd4_end_grace()

    RECLAIM_COMPLETE path
      nfsd compound kthread
        nfsd4_reclaim_complete()
          inc_reclaim_complete()
            nfsd4_end_grace()

Both callers can observe grace_ended == false on different CPUs,
both store true, and both proceed into nfsd4_record_grace_done(),
which invokes the active client_tracking_ops->grace_done callback.
For tracking ops that drain reclaim_str_hashtbl (legacy_tracking_ops
via nfsd4_recdir_purge_old, and the cld v1+ ops via
nfsd4_cld_grace_done), grace_done calls nfs4_release_reclaim(),
which walks every bucket of reclaim_str_hashtbl with no lock and
calls nfs4_remove_reclaim_record() (list_del + kfree) on each
entry.  Two concurrent walkers corrupt the list and double-free
every nfs4_client_reclaim.  A concurrent nfsd4_find_reclaim_client()
iterating the same bucket reads through freed memory.

A third call site exists in nfs4_state_start_net() on the
skip_grace startup path, but it runs under nfsd_mutex before any
client has connected and before the laundromat's first delayed
work fires, so it cannot race with the two callers above.

Fix by replacing the read/write pair with try_cmpxchg() so exactly
one caller transitions grace_ended from false to true and proceeds
into the drain; the loser returns immediately.  bool supports
1-byte cmpxchg on all supported architectures, and no lock
ordering changes are needed.

Fixes: 362063a595be ("nfsd: keep a tally of RECLAIM_COMPLETE operations when using nfsdcld")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4state.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f4d12dbcf97b..dc4ac541436f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7022,12 +7022,23 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_end_grace(struct nfsd_net *nn)
 {
-	/* do nothing if grace period already ended */
-	if (nn->grace_ended)
+	bool expected = false;
+
+	/*
+	 * nfsd4_end_grace() can be entered concurrently from the
+	 * laundromat workqueue and from an nfsd compound thread
+	 * handling RECLAIM_COMPLETE.  Without serialization, both
+	 * callers can observe grace_ended==false and proceed into
+	 * nfsd4_record_grace_done().  For tracking ops whose
+	 * grace_done drains reclaim_str_hashtbl, that results in
+	 * list corruption and a double free of every
+	 * nfs4_client_reclaim entry.  Use an atomic test-and-set so
+	 * exactly one caller proceeds.
+	 */
+	if (!try_cmpxchg(&nn->grace_ended, &expected, true))
 		return;
 
 	trace_nfsd_grace_complete(nn);
-	nn->grace_ended = true;
 	/*
 	 * If the server goes down again right now, an NFSv4
 	 * client will still be allowed to reclaim after it comes back up,

-- 
2.54.0


