Return-Path: <linux-nfs+bounces-3553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0008FBDC5
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 23:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0951C22F28
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858CF14D2AE;
	Tue,  4 Jun 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObK8qDcr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0514D2A7;
	Tue,  4 Jun 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535295; cv=none; b=JcanZryhfmWmlWLcsKgUDPKmgvAV7SdgT5VvFoS1ktT9lYCCu69aj9xDQ+UfLRN4szydlXrnmg3M8HAxKr8W8xBKM+VQUozv/8wiRegyCkQNmkLgfuo9OJ9ErPvPd3ydLyo/+NB/IreH7dDtWg0EuaEmNrigUqqviOQM3pFQsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535295; c=relaxed/simple;
	bh=4ejWVCwRkJi2nJTPzl+iwDP9GaQR2cMB6eHw2ik9W8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBbpTrJMIkiWZhS9iBTN6XjL77YnF+zjR2PKqQkebsAhV/2A/Gakm9Wp7Wd478/9VtOT2S1T8Vqnmv+HAbI/MvNoF5nAGKutmgA1U2gLWdhN6jv/d7A5Iwiq5t6Hygul8jRtdtdGO3flFAurIWexyTQUdMTHv60oceXn+YN3d6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObK8qDcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A87C4AF14;
	Tue,  4 Jun 2024 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717535295;
	bh=4ejWVCwRkJi2nJTPzl+iwDP9GaQR2cMB6eHw2ik9W8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ObK8qDcrWdyXVn6H3oK6tqOa3iKG3SQ6Iy+merZdT4LVnpna2cb2yphlQItPgaRcl
	 sin+oLuYF0/U9j+yOMZOLzYianzT/a1nzJqVqq9FZqx/hb274ZZEoj5RFxvfWEprYC
	 5/JMpCA6JaOTLcSYxnOt3SzmQJA4Vn9TXwIyNxAsuDvXQOPGYNdcGEV9JXAL2Zm+9D
	 4lWJBDbz2jRsR9xU5HxL7VTKEvCg2/pRWBlSvbiOXu1W3JeXGQwZVFIBK2fO+kjpiJ
	 2niETsenodZKSUZXEp0rW5XTVgpQZYdwM95rmQSJJFWr2gymRCChq4TyCWQW8+3lhQ
	 vIHJfmWDyr42A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 04 Jun 2024 17:07:55 -0400
Subject: [PATCH 2/3] nfsd: make nfsd_svc call nfsd_set_nrthreads
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nfsd-next-v1-2-8df686ae61de@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3981; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4ejWVCwRkJi2nJTPzl+iwDP9GaQR2cMB6eHw2ik9W8c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmX4I6DuBsDDSECRq+rIbwsbYBIBMU8RWrtUpva
 Hwu9Eb17f2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZl+COgAKCRAADmhBGVaC
 FeBKD/4nxsChtoKGX3jR2KqlJXXG9o6Vc5J7ISr9kzag2cZTifpZ7EVZi3MJmNhi0SjoIwgpEVu
 79KmyYrFKOo/KPrt6XZtdHrKDrUy9nasrqSQnkMv8VZU3fxhQJZ8RzFoBL69t3ppfYIjYZpDM24
 8qCLfIWV04JoT1fMioz7Tad3VMDND8kfkSvC+ilUtQ9/FJjWaCi0nzMv6bBFcsI2Tx0P8hV5u7Q
 shn+dO2wcYjMkllV/tWSN5j99Wl5B6u6dOCkc7KEILT67CCxvI4EKMf/H+0w1XHSv7WVuj2tWEY
 4SXLB02YgocTR8xTgdlt87ooM16TiHJjG3HgT6DM4Vpv6zBgzSvYqXi9hTD0qSGX+ni7Bcp3nfC
 a9nh+37v2bkMB2bPUS+usBNsXLbnmwr5ny/oq/zYFd70xIqh8IfxbGvRulJZCjEwqtirMmePS+8
 Gfj8yu5rmZCaIfNqk7qvYtsEuTgLA9kdeCCypIAbNo4AlZnbwn2E99yLXouZ5h3LctDMt7pflna
 QTeyJbx/MmIg6xqDKArXPq7r/+pCb8h/MhXGxR6nb6Y2XxUzPrx5GMsFMFTO3gmGQwIGsSLD4hw
 z6M4i5SPJ3kg8mFtNQjRhPD5GXiiuq3F5gWhxiLkBP3zU+8VbNa+VRYngzD+cXUozvZm0pPIur6
 eJXkhino9kXjMhw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that the refcounting is fixed, rework nfsd_svc to use the same
