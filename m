Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B75031BEAD
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 17:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhBOQP7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 11:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231948AbhBOQMR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 11:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613405450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGz5aMZ2jUE7VsZQ0p6DHdAUwcF8yoK7x2FH4KaV5ws=;
        b=NKYlTdy8uzaenOkMO2jRgxysmPl2yrK9ctqnsV3+EALcZtFKgyVuu7mLaoFDpXYmZGoPzt
        MeeVMSjaOg7dxoTV7Gffd93nPgBu6V2kcmK5qQ126yFKWEKC4x6ou9qhSsNrvBgAPidnWr
        hfFhm9/PeEl2Lv6zhhGm/yI8ZQq4q7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-QWwqF1qcM4as0fDR0HtNpg-1; Mon, 15 Feb 2021 11:10:46 -0500
X-MC-Unique: QWwqF1qcM4as0fDR0HtNpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B02B801962;
        Mon, 15 Feb 2021 16:10:45 +0000 (UTC)
Received: from carbon (unknown [10.36.110.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 498B45D9C0;
        Mon, 15 Feb 2021 16:10:39 +0000 (UTC)
Date:   Mon, 15 Feb 2021 17:10:38 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Mel Gorman <mgorman@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jakub Kicinski <kuba@kernel.org>, brouer@redhat.com
Subject: Re: alloc_pages_bulk()
Message-ID: <20210215171038.42f62438@carbon>
In-Reply-To: <20210215120056.GD3697@techsingularity.net>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
        <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
        <20210209113108.1ca16cfa@carbon>
        <20210210084155.GA3697@techsingularity.net>
        <20210210124103.56ed1e95@carbon>
        <20210210130705.GC3629@suse.de>
        <B123FB11-661F-45A6-8235-2982BF3C4B83@oracle.com>
        <20210211091235.GC3697@techsingularity.net>
        <20210211132628.1fe4f10b@carbon>
        <20210215120056.GD3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On Mon, 15 Feb 2021 12:00:56 +0000
Mel Gorman <mgorman@techsingularity.net> wrote:

> On Thu, Feb 11, 2021 at 01:26:28PM +0100, Jesper Dangaard Brouer wrote:
[...]
> 
> > I also suggest the API can return less pages than requested. Because I
> > want to to "exit"/return if it need to go into an expensive code path
> > (like buddy allocator or compaction).  I'm assuming we have a flags to
> > give us this behavior (via gfp_flags or alloc_flags)?
> >   
> 
> The API returns the number of pages returned on a list so policies
> around how aggressive it should be allocating the requested number of
> pages could be adjusted without changing the API. Passing in policy
> requests via gfp_flags may be problematic as most (all?) bits are
> already used.

Well, I was just thinking that I would use GFP_ATOMIC instead of
GFP_KERNEL to "communicate" that I don't want this call to take too
long (like sleeping).  I'm not requesting any fancy policy :-)


For page_pool use case we use (GFP_ATOMIC | __GFP_NOWARN) flags.

static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
{
	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);

	return page_pool_alloc_pages(pool, gfp);
}

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

