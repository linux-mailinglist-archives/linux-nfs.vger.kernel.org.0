Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B714DD65
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2020 15:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgA3O4M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jan 2020 09:56:12 -0500
Received: from fieldses.org ([173.255.197.46]:54150 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgA3O4M (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 Jan 2020 09:56:12 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 7654689A; Thu, 30 Jan 2020 09:56:11 -0500 (EST)
Date:   Thu, 30 Jan 2020 09:56:11 -0500
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd4: fix double free in nfsd4_do_async_copy()
Message-ID: <20200130145611.GA18127@fieldses.org>
References: <20200113132307.frp6ur5zhzolu5ys@kili.mountain>
 <CAN-5tyEEPq6JX7mMRwX+7DTJJ3zy3-=SVqfqQyXvvbOQxqgDJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyEEPq6JX7mMRwX+7DTJJ3zy3-=SVqfqQyXvvbOQxqgDJQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 21, 2020 at 04:56:31PM -0500, Olga Kornievskaia wrote:
> On Mon, Jan 13, 2020 at 8:24 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > This frees "copy->nf_src" before and again after the goto.
> >
> > Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 1e14b3ed5674..c90c24c35b2e 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1469,7 +1469,6 @@ static int nfsd4_do_async_copy(void *data)
> >                 copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> >                                               &copy->stateid);
> >                 if (IS_ERR(copy->nf_src->nf_file)) {
> > -                       kfree(copy->nf_src);
> >                         copy->nfserr = nfserr_offload_denied;
> >                         nfsd4_interssc_disconnect(copy->ss_mnt);
> >                         goto do_callback;
> > --
> > 2.11.0
> >
> 
> Reviewed-by: Olga Kornievskaia <kolga@netapp.com>
> 
> Bruce, can you add this to your nfsd-next?

Done, thanks for the reminder.

--b.
