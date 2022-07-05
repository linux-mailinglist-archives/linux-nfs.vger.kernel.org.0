Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF41567861
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiGEUaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 16:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiGEUaA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 16:30:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7122C1ADBD;
        Tue,  5 Jul 2022 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K09u3BTeWpo+6I64to3zCKlnogCRvue0V/mHY0f5E/Q=; b=l57h2cRbrO6Lg1HhRVycuIT/Kf
        oy/j+j8TitmuTC9psjEhtXWHbAfC0zhXA46E6lUE3+COlb+F/dlExPfMrkI+iEwxNOzH/PXaKzszt
        I8nI0tl9b7eupBxd8uyiEbAdRB9LngWJ/nQ/nh8VThmiBMZbcZfMsiOxh4vLc1iQQcJ6nHUPfnVMf
        O/TwACOda5fGjMAYrn3femvZ2m5QEUo8l8ql+CmN0lv3F8/qRGunKw7kJO9vXg0MR43HhesiLw7r2
        peV5uw0+N0m9szbczf4Vzl/LsFL11NP7g4Q328lScBhez1i+PvLAWCUSY/Iisol+pOuSTiHfxcXmr
        D62QgbZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8pB8-000tQG-CR; Tue, 05 Jul 2022 20:29:50 +0000
Date:   Tue, 5 Jul 2022 21:29:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dai.ngo@oracle.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        gniebler@suse.com,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: bug in btrfs during low memory testing.
Message-ID: <YsSfPl6IvqrM5OPU@casper.infradead.org>
References: <c09e1af7-7d1f-1bbf-5562-ead9a4d99562@oracle.com>
 <CAL3q7H7Jm034yfVYJDzugWHPamvnKU=7XSb=38ey+-L_qdd=OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7Jm034yfVYJDzugWHPamvnKU=7XSb=38ey+-L_qdd=OA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 05, 2022 at 09:26:47PM +0100, Filipe Manana wrote:
> In this case we can actually call xa_insert() without holding that
> spinlock, it's safe against other concurrent calls to
> btrfs_get_or_create_delayed_node(), btrfs_get_delayed_node(),
> btrfs_kill_delayed_inode_items(), etc.
> 
> However, looking at xa_insert() we have:
> 
>         xa_lock(xa);
>         err = __xa_insert(xa, index, entry, gfp);
>         xa_unlock(xa);
> 
> And xa_lock() is defined as:
> 
>         #define xa_lock(xa)             spin_lock(&(xa)->xa_lock)
> 
> So we'll always be under a spinlock even if we change btrfs to not
> take the root->inode_lock spinlock.
> 
> This seems more like a general problem outside btrfs' control.
> So CC'ing Willy to double check.

No, the XArray knows about its own spinlock.  It'll drop it if it needs
to allocate memory and the GFP flags indicate that the caller can sleep.
It doesn't know about your spinlock, so it can't do the same thing for
you ;-)
