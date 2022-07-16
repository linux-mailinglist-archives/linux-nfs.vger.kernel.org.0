Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC7576B1B
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 02:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiGPAYE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 20:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGPAYD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 20:24:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB4932EE2
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 17:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA199B82F01
        for <linux-nfs@vger.kernel.org>; Sat, 16 Jul 2022 00:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABDAC34115;
        Sat, 16 Jul 2022 00:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657931039;
        bh=lRUwnk22LEYqNs7U+I00SYnXM3yzhW8pxbBuR7u4TC8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=buxXlC8qrqTAodW7bsoB9voPJ4ctMgaqTamLgOI1nlgqDcCTPPe6uDdhgosDemHdA
         jgyOXufDUBQGn+eblfzicWIjxpPi9r8ff/sgiZks2R29qdtSgH8idffKbf8cHemzdM
         Jh1/54wkHOCPqCg8bi4x2vJ25E2cnsOACtw6+SSMZJ1yZkDkKUb5fgHhVXMHlW18GY
         iVq8Bn/zi2RwJZ+UtRgUTjC5zhpyutYT86ucuCZCBd9EeFEkLINQQv2UhT5bWqM+4Q
         QXV/8tgSQZG97+L9T/ep3dsToq+1vSTyD5lhg9TdsnMmOtgMCm8sYUnjRh4Ig1jSCs
         Qzvio7wjKcooA==
Message-ID: <0bce587f7b012c6ee1cab04923946c64d928e059.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] nfsd: close potential race between open and
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 15 Jul 2022 20:23:57 -0400
In-Reply-To: <6F1AD05A-B3C7-4B2E-84CA-D08BF1093F82@oracle.com>
References: <20220715183257.41129-1-jlayton@kernel.org>
         <6F1AD05A-B3C7-4B2E-84CA-D08BF1093F82@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-07-15 at 18:42 +0000, Chuck Lever III wrote:
>=20
> > On Jul 15, 2022, at 2:32 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > v2:
> > - use nfsd_lookup_dentry instead of lookup_one_len
> >=20
> > Here's a respin of the patches to fix up the potential race between an
> > open and delegation. I took Neil's advice an changed over to use
> > nfsd_lookup_dentry.
> >=20
> > This patchset is based on top of Neil's recent patchset entitled:
> >=20
> >    [PATCH 0/8] NFSD: clean up locking.
>=20
> Thanks to both of you for pursuing this work! I think there are
> some good improvements here.
>=20
> Note that there are some outstanding review comments (aside from
> the disagreement about how to refactor nfsd_create) so I expect
> Neil will be reposting his series. This is just to note that, as
> long as your series is based on his, I will consider your series
> as RFC until his base series is stable and pulled.
>=20
> I'll review again today or over the weekend.
>=20

Thanks. I think I'll be able to adapt this approach on top of whatever
Neil comes up with.

>=20
> > Tested with xfstests and it seemed to behave. I haven't done any testin=
g
> > to ensure that the race is actually fixed, mainly because I don't have =
a
> > way to reliably reproduce it.
>=20
> That's the thing: we don't have many tests that use multiple clients
> targeting the same set of files.
>=20
>=20

Yeah, it's a difficult problem. Testing delegation behavior is
particularly difficult since the client doesn't have a lot of control
over them being granted in the first place.

> > Jeff Layton (2):
> >  nfsd: drop fh argument from alloc_init_deleg
> >  nfsd: vet the opened dentry after setting a delegation
> >=20
> > fs/nfsd/nfs4state.c | 58 ++++++++++++++++++++++++++++++++++++++-------
> > 1 file changed, 49 insertions(+), 9 deletions(-)
> >=20
> > --=20
> > 2.36.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
