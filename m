Return-Path: <linux-nfs+bounces-23207-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dqX1OSvvT2qSqgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23207-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:57:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F1F734A37
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:57:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Vig/Yz7O";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23207-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23207-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE1F3305EA54
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 18:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F298E3BFE34;
	Thu,  9 Jul 2026 18:47:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5593BB9F3;
	Thu,  9 Jul 2026 18:47:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622877; cv=none; b=rpNA7Ij1M4zFKiOgZDYlwxyK3q3MCcIKXPWQc219AoXsrA6YI+Kc4FkR2zVg1IJqdb3kW+6fB244SPja6X5aa6KX9tf2bKVXTzFeU53Jtts3SWTWDIBbXJ9fd2UkiAZAmdn9pJWQXZtzD97l35m0vC68emezyJiUzjCkTbZKHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622877; c=relaxed/simple;
	bh=rfKsUyMbAxU1oFUkwyRq1/50EfZPzhSWnRTiX3/XtXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TtNiku5XyaEqVWzejqyLkCOnrrd5QKJX7gb2CyKoOWv6aDk16OBrR1QhRq9Mg2bln0rgrOD1BFFzVosDIVXgiLF4DftQxFeRqB8sKHHO0cxwjf7+wXQuEvr8EzVJx85xRA4xyh8ou7bjets8shfJZWigChA8DQIHh/nk/97Y3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vig/Yz7O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33491F00A3F;
	Thu,  9 Jul 2026 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622876;
	bh=0WvleFZ1GxnBtowhUEbZuiqr/eM3Qx8KSK3wmd5xtrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vig/Yz7OnnGIDxcAIHVoTS6o8sQpu0lL4L0KCCvAz4jUtty4Y/4+OY12Qsagu9aIN
	 gdTkYhQXZ48OLdGj+YZvSiFw6rXDfjowcthwflMSp7YmFbe/XHV73q9MX7NpZlfkzz
	 i6WqS+EI9yfgU4viISuEKC3DDjGTJtGzL8/n/atIxZSLAB8GyejSvlScI/ZVQdJkvL
	 9hPAOm9I4Wib+mZXGT9CH7k/CRMSfE03Nj3ORRYfmh8CNXBBu1gzlVH4fbBciSYtBs
	 4ApQWDhUvHYAvcwzFIjFgKaPk5ZBgPhuRToalWPA3yaBt4GoEiJGG6lbenKe3AV65A
	 DUHkifgftXrxQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 14:47:42 -0400
Subject: [PATCH v2 05/10] nfsd: check client ownership when cancelling a
 copy-notify stateid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nfsd-testing-v2-5-0a1ba233bf87@kernel.org>
References: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
In-Reply-To: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rfKsUyMbAxU1oFUkwyRq1/50EfZPzhSWnRTiX3/XtXo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT+zVFgBBQxEJScuufkyI1Ko7OpfOCL1LJhdui
 tVmgOchRdCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/s1QAKCRAADmhBGVaC
 FVepD/4qTguoZV2Ns3fQkLoCiuON1A3Y/m5j55X2POoPD40OZClwTrR8yl3JRcr2zMirFY/LpOX
 otJBu+9RoMmFcwUQnyVlveOZ75pCMNkTF+I9mfD2iEuyfiui4JCmWLwUztgbc3rPQT/kVMx/ucB
 chnXjY9VBESupqtQRvruewPgLxr6bDJoKIzWaSu6x6vlZROsa+h+0Ph5jS/EjKdLBQRLZoCQvS6
 dKMBqkU2fYUHAInlhfhGIxSpBhy4SKJA2Y8A33hz9/Zq2ojeregWLDqnTKrC23a/rh9EtcgFOWy
 KZNXX3w+aC72lbXYnGoDxk6SWl1Wtbr1PRSf/j915JhjygIXZCPppMHIVnDp8FzWZIVmCn2U2HN
 be46XeFPG7/0oB0MdQ0blc7wYIkX9OpAH1sq/xLxaW69rH+tVBQtxnZ7AObavdLJtnZFPZqeTja
 u6TMfI66vq3zJwAy3hh4VI3faZ0j/Wf4fCvO1QvB9kMRK5IrNr0pXvEDLPvMhcln8IU34FUEOne
 M1Zh6+8hj5wlE6rmIXls0d1pBHAyWw+Fa8iYug4e+s4w1xO84C0vIHwfXflnlacQnIFfPPrXpht
 IAillN48KzpLr6ppPSEq97moSwWDClQiayBi9Wv7dXH0HR60nwIJr4XisgOQWgXi8yshnrgZE85
 qSawf28VdbbT/gQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23207-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54F1F734A37

On the OFFLOAD_CANCEL path (clp != NULL), manage_cpntf_state() freed the
target cpntf state without checking ownership. The lookup key
st->si_opaque.so_id is allocated cyclically (guessable) and the embedded
clientid is the fixed per-net nn->s2s_cp_cl_id, so any authenticated
NFSv4.2 client could cancel and free another client's copy-notify
stateid.

Compare the creating clientid recorded in state->cp_p_clid against the
requesting client's cl_clientid and return nfserr_bad_stateid on a
mismatch instead of freeing the entry.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1ef015cbc055..76c0e08711df 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7916,10 +7916,22 @@ __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 			state = NULL;
 			goto unlock;
 		}
-		if (!clp)
+		if (!clp) {
 			refcount_inc(&state->cp_stateid.cs_count);
-		else
+		} else if (memcmp(&clp->cl_clientid, &state->cp_p_clid,
+				  sizeof(clientid_t))) {
+			/*
+			 * OFFLOAD_CANCEL: only the client that created the
+			 * copy-notify stateid may cancel it. so_id values are
+			 * cyclic and guessable, so without this check any
+			 * authenticated client could free another client's
+			 * cpntf state.
+			 */
+			state = NULL;
+			goto unlock;
+		} else {
 			_free_cpntf_state_locked(nn, state);
+		}
 	}
 unlock:
 	spin_unlock(&nn->s2s_cp_lock);

-- 
2.55.0


