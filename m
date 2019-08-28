Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16CA0C23
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfH1VGQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 17:06:16 -0400
Received: from fieldses.org ([173.255.197.46]:49470 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfH1VGP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 17:06:15 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 6B0831C97; Wed, 28 Aug 2019 17:06:15 -0400 (EDT)
Date:   Wed, 28 Aug 2019 17:06:15 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "aglo@umich.edu" <aglo@umich.edu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "louis.devandiere@atos.net" <louis.devandiere@atos.net>
Subject: Re: Maximum Number of ACL on NFSv4
Message-ID: <20190828210615.GA32010@fieldses.org>
References: <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu>
 <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <20190826164600.GD28580@ndevos-x270>
 <AM5PR0202MB2564874D2AD5845AE3CD13DAE7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <CAN-5tyHjQfrFU_iGXKSDSLnR6ywXizAqtU=5et1ESgKLCgHkAA@mail.gmail.com>
 <AM5PR0202MB2564D07CBF6B765EDABAAAB1E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <20190828180541.GC29148@fieldses.org>
 <CAN-5tyEth0YYiuS0oe8Q_LN-7Z8NXiF3hJPj1sL5MYCXjF-jnQ@mail.gmail.com>
 <20190828192931.GA30217@fieldses.org>
 <848b2abbedb5147e7a7e527111018fb04ec9ed7d.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848b2abbedb5147e7a7e527111018fb04ec9ed7d.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 08:25:16PM +0000, Trond Myklebust wrote:
> Umm... Don't forget that NFSv4 ACL aces are typically much larger than
> POSIX ACL aces because the user/group names are encoded as strings, not
> binary uids and gids.
> 
> IOW: The size of the RPC message is likely to be a lot larger than the
> resulting POSIX ACL...

Actually this limit is post-idmapping, but, yes, before NFSv4->Posix
mapping (complicated in itself), which is why I talked about having to
estimate.

More interested to hear what you think about whether we need a limit at
all.  Do we have any ideas how big is too big a number to pass to
kmalloc?  Or is it OK to just let anything through and let kmalloc fail?

--b.
