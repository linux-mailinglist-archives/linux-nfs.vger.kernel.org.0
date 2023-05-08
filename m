Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85086FA0CC
	for <lists+linux-nfs@lfdr.de>; Mon,  8 May 2023 09:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjEHHRa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 8 May 2023 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjEHHR3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 May 2023 03:17:29 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C66E75
        for <linux-nfs@vger.kernel.org>; Mon,  8 May 2023 00:17:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B617E62E1AA8;
        Mon,  8 May 2023 09:17:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kYDAX1brKomR; Mon,  8 May 2023 09:17:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 29CEE62E1AA1;
        Mon,  8 May 2023 09:17:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yQ7iuxx1gQVy; Mon,  8 May 2023 09:17:20 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0B1DC62E1A83;
        Mon,  8 May 2023 09:17:20 +0200 (CEST)
Date:   Mon, 8 May 2023 09:17:19 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     NeilBrown <neilb@suse.de>
Cc:     Steve Dickson <steved@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <585821338.5940345.1683530239813.JavaMail.zimbra@nod.at>
In-Reply-To: <168352657591.17279.393573102599959056.stgit@noble.brown>
References: <168352657591.17279.393573102599959056.stgit@noble.brown>
Subject: Re: [PATCH 0/2] Minor improvements for fsidd in nfs-utils
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Minor improvements for fsidd in nfs-utils
Thread-Index: RTRcS7MIwi/eLtL7GDy/7Dbaz3hI3Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Niel,

----- Ursprüngliche Mail -----
> Von: "NeilBrown" <neilb@suse.de>
> nfs-utils in openSUSE was recently updated to a version with fsidd and a
> routine security audit was performed.  No real security issues were
> found but a couple of oddities were highlighted.  The follow two patches
> propose ways to clean up these oddities.

Nice! TBH, the series got faster merged than expected. ;-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
