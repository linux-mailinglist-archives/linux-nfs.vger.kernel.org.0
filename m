Return-Path: <linux-nfs+bounces-23209-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nObhBKnvT2q3qgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23209-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:59:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C099C734A9B
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:59:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lv5CaoBQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23209-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23209-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E02D230FDD26
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 18:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3593C4176;
	Thu,  9 Jul 2026 18:48:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7463C13EE;
	Thu,  9 Jul 2026 18:47:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622880; cv=none; b=aDlMo033Q7V8rPPvrfmL98lWs9HBkipdYvku1xSdzq7g9QjKVqiGaA/Cn8WY9KefjHkrOZuxbaz4RMZRW/IHFkTA8PuYrxNahFEh+Hu0Fnus3t1dhiGiG7+QwHlElxPO1MzfJSQFE0Q2eKQieVu4S2DEUAJ7R/CHeCg9FKDOfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622880; c=relaxed/simple;
	bh=NrNV+9Gvppv6pztzo3YDVONamNgR86hB+A5MfZjqCS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gp33x9YmYCZNRPGjAPF7HJLO0xaQNH2q7Cl15UI8eVPRLm5EJJkz4/kpp3jiIFeWCXWY/oS9ZKtbsBSxXwTHHprsTSqGrd3+f2zfbhhuo+72NPAdMGfLiYy1mj+aDRybWUpnsjim7eksjFUroHcWcNh9tPrNSZC9Z/7eKu/4jFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv5CaoBQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CDD1F00A3E;
	Thu,  9 Jul 2026 18:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622878;
	bh=U/h86rD3SFXFX5G+/C79Zn83QCIfNPT2NTgGfh+8Q/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lv5CaoBQr8wiQ0eq3rQg4yApwz6Hr00hvujeYmisPflKQWmQhU0qO6cZLXyL9kNV9
	 B46RihhWoj+7fPcYA3c5WQd4oOstGaRaUHuPp984k9+I/dwC/SWtUSO6xtlGhIadm7
	 ADFmplmjcpDgBeKouyo4M3NbfAs+SYJ39kclTANVEwjjDQ83Jx4WRpLP/0Vq3IMR0m
	 CLzBa8ijIZtV2Q+dfdCH9LNEQK7kf9ez8Njd5YfuZMtmWEpKeUsd43Gwc+vW+exGk0
	 5izFrgX5fig82QIKc+c1rsIOuGj54sdS7a6W1Q2BLaYGlcGC6V/PgrIPL3ZAKS9V5l
	 90jpDIK5DSLxg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 14:47:44 -0400
Subject: [PATCH v2 07/10] nfsd: return NFS4ERR_NOTSUPP for unsupported
 netloc4 types
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nfsd-testing-v2-7-0a1ba233bf87@kernel.org>
References: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
In-Reply-To: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NrNV+9Gvppv6pztzo3YDVONamNgR86hB+A5MfZjqCS8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT+zVC8D1qoPsdf2jomCKGYTYNXdSVftGoJUxY
 y3VRUVcQjuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/s1QAKCRAADmhBGVaC
 FQtjD/97bzGNgbBlbhJJQ7A1Zzm9zlw4mHx4Z6kJwqvD/+zHcZChoK5LTWqslG4qCY/uGufjHzM
 gtimHfLPE5tqinNbMqRdhpXjbDOBt/Tl3XfXOzuTgpOnuLK26LwDKC2L8sfM383dQLnZZjk0+IP
 r7C+HAsLapTQgkxvQJyyceclKjkrKdDuF2MZb/GutwpFzfcC53pfJVzgMoWYPTJFzHhyU+w0FhT
 QS9oGVEjiIbKY4OcxfiW0DFWhh+WVyjfCP5S79qg+FyihmlcOT/b210f5+EpIOZMZ0LzIrEBS0b
 b+3a69veqDQDKumn5b9/niN2PAClbNpG5eeGCkblZoNaFnuZ8LQPRE8j6tJJ7GIYca1dtowmqsq
 3yqfLmSk94XF/8PnjZA3FHlUJ9DMSY3mgzmTs4z2jZOyxmAxuwILSkMDCTR+75BNjSdm0SWYXd2
 RaiK3GUqm6BLHOEK8rjI47EOpRb1p2UbojTw2918//oHkD8BYXBWLKCICMUTNGeJBnM3vX6zytS
 /bR4uZ0ylzQ/x2awiKGfMhm6K25eKpxzaReflfKtCuiiXGHxbxnI4RZcMJ0EPxii/TUVh0gcsYt
 eSFbI6ebL88HT+YnvBFikl/VLXc7QH68kOefU5xpJ/jDuLDeVHfbkAaDZitKQ60kZaUkY3E5tdQ
 nfOyd0ZCLJx16vQ==
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
	TAGGED_FROM(0.00)[bounces-23209-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C099C734A9B

nfsd4_decode_nl4_server() handled only NL4_NETADDR and returned
nfserr_bad_xdr for NL4_NAME and NL4_URL. Those forms are well-formed XDR,
so BADXDR is misleading -- the request is unsupported, not malformed.

Decode and discard the utf8str_cis for NL4_NAME and NL4_URL to keep the
stream consistent, and return nfserr_notsupp. nfsd4_proc_compound() honors
a decode-time op->status, so the op fails without executing.

Fixes: 84e1b21d5ec4 ("NFSD add ca_source_server<> to COPY")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index aef48fb0fac2..23f50a947bf1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2123,6 +2123,7 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 {
 	struct nfs42_netaddr *naddr;
 	__be32 *p;
+	u32 str_len;
 
 	if (xdr_stream_decode_u32(argp->xdr, &ns->nl4_type) < 0)
 		return nfserr_bad_xdr;
@@ -2152,6 +2153,20 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 			return nfserr_bad_xdr;
 		memcpy(naddr->addr, p, naddr->addr_len);
 		break;
+	case NL4_NAME:
+	case NL4_URL:
+		/*
+		 * A netloc name or URL is well-formed XDR, but this server
+		 * only supports NL4_NETADDR.  Consume the utf8str_cis so the
+		 * stream stays aligned for any following operations, then
+		 * reject the operation with NFS4ERR_NOTSUPP rather than the
+		 * misleading NFS4ERR_BADXDR.
+		 */
+		if (xdr_stream_decode_u32(argp->xdr, &str_len) < 0)
+			return nfserr_bad_xdr;
+		if (!xdr_inline_decode(argp->xdr, str_len))
+			return nfserr_bad_xdr;
+		return nfserr_notsupp;
 	default:
 		return nfserr_bad_xdr;
 	}

-- 
2.55.0


