Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039C8145E4B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 22:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVV4B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 16:56:01 -0500
Received: from smtpcmd0641.aruba.it ([62.149.156.41]:60998 "EHLO
        smtpcmd0641.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVV4B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 16:56:01 -0500
Received: from [192.168.126.128] ([146.241.70.103])
        by smtpcmd06.ad.aruba.it with bizsmtp
        id tZvy2100m2DhmGq01ZvzGn; Wed, 22 Jan 2020 22:56:00 +0100
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler
 costraint
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
References: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
 <ae36c91f-bed4-3839-bdd5-fffdcca9bf40@RedHat.com>
 <92111fa0-a808-84da-19b8-823ad6a26a99@benettiengineering.com>
 <3857d0ce-ba29-d92e-3e24-9dfc33cfc7f9@benettiengineering.com>
 <b98b367b-3fbb-99d4-b1af-e7e7f6a1728c@RedHat.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <cc7f2ae5-99a7-57ca-5913-7df6a85e08ba@benettiengineering.com>
Date:   Wed, 22 Jan 2020 22:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b98b367b-3fbb-99d4-b1af-e7e7f6a1728c@RedHat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1579730160; bh=9Aa6DmijMjx/IqtggBDSyC26trFL6MNztt/fTRzr87U=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=b4Y81ToJQx1ghNS3+2NZXnLF6zXjNv4xgUMbMzW37jo53D2RFlkqYAGSBVIjajHR4
         +Klh/2uvh3cx9LV0RH7b2IT9+vKyiFqcKQ2JbyWLKJzh2tZ9u1sBz38kVvIWfP23+x
         hYy8NlkFY7WIU3yn3uIhT3hiO9+BUTTEHvzhizRqbjH8M1ix/x2G7+C+qqqb6XMQS0
         F7vRPn82mCTLl3JJx0mKnFtKuTf+2IM4zRv7ePaK+Jf8WcguLFQQ0r9m5jor1oeBHP
         AcZKjF8Ofcg4AarllVaBALiOUgje3g9ickktguzzoPF+I8Yp3k0evPnhcxQK8SXWcU
         mwKG7qo7ND6pA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/22/20 8:30 PM, Steve Dickson wrote:
> 
> 
> On 1/22/20 1:54 PM, Giulio Benetti wrote:
>> Hi Steve, Petr,
>>
>> On 1/22/20 7:11 PM, Giulio Benetti wrote:
>>> Hi Steve,
>>>
>>> On 1/22/20 6:56 PM, Steve Dickson wrote:
>>>>
>>>>
>>>> On 1/15/20 11:08 AM, Giulio Benetti wrote:
>>>>> Currently locktest can be built only for host because CC_FOR_BUILD is
>>>>> specified as CC, but this leads to build failure when passing CFLAGS not
>>>>> available on host gcc(i.e. -mlongcalls) and most of all locktest would
>>>>> be available on target systems the same way as rpcgen etc. So remove CC
>>>>> and LIBTOOL assignments.
>>>>>
>>>>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>>>> Committed... (tag: nfs-utils-2-4-3-rc6)
>>>
>>> I've just setup up a Gentoo to try building nfs-utils, I give a try
>>> anyway by now, so we should be sure.
>>
>> Just tried, it builds correctly on latest Gentoo.
> Good to hear... Thank you for your effort!!!!

It's a pleasure. Btw, when do you plan to release version 2.4.3?
I have Buildroot patch ready to be sent.

Kinds regards
-- 
Giulio Benetti
Benetti Engineering sas
