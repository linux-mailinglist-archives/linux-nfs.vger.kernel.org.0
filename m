Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0005B4A77
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Sep 2022 00:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIJWNe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Sep 2022 18:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIJWNc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 10 Sep 2022 18:13:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB565E3
        for <linux-nfs@vger.kernel.org>; Sat, 10 Sep 2022 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YR+ntuHl5fOk06kmMtEESyE6d9xq40oR2msXPof/X2w=; b=GYfnMrOwmiEwokZy0Qh/lHe7aQ
        tbI9wJ0z/ENTAX8UtsRkMpjm6+0lEx+hvtd1jSo+S8hTUhN+mKPo/UaxtUfOca1sMQc4R8WeoB/mb
        q0ZlxBmPTZl7QcML/WdP9I1A+aFA/AB+g15JWYCu1ZkNYhv9Ps6Y4vygxyMOojNxubFf3T53qARKI
        ccpKozpFomaGX2cGzHglUXbDkjH/5BV8/YY65p0p78Y+CYy9/lq/EfEi05FC4qta8Lu4xKCJq2eVV
        Q7wH6QgRQz5AoB9QMPxGKO87P7/dBiAVEbB8e0KdauIt7g0dZXQrkui7nVgqA+rcnS01pf6P1RXDp
        1JsOiAlw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oX8is-00ESF7-Ar;
        Sat, 10 Sep 2022 22:13:10 +0000
Date:   Sat, 10 Sep 2022 23:13:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Message-ID: <Yx0L9p4VMH2v2tBX@ZenIV>
References: <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com>
 <Yxz+GhK7nWKcBLcI@ZenIV>
 <9D6CDF68-6B12-44DE-BC01-3BD0251E7F94@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D6CDF68-6B12-44DE-BC01-3BD0251E7F94@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Sep 10, 2022 at 09:21:11PM +0000, Chuck Lever III wrote:

> It's also possible that recent simplifications I've done to the splice
> read actor accidentally removed the ability to deal with compound pages.
> You might want to review the commit history of nfsd_splice_actor() to
> see if there is an historic version that would behave correctly with
> the new copy_page_to_iter().

Nah, that's unrelated...

> Is the need to deal with CompoundPage documented somewhere? If not,
> perhaps nfsd_splice_actor() could mention it so that overzealous
> maintainers don't break it again.

> > +	struct page *page = buf->page;	// may be a compound one

Does that qualify? ;-)

FWIW, there's a separate problem in that thing - it assumes that
pipe_buffer boundaries will end up PAGE_SIZE-aligned.  Usually
that's going to be true, but foofs_splice_read() is not required to
maintain that.  E.g. it might be working in terms of chunks
used by weird protocol used by foofs, with e.g. 1024-byte payloads
+ 300-odd bytes of framing/checskums/whatnot.  In that case it
might do 1024 bytes per pipe_buffer, with non-zero offset in page
in each of them; normal read()/splice()/etc. would work just fine
with that, but for nfsd_splice_actor() results would not be
nice.

AFAICS, sunrpc assumes that we have several pages, offset in the
first one and total size; no provisions exist for e.g. 5Kb of
data scattered in 5 chunks over 5 pages.  Correct?
