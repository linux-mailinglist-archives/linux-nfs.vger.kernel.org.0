Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9818B69E23D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Feb 2023 15:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjBUOY6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Feb 2023 09:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjBUOY5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Feb 2023 09:24:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810AC10269;
        Tue, 21 Feb 2023 06:24:55 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pUTZc-0002EL-Pt; Tue, 21 Feb 2023 15:24:52 +0100
Message-ID: <9dda9e11-565f-8725-6d15-803a66782753@leemhuis.info>
Date:   Tue, 21 Feb 2023 15:24:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <65ae10cd-a086-47c6-c881-d1385d7fcf42@leemhuis.info>
 <5150343c-e13d-ed15-e59a-bc14f0db89da@leemhuis.info>
 <78806040-5725-103f-fe55-8c6d9ced6e63@linaro.org>
Content-Language: en-US, de-DE
In-Reply-To: <78806040-5725-103f-fe55-8c6d9ced6e63@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676989495;a5a7c7ef;
X-HE-SMSGID: 1pUTZc-0002EL-Pt
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18.02.23 16:09, Krzysztof Kozlowski wrote:
> On 18/02/2023 05:42, Linux regression tracking #update (Thorsten
> Leemhuis) wrote:
>> [TLDR: This mail in primarily relevant for Linux regression tracking. A
>> change or fix related to the regression discussed in this thread was
>> posted or applied, but it did not use a Link: tag to point to the
>> report, as Linus and the documentation call for. Things happen, no
>> worries -- but now the regression tracking bot needs to be told manually
>> about the fix. See link in footer if these mails annoy you.]
>>
>> On 08.01.23 09:52, Linux kernel regression tracking (#adding) wrote:
>>> On 07.01.23 16:44, Krzysztof Kozlowski wrote:
>>>>
>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
>>>> KConfig value for READ_PLUS") as one leading to NULL pointer exception
>>>> when mounting NFS root on NFSv4 client:
>>> [...]
>>> Thanks for the report. To be sure the issue doesn't fall through the
>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>> tracking bot:
>>>
>>> #regzbot ^introduced 7fd461c47
>>> #regzbot title nfs: NULL pointer dereference since NFS_V4_2_READ_PLUS is
>>> enabled by default
>>> #regzbot ignore-activity
>>
>> #regzbot fix: 896e090eefedeb8a715ea19938a2791c32679
> 
> I see it was posted and merged as "Revert "NFSv4.2: Change the default
> KConfig value for READ_PLUS"". It's nice to give credits to people who
> report bugs with "Reported-by" tag.

Yup. And a "Link:" with the url to the report is missing as well (Linus
wants those, automatic regression tracking needs those [IOW: if they are
missing it causes me trouble, that's why I care], and the docs explain
this as well).

That's why I asked for those two tags, but I didn't even get a reply:

https://lore.kernel.org/all/8d26e819-a3a5-7ae1-bb9e-56bacfa7f65b@leemhuis.info/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
