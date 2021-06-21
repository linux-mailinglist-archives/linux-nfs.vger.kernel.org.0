Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EAE3AE359
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhFUGpE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 02:45:04 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55224 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFUGpE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 02:45:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ud4ur3D_1624257759;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ud4ur3D_1624257759)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Jun 2021 14:42:41 +0800
Date:   Mon, 21 Jun 2021 14:42:39 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-nfs@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [RFC PATCH 2/1] nfs: NFSv3: fix SGID bit dropped when inheriting
 ACLs
Message-ID: <YNA03/Y3KxHYuoLu@B-P7TQMD6M-0146.local>
References: <1623990055-222609-1-git-send-email-hsiangkao@linux.alibaba.com>
 <1624007545-142045-1-git-send-email-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1624007545-142045-1-git-send-email-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

( also +cc Andreas Gruenbacher )

tested NFSv3 with -g quick in my environment:
Vanilla:
Failures: generic/258 generic/294 generic/444 generic/467 generic/477 generic/531

Patched:
Failures: generic/258 generic/294 generic/467 generic/477 generic/531

It'd be much helpful to get some hints of this, am I missing something?
Many thanks!

Thanks,
Gao Xiang

On Fri, Jun 18, 2021 at 05:12:25PM +0800, Gao Xiang wrote:
> generic/444 fails with NFSv3 as shown above, "
>      QA output created by 444
>      drwxrwsr-x
>     -drwxrwsr-x
>     +drwxrwxr-x
> ", which tests "SGID inheritance with default ACLs" fs regression
> and looks after the following commits:
> 
> a3bb2d558752 ("ext4: Don't clear SGID when inheriting ACLs")
> 073931017b49 ("posix_acl: Clear SGID bit when setting file permissions")
> 
> commit 055ffbea0596 ("[PATCH] NFS: Fix handling of the umask when
> an NFSv3 default acl is present.") sets acls explicitly when
> when files are created in a directory that has a default ACL.
> However, after commit a3bb2d558752 and 073931017b49, SGID can be
> dropped if user is not member of the owning group with
> set_posix_acl() called.
> 
> Since underlayfs will handle ACL inheritance when creating
> files in a directory that has the default ACL and the umask is
> supposed to be ignored for such case. Therefore, I think no need
> to set acls explicitly (to avoid SGID bit cleared) but only apply
> client umask if the default ACL of the parent directory doesn't
> exist.
> 
> With this patch, generic/444 can pass now.
> 
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> 
> I didn't find the original discussion with Buck Huppmann <buchk@pobox.com>
> about this topic mentioned in
> https://lore.kernel.org/r/20050122203620.108564000@blunzn.suse.de/
> 
> and it's just a rough thought about this issue...
> 
>  fs/nfs/nfs3proc.c | 43 ++++++++++++++++---------------------------
>  1 file changed, 16 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
> index 2299446b3b89..a5676be676be 100644
> --- a/fs/nfs/nfs3proc.c
> +++ b/fs/nfs/nfs3proc.c
> @@ -339,7 +339,7 @@ static void nfs3_free_createdata(struct nfs3_createdata *data)
>  nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
>  		 int flags)
>  {
> -	struct posix_acl *default_acl, *acl;
> +	struct posix_acl *pacl;
>  	struct nfs3_createdata *data;
>  	struct dentry *d_alias;
>  	int status = -ENOMEM;
> @@ -350,6 +350,10 @@ static void nfs3_free_createdata(struct nfs3_createdata *data)
>  	if (data == NULL)
>  		goto out;
>  
> +	pacl = get_acl(dir, ACL_TYPE_DEFAULT);
> +	if (!pacl || pacl == ERR_PTR(-EOPNOTSUPP))
> +		sattr->ia_mode &= ~current_umask();
> +
>  	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_CREATE];
>  	data->arg.create.fh = NFS_FH(dir);
>  	data->arg.create.name = dentry->d_name.name;
> @@ -363,10 +367,6 @@ static void nfs3_free_createdata(struct nfs3_createdata *data)
>  		data->arg.create.verifier[1] = cpu_to_be32(current->pid);
>  	}
>  
> -	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
> -	if (status)
> -		goto out;
> -
>  	for (;;) {
>  		d_alias = nfs3_do_create(dir, dentry, data);
>  		status = PTR_ERR_OR_ZERO(d_alias);
> @@ -416,14 +416,10 @@ static void nfs3_free_createdata(struct nfs3_createdata *data)
>  		if (status != 0)
>  			goto out_dput;
>  	}
> -
> -	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
> -
>  out_dput:
>  	dput(d_alias);
>  out_release_acls:
> -	posix_acl_release(acl);
> -	posix_acl_release(default_acl);
> +	posix_acl_release(pacl);
>  out:
>  	nfs3_free_createdata(data);
>  	dprintk("NFS reply create: %d\n", status);
> @@ -582,7 +578,7 @@ static void nfs3_proc_rename_rpc_prepare(struct rpc_task *task, struct nfs_renam
>  static int
>  nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
>  {
> -	struct posix_acl *default_acl, *acl;
> +	struct posix_acl *pacl;
>  	struct nfs3_createdata *data;
>  	struct dentry *d_alias;
>  	int status = -ENOMEM;
> @@ -593,10 +589,9 @@ static void nfs3_proc_rename_rpc_prepare(struct rpc_task *task, struct nfs_renam
>  	if (data == NULL)
>  		goto out;
>  
> -	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
> -	if (status)
> -		goto out;
> -
> +	pacl = get_acl(dir, ACL_TYPE_DEFAULT);
> +	if (!pacl || pacl == ERR_PTR(-EOPNOTSUPP))
> +		sattr->ia_mode &= ~current_umask();
>  	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_MKDIR];
>  	data->arg.mkdir.fh = NFS_FH(dir);
>  	data->arg.mkdir.name = dentry->d_name.name;
> @@ -612,12 +607,9 @@ static void nfs3_proc_rename_rpc_prepare(struct rpc_task *task, struct nfs_renam
>  	if (d_alias)
>  		dentry = d_alias;
>  
> -	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
> -
>  	dput(d_alias);
>  out_release_acls:
> -	posix_acl_release(acl);
> -	posix_acl_release(default_acl);
> +	posix_acl_release(pacl);
>  out:
>  	nfs3_free_createdata(data);
>  	dprintk("NFS reply mkdir: %d\n", status);
> @@ -713,7 +705,7 @@ static int nfs3_proc_readdir(struct nfs_readdir_arg *nr_arg,
>  nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
>  		dev_t rdev)
>  {
> -	struct posix_acl *default_acl, *acl;
> +	struct posix_acl *pacl;
>  	struct nfs3_createdata *data;
>  	struct dentry *d_alias;
>  	int status = -ENOMEM;
> @@ -725,9 +717,9 @@ static int nfs3_proc_readdir(struct nfs_readdir_arg *nr_arg,
>  	if (data == NULL)
>  		goto out;
>  
> -	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
> -	if (status)
> -		goto out;
> +	pacl = get_acl(dir, ACL_TYPE_DEFAULT);
> +	if (!pacl || pacl == ERR_PTR(-EOPNOTSUPP))
> +		sattr->ia_mode &= ~current_umask();
>  
>  	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_MKNOD];
>  	data->arg.mknod.fh = NFS_FH(dir);
> @@ -762,12 +754,9 @@ static int nfs3_proc_readdir(struct nfs_readdir_arg *nr_arg,
>  	if (d_alias)
>  		dentry = d_alias;
>  
> -	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
> -
>  	dput(d_alias);
>  out_release_acls:
> -	posix_acl_release(acl);
> -	posix_acl_release(default_acl);
> +	posix_acl_release(pacl);
>  out:
>  	nfs3_free_createdata(data);
>  	dprintk("NFS reply mknod: %d\n", status);
> -- 
> 1.8.3.1
