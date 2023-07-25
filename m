Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D089761A0C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGYNeq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 09:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGYNep (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 09:34:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC791BC3;
        Tue, 25 Jul 2023 06:34:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qOIBR-000258-7S; Tue, 25 Jul 2023 15:34:37 +0200
Message-ID: <da198f52-f699-00f6-cd77-366adc4bbdc9@leemhuis.info>
Date:   Tue, 25 Jul 2023 15:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: NFS workload leaves nfsd threads in D state
Content-Language: en-US, de-DE
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Chengming Zhou <chengming.zhou@linux.dev>,
        Christoph Hellwig <hch@lst.de>,
        "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
 <20230710075634.GA30120@lst.de>
 <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com>
 <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com>
 <20230710172839.GA7190@lst.de>
 <0F9A70B1-C6AE-4A8B-8A4B-8DC9ADED73AB@oracle.com>
 <20230711120137.GA27050@lst.de>
 <82cb9937-bd11-64a9-2520-bf3cf81ec720@linux.dev>
 <92CC9151-0309-41E9-920E-A549E2A73BE4@oracle.com>
 <5ce5b89e-3ea7-318a-1234-279ec92ffb8b@leemhuis.info>
 <73D6DC23-297A-4802-9925-1C94BB14FFF8@oracle.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <73D6DC23-297A-4802-9925-1C94BB14FFF8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690292083;5fa3955d;
X-HE-SMSGID: 1qOIBR-000258-7S
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25.07.23 15:21, Chuck Lever III wrote:
>> On Jul 25, 2023, at 5:57 AM, Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 12.07.23 15:29, Chuck Lever III wrote:
>>>> On Jul 12, 2023, at 7:34 AM, Chengming Zhou <chengming.zhou@linux.dev> wrote:
>>>> On 2023/7/11 20:01, Christoph Hellwig wrote:
>>>>> On Mon, Jul 10, 2023 at 05:40:42PM +0000, Chuck Lever III wrote:
>>
>> Chuck, what's the status here? This thread looks stalled, that's why I
>> wonder.
>>
>> FWIW, I noticed a commit with a Fixes: tag for your culprit in next (see
>> 28b24123747098 ("blk-flush: fix rq->flush.seq for post-flush
>> requests")). But unless I missed something you are not CCed, so I guess
>> that's a different issue?
> 
> This issue was fixed in 6.5-rc2 by commit
> 
> 9f87fc4d72f5 ("block: queue data commands from the flush state machine at the head")

Ahh, many thx for the update, it lacked a proper Link:/Closes: tag and
mentioned another culprit, so I had missed that!

#regzbot fix: 9f87fc4d72f5
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
