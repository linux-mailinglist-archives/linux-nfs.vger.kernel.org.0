Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75E98A316
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2019 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfHLQMq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Aug 2019 12:12:46 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36278 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfHLQMp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Aug 2019 12:12:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id y16so70109723vsc.3
        for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2019 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9OrXxikBygPfVRiBsmBXze65GQW81W5xtYU1sFf1oGQ=;
        b=pX9Z069Q4npcj3HEfLbC2sfC/B2psnmChUojGiNgOpojSJjvVryEDxv6NiEdHwndU7
         5dhUSIMdEVCg2NKO2lFlj87i8y26hf9k3Yb8/VSFRVgVGaLxUAGUmomYsjp3vvO+Z9+9
         Owrvq5cGNQso9xOlDkLihhjAcqZMVxe/GfIRdMekm1UdurZQHtO+pkvAwR80RAdi1XMf
         24c6JwuN3Ap9Bma5rrZ25rEaBYnmckheTL7Xovl8vSjilT160552I5V9x2na2y32Xw2z
         lB3UBfjIj7A8Y3qxdaxdHXPgmHj6hSufiPhWeJMjoJgrNYzaduAUEGSxxmyuxSl1WBup
         L3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OrXxikBygPfVRiBsmBXze65GQW81W5xtYU1sFf1oGQ=;
        b=FtanXezFbAZs2xgDn+tFBbtSU7FNPRxAg6Sba0i64RfVLgQ5isrZalmQH0MHQE9uue
         jRELQN0wmcuBtPyTsAZrnyrbm1lu0ry2ucII2eREK1Q+aOeuGEiYx4J/n0N3CzGxnRw5
         NmNhiFhgGSN4WOxsgZNjmX5Xc01z3SWpGIvo3kDS28XIQ9Pe1lb1ZH5g8N/uou4TSxD9
         chIGLiKimTh3H1cNqbNWtxRSbBWJklOEgZw+3R3EDSpaHagkCCZDFUQ9b5CJhM2CpdTI
         Ibe0+cUoyhwftEk8EABhFU4BjgwR+jcRxid9kZVZEZ/myaWzM2EWGeALNenb+5J96/dp
         gDsQ==
X-Gm-Message-State: APjAAAWtwJS2M1WKoIUB5FzkFfKmWKrTBbwcCCvL3a1czBsla1hBrkHg
        w33US1N8aPn4s5a6aITnxGOyQRXxxsa8QmmopzQ=
X-Google-Smtp-Source: APXvYqzVKcENW3m6EORQBKzME+9X7hCyHLLHhmcG4mRqVmmV9X2I31zj0I8G1Rbg5DRkdPlY5BSiVX1hsQ/oUFalxA8=
X-Received: by 2002:a67:79d4:: with SMTP id u203mr22009520vsc.85.1565626364704;
 Mon, 12 Aug 2019 09:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190808201848.36640-2-olga.kornievskaia@gmail.com> <201908111349.HDWO4xNv%lkp@intel.com>
In-Reply-To: <201908111349.HDWO4xNv%lkp@intel.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 12 Aug 2019 12:12:33 -0400
Message-ID: <CAN-5tyHtr6X+Rj8wCxkrTwSS+Y4Sug24n=hRaMjqjTq0O4JDUw@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] NFSD fill-in netloc4 structure
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

I believe I'm getting this because as it has been before NFSD patches
depend on client-side patches (or specifically) it needed
https://patchwork.kernel.org/patch/10649667/

I should have included the patch in both the client and server patch
series. How should I correct this?

Also, in general (to run things) nfsd patches need the client side
patches to be functional destination server (destination server nfs
client piece).



On Sun, Aug 11, 2019 at 1:49 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Olga,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on nfsd/nfsd-next]
> [cannot apply to v5.3-rc3 next-20190809]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Olga-Kornievskaia/server-side-support-for-inter-SSC-copy/20190811-120551
> base:   git://linux-nfs.org/~bfields/linux.git nfsd-next
> config: x86_64-lkp (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from fs/nfsd/state.h:42:0,
>                     from fs/nfsd/trace.h:128,
>                     from fs/nfsd/trace.c:3:
> >> fs/nfsd/nfsd.h:391:16: warning: 'struct nfs42_netaddr' declared inside parameter list will not be visible outside of this definition or declaration
>             struct nfs42_netaddr *netaddr)
>                    ^~~~~~~~~~~~~
>    fs/nfsd/nfsd.h: In function 'nfsd4_set_netaddr':
> >> fs/nfsd/nfsd.h:401:18: error: dereferencing pointer to incomplete type 'struct nfs42_netaddr'
>       sprintf(netaddr->netid, "tcp");
>                      ^~
>
> vim +401 fs/nfsd/nfsd.h
>
>    389
>    390  static inline u32 nfsd4_set_netaddr(struct sockaddr *addr,
>  > 391                                      struct nfs42_netaddr *netaddr)
>    392  {
>    393          struct sockaddr_in *sin = (struct sockaddr_in *)addr;
>    394          struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)addr;
>    395          unsigned int port;
>    396          size_t ret_addr, ret_port;
>    397
>    398          switch (addr->sa_family) {
>    399          case AF_INET:
>    400                  port = ntohs(sin->sin_port);
>  > 401                  sprintf(netaddr->netid, "tcp");
>    402                  netaddr->netid_len = 3;
>    403                  break;
>    404          case AF_INET6:
>    405                  port = ntohs(sin6->sin6_port);
>    406                  sprintf(netaddr->netid, "tcp6");
>    407                  netaddr->netid_len = 4;
>    408                  break;
>    409          default:
>    410                  return nfserr_inval;
>    411          }
>    412          ret_addr = rpc_ntop(addr, netaddr->addr, sizeof(netaddr->addr));
>    413          ret_port = snprintf(netaddr->addr + ret_addr,
>    414                              RPCBIND_MAXUADDRLEN + 1 - ret_addr,
>    415                              ".%u.%u", port >> 8, port & 0xff);
>    416          WARN_ON(ret_port >= RPCBIND_MAXUADDRLEN + 1 - ret_addr);
>    417          netaddr->addr_len = ret_addr + ret_port;
>    418          return 0;
>    419  }
>    420
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
