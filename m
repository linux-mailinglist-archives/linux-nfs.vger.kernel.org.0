Return-Path: <linux-nfs+bounces-7741-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D89C1092
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2024 22:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B5B1C21687
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2024 21:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6D227B96;
	Thu,  7 Nov 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gjozJY8K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09235219C87;
	Thu,  7 Nov 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013208; cv=none; b=JiHA4K5irRsJIKzTO5LZe2H7Wao/+6ZOiRm4kg7TycbNt5JKOGcyOpWxRsBEKg7tSVfJock8z2Y5P0Wcl04U+r2Zz2HW4YU51jyFMVjHuZ48pvRLG5jP8tksjSNLG8vEf1KpVSWlSNh5fIQWcd9kBV1VwTIh+tQTiIcGoDWC7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013208; c=relaxed/simple;
	bh=0Nny2UyaTu4go4AZWKLE7D5SP82bLLtiYPz+DNT/uEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOCV4U6rtXMRtWrhO5BhoKShS4NzCmQXUuq7O/p7io85qJFiY5LQd+Yxh62KU0nGDUvJsGZJmdL3lLtCAksJfwcMDTM+MxsruYm0bAy/iu4HSlDsGXaxxSfBBPs4hagSB9jx3M0coTwcIJtCSOid8IDrpY7cYhIQidUmT6vgWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gjozJY8K; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731013206; x=1762549206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5yz4s/Oc0HMfpz3T57N6IiKL/vnshJ9HMzg1cmzBKE=;
  b=gjozJY8KITHbzKoR2CHfbL9fkFq6Ua0IFER5yINnzhbSRK9Iqrjgfza/
   QQ+3rcJyRLawJAJQ4ZEua023WrdgQfshh+eCsUkysodSlMNo9ynRSBnPJ
   ekQAMnStMQp0o1e5Lhb4pas0PdO7oT61pQuE7JnFRG2fTBFuPwNugD0WQ
   0=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="383370609"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 21:00:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:47518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.53:2525] with esmtp (Farcaster)
 id bf378411-21c2-41ff-aaa0-91736d3975b8; Thu, 7 Nov 2024 20:59:59 +0000 (UTC)
X-Farcaster-Flow-ID: bf378411-21c2-41ff-aaa0-91736d3975b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 20:59:59 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 20:59:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <liujian56@huawei.com>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<geert+renesas@glider.be>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-nfs@vger.kernel.org>, <neilb@suse.de>,
	<netdev@vger.kernel.org>, <ofir.gal@volumez.com>, <okorniev@redhat.com>,
	<pabeni@redhat.com>, <tom@talpey.com>, <trondmy@kernel.org>
Subject: Re: [PATCH net v2] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
Date: Thu, 7 Nov 2024 12:59:52 -0800
Message-ID: <20241107205952.7992-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <78efbd6e-31e5-4e67-a046-2736747b291d@huawei.com>
References: <78efbd6e-31e5-4e67-a046-2736747b291d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "liujian (CE)" <liujian56@huawei.com>
Date: Thu, 7 Nov 2024 20:03:40 +0800
> >> diff --git a/net/socket.c b/net/socket.c
> >> index 042451f01c65..e64a02445b1a 100644
> >> --- a/net/socket.c
> >> +++ b/net/socket.c
> >> @@ -1651,6 +1651,34 @@ int sock_create_kern(struct net *net, int family, int type, int protocol, struct
> >>   }
> >>   EXPORT_SYMBOL(sock_create_kern);
> >>   
> >> +int sock_create_kern_getnet(struct net *net, int family, int type, int proto, struct socket **res)
> >> +{
> >> +	struct sock *sk;
> >> +	int ret;
> >> +
> >> +	if (!maybe_get_net(net))
> >> +		return -EINVAL;
> > 
> > Is this really safe ?
> > 
> > IIUC, maybe_get_net() is safe for a net only when it is fetched under
> > RCU, then rcu_read_lock() prevents cleanup_net() from reusing the net
> > by rcu_barrier().
> > 
> > Otherwise, there should be a small chance that the same slab object is
> > reused for another netns between fetching the net and reaching here.
> > 
> > svc_create_socket() is called much later after the netns is fetched,
> > and _svc_xprt_create() calls try_module_get() before ->xpo_create().
> > So, it seems the path is not under RCU and maybe_get_net() must be
> > called much earlier by each call site.
> > 
> > For this reason, when I write a patch for the same issue in CIFS,
> > I delayed put_net() to cifsd kthread so that the netns refcnt taken
> > for each CIFS server info lives until the last __sock_create() attempt
> > from cifsd.
> > 
> > https://lore.kernel.org/linux-cifs/20241102212438.76691-1-kuniyu@amazon.com/
> > 
> Okay, got it. thank you.
> Looking at the nfs and nfsd processing flow, it seems that the call to 
> __sock_create() to create a TCP socket is always after the mount 
> operation get_net(). So it should be fine to use get_net() directly.

Is there any chance that a concurrent unmount releases the
last refcount by put_net() while another thread trying to call
__sock_create() ?

CIFS was the case.


> So 
> here I'm going to change may_get_net() to get_net(), move 
> sock_create_kern_getnet() to the sunrpc module, and rename it to 
> something more appropriate. Is that okay?

Could you go without adding a helper and do the conversion in sunrpc
code as CIFS did ?

I plan to resurrect my patch and remove such socket conversion altogether
in the next cycle after the CIFS fix lands on net-next.

https://lore.kernel.org/netdev/20240227011041.97375-4-kuniyu@amazon.com/
https://github.com/q2ven/linux/commits/427_2
https://github.com/q2ven/linux/commit/2e54a8cc84f1e9ce60a0e4693c79a8e74c3dbeb9

I inspected all the callers of __sock_create() and friends, and all
__sock_create() can be replaced with sock_create_kern(), so I will
unexport __sock_create() and then add a new parameter hold_net to it.

Then, I'll rename sock_create_kern() to sock_create_net_noref() and add
a fat comment to catch in-kernel users attention so that they no longer
use _kern() API blindly without care about netns reference.  Also, I'll
add sock_create_net() and use it for MPTCP, SMC, CIFS, (and sunrpc) etc.

RDS uses maybe_net_get() but I think this is still buggy and I need
to check more.

