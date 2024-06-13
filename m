Return-Path: <linux-nfs+bounces-3755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF4C906F6E
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 14:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6FB1F21537
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A86146A6F;
	Thu, 13 Jun 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXqmqhmT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D78145FF6;
	Thu, 13 Jun 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281019; cv=none; b=DiaTUfQDggro4749f9OXB2hovlzaHxxFYP9JUqDEqRLlyKHR+HBpASrcoF+M/aOb14isT0QeFFF2PI7E8nTwRmcJvaqv/Z7lMyQeGSOKl27qpqw004IfFo18X0Jrh55JwTv3X0iMLZs3x/KnXZGqS7+WrWFsDstI2ztdDpTR0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281019; c=relaxed/simple;
	bh=BO3b54uN5KBEeup6eygbfA/ktVZYSlBfJA/gQCCFXIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlStLFP56Aku3X5QxqRroIiTa+RJdwhgjYVUuSef1eURn/cYkBJKC6By/efjS0o+rzmWXsk/x7R9lb6HKOYMEzxSWyQPec77KCi3uIyS6SquCstG35eBeCmi1nKcgJQRWUb51Ia3T6IwJGs0VoNAS8NTvAb1CmExFgt4m/iiWps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXqmqhmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2A6C2BBFC;
	Thu, 13 Jun 2024 12:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718281019;
	bh=BO3b54uN5KBEeup6eygbfA/ktVZYSlBfJA/gQCCFXIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JXqmqhmTL4mBJzxad+GpL2XBxTlVIlOCxUU/+baH/tNWpDK6KpfcEmLnED4EKODps
	 t/36g2PmN6Re4bmpEj0/LpOoVZLSJKq8x+u4scpe8/imKbbSC7zxa2OVRX/bBFZnKw
	 5CHwQudKgDzxwr7WvgU0GYIaDPyOrDXH5mDzrRXz1xKViUUPS6S7Kd9jCQ9wCzWt07
	 0x5xAPWIcUh+Cp5Cf6UaDy5OQchSlO/K5YwQwGU9ccQMZoquirdjLXBX+anPpkIt/2
	 KPkUuwZ85ZsmMoPEd8SPGxycoQnXNvR/uXGuoP7LkaeZFXw82ZsT4js32xBli0V7/S
	 5QsA4w57sP+FA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 08:16:39 -0400
Subject: [PATCH v2 2/5] nfsd: make nfsd_svc call nfsd_set_nrthreads
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsd-next-v2-2-20bf690d65fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3981; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BO3b54uN5KBEeup6eygbfA/ktVZYSlBfJA/gQCCFXIU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmauM1I0gM0Komuwlqjvrf4FN/BtFDUO9MjPQHk
 QSDQLefH1CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmrjNQAKCRAADmhBGVaC
 FZ5lD/9tAkikSuEKG9EEc3J4Rg9sQtA7E+ZD+IvlLdaLoOKZ2QG19ZRa2huovMo4Bg016KcwssT
 4EzBmbFzjsvP0S9bCs4RQRO3TA63tyk7wC+Wk+d3AhWUh7UrPGEIKGY7PyEBM7C3WhAwW1vpWuC
 7SJ7BCuw45R6vRh/C3D0OKQPUPw27+3RxqySBxL4zkHRliM3ACzLttyRJ9EcKbrGt7p3DKgNw70
 M1hVnRTLc5mafJkpwGhgLtJLV59Msqzcqg/v76PoITvlpQxKiZDHszc0O2RgguOU3uHz5iP5iG0
 y0fzUO7KJc3Umh19mzASIQ0yMlOG9BQpgSxmAyIHFPhrWsmal3yJx4BPUsr2pwedRXTWoxxYgHC
 WeNR3J8aAX13D9icdRVBPWCdNTvoWvQH0DeEByRMpqYCwX3W30jyF5QnoECLpJEvkdCvHua1k0P
 EnQkf3opGSkcXZXPhvlMwI4lTvoc1xF1O53b0G3oLYNatS45+RIpFIjtf5+zf7jStj8MLgUivJa
 XII7uq1edUPcdnJLmNOIvurZ9ZJZODPGP6Xk+YAjtezisRP2GMNQ9Hs8vIO17Tb/dUeHRiY+dpo
 1a3qAdO1DOVyQKPcEQsgej+g9dvdEYL5rRfyJOleNHJRovwRHMsSL12UXVw/6Riwy8DyNko1WaN
 6tZHkoir5yqGO3w==
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
2.45.2


