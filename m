Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29FE316571
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Feb 2021 12:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBJLo4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Feb 2021 06:44:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230328AbhBJLmn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Feb 2021 06:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612957275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wL4SG9uMFV+mFhCtvdkD+pczNWZ7HBnX4eYd8blqO0A=;
        b=UHePbQJ1JbYgCfKOUxu8TkvDrzHcyFIq5s222tYydfIaBrsNoyD5tjKwAX1A/ntMbQITQ5
        R0ZL33PVv0+MuTazmQMfjDe88SuFmxrEEONkWpKtejcPgIYSeWltunx0pbxEIEV/ND3wjt
        O4bv+jumnCASr3nSxaR2OBom5/PpKQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-NB1JMqSQO_6iEkM3iVqzsw-1; Wed, 10 Feb 2021 06:41:11 -0500
X-MC-Unique: NB1JMqSQO_6iEkM3iVqzsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37F975B364;
        Wed, 10 Feb 2021 11:41:10 +0000 (UTC)
Received: from carbon (unknown [10.36.110.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65EF560BE2;
        Wed, 10 Feb 2021 11:41:03 +0000 (UTC)
Date:   Wed, 10 Feb 2021 12:41:03 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, brouer@redhat.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: alloc_pages_bulk()
Message-ID: <20210210124103.56ed1e95@carbon>
In-Reply-To: <20210210084155.GA3697@techsingularity.net>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
        <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
        <20210209113108.1ca16cfa@carbon>
        <20210210084155.GA3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 10 Feb 2021 08:41:55 +0000
Mel Gorman <mgorman@techsingularity.net> wrote:

> On Tue, Feb 09, 2021 at 11:31:08AM +0100, Jesper Dangaard Brouer wrote:
> > > > Neil Brown pointed me to this old thread:
> > > > 
> > > > https://lore.kernel.org/lkml/20170109163518.6001-1-mgorman@techsingularity.net/
> > > > 
> > > > We see that many of the prerequisites are in v5.11-rc, but
> > > > alloc_page_bulk() is not. I tried forward-porting 4/4 in that
> > > > series, but enough internal APIs have changed since 2017 that
> > > > the patch does not come close to applying and compiling.  
> > 
> > I forgot that this was never merged.  It is sad as Mel showed huge
> > improvement with his work.
> >   
> > > > I'm wondering:
> > > > 
> > > > a) is there a newer version of that work?
> > > >   
> > 
> > Mel, why was this work never merged upstream?
> >   
> 
> Lack of realistic consumers to drive it forward, finalise the API and
> confirm it was working as expected. It eventually died as a result. If it
> was reintroduced, it would need to be forward ported and then implement
> at least one user on top.

I guess I misunderstood you back in 2017. I though that I had presented
a clear use-case/consumer in page_pool[1].  But you wanted the code as
part of the patchset I guess.  I though, I could add it later via the
net-next tree.

It seems that Chuck now have a NFS use-case, and Hellwig also have a
use-case for DMA-iommu in __iommu_dma_alloc_pages.

The performance improvement (in above link) were really impressive!

Quote:
 "It's roughly a 50-70% reduction of allocation costs and roughly a halving of the
 overall cost of allocating/freeing batches of pages."

Who have time to revive this patchset?

I can only signup for coding the page_pool usage.
Chuck do you have time if Mel doesn't?

[1] https://github.com/torvalds/linux/blob/master/net/core/page_pool.c#L201-L209
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

