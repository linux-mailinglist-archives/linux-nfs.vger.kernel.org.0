Return-Path: <linux-nfs+bounces-4040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE090E0F6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 02:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524EB1C21DB3
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 00:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5E44405;
	Wed, 19 Jun 2024 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AnUVgVGO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45383FD4
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757764; cv=none; b=Ui7Cf8y/KLakV9LHrvP36j+Zv681kIabpMXfyi/XAGNVbBIaunAe40UHhMmIne4X7bck4aFozHcZJDgzbo2ZVpH7E2soICaUu7FVlSDZtzNrs8mbHL+ogTGJRJ/8ANLVt49Ldmzv9/S8BefjWy5A3M+VdV098IacjaEECjFBz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757764; c=relaxed/simple;
	bh=V8IIlGB5HSbXGMvD/HfModZvC8lRc9jqnuzwf7BwnzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIcc1pvGSRsPHyZ2+l53PrP0bwTbSBngC7Nb5OldSW3jecHfvnrpCF0jhOvvk7xUGBN75LRVl++zyd81AkLILLQmfmA4TiuMY/1bf2Z5yT/C/z7I1wntix9n4khHnggrJEF4AjYGmqNdvmt3prY3lAjidbVp6iOXG57Gn6wJFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AnUVgVGO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f44b594deeso56267585ad.2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 17:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718757762; x=1719362562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7hcqdgsagU8CABw63hCI2Sib+PiH9YgA6LPV3G5etnM=;
        b=AnUVgVGOJAVDqoNcM1ZV16kVt5pBrlxnEVs3/5clmpiykJIrEN/CE+G3aZmdmMrAZU
         e4Z/A9npKF+t7z++eJ3XIxrW9KVvVrhLxxTrJY9a8r7fiZyq48LdTRo+8DEAA2jdQFqA
         j04RbFVNRO8ki4OpFDU9HTv9JKK/VohfOi0ub/DusuXlRr35LLKFWUU9gdW5Iu5eaOy9
         wC6JE9tJLa+C+TmPvzJlcOOS7nUr8JpUppGpIxSoEmffYQYisBSEdLREImhuJzImYljH
         C8YUZug0DSeas5qHsiCS/H0CBqmu3hV6xgmZI+9658vTly79NVdl3d5DLaV2XD4gWbBU
         MmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718757762; x=1719362562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hcqdgsagU8CABw63hCI2Sib+PiH9YgA6LPV3G5etnM=;
        b=LSjx0DnagmMJ18HZZj7YqgyHR/phgDmHOo4p4m92Wu+k8ttlFNM3SHPx1GS8wbCEV9
         2XcnFINt0JN05fVj6j2yiazKvz91NEXUCfU3iXH0s3pjEAAXvOl2yLRb9d02E//J5kco
         tBWdtlFHORrpYVaIoVlfsT20DsrnqNpeGUiE3B49rwAHjKViTk+zhsE9WscJWVVY2CJo
         GZUV27+o3/z0fRhZhniUfq/4Zk3Wia/j0mOMLMcQMvMcHYzukQcslQmDQbmxX9UgxOW1
         VQjAg2YrPp+ZkOUDJSj7pJn0eS7XoJDkGhgvAxpBL2tEb56lSMM427WA6TFZBX7EC4TA
         AsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcVRmVKABmyB/heBCOzPCCye2FRJnBRWmZa/a534SKpXBQ2q1BGZ6z+M/Om+wr7KJPCHoG5Muv8Jg22FXb2ln1mynhTyMbE1WL
X-Gm-Message-State: AOJu0YxienqwjPcSgZipYEO/T4wFo34rIu7r6g2hjViMi0NoSFc+AT4u
	t7tkLOmIm+31Kg8h9kN3FOBAODocLzpdGNTBklkrT8KzJ0hyCHh2Glcd/zpQGLQ=
X-Google-Smtp-Source: AGHT+IHkLUuxrtVyV+Duaw1kX4CVXhP9e1x/sJflmWcIgPqv6lmrJECdKXWQM+J/71WXGxKCXATErA==
X-Received: by 2002:a17:903:94b:b0:1f8:3c47:9da6 with SMTP id d9443c01a7336-1f9aaa5dbe2mr13715325ad.69.1718757761707;
        Tue, 18 Jun 2024 17:42:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9b000bffdsm1153435ad.107.2024.06.18.17.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 17:42:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sJjPK-003KHz-1O;
	Wed, 19 Jun 2024 10:42:38 +1000
Date: Wed, 19 Jun 2024 10:42:38 +1000
From: Dave Chinner <david@fromorbit.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"neilb@suse.com" <neilb@suse.com>
Subject: Re: knfsd performance
Message-ID: <ZnIpfgCrRe95sXdr@dread.disaster.area>
References: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
 <58A84B36-C121-46F8-ABCB-BE4F212E9C81@oracle.com>
 <754f3e0f6f962cbd46b2b22e87d9de9f8b285ab4.camel@hammerspace.com>
 <7FFACD6E-86D2-4D14-BF03-77081B4CFF38@oracle.com>
 <70766c4bd70742d0da79be50ebaf2eaeb7b18559.camel@hammerspace.com>
 <7F7971B5-C7C8-4D0B-99CB-2D6CA8235FDD@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7F7971B5-C7C8-4D0B-99CB-2D6CA8235FDD@oracle.com>

