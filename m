Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668C4BAAA9
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiBQUP4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 17 Feb 2022 15:15:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiBQUPz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 15:15:55 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268E8093C
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 12:15:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ECF9760765A1;
        Thu, 17 Feb 2022 21:15:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5DGmGCF3v2Jv; Thu, 17 Feb 2022 21:15:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 66DCE605DEB4;
        Thu, 17 Feb 2022 21:15:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BLLgA6u8Lk_4; Thu, 17 Feb 2022 21:15:38 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3B02F608898A;
        Thu, 17 Feb 2022 21:15:38 +0100 (CET)
Date:   Thu, 17 Feb 2022 21:15:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <245552734.60874.1645128938141.JavaMail.zimbra@nod.at>
In-Reply-To: <20220217192726.GB16497@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at> <20220217163332.GA16497@fieldses.org> <1525788049.60261.1645118835162.JavaMail.zimbra@nod.at> <20220217192726.GB16497@fieldses.org>
Subject: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: nfs-utils: Improving NFS re-exports
Thread-Index: Wp0kIE3Tr2IMSmT4Eb45TCd4l8Xd8w==
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
>> Which one do you prefer?
>> "predefined-fsidnum" should be the safest one to start.
> 
> I don't know!  I'll have to do some more reading and think about it.

No need to worry, take your time.
 
>> > Setting the timeout to 0 doesn't help with re-export server reboots.
>> > After a reboot is another case where we could end up in a situation
>> > where a client hands us a filehandle for a filesystem that isn't mounted
>> > yet.
>> > 
>> > I think you want to keep a path with each entry in the database.  When
>> > mountd gets a request for a filesystem it hasn't seen before, it stats
>> > that path, which should trigger the automounts.
>> 
>> I have implemented that already. This feature is part of this series. :-)
> 
> Oh, good, got it.  It'll take me some time to catch up.

The reason why setting the timeout to 0 is still needed is because
when mountd uncovers a subvolume but no client uses it a filehandle,
it is not locked and can be unmounted later.
Only when nfsd sees a matching filehandle the reference counter will
be increased and umounting is no longer possible.

Thanks,
//richard
