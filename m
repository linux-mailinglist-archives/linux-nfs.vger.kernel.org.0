Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D04F6F49
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 02:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiDGAkM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 20:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiDGAkL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 20:40:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78ACA6C3
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 17:38:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48455210E4;
        Thu,  7 Apr 2022 00:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649291892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3e7KGgjHqGxDcwftbXdQ5rrVikNKaOOeBRQJCF9/5Y=;
        b=oQ6JeYlM4Nr4jmpgHN68F2mgL8RvGT+RkOMMZSU3JO+ifRNBlIekNRT373g0gPOcD0JT5j
        cUTmx6LdBYTk32Jd1WnSeIyOWmcNwxKLcq0WerFZUaEOAxh+hrFOxA0qrizszETBOJGs9S
        ZW5cAMVW6H5L1cn6S71NYZhYq8j1Q5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649291892;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3e7KGgjHqGxDcwftbXdQ5rrVikNKaOOeBRQJCF9/5Y=;
        b=IhyPJIF7b/rJkcjTIelKd5rRLMG3ggxthifU0yufU62c+w4fZYipAcmpHZkdGGU948S3c3
        6MiSfJQ2qDoZxMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E94D413A9C;
        Thu,  7 Apr 2022 00:38:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ObFLKXIyTmKfcgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Apr 2022 00:38:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Possible NFS4 regression on 5.18-rc1
In-reply-to: <23f11c6151f9bbfbb09d2699f4388d4a09a87127.camel@hammerspace.com>
References: <20220406142541.eouf7ryfbd7aooye@basti-XPS-13-9310>,
 <23f11c6151f9bbfbb09d2699f4388d4a09a87127.camel@hammerspace.com>
Date:   Thu, 07 Apr 2022 10:38:07 +1000
Message-id: <164929188775.10985.17822469281433754130@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 07 Apr 2022, Trond Myklebust wrote:
> On Wed, 2022-04-06 at 16:25 +0200, Sebastian Fricke wrote:
> > [You don't often get email from sebastian.fricke@collabora.com. Learn
> > why this is important at
> > http://aka.ms/LearnAboutSenderIdentification.]
> >=20
> > Hello folks,
> >=20
> > I am currently developing a V4L2 driver with support on GStreamer,
> > for
> > that purpose I am mounting the GStreamer repository via NFS from my
> > development machine to the target ARM64 hardware.
> >=20
> > I just switched to the latest kernel and got a sudden hang up of my
> > system.
> > What I did was a rebase of the GStreamer repository and then I wanted
> > to
> > build it with ninja on the target, this failed with a segmentation
> > fault:
> > ```
> > gstreamer| Configuring libgstreamer-1.0.so.0.2100.0-gdb.py using
> > configurat=3D
> > ion
> > Segmentation fault
....

> > [ 4595.209552] pc : list_lru_add+0xd4/0x180
> > [ 4595.209907] lr : list_lru_add+0x15c/0x180

This is almost certainly fixed by the patch at

https://lore.kernel.org/all/164876616694.25542.14010655277238655246@noble.nei=
l.brown.name/

which almost landed in -mm, but didn't quite.

The subsequent email

https://lore.kernel.org/all/CAMZfGtUMyag7MHxmg7E1_xmyZ7NDPt62e-qXbqa8nJHFC72=
=3D3w@mail.gmail.com/

suggests a one-line change.

Trond: maybe you could queue this?

NeilBrown
