Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7D20B421
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgFZPET (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgFZPET (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 11:04:19 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EDBC03E979;
        Fri, 26 Jun 2020 08:04:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 444FC1509; Fri, 26 Jun 2020 11:04:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 444FC1509
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593183858;
        bh=bDhiMSq/GuETPNBoBRrqQk+14eY/oLGXmwAu+loUjFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z46yHmAVdfOD1RLsbxo3o9Pfe0jZAW37yZSCdgaogotBo6AHkm3wne1hjcmko9VjX
         Gu1KX1odzxFesm7Dmqrit35fzOMuF1JDx9L1H3IWCjBwS4ODsSDqdAC1ItPCMishX6
         OaVtOUC+WHZzwXlheKRiqrWfUhZPxVYLAo4PewoI=
Date:   Fri, 26 Jun 2020 11:04:18 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Luo Xiaogang <lxgrxd@163.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, falcon <falcon@tinylab.org>
Subject: Re: Re: [PATCH] nfsd: fix kernel crash when load nfsd in docker
Message-ID: <20200626150418.GA3565@fieldses.org>
References: <20200615071211.31326-1-lxgrxd@163.com>
 <20200624012901.GC18460@fieldses.org>
 <cd7401f.3001.172f0a9407f.Coremail.lxgrxd@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7401f.3001.172f0a9407f.Coremail.lxgrxd@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 26, 2020 at 08:45:23PM +0800, Luo Xiaogang wrote:
> At 2020-06-24 09:29:01, "J. Bruce Fields" <bfields@fieldses.org> wrote:
> >On Mon, Jun 15, 2020 at 03:12:11PM +0800, Luo Xiaogang wrote:
> >> We load nfsd module in the docker container, kernel crash as following.
> >> 
> >> The 'current->nsproxy->net_ns->gen->ptr[nfsd_net_id]' is overflow in the
> >> nfsd_init_net.
> >> 
> >> We should use the net_ns which is being init in the nfsd_init_net,
> >> not the 'current->nsproxy->net_ns'.
> >
> >Thanks!  Actually, I think my problem was that net init and exit are
> >just the wrong place to be doing this--I moved them to nfsd start/stop
> >instead.
> >
> >And then that exposed the fact that I had an inode leak.
> >
> >Do the following two patches help?
> 
> Just test it on Ubuntu 18.04 + Docker 19.03.6, and the docker image is ubuntu:18.04.
> 
> Your patchset helps, here is my reported-and-tested-by, Thanks very much.
> 
> Reported-and-Tested-by:  Luo Xiaogang <lxgrxd@163.com>

Thank you!

--b.

> 
> 
> >--b.
> >
> >From 16f954bd5c481596a63271a91963bf260e2f3f46 Mon Sep 17 00:00:00 2001
> >From: "J. Bruce Fields" <bfields@redhat.com>
> >Date: Tue, 23 Jun 2020 16:00:33 -0400
> >Subject: [PATCH 1/2] nfsd4: fix nfsdfs reference count loop
> >
> >We don't drop the reference on the nfsdfs filesystem with
> >mntput(nn->nfsd_mnt) until nfsd_exit_net(), but that won't be called
> >until the nfsd module's unloaded, and we can't unload the module as long
> >as there's a reference on nfsdfs.  So this prevents module unloading.
> >
> >Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> >---
> > fs/nfsd/nfs4state.c |  8 +++++++-
> > fs/nfsd/nfsctl.c    | 22 ++++++++++++----------
> > fs/nfsd/nfsd.h      |  3 +++
> > 3 files changed, 22 insertions(+), 11 deletions(-)
> >
> >diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >index bb3d2c32664a..cce2510b2cca 100644
> >--- a/fs/nfsd/nfs4state.c
> >+++ b/fs/nfsd/nfs4state.c
> >@@ -7912,9 +7912,14 @@ nfs4_state_start_net(struct net *net)
> > 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > 	int ret;
> > 
> >-	ret = nfs4_state_create_net(net);
> >+	ret = get_nfsdfs(net);
> > 	if (ret)
> > 		return ret;
> >+	ret = nfs4_state_create_net(net);
> >+	if (ret) {
> >+		mntput(nn->nfsd_mnt);
> >+		return ret;
> >+	}
> > 	locks_start_grace(net, &nn->nfsd4_manager);
> > 	nfsd4_client_tracking_init(net);
> > 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
> >@@ -7984,6 +7989,7 @@ nfs4_state_shutdown_net(struct net *net)
> > 
> > 	nfsd4_client_tracking_exit(net);
> > 	nfs4_state_destroy_net(net);
> >+	mntput(nn->nfsd_mnt);
> > }
> > 
> > void
> >diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> >index b68e96681522..cf98a81ca1ea 100644
> >--- a/fs/nfsd/nfsctl.c
> >+++ b/fs/nfsd/nfsctl.c
> >@@ -1424,6 +1424,18 @@ static struct file_system_type nfsd_fs_type = {
> > };
> > MODULE_ALIAS_FS("nfsd");
> > 
> >+int get_nfsdfs(struct net *net)
> >+{
> >+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >+	struct vfsmount *mnt;
> >+
> >+	mnt =  vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);
> >+	if (IS_ERR(mnt))
> >+		return PTR_ERR(mnt);
> >+	nn->nfsd_mnt = mnt;
> >+	return 0;
> >+}
> >+
> > #ifdef CONFIG_PROC_FS
> > static int create_proc_exports_entry(void)
> > {
> >@@ -1451,7 +1463,6 @@ unsigned int nfsd_net_id;
> > static __net_init int nfsd_init_net(struct net *net)
> > {
> > 	int retval;
> >-	struct vfsmount *mnt;
> > 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > 
> > 	retval = nfsd_export_init(net);
> >@@ -1478,16 +1489,8 @@ static __net_init int nfsd_init_net(struct net *net)
> > 	init_waitqueue_head(&nn->ntf_wq);
> > 	seqlock_init(&nn->boot_lock);
> > 
> >-	mnt =  vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);
> >-	if (IS_ERR(mnt)) {
> >-		retval = PTR_ERR(mnt);
> >-		goto out_mount_err;
> >-	}
> >-	nn->nfsd_mnt = mnt;
> > 	return 0;
> > 
> >-out_mount_err:
> >-	nfsd_reply_cache_shutdown(nn);
> > out_drc_error:
> > 	nfsd_idmap_shutdown(net);
> > out_idmap_error:
> >@@ -1500,7 +1503,6 @@ static __net_exit void nfsd_exit_net(struct net *net)
> > {
> > 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > 
> >-	mntput(nn->nfsd_mnt);
> > 	nfsd_reply_cache_shutdown(nn);
> > 	nfsd_idmap_shutdown(net);
> > 	nfsd_export_shutdown(net);
> >diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >index 36cdd81b6688..57c832d1b30f 100644
> >--- a/fs/nfsd/nfsd.h
> >+++ b/fs/nfsd/nfsd.h
> >@@ -90,6 +90,8 @@ void		nfsd_destroy(struct net *net);
> > 
> > bool		i_am_nfsd(void);
> > 
> >+int get_nfsdfs(struct net *);
> >+
> > struct nfsdfs_client {
> > 	struct kref cl_ref;
> > 	void (*cl_release)(struct kref *kref);
> >@@ -100,6 +102,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
> > 		struct nfsdfs_client *ncl, u32 id, const struct tree_descr *);
> > void nfsd_client_rmdir(struct dentry *dentry);
> > 
> >+
> > #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > #ifdef CONFIG_NFSD_V2_ACL
> > extern const struct svc_version nfsd_acl_version2;
> >-- 
> >2.26.2
> >
> >
> >From 51de3b460b39e862f7dcfd4d600e8de0afe73e29 Mon Sep 17 00:00:00 2001
> >From: "J. Bruce Fields" <bfields@redhat.com>
> >Date: Tue, 23 Jun 2020 21:01:19 -0400
> >Subject: [PATCH 2/2] nfsd: fix nfsdfs inode reference count leak
> >
> >I don't understand this code well, but  I'm seeing a warning about a
> >still-referenced inode on unmount, and every other similar filesystem
> >does a dput() here.
> >
> >Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> >---
> > fs/nfsd/nfsctl.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> >index cf98a81ca1ea..cd05732f8eaa 100644
> >--- a/fs/nfsd/nfsctl.c
> >+++ b/fs/nfsd/nfsctl.c
> >@@ -1335,6 +1335,7 @@ void nfsd_client_rmdir(struct dentry *dentry)
> > 	WARN_ON_ONCE(ret);
> > 	fsnotify_rmdir(dir, dentry);
> > 	d_delete(dentry);
> >+	dput(dentry);
> > 	inode_unlock(dir);
> > }
> > 
> >-- 
> >2.26.2
