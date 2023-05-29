Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B767E7148AA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 May 2023 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjE2Lh0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 May 2023 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjE2LhZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 May 2023 07:37:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4551B1
        for <linux-nfs@vger.kernel.org>; Mon, 29 May 2023 04:36:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f60b3f32b4so20122545e9.1
        for <linux-nfs@vger.kernel.org>; Mon, 29 May 2023 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685360162; x=1687952162;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/urOUHJPIKnLFNjMtmkB4N3xW2SaZY6xqW4O6ymt0M=;
        b=sDaMNLqT8/P/xE2h/h5b3Ms4tPQW6X8UsvXq3htM8liMtCXFc+p4MUGdc7d3I9w7/5
         QCAeSQUG60Vy3hREYdDUWHSZ4UXvcY9LE/hIox+0r6M17vTySYzSJ99Rs2A5gqNm8tYp
         Nu6A/rP72UgOev9zeLiwgfA7hgn/4IdW4+DJZ/W7XPQP2tpFDZK0ryQhx1F90aw7Zk0D
         g0EIum7MB1LKuV/6zmzU01DH0LqufOBjOj2E4s4sAu8eROeoICctuiEN4vmeOVflKBWi
         b7F3f22TYwul1dBW5el/87YzeE8+a6AUQ4AYMOzYVeNeB0ZhXxOQyTWcTSPqnSV8NEBg
         SynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685360162; x=1687952162;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/urOUHJPIKnLFNjMtmkB4N3xW2SaZY6xqW4O6ymt0M=;
        b=DRiBoYsxlHKRG5fRVStg9GSJjcgK0Qqijodot8J1J1Y8LOOhgHkdPmK7uvSXjUUbVQ
         eaz8xWjqr2ydN1+Z+jKjFWloW3tX0ANtXB7B/VIonx0zYEo7v8XrPfAT+fVSsc4zWBaw
         KmWzgnKxmu+z1dJtcrjEHUUwBOOx0fMW8JIBPNqrnFNBet+y1TVQmhSd6ANSec1sLxdh
         Wk2oBNqVmUqKV8G8aJ0yF1B4p5/6x3MmiMMDEUzD+mnas4yr9MR48LU9ueVfz3yGnur7
         PduXUDwVua0yYtoxIYR6Wymcc9EqNoO6eNwXS9hXw5p/psOtZL/SmJKI6IyHxPEsfdNj
         r6Cw==
X-Gm-Message-State: AC+VfDzqnou0P8BeNQufiGtPlBGtWJLjK3qfh0SM96rkKX3IE9s531X+
        z/ANrIciH8rgnYMxvkx/8VFSLg==
X-Google-Smtp-Source: ACHHUZ4Xp7Ie0fG+BLijqglWXvK8WUkmxqKCXYVeFoVJ6u31XJEKq+4EKbavvAfXtoy6UhJLxIITiQ==
X-Received: by 2002:a7b:cb98:0:b0:3f6:e42:8f93 with SMTP id m24-20020a7bcb98000000b003f60e428f93mr8682186wmi.11.1685360161884;
        Mon, 29 May 2023 04:36:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c00c500b003f0ad8d1c69sm17514712wmm.25.2023.05.29.04.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 04:35:59 -0700 (PDT)
Date:   Mon, 29 May 2023 14:35:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Stanislav Kinsbursky <skinsbursky@parallels.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nfsd: fix double fget() bug in __write_ports_addfd()
Message-ID: <9c90e813-c7fb-4c90-b52b-131481640a78@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The bug here is that you cannot rely on getting the same socket
from multiple calls to fget() because userspace can influence
that.  This is a kind of double fetch bug.

The fix is to delete the svc_alien_sock() function and insted do
the checking inside the svc_addsock() function.

Fixes: 3064639423c4 ("nfsd: check passed socket's net matches NFSd superblock's one")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Based on static analysis and untested.  This goes through the NFS tree. 
Inspired by CVE-2023-1838.

 include/linux/sunrpc/svcsock.h |  7 +++----
 fs/nfsd/nfsctl.c               |  7 +------
 net/sunrpc/svcsock.c           | 23 +++++------------------
 3 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index d16ae621782c..a7116048a4d4 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -61,10 +61,9 @@ int		svc_recv(struct svc_rqst *, long);
 void		svc_send(struct svc_rqst *rqstp);
 void		svc_drop(struct svc_rqst *);
 void		svc_sock_update_bufs(struct svc_serv *serv);
-bool		svc_alien_sock(struct net *net, int fd);
-int		svc_addsock(struct svc_serv *serv, const int fd,
-					char *name_return, const size_t len,
-					const struct cred *cred);
+int		svc_addsock(struct svc_serv *serv, struct net *net,
+			    const int fd, char *name_return, const size_t len,
+			    const struct cred *cred);
 void		svc_init_xprt_sock(void);
 void		svc_cleanup_xprt_sock(void);
 struct svc_xprt *svc_sock_create(struct svc_serv *serv, int prot);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e0e98b40a6e5..1489e0b703b4 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -698,16 +698,11 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 		return -EINVAL;
 	trace_nfsd_ctl_ports_addfd(net, fd);
 
-	if (svc_alien_sock(net, fd)) {
-		printk(KERN_ERR "%s: socket net is different to NFSd's one\n", __func__);
-		return -EINVAL;
-	}
-
 	err = nfsd_create_serv(net);
 	if (err != 0)
 		return err;
 
-	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
+	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
 	if (err >= 0 &&
 	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 46845cb6465d..e4184e40793c 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1474,22 +1474,6 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	return svsk;
 }
 
-bool svc_alien_sock(struct net *net, int fd)
-{
-	int err;
-	struct socket *sock = sockfd_lookup(fd, &err);
-	bool ret = false;
-
-	if (!sock)
-		goto out;
-	if (sock_net(sock->sk) != net)
-		ret = true;
-	sockfd_put(sock);
-out:
-	return ret;
-}
-EXPORT_SYMBOL_GPL(svc_alien_sock);
-
 /**
  * svc_addsock - add a listener socket to an RPC service
  * @serv: pointer to RPC service to which to add a new listener
@@ -1502,8 +1486,8 @@ EXPORT_SYMBOL_GPL(svc_alien_sock);
  * Name is terminated with '\n'.  On error, returns a negative errno
  * value.
  */
-int svc_addsock(struct svc_serv *serv, const int fd, char *name_return,
-		const size_t len, const struct cred *cred)
+int svc_addsock(struct svc_serv *serv, struct net *net, const int fd,
+		char *name_return, const size_t len, const struct cred *cred)
 {
 	int err = 0;
 	struct socket *so = sockfd_lookup(fd, &err);
@@ -1514,6 +1498,9 @@ int svc_addsock(struct svc_serv *serv, const int fd, char *name_return,
 
 	if (!so)
 		return err;
+	err = -EINVAL;
+	if (sock_net(so->sk) != net)
+		goto out;
 	err = -EAFNOSUPPORT;
 	if ((so->sk->sk_family != PF_INET) && (so->sk->sk_family != PF_INET6))
 		goto out;
-- 
2.39.2

