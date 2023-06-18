Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663E7345DB
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jun 2023 12:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjFRKka (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Jun 2023 06:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRKk3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Jun 2023 06:40:29 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684ADE60;
        Sun, 18 Jun 2023 03:40:25 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qAppU-0005HL-1I; Sun, 18 Jun 2023 12:40:20 +0200
Message-ID: <d698b838-57e0-d019-a783-c229c04eeca4@leemhuis.info>
Date:   Sun, 18 Jun 2023 12:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To:     Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        stable@vger.kernel.org, Eirik Fuller <efuller@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230616191744.202292-1-jlayton@kernel.org>
 <ZIzFp3ViiU2SCi6J@manet.1015granger.net>
 <4b5063eb5a1139adc9dd4bdadde30674faee0700.camel@kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] nfsd: move init of percpu reply_cache_stats counters back
 to nfsd_init_net
In-Reply-To: <4b5063eb5a1139adc9dd4bdadde30674faee0700.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687084825;3626a0dc;
X-HE-SMSGID: 1qAppU-0005HL-1I
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16.06.23 22:54, Jeff Layton wrote:
> On Fri, 2023-06-16 at 16:27 -0400, Chuck Lever wrote:
>> Thanks Eirik and Jeff.
>>
>> At this point in the release cycle, I plan to apply this for the
>> next merge window (6.5).
> 
> I think we should take this in sooner. This is a regression and a
> user-triggerable oops in the right situation. If:
> 
> - non-x86_64 arch
> - /proc/fs/nfsd is mounted in the namespace
> - nfsd is not started in the namespace
> - unprivileged user calls "cat /proc/fs/nfsd/reply_cache_stats"

FWIW, might be worth to simply tell Linus about it and let him decide,
that's totally fine and even documented in the old and the new docs for
handling regressions[1].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/process/handling-regressions.rst?id=eed892da9cd08be76a8f467c600ef58716dbb4d2

>>> Cc: stable@vger.kernel.org # v6.3+
>>> Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nfsd startup")
>>
>> Why both Fixes: and Cc: stable?
> 
> *shrug* : they mean different things. I can drop the Cc stable.

Please leave it, only a stable tag ensures backporting; a fixes tag
alone is not enough. See [1] above or these recent messages from Greg:

https://lore.kernel.org/all/2023061137-algorithm-almanac-1337@gregkh/
https://lore.kernel.org/all/2023060703-colony-shakily-3514@gregkh/

Ciao, Thorsten
