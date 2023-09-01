Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BD778FBBB
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347853AbjIAKVt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbjIAKVs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 06:21:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186F2CC;
        Fri,  1 Sep 2023 03:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1A1E60F6A;
        Fri,  1 Sep 2023 10:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A03C433C7;
        Fri,  1 Sep 2023 10:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693563705;
        bh=8+zgMsIxNVky1b+iU/hk4UlHtrkhcGXxHQtE/5ecxoI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jnfvN9/juxHF1g7sw9iOEkDiurOqSzr5zZX3FnveI01BzvhiuTUfW19omq51bf9RM
         Vj0ml/Vu3lDF8q2+AZCOb2CYBDt7chen8iy7NAFyJg9UpUgODx58sKIEQdixsJXlmd
         Mk2Sv0x32/0AyMy1sQxw65biT26zqtoP9jNuPY6qzHKwJJXmYgqwkb91aFNJ+7g0sZ
         x4fSDk6FRDzK4dF4v7BsCa+y/Yuqeck6YJgTyA0atdpMkjt72BSS0wfmwXJJeDGWsA
         TGp1tVpVbnsAqSl4HUZ3Dq3alCuKoqLD/QrzG3bQy9jZKZ5OTMSlSkPhD8wt0UxYAM
         NBTjQ7V3PV0pQ==
Message-ID: <8db2e22a71ed9c658945bd3d7f0a4b6cad7db1d3.camel@kernel.org>
Subject: Re: [PATCH fstests 1/3] generic/294: don't run this test on NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 Sep 2023 06:21:43 -0400
In-Reply-To: <20230901051439.j5jduasrkmh67g6g@zlang-mailbox>
References: <20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org>
         <20230831-nfs-skip-v1-1-d54c1c6a9af2@kernel.org>
         <20230901051439.j5jduasrkmh67g6g@zlang-mailbox>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-09-01 at 13:14 +0800, Zorro Lang wrote:
> On Thu, Aug 31, 2023 at 02:40:28PM -0400, Jeff Layton wrote:
> > When creating a new dentry (of any type), NFS will optimize away any
> > on-the-wire lookups prior to the create since that means an extra
> > round trip to the server. Because of that, it consistently fails this
> > test.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  tests/generic/294 | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/tests/generic/294 b/tests/generic/294
> > index 406b1b3954b9..777b62aec9ad 100755
> > --- a/tests/generic/294
> > +++ b/tests/generic/294
> > @@ -15,6 +15,10 @@ _begin_fstest auto quick
> > =20
> >  # real QA test starts here
> > =20
> > +# NFS will optimize away the on-the-wire lookup before attempting to
> > +# create a new file (since that means an extra round trip).
> > +test $FSTYP =3D "nfs"  && _notrun "NFS optmizes away lookups on exclus=
ive creates"
> > +
> >  # Modify as appropriate.
> >  _supported_fs generic
>=20
> I don't know if nfs-list wants to skip these test cases on nfs. Anyway, i=
f
> there's not an objection from nfs team, the _supported_fs helper can use
> a black list, likes:
>=20
>   _supported_fs ^nfs
>=20
> If a test case doesn't support nfs totally, you can use this and give it =
a
> proper comment.
>=20

I think we do want to skip it. This one consistently fails on NFS and is
testing very specific and subtle behavior that is not required by POSIX.

I can respin these using the _supported_fs syntax if that's preferred
though.=20
--=20
Jeff Layton <jlayton@kernel.org>
