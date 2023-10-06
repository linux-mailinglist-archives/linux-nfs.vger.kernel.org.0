Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6419C7BB503
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Oct 2023 12:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjJFKWV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Oct 2023 06:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjJFKWU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Oct 2023 06:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA24DAD
        for <linux-nfs@vger.kernel.org>; Fri,  6 Oct 2023 03:22:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE955C433C8;
        Fri,  6 Oct 2023 10:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696587738;
        bh=L6PGvdYR4abq+fMSh13Uu6mxOdeChH/INMOf7Ty7orM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NprbgfieGTdqVu7xRyvArSeOIh825Btof5RD5LoyymuI0hJHpSGAEzeHhoLP5u2Za
         0kFfR0wqEBPtInrWQ16TLbJx/9XBi8lySiUriCNLcffuzYXQOWGeDFKioMGTvh5Ksy
         Nlxv5YqQtLGznWnI5HBbRML31+hGzSvKjSYqZi1PntBE7TV401G+n2qr5rxBFL9ozR
         6C9c9M4JUaehKnGztwCC4RtBby7ODEr8I5vzRsNbEQ9bKzKR8RQHghNr+mntSmKH7F
         uClyKgVpWZyFYZzh6GwLM3XddYCKPZOKaGtGRR5lycN6NuEb9htA9UTCK0LE0AWGAf
         PaXud1jRTRRhA==
Message-ID: <935f32e3fe9daf234ff547de1efa2bdcdfa6288e.camel@kernel.org>
Subject: Re: [PATCH v4 1/1] nfs42: client needs to strip file mode's
 suid/sgid bit after ALLOCATE op
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, anna@kernel.org
Cc:     trondmy@hammerspace.com, linux-nfs@vger.kernel.org
Date:   Fri, 06 Oct 2023 06:22:16 -0400
In-Reply-To: <1695105020-5886-1-git-send-email-dai.ngo@oracle.com>
References: <1695105020-5886-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-09-18 at 23:30 -0700, Dai Ngo wrote:
> The Linux NFS server strips the SUID and SGID from the file mode
> on ALLOCATE op.
>=20
> Modify _nfs42_proc_fallocate to add NFS_INO_REVAL_FORCED to
> nfs_set_cache_invalid's argument to force update of the file
> mode suid/sgid bit.
>=20
> Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
> v3 -> v4: add Suggested-by and Reviewed-by tag.
>=20
>  fs/nfs/nfs42proc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 63802d195556..9d2f07feeb29 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -81,7 +81,8 @@ static int _nfs42_proc_fallocate(struct rpc_message *ms=
g, struct file *filep,
>  	if (status =3D=3D 0) {
>  		if (nfs_should_remove_suid(inode)) {
>  			spin_lock(&inode->i_lock);
> -			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
> +			nfs_set_cache_invalid(inode,
> +				NFS_INO_REVAL_FORCED | NFS_INO_INVALID_MODE);
>  			spin_unlock(&inode->i_lock);
>  		}
>  		status =3D nfs_post_op_update_inode_force_wcc(inode,

This fixes generic/683 and generic/684 for me, when nfsd has issued a
write delegation. This was posted some time ago. Is there some reason
this hasn't been merged yet?

Tested-by: Jeff Layton <jlayton@kernel.org>
