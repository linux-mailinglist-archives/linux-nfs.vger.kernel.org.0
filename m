Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C01507AFF
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Apr 2022 22:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357281AbiDSUeM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 19 Apr 2022 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346295AbiDSUeL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Apr 2022 16:34:11 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7B3C49E
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 13:31:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8D6006081106;
        Tue, 19 Apr 2022 22:31:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id t20bQAsDSYg2; Tue, 19 Apr 2022 22:31:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 282BA608110E;
        Tue, 19 Apr 2022 22:31:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ECkOwhtBt94M; Tue, 19 Apr 2022 22:31:23 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 000906081106;
        Tue, 19 Apr 2022 22:31:22 +0200 (CEST)
Date:   Tue, 19 Apr 2022 22:31:22 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Steve Dickson <steved@redhat.com>
Cc:     bfields <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <329205436.268224.1650400282779.JavaMail.zimbra@nod.at>
In-Reply-To: <b5c5de51-327e-ef27-b84e-e1bdffe8f43b@redhat.com>
References: <20220217131531.2890-1-richard@nod.at> <20220217163332.GA16497@fieldses.org> <1645735662.120362.1646645152190.JavaMail.zimbra@nod.at> <20220307222924.GD24816@fieldses.org> <b5c5de51-327e-ef27-b84e-e1bdffe8f43b@redhat.com>
Subject: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: nfs-utils: Improving NFS re-exports
Thread-Index: gA/RO51wMYdZOo9LUbzu5KdCBGFg+w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> On 3/7/22 5:29 PM, bfields wrote:
>> On Mon, Mar 07, 2022 at 10:25:52AM +0100, Richard Weinberger wrote:
>>> Did you find some cycles to think about which approach you prefer?
>> 
>> I haven't.  I'll try to take a look in the next couple days.  Thanks for
>> the reminder.
> 
> Is there any movement on this?? I would be good to have some
> for the upcoming Bakeathon... Next week.

I'm in the middle of preparing the next version of the series.

Thanks,
//richard
