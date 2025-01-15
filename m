Return-Path: <linux-nfs+bounces-9225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128A3A12661
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 15:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3532F165887
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8B8614E;
	Wed, 15 Jan 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1RYfpyN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADF24A7CC
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952298; cv=none; b=qOgL9IoMfiSe6MZSYicNa/7z2I4t/r95YvUPOsHUv8p/AzIqJJuiRXZOBivfhLTmNMknuOppGHjucrDkWQ8c5BGM7z8wg7FuiOHGMF2Tm6I6qPS/eTTfSBfBAalozDs/mEAi7CnVcSYq4uQZO5WBmx7V2WHTb8u1KOkGPsSUmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952298; c=relaxed/simple;
	bh=bah6Tng/b3NQO8+fCzk29l5ItJ464ZElERuGQ2GFutM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA9QKFNLzQJY5476o52Ji00doELa2BIVdiYEmbKfHLux9YWYoojojcANnHaprY784dMMBCDM/ErJ+koI3TwaE/plHr3Y3tG0+in9u55tRXgCFLIIhurqEr3rLoOgdALUom1hjqe8ZKhgyaYu4r4Kt3Tmv0ETxrTYJMQAs5oJk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1RYfpyN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736952295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=POnmy1/45F8FiObEkAMir+YmM3rtkp5RPAsCcO0LvYU=;
	b=c1RYfpyNl/X/2j+XVSyjLV5LGNMrMeclIyYC1diBowKXCrp/gvoG6O48m84zefbNq4TQ2g
	B2vmS7d9t0SM684qaSA0EO0qgMc2MphItS1M6/IKSRzVAyqSgjIHaGp4BoVapNz/r68I3+
	zkcypC5Gr0k0D+u3noJE1pNGHorEAqo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-7bH0kPnqMcmpn5uvo5dv8A-1; Wed,
 15 Jan 2025 09:44:54 -0500
X-MC-Unique: 7bH0kPnqMcmpn5uvo5dv8A-1
X-Mimecast-MFC-AGG-ID: 7bH0kPnqMcmpn5uvo5dv8A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F184118C4B38;
	Wed, 15 Jan 2025 14:44:32 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.89.167])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A459119560AB;
	Wed, 15 Jan 2025 14:44:32 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 0C98C312B26; Wed, 15 Jan 2025 09:44:31 -0500 (EST)
Date: Wed, 15 Jan 2025 09:44:31 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, Yongcheng Yang <yoyang@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] nfsdctl: add support for new lockd configuration
 interface
Message-ID: <Z4fJz4re4iFyM2FE@aion>
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
 <Z4bScYOgDwbpyXjt@aion>
 <659d6f0153daf83ebfcad8d7bdb80adb6aa319b5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659d6f0153daf83ebfcad8d7bdb80adb6aa319b5.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 14 Jan 2025, Jeff Layton wrote:

> On Tue, 2025-01-14 at 16:09 -0500, Scott Mayhew wrote:
> > On Fri, 10 Jan 2025, Jeff Layton wrote:
> > 
> > > v2 is just a small update to fix the problems that Scott spotted.
> > > 
> > > This patch series adds support for the new lockd configuration interface
> > > that should fix this RH bug:
> > > 
> > >     https://issues.redhat.com/browse/RHEL-71698
> > > 
> > > There are some other improvements here too, notably a switch to xlog.
> > > Only lightly tested, but seems to do the right thing.
> > > 
> > > Port handling with lockd still needs more work. Currently that is
> > > usually configured by rpc.statd. I think we need to convert it to
> > > use netlink to configure the ports as well, when it's able.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > I think the read_nfsd_conf call should be moved out of autostart_func
> > and into main (right before the command-line options are parsed).  Right
> > now if you enable debugging in nfs.conf, you get the "configuring
> > listeners" and "nfsdctl exiting" messages, but not the "nfsdctl started"
> > message.  It's not a big deal though and could be done if additional
> > debug logging is added in the future.
> > 
> 
> That sounds good. We can do that in a separate patch.
> 
> > Reviewed-by: Scott Mayhew <smayhew@redhat.com>
> 
> Thanks!

Hey, Jeff.  I was testing this against a kernel without the lockd
netlink patch, and I get this:

Jan 15 09:39:16 systemd[1]: Starting nfs-server.service - NFS server and services...
Jan 15 09:39:17 sh[1603]: nfsdctl: nfsdctl started
Jan 15 09:39:17 sh[1603]: nfsdctl: nfsd not found
Jan 15 09:39:17 sh[1603]: nfsdctl: lockd configuration failure
Jan 15 09:39:17 sh[1603]: nfsdctl: nfsdctl exiting
Jan 15 09:39:17 sh[1601]: rpc.nfsd: knfsd is currently down
Jan 15 09:39:17 sh[1601]: rpc.nfsd: Writing version string to kernel: -2 +3 +4 +4.1 +4.2
Jan 15 09:39:17 sh[1601]: rpc.nfsd: Created AF_INET TCP socket.
Jan 15 09:39:17 sh[1601]: rpc.nfsd: Created AF_INET6 TCP socket.

Do we really want it falling back to rpc.nfsd if it can't configure
lockd?  Maybe it should emit a warning instead?

At the very least, NFSD_FAMILY_NAME should no longer be hard-coded in
that "not found" error message in netlink_msg_alloc().

-Scott

> 
> > > ---
> > > Changes in v2:
> > > - properly regenerate manpages
> > > - fix up bogus merge conflict
> > > - add D_GENERAL xlog messages when nfsdctl starts and exits
> > > - Link to v1: https://lore.kernel.org/r/20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org
> > > 
> > > ---
> > > Jeff Layton (3):
> > >       nfsdctl: convert to xlog()
> > >       nfsdctl: fix the --version option
> > >       nfsdctl: add necessary bits to configure lockd
> > > 
> > >  configure.ac                  |   4 +
> > >  utils/nfsdctl/lockd_netlink.h |  29 ++++
> > >  utils/nfsdctl/nfsdctl.8       |  15 +-
> > >  utils/nfsdctl/nfsdctl.adoc    |   8 +
> > >  utils/nfsdctl/nfsdctl.c       | 331 ++++++++++++++++++++++++++++++++++--------
> > >  5 files changed, 321 insertions(+), 66 deletions(-)
> > > ---
> > > base-commit: 65f4cc3a6ce1472ee4092c4bbf4b19beb0a8217b
> > > change-id: 20250109-lockd-nl-6272fa9e8a5d
> > > 
> > > Best regards,
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


