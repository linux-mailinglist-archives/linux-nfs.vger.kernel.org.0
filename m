Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2011C383C01
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 20:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhEQSPo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 14:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbhEQSPo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 14:15:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58970C061573
        for <linux-nfs@vger.kernel.org>; Mon, 17 May 2021 11:14:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i13so8001410edb.9
        for <linux-nfs@vger.kernel.org>; Mon, 17 May 2021 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCmxRjY//h49LTDOfy1yHEx+hicOfE8l7MMfaLxPpuM=;
        b=qTepdyE59LmpLWf2nn05n9TGaJt/ZLSlt54oFGYafaNr+5sXJmlFgANqXcMwkS4WR6
         euZV4f2sOjYAOe/Hz4yqnzkn6o0snDUNKrIcoxzjK8PcD4k59y1S3eBl14FCGyd0mSLJ
         5KRzyF7lc+Qyfc0wxrh15NO2JL+wUFIe/G7zZifFiaVPYgrh0I98weYEpWBCzc1kCZZH
         vrOPrWk/2YhyO7ge6AgNQtpV9VZSD4oaoyvKNV4npcJ8PjlWHA2YnzbhyWqfBpKQ1zo2
         4cIQQa3yEiY55bMscnbCEzeUMuV5muCJVwqxiMXzFw31nW+NVxkcWypTZCo4tXj7hUyn
         sWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCmxRjY//h49LTDOfy1yHEx+hicOfE8l7MMfaLxPpuM=;
        b=dJzrT3OFZlhBISWFKpCyIElWxfBpLuVU9UC2oTeQYcoeezCaf68JvHUr+IDuw97xoS
         OGq9lN7G4XU/N4Kpknf4vV972YkUFN0oPJB/VG+mgBbB4bICnaO98/9RhAeanZJONHA5
         4CJcwHmQdUSkLfwvRL2euPXOLByHNjdHP0/SW6wRaUlndGX03lIAYYDiM04JcCPwNQ29
         yURPgpZ57Zq5h5y5ALRXNVJCObxodW4JPdf0pLo2Z7+cHkXc8YkskfptmPZS6OC59mQO
         ++XUiFPUfqgqWcB7K1bUfCZbevIu1bdeEWiQ7beVFI0P3cEmKVjsd0YvOK7aa7Eemd3R
         xrOQ==
X-Gm-Message-State: AOAM533yccNYsPrIUxEHnl+Rtm3V4FILRpjW4/a9QSn0Tt+pNwJ9JEjv
        7sN1mcNA3y+GRvkKcMod3bsOCx1kRw/UULvy7hi+nTEPrzc=
X-Google-Smtp-Source: ABdhPJwm/yyYZEJ+x/qW8B9MB6XXpSlxFQ1oRYtKDXlFpNm2QjXdp39ylTtGczrRFElNOirTbbCmZmGIGY//IhJ58aI=
X-Received: by 2002:a05:6402:354b:: with SMTP id f11mr1610275edd.139.1621275264937;
 Mon, 17 May 2021 11:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
 <20210514141323.67922-11-olga.kornievskaia@gmail.com> <20210515124232.y7xmofawebp7l5w6@gmail.com>
 <CAN-5tyGGnrGPMq4kakCZhNdJj9i-Arc-FXn=uxWRW9nuAVpE7A@mail.gmail.com> <20210517171613.toxgdygnzw76ibgd@gmail.com>
In-Reply-To: <20210517171613.toxgdygnzw76ibgd@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 17 May 2021 14:14:13 -0400
Message-ID: <CAN-5tyGV+Ct6ybKAJG98wLpJE=V70D=oXLQq9CdNh92iMWcisA@mail.gmail.com>
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

On Mon, May 17, 2021 at 1:16 PM Dan Aloni <dan@kernelim.com> wrote:
>
> On Mon, May 17, 2021 at 09:53:30AM -0400, Olga Kornievskaia wrote:
> > On Sat, May 15, 2021 at 8:42 AM Dan Aloni <dan@kernelim.com> wrote:
> > >
> > > On Fri, May 14, 2021 at 10:13:21AM -0400, Olga Kornievskaia wrote:
> > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > >
> > > > Allow to query and set the destination's address of a transport.
> > > > Setting of the destination address is allowed only for TCP or RDMA
> > > > based connections.
> > > >
> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ..
> > > > +     saddr = (struct sockaddr *)&xprt->addr;
> > > > +     port = rpc_get_port(saddr);
> > > > +
> > > > +     dst_addr = kstrndup(buf, count - 1, GFP_KERNEL);
> > > > +     if (!dst_addr)
> > > > +             goto out_err;
> > > > +     saved_addr = kzalloc(sizeof(*saved_addr), GFP_KERNEL);
> > > > +     if (!saved_addr)
> > > > +             goto out_err_free;
> > > > +     saved_addr->addr =
> > > > +             rcu_dereference_raw(xprt->address_strings[RPC_DISPLAY_ADDR]);
> > > > +     rcu_assign_pointer(xprt->address_strings[RPC_DISPLAY_ADDR], dst_addr);
> > > > +     call_rcu(&saved_addr->rcu, free_xprt_addr);
> > > > +     xprt->addrlen = rpc_pton(xprt->xprt_net, buf, count - 1, saddr,
> > > > +                              sizeof(*saddr));
> > >
> > > Hi Olga,
> > >
> > > How does this behave if rpc_pton fails? Perhaps this conversion being
> > > also a validation check on input given from user-space should be done
> > > before the xprt is being modified?
> >
> > It's assumed that an administrator is providing a valid (and correct)
> > address value. Transport would continue to be disconnected until a
> > proper value is supplied. We can't validate for instance that the
> > supplied value is a "correct" value for the v4.1 server (which would
> > require sending an EXCHANGE_ID and checking that it's the same server
> > as before).
>
> I'm not sure it would work that way - looks like `rpc_pton` zeroes
> `saddr` before trying to fill it (or leaves it as it in other cases such
> as the INET_ADDRSTRLEN bound check). I think `0.0.0.0` routes to
> localhost by default? That might cause unexpected behavior from admin PoV.
>
> More to consider is that `xprt->address_strings[RPC_DISPLAY_ADDR]`
> should be consistent with the value of `saddr` in the error cases,
> otherwise debugging xprt state may be give confusing output.

the reason for rpc_pton() to fail if an incorrect address is supplied.
I again said that given that this is a privileged operation, we rely
on the admin to provide a correct address. But are you arguing for
checking return or rpt_pton() and then reverting address_string
assignment back to the saved value and returning? Ok, I can do that.
But what can't be done is that once xprt_force_disconnect() is called
(1) we can't know if re-connect to the newly provided value is
successful and (2) thus we can't roll back the address values to the
old ones. Seems the added complexity is not gaining us much in return.
As I said I think the userspace tool that would sit on top of this
would do all the checks first before using the sysfs.

>
> --
> Dan Aloni
