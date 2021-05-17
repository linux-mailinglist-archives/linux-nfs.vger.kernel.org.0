Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF51382E03
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhEQNy7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 09:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhEQNy7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 09:54:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2650EC061756
        for <linux-nfs@vger.kernel.org>; Mon, 17 May 2021 06:53:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k14so5848571eji.2
        for <linux-nfs@vger.kernel.org>; Mon, 17 May 2021 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8Z+w1Y6Rf9gclo3jq11QDfu9zPhiWbiWM7O3Q/pH7g=;
        b=WXUny7D9XwCLWhtEMS5dhHdu+m7ukLt7WrXtkbbsmZQHzA4XPDt/wotC8XHmebQhwY
         HJqoDdnw37k5cWXc0+SBLu9FfKfEbHt05VAtRiTDzFUiMNrXpolJeHZJ7FDWRBac3Gjl
         6q9qAnmS0z+crSU09CAY4ZAsPLR7YKRpgVLnrjJ3KlgWzTydplljo0Jp9g9i5vO+CtLS
         wjhDHhSNqklvUK0Zt3jq3M7cHGBl5ibLL9dneMvhKwGGHFje9lVUQUyuc5DR8Oji5oMq
         z0oB3Gsg/WcLSkjNAVHX2p4lpicKEj2SoLFHyafKPexm98wh4zbHiSIb6OdBUEdsF09n
         HHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8Z+w1Y6Rf9gclo3jq11QDfu9zPhiWbiWM7O3Q/pH7g=;
        b=oDsoJ03MmVubIqMfTMQ7KlTty+fsLp1ZZwxmONeHIqFLZFW9hAEC2EHxqIvZSaPG9o
         6heDgsF1H+UHBD1H/J6j9TwL5GPNza1+uYZSvLfpMWijztp7EAx5X10mn5Yw8JZVd8Az
         UQbGj/AwHWcYhK2IzeoxQVS42MwwV1+m6i0LLt+Qi85wQSEPeTIvqHEERzbeGR4cNQO9
         I55kylVTFOS8uckosu8zDgRgHyD/bd1rwJ8imGYxZaEMyy5tC6nPlL72ING1mx6v4iYS
         cLA+BYuEUpHS2YB84oiJ6z1pw2JXxOOOddCAGyDmsw154c3S6oP2VpXS91ksnLAfcEQI
         fAPQ==
X-Gm-Message-State: AOAM531mcWZBbJiMBeFK63c6ddz3m6muQaGN1/qPR5PyCDKyzGzc5+u9
        qCmmqP8vs338/kqxREMhOS98TjWsQrKV3mOSyiDz7jo8wzI=
X-Google-Smtp-Source: ABdhPJwG9nlbEZgqxEbZYyt0GDq3J4fLYD/KM2lJb142e9SkkDLGWPK51UB7gHC9NkxKXFzDr5yuTJ2i1BcPLe7bMMA=
X-Received: by 2002:a17:906:584e:: with SMTP id h14mr27618ejs.432.1621259621792;
 Mon, 17 May 2021 06:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
 <20210514141323.67922-11-olga.kornievskaia@gmail.com> <20210515124232.y7xmofawebp7l5w6@gmail.com>
In-Reply-To: <20210515124232.y7xmofawebp7l5w6@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 17 May 2021 09:53:30 -0400
Message-ID: <CAN-5tyGGnrGPMq4kakCZhNdJj9i-Arc-FXn=uxWRW9nuAVpE7A@mail.gmail.com>
Subject: Re: [PATCH v7 10/12] sunrpc: add dst_attr attributes to the sysfs
 xprt directory
To:     Dan Aloni <dan@kernelim.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, May 15, 2021 at 8:42 AM Dan Aloni <dan@kernelim.com> wrote:
>
> On Fri, May 14, 2021 at 10:13:21AM -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Allow to query and set the destination's address of a transport.
> > Setting of the destination address is allowed only for TCP or RDMA
> > based connections.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ..
> > +     saddr = (struct sockaddr *)&xprt->addr;
> > +     port = rpc_get_port(saddr);
> > +
> > +     dst_addr = kstrndup(buf, count - 1, GFP_KERNEL);
> > +     if (!dst_addr)
> > +             goto out_err;
> > +     saved_addr = kzalloc(sizeof(*saved_addr), GFP_KERNEL);
> > +     if (!saved_addr)
> > +             goto out_err_free;
> > +     saved_addr->addr =
> > +             rcu_dereference_raw(xprt->address_strings[RPC_DISPLAY_ADDR]);
> > +     rcu_assign_pointer(xprt->address_strings[RPC_DISPLAY_ADDR], dst_addr);
> > +     call_rcu(&saved_addr->rcu, free_xprt_addr);
> > +     xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr,
> > +                              sizeof(*saddr));
>
> Hi Olga,
>
> How does this behave if rpc_pton fails? Perhaps this conversion being
> also a validation check on input given from user-space should be done
> before the xprt is being modified?

It's assumed that an administrator is providing a valid (and correct)
address value. Transport would continue to be disconnected until a
proper value is supplied. We can't validate for instance that the
supplied value is a "correct" value for the v4.1 server (which would
require sending an EXCHANGE_ID and checking that it's the same server
as before).

But yes perhaps a userland utility can do things like DNS resolution
to get the IP, it can check format correctness and connectivity as
well (but can't check the v4 requirement though).

>
> --
> Dan Aloni
