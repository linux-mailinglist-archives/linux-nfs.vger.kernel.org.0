Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD68A575588
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 20:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiGNS7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiGNS7V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 14:59:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513EF46D83
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 11:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7F19B82875
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 18:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0642DC34115;
        Thu, 14 Jul 2022 18:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657825157;
        bh=N5it7a/hz43JQZ780ngEdEXBKxs7VH3nGWyNajVH+W4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P0SFCEMi60Ak2xG2faoxEDJzcbgiMsfGDYhUJKCpvdptNnfak1QYNmCUzw7mbPm7f
         sdhG97EnkvYdzhft+7yo4h7KMS19lFLRbl6Dk28oItWvKNg3VXweaFem37Ky1Da0HB
         ZD30sZf6FOwm0Xo2RL4KGP7pXPl9rl/AwrGz8INQN3/QObW6yWQ6FGvqxOW+vDNpZi
         bMqt7yREFWTGt8Ntx4B0aXmsRsQl/Zt246aDtly8EGAp+jOSyZubdskV3HWoE+3ep/
         tYYtda2GFPKuyF1uvDQoDVtFaAEgVtjNOLLJiblCxPk819JsEVytH1uGAszOw3fzqv
         QfIT/aNPCBBSg==
Message-ID: <380a3ac6d07832c4c7bef84615bc5c5d47be30ac.camel@kernel.org>
Subject: Re: [RFC PATCH 2/3] nfsd: rework arguments to nfs4_set_delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 14 Jul 2022 14:59:15 -0400
In-Reply-To: <E8CCB7EF-242C-4530-96E2-ACC7B5CB3163@oracle.com>
References: <20220714152819.128276-1-jlayton@kernel.org>
         <20220714152819.128276-3-jlayton@kernel.org>
         <CDD9B96C-3CFC-4BA5-A71C-6C2BFAC2B227@oracle.com>
         <476892362c94debad589af79ff7d6766f5ca8c85.camel@kernel.org>
         <E8CCB7EF-242C-4530-96E2-ACC7B5CB3163@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-07-14 at 17:14 +0000, Chuck Lever III wrote:
> =20
>=20
> > On Jul 14, 2022, at 1:12 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Thu, 2022-07-14 at 16:47 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Jul 14, 2022, at 11:28 AM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > >=20
> > > > We'll need the nfs4_open to vet the filename. Change nfs4_set_deleg=
ation
> > > > to take the same arguments are nfs4_open_delegation.
> > >=20
> > > ^are^as
> > >=20
> > > Nit: Considering that in the next patch you change the synopsis of
> > > nfs4_open_delegation again but not nfs4_set_delegation, this
> > > description causes a little whiplash.
> > >=20
> > >=20
> >=20
> > Yeah, I should have squashed a couple of those together. I _did_ say it
> > was an RFC. I can resend a cleaned-up version later if you want to take
> > this in.
>=20
> I'm interested in Neil's thoughts about this approach, but I'm
> willing to run with it unless test results show a regression.
>=20
>=20

...and there is a regression. Partial lockdep pop here:

Jul 14 14:46:54 quad3 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Jul 14 14:46:54 quad3 kernel: WARNING: possible recursive locking detected
Jul 14 14:46:54 quad3 kernel: 5.19.0-rc5+ #316 Tainted: G           OE   =
=20
Jul 14 14:46:54 quad3 kernel: --------------------------------------------
Jul 14 14:46:54 quad3 kernel: nfsd/1148 is trying to acquire lock:
Jul 14 14:46:54 quad3 kernel: ffff88812a3a7388 (&inode->i_sb->s_type->i_mut=
ex_dir_key/1){++++}-{3:3}, at: nfsd4_process_open2+0x1890/0x2710 [nfsd]
Jul 14 14:46:54 quad3 kernel:=20
                              but task is already holding lock:
Jul 14 14:46:54 quad3 kernel: ffff88812a3a7388 (&inode->i_sb->s_type->i_mut=
ex_dir_key/1){++++}-{3:3}, at: nfsd_lookup_dentry+0x16f/0x6a0 [nfsd]
Jul 14 14:46:54 quad3 kernel:=20
                              other info that might help us debug this:
Jul 14 14:46:54 quad3 kernel:  Possible unsafe locking scenario:
Jul 14 14:46:54 quad3 kernel:        CPU0
Jul 14 14:46:54 quad3 kernel:        ----
Jul 14 14:46:54 quad3 kernel:   lock(&inode->i_sb->s_type->i_mutex_dir_key/=
1);
Jul 14 14:46:54 quad3 kernel:   lock(&inode->i_sb->s_type->i_mutex_dir_key/=
1);
Jul 14 14:46:54 quad3 kernel:=20
                               *** DEADLOCK ***
Jul 14 14:46:54 quad3 kernel:  May be due to missing lock nesting notation
Jul 14 14:46:54 quad3 kernel: 1 lock held by nfsd/1148:
Jul 14 14:46:54 quad3 kernel:  #0: ffff88812a3a7388 (&inode->i_sb->s_type->=
i_mutex_dir_key/1){++++}-{3:3}, at: nfsd_lookup_dentry+0x16f/0x6a0 [nfsd]
Jul 14 14:46:54 quad3 kernel:=20


The core problem is the unclear locking in nfsd_lookup_dentry. Sometimes
that returns with the i_rwsem held, but there's no clear indication of
whether that's the case when the function returns. I guess fh_unlock
just takes care of that (which is a little scary, tbqh).

Now that I've taken a stab at it, I don't see how we can fix this w/o
taking Neil's locking cleanups series first. I think I'll pull that in
and try to redo this series on top of it.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
