Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6034421A9
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 21:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhKAUas (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 16:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhKAUar (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 16:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635798492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52xg5V+afrN7aMS4Vl01yxpXugZhZkBU3cHVpY6lNZk=;
        b=fDqbF5VtRWmSVCfhYGVx5RLKJTBvNvhylUujLpJCLxBYEQ1T4aG8vDRmFVrXBoAESrqQWT
        SxUyhC1eL9NxmDjYjtaJLcKuR7zHlCY8VlvRj2ktYiPt2Q67MaKRhRFJAOjCvkHW5p8Qfs
        UjVrBxz6JTSfacJdjsKf93gcT4uOT6g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-c3NkYI6rOFid2R4-CC7ayw-1; Mon, 01 Nov 2021 16:28:12 -0400
X-MC-Unique: c3NkYI6rOFid2R4-CC7ayw-1
Received: by mail-qv1-f72.google.com with SMTP id ib13-20020a0562141c8d00b003958b43bcf2so11337858qvb.1
        for <linux-nfs@vger.kernel.org>; Mon, 01 Nov 2021 13:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=52xg5V+afrN7aMS4Vl01yxpXugZhZkBU3cHVpY6lNZk=;
        b=VRsPvqphqEGonK/G+9u5vIq/qZYxMJfKGpKpeaXfkaZZOCVSxUKHZYdiIYiFziojKU
         aVkaUcn1SKnTjrUYG1TteV++Jd0Fg8+B5EtLu2Tp4aJuEcqRZvFSClWSCC0QBUhxYuCj
         PUJvgmVrMSQTF6a73II8ln50mvcOalq/3puPlpmlPJll9xxFInE/ra6ZAfNu6lqHbO0p
         pmRcAcZLXcI4uf/IK0nktSZ8nuMSUW81y+fVR6mUPUE/qRI3e9jzQj0wsiJzkqx8av6g
         5x+HMftv5sGCKvn+JkB3MwgYHyMbYR+E9LDNVybAbfVEmwBBrAIxqd53qDYiM9+yQUAe
         7x5Q==
X-Gm-Message-State: AOAM5334wQ+fUMugFvHh8vaD5t0VG+aqIiJY5mqbbzhKP+f/En51UPob
        sdKAEC5YymZ4t6YqkG7R2U5n0eriXSM0hsv08Tc3uwELyXqs5i6qye18jahBwAa+A5VWo0MKysF
        kzWTfpxQH1IuBRA1fYgEo
X-Received: by 2002:a05:6214:2606:: with SMTP id gu6mr27104991qvb.30.1635798491377;
        Mon, 01 Nov 2021 13:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaRvdhgQavt0/7WcQjt/7mb1ZIFw7v/9VBd25GwZHV+2mwpMqIXzyU96Ktw8HrVnV6rI7Ufw==
X-Received: by 2002:a05:6214:2606:: with SMTP id gu6mr27104979qvb.30.1635798491205;
        Mon, 01 Nov 2021 13:28:11 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id f3sm8924012qtf.55.2021.11.01.13.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:28:10 -0700 (PDT)
Message-ID: <c66992cb-a063-b226-eb50-7efe61f87ffd@redhat.com>
Date:   Mon, 1 Nov 2021 16:28:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
 <93DAB7C7-D0BB-48BA-9BFF-2821D88582EA@oracle.com>
 <20211101183916.GA14427@fieldses.org>
 <79e55dad-7f34-3723-98b0-7c2ef7be9355@redhat.com>
 <20211101192606.GC14427@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211101192606.GC14427@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/1/21 15:26, Bruce Fields wrote:
> On Mon, Nov 01, 2021 at 03:10:31PM -0400, Steve Dickson wrote:
>>
>>
>> On 11/1/21 14:39, Bruce Fields wrote:
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 91ba391f9b32..14bc3f0b0149 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3243,6 +3243,19 @@
>>>   			driver. A non-zero value sets the minimum interval
>>>   			in seconds between layoutstats transmissions.
>>> +	nfsd.inter_copy_offload_enable =
>>> +			[NFSv4.2] When set to 1, the server will support
>>> +			server-to-server copies for which this server is
>>> +			the destination of the copy.
>>> +
>>> +	nfsd.nfsd4_ssc_umount_timeout =
>>> +			[NFSv4.2] When used as the destination of a
>>> +			server-to-server copy, knfsd temporarily mounts
>>> +			the source server.  It caches the mount in case
>>> +			it will be needed again, and discards it if not
>>> +			used for the number of milliseconds specified by
>>> +			this parameter.
>>> +
>>>   	nfsd.nfs4_disable_idmapping=
>>>   			[NFSv4] When set to the default of '1', the NFSv4
>>>   			server will return only numeric uids and gids to
>>> @@ -3250,6 +3263,7 @@
>>>   			and gids from such clients.  This is intended to ease
>>>   			migration from NFSv2/v3.
>>> +
>>>   	nmi_backtrace.backtrace_idle [KNL]
>>>   			Dump stacks even of idle CPUs in response to an
>>>   			NMI stack-backtrace request.
>>>
>> Interesting... I don't see these in the Linus tree I'm looking at [1]
>> find Documentation/ -type f  | xargs grep -i inter_copy_offload_enable
> 
> I was suggesting that as a patch.  It's queued up for 5.16 now.
Sorry I did miss the patch part of the email...

Does it make sense to document both nfs and nfsd module
parameters in a couple man pages?

steved.

