Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9402A6818
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 16:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgKDPvO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 10:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKDPvO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 10:51:14 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071F3C0613D3;
        Wed,  4 Nov 2020 07:51:14 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h6so16939068pgk.4;
        Wed, 04 Nov 2020 07:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kUav6eXWp0jPmPreHo7LWFE6KwlgV1KptSaV2Oi4UhE=;
        b=YBmGjpKMk7axAXImrhjZeTr8OHLq0d3e7rP6UVggE0HLVS7iMiiy6ZV2my1w7Or+DW
         3+cZmeYPrVjWOKHMbej5WIhKY4wcZkwElHrqY6uhqMF2VtruyRSS+/V6yghTG6Wnq6X8
         0QSfLB193BPiz1DNZeWDF6IagmAtoztzCsbtd5vHum+No5lEJNLnctn2cwWbAKGlBBoD
         K2OHnApQ4kklKfE1CisQR9v1cjimu07PQxrlxWcT2WsDbkk1qPBdcgd0KePpngfcvLHP
         lZwp+m2TvtydpUxUzGO1NzT+b2NWLfR3uJ9A0RW2Fuozxyc6Ojy6qxgEdU4jUqWmvauS
         SEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUav6eXWp0jPmPreHo7LWFE6KwlgV1KptSaV2Oi4UhE=;
        b=nT2AqVJMZoNbusZp2iI+GK9EtPFYsOQRWrMwfqcU/Qg+bNS0JIwMoR6vj4v4IoK5Bd
         V+qbxeuXeA8I2P+Lyh5Eg0i24UA/ozRnbkIp4L5AtV8ha6ncoEIBn9nQyYCWm8qa5y6Q
         d2HxN0pdcZJ9zoOu1WvRTawmaZh2P6udsSkA2jKoVyOFeJM2Q0mJ+U1ki5oZ0OcAfnta
         0f2NobzZNAIsZzwAb5dNFK0PpZPyH4Nsl/ziAF7Uhsd0iUFZf7qXTa3/CZNREfzaAlF6
         aBL9GwS/5S0TX70+EgBiiJ8UvvCkzxPrUl/uELp5E+E5ZHwWZ182uIQm0OUiSd1vIHxz
         0vOQ==
X-Gm-Message-State: AOAM530wiTzZhxHaFzkf1YHGiQylwEOhZpRG1lBgABgdVABtzln51iwQ
        jYhJEqBLETyYdXTnoFAhc/yg/626vJP5VQ==
X-Google-Smtp-Source: ABdhPJzrfRmH0bfHOo6g6dN6Uuu4oikRo7o02fkBhsLFG0tkSLYvjSpS+ho3JabnXlxiyVZBEF/NnQ==
X-Received: by 2002:a17:90a:2e15:: with SMTP id q21mr4879528pjd.123.1604505073567;
        Wed, 04 Nov 2020 07:51:13 -0800 (PST)
Received: from soladeMBP.lan (173.28.92.34.bc.googleusercontent.com. [34.92.28.173])
        by smtp.gmail.com with ESMTPSA id mt2sm2605605pjb.7.2020.11.04.07.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 07:51:12 -0800 (PST)
Subject: Re: [PATCH 2/2] NFS: Limit the number of retries
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chenwenle@huawei.com" <chenwenle@huawei.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nixiaoming@huawei.com" <nixiaoming@huawei.com>
References: <20201102162438.14034-1-chenwenle@huawei.com>
 <20201102162438.14034-3-chenwenle@huawei.com>
 <8db50c039cb8b8325bb428c60ff005b899654fb4.camel@hammerspace.com>
 <ebee08ee-ecbe-c47c-1f7c-799f86b3879c@gmail.com>
 <CAN-5tyF-LVzfm2hGmBJhQXUvt_d19tmhk76DFmNuS-SaTZDvDg@mail.gmail.com>
From:   Wenle Chen <solomonchenclever@gmail.com>
Message-ID: <d98f9dc4-1122-5e39-c09a-05c403b5a163@gmail.com>
Date:   Wed, 4 Nov 2020 23:51:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyF-LVzfm2hGmBJhQXUvt_d19tmhk76DFmNuS-SaTZDvDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Olga Kornievskaia 於 2020/11/4 下午9:22 寫道:
> On Wed, Nov 4, 2020 at 6:36 AM Wenle Chen <solomonchenclever@gmail.com> wrote:
>>
>>
>>
>> Trond Myklebust 於 2020/11/3 上午1:45 寫道:
>>> On Tue, 2020-11-03 at 00:24 +0800, Wenle Chen wrote:
>>>>     We can't wait forever, even if the state
>>>> is always delayed.
>>>>
>>>> Signed-off-by: Wenle Chen <chenwenle@huawei.com>
>>>> ---
>>>>    fs/nfs/nfs4proc.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>> index f6b5dc792b33..bb2316bf13f6 100644
>>>> --- a/fs/nfs/nfs4proc.c
>>>> +++ b/fs/nfs/nfs4proc.c
>>>> @@ -7390,15 +7390,17 @@ int nfs4_lock_delegation_recall(struct
>>>> file_lock *fl, struct nfs4_state *state,
>>>>    {
>>>>           struct nfs_server *server = NFS_SERVER(state->inode);
>>>>           int err;
>>>> +       int retry = 3;
>>>>
>>>>           err = nfs4_set_lock_state(state, fl);
>>>>           if (err != 0)
>>>>                   return err;
>>>>           do {
>>>>                   err = _nfs4_do_setlk(state, F_SETLK, fl,
>>>> NFS_LOCK_NEW);
>>>> -               if (err != -NFS4ERR_DELAY)
>>>> +               if (err != -NFS4ERR_DELAY || retry == 0)
>>>>                           break;
>>>>                   ssleep(1);
>>>> +               --retry;
>>>>           } while (1);
>>>>           return nfs4_handle_delegation_recall_error(server, state,
>>>> stateid, fl, err);
>>>>    }
>>>
>>> This patch will just cause the locks to be silently lost, no?
>>>
>> This loop was introduced in commit 3d7a9520f0c3e to simplify the delay
>> retry loop. Before this, the function nfs4_lock_delegation_recall would
>> return a -EAGAIN to do a whole retry loop.
> 
> This commit was not simplifying retry but actually handling the error.
> Without it the error isn't handled and client falsely thinks it holds
> the lock. Limiting the number of retries as Trond points out would
> lead to the same problem which in the end is data corruption.
> Alternative would be to fail the application. However ERR_DELAY is a
> transient error and the server would, when ready, return something
> else. If server is broken and continues to do so then the server needs
> to be fix (client isn't coded to the broken server). I don't see a
> good argument for limiting the number of re-tries.
> 
>> When we retried three times and waited three seconds, it was still in
>> delay. I think we can get a whole loop and check the other points if it
>> was changed or not. It is just a proposal.
In the function nfs_end_delegation_return, it would get the return 
err=-EAGAIN and check the client is active and get a retry. I has so 
thought. Maybe I think wrong. I will understand more carefully. Thinks.
