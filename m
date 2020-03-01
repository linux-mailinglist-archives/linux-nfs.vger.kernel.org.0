Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D249174EDA
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2020 19:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCASJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 13:09:25 -0500
Received: from p3plsmtpa12-07.prod.phx3.secureserver.net ([68.178.252.236]:43747
        "EHLO p3plsmtpa12-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbgCASJZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 13:09:25 -0500
Received: from [172.20.1.219] ([50.235.29.75])
        by :SMTPAUTH: with ESMTPSA
        id 8T1njeXR6R8ul8T1oj6NVm; Sun, 01 Mar 2020 11:09:24 -0700
X-CMAE-Analysis: v=2.3 cv=I+Ubu+og c=1 sm=1 tr=0
 a=VA9wWQeJdn4CMHigaZiKkA==:117 a=VA9wWQeJdn4CMHigaZiKkA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=qUmw6LHj88nit2jrCvkA:9
 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 00/11] NFS/RDMA client side connection overhaul
To:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <3a891d0c-3192-6445-c4df-3725335e9d95@talpey.com>
Date:   Sun, 1 Mar 2020 10:09:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221214906.2072.32572.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDpQvDNGQ7tr4+BUuy5qoMRogC/KpQEBpqNQWtVbSsUSd9C8Ir5/dV/hbJrXBD6gJ8398qXgGRbNQJf1adzIU99viOAVGT8rZOLtNAT9LMjcScDwdu8e
 Io/VevlQqrHvbyKKBclmAHLSgLGrb6IwFTTvRi1Der1Z7FekIp4U16P2GHIeGVYgtc6snwgSoIX5eBxEvDm1adssSZMhFQPX3CV25mGTFxvg25TBazJW+akT
 xGRnvk7uLp7MFqz6L4oVlg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/21/2020 2:00 PM, Chuck Lever wrote:
> Howdy.
> 
> I've had reports (and personal experience) where the Linux NFS/RDMA
> client waits for a very long time after a disruption of the network
> or NFS server.
> 
> There is a disconnect time wait in the Connection Manager which
> blocks the RPC/RDMA transport from tearing down a connection for a
> few minutes when the remote cannot respond to DREQ messages.

This seems really unfortunate. Why such a long wait in the RDMA layer?
I can see a backoff, to prevent connection attempt flooding, but a
constant "few minute" pause is a very blunt instrument.

> An RPC/RDMA transport has only one slot for connection state, so the
> transport is prevented from establishing a fresh connection until
> the time wait completes.
> 
> This patch series refactors the connection end point data structures
> to enable one active and multiple zombie connections. Now, while a
> defunct connection is waiting to die, it is separated from the
> transport, clearing the way for the immediate creation of a new
> connection. Clean-up of the old connection's data structures and
> resources then completes in the background.

This is a good idea in any case. It separates the layers, and leads
to better connection establishment throughput.

Does the RPCRDMA layer ensure it backs off, if connection retries
fail? Or are you depending on the NFS upper layer for this.

Tom.

> Well, that's the idea, anyway. Review and comments welcome. Hoping
> this can be merged in v5.7.
> 
> ---
> 
> Chuck Lever (11):
>        xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
>        xprtrdma: Refactor frwr_init_mr()
>        xprtrdma: Clean up the post_send path
>        xprtrdma: Refactor rpcrdma_ep_connect() and rpcrdma_ep_disconnect()
>        xprtrdma: Allocate Protection Domain in rpcrdma_ep_create()
>        xprtrdma: Invoke rpcrdma_ia_open in the connect worker
>        xprtrdma: Remove rpcrdma_ia::ri_flags
>        xprtrdma: Disconnect on flushed completion
>        xprtrdma: Merge struct rpcrdma_ia into struct rpcrdma_ep
>        xprtrdma: Extract sockaddr from struct rdma_cm_id
>        xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt
> 
> 
>   include/trace/events/rpcrdma.h    |   97 ++---
>   net/sunrpc/xprtrdma/backchannel.c |    8
>   net/sunrpc/xprtrdma/frwr_ops.c    |  152 ++++----
>   net/sunrpc/xprtrdma/rpc_rdma.c    |   32 +-
>   net/sunrpc/xprtrdma/transport.c   |   72 +---
>   net/sunrpc/xprtrdma/verbs.c       |  681 ++++++++++++++-----------------------
>   net/sunrpc/xprtrdma/xprt_rdma.h   |   89 ++---
>   7 files changed, 445 insertions(+), 686 deletions(-)
> 
> --
> Chuck Lever
> 
> 
