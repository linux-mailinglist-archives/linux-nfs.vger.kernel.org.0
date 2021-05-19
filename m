Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8348E389271
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354573AbhESPWN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 11:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354564AbhESPWG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 May 2021 11:22:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F301610A8;
        Wed, 19 May 2021 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621437645;
        bh=3+9rvynNd8HYd4k51Z7zS9qoKyq5UZFHkH6xhY5p2JU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3n4UsNjr7kl+Ql764EN2DQLeN07wKo7FkScraqkyEWQ6ZlYxvngaCKGHAxF9JjZu
         0engIRSvx000O/e7TgXb6ZCcZF8fw4yZEzDidZpH4LL5lLVzEVQj2HVJ4bKtalwTet
         0jPogiyi7RH7hPCeMNbfoJiEjOZrxYJWsNWyfTsO/SP1PVqoGkCU812ZxnL5nV7qSO
         RWixH/aLGgz4dwt9h0Xql3pVactv6sySZHNMDQpXWo4ptvr9ft8z8GmfNEFWTL0yJc
         7niLo0B7ZcCBUASPLLdloXBj6v7drlPM4tXK2FlB7pY1f0Gg0cRAvBv1rY4yq2PTie
         9X3V9vhSboFyQ==
Date:   Wed, 19 May 2021 18:20:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Message-ID: <YKUsyKUFdL9IfLRp@unreal>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 17, 2021 at 04:27:29PM +0000, Chuck Lever III wrote:
> Hello Timo-
> 
> > On May 16, 2021, at 1:29 PM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
> > 
> > This has happened 3 times so far over the last couple months, and I do not have a clear way to reproduce it.
> > It happens under moderate load, when lots of nodes read and write from the server. Though not in any super intense way. Just normal program execution, writing of light logs, and other standard tasks.
> > 
> > The issues on the clients manifest in a multitude of ways. Most of the time, random IO operations just fail, rarely hang indefinitely and make the process unkillable.
> > Another example would be: "Failed to remove '.../.nfs00000000007b03af00000001': Device or resource busy"
> > 
> > Once a client is in that state, the only way to get it back into order is a reboot.
> > 
> > On the server side, a single error cqe is dumped each time this problem happened. So far, I always rebooted the server as well, to make sure everything is back in order. Not sure if that is strictly necessary.
> > 
> >> [561889.198889] infiniband mlx5_0: dump_cqe:272:(pid 709): dump error cqe
> >> [561889.198945] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> [561889.198984] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> [561889.199023] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> [561889.199061] 00000030: 00 00 00 00 00 00 88 13 08 00 01 13 07 47 67 d2
> > 
> >> [985074.602880] infiniband mlx5_0: dump_cqe:272:(pid 599): dump error cqe
> >> [985074.602921] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> [985074.602946] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> [985074.602970] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> [985074.602994] 00000030: 00 00 00 00 00 00 88 13 08 00 01 46 f2 93 0b d3
> > 
> >> [1648894.168819] infiniband ibp1s0: dump_cqe:272:(pid 696): dump error cqe
> >> [1648894.168853] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> [1648894.168878] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> [1648894.168903] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> [1648894.168928] 00000030: 00 00 00 00 00 00 88 13 08 00 01 08 6b d2 b9 d3
> 
> I'm hoping Leon can get out his magic decoder ring and tell us if
> these CQE dumps contain a useful WC status code.

Unfortunately, no. I failed to parse it, if I read the dump correctly,
it is not marked as error and opcode is 0.

Thanks
