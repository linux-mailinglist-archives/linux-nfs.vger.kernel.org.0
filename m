Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989943FA436
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 09:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhH1HMB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Aug 2021 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhH1HMB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 Aug 2021 03:12:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7282C0613D9
        for <linux-nfs@vger.kernel.org>; Sat, 28 Aug 2021 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b5ear5mTBHOuPg1atwbc40Tb3/zvsviCgwd0Gh//4HE=; b=a3iQo1GaCG68Vd6StGUxytkjIc
        QONhN0/6CrKVYV0hNwCmJ6tqXGdbxs7Uf76PkxjdcvWYUtkn9mtSAjsTH+hWPb2LyCTWX5qCDSYE2
        n6gLe3fcKaVaaAaX80CxRW3Mgfe9W/l+guwhhNV3fktXlLR4EPZSdNvFNoyc5H+RB8NXrq5T2PuwL
        p3lUIdm4eXzBS3Ity6vE36t3BVg2hprDQIcY++PrpRkNDmOQ0JDLI1TeCP8dfhWn+5FM5xwVngw2G
        6dIn6AB76vWa7B5AMTU9SfUgGHyaFE5kuzl9+Ee/kxg0nEBha0QPknyv4mCO9ZBTq34SV5YBOOxT/
        KO36OWEA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJsSs-00FMV3-5W; Sat, 28 Aug 2021 07:09:44 +0000
Date:   Sat, 28 Aug 2021 08:09:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <YSnhHl0HDOgg07U5@infradead.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org>
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163010550851.7591.9342822614202739406@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Aug 28, 2021 at 09:05:08AM +1000, NeilBrown wrote:
> There doesn't seem to be any other option - and this is still an
> improvement over the current behaviour.
> 
> Collisions should still be quite a few years away, and there is hope
> that the btrfs developers will take action before then to provide some
> certainty.   Not much hope, but some.

I think that is a very dangerous assumption.  Given how every inode
allocation tends to be somewhat predictable I'm also really worried
that this actually opens up an attach vector.  Last but not least
I also very much disagree with any of the impact to common code.
Most importantly the kstat structure, which exist to support the stat
family of system calls and not as a side channel for NFS file handles
(nevermind that it is hidden in a nfs patch and didn't even Cc the
fsdevel list), but also all the impact to the generic nfsd code for
this very broken concept.  If you want to support such a scheme in
btrfs as the lesser of evils (which I disagree with), please make
sure it stays self-contained in the btrfs specific file handle
encoding and decoding.
