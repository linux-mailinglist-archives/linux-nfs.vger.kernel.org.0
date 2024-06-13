Return-Path: <linux-nfs+bounces-3784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BA907B8F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD7B283651
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5114F9ED;
	Thu, 13 Jun 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5jFvDJg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41A14F10C;
	Thu, 13 Jun 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303684; cv=none; b=A19mjH8hrXp6rNl2ATYMMJAru//ptubcRc3wTx5ERuzbalsIFAO69Zm/JjMIrXK7/0ujer7ug3MMBvZdrJgo8qQinS3SmQ0TRkCqN6BVI9BpCHI30cu8b/QUAQXNiagKQbgFziqNSq7PxbXEZee6dOe1ZMibvmMHUFOe3EsoATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303684; c=relaxed/simple;
	bh=dne48/WuerJI5cDYxx4gUTpls8+CI/TolliuHR/okWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/ce1CpUjB1K+gblnd5T37w5bbPGQ8mIz1jjGNLA/WrwVx+1kAnd+2NHJz5Y4NHyfGi2ps17P/2M/nnN9oaGsWKrN52SwtBklnz5nIMFuHp9I6ewxxHk4C0rYY01oznYip5I1uOXRpGRqw66OvIeG3OKMeD0ZYlmOhC7x12gMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5jFvDJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE42C2BBFC;
	Thu, 13 Jun 2024 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303684;
	bh=dne48/WuerJI5cDYxx4gUTpls8+CI/TolliuHR/okWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m5jFvDJg4ITfm6OlfyZL6K/YPjxAwqmONtVbz/QTXsIO/yEAK3OdvbrUQXWbNEcz0
	 G0GtEs92Do0lge4ZjEGxMsYB0e5qRZNvhn152feVreJH0hW+nO1y4YbtFH7xlW499t
	 8/DAXVtf0yoZfkl5tpAuiUWlIyZYjTm5dL6NIMO2gqEivkItszcDd7sLfObdKDY9xD
	 BCbFYQPk677YUpDTmZpXvP+2MvUBcZ6BR/7ZvUuT8zLTFcttsnN+3SFO1xGebEFEjx
	 Rf8iuzeauknQOh5CLh/+RQPZB+TisI/LpCcocohj6NSVfp/TrdrHYrRFFYaSu+KZvW
	 UccR24746swcg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 14:34:31 -0400
Subject: [PATCH v3 2/5] nfsd: make nfsd_svc take an array of thread counts
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsd-next-v3-2-3b51c3c2fc59@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5775; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dne48/WuerJI5cDYxx4gUTpls8+CI/TolliuHR/okWM=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGZrO7+iKmCHhCe4pRptwsD6IdAndP4Llz62DqD10ToMQcSsG
 IkCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJmazu/AAoJEAAOaEEZVoIV/5sQAKpX
 xHN5rsuERKUtlC9prSnDu2qMSixqkjskquUtCnoRUY8GOcrWENJbl7LviBi2PPE1hyFfH/ENUrM
 vuvicTl4WYrrzlBwPU3WiprOcABDXnAzULC7M57Hy8EXvZXmjKODEE4fd9n1j44qRMO9MD9IiZZ
 Urhet9TXfsmma04W5vAs6A04cuqyuKrbHT3WbYVi7UsmfnglGEcWsRAxtWLLB9dFoYls6DD4eGg
 ncFNnAGnPVRA25Je58xDfJlQXLn0x/DKLUX43x8xDGPVYVkyM7Z8GyBHvNaEqk0X37TNMPkyIVS
 E//Tmoznlr34b21Fx6Oi4TUX2VsM0JeITWdwvurwfEjahebQvmqBOgHLrVuE/KZX4l5Rf7Z2for
 fmRQ3NvVMn+5sGTKjhwiWv7b1bLC9E0KC5SET1dGYgvuh7G5BXco1ApsY35Ncr/849JoygxfWIb
 oJ+jJnsEwvq/+Z6lhgSfCKvRQyMucf68wit7tLySQZT9ZGWR6gTm1SaA7ELU36nkS9HJFJp7I6f
 uaTSumMMJtcTWTIoyu86h4OAOWojzA4+24Z0RnXfhBmwUFGE1fs/LG4/7SDHfi0alIcO7rMAlEO
 00bwZUz0ZoYbCa7H8JAUtv5uQ+uKdN8B8vd7NlonYdpw1Ryw3VSzLK/zyp545LhmHgLCU0f0Izz
 97XdW
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that the refcounting is fixed, rework nfsd_svc to use the same
thread setup as the pool_threads interface. Have it take an array of
thread counts instead of just a single value, and pass that from the
netlink threads set interface.  Since the new netlink interface doesn't
have the same restriction as pool_threads, move the guard against
shutting down all threads to write_pool_threads.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 12 ++++++++++--
 fs/nfsd/nfsd.h   |  3 ++-
 fs/nfsd/nfssvc.c | 47 ++++++++++++++++++++++++++---------------------
 3 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 202140df8f82..c0d84a6e5416 100644
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
@@ -481,6 +481,14 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 				goto out_free;
 			trace_nfsd_ctl_pool_threads(net, i, nthreads[i]);
 		}
+
+		/*
+		 * There must always be a thread in pool 0; the admin
+		 * can't shut down NFS completely using pool_threads.
+		 */
+		if (nthreads[0] == 0)
+			nthreads[0] = 1;
+
 		rv = nfsd_set_nrthreads(i, nthreads, net);
 		if (rv)
 			goto out_free;
@@ -1722,7 +1730,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
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
index cd9a6a1a9fc8..2e47fd26c9b4 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -710,6 +710,19 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 	return 0;
 }
 
+/**
+ * nfsd_set_nrthreads - set the number of running threads in the net's service
+ * @n: number of array members in @nthreads
+ * @nthreads: array of thread counts for each pool
+ * @net: network namespace to operate within
+ *
+ * This function alters the number of running threads for the given network
+ * namespace in each pool. If passed an array longer then the number of pools
+ * the extra pool settings are ignored. If passed an array shorter than the
+ * number of pools, the missing values are interpreted as 0's.
+ *
+ * Returns 0 on success or a negative errno on error.
+ */
 int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 {
 	int i = 0;
@@ -717,7 +730,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	int err = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	WARN_ON(!mutex_is_locked(&nfsd_mutex));
+	lockdep_assert_held(&nfsd_mutex);
 
 	if (nn->nfsd_serv == NULL || n <= 0)
 		return 0;
@@ -744,13 +757,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
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
@@ -762,13 +768,19 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	return err;
 }
 
-/*
- * Adjust the number of threads and return the new number of threads.
- * This is also the function that starts the server if necessary, if
- * this is the first time nrservs is nonzero.
+/**
+ * nfsd_svc: start up or shut down the nfsd server
+ * @n: number of array members in @nthreads
+ * @nthreads: array of thread counts for each pool
+ * @net: network namespace to operate within
+ * @cred: credentials to use for xprt creation
+ * @scope: server scope value (defaults to nodename)
+ *
+ * Adjust the number of threads in each pool and return the new
+ * total number of threads in the service.
  */
 int
-nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scope)
+nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const char *scope)
 {
 	int	error;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
@@ -778,13 +790,6 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 
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
 
@@ -796,7 +801,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 	error = nfsd_startup_net(net, cred);
 	if (error)
 		goto out_put;
-	error = svc_set_num_threads(serv, NULL, nrservs);
+	error = nfsd_set_nrthreads(n, nthreads, net);
 	if (error)
 		goto out_put;
 	error = serv->sv_nrthreads;

-- 
2.45.2


