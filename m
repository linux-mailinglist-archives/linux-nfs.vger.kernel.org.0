Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBCC70A35
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2019 21:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfGVT70 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jul 2019 15:59:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40397 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfGVT70 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jul 2019 15:59:26 -0400
Received: by mail-vs1-f66.google.com with SMTP id a186so25541178vsd.7
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2019 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXAiNBKSGvHHvKKPrqoK3zYqyQGzmtM3JyZq0oeg6bQ=;
        b=WS1zMKYJqnjIlK0FgNrL0zM36cUcLWe6HfJ6fXCUIjYJiu8+IlGyxJeFj8Us0P2sF2
         M1ZDxrbh9EfUX21kINEzXIwCPHWYDna+WXT/ju7ukLyxr2vZ0NmzLd1I2cQ4OAIOfO64
         9cW68F2idZQXhKcTu0u795zkbuNrMsgOeq9OteqKx7MkVaKPI2lBd78GYwPwvaS/I3rt
         ySxDSBKl1vPA7mPsfvOO4PAT4H1CwLEyRcSyrfIns0t7Efr1iElb5rMuqQjlmJv5xovK
         SrwuP0H5qEMNtIu4F2S9q1BXQfgVontII5kGjUIz3MWA6WaWC+IfT1FuOM1YbernMOtQ
         WzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXAiNBKSGvHHvKKPrqoK3zYqyQGzmtM3JyZq0oeg6bQ=;
        b=Um2yvU/Fedtv17S7vHdFneQHmkxS50gNtopcwkUZMI61YJ3rqH+yNUhfpRXQT5SFP8
         X5Wir539JdzTZWRdw/L6ATPt4RfBB2W7KHMrv3ZdDOjtwBktwOedgCHoYgWTxls78gNw
         LbOWhsP38qeswbB8xplkwSY/K2ACI1Jy7Xb3OxzCQJcl01L0Y4CwlPaAguKo7RiASXnR
         VVCdZtx4J5RuIgcnIhgNddgWgpt8FsVlKQURYjaOgrGi5mJQyfGrBAnz6rAjtwZiIlRH
         IPegnfK2VMRXZL7cOHXBNeEWegnz9x2D/xuzp+8iNiLrrzpgZk8uELZPg65MJkn1vbNj
         JVew==
X-Gm-Message-State: APjAAAUBsmXKNyBCMj+2ZAkoXC9rP/7JpJKLHtxGypahtOnQfrbBPnP6
        V0AIdcoYbjbbYxxLNTESMbUqfV6ZOPFbFjz6iWk=
X-Google-Smtp-Source: APXvYqz3y0UB/EFJjPINHZKvb555l0p+cHi8wsNCLVfipnxoVmtiDstRLawCjxVqix+UUt6FJ8of+/Ou+YaxCHuzoyI=
X-Received: by 2002:a67:dc1:: with SMTP id 184mr45626966vsn.164.1563825565340;
 Mon, 22 Jul 2019 12:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-2-olga.kornievskaia@gmail.com> <20190717211317.GM24608@fieldses.org>
In-Reply-To: <20190717211317.GM24608@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 22 Jul 2019 15:59:14 -0400
Message-ID: <CAN-5tyHxY0YPoXwK0pVudfH3n9SiNwzmYOywzmtpYSHFZkH23Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] NFSD fill-in netloc4 structure
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 17, 2019 at 5:13 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jul 08, 2019 at 03:23:45PM -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > nfs.4 defines nfs42_netaddr structure that represents netloc4.
> >
> > Populate needed fields from the sockaddr structure.
> >
> > This will be used by flexfiles and 4.2 inter copy
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfsd/nfsd.h | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 24187b5..8f4fc50 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -19,6 +19,7 @@
> >  #include <linux/sunrpc/svc.h>
> >  #include <linux/sunrpc/svc_xprt.h>
> >  #include <linux/sunrpc/msg_prot.h>
> > +#include <linux/sunrpc/addr.h>
> >
> >  #include <uapi/linux/nfsd/debug.h>
> >
> > @@ -375,6 +376,37 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
> >
> >  extern const u32 nfsd_suppattrs[3][3];
> >
> > +static inline u32 nfsd4_set_netaddr(struct sockaddr *addr,
> > +                                 struct nfs42_netaddr *netaddr)
> > +{
> > +     struct sockaddr_in *sin = (struct sockaddr_in *)addr;
> > +     struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)addr;
> > +     unsigned int port;
> > +     size_t ret_addr, ret_port;
> > +
> > +     switch (addr->sa_family) {
> > +     case AF_INET:
> > +             port = ntohs(sin->sin_port);
> > +             sprintf(netaddr->netid, "tcp");
> > +             netaddr->netid_len = 3;
> > +             break;
> > +     case AF_INET6:
> > +             port = ntohs(sin6->sin6_port);
> > +             sprintf(netaddr->netid, "tcp6");
> > +             netaddr->netid_len = 4;
> > +             break;
> > +     default:
> > +             return nfserr_inval;
> > +     }
> > +     ret_addr = rpc_ntop(addr, netaddr->addr, sizeof(netaddr->addr));
> > +     ret_port = snprintf(netaddr->addr + ret_addr,
> > +                         RPCBIND_MAXUADDRLEN + 1 - ret_addr,
> > +                         ".%u.%u", port >> 8, port & 0xff);
> > +     WARN_ON(ret_port >= RPCBIND_MAXUADDRLEN + 1 - ret_addr);
> > +     netaddr->addr_len = ret_addr + ret_port;
> > +     return 0;
> > +}
>
> Kinda surprised we don't already do something like this elsewhere, but I
> don't see anything exactly the same.  Might be possible to put this in
> net/sunrpc/addr.c and share some code with rpc_sockaddr2uaddr?  I'll
> leave it to you whether that looks worth it.

I'll investigate how to move this into the sunrpc. Client also
populates nfs42_netaddr structure but it's slightly different. I need
to go back and see if what's shareable.

>
> --b.
>
> > +
> >  static inline bool bmval_is_subset(const u32 *bm1, const u32 *bm2)
> >  {
> >       return !((bm1[0] & ~bm2[0]) ||
> > --
> > 1.8.3.1
