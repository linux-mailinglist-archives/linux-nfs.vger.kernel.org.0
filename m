Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740237ACAF
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfG3Psw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 11:48:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36797 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfG3Psw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Jul 2019 11:48:52 -0400
Received: by mail-vs1-f68.google.com with SMTP id y16so43771286vsc.3
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2019 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFLfAMk00hdmY9QKxREnCJ0q6m0jmdvFUXj+kjxiZ+o=;
        b=K1CcuXf3Nqloz09gDQgV7pulRCDXXzMkprAgIVdfByg6ntrcYuxElecvJxzmWOFsLz
         /IfUjSh3xJKWlsob/imAutf0UTbr8ScAekdr06Mtf1iiDZ36gEiysiG/ygn8Gcu/kDbW
         EahBUg/YBDxgj1HFjfkT9oBrE3fY5ORzbjB4m8HgvmBh3L8tswBqU8LqrnvLl9ga1Hmv
         RcL79XkpjS/f0P1nCmirsAxQ0uXENS/fLRJoncyZc+NtmUt7fcQ7pg9whfa9ow33o6ul
         +7I3cm9Ou1kjVK3BEHi4o/g8APocf1VcTnKi6pwBF2Z+G8lj+LnrEiIwRprVPZa0cLC0
         N1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFLfAMk00hdmY9QKxREnCJ0q6m0jmdvFUXj+kjxiZ+o=;
        b=awQJ1nGHyv4rSkRL7AD6QDg7Z80T7yVoU/M/jfX1p1jhaTUqgd0WMQ0nPaMlP0/IT5
         seZpbPm1gZS+cVApHCgcjVI4Or2AeudzBg6niTS0UVKMfIigMX6vOifq9ZVoTf8b3k1i
         E0Lr9Yb70Y/LalMRCiicUInf9lnKdEDZRz396Ukc+zY0TcXTqudjRJXcehaLK8gk9jb+
         +wZoGXqXstCFKEpPgw0fW4wYL6BFsrGfNNO3JbY21f3Ycs6bVrbBKg9T2FlYhobczAJF
         15gGq/cUBCUsgf3dXDYch6JZuCfh0hTNP01IHtze50e1BqNNVfDsuHSJD3Ayb+6yGltc
         pe4A==
X-Gm-Message-State: APjAAAVzDHrx8CdzOGbNT/fL77s5sIrTTaQMyCLSpPrVfm6QK0vwffCa
        B0mRy/fohldl/pUUFZ+mJwLKsYSuMkXSPvIZjds=
X-Google-Smtp-Source: APXvYqxbDOftSMEvh3iScxWDPd1xhY9huPSm/+nlxUltzugpLnHDD3A+yFgxN0SywmblxehtApcnbBC2SZDrPLfIXw8=
X-Received: by 2002:a67:8907:: with SMTP id l7mr73476327vsd.194.1564501730949;
 Tue, 30 Jul 2019 08:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-2-olga.kornievskaia@gmail.com> <20190717211317.GM24608@fieldses.org>
 <CAN-5tyHxY0YPoXwK0pVudfH3n9SiNwzmYOywzmtpYSHFZkH23Q@mail.gmail.com>
In-Reply-To: <CAN-5tyHxY0YPoXwK0pVudfH3n9SiNwzmYOywzmtpYSHFZkH23Q@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 30 Jul 2019 11:48:40 -0400
Message-ID: <CAN-5tyHD4ms1b9udXb8cXKC+N0vZbpmG7cb_TmnB9GTLoOr45g@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] NFSD fill-in netloc4 structure
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 22, 2019 at 3:59 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Wed, Jul 17, 2019 at 5:13 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Jul 08, 2019 at 03:23:45PM -0400, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > nfs.4 defines nfs42_netaddr structure that represents netloc4.
> > >
> > > Populate needed fields from the sockaddr structure.
> > >
> > > This will be used by flexfiles and 4.2 inter copy
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  fs/nfsd/nfsd.h | 32 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > >
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index 24187b5..8f4fc50 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/sunrpc/svc.h>
> > >  #include <linux/sunrpc/svc_xprt.h>
> > >  #include <linux/sunrpc/msg_prot.h>
> > > +#include <linux/sunrpc/addr.h>
> > >
> > >  #include <uapi/linux/nfsd/debug.h>
> > >
> > > @@ -375,6 +376,37 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
> > >
> > >  extern const u32 nfsd_suppattrs[3][3];
> > >
> > > +static inline u32 nfsd4_set_netaddr(struct sockaddr *addr,
> > > +                                 struct nfs42_netaddr *netaddr)
> > > +{
> > > +     struct sockaddr_in *sin = (struct sockaddr_in *)addr;
> > > +     struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)addr;
> > > +     unsigned int port;
> > > +     size_t ret_addr, ret_port;
> > > +
> > > +     switch (addr->sa_family) {
> > > +     case AF_INET:
> > > +             port = ntohs(sin->sin_port);
> > > +             sprintf(netaddr->netid, "tcp");
> > > +             netaddr->netid_len = 3;
> > > +             break;
> > > +     case AF_INET6:
> > > +             port = ntohs(sin6->sin6_port);
> > > +             sprintf(netaddr->netid, "tcp6");
> > > +             netaddr->netid_len = 4;
> > > +             break;
> > > +     default:
> > > +             return nfserr_inval;
> > > +     }
> > > +     ret_addr = rpc_ntop(addr, netaddr->addr, sizeof(netaddr->addr));
> > > +     ret_port = snprintf(netaddr->addr + ret_addr,
> > > +                         RPCBIND_MAXUADDRLEN + 1 - ret_addr,
> > > +                         ".%u.%u", port >> 8, port & 0xff);
> > > +     WARN_ON(ret_port >= RPCBIND_MAXUADDRLEN + 1 - ret_addr);
> > > +     netaddr->addr_len = ret_addr + ret_port;
> > > +     return 0;
> > > +}
> >
> > Kinda surprised we don't already do something like this elsewhere, but I
> > don't see anything exactly the same.  Might be possible to put this in
> > net/sunrpc/addr.c and share some code with rpc_sockaddr2uaddr?  I'll
> > leave it to you whether that looks worth it.
>
> I'll investigate how to move this into the sunrpc. Client also
> populates nfs42_netaddr structure but it's slightly different. I need
> to go back and see if what's shareable.

Ok I'd like argue for the code to stay as is because
1. can't move the whole function into addr.c because it created a data
structure (nfs42_netaddr) that rpc knows nothing about
2. While the nfs42_netaddr->addr is the output of the rpc_sock2uaddr()
but we still need the switch to populate the netid . Also since
rpc_sock2uaddr returns memory than the nfs42_netaddr data structure
needs to change to store pointers (and that's shared with the client).
Thus client and server would need to add other code to free the
created netaddr.
3. this function as is can be used by the flexfile layout as well
(they also decided not to share code with rpc_sockaddr2uaddr but use
same content). that function also doesn't want the memory to be
allocated.

Maybe I'm wrong about all of it and it all needs to be re-written to
take dynamic memory. But to use as is I don't want to call it and then
memcpy into existing static buffers and freeing what
rpc_sockaddr2uaddr has allocated.



>
> >
> > --b.
> >
> > > +
> > >  static inline bool bmval_is_subset(const u32 *bm1, const u32 *bm2)
> > >  {
> > >       return !((bm1[0] & ~bm2[0]) ||
> > > --
> > > 1.8.3.1
