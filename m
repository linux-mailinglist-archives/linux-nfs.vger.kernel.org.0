Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633867D74F2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 21:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYT5F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 25 Oct 2023 15:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjJYT5C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 15:57:02 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2C4199
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 12:56:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AAFBD622F58A;
        Wed, 25 Oct 2023 21:56:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UGBbq78KcShG; Wed, 25 Oct 2023 21:56:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4EEF8623488E;
        Wed, 25 Oct 2023 21:56:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mI-h2KQdF8Ke; Wed, 25 Oct 2023 21:56:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2CE5A622F58A;
        Wed, 25 Oct 2023 21:56:54 +0200 (CEST)
Date:   Wed, 25 Oct 2023 21:56:53 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Message-ID: <733457095.2959.1698263813891.JavaMail.zimbra@nod.at>
In-Reply-To: <20231025194701.456031-3-pvorel@suse.cz>
References: <20231025194701.456031-1-pvorel@suse.cz> <20231025194701.456031-3-pvorel@suse.cz>
Subject: Re: [PATCH 2/3] support/reexport.c: Remove unused headers
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: support/reexport.c: Remove unused headers
Thread-Index: cM5myqdd0Jpxyv6QzpTF00KdeWK8pQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Petr Vorel" <pvorel@suse.cz>
> An: "linux-nfs" <linux-nfs@vger.kernel.org>
> CC: "Petr Vorel" <pvorel@suse.cz>, "richard" <richard@nod.at>, "Steve Dickson" <steved@redhat.com>
> Gesendet: Mittwoch, 25. Oktober 2023 21:47:00
> Betreff: [PATCH 2/3] support/reexport.c: Remove unused headers

> Some of them are needed but included elsewhere, e.g. <sys/socket.h>
> included in nfslib.h or <string.h> included in xcommon.h, but at least
> <sys/random.h> is removed due further code simplification.
> 
> Fixes: 878674b3 ("Add reexport helper library")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
