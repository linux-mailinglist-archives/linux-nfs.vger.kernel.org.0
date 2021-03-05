Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3A32EC6F
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 14:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCENnK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Mar 2021 08:43:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhCENm4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Mar 2021 08:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614951776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o+id3uXu8Xf3BgNJMKx3xsWSbIpfn0er0zjHSyTY0LA=;
        b=R1vPCXJKbsU/CxmtwAuqRZbKrqKlelVnv+6Dlqyiz0W/DhCW2xQ+HkjzR/4WcQ8JTGX6J8
        LaY2EUeTWcu11Tinr60rF5b9asY4KMdX3ighhUSIpcUdE1PL80EjTqVIs2zb/a9bBMH5SH
        gcbL0avmJLMU6EDdP47/txDWNZSUCLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-aM2AS3n9MiSTTBgytn-ByA-1; Fri, 05 Mar 2021 08:42:54 -0500
X-MC-Unique: aM2AS3n9MiSTTBgytn-ByA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E94B1005D4A;
        Fri,  5 Mar 2021 13:42:53 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EB5B60C66;
        Fri,  5 Mar 2021 13:42:52 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Roberto Bergantinos Corpas" <rbergant@redhat.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        anna.schumaker@netapp.com
Subject: Re: [PATCH] pNFS: make DS availability problems visible in log
Date:   Fri, 05 Mar 2021 08:42:51 -0500
Message-ID: <20954E17-8391-4C91-8C05-A55F9797FC67@redhat.com>
In-Reply-To: <CACWnjLw9KQ+-d2otHQ_-vx34Up1A-EiY=2phQOwUu8S-ZExyhw@mail.gmail.com>
References: <20210303153307.3147-1-rbergant@redhat.com>
 <FBBBDFDD-6819-450C-879D-0B11B917BD10@oracle.com>
 <9e98d684c6ecdbb0395beb66a0bc694c4ca870c8.camel@hammerspace.com>
 <CACWnjLw9KQ+-d2otHQ_-vx34Up1A-EiY=2phQOwUu8S-ZExyhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There's always going to be some sort of user intervention, even if the 
intervention is to read the system's logs.  What does the solution to 
notice DS problems ideally look like to the user?  Instead of "check the 
logs for DS problems", couldn't you replace that with "run this script 
to check for DS problems"?

Ben

On 5 Mar 2021, at 7:29, Roberto Bergantinos Corpas wrote:

