Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D2345F31
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 14:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCWNO1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 09:14:27 -0400
Received: from p3plsmtpa08-01.prod.phx3.secureserver.net ([173.201.193.102]:59280
        "EHLO p3plsmtpa08-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231476AbhCWNNk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 09:13:40 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Mar 2021 09:13:40 EDT
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id OgjglFAwr0E92OgjglIxem; Tue, 23 Mar 2021 06:06:16 -0700
X-CMAE-Analysis: v=2.4 cv=bM3TnNyZ c=1 sm=1 tr=0 ts=6059e7c9
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=-c6L1L7GA5ZB5I1DlIIA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <ace78074-0d1f-ceed-10c2-48d2ad3bdde1@talpey.com>
Date:   Tue, 23 Mar 2021 09:06:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCve7YgOO/LPHxeq6C+jOsioqX/5nna/ozL88IGSkgY2m9g2xvrAA4T1G2/2VK2+cZkLVsLKYwK44h8NdoHMiQqFVVv5KE5D/AiPt3xv/BQe19HzjPoU
 uQWqb+rzl+Cp75vh5Kk0UHvGf6rVSmLEoFN+0AveMJBuLrEVXWb6lEMft0DJZrqXRwv7usJ6PwYHZpFjyTPP+p4kwZiSBLVsqrGPsosCOOdZklkbJO2E89QZ
 ywwWMafKkAUm7D4h4M6BWrC7kmJJz3yNnwRXaoESGHpCcTHytV3CJq3ynUxvpiRqeXz8e9a3h/Dv6OHQSiiR5g==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

All the patches in this series have the same subject/title. They
really should have more context so they stand alone and can be
reviewed separately.

High level question below.

On 3/23/2021 1:46 AM, Nagendra Tomar wrote:
> From: Nagendra S Tomar <natomar@microsoft.com>
> 
> If a clustered NFS server is behind an L4 loadbalancer the default
> nconnect roundrobin policy may cause RPC requests to a file to be
> sent to different cluster nodes. This is because the source port
> would be different for all the nconnect connections.
> While this should functionally work (since the cluster will usually
> have a consistent view irrespective of which node is serving the
> request), it may not be desirable from performance pov. As an
> example we have an NFSv3 frontend to our Object store, where every
> NFSv3 file is an object. Now if writes to the same file are sent
> roundrobin to different cluster nodes, the writes become very
> inefficient due to the consistency requirement for object update
> being done from different nodes.
> Similarly each node may maintain some kind of cache to serve the file
> data/metadata requests faster and even in that case it helps to have
> a xprt affinity for a file/dir.
> In general we have seen such scheme to scale very well.
> 
> This patch introduces a new rpc_xprt_iter_ops for using an additional
> u32 (filehandle hash) to affine RPCs to the same file to one xprt.
> It adds a new mount option "ncpolicy=roundrobin|hash" which can be
> used to select the nconnect multipath policy for a given mount and
> pass the selected policy to the RPC client.

What's the reason for exposing these as a mount option, with multiple
values? What makes one value better than the other, and why is there
not a default?

Tom.

> It adds a new rpc_procinfo member p_fhhash, which can be supplied
> by the specific RPC programs to return a u32 hash of the file/dir the
> RPC is targetting, and lastly it provides p_fhhash implementation
> for various NFS v3/v4/v41/v42 RPCs to generate the hash correctly.
> 
> Thoughts?
> 
> Thanks,
> Tomar
> 
> Nagendra S Tomar (5):
>    SUNRPC: Add a new multipath xprt policy for xprt selection based
>      on target filehandle hash
>    SUNRPC/NFSv3/NFSv4: Introduce "enum ncpolicy" to represent the nconnect
>      policy and pass it down from mount option to rpc layer
>    SUNRPC/NFSv4: Rename RPC_TASK_NO_ROUND_ROBIN -> RPC_TASK_USE_MAIN_XPRT
>    NFSv3: Add hash computation methods for NFSv3 RPCs
>    NFSv4: Add hash computation methods for NFSv4/NFSv42 RPCs
> 
>   fs/nfs/client.c                      |   3 +
>   fs/nfs/fs_context.c                  |  26 ++
>   fs/nfs/internal.h                    |   2 +
>   fs/nfs/nfs3client.c                  |   4 +-
>   fs/nfs/nfs3xdr.c                     | 154 +++++++++++
>   fs/nfs/nfs42xdr.c                    | 112 ++++++++
>   fs/nfs/nfs4client.c                  |  14 +-
>   fs/nfs/nfs4proc.c                    |  18 +-
>   fs/nfs/nfs4xdr.c                     | 516 ++++++++++++++++++++++++++++++-----
>   fs/nfs/super.c                       |   7 +-
>   include/linux/nfs_fs_sb.h            |   1 +
>   include/linux/sunrpc/clnt.h          |  15 +
>   include/linux/sunrpc/sched.h         |   2 +-
>   include/linux/sunrpc/xprtmultipath.h |   9 +-
>   include/trace/events/sunrpc.h        |   4 +-
>   net/sunrpc/clnt.c                    |  38 ++-
>   net/sunrpc/xprtmultipath.c           |  91 +++++-
>   17 files changed, 913 insertions(+), 103 deletions(-)
> 
