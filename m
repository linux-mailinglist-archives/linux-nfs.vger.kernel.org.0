Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58814BD251
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Feb 2022 23:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiBTWfM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Feb 2022 17:35:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbiBTWfL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Feb 2022 17:35:11 -0500
X-Greylist: delayed 489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Feb 2022 14:34:49 PST
Received: from cc-smtpout2.netcologne.de (cc-smtpout2.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B454C40F
        for <linux-nfs@vger.kernel.org>; Sun, 20 Feb 2022 14:34:48 -0800 (PST)
Received: from cc-smtpin3.netcologne.de (cc-smtpin3.netcologne.de [89.1.8.203])
        by cc-smtpout2.netcologne.de (Postfix) with ESMTP id EE8FA125B5;
        Sun, 20 Feb 2022 23:26:35 +0100 (CET)
Received: from nas2.garloff.de (xdsl-89-0-244-240.nc.de [89.0.244.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin3.netcologne.de (Postfix) with ESMTPSA id 77DD211DDF;
        Sun, 20 Feb 2022 23:26:32 +0100 (CET)
Received: from [192.168.155.16] (unknown [192.168.155.10])
        by nas2.garloff.de (Postfix) with ESMTPSA id 18CB9B3B0027;
        Sun, 20 Feb 2022 23:26:24 +0100 (CET)
Message-ID: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
Date:   Sun, 20 Feb 2022 23:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Olga Kornievskaia <kolga@netapp.com>
From:   Kurt Garloff <kurt@garloff.de>
Subject: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
Cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 77DD211DDF
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

your upstream commit 1976b2b3, applied to 5.15.24 as 6f283634 breaks NFS
for me.

This is while mounting many NFS filesystems from two NFS servers, one
Qnap (nfs v4.1) and one linux 5.15.16 knfsd (nfs v4.2).

The NFS mounts just would not succeed. This appears to happen to all
Qnap mounts and one of the mounts from the linux knfsd.

I did some bisecting in 5.15.24 ... reverting 6f283634 and subsequent
NFS/sunRPC patches from you and Xiyu, Anna did the trick to recover from
this failure.
To be precise: I reverted 4403233b 4b22aa42 5ca123c9 c5ae18fa be67be6a
6f283634 2df6a47a 0c5d3bfb 3cb5b317 58967a23 bbf647ec and 38ae9387 in
5.15.24. I started reenabling and 2df6aa647a is the last patch that
still results a working NFS for me.

Looking at the culprit patch, I could not immediately see what's wrong
-- so I'll leave it to you. I guess the server does not return
fs_locations in the way it's expected and thus the NFS mount hangs.

I seem not to be the only one, see
https://bbs.archlinux.org/viewtopic.php?pid=2022938
https://bugs.archlinux.org/task/73860

HTH,

-- 
Kurt Garloff <kurt@garloff.de>
