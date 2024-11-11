Return-Path: <linux-nfs+bounces-7882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648949C496E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 00:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216E128828C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 23:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C72158D8B;
	Mon, 11 Nov 2024 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oCd5qown"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B716224FD;
	Mon, 11 Nov 2024 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731366065; cv=none; b=lbqj2Gfr6SRj+JMxWXhfDHi+m7Sg6ajbd8HEjj4l8bsq/JiZO4JK+yzfzKyn8oC41DTdSPGtjsZd6vaQpOGogx0uSC8sJNuTmbGuHtmdIbD5ArEXhQhad6ylF1XzGNdbr9wNqO1r4q+LJKvfnlGF6ixTiX3J9cbEpzHNmsgzqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731366065; c=relaxed/simple;
	bh=qDZkqTdAT5YURqPfR8TG4+JsVxiTK/oTrV1y2mYdmBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8sMJxeXuV+L8zh6lAsWPtpWb6OEVBsCluybrDyR0OmpGN8rkn2ug1AMIvjSko5ardacOfXhF8BHX6vr91lObW20yN+sVceY8GFAPAt25/NrDrBnGlcgkKxvOx4sfnVB/jqyXmhiaEXeU8G8ipwzXAMy9ZYHoeRVoxEKaqsPwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oCd5qown; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731366063; x=1762902063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tptZj49XWdeiJ62/CwMkCF81VQcbIFs0dp/76ot3M/M=;
  b=oCd5qownUTZg94JM3zkIaScVTP5qtoquuJq0a8uNzTIjivcLnIxnIkyZ
   SgjHInmZef7iDblc89PkrYmMjl0XkKBTboJz8pEuo0RVO4NGwJ0S6kXlb
   pJyT0sFnXYf/LwI14BqtLPeKggfNz2zExjQBH1xr/GSjL27jFqyv042P5
   4=;
X-IronPort-AV: E=Sophos;i="6.12,146,1728950400"; 
   d="scan'208";a="673162477"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 23:00:59 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:28519]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.224:2525] with esmtp (Farcaster)
 id a35a08d3-1b23-45cb-a986-a3d7f5484b74; Mon, 11 Nov 2024 23:00:59 +0000 (UTC)
X-Farcaster-Flow-ID: a35a08d3-1b23-45cb-a986-a3d7f5484b74
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 23:00:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 11 Nov 2024 23:00:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <chuck.lever@oracle.com>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <davem@davemloft.net>,
	<ebiederm@xmission.com>, <edumazet@google.com>, <horms@kernel.org>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-nfs@vger.kernel.org>, <liujian56@huawei.com>, <neilb@suse.de>,
	<netdev@vger.kernel.org>, <okorniev@redhat.com>, <pabeni@redhat.com>,
	<tom@talpey.com>, <trondmy@kernel.org>
Subject: Re: [PATCH net v3] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
Date: Mon, 11 Nov 2024 15:00:52 -0800
Message-ID: <20241111230052.50577-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <ZzIejAHeZYTqOqeH@tissot.1015granger.net>
References: <ZzIejAHeZYTqOqeH@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Chuck Lever <chuck.lever@oracle.com>
Date: Mon, 11 Nov 2024 10:11:08 -0500
> > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > index 6f272013fd9b..d4330aaadc23 100644
> > --- a/net/sunrpc/svcsock.c
> > +++ b/net/sunrpc/svcsock.c
> > @@ -1551,6 +1551,10 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
> >  	newlen = error;
> >  
> >  	if (protocol == IPPROTO_TCP) {
> > +		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
> > +		sock->sk->sk_net_refcnt = 1;
> > +		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> > +		sock_inuse_add(net, 1);
> 
> I'm not as familiar with net tracking as perhaps I should be. Can
> you tell me where this reference count is released, or does it not
> need to be?

It's decremented when the socket is destroyed in __sk_free().


> 
> Does the net reference count get carried over to sockets created
> by accept() ?

Yes, sk_clone_lock() creates a child socket that inherits the
listener's sk->sk_net_refcnt, then the child will call get_net_track().

  tcp_create_openreq_child
    inet_csk_clone_lock
      sk_clone_lock

