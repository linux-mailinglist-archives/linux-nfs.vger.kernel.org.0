Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8479C318AC8
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Feb 2021 13:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBKMfY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Feb 2021 07:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231304AbhBKM2I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Feb 2021 07:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613046400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6m4kGX2cdA+VMa271XYlfXwmWuiLyNeCkG21zKLMcdM=;
        b=MsA0f7e0VOhHS8Bu0oXXLov258ExUH0BoKAn71kxDLHGG5kX4foEsZpDuZjRLUyK6Jhbb1
        9GwnAD1tu7sEZ/ZZuyT7VOIyCCUr69orVmR2rtjjhBxtm0QMZXEk4jixpj106hnU6MqiQa
        2zZXmhUs+KNiqeKSTPzFKUzszmLVf+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-Yy0NX-JmMby4iEnbsn-ggA-1; Thu, 11 Feb 2021 07:26:36 -0500
X-MC-Unique: Yy0NX-JmMby4iEnbsn-ggA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 058809126D;
        Thu, 11 Feb 2021 12:26:35 +0000 (UTC)
Received: from carbon (unknown [10.36.110.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5BF23A3;
        Thu, 11 Feb 2021 12:26:29 +0000 (UTC)
Date:   Thu, 11 Feb 2021 13:26:28 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Mel Gorman <mgorman@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jakub Kicinski <kuba@kernel.org>, brouer@redhat.com
Subject: Re: alloc_pages_bulk()
Message-ID: <20210211132628.1fe4f10b@carbon>
In-Reply-To: <20210211091235.GC3697@techsingularity.net>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
        <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
        <20210209113108.1ca16cfa@carbon>
        <20210210084155.GA3697@techsingularity.net>
        <20210210124103.56ed1e95@carbon>
        <20210210130705.GC3629@suse.de>
        <B123FB11-661F-45A6-8235-2982BF3C4B83@oracle.com>
        <20210211091235.GC3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 11 Feb 2021 09:12:35 +0000
Mel Gorman <mgorman@techsingularity.net> wrote:

> On Wed, Feb 10, 2021 at 10:58:37PM +0000, Chuck Lever wrote:
> > > Not in the short term due to bug load and other obligations.
> > > 
> > > The original series had "mm, page_allocator: Only use per-cpu allocator
> > > for irq-safe requests" but that was ultimately rejected because softirqs
> > > were affected so it would have to be done without that patch.
> > > 
> > > The last patch can be rebased easily enough but it only batch allocates
> > > order-0 pages. It's also only build tested and could be completely
> > > miserable in practice and as I didn't even try boot test let, let alone
> > > actually test it, it could be a giant pile of crap. To make high orders
> > > work, it would need significant reworking but if the API showed even
> > > partial benefit, it might motiviate someone to reimplement the bulk
> > > interfaces to perform better.
> > > 
> > > Rebased diff, build tested only, might not even work  
> > 
> > Thanks, Mel, for kicking off a forward port.
> > 
> > It compiles. I've added a patch to replace the page allocation loop
> > in svc_alloc_arg() with a call to alloc_pages_bulk().
> > 
> > The server system deadlocks pretty quickly with any NFS traffic. Based
> > on some initial debugging, it appears that a pcplist is getting corrupted
> > and this causes the list_del() in __rmqueue_pcplist() to fail during a
> > a call to alloc_pages_bulk().
> >   
> 
> Parameters to __rmqueue_pcplist are garbage as the parameter order changed.
> I'm surprised it didn't blow up in a spectacular fashion. Again, this
> hasn't been near any testing and passing a list with high orders to
> free_pages_bulk() will corrupt lists too. Mostly it's a curiousity to see
> if there is justification for reworking the allocator to fundamentally
> deal in batches and then feed batches to pcp lists and the bulk allocator
> while leaving the normal GFP API as single page "batches". While that
> would be ideal, it's relatively high risk for regressions. There is still
> some scope for adding a basic bulk allocator before considering a major
> refactoring effort.

The alloc_flags reminds me that I have some asks around the semantics
of the API.  I'm concerned about the latency impact on preemption.  I
want us to avoid creating something that runs for too long with
IRQs/preempt disabled.

(With SLUB kmem_cache_free_bulk() we manage to run most of the time with
preempt and IRQs enabled.  So, I'm not worried about large slab bulk
free. For SLUB kmem_cache_alloc_bulk() we run with local_irq_disable(),
so I always recommend users not to do excessive bulk-alloc.)

For this page bulk alloc API, I'm fine with limiting it to only support
order-0 pages. (This will also fit nicely with the PCP system it think).

I also suggest the API can return less pages than requested. Because I
want to to "exit"/return if it need to go into an expensive code path
(like buddy allocator or compaction).  I'm assuming we have a flags to
give us this behavior (via gfp_flags or alloc_flags)?

My use-case is in page_pool where I can easily handle not getting exact
number of pages, and I want to handle low-latency network traffic.



> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f8353ea7b977..8f3fe7de2cf7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5892,7 +5892,7 @@ __alloc_pages_bulk_nodemask(gfp_t gfp_mask, unsigned int order,
>  	pcp_list = &pcp->lists[migratetype];
>  
>  	while (nr_pages) {
> -		page = __rmqueue_pcplist(zone, gfp_mask, migratetype,
> +		page = __rmqueue_pcplist(zone, migratetype, alloc_flags,
>  								pcp, pcp_list);
>  		if (!page)
>  			break;



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

