Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4262B578092
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiGRLQ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 07:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiGRLQ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 07:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC220189
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 04:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1939961254
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 11:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6A2C341C0;
        Mon, 18 Jul 2022 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658142986;
        bh=JYrDjYQ66SShctwuyXUB9mzM+a4wG2xtmzgWi/dL/s8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A13bdgNfabUkogwz7V/W4mDyMpQr47nsfj8anUrYVGMLZH6mQlmY1+lpVUHKQL9ji
         3c8qgRoV/HONSUIp6xRXK3ZUGw2wxWlyfhkLVsa9XgTwSKQCB5oZDZFGMrhjmkqh9i
         nl7euf+Y8v21RBod43Rpm7fWcVgzGLu8GGrhcXc76072sW3RyihsYziFXDVU2Ir0JW
         gF2TYQlw3+mg3brCsEs0/fYu7OrbogLE+IYTWtMxvYZRGcNt9hrAB8NYuDdnZIS/kc
         wuCYfUOvZDmKCgpBIUsAvCKpjaiG0WxFiRiu+H5MwknXI3OQY4wQBm6Y3KzdCH7Koo
         1JiRPzdY4tB1w==
Message-ID: <e8d4d73ce58e3ecac0de35b0641501673dadfa18.camel@kernel.org>
Subject: Re: [PATCH 0/2] nfsd: close potential race between open and
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Mon, 18 Jul 2022 07:16:24 -0400
In-Reply-To: <165811450205.25184.16800980627192339653@noble.neil.brown.name>
References: <20220714200434.161818-1-jlayton@kernel.org>
        , <165784314214.25184.13511971308364755291@noble.neil.brown.name>
        , <c10b61cd59a940dd93f6977300ab0d3c6742320f.camel@kernel.org>
         <165811450205.25184.16800980627192339653@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-07-18 at 13:21 +1000, NeilBrown wrote:
> On Fri, 15 Jul 2022, Jeff Layton wrote:
> > On Fri, 2022-07-15 at 09:59 +1000, NeilBrown wrote:
> >=20
> > > however...
> > > 2/ Do we really need to lock the parent?  If a rename or unlink happe=
ns
> > >    after the lease was taken, the lease will be broken. So
> > >     take lease.
> > >     repeat lookup (locklessly)
> > >     Check if lease has been broken
> > >    Should provide all you need.
> > >=20
> > >    You don't *need* to lock the directory to open an existing file an=
d
> > >    with my pending parallel-updates patch set, you only need a shared
> > >    lock on the directory to create a file.  So I'd rather not be lock=
ing
> > >    the directory at all to get a delegation
> > >=20
> >=20
> > Yeah, we probably don't need to lock the dir. That said, after your
> > patch series we already hold the i_rwsem on the parent at this point so
> > lookup_one_len is fine in this instance.
>=20
> But the only reason we hold i_rwsem at this point is to prevent renames
> in the "opened existing file" case.  The "created new file" case holds
> it as well just be be consistent with the first case.
>=20
> If we "vet" the dentry, then we don't need the lock any more.  We can
> then simplify nfsd_lookup_dentry() to always assume the dir is not
> locked - so the "locked" arg can go, and nfsd_lookup() can lose the
> "lock" arg and always return with the directory unlocked.
>=20
> I'm tempted to add your patch to the front of my series.  The
> inconsistency in locking can be fix by unlocking the directory before we
> get even close to handing out a delegation - so the delegation never
> sees a locked directory.

Hmm, ok. I suppose we don't necessarily have to care whether the thing
is locked before calling into nfsd_lookup_dentry. I'll take another stab
at fixing this in the kernel w/o your series. That'll make Chuck happy
too.

> But right now I have a cold and don't trust myself to think clearly
> enough to create code worth posting.  Hopefully I'll be thinking more
> clearly later in the week.
>=20
> While I'm here ...  is "vet" a good word?  The meaning is appropriate,
> but I wonder if it would cause our friends for whom English isn't their
> first language to stumble.  There are about 5 uses in the kernel at
> present.
>=20
> Would validate or verify be better?  Even though they are longer..


Good point. I'm all for helping out non-native English speakers. I'll
plan to change it to something less esoteric.
--=20
Jeff Layton <jlayton@kernel.org>
