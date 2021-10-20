Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79D043512A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJTR1L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 13:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhJTR1K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 13:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634750695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUl5muFBZnzs70E1ZwVtKgyY/xo6vrSQnWJnWVn1mC8=;
        b=K8UTu/vNzy+8IwxiOfgjvCrVBaPRoSX64zRDbEU2vH8aj8zGUY3XCmBNV5hySnLxY8k7WZ
        MBpTUnk890CZ21jhnGDPhvf91miY4uXA7KR+IqNAw9YvFfJ4ljxjM5fronQPwSOCp8jwvw
        aozpDATCNf7BtOGq5VBrwRY5SaMrCrg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-zhcRxHXbO2ax7PMZu6zmqg-1; Wed, 20 Oct 2021 13:24:54 -0400
X-MC-Unique: zhcRxHXbO2ax7PMZu6zmqg-1
Received: by mail-qv1-f69.google.com with SMTP id if11-20020a0562141c4b00b0038317257571so3386911qvb.3
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 10:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xUl5muFBZnzs70E1ZwVtKgyY/xo6vrSQnWJnWVn1mC8=;
        b=Tpi9LQfoalp1QK7cf19SlmETxEytKxOKtwl/qVNnZX91933ZLlDSGZojQoaspy4WQD
         wN+SRXB3nO+p8RrmXNI/cNzMY/kFmf6lH0Nq6/cTIWDLRHDjsEi0lKrXe4lm6Pjig/2n
         IUsXWLEg0PVw0XB0FsCG56wzroVCz4fEvxuZbB1mE8P03+Ti9QKauqJuDGt8SY8Q4YNA
         uIxNFf456CkflDQd6OG5bN9xepnoju7TnBQJ7BWGUf3VxxHF5rHq8auGFOQdexn3q7X4
         wlg2qo4tXpMrCdJ42DGjwDcPbrnVCRupbMtVagK8L3MYIdKi6Tr28iroPhUMDFRG5bn2
         y3Ug==
X-Gm-Message-State: AOAM533CtIgTbc2XrgFldqvEu70YR8NZBozcSt/0++SBahLapK7VufPH
        3cFb0xsUw9P7Q4QOpsDd6XJRBeU0AxVhZncxRHhRBKsDJ3u2l2lo3pNAEN1mWZxQKbxn3vwesSs
        4cxODYLY0uZaUZiY+TXiE
X-Received: by 2002:a0c:f648:: with SMTP id s8mr190924qvm.9.1634750693691;
        Wed, 20 Oct 2021 10:24:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlMy9hx/x1oWEg0zRB6cVEO0sELm+pYTOgLAgOhVHeZjkSipr6MP7OFfikJ4MnW1B2TDSYBg==
X-Received: by 2002:a0c:f648:: with SMTP id s8mr190909qvm.9.1634750693469;
        Wed, 20 Oct 2021 10:24:53 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id 11sm1193983qtt.14.2021.10.20.10.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 10:24:53 -0700 (PDT)
Message-ID: <e2b1210d-5b06-72bb-59c5-6b8b712fd2ec@redhat.com>
Date:   Wed, 20 Oct 2021 13:24:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: server-to-server copy by default
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
References: <20211020155421.GC597@fieldses.org>
 <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 10/20/21 12:00, Chuck Lever III wrote:
> 
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
> 
> I like the idea of enabling it in one of the technology
> preview distributions.
My thoughts on this... we can do this one of two ways.
either do a kernel patch to enable inter_copy_offload_enable
by default or I could have nfs-utils drop a nfsd.conf file in
/etc/modprobe.d/ enabling it.

The kernel patch is more of a commitment but the
nfs-utils change is easier to back out.

> 
> But wrt the maturity question, is the work finished? Or,
> perhaps a better question is do we have a minimum viable
> product here that can be enabled, or is more work needed
> to meet even that bar?
I've been testing it and it seems to be pretty solid.

Question, Olga mentioned Dia did a patch that eliminations
the (rsize*14) file size limit... Meaning the file has
to be greater that (rsize*14) for the SSC to happen.
Was that patch committed? I have not looked that hard
but I haven't found it...

> 
> One thing that I recall is missing is support for Kerberos
> in the server-to-server copy operation. Is that in plan,
> or deemed unimportant?
Personally I think we should make sure the technology
is stable before adding things on to it.. IMHO.

> 
> 
>> 2. Security question: with server-to-server copy enabled, you can send
>> the server a COPY call with any random address, and the server will
>> mount that address, open a file, and read from it.  Is that safe?
>>
>> Normally we only mount servers that were chosen by root.  Here we'll
>> mount any random server that some client told us to.  What's the worst
>> that random server can do?  Do we trust our xdr decoding?  Can it DOS us
>> by throwing the client's state recovery code into some loop with weird
>> error returns?  Etc.
> 
> A basic question is what is in distribution QE test suites
> that could exercise this feature? Should upstream be tasked
> with providing any missing pieces (as part of, say, pynfs,
> or nfstests)?
As Olga pointed out... nfstests already has a test...

my two cents,

steved.

> 
> 
>> Maybe it's fine.  I'm OK with some level of risk.  I just want to make
>> sure somebody's thought this through.
>>
>> There's also interest in allowing unprivileged NFS mounts, but I don't
>> think we've turned that on yet, partly for similar reasons.  This is a
>> subset of that problem.
>>
>> --b.
> 
> --
> Chuck Lever
> 
> 
> 

