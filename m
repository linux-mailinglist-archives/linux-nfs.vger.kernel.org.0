Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D6457555B
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiGNSuY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiGNSuG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 14:50:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9B0474E7
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 11:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E93AEB82875
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 18:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1551DC34114;
        Thu, 14 Jul 2022 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657824601;
        bh=+7ABenY2YSpCnrhob1Ti0qnN0pSROrxpNQiery4teH0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bUvX+txN4MszTcA/rjCJRGTUQhjFDcVd1Jqp/+bAj445LDyKzIrVZEqzN0iUDd5ig
         DR++Z4BbMBddYHk4e1c6BSk3cXkkeyCcxFj9Rl44xolN11BB3IYmXIv6LMZYvtkdBz
         z9YDq6pd9VT3MwaCQDC1kyCyp3RpC5lKTiUnvrBd5cLkMG0IyoYw5c48meJmHcywJL
         fQ/sBcx7R/81KP+G7GM7ntYDsX2L0iotLw7Li/y+1lFZUEtUcpGvNFTjyhBp8egEzw
         okFRhlOLfflrLzR9XSe8NPmGa4jO2hON+Iqp20H+AprjhwPloTIjwmYD6lZf5N/DVq
         Sjwt8uEg8yV+Q==
Message-ID: <2d6fb0c2f74a75308243d10cc0531a8ccfdfc703.camel@kernel.org>
Subject: Re: [RFC PATCH 3/3] nfsd: vet the opened dentry after setting a
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 14 Jul 2022 14:49:59 -0400
In-Reply-To: <87EC2FB8-EA8A-4322-8725-A6494B606317@oracle.com>
References: <20220714152819.128276-1-jlayton@kernel.org>
         <20220714152819.128276-4-jlayton@kernel.org>
         <F7B94422-F889-49DA-AA38-0D8AA1F9B682@oracle.com>
         <fc9e2f339e9a84912e9e4644292bec44b5e49137.camel@kernel.org>
         <87EC2FB8-EA8A-4322-8725-A6494B606317@oracle.com>
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

On Thu, 2022-07-14 at 17:16 +0000, Chuck Lever III wrote:
>=20
> > On Jul 14, 2022, at 1:11 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Thu, 2022-07-14 at 16:53 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Jul 14, 2022, at 11:28 AM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > >=20
> > > > Between opening a file and setting a delegation on it, someone coul=
d
> > > > rename or unlink the dentry. If this happens, we do not want to gra=
nt a
> > > > delegation on the open.
> > > >=20
> > > > Take the i_rwsem before setting the delegation. If we're granted a
> > > > lease, redo the lookup of the file being opened and validate that t=
he
> > > > resulting dentry matches the one in the open file description. We o=
nly
> > > > need to do this for the CLAIM_NULL open case however.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > fs/nfsd/nfs4state.c | 55 ++++++++++++++++++++++++++++++++++++++++--=
---
> > > > 1 file changed, 50 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 347794028c98..e5c7f6690d2d 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -1172,6 +1172,7 @@ alloc_init_deleg(struct nfs4_client *clp, str=
uct nfs4_file *fp,
> > > >=20
> > > > void
> > > > nfs4_put_stid(struct nfs4_stid *s)
> > > > +	__releases(&clp->cl_lock)
> > > > {
> > > > 	struct nfs4_file *fp =3D s->sc_file;
> > > > 	struct nfs4_client *clp =3D s->sc_client;
> > >=20
> > > This hunk causes a bunch of new sparse warnings:
> > >=20
> > > /home/cel/src/linux/klimt/include/linux/list.h:137:19: warning: conte=
xt imbalance in 'put_clnt_odstate' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1174:1: warning: contex=
t imbalance in 'nfs4_put_stid' - different lock contexts for basic block
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1230:13: warning: conte=
xt imbalance in 'destroy_unhashed_deleg' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1528:17: warning: conte=
xt imbalance in 'release_lock_stateid' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1624:17: warning: conte=
xt imbalance in 'release_last_closed_stateid' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:2212:22: warning: conte=
xt imbalance in '__destroy_client' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4481:17: warning: conte=
xt imbalance in 'nfsd4_find_and_lock_existing_open' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4557:25: warning: conte=
xt imbalance in 'init_open_stateid' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4606:17: warning: conte=
xt imbalance in 'move_to_close_lru' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4752:13: warning: conte=
xt imbalance in 'nfsd4_cb_recall_release' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5003:17: warning: conte=
xt imbalance in 'nfs4_check_deleg' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5392:9: warning: contex=
t imbalance in 'nfs4_set_delegation' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5467:9: warning: contex=
t imbalance in 'nfs4_open_delegation' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5619:17: warning: conte=
xt imbalance in 'nfsd4_process_open2' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5638:17: warning: conte=
xt imbalance in 'nfsd4_cleanup_open_state' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5934:27: warning: conte=
xt imbalance in 'nfs4_laundromat' - different lock contexts for basic block
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6160:17: warning: conte=
xt imbalance in 'nfsd4_lookup_stateid' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6374:25: warning: conte=
xt imbalance in 'nfs4_preprocess_stateid_op' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6422:9: warning: contex=
t imbalance in 'nfsd4_free_lock_stateid' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6459:28: warning: conte=
xt imbalance in 'nfsd4_free_stateid' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6528:17: warning: conte=
xt imbalance in 'nfs4_preprocess_seqid_op' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6545:17: warning: conte=
xt imbalance in 'nfs4_preprocess_confirmed_seqid_op' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6588:9: warning: contex=
t imbalance in 'nfsd4_open_confirm' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6657:9: warning: contex=
t imbalance in 'nfsd4_open_downgrade' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6730:9: warning: contex=
t imbalance in 'nfsd4_close' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6762:9: warning: contex=
t imbalance in 'nfsd4_delegreturn' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7034:17: warning: conte=
xt imbalance in 'init_lock_stateid' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7063:17: warning: conte=
xt imbalance in 'find_or_create_lock_stateid' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7362:17: warning: conte=
xt imbalance in 'nfsd4_lock' - unexpected unlock
> > > /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7535:9: warning: contex=
t imbalance in 'nfsd4_locku' - unexpected unlock
> > >=20
> > > Let's repair the "/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1185:=
9:
> > > warning: context imbalance in 'nfs4_put_stid' - unexpected unlock" me=
ssage
> > > in a separate patch.
> > >=20
> >=20
> >=20
> > Yeah, I saw that too after I sent this. That hunk doesn't belong in
> > here. I'll drop it from my local copy.
>=20
> Well, I'm interested in trying to get rid of the existing sparse
> warnings too, since those tend to block our ability to see new
> warnings that arise.
>=20
> If you have suggestions or proposals, please send them!
>=20

We should definitely annotate these functions that have unbalanced
locking like this one. That's the usual way to silence these sorts of
warnings. I'm hoping Neil's patches will make it easier to address.

--=20
Jeff Layton <jlayton@kernel.org>
