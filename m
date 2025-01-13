Return-Path: <linux-nfs+bounces-9185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54823A0C55E
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 00:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CACC1885DE0
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 23:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84641F9F5F;
	Mon, 13 Jan 2025 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZewHyEHX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CAE1F9F50
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809917; cv=none; b=TESUgo1ZBSbY5Uq18M5il4FHw4biYVFzq3MG/JLU//JhZAfMnHmrXKiEiLn5zrYm8rl/dfLFkNmcD8BjR4tlvjXF0jnpkClfnlrQrkxJ4Oxaz/BAkSc1yuuMO6nL8rhENamA+2jVk79s8PtHK2E7eDcmhzFrZ22ryZVsYg4sccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809917; c=relaxed/simple;
	bh=v9bLYfiyLKnCom6OTE5uh9n15DL1lyZBNZ4V8l6LMc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taiFlDUtXBn/vD8jl9YJJhPBD6VcHcme3ieB0QoPU0WbaWGrMJJ/Gdb8ZJPYQCsTva28NDczdD/5GRz/aw+k8Thyc5izrV1wLyD8Ib5Hr99xUrZ5Dme/ypmwXGJ1t9QEPnlMwB0DqJwOFGmsvR3RY5PaX/tVY/Q+0L2heW8tbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZewHyEHX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736809914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oc/bqQ9WaC6Pg2Mv4niv0X+07elpzwtgKZ99OYhTEY=;
	b=ZewHyEHXzsFqzMfe6l16QFtYEF4AqD8Y2UeAK8/L7O6N0+vFZ4xtU8E7gbZgAb7No1FZKI
	NP+bWpfIgoyusS4FcVMgTVet8MtfgCypgo5ZxljT8TLcIJ3OzvdX+g9VbAJrcy+0uYRNrs
	NhSRpXF1gEMfm9TpP98K/UxGb+SLH0M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-oe4hwYfePBSGYE71IO1_Sw-1; Mon,
 13 Jan 2025 18:11:53 -0500
X-MC-Unique: oe4hwYfePBSGYE71IO1_Sw-1
X-Mimecast-MFC-AGG-ID: oe4hwYfePBSGYE71IO1_Sw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 385D1195608A;
	Mon, 13 Jan 2025 23:11:52 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03AE430001BE;
	Mon, 13 Jan 2025 23:11:52 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 7880A2EA88B; Mon, 13 Jan 2025 18:11:50 -0500 (EST)
Date: Mon, 13 Jan 2025 18:11:50 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: steved@redhat.com, yoyang@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH v2 0/2] nfsdctl version handling fixes
Message-ID: <Z4Wdtg6yvrfbSLT0@aion>
References: <20250110201746.869995-1-smayhew@redhat.com>
 <6553ee0f1fd57c64db76333efb47fca007f61693.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6553ee0f1fd57c64db76333efb47fca007f61693.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, 11 Jan 2025, Jeff Layton wrote:

> On Fri, 2025-01-10 at 15:17 -0500, Scott Mayhew wrote:
> > Two changes in how nfsdctl does version handling.  The first patch makes
> > the 'nfsdctl version' command behave according to the man page for w.r.t
> > handling +4/-4, e.g.
> > 
> > # utils/nfsdctl/nfsdctl
> > nfsdctl> threads 0
> > nfsdctl> version
> > +3.0 +4.0 +4.1 +4.2
> > nfsdctl> version -4
> > nfsdctl> version
> > +3.0 -4.0 -4.1 -4.2
> > nfsdctl> version +4
> > nfsdctl> version
> > +3.0 +4.0 +4.1 +4.2
> > nfsdctl> version -4 +4.2
> > nfsdctl> version
> > +3.0 -4.0 -4.1 +4.2
> > nfsdctl> ^D
> > 
> > The second patch makes nfsdctl's handling of the nfsd version options in
> > nfs.conf behave like rpc.nfsd's.  This is important since the systemd
> > service file will fall back to rpc.nfsd if nfsdctl fails.  I'll send a
> > test script and test results in a followup email.
> > 
> > -Scott
> > 
> > Scott Mayhew (2):
> >   nfsdctl: tweak the version subcommand behavior
> >   nfsdctl: tweak the nfs.conf version handling
> > 
> >  utils/nfsdctl/nfsdctl.c | 69 +++++++++++++++++++++++++++++++++++------
> >  1 file changed, 59 insertions(+), 10 deletions(-)
> > 
> 
> LGTM!
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
If you look at my test results, you'll notice that I was skipping the
test whenever vers3=n and vers4=n.  I was mainly doing this because in
those cases rpc.nfsd would error out with the message "no version
specified", while nfsdctl would not.  But when I went ahead and tested
those scenarios, rpc.nfsd's behavior seemed incorrect in several of
them.

For example, consider this scenario:

# cat /etc/nfs.conf
[nfsd]
vers3=n
vers4=n
vers4.0=n
vers4.1=n
vers4.2=y
# rpc.nfsd 16
rpc.nfsd: no version specified

That shouldn't have failed, because v4.2 is enabled... and before anyone
chimes in claiming that vers4=n should override any vers4.x=y config option,
consider this scenario:

# cat /etc/nfs.conf
[nfsd]
vers3=3
vers4=n
vers4.0=n
vers4.1=n
vers4.2=y
# rpc.nfsd 16
# cat /proc/fs/nfsd/versions 
+3 +4 -4.0 -4.1 +4.2

So anyways, a v3 patchset is incoming that changes both nfsdctl and
rpc.nfsd so that they behave more consistently.

-Scott


