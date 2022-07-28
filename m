Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3CA584278
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiG1O7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiG1O7V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:59:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64C1C4B
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 912C3B82483
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 14:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99D2C433C1;
        Thu, 28 Jul 2022 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659020358;
        bh=Y4P4YKpgAlIAICZIZe0sFnpoW3Ncdzm1xrLN+ss/f00=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lI28VHcxA7V9CXMn4v8SMEy2T67NGPvErhxXbmhmMvFRzA/JM2IgPsONqQZ8+eoLm
         vQ3A3IqqPI/xLn+iyWfut0Ngh078rBQG/iZ4AOJQ0kyqqFmWUaEm3NUNwKjJzU972A
         V5EIn4azs2/AmZ0gk/LWtwObYMV5CUoCx7CVpwE6aejrlKKCnFL0PSy+FT/oOLrgFt
         rJnacbt4gfcbkkAEVgtTxKDjZqD4d8tXIFsLsudg6I+judiYhaSTruVlT6iGk9OyIR
         wPRtHYMMbDcN2d/uUf0UKY6wd7a62EwZ8wOka5f8hpzINJ2wN3PEdyDtLG9C2gN9Ej
         NWoadWHHqmQNw==
Message-ID: <358ff1e4ab5ea12d8f16417ca85414bf58e37993.camel@kernel.org>
Subject: Re: [RFC PATCH] nfs: don't skip CTO on v2/3 mounts, regardless of
 order of reference puts
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "kolga@netapp.com" <kolga@netapp.com>
Date:   Thu, 28 Jul 2022 10:59:16 -0400
In-Reply-To: <1514326848e2874284a4af016fbda6dea67327fb.camel@hammerspace.com>
References: <20220728142406.91832-1-jlayton@kernel.org>
         <1514326848e2874284a4af016fbda6dea67327fb.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-07-28 at 14:53 +0000, Trond Myklebust wrote:
> On Thu, 2022-07-28 at 10:24 -0400, Jeff Layton wrote:
> > Olga reported a case of data corruption in a situation where two
> > clients
> > (v3 and v4) were alternately doing open/write/close the same file.
> >=20
> > Looking at captures, the v3 client failed to perform any of the
> > GETATTR
> > calls for CTO during one of the events, leading it to overwrite some
> > data that had been written by the v4 client.
> >=20
> > We have two calls that work similarly: put_nfs_open_context and
> > put_nfs_open_context_sync. The only difference is the is_sync
> > parameter
> > that gets passed to close_context. The only caller of the _sync
> > variant
> > is in the close codepath.
> >=20
> > On a v2/3 mount, if the last reference is not put by
> > put_nfs_open_context_sync, then CTO revalidation never happens. Fix
> > this
> > by adding a new flag to nfs_open_context and set that in
> > put_nfs_open_context_sync. In nfs_close_context, check for that flag
> > when we're checking is_sync and treat them as equivalent.
> >=20
> > Cc: Scott Mayhew <smayhew@redhat.com>
> > Cc: Ben Coddington <bcodding@redhat.com>
> > Reported-by: Olga Kornieskaia <kolga@netapp.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =A0fs/nfs/inode.c=A0=A0=A0=A0=A0=A0=A0=A0 | 3 ++-
> > =A0include/linux/nfs_fs.h | 3 ++-
> > =A02 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > I'm not sure this is the right fix. Maybe we'd be better off just
> > ignoring the is_sync parameter in nfs_close_context? It's probably
> > functionally equivalent anyway.
> >=20
> > Thoughts?
> >=20
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index b4e46b0ffa2d..58b506a0a2f2 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -1005,7 +1005,7 @@ void nfs_close_context(struct nfs_open_context
> > *ctx, int is_sync)
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0if (!(ctx->mode & FMODE_WRITE))
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > -=A0=A0=A0=A0=A0=A0=A0if (!is_sync)
> > +=A0=A0=A0=A0=A0=A0=A0if (!is_sync && !test_bit(NFS_CONTEXT_DO_CLOSE, &=
ctx->flags))
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > =A0=A0=A0=A0=A0=A0=A0=A0inode =3D d_inode(ctx->dentry);
> > =A0=A0=A0=A0=A0=A0=A0=A0if (NFS_PROTO(inode)->have_delegation(inode, FM=
ODE_READ))
>=20
> NACK. If the 'is_sync' flag is not set, then it is because the function
> is being called from a context where it is not safe to do a synchronous
> RPC call.
>=20

Ok. Any thoughts on the right way to fix this then? It seems like
skipping revalidation because the last put wasn't in the close codepath
is the wrong thing to do. Should we schedule it to a workqueue?
--=20
Jeff Layton <jlayton@kernel.org>
