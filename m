Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3952A4420CE
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 20:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhKAT2d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 15:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231820AbhKAT2d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 15:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635794759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdLmsYXpzBXJiMviigikqys0QaGB8SUGBx+FSNIX83k=;
        b=iUJ/bSsdUCF5NrD5HDYeBNyv5l/GLCg3q83X6JfARZ1YwAuUWp3Eh42eeUgzhCRh690CoU
        ythgirmIVtIeJ5rWIvtaVhd9oKLRWs2aUpdw2cb6ksavgfQzCD/8LLSVY9YsKsIeTHqOk+
        8uysNPdH1ci+jFZX2PgM1M/LGycy95g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-HmnOFnfrM1620DcJs6LWDQ-1; Mon, 01 Nov 2021 15:25:58 -0400
X-MC-Unique: HmnOFnfrM1620DcJs6LWDQ-1
Received: by mail-qv1-f71.google.com with SMTP id ke1-20020a056214300100b003b5a227e98dso1614689qvb.14
        for <linux-nfs@vger.kernel.org>; Mon, 01 Nov 2021 12:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TdLmsYXpzBXJiMviigikqys0QaGB8SUGBx+FSNIX83k=;
        b=FJcx6slVVdfioTiwLP/EOlq2Wcli+trDlvZn7rUVhKgsgAYsAY86JpRd117ygny7oM
         u2mREkRD8of/CkgUbWzbiJiSYL4846ASy2aUzjPdpQV9pXVA/oZozRRgopHrLbonFclg
         EBCmz2T6iti9Y+B3SLmz/waRDr/ccxjlbzjr6vUTq+UHZm6DM21l9HZ6n8oMlN7304Rn
         mrhyxS565D5TYMOKaUfjGgA8zQCHEow+t/j7A5But8+YATqDgEkMpNDTq/O729kbvH76
         HZbiV84BOYBggBiKgb5OREFD+uNaQZzCtKp8iwfypu60nt/eS0YtAuhDZ9Vlx/5v4jE0
         +OZw==
X-Gm-Message-State: AOAM531hors5vIQ4QO+6G4mlWc/rnzDochwozr0pNAjrJhnF8JbtFHIk
        cFrLY+KlE0z+LbZcuWBe0um7Pw6O4aXno7o9MU3W7uqiHczTvWdvYwAzxKLqiAuqMVFK/nhh13R
        AiLH7co3sQqaIlo2Jtp8Q
X-Received: by 2002:ad4:4246:: with SMTP id l6mr23009179qvq.65.1635794757445;
        Mon, 01 Nov 2021 12:25:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOR6P1m+lhp+PmuEFYUt9aKmOaqgc5Uw8D9mhakoF3bUCBFeYo70yc0VCZ9Z4QATDyypE00g==
X-Received: by 2002:ad4:4246:: with SMTP id l6mr23009158qvq.65.1635794757231;
        Mon, 01 Nov 2021 12:25:57 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id 18sm2636365qty.42.2021.11.01.12.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 12:25:57 -0700 (PDT)
Message-ID: <20f2fbf2-cce9-acc9-557d-82251aeef662@redhat.com>
Date:   Mon, 1 Nov 2021 15:25:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: server-to-server copy by default
Content-Language: en-US
To:     Charles Hedrick <hedrick@rutgers.edu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        dai.ngo@oracle.com,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20211020155421.GC597@fieldses.org>
 <C0088A79-6936-4764-8ADB-4D6C32054265@rutgers.edu>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <C0088A79-6936-4764-8ADB-4D6C32054265@rutgers.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 11/1/21 14:22, Charles Hedrick wrote:
> I am in general concerned about turning on new features before basic ones work reliably. We’ve had enough different failures that we’ve backup up to NFS 3 for file systems with heavy use.
> 
> We first tried turning off delegation. That helped a lot. But we just ran into a two different machine hung trying to lock Chome’s profile. (I sent a bit of information on that one previously.) We had to restart NFS on the server to fix it, and that caused us to lose a bunch of VMs. (That shouldn’t have happened. It looks like ESX misbehaved.) If I could turn off NFS4 locking I would.
This is the reason I was hopping not make this a global switch
but a per export switch...

Question... Do you do many server to server copies in your world?
Meaning a client coping from one server to another?

steved.

> 
>> On Oct 20, 2021, at 11:54 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>
>> knfsd has supported server-to-server copy for a couple years (since
>> 5.5).  You have set a module parameter to enable it.  I'm getting asked
>> when we could turn that parameter on by default.
>>
>> I've got a couple vague criteria: one just general maturity, the other a
>> security question:
>>
>> 1. General maturity: the only reports I recall seeing are from testers.
>> Is anyone using this?  Does it work for them?  Do they find a benefit?
>> Maybe we could turn it on by default in one distro (Fedora?) and promote
>> it a little and see what that turns up?
>>
>> 2. Security question: with server-to-server copy enabled, you can send
>> the server a COPY call with any random address, and the server will
>> mount that address, open a file, and read from it.  Is that safe?
>>
>> Normally we only mount servers that were chosen by root.  Here we'll
>> mount any random server that some client told us to.  What's the worst
>> that random server can do?  Do we trust our xdr decoding?  Can it DOS us
>> by throwing the client's state recovery code into some loop with weird
>> error returns?  Etc.
>>
>> Maybe it's fine.  I'm OK with some level of risk.  I just want to make
>> sure somebody's thought this through.
>>
>> There's also interest in allowing unprivileged NFS mounts, but I don't
>> think we've turned that on yet, partly for similar reasons.  This is a
>> subset of that problem.
>>
>> --b.
> 

