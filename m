Return-Path: <linux-nfs+bounces-20316-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEPnKcTlwGl6OQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20316-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:03:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 168052ED426
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BA6B300B105
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 07:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7A0223DCE;
	Mon, 23 Mar 2026 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erN8wzFX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39629D26E
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249377; cv=none; b=jxlyGIQ3cDwCiAMkfwWKWI3rBrjCrRYI17cR313UPAOxAlfFFSF7k+bVhlMt4yY89pgEIjLZEemhmJStvIFn4sLaQpIizclBgpGbQyHa2dGyNCFHgl2kuq46WbyVGaD2qG9i748FbVJftqPK5AexhNJ+1pCTt21rvhiXo4tv9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249377; c=relaxed/simple;
	bh=qZ2tCPAcsI96xkMIoA2fAoyCOMpyDox8B04kEiFdjno=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/2ewUmG5COCL1Uis5LPaqEh6/D1pjCP+Vx9gqG6um3RpZ82GyYWh4K3KB7RjSiyN/kDPSp179RZyRKcgUVyGk4T+8NDCQ3rBmVzt7ARRWliZvBTqIeebYfVHP8QCevNA8HAxDj7j24t65ECy1W2zWHUs6gWZRkcHHnveckE9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erN8wzFX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c6fc2910so2776750f8f.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774249374; x=1774854174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+yDsTu0y8yqJoK5Jnrw9284knaFcfDJgG+GdDTgbUI=;
        b=erN8wzFX77LN7ypi5bhdRfcUbkGh31Gjo9T0y3PvJrqi2KYJORa+E619avchJ14F/A
         O6uUdbuji78a790iWCRcbJyytjYyoNi8I5/0x+0au0P/pwJHgtfYUyhEOVO9FBGdkWZS
         cXkFu1NQc9VCMkItfoLcT3ozdURTmvvb4R1IdMVU1KSV5HarFVC1uU+YcuKqJmxPDPc6
         Y+M8S0Cn9BkOZKw6f95tv0LMBj3mZ+TLz7sHZXMKdmolROSF5MdePAwoVGKWDUkOurre
         GaO0PyFZ34zskGu1XwKA2mJJvTm49BlRm3Fgxtq+6QhdZWV9M8NDR4vNpfct4IT7i8v3
         rqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774249374; x=1774854174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+yDsTu0y8yqJoK5Jnrw9284knaFcfDJgG+GdDTgbUI=;
        b=M5xYV6afRmhOx5cGSoyJhAMrL51szleKnszuRvxHacu4AfwARvkxFj0c1iNzYTDy/n
         eUCSB0H1wDkFDqgCweajjm+bp1vWtrk+01d3cA6YcdJfeFAa+ivVhCug/hv48MHtIu0s
         UdigpUmD6bh1r2UaZlAIfDxFb7LCtD/GZ88LIoA65vjoafuqAtt5QWrbLiqcMN9TnPfB
         K1hozm6TFc/HbJdZr3bGOUXQJ10JUVYYQFpuxsBMD64NBrMQPyoo8LqQCiGHfDwGVWod
         67JVvcOd/Nd23fTIDS/iaMwMWdV5BzfPtlDFiA4YdaqB53KDmuEe3c5kHxLAJ9wnfR6G
         ZedQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2glvXIhgzbFZMxswftxRWRBPz8mQamDA6/Cgw61qAkd7/Pz1L7kId3XPkPgefGZk52rFyZqOiwW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5w7rxldgR/L3qwP6xcbU4A9+Fhsagcu1SYXzSFQMlOAF4CKce
	Wxv0AGH2LhEXPKbagufLWJ86xpk04DzL555At3dXV1n3JNPoVYkvpsbw
X-Gm-Gg: ATEYQzwW5GYrHLlAVUwPDHaUecIeozB0LsH+Plf6QSo+SsznEvGqdRHTENO6UyC5D5q
	YQm5/D1gmi4G8RImmXa+DJuTWYrz//8GzrBLfzz/SqRgmxQHVuWR+SXFzY3bRiK5nRYyG8PsZkB
	aH3zxkOH6p6iAP6hZO4a9L3zkBwbbd5oMzmSg1fN62sqYn9mxdaJfvNSfOrGgeG4j8hg7hl6Q+z
	6AorYFmOtnKvXWi5loRIQ66hfDNfe4PZ+LdJReGA/864Xy/gkqZHM6c+yhcXG9LffUW+LsFwi3Z
	/XX/S5LLx4waBA9LgKj5ino9+jvyFdL0lfG+m2nCcYc437p7UJr6B5PHCrehSherP8YZQ61b93P
	f132n/8DfRy0Rcm3+ZhwyfvboEVNPs2wXdlzwmdP/AmL8OxrIyinMI6mdtQksZTDOhQqqXYlVCm
	exovQmm4/u9otvIpC9zN/lhS0bzHf5lBJtQ3j4uwnv3nkvw4xk/V8RGT2J563B646uxtg/EA==
