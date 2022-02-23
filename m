Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34704C1E6D
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 23:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbiBWWZV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 17:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiBWWZT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 17:25:19 -0500
Received: from cc-smtpout2.netcologne.de (cc-smtpout2.netcologne.de [89.1.8.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42443DA67
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 14:24:50 -0800 (PST)
Received: from cc-smtpin3.netcologne.de (cc-smtpin3.netcologne.de [89.1.8.203])
        by cc-smtpout2.netcologne.de (Postfix) with ESMTP id 6EC2512661;
        Wed, 23 Feb 2022 23:24:48 +0100 (CET)
Received: from nas2.garloff.de (xdsl-89-0-168-136.nc.de [89.0.168.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin3.netcologne.de (Postfix) with ESMTPSA id 8331311DC2;
        Wed, 23 Feb 2022 23:24:42 +0100 (CET)
Received: from [192.168.155.202] (unknown [192.168.155.10])
        by nas2.garloff.de (Postfix) with ESMTPSA id 083AAB3B131A;
        Wed, 23 Feb 2022 23:24:33 +0100 (CET)
Message-ID: <691bc46a-637c-5bc7-add9-d6da2f429750@garloff.de>
Date:   Wed, 23 Feb 2022 23:24:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Greg Kroah-Hartman <greg@kroah.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
 <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
 <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
 <6401c5e1-8f05-5644-9bea-207640a21b77@garloff.de>
 <CAN-5tyG+CiPVi=wQDvMp0rWyt9TgCYnb_1_g_TYQSrxEFz7sAw@mail.gmail.com>
From:   Kurt Garloff <kurt@garloff.de>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
In-Reply-To: <CAN-5tyG+CiPVi=wQDvMp0rWyt9TgCYnb_1_g_TYQSrxEFz7sAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 8331311DC2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

On 23/02/2022 18:56, Olga Kornievskaia wrote:
> On Wed, Feb 23, 2022 at 8:20 AM Kurt Garloff <kurt@garloff.de> wrote:
>> Hi Olga,
>>
>> any updates? Were you able to investigate the traces?
>>
>> Breaking NFS mounts from Qnap (knfsd with 3.4.6 kernel here,
>> though Qnap might have patched it),is not something that
>> should happen with a -stable kernel update, even if the problem
>> would be on the Qnap side, which would not be completely
>> surprising.
>>
>> So I think we should revert this patch at least for -stable,
>> unless we understand what's going on and have a better fix
>> than a plain revert.
> I haven't commented on your ask of requesting a revert in the stable
> version. I'm not sure what the philosophy there. I don't see why we
> can't ask for this feature to only be available from the kernel
> version it has been accepted into and not before. If you think the
> kernel version that you want to use will always be before this feature
> was accepted, then asking folks responsible for "stable" kernels seems
> like a good idea. At the time of inclusion to stable, I wasn't aware
> of the broken legacy server implementations out there.

I guess Greg would need to comment on the detailed policies
for stable kernels.
One of the goals for sure is to avoid regressions. If that causes
bugs not to be fixable or features not to be available, than that's
a price that might need to be accepted. A regression is just many many
times worse than an unfixed issue, twice so for something that claims
to be stable.

So, if we are relatively sure that no NFSv4.2 server has the
kernel-3.4.6-knfsd Qnap (NFSv4.1) misbehavior, my change that masks the
new features for NFS<v4.2 might be what makes this patch acceptable
for stable. Otherwise, we should either revert it or make it
opt-in. The latter is not really a good idea if we then differ
from the main branch where we might go for an opt-out solution.
So maybe it's opt-out for main branch and for stable with an
additional guard against NFS<v4.2 at least for -stable.

Just my 0.02€.

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany


