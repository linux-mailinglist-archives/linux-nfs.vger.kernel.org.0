Return-Path: <linux-nfs+bounces-3756-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE51906F75
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955C3287D92
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298E41474A6;
	Thu, 13 Jun 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDEFkK5X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193F146D7E;
	Thu, 13 Jun 2024 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281021; cv=none; b=W34s5ws0RcpNQinnsC+ghHLOdeBuj1Jq3JphjLbYRXYjHoRVQeOmhn88/DrNX/eXbtFc8uRDF12jSxiiuAJ1/38Ptl0NS6l53ONhfencs0+tYgjwoJvYARFyUWdsRRpjQkywpSJ8TP1XZ9Wd03zB6Viv+edXm2j6ezKwthsDxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281021; c=relaxed/simple;
	bh=F4yQVNCqHoax6TyvivF3/cRELpDg4rafpz6ZL4viPj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ioEIQbzpn/Odq8NiRBacgjrY8CYaVHanRu0mIydM3ubqfr1xzpV4rfe5+dNhGoHhhWBLqw/zBnVAwnz3+L5jP2iKYNpyzFvcGgrflXltgw66k2C85GRcpFpGmtNCi6TWgBAD0osjoqlwoh3JdOnB8swHv/qK3Yl9soLQ4oU6g/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDEFkK5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D96FC4AF1D;
	Thu, 13 Jun 2024 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718281020;
	bh=F4yQVNCqHoax6TyvivF3/cRELpDg4rafpz6ZL4viPj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mDEFkK5X8REFmA+XJdwQPtixQ6krj6SLc/CT1z8Bv/jq5W1pbFEpnlPfrssSLnOAv
	 7sNYIeVLfLUEtiO2E5qJzUAHwaPbm2iBF3AV/P/WZagfAHRnlF4byH220rs0ALPJdO
	 +ZHnF366sGdNfDzys7DtydIL8VjiyNZH8zsykDiZW6eJS+5emzKfa92lQrBTjTxS1q
	 BVV+fqxRRHOzEZHsSSLbU0VIy5alDwq9PvrfWF4c/7SdqGuvFtM49GI7lflu5+sOFr
	 wEIo0NtDorR7KQJh27gqdBpNiKxzCmzD8UC3l3mYLqDycvXroxyoslkesR7PedVcTN
	 GcipNaY8JhScQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 08:16:40 -0400
Subject: [PATCH v2 3/5] nfsd: allow passing in array of thread counts via
 netlink
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsd-next-v2-3-20bf690d65fb@kernel.org>
References: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
In-Reply-To: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
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
 h=from:subject:message-id; bh=F4yQVNCqHoax6TyvivF3/cRELpDg4rafpz6ZL4viPj8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmauM24ySExYsjOMXyCf5+X98995OYvDizbtzEW
 91A3ITsUcWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmrjNgAKCRAADmhBGVaC
 FXYFEACRr3tqAwGMcvRz4Iv2j/7wk/K35X6lQFM+XHzOqegPXgY/Q1E7XWAz+uf2n2xDOVz2DgW
 PU2cI5fqZtvvROlnSla7Y6F7xkZgZtqpjV7hayRFWtelSRL7IcvLmF/AJNC/75JujuOMuc2nEYM
 N9yVx5S4cJbJMgbcJQJ9kDwSpv1a152x9eSW4yC4uIaP5gYG6yVU1TugGlFV6DmRbI+ry9wExFj
 wTIjV5q4CFZ0XZOeKEyvwSfgnCNn6uOkBWcbXafEckAeoAHzgOBbLqC9x9l+BTQ68ZfXlIeiy5Q
 cH0cbvhXaNWBNEVYUnHJ23EhubUvGdvyGIPrZauxikwjmdCrDodNR9lulO2qnT1Tk6a6aWBNugS
 HEbL9OszHs7eleJRhyG8KsjaW//n6jpiBPhz9iuMAmvpbWUoYvtYHAy/jkiO1R2Or5Lbq+cmuT/
 HJZ4cJd/EHzrSSjlw6dkTrOq7r7QK5Xhxf9tiADU188HEdGX8cESM2ikPIyLVG+DF/PWq+bcXoT
 +YNvgahF2flKHzCpK5O1d60CqvZ8I3lmbT8x/zW0NsP+vDMJjxwme418b/j+czc2Q0KFVzF9RJN
 7ov946+/Eap3QsZTX1E9f6cOtJ5ZnsO9d3ZmTGCFTYLy/3asGbDEm9wILiU+6lCf7EjFtrniWJj
 TTAKHyxRtK9gi0A==
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
index 121b866125d4..d67057d5b858 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1673,7 +1673,7 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
  */
 int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	int nthreads = 0, count = 0, nrpools, ret = -EOPNOTSUPP, rem;
+	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	const struct nlattr *attr;
@@ -1690,15 +1690,22 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -1732,12 +1739,13 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
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
index 076f35dc17e4..6754cbc27c71 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -750,8 +750,18 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
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


