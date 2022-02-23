Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D004C1EAD
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 23:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiBWWgB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 17:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbiBWWfq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 17:35:46 -0500
Received: from cc-smtpout3.netcologne.de (cc-smtpout3.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8233B01D
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 14:35:14 -0800 (PST)
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
        by cc-smtpout3.netcologne.de (Postfix) with ESMTP id 2B3BB12320;
        Wed, 23 Feb 2022 23:35:12 +0100 (CET)
Received: from nas2.garloff.de (xdsl-89-0-168-136.nc.de [89.0.168.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA id 958B111E24;
        Wed, 23 Feb 2022 23:35:06 +0100 (CET)
Received: from [192.168.155.202] (unknown [192.168.155.10])
        by nas2.garloff.de (Postfix) with ESMTPSA id 132AEB3B131A;
        Wed, 23 Feb 2022 23:34:57 +0100 (CET)
Message-ID: <b1a248fc-b4d9-04cb-ff12-fadcde3ccc86@garloff.de>
Date:   Wed, 23 Feb 2022 23:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Content-Language: en-US
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
 <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
 <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
 <6401c5e1-8f05-5644-9bea-207640a21b77@garloff.de>
 <CAN-5tyHC0m8nLgEi89EdKUo-kpEWsi-LUNHqAXc=gBzW+u52NA@mail.gmail.com>
 <53040065-a88b-1b60-3430-27d2acd761b7@garloff.de>
 <CAN-5tyHToHJKoqc38ybp9+DMVdUrapu+4u0i7YMpG86ZQFOw5w@mail.gmail.com>
From:   Kurt Garloff <kurt@garloff.de>
In-Reply-To: <CAN-5tyHToHJKoqc38ybp9+DMVdUrapu+4u0i7YMpG86ZQFOw5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 958B111E24
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

On 23/02/2022 18:49, Olga Kornievskaia wrote:
> I have posted a patch where you can mount with "notrunkdiscovery" and
> that should fix the problem with the Qnap server?

I have not seen it, unfortunately,y

Care to copy me?

You have seen my patch that limits the
FS_LOCATIONS capability to NFS >= v4.2 and
I found this to be effective in making things
work again. Assuming that you check for
the mount parameter instead of the NFS version
to disable this feature, I would assume the
option to be effective. I'm happy to test
as soon as I get hold of the patch.

Thanks,

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany

