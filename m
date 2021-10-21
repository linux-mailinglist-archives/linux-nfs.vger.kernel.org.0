Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76764436342
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 15:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUNqA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 09:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhJUNp7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 09:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634823823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=js1nRKd51ZMsm3IyNlz8oOrBnH29pk9rPadFBPRsJh0=;
        b=VsppewdA4omlbsQ3DCyZWC7F1iaXwJqtU1/eyJFXXLTthoV3xHDQ5257E28AGLQ6OUbxI7
        4bI1wpEn1OL1WzVZ1S/98C7d9Kxv4otx7n5pu+mbrrI/UfRe8Dxp3USgVp8In63D+rhQU6
        PhWxDfGZ4I1Qcvt6WSIx7op6QgEmnjY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-CJikyUMWMIKo_sbLFBn9mg-1; Thu, 21 Oct 2021 09:43:40 -0400
X-MC-Unique: CJikyUMWMIKo_sbLFBn9mg-1
Received: by mail-qt1-f197.google.com with SMTP id c19-20020ac81e93000000b002a71180fd3dso564198qtm.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Oct 2021 06:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=js1nRKd51ZMsm3IyNlz8oOrBnH29pk9rPadFBPRsJh0=;
        b=lQ60WrQEoXgPMkKMOm9+hHZWQ+OBlTljt5T921QFA3dCi9QpYA91AnZLNrIq3uM2hl
         AZA1MnjYXqw8dncOBmzgCRCh0hZCWHzwzqb9rXtWW5ves4Dev/ma6GUHHdxmqITb0xRU
         myWvGbA5LXY0nHg+EJlPhN749m/Vnlcl/2zwyP7G2JtBfKmXBP8guODSKNC+2DSwhVv6
         nSiut2M3dq+DPFtJz0dteZFde24SSbgIYC+3w9dtD0qG9NsOxwDYOJ8Rjox1GJs1d8kB
         JadiVufcodj0KnLjnXPUnDASTgPCTC9eEJrF37TWWaYXHQH1lnIMSKMCG9Aqd411qQFA
         yJOw==
X-Gm-Message-State: AOAM532CEfuTleBobZm87Z3xmmYMH1PXo3O279vYX33saIfVG22/EFOa
        XtgHR445VBnzhuF5uK5IB/pEbZnGJwDfw8wykch2M3enYGAnXvb8XykER9sPew6Uec5o+xjk/4B
        1whAc0vQVgriQCVvHRLgF
X-Received: by 2002:a05:620a:454f:: with SMTP id u15mr4362534qkp.283.1634823819946;
        Thu, 21 Oct 2021 06:43:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEWm6zYcziOiwfx9rOE/2aNYwavDVQTNBwUKlr0V3eyFEgW/BdzBXfSX6fj2BOIQQKfWj58Q==
X-Received: by 2002:a05:620a:454f:: with SMTP id u15mr4362518qkp.283.1634823819709;
        Thu, 21 Oct 2021 06:43:39 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id a5sm2430855qtd.52.2021.10.21.06.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 06:43:39 -0700 (PDT)
Message-ID: <726db266-0ac4-e03e-9cc4-99e5b54b9349@redhat.com>
Date:   Thu, 21 Oct 2021 09:43:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: server-to-server copy by default
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
References: <20211020155421.GC597@fieldses.org>
 <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
 <0492823C-5F90-494E-8770-D0EC14130846@oracle.com>
 <20211020181512.GE597@fieldses.org>
 <EC5F0B99-7866-4AA6-BF2F-AB1A93C623DF@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <EC5F0B99-7866-4AA6-BF2F-AB1A93C623DF@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/20/21 15:04, Chuck Lever III wrote:
> 
> 
>> On Oct 20, 2021, at 2:15 PM, Bruce Fields <bfields@fieldses.org> wrote:
>>
>> On Wed, Oct 20, 2021 at 05:45:58PM +0000, Chuck Lever III wrote:
>>>> On Oct 20, 2021, at 12:37 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
>>>>
>>>> On Wed, Oct 20, 2021 at 11:54 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>>>>>
>>>>> knfsd has supported server-to-server copy for a couple years (since
>>>>> 5.5).  You have set a module parameter to enable it.  I'm getting asked
>>>>> when we could turn that parameter on by default.
>>>>>
>>>>> I've got a couple vague criteria: one just general maturity, the other a
>>>>> security question:
>>>>>
>>>>> 1. General maturity: the only reports I recall seeing are from testers.
>>>>> Is anyone using this?  Does it work for them?  Do they find a benefit?
>>>>> Maybe we could turn it on by default in one distro (Fedora?) and promote
>>>>> it a little and see what that turns up?
>>>>>
>>>>> 2. Security question: with server-to-server copy enabled, you can send
>>>>> the server a COPY call with any random address, and the server will
>>>>> mount that address, open a file, and read from it.  Is that safe?
>>>>
>>>> How about adding a piece then on the server (a policy) that would only
>>>> control that? The concept behind the server-to-server was that servers
>>>> might have a private/fast network between them that they would want to
>>>> utilize. A more restrictive policy could be to only allow predefined
>>>> network space to do the COPY? I know that more work. But sound like
>>>> perhaps it might be something that provides more control to the
>>>> server.
>>>>
>>>> But as Chuck pointed out perhaps the kerberos piece would make this
>>>> concern irrelevant.
>>>
>>> I like the idea of having a server-side policy setting that
>>> controls whether s2sc is permitted, and maybe establishes a
>>> range of IP addresses allowed to be destination servers.
>>
>> Maybe, but:
>>
>> 	1) Couldn't you get something awfully close to that with
>> 	firewall configuration?
> 
> Not if the s2sc policy setting is on each export.
Is this level complication really necessary... I just
don't see why people would not want to make copies
on all exports faster.

Is not having this option a showstopper to enabling it?

> 
> 
>> 	2) I'm getting asked why server-side copy isn't on by default.
> 
> And your answer to that was "we haven't figured out how to
> guarantee security when it's enabled".
I'm thinking the servers will be behind a firewall
which by definition makes them secure.

Now if there is a malicious app throwing COPY calls
with rouge address behind the firewall is that
something we really need to protect from? The
network has already been compromised.

As Olga pointed out... clustered servers will have a
will have a very fast connection between them which
is something we should take advantage of... IMHO

steved.

> 
> 
>> 	So I guess the requirement to set inter_copy_offload_enable is
>> 	too much.  How does requiring more complicated configuration
>> 	answer that concern?
> 
> It answers the concern by letting local administrators choose
> to enable or disable s2sc based on their own security needs.
> 
> 
>> 	3) There's interest in allowing unprivileged NFS mounts.  That's
>> 	more of a security risk than this.  What's the client
>> 	maintainers' judgement about unprivileged NFS mounts?  Do they
>> 	think that would be safe to allow by default in distros?  If so,
>> 	then we're certainly fine here.
> 
> Unprivileged mounting seems like a different question to me.
> Related, possibly, but not the same. I'd rather leave that
> discussion to another thread.
> 
> 
> --
> Chuck Lever
> 
> 
> 

