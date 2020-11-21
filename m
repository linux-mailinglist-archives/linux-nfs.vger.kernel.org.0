Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D322BBE8D
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 11:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgKUKyr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 05:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbgKUKyr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 05:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605956084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jxSPit35VJ+3fmzmBiFIJ1OiVFuB9LMJGr7vPdRryw=;
        b=iJS9/jJo/CTMcnAEtFvt3P1Q+JGt7PNUx7ALzqYigxVVCrKwPzuVLydSVGNhhYuzVi0OZd
        XvOxW8SyDXdKYSElOUxrBg9P69YwpQQyc1RP/hJaUlPpKu4oce9+6e8RoYY71UQGT+8M5/
        Th+MAkKPqst/5IDemLWm1yXOmJ2sP74=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-8eEIwtMhOGajISRC1IEPOA-1; Sat, 21 Nov 2020 05:54:43 -0500
X-MC-Unique: 8eEIwtMhOGajISRC1IEPOA-1
Received: by mail-il1-f199.google.com with SMTP id q10so5672252ile.1
        for <linux-nfs@vger.kernel.org>; Sat, 21 Nov 2020 02:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jxSPit35VJ+3fmzmBiFIJ1OiVFuB9LMJGr7vPdRryw=;
        b=YmH7X4kL9OBJoAZN26Up+E3a79tS7JZT8UIa973suWVJESnx0eVdflFvghoC0x9l1L
         +HU+D4SljhFEWnz27hEDzEf52KNM+QXGgA3SAyaHqkaxh39O9Y8t0jmSTMUp/lGb+FGB
         +doGgEYuraT8un92uQBPi6picKTQQ/R3+PoRfyoVpIeeIReAngpEgicSMs/qB4Jhx57r
         apx48R+mbqeCm/m+TOyz9zYmzn3htMoIa8p+meJp07zHFj0BCM++4k6w+MPqE3cax7K6
         8y2QyUw9uTKz6n3jW6a/adAg1Mwm123pipC0f9Hx/EbWfr5u5ceZdpTaXZEIOtdHrz8x
         c65A==
X-Gm-Message-State: AOAM530UwkhPVZfk2wc9SYPMiWgk7XVlWkIWj+o/msgqQWUyRtPis+6A
        bceJ3vDd1H36S0lRs96GOxrUh6TrB65qrOaQDFVl05vdlLXLiIojEk/75s7kSzt1WykgHKsCSTw
        lAIjMM/E39PasHbcMy6/vqeXUdW5WZniE+I5G
X-Received: by 2002:a5d:958b:: with SMTP id a11mr10457761ioo.160.1605956082107;
        Sat, 21 Nov 2020 02:54:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFH0OMIRlRA41Ga8KgUUfnHmzWT/P8Vnz+Iz8qScBHVW4E0MhwcGIExLsNRnz3dEq4Ujx2YYxGsjQ72t6ugC0=
X-Received: by 2002:a5d:958b:: with SMTP id a11mr10457754ioo.160.1605956081840;
 Sat, 21 Nov 2020 02:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20201026150530.29019-1-rbergant@redhat.com> <20201106215128.GD26028@fieldses.org>
In-Reply-To: <20201106215128.GD26028@fieldses.org>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Sat, 21 Nov 2020 11:54:30 +0100
Message-ID: <CACWnjLxiCTAkxBca_NFrUSPCq_g4y0yNaHuNKX+Rwr=-xPhibw@mail.gmail.com>
Subject: Re: [PATCH] sunrpc : make RPC channel buffer dynamic for slow case
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

  Sorry for late response as well.

    Ok, here's a possible patch, let me know your thoughts

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index baef5ee43dbb..1347ecae9c84 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -777,7 +777,6 @@ void cache_clean_deferred(void *owner)
  */

 static DEFINE_SPINLOCK(queue_lock);
