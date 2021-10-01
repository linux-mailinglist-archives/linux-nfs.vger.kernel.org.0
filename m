Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C941F5D5
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 21:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhJATpD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 15:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhJATpD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 15:45:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D66CC061775
        for <linux-nfs@vger.kernel.org>; Fri,  1 Oct 2021 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XiYRe7l+AkFXd4W8/qljO00jcN54Re+n4pMLJBImcn4=; b=iQI6FiASRn2habvKhbw6JQqj52
        OKre4X2XWAD4zcFFS6NAZUIei9XMNcRLT85OPvTamROTSOr6+OC70n1Bre4z3l7ppfXJJwTbMBMu5
        PS5B3glxN8RhlLhnHnQzECNI5VmCXUdW5fb4SThejwj9nxD3mMh9nLfO7S7PWzXwcTcVJ87Oya+qc
        RH8rjyCPRWBl5eHSAKwK5gmdomKGrz/LSgdNonQA+TSO3xUe1vSS0KAS//Bg5ifXw7WGWEOUMA925
        /AB1+s3jE5kptfbxsYbi0NcK39gypiHAjjfRvN52ZirZVGRp1oK06oW+1RgQuWxg2l2B6pnRQTeHV
        ZSUTwNxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWOQT-00EDKy-Sm; Fri, 01 Oct 2021 19:42:39 +0000
Date:   Fri, 1 Oct 2021 20:42:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: Can the GFP flags to releasepage() be trusted? -- was Re: [PATCH
 v2 3/8] nfs: Move to using the alternate fallback fscache I/O API
Message-ID: <YVdkqUrwcPUqhF6d@casper.infradead.org>
References: <97eb17f51c8fd9a89f10d9dd0bf35f1075f6b236.camel@hammerspace.com>
 <163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk>
 <163189108292.2509237.12615909591150927232.stgit@warthog.procyon.org.uk>
 <CALF+zO=165sRYRaxPpDS7DaQCpTe-YOa4FamSoMy5FV2uuG5Yg@mail.gmail.com>
 <81120.1633099916@warthog.procyon.org.uk>
 <23033528036059af4633f60b8325e48eab95ac36.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23033528036059af4633f60b8325e48eab95ac36.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 01, 2021 at 03:04:08PM +0000, Trond Myklebust wrote:
> On Fri, 2021-10-01 at 15:51 +0100, David Howells wrote:
> > Trond Myklebust <trondmy@hammerspace.com> wrote:
> > 
> > > > > @@ -432,7 +432,12 @@ static int nfs_release_page(struct page
> > > > > *page, gfp_t gfp)
> > > > >         /* If PagePrivate() is set, then the page is not
> > > > > freeable */
> > > > >         if (PagePrivate(page))
> > > > >                 return 0;
> > > > > -       return nfs_fscache_release_page(page, gfp);
> > > > > +       if (PageFsCache(page)) {
> > > > > +               if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp &
> > > > > __GFP_FS))
> > > > > +                       return false;
> > > > > +               wait_on_page_fscache(page);
> > > > > +       }
> > > > > +       return true;
> > > > >  }
> > > 
> > > I've found this generally not to be safe. The VM calls -
> > > >release_page()
> > > from a variety of contexts, and often fails to report it correctly
> > > in
> > > the gfp flags. That's particularly true of the stuff in
> > > mm/vmscan.c.
> > > This is why we have the check above that vetos page removal upon
> > > PagePrivate() being set.
> > 
> > [Adding Willy and the mm crew to the cc list]
> > 
> > I wonder if that matters in this case.  In the worst case, we'll wait
> > for the
> > page to cease being DMA'd - but we won't return true if it is.
> > 
> > But if vmscan is generating the wrong VM flags, we should look at
> > fixing that.
> > 
> > 
> 
> To elaborate a bit: we used to have code here that would check whether
> the page had been cleaned but was unstable, and if an argument of
> GFP_KERNEL or above was set, we'd try to call COMMIT to ensure the page
> was synched to disk on the server (and we'd wait for that call to
> complete).
> 
> That code would end up deadlocking in all sorts of horrible ways, so we
> ended up having to pull it.

Based on having read zero code at all in this area ...

Is it possible that you can wait for an existing operation to finish,
but starting a new operation will take a lock that is already being
held somewhere in your call chain?  So it's not that the gfp flags are
being set incorrectly, it's just that you're not in a context where you
can start a new operation.
