Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3989C2C6A78
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Nov 2020 18:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbgK0ROV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Nov 2020 12:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731419AbgK0ROU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Nov 2020 12:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606497260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FXL1bpUlqJXzznp4VClhdwXzrBzm9V/O9XDJM/WBghU=;
        b=VntZcQrFWBPm+WLG9kwXsxMkOTrpNtVy2I5WOJdDG7Y0qQEpV6EHw4tiBZL3Fn3teh1/Sv
        tvc70EKGOZmQtYBGyhR4ROYdwe5GoiSXENgAK1MFMSWttcZIaC3jB/ZWU+DxspNCuhH6+n
        0dnJcQAxLGrZX6wGBq4SKk+C2oF22Wo=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-26hKGkCePgW6T4QwqUZS5Q-1; Fri, 27 Nov 2020 12:14:18 -0500
X-MC-Unique: 26hKGkCePgW6T4QwqUZS5Q-1
Received: by mail-io1-f70.google.com with SMTP id m3so3685503iok.21
        for <linux-nfs@vger.kernel.org>; Fri, 27 Nov 2020 09:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXL1bpUlqJXzznp4VClhdwXzrBzm9V/O9XDJM/WBghU=;
        b=An/tRm9WSBI2mXgYFHKTDgcPnYLyxFwv/80Y/QXiUBcc1JvEnqJoQR+vqmMLqTrHFz
         3PIYhE+jSZ0EEfrc8779Gi00gbTfqh+GsHrDzjEk56IawmThM9thJu5n9hSIlVxOz/n2
         TaTvOgRN9N06tvAYtxwmn2i0RVNJ/Vb85w7ElwBOL53X14WywLDLU9DqyDrlSj4K4lnG
         14VT7uEgF+IBUCFeIL0sVUBVN+fBuNbnha4XMZepaVJ6TmZL6b0ksJ/eKjZ3MeJZ12GY
         OUg1t5b0/bNeNlaqcx5MLZnBWPpOj18wqqLRhXErpTvImeb8FyembiTRRsyXrQ9Vtwvd
         xsRQ==
X-Gm-Message-State: AOAM531URwVRFcMKffaFw/CovM2Fo7w99mpsP1ZzhcuUOFrRjH+jzbJP
        NcVtHANi1tJwb/R5L4zBYSqK7dhyYMe06Unkxa73FrQUjfFbrF3pW2zBMBzFH0NQh4RFOXfGPRJ
        oJ3bWs2LlelWMs5v0DBFiBco7hDTIixSazk5O
X-Received: by 2002:a05:6638:f89:: with SMTP id h9mr8383670jal.89.1606497257429;
        Fri, 27 Nov 2020 09:14:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxdCCrh6i590cTprcZBMgSZ5JrHXya58XqtZq/JxZm23pkUfnaFrt68GTGToQj9MwLsp7D/0xN/5X/XEA8EfM=
X-Received: by 2002:a05:6638:f89:: with SMTP id h9mr8383659jal.89.1606497257167;
 Fri, 27 Nov 2020 09:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20201127161451.17922-1-rbergant@redhat.com> <F08098E1-7E04-4ECA-852A-C93E837E4EBF@oracle.com>
In-Reply-To: <F08098E1-7E04-4ECA-852A-C93E837E4EBF@oracle.com>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Fri, 27 Nov 2020 18:14:04 +0100
Message-ID: <CACWnjLwx_Lj4HXr4ifaSzvjRvQTj-QuC7VeYYxNpLJwBh=uuXQ@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: clean-up cache downcall
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce!

 Thanks for comments!, i'll send a v2 with mechanical errors fixed
based on v5.10-rc5.

rgds
roberto

On Fri, Nov 27, 2020 at 5:52 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Roberto-
>
> I spotted some mechanical problems.
>
>
> > On Nov 27, 2020, at 11:14 AM, Roberto Bergantinos Corpas <rbergant@redhat.com> wrote:
> >
> > We can simplifly code around cache_downcall unifying memory
>
> ^simplifly^simplify
>
> > allocations using kvmalloc, this have the benefit of getting rid of
>
> ^, this have^. This has
>
> > cache_slow_downcall (and queue_io_mutex), and also matches userland
> > allocation size and limits
> >
> > Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
>
> Assuming Bruce is copacetic with this patch, the change looks
> appropriate for the v5.11 merge window. However, this patch
> doesn't appear to apply to v5.10-rc5. Might be because
> 27a1e8a0f79e ("sunrpc: raise kernel RPC channel buffer size")
> was already merged?
>
>
> > ---
> > net/sunrpc/cache.c | 41 +++++++++++------------------------------
> > 1 file changed, 11 insertions(+), 30 deletions(-)
> >
> > diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> > index baef5ee43dbb..1347ecae9c84 100644
> > --- a/net/sunrpc/cache.c
> > +++ b/net/sunrpc/cache.c
> > @@ -777,7 +777,6 @@ void cache_clean_deferred(void *owner)
> >  */
> >
> > static DEFINE_SPINLOCK(queue_lock);
> > -static DEFINE_MUTEX(queue_io_mutex);
> >
> > struct cache_queue {
> >       struct list_head        list;
> > @@ -905,44 +904,26 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
> >       return ret;
> > }
> >
> > -static ssize_t cache_slow_downcall(const char __user *buf,
> > -                                size_t count, struct cache_detail *cd)
> > -{
> > -     static char write_buf[8192]; /* protected by queue_io_mutex */
> > -     ssize_t ret = -EINVAL;
> > -
> > -     if (count >= sizeof(write_buf))
> > -             goto out;
> > -     mutex_lock(&queue_io_mutex);
> > -     ret = cache_do_downcall(write_buf, buf, count, cd);
> > -     mutex_unlock(&queue_io_mutex);
> > -out:
> > -     return ret;
> > -}
> > -
> > static ssize_t cache_downcall(struct address_space *mapping,
> >                             const char __user *buf,
> >                             size_t count, struct cache_detail *cd)
> > {
> > -     struct page *page;
> > -     char *kaddr;
> > +     char *write_buf;
> >       ssize_t ret = -ENOMEM;
> >
> > -     if (count >= PAGE_SIZE)
> > -             goto out_slow;
> > +     if (count >= 32768) { /* 32k is max userland buffer, lets check anyway */
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> >
> > -     page = find_or_create_page(mapping, 0, GFP_KERNEL);
> > -     if (!page)
> > -             goto out_slow;
> > +     write_buf = kvmalloc(count + 1, GFP_KERNEL);
> > +     if (!write_buf)
> > +             goto out;
> >
> > -     kaddr = kmap(page);
> > -     ret = cache_do_downcall(kaddr, buf, count, cd);
> > -     kunmap(page);
> > -     unlock_page(page);
> > -     put_page(page);
> > +     ret = cache_do_downcall(write_buf, buf, count, cd);
> > +     kvfree(write_buf);
> > +out:
> >       return ret;
> > -out_slow:
> > -     return cache_slow_downcall(buf, count, cd);
> > }
> >
> > static ssize_t cache_write(struct file *filp, const char __user *buf,
> > --
> > 2.21.0
> >
>
> --
> Chuck Lever
>
>
>

