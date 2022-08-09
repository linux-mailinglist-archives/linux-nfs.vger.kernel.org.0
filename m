Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC058E326
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Aug 2022 00:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiHIWXI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 18:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHIWXH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 18:23:07 -0400
Received: from smtpcmd04135.aruba.it (smtpcmd04135.aruba.it [62.149.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB91E5D0C5
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 15:23:06 -0700 (PDT)
Received: from [192.168.8.155] ([86.32.63.136])
        by Aruba Outgoing Smtp  with ESMTPSA
        id LXcvomt5OVH2DLXcvo1gL6; Wed, 10 Aug 2022 00:23:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660083785; bh=px/hTelzb0pD7QKy2s3H5ZnBzpUwk6Ns4qMVbZ2sWqo=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=RXocDfkoZ9Ku1iAiVk3h9XtFaX5+gkPelbLbpXa9AZuw55dnZJ74eoeJVCml6lWmc
         WNdp307o9eWxg1UaciqBfKHbDTiH+CXuzw6QmiLRFgTN+QUxvGOw5Iz5/SgAExDGb0
         nYpLqhF72voo/FMqe4J/2jdGFy8qOYnqBSRU9wG1r69DQgSzeJsOUnKJwCz8IAUGnD
         sgUlN98aVcsA3ZJNbFjisDnlFaMVn5W0Qw6/vfqTpoNvnXHonhc2v6yddOaoxpdzSi
         UvuVVPt/bGqxlwrpc/GIe1MRX00YBCo/p0v3/h3Q0UKXZHLvDmRBlJsAchDfIUy0l7
         V3oLmlyhtuw0Q==
Message-ID: <ee93061b-c40f-249f-42ef-9c4c1238139b@benettiengineering.com>
Date:   Wed, 10 Aug 2022 00:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] nfsrahead: fix linking while static linking
To:     linux-nfs@vger.kernel.org
References: <20220809221252.772891-1-giulio.benetti@benettiengineering.com>
Content-Language: en-US
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20220809221252.772891-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAlczc4vE4pJVri8inikscyGjgXZXMNJMgsjy3O1ye7DxWIAgBlmq2RpujFO2p55s0hIFVeKLYEiQqcDdsNQXjPBueJbu984qERwXT80BQ2cECiVoD/X
 TxFwEl9slQsqDP6TLQJKJLjD4iA2JGrljYFw/XDvWm0JPwKfIYhcp70QOBDgztkl1PktPF3leS/p9PD+eJzGohRiODnQuDiEcJaIv4FqCxG+BUKIvOnuiYXq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Pardon, s/pkg-conf/pkg-config

I'm going to send V2

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

On 10/08/22 00:12, Giulio Benetti wrote:
> -lmount must preceed -lblkid and to obtain this let's add:
> `pkg-conf --libs mount`
> in place of:
> `-lmount`
> This ways the library order will always be correct.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>   tools/nfsrahead/Makefile.am | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
> index 845ea0d5..74fc344f 100644
> --- a/tools/nfsrahead/Makefile.am
> +++ b/tools/nfsrahead/Makefile.am
> @@ -1,6 +1,6 @@
>   libexec_PROGRAMS = nfsrahead
>   nfsrahead_SOURCES = main.c
> -nfsrahead_LDFLAGS= -lmount
> +nfsrahead_LDFLAGS= `pkg-conf --libs mount`
>   nfsrahead_LDADD = ../../support/nfs/libnfsconf.la
>   
>   man5_MANS = nfsrahead.man

