Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7966142F
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 09:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjAHIxC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 03:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjAHIxB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 03:53:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED999CD1;
        Sun,  8 Jan 2023 00:52:57 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pERQF-0006lI-8O; Sun, 08 Jan 2023 09:52:55 +0100
Message-ID: <65ae10cd-a086-47c6-c881-d1385d7fcf42@leemhuis.info>
Date:   Sun, 8 Jan 2023 09:52:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Content-Language: en-US, de-DE
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673167978;5ad638ba;
X-HE-SMSGID: 1pERQF-0006lI-8O
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 07.01.23 16:44, Krzysztof Kozlowski wrote:
> Hi,
> 
> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
> KConfig value for READ_PLUS") as one leading to NULL pointer exception
> when mounting NFS root on NFSv4 client:
> 
> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid
> argument
> [   26.199478] 8<--- cut here ---
> [   26.201366] Unable to handle kernel NULL pointer dereference at
> virtual address 00000004
> ...
> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/0x358
> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
> 
> Full OOPS attached. Full log available here:
> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
> 
> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commit is
> not the cause, but rather making it default caused the regression.
> 
> I did not make the bisect yet which commit introduced it, if every
> config includes NFS_V4_2_READ_PLUS.
> 
> 
> Some details about platform:
> 
> 1. Arch ARM Linux
> 2. exynos_defconfig
> 3. Odroid HC1 board with ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
> 4. systemd, boot up with static IP set in kernel command line
> 5. No swap
> 6. Kernel, DTB and initramfs are downloaded with TFTP
> 7. NFS root (NFS client) mounted from a NFSv4 server

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 7fd461c47
#regzbot title nfs: NULL pointer dereference since NFS_V4_2_READ_PLUS is
enabled by default
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
