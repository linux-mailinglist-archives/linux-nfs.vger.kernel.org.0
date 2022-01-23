Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E7B497612
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jan 2022 23:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiAWWml (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 17:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiAWWmk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 17:42:40 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD8C06173B
        for <linux-nfs@vger.kernel.org>; Sun, 23 Jan 2022 14:42:40 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 05362602D; Sun, 23 Jan 2022 17:42:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 05362602D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642977759;
        bh=NLco8ANhlkuO6fI32wONj3S8dhPDJImmSS4uwpX7NWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdUvyXQVY+lm7jY5KZ1gpP25LDv0Q77folEtQXd/VaNHl/Y37tCt7W2mZ3dIfunO0
         8sZLz7a2e34QOAe7qRPhIKcJ5hbR2D80VnhNKj6Dk4If5Xu62wNFLxHI88a0au/bnS
         qMj7sNz7XTU9Jgyg7u+S1GMAfXYE8G0q/ir6CMLk=
Date:   Sun, 23 Jan 2022 17:42:38 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
Message-ID: <20220123224238.GA9255@fieldses.org>
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
 <CAPt2mGPtxNzigMEYXKFX0ayVc__gyJcQJVHU51CKqU+ujqh7Cg@mail.gmail.com>
 <20220110145210.GA18213@fieldses.org>
 <20220110172106.GC18213@fieldses.org>
 <CAPt2mGPUa_VHHshXwLLCH=wvdrd6Hyb4gttMeEqKdgFV4GJY7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGPUa_VHHshXwLLCH=wvdrd6Hyb4gttMeEqKdgFV4GJY7g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 23, 2022 at 09:56:19PM +0000, Daire Byrne wrote:
> On Mon, 10 Jan 2022 at 17:21, J. Bruce Fields <bfields@fieldses.org> wrote:
> > Looks to me like the mount option may just be getting lost on the way
> > down to the rpc client somehow, but I'm not quite sure how it's supposed
> > to work, and a naive attempt to copy what v3 is doing (below) wasn't
> > sufficient.
> >
> > --b.
> 
> Should I just open a bugzilla?

Worth a try.  It's probably nothing complicated, just a matter of time
to dig into it....

> It would be nice to mount more than 7
> remote v4 servers with nconnect=16.
> 
> I did a very quick test of RHEL7 and RHEL8 client kernels and it seems
> like they are doing the right thing with vers=4.2,noresvport.
> 
> I suspect it's just more recent kernels that has lost the ability to
> use v4+noresvport

Yes, thanks for checking that.  Let us know if you narrow down the
kernel any more.

> (or newer nfs-utils?).

Pretty sure nfs-utils is doing the right thing and passing down the
noresvport option:

# strace -f -etrace=mount mount -overs=4.2,resvport localhost:/ /mnt/
strace: Process 4088 attached
[pid  4088] mount("localhost:/", "/mnt", "nfs", 0, "vers=4.2,resvport,addr=127.0.0.1"...)

--b.
