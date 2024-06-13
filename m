Return-Path: <linux-nfs+bounces-3785-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 676C0907B91
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 20:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEE01F26152
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E96C1553BC;
	Thu, 13 Jun 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtL/XjB2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D8015534F;
	Thu, 13 Jun 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303686; cv=none; b=fl8lNegfFZDzK36EHnVTmqDWntBqQVPqDoe/6SbMWD7Y8rEXHb6si/3hpoYT+xnY402gjTNtdpnWjXTVYP3AZn6SYGIBd7TbXDANXFlmk7e0z94AtHl/5GNHugb1LXEOf9v2WqXAnrfdYvaRe1BlDsSGw+oGZR3P9UynVYGM7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303686; c=relaxed/simple;
	bh=YDURFbnijazgcN8VD4DI4iq+yEb5LyI+bfN3po4d1eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tawwfGlNrA/MU1tBnjFxffUuMDBpzU93Cr9KCiKPsJ4Nq/u19HFadFMLdFNQ6FSAzw5vI9fExtDqJsotOb5H3IBCPGZ4hezL0VMFMyO+sIoZN8tvEcdCPAohJzbM30Q3mJMd2p5Bx5tLL54Zp5qWeu3iyhkmJ7wmWiMGo90C2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtL/XjB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1B1C4AF1C;
	Thu, 13 Jun 2024 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303685;
	bh=YDURFbnijazgcN8VD4DI4iq+yEb5LyI+bfN3po4d1eE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EtL/XjB2M/cKBZbVDuDraemb7CL8vJfRqmoJAmE8pstG2+6pACZaPzHVU5jpLwJzw
	 7Wpc5LjBHJ5TE1aRToVHnEhdbMTKJ4GJ7GRZoIf7s2F+IPtFUst45guIWqdv4oC0ki
	 TKx+ZJrBM15H9CzBqSh7H87OhkbtBlBW3Sa1fomvWjvcBAnKA/hPzZv606dEye+T8f
	 8Glc38zq9DVLteyHyMdnnXLBalc+5HLuC4j5wX0xVzsr64PfT5TNtWCIpv9qYGRCZT
	 34Y3TXw+MIdwkErUkFP/Rml2kJN+CgYYCuxUvUHiLH9ANamnV19t1hU0ui2hpnGeFH
	 QmxglpV1mbmTQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 14:34:32 -0400
Subject: [PATCH v3 3/5] nfsd: allow passing in array of thread counts via
 netlink
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsd-next-v3-3-3b51c3c2fc59@kernel.org>
References: <20240613-nfsd-next-v3-0-3b51c3c2fc59@kernel.org>
In-Reply-To: <20240613-nfsd-next-v3-0-3b51c3c2fc59@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3124; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YDURFbnijazgcN8VD4DI4iq+yEb5LyI+bfN3po4d1eE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmazu/0gFtlyoRt8a0xgZFOVewMJyPR1pCaPpBK
 VLuEIq4Jd2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZms7vwAKCRAADmhBGVaC
 FYQwEAC68zu5Hf7AlKKPLWD6Ey5g198JeeKVFRnVu5NhRzlkU7NH6NUICRE6pkBtTq9ReHy4JoO
 4HXtgux11rYseX3xtaFpNR43zUof2DhlzEO8yj1f8W4+fZjWk0ggJaizFl5Wud+byYUikhpEyRl
 T8DNvGtxr6T8xIB+xe8aQrQJK+jmdV/z2kOFMBZI8ZT9eIhRjap9DEd+z9hZ1s9dP4Uo1xcASbV
 cqTITAviXwWpoNeCoVH29qBVFk5M3a5id9pFOjuG12c4U5OPs6jSa8Wh1Y3Jez9kEvnmEj2TJBA
 /iks/T011QYCtvXZhflZTWo81y3OthIzJUbxV7YGryyWZ5AyKCAbGLHbPW9seaVb7fcImbxObZ+
 nq5AQguYhWIyP4n6qJYIOgh2YmfvJ7CwmXrXiuoF9HzNwpguoYFRV9lwd4wNV1ey6d0V7cgRvLx
 oRw7UKOLSNMKXGzwZWEb4NBRHkw8TEqQ2dPS20rPMIgyy60bOc+xTpHg3BXbxdIDdIdpjXpgkE5
 ji2YKeF+hdGKjCJ6vY1/FVChXiW3Awr2yxcYZ9MnXSJcniVkrnkYcHqyZQtuMiBMVwMhpzjr4GU
 iD3CKnGhEiUUOkbGQMSQWhAHl1qp5UbqhFfa4WR4DphJzX5vdrtGNPp6o2CfOR5gHfxj4q+jSjA
 goVa0lir2woZq9A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that nfsd_svc can handle an array of thread counts, fix up the
netlink threads interface to construct one from the netlink call
and pass it through so we can start a pooled server the same way we
would start a normal one.

Note that any unspecified values in the array are considered zeroes,
so it's possible to shut down a pooled server by passing in a short
array that has only zeros, or even an empty array.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 32 ++++++++++++++++++++------------
 fs/nfsd/nfssvc.c | 12 +++++++++++-
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c0d84a6e5416..dde42aad5582 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1671,7 +1671,7 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
  */
 int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	int nthreads = 0, count = 0, nrpools, ret = -EOPNOTSUPP, rem;
+	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	const struct nlattr *attr;
@@ -1688,15 +1688,22 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&nfsd_mutex);
 
-	nrpools = nfsd_nrpools(net);
-	if (nrpools && count > nrpools)
-		count = nrpools;
-
-	/* XXX: make this handle non-global pool-modes */
-	if (count > 1)
+	nrpools = max(count, nfsd_nrpools(net));
+	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
+	if (!nthreads) {
+		ret = -ENOMEM;
 		goto out_unlock;
+	}
+
+	i = 0;
+	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+		if (nla_type(attr) == NFSD_A_SERVER_THREADS) {
+			nthreads[i++] = nla_get_u32(attr);
+			if (i >= nrpools)
+				break;
+		}
+	}
 
-	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_THREADS]);
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
 	    info->attrs[NFSD_A_SERVER_SCOPE]) {
@@ -1730,12 +1737,13 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			scope = nla_data(attr);
 	}
 
-	ret = nfsd_svc(1, &nthreads, net, get_current_cred(), scope);
-
+	ret = nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
+	if (ret > 0)
+		ret = 0;
 out_unlock:
 	mutex_unlock(&nfsd_mutex);
-
-	return ret == nthreads ? 0 : ret;
+	kfree(nthreads);
+	return ret;
 }
 
 /**
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 2e47fd26c9b4..9edb4f7c4cc2 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -763,8 +763,18 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 					  &nn->nfsd_serv->sv_pools[i],
 					  nthreads[i]);
 		if (err)
-			break;
+			goto out;
 	}
+
+	/* Anything undefined in array is considered to be 0 */
+	for (i = n; i < nn->nfsd_serv->sv_nrpools; ++i) {
+		err = svc_set_num_threads(nn->nfsd_serv,
+					  &nn->nfsd_serv->sv_pools[i],
+					  0);
+		if (err)
+			goto out;
+	}
+out:
 	return err;
 }
 

-- 
2.45.2


