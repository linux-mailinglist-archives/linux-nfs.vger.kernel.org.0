Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6EB75B4A6
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 18:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjGTQjv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 12:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGTQjp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 12:39:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315A2736;
        Thu, 20 Jul 2023 09:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C224F61B8D;
        Thu, 20 Jul 2023 16:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643A1C433C9;
        Thu, 20 Jul 2023 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689871138;
        bh=2gME/jlBfFp+8xl95AKBlT8xPNpXAgidZPMiIKzm32Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fb92fS5asKJzq6Mu5j24cHQoFdOXPSZ/ZUap5QSJsjG/1bou29cK0J4edyVTnPCor
         aeW5PgvI/lVZiKEjyyd61uEIE/4fTiPifu2VETw7hYh3nVKL2eQtWRBmAlOi8VFVgp
         D+xZsb6fSDIMZWWP5k8fGFpxmizV0gv2IDeyl9htBBwxgqthhs8RO6bppbtUJmZDtp
         qkX1lLXiUiubi0nrCNH5m0hc7Fll3eGvF1wfLold/C/oTAyUz33c4+firN16khUIdr
         5+0yP3WYRZGqgiVxPtki+TXwyZyN4lMUiRzh3t5tnO/0yTW1QLrsJA70N02hM8ctfM
         L7xdZBds0Lhtw==
Message-ID: <016b04630ce7e168cbaacb1a27bd95b966b8c64e.camel@kernel.org>
Subject: Re: [PATCH] nfsd: remove unsafe BUG_ON from set_change_info
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Date:   Thu, 20 Jul 2023 12:38:56 -0400
In-Reply-To: <C4A9048C-C3C8-4C62-B68F-7170C6CDC5BE@oracle.com>
References: <20230720-bz2223560-v1-1-edb4900043b8@kernel.org>
         <4B067A0F-93E3-435A-A32B-B17BC07D4606@oracle.com>
         <061f2b988de3da1dac32ecb3d8ac76319065b51d.camel@kernel.org>
         <C4A9048C-C3C8-4C62-B68F-7170C6CDC5BE@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-07-20 at 15:37 +0000, Chuck Lever III wrote:
>=20
> > On Jul 20, 2023, at 11:33 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Thu, 2023-07-20 at 15:15 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Jul 20, 2023, at 10:59 AM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > >=20
> > > > At one time, nfsd would scrape inode information directly out of st=
ruct
> > > > inode in order to populate the change_info4. At that time, the BUG_=
ON in
> > > > set_change_info made some sense, since having it unset meant a codi=
ng
> > > > error.
> > > >=20
> > > > More recently, it calls vfs_getattr to get this information, which =
can
> > > > fail. If that fails, fh_pre_saved can end up not being set. While t=
his
> > > > situation is unfortunate, we don't need to crash the box.
> > >=20
> > > I'm always happy to get rid of a BUG_ON(). But I'm not sure even
> > > a warning is necessary in this case. It's not likely that it's
> > > a software bug or something that the server administrator can
> > > do something about.
> > >=20
> > > Can you elaborate on why the vfs_getattr() might fail? Eg, how
> > > was it failing in 2223560 ?
> > >=20
> >=20
> > I'm fine with dropping the WARN_ON. You are correct that there is
> > probably little the admin can do about it.
> >=20
> > vfs_getattr can fail for all sorts of reasons. It really depends on the
> > underlying filesystem. In 2223560, I don't know for sure, but just prio=
r
> > to the oops, there were these messages in the log:
> >=20
> > [51935.482019] XFS (vda3): Filesystem has been shut down due to log err=
or (0x2).=20
> > [51935.482020] XFS (vda3): Please unmount the filesystem and rectify th=
e problem(s).=20
> > [51935.482550] vda3: writeback error on inode 25320400, offset 2097152,=
 sector 58684120=20
> >=20
> > My assumption was that the fs being shut down caused some VFS operation=
s
> > to start returning errors (including getattr) and that is why
> > fh_pre_saved ultimately didn't get set.
>=20
> I'm wondering if the operation should just fail in this case
> rather than return a cobbled-up changeinfo4. Maybe for another
> day.
>=20

Actually, this doesn't look too hard to do. We should be able to just
unwind and return an error in all cases if collecting pre_op_attrs
fails.

The trickier bit is what to do if collecting post_op_attrs fails after
collecting pre-op attrs and the operation itself succeeded. What should
go into the after_change value? 0? Should we just copy the before_change
value?

--=20
Jeff Layton <jlayton@kernel.org>
