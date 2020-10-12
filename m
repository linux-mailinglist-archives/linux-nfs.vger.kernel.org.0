Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E3828BE0F
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Oct 2020 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403860AbgJLQd5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Oct 2020 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403861AbgJLQd4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Oct 2020 12:33:56 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1501C0613D0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Oct 2020 09:33:56 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C1D8C69C3; Mon, 12 Oct 2020 12:33:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C1D8C69C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602520435;
        bh=Hqf2J3XEyD6rJzGR+EPW1rcNZ9YGWIDYy7Wr1Xmk0C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mduu6wp50AF7bYv6IOjza8LnHUiRQuq4yiIiJjqHVhQRNHnkBV3v8hQ7N6wXt08kQ
         0VYPPeSkhbgfOvvxYGMoesBcqHvUs6Cs7DrY/wZz8MGKTFzsixR/niUbpu3pEuspGW
         90V8JIBUMg8mjbi7eXV3IZLzwqmHnk8aSolzv1Vg=
Date:   Mon, 12 Oct 2020 12:33:55 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Message-ID: <20201012163355.GF26571@fieldses.org>
References: <20201011075913.GA8065@eldamar.lan>
 <20201012142602.GD26571@fieldses.org>
 <20201012154159.GA49819@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012154159.GA49819@eldamar.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 12, 2020 at 05:41:59PM +0200, Salvatore Bonaccorso wrote:
> Hi Bruce,
> 
> Thanks a lot for your reply, much appreciated.
> 
> On Mon, Oct 12, 2020 at 10:26:02AM -0400, J. Bruce Fields wrote:
> > On Sun, Oct 11, 2020 at 09:59:13AM +0200, Salvatore Bonaccorso wrote:
> > > Hi
> > > 
> > > On a system running 4.19.146-1 in Debian buster an issue got hit,
> > > while the server was under some slight load, but it does not seem
> > > easily reproducible, so asking if some more information can be
> > > provided to track/narrow this down. On the console the following was
> > > caught:
> > 
> > Worth checking git logs of fs/nfsd/nfs4state.c and
> > fs/nfsd/nfs4callback.c.  It might be
> > 2bbfed98a4d82ac4e7abfcd4eba40bddfc670b1d "nfsd: Fix races between
> > nfsd4_cb_release() and nfsd4_shutdown_callback()" ?
> 
> That might be possible. As it was not possible to simply trigger the
> issue, do you know if it is possible to simply reproduce the issue
> fixed in the above?

I don't have a reproducer.

--b.

> 
> 2bbfed98a4d8 ("nfsd: Fix races between nfsd4_cb_release() and
> nfsd4_shutdown_callback()") would be missing in the v4.19.y stable
> series (as it was in 5.5-rc1 but not backported to other stable
> versions).
> 
> Regards,
> Salvatore
