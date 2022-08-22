Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFAE59CA11
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Aug 2022 22:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiHVUer (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Aug 2022 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiHVUep (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Aug 2022 16:34:45 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 13:34:43 PDT
Received: from smtpcmd13158.aruba.it (smtpcmd13158.aruba.it [62.149.156.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 623AF54CB0
        for <linux-nfs@vger.kernel.org>; Mon, 22 Aug 2022 13:34:43 -0700 (PDT)
Received: from [192.168.8.175] ([86.32.48.35])
        by Aruba Outgoing Smtp  with ESMTPSA
        id QE7BoCHireEtAQE7BoHsc1; Mon, 22 Aug 2022 22:33:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1661200421; bh=+g9XVWxxnyYZewNCvsfRpgHeOl53WPa05r6a57zujSo=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=XTnXUeDnrdyLlGxyJib0dBuQHmvTitf5dK2dnDTkWJbdcAUWFIH0OUMmKY5JQJjPw
         niaoOV/hgchHBFyQP4IGs8UTBTRbTxAf9iXgSmdpR27dObbCbTxPfVoPUPCpX6T9Hu
         D4Gk/KWC/RaKC1KGVeC62kGf71xo4CjlSCjnCjEoPJNb1h1opSRUdAXFXESSiK6dkr
         bkrgKS61nddQ+j/9cvteP0d3lQ9ftDfEwg84mytPGkWOsZ84JJBFjjO6OZl9hlMUwJ
         RfIgEYznKuq7AhafiLdWh8dX2u1G+SXhqLKpyJtLd4F/29cVZnMQXEm4qkH+kOOYmQ
         G1znIitHvabmg==
Message-ID: <21969dec-4bbe-94ae-b317-1bc12300d6ca@benettiengineering.com>
Date:   Mon, 22 Aug 2022 22:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] nfsrahead: fix linking while static linking
Content-Language: en-US
To:     Steve Dickson <steved@redhat.com>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org
References: <YvVkftYtIgFhYHKk@pevik>
 <881E6E82-812C-4BD8-849C-4DEE484AE4F0@benettiengineering.com>
 <12ece17b-b2d9-6621-0af7-26a12470bc99@redhat.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <12ece17b-b2d9-6621-0af7-26a12470bc99@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLiSwNVq5J4GYvRWc1yko/Kyd8nTqF7IippCTcPImRdiQmjuFJ6L7eT1GQ5UPkLPEeHJsro/Xa+7E6qmAsPDHMxrHw6Xmf3VDEXb/lsLBaogyQ1fID0x
 zDOHBkowRCOzQCrLy0x2Wl2YY80EVMjk8uJ3rU6cEvfJgJsrtT1gMQcWmDGd7A2+kkbvqnBqPCOqxeIq4buZhNCLt0QBTGGhwZo0YBUvZ1rYqjWQQY7bI4lV
 wiGBaKJttU1KhKwfODT86Z0xTtiUKDQrj1k6SDqwmxg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve, Petr,

On 22/08/22 21:17, Steve Dickson wrote:
> 
> 
> On 8/11/22 4:36 PM, Giulio Benetti wrote:
>> Hi Petr,
>>
>>> Il giorno 11 ago 2022, alle ore 22:20, Petr Vorel <pvorel@suse.cz> ha 
>>> scritto:
>>>
>>> ﻿Hi,
>>>
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>>
>>> nit (not worth of reposting): I'm not a native speaker, but IMHO 
>>> subject should
>>> be without while, e.g. "fix order on static linking"
>>
>> Totally, it sounds awful as it is now.
>> I ask maintainers if it’s possible to reword like Petr
>> pointed.
> Will do!

Thank you!

I will try to improve the pkg-config autotools because as it is now it 
works but it’s not a good solution.

I should use what it’s been suggested to me here:
https://lists.buildroot.org/pipermail/buildroot/2022-August/648926.html
And I’ve given another solution:
https://lists.buildroot.org/pipermail/buildroot/2022-August/648933.html
but it’s still not ok:
https://lists.buildroot.org/pipermail/buildroot/2022-August/649058.html

So for the moment it’s a decent solution indeed it’s been committed to 
Buildroot
but I’ll try to improve it once I’ll have time.

Kind regards
—
Giulio Benetti
CEO/CTO@Benetti Engineering sas

> steved.
>>
>> Thank you all.
>>
>> Best regards
>> Giulio
>>
>>>
>>> Kind regards,
>>> Petr
>>
> 

-- 
Giulio Benetti
Benetti Engineering sas
