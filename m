Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236DD5B4B84
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Sep 2022 05:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIKDvc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Sep 2022 23:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIKDv0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Sep 2022 23:51:26 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2E32F01F
        for <linux-nfs@vger.kernel.org>; Sat, 10 Sep 2022 20:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fzaCnq+vbd/vpfxECV4iLovfuzdgvAIS76l3dqNIxOY=; b=Dkz79oZU4IJip9NpZkaenXbB9+
        y7M8c5/r6hZZUtzme3dRAH8gRSMIalqgOT7fNwqbOqR7gbBEQ+d3YavkjGkmnZMzL7jReKOqfPf1N
        ycacnMp0BtEbUGTZSsV+LYg1DVX3UYC/pW5fVFj07nGTwc/cv10EjicJGw4Y0kqbbTQ5wZJ79L9VG
        cWSfPlMioNnZoxBsSBM38mxdufgZs+sO6j8aGrUQkyOH31R1OzQx8K2G7cSKxHaT7IZRjYsqSfDbR
        ag2uWSTatGHNYicvMsda6O2LswMv0ReOzuNwpVJHqHtFasa+mxaDSnK4GQhHlB9PFBhXYnL5P538l
        ynwSOhCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oXDzx-00Eaaa-F2;
        Sun, 11 Sep 2022 03:51:09 +0000
Date:   Sun, 11 Sep 2022 04:51:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Message-ID: <Yx1bLd15llExAQ/L@ZenIV>
References: <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com>
 <Yxz+GhK7nWKcBLcI@ZenIV>
 <9D6CDF68-6B12-44DE-BC01-3BD0251E7F94@oracle.com>
 <Yx0L9p4VMH2v2tBX@ZenIV>
 <5FF21605-6F1E-4DF1-A141-F86263CA579F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FF21605-6F1E-4DF1-A141-F86263CA579F@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Sep 10, 2022 at 10:35:52PM +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 10, 2022, at 6:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > On Sat, Sep 10, 2022 at 09:21:11PM +0000, Chuck Lever III wrote:
> > 
> >> It's also possible that recent simplifications I've done to the splice
> >> read actor accidentally removed the ability to deal with compound pages.
> >> You might want to review the commit history of nfsd_splice_actor() to
> >> see if there is an historic version that would behave correctly with
> >> the new copy_page_to_iter().
> > 
> > Nah, that's unrelated...
> > 
> >> Is the need to deal with CompoundPage documented somewhere? If not,
> >> perhaps nfsd_splice_actor() could mention it so that overzealous
> >> maintainers don't break it again.
> > 
> >>> +	struct page *page = buf->page;	// may be a compound one
> > 
> > Does that qualify? ;-)
> 
> Well, no, since you just added it :-) I meant pre-existing
> documentation of the API. I take your remark as polite
> encouragement to go and look for it, because this is an
> area where I need deeper understanding.

Not really - quality of documentation aside, it's a combination of splice
from sockets being capable of stuffing skb fragments into destination pipe
and skb allocations using compound pages.  E.g. AF_UNIX sendmsg() on
a large datagram will result in that.  socketpair(), then such sendmsg()
on one end, splice() from another and there you go - references to compound
pages ending up in pipe buffers...

nfsd_splice_read() does file-to-pipe splice (into internal pipe) + feeding
the contents of that pipe into nfsd_splice_actor(); the new part here is
that file-to-pipe splice from regular file can end up with the thing that
had always been possible for file-to-pipe splice from sockets...
