Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265475687CF
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 14:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiGFMKF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGFMKF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 08:10:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023BC27FE1;
        Wed,  6 Jul 2022 05:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AO1jDDt6BzagafkZZ4mZQiiTyhyUvD3r4qfXyF1omZs=; b=kecU2dEh3MfWeQjtHrKdPHJlE9
        c7+HHLq26fIVHAGDyLVtBktWnk5JvenC+atQrJO2jptnKxSQT5YKZM8s08r6EkjQ2bdVMLNkpFcyg
        InKgaa6S0+Z6LPFe4TUoqFUnkXoDFTomQFUXu2KgAQfehyH9QGOVB5Mm17+S5jWfH+o/Sv12AhDlG
        BywmvG4RmMR8Jnjz7qcVXKZkOznhr+HYDjiAOfFs7kPCmYOGyJneiM4Dsh0ao3eb45/vlaB13LvsW
        E2WUNagQBnCTqyO03adUnbKjIqfyme3Yn6DoSZhigmk5LBR6Wzoohm0fXfYzGdK5iXVlk03YK+7J4
        /Fph9m2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o93qr-001dAU-Ey; Wed, 06 Jul 2022 12:09:53 +0000
Date:   Wed, 6 Jul 2022 13:09:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, dai.ngo@oracle.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>, gniebler@suse.com,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: bug in btrfs during low memory testing.
Message-ID: <YsV7kfglS4EEQTJU@casper.infradead.org>
References: <c09e1af7-7d1f-1bbf-5562-ead9a4d99562@oracle.com>
 <CAL3q7H7Jm034yfVYJDzugWHPamvnKU=7XSb=38ey+-L_qdd=OA@mail.gmail.com>
 <YsSfPl6IvqrM5OPU@casper.infradead.org>
 <148c0ac2-add4-69e8-ced7-49772841720b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <148c0ac2-add4-69e8-ced7-49772841720b@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 06, 2022 at 09:36:42AM +0300, Nikolay Borisov wrote:
> On 5.07.22 г. 23:29 ч., Matthew Wilcox wrote:
> > On Tue, Jul 05, 2022 at 09:26:47PM +0100, Filipe Manana wrote:
> > > In this case we can actually call xa_insert() without holding that
> > > spinlock, it's safe against other concurrent calls to
> > > btrfs_get_or_create_delayed_node(), btrfs_get_delayed_node(),
> > > btrfs_kill_delayed_inode_items(), etc.
> > > 
> > > However, looking at xa_insert() we have:
> > > 
> > >          xa_lock(xa);
> > >          err = __xa_insert(xa, index, entry, gfp);
> > >          xa_unlock(xa);
> > > 
> > > And xa_lock() is defined as:
> > > 
> > >          #define xa_lock(xa)             spin_lock(&(xa)->xa_lock)
> > > 
> > > So we'll always be under a spinlock even if we change btrfs to not
> > > take the root->inode_lock spinlock.
> > > 
> > > This seems more like a general problem outside btrfs' control.
> > > So CC'ing Willy to double check.
> > 
> > No, the XArray knows about its own spinlock.  It'll drop it if it needs
> > to allocate memory and the GFP flags indicate that the caller can sleep.
> > It doesn't know about your spinlock, so it can't do the same thing for
> > you ;-)
> 
> 
> In order to catch (and prevent) further offensive can we perhaps have
> something like that in xa_insert:
> 
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index c29e11b2c073..63c00b2945a2 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -770,6 +770,9 @@ static inline int __must_check xa_insert(struct xarray
> *xa,
>  {
>         int err;
> 
> +       if (gfpflags_allow_blocking(gfp))
> +               might_sleep()
> +
>         xa_lock(xa);
>         err = __xa_insert(xa, index, entry, gfp);
>         xa_unlock(xa);

I think you mean:

	might_alloc(gfp);

And yes, I think that makes a lot of sense.  Quite a few similar places
to do ... I'll take care of it.
