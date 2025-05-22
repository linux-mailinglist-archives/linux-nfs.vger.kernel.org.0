Return-Path: <linux-nfs+bounces-11865-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0385BAC10CE
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 18:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E46D9E6878
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276E29A31D;
	Thu, 22 May 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="H0MMvTQ7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9BB298986;
	Thu, 22 May 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930372; cv=none; b=DTAv3Ke29tQocIBHWtBZBaGFG4pABgcfMTjb4oifQjhFjLd1XWxMRG2xDFvog7RPJqdufoWI7ob7B7hTq5RS4KV73KBaAqm/dXOJJGRv5nRWX1iitTOL5eoinAhWjvfOzc15xswN/XF3OEPjyPnUlcUIN3fziRIgawn7pUpmErw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930372; c=relaxed/simple;
	bh=r/9YbCnf38I2uNWxlrT08OWQjmU2+IxyxKka3g6yh7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mT1dzJHYLtWbiUwWadFBDf936DFuIwSNuExOMS4zFQ3du/VUdFFjzVmifdXIUAWBIiCAQeqqUw/a1qOEjcBSV45QnHVYiNvDCu+iPlz1u1qbbNC1sTEYqqCmqos5psdq+4fqITF8Z46UCbAI19nSvY4di00uC5xRFhgPEC6hGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=H0MMvTQ7; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747930370; x=1779466370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q83a3aOAlFEsUBxycxiFP+NkK9i6pWmdjvMN3DiYJEA=;
  b=H0MMvTQ7QE1Kopn2QsQPABCVvDnXKdyXkuc5GQckz0i69GInlMDt7RpN
   6UxIuhWaUU8PzaRicPGorasoKCOqeABKgB+o7lK0ulk6qxt/kTOtx/LTD
   ViM2xgjec9k5w18Nub2CStiS8QX7WI7h49kWB4KKENgwHatfe9xznFA9I
   RN/0XQPuJ061dMWYHAO+vY0QG82NbaMLJL3wIVf5lT2jk3foqvdSolS6N
   40dm2NR/X9faXY3ow3sOnrwUutQp18AEB7erCpcLHe/rSIU0SetZ5o67v
   648MAkkGZI4bACRrJIlW0+BxIg4C3cXgw64Qiwzz6SZ7ADzcFYS4mrxYG
   g==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="199907297"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:12:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:57322]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.185:2525] with esmtp (Farcaster)
 id 5dac8cde-4bb0-4f29-b099-51b167a264c8; Thu, 22 May 2025 16:12:48 +0000 (UTC)
X-Farcaster-Flow-ID: 5dac8cde-4bb0-4f29-b099-51b167a264c8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 16:12:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 16:12:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <axboe@kernel.dk>, <chuck.lever@oracle.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <hch@lst.de>, <horms@kernel.org>,
	<jaka@linux.ibm.com>, <jlayton@kernel.org>, <kbusch@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-nfs@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>,
	<netdev@vger.kernel.org>, <sfrench@samba.org>, <wenjia@linux.ibm.com>,
	<willemb@google.com>
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion except for net/rds/.
Date: Thu, 22 May 2025 09:12:22 -0700
Message-ID: <20250522161235.32989-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
References: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 22 May 2025 10:55:47 +0200
> On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
> > Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
> > count the netns of kernel sockets."), TCP kernel socket has caused
> > many UAF.
> > 
> > We have converted such sockets to hold netns refcnt, and we have
> > the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.
> > 
> >   __sock_create_kern(..., &sock);
> >   sk_net_refcnt_upgrade(sock->sk);
> > 
> > Let's drop the conversion and use sock_create_kern() instead.
> > 
> > The changes for cifs, mptcp, nvme, and smc are straightforward.
> > 
> > For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> > call __sock_create_kern() for others.
> > 
> > For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
> > sockets.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> This LGTM, but is touching a few other subsystems, it would be great to
> collect acks from the relevant maintainers: I'm adding a few CCs.
> 
> Direct link to the series:
> 
> https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t
> 
> > diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> > index 37a2ba38f10e..c7b4f5a7cca1 100644
> > --- a/fs/smb/client/connect.c
> > +++ b/fs/smb/client/connect.c
> > @@ -3348,21 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
> >  		socket = server->ssocket;
> >  	} else {
> >  		struct net *net = cifs_net_ns(server);
> > -		struct sock *sk;
> >  
> > -		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
> > -					IPPROTO_TCP, &server->ssocket);
> > +		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
> > +				      IPPROTO_TCP, &server->ssocket);
> >  		if (rc < 0) {
> >  			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
> >  			return rc;
> >  		}
> >  
> > -		sk = server->ssocket->sk;
> > -		__netns_tracker_free(net, &sk->ns_tracker, false);
> > -		sk->sk_net_refcnt = 1;
> > -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> > -		sock_inuse_add(net, 1);
> 
> AFAICS the above implicitly adds a missing net_passive_dec(net), which
> in turns looks like a separate bugfix. What about adding a separate
> patch introducing that line? Could be in the same series to simplify the
> processing.

Thanks for catching!

Will add this patch before this change.

---8<---
commit c7ff005fe4d930169f319aca0bd9577541cd7459 (HEAD)
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Thu May 22 16:03:29 2025 +0000

    smb: client: Add missing net_passive_dec().
    
    While reverting commit e9f2517a3e18 ("smb: client: fix TCP timers deadlock
    after rmmod"), I should have added net_passive_dec(), which was added between
    the original commit and the revert by commit 5c70eb5c593d ("net: better track
    kernel sockets lifetime").
    
    Let's call net_passive_dec() in generic_ip_connect().
    
    Note that this commit is only needed for 6.14+.
    
    Fixes: 95d2b9f693ff ("Revert "smb: client: fix TCP timers deadlock after rmmod"")
    Cc: <stable@vger.kernel.org> # 6.14.x
    Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 37a2ba38f10e..afac23a5a3ec 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3359,6 +3359,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
 
                sk = server->ssocket->sk;
                __netns_tracker_free(net, &sk->ns_tracker, false);
+               net_passive_dec(net);
                sk->sk_net_refcnt = 1;
                get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
                sock_inuse_add(net, 1);
---8<---