thread setup as the pool_threads interface. Since the new netlink
interface doesn't have the same restriction as pool_threads, move the
guard against shutting down all threads to write_pool_threads.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 14 ++++++++++++--
 fs/nfsd/nfsd.h   |  3 ++-
 fs/nfsd/nfssvc.c | 18 ++----------------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 202140df8f82..121b866125d4 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -406,7 +406,7 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 			return -EINVAL;
 		trace_nfsd_ctl_threads(net, newthreads);
 		mutex_lock(&nfsd_mutex);
-		rv = nfsd_svc(newthreads, net, file->f_cred, NULL);
+		rv = nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
 		mutex_unlock(&nfsd_mutex);
 		if (rv < 0)
 			return rv;
@@ -481,6 +481,16 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 				goto out_free;
 			trace_nfsd_ctl_pool_threads(net, i, nthreads[i]);
 		}
+
+		/*
+		 * There must always be a thread in pool 0; the admin
+		 * can't shut down NFS completely using pool_threads.
+		 *
+		 * FIXME: do we really need this?
+		 */
+		if (nthreads[0] == 0)
+			nthreads[0] = 1;
+
 		rv = nfsd_set_nrthreads(i, nthreads, net);
 		if (rv)
 			goto out_free;
@@ -1722,7 +1732,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			scope = nla_data(attr);
 	}
 
-	ret = nfsd_svc(nthreads, net, get_current_cred(), scope);
+	ret = nfsd_svc(1, &nthreads, net, get_current_cred(), scope);
 
 out_unlock:
 	mutex_unlock(&nfsd_mutex);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8f4f239d9f8a..cec8697b1cd6 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -103,7 +103,8 @@ bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
 /*
  * Function prototypes.
  */
-int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scope);
+int		nfsd_svc(int n, int *nservers, struct net *net,
+			 const struct cred *cred, const char *scope);
 int		nfsd_dispatch(struct svc_rqst *rqstp);
 
 int		nfsd_nrthreads(struct net *);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index cd9a6a1a9fc8..076f35dc17e4 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -744,13 +744,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		}
 	}
 
-	/*
-	 * There must always be a thread in pool 0; the admin
-	 * can't shut down NFS completely using pool_threads.
-	 */
-	if (nthreads[0] == 0)
-		nthreads[0] = 1;
-
 	/* apply the new numbers */
 	for (i = 0; i < n; i++) {
 		err = svc_set_num_threads(nn->nfsd_serv,
@@ -768,7 +761,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
  * this is the first time nrservs is nonzero.
  */
 int
-nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scope)
+nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const char *scope)
 {
 	int	error;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
@@ -778,13 +771,6 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 
 	dprintk("nfsd: creating service\n");
 
-	nrservs = max(nrservs, 0);
-	nrservs = min(nrservs, NFSD_MAXSERVS);
-	error = 0;
-
-	if (nrservs == 0 && nn->nfsd_serv == NULL)
-		goto out;
-
 	strscpy(nn->nfsd_name, scope ? scope : utsname()->nodename,
 		sizeof(nn->nfsd_name));
 
@@ -796,7 +782,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 	error = nfsd_startup_net(net, cred);
 	if (error)
 		goto out_put;
-	error = svc_set_num_threads(serv, NULL, nrservs);
+	error = nfsd_set_nrthreads(n, nthreads, net);
 	if (error)
 		goto out_put;
 	error = serv->sv_nrthreads;

-- 
2.45.1


