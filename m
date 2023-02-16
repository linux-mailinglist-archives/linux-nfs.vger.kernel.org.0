Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E94698FE2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Feb 2023 10:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBPJe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Feb 2023 04:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBPJe6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Feb 2023 04:34:58 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83030B35
        for <linux-nfs@vger.kernel.org>; Thu, 16 Feb 2023 01:34:57 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSafH-0002E0-PE; Thu, 16 Feb 2023 10:34:55 +0100
Message-ID: <8d26e819-a3a5-7ae1-bb9e-56bacfa7f65b@leemhuis.info>
Date:   Thu, 16 Feb 2023 10:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] Revert "NFSv4.2: Change the default KConfig value for
 READ_PLUS"
Content-Language: en-US, de-DE
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com
References: <20230215214922.1811502-1-anna@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <20230215214922.1811502-1-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676540097;c1d0cde7;
X-HE-SMSGID: 1pSafH-0002E0-PE
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 15.02.23 22:49, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> This reverts commit 7fd461c47c6cfab4ca4d003790ec276209e52978.
> 
> Unfortunately, it has come to our attention that there is still a bug
> somewhere in the READ_PLUS code that can result in nfsroot systems on
> ARM to crash during boot.
> 
> Let's do the right thing and revert this change so we don't break
> people's nfsroot setups.

Many thx for taking care of this.

Do you plan to send this to Linus before he releases the final? Or
should I point him to this patch (or a later version) in my weekly
report so that he can decide himself if he wants to pick it up?

There is afaics also one small thing to improve, please add the
following tags to make things easier for future code archaeologists:

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link:
https://lore.kernel.org/all/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/

To explain: Linus[1] and others considered proper link tags with the URL
to the report important, as they allow anyone to look into the backstory
of a fix weeks or years later. That's nothing new, the documentation[2]
for some time says to place such tags in cases like this. I care
personally (and made it a bit more explicit in the docs a while ago),
because these tags make my regression tracking efforts a whole lot
easier, as they allow my tracking bot 'regzbot' to automatically connect
reports with patches posted or committed to fix tracked regressions.

Apropos regzbot, let me tell regzbot to monitor this thread:

#regzbot ^backmonitor:
https://lore.kernel.org/all/f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org/

> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
