Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA24C2D7A
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 14:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiBXNnU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 08:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiBXNnT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 08:43:19 -0500
Received: from cc-smtpout2.netcologne.de (cc-smtpout2.netcologne.de [89.1.8.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E0175836
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 05:42:49 -0800 (PST)
Received: from cc-smtpin3.netcologne.de (cc-smtpin3.netcologne.de [89.1.8.203])
        by cc-smtpout2.netcologne.de (Postfix) with ESMTP id 85450127B4;
        Thu, 24 Feb 2022 14:42:46 +0100 (CET)
Received: from nas2.garloff.de (xdsl-89-0-167-237.nc.de [89.0.167.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin3.netcologne.de (Postfix) with ESMTPSA id BC5FC11E9E;
        Thu, 24 Feb 2022 14:42:42 +0100 (CET)
Received: from [192.168.155.203] (unknown [192.168.155.10])
        by nas2.garloff.de (Postfix) with ESMTPSA id 5C55BB3B131A;
        Thu, 24 Feb 2022 14:42:33 +0100 (CET)
Message-ID: <a494ba2b-7e2c-bcad-bac9-12804b113383@garloff.de>
Date:   Thu, 24 Feb 2022 14:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHy_+tBfv3PuD0CBwHbppHo3pRNwo0O9xRGjZxK0-rOjw@mail.gmail.com>
From:   Kurt Garloff <kurt@garloff.de>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
In-Reply-To: <CAN-5tyHy_+tBfv3PuD0CBwHbppHo3pRNwo0O9xRGjZxK0-rOjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: BC5FC11E9E
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

thanks!

I can confirm that after applying your patch (against 5.15.24),
passing the mount option notrunkdiscovery to NFS mount does
indeed make the NFS mounts from the Qnap server (with knfsd from
3.4.6 kernel) work again.

Sorry to say, but I don't think this is the final solution yet:
* The option notrunkdiscovery is not tolerated by older kernels,
   so there is no way to pass a setting that works with <= 5.15.23
   and the kernels with your latest patch. This is a problem for
   me who keeps automount maps in LDAP.
* From a user perspective, the 5.15.24+/5.6.10+/5.17-rc behavior
   is still a regression, as the Qnap NFS mounts all break. With
   your patch, there is a way to recover, but it needs to be well
   documented and then be found by an admin who then needs to do
   the right change. Not acceptable for -stable IMVHO and according
   to Greg's explanations not for mainline either.

I see a number of possibilities to resolve this:
(0) We pretend it's not a problem that's serious enough to take
     action (and ensure that we do document this new option well).
(1) We revert the patch that does FS_LOCATIONS discovery.
     Assuming that FS_LOCATIONS does provide a useful feature, this
     would not be our preferred solution, I guess ...
(2) We prevent NFS v4.1 servers to use FS_LOCATIONS (like my patch
     implements) and additionally allow for the opt-out with
     notrunkdiscovery mount option. This fixes the known regression
     with Qnap knfsd (without requiring user intervention) and still
     allows for FS_LOCATIONS to be useful with NFSv4.2 servers that
     support this. The disadvantage is that we won't use the feature
     on NFSv4.1 servers which might support this feature perfectly
     (and there's no opt-in possibility). And the risk is that there
     might be NFSv4.2 servers out there that also misreport
     FS_LOCATIONS support and still need manual intervention (which
     at least is possible with notrunkdiscovery).
(3) We make this feature an opt-in thing and require users to
     pass trunkdiscovery to take advantage of the feature.
     This has zero risk of breakage (unless we screw up the patch),
     but always requires user intervention to take advantage of
     the FS_LOCATIONS feature.
(4) Identify a way to recover from the mount with FS_LOCATIONS
     against the broken server, so instead of hanging we do just
     turn this off if we find it not to work. Disadavantage is that
     this adds complexity and might stall the mounting for a while
     until the recovery worked. The complexity bears the risk for
     us screwing up.

I personally find solutions 2 -- 4 acceptable.

If the experts see (4) as simple enough, it might be worth a try.
Otherwise (2) or (3) would seem the way to go from my perspective.

Thanks!

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany

