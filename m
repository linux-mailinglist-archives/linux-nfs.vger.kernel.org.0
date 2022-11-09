Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D2E622F64
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Nov 2022 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKIPyD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Nov 2022 10:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKIPyC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Nov 2022 10:54:02 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CCF11C36
        for <linux-nfs@vger.kernel.org>; Wed,  9 Nov 2022 07:54:01 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1osnOq-0004Vb-3d; Wed, 09 Nov 2022 16:54:00 +0100
Message-ID: <a6168d8c-b991-478f-ada6-46cc4068543d@leemhuis.info>
Date:   Wed, 9 Nov 2022 16:53:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge #forregzbot
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev
Cc:     linux-nfs@vger.kernel.org
References: <20221031154921.500620-1-jlayton@kernel.org>
 <Y2WCdDAGt1OEFzL7@pevik>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y2WCdDAGt1OEFzL7@pevik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668009241;110d168f;
X-HE-SMSGID: 1osnOq-0004Vb-3d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

On 04.11.22 22:21, Petr Vorel wrote:
> Hi all,
> 
>> If the namespace doesn't match the one in "net", then we'll continue,
>> but that doesn't cause another rhashtable_walk_next call, so it will
>> loop infinitely.
> 
>> Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
> 
> Adding this to regression tracker.
> https://linux-regtracking.leemhuis.info/tracked-regression/
> 
> #regzbot ^introduced ce502f81ba88
> #regzbot ignore-activity

#regzbot fixed-by: d3aefd2b29ff5
