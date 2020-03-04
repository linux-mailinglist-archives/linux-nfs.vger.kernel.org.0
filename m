Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132751791D8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2020 15:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCDOBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Mar 2020 09:01:42 -0500
Received: from mailomta28-sa.btinternet.com ([213.120.69.34]:35662 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgCDOBm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Mar 2020 09:01:42 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2020 09:01:39 EST
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200304135600.LLWN5147.sa-prd-fep-045.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Wed, 4 Mar 2020 13:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1583330160; 
        bh=hWTO8Pnju1Jw+CN+ilIZh6ikJ02pleJAuekp30eohCk=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=pwQqyxu9zWAdEMPR63tO15it+WBEKfdO+Jnwf9GKuXRNz/OmvY6JyZ1wn17nlqx1jY9nATmYsRutudX1EUSaJ6FmkR/M01/lKTbbiFp1Y5M1F84m2ZtFSTnl19wt2OIVV60RqJqBP1pc/fYOyUpT6fq/slI5T1V0b4ePlyEdCbMka61LadSdZrm0MuHY1AFnKdgdqhjLqunb0+kRnkDXAqRaBSaRHY4+3j+uTpmf+zv2lkwOyqeAGDlm/cq07esMVuA8NPJJg7YZxyiTxwx3lbNb/1vuS9bng9HcH02sUfYqeloOIe75tS9KaFxowYVp5njnfl7bJopXBRGXKiw8AQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [81.153.63.233]
X-OWM-Source-IP: 81.153.63.233 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddtkedgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkedurdduheefrdeifedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdeifedrvdeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegrnhhnrgdrshgthhhumhgrkhgvrhesnhgvthgrphhprdgtohhmqedprhgtphhtthhopeeosghfihgvlhgushesfhhivghlughsvghsrdhorhhgqedprhgtphhtthhopeeolhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedp
        rhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhmrgihhhgvfiesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeothhrohhnugdrmhihkhhlvggsuhhstheshhgrmhhmvghrshhprggtvgdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.63.233) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A24110478E039; Wed, 4 Mar 2020 13:56:00 +0000
Message-ID: <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Scott Mayhew <smayhew@redhat.com>, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Cc:     bfields@fieldses.org, paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org
Date:   Wed, 04 Mar 2020 13:55:59 +0000
In-Reply-To: <20200303225837.1557210-1-smayhew@redhat.com>
References: <20200303225837.1557210-1-smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2020-03-03 at 17:58 -0500, Scott Mayhew wrote:
> When using NFSv4.2, the security label for the root inode should be
> set
> via a call to nfs_setsecurity() during the mount process, otherwise
> the
> inode will appear as unlabeled for up to acdirmin seconds.  Currently
> the label for the root inode is allocated, retrieved, and freed
> entirely
> witin nfs4_proc_get_root().
> 
> Add a field for the label to the nfs_fattr struct, and allocate &
> free
> the label in nfs_get_root(), where we also add a call to
> nfs_setsecurity().  Note that for the call to nfs_setsecurity() to
> succeed, it's necessary to also move the logic calling
> security_sb_{set,clone}_security() from nfs_get_tree_common() down
> into
> nfs_get_root()... otherwise the SBLABEL_MNT flag will not be set in
> the
> super_block's security flags and nfs_setsecurity() will silently
> fail.

I built and tested this patch on selinux-next (note that the NFS module
is a few patches behind).
The unlabeled problem is solved, however using:

mount -t nfs -o
vers=4.2,rootcontext=system_u:object_r:test_filesystem_file_t:s0
localhost:$TESTDIR /mnt/selinux-testsuite

I get the message:
    mount.nfs: an incorrect mount option was specified
with a log entry:
    SELinux: mount invalid.  Same superblock, different security
settings for (dev 0:42, type nfs)

If I use "fscontext=" instead then works okay. Using no context option
also works. I guess the rootcontext= option should still work ???

