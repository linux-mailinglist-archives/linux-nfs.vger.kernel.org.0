Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD706E388C
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Apr 2023 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDPNOQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Apr 2023 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDPNOP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Apr 2023 09:14:15 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C865211B
        for <linux-nfs@vger.kernel.org>; Sun, 16 Apr 2023 06:14:14 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1po2Cq-0003L1-9w; Sun, 16 Apr 2023 15:14:12 +0200
Message-ID: <e25e2e81-47e6-63a0-9c0d-00258397e47b@leemhuis.info>
Date:   Sun, 16 Apr 2023 15:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: v6.2 client behaviour change (repeat access calls)?
Content-Language: en-US, de-DE
To:     Daire Byrne <daire@dneg.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
References: <CAPt2mGMgCCWYP-ZaHCovMuRZmHYYPhApNiUybKTw4pr5XwZkjw@mail.gmail.com>
 <2f2473a4-5fd2-a772-e1af-885e21700467@leemhuis.info>
 <0cfd6568-de03-9ea5-2778-42ab2e6515db@leemhuis.info>
 <7912bba8-7127-abb0-4366-1abbb88db504@leemhuis.info>
 <CAPt2mGNaNTD=a+UsDLDeRWqd+PVHk6Rh-OX0+0BxGc+xgovraA@mail.gmail.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAPt2mGNaNTD=a+UsDLDeRWqd+PVHk6Rh-OX0+0BxGc+xgovraA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681650854;b6470b25;
X-HE-SMSGID: 1po2Cq-0003L1-9w
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23.03.23 13:02, Daire Byrne wrote:
> Yes, sorry, I did see that patch was posted not long after I reported
> the excessive repeat ACCESS calls but I have not had a chance to test
> it.
> 
> It certainly looks promising. I will try to get to it next week and
> update my original email.

Hmm, no update afaics (or I missed it). No worries, but I for now will
assume this was fixed. Please correct me if it later turns out that I've
been wrong.

#regzbot fix: 21fd9e8700de86d1169
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


