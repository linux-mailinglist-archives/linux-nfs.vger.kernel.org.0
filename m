Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C728099C
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 23:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgJAVru (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 17:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAVru (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 17:47:50 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314BEC0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 14:47:50 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 959196192; Thu,  1 Oct 2020 17:47:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 959196192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601588869;
        bh=+HHW5/8+IJ9Z1KssUsp/rV3T0cffctVAKjBOiBsGCWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vlbiQG9VBaU0jjb4mOSt+8x2Q9hJJas7Tm4IUFvEu7zWmfVDnvma5Rqy79GJoENsh
         D2hKazNKePAxfkPGb8kjQ6SqpMVnCpia363/b6xRxq7IrzPP3oyPhmiiEqFM/A7KqH
         DBQobz2wtUP2WCLttiKl1Iuq2UtfydWlWoAHe0IE=
Date:   Thu, 1 Oct 2020 17:47:49 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: client caching and locks
Message-ID: <20201001214749.GK1496@fieldses.org>
References: <20200608211945.GB30639@fieldses.org>
 <OSBPR01MB2949040AA49BC9B5F104DA1FEF9B0@OSBPR01MB2949.jpnprd01.prod.outlook.com>
 <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
 <20200618200905.GA10313@fieldses.org>
 <20200622135222.GA6075@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622135222.GA6075@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 22, 2020 at 09:52:22AM -0400, bfields@fieldses.org wrote:
> On Thu, Jun 18, 2020 at 04:09:05PM -0400, bfields@fieldses.org wrote:
> > I probably don't understand the algorithm (in particular, how it
> > revalidates caches after a write).
> > 
> > How does it avoid a race like this?:
> > 
> > Start with a file whose data is all 0's and change attribute x:
> > 
> >         client 0                        client 1
> >         --------                        --------
> >         take write lock on byte 0
> >                                         take write lock on byte 1
> >         write 1 to offset 0
> >           change attribute now x+1
> >                                         write 1 to offset 1
> >                                           change attribute now x+2
> >         getattr returns x+2
> >                                         getattr returns x+2
> >         unlock
> >                                         unlock
> > 
> >         take readlock on byte 1
> > 
> > At this point a getattr will return change attribute x+2, the same as
> > was returned after client 0's write.  Does that mean client 0 assumes
> > the file data is unchanged since its last write?
> 
> Basically: write-locking less than the whole range doesn't prevent
> concurrent writes outside that range.  And the change attribute gives us
> no way to identify whether concurrent writes have happened.  (At least,
> not without NFS4_CHANGE_TYPE_IS_VERSION_COUNTER.)
> 
> So as far as I can tell, a client implementation has no reliable way to
> revalidate its cache outside the write-locked area--instead it needs to
> just throw out that part of the cache.

Does my description of that race make sense?

--b.
