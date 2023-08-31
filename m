Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F382478F3B4
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 21:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjHaT5R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjHaT5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 15:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B3FE5B
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 12:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EF576204D
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 19:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83858C433C8;
        Thu, 31 Aug 2023 19:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693511833;
        bh=skulouPIwW9yFPTQ33GlfoXESEyR2o9/GFfX8Ht2mlQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kduS+VF6LsUi3XZ7jCL8B/LOC3F2tjntA4uu2c/6VPXfz+kM08pPBhfthNToMlm70
         AUaOj9AMYcrrZH7xU6nJjs0WEYoFG1fR8QdCDMXf18hAKjgKCK0as/qTHsW8924soq
         WGnmx3sXphn1w7jH/OLDt/xezm2p53fAM9tkCiSSK5e9p2qPASZRheorga2mIQyGLo
         xd67PRsLLThquyeD1ObE4SaXRIwDGMWYscIC6jO8pOMOfGa19Owf0HWK5wLq/1cAP1
         Wnl9fDWwq/odHfgnKwO+uSWsfSO36rReMkOsStm5qLlwbomd0ieikCM+THH9UdwFnX
         RD8DBs94dn8bg==
Message-ID: <40e1d5aa2fcc18edbbff6a7c99bbc883b6ed79f6.camel@kernel.org>
Subject: Re: [PATCH v3 1/1] nfs42: client needs to strip file mode's
 suid/sgid bit after ALLOCATE op
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, trondmy@hammerspace.com,
        anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 31 Aug 2023 15:57:11 -0400
In-Reply-To: <1692918707-30648-1-git-send-email-dai.ngo@oracle.com>
References: <1692918707-30648-1-git-send-email-dai.ngo@oracle.com>
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

On Thu, 2023-08-24 at 16:11 -0700, Dai Ngo wrote:
> The Linux NFS server strips the SUID and SGID from the file mode
> on ALLOCATE op.
>=20
> Modify _nfs42_proc_fallocate to add NFS_INO_REVAL_FORCED to
> nfs_set_cache_invalid's argument to force update of the
> file mode suid/sgid bit.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
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

Yeah, I think this looks like the right thing to do. IIUC,
NFS_INO_REVAL_FORCED just means "ignore the fact that I have a
delegation", which I think is what we want here.

If this turns out to be too expensive, another idea might be to only set
FORCED here if the current mode has bits that would be cleared on a
write (i.e. setuid/setgid bits with execute bits set under them). We
don't expect "stealth" mode changes unless that's the case.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
