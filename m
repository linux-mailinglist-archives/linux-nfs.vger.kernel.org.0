Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D005E14AA20
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 19:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgA0S6H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 13:58:07 -0500
Received: from smtpcmd11116.aruba.it ([62.149.156.116]:35019 "EHLO
        smtpcmd11116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0S6H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 13:58:07 -0500
Received: from [192.168.126.128] ([146.241.70.103])
        by smtpcmd11.ad.aruba.it with bizsmtp
        id vWy42100L2DhmGq01Wy41E; Mon, 27 Jan 2020 19:58:05 +0100
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler
 costraint
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
References: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
 <ae36c91f-bed4-3839-bdd5-fffdcca9bf40@RedHat.com>
 <92111fa0-a808-84da-19b8-823ad6a26a99@benettiengineering.com>
 <3857d0ce-ba29-d92e-3e24-9dfc33cfc7f9@benettiengineering.com>
 <b98b367b-3fbb-99d4-b1af-e7e7f6a1728c@RedHat.com>
 <cc7f2ae5-99a7-57ca-5913-7df6a85e08ba@benettiengineering.com>
 <a958026e-4ec1-bdda-ef5c-d73f47f0ea33@RedHat.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <c3431ba6-d141-780a-6399-02850c068a3f@benettiengineering.com>
Date:   Mon, 27 Jan 2020 19:58:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a958026e-4ec1-bdda-ef5c-d73f47f0ea33@RedHat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1580151485; bh=rpHf1YmB8mKCGZx3rqWPQO0C2uOUKAWOjPCNVSgKhs4=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=edBLMKomR716I9Jl6uNpfOQzDkLm9xtF1OKqG6bCb00dBNuDkbO8Y3hA3/1VoCuJ5
         7YJbAUnS9M0ZN6QpcM3MnSGEstERNEfPSyYT86NnS/4ZKyXbStTQMA68Mto4vAi2TO
         vKhqxdPXpdt/Kvmp6jAcMEoycyCrGPbzyQRmrdpZbvxGJha70yavPsWCat2K2YaQs8
         dqT7QAm5r78ALUUtIVcw9zb882S8ImDt6nmlDmqOOB6cBDuktfmFNWZQks6CjMtuKf
         +x7LZVH9GYkpzvGvwZPEhu69WfzhM+fWuwK3Oe/WvyodfgwZSyxGWqRxfkxMfwbrQV
         516pgi0sAV4SA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

On 1/27/20 7:41 PM, Steve Dickson wrote:
> 
> 
> On 1/22/20 4:55 PM, Giulio Benetti wrote:
>> On 1/22/20 8:30 PM, Steve Dickson wrote:
>>>
>>>
>>> On 1/22/20 1:54 PM, Giulio Benetti wrote:
>>>> Hi Steve, Petr,
>>>>
>>>> On 1/22/20 7:11 PM, Giulio Benetti wrote:
>>>>> Hi Steve,
>>>>>
>>>>> On 1/22/20 6:56 PM, Steve Dickson wrote:
>>>>>>
>>>>>>
>>>>>> On 1/15/20 11:08 AM, Giulio Benetti wrote:
>>>>>>> Currently locktest can be built only for host because CC_FOR_BUILD is
>>>>>>> specified as CC, but this leads to build failure when passing CFLAGS not
>>>>>>> available on host gcc(i.e. -mlongcalls) and most of all locktest would
>>>>>>> be available on target systems the same way as rpcgen etc. So remove CC
>>>>>>> and LIBTOOL assignments.
>>>>>>>
>>>>>>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>>>>>> Committed... (tag: nfs-utils-2-4-3-rc6)
>>>>>
>>>>> I've just setup up a Gentoo to try building nfs-utils, I give a try
>>>>> anyway by now, so we should be sure.
>>>>
>>>> Just tried, it builds correctly on latest Gentoo.
>>> Good to hear... Thank you for your effort!!!!
>>
>> It's a pleasure. Btw, when do you plan to release version 2.4.3?
>> I have Buildroot patch ready to be sent.
> Go ahead and send it... I'll make a release after that...

You can already release, I've meant that I have a patch so send to 
Buildroot to bump nfs-utils version :-)

Thank you
Best regards
-- 
Giulio Benetti
Benetti Engineering sas

> steved.
> 
>>
>> Kinds regards
> 