> Trond, Chuck
>
> thanks for feedback. I understand the point
>
> Sure we can turn those printks into tracepoints, done. However
> original point was flag somehow DS issues
> outside debug, i.e. user intervention. What about just a pr_warn_once
> just for the case when at _nfs4_pnfs_v4_ds_connect
> we could not reach any DS ?
>
> On Thu, Mar 4, 2021 at 9:35 PM Trond Myklebust 
> <trondmy@hammerspace.com> wrote:
>>
>> On Thu, 2021-03-04 at 20:20 +0000, Chuck Lever wrote:
>>> Hello Roberto!
>>>
>>>> On Mar 3, 2021, at 10:33 AM, Roberto Bergantinos Corpas <
>>>> rbergant@redhat.com> wrote:
>>>>
>>>> Would be interesting to promote DS availability logging outside
>>>> debug
>>>> so that we are more aware that I/O is diverted to MDS and some part
>>>> of the infraestructure failed.
>>>>
>>>> Also added logging for failed DS connection attempts.
>>>
>>> Given that this enables remote system behavior to generate
>>> kernel log traffic that can fill the local root partition,
>>> I'd like to see either:
>>>
>>> - the explicit use of rate limiting, or
>>>
>>> - these dprintks replaced with tracepoints
>>
>> I cannot accept a pr_warn(), even a rate limited one, for a timeout
>> error or for a connection error in the data path. Those are just too
>> nasty to deal with in a syslog.
>>
>> Tracepoints would be acceptable.
>>
>>>
>>>
>>>> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
>>>> ---
>>>> fs/nfs/filelayout/filelayout.c         | 4 ++--
>>>> fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
>>>> fs/nfs/pnfs_nfs.c                      | 6 +++++-
>>>> 3 files changed, 10 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/fs/nfs/filelayout/filelayout.c
>>>> b/fs/nfs/filelayout/filelayout.c
>>>> index 7f5aa0403e16..fef2d31a501a 100644
>>>> --- a/fs/nfs/filelayout/filelayout.c
>>>> +++ b/fs/nfs/filelayout/filelayout.c
>>>> @@ -181,7 +181,7 @@ static int filelayout_async_handle_error(struct
>>>> rpc_task *task,
>>>>         case -EIO:
>>>>         case -ETIMEDOUT:
>>>>         case -EPIPE:
>>>> -               dprintk("%s DS connection error %d\n", __func__,
>>>> +               pr_warn("%s DS connection error %d\n", __func__,
>>>>                         task->tk_status);
>>>>                 nfs4_mark_deviceid_unavailable(devid);
>>>>                 pnfs_error_mark_layout_for_return(inode, lseg);
>>>> @@ -190,7 +190,7 @@ static int filelayout_async_handle_error(struct
>>>> rpc_task *task,
>>>>                 fallthrough;
>>>>         default:
>>>> reset:
>>>> -               dprintk("%s Retry through MDS. Error %d\n",
>>>> __func__,
>>>> +               pr_warn("%s Retry through MDS. Error %d\n",
>>>> __func__,
>>>>                         task->tk_status);
>>>>                 return -NFS4ERR_RESET_TO_MDS;
>>>>         }
>>>> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
>>>> b/fs/nfs/flexfilelayout/flexfilelayout.c
>>>> index a163533446fa..7150d94e80e6 100644
>>>> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
>>>> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
>>>> @@ -1129,7 +1129,7 @@ static int
>>>> ff_layout_async_handle_error_v4(struct rpc_task *task,
>>>>         case -EIO:
>>>>         case -ETIMEDOUT:
>>>>         case -EPIPE:
>>>> -               dprintk("%s DS connection error %d\n", __func__,
>>>> +               pr_warn("%s DS connection error %d\n", __func__,
>>>>                         task->tk_status);
>>>>                 nfs4_delete_deviceid(devid->ld, devid->nfs_client,
>>>>                                 &devid->deviceid);
>>>> @@ -1139,7 +1139,7 @@ static int
>>>> ff_layout_async_handle_error_v4(struct rpc_task *task,
>>>>                 if (ff_layout_avoid_mds_available_ds(lseg))
>>>>                         return -NFS4ERR_RESET_TO_PNFS;
>>>> reset:
>>>> -               dprintk("%s Retry through MDS. Error %d\n",
>>>> __func__,
>>>> +               pr_warn("%s Retry through MDS. Error %d\n",
>>>> __func__,
>>>>                         task->tk_status);
>>>>                 return -NFS4ERR_RESET_TO_MDS;
>>>>         }
>>>> @@ -1167,7 +1167,7 @@ static int
>>>> ff_layout_async_handle_error_v3(struct rpc_task *task,
>>>>                 nfs_inc_stats(lseg->pls_layout->plh_inode,
>>>> NFSIOS_DELAY);
>>>>                 goto out_retry;
>>>>         default:
>>>> -               dprintk("%s DS connection error %d\n", __func__,
>>>> +               pr_warn("%s DS connection error %d\n", __func__,
>>>>                         task->tk_status);
>>>>                 nfs4_delete_deviceid(devid->ld, devid->nfs_client,
>>>>                                 &devid->deviceid);
>>>> diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
>>>> index 679767ac258d..322661a48348 100644
>>>> --- a/fs/nfs/pnfs_nfs.c
>>>> +++ b/fs/nfs/pnfs_nfs.c
>>>> @@ -934,8 +934,11 @@ static int _nfs4_pnfs_v4_ds_connect(struct
>>>> nfs_server *mds_srv,
>>>>                                                 (struct sockaddr
>>>> *)&da->da_addr,
>>>>                                                 da->da_addrlen,
>>>> IPPROTO_TCP,
>>>>                                                 timeo, retrans,
>>>> minor_version);
>>>> -                       if (IS_ERR(clp))
>>>> +                       if (IS_ERR(clp)) {
>>>> +                               pr_warn("%s: DS: %s unable to
>>>> connect with address %s, error: %ld\n",
>>>> +                                       __func__, ds->ds_remotestr,
>>>> da->da_remotestr, PTR_ERR(clp));
>>>>                                 continue;
>>>> +                       }
>>>>
>>>>                         status = nfs4_init_ds_session(clp,
>>>>                                         mds_srv->nfs_client-
>>>>> cl_lease_time);
>>>> @@ -949,6 +952,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct
>>>> nfs_server *mds_srv,
>>>>         }
>>>>
>>>>         if (IS_ERR(clp)) {
>>>> +               pr_warn("%s: no DS available\n", __func__);
>>>>                 status = PTR_ERR(clp);
>>>>                 goto out;
>>>>         }
>>>> --
>>>> 2.21.0
>>>>
>>>
>>> --
>>> Chuck Lever
>>>
>>>
>>>
>>
>> --
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
>> trond.myklebust@hammerspace.com
>>
>>

