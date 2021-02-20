Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FBC320261
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 02:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhBTBJr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 20:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBTBJq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 20:09:46 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C26C061574
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 17:09:05 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8557728E5; Fri, 19 Feb 2021 20:09:03 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8557728E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1613783343;
        bh=QKsVyXZleGD2zzTBzENsiCjrMG9pXn5mYWstYrycHUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XD7elECOu/IUS36P+oqCK1eTYqw//iuO7jZvD5w0m0l/yfUc5nt9hhZ2KHF5K2Gg5
         8R301v62yoJO2g/vOunR7Q/nMxVD84L0mMjl3As/MgnoM2r6Jl1tAio7IpA+1MDEPu
         Q8+xjsd2gltuc6Z6jz1WMPOB7Ev8fuu9dMyXcGzI=
Date:   Fri, 19 Feb 2021 20:09:03 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Dai Ngo <dai.ngo@oracle.com>, linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
Message-ID: <20210220010903.GE5357@fieldses.org>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
 <20201029190716.70481-2-dai.ngo@oracle.com>
 <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dai, do you have a copy of the original use-after-free warning?

--b.

On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
> Hi Dai (Bruce),
> 
> This patch is what broke the mount that's now left behind between the
> source server and the destination server. We are no longer dropping
> the necessary reference on the mount to go away. I haven't been paying
> as much attention as I should have been to the changes. The original
> code called fput(src) so a simple refcount of the file. Then things
> got complicated and moved to nfsd_file_put(). So I don't understand
> complexity. But we need to do some kind of put to decrement the needed
> reference on the superblock. Bruce any ideas? Can we go back to
> fput()?
> 
> On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> wrote:
> >
> > The source file nfsd_file is not constructed the same as other
> > nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
> > called to free the object; nfsd_file_put is not the inverse of
> > kzalloc, instead kfree is called by nfsd4_do_async_copy when done.
> >
> > Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index ad2fa1a8e7ad..9c43cad7e408 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
> >                         struct nfsd_file *dst)
> >  {
> >         nfs42_ssc_close(src->nf_file);
> > -       nfsd_file_put(src);
> > +       /* 'src' is freed by nfsd4_do_async_copy */
> >         nfsd_file_put(dst);
> >         mntput(ss_mnt);
> >  }
> > --
> > 2.20.1.1226.g1595ea5.dirty
> >