On Tue, Jun 18, 2024 at 07:54:43PM +0000, Chuck Lever III wrote  > On Jun 18, 2024, at 3:50 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > 
> > On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> >> 
> >> 
> >>> On Jun 18, 2024, at 3:29 PM, Trond Myklebust
> >>> <trondmy@hammerspace.com> wrote:
> >>> 
> >>> On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> >>>> 
> >>>> 
> >>>>> On Jun 18, 2024, at 2:32 PM, Trond Myklebust
> >>>>> <trondmy@hammerspace.com> wrote:
> >>>>> 
> >>>>> I recently back ported Neil's lwq code and sunrpc server
> >>>>> changes to
> >>>>> our
> >>>>> 5.15.130 based kernel in the hope of improving the performance
> >>>>> for
> >>>>> our
> >>>>> data servers.
> >>>>> 
> >>>>> Our performance team recently ran a fio workload on a client
> >>>>> that
> >>>>> was
> >>>>> doing 100% NFSv3 reads in O_DIRECT mode over an RDMA connection
> >>>>> (infiniband) against that resulting server. I've attached the
> >>>>> resulting
> >>>>> flame graph from a perf profile run on the server side.
> >>>>> 
> >>>>> Is anyone else seeing this massive contention for the spin lock
> >>>>> in
> >>>>> __lwq_dequeue? As you can see, it appears to be dwarfing all
> >>>>> the
> >>>>> other
> >>>>> nfsd activity on the system in question here, being responsible
> >>>>> for
> >>>>> 45%
> >>>>> of all the perf hits.

Ouch. __lwq_dequeue() runs llist_reverse_order() under a spinlock.

llist_reverse_order() is an O(n) algorithm involving full length
linked list traversal. IOWs, it's a worst case cache miss algorithm
running under a spin lock. And then consider what happens when
enqueue processing is faster than dequeue processing.

This means the depth of the queue grows, and ultimate length of the
queue is unbound. Because fo the batch processing nature of lwq -
it takes ->new, reverses it and places it in ->ready - the length of
the list that needs reversing ends up growing every batch that
we queue faster than we dequeue. Unbound processing queues are bad
even when they have O(1) behaviour. lwq has O(n) worst case
behaviour, and that makes this even worse...

Regardless, The current lwq could be slightly improved - the
lockless enqueue competes for the same cacheline as the dequeue
serialisation lock.

struct lwq {
        spinlock_t              lock;
        struct llist_node       *ready;         /* entries to be dequeued */
        struct llist_head       new;            /* entries being enqueued */
};

Adding __cacheline_aligned_in_smp to ->new (the enqueue side) might
help reduce this enqueue/dequeue cacheline contention a bit by
separating them onto different cachelines. That will push the point
of catastrophic breakdown out a little bit, not solve the issue of
queue depth based batch processing on the dequeue side.

I suspect a lockless ring buffer might be a more scalable solution
for the nfsd...

> >>>> I haven't seen that, but I've been working on other issues.
> >>>> 
> >>>> What's the nfsd thread count on your test server? Have you
> >>>> seen a similar impact on 6.10 kernels ?
> >>>> 
> >>> 
> >>> 640 knfsd threads. The machine was a supermicro 2029BT-HNR with
> >>> 2xIntel
> >>> 6150, 384GB of memory and 6xWDC SN840.
> >>> 
> >>> Unfortunately, the machine was a loaner, so cannot compare to 6.10.
> >>> That's why I was asking if anyone has seen anything similar.
> >> 
> >> If this system had more than one NUMA node, then using
> >> svc's "numa pool" mode might have helped.

It's a dual socket machine so it has at least 2 physical nodes. Of
course, the bios has to be configured to expose this as a NUMA
machine and not a "legacy SMP" machine for the OS to know that, but
I'm pretty sure that's been the typical server bios defaults for
quite a few years now.

Even if it wasn't a dual socket machine, the CPU itself is a NUMA
architecture.  i.e. just about every server x86-64 CPU sold these
days is a NUMA SOC - neither core-to-core or core-to-memory latency
is uniform within a socket these days. Desktop CPUs are also well
down this track, too.

Intel exposes the details of the topology within a socket via the
bios option known as "sub-numa clustering". This exposes the full
sub-socket CPU and memory topology to the OS, so it is fully aware
of both the on-chip and off-chip topology.

Using sub-numa clustering means we don't end up with 32+ CPUS to a
per-socket numa node. Numa scalability algorithms largely rely on
keeping the cores-per-numa-node ratio in check. Sub-numa
clustering enables the OS to keep this ratio down to reasonable
levels.

> > Interesting. I had forgotten about that setting.
> > 
> > Just out of curiosity, is there any reason why we might not want to
> > default to that mode on a NUMA enabled system?
> 
> Can't think of one off hand. Maybe back in the day it was
> hard to tell when you were actually /on/ a NUMA system.

As per above, I would assume that the kernel is *always* running on
a NUMA machine. IOWs, if CONFIG_NUMA is enabled (which it is on just
about every distro kernel these days), then we should be using NUMA
optimisations by default.

If the machine is not a NUMA machine (e.g. single socket, sub-numa
clustering off), then the NUMA subsystem will be initialised with
nr_online_nodes = 1 (i.e. a single active node) and numa aware
algorithms should just behave as if there is a single global node.
If CONFIG_NUMA=n, then nr_online_nodes is hard coded to 1.

Hence subsystems only need to implement a single algorithm that is
NUMA aware. The bios/system config will tell the kernel how many
nodes there are, and the NUMA algorithms will just do the right
thing because nr_online_nodes=1 in those situations..

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

