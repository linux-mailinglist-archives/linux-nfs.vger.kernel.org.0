Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1957F5B48F3
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Sep 2022 23:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiIJVOX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Sep 2022 17:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIJVOW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Sep 2022 17:14:22 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1EA4B4BE
        for <linux-nfs@vger.kernel.org>; Sat, 10 Sep 2022 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=boyuCw461qZ2QHbvnlQAuYg55hL5On0m5nmeSI+rLt4=; b=uP+eRNm4w4AwsRKxqpA6K9yJm+
        BaPZBKZNwcf2gYvepocDUtHEBlktEWB/LJxTrWNcN3K4/5c8bO5JASDfckb44TsJQWl4r4TQ0FQyg
        jT3Klw/x1HKehrpVg0NTraXTvdQYawRIH1lPjvOnqCuB5hi5pmuT2RVV9ntsrYVXE3F5ofjvRaPes
        4fY9ImmdAL1eg94w99Y29tA0ylF5jy4KfnhMjrHHliedmd5EvizvYmmeZ0hH6kNiBQ5hBeI+MkdC9
        egHUCewoVr1oKm+XjFp1GXQ8eF9n3C4OGGZ0rmLNzWQcSYHyrLXh1pJyxGGcOmBL3T0boHdJ3+n8k
        3h9vWu5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oX7ne-00EQiv-MZ;
        Sat, 10 Sep 2022 21:14:02 +0000
Date:   Sat, 10 Sep 2022 22:14:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: Is this nfsd kernel oops known?
Message-ID: <Yxz+GhK7nWKcBLcI@ZenIV>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 07, 2022 at 08:52:46AM -0400, Benjamin Coddington wrote:
> On 7 Sep 2022, at 0:58, Chuck Lever III wrote:
> 
> > > On Sep 6, 2022, at 3:12 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > > 
> > > On Tue, Sep 6, 2022 at 2:28 PM Benjamin Coddington
> > > <bcodding@redhat.com> wrote:
> > > > 
> > > > On 1 Sep 2022, at 21:27, Olga Kornievskaia wrote:
> > > > 
> > > > > Thanks Chuck. I first, based on a hunch, narrowed down that it's
> > > > > coming from Al Viro's merge commit. Then I git bisected his
> > > > > 32patches
> > > > > to the following commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
> > > > 
> > > > No crash for me after reverting
> > > > f0f6b614f83dbae99d283b7b12ab5dd2e04df979.
> > > 
> > > I second that. No crash after a revert here.
> > 
> > I bisected the new xfstests failures to the same commit:
> > 
> > f0f6b614f83dbae99d283b7b12ab5dd2e04df979 is the first bad commit
> > commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
> > Author: Al Viro <viro@zeniv.linux.org.uk>
> > Date:   Thu Jun 23 17:21:37 2022 -0400
> > 
> >     copy_page_to_iter(): don't split high-order page in case of
> > ITER_PIPE
> > 
> >     ... just shove it into one pipe_buffer.
> > 
> >     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> >  lib/iov_iter.c | 21 ++++++---------------
> >  1 file changed, 6 insertions(+), 15 deletions(-)
> > 
> 
> I've been reliably reproducing this on generic/551 on xfs.  In the case
> where it crashes, rqstp->rq_res.page_base is positive multiple of PAGE_SIZE
> after getting set in nfsd_splice_actor(), and that with page_len overruns
> the 256 pages we have.
> 
> With f0f6b614f83d reverted, rqstp->rq_res.page_base is always zero.
> 
> After 47b7fcae419dc and f0f6b614f83d, buf->offset in nfsd_splice_actor can
> be a positive multiple of PAGE_SIZE, whereas before it was always just the
> offset into the page.
> 
> Something like this might fix it up:
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 9f486b788ed0..d62963f36f03 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -849,7 +849,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct
> pipe_buffer *buf,
> 
>         svc_rqst_replace_page(rqstp, buf->page);
>         if (rqstp->rq_res.page_len == 0)
> -               rqstp->rq_res.page_base = buf->offset;
> +               rqstp->rq_res.page_base = buf->offset % PAGE_SIZE;
>         rqstp->rq_res.page_len += sd->len;
>         return sd->len;
>  }
> 
> .. but we should check with Al about whether this needs to be fixed over in
> copy_page_to_iter_pipe(),  since I don't think pipe_buffer offset should be
> greater than PAGE_SIZE.
> 
> Al, any thoughts?

pipe_buffer offsets in general can be greater than PAGE_SIZE.  What's more,
buffer *size* can be greater than PAGE_SIZE - it really can contain more
than PAGE_SIZE worth of data.  In that case the page is a compound one, of
course.

Regression is the combination of "splice from regular file to pipe hadn't
produced that earlier, now it does" and "nfsd never needed to handle that".

I don't believe that fix is correct.  *IF* you can't deal with compound
page in sunrpc, you need a loop going by subpages in nfsd_splice_actor(),
similar to one that used to be in copy_page_to_iter().  Could you try
the following:

nfsd_splice_actor(): handle compound pages

pipe_buffer might refer to a compound page (and contain more than a PAGE_SIZE
worth of data).  Theoretically it had been possible since way back, but
nfsd_splice_actor() hadn't run into that until copy_page_to_iter() change.
Fortunately, the only thing that changes for compound pages is that we
need to stuff each relevant subpage in and convert the offset into offset
in the first subpage.

Hopefully-fixes: f0f6b614f83d "copy_page_to_iter(): don't split high-order page in case of ITER_PIPE"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9f486b788ed0..b16aed158ba6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -846,10 +846,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 		  struct splice_desc *sd)
 {
 	struct svc_rqst *rqstp = sd->u.data;
-
-	svc_rqst_replace_page(rqstp, buf->page);
-	if (rqstp->rq_res.page_len == 0)
-		rqstp->rq_res.page_base = buf->offset;
+	struct page *page = buf->page;	// may be a compound one
+	unsigned offset = buf->offset;
+
+	page += offset / PAGE_SIZE;
+	for (int i = sd->len; i > 0; i -= PAGE_SIZE)
+		svc_rqst_replace_page(rqstp, page++);
+	if (rqstp->rq_res.page_len == 0)	// first call
+		rqstp->rq_res.page_base = offset % PAGE_SIZE;
 	rqstp->rq_res.page_len += sd->len;
 	return sd->len;
 }