> On Thu, 23 Mar 2023 at 11:54, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> On 20.03.23 13:34, Thorsten Leemhuis wrote:
>>> On 10.03.23 11:43, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> [CCing the regression list, as it should be in the loop for regressions:
>>>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>>>
>>>> [also adding the author of the culprit (Trond) and the second NFS client
>>>> maintainer (Anna) to the list of recipients]
>>>
>>> Trond, sorry to bother you, but do you still have this regression report
>>> on your radar? It looks a bit like it fall through the cracks, as I
>>> don't see any reply since it was posted nearly two weeks ago. Or did
>>> some progress to address this happen and I just missed it?
>>
>> Daire, it seems the NFS developers ignore my inquiries, sorry.
>>
>> But well, I noticed there is a patch that references the culprit you
>> found in the bisection:
>>
>> https://lore.kernel.org/all/20230308080327.33906-1-chengen.du@canonical.com/
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=master&id=21fd9e8700de86d1169f6336e97d7a74916ed04a
>>
>> I wonder if you are aware of it or maybe even tested it already. To me
>> it sounds like it could fix your problem, but this is not my area of
>> expertise, so I might be totally wrong.
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot ignore-activity
>>
>>>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>>>> regressions; the text you find below is based on a few templates
>>>> paragraphs you might have encountered already in similar form.
>>>> See link in footer if these mails annoy you.]
>>>>
>>>> On 07.03.23 18:38, Daire Byrne wrote:
>>>>> I noticed a change in behaviour in the v6.2.x client versus v6.1.12 (and below).
>>>>>
>>>>> We have some servers that mount Netapps from different locations many
>>>>> milliseconds away, and these contain apps and libs that get added to
>>>>> the LD_LIBRARY_PATH and PATH on remote login.
>>>>>
>>>>> I then noticed that when I ssh'd into a remote server that had these
>>>>> mounts and the shell was starting, the first login was normal and I
>>>>> observed an expected flurry of lookups,getattrs and access calls for a
>>>>> grand total of only ~120 packets to the Netapp.
>>>>>
>>>>> But when I disconnect and reconnect (ssh), now I see a flood of access
>>>>> calls to the netapp for a handful of repeating filehandles which look
>>>>> something like:
>>>>>
>>>>>  2700 85.942563180 10.23.112.10 → 10.23.21.11  NFS 254 V3 ACCESS Call,
>>>>> FH: 0x7f36addc, [Check: RD LU MD XT DL]
>>>>>  2701 85.999838796  10.23.21.11 → 10.23.112.10 NFS 190 V3 ACCESS Reply
>>>>> (Call In 2700), [Allowed: RD LU MD XT DL]
>>>>>  2702 85.999970825 10.23.112.10 → 10.23.21.11  NFS 254 V3 ACCESS Call,
>>>>> FH: 0x7f36addc, [Check: RD LU MD XT DL]
>>>>>  2703 86.055340946  10.23.21.11 → 10.23.112.10 NFS 190 V3 ACCESS Reply
>>>>> (Call In 2702), [Allowed: RD LU MD XT DL]
>>>>>  2704 86.056865308 10.23.112.10 → 10.23.21.11  NFS 254 V3 ACCESS Call,
>>>>> FH: 0x7f36addc, [Check: RD LU MD XT DL]
>>>>>  2705 86.112233415  10.23.21.11 → 10.23.112.10 NFS 190 V3 ACCESS Reply
>>>>> (Call In 2704), [Allowed: RD LU MD XT DL]
>>>>>
>>>>> This time we total 5000+ packets for this login which becomes very
>>>>> noticeable when the Netapp is 50ms away.
>>>>>
>>>>> I didn't understand why the first login was fine but the second goes
>>>>> into this repeating access pattern. I set actimeo=3600 (long) but it
>>>>> does not seem to affect it.
>>>>>
>>>>> I do not see this prior to v6.2 where repeated logins are equally fast
>>>>> and we don't see the repeating access calls.
>>>>>
>>>>> So a bit of digging through the v6.2 changes and this looked like the
>>>>> relevant change:
>>>>>
>>>>> commit 0eb43812c027 ("NFS: Clear the file access cache upon login”)
>>>>> [PATCH] NFS: Judge the file access cache's timestamp in rcu path?
>>>>>
>>>>> I reverted those and got the prior (v6.1) performance.
>>>>>
>>>>> What constitutes a login exactly? I also have services like "sysstat"
>>>>> or pcp that cause a systemd-logind to trigger regularly on our
>>>>> machines.... does that count and invalidate the cache?
>>>>>
>>>>> Do the repeated access calls on the same handful of filehandles make
>>>>> sense? Even prior to those patches (or v6.1) there are only a couple
>>>>> of ACCESS calls to the Netapp on login.
>>>>>
>>>>> We are a bit unique in that we run quite a few WAN high latency NFS
>>>>> workflows so are happy to trade long lived caches (e.g. actimeo and
>>>>> even nocto on occasion) for lower ops at the expense of total
>>>>> correctness.
>>>>
>>>> Thanks for the report. To be sure the issue doesn't fall through the
>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>>> tracking bot:
>>>>
>>>> #regzbot ^introduced 0eb43812c027
>>>> #regzbot title nfs: flood of access on second log-in (first is fine)
>>>> #regzbot ignore-activity
>>>>
>>>> This isn't a regression? This issue or a fix for it are already
>>>> discussed somewhere else? It was fixed already? You want to clarify when
>>>> the regression started to happen? Or point out I got the title or
>>>> something else totally wrong? Then just reply and tell me -- ideally
>>>> while also telling regzbot about it, as explained by the page listed in
>>>> the footer of this mail.
>>>>
>>>> Developers: When fixing the issue, remember to add 'Link:' tags pointing
>>>> to the report (the parent of this mail). See page linked in footer for
>>>> details.
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>> --
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> That page also explains what to do if mails like this annoy you.
> 
> 
