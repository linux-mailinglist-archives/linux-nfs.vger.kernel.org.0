Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513F7349AD4
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 21:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCYUJf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 16:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYUJ1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 16:09:27 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268AC06174A
        for <linux-nfs@vger.kernel.org>; Thu, 25 Mar 2021 13:09:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 680FE6D18; Thu, 25 Mar 2021 16:09:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 680FE6D18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1616702966;
        bh=+zf/AwflHb+wUTy9m4OXGAJWxxRZvXgH601Os6n4K/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqiSQ91hhCFDzJ+imD9FFmC7i8Rv0udO+zDy/ppbGs8Sn3TxYdd0PJC/ecbUqGO9I
         MSOZECXaZilne0jWfy/SboTCPE4rtzBX+ospUdnnX6hur4S0P4fSWk9ebnL6qTqkNP
         CSo9sj5EFIv/TnylTjvJjloP+g7+kbW7uNvolBks=
Date:   Thu, 25 Mar 2021 16:09:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Steve Dickson <steved@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] exportfs: fix unexporting of '/'
Message-ID: <20210325200926.GB18351@fieldses.org>
References: <20210322210238.96915-1-omosnace@redhat.com>
 <20210325191903.GA18351@fieldses.org>
 <CAFqZXNsg7XTEbzxEz+7oO9DLFTu=6-LzwXJpOdTZTzj5Td_2Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNsg7XTEbzxEz+7oO9DLFTu=6-LzwXJpOdTZTzj5Td_2Ng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 25, 2021 at 08:48:57PM +0100, Ondrej Mosnacek wrote:
> On Thu, Mar 25, 2021 at 8:27 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > On Mon, Mar 22, 2021 at 10:02:38PM +0100, Ondrej Mosnacek wrote:
> > > The code that has been added to strip trailing slashes from path in
> > > unexportfs_parsed() forgot to account for the case of the root
> > > directory, which is simply '/'. In that case it accesses path[-1] and
> > > reduces the path to an empty string, which then fails to match any
> > > export.
> > >
> > > Fix it by stopping the stripping when the path is just a single
> > > character - it doesn't matter if it's a '/' or not, we want to keep it
> > > either way in that case.
> >
> > Makes sense to me.
> >
> > (Note nfs-exporting / is often a bad idea.  I assume you had some good
> > reason in this case.)
> 
> I hit it in a test, so if the only issue is that it exposes more than
> necessary, then I guess it's fine in this case :)

Yes, in a lot of typical setups, exporting "/" would expose files to the
network that you don't really want to.

But, anyway, it should work.  Looks like a good fix.

--b.

> 
> >
> > --b.
> >
> > >
> > > Reproducer:
> > >
> > >     exportfs localhost:/
> > >     exportfs -u localhost:/
> > >
> > > Without this patch, the unexport step fails with "exportfs: Could not
> > > find 'localhost:/' to unexport."
> > >
> > > Fixes: a9a7728d8743 ("exportfs: Deal with path's trailing "/" in unexportfs_parsed()")
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1941171
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  utils/exportfs/exportfs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> > > index 262dd19a..1aedd3d6 100644
> > > --- a/utils/exportfs/exportfs.c
> > > +++ b/utils/exportfs/exportfs.c
> > > @@ -383,7 +383,7 @@ unexportfs_parsed(char *hname, char *path, int verbose)
> > >        * so need to deal with it.
> > >       */
> > >       size_t nlen = strlen(path);
> > > -     while (path[nlen - 1] == '/')
> > > +     while (nlen > 1 && path[nlen - 1] == '/')
> > >               nlen--;
> > >
> > >       for (exp = exportlist[htype].p_head; exp; exp = exp->m_next) {
> > > --
> > > 2.30.2
> >
> 
> 
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
