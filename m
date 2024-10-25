Return-Path: <linux-nfs+bounces-7506-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A639B1191
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 23:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF06FB2112D
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70E18BB90;
	Fri, 25 Oct 2024 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LvFV05bh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6776217F26;
	Fri, 25 Oct 2024 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729891259; cv=none; b=oyJJPxONKdZd4/kRk7gr9iFNAhyETUFrprUMDGR/igmD7MqK0FYCB1cJJAPojN96Kui8x1V1RxN6mj3+1HzfzGXOF44j+1k3GcUTDmsUVWWCvsRI3oFC5XPR/P2cNLN0Wolksf2hF/RO0Nv+1DALuooD2LrIyjkkQuFkYHf4FEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729891259; c=relaxed/simple;
	bh=57vOctAD49NrQhDt8l1YUqfvpP3ziCUAVIMrtEA3ITs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5G/hk2aomggqEneVTE7iB0V7VNtWpdtUDWBmTc4tFlsUnzmXCvzfJ6zB7D/w5JcCxBt/7+1uB2/5YIwagFSUriLayoSOs+Eng4ZfQRsXEL4JFv6FmdYCT5iomVHf8JnjS5u8Ejx6F5iMIXUs7FhTeL/HczouVJaSvnEIGREqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LvFV05bh; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729891257; x=1761427257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xJucfPW8gqHovBbo1lxqZGoM9KaBpI/dnGHVCNGQC/4=;
  b=LvFV05bhi3bGFq3ndil5rgPVZym2MWuDAoGfyBfNd0TxU7F7IPcH7eQH
   eBF2YkQgqaBg7IF3i9L0QN41fDIfk2xMBBvnVfgtHTzTyU2+plNYytF3n
   NLzUK4/LyQfNsRml+dNriT7Ptyn0ppZHtlckfHHo+JoWHL1huFheuD3Oj
   4=;
X-IronPort-AV: E=Sophos;i="6.11,233,1725321600"; 
   d="scan'208";a="242466256"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 21:20:52 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:36367]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.37:2525] with esmtp (Farcaster)
 id dc60af94-3e76-4c67-b1bf-1a0cea511b81; Fri, 25 Oct 2024 21:20:51 +0000 (UTC)
X-Farcaster-Flow-ID: dc60af94-3e76-4c67-b1bf-1a0cea511b81
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 25 Oct 2024 21:20:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.64.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 25 Oct 2024 21:20:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <liujian56@huawei.com>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <linux-nfs@vger.kernel.org>,
	<neilb@suse.de>, <netdev@vger.kernel.org>, <okorniev@redhat.com>,
	<pabeni@redhat.com>, <tom@talpey.com>, <trondmy@hammerspace.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
Date: Fri, 25 Oct 2024 14:20:38 -0700
Message-ID: <20241025212038.31584-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <d340cd68-f08b-41e6-9202-a13225c744a9@huawei.com>
References: <d340cd68-f08b-41e6-9202-a13225c744a9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "liujian (CE)" <liujian56@huawei.com>
Date: Fri, 25 Oct 2024 11:32:52 +0800
> >>> If not, then what prevents it from happening?
> >> The socket created by the userspace program obtains the reference
> >> counting of the namespace, but the kernel socket does not.
> >>
> >> There's some discussion here:
> >> https://lore.kernel.org/all/CANn89iJE5anTbyLJ0TdGAqGsE+GichY3YzQECjNUVMz=G3bcQg@mail.gmail.com/
> > OK... So then it looks to me as if NFS, SMB, AFS, and any other
> > networked filesystem that can be started from inside a container is
> > going to need to do the same thing that rds appears to be doing.

FWIW, recently we saw a similar UAF on CIFS.


> >
> > Should there perhaps be a helper function in the networking layer for
> > this?
> 
> There should be no such helper function at present, right?.
> 
> If get net's reference to fix this problem, the following test is 
> performed. There's nothing wrong with this case. I don't know if there's 
> anything else to consider.
> 
> I don't have any other ideas other than these two methods. Do you have 
> any suggestions on this problem? @Eric @Jakub ... @All

The netns lifetime should be managed by the upper layer rather than
the networking layer.  If the netns is already dead, the upper layer
must discard the net pointer anyway.

I suggest checking maybe_get_net() in NFS, CIFS, etc and then calling
__sock_create() with kern 0.


> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index b75bc534c1b3..58216da3b62c 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -255,6 +255,7 @@ int __sock_create(struct net *net, int family, int 
> type, int proto,
>                    struct socket **res, int kern);
>   int sock_create(int family, int type, int proto, struct socket **res);
>   int sock_create_kern(struct net *net, int family, int type, int proto, 
> struct socket **res);
> +int sock_create_kern_getnet(struct net *net, int family, int type, int 
> proto, struct socket **res);
>   int sock_create_lite(int family, int type, int proto, struct socket 
> **res);
>   struct socket *sock_alloc(void);
>   void sock_release(struct socket *sock);
> diff --git a/net/socket.c b/net/socket.c
> index 042451f01c65..e64a02445b1a 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1651,6 +1651,34 @@ int sock_create_kern(struct net *net, int family, 
> int type, int protocol, struct
>   }
>   EXPORT_SYMBOL(sock_create_kern);
> 
> +int sock_create_kern_getnet(struct net *net, int family, int type, int 
> proto, struct socket **res)
> +{
> +       struct sock *sk;
> +       int ret;
> +
> +       if (!maybe_get_net(net))
> +               return -EINVAL;
> +
> +       ret = sock_create_kern(net, family, type, proto, res);
> +       if (ret < 0) {
> +               put_net(net);
> +               return ret;
> +       }
> +
> +       sk = (*res)->sk;
> +       lock_sock(sk);
> +       /* Update ns_tracker to current stack trace and refcounted 
> tracker */
> +       __netns_tracker_free(net, &sk->ns_tracker, false);
> +
> +       sk->sk_net_refcnt = 1;
> +       netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
> +       sock_inuse_add(net, 1);
> +       release_sock(sk);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(sock_create_kern_getnet);
> +
>   static struct socket *__sys_socket_create(int family, int type, int 
> protocol)
>   {
>          struct socket *sock;
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 825ec5357691..31dc291446fb 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1526,7 +1526,10 @@ static struct svc_xprt *svc_create_socket(struct 
> svc_serv *serv,
>                  return ERR_PTR(-EINVAL);
>          }
> 
> -       error = __sock_create(net, family, type, protocol, &sock, 1);
> +       if (protocol == IPPROTO_TCP)
> +               error = sock_create_kern_getnet(net, family, type, 
> protocol, &sock);
> +       else
> +               error = sock_create_kern(net, family, type, protocol, 
> &sock);
>          if (error < 0)
>                  return ERR_PTR(error);
> 
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 0e1691316f42..d2304010daeb 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1922,7 +1922,10 @@ static struct socket *xs_create_sock(struct 
> rpc_xprt *xprt,
>          struct socket *sock;
>          int err;
> 
> -       err = __sock_create(xprt->xprt_net, family, type, protocol, 
> &sock, 1);
> +       if (protocol == IPPROTO_TCP)
> +               err = sock_create_kern_getnet(xprt->xprt_net, family, 
> type, protocol, &sock);
> +       else
> +               err = sock_create_kern(xprt->xprt_net, family, type, 
> protocol, &sock);
>          if (err < 0) {
>                  dprintk("RPC:       can't create %d transport socket 
> (%d).\n",
>                                  protocol, -err);

