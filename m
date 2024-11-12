Return-Path: <linux-nfs+bounces-7886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A19C4A7D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 01:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB63281109
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 00:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E015223;
	Tue, 12 Nov 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UWKmA3N3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E033D8;
	Tue, 12 Nov 2024 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370404; cv=none; b=tntP2lk7yM2kiNIReCqU+wzCQRDUy8J91LeY49oxcMk9zcF0kL22IG19HpcOVAFx08hAPuquTfjiCEfUMEMiadJYkV+S7mnFML05w/9UZrRiSyKNJMnzCC0JAa18kUgYi7sofR64qIa5mFu+6MTVnREvs88BCWcu/f0pMINX6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370404; c=relaxed/simple;
	bh=c8JMhxaw2aTzUlJqs9T0oHnklHlgTT7i1tkiYE+Chjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cswdId/tMgtcwz5X9vv7jUKKpcCts/8iN6hlxihq64Xl7DvzCqSqSUK5JORtfVSbAs+BsqiFB6Z815F2ZrWpBEJqUMYSoENtBg0a6nng9dTYXVUPshAYSzqaXjA3iT+aG0cp3gzfiTmAKs8hbNJCThyjXvn2iJl/8N7ILfHwqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UWKmA3N3; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731370403; x=1762906403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7PqkhJJe7HHVVYYciRML661Up3/RTfmAgq2lLOwz/+U=;
  b=UWKmA3N3FKQfJ3MAWpmfD+dkCe75AehXn+JmeWoVRNxEbGNvmb7iO29j
   Xymbp98XN3H3KyVECDk/xNy2cIKAkDiPuRM/ggsBY1GO7H5U5ha6y/iR9
   2X3XewopXBZBkWOPOMIVkFgye0vxyn57pMPjZQ2hQwbj/Jmqsg435SWiD
   k=;
X-IronPort-AV: E=Sophos;i="6.12,146,1728950400"; 
   d="scan'208";a="694616557"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 00:13:19 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:29838]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.168:2525] with esmtp (Farcaster)
 id 7fdd29ac-bb45-4d6d-9f13-6f1edba3eb25; Tue, 12 Nov 2024 00:13:18 +0000 (UTC)
X-Farcaster-Flow-ID: 7fdd29ac-bb45-4d6d-9f13-6f1edba3eb25
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 00:13:15 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 12 Nov 2024 00:13:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <neilb@suse.de>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<horms@kernel.org>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-nfs@vger.kernel.org>, <liujian56@huawei.com>,
	<netdev@vger.kernel.org>, <okorniev@redhat.com>, <pabeni@redhat.com>,
	<tom@talpey.com>, <trondmy@kernel.org>
Subject: Re: [PATCH net v3] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
Date: Mon, 11 Nov 2024 16:13:08 -0800
Message-ID: <20241112001308.58355-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <173136915454.1734440.13584866019725922631@noble.neil.brown.name>
References: <173136915454.1734440.13584866019725922631@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "NeilBrown" <neilb@suse.de>
Date: Tue, 12 Nov 2024 10:52:34 +1100
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
> This is really ugly.  These internal details of the network layer have
> no place in sunrpc code. There must be a better way.

I asked to do this way.  I agree this way is really ugly.  Similar
code exists in MPTCP, SMC, CIFS, etc, so I plan to add a new API for
this case, but this requires huge change adding a new parameter for
->create() prototype and the changes are not backportable.

https://github.com/q2ven/linux/commit/bb8b8814a73b3f50c3fef5eaf8d30d8c1df43e7b
https://github.com/q2ven/linux/commits/427_2

After my series, we can use the following but cannot backport it to
stable.

  sock_create_net(net, family, type, protocol);

  e.g. commit for MPTCP
  https://github.com/q2ven/linux/commit/24a4647561272c1e67a685d8403e27eb863398cf

That's why I suggested to go with the ugly way and I will clean them
up in the next cycle.

So, finally the sunrpc code will be much cleaner and the netns refcnt
will be touched only in the core code.


> 
> Can we pass '0' for the kern arg to __sock_create()?  That should fix
> the refcounting issues, but might mess up security labelling.

This should be avoided as it's confusing for BPF programs, LSMs, and
LOCKDEP.


> 
> Can we wait for something before we call put_net() to release the net.
> 
> Maybe we want to split the "kern" arg t __sock_create() and have
> "kern" which affects labeling and "refnet" with affects refcounting the
> net.

This is exactly what my series does, but again, it's not backport
friendly.
https://github.com/q2ven/linux/commit/413e867b4aee9e9f60f3c33fb38d2004aeb29c40


> 
> I had a quick look and very nearly every caller of __sock_create()
> outside of net/core really does want refcount.  Many callers of
> sock_create_kern() possibly don't.

Actually, since sock_create_kern() is added, we no longer need to
export __sock_create(), so I have a patch to convert them to
sock_create_kern().

And most of TCP socket does need refcnt, but non-TCP won't.
Also, handshake one is exception, which uses TCP but only in init_net,
where we need not take care of netns refcnt.

https://github.com/q2ven/linux/commit/b56888bbbf327d57ea25a6b97275d6b9b8ad043a



> 
> So I really think this needs to be cleaned up in net/core, not in all
> the different network clients in the kernel.

Yes, will be done in the next cycle.

