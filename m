Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41570735564
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jun 2023 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjFSLFA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jun 2023 07:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjFSLEl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jun 2023 07:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F1D2733;
        Mon, 19 Jun 2023 04:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9923160BA2;
        Mon, 19 Jun 2023 11:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EB9C433C8;
        Mon, 19 Jun 2023 11:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687172610;
        bh=Gbbft4RegPZLfwKq98ecTGKYvyCX9Hk20rzGGLCNRyg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uiPAiFYuI4+WL4ZgxE2edNxsq+aFR5tBS4hzIg7oRW40jX81+zqf3Sy3hVTfZTK1c
         /+Qc684YtfpetV9nsPn2fgtk0Glha8F8DpfB3AjOhJR0VEUWgpq8vCHqhlyVJt+vxy
         1PzdGnP9kdhbjzoDxqqj+ugdkWXAdTAiLMDdP72hpGL2SBJKm0hVgES8+IqZmfOEX9
         BzHZjLAS4o40UwDLy0AtgTv/nu18bfZ7KHN2UJnaXVssR8vA2JX4aQ9mYiXp9iH00h
         kYFXX6y9OmcfGcMUF0ECcZqVulY9HB16vasxC8y0oyMTJ4dY29TaJw3g3xG3I21wtc
         Pp7az95SIw/0w==
Message-ID: <356b94ef10dc12063da5dc145b61a47ddff5c23a.camel@kernel.org>
Subject: Re: [PATCH] nfsd: move init of percpu reply_cache_stats counters
 back to nfsd_init_net
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Chuck Lever <cel@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-stable <stable@vger.kernel.org>,
        Eirik Fuller <efuller@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 19 Jun 2023 07:03:27 -0400
In-Reply-To: <9154BA25-C795-4BEF-B32D-EAB8679E9472@oracle.com>
References: <20230616191744.202292-1-jlayton@kernel.org>
         <ZIzFp3ViiU2SCi6J@manet.1015granger.net>
         <4b5063eb5a1139adc9dd4bdadde30674faee0700.camel@kernel.org>
         <d698b838-57e0-d019-a783-c229c04eeca4@leemhuis.info>
         <7d9515dbe6af110f2c32dce2b994120e4637b295.camel@kernel.org>
         <9154BA25-C795-4BEF-B32D-EAB8679E9472@oracle.com>
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

On Sun, 2023-06-18 at 15:59 +0000, Chuck Lever III wrote:
>=20
> > On Jun 18, 2023, at 8:09 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Sun, 2023-06-18 at 12:40 +0200, Thorsten Leemhuis wrote:
> > > On 16.06.23 22:54, Jeff Layton wrote:
> > > > On Fri, 2023-06-16 at 16:27 -0400, Chuck Lever wrote:
> > > > > Thanks Eirik and Jeff.
> > > > >=20
> > > > > At this point in the release cycle, I plan to apply this for the
> > > > > next merge window (6.5).
> > > >=20
> > > > I think we should take this in sooner. This is a regression and a
> > > > user-triggerable oops in the right situation. If:
> > > >=20
> > > > - non-x86_64 arch
> > > > - /proc/fs/nfsd is mounted in the namespace
> > > > - nfsd is not started in the namespace
> > > > - unprivileged user calls "cat /proc/fs/nfsd/reply_cache_stats"
> > >=20
> > > FWIW, might be worth to simply tell Linus about it and let him decide=
,
> > > that's totally fine and even documented in the old and the new docs f=
or
> > > handling regressions[1].
> > >=20
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/Documentation/process/handling-regressions.rst?id=3Deed892da9cd08be76=
a8f467c600ef58716dbb4d2
> > >=20
> >=20
> > I'd rather Chuck make the final call here.
>=20
> Thanks! I feel this one needs broader testing than we can manage
> in just a couple of days. If this were earlier in the -rc cycle
> I would pull the patch right into 6.4-rc without hesitation. It
> is obviously -rc material, but the timing is unfortunate.
>=20
> I'm planning the nfsd for-6.5 pull request early in the merge
> window, so practically speaking it shouldn't delay the finalized
> upstream version of this patch by more than a few days.
>=20
>=20
Ok. I'll trust your judgment then and just cultivate my patience!

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
