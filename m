Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E00760FF7
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjGYJ6I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjGYJ6G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 05:58:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD1910F8;
        Tue, 25 Jul 2023 02:57:58 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qOEni-0000Af-Ig; Tue, 25 Jul 2023 11:57:54 +0200
Message-ID: <5ce5b89e-3ea7-318a-1234-279ec92ffb8b@leemhuis.info>
Date:   Tue, 25 Jul 2023 11:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: NFS workload leaves nfsd threads in D state
Content-Language: en-US, de-DE
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Christoph Hellwig <hch@lst.de>,
        "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
 <20230710075634.GA30120@lst.de>
 <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com>
 <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com>
 <20230710172839.GA7190@lst.de>
 <0F9A70B1-C6AE-4A8B-8A4B-8DC9ADED73AB@oracle.com>
 <20230711120137.GA27050@lst.de>
 <82cb9937-bd11-64a9-2520-bf3cf81ec720@linux.dev>
 <92CC9151-0309-41E9-920E-A549E2A73BE4@oracle.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <92CC9151-0309-41E9-920E-A549E2A73BE4@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690279078;391d52a8;
X-HE-SMSGID: 1qOEni-0000Af-Ig
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12.07.23 15:29, Chuck Lever III wrote:
>> On Jul 12, 2023, at 7:34 AM, Chengming Zhou <chengming.zhou@linux.dev> wrote:
>> On 2023/7/11 20:01, Christoph Hellwig wrote:
>>> On Mon, Jul 10, 2023 at 05:40:42PM +0000, Chuck Lever III wrote:
>>>>> blk_rq_init_flush(rq);
>>>>> - rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
>>>>> + rq->flush.seq |= REQ_FSEQ_PREFLUSH;
>>>>> spin_lock_irq(&fq->mq_flush_lock);
>>>>> list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
>>>>> spin_unlock_irq(&fq->mq_flush_lock);
>>>>
>>>> Thanks for the quick response. No change.
>>> I'm a bit lost and still can't reprodce.  Below is a patch with the
>>> only behavior differences I can find.  It has two "#if 1" blocks,
>>> which I'll need to bisect to to find out which made it work (if any,
>>> but I hope so).
>>
>> I tried today to reproduce, but can't unfortunately.
>>
>> Could you please also try the fix patch [1] from Ross Lagerwall that fixes
>> IO hung problem of plug recursive flush?
>>
>> (Since the main difference is that post-flush requests now can go into plug.)
>>
>> [1] https://lore.kernel.org/all/20230711160434.248868-1-ross.lagerwall@citrix.com/
> 
> Thanks for the suggestion. No change, unfortunately.

Chuck, what's the status here? This thread looks stalled, that's why I
wonder.

FWIW, I noticed a commit with a Fixes: tag for your culprit in next (see
28b24123747098 ("blk-flush: fix rq->flush.seq for post-flush
requests")). But unless I missed something you are not CCed, so I guess
that's a different issue?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
