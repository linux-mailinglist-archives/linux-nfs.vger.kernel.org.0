Return-Path: <linux-nfs+bounces-3554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF68FBDC8
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 23:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3C42852D4
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D80514D6E4;
	Tue,  4 Jun 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXPFarra"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FF14D457;
	Tue,  4 Jun 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535297; cv=none; b=VgrQcsecanSRfvpXQSU6aY+XVH6ntB9MN/zdEpvvtachPsS6A1vSFDpYlrpQ9OHhU1XQIt/BNrkC5risHTeTNJpRmdAoQ1CXqAmUbg0BAaIaF+AqqanBUHH/dSB6ygN6r7chUIaXtLTPfBkDElWTN6x8Pxx9SvLpiXSbGvPfwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535297; c=relaxed/simple;
	bh=smICcs3nQ7Qjl4GeQETN5FWVfli3hNNvlp5QgM1lB1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVkxXILQYtH3jRnnvGfvlDZ3YR6nHVAzYEv01e5yFRAF2O9ZX86W6b+OsHglBBNUfK8bzQdGHqWmfrJWs4oMlCWszjoCwd+gVohtHZIaDF3QNNiU+noZ33i8c0K6e3kkwdlpfdcbvVS9lqvpT3t0Jz8oGxzosbVn8U/EpOIZTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXPFarra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8DAC2BBFC;
	Tue,  4 Jun 2024 21:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717535296;
	bh=smICcs3nQ7Qjl4GeQETN5FWVfli3hNNvlp5QgM1lB1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LXPFarras8Z3AlcK9p6oJotHBi1MZkG7naQLeFlzubekjqVg8+kcKA5rTEFAd73jE
	 2dKnVwXy60xIQHVvHkm9sn6QpzgO4B2d0UDc90Jz6cnU18V88dcCJmcIhaG4pFR1LM
	 CU01I15s1T3LpjpccayLEAXzA6YGVcMQDl9yUR/mfU7iPA4faEX1MIXcCcB7IG8bUy
	 fqD52Mtg6EmIJzAkln9y9TQn2L30qo8vEXinIfOPnzbIkKhZGuh8UFmvWABHL78C7+
	 /AIl0SwOZ+L8AgHGqYQfJg3WhNCMpiNDCGCeUUr0diFpjospggQyTTiQJvrEk1VN6e
	 YfS34gqyOADmA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 04 Jun 2024 17:07:56 -0400
Subject: [PATCH 3/3] nfsd: allow passing in array of thread counts via
 netlink
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nfsd-next-v1-3-8df686ae61de@kernel.org>
References: <20240604-nfsd-next-v1-0-8df686ae61de@kernel.org>
In-Reply-To: <20240604-nfsd-next-v1-0-8df686ae61de@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=smICcs3nQ7Qjl4GeQETN5FWVfli3hNNvlp5QgM1lB1A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmX4I65iElhkbqt7azyrUZFfxAg2uurCdvxAAYk
 HShJFRvy2yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZl+COgAKCRAADmhBGVaC
 FdbFEACxVJZvjPhMxFD01p7PTrKSX0u7ugzuft5cJ55E/yHNGO51h8I/UD3OyBdUeeY+V6e8v74
 IKWcrJi648BKajyHm7wN4jB3VUw2LcNTHj9y2vPSRicZbi021ozxd2gs7OJs11eB/ldNVAkazvS
 KwlAIDv+x/7fAbDvGO9d4BVsW+YjA/srmfBoSRGfUMjrMKD2kx2PN3eMH/Kepd9Mr0rlJnHXYEh
 JUc1NpCrO2gXkHkNxkGd54r5IEDArMU4+tkd/E6TNlC5PDM+UtbcalW7E8sdQuzGm7gXb8zcWnh
 m7kaABXW+VgO1n1ZMSjXvkuVmAHa7NlEtTNtYiMomS1Z9CH5SNRg3vALFUJW5TxKFiIPreoVbw6
 DNNiBz59ILY7Zit5GpNgsxTuoXIBYTip8aChvuTW19uKxET9cIslAJJVIblr5Kagg2qxpvqbHv4
 HVPKTeUCkwRu8cH6NewWpIb3P4yQ7wJtLovcTvwfh3UETiVRdfq5Atp84MVfuHAp+/U8dmDWa6L
 DoEAO4NejBOfalYuR0/vPvXzgnnIBeMB419aVVzp+DQVD2u7ayzukYUlbZm3BvvKIsLigPyn8T8
 Fmtg/g71GWVWlv3mPhE2+/2RvPzX4iE5mFtQsguS94eKMlnRrTujAt8AmJ8mWexXLzjoMm5kvUH
 VoMz/xlnP8Dv7Gw==
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
 fs/nfsd/nfsctl.c | 33 +++++++++++++++++++++------------
 fs/nfsd/nfssvc.c | 12 +++++++++++-
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 121b866125d4..54b98e569740 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1673,7 +1673,8 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
  */
 int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	int nthreads = 0, count = 0, nrpools, ret = -EOPNOTSUPP, rem;
+	int *nthreads, count = 0, nrpools, ret = -EOPNOTSUPP;
+	int rem, i, total = 0;
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	const struct nlattr *attr;
@@ -1690,15 +1691,22 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
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
+			total += nthreads[i++] = nla_get_u32(attr);
+			if (i >= count)
+				break;
+		}
+	}
 
-	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_THREADS]);
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
 	    info->attrs[NFSD_A_SERVER_SCOPE]) {
@@ -1732,12 +1740,13 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
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
2.45.1


