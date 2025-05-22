Return-Path: <linux-nfs+bounces-11867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741FAC11D0
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E33017A5FB
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04B17B506;
	Thu, 22 May 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cx0WBx2r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95117A2FC;
	Thu, 22 May 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933539; cv=none; b=MxNuR5vdjwrj3y9fV1fDVKMLQ0n0nQjkRiDUWN1Lu7wm0MJjFGiEJ3XSW16JYkZodB0KHhx/ISsAWz/JGyG0fD7Z+EWnOXxWCyKbfU7x4DIxf1rI0JnhHKmvaZCvykw4i+U9KtRDqWt8LMI7H5MVbO7v0/iksuDh/IBCxBcXsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933539; c=relaxed/simple;
	bh=mX71Fjsi5h5YpxMRmRhQaF13trpv/g/ePLAHMDd79Hg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wusd5KU5tk5YMKsuMVsGmZ1UDAWZpEUup4V8p8UOqrK4A0Oje+lkNuzqE5+1CVXqO+/W+umWW9LYtfe+QWo6uRd3tzzgG+aKL4oDbL5KDgysUwsibhxpekhnYlgPVXVP3SZAkzcDp5ZSreqdFhj8upww45NjkGVryv9/M5Ecr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cx0WBx2r; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747933538; x=1779469538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mwf+P23CSKd+lg3vtdZYz0g0GEFKW8pE4MrhtK1epSU=;
  b=Cx0WBx2r1EkmtVPBa5yBuxeB5DQNL1HUbuRjanu3WXYMfN7KLaekzyXA
   MQ6lp1vXYBVXIeHA0fu8fjsYef6gCWUIg5YXnPP5gsMImX6bbO7G5NQxl
   w5zOjnsiEBs38Zyc2IruJQf3aq7IYB/BM0Yb1BtzlZeHL3+ULRk5AdTHJ
   aCQD2HztiGAKSIx7iPKGKQ2rpC0/39GulkClUNB5mSb9A3aQYCn7W4YWy
   6teo1StVJ9YPhS1RmzGC4MgLAWoU24RFjq5Rcvh2CokBW5yPAZiUVWegb
   iKhuC+j6HLEGWY0mSZ7bh28H/OgOvt5uB70sGLnHH2y7OEF8DfTMGqS4Y
   A==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="96335492"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 17:05:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:2008]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.213:2525] with esmtp (Farcaster)
 id 4433f7e4-b50c-4174-ab14-8accf7c1ba1b; Thu, 22 May 2025 17:05:25 +0000 (UTC)
X-Farcaster-Flow-ID: 4433f7e4-b50c-4174-ab14-8accf7c1ba1b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 17:05:25 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 17:05:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <chuck.lever@oracle.com>
CC: <axboe@kernel.dk>, <davem@davemloft.net>, <edumazet@google.com>,
	<hch@lst.de>, <horms@kernel.org>, <jaka@linux.ibm.com>, <jlayton@kernel.org>,
	<kbusch@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <linux-nfs@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-rdma@vger.kernel.org>,
	<matttbe@kernel.org>, <mptcp@lists.linux.dev>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sfrench@samba.org>, <wenjia@linux.ibm.com>,
	<willemb@google.com>
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion except for net/rds/.
Date: Thu, 22 May 2025 10:04:48 -0700
Message-ID: <20250522170512.41751-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <44b6a9b5-6bd7-48f3-927d-3188cfd726f1@oracle.com>
References: <44b6a9b5-6bd7-48f3-927d-3188cfd726f1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 22 May 2025 12:38:03 -0400
> On 5/22/25 4:55 AM, Paolo Abeni wrote:
> > On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
> >> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
> >> count the netns of kernel sockets."), TCP kernel socket has caused
> >> many UAF.
> >>
> >> We have converted such sockets to hold netns refcnt, and we have
> >> the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.
> >>
> >>   __sock_create_kern(..., &sock);
> >>   sk_net_refcnt_upgrade(sock->sk);
> >>
> >> Let's drop the conversion and use sock_create_kern() instead.
> >>
> >> The changes for cifs, mptcp, nvme, and smc are straightforward.
> >>
> >> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> >> call __sock_create_kern() for others.
> >>
> >> For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
> >> sockets.
> >>
> >> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > 
> > This LGTM, but is touching a few other subsystems, it would be great to
> > collect acks from the relevant maintainers: I'm adding a few CCs.
> > 
> > Direct link to the series:
> > 
> > https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t
> 
> Thank you, Paolo, for forwarding this series.
> 
> For all hunks modifying net/sunrpc/svcsock.c and
> net/handshake/handshake-test.c:
> 
>   Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Regarding patch 4/6:
> 
> This paragraph in the patch description needs to explain /why/ sunrpc
> is an exception:
> 
> > For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> > call __sock_create_kern() for others.

Sorry I noticed this sentence was not updated from the previous series.

I'll change it as follows

    For sunrpc, we call sk_net_refcnt_upgrade() for IPPROTO_TCP only
    so we use sock_create_kern() for TCP and keep __sock_create_kern()
    for others.


> 
> The below hunk doesn't seem related to the marquee purpose of this
> series. Should it be a separate patch with its own rationale?
> 
> @@ -1541,8 +1544,8 @@ static struct svc_xprt *svc_create_socket(struct
> svc_serv *serv,
>  	newlen = error;
> 
>  	if (protocol == IPPROTO_TCP) {
> -		sk_net_refcnt_upgrade(sock->sk);

The part above is related, and the below is not, using the old
style warned by checkpatch, so I cleaned it up while at it but
didn't think it's worth a patch.  I'm fine to drop it.


> -		if ((error = kernel_listen(sock, 64)) < 0)
> +		error = kernel_listen(sock, 64);
> +		if (error < 0)
>  			goto bummer;
>  	}
> 

