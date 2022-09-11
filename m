Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475465B50EB
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Sep 2022 21:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiIKTj4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Sep 2022 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIKTjz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Sep 2022 15:39:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D190D12ADD
        for <linux-nfs@vger.kernel.org>; Sun, 11 Sep 2022 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eD2QaVV/z60ab9/ZtuPPSACehSEwOfRrxTzdGqbMckQ=; b=Iygc/r0rffcYtrDj3V+usnhQ11
        u5X9id0gRBcSbF04+6Lh0K9lfJj01pFAa3L13VmfIIwfXupvetOWNpwOU0Look3e72uj3eINnaHEa
        yJzhddhMTUYIO5jRHI2AOcZCHtr/PEaV/NGz14gOrGSusAemJmgvSYW8nIYtI0TzDtAk1BfmSTPWM
        +He9lMqc1gQudfj0PJuTBV/CtV1uHu4wnqLHRGdqd+kHjjkolWy69mJyoFFygTB957hDkjfNSPDH8
        1jupZD+I0dvW7go2L+NeE5sis/4CMY/76oRb15kycXeCaNNGkTvTLYNrbMAijG+AWnM6xgZQgsmKn
        mvCLEFCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oXSni-00EznS-AZ;
        Sun, 11 Sep 2022 19:39:30 +0000
Date:   Sun, 11 Sep 2022 20:39:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Message-ID: <Yx45clPaZODzYV+z@ZenIV>
References: <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com>
 <Yxz+GhK7nWKcBLcI@ZenIV>
 <8B4DBE66-960F-473C-8636-8159B397FFC0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8B4DBE66-960F-473C-8636-8159B397FFC0@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Sep 11, 2022 at 06:36:22PM +0000, Chuck Lever III wrote:

> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 9f486b788ed0..b16aed158ba6 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -846,10 +846,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
> > 		  struct splice_desc *sd)
> > {
> > 	struct svc_rqst *rqstp = sd->u.data;
> > -
> > -	svc_rqst_replace_page(rqstp, buf->page);
> > -	if (rqstp->rq_res.page_len == 0)
> > -		rqstp->rq_res.page_base = buf->offset;
> > +	struct page *page = buf->page;	// may be a compound one
> > +	unsigned offset = buf->offset;
> > +
> > +	page += offset / PAGE_SIZE;
> 
> Nit: I see "offset / PAGE_SIZE" is used in the iter code base,
> but in the NFS stack, we prefer "offset >> PAGE_SIZE" and
> "offset & ~PAGE_MASK" (below).

*shrug*

If a C compiler is too dumb to recognize division by a power of two
constant...

Anyway, your codebase, your rules.

> 
> > +	for (int i = sd->len; i > 0; i -= PAGE_SIZE)
> > +		svc_rqst_replace_page(rqstp, page++);
> > +	if (rqstp->rq_res.page_len == 0)	// first call
> > +		rqstp->rq_res.page_base = offset % PAGE_SIZE;
> > 	rqstp->rq_res.page_len += sd->len;
> > 	return sd->len;
> > }
> 
> I could take this through the nfsd for-rc tree, but that's based
> on 5.19-rc7 so it doesn't have f0f6b614f83d. I don't think will
> break functionality, but I'm wondering if it would be better for
> you to take this through your tree to improve bisect-ability.
> 
> If you agree and Ben reports a Tested-by:, then here's my
> 
>   Acked-by: Chuck Lever <chuck.lever@oracle.com>

OK, I'll wait for Tested-by and send it to Linus.  Should be safe
for backports - with non-compound pages we are going to have
offset < PAGE_SIZE and sd->len <= PAGE_SIZE, so this is equivalent
to the mainline variant of the function for those...
