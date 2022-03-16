Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869A34DAFE0
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 13:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355784AbiCPMku (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 08:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355785AbiCPMkq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 08:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECDD866200
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647434371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQbeNKYm8k5Yw7AFnf6GBz5Tkwp0/EraKHqLpaxy5HA=;
        b=ZJWP2DLpdwYs6orj67OTad/yFy7DW6iAGIHca+fX5QMVrLu+WUFF+fTksqC9EOXZCX5cBd
        mQy7IWRbQwWLnXwZ5deAESvnea2yVpw0XaBAd3ZKveBElLGRI3HnOST43m+mv5GBpoCXjX
        hq35YhGt3LWD06W6SeVzsCJ+WJBEBF0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-ITzl8SuROPmyctZa_rEMSg-1; Wed, 16 Mar 2022 08:39:30 -0400
X-MC-Unique: ITzl8SuROPmyctZa_rEMSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F322738035BD;
        Wed, 16 Mar 2022 12:39:29 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE10B40D2820;
        Wed, 16 Mar 2022 12:39:29 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Kurt Garloff" <kurt@garloff.de>
Cc:     "Olga Kornievskaia" <olga.kornievskaia@gmail.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
Date:   Wed, 16 Mar 2022 08:39:29 -0400
Message-ID: <8849D8CD-0720-40E2-A752-1C9AADC93C55@redhat.com>
In-Reply-To: <B476B883-D5D4-4112-BB08-6D9172C5D335@garloff.de>
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHy_+tBfv3PuD0CBwHbppHo3pRNwo0O9xRGjZxK0-rOjw@mail.gmail.com>
 <a494ba2b-7e2c-bcad-bac9-12804b113383@garloff.de>
 <B476B883-D5D4-4112-BB08-6D9172C5D335@garloff.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25 Feb 2022, at 17:48, Kurt Garloff wrote:

> Hi,
>
> Am 24. Februar 2022 14:42:41 MEZ schrieb Kurt Garloff <kurt@garloff.de>:
>> Hi Olga,
>> [...]
>>
>> I see a number of possibilities to resolve this:
>> (0) We pretend it's not a problem that's serious enough to take
>>     action (and ensure that we do document this new option well).
>> (1) We revert the patch that does FS_LOCATIONS discovery.
>>     Assuming that FS_LOCATIONS does provide a useful feature, this
>>     would not be our preferred solution, I guess ...
>> (2) We prevent NFS v4.1 servers to use FS_LOCATIONS (like my patch
>>     implements) and additionally allow for the opt-out with
>>     notrunkdiscovery mount option. This fixes the known regression
>>     with Qnap knfsd (without requiring user intervention) and still
>>     allows for FS_LOCATIONS to be useful with NFSv4.2 servers that
>>     support this. The disadvantage is that we won't use the feature
>>     on NFSv4.1 servers which might support this feature perfectly
>>     (and there's no opt-in possibility). And the risk is that there
>>     might be NFSv4.2 servers out there that also misreport
>>     FS_LOCATIONS support and still need manual intervention (which
>>     at least is possible with notrunkdiscovery).
>> (3) We make this feature an opt-in thing and require users to
>>     pass trunkdiscovery to take advantage of the feature.
>>     This has zero risk of breakage (unless we screw up the patch),
>>     but always requires user intervention to take advantage of
>>     the FS_LOCATIONS feature.
>> (4) Identify a way to recover from the mount with FS_LOCATIONS
>>     against the broken server, so instead of hanging we do just
>>     turn this off if we find it not to work. Disadavantage is that
>>     this adds complexity and might stall the mounting for a while
>>     until the recovery worked. The complexity bears the risk for
>>     us screwing up.
>>
>> I personally find solutions 2 -- 4 acceptable.
>>
>> If the experts see (4) as simple enough, it might be worth a try.
>> Otherwise (2) or (3) would seem the way to go from my perspective.
>
> Any thought ls?

I think (3) is the best way, and perhaps using sysfs to toggle it would
be a solution to the problems presented by a mount option.

I'm worried that this issue is being ignored because that's usually what
happens when requests/patches are proposed that violate the policy of "we do
not fix the client for server bugs".  In this case that policy conficts with
"no user visible regressions".

Can anyone declare which policy takes precedent?

Ben

