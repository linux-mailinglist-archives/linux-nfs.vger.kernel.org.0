Return-Path: <linux-nfs+bounces-22496-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6iXlHykUK2ot2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22496-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:01:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC15674E70
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:01:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=id8wcOA7;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22496-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22496-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF3B6313BA62
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1461385D7F;
	Thu, 11 Jun 2026 20:01:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5836D9FA;
	Thu, 11 Jun 2026 20:01:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208069; cv=none; b=S/OdEGzJfcMFl1Jz/AOOGy4fhEiqO+yj7hjJXBxueNeMZUXfpayqWPs1FOUclSmMN9O/cJOCrDzTSMDgdn4ItbBHstdX0TEHKjKjE2LG7xlaEW9w8dMQ+FyNG4it3RbLarHstctUK93JtPXCXK0LxElYG4oMIVfEJn4MQ4L1NpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208069; c=relaxed/simple;
	bh=CcG6OUziAhXqUtWJhTOO5mRk4TUJphs0RXifnfi5mtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJKh2u31J4tAtiiXityRnfD9PN2KL3o79sKJb4Kc0DH+2zjzKmtbkvlggS4InRzSAKSIwVAvChAR6wgdzIOx18uopPd/9hy/KSkmPnf3a1d9VenHF5+rA4yK2fBb/dDkmVQD5owpxh8dQfhtLlB30fOWtS9abpd4Ftb8SN0tsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id8wcOA7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D581F00A3A;
	Thu, 11 Jun 2026 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208068;
	bh=mAEqiA37affUSLRyClOuNhJ6p7CdJTTrjpVPa02VrCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=id8wcOA78nqa0YvKvw+pwKUyPpVGEry6C4ObzXHXoN/49vr7FIH/S5c7+BOK6wwvs
	 HtCnchKEO6kmkVabyp5NFO/EUJrgmA+lVtRGBZME5OzyhSZNVdb4LXz4V0ED7wWSE2
	 biKzF5r0ROKKNSbV0YIcSo32q7hflXWzv7KqyoiHfmbrNvFyNqaPXvThlOLTx7Fjtw
	 cIPpAI1jHR70olYYLZ26K7KoOhslHz66l73yVftpNqR3rvCusXdqGeEiZwPxwObIbU
	 NNtsz/7Pel6ueSUzt/BB6QqcISwontngiY9YnkRk2GDMlV8lxE7skkbLPJtSgASupl
	 5+Q20SEanlxxQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:45 -0400
Subject: [PATCH v2 02/21] nfsd: add missing read barrier to rpc_status_get
 dumpit seqcount retry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-2-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CcG6OUziAhXqUtWJhTOO5mRk4TUJphs0RXifnfi5mtM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP8EfYEkRICYfz9k+OJBE5sNBKEbqnlkSyOi
 ccCcj04T5+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT/AAKCRAADmhBGVaC
 FSArD/wKy51MVStKB8MUeMof8vO1Ug2VgFG/ei7vwtdFFbf5LEp14lTxMYU+430q+PyBjEDCaGp
 iMrUQKcwYi36rjRpQcbETnIBd9bPZH8+phZGC58i3w2xjUuzd0Gqcpaxc0CHdPOAFkX8xwK0BXg
 anQUsAa1Ie0UBY/Xdm7X7b+OTEi/0PGbDQoV87ieeCWxy1obPm8GHxSfhp5sASUr4myU3UV2fji
 8KKMm/E2XuEdZBIAA+rmli7rfrfrcW+p8d/Ux7OlT9STcj6qQ+0xlHg35ynlPVeShdSng1zvT2V
 TN++VA/uZuOVrSY20hM5nVCco5aX3s7cTgBXimVw5hupusAdhnMOOPBr8+7HYDs0Ms6M+b4TVIe
 1kWnhA1W4Yye7o4IX3isFCNT4ibqzUz/aiT1dpzBwPaR+k8HMgjIsuHZpZt76yudCI8haQwL/I4
 TueMhDI2/hEmCZU0GRhcKVUUt00FmlswNxzpNsNWflGiA4fhRpwXdEAEbWfETdjWaE04fGe5ujf
 CJlpB5PFbhj7K507LVvnlucEGhGoAxStAJ2GcBxYdRG+g2rgtul5OeVGOwkJUVD896pdIV1G+xx
 Zq+ys6NmR7R5Lj4/pPACPivNeYkVIGBt1ZbxazYy+SwurlmbZRVWwC6wsxTVfnsqH60cO/+yZqa
 WN6ZXu0gr3sA8sg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22496-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEC15674E70

The hand-rolled seqcount-like protocol in nfsd_nl_rpc_status_get_dumpit()
is missing a read memory barrier (smp_rmb) before its second counter
check.  The standard kernel read_seqcount_retry() includes smp_rmb()
to ensure that all data reads complete before the counter is re-checked.

Without this barrier, on weakly-ordered architectures (ARM, POWER),
the CPU may reorder field reads past the second counter check, making
the retry logic ineffective: it could observe a consistent counter pair
while reading fields that have been concurrently modified by the writer.

Add smp_rmb() before the second smp_load_acquire() to match the
barrier semantics of the standard seqcount read-side.

Fixes: ac18892ea3f7 ("NFSD: add rpc_status netlink support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c06d25c06f06..a4b5b1467fe2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1576,9 +1576,11 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 #endif /* CONFIG_NFSD_V4 */
 
 			/*
-			 * Acquire rq_status_counter before reporting the rqst
-			 * fields to the user.
+			 * Ensure all field reads complete before re-checking
+			 * the status counter. Pairs with the smp_store_release
+			 * in nfsd_dispatch to form a seq-lock like protocol.
 			 */
+			smp_rmb();
 			if (smp_load_acquire(&rqstp->rq_status_counter) !=
 			    status_counter)
 				continue;

-- 
2.54.0


