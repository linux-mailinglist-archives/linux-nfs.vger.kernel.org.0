Return-Path: <linux-nfs+bounces-7509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D6C9B13F2
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 02:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7021F228BF
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 00:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52723A0;
	Sat, 26 Oct 2024 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CVnXw1Uk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8478488;
	Sat, 26 Oct 2024 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903728; cv=none; b=SiOe9s+ouIK7HrZzvMVw7vtyrtJGbPJFGZy2Gu0dbIgAosy0z3ukA96rwPIkUZ2TqC/ewyK9cXPPiggsrwu0sp7bKCjpk8ebmQwQBBtcEtm/DISXAb2gtXv8E9d+p/eP0o7/89aYrnHGLLcHIXkqbLFwFoG1inlhlvTyQexnsP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903728; c=relaxed/simple;
	bh=YHZWdnLzTJs2zyTVS+j8wsunjMlgh1rlHUwh8i5eM0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCc3XUeyoTsUCjl+xKfRgi6j/WslsTzatGyFMKMQegJ1wuOwzVlQK3fy57GHNfaLDOo21YiQWVMBRZUBsY1NYpS18PpB70qSNeIVOci4zsBZXg/CblhLvCSX8kTH70dju6WC6dgQurHTT+qjTLzA+qk6oIvlJCx4z18q45Ep5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CVnXw1Uk; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729903726; x=1761439726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlZDM7vIkk3uEbiZukBxgSNywFRcVq+UXcbpdaUZ3rw=;
  b=CVnXw1UkdCf2CIFxX0l93qy8urA40mL1XOxdqPNhEAFg6M7RZVVMBGxV
   pv5vxSZOMrQ4WoI/GmE3VqKyL6EoZLHEmUqfsKwLqk0U1Ej/EZo59zrcX
   wG0qP//60Q1p80gQ1j4qqF2P6xZpSD2oiqYsucXQfztj3lpTlg+LJ6PZn
   M=;
X-IronPort-AV: E=Sophos;i="6.11,233,1725321600"; 
   d="scan'208";a="140846331"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 00:48:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:62787]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.158:2525] with esmtp (Farcaster)
 id 625cb3ba-6dc7-45ad-83ab-85cd53695419; Sat, 26 Oct 2024 00:48:44 +0000 (UTC)
X-Farcaster-Flow-ID: 625cb3ba-6dc7-45ad-83ab-85cd53695419
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 26 Oct 2024 00:48:44 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 26 Oct 2024 00:48:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <trondmy@hammerspace.com>
CC: <Dai.Ngo@oracle.com>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-nfs@vger.kernel.org>, <liujian56@huawei.com>, <neilb@suse.de>,
	<netdev@vger.kernel.org>, <okorniev@redhat.com>, <pabeni@redhat.com>,
	<tom@talpey.com>
Subject: Re: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
Date: Fri, 25 Oct 2024 17:48:37 -0700
Message-ID: <20241026004837.57278-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <0e434c61120b5b4a530731260c0f2c72ad02fa6f.camel@hammerspace.com>
References: <0e434c61120b5b4a530731260c0f2c72ad02fa6f.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Trond Myklebust <trondmy@hammerspace.com>
Date: Sat, 26 Oct 2024 00:35:30 +0000
> On Fri, 2024-10-25 at 14:20 -0700, Kuniyuki Iwashima wrote:
> > From: "liujian (CE)" <liujian56@huawei.com>
> > Date: Fri, 25 Oct 2024 11:32:52 +0800
> > > > > > If not, then what prevents it from happening?
> > > > > The socket created by the userspace program obtains the
> > > > > reference
> > > > > counting of the namespace, but the kernel socket does not.
> > > > > 
> > > > > There's some discussion here:
> > > > > https://lore.kernel.org/all/CANn89iJE5anTbyLJ0TdGAqGsE+GichY3YzQECjNUVMz=G3bcQg@mail.gmail.com/
> > > > OK... So then it looks to me as if NFS, SMB, AFS, and any other
> > > > networked filesystem that can be started from inside a container
> > > > is
> > > > going to need to do the same thing that rds appears to be doing.
> > 
> > FWIW, recently we saw a similar UAF on CIFS.
> > 
> > 
> > > > 
> > > > Should there perhaps be a helper function in the networking layer
> > > > for
> > > > this?
> > > 
> > > There should be no such helper function at present, right?.
> > > 
> > > If get net's reference to fix this problem, the following test is 
> > > performed. There's nothing wrong with this case. I don't know if
> > > there's 
> > > anything else to consider.
> > > 
> > > I don't have any other ideas other than these two methods. Do you
> > > have 
> > > any suggestions on this problem? @Eric @Jakub ... @All
> > 
> > The netns lifetime should be managed by the upper layer rather than
> > the networking layer.  If the netns is already dead, the upper layer
> > must discard the net pointer anyway.
> > 
> > I suggest checking maybe_get_net() in NFS, CIFS, etc and then calling
> > __sock_create() with kern 0.
> > 
> 
> Thanks for the suggestion, but we already manage the netns lifetime in
> the RPC layer. A reference is taken when the filesystem is being
> mounted. It is dropped when the filesystem is being unmounted.
> 
> The problem is the TCP timer races on shutdown. There is no interest in
> having to manage that in the RPC layer.

Does that mean netns is always alive when the socket is created
in svc_create_socket() or xs_create_sock() ?  If so, you can just
use __sock_create(kern=0) there to prevent net from being freed
before the socket.

sock_create_kern() and kern@ are confusing, and we had similar issues
in other kernel TCP socket users SMC/RDS, so I'll rename them to
sock_create_noref() and no_net_ref@ or something.

