Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177F0531B23
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbiEWRxN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 13:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbiEWRv7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 13:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0926D3A7
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 10:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6955960BD3
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 17:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE22C385A9;
        Mon, 23 May 2022 17:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653327541;
        bh=7qgSf/5NH4N7+Rd1yZrHkdcdD3D13iNxU/v08hdbVGA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=I5GOan8J16X5vP4ruS4TNkjO8glJKaladNJtGUkMuwa0CbWLV+Ksd3D1nSCrN9FsN
         Nb7iVwLSJR/aiIJAw4CviRfJw2+y00QjIh7pHvpx2qMkyNhPidO/dDIlpLga5mZ4Is
         HVci/qSre9fHFPAXToKofSo+pLi42ldsIimlBYtWAR6Q0niTAOrjmmh9XXWTfki5K3
         Nklgm7Cpcdnmfh5SVqmeECqmEOM+KWDV+foiRJ0VUVX8vcHHXfwfWPfixP5g3Yddg3
         QQ5NhOQP6qe/im0ylEGZWCbTIPlJkULs50cfyik2I8NYXlnmKiag5pkOowM5zO9ftf
         z+MdmEFVs8DGg==
Message-ID: <f20de886f02402970c86c5195ea344de128afd91.camel@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 23 May 2022 13:38:59 -0400
In-Reply-To: <FF7F2939-C3DE-4584-BFFA-13B554706B9C@oracle.com>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
         <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
         <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
         <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
         <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
         <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
         <FF7F2939-C3DE-4584-BFFA-13B554706B9C@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-05-23 at 17:25 +0000, Chuck Lever III wrote:
>=20
> > On May 23, 2022, at 12:37 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2022-05-23 at 15:41 +0000, Chuck Lever III wrote:
> > >=20
> > > > On May 23, 2022, at 11:26 AM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > >=20
> > > > What I was going to suggest is a nfsd_file_put variant that takes a
> > > > list_head. If the refcount goes to zero and the thing ends up being
> > > > unhashed, then you put it on the dispose list rather than doing the
> > > > blocking operations, and then clean it up later.
> > >=20
> > > Trond doesn't like that approach; see the e-mail thread.
> >=20
> > I didn't see him saying that that would be wrong, per-se, but the
> > initial implementation was racy.
>=20
> I proposed this for check_for_locks() to use:
>=20
> > void nfsd_file_put_async(struct nfsd_file *nf)
> > {
> > 	if (refcount_dec_and_test(&nf->nf_ref))
> > 		nfsd_file_close_inode(nf->nf_inode);
> > }
>=20
>=20
> Trond's response was:
>=20
> > That approach moves the sync to the garbage collector, which was
> > exactly what we're trying to avoid in the first place.
>=20
> Basically he's opposed to any flush work being done by
> the garbage collector because that has a known negative
> performance impact.
>=20
>=20

Fair enough. I like his other suggestion better anyway.

> > His suggestion was just to keep a counter in the lockowner of how many
> > locks are associated with it. That seems like a good suggestion, though
> > you'd probably need to add a parameter to lm_get_owner to indicate
> > whether you were adding a new lock or just doing a conflock copy.
>=20
> locks_copy_conflock() would need to take a boolean parameter
> that callers would set when they actually manipulate a lock.
>=20

Yep. You'd also have to add a bool arg to lm_put_owner so that you know
whether you need to decrement the counter.

> I would feel more comfortable with that approach if
> locks_copy_conflock() was a private API used only in fs/locks.c
> so we can audit its usage to ensure that callers are managing
> the lock count correctly.
>=20
>=20

It basically is. In fact, I'm not sure why it's exported since nothing
outside of locks.c calls it. Looking at the git history, it probably got
exported by mistake when we split up locks_copy_lock and
locks_copy_conflock, as the former was exported.

I think this approach is quite doable...
--=20
Jeff Layton <jlayton@kernel.org>
