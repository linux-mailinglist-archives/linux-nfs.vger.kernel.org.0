Return-Path: <linux-nfs+bounces-22107-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOmQMzjkGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22107-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EBC60CF19
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 398E83042E45
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A613CB2DB;
	Sat, 30 May 2026 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1G9OUoK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445E3CAA57;
	Sat, 30 May 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147187; cv=none; b=mujNjxj38vH4SK7B5yhFQJfOpi0Oax7i62g2OcnV9G/rjmg2nAZG1cBDLGnlB25BKZkQpxn1Zur3GzkJgZxYM//ou5xviUQWEaCR24/gNRoJ5oMaxWsMdDU9VG/ztuqhsuUa1oUvUCRlpZMLD/5ShL+eOQxawmnNXsslubp5W4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147187; c=relaxed/simple;
	bh=fnkW/YE5vOVVkFeC+zpucTPVdK+0fy6HvVg8/P9y9po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sreiVmT1xAe9nioEoj7tkrKtZcLbmtEpO4PLFBkXg6dOHNkgyqlqcJCj+OL6fgUeQqDNAzk6WslnaUDvYxozuiTQwl8m/1DyinjwR2iSntEeRdhSY5FrTTCdzerkArX2hsdWeGo+y1OECQZ28VkcWgxoA1aAk5j9I9UeA2/Dcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1G9OUoK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7AE1F00899;
	Sat, 30 May 2026 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147186;
	bh=r/xRLR89cQUHFz9b7QBpSXvBCkBRIyacUAUlW9fTv/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z1G9OUoKycD/gyXGAzayuOUS8+yKiLJDUUIKl/KIuxL2Yo/v+9uFsTldYI4fKn/pP
	 JZZF7Es4bv0IXuuFVAx2LNhrLFqarc/fGm9liKO3ZwqH7/QV7RzoVffVTk2dVvfnd2
	 W4sUfN8GPLFM729ZK97vtWxlgO+wID9oFAP3QysVBDZ2sJt1K201o8Zm2SCpKax/er
	 TBgpmZFbZs8TvqoheD7bjNV9K//5KwMqZvJxu1nB3F1RL3XF4JRXJDrHJJYGSOGEcc
	 d/c48w7s889WlUWDZjM3nq4a4AhhloQ3wB70VNlNgr35Gk54MHV4IzAh3eYNHnBzpP
	 WrvSZCB+sK8Kw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:25 -0400
Subject: [PATCH v2 9/9] nfsd: validate symlink target length in NFSv4
 CREATE
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-nfsd-fixes-v2-9-f27e8eb4d974@kernel.org>
References: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
In-Reply-To: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fnkW/YE5vOVVkFeC+zpucTPVdK+0fy6HvVg8/P9y9po=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPiZpLiwa1VA/lErd8L5bmtV//43VMPKATsg
 9iQnFhQMhGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj4gAKCRAADmhBGVaC
 FQQbD/9U1CfVfTjJv7yI/KGYbHo/kArWN+nBpDNvPTivIK0qRJMSwH/Eca2pZa9oCE1OlragC3r
 3eVCCg0+SmrvRXPGc2Xx8kQGfAlPQYTv2z/7Aj30oUnlHTSBaNYeCcA/daAfA/TTabCbh7jSAdU
 UlvN20E/fzkxjY2r9HQCtRItHE/1BH4JbuBbApg8OZ8sNRg54gHI5o6xAwRzV7yJ6GzyeGU5zxb
 QLEavZvKPi4SwOEhLzpEyoF3wEvfIAfQ++Dr7q3WpLChSwj/Zod/mlw7YLpMZZkamDd+i7q55cO
 ZMuffe6bzrid3YzDhChH3Yp6WzvfLFdgLb3GJqdXIq2ugewNyEpmuz6cgecVCpHpLsaxA53DBXD
 7DKTi9AOn7aLciDjwaBiTKsrZW0JLEAriB+4d6WdnVQGmVLmDeGztYZEQeDZfJpikRgTmKxYamF
 JUowse8s0t4VqtftT1qxF4b9a6MLHboVdV068KiYnnfxEr/RkLmrD20t2/7BFTEJzGeCXp+zQBT
 Ydc/3M9ipzKH68wGLgLe7Ens+Ho6C6Kztj0DBeCvmTpNFEFVts0lch1yo5yhLifbU43oh+Edzyf
 L+36De3yoeJtPs/rH46R7Xk8SsPg/JjwRcyDjh+0zmbTJzl06gvY5aA9qugvKZhokcaRPHBxJan
 FDhVxR4AU9RpMUQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22107-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 96EBC60CF19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_decode_create() accepts an unbounded cr_datalen from the wire for
NF4LNK symlink targets, allowing a client to force a kmalloc of up to
the RPC-max size (~1 MiB) per COMPOUND op that persists until compound
teardown.  The VFS rejects oversized targets with ENAMETOOLONG, but the
allocation has already occurred.

Reject cr_datalen == 0 early with nfserr_inval and
cr_datalen >= PATH_MAX with nfserr_nametoolong to bound the
allocation.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 508f6986842f..a5cfce95d2d7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -964,6 +964,10 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	case NF4LNK:
 		if (xdr_stream_decode_u32(argp->xdr, &create->cr_datalen) < 0)
 			return nfserr_bad_xdr;
+		if (create->cr_datalen == 0)
+			return nfserr_inval;
+		if (create->cr_datalen > NFS4_MAXPATHLEN)
+			return nfserr_nametoolong;
 		p = xdr_inline_decode(argp->xdr, create->cr_datalen);
 		if (!p)
 			return nfserr_bad_xdr;

-- 
2.54.0


