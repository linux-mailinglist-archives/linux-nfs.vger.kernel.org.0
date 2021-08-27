Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C203F9C53
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 18:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhH0QW0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 12:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhH0QW0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 12:22:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1008FC061757
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xrmc9Wu6Z19w6aU/Gjrpp1mITec0kWy9PcPnd8ctnsQ=; b=VolxFbVEVXNHM0Gfj0KE7pe4Wn
        IkaoWPJ/kzER0FKMf3jeBYImIKY43OXSkltTsNsyBrYlXndYFmqF2CPfQiv6oKIyE1X6Tg0mRb563
        rko1JEKKw/P29AeMZLMC+72T9haLrOCh9udDl/1I7TcDp0tKuCY8hClqVreABXrhAj5RLXHYkHs04
        mGuDeOq1D5eH3xIBN9YRJBrBG9WuHuqVZFvuUwtpZiTou3X7MiExuXf3FSr0MLM2IXfX6KZQ7N6YE
        rG9KHHhBKizu4bUrIw3PXPKdmnog8pkU74tba24BrcseH0Yp9g3QwdSSnPKS+dNvHfAjNgrYKBCv9
        5f44sNJQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJeb1-00Ek69-3j; Fri, 27 Aug 2021 16:20:58 +0000
Date:   Fri, 27 Aug 2021 17:20:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "J.  Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <YSkQ31UTVDtBavOO@infradead.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162995778427.7591.11743795294299207756@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 26, 2021 at 04:03:04PM +1000, NeilBrown wrote:
> 
> [[ Hi Bruce and Chuck,
>    I've rebased this patch on the earlier patch I sent which allows
>    me to use the name "fh_flags".  I've also added a missing #include.
>    I've added the 'Acked-by' which Joesf provided earlier for the
>    btrfs-part.  I don't have an 'ack' for the  stat.h part, but no-one
>    has complained wither.
>    I think it is as ready as it can be, and am keen to know what you
>    think.
>    I'm not *very* keen on testing s_magic in nfsd code (though we
>    already have a couple of such tests in nfs3proc.c), but it does have
>    the advantage of ensuring that no other filesystem can use this
>    functionality without landing a patch in fs/nfsd/.
>  
>    Thanks for any review that you can provide,
>    NeilBrown
> ]]
> 
> BTRFS does not provide unique inode numbers across a filesystem.
> It only provides unique inode numbers within a subvolume and
> uses synthetic device numbers for different subvolumes to ensure
> uniqueness for device+inode.
> 
> nfsd cannot use these varying synthetic device numbers.  If nfsd were to
> synthesise different stable filesystem ids to give to the client, that
> would cause subvolumes to appear in the mount table on the client, even
> though they don't appear in the mount table on the server.  Also, NFSv3
> doesn't support changing the filesystem id without a new explicit mount
> on the client (this is partially supported in practice, but violates the
> protocol specification and has problems in some edge cases).
> 
> So currently, the roots of all subvolumes report the same inode number
> in the same filesystem to NFS clients and tools like 'find' notice that
> a directory has the same identity as an ancestor, and so refuse to
> enter that directory.
> 
> This patch allows btrfs (or any filesystem) to provide a 64bit number
> that can be xored with the inode number to make the number more unique.
> Rather than the client being certain to see duplicates, with this patch
> it is possible but extremely rare.

Yikes.  Please don't do something like this that will eventually
cause collisions.
