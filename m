Return-Path: <linux-nfs+bounces-5672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AEA95D940
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 00:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D5C284782
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1005F1C93A4;
	Fri, 23 Aug 2024 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGuTFlup"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17C1C8FDF;
	Fri, 23 Aug 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724452071; cv=none; b=EY9Gq/dm83Rhj9C9Sljf/PzdJupZA1FTVDNNm6Rpgz55SVmxdbqXOKVEcULSTRx5iI48BuQS4IHI/6FujWq8zdWLFZKLc5WZeSGb808OG02bXnYhgvlrK1NQPe/4LUqSYucv86zUVxPU5rcXwKB7Q9y5r5A85BnLUZVXB5QMGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724452071; c=relaxed/simple;
	bh=VaOIE8fAcxFiczViQtCEfu9n7BmxyyuHGJb1i2Aqdfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dK3DHokZSCZJYU2MPVR6WVdIQ4YCxAWULuMLFILDdLTrH1MLaYu4b2qsSq77hjLczR7ELQe9RaXQu/fYQnI9ucc9azcjwtg0JHX4JzbA/wi7iJi2nGbzgXCaYRRjKv0YoMxhSi+S5LNBggzydRJH1Xs/kd3qDPzef3UwS88UnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGuTFlup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C1DC4AF0F;
	Fri, 23 Aug 2024 22:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724452070;
	bh=VaOIE8fAcxFiczViQtCEfu9n7BmxyyuHGJb1i2Aqdfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nGuTFlupgrAsOVWzT/6ptT+SMthuouMfc+4QG/nUUJzueQhEH6bVjEXNg6eNqVeOp
	 LouPb04To0pGMUkPNWDV0RZM1Oz9QGd1IkJ/fIfiljWp7W90RJQjVdtITPmYoQhZWF
	 TeN/PSxDZ2+k6Jdc/9Rd0SnmZvVhVw3vkh+IKSbZy+oP7XofYrPf5d9pnCdZls4T2B
	 ZUQ57q+avlWaDJ60k0rzSfCEIX8xIz3QLKtxcXZPyjw7w+ZaRd8tCVGVEgBaImBE+t
	 3bDasLFMQ3HlLTrUkw1d9puF9mBi2GC6yEEg+mHAvDGaU4CR5aAEVt6s4qpX4OTq6+
	 UTD4AxVH9ZTXg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 23 Aug 2024 18:27:39 -0400
Subject: [PATCH 2/2] nfsd: fix potential UAF in nfsd4_cb_getattr_release
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-nfsd-fixes-v1-2-fc99aa16f6a0@kernel.org>
References: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
In-Reply-To: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VaOIE8fAcxFiczViQtCEfu9n7BmxyyuHGJb1i2Aqdfk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmyQzjFpG9bEY8TZ4FBmIcK5SjwoLJXW++RYY1L
 WMZqSEbQXKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZskM4wAKCRAADmhBGVaC
 Ff3LEACvewz1XG84JaG7EVxUdev3vyc44A353Cr00OuqQXMv2pTqnxyAW2ygOwNSH0Fai4zwXMr
 Dhu2RBCwSSGQ1IyIBKcXZnm3Bvdfv1rgsGDG/k+5azv4I+TMBHwqDCaJn8c1alNsCxmllk39QN+
 Vh4JQz5qmZ2u14iJfZXihs0spypMldkgIDQLwnCzEsmXMk0pDZ2kohnzxQ511aArJGnE1sgP7h4
 /6mOeqJiJmy6LgEJvQsBkHKdanFU2LHtvJWFH4LJzlkkiKK3u8v7CH7ChuPL0bHY3jitD/6gm1X
 HfThI81qTGDtCoOnB0Gyu8SxfQv0mlGR2CigRVxYHbQNkQP94xkk4fwDNWuhw4SueUc9m0hmh8w
 j3ECt/on/WNhLfcBntJpzr+Zxm4GbPaLIej1wO3KIwnD1VbPxfrRRgvo3DXiyKU0dxXeba7Cn/H
 4C1EqsxMt7FdVzRvYC1Ymyh5tHuww5ckAv7hYQ8cBIo8aK2dqpAKNMoPCdDQih8j86R+0WIzIXH
 sfCP6sOdhxjh5B3G2Je7/F2kIB8UD9J37Grs3IKasHBdv6Ikmd9okSxI8fAZt3m+nH9axjv8uP6
 dMOMmMCSa0WSrHGVZUU4k1iLctF8FktGMZOwydMufFnkNCo3/7VUqocM2jzwG5Jddel/vMEDdAQ
 y0gw4hDmoueOrzw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Once we drop the delegation reference, the fields embedded in it are no
longer safe to access. Do that last.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 19d39872be32..02d43f95146e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3078,9 +3078,9 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 	struct nfs4_delegation *dp =
 			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
 
-	nfs4_put_stid(&dp->dl_stid);
 	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
 	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
+	nfs4_put_stid(&dp->dl_stid);
 }
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {

-- 
2.46.0


