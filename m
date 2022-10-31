Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814176132E8
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJaJkk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 05:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJaJkj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 05:40:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1295F96
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 02:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F51DCE12B1
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 09:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23598C433D7;
        Mon, 31 Oct 2022 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667209233;
        bh=dH33vN6G7h/y+IuNmPLMWqbgxTELDD+I7H/t7BJ48L4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HF9Hh5n/tYjATVFgoetc3U4AA1+/x6DyFhfp/IWc33VvuS0uEOj8EsK7luFM0YLYg
         e+fhnc2/E8Razi9dGa//A0XyibEITLkNruY3uyOnn5DeWo0VSf8H80CJjuBlJUa/E0
         8QpHhjfifkJ7E4G7NpI1ffK01IqR15b2f2MxqwgvSTi2WWCuwSB+gSYuepfCJhWmou
         9Ni5t8Wwugmb425q20EcgLE+xI5VaIGGr+QCpQsn9EIXRgP1aVaThVTFTz56mmSObn
         Mn3s1udrE+G9N2b1h35fQZbfnrqK59pb6ROwxKIvP1VNGkB3e/LB7LmymJvU5dD6/A
         iXdbXBfCrJF9A==
Message-ID: <582ac853ea286dead7452bb75a0aa6e450a5c981.camel@kernel.org>
Subject: Re: [PATCH v3 2/4] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Mon, 31 Oct 2022 05:40:31 -0400
In-Reply-To: <9C3A23A5-029E-44FC-9212-5A1D9C01C34A@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
         <20221028185712.79863-3-jlayton@kernel.org>
         <96D34180-0E11-4582-8B45-B3FD9CD8F2DB@oracle.com>
         <432239da4d20337f6f14c91f40fb4432e637a662.camel@kernel.org>
         <3DD6D3B9-552C-470F-BF54-929497C58A4F@oracle.com>
         <2fbb55230b48c2e3b29b1fb16ebe7467b90e4052.camel@kernel.org>
         <9C3A23A5-029E-44FC-9212-5A1D9C01C34A@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-10-28 at 21:23 +0000, Chuck Lever III wrote:
>=20
> > On Oct 28, 2022, at 5:03 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2022-10-28 at 20:39 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Oct 28, 2022, at 4:13 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > On Fri, 2022-10-28 at 19:49 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> w=
rote:
> > > > > >=20
> > > > > > The filecache refcounting is a bit non-standard for something s=
earchable
> > > > > > by RCU, in that we maintain a sentinel reference while it's has=
hed. This
> > > > > > in turn requires that we have to do things differently in the "=
put"
> > > > > > depending on whether its hashed, which we believe to have led t=
o races.
> > > > > >=20
> > > > > > There are other problems in here too. nfsd_file_close_inode_syn=
c can end
> > > > > > up freeing an nfsd_file while there are still outstanding refer=
ences to
> > > > > > it, and there are a number of subtle ToC/ToU races.
> > > > > >=20
> > > > > > Rework the code so that the refcount is what drives the lifecyc=
le. When
> > > > > > the refcount goes to zero, then unhash and rcu free the object.
> > > > > >=20
> > > > > > With this change, the LRU carries a reference. Take special car=
e to
> > > > > > deal with it when removing an entry from the list.
> > > > >=20
> > > > > I can see a way of making this patch a lot cleaner. It looks like=
 there's
> > > > > a fair bit of renaming and moving of functions -- that can go in =
clean
> > > > > up patches before doing the heavy lifting.
> > > > >=20
> > > >=20
> > > > Is this something that's really needed? I'm already basically rewri=
ting
> > > > this code. Reshuffling the old code around first will take a lot of=
 time
> > > > and we'll still end up with the same result.
> > >=20
> > > I did exactly this for the nfs4_file rhash changes. It took just a co=
uple
> > > of hours. The outcome is that you can see exactly, in the final patch=
 in
