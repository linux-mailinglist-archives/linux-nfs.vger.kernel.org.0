Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7B43FF67
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJ2P0s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 11:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhJ2P0s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Oct 2021 11:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635521059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWNVIVuxSenMExNKwDNHf64ic8u7W0kI+Qu2xuxBuC4=;
        b=bu7Hj9tmBxR/wRNnWhqhB4gmlyHtYTfjMKCW2NRorWrEt2BVXRLsqD4Y4p58wZXjq/d+DL
        o36DoGhi6O7t9qyuLPb/QMYZrzbcKhVzrQ1kUFCWNCqYHS0PS/gvzbJWIueGcoV2ncxb3S
        LcxGBP6Ov/c1LOhejjQ4YN3PJN4vh4M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-iPtapcpvNXOiszNQM0mPpw-1; Fri, 29 Oct 2021 11:24:17 -0400
X-MC-Unique: iPtapcpvNXOiszNQM0mPpw-1
Received: by mail-qv1-f70.google.com with SMTP id t12-20020a05621421ac00b00382ea49a7cbso8069660qvc.0
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 08:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QWNVIVuxSenMExNKwDNHf64ic8u7W0kI+Qu2xuxBuC4=;
        b=qmqa4sbhStLZPfPeyf8nJT90eTE2MoGPAA/+SicWtsZYFgvHMBlwKr10rn4M46maKN
         jEnbh/EeF4bg/TVqViaJB3lfg2GwIkLqTp+x8rc0RD9KVSCm6HLl6JM0Ye8SVDqpw7G7
         8HM51NmgpAy+WTnXdi05Xh3F7G9gSq9S0/iChbT4w8PoGKLpxc7HQSMDWZwZRNl3BkqY
         y8ZaTRRdQ7kAnjMRvriLvkowVXyNItJyUzTibxsVDij6Cj5SWZKsxlWqIZEOB0JiPjkd
         t8Rxx8rbFfMcrEgn1K4aq6G6ZhPLdMDuue7xXnhgRmYQOQB0KMnpgTJwldYWBKlzOVHS
         m2AQ==
X-Gm-Message-State: AOAM531O0Qe/H1Jddz5SoAOKt0Aj42HcxSjORgx2UtY6ROSZYo66rynH
        OtfC3CWlYn131MAvo0eenE9BBb2hWijYTCHMM35fSQMw3aR6+hjuOPhZEwwNutHzVLt4dF2Pqpg
        btWJySHRfC5ixnwjLwHWm
X-Received: by 2002:a05:622a:253:: with SMTP id c19mr12704762qtx.382.1635521057055;
        Fri, 29 Oct 2021 08:24:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyzR3oKMj7pWAHJYKB4nkHcU3CnZ3Er6Xme43gNh8XgquEIGWedk1CevpxPTs1AhteyE+Cdw==
X-Received: by 2002:a05:622a:253:: with SMTP id c19mr12704742qtx.382.1635521056819;
        Fri, 29 Oct 2021 08:24:16 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id y22sm4027600qkj.93.2021.10.29.08.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 08:24:16 -0700 (PDT)
Message-ID: <f7c7ba0e-06f6-4ee6-b8f1-edff497418d1@redhat.com>
Date:   Fri, 29 Oct 2021 11:24:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org> <20211029142639.GC19967@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211029142639.GC19967@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/29/21 10:26, J. Bruce Fields wrote:
> On Fri, Oct 29, 2021 at 09:45:34AM -0400, bfields wrote:
>> On Thu, Oct 28, 2021 at 10:48:50AM -0400, Steve Dickson wrote:
>>> This kernel patch and an upcoming nfs-utils patch
>>> adds a new export option 's2sc' which will allow
>>> inter server to server copies.
>>
>> They're already allowed by a module option.  Why is an export option
>> better?  And why should it be set on the destination server and not the
>> source server?
>>
>> Really, first I think we should try to identify what the problem is that
>> we're trying to solve.
> 
> I guess we're thinking: we expect server-to-server copy to be a win in
> some cases, but not others.
Right!

> 
> What would those cases look like?
> 
> Say you've got a client "C" and two servers, "S" and "T", and C is
> copying a file from S to T.
> 
> I'd expect bandwidth of the traditional read-write-loop copy to be the
> minimum of the network bandwidth between S and C, and the network
> bandwidth between C and T.  Are there common cases were the S-to-T
> bandwidth would be significantly less than both of those?
I was thinking the connection between S-to-T would be much
faster (come type of cluster interconnect) that the connection
between C-S or C-T.

> 
> My guess would've been that that's relatively unusual.  So as a first
> pass, just turning on COPY unconditionally doesn't seem so bad.
> 
> I know you're thinking about in cases where S and T are connected by a
> high-performance network not necessarily available to C.
Exactly... well said.

> 
> In that case, we know we want to use server-to-server copy for copies
> between S and T.  But is it necessarily a problem to also use it for
> copies between some other server and T?  Also, does knowing the export
> containing the destination file on T really tell you whether or not the
> copy will be coming from S and not from some other server?
No... All the export is doing is allowing the COPY request
to succeed. I don't think T has any idea where the
COPY is coming from... but you would know better that I :-)

> 
> I'd think the bigger issue in that case is figuring out how to configure
> S so that it returns the right IP address in the cnr_source_server field
> of the COPY_NOTIFY reply.  Currently we return address that the client
> sent the COPY_NOTIFY, and I don't know if that's correct for that case.
I didn't look at this part of the transaction since it was
not controlled by the module param... But How would S know its the
"right IP address" since it is C that did the mount to T and
is giving S the address?

Keeping in context of what I'm trying to do... All I'm
trying to do is enable the feature, and with your points,
I think you are making my case there should be an
alternate of enabling these copies.

steved.

