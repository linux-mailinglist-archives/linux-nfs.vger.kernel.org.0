Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75811628869
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiKNSiR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 13:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiKNSiJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 13:38:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94E30F54
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 10:38:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD9D61342
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 18:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CE6C433C1;
        Mon, 14 Nov 2022 18:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668451087;
        bh=t8xhwOQYTxlThbP6wCDA4cM2FKoSxaG6kD+KWLY4ISI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YfJqfnK4Ax1Pl4AnCHqGA3wHS6Jz43ORz1ktHxYDRABX4VXIIV9V0s+vLtbyCUXm7
         o/YC25CDHhWeLH3TKpgpEfewpi92nm7iDBIyQE0cNYa139/p1309cOKIfuPch3IPbS
         NyIrgZ6qrYRFNUz+3Ly1Zi/QOF99xgWWCwIurTsuh9VvOOBRM8CSIBP+D1fPlxWsup
         c5CfAN51ZErOLeOA3Hfv01fbpeE472ujFC3z83uGM0P+Rrwt9IU5DnvpH4FX89Z0DF
         KfiwHVI/CLvzyRb1l3xfgjsjFS+BW6EtyQsLVnPX/R510r4xKLvcOTChoXWJMy9d9F
         1f1kg9FHaYhsg==
Message-ID: <1e2722cee7cc03f0da0623a7d45b9531973c0906.camel@kernel.org>
Subject: Re: [PATCH 3/4] lockd: fix file selection in nlmsvc_cancel_blocked
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 14 Nov 2022 13:38:05 -0500
In-Reply-To: <55593a438387aca9187a8a8ea1e0d3c2cc4efb9b.camel@kernel.org>
References: <20221111193639.346992-1-jlayton@kernel.org>
         <20221111193639.346992-4-jlayton@kernel.org>
         <1AE4E7CF-F76B-42E8-90D7-5DA52AFDE66E@oracle.com>
         <55593a438387aca9187a8a8ea1e0d3c2cc4efb9b.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-11-11 at 16:52 -0500, Jeff Layton wrote:
> On Fri, 2022-11-11 at 20:29 +0000, Chuck Lever III wrote:
> >=20
> > > On Nov 11, 2022, at 2:36 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > We currently do a lock_to_openmode call based on the arguments from t=
he
> > > NLM_UNLOCK call, but that will always set the fl_type of the lock to
> > > F_UNLCK, the the O_RDONLY descriptor is always chosen.
> >=20
> > Except for the above sentence, these all look sane to me.
> > I can apply them to nfsd's for-next once they've seen some
> > review on fsdevel, as you mentioned in the other thread.
> >=20
> >=20
>=20
> Thanks. That should say "and the O_RDONLY...". Fixed in my tree.
>=20
> I'll go ahead and resend with fsdevel included.
>=20

I reposted the series Friday afternoon.

What might be best is for you to carry the first 3 patches in the nfsd
tree, and I'll take the filelock: patch into the locks-next branch,
along with the other filelock API cleanups.

Sound OK?

> > > Fix it to use the file_lock from the block instead.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > fs/lockd/svclock.c | 7 ++++---
> > > 1 file changed, 4 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > index 9eae99e08e69..4e30f3c50970 100644
> > > --- a/fs/lockd/svclock.c
> > > +++ b/fs/lockd/svclock.c
> > > @@ -699,9 +699,10 @@ nlmsvc_cancel_blocked(struct net *net, struct nl=
m_file *file, struct nlm_lock *l
> > > 	block =3D nlmsvc_lookup_block(file, lock);
> > > 	mutex_unlock(&file->f_mutex);
> > > 	if (block !=3D NULL) {
> > > -		mode =3D lock_to_openmode(&lock->fl);
> > > -		vfs_cancel_lock(block->b_file->f_file[mode],
> > > -				&block->b_call->a_args.lock.fl);
> > > +		struct file_lock *fl =3D &block->b_call->a_args.lock.fl;
> > > +
> > > +		mode =3D lock_to_openmode(fl);
> > > +		vfs_cancel_lock(block->b_file->f_file[mode], fl);
> > > 		status =3D nlmsvc_unlink_block(block);
> > > 		nlmsvc_release_block(block);
> > > 	}
> > > --=20
> > > 2.38.1
> > >=20
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
