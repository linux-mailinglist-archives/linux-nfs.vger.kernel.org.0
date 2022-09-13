Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952725B775A
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiIMRIM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiIMRHq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 13:07:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2605F90C42
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 08:57:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C471734C42;
        Tue, 13 Sep 2022 15:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663084617;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kM3oceWYTwXTJ87wjVgDRLcrCQPzSh85+zwy7HneCf4=;
        b=m33h3znXFM9TSHWseB0uxOW2zHuQJsOzS1fSH6vKaCeRz+EK5OOFYM1/ykhHXvA9U0+252
        P2hx6xhsK64Dn16gbPCkH8BRKbaZD3T7+B7feSnB7ldjVuV5CAKKr6Tmvv1KVXh1lg4bXE
        6xuR0TnaUzy23xthu0yjYMCiy3Pqu+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663084617;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kM3oceWYTwXTJ87wjVgDRLcrCQPzSh85+zwy7HneCf4=;
        b=UwJ9mJjToZcLkvzIg28jeXFQWrXWklE9qJh5FNdjqtfMNPKHCicm0CZMOpKW1IyfQagNfM
        VEVq0ZdA8EaIDdCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 977D6139B3;
        Tue, 13 Sep 2022 15:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qwwZIkmoIGNlYgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 15:56:57 +0000
Date:   Tue, 13 Sep 2022 17:56:55 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Steve Dickson <steved@redhat.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] nfsrahead: fix linking while static linking
Message-ID: <YyCoRz6FfHgnCnmw@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YvVkftYtIgFhYHKk@pevik>
 <881E6E82-812C-4BD8-849C-4DEE484AE4F0@benettiengineering.com>
 <12ece17b-b2d9-6621-0af7-26a12470bc99@redhat.com>
 <21969dec-4bbe-94ae-b317-1bc12300d6ca@benettiengineering.com>
 <42980d60-3b6d-4479-8c1a-a5fd7ba30f4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42980d60-3b6d-4479-8c1a-a5fd7ba30f4c@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On 8/22/22 4:33 PM, Giulio Benetti wrote:
> > Hi Steve, Petr,

> > On 22/08/22 21:17, Steve Dickson wrote:


> > > On 8/11/22 4:36 PM, Giulio Benetti wrote:
> > > > Hi Petr,

> > > > > Il giorno 11 ago 2022, alle ore 22:20, Petr Vorel
> > > > > <pvorel@suse.cz> ha scritto:

> > > > > ﻿Hi,

> > > > > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > > > nit (not worth of reposting): I'm not a native speaker, but
> > > > > IMHO subject should
> > > > > be without while, e.g. "fix order on static linking"

> > > > Totally, it sounds awful as it is now.
> > > > I ask maintainers if it’s possible to reword like Petr
> > > > pointed.
> > > Will do!

> > Thank you!

> > I will try to improve the pkg-config autotools because as it is now it
> > works but it’s not a good solution.

> > I should use what it’s been suggested to me here:
> > https://lists.buildroot.org/pipermail/buildroot/2022-August/648926.html
> > And I’ve given another solution:
> > https://lists.buildroot.org/pipermail/buildroot/2022-August/648933.html
> > but it’s still not ok:
> > https://lists.buildroot.org/pipermail/buildroot/2022-August/649058.html
> I don't have access to those list...

Yep, these are forbidden 403.
Giulio, please post a link on lore
https://lore.kernel.org/buildroot/
(or on patchwork)

Kind regards,
Petr


> > So for the moment it’s a decent solution indeed it’s been committed to
> > Buildroot
> > but I’ll try to improve it once I’ll have time.
> Sounds like a plan...

> steved.


> > Kind regards
> > —
> > Giulio Benetti
> > CEO/CTO@Benetti Engineering sas

> > > steved.

> > > > Thank you all.

> > > > Best regards
> > > > Giulio


> > > > > Kind regards,
> > > > > Petr




