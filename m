Return-Path: <linux-nfs+bounces-4043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367590E1CA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 04:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F97B20ADD
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 02:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16047A40;
	Wed, 19 Jun 2024 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FykiZsZw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23975227
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765810; cv=none; b=AbyABOUJ+WNiZb6umrzTBQZm6O5Ayx0HLxKSvp+Zy/bEUJmZ4aDqA7dimwWY1W2Q/B11IgwYNi1rTqdEMq5Em2hb965/KFU1DO4K/W1kcPcsvYcIGbdgr09i+TTd+hKnzs5O+G89tyuKeYrsBkncOpAzlBn7Q+Ky46/bwY1QM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765810; c=relaxed/simple;
	bh=QLhICn178Xyw+t8NTT7b/GUfklcCAUGpdMnoOyAcKBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he3ULJz8RFAJ7HC0YV6FeQoppbkBljUR9I58YEPYIVF9IhwLIv+rImPlcZUeGXHLTxPMABPDizYFjd21e50leNxFxinHtp9zsLkmJPHSGd3xRhSKe5lpEeT58ZJcI60t1qszr5ULsrKcVbkLgiB72y8mMViCNjsW6d9wWUHcurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FykiZsZw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-70346ae2c43so301850a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718765808; x=1719370608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fbnht+vZzVRkV8lX/q3nOBHp9BZGNrrFqx5tXJvt48E=;
        b=FykiZsZwzVHp9xZtZ7DnmmSnVf5ld1ddbTPLsrGz99WeE41hWzmazTejmq0Ef7RxcH
         ewMSf9IfFsOVuXhLRyQ0MhvckbftiRhcx88B1j/q6ET6F/H4faiAZxKSgzOkw2DmiZr4
         2hbPDkmwoRZ3JjH2e1VmOJWt1ZrCpaxYpx6oHLz2U6NiLKbAtI65vqGCAj3jaQt4A/as
         gsLUBBBFyBlAkevr2qNe2ijFNxHI4AeNWuzsCcZSTuzBgKB1V/YFqJvcV8cfOzefecLO
         mwBFXAU5yv9zBfBElG2CZDVM3AaO3Z5EPFX8D2rxQmq3VaETGnRZ7HdfSUfqc4lUnA9b
         4cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718765808; x=1719370608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbnht+vZzVRkV8lX/q3nOBHp9BZGNrrFqx5tXJvt48E=;
        b=qdJ7cANSysRx4jm+iG2pUplfLeSYEJL2vT41yhwVZYK1HIc1jNTdxU1W26J3243JM8
         WraIr3h7elDPlbRZFBBheHcGFYaVifI3OGmHJ+CqNdxrw4MmaK5jBwk9SEsmk0TpFJqX
         sTBji+9D7Un0veBTF9u0WjfSSDkpNGeygWhphz74BGDRtbbeuhSGMLNW1rcqgfBlMkSV
         CDX0h8eKJBnUcIbeBELGEE2zd60iH1U+Uo6K58/ly8J8I82D6zPJKqs/Ib7Nml+fingx
         hnaq7JnKU3JaTuMSrjvOQIDl9ZQuUGP7V7vet3HNcsFdZz4FXOu0z3F0k1pJ+5bdEJmq
         mYDw==
X-Forwarded-Encrypted: i=1; AJvYcCWpQRFFqUW1JKWs6In9ZtG1dhxtQP9dRiOwVPheoSMpD9xadQ1VJzgxDXrlfutkg1UvGY0nLFDTN8EgHq37kHR6h0Yfd/kuMl9j
X-Gm-Message-State: AOJu0YwY60pTUDUT1YTdxhXajQDNitJwlL8FNe++0sYnAbJ78uBjhPPc
	N1bRK/nQ9L5Txnwh74PE5hYMyuaGBJrMi1/YZc24quod4u+t9m811O0etMjOt8k=
