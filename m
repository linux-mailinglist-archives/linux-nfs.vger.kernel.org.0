Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB53EABCF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhHLUdP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhHLUdP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 16:33:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65897C061756
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 13:32:49 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5814D7C76; Thu, 12 Aug 2021 16:32:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5814D7C76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1628800368;
        bh=rCcz+AzZpYtYx1ljjsHKu5iTgjnc1aCgOmEQnm4X+68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhSfDxRzcy5wkJrh6QFa/ut4Vq/tj5zJDaKm//Ud8vetVPH36M68qILIWPkA9mHca
         R2ZE39+B2RiwB/5meYjwrf3O4YKZvI7cjRXenGXH6PSk6zc78KwG+cMM1F8NYKMrxE
         BXqzYQMqpyH3CqBgSTbo0/w2fUJeTtk1Inm1ZeAM=
Date:   Thu, 12 Aug 2021 16:32:48 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     schumaker.anna@gmail.com
Cc:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@Netapp.com
Subject: Re: [PATCH] sunrpc: Avoid a KASAN slab-out-of-bounds bug in
 xdr_set_page_base()
Message-ID: <20210812203248.GA907@fieldses.org>
References: <20210609210729.254578-1-Anna.Schumaker@Netapp.com>
 <20210614231440.GD16500@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614231440.GD16500@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 14, 2021 at 07:14:40PM -0400, bfields wrote:
> On Wed, Jun 09, 2021 at 05:07:29PM -0400, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > This seems to happen fairly easily during READ_PLUS testing on NFS v4.2.
> 
> Yep, I hit a KASAN warning here every time, and this fixes it,
> thanks.--b.

By the way, config NFS_V4_2_READ_PLUS still says:

	This is intended for developers only. The READ_PLUS operation
	has been shown to have issues under specific conditions and
	should not be used in production.

But this warning was the only thing I was seeing.  Is there another
known issue remaining?

--b.

> 
> > I found that we could end up accessing xdr->buf->pages[pgnr] with a pgnr
> > greater than the number of pages in the array. So let's just return
> > early if we're setting base to a point at the end of the page data and
> > let xdr_set_tail_base() handle setting up the buffer pointers instead.
> > 
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  net/sunrpc/xdr.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 3964ff74ee51..ca10ba2626f2 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -1230,10 +1230,9 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
> >  	void *kaddr;
> >  
> >  	maxlen = xdr->buf->page_len;
> > -	if (base >= maxlen) {
> > -		base = maxlen;
> > -		maxlen = 0;
> > -	} else
> > +	if (base >= maxlen)
> > +		return 0;
> > +	else
> >  		maxlen -= base;
> >  	if (len > maxlen)
> >  		len = maxlen;
> > -- 
> > 2.32.0
