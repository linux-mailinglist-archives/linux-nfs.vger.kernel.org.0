Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE773460F
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jun 2023 14:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjFRMJ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Jun 2023 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjFRMJz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Jun 2023 08:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D1F7;
        Sun, 18 Jun 2023 05:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDFAF60B8B;
        Sun, 18 Jun 2023 12:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EAFC433C0;
        Sun, 18 Jun 2023 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687090193;
        bh=U96oc84V7ydjoimAikfo3376ACAFBS29BVe29oAp1WE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BPJompywBU3hnZJ3Wg/Iq7fJBKIiv8h3EeqFinSLOtowecKBEU3JWDNzTRbFU4+Hq
         5QuD3mVCKj1Khh7ZomEqH9FepwZfgDmBYmoumRQ2Oj9QA7K2EYrUFF7C9aG8mtE5lP
         UOHON/qPKGGrYDwuAM9HyDvn1Pr0bf65MM2HsL2b5NmsmAxxwIO9Al+HAWLxs/ea0+
         lox9LwCx971tZLKF1kSTk5EgyCfidubK/fgmzLnf5IZlBdjmFQqLwf4Q4m+BfxWDIq
         5EnG4y3nIF1J+qWhs1N5+GqZWkPhpW+mGf5ax6WnXObSvUj0etXKgu+K3RYKHKXpO7
         f5bSHt7Gfb4ZQ==
Message-ID: <7d9515dbe6af110f2c32dce2b994120e4637b295.camel@kernel.org>
Subject: Re: [PATCH] nfsd: move init of percpu reply_cache_stats counters
 back to nfsd_init_net
From:   Jeff Layton <jlayton@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        stable@vger.kernel.org, Eirik Fuller <efuller@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 18 Jun 2023 08:09:50 -0400
In-Reply-To: <d698b838-57e0-d019-a783-c229c04eeca4@leemhuis.info>
References: <20230616191744.202292-1-jlayton@kernel.org>
         <ZIzFp3ViiU2SCi6J@manet.1015granger.net>
         <4b5063eb5a1139adc9dd4bdadde30674faee0700.camel@kernel.org>
         <d698b838-57e0-d019-a783-c229c04eeca4@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-06-18 at 12:40 +0200, Thorsten Leemhuis wrote:
> On 16.06.23 22:54, Jeff Layton wrote:
> > On Fri, 2023-06-16 at 16:27 -0400, Chuck Lever wrote:
> > > Thanks Eirik and Jeff.
> > >=20
> > > At this point in the release cycle, I plan to apply this for the
> > > next merge window (6.5).
> >=20
> > I think we should take this in sooner. This is a regression and a
> > user-triggerable oops in the right situation. If:
> >=20
> > - non-x86_64 arch
> > - /proc/fs/nfsd is mounted in the namespace
> > - nfsd is not started in the namespace
> > - unprivileged user calls "cat /proc/fs/nfsd/reply_cache_stats"
>=20
> FWIW, might be worth to simply tell Linus about it and let him decide,
> that's totally fine and even documented in the old and the new docs for
> handling regressions[1].
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/Documentation/process/handling-regressions.rst?id=3Deed892da9cd08be76a8f4=
67c600ef58716dbb4d2
>=20

I'd rather Chuck make the final call here. The original patch
description didn't point out how easy it is to trigger a panic with
this, so I was hoping to convince him.

To further that argument too:

I have to wonder if this bug might cause (temporary?) memory corruption
on x86_64. The code hits a spinlock in that struct, so there may be a
window of time where it doesn't contain what's expected.

> > > > Cc: stable@vger.kernel.org # v6.3+
> > > > Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nf=
sd startup")
> > >=20
> > > Why both Fixes: and Cc: stable?
> >=20
> > *shrug* : they mean different things. I can drop the Cc stable.
>=20
> Please leave it, only a stable tag ensures backporting; a fixes tag
> alone is not enough. See [1] above or these recent messages from Greg:
>=20
> https://lore.kernel.org/all/2023061137-algorithm-almanac-1337@gregkh/
> https://lore.kernel.org/all/2023060703-colony-shakily-3514@gregkh/
>=20

Chuck and I also recently requested that the stable series not pick
patches automatically for fs/nfsd. This does need to be backported
though, so I cc'ed stable to make that clear.
--=20
Jeff Layton <jlayton@kernel.org>
