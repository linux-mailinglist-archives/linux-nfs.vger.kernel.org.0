Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0A43F8FC2
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhHZUnO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 16:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhHZUnK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 16:43:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7028DC061757
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 13:42:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E16AC61D7; Thu, 26 Aug 2021 16:42:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E16AC61D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630010541;
        bh=q3Hk3rMUpa5k2bFG+qHeogZ2h3fa0xwj5jLDgwqR/l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3K248OEFV3DWa2QhJvuZs5gjypINwUcYCshSeTjiAr1Vjf0jwsehdlfPiWPhKUdP
         P5ZstmIMD5cwe4GJnPSUQbqqdVZMm1t+yxKPE+SslG2ZdAiTqsa5mZuyLd2DK/P0uL
         Xr2AiNjwcVS+aDpw7aeHEs4mGM2I8fLUOALL+HSM=
Date:   Thu, 26 Aug 2021 16:42:21 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Trond Myklebust <Trond.Myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: Avoid a KASAN slab-out-of-bounds bug in
 xdr_set_page_base()
Message-ID: <20210826204221.GC10730@fieldses.org>
References: <20210609210729.254578-1-Anna.Schumaker@Netapp.com>
 <20210614231440.GD16500@fieldses.org>
 <20210812203248.GA907@fieldses.org>
 <CAFX2Jf=b1JwPRaC35rKbX5bD821h1dsEj6opYW9eZET171Zd6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jf=b1JwPRaC35rKbX5bD821h1dsEj6opYW9eZET171Zd6A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 26, 2021 at 03:44:32PM -0400, Anna Schumaker wrote:
> On Thu, Aug 12, 2021 at 4:32 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Jun 14, 2021 at 07:14:40PM -0400, bfields wrote:
> > > On Wed, Jun 09, 2021 at 05:07:29PM -0400, schumaker.anna@gmail.com wrote:
> > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > >
> > > > This seems to happen fairly easily during READ_PLUS testing on NFS v4.2.
> > >
> > > Yep, I hit a KASAN warning here every time, and this fixes it,
> > > thanks.--b.
> >
> > By the way, config NFS_V4_2_READ_PLUS still says:
> >
> >         This is intended for developers only. The READ_PLUS operation
> >         has been shown to have issues under specific conditions and
> >         should not be used in production.
> >
> > But this warning was the only thing I was seeing.  Is there another
> > known issue remaining?
> 
> I think it was an issue around using lseek to generate the reply. The
> file contents could change between each call, leading to inconsistent
> results (and a new failing xfstest that previously passed)

OK, thanks, I see now that you mentioned in 21e31401fc45 "NFS: Disable
READ_PLUS by default" that there were generic/091 and generic/263
failures.

Looks like they're both testing concurrent direct and buffered IO.  I
don't know what we try to guarantee in that case.

--b.

> 
> Anna
> 
> >
> > --b.
> >
> > >
> > > > I found that we could end up accessing xdr->buf->pages[pgnr] with a pgnr
> > > > greater than the number of pages in the array. So let's just return
> > > > early if we're setting base to a point at the end of the page data and
> > > > let xdr_set_tail_base() handle setting up the buffer pointers instead.
> > > >
> > > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > ---
> > > >  net/sunrpc/xdr.c | 7 +++----
> > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > > > index 3964ff74ee51..ca10ba2626f2 100644
> > > > --- a/net/sunrpc/xdr.c
> > > > +++ b/net/sunrpc/xdr.c
> > > > @@ -1230,10 +1230,9 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
> > > >     void *kaddr;
> > > >
> > > >     maxlen = xdr->buf->page_len;
> > > > -   if (base >= maxlen) {
> > > > -           base = maxlen;
> > > > -           maxlen = 0;
> > > > -   } else
> > > > +   if (base >= maxlen)
> > > > +           return 0;
> > > > +   else
> > > >             maxlen -= base;
> > > >     if (len > maxlen)
> > > >             len = maxlen;
> > > > --
> > > > 2.32.0
