Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D15049B72E
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388423AbiAYPET (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 10:04:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43930 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358068AbiAYPB5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 10:01:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D02BB81814;
        Tue, 25 Jan 2022 15:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44222C340E0;
        Tue, 25 Jan 2022 15:01:40 +0000 (UTC)
Date:   Tue, 25 Jan 2022 10:01:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: linux-next: runtime warning in next-20220125
Message-ID: <20220125100138.0d19c8ca@gandalf.local.home>
In-Reply-To: <20220125162146.13872bdb@canb.auug.org.au>
References: <20220125160505.068dbb52@canb.auug.org.au>
        <20220125162146.13872bdb@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022 16:21:46 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Tue, 25 Jan 2022 16:05:05 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > My qemu boot test of a powerpc pseries_le_defconfig kernel produces the
> > following trace:
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at kernel/trace/trace_events.c:417 trace_event_raw_init+0x194/0x730
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc1 #2
> > NIP:  c0000000002bdbb4 LR: c0000000002bdcb0 CTR: c0000000002bdb70
> > 
> > I have no idea what has caused this :-(  Maybe commit
> > 
> >   5544d5318802 ("SUNRPC: Same as SVC_RQST_ENDPOINT, but without the xid")  
> 
> Actually, reverting commits
> 
>   6ff851d98af8 ("SUNRPC: Improve sockaddr handling in the svc_xprt_create_error trace point")
>   5544d5318802 ("SUNRPC: Same as SVC_RQST_ENDPOINT, but without the xid")
>   e2d3613db12a ("SUNRPC: Record endpoint information in trace log")
> 
> makes the warning go away.
> 

We added a new way to save items on the ring buffer, but did not update the
safety checks to know about them. I'll fix this shortly.

-- Steve