> > > that series, how the file_hashtbl -> rhltable substitution is done.
> > >=20
> > > Making sure each of the changes is more or less mechanical and obviou=
s
> > > is a good way to ensure no-one is doing something incorrect. That's w=
hy
> > > folks like to use cocchinelle.
> > >=20
> > > Trust me, it will be much easier to figure out in a year when we have
> > > new bugs in this code if we split up this commit just a little.
> > >=20
> >=20
> > Sigh. It seems pointless to rearrange code that is going to be replaced=
,
> > but I'll do it. It'll probably be next week though.
> >=20
> > >=20
> > > > > I'm still not sold on the idea of a synchronous flush in nfsd_fil=
e_free().
> > > >=20
> > > > I think that we need to call this there to ensure that writeback er=
rors
> > > > are handled. I worry that if try to do this piecemeal, we could end=
 up
> > > > missing errors when they fall off the LRU.
> > > >=20
> > > > > That feels like a deadlock waiting to happen and quite difficult =
to
> > > > > reproduce because I/O there is rarely needed. It could help to pu=
t a
> > > > > might_sleep() in nfsd_file_fsync(), at least, but I would prefer =
not to
> > > > > drive I/O in that path at all.
> > > >=20
> > > > I don't quite grok the potential for a deadlock here. nfsd_file_fre=
e
> > > > already has to deal with blocking activities due to it effective do=
ing a
> > > > close(). This is just another one. That's why nfsd_file_put has a
> > > > might_sleep in it (to warn its callers).
> > >=20
> > > Currently nfsd_file_put() calls nfsd_file_flush(), which calls
> > > vfs_fsync(). That can't be called while holding a spinlock.
> > >=20
> > >=20
> >=20
> > nfsd_file_free (and hence, nfsd_file_put) can never be called with a
> > spinlock held. That's true even before this set. Both functions can
> > block.
>=20
> Dead horse: in the current code base, nfsd_file_free() can be called
> via nfsd_file_close_inode_sync(), which is an API external to
> filecache.c. But, I agree now that both functions can block.
>=20
>=20
> > > > What's the deadlock scenario you envision?
> > >=20
> > > OK, filp_close() does call f_op->flush(). So we have this call
> > > here and there aren't problems today. I still say this is a
> > > problem waiting to occur, but I guess I can live with it.
> > >=20
> > > If filp_close() already calls f_op->flush(), why do we need an
> > > explicit vfs_fsync() there?
> > >=20
> > >=20
> >=20
> > ->flush doesn't do anything on some filesystems, and while it does
> > return an error code today, it should have been a void return function.
> > The error from it can't be counted on.
>=20
> OK. The goal is detecting writeback errors, and ->flush is not a
> reliable way to do that.
>=20
>=20
> > vfs_fsync is what ensures that everything gets written back and returns
> > info about writeback errors. I don't see a way around calling it at
> > least once before we close a file, if we want to keep up the "trick" of
> > resetting the verifier when we see errors.
>=20
> Fair enough, but maybe it's not worth a complexity and performance
> impact. Writeback errors are supposed to be rare compared to I/O.
>=20

Absolutely, but they _do_ happen, and in a world with more complex I/O
stacks, we see them more often than before.

> If we can find another way (especially, a more reliable way) to
> monitor for writeback errors, that might be an improvement over
> using vfs_fsync, which seems heavyweight no matter how you cut it.
>=20

There really isn't a way as we can't guarantee that everything has been
written back without calling vfs_fsync.

>=20
> > IMO, the goal ought to be to ensure that we don't end up having to do
> > any writeback when we get to GC'ing it, and that's what patch 4/4 shoul=
d
> > do.
>=20
> Understood. I don't disagree with the goal, since filp_close()
> won't be able to avoid a potentially costly ->flush in some cases.
>=20
> The issue is even a SYNC_NONE flush has appreciable cost.

Sure, but the machine will have to pay that cost eventually. We can try
to offload that onto other threads and whatnot, but I'm not convinced
that's really better for overall performance.

--=20
Jeff Layton <jlayton@kernel.org>
