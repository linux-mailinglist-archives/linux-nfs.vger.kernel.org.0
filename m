Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB25C066
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2019 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfGAPhs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Jul 2019 11:37:48 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45201 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbfGAPhs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Jul 2019 11:37:48 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F2A3C21CDD;
        Mon,  1 Jul 2019 11:37:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 01 Jul 2019 11:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Cu1gXpO0xWcS/oZfvCGwVEe4T6x
        gt0tebCnzb5vWblw=; b=KomX6tHsKjMHZ7BJt6XaLeTHvnlRKa9iQN8DHrn+FVK
        8zSIAJwRFa8UA3FtZ5qV9gX7I/5pvPS0XC8xvNRFypS75b9ukYYeVqQ2jNKl5Gmy
        b145N4EA7NaIWXypiMcD8tEwK9jdO5W3NeSOfnfujt484x7HgYexw82q8PgvlrVa
        arhu+S5Uxly+T8fBM0nuYYKOwKUg7/OnscJ+hUgGZvt4ozOFBw7+ZW3u2z8XRUFn
        MJ0DviY3n2InMKTIHedEP9C20uAZYmv8YiLIlioGnT0eifihWqvPQ5e8cisk/fat
        nbGvbPy4B0WbD4XBupJjsOlm5BGi5uvwG2P519TkgRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Cu1gXp
        O0xWcS/oZfvCGwVEe4T6xgt0tebCnzb5vWblw=; b=uWbSXb9f0ooCPiW4rymwCA
        Ie5aijMVzdyymbLfb9nIJOGkf1Ix8sO56eub+U3IcFEdHXsipEBfeVBouoMcZAsi
        2aEFhhCSXYyP25wO13PfZ0wjfyWbdRrWHVOY+hg6PyMNZVfL5AmLMFq73evEiWKv
        DZvAz0Xib7hSRV0QuqqmKxh5grEyedoLh7dzHsbsUa5+Yryln11CVzfI9uRKnDi5
        rFnBWtsziVJmkfhKnvv0thco6NXD9rbyrHVcAgtGbRPr56StDTaT+sHVnAMYfx2q
        c+5y7Ez8DzQMYs1g4wIeubOWf/q6eZqPh+MZavN7gRYz3h3X7S3XghWjKC51gGzQ
        ==
X-ME-Sender: <xms:yygaXbRKT_HL3XKCyJuG6x-aJthLYDwVpH8AmP1nqHhJPGqVlZVQeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeigdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:yygaXVXbmE7JzfoqWFYHrDjxe77c8klKCPwvj-3x87uH6Pn2nJlX0A>
    <xmx:yygaXX5leVEukZwK0JrD1BURHFgmYFLb6nX-IKFIz9mSCclP4OCGPw>
    <xmx:yygaXQHI2rIZ2j9uETh0ZmpBJ0iNC4hmBNwux-_Y62z-zdgfioW0Kg>
    <xmx:yygaXRW56Gfw4LCErKL9X9nfiH_aTRiaUuRUkj5FN9A9b3shwKE18A>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A36A8005A;
        Mon,  1 Jul 2019 11:37:46 -0400 (EDT)
Date:   Mon, 1 Jul 2019 17:37:44 +0200
From:   Greg KH <greg@kroah.com>
To:     Caspar Zhang <caspar@linux.alibaba.com>
Cc:     Yihao Wu <wuyihao@linux.alibaba.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [backport request][stable] SUNRPC: Clean up initialisation of
 the struct rpc_rqst
Message-ID: <20190701153744.GA24719@kroah.com>
References: <1b4585b9-401a-9022-6bc9-5ecbe253799d@linux.alibaba.com>
 <20190701082547.GA89243@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701082547.GA89243@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 01, 2019 at 04:25:47PM +0800, Caspar Zhang wrote:
> On Mon, Jul 01, 2019 at 01:27:26AM +0800, Yihao Wu wrote:
> > Hi,
> >
> > I'm using kernel v4.19.y and find that v4.19.y panic when mounting NFSv4, which can be simply reproduced as follows:
> >
> >
> > while :; do
> > mkfs.ext4 -F /dev/vdb
> > mount /dev/vdb /tmp/mymnt_server
> > exportfs -o insecure,rw,sync,no_root_squash,fsid=1 127.0.0.1:/tmp/mymnt_server
> > mount -t nfs4 -o minorversion=0 127.0.0.1:/tmp/mymnt_server /tmp/mymnt_client
> > umount -f -l /tmp/mymnt_client
> > sleep 0.5
> > exportfs -r
> > sleep 0.2
> > umount -f -l /tmp/mymnt_server
> > done
> >
> >
> > # kernel 4.19.y
> > After a while, the kernel panic.
> 
> This is a Regression, introduced by the following commit:
> 
>     NFS4: Fix v4.0 client state corruption when mount
> 
> in v4.19.46[1].
> 
> The interesting part is, looks like commit 9dc6edcf676("SUNRPC: Clean up
> initialisation of the struct rpc_rqst")[2] is not targeted to fix this
> regression, but a general clean-up fix, maybe that explains somehow we
> missed this fix in stable tree ;-)
> 
> Since this is a Regression in stable tree, I strongly suggest we put the
> fix commit into 4.19. Greg, Trond, any comments?

Looks good to me, now queued up, thanks!

greg k-h
