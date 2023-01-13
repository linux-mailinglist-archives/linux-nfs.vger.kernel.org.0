Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0265A6698A9
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 14:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbjAMNex (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 08:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbjAMNdw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 08:33:52 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE1E6355
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 05:27:11 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pGK5N-0001CT-RS; Fri, 13 Jan 2023 14:27:09 +0100
Message-ID: <e2d7f377-826a-53f3-eb0b-a160786155b3@leemhuis.info>
Date:   Fri, 13 Jan 2023 14:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: NFSD: refcount_t: underflow; use-after-free from nfsd_file_free
Content-Language: en-US, de-DE
To:     dai.ngo@oracle.com, Jeff Layton <jlayton@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <3c525b04-ef64-2bee-efc9-9a43069306f7@oracle.com>
 <830543ab-10e0-3a62-c683-8bd95292db4b@oracle.com>
 <a456ac8ccdb54f4d661fae5ef090d63d0bbcc690.camel@redhat.com>
 <445f3dbd-7fe0-b16d-227b-b545d6cf604c@oracle.com>
From:   "Linux kernel regression tracking (#update)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <445f3dbd-7fe0-b16d-227b-b545d6cf604c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673616432;3ae9cac0;
X-HE-SMSGID: 1pGK5N-0001CT-RS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 09.01.23 00:23, dai.ngo@oracle.com wrote:
> 
> On 1/8/23 2:23 AM, Jeff Layton wrote:
>> On Sat, 2023-01-07 at 14:04 -0800, dai.ngo@oracle.com wrote:
>>> Hi,
>>>
>>> This is a regression in 6.2.0-rc1.
>>>
>>> The problem can be reproduced with a simple test:
>>> . client mounts server's export using 4.1
>>> . client cats a file on server's export
>>> . on server stop nfs-server service
>>>
>>> Bisect points to commit ac3a2585f018 (nfsd: rework refcounting in
>>> filecache)
>>>
>>> -Dai
>>>
>>
>> This looks like the same problem that 789e1e10f214 ("nfsd: shut down the
>> NFSv4 state objects before the filecache") is intended to fix. That
>> patch was not in -rc1. Can you test a kernel that does have that patch
>> and let us know if it fixes this?
> 
> Sorry Jeff, it's my bad. This is fixed in 6.2-rc3.

In that case:

#regzbot fix: 789e1e10f214

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot ignore-activity