> 
> Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfs/getroot.c        | 39 +++++++++++++++++++++++++++++++++++----
>  fs/nfs/nfs4proc.c       | 12 +++---------
>  fs/nfs/super.c          | 25 -------------------------
>  include/linux/nfs_xdr.h |  1 +
>  4 files changed, 39 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
> index b012c2668a1f..6d0628149390 100644
> --- a/fs/nfs/getroot.c
> +++ b/fs/nfs/getroot.c
> @@ -73,6 +73,7 @@ int nfs_get_root(struct super_block *s, struct
> fs_context *fc)
>  	struct inode *inode;
>  	char *name;
>  	int error = -ENOMEM;
> +	unsigned long kflags = 0, kflags_out = 0;
>  
>  	name = kstrdup(fc->source, GFP_KERNEL);
>  	if (!name)
> @@ -83,11 +84,14 @@ int nfs_get_root(struct super_block *s, struct
> fs_context *fc)
>  	if (fsinfo.fattr == NULL)
>  		goto out_name;
>  
> +	fsinfo.fattr->label = nfs4_label_alloc(server, GFP_KERNEL);
> +	if (IS_ERR(fsinfo.fattr->label))
> +		goto out_fattr;
>  	error = server->nfs_client->rpc_ops->getroot(server, ctx-
> >mntfh, &fsinfo);
>  	if (error < 0) {
>  		dprintk("nfs_get_root: getattr error = %d\n", -error);
>  		nfs_errorf(fc, "NFS: Couldn't getattr on root");
> -		goto out_fattr;
> +		goto out_label;
>  	}
>  
>  	inode = nfs_fhget(s, ctx->mntfh, fsinfo.fattr, NULL);
> @@ -95,12 +99,12 @@ int nfs_get_root(struct super_block *s, struct
> fs_context *fc)
>  		dprintk("nfs_get_root: get root inode failed\n");
>  		error = PTR_ERR(inode);
>  		nfs_errorf(fc, "NFS: Couldn't get root inode");
> -		goto out_fattr;
> +		goto out_label;
>  	}
>  
>  	error = nfs_superblock_set_dummy_root(s, inode);
>  	if (error != 0)
> -		goto out_fattr;
> +		goto out_label;
>  
>  	/* root dentries normally start off anonymous and get spliced
> in later
>  	 * if the dentry tree reaches them; however if the dentry
> already
> @@ -111,7 +115,7 @@ int nfs_get_root(struct super_block *s, struct
> fs_context *fc)
>  		dprintk("nfs_get_root: get root dentry failed\n");
>  		error = PTR_ERR(root);
>  		nfs_errorf(fc, "NFS: Couldn't get root dentry");
> -		goto out_fattr;
> +		goto out_label;
>  	}
>  
>  	security_d_instantiate(root, inode);
> @@ -123,12 +127,39 @@ int nfs_get_root(struct super_block *s, struct
> fs_context *fc)
>  	}
>  	spin_unlock(&root->d_lock);
>  	fc->root = root;
> +	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
> +		kflags |= SECURITY_LSM_NATIVE_LABELS;
> +	if (ctx->clone_data.sb) {
> +		if (d_inode(fc->root)->i_fop != &nfs_dir_operations) {
> +			error = -ESTALE;
> +			goto error_splat_root;
> +		}
> +		/* clone any lsm security options from the parent to
> the new sb */
> +		error = security_sb_clone_mnt_opts(ctx->clone_data.sb,
> s, kflags,
> +				&kflags_out);
> +	} else {
> +		error = security_sb_set_mnt_opts(s, fc->security,
> +							kflags,
> &kflags_out);
> +	}
> +	if (error)
> +		goto error_splat_root;
> +	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
> +		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
> +		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
> +
> +	nfs_setsecurity(inode, fsinfo.fattr, fsinfo.fattr->label);
>  	error = 0;
>  
> +out_label:
> +	nfs4_label_free(fsinfo.fattr->label);
>  out_fattr:
>  	nfs_free_fattr(fsinfo.fattr);
>  out_name:
>  	kfree(name);
>  out:
>  	return error;
> +error_splat_root:
> +	dput(fc->root);
> +	fc->root = NULL;
> +	goto out_label;
>  }
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 69b7ab7a5815..cb34e840e4fb 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4002,7 +4002,7 @@ static int nfs4_proc_get_root(struct nfs_server
> *server, struct nfs_fh *mntfh,
>  {
>  	int error;
>  	struct nfs_fattr *fattr = info->fattr;
> -	struct nfs4_label *label = NULL;
> +	struct nfs4_label *label = fattr->label;
>  
>  	error = nfs4_server_capabilities(server, mntfh);
>  	if (error < 0) {
> @@ -4010,23 +4010,17 @@ static int nfs4_proc_get_root(struct
> nfs_server *server, struct nfs_fh *mntfh,
>  		return error;
>  	}
>  
> -	label = nfs4_label_alloc(server, GFP_KERNEL);
> -	if (IS_ERR(label))
> -		return PTR_ERR(label);
> -
>  	error = nfs4_proc_getattr(server, mntfh, fattr, label, NULL);
>  	if (error < 0) {
>  		dprintk("nfs4_get_root: getattr error = %d\n", -error);
> -		goto err_free_label;
> +		goto out;
>  	}
>  
>  	if (fattr->valid & NFS_ATTR_FATTR_FSID &&
>  	    !nfs_fsid_equal(&server->fsid, &fattr->fsid))
>  		memcpy(&server->fsid, &fattr->fsid, sizeof(server-
> >fsid));
>  
> -err_free_label:
> -	nfs4_label_free(label);
> -
> +out:
>  	return error;
>  }
>  
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index dada09b391c6..bb14bede6da5 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1179,7 +1179,6 @@ int nfs_get_tree_common(struct fs_context *fc)
>  	struct super_block *s;
>  	int (*compare_super)(struct super_block *, struct fs_context *)
> = nfs_compare_super;
>  	struct nfs_server *server = ctx->server;
> -	unsigned long kflags = 0, kflags_out = 0;
>  	int error;
>  
>  	ctx->server = NULL;
> @@ -1239,26 +1238,6 @@ int nfs_get_tree_common(struct fs_context *fc)
>  		goto error_splat_super;
>  	}
>  
> -	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
> -		kflags |= SECURITY_LSM_NATIVE_LABELS;
> -	if (ctx->clone_data.sb) {
> -		if (d_inode(fc->root)->i_fop != &nfs_dir_operations) {
> -			error = -ESTALE;
> -			goto error_splat_root;
> -		}
> -		/* clone any lsm security options from the parent to
> the new sb */
> -		error = security_sb_clone_mnt_opts(ctx->clone_data.sb,
> s, kflags,
> -				&kflags_out);
> -	} else {
> -		error = security_sb_set_mnt_opts(s, fc->security,
> -							kflags,
> &kflags_out);
> -	}
> -	if (error)
> -		goto error_splat_root;
> -	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
> -		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
> -		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
> -
>  	s->s_flags |= SB_ACTIVE;
>  	error = 0;
>  
> @@ -1268,10 +1247,6 @@ int nfs_get_tree_common(struct fs_context *fc)
>  out_err_nosb:
>  	nfs_free_server(server);
>  	goto out;
> -
> -error_splat_root:
> -	dput(fc->root);
> -	fc->root = NULL;
>  error_splat_super:
>  	deactivate_locked_super(s);
>  	goto out;
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 94c77ed55ce1..6838c149f335 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -75,6 +75,7 @@ struct nfs_fattr {
>  	struct nfs4_string	*owner_name;
>  	struct nfs4_string	*group_name;
>  	struct nfs4_threshold	*mdsthreshold;	/* pNFS threshold
> hints */
> +	struct nfs4_label	*label;
>  };
>  
>  #define NFS_ATTR_FATTR_TYPE		(1U << 0)

