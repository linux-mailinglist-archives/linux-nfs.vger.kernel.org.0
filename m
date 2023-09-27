Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01DC7B0562
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 15:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjI0NaY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 09:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjI0NaY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 09:30:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72F180
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 06:30:22 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qlUcP-0007o8-2A; Wed, 27 Sep 2023 15:30:21 +0200
Message-ID: <ac51e942-7348-411d-8532-99fe0101df2b@leemhuis.info>
Date:   Wed, 27 Sep 2023 15:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
        linux-nfs@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695821422;19f02558;
X-HE-SMSGID: 1qlUcP-0007o8-2A
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 24.09.23 15:07, Mantas Mikulėnas wrote:
> I've recently upgraded my home NFS server from 6.4.12 to 6.5.4 (running
> Arch Linux x86_64).
> 
> Now, when I'm accessing the server over NFSv4.2 from a client that's
> running 5.10.0 (32-bit x86, Debian 11), if the mount is using sec=krb5i
> or sec=krb5p, trying to read a file that's <= 4092 bytes in size will
> return all-zero data. (That is, `hexdump -C file` shows "00 00 00...")
> Files that are 4093 bytes or larger seem to be unaffected.
> 
> Only sec=krb5i/krb5p are affected by this – plain sec=krb5 (or sec=sys
> for that matter) seems to work without any problems.
> 
> Newer clients (like 6.1.x or 6.4.x) don't seem to have any issues, it's
> only 5.10.0 that does... though it might also be that the client is
> 32-bit, but the same client did work previously when the server was
> running older kernels, so I still suspect 6.5.x on the server being the
> problem.
> 
> Upgrading to 6.6.0-rc2 on the server hasn't changed anything.
> The server is using Btrfs but I've tested with tmpfs as well.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 703d7521555504b3a316b105b4806d641
#regzbot title nfs: Data corruption with 5.10.x client -> 6.5.x server
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