X-Google-Smtp-Source: AGHT+IEbDY3X4DXIKniS37MbdEOHfKC+22Pa+Ut+t8Bg2xM4rZqhWPVdUBkGGO9TBYSEesdff07FmA==
X-Received: by 2002:a17:90a:34c9:b0:2c2:d6ca:3960 with SMTP id 98e67ed59e1d1-2c7b3ba80b8mr2126738a91.17.1718765807744;
        Tue, 18 Jun 2024 19:56:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45f3035sm11686547a91.25.2024.06.18.19.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:56:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sJlV6-003R4P-1J;
	Wed, 19 Jun 2024 12:56:44 +1000
Date: Wed, 19 Jun 2024 12:56:44 +1000
From: Dave Chinner <david@fromorbit.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
Message-ID: <ZnJI7Em5clnyWDU6@dread.disaster.area>
References: <87354accc0d1166eb60827c0f8da545e0669915b.camel@kernel.org>
 <171875264902.14261.9558408320953444532@noble.neil.brown.name>
 <E14A0A67-71C7-4ED7-BE4E-525A186B876A@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E14A0A67-71C7-4ED7-BE4E-525A186B876A@oracle.com>

On Tue, Jun 18, 2024 at 11:26:22PM +0000, Chuck Lever III wrote:
> > On Jun 18, 2024, at 7:17 PM, NeilBrown <neilb@suse.de> wrote:
> >> Eventually we'd like to make the thread poos dynamic, at which point
> >> making that the default becomes much simpler from an administrative
> >> standpoint.
> > 
> > I agree that dynamic thread pools will make numa management simpler.
> > Greg Banks did the numa work for SGI - I wonder where he is now.  He was
> > at fastmail 10 years ago..
>
> Dave (cc'd) designed it with Greg, Greg implemented it.

[ I'll dump a bit of history about the NUMA nfsd architecture at the
end. ]

> > The idea was to bind network interfaces to numa nodes with interrupt
> > routing.  There was no expectation that work would be distributed evenly
> > across all nodes. Some might be dedicated to non-nfs work.  So there was
> > expected to be non-trivial configuration for both IRQ routing and
> > threads-per-node.  If we can make threads-per-node demand-based, then
> > half the problem goes away.

Right.

For the dynamic thread pool stuff, the grow side was a simple
heuristic: when we dequeued a request, we checked if the request
queue was empty, if there were idle nfsd threads and whether we were
under the max thread count.  i.e. If we had more work to do and no
idle workers to do it, we forked another nfsd thread to do the work.

I don't recall exactly what Greg implemented on Linux for the shrink
side. On Irix, the nfsd would record the time at which it completed
it's last request processing, we fired a timer every 30s or
so to walk the nfsd status array. If we found an nfsd with a
completion time older than 30s, the nfsd got reaped. 30s was long
enough to handle bursty loads, but short enough that people didn't
complain about having hundreds of nfsds sitting around....

This is basically a very simple version of what workqueues do for us
now.

That is, if we just make the nfsd request work be based on per-node, node
affine, unbound work queues, then thread scaling comes along for
free. I think that workqueues support this per-node thread pool
affinity natively now:

enum wq_affn_scope {
        WQ_AFFN_DFL,                    /* use system default */
        WQ_AFFN_CPU,                    /* one pod per CPU */
        WQ_AFFN_SMT,                    /* one pod poer SMT */
        WQ_AFFN_CACHE,                  /* one pod per LLC */
>>>>>   WQ_AFFN_NUMA,                   /* one pod per NUMA node */
        WQ_AFFN_SYSTEM,                 /* one pod across the whole system */

        WQ_AFFN_NR_TYPES,
};

I'm not sure that the NFS server needs to reinvent the wheel here...

> Network devices (and storage devices) are affined to one
> NUMA node.

NVMe storage devices don't need to be affine to the node. They just
need to have a hardware queue assigned to each node so that
node-local IO always hits the same hardware queue and gets
completion interrupts returned to that same node.

And, yes, this is something that still has to be configured
manually, too.

> If the nfsd threads are not on the same node
> as the network device, there is a significant penalty.
>
> I have a two-node system here, and it performs consistently
> well when I put it in pool-mode=numa and affine the network
> device's IRQs to one node.
>
> It even works with two network devices (one per node) --
> each device gets its own set of nfsd threads.

Right. But this is all orthogonal to solving the problem of demand
based thread pool scaling.

> I don't think the pool_mode needs to be demand based. If
> the system is a NUMA system, it makes sense to split up
> the thread pools and put our pencils down. The only other
> step that is needed is proper IRQ affinity settings for
> the network devices.

I think it's better for everyone if the system automatically scales
with demand, regardless of whether it's a NUMA system or not, and
regardless of whether the proper NUMA affinity has been configured
or not.

> > We could even default to one-thread-pool-per-CPU if there are more than
> > X cpus....
> 
> I've never seen a performance improvement in the per-cpu
> pool mode, fwiw.

We're not doing anything inherently per-cpu in processing an NFS
request, so I can only see downsides to trying to restrict incoming
processing to per-cpu queues. i.e. if the CPU can't handle all the
incoming requests, what processes the per-cpu request backlog? At
least with per-node queues, we have many cpus to through at the one
incoming request queue and we are much less likely to get backlogged
and starve the request queue of processing resources...

Cheers,

Dave.

-----

History....

I did the original NUMA NFS server architecture and implementation
work on Irix Origin NUMA machines. Greg took that architecture and
made it work on Linux Altix NUMA machines. The differences in OS
implementation and the general lack of NUMA and hardware topology
support in Linux meant that things had to be done differently on
Linux. The Linux project was a much bigger and complex undertaking,
and Greg did most of that work.

The original Irix architecture was per-node NICs and FC HBAs.  The
per-node HBAs were attached to shared storage via a multi-path FC
SAN, and the NICS were bonded to the local switch and load balanced.
Every node had the same network and storage bandwdith - I think it
was 4x1GbE and 2x2Gb FC ports per 8p/32GB node.

IOWs, roughly 400MB/s per numa node to/from network, to/from disk.

On Irix, the NICs and storage hardware were always configured at
startup to be affine to the nearest CPU node. The OS knew the
physical topology of every piece of hardware in the system, and knew
what NUMA node they should be bound to. Nothing needed manual
configuration to be node affine.

Because we were dealing with networks of thousands of NFS clients
(think 2000s era renderwalls) we used ip/port hash based load
balancing across all the NIC ports in the machine. This effectively
always drove the requests from a single client on the network to a
specific NIC on the server. With the NICs being bound to a specific
node, we essentially sharded per-client information into per-node
structures (e.g. duplicate request detection). Hence most requests
rarely need cross-node structure access. Incoming requests were
processed on the local node, and any IO that the local NFSd needed
to do through XFS was sent directly out the HBAs on the local node
and completions were signalled back to that node.

Essentially, all the requests, the processing and IO for a specific
client ended up being bound to a specific NUMA node. The largest
Irix machines we shipped as dedicated NAS boxes were 4 node O300
machines. They had 32 600Mhz r18k MIPS CPUs, 192GB RAM, 16 GbE
ports, 8xFC HBA ports and they scaled out to a bit over 1.2GB/s
to/from the network to/from storage. That doesn't seem like much
these days, but this was back in 2005....

There was relatively little that needed to change in Irix to do
this. It largely had all the functionality it already needed, and so
it was largely a simple matter of connecting existing dots once the
overall architecture was worked out.

OTOH, at the time Linux didn't really have a concept of physical
hardware topology. All interrupt vectoring had to be set up manually
in userspace to point them at the right node. The network drivers
didn't use node affine memory to fill receive rings. The bonding
driver didn't support the whacky arp games the Irix driver
utilised to do it's thing. The network stack performance was a long
way behind Irix. The nfsd didn't support dynamic worker thread
instantiation. The scheduler didn't really understand numa topology
or node affinity very well. The list went on.

These were some of the problems that Greg and other SGI people
addressed - that was *much* more work that what I had to do
originally to get this all to work on Irix, even though the overall
architecture was largely the same.

-- 
Dave Chinner
david@fromorbit.com

