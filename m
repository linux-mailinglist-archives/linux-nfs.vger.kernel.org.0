Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2E6C30FA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 12:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCULzX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 07:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjCULzW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 07:55:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBEA4C6CB;
        Tue, 21 Mar 2023 04:54:51 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1peaZk-0003yv-QP; Tue, 21 Mar 2023 12:54:48 +0100
Message-ID: <b5920311-abbe-1b00-5bb5-66a545f2d481@leemhuis.info>
Date:   Tue, 21 Mar 2023 12:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [regression] Bug 217165 - NFS cache stops working if accessed
 from process with PPID of 1
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Chengen Du <chengen.du@canonical.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <1ee77457-3345-0f7f-a0d0-fa8eced53b8f@leemhuis.info>
 <16171331-8301-738e-8c1d-b48a11275ce9@leemhuis.info>
In-Reply-To: <16171331-8301-738e-8c1d-b48a11275ce9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679399691;87f1a59d;
X-HE-SMSGID: 1peaZk-0003yv-QP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 20.03.23 13:40, Thorsten Leemhuis wrote:
> [adding the author of the culprit, the NFS maintainers & list and lkml
> to the list of recipients]

Chengen Du, thx for replying in bugzilla!

> On 10.03.23 10:42, Linux regression tracking #adding (Thorsten Leemhuis)
> wrote:
> 
> Seems I was wrong in this case or in general, as that bug report didn't
> get a single reply yet. Hence this mail to ensure the right people have
> it on their radar. Or was some progress to address this made and I just
> missed it?
> 
>> nevertheless I'd like to add
>> to the tracking to ensure it's doesn't fall through the cracks in the end:
>>
>> #regzbot introduced: 029085b8949f5d269ae
>> https://bugzilla.kernel.org/show_bug.cgi?id=217165
>> #regzbot title: nfs: cache stops working if accessed from process with
>> PPID of 1
>> #regzbot ignore-activity

#regzbot fix: 21fd9e8700de86d1169f6336e97d7a74916ed0
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
