Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD54C51BD
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 23:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiBYWtb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 25 Feb 2022 17:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYWtb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 17:49:31 -0500
Received: from cc-smtpout3.netcologne.de (cc-smtpout3.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49481AE679
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 14:48:57 -0800 (PST)
Received: from cc-smtpin3.netcologne.de (cc-smtpin3.netcologne.de [89.1.8.203])
        by cc-smtpout3.netcologne.de (Postfix) with ESMTP id 07BFA12491;
        Fri, 25 Feb 2022 23:48:54 +0100 (CET)
Received: from nas2.garloff.de (xdsl-89-0-252-109.nc.de [89.0.252.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin3.netcologne.de (Postfix) with ESMTPSA id 44B3C11DF5;
        Fri, 25 Feb 2022 23:48:49 +0100 (CET)
Received: from [IPv6:::1] (tmo-085-40.customers.d1-online.com [80.187.85.40])
        by nas2.garloff.de (Postfix) with ESMTPSA id BC28FB3B131A;
        Fri, 25 Feb 2022 23:48:38 +0100 (CET)
Date:   Fri, 25 Feb 2022 23:48:46 +0100
From:   Kurt Garloff <kurt@garloff.de>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
CC:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1=5D_NFSv4=2E1_provide_mount?= =?US-ASCII?Q?_option_to_toggle_trunking_discovery?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a494ba2b-7e2c-bcad-bac9-12804b113383@garloff.de>
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com> <CAN-5tyHy_+tBfv3PuD0CBwHbppHo3pRNwo0O9xRGjZxK0-rOjw@mail.gmail.com> <a494ba2b-7e2c-bcad-bac9-12804b113383@garloff.de>
Message-ID: <B476B883-D5D4-4112-BB08-6D9172C5D335@garloff.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 44B3C11DF5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, 

Am 24. Februar 2022 14:42:41 MEZ schrieb Kurt Garloff <kurt@garloff.de>:
>Hi Olga,
>[...] 
>
>I see a number of possibilities to resolve this:
>(0) We pretend it's not a problem that's serious enough to take
>     action (and ensure that we do document this new option well).
>(1) We revert the patch that does FS_LOCATIONS discovery.
>     Assuming that FS_LOCATIONS does provide a useful feature, this
>     would not be our preferred solution, I guess ...
>(2) We prevent NFS v4.1 servers to use FS_LOCATIONS (like my patch
>     implements) and additionally allow for the opt-out with
>     notrunkdiscovery mount option. This fixes the known regression
>     with Qnap knfsd (without requiring user intervention) and still
>     allows for FS_LOCATIONS to be useful with NFSv4.2 servers that
>     support this. The disadvantage is that we won't use the feature
>     on NFSv4.1 servers which might support this feature perfectly
>     (and there's no opt-in possibility). And the risk is that there
>     might be NFSv4.2 servers out there that also misreport
>     FS_LOCATIONS support and still need manual intervention (which
>     at least is possible with notrunkdiscovery).
>(3) We make this feature an opt-in thing and require users to
>     pass trunkdiscovery to take advantage of the feature.
>     This has zero risk of breakage (unless we screw up the patch),
>     but always requires user intervention to take advantage of
>     the FS_LOCATIONS feature.
>(4) Identify a way to recover from the mount with FS_LOCATIONS
>     against the broken server, so instead of hanging we do just
>     turn this off if we find it not to work. Disadavantage is that
>     this adds complexity and might stall the mounting for a while
>     until the recovery worked. The complexity bears the risk for
>     us screwing up.
>
>I personally find solutions 2 -- 4 acceptable.
>
>If the experts see (4) as simple enough, it might be worth a try.
>Otherwise (2) or (3) would seem the way to go from my perspective.

Any thought ls? 

Thanks, 

-- 
Kurt Garloff <kurt@garloff.de>, Cologne, Germany
(Sent from Mobile with K9.)
