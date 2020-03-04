Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0EA17926B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2020 15:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCDOhP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 4 Mar 2020 09:37:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48643 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727084AbgCDOhP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Mar 2020 09:37:15 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-_yZxS1EPP5CFRYZGihITAw-1; Wed, 04 Mar 2020 09:37:06 -0500
X-MC-Unique: _yZxS1EPP5CFRYZGihITAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9148018A9;
        Wed,  4 Mar 2020 14:37:04 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-120-213.rdu2.redhat.com [10.10.120.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3789790796;
        Wed,  4 Mar 2020 14:37:03 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 7A4F81A0107; Wed,  4 Mar 2020 09:37:01 -0500 (EST)
Date:   Wed, 4 Mar 2020 09:37:01 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@fieldses.org, paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
Message-ID: <20200304143701.GB3175@aion.usersys.redhat.com>
References: <20200303225837.1557210-1-smayhew@redhat.com>
 <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
MIME-Version: 1.0
In-Reply-To: <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 04 Mar 2020, Richard Haines wrote:

> On Tue, 2020-03-03 at 17:58 -0500, Scott Mayhew wrote:
> > When using NFSv4.2, the security label for the root inode should be
> > set
> > via a call to nfs_setsecurity() during the mount process, otherwise
> > the
> > inode will appear as unlabeled for up to acdirmin seconds.  Currently
> > the label for the root inode is allocated, retrieved, and freed
> > entirely
> > witin nfs4_proc_get_root().
> > 
> > Add a field for the label to the nfs_fattr struct, and allocate &
> > free
> > the label in nfs_get_root(), where we also add a call to
> > nfs_setsecurity().  Note that for the call to nfs_setsecurity() to
> > succeed, it's necessary to also move the logic calling
> > security_sb_{set,clone}_security() from nfs_get_tree_common() down
> > into
> > nfs_get_root()... otherwise the SBLABEL_MNT flag will not be set in
> > the
> > super_block's security flags and nfs_setsecurity() will silently
> > fail.
> 
> I built and tested this patch on selinux-next (note that the NFS module
> is a few patches behind).
> The unlabeled problem is solved, however using:
> 
> mount -t nfs -o
> vers=4.2,rootcontext=system_u:object_r:test_filesystem_file_t:s0
> localhost:$TESTDIR /mnt/selinux-testsuite
> 
> I get the message:
>     mount.nfs: an incorrect mount option was specified
> with a log entry:
>     SELinux: mount invalid.  Same superblock, different security
> settings for (dev 0:42, type nfs)
> 
> If I use "fscontext=" instead then works okay. Using no context option
> also works. I guess the rootcontext= option should still work ???

Thanks for testing.  It definitely wasn't my intention to break
anything, so I'll look into it.

-Scott
> 
> > 
> > Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  fs/nfs/getroot.c        | 39 +++++++++++++++++++++++++++++++++++----
> >  fs/nfs/nfs4proc.c       | 12 +++---------
> >  fs/nfs/super.c          | 25 -------------------------
> >  include/linux/nfs_xdr.h |  1 +
> >  4 files changed, 39 insertions(+), 38 deletions(-)
> > 
> > diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
> > index b012c2668a1f..6d0628149390 100644
> > --- a/fs/nfs/getroot.c
> > +++ b/fs/nfs/getroot.c
> > @@ -73,6 +73,7 @@ int nfs_get_root(struct super_block *s, struct
> > fs_context *fc)
> >  	struct inode *inode;
> >  	char *name;
> >  	int error = -ENOMEM;
> > +	unsigned long kflags = 0, kflags_out = 0;
> >  
> >  	name = kstrdup(fc->source, GFP_KERNEL);
> >  	if (!name)
> > @@ -83,11 +84,14 @@ int nfs_get_root(struct super_block *s, struct
> > fs_context *fc)
> >  	if (fsinfo.fattr == NULL)
> >  		goto out_name;
> >  
> > +	fsinfo.fattr->label = nfs4_label_alloc(server, GFP_KERNEL);
> > +	if (IS_ERR(fsinfo.fattr->label))
> > +		goto out_fattr;
> >  	error = server->nfs_client->rpc_ops->getroot(server, ctx-
> > >mntfh, &fsinfo);
> >  	if (error < 0) {
> >  		dprintk("nfs_get_root: getattr error = %d\n", -error);
> >  		nfs_errorf(fc, "NFS: Couldn't getattr on root");
> > -		goto out_fattr;
> > +		goto out_label;
> >  	}
> >  
> >  	inode = nfs_fhget(s, ctx->mntfh, fsinfo.fattr, NULL);
> > @@ -95,12 +99,12 @@ int nfs_get_root(struct super_block *s, struct
> > fs_context *fc)
> >  		dprintk("nfs_get_root: get root inode failed\n");
> >  		error = PTR_ERR(inode);
> >  		nfs_errorf(fc, "NFS: Couldn't get root inode");
> > -		goto out_fattr;
> > +		goto out_label;
> >  	}
> >  
> >  	error = nfs_superblock_set_dummy_root(s, inode);
> >  	if (error != 0)
> > -		goto out_fattr;
> > +		goto out_label;
> >  
> >  	/* root dentries normally start off anonymous and get spliced
> > in later
> >  	 * if the dentry tree reaches them; however if the dentry
> > already
> > @@ -111,7 +115,7 @@ int nfs_get_root(struct super_block *s, struct
> > fs_context *fc)
> >  		dprintk("nfs_get_root: get root dentry failed\n");
> >  		error = PTR_ERR(root);
> >  		nfs_errorf(fc, "NFS: Couldn't get root dentry");
> > -		goto out_fattr;
> > +		goto out_label;
> >  	}
> >  
> >  	security_d_instantiate(root, inode);
> > @@ -123,12 +127,39 @@ int nfs_get_root(struct super_block *s, struct
> > fs_context *fc)
> >  	}
> >  	spin_unlock(&root->d_lock);
> >  	fc->root = root;
> > +	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
> > +		kflags |= SECURITY_LSM_NATIVE_LABELS;
> > +	if (ctx->clone_data.sb) {
> > +		if (d_inode(fc->root)->i_fop != &nfs_dir_operations) {
> > +			error = -ESTALE;
> > +			goto error_splat_root;
> > +		}
> > +		/* clone any lsm security options from the parent to
> > the new sb */
> > +		error = security_sb_clone_mnt_opts(ctx->clone_data.sb,
> > s, kflags,
> > +				&kflags_out);
> > +	} else {
> > +		error = security_sb_set_mnt_opts(s, fc->security,
> > +							kflags,
> > &kflags_out);
> > +	}
> > +	if (error)
> > +		goto error_splat_root;
> > +	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
> > +		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
> > +		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
> > +
> > +	nfs_setsecurity(inode, fsinfo.fattr, fsinfo.fattr->label);
> >  	error = 0;
> >  
> > +out_label:
> > +	nfs4_label_free(fsinfo.fattr->label);
> >  out_fattr:
> >  	nfs_free_fattr(fsinfo.fattr);
> >  out_name:
> >  	kfree(name);
> >  out:
> >  	return error;
> > +error_splat_root:
> > +	dput(fc->root);
> > +	fc->root = NULL;
> > +	goto out_label;
> >  }
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 69b7ab7a5815..cb34e840e4fb 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -4002,7 +4002,7 @@ static int nfs4_proc_get_root(struct nfs_server
> > *server, struct nfs_fh *mntfh,
> >  {
> >  	int error;
> >  	struct nfs_fattr *fattr = info->fattr;
> > -	struct nfs4_label *label = NULL;
> > +	struct nfs4_label *label = fattr->label;
> >  
> >  	error = nfs4_server_capabilities(server, mntfh);
> >  	if (error < 0) {
> > @@ -4010,23 +4010,17 @@ static int nfs4_proc_get_root(struct
> > nfs_server *server, struct nfs_fh *mntfh,
> >  		return error;
> >  	}
> >  
> > -	label = nfs4_label_alloc(server, GFP_KERNEL);
> > -	if (IS_ERR(label))
> > -		return PTR_ERR(label);
> > -
> >  	error = nfs4_proc_getattr(server, mntfh, fattr, label, NULL);
> >  	if (error < 0) {
> >  		dprintk("nfs4_get_root: getattr error = %d\n", -error);
> > -		goto err_free_label;
> > +		goto out;
> >  	}
> >  
> >  	if (fattr->valid & NFS_ATTR_FATTR_FSID &&
> >  	    !nfs_fsid_equal(&server->fsid, &fattr->fsid))
> >  		memcpy(&server->fsid, &fattr->fsid, sizeof(server-
> > >fsid));
> >  
> > -err_free_label:
> > -	nfs4_label_free(label);
> > -
> > +out:
> >  	return error;
> >  }
> >  
> > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > index dada09b391c6..bb14bede6da5 100644
> > --- a/fs/nfs/super.c
> > +++ b/fs/nfs/super.c
> > @@ -1179,7 +1179,6 @@ int nfs_get_tree_common(struct fs_context *fc)
> >  	struct super_block *s;
> >  	int (*compare_super)(struct super_block *, struct fs_context *)
> > = nfs_compare_super;
> >  	struct nfs_server *server = ctx->server;
> > -	unsigned long kflags = 0, kflags_out = 0;
> >  	int error;
> >  
> >  	ctx->server = NULL;
> > @@ -1239,26 +1238,6 @@ int nfs_get_tree_common(struct fs_context *fc)
> >  		goto error_splat_super;
> >  	}
> >  
> > -	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
> > -		kflags |= SECURITY_LSM_NATIVE_LABELS;
> > -	if (ctx->clone_data.sb) {
> > -		if (d_inode(fc->root)->i_fop != &nfs_dir_operations) {
> > -			error = -ESTALE;
> > -			goto error_splat_root;
> > -		}
> > -		/* clone any lsm security options from the parent to
> > the new sb */
> > -		error = security_sb_clone_mnt_opts(ctx->clone_data.sb,
> > s, kflags,
> > -				&kflags_out);
> > -	} else {
> > -		error = security_sb_set_mnt_opts(s, fc->security,
> > -							kflags,
> > &kflags_out);
> > -	}
> > -	if (error)
> > -		goto error_splat_root;
> > -	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
> > -		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
> > -		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
> > -
> >  	s->s_flags |= SB_ACTIVE;
> >  	error = 0;
> >  
> > @@ -1268,10 +1247,6 @@ int nfs_get_tree_common(struct fs_context *fc)
> >  out_err_nosb:
> >  	nfs_free_server(server);
> >  	goto out;
> > -
> > -error_splat_root:
> > -	dput(fc->root);
> > -	fc->root = NULL;
> >  error_splat_super:
> >  	deactivate_locked_super(s);
> >  	goto out;
> > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > index 94c77ed55ce1..6838c149f335 100644
> > --- a/include/linux/nfs_xdr.h
> > +++ b/include/linux/nfs_xdr.h
> > @@ -75,6 +75,7 @@ struct nfs_fattr {
> >  	struct nfs4_string	*owner_name;
> >  	struct nfs4_string	*group_name;
> >  	struct nfs4_threshold	*mdsthreshold;	/* pNFS threshold
> > hints */
> > +	struct nfs4_label	*label;
> >  };
> >  
> >  #define NFS_ATTR_FATTR_TYPE		(1U << 0)
> 

