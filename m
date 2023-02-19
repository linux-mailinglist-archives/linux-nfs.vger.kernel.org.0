Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD07D69C300
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Feb 2023 23:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBSW6L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Feb 2023 17:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBSW6K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Feb 2023 17:58:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112C9773
        for <linux-nfs@vger.kernel.org>; Sun, 19 Feb 2023 14:58:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CED8960C43
        for <linux-nfs@vger.kernel.org>; Sun, 19 Feb 2023 22:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC14C433D2;
        Sun, 19 Feb 2023 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676847488;
        bh=b9cmBQjDE7vrW6ALS860NwqHusS2n0RZdv/818JelOY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hBFdbp2RmYLDMcu2+3qHOxgpmqgj/RXurLfwjLar2iNq1qeTPd1IzkrwVhXJ9qFBH
         2Ry9GdYSFU79rNFD2Hul7SNySMn3OawOUHB1mZUUbo9iavQnmz05t+tZsRFN91NDs9
         TNoabD6goxk/9kzjnvFZGE28iqmkroIxTGmCI0FshP0ZY0tXseX/G+ZiUUiUxlWZ3u
         +zEdizidYjMR1RyZzKRxDiqV2m7q7fexSdDcAELxwH+q5zgEY9NUk56xEdwyqcRJ16
         PPI7Sq/W4Xt6oSYP1e1skXPARRJJ5SCPYQicJLDZwVyVQrsOq00xipucjzpYHNpWqi
         /frm6dzqOpqFg==
Message-ID: <69d0ba15d5f6ec145face427809903605006de5b.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: allow reaping files still under writeback
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Sun, 19 Feb 2023 17:58:06 -0500
In-Reply-To: <ACB5CC34-59DD-42DD-95D4-F4B7CA93552A@oracle.com>
References: <20230215115354.14907-1-jlayton@kernel.org>
         <ACB5CC34-59DD-42DD-95D4-F4B7CA93552A@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-02-19 at 19:45 +0000, Chuck Lever III wrote:
>=20
> > On Feb 15, 2023, at 6:53 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On most filesystems, there is no reason to delay reaping an nfsd_file
> > just because its underlying inode is still under writeback. nfsd just
> > relies on client activity or the local flusher threads to do writeback.
> >=20
> > The main exception is NFS, which flushes all of its dirty data on last
> > close. Add a new EXPORT_OP_FLUSH_ON_CLOSE flag to allow filesystems to
> > signal that they do this, and only skip closing files under writeback o=
n
> > such filesystems.
> >=20
> > Also, remove a redundant NULL file pointer check in
> > nfsd_file_check_writeback, and clean up nfs's export op flag
> > definitions.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> I assume that I'm taking this via the nfsd tree? If so,
> I would like an Acked-by from the NFS client maintainers...
>=20
> For the moment this is going to topic-filecache-cleanups,
> not to nfsd-next.
>=20
>=20

No need to rush on this one, IMO. It's not super-critical or anything.
The topic branch is probably fine.

> > ---
> > fs/nfs/export.c          |  9 ++++++---
> > fs/nfsd/filecache.c      | 11 ++++++++++-
> > include/linux/exportfs.h |  1 +
> > 3 files changed, 17 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > index 0a5ee1754d50..102a454e27c9 100644
> > --- a/fs/nfs/export.c
> > +++ b/fs/nfs/export.c
> > @@ -156,7 +156,10 @@ const struct export_operations nfs_export_ops =3D =
{
> > 	.fh_to_dentry =3D nfs_fh_to_dentry,
> > 	.get_parent =3D nfs_get_parent,
> > 	.fetch_iversion =3D nfs_fetch_iversion,
> > -	.flags =3D EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> > -		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> > -		EXPORT_OP_NOATOMIC_ATTR,
> > +	.flags =3D EXPORT_OP_NOWCC		|
> > +		 EXPORT_OP_NOSUBTREECHK 	|
> > +		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
> > +		 EXPORT_OP_REMOTE_FS		|
> > +		 EXPORT_OP_NOATOMIC_ATTR	|
> > +		 EXPORT_OP_FLUSH_ON_CLOSE,
> > };
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index e6617431df7c..98e1ab013ac0 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -302,8 +302,17 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> > 	struct file *file =3D nf->nf_file;
> > 	struct address_space *mapping;
> >=20
> > -	if (!file || !(file->f_mode & FMODE_WRITE))
> > +	/* File not open for write? */
> > +	if (!(file->f_mode & FMODE_WRITE))
> > 		return false;
> > +
> > +	/*
> > +	 * Some filesystems (e.g. NFS) flush all dirty data on close.
> > +	 * On others, there is no need to wait for writeback.
> > +	 */
> > +	if (!(file_inode(file)->i_sb->s_export_op->flags & EXPORT_OP_FLUSH_ON=
_CLOSE))
> > +		return false;
> > +
> > 	mapping =3D file->f_mapping;
> > 	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> > 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index fe848901fcc3..218fc5c54e90 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -221,6 +221,7 @@ struct export_operations {
> > #define EXPORT_OP_NOATOMIC_ATTR		(0x10) /* Filesystem cannot supply
> > 						  atomic attribute updates
> > 						*/
> > +#define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on clo=
se */
> > 	unsigned long	flags;
> > };
> >=20
> > --=20
> > 2.39.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
