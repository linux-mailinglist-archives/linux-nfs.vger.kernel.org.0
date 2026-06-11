Return-Path: <linux-nfs+bounces-22501-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uyFWJJEUK2pE2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22501-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:03:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C541674EAF
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:03:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jELbhejk;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22501-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22501-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D25FE31675EB
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC0B39184A;
	Thu, 11 Jun 2026 20:01:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02D38F653;
	Thu, 11 Jun 2026 20:01:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208074; cv=none; b=KlMSFYeIn6nNBZdpIKsPGvij22aXUUf49KBtJUInF5UImmXnh4llM7RdSMwdjlcTYLNieGOv+Cbn4Zb/1V3i5wnyM+vpqNJY/nPTvAvFNeijJmpKJVafDHq8y/a6suuI7ix7PTuDsVBIMDUgI8li6BGY6j7ZuY5kBENGYuipYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208074; c=relaxed/simple;
	bh=+rxPQ6oAE0p/Q4OGK6v8FZlkDtkd3fH11hIexGCDKI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcl3pbv13ee93JPwb3ET31geEtpOlrrX9vsvKz25IGSAlgpe71l/C1e66RPf5i85EuhFOt1n4FODx3cHeBJLJDkcGhqePENvcJzEtqzDX4qUiQnsNKvBOewKJc72GwPtiQjgve+5bKVWHwdVPdec+NR36Q5nwROChRX5ShAONwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jELbhejk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0FA1F00A3E;
	Thu, 11 Jun 2026 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208073;
	bh=DnDZp+b6bsA0t2dC0iM15A3EwgkBFB7/zFfve8bdYNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jELbhejkuOatkbBHLeKX4GfWtqQY9ih23jGSreA8+xdBX+7iNrnKharkMy3bvkrDJ
	 bSOehEHOzx4FPETh0+971nyMxh/gGiNmYrthpUPkJH3YZgBlCYY8juM7mxse9GKK50
	 s6uBjXY/pDc8hzb7dq2kvVrmNhClKnfyejlzxtaiHaKNdZMN/6CFKGNCodjvNihlXm
	 ovGfYLB5CBQWR8ilG5XB+GJPlv2nyAfXs5q+AQZfSVgbOwFZ7d1yAVxGO/UB66W/Sr
	 kK0Df6UY1BtaUuBeRsT+JAQvE0bztyI/A0SOWlvgUWZmwBNQ/Fz1TeihBAlaZewtv3
	 2FwkPIBghSv2Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:50 -0400
Subject: [PATCH v2 07/21] nfsd: validate nseconds in TIME_DELEG decode
 paths
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-7-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+rxPQ6oAE0p/Q4OGK6v8FZlkDtkd3fH11hIexGCDKI4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP+UeEYyagFphfkjXi/l/unPqPsA3AFSkHSz
 fjhJh1BQC+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT/gAKCRAADmhBGVaC
 FWSzD/9Au53jORKthHQ9pVstjiKaujgyjGi7T3xzmR0WH/Zy8mIYA2HixbP2kIax6zH2leesH7v
 hszR5Z+F0yZkP9hyOTxSz2f4H6kJ6pkjWD5RX14S/a7KdL6TF2W7x14D9yGBF6coC0XKLrR8DKS
 uKSOLBAmQ3JpA9haFDe8xzi/tlG+hyXD5MJHxJgKd+W6ydCj8ePch6H55SiZIxB7QPKgKiGLucx
 utSAU4Kku1n9X/hb8NDasNQEhHOmUU8deL8uYPqh2Z3HzbJDPJSX2aHkAos/D0ClswmIrS3NTCL
 aioH9b+K6LuDL/XqhLqc71vA2pFYPC9II4O8y3NnNsVpM1EXCjkO7ZunJFXlMhh/C6Y6ZNiRYYx
 owBBUSl1dnlHrxSCQAg/h6NgA9eZWkmM638tNRbJ1n2AWrKm5CDOVQel4PJDcNnOXTwI9JM4YQV
 3o420zAnL6+wQ0gkGqWPWDah/9muZzW8VMve4UcF4Htmh8yyzNwy9E5ivYxiI6H2UCsqLNkBZgq
 oL/V2oeUMGzXkXEFsNtXQ9z1LWt7n1sf82TmUBN1StUKis2qfreAsLmxzqmABo+UigaOelpUUsv
 wP+TnDCs6LYwljRu+m1CdeCFYbHmUnxF7giDPCptoEuJtFd2Pk08dksbSZRdjq3FOhJ9v/Eae0i
 dxiC3rrCEIe0axA==
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
	TAGGED_FROM(0.00)[bounces-22501-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 0C541674EAF

The xdrgen-based TIME_DELEG_ACCESS and TIME_DELEG_MODIFY decode arms
store a raw uint32_t nseconds directly into tv_nsec without enforcing
nseconds < NSEC_PER_SEC. The legacy nfsd4_decode_nfstime4 has this
check but the TIME_DELEG paths do not. A malformed timespec can
propagate through notify_change() to disk.

Add range checks in both nfs4xdr.c (SETATTR path) and
nfs4callback.c (CB_GETATTR path).

Fixes: 6ae30d6eb26b ("nfsd: add support for delegated timestamps")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 4 ++++
 fs/nfsd/nfs4xdr.c      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1628bb9ef9dd..7c868afc329e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -108,6 +108,8 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 
 		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
 			return -EIO;
+		if (access.nseconds >= NSEC_PER_SEC)
+			return -EIO;
 		fattr->ncf_cb_atime.tv_sec = access.seconds;
 		fattr->ncf_cb_atime.tv_nsec = access.nseconds;
 
@@ -117,6 +119,8 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
 
 		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
 			return -EIO;
+		if (modify.nseconds >= NSEC_PER_SEC)
+			return -EIO;
 		fattr->ncf_cb_mtime.tv_sec = modify.seconds;
 		fattr->ncf_cb_mtime.tv_nsec = modify.nseconds;
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e4a51926910..056a8df3fd50 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -637,6 +637,8 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 
 		if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, &access))
 			return nfserr_bad_xdr;
+		if (access.nseconds >= NSEC_PER_SEC)
+			return nfserr_inval;
 		iattr->ia_atime.tv_sec = access.seconds;
 		iattr->ia_atime.tv_nsec = access.nseconds;
 		iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | ATTR_DELEG;
@@ -646,6 +648,8 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 
 		if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, &modify))
 			return nfserr_bad_xdr;
+		if (modify.nseconds >= NSEC_PER_SEC)
+			return nfserr_inval;
 		iattr->ia_mtime.tv_sec = modify.seconds;
 		iattr->ia_mtime.tv_nsec = modify.nseconds;
 		iattr->ia_ctime.tv_sec = modify.seconds;

-- 
2.54.0


