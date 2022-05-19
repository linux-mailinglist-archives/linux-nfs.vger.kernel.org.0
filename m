Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2624052DD32
	for <lists+linux-nfs@lfdr.de>; Thu, 19 May 2022 20:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiESSxV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 May 2022 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiESSxN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 May 2022 14:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA68C108A86
        for <linux-nfs@vger.kernel.org>; Thu, 19 May 2022 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652986348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlZJnKxGTeokl1Q4CE+9ngODcoQwnWfK3KiRnYY1uBc=;
        b=WWvUUEEtzJBuwYszkXeU3LG12JGEpzK6TclgEyXC2Z/MBWOl/DLJek2aCT486wj/nEuMF1
        MWCBSd3Z7zJegsXzbA1Xce3ZWRZ2ilf4+5j/05ZtBVxvGZAWhG9oWlpYdD8QMwK6zbGJtT
        huflVhTe/nIN+TDqsGof7zBjHK6OqYc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-CcXviha3NFqYyWXj-t9Dig-1; Thu, 19 May 2022 14:52:27 -0400
X-MC-Unique: CcXviha3NFqYyWXj-t9Dig-1
Received: by mail-qk1-f198.google.com with SMTP id 63-20020a370c42000000b006a063777620so4797577qkm.21
        for <linux-nfs@vger.kernel.org>; Thu, 19 May 2022 11:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OlZJnKxGTeokl1Q4CE+9ngODcoQwnWfK3KiRnYY1uBc=;
        b=Qowh5A1leSa0b/QDoJn172wOT8adw91ob9KMJd4NuBEjvG2/tuCciPFfaVW0JSreEb
         IW0l9ebbh6UN9GQvay6HkB4CIG2AwsiHz3YLe7Qo1uYiSMc7E7u7K8f65l6XFMfqbd0U
         rn/7HZvDTytIoiaV4zKgd0SCafbSn5xs2jb7b2TtE7Y85rk0HSGQA1DLYBvkKLZmH/I+
         zX1cuAqFn4GG3rEYQ1LsbP0I5eRKZqkiLvjkn+e2cYOabpRRucNeYtqQ0ArvF2/lZCS0
         j+wHIA7wfmjPj5n3gfnqM1rfY+oSOP6zOp7pUBNkRjOboOIxjbccumPpF0ws9PzOI4fF
         JwNg==
X-Gm-Message-State: AOAM5339km9Ad8BpE5r7LemxvD/aIy+v7JuMtkPuHRvBPUErnxYWK66o
        r32Zi9aCNVsxrElBmE9E+MEFaS/YbcsQ646g6KdKOapfhB7nFX6/2Jm0YUF8KzONPLNIGhVRrfs
        FAY5YGw+fQSw39GicMEkS
X-Received: by 2002:a05:6214:528e:b0:462:584:3d75 with SMTP id kj14-20020a056214528e00b0046205843d75mr2451212qvb.110.1652986346987;
        Thu, 19 May 2022 11:52:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOBXoQ7Dpl/hbCKY1JbNwr7Etc4Xi3OpTVLHV3eIixYJi6ZZ5Hb0UcFjfcVZnl0RX7MUmaLQ==
X-Received: by 2002:a05:6214:528e:b0:462:584:3d75 with SMTP id kj14-20020a056214528e00b0046205843d75mr2451190qvb.110.1652986346683;
        Thu, 19 May 2022 11:52:26 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.96.106])
        by smtp.gmail.com with ESMTPSA id o13-20020ac8554d000000b002f3ef928fbbsm1651123qtr.72.2022.05.19.11.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 11:52:26 -0700 (PDT)
Message-ID: <765e7b64-c5dd-a62e-3762-8e4ecec9f0d8@redhat.com>
Date:   Thu, 19 May 2022 14:52:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/6] Allow nfs4-acl-tools to access 'dacl' and 'sacl'
Content-Language: en-US
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
 <20220515015946.GB30004@fieldses.org>
 <15c4602658aff025b6d84e2b9461378930cbd802.camel@hammerspace.com>
 <627133c7-dab9-db0b-5fdf-ecb95820e76a@redhat.com>
 <20220519135311.GC23564@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220519135311.GC23564@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/19/22 9:53 AM, bfields@fieldses.org wrote:
> On Thu, May 19, 2022 at 09:47:41AM -0400, Steve Dickson wrote:
>>
>>
>> On 5/14/22 11:23 PM, Trond Myklebust wrote:
>>> On Sat, 2022-05-14 at 21:59 -0400, J.Bruce Fields wrote:
>>>> On Sat, May 14, 2022 at 10:44:30AM -0400, trondmy@kernel.org wrote:
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>
>>>>> The following patch set matches the kernel patches to allow access
>>>>> to
>>>>> the NFSv4.1 'dacl' and 'sacl' attributes. The current patches are
>>>>> very
>>>>> basic, adding support for encoding/decoding the new attributes only
>>>>> when
>>>>> the user specifies the '--dacl' or '--sacl' flags on the command
>>>>> line.
>>>>
>>>> Seems like a reasonable thing to do.
>>>>
>>>> I'd rather not be responsible for nfs4-acl-tools any longer, though.
>>>>
>>>> --b.
>>>
>>> I suspected that might be the case, but since you haven't made any
>>> announcements about anybody else taking over, I figured I'd start by
>>> sending these to you.
>>>
>>> So who should take over the nfs4-acl-tools maintainer role? Is that
>>> something Red Hat might be interested in doing, or should I volunteer
>>> to do it while we wait for somebody to get so fed up that they decide
>>> to step in?
>>>
>> Yeah... it probably something we should take over....
>>
>> I'll add these to my todo list... Where does the upstream repo
>> live today?
There is now a new nfs4-acl-tools repo [1]  that I will start
using for this patch set. You might want to disable
the old repo.

Also the links on the main page of linux-nfs.org [2]
will need to point to [1]. I guess I don't have an
account on that box, so I can not make that change.

steved.


[1] git://git.linux-nfs.org/~steved/nfs4-acl-tools.git
[2] http://linux-nfs.org/wiki/index.php/Main_Page



