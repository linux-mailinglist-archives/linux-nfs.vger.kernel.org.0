Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B502774709
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 21:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjHHTIq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 15:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjHHTIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 15:08:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A20DAD0A
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 09:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 463EE624E3
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 11:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E570C433C7;
        Tue,  8 Aug 2023 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691494914;
        bh=J0y+EoVkwIiGNnSgXYIxH9JSH5pvSf26B+QXrDiW0Ts=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gpkjJZfd4lxzg5RkOfZ46lTjQ12GAKIgn4vOcGuzNVcTSS2x1sfw30bs23oBGtk2V
         8uu9duWUyJ9OghWQXMoNgNUdhD7FQOA8/LDjpyCOy6FZfTVpG1AClCJD2b9dz65EBJ
         vlkgne3YCEiL6Ljdk1Ieg5nvEZJC31Ygxl2Muhw37Lz2H/2INd/2dcZia9lkphSVB/
         V8ATqQmumtxRMVGa5W4yGN40JeznM63ayy9GR7M2WwkDiuRC9xEBhdJPA2F+1kabUx
         g+NB63VQyWTVuqV5qI0GcK8ooUaZ3v6NH2dvcMMcQ37xoKDiOZek15PsRLPLcNkneV
         GY/I9quYRPOnw==
Message-ID: <f7072b411e4a8f5d58e2c6a7982d393efa248408.camel@kernel.org>
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, neilb@suse.de
Date:   Tue, 08 Aug 2023 07:41:53 -0400
In-Reply-To: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-08-08 at 10:21 +0200, Lorenzo Bianconi wrote:
> Introduce version field to nfsd_rpc_status handler in order to help
> the user to maintain backward compatibility.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfssvc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 33ad91dd3a2d..6d5feeeb09a7 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1117,6 +1117,9 @@ int nfsd_stats_release(struct inode *inode, struct =
file *file)
>  	return ret;
>  }
> =20
> +/* Increment NFSD_RPC_STATUS_VERSION adding new info to the handler */
> +#define NFSD_RPC_STATUS_VERSION		1
> +
>  static int nfsd_rpc_status_show(struct seq_file *m, void *v)
>  {
>  	struct inode *inode =3D file_inode(m->file);
> @@ -1125,6 +1128,8 @@ static int nfsd_rpc_status_show(struct seq_file *m,=
 void *v)
> =20
>  	rcu_read_lock();
> =20
> +	seq_printf(m, "# version %u\n", NFSD_RPC_STATUS_VERSION);
> +
>  	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
>  		struct svc_rqst *rqstp;
> =20

Should we also add a line that starts with '#' to show what the fields
indicate? Either way, this is fine:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
