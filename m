Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2A24386D
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfFMPFr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 11:05:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42678 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732439AbfFMON2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jun 2019 10:13:28 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so17180552ior.9
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2019 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehkJYWC1p94ZapNpY1eAcwZHNv2DdSb1jRkL6CQmSXc=;
        b=XzV9xpChVBAa9jqtcQ66PwrzgArnW79YoNikn4QKmOORtfYCNARNhku1YV8k8pRd0+
         TpBceZrFLMj5ZWbnm89SpTimND8ZZ/i1NpGKPvDFFV7+kY5PhvA3deJRh1t1MviBz8d6
         2WgvYrKsRmPboQ59Dsf3w67lwDKzEGbhgPQXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehkJYWC1p94ZapNpY1eAcwZHNv2DdSb1jRkL6CQmSXc=;
        b=nSUlpIEfZpVslQMLG7hOu7x0lY9vDHQG7rZm7XyDJV+nmzPZrSFGfGo2v5Ua/9d/GW
         kp5dAI5cRzfZkFROJhy7govWrVSM9YslxtE6R6DboL5EDAJs3D4g3HVime5W3+LlJf8X
         76C/fA0Rmsg+fMhp7jOctParrKpvONdJHAJhx1ADUPIQeOprLghf2yTOOVXKjMx0uMem
         a7ArxdpVxv+ADd/ligpk6gPF2KT5mVXx52RcFt1Y5b2ouTE5JAEkZwAw2Y65WjfLW4Ta
         DA+NY8uV9vyIcabzOHTpQymkVv6SnQJMcCiBn8jXwUDsyO+SEMeXx72QRHEdFQ2k4zCg
         +Jfw==
X-Gm-Message-State: APjAAAWx2OTaIEYjJIzVj72C5gFQX3tu4RqoCxwY2av7fOmUR/QMQsYj
        HIic5KL99O8MSZEucb6fGGXtCLlAce9crI+y0qUMCw==
X-Google-Smtp-Source: APXvYqy6WRYvdHLq+gy5VPmn46gTLcUDrorQB67zOqyoIHFBd6FWkOmz9cXztOtlGThbC8W7OtdrbIjOIR3xeRUcdgc=
X-Received: by 2002:a5e:8618:: with SMTP id z24mr54385645ioj.174.1560435207415;
 Thu, 13 Jun 2019 07:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190612172408.22671-1-amir73il@gmail.com> <20190612183156.GA27576@fieldses.org>
In-Reply-To: <20190612183156.GA27576@fieldses.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 13 Jun 2019 16:13:15 +0200
Message-ID: <CAJfpegvj0NHQrPcHFd=b47M-uz2CY6Hnamk_dJvcrUtwW65xBw@mail.gmail.com>
Subject: Re: [PATCH v2] locks: eliminate false positive conflicts for write lease
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 12, 2019 at 8:31 PM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> How do opens for execute work?  I guess they create a struct file with
> FMODE_EXEC and FMODE_RDONLY set and they decrement i_writecount.  Do
> they also increment i_readcount?  Reading do_open_execat and alloc_file,
> looks like it does, so, good, they should conflict with write leases,
> which sounds right.

Right, but then why this:

> > +     /* Eliminate deny writes from actual writers count */
> > +     if (wcount < 0)
> > +             wcount = 0;

It's basically a no-op, as you say.  And it doesn't make any sense
logically, since denying writes *should* deny write leases as well...

Thanks,
Miklos
