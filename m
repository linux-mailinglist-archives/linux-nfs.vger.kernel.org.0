Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14AB2C0EF5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 16:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbgKWPg3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 10:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732256AbgKWPg3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 10:36:29 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D499C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 07:36:29 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1DB916EA1; Mon, 23 Nov 2020 10:36:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1DB916EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606145787;
        bh=9/66e0zDaQZpwNyeclK2IXabup0B9rp6K+fDwP+z7o0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahEgJTfUjXs8xbk0W2u0vhm2KrhW2gYfPuxgbB7CXThKWc0wcnwYQgB6YrvpKaAjd
         o56I9pd3ss7V9JxtyoCQCMoGDI+wTbomweBV4Vq4qvW7b81ftHCbthT5Vm7Mk6gUr+
         onQvbFq79OyIdBb5ALOXc30ZhJ2U8hXZoBHlSynY=
Date:   Mon, 23 Nov 2020 10:36:27 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc : make RPC channel buffer dynamic for slow case
Message-ID: <20201123153627.GD32599@fieldses.org>
References: <20201026150530.29019-1-rbergant@redhat.com>
 <20201106215128.GD26028@fieldses.org>
 <CACWnjLxiCTAkxBca_NFrUSPCq_g4y0yNaHuNKX+Rwr=-xPhibw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACWnjLxiCTAkxBca_NFrUSPCq_g4y0yNaHuNKX+Rwr=-xPhibw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 21, 2020 at 11:54:30AM +0100, Roberto Bergantinos Corpas wrote:
> Hi Bruce,
> 
>   Sorry for late response as well.
> 
>     Ok, here's a possible patch, let me know your thoughts

Looks good to me!  Could you just submit with changelog and
Signed-off-by?

--b.

> 
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index baef5ee43dbb..1347ecae9c84 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -777,7 +777,6 @@ void cache_clean_deferred(void *owner)
>   */
> 
>  static DEFINE_SPINLOCK(queue_lock);
> -static DEFINE_MUTEX(queue_io_mutex);
> 
>  struct cache_queue {
>         struct list_head        list;
> @@ -905,44 +904,26 @@ static ssize_t cache_do_downcall(char *kaddr,
> const char __user *buf,
>         return ret;
>  }
> 
> -static ssize_t cache_slow_downcall(const char __user *buf,
> -                                  size_t count, struct cache_detail *cd)
> -{
> -       static char write_buf[8192]; /* protected by queue_io_mutex */
> -       ssize_t ret = -EINVAL;
> -
> -       if (count >= sizeof(write_buf))
> -               goto out;
> -       mutex_lock(&queue_io_mutex);
> -       ret = cache_do_downcall(write_buf, buf, count, cd);
> -       mutex_unlock(&queue_io_mutex);
> -out:
> -       return ret;
> -}
> -
>  static ssize_t cache_downcall(struct address_space *mapping,
>                               const char __user *buf,
>                               size_t count, struct cache_detail *cd)
>  {
> -       struct page *page;
> -       char *kaddr;
> +       char *write_buf;
>         ssize_t ret = -ENOMEM;
> 
> -       if (count >= PAGE_SIZE)
> -               goto out_slow;
> +       if (count >= 32768) { /* 32k is max userland buffer, lets
> check anyway */
> +               ret = -EINVAL;
> +               goto out;
> +       }
> 
> -       page = find_or_create_page(mapping, 0, GFP_KERNEL);
> -       if (!page)
> -               goto out_slow;
> +       write_buf = kvmalloc(count + 1, GFP_KERNEL);
> +       if (!write_buf)
> +               goto out;
> 
> -       kaddr = kmap(page);
> -       ret = cache_do_downcall(kaddr, buf, count, cd);
> -       kunmap(page);
> -       unlock_page(page);
> -       put_page(page);
> +       ret = cache_do_downcall(write_buf, buf, count, cd);
> +       kvfree(write_buf);
> +out:
>         return ret;
> -out_slow:
> -       return cache_slow_downcall(buf, count, cd);
>  }
> 
>  static ssize_t cache_write(struct file *filp, const char __user *buf,
> 
> On Fri, Nov 6, 2020 at 10:51 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Oct 26, 2020 at 04:05:30PM +0100, Roberto Bergantinos Corpas wrote:
> > > RPC channel buffer size for slow case (user buffer bigger than
> > > one page) can be converted into dymanic and also allows us to
> > > prescind from queue_io_mutex
> >
> > Sorry for the slow response.
> >
> > Let's just remove cache_slow_downcall and the find_or_create_page()
> > thing and just do a kvmalloc() from the start.  I don't understand why
> > we need to be more complicated.
> >
> > --b.
> >
> > >
> > > Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> > > ---
> > >  net/sunrpc/cache.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> > > index baef5ee43dbb..325393f75e17 100644
> > > --- a/net/sunrpc/cache.c
> > > +++ b/net/sunrpc/cache.c
> > > @@ -777,7 +777,6 @@ void cache_clean_deferred(void *owner)
> > >   */
> > >
> > >  static DEFINE_SPINLOCK(queue_lock);
> > > -static DEFINE_MUTEX(queue_io_mutex);
> > >
> > >  struct cache_queue {
> > >       struct list_head        list;
> > > @@ -908,14 +907,18 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
> > >  static ssize_t cache_slow_downcall(const char __user *buf,
> > >                                  size_t count, struct cache_detail *cd)
> > >  {
> > > -     static char write_buf[8192]; /* protected by queue_io_mutex */
> > > +     char *write_buf;
> > >       ssize_t ret = -EINVAL;
> > >
> > > -     if (count >= sizeof(write_buf))
> > > +     if (count >= 32768) /* 32k is max userland buffer, lets check anyway */
> > >               goto out;
> > > -     mutex_lock(&queue_io_mutex);
> > > +
> > > +     write_buf = kvmalloc(count + 1, GFP_KERNEL);
> > > +     if (!write_buf)
> > > +             return -ENOMEM;
> > > +
> > >       ret = cache_do_downcall(write_buf, buf, count, cd);
> > > -     mutex_unlock(&queue_io_mutex);
> > > +     kvfree(write_buf);
> > >  out:
> > >       return ret;
> > >  }
> > > --
> > > 2.21.0
> >
