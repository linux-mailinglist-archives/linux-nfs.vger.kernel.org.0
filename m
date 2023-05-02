Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64A6F498F
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 20:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEBSQi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 14:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEBSQh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 14:16:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D278CEC;
        Tue,  2 May 2023 11:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 619C061F53;
        Tue,  2 May 2023 18:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512CAC433D2;
        Tue,  2 May 2023 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683051395;
        bh=IZXUSj//bQ71zV7usY+Sn70SF28HYftJz+7q71IaAc8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i8fQnwpkD3np685SKxYPicHji+RYqLpnOBqHWyRLRSShtAL5ad0IdR1ZhJC/pJ664
         WutY6jnnnsb15+MQURjZkXcTJnBDeduh6cfyq/QJm09cpJ59rqMw0yzGKG2gqnaqYq
         sE0SEnMCDzRpKVRoZaYhJC0XAIVEPIyXMu6LBhW1XwsenG+rT9VQJs0zZtYqotOi0/
         fR95v90ykP1hys58Tb4U+KHw60mcyh8YkKWg3vbMYcVHR4dKxxbI8QgRo9Yw2b2K4o
         Parf4/cAi9RCqi+ckgJRHQnxHIE/7Vr0IyDMIE2w0ls4SHdTIFoEInO0YuYiXr+Boo
         NupZI26jxe9xQ==
Message-ID: <db82df959da68781fa284483821a45d65f3aeddd.camel@kernel.org>
Subject: Re: [PATCH] nfsd: define exports_proc_ops with CONFIG_PROC_FS
From:   Jeff Layton <jlayton@kernel.org>
To:     Tom Rix <trix@redhat.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 May 2023 14:16:33 -0400
In-Reply-To: <20230502171121.2929222-1-trix@redhat.com>
References: <20230502171121.2929222-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-05-02 at 13:11 -0400, Tom Rix wrote:
> gcc with W=3D1 and ! CONFIG_PROC_FS
> fs/nfsd/nfsctl.c:161:30: error: =E2=80=98exports_proc_ops=E2=80=99
>   defined but not used [-Werror=3Dunused-const-variable=3D]
>   161 | static const struct proc_ops exports_proc_ops =3D {
>       |                              ^~~~~~~~~~~~~~~~
>=20
> The only use of exports_proc_ops is when CONFIG_PROC_FS
> is defined, so its definition should be likewise conditional.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  fs/nfsd/nfsctl.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7b8f17ee5224..c159817d1282 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -153,18 +153,6 @@ static int exports_net_open(struct net *net, struct =
file *file)
>  	return 0;
>  }
> =20
> -static int exports_proc_open(struct inode *inode, struct file *file)
> -{
> -	return exports_net_open(current->nsproxy->net_ns, file);
> -}
> -
> -static const struct proc_ops exports_proc_ops =3D {
> -	.proc_open	=3D exports_proc_open,
> -	.proc_read	=3D seq_read,
> -	.proc_lseek	=3D seq_lseek,
> -	.proc_release	=3D seq_release,
> -};
> -
>  static int exports_nfsd_open(struct inode *inode, struct file *file)
>  {
>  	return exports_net_open(inode->i_sb->s_fs_info, file);
> @@ -1458,6 +1446,19 @@ static struct file_system_type nfsd_fs_type =3D {
>  MODULE_ALIAS_FS("nfsd");
> =20
>  #ifdef CONFIG_PROC_FS
> +
> +static int exports_proc_open(struct inode *inode, struct file *file)
> +{
> +	return exports_net_open(current->nsproxy->net_ns, file);
> +}
> +
> +static const struct proc_ops exports_proc_ops =3D {
> +	.proc_open	=3D exports_proc_open,
> +	.proc_read	=3D seq_read,
> +	.proc_lseek	=3D seq_lseek,
> +	.proc_release	=3D seq_release,
> +};
> +
>  static int create_proc_exports_entry(void)
>  {
>  	struct proc_dir_entry *entry;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
