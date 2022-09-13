Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0655B7C73
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 23:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIMVGq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 17:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIMVGo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 17:06:44 -0400
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26EA661B13
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 14:06:41 -0700 (PDT)
Received: from [192.168.50.173] ([146.241.22.4])
        by Aruba Outgoing Smtp  with ESMTPSA
        id YD78oa4POWuL0YD78oFoea; Tue, 13 Sep 2022 23:06:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1663103199; bh=20m1Xz05dyemyXvB6f90NSVuR2jT16nE0etUMS9IQwM=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=e4V42ch7fcQoR6ynZh5uzZumbDj7GQsa9mSHFVe157uSnAdzjas/YZn/0JJCgcNKZ
         n1J2n6Eq5iyavhnFLRFMrJHehFo+1kGxsqE2+QPvVmuQf9avDdI8s19JvH8MKo2rrh
         meABK5yDiG38rQ61uTz+G75FNbZFIW8ztQWFX5715QPpr4ObuxjlficEC0t0l4mmnV
         kQxu9DhXj2vqoV8eqEPRpk1RJnKnRe/d3ZJHK3yo7k7wlAvOo+55ZjoXcjarpDE8YO
         uaCE+7G6XlFlHA6ZILs/GgTWnpeUO6a0YXBXB+V7kb7l7L98BjtHXdHzgiZmH30T6c
         MEc1nfoS9TUcw==
Message-ID: <f67c4131-0dc0-a909-e5ad-d323406ce03d@benettiengineering.com>
Date:   Tue, 13 Sep 2022 23:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3] nfsrahead: fix linking while static linking
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <YvVkftYtIgFhYHKk@pevik>
 <881E6E82-812C-4BD8-849C-4DEE484AE4F0@benettiengineering.com>
 <12ece17b-b2d9-6621-0af7-26a12470bc99@redhat.com>
 <21969dec-4bbe-94ae-b317-1bc12300d6ca@benettiengineering.com>
 <42980d60-3b6d-4479-8c1a-a5fd7ba30f4c@redhat.com> <YyCoRz6FfHgnCnmw@pevik>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <YyCoRz6FfHgnCnmw@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBROEG902JmmmJkWhksEIPkSYUNEklJpoO0koQ9LUo5ZddOCvK0QRf5t5Z2bKM8b3Mi6wkDr+gk/DD27jsHma0MmUPvH8S6zJppmix3SsAAWiwKrb5HN
 9M7miwmLhteJ9DvM94qGqzBWs35U2DMR7VplVjC+mqRrMfvm193kK/tW6BSvzg1ZDaLUx5KYyJLncBZMnUgnCXKoG/PcvJUnzQaKqbAj2YIvrj72sPgRIlGX
 Kpm4uPtToAJV19WrdOq4VUroSRFaxlxfcspNGc65wCg=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Petr, Steve, All,

On 13/09/22 17:56, Petr Vorel wrote:
> 
> 
>> On 8/22/22 4:33 PM, Giulio Benetti wrote:
>>> Hi Steve, Petr,
> 
>>> On 22/08/22 21:17, Steve Dickson wrote:
> 
> 
>>>> On 8/11/22 4:36 PM, Giulio Benetti wrote:
>>>>> Hi Petr,
> 
>>>>>> Il giorno 11 ago 2022, alle ore 22:20, Petr Vorel
>>>>>> <pvorel@suse.cz> ha scritto:
> 
>>>>>> ﻿Hi,
> 
>>>>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>>>>>> nit (not worth of reposting): I'm not a native speaker, but
>>>>>> IMHO subject should
>>>>>> be without while, e.g. "fix order on static linking"
> 
>>>>> Totally, it sounds awful as it is now.
>>>>> I ask maintainers if it’s possible to reword like Petr
>>>>> pointed.
>>>> Will do!
> 
>>> Thank you!
> 
>>> I will try to improve the pkg-config autotools because as it is now it
>>> works but it’s not a good solution.
> 
>>> I should use what it’s been suggested to me here:
>>> https://lists.buildroot.org/pipermail/buildroot/2022-August/648926.html
>>> And I’ve given another solution:
>>> https://lists.buildroot.org/pipermail/buildroot/2022-August/648933.html
>>> but it’s still not ok:
>>> https://lists.buildroot.org/pipermail/buildroot/2022-August/649058.html
>> I don't have access to those list...
> 
> Yep, these are forbidden 403.
> Giulio, please post a link on lore
> https://lore.kernel.org/buildroot/
> (or on patchwork)

Oops, you're both right, thank you Petr.

Follows lore links:

I should use what it’s been suggested to me here:
https://lore.kernel.org/buildroot/20220810231839.1b6164f7@windsurf/
And I’ve given another solution:
https://lore.kernel.org/buildroot/20220810215104.107714-1-giulio.benetti@benettiengineering.com/
but it’s still not ok:
https://lore.kernel.org/buildroot/20220811224752.1a1e53b7@windsurf/

Best regards
-- 
Giulio Benetti
Benetti Engineering sas
