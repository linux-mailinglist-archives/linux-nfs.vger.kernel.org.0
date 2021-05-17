Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A087383B02
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhEQRRl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 13:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242593AbhEQRRg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 13:17:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5808C061756
        for <linux-nfs@vger.kernel.org>; Mon, 17 May 2021 10:16:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so27348wmk.0
        for <linux-nfs@vger.kernel.org>; Mon, 17 May 2021 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8E3aCNC5Xysu3QXy6pFzKcdOHLv6ZxHyyGdT0jBjyQA=;
        b=khmljocnajWsqwOpNPJ8P6uQF9DUtIbuGnTTqXc/1ZMlWz0wj6D6MgbACT1vFij1qe
         IfBRrf1hBGMKvWFiyCLZP2olTmDnFMfXGksr3ppR4JApz0kYhVieP4a+fCmJG51rqs62
         MF6q4biIflBcn2wQBfPgLJ7IyGdK00DxXqiQcz4Wvjlxf1Ich+qdRvdSM9X/KnE+FO4B
         CFEkL6OR2+SISIB+vgbSGushPGLJwGP4LvvsqOE5EqLKhKLzXI37ph3Ho60dvekiSKgB
         j4hL8/u8EvulyLDG2iYFflHAOV2bGno7vWfj2fjgseCC1xODpG23DlOtHquduF5xQGTG
         q5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8E3aCNC5Xysu3QXy6pFzKcdOHLv6ZxHyyGdT0jBjyQA=;
        b=SNp/pbUdOep8GN7ST9+vRXyc1r9WWMdJITt2TvU2iCmc5M6XK/H80qc/7qbi7m1/at
         2HpjK0h0ICEJq6uf3m2rGQNcQg3IPR4K54qOhGmCmXQXq7WqTU+V0HUBwvlgBi4n7VT2
         8T0xG+3zCXY5x12WmNoX5yvJjf0RcR3L3xJWmlkQ73VO9MK9eiS0ypiX24S9LVjIGBqD
         zW0P+xGOuSXNs0OFMJrHHT2TXMC1/fUYRbBHjBftctZrlM2ZatVKeO+CzU6E+agvBkIV
         8lUJ6krNqvJtdzppF4NnLM9i9mpPpiuXjiv1v0t1LbtCHBxDdfnmiUtbAuLWt0hWM7TR
         wG7w==
X-Gm-Message-State: AOAM532wleWkK0yD+5JypB5FdBBBvpsmeSPtzyGg2Gf2qbHdrmNuQN6e
        Kkzgagp5/X9AJgUQPWh39Pv98w==
X-Google-Smtp-Source: ABdhPJxrvCQ298lBhKCWwoutKHU6LaIjgiA53+7kp815HcuNFU2iiTQP9GI/v+ng4oZTYv47xk4aBQ==
X-Received: by 2002:a1c:2c0a:: with SMTP id s10mr146329wms.158.1621271777249;
        Mon, 17 May 2021 10:16:17 -0700 (PDT)
Received: from gmail.com ([77.124.118.36])
        by smtp.gmail.com with ESMTPSA id t16sm9591140wrb.66.2021.05.17.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:16:16 -0700 (PDT)
Date:   Mon, 17 May 2021 20:16:13 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 10/12] sunrpc: add dst_attr attributes to the sysfs
 xprt directory
Message-ID: <20210517171613.toxgdygnzw76ibgd@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
 <20210514141323.67922-11-olga.kornievskaia@gmail.com>
 <20210515124232.y7xmofawebp7l5w6@gmail.com>
 <CAN-5tyGGnrGPMq4kakCZhNdJj9i-Arc-FXn=uxWRW9nuAVpE7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyGGnrGPMq4kakCZhNdJj9i-Arc-FXn=uxWRW9nuAVpE7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 17, 2021 at 09:53:30AM -0400, Olga Kornievskaia wrote:
> On Sat, May 15, 2021 at 8:42 AM Dan Aloni <dan@kernelim.com> wrote:
> >
> > On Fri, May 14, 2021 at 10:13:21AM -0400, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > Allow to query and set the destination's address of a transport.
> > > Setting of the destination address is allowed only for TCP or RDMA
> > > based connections.
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ..
> > > +     saddr = (struct sockaddr *)&xprt->addr;
> > > +     port = rpc_get_port(saddr);
> > > +
> > > +     dst_addr = kstrndup(buf, count - 1, GFP_KERNEL);
> > > +     if (!dst_addr)
> > > +             goto out_err;
> > > +     saved_addr = kzalloc(sizeof(*saved_addr), GFP_KERNEL);
> > > +     if (!saved_addr)
> > > +             goto out_err_free;
> > > +     saved_addr->addr =
> > > +             rcu_dereference_raw(xprt->address_strings[RPC_DISPLAY_ADDR]);
> > > +     rcu_assign_pointer(xprt->address_strings[RPC_DISPLAY_ADDR], dst_addr);
> > > +     call_rcu(&saved_addr->rcu, free_xprt_addr);
> > > +     xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr,
> > > +                              sizeof(*saddr));
> >
> > Hi Olga,
> >
> > How does this behave if rpc_pton fails? Perhaps this conversion being
> > also a validation check on input given from user-space should be done
> > before the xprt is being modified?
> 
> It's assumed that an administrator is providing a valid (and correct)
> address value. Transport would continue to be disconnected until a
> proper value is supplied. We can't validate for instance that the
> supplied value is a "correct" value for the v4.1 server (which would
> require sending an EXCHANGE_ID and checking that it's the same server
> as before).

I'm not sure it would work that way - looks like `rpc_pton` zeroes
`saddr` before trying to fill it (or leaves it as it in other cases such
as the INET_ADDRSTRLEN bound check). I think `0.0.0.0` routes to
localhost by default? That might cause unexpected behavior from admin PoV.

More to consider is that `xprt->address_strings[RPC_DISPLAY_ADDR]`
should be consistent with the value of `saddr` in the error cases,
otherwise debugging xprt state may be give confusing output.

-- 
Dan Aloni