X-Received: by 2002:a05:6000:22c1:b0:43b:48ab:5672 with SMTP id ffacd0b85a97d-43b642876b2mr17172547f8f.45.1774249374264;
        Mon, 23 Mar 2026 00:02:54 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c27sm27331959f8f.18.2026.03.23.00.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 00:02:53 -0700 (PDT)
From: salvatore.bonaccorso@gmail.com
X-Google-Original-From: Salvatore Bonaccorso <salvi@eldamar.lan>, Salvatore Bonaccorso <carnil@debian.org>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 52DC9BE2EE7; Mon, 23 Mar 2026 08:02:52 +0100 (CET)
Date: Mon, 23 Mar 2026 08:02:52 +0100
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd/nfsdctl: default to starting with v4.0 servers
 disabled
Message-ID: <acDlnPo3z5Uk2vcH@eldamar.lan>
References: <20251008-master-v1-0-c879be4973c8@kernel.org>
 <a04afd6b-e295-4100-a785-2b6feb6b3cf7@redhat.com>
 <acBfpHr2e6LMmiGQ@eldamar.lan>
 <643b2d6bb1bdda8c2602535da9c679e6dfbe68a7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643b2d6bb1bdda8c2602535da9c679e6dfbe68a7.camel@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20316-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[salvatorebonaccorso@gmail.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eldamar.lan:mid]
X-Rspamd-Queue-Id: 168052ED426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jeff,

On Sun, Mar 22, 2026 at 05:42:29PM -0400, Jeff Layton wrote:
> On Sun, 2026-03-22 at 22:31 +0100, Salvatore Bonaccorso wrote:
> > Hi Steve, Jeff,
> > 
> > On Sun, Mar 22, 2026 at 04:30:02PM -0400, Steve Dickson wrote:
> > > 
> > > 
> > > On 10/8/25 4:13 PM, Jeff Layton wrote:
> > > > At this week's NFS Bakeathon, we had a discussion around deprecating the
> > > > NFSv4.0 protocol. To prepare for that eventuality, make the NFS server
> > > > only accept NFSv4.0 if it was explicitly requested in the config file or
> > > > in command-line options.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > Jeff Layton (2):
> > > >        nfsd: disable v4.0 by default
> > > >        nfsdctl: disable v4.0 by default
> > > > 
> > > >   utils/nfsd/nfsd.c       | 5 +++--
> > > >   utils/nfsdctl/nfsdctl.c | 2 +-
> > > >   2 files changed, 4 insertions(+), 3 deletions(-)
> > > > ---
> > > > base-commit: 612e407c46b848932c32be00b835a7b5317e3d08
> > > > change-id: 20251008-master-724587cca99a
> > > > 
> > > > Best regards,
> > > Committed... (tag: nfs-utils-2-9-1-rc1)
> > > 
> > > My apologies for taking so long... The CVE
> > > took longer than expected and there was
> > > some issues with recent patches,
> > > which caused another release..
> > > 
> > > Turning off a protocol version (v4.0)
> > > on the server by default which this rc
> > > release does, is not a small thing
> > > although with the 7.X kernels the
> > > v4.0 client is already off.
> > 
> > I have one small followup question on that. The nfs.conf reads:
> > 
> > [nfsd]
> > # debug=0
> > # threads=16
> > # host=
> > # port=0
> > # grace-time=90
> > # lease-time=90
> > # udp=n
> > # tcp=y
> > # vers3=y
> > # vers4=y
> > # vers4.0=y
> > # vers4.1=y
> > # vers4.2=y
> > [...]
> > 
> > Should the 'default off' change as well be reflected in the commented
> > entry for vers4.0 and read vers4.0=n for consistency?
> > 
> 
> Yes, good catch. Would you mind spinning up a patch? If not, I'll do
> one in the near future.

Thanks for confirming, yes happy to provide a patch for that, will
send it later the day.

Regards,
Salvatore

