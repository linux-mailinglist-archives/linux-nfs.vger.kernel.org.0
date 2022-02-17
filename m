Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43D34BAB11
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 21:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbiBQU35 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 17 Feb 2022 15:29:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343662AbiBQU34 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 15:29:56 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B816C332B
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 12:29:41 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EE12060765A1;
        Thu, 17 Feb 2022 21:29:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m1OHZKLnaUQ8; Thu, 17 Feb 2022 21:29:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8546F60765A3;
        Thu, 17 Feb 2022 21:29:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lh1UrxI_x2vk; Thu, 17 Feb 2022 21:29:39 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5231D60765A1;
        Thu, 17 Feb 2022 21:29:39 +0100 (CET)
Date:   Thu, 17 Feb 2022 21:29:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <2117074981.60920.1645129779132.JavaMail.zimbra@nod.at>
In-Reply-To: <20220217201805.GC16497@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at> <20220217163332.GA16497@fieldses.org> <1525788049.60261.1645118835162.JavaMail.zimbra@nod.at> <20220217192726.GB16497@fieldses.org> <245552734.60874.1645128938141.JavaMail.zimbra@nod.at> <20220217201805.GC16497@fieldses.org>
Subject: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: nfs-utils: Improving NFS re-exports
Thread-Index: q1XuzeijnZKTn+gLIFFS3/xbKp+siQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "bfields" <bfields@fieldses.org>
>> The reason why setting the timeout to 0 is still needed is because
>> when mountd uncovers a subvolume but no client uses it a filehandle,
>> it is not locked and can be unmounted later.
>> Only when nfsd sees a matching filehandle the reference counter will
>> be increased and umounting is no longer possible.
> 
> I understand that.  But, then if a client comes in with a matching
> filehandle, mountd should be able to look up the filesystem and trigger
> a new mount, right?

This does not match what I saw in my experiments. The handle machted only
when the subvolume was mounted before.
But I understand now your point, in theory it should work.
I'll investigate into this.

Thanks,
//richard
