Return-Path: <linux-nfs+bounces-21869-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDpJLmrTEWrvqwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21869-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:18:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF5D5BFC57
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C3B83026749
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2E31E84A;
	Sat, 23 May 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQVtopwQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4C31691A;
	Sat, 23 May 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553064; cv=none; b=AhKgort9fGn9MxxukupO5XIidd74AyGiada7z6eJwLvBVugfLdMdH1VBDGexV8Y9jVaJbuKyMFC7ijnjoI5CL1s/T8NQ835O38I4id7Z2aT1+mKg+NjClZ4zyqZAF4fh0eBx1jmDnqzbbGE9USwE69x9BO6kKRIkXee1C8Y+VIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553064; c=relaxed/simple;
	bh=+w/vqGVSogzDzldgqsaBUVziSOav81+ONlsyh/zZvU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mW9XDHkSql3MKB+9Mucwnmm3sF8n9OK+Q7YfiCI7eNd8MbNA4KjQOVEoO65kumQF8p8yZjoGm+v/7Gl0shR6D8B/9P9LGUDksDAUpARfgOe4a+65elLlRXdtpQi8NvX1m+Amf4+kfI1BPK9INxLfQgLDNnDh/0G6SmJfZ5iHan0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQVtopwQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9231F00A3A;
	Sat, 23 May 2026 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779553062;
	bh=w5WUrg12vKsMgDhSRfjrdrxE4KdymXONHR28Df9OUFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SQVtopwQtiN+5CSbE8BJ4pJWc7STXyYKr5hE9jCgrmciRGpEztAO3YiZLAFVlzB36
	 dt2POlKIfElq+DaHH4SdEZ8S+RSxrJ4vWWXZrNNh2ywPdvBizjkC4NSeWAmWSs6TVg
	 nsdtfSUh+omqIXd3/Tl1hK/0AifGo+n2XZa09IK0d7FvnI0wv0O4RHhbMRVV0Q+k3+
	 HbB+Ep9bx1bV5GhWFijj1viQy8U55hxKTor9qVyFiFAeYfaYkJeUwgL8h9UoWpljkv
	 3l2BzsW4M/p8gACO9OWAviDbs4V+w7xjEkM1UxoVTXQfWcAQdxwn0yfc0Hrd7esE83
	 DcfAMHMbrylxw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 23 May 2026 12:17:35 -0400
Subject: [PATCH 2/4] nfsd: use empty string for directory name in
 NOTIFY4_CHANGE_DIR_ATTRS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dir-deleg-fixes-v1-2-142c884f85ce@kernel.org>
References: <20260523-dir-deleg-fixes-v1-0-142c884f85ce@kernel.org>
In-Reply-To: <20260523-dir-deleg-fixes-v1-0-142c884f85ce@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+w/vqGVSogzDzldgqsaBUVziSOav81+ONlsyh/zZvU0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEdMjl3UpaRtiHQS3dvMUISNpCcIau/fozDdNW
 GE6Mw4vr++JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahHTIwAKCRAADmhBGVaC
 FVTaD/sGCjs+vc4jP2z/+zmpF2tG/wZ1xAifyHbTD0Hb+fnlD/OG5F0xvamPe2Yvv2axA3yHUrX
 270jX5iEr0NlY9oARcZX0/lj7GgSVMUzqHDXWZh3XTGFtJGkmC/ssOY5k6V58WNCJ/6wthAm3Lq
 PCTzkxI4r1zzTkAoyaC2MingRSdbz24z4D4GUp1l2eCpIPE40OSjunV2VSCihaTVdank6HPj9Ec
 A8MdZ75wp/EJWnTjKzXNz8KR6tDB//Tpo5j68MTukm0i2KG1OhTNLdwiZKe4lzrNQjd/w/9yaUo
 V1CtIQ8cCZNOfTSPi7QV+5iu/LXJjLNNca4kPKabBlqG7PBkkQd+GeBe2a2YkORVIAB46L0wEIG
 83m9eMriUzuPrymILzpRkPAVkFE0RX9UkEJwUeN8Ot1WSHshm7VbOVFT9BlkCFmOniba+SExZam
 Zwesiw8F5zaZF3nccZmTWT7ZZ2yxxLGUVQqf6jQAUMWwjUpGkXprblPc8Eqkxj8HlvOuBWzQZuM
 omOxA+SE2Hm/IgAtMU37NsmIH32HYfz19o8IuXLCfjUkOjxbGPJFvMyg6BpIM7DRaA82cuCJrvP
 c4gnw648AwyPbZbB2i8fhnJpim8nm9Yj6GGl32Avg0jV5Eqj/80iDYGuP1QQzW0riuJfA06P8rD
 g7MwxMICA6xvnLQ==
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
	TAGGED_FROM(0.00)[bounces-21869-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3AF5D5BFC57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 8881 Section 10.4.3 specifies that for NOTIFY4_CHANGE_DIR_ATTRS
events, the ne_file component name must be a zero-length string. The
code was incorrectly using the directory's own dentry name, which
could leak the local namespace to the client and cause cache
confusion.

Pass an empty string and zero length instead, and remove the
now-unnecessary name_snapshot.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2f8d26601581..c6c50c376b23 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4404,17 +4404,15 @@ u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct nfs4_delegation
 {
 	struct dentry *dentry = nf->nf_file->f_path.dentry;
 	struct notify_attr4 na = { };
-	struct name_snapshot n;
 	bool ret;
 	u8 *p = NULL;
 
 	if (!(dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)))
 		return NULL;
 
-	take_dentry_name_snapshot(&n, dentry);
+	/* RFC 8881 s10.4.3: ne_file must be a zero-length string for dir attrs */
 	ret = nfsd4_setup_notify_entry4(&na.na_changed_entry, xdr,
-					dentry, dp, nf, (char *)n.name.name,
-					n.name.len);
+					dentry, dp, nf, "", 0);
 
 	/* Don't bother with the event if we're not encoding attrs */
 	if (ret && na.na_changed_entry.ne_attrs.attr_vals.len) {
@@ -4422,7 +4420,6 @@ u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct nfs4_delegation
 		if (!xdrgen_encode_notify_attr4(xdr, &na))
 			p = NULL;
 	}
-	release_dentry_name_snapshot(&n);
 	return p;
 }
 

-- 
2.54.0


