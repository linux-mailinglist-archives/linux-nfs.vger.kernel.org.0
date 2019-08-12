Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EFB8A7A7
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2019 21:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfHLT6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Aug 2019 15:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfHLT6C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Aug 2019 15:58:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EF363061424;
        Mon, 12 Aug 2019 19:58:02 +0000 (UTC)
Received: from parsley.fieldses.org (ovpn-122-197.rdu2.redhat.com [10.10.122.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA2FA5792;
        Mon, 12 Aug 2019 19:58:01 +0000 (UTC)
Received: by parsley.fieldses.org (Postfix, from userid 2815)
        id 3AB98180A60; Mon, 12 Aug 2019 15:58:01 -0400 (EDT)
Date:   Mon, 12 Aug 2019 15:58:01 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 1/9] NFSD fill-in netloc4 structure
Message-ID: <20190812195801.GA29812@parsley.fieldses.org>
References: <20190808201848.36640-2-olga.kornievskaia@gmail.com>
 <201908111349.HDWO4xNv%lkp@intel.com>
 <CAN-5tyHtr6X+Rj8wCxkrTwSS+Y4Sug24n=hRaMjqjTq0O4JDUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyHtr6X+Rj8wCxkrTwSS+Y4Sug24n=hRaMjqjTq0O4JDUw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 12 Aug 2019 19:58:02 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 12, 2019 at 12:12:33PM -0400, Olga Kornievskaia wrote:
> Hi Bruce,
> 
> I believe I'm getting this because as it has been before NFSD patches
> depend on client-side patches (or specifically) it needed
> https://patchwork.kernel.org/patch/10649667/
> 
> I should have included the patch in both the client and server patch
> series. How should I correct this?
> 
> Also, in general (to run things) nfsd patches need the client side
> patches to be functional destination server (destination server nfs
> client piece).

I think I'd just sent it all as one series.  You can note in the cover
letter that the first X patches are for the client and the rest for the
server, if you'd like.

--b.

> On Sun, Aug 11, 2019 at 1:49 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Olga,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on nfsd/nfsd-next]
> > [cannot apply to v5.3-rc3 next-20190809]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Olga-Kornievskaia/server-side-support-for-inter-SSC-copy/20190811-120551
> > base:   git://linux-nfs.org/~bfields/linux.git nfsd-next
> > config: x86_64-lkp (attached as .config)
> > compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All error/warnings (new ones prefixed by >>):
> >
> >    In file included from fs/nfsd/state.h:42:0,
> >                     from fs/nfsd/trace.h:128,
> >                     from fs/nfsd/trace.c:3:
> > >> fs/nfsd/nfsd.h:391:16: warning: 'struct nfs42_netaddr' declared inside parameter list will not be visible outside of this definition or declaration
> >             struct nfs42_netaddr *netaddr)
> >                    ^~~~~~~~~~~~~
> >    fs/nfsd/nfsd.h: In function 'nfsd4_set_netaddr':
> > >> fs/nfsd/nfsd.h:401:18: error: dereferencing pointer to incomplete type 'struct nfs42_netaddr'
> >       sprintf(netaddr->netid, "tcp");
> >                      ^~
> >
> > vim +401 fs/nfsd/nfsd.h
> >
> >    389
> >    390  static inline u32 nfsd4_set_netaddr(struct sockaddr *addr,
> >  > 391                                      struct nfs42_netaddr *netaddr)
> >    392  {
> >    393          struct sockaddr_in *sin = (struct sockaddr_in *)addr;
> >    394          struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)addr;
> >    395          unsigned int port;
> >    396          size_t ret_addr, ret_port;
> >    397
> >    398          switch (addr->sa_family) {
> >    399          case AF_INET:
> >    400                  port = ntohs(sin->sin_port);
> >  > 401                  sprintf(netaddr->netid, "tcp");
> >    402                  netaddr->netid_len = 3;
> >    403                  break;
> >    404          case AF_INET6:
> >    405                  port = ntohs(sin6->sin6_port);
> >    406                  sprintf(netaddr->netid, "tcp6");
> >    407                  netaddr->netid_len = 4;
> >    408                  break;
> >    409          default:
> >    410                  return nfserr_inval;
> >    411          }
> >    412          ret_addr = rpc_ntop(addr, netaddr->addr, sizeof(netaddr->addr));
> >    413          ret_port = snprintf(netaddr->addr + ret_addr,
> >    414                              RPCBIND_MAXUADDRLEN + 1 - ret_addr,
> >    415                              ".%u.%u", port >> 8, port & 0xff);
> >    416          WARN_ON(ret_port >= RPCBIND_MAXUADDRLEN + 1 - ret_addr);
> >    417          netaddr->addr_len = ret_addr + ret_port;
> >    418          return 0;
> >    419  }
> >    420
> >
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
