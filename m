Return-Path: <linux-nfs+bounces-21868-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIZqHz/TEWrvqwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21868-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:18:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05E5BFC47
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE173014290
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2513318ED2;
	Sat, 23 May 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBeY+Xvr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D622A4EE;
	Sat, 23 May 2026 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553062; cv=none; b=N9Fg6cQoQ0g5WJEOKnVsE9TSd3ZFR0+7Ep4tUM1efwRy61n24ZAuH/WOIVW9EFUfD/sGqua+th5dfy17Uh5swpWk/zCoRXRT/URKN9PJxwonIahNZ1ZcBmsKL2KnV6XoP8Tc8+N2rZRTlrrguEhcV9HAFIcS/b3KFKwmfQLQF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553062; c=relaxed/simple;
	bh=x1fAb7qeTFbcK02DygPDSguOWqiqmcaEiZa0YrbM1FE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqzMX3waDKua1/xN/0VIOCHQqcLIcGPngd5Lhlqfuzawx22LVrmlFMlW2I8pcotayz3nb9IBFBbWtW6NVB2vMRe4J8mNFw5NitVNZmfxQBs9zojnbYEcWUvtglWQPvOh5zfNuyHEng2+5pPi08qvq5TxTfs35mbZbJoUQurb7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBeY+Xvr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EFA1F00A3C;
	Sat, 23 May 2026 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779553061;
	bh=zZTLvdfyZfQnACyeuJT0lpOyJDhgRcx9Fe66L5RJbY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OBeY+XvrhOJYaUhkNeBmIHLWDd+cSwtN6ZS0VLPQZCAaNY3xaL1eaZ0ed/XnbXEI5
	 HQYWhyWeAdKJ6ew8cpKWGIaMg/MManr1uVKV0LaCc07WxsGxYZLPhNXA3EMJ6snGDG
	 0nYF3YfCwopktUjduHRNM26QTzKghP3qPlHHQMXHAAC5av8KlHKHV9jNfBK01uWPmN
	 iGWdQdPu/+OMZpIlPQhQlLnefFEzWmmIUU1/R2eMs9e0v5hYLP3klKWJucrYvKhvKG
	 Pm3nEShHj5RIcKI6+okSwx4xfoAqZcF93TDvx6Duq42JK+VlvoVgxOgnqyZAn9AzHJ
	 CEFJ24x3PSNkw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 23 May 2026 12:17:34 -0400
Subject: [PATCH 1/4] nfsd: check for FILEID_INVALID in setup_notify_fhandle
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dir-deleg-fixes-v1-1-142c884f85ce@kernel.org>
References: <20260523-dir-deleg-fixes-v1-0-142c884f85ce@kernel.org>
In-Reply-To: <20260523-dir-deleg-fixes-v1-0-142c884f85ce@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=x1fAb7qeTFbcK02DygPDSguOWqiqmcaEiZa0YrbM1FE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEdMiT1mfRWREbCBvqDOdSAm4D4x1q4JWqa85z
 HGMCtj+yA2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahHTIgAKCRAADmhBGVaC
 FW9gEACp5aiZtgjKdn6Hwmk8Zv67DVQqa+4ED8M6VNy9cbAM7ggPTBd7ywcbuZlatWxs3JgQouQ
 tdp/Zipx00jgLlt4DZ19a8kbx/EgkrNpwHHHtsxnXRtKJws182paLxMaIntww5sDq1b+JSFYC3w
 xJzYzdtWK5pnUDslxOaBNXkVlaHPZXRFeDjw12cQNZkmK3dF+uEiAztBonSkbhqUTulrfa6IIy5
 X80jG6saz944F6udUdumwKDtxqj2qAVMq39fDDIJUFaALvvfsByx9Vb1vyh1tA5Q7dIxwlVsF04
 7rqterqsQbmvVeqn9OlslrD71P3nBz1hj0lPXwoxCFdT3B3EQJjm4eVbla+iWiq1Bu9KPtlwuM8
 dwUcS2mku3AtrTBpCHLE3wBM5pMxl6PGJFC3weZJIIHpH4Wyc87KXIFQ36Wtu2ohoPP55i94adG
 Pfsr/ZcO574+6Bl5L3l5nPOD9HXk9w9PLK7PrMQQjc4QTjTpyvAgkR4lUmhIVQuOZXJf1Z/xrQW
 PAm8alM0x12HT9hbTxGvrrvSvDtJavcmxmqePqt8Jo67htOmbTT94wxC6qxRK/z2Kf/oMnSicNQ
 qbyl/301jvIv4tvgat40hYgrnuRtDpVM6gXqkZn75cYOL8pt2g+6zJFu1jt/auVMQ4LOyGBy+07
 LsOdfjIax8vaahw==
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
	TAGGED_FROM(0.00)[bounces-21868-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 1C05E5BFC47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

exportfs_encode_inode_fh() can return FILEID_INVALID (255) when the
buffer is too small. Since this is a positive value, the existing
check (fileid_type < 0) won't catch it. If this happens, maxsize will
have been updated to the required (larger) size, and fhp->fh_size
could overflow the fh_raw buffer, leading to an out-of-bounds read
when the filehandle is later encoded onto the wire.

Add a check for FILEID_INVALID alongside the existing negative return
check.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2143fb6d5e3f..2f8d26601581 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4209,7 +4209,7 @@ setup_notify_fhandle(struct dentry *dentry, struct nfs4_file *fi,
 	}
 
 	fileid_type = exportfs_encode_inode_fh(inode, fid, &maxsize, parent, flags);
-	if (fileid_type < 0)
+	if (fileid_type < 0 || fileid_type == FILEID_INVALID)
 		return false;
 
 	fhp->fh_fileid_type = fileid_type;

-- 
2.54.0


