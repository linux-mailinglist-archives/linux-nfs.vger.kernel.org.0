Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B616567877
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 22:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiGEUeh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 16:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGEUeh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 16:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B9AFD1F;
        Tue,  5 Jul 2022 13:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B9CF61C00;
        Tue,  5 Jul 2022 20:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96BAC341C7;
        Tue,  5 Jul 2022 20:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657053275;
        bh=50nY0ggP+J21wkvr99VofKlSXlyDIr+OVw7BtesaheA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ofz6aecGD0+ZLizVyLJCR31Ct2zEmsM1DkPts9knFJP6ldlqLW+XtLXoPRrFgjUuY
         Nwu2jYh5B+Lo9ZEBGvz5WUAbaDEWWWmxi78exFrMNExcWwwKPzgYOyya9nkL1s76JI
         zUMx/5m5mEPyV8omlLcFZT0fvBqpf9Lz35ZyqCvIFBk0CnRk6NXd3Rb31nLihgiUAO
         cZnW3ib8XrtzTAl7fgVA0j5nu4wutm4y2SzD/PCgBt9sB6ASWA1bl8bOlPKUqQWlSd
         v+63ISe096J6hDbcbBRssXGrFKN1NeK3b5mTg69cU/FKAj6dl4k8IuiH9U5ZiiV/Ff
         KQdwTOh3F3eKQ==
Received: by mail-qt1-f169.google.com with SMTP id ck6so15474029qtb.7;
        Tue, 05 Jul 2022 13:34:35 -0700 (PDT)
X-Gm-Message-State: AJIora+bmtb209lcYx90FvwpV6+4Vd1NXwOstJqb+KVAy3ySStXR27qi
        ZFvaE+Bh+j2duDxnDQQyI6LMhNByTXMVECl2rts=
X-Google-Smtp-Source: AGRyM1vJX8IS5fOZTN+UdUe+dK0apDVQHZCIlEfOzzSwyhnaw828mrfY7MtRu4mY+/aPCerRbmskwaYM6lIItXuGrkA=
X-Received: by 2002:a0c:fe02:0:b0:473:1ca:51f1 with SMTP id
 x2-20020a0cfe02000000b0047301ca51f1mr6097581qvr.5.1657053274747; Tue, 05 Jul
 2022 13:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <c09e1af7-7d1f-1bbf-5562-ead9a4d99562@oracle.com>
 <CAL3q7H7Jm034yfVYJDzugWHPamvnKU=7XSb=38ey+-L_qdd=OA@mail.gmail.com> <YsSfPl6IvqrM5OPU@casper.infradead.org>
In-Reply-To: <YsSfPl6IvqrM5OPU@casper.infradead.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 5 Jul 2022 21:33:58 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6w+3PM83FtCymAWTUrerrMm+3Ztjt+aCt+r+g_9+3nLg@mail.gmail.com>
Message-ID: <CAL3q7H6w+3PM83FtCymAWTUrerrMm+3Ztjt+aCt+r+g_9+3nLg@mail.gmail.com>
Subject: Re: bug in btrfs during low memory testing.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dai.ngo@oracle.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        gniebler@suse.com,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 5, 2022 at 9:30 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jul 05, 2022 at 09:26:47PM +0100, Filipe Manana wrote:
> > In this case we can actually call xa_insert() without holding that
> > spinlock, it's safe against other concurrent calls to
> > btrfs_get_or_create_delayed_node(), btrfs_get_delayed_node(),
> > btrfs_kill_delayed_inode_items(), etc.
> >
> > However, looking at xa_insert() we have:
> >
> >         xa_lock(xa);
> >         err = __xa_insert(xa, index, entry, gfp);
> >         xa_unlock(xa);
> >
> > And xa_lock() is defined as:
> >
> >         #define xa_lock(xa)             spin_lock(&(xa)->xa_lock)
> >
> > So we'll always be under a spinlock even if we change btrfs to not
> > take the root->inode_lock spinlock.
> >
> > This seems more like a general problem outside btrfs' control.
> > So CC'ing Willy to double check.
>
> No, the XArray knows about its own spinlock.  It'll drop it if it needs
> to allocate memory and the GFP flags indicate that the caller can sleep.
> It doesn't know about your spinlock, so it can't do the same thing for
> you ;-)

Ah, that's good to know.
Thanks Willy.
