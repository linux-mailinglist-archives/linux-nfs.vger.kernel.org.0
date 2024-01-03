Return-Path: <linux-nfs+bounces-875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2DB822E7D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C131F2432D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87D4199BA;
	Wed,  3 Jan 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csjzmMWw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BBE199A7;
	Wed,  3 Jan 2024 13:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AFFC433C8;
	Wed,  3 Jan 2024 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704289019;
	bh=npHM9vpQDD0YaKHAFSgDUNbwthYUPEZd70TaRUZD2jQ=;
	h=From:Date:Subject:To:Cc:From;
	b=csjzmMWw0qt+2fLHY7xAR4JX6QOhTh3IxX3kFFvTwmtGmhvMfltIQ+XTYRBnSCcRO
	 7sjmonKV1KSJ4E10JPEcwqOtrhr/Kd7bPLnAPu/M8gP8sLO02YPOgtdE1x4UZdudWE
	 YARqtAKQco5uY9zW2Q/z5venTrN+EuRDmIQopzyJUu2GfTRHIA7PJLf2deAhkjD1QU
	 uTPxPxq/jEU4vk93wNWunDIHrQ319K0JEhw1JR0vOOuaiGTwox0ook5LJQuPgHw8zI
	 ic5BVS9NvshgO9TslBl99w1tma80vLADOXot8ViTrkIYlTOdvhelrwwhQVaR4IPIks
	 tI+DqBoDneRvg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 03 Jan 2024 08:36:52 -0500
Subject: [PATCH] nfsd: drop the nfsd_put helper
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-nfsd-fixes-v1-1-4f4f9d7edd0d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPNilWUC/x2LQQqAIBAAvyJ7bsFVCeor0SFyrb1YuBCB+Pek4
 zAzFZSLsMJsKhR+ROXKHWgwsJ9bPhgldgZnXbBkPeakEZO8rEiJaBrJh40I+nAX/kXvl7W1D7F
 5o4RcAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zhi Li <yieli@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4169; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=npHM9vpQDD0YaKHAFSgDUNbwthYUPEZd70TaRUZD2jQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBllWL6CHoxnJYzNSIeWmPmToKgjiAjfYI/MkcFT
 BJK2ZRv1TOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZZVi+gAKCRAADmhBGVaC
 FYe1D/9rHq1ta/c44yjQzKR2GMS8vTot5jLnLN0i9Cdu90C2/+zKupjLmiQFwxG3ghDw0BjAQB2
 35whAkNzJ18HRr4YmI+3mlUdLOvFVqBDvJmUkFSQoHlf4oj/55F8/jva4VLGxes3rXI+HvCP5c7
 k6tdb5sJqof5BxIDGJ2vG2ujJTI6y6PkvNmTNhVaM1I9/mkqO4AA7Wt7NILjgnrSi00WiowJKRn
 QQ4WHnr61h12WBneqsLM6CZWuEzVGbtoLaYiaDZ517uxDcC2yFAxctG4L+/Zg+njBUGwRNhVIIS
 b550o+JIpQw6tcLJCoA805rQK9ocXmyMR7UDS/ttaAXJBDSNyKEwe6Ru2jKPPLsZ6vag1SgPffz
 GvPMUsCrFffbRcZFfdEKK6/3VLvQHtUOAnVH/CSNzQ2D11L13ick2ILijFVIWo8EU8NT1yetEHe
 eWhgbWW73cghn7Om0wEH/+jk7DIg9k6/i9xR8cg7aZSxyJ49lIZwL4LXMncMbGanmMbKnaBBsri
 yLJcYy1PbqlS6+KPlQFuLrEJHgjmVjvbsQYhKm2GQpH8fCvN9RUZ1mdHUy2AEEhCw/5mi9iaCLz
 m9RSA/nPvFumVFMYS5UuysSAfjkyAH8lnnXw26lhRaTfh/FDB8jy0YEpfWV/1vV6tc7xBs0+QtX
 SDouGTUduiH80pQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

It's not safe to call nfsd_put once nfsd_last_thread has been called, as
that function will zero out the nn->nfsd_serv pointer.

Drop the nfsd_put helper altogether and open-code the svc_put in its
callers instead. That allows us to not be reliant on the value of that
pointer when handling an error.

Fixes: 2a501f55cd64 ("nfsd: call nfsd_last_thread() before final nfsd_put()")
Reported-by: Zhi Li <yieli@redhat.com>
Cc: NeilBrown <neilb@suse.de>
Signed-off-by: Jeffrey Layton <jlayton@redhat.com>
---
I know it's late, but it would be good to get this into v6.7 if
possible. I think it's fairly straightforward.
---
 fs/nfsd/nfsctl.c | 31 +++++++++++++++++--------------
 fs/nfsd/nfsd.h   |  7 -------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7cd513e59305..87fed75808ff 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -693,6 +693,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	char *mesg = buf;
 	int fd, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	err = get_int(&mesg, &fd);
 	if (err != 0 || fd < 0)
@@ -703,15 +704,15 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	if (err != 0)
 		return err;
 
-	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
+	serv = nn->nfsd_serv;
+	err = svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+	if (err < 0 && !serv->sv_nrthreads && !nn->keep_active)
 		nfsd_last_thread(net);
-	else if (err >= 0 &&
-		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+	else if (err >= 0 && !serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(serv);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return err;
 }
 
@@ -725,6 +726,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	struct svc_xprt *xprt;
 	int port, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	if (sscanf(buf, "%15s %5u", transport, &port) != 2)
 		return -EINVAL;
@@ -737,32 +739,33 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (err != 0)
 		return err;
 
-	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+	serv = nn->nfsd_serv;
+	err = svc_xprt_create(serv, transport, net,
 			      PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0)
 		goto out_err;
 
-	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+	err = svc_xprt_create(serv, transport, net,
 			      PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0 && err != -EAFNOSUPPORT)
 		goto out_close;
 
-	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+	if (!serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(serv);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return 0;
 out_close:
-	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
+	xprt = svc_find_xprt(serv, transport, net, PF_INET, port);
 	if (xprt != NULL) {
 		svc_xprt_close(xprt);
 		svc_xprt_put(xprt);
 	}
 out_err:
-	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+	if (!serv->sv_nrthreads && !nn->keep_active)
 		nfsd_last_thread(net);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return err;
 }
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 3286ffacbc56..9ed0e08d16c2 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -113,13 +113,6 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-static inline void nfsd_put(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	svc_put(nn->nfsd_serv);
-}
-
 bool		i_am_nfsd(void);
 
 struct nfsdfs_client {

---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240103-nfsd-fixes-1f1196134a11

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


