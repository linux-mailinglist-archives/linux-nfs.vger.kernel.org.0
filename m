Return-Path: <linux-nfs+bounces-8855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4B9FEBE3
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 01:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6CA161E9E
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 00:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108964A;
	Tue, 31 Dec 2024 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJVq+nFD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0605FC0B
	for <linux-nfs@vger.kernel.org>; Tue, 31 Dec 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735604954; cv=none; b=HcWh+ytUXGsG9ptsrd3LB0yru4ZcGSNQtExAi9tVPohRw4jujBK9u/7gPPaAA7tBPsPH7txbuoavXyZB3eTwJ7+pOg114bZ9XSjby0RhK826FQ48d5Jq6Hg+qKM4tbFmGbY1wdUIefPhy4oplSqUd95ol7VCzmXy9azVmQNqM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735604954; c=relaxed/simple;
	bh=2TNh56EU58bkLWikRL7pv/3nKn+wP3Luw8Yfa5uOFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ib46jxUYhU0cKIkKdRwWScAzo6irNjj9Dl0+EqKjOT/xcKueF6UtjeoD7ZO/cpxaNAaRB7EKCHZDAPAllHVU8PuLmZq3MxeLv2m9lVVMENLWuFRr0BpNWW+fbtzBigD47sWXchyW6sQ6wA4SjS+UTrsIvNvhTwo++wKnd2YUFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJVq+nFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0396C4CED4;
	Tue, 31 Dec 2024 00:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735604953;
	bh=2TNh56EU58bkLWikRL7pv/3nKn+wP3Luw8Yfa5uOFQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJVq+nFDPfEG7W3Lbewkoud94AwOZcVwpYDMs7MvqosOG7hgp5VMk1plCxIggyP0T
	 NQi20qQteijDPcIaGZ7K+CjF0ErQMjy+AiWFPaNhtqDCHI024NLfj6RFBYDLQiFu4L
	 V47yT3qpPXOI/R3WNQzk5g/cJ95+i2P/7vIStFdGKBkWMWahoVJ3qnu6q3SLvdK+sn
	 pcGIQ4FFHMP8oGkPH0yy+o5IOgULzZmNXE3WvfKwD8ffqqDbzGcomxyABAKwvXnkU0
	 G2Eun5wmQmuXnVhE9fXbIDU8lzEKxXcpfwB8j+90uwntaWVmNF4P0uH9IxZtBdCiKH
	 hCVLB96F/T7cQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	j.david.lists@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 8/9] NFSD: Insulate nfsd4_encode_secinfo() from page boundaries in the encode buffer
Date: Mon, 30 Dec 2024 19:28:59 -0500
Message-ID: <20241231002901.12725-9-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241231002901.12725-1-cel@kernel.org>
References: <20241231002901.12725-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

There's no guarantee that the pointer returned from
xdr_reserve_space() will still point to the correct reserved space
in the encode buffer after one or more intervening calls to
xdr_reserve_space(). It just happens to work with the current
implementation of xdr_reserve_space().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a8b99e4796c9..348cd13f9012 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4642,13 +4642,13 @@ nfsd4_encode_secinfo4(struct xdr_stream *xdr, rpc_authflavor_t pf,
 }
 
 static __be32
-nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
+nfsd4_encode_SECINFO4resok(struct xdr_stream *xdr, struct svc_export *exp)
 {
 	u32 i, nflavs, supported;
 	struct exp_flavor_info *flavs;
 	struct exp_flavor_info def_flavs[2];
-	__be32 *flavorsp;
-	__be32 status;
+	unsigned int count_offset;
+	__be32 status, wire_count;
 
 	if (exp->ex_nflavors) {
 		flavs = exp->ex_flavors;
@@ -4670,8 +4670,8 @@ nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 		}
 	}
 
-	flavorsp = xdr_reserve_space(xdr, XDR_UNIT);
-	if (!flavorsp)
+	count_offset = xdr_stream_pos(xdr);
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT)))
 		return nfserr_resource;
 
 	for (i = 0, supported = 0; i < nflavs; i++) {
@@ -4681,7 +4681,9 @@ nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 			return status;
 	}
 
-	*flavorsp = cpu_to_be32(supported);
+	wire_count = cpu_to_be32(supported);
+	write_bytes_to_xdr_buf(xdr->buf, count_offset, &wire_count,
+			       XDR_UNIT);
 	return 0;
 }
 
@@ -4692,7 +4694,7 @@ nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_secinfo *secinfo = &u->secinfo;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_do_encode_secinfo(xdr, secinfo->si_exp);
+	return nfsd4_encode_SECINFO4resok(xdr, secinfo->si_exp);
 }
 
 static __be32
@@ -4702,7 +4704,7 @@ nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_secinfo_no_name *secinfo = &u->secinfo_no_name;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_do_encode_secinfo(xdr, secinfo->sin_exp);
+	return nfsd4_encode_SECINFO4resok(xdr, secinfo->sin_exp);
 }
 
 static __be32
-- 
2.47.0


