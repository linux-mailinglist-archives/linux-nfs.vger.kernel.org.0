Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF996C11FB
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 13:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCTMfD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 08:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCTMfC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 08:35:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FBC6E97
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 05:34:49 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1peEis-0000Rm-Ss; Mon, 20 Mar 2023 13:34:46 +0100
Message-ID: <0cfd6568-de03-9ea5-2778-42ab2e6515db@leemhuis.info>
Date:   Mon, 20 Mar 2023 13:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: v6.2 client behaviour change (repeat access calls)?
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>, Anna Schumaker <anna@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <CAPt2mGMgCCWYP-ZaHCovMuRZmHYYPhApNiUybKTw4pr5XwZkjw@mail.gmail.com>
 <2f2473a4-5fd2-a772-e1af-885e21700467@leemhuis.info>
In-Reply-To: <2f2473a4-5fd2-a772-e1af-885e21700467@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679315690;87ebe64d;
X-HE-SMSGID: 1peEis-0000Rm-Ss
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10.03.23 11:43, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> 
> [also adding the author of the culprit (Trond) and the second NFS client
> maintainer (Anna) to the list of recipients]

Trond, sorry to bother you, but do you still have this regression report
on your radar? It looks a bit like it fall through the cracks, as I
don't see any reply since it was posted nearly two weeks ago. Or did
some progress to address this happen and I just missed it?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
> 
> On 07.03.23 18:38, Daire Byrne wrote:
>> I noticed a change in behaviour in the v6.2.x client versus v6.1.12 (and below).
>>
>> We have some servers that mount Netapps from different locations many
>> milliseconds away, and these contain apps and libs that get added to
>> the LD_LIBRARY_PATH and PATH on remote login.
>>
>> I then noticed that when I ssh'd into a remote server that had these
>> mounts and the shell was starting, the first login was normal and I
>> observed an expected flurry of lookups,getattrs and access calls for a
>> grand total of only ~120 packets to the Netapp.
>>
>> But when I disconnect and reconnect (ssh), now I see a flood of access
>> calls to the netapp for a handful of repeating filehandles which look
>> something like:
>>
>>  2700 85.942563180 10.23.112.10 → 10.23.21.11  NFS 254 V3 ACCESS Call,
>> FH: 0x7f36addc, [Check: RD LU MD XT DL]
>>  2701 85.999838796  10.23.21.11 → 10.23.112.10 NFS 190 V3 ACCESS Reply
>> (Call In 2700), [Allowed: RD LU MD XT DL]
>>  2702 85.999970825 10.23.112.10 → 10.23.21.11  NFS 254 V3 ACCESS Call,
>> FH: 0x7f36addc, [Check: RD LU MD XT DL]
>>  2703 86.055340946  10.23.21.11 → 10.23.112.10 NFS 190 V3 ACCESS Reply
>> (Call In 2702), [Allowed: RD LU MD XT DL]
>>  2704 86.056865308 10.23.112.10 → 10.23.21.11  NFS 254 V3 ACCESS Call,
>> FH: 0x7f36addc, [Check: RD LU MD XT DL]
>>  2705 86.112233415  10.23.21.11 → 10.23.112.10 NFS 190 V3 ACCESS Reply
>> (Call In 2704), [Allowed: RD LU MD XT DL]
>>
>> This time we total 5000+ packets for this login which becomes very
>> noticeable when the Netapp is 50ms away.
>>
>> I didn't understand why the first login was fine but the second goes
>> into this repeating access pattern. I set actimeo=3600 (long) but it
>> does not seem to affect it.
>>
>> I do not see this prior to v6.2 where repeated logins are equally fast
>> and we don't see the repeating access calls.
>>
>> So a bit of digging through the v6.2 changes and this looked like the
>> relevant change:
>>
>> commit 0eb43812c027 ("NFS: Clear the file access cache upon login”)
>> [PATCH] NFS: Judge the file access cache's timestamp in rcu path?
>>
>> I reverted those and got the prior (v6.1) performance.
>>
>> What constitutes a login exactly? I also have services like "sysstat"
>> or pcp that cause a systemd-logind to trigger regularly on our
>> machines.... does that count and invalidate the cache?
>>
>> Do the repeated access calls on the same handful of filehandles make
>> sense? Even prior to those patches (or v6.1) there are only a couple
>> of ACCESS calls to the Netapp on login.
>>
>> We are a bit unique in that we run quite a few WAN high latency NFS
>> workflows so are happy to trade long lived caches (e.g. actimeo and
>> even nocto on occasion) for lower ops at the expense of total
>> correctness.
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 0eb43812c027
> #regzbot title nfs: flood of access on second log-in (first is fine)
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
> 
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (the parent of this mail). See page linked in footer for
> details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.
