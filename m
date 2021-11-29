Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E8E462317
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhK2VTU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 16:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233090AbhK2VRT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 16:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638220440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1QFQIuQNhLDTpR/YSm65NA3I3OujckW6OT+ph1+HVQ=;
        b=iByvbn+/xorQ1evIjVD0ND354WKBqQtE4pqWeyjJlBO8Fsm5IcZarzVnhA56qRkSW/i+gk
        xcgYhBD9wnaoXgR4dDDIVySmJjyN9yzKPfLIKkyfdLGgyNFSYF6nBI9R6BoLKT1mOnzpgZ
        kQ10PvAaeWAm42P9LngWOTDutlr/yWw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-JH9XPRtvOS-T0I_-LtI-ew-1; Mon, 29 Nov 2021 16:13:59 -0500
X-MC-Unique: JH9XPRtvOS-T0I_-LtI-ew-1
Received: by mail-qt1-f199.google.com with SMTP id h13-20020ac87d4d000000b002af9c496444so24949608qtb.22
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 13:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w1QFQIuQNhLDTpR/YSm65NA3I3OujckW6OT+ph1+HVQ=;
        b=yTSYJPHzZGeGPHuzxiOlIW449IUqZzjkAX4VBMAdyVAAbE1cOnCRUKusfmO2xL6OJf
         1JBiKW7L51KQSiHUNXBfy43gWfNLXxxq/lzcMtfybcLwt5XVmyCNtICrejVWCnAFN0FU
         YJbH7SSeXtMsUlsDJ2mpSNHnNfGL3FPFE8kYzoM5cXNkvMLfKH1QaZiV/CIbUYrTBGqw
         pm8JyP6Nb3iqa2Q0+2bDhn6A+V9CKxN/6+mqbpPeLg7nW7rdl3F4KcrZwSYAVS7oUqdf
         YmBjCts/V1I9q/0PJQ7lSNRf0nWR4kuhxgdLOu1Dm5HR3S8D5S4EPlDLvANKAZSFEib6
         YjDw==
X-Gm-Message-State: AOAM533Nns1vQf5iBd5arPh/8tG/my4po6mwh35/XY0HnYetuTfUORYB
        47z+cF29c/4YFyuWOP/WWS7pAOTmyNiNxeGoaY8DZ1MWHP8QuD8SaOhJMalqOflJRppC0/5I0uQ
        Y7QmFvhWsTbeY7A4Ys17C
X-Received: by 2002:ac8:570b:: with SMTP id 11mr49292479qtw.128.1638220438627;
        Mon, 29 Nov 2021 13:13:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztlQIcK1loISJVeAgrlStLoymTbzGuXDPIp2wIwHf+AYeQjzF2zllxdm9SaL6JJMBLP/jPdA==
X-Received: by 2002:ac8:570b:: with SMTP id 11mr49292450qtw.128.1638220438404;
        Mon, 29 Nov 2021 13:13:58 -0800 (PST)
Received: from [172.31.1.6] ([70.109.163.47])
        by smtp.gmail.com with ESMTPSA id bq36sm8994637qkb.6.2021.11.29.13.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 13:13:58 -0800 (PST)
Message-ID: <56de55c4-d3f2-4671-f7b4-912d872315fd@redhat.com>
Date:   Mon, 29 Nov 2021 16:13:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC 0/3] Remove NFS v2 support from the client and server
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20211129192731.783466-1-steved@redhat.com>
 <163821829080.26075.9477835708436642432@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <163821829080.26075.9477835708436642432@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 11/29/21 15:38, NeilBrown wrote:
> On Tue, 30 Nov 2021, Steve Dickson wrote:
>> These patches will remove the all references and
>> support of NFS v2 in both the server and client.
> 
> What is the motivation for this?
> I don't necessarily disagree, but I'm curious as to what you hope to
> gain.
Just to eliminate v2 support once and for all...
It is a dead version, IMHO, so I'm just trying
to clean things up by remove it from the man pages
and error out (on the client), if a v2 mount is tried...

We are coming out with a major fairly soon, so
I'm just trying make it clear v2 is no longer
an option... So I wanted to more eyes on what
we are thinking of doing.

steved.

> 
> Thanks,
> NeilBrown
> 
>>
>> On server side the support has been off, by default,
>> since 2013 (6b4e4965a6b). With this server patch the
>> ability to enable v2 will be remove.
>>
>> Currently even with CONFIG_NFS_V2 not set
>> v2 mounts are still tied (over-the-wire). I looked at creating
>> a kernel parameter module so support could re-enabled
>> but that got ugly quick.
>>
>> So I just decided to make all V2 mounts fail with
>> EOPNOTSUPP, with no way of turn them back on.
>>
>> Steve Dickson (3):
>>    nfsd: Remove the ability to enable NFS v2.
>>    nfs.man: Remove references to NFS v2 from the man pages
>>    mount: Remove NFS v2 support from mount.nfs
>>
>>   nfs.conf                  |  1 -
>>   utils/mount/configfile.c  |  2 +-
>>   utils/mount/mount.nfs.man |  2 +-
>>   utils/mount/network.c     |  4 ++--
>>   utils/mount/nfs.man       | 20 +++-----------------
>>   utils/mount/nfsmount.conf |  2 +-
>>   utils/mount/stropts.c     |  3 +++
>>   utils/nfsd/nfsd.c         |  2 --
>>   utils/nfsd/nfsd.man       |  4 ++--
>>   9 files changed, 13 insertions(+), 27 deletions(-)
>>
>> -- 
>> 2.31.1
>>
>>
> 

