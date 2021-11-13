Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E2444F57D
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Nov 2021 22:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhKMVf7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Nov 2021 16:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhKMVf6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Nov 2021 16:35:58 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B8C061766
        for <linux-nfs@vger.kernel.org>; Sat, 13 Nov 2021 13:33:06 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id BCC666F2A; Sat, 13 Nov 2021 16:33:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BCC666F2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1636839185;
        bh=5ddBuseDbRa7q1QCRlHfg+I6lPAvQfUSnXt9HBqcFew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkKxHHdus21Z/Mk+N/OY73V5YKsnHqD+ubXqVI0s/vyXwwGkok/yobCArn3uqFAjQ
         EbxEIlCW6iydC7DENpSanvMaPGtgyAAsYAetKZnrDKOB0MxrD/ESPuuxpx6BMVoXjn
         rS68UuMQM5bwDo65dnO/QL13hjnUIyDjtGpSnPFI=
Date:   Sat, 13 Nov 2021 16:33:05 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     rtm@csail.mit.edu
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Message-ID: <20211113213305.GC27601@fieldses.org>
References: <97860.1636837122@crash.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97860.1636837122@crash.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

By the way, thanks for this work.  Just out of curiosity: did anything
in particular prompt this?  And do you have some tool that's finding
these, or is it manual code inspection, or some combination?

--b.

On Sat, Nov 13, 2021 at 03:58:42PM -0500, rtm@csail.mit.edu wrote:
> nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
> directs it to do so. This can cause nfsd4_decode_state_protect4_a() to
> write client-supplied data beyond the end of
> nfsd4_exchange_id.spo_must_allow[] when called by
> nfsd4_decode_exchange_id().
> 
> I've attached a demo in which the client's EXCHANGE_ID RPC supplies an
> address (0x400) that nfsd4_decode_bitmap4() writes into
> nii_domain.data due to overflowing bmval[]. The EXCHANGE_ID RPC also
> supplies a zero-length eia_client_impl_id<>. The result is that
> copy_impl_id() (called by nfsd4_exchange_id()) tries to read from
> address 0x400.
> 
> # cc nfsd_1.c
> # uname -a
> Linux (none) 5.15.0-rc7-dirty #64 SMP Sat Nov 13 20:10:21 UTC 2021 riscv64 riscv64 riscv64 GNU/Linux
> # ./nfsd_1
> ...
> [   16.600786] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000400
> [   16.643621] epc : __memcpy+0x3c/0xf8
> [   16.650154]  ra : kmemdup+0x2c/0x3c
> [   16.657733] epc : ffffffff803667bc ra : ffffffff800e80fe sp : ffffffd000553c20
> [   16.777502] status: 0000000200000121 badaddr: 0000000000000400 cause: 000000000000000d
> [   16.788193] [<ffffffff803667bc>] __memcpy+0x3c/0xf8
> [   16.796504] [<ffffffff8028cf0e>] nfsd4_exchange_id+0xe6/0x406
> [   16.806159] [<ffffffff8027c352>] nfsd4_proc_compound+0x2b4/0x4e8
> [   16.815721] [<ffffffff80266782>] nfsd_dispatch+0x118/0x172
> [   16.823405] [<ffffffff807633fa>] svc_process_common+0x2de/0x62c
> [   16.832935] [<ffffffff8076380c>] svc_process+0xc4/0x102
> [   16.840421] [<ffffffff802661de>] nfsd+0x102/0x16a
> [   16.848520] [<ffffffff80025b60>] kthread+0xfe/0x110
> [   16.856648] [<ffffffff80003054>] ret_from_exception+0x0/0xc
> 