-static DEFINE_MUTEX(queue_io_mutex);

 struct cache_queue {
        struct list_head        list;
@@ -905,44 +904,26 @@ static ssize_t cache_do_downcall(char *kaddr,
const char __user *buf,
        return ret;
 }

-static ssize_t cache_slow_downcall(const char __user *buf,
-                                  size_t count, struct cache_detail *cd)
-{
-       static char write_buf[8192]; /* protected by queue_io_mutex */
-       ssize_t ret = -EINVAL;
-
-       if (count >= sizeof(write_buf))
-               goto out;
-       mutex_lock(&queue_io_mutex);
-       ret = cache_do_downcall(write_buf, buf, count, cd);
-       mutex_unlock(&queue_io_mutex);
-out:
-       return ret;
-}
-
 static ssize_t cache_downcall(struct address_space *mapping,
                              const char __user *buf,
                              size_t count, struct cache_detail *cd)
 {
-       struct page *page;
-       char *kaddr;
+       char *write_buf;
        ssize_t ret = -ENOMEM;

-       if (count >= PAGE_SIZE)
-               goto out_slow;
+       if (count >= 32768) { /* 32k is max userland buffer, lets
check anyway */
+               ret = -EINVAL;
+               goto out;
+       }

-       page = find_or_create_page(mapping, 0, GFP_KERNEL);
-       if (!page)
-               goto out_slow;
+       write_buf = kvmalloc(count + 1, GFP_KERNEL);
+       if (!write_buf)
+               goto out;

-       kaddr = kmap(page);
-       ret = cache_do_downcall(kaddr, buf, count, cd);
-       kunmap(page);
-       unlock_page(page);
-       put_page(page);
+       ret = cache_do_downcall(write_buf, buf, count, cd);
+       kvfree(write_buf);
+out:
        return ret;
-out_slow:
-       return cache_slow_downcall(buf, count, cd);
 }

 static ssize_t cache_write(struct file *filp, const char __user *buf,

On Fri, Nov 6, 2020 at 10:51 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Oct 26, 2020 at 04:05:30PM +0100, Roberto Bergantinos Corpas wrote:
> > RPC channel buffer size for slow case (user buffer bigger than
> > one page) can be converted into dymanic and also allows us to
> > prescind from queue_io_mutex
>
> Sorry for the slow response.
>
> Let's just remove cache_slow_downcall and the find_or_create_page()
> thing and just do a kvmalloc() from the start.  I don't understand why
> we need to be more complicated.
>
> --b.
>
> >
> > Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> > ---
> >  net/sunrpc/cache.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> > index baef5ee43dbb..325393f75e17 100644
> > --- a/net/sunrpc/cache.c
> > +++ b/net/sunrpc/cache.c
> > @@ -777,7 +777,6 @@ void cache_clean_deferred(void *owner)
> >   */
> >
> >  static DEFINE_SPINLOCK(queue_lock);
> > -static DEFINE_MUTEX(queue_io_mutex);
> >
> >  struct cache_queue {
> >       struct list_head        list;
> > @@ -908,14 +907,18 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
> >  static ssize_t cache_slow_downcall(const char __user *buf,
> >                                  size_t count, struct cache_detail *cd)
> >  {
> > -     static char write_buf[8192]; /* protected by queue_io_mutex */
> > +     char *write_buf;
> >       ssize_t ret = -EINVAL;
> >
> > -     if (count >= sizeof(write_buf))
> > +     if (count >= 32768) /* 32k is max userland buffer, lets check anyway */
> >               goto out;
> > -     mutex_lock(&queue_io_mutex);
> > +
> > +     write_buf = kvmalloc(count + 1, GFP_KERNEL);
> > +     if (!write_buf)
> > +             return -ENOMEM;
> > +
> >       ret = cache_do_downcall(write_buf, buf, count, cd);
> > -     mutex_unlock(&queue_io_mutex);
> > +     kvfree(write_buf);
> >  out:
> >       return ret;
> >  }
> > --
> > 2.21.0
>

