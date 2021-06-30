Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F943B81A9
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhF3MI3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 08:08:29 -0400
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:45151 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234349AbhF3MI3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 08:08:29 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 6A5E51C43BC
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 13:05:59 +0100 (IST)
Received: (qmail 24999 invoked from network); 30 Jun 2021 12:05:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Jun 2021 12:05:59 -0000
Date:   Wed, 30 Jun 2021 13:05:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, brouer@redhat.com
Subject: Re: [PATCH v3] mm/page_alloc: Further fix __alloc_pages_bulk()
 return value
Message-ID: <20210630120557.GK3840@techsingularity.net>
References: <162497449506.16614.7781489905877008435.stgit@klimt.1015granger.net>
 <be9186d9-1e8e-4d99-ab0f-84c0518025c5@redhat.com>
 <20210630065855.GH3840@techsingularity.net>
 <543ef038-d50c-f035-bd9d-ae3140ca0e33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <543ef038-d50c-f035-bd9d-ae3140ca0e33@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 30, 2021 at 01:22:24PM +0200, Jesper Dangaard Brouer wrote:
> 
> On 30/06/2021 08.58, Mel Gorman wrote:
> > On Tue, Jun 29, 2021 at 06:01:12PM +0200, Jesper Dangaard Brouer wrote:
> > > On 29/06/2021 15.48, Chuck Lever wrote:
> > > 
> > > > The call site in __page_pool_alloc_pages_slow() also seems to be
> > > > confused on this matter. It should be attended to by someone who
> > > > is familiar with that code.
> > > I don't think we need a fix for __page_pool_alloc_pages_slow(), as the array
> > > is guaranteed to be empty.
> > > 
> > > But a fix would look like this:
> > > 
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index c137ce308c27..1b04538a3da3 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -245,22 +245,23 @@ static struct page
> > > *__page_pool_alloc_pages_slow(struct page_pool *pool,
> > >          if (unlikely(pp_order))
> > >                  return __page_pool_alloc_page_order(pool, gfp);
> > > 
> > >          /* Unnecessary as alloc cache is empty, but guarantees zero count */
> > > -       if (unlikely(pool->alloc.count > 0))
> > > +       if (unlikely(pool->alloc.count > 0))   // ^^^^^^^^^^^^^^^^^^^^^^
> > >                  return pool->alloc.cache[--pool->alloc.count];
> > > 
> > >          /* Mark empty alloc.cache slots "empty" for alloc_pages_bulk_array
> > > */
> > >          memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
> > > 
> > > +       /* bulk API ret value also count existing pages, but array is empty
> > > */
> > >          nr_pages = alloc_pages_bulk_array(gfp, bulk, pool->alloc.cache);
> > >          if (unlikely(!nr_pages))
> > >                  return NULL;
> > > 
> > >          /* Pages have been filled into alloc.cache array, but count is zero
> > > and
> > >           * page element have not been (possibly) DMA mapped.
> > >           */
> > > -       for (i = 0; i < nr_pages; i++) {
> > > +       for (i = pool->alloc.count; i < nr_pages; i++) {
> > That last part would break as the loop is updating pool->alloc_count.
>
> The last part "i = pool->alloc.count" probably is a bad idea.

It is because it confuses the context, either alloc.count is guaranteed
zero or it's not. Initialised as zero, it's fairly clear that it's a)
always zero and b) the way i and alloc.count works mean that the array
element pointing to a freed page is either ignored or overwritten by a
valid page pointer in a later loop iteration.

-- 
Mel Gorman
SUSE Labs
