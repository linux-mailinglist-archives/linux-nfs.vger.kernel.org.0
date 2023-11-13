Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36C67EA07C
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 16:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjKMPs7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 10:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjKMPs5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 10:48:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7932D5E
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 07:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699890490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzP6279Hudc3w1X9RcmMIF8cGG+LFQWnCgq6dYAhDHU=;
        b=P6B+KMSeRnnCOcri1YwMjMQzM3YCR0NPeGObAAVlFuc7L/qX9FtRkjsrNs2t8rT40ocXm3
        3ZUrtgps3fMXA3rSDwmgL4PIKvbI6XRlRYb6713vPnziyQSYC3a+KddzVWwhX5hXMgYKF8
        acUqmXgCooWtKQmtSNgc/wcLRGNhQcQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-cyHpp8KuOSuscRiSQ2Zesg-1; Mon, 13 Nov 2023 10:48:07 -0500
X-MC-Unique: cyHpp8KuOSuscRiSQ2Zesg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41cbafdb4b6so10837911cf.0
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 07:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890487; x=1700495287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzP6279Hudc3w1X9RcmMIF8cGG+LFQWnCgq6dYAhDHU=;
        b=aEtC6YWuBx3PIyNE8gGRllLm8g21NrovFcB7vIwqA7ChBOcz5G+58oA3jzoZ635OoE
         9gnryqhyIlMMIEwMnkWEQKwbrzsZEXKzSPmm7sqoXRbc/5UuH/Cb9H8Ax7bjdIm/SQXf
         kfrOwqy2LdWwASH0KbQtYIay0VDTQr2FvAsUsXQVaGs0f25hv49VfVOR9/lbvobiqMjM
         lmywEXUwqGDXC+b5yEiIYlfSAwLhQUq/6LXX4hJ1tjFwnXLZKOCz2p/BOYeu21J3+O4n
         v9WjCclOnasudzlVKU6DYQvTvrKf7pR+vvZAAGb8m1OjyZ1QsA9gKAZoCVfTILDrr/wx
         0tdQ==
X-Gm-Message-State: AOJu0YxFb4uE9V5y1YC6rIehBnyFuWQq4RyD+7hoeW6dHZkY0G2rPFmU
        ql8Uu146TRKaTwofcoCSnG70Yp4CeJUUr2gv0clUyOWfxdd9ofamXQlK7bzi4P5lQ3yU4FFAiJc
        3LKKJAGcYuzQ53ahqH5znc0S9dnOl
X-Received: by 2002:a05:622a:648:b0:412:d46:a8c3 with SMTP id a8-20020a05622a064800b004120d46a8c3mr8977493qtb.2.1699890486936;
        Mon, 13 Nov 2023 07:48:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWKc4fZLan4/x0BzAeZNoY7IIKljqVDyNU4b9lXv9COdcU4LQNud+ljk0zfArrlpREapfsIA==
X-Received: by 2002:a05:622a:648:b0:412:d46:a8c3 with SMTP id a8-20020a05622a064800b004120d46a8c3mr8977443qtb.2.1699890486181;
        Mon, 13 Nov 2023 07:48:06 -0800 (PST)
Received: from [172.31.1.12] ([70.105.251.235])
        by smtp.gmail.com with ESMTPSA id kq4-20020ac86184000000b004181c32dcc3sm2010406qtb.16.2023.11.13.07.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:48:05 -0800 (PST)
Message-ID: <d864c378-3b4d-41f2-bb21-d3403db55cbc@redhat.com>
Date:   Mon, 13 Nov 2023 10:48:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in
 /etc/exports?
Content-Language: en-US
To:     Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Martin Wege <martin.l.wege@gmail.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Roland Mainz <roland.mainz@nrubsig.org>
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
 <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
 <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
 <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com>
 <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Ced,

On 11/12/23 8:01 PM, Cedric Blancher wrote:
> On Fri, 10 Nov 2023 at 20:17, Chuck Lever III <chuck.lever@oracle.com> wrote:
>>
>>
>>
>>> On Nov 10, 2023, at 3:30 AM, Martin Wege <martin.l.wege@gmail.com> wrote:
>>>
>>> On Fri, Nov 10, 2023 at 3:20 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>
>>>>> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>>>>>
>>>>> On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>>>
>>>>>>> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>>>>>>>
>>>>>>> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Good morning!
>>>>>>>>
>>>>>>>> Does anyone have examples of how to use the refer= option in /etc/exports?
>>>>>>>
>>>>>>> Short answer:
>>>>>>> To redirect an NFS mount from local machine /ref/baguette to
>>>>>>> /export/home/baguette on host 134.49.22.111 add this to Linux
>>>>>>> /etc/exports:
>>>>>>>
>>>>>>> /ref *(no_root_squash,refer=/export/home@134.49.22.111)
>>>>>>>
>>>>>>> This is basically an exports(5) manpage bug, which does not provide
>>>>>>> ANY examples.
>>>>>>
>>>>>> That's because setting up a referral this way is deprecated.
>>>>>
>>>>> Why did you do that?
>>>>
>>>> The nfsref command on Linux matches the same command on Solaris.
>>>>
>>>> nfsref was added years ago to manage junctions, as part of FedFS.
>>>> The "refer=" export option can't do that...
>>>
>>> Where in the kernel is the code for the refer= option? I'd like to get
>>> some of my students to contribute support for custom NFS ports.
>>
>> IIRC supporting ports is one thing we can't do right now because
>> the mountd downcall interface is text-based, and its parser can
>> barely handle "refer=", let alone specifying a port.
> 
> I had a chat this weekend with Roland Mainz (who works on the NFSv4
> driver for Windows these days):
> ...
> That is the old mistake to think that "hostname" and "port" are
> separate entities. We had this kind of debate at SUN/MPK17 several
> times. Host and TCP port are the "location of the server", and they
> are inseparable.
> ...
> The RFCs even help out with that one, for example RFC1738 (URL RFC)
> defines a "hostport" in Page 18.
> And that's what I actually did for ms-nfs41-client: NIH&Institute
> Pasteur needed custom TCP server ports, and I implemented this by
> changing the communication of nfs41_driver.sys (kernel) to userland
> NFSv4 client daemon (nfsd_debug.exe) from "hostname" to "hostport",
> and added the port number in the UNC, so Windows always uses (and
> remembers!) the port number together with the hostname.
> Or easier: I changed "hostname" to "hostport" to embed the port number
> in the up-/downcalls for mount requests - and that is what the Linux
> people can use too.
> ...
> 
>> Our plan is to replace the mountd downcall with a netlink protocol
>> that Lorenzo is working on, and then it would be very straightforward
>> to add a port to each target location. But getting to a mature
>> netlink implementation will take a while.
> 
> Yeah, instead of waiting for NetLink you could implement Roland's
> suggestion, and change "hostname" to "hostport" in your test-based
> mount protocol, and technically everywhere else, like /proc/mounts and
> the /sbin/mount output.
> So instead of:
> mount -t nfs -o port=4444 10.10.0.10:/backups /var/backups
> you could use
> mount -t nfs 10.10.0.10@4444:/backups /var/backups
> 
> The same applies to refer= - just change from "hostname" to
> "hostport", and the text-based mountd downcall can stay the same (e.g.
> so "foobarhost" changes to "foobarhost@444" in the mountd download.)
My suggestion is you and Roland attend the next Bakeathon, this
spring, which will have remote access for testing and
talk about this on one of @2pm talks.

steved.

