Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AEA6E64A3
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjDRMvK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 18 Apr 2023 08:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjDRMvJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 08:51:09 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D5416DEE
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 05:50:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B375763CC168;
        Tue, 18 Apr 2023 14:50:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DxISwoef9APb; Tue, 18 Apr 2023 14:50:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 50C5A6431C34;
        Tue, 18 Apr 2023 14:50:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lesqXc_pH0u4; Tue, 18 Apr 2023 14:50:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2418963CC168;
        Tue, 18 Apr 2023 14:50:45 +0200 (CEST)
Date:   Tue, 18 Apr 2023 14:50:44 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <487745654.155712.1681822244964.JavaMail.zimbra@nod.at>
In-Reply-To: <c43a2268-3a12-2eeb-9cb2-6b01f5a225ef@redhat.com>
References: <20230404111308.23465-1-richard@nod.at> <c43a2268-3a12-2eeb-9cb2-6b01f5a225ef@redhat.com>
Subject: Re: [PATCH 0/2 v2 RESEND] nfs-utils: Improving NFS re-export wrt.
 crossmnt
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: nfs-utils: Improving NFS re-export wrt. crossmnt
Thread-Index: Rjlx6436CLEYg43551XLZfeZdbBvTw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Steve Dickson" <steved@redhat.com>
> My apologies for taking so long to get to this!

No problem. :-)

> These patch does not apply cleanly on Chuck's TLS patches,
> not something you could have voided and the fix
> is minor...  But!
> 
> Then the first patch does not compile without
> the second patch due to a missing header file.
> 
> When the second patch is applied the compile
> breaks in exportd code:
>    make[2]: *** No rule to make target
> '../support/reexport/libreexport.a', needed by 'exportd'.  Stop.
> 
> The first patch is way to big for debugging and reading... IMO.
> 
> Maybe the exportd, exportfs, and mount changes be put
> in their own patches and maybe the reexport command
> can be separated out from the rest of support/ changes
> although that might be more difficult.
> 
> Not clear how you can break up the second patch other
> than moving reexport_backend.h into the first patch
> so it compiles...
> 
> I just committed Chuck's TLS patch (tag: nfs-utils-2-6-3-rc8)
> So if you could rebase your patches to the head of my repo
> that would great, with the above changes.

I just rebased the whole series and spitted into multiple patches.
Every single patch builds now, sorry for that.
 
> I'll be very motivate get these changes in for the
> upcoming virtual bakeathon starting a week from
> Monday (Apr 24). The detail are here [1]...
> 
> I'm hopeful you will be attending and setting a server
> for us to test against.

I'll try hard to attend! :-)

Thanks,
//richard
