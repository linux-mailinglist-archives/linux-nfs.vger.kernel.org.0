Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5438F3479A1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 14:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhCXNbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 09:31:01 -0400
Received: from p3plsmtpa11-03.prod.phx3.secureserver.net ([68.178.252.104]:35187
        "EHLO p3plsmtpa11-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235262AbhCXNav (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Mar 2021 09:30:51 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2021 09:30:50 EDT
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id P3Tpl0vNfKEOAP3TqlxCqi; Wed, 24 Mar 2021 06:23:26 -0700
X-CMAE-Analysis: v=2.4 cv=erwacqlX c=1 sm=1 tr=0 ts=605b3d4e
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=odEeS2lDZInev2U_FtgA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=fCgQI5UlmZDRPDxm0A3o:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Nagendra Tomar <Nagendra.Tomar@microsoft.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
 <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <8ad09054-967e-d58b-1bba-c63aa5362f6f@talpey.com>
Date:   Wed, 24 Mar 2021 09:23:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfONyZtFcJrVXm7c34BrJ/6uI+bDIFqJGgLK+O7jaoSn5q5q93+s42e/ibzh8dyrYCY1nsi+jg5wAOcJjsiR5W0D2nE+JHUEx4N4hK6GO3tgYAjxy+Ncz
 GzX/TEMT1wbjeCZh4ziuxSiBI8982oJ5VACaCqS5IftMZfXV8+ZENFLdcQa/wwOGChdNMMDKOWz+RSqv4d2avMVKlx3ZitAvQivzgN7eNUqvrZhvqcalxb2S
 ibySteQzQZCg/cnaO7Anpa5yIHMTSTbwuF7UJEjFZV+RYTv/XnPZ+u3e2NSVgfrL0HlmRJfuvoAM3eOuvio9yBks6Mczyf/hwjAGqoAhSWkxcwIlsPbhH/oE
 Wkg9wk0a
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/23/2021 12:14 PM, Chuck Lever III wrote:
> 
> 
>> On Mar 23, 2021, at 11:57 AM, Nagendra Tomar <Nagendra.Tomar@microsoft.com> wrote:
>>
>>>> On Mar 23, 2021, at 1:46 AM, Nagendra Tomar
>>> <Nagendra.Tomar@microsoft.com> wrote:
>>>>
>>>> From: Nagendra S Tomar <natomar@microsoft.com>
>>>>
>>>> If a clustered NFS server is behind an L4 loadbalancer the default
>>>> nconnect roundrobin policy may cause RPC requests to a file to be
>>>> sent to different cluster nodes. This is because the source port
>>>> would be different for all the nconnect connections.
>>>> While this should functionally work (since the cluster will usually
>>>> have a consistent view irrespective of which node is serving the
>>>> request), it may not be desirable from performance pov. As an
>>>> example we have an NFSv3 frontend to our Object store, where every
>>>> NFSv3 file is an object. Now if writes to the same file are sent
>>>> roundrobin to different cluster nodes, the writes become very
>>>> inefficient due to the consistency requirement for object update
>>>> being done from different nodes.
>>>> Similarly each node may maintain some kind of cache to serve the file
>>>> data/metadata requests faster and even in that case it helps to have
>>>> a xprt affinity for a file/dir.
>>>> In general we have seen such scheme to scale very well.
>>>>
>>>> This patch introduces a new rpc_xprt_iter_ops for using an additional
>>>> u32 (filehandle hash) to affine RPCs to the same file to one xprt.
>>>> It adds a new mount option "ncpolicy=roundrobin|hash" which can be
>>>> used to select the nconnect multipath policy for a given mount and
>>>> pass the selected policy to the RPC client.
>>>
>>> This sets off my "not another administrative knob that has
>>> to be tested and maintained, and can be abused" allergy.
>>>
>>> Also, my "because connections are shared by mounts of the same
>>> server, all those mounts will all adopt this behavior" rhinitis.
>>
>> Yes, it's fair to call this out, but ncpolicy behaves like the nconnect
>> parameter in this regards.
>>
>>> And my "why add a new feature to a legacy NFS version" hives.
>>>
>>>
>>> I agree that your scenario can and should be addressed somehow.
>>> I'd really rather see this done with pNFS.
>>>
>>> Since you are proposing patches against the upstream NFS client,
>>> I presume all your clients /can/ support NFSv4.1+. It's the NFS
>>> servers that are stuck on NFSv3, correct?
>>
>> Yes.
>>
>>>
>>> The flexfiles layout can handle an NFSv4.1 client and NFSv3 data
>>> servers. In fact it was designed for exactly this kind of mix of
>>> NFS versions.
>>>
>>> No client code change will be necessary -- there are a lot more
>>> clients than servers. The MDS can be made to work smartly in
>>> concert with the load balancer, over time; or it can adopt other
>>> clever strategies.
>>>
>>> IMHO pNFS is the better long-term strategy here.
>>
>> The fundamental difference here is that the clustered NFSv3 server
>> is available over a single virtual IP, so IIUC even if we were to use
>> NFSv41 with flexfiles layout, all it can handover to the client is that single
>> (load-balanced) virtual IP and now when the clients do connect to the
>> NFSv3 DS we still have the same issue. Am I understanding you right?
>> Can you pls elaborate what you mean by "MDS can be made to work
>> smartly in concert with the load balancer"?
> 
> I had thought there were multiple NFSv3 server targets in play.
> 
> If the load balancer is making them look like a single IP address,
> then take it out of the equation: expose all the NFSv3 servers to
> the clients and let the MDS direct operations to each data server.
> 
> AIUI this is the approach (without the use of NFSv3) taken by
> NetApp next generation clusters.

It certainly sounds like the load balancer is actually performing a
storage router function here, and roundrobin is going to thrash that
badly. I'm not sure that exposing a magic "hash" knob is a very good
solution though. Pushing decisions to the sysadmin is rarely a great
approach.

Why not simply argue that "hash" is the better algorithm, and prove
that it be the default? Is that not the case?

Tom.

>>>> It adds a new rpc_procinfo member p_fhhash, which can be supplied
>>>> by the specific RPC programs to return a u32 hash of the file/dir the
>>>> RPC is targetting, and lastly it provides p_fhhash implementation
>>>> for various NFS v3/v4/v41/v42 RPCs to generate the hash correctly.
>>>>
>>>> Thoughts?
>>>>
>>>> Thanks,
>>>> Tomar
>>>>
>>>> Nagendra S Tomar (5):
>>>> SUNRPC: Add a new multipath xprt policy for xprt selection based
>>>>    on target filehandle hash
>>>> SUNRPC/NFSv3/NFSv4: Introduce "enum ncpolicy" to represent the
>>> nconnect
>>>>    policy and pass it down from mount option to rpc layer
>>>> SUNRPC/NFSv4: Rename RPC_TASK_NO_ROUND_ROBIN ->
>>> RPC_TASK_USE_MAIN_XPRT
>>>> NFSv3: Add hash computation methods for NFSv3 RPCs
>>>> NFSv4: Add hash computation methods for NFSv4/NFSv42 RPCs
>>>>
>>>> fs/nfs/client.c                      |   3 +
>>>> fs/nfs/fs_context.c                  |  26 ++
>>>> fs/nfs/internal.h                    |   2 +
>>>> fs/nfs/nfs3client.c                  |   4 +-
>>>> fs/nfs/nfs3xdr.c                     | 154 +++++++++++
>>>> fs/nfs/nfs42xdr.c                    | 112 ++++++++
>>>> fs/nfs/nfs4client.c                  |  14 +-
>>>> fs/nfs/nfs4proc.c                    |  18 +-
>>>> fs/nfs/nfs4xdr.c                     | 516 ++++++++++++++++++++++++++++++-----
>>>> fs/nfs/super.c                       |   7 +-
>>>> include/linux/nfs_fs_sb.h            |   1 +
>>>> include/linux/sunrpc/clnt.h          |  15 +
>>>> include/linux/sunrpc/sched.h         |   2 +-
>>>> include/linux/sunrpc/xprtmultipath.h |   9 +-
>>>> include/trace/events/sunrpc.h        |   4 +-
>>>> net/sunrpc/clnt.c                    |  38 ++-
>>>> net/sunrpc/xprtmultipath.c           |  91 +++++-
>>>> 17 files changed, 913 insertions(+), 103 deletions(-)
>>>
>>> --
>>> Chuck Lever
> 
> --
> Chuck Lever
> 
> 
> 
> 
