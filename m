Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3300B6B66C5
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Mar 2023 14:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCLNgK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Sun, 12 Mar 2023 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCLNgJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Mar 2023 09:36:09 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C544D609
        for <linux-nfs@vger.kernel.org>; Sun, 12 Mar 2023 06:36:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 69925608F44F;
        Sun, 12 Mar 2023 14:36:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uGeCt6qYae-a; Sun, 12 Mar 2023 14:36:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 103006431C2E;
        Sun, 12 Mar 2023 14:36:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K9Uj0GS9JR3T; Sun, 12 Mar 2023 14:36:00 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E6068608F44F;
        Sun, 12 Mar 2023 14:36:00 +0100 (CET)
Date:   Sun, 12 Mar 2023 14:36:00 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <1826031117.236924.1678628160815.JavaMail.zimbra@nod.at>
In-Reply-To: <31643f88-26ec-515c-d1d6-fad951248a8c@redhat.com>
References: <1497292229.221220.1678287959937.JavaMail.zimbra@nod.at> <655a8ee6-dd94-effd-738a-9ce8db8ebed7@redhat.com> <156604342.233758.1678553565027.JavaMail.zimbra@nod.at> <31643f88-26ec-515c-d1d6-fad951248a8c@redhat.com>
Subject: Re: mountd: Possible bug in next_mnt()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mountd: Possible bug in next_mnt()
Thread-Index: EfoU6xyIS8clW2aTJGviTy1d/Tziyg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> On 3/11/23 11:52 AM, Richard Weinberger wrote:
>> ----- Ursprüngliche Mail -----
>>>> next_mnt() finds submounts below a given path p.
>>>> While investigating into an issue in my crossmount patches for nfs-utils I
>>>> noticed
>>>> that it does not work when fsid=root, rootdir=/some/path/ and then "/" is being
>>>> exported.
>>>> In this case next_mnt() is asked to find submounts of "/" but returns none.
>>> I'm not clear as what you are saying... "rootdir=/some/path/" is not an
>>> export option.
>> 
>> Sorry for being imprecise.
>> rootdir= is an nfs.conf exports option.Point. But I still need the patch in the
>> correct
> format with the Signed-off-by...

Well, the goal of my mail was not sending a ready-to-apply patch.
It was a question. To me next_mnt() looks wrong but I'm not sure whether
the current handling of "/" is desired for some special case I'm not aware of.

I'll happily send a patch after we agree that next_mnt() is wrong.

Thanks,
//richard

