Return-Path: <linux-nfs+bounces-9234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB68A128E9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 17:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18F91649BD
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452E143C63;
	Wed, 15 Jan 2025 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQD5hVWs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675961553BB
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959218; cv=none; b=K8xLHX7U/T7lxlgi+Fx4ikmO5+LiF2ClzxG1VGnbjxySpqm7Uyc491sSiQ1iBV6y6UTe2whXeqypWi0MCmaMRPPgNGgxpYwchbH0I+hqUGxXramjpVo1TTX3gCsfvmd700bjT+K/OZ/pXanZucamv9rFcOPBtarcFsNsUL/435s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959218; c=relaxed/simple;
	bh=Ufw374dPPmP1HT2FrDPPTHkotA+5b4RcipQqpnFP0bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZqx/uzYmUg9G20wJA8YK5MX0ncTKb9yhE5cVa7AdE8ecEbW5Rwlz1lz8AhjEwiEvKgeKwtSz5KiqCoIZr26UHohxJo+R5d4BYT0wFYi2DzTtnaY5Or16IeUZIWSmPtNxrdieFWg5N/HDNhjcjbNV350zyxyNCAThS6oq+O1k2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQD5hVWs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736959215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNoipceIMSNgv2/C3kziFV/nnWEaM8IoPvEO0RRfsgI=;
	b=ZQD5hVWsS8bbR4+Z2hCxi5xgcaOt2zFmUuCJWoxPSrKI4JUsqnX1zwBUZ6kZONHCa1jR1r
	jnQg1HYBHrcJLEtxGm4v1aRS/BIhg5ipfQV1BvehczCuJvUBEZ6gXmSzeMcwZcaISZGXor
	206k4d19+i2YTUAnYUTod6NFQW0nILM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-yjRBaU4iP2S9rDJz5sBgtQ-1; Wed,
 15 Jan 2025 11:40:11 -0500
X-MC-Unique: yjRBaU4iP2S9rDJz5sBgtQ-1
X-Mimecast-MFC-AGG-ID: yjRBaU4iP2S9rDJz5sBgtQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC80D19560B7;
	Wed, 15 Jan 2025 16:40:10 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.89.167])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87C4719560A3;
	Wed, 15 Jan 2025 16:40:10 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id EC7FA312B61; Wed, 15 Jan 2025 11:40:03 -0500 (EST)
Date: Wed, 15 Jan 2025 11:40:03 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, Yongcheng Yang <yoyang@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] nfsdctl: add support for new lockd configuration
 interface
Message-ID: <Z4fk45I76B6IM1R_@aion>
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
 <Z4bScYOgDwbpyXjt@aion>
 <659d6f0153daf83ebfcad8d7bdb80adb6aa319b5.camel@kernel.org>
 <Z4fJz4re4iFyM2FE@aion>
 <5487afbab2acfe396e1ccc8ba3dfd1256fa00c7b.camel@kernel.org>
 <532ea7d0-afe9-47c0-8436-6891a4b63da4@redhat.com>
 <0068c0d811976aca15818b60192a96ca017893f8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0068c0d811976aca15818b60192a96ca017893f8.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, 15 Jan 2025, Jeff Layton wrote:

> On Wed, 2025-01-15 at 10:12 -0500, Steve Dickson wrote:
> > 
> > On 1/15/25 9:56 AM, Jeff Layton wrote:
> > > On Wed, 2025-01-15 at 09:44 -0500, Scott Mayhew wrote:
> > > > On Tue, 14 Jan 2025, Jeff Layton wrote:
> > > > 
> > > > > On Tue, 2025-01-14 at 16:09 -0500, Scott Mayhew wrote:
> > > > > > On Fri, 10 Jan 2025, Jeff Layton wrote:
> > > > > > 
> > > > > > > v2 is just a small update to fix the problems that Scott spotted.
> > > > > > > 
> > > > > > > This patch series adds support for the new lockd configuration interface
> > > > > > > that should fix this RH bug:
> > > > > > > 
> > > > > > >      https://issues.redhat.com/browse/RHEL-71698
> > > > > > > 
> > > > > > > There are some other improvements here too, notably a switch to xlog.
> > > > > > > Only lightly tested, but seems to do the right thing.
> > > > > > > 
> > > > > > > Port handling with lockd still needs more work. Currently that is
> > > > > > > usually configured by rpc.statd. I think we need to convert it to
> > > > > > > use netlink to configure the ports as well, when it's able.
> > > > > > > 
> > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > 
> > > > > > I think the read_nfsd_conf call should be moved out of autostart_func
> > > > > > and into main (right before the command-line options are parsed).  Right
> > > > > > now if you enable debugging in nfs.conf, you get the "configuring
> > > > > > listeners" and "nfsdctl exiting" messages, but not the "nfsdctl started"
> > > > > > message.  It's not a big deal though and could be done if additional
> > > > > > debug logging is added in the future.
> > > > > > 
> > > > > 
> > > > > That sounds good. We can do that in a separate patch.
> > > > > 
> > > > > > Reviewed-by: Scott Mayhew <smayhew@redhat.com>
> > > > > 
> > > > > Thanks!
> > > > 
> > > > Hey, Jeff.  I was testing this against a kernel without the lockd
> > > > netlink patch, and I get this:
> > > > 
> > > > Jan 15 09:39:16 systemd[1]: Starting nfs-server.service - NFS server and services...
> > > > Jan 15 09:39:17 sh[1603]: nfsdctl: nfsdctl started
> > > > Jan 15 09:39:17 sh[1603]: nfsdctl: nfsd not found
> > > > Jan 15 09:39:17 sh[1603]: nfsdctl: lockd configuration failure
> > > > Jan 15 09:39:17 sh[1603]: nfsdctl: nfsdctl exiting
> > > > Jan 15 09:39:17 sh[1601]: rpc.nfsd: knfsd is currently down
> > > > Jan 15 09:39:17 sh[1601]: rpc.nfsd: Writing version string to kernel: -2 +3 +4 +4.1 +4.2
> > > > Jan 15 09:39:17 sh[1601]: rpc.nfsd: Created AF_INET TCP socket.
> > > > Jan 15 09:39:17 sh[1601]: rpc.nfsd: Created AF_INET6 TCP socket.
> > > > 
> > > > Do we really want it falling back to rpc.nfsd if it can't configure
> > > > lockd?  Maybe it should emit a warning instead?
> > > > 
> > > 
> > > I thought about that, and I think it's better to error out here.
> > > 
> > > Falling back to rpc.nfsd is harmless, and only people who are trying to
> > > set the grace period or lockd ports will ever hit this. lockd
> > > configuration is a no-op if none of those settings are set.
> > > 
> > > > At the very least, NFSD_FAMILY_NAME should no longer be hard-coded in
> > > > that "not found" error message in netlink_msg_alloc().
> > > > 
> > > 
> > > Yeah, that would be good to fix.
> > > 
> > 
> > On a rawhide kernel (6.13.0-0.rc6) the server does
> > come up with 'nfsdctl autostart' but with the
> > new argument 'nlm' I'm getting
> > 
> > $ nfsdctl nlm
> > nfsdctl: nfsd not found
> > 
> 
> Yeah, that's what Scott pointed out too. We should make that error
> message a bit more friendly. It may be a bit before I can get to it. Do
> you guys want to propose a patch to fix that?

Sure, I can do that.
> 
> Thanks,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


