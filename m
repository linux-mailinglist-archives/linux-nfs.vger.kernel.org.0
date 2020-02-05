Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA51153B57
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 23:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBEWtD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 17:49:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46652 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbgBEWtC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Feb 2020 17:49:02 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izTTc-00809s-GG; Wed, 05 Feb 2020 22:48:56 +0000
Date:   Wed, 5 Feb 2020 22:48:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: linux-next: manual merge of the vfs tree with the nfs-anna tree
Message-ID: <20200205224856.GX23230@ZenIV.linux.org.uk>
References: <20200206092512.5eb304b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206092512.5eb304b7@canb.auug.org.au>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 06, 2020 at 09:25:12AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vfs tree got a conflict in:
> 
>   fs/nfs/dir.c
> 
> between commit:
> 
>   227823d2074d ("nfs: optimise readdir cache page invalidation")
> 
> from the nfs-anna tree and commit:
> 
>   ef3af2d44331 ("nfs: optimise readdir cache page invalidation")
> 
> from the vfs tree.
> 
> I fixed it up (I used the nfs-anna tree version) and can carry the fix
> as necessary. This is now fixed as far as linux-next is concerned, but
> any non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Umm...  OK, I'll redo that merge; FWIW, the only reason I pull that
branch in the first place is that bunch of fixups needed to accomodate
it for work.fs_parse changes.

As soon as nfs-anna lands in mainline, I'm going to send Linus a pull
requrest for work.fs_parse + fixups...
