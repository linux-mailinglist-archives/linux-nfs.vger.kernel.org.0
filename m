Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CFD7D7541
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 22:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjJYUNG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 25 Oct 2023 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYUNF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 16:13:05 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB395192
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 13:13:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AFB80622F589;
        Wed, 25 Oct 2023 22:13:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iN3NeRnDa_0H; Wed, 25 Oct 2023 22:13:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4A2D8622F58A;
        Wed, 25 Oct 2023 22:13:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vmC9xltJM6QH; Wed, 25 Oct 2023 22:13:01 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 23623622F589;
        Wed, 25 Oct 2023 22:13:01 +0200 (CEST)
Date:   Wed, 25 Oct 2023 22:13:00 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Message-ID: <857096093.3016.1698264780882.JavaMail.zimbra@nod.at>
In-Reply-To: <20231025194701.456031-1-pvorel@suse.cz>
References: <20231025194701.456031-1-pvorel@suse.cz>
Subject: Re: [PATCH 0/3] Add getrandom() fallback, cleanup headers
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add getrandom() fallback, cleanup headers
Thread-Index: Bpx3skmGDG7VX5pK6h7r55kvR0ekAA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Petr Vorel" <pvorel@suse.cz>
> I also wonder why getrandom() syscall does not called with GRND_NONBLOCK
> flag. Is it ok/needed to block?

With GRND_NONBLOCK it would return EAGAIN if not enough
randomness is ready. How to handle this then? Aborting the start of the daemon?

Before we other think the whole thing, the sole purpose of the getrandom()
call is seeding libc's PRNG with srand() to give every waiter a different
amount of sleep time upon concurrent database access.
See wait_for_dbaccess() and handling of SQLITE_LOCKED.

I'm pretty sure instead of seeding from getrandom() we can also use the current
time or read a few bytes from /dev/urandom.
Just make sure that every user of sqlite_plug_init() has a different seed.

Thanks,
//richard
