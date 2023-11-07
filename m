Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8E7E4771
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Nov 2023 18:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjKGRql convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 7 Nov 2023 12:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjKGRqX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Nov 2023 12:46:23 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B8F1712;
        Tue,  7 Nov 2023 09:46:11 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SPwKG0Xw6z9xrpS;
        Wed,  8 Nov 2023 01:32:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDXE3S4d0pluDM6AA--.2425S2;
        Tue, 07 Nov 2023 18:45:42 +0100 (CET)
Message-ID: <56bad12bde243ac0a3171922db9795bab0791c95.camel@huaweicloud.com>
Subject: Re: [PATCH v5 11/23] security: Introduce inode_post_removexattr hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Tue, 07 Nov 2023 18:45:25 +0100
In-Reply-To: <85c5dda2-5a2f-4c73-82ae-8a333b69b4a7@schaufler-ca.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
         <20231107134012.682009-12-roberto.sassu@huaweicloud.com>
         <85c5dda2-5a2f-4c73-82ae-8a333b69b4a7@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwDXE3S4d0pluDM6AA--.2425S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryfur1DZr4xWrWrZF4fZrb_yoWrtw1kpF
        s8K3Z0kr4rJFy7WFyktF1Uuw4I9ayFgr17ArW2gw12yFn2yr1IqrWakF15CryrJrWjgF1q
        qFnFkrs5Cr15Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5YfQAADsw
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-11-07 at 09:33 -0800, Casey Schaufler wrote:
> On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> > the inode_post_removexattr hook.
> > 
> > At inode_removexattr hook, EVM verifies the file's existing HMAC value. At
> > inode_post_removexattr, EVM re-calculates the file's HMAC with the passed
> > xattr removed and other file metadata.
> > 
> > Other LSMs could similarly take some action after successful xattr removal.
> > 
> > The new hook cannot return an error and cannot cause the operation to be
> > reverted.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  fs/xattr.c                    |  9 +++++----
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      |  5 +++++
> >  security/security.c           | 14 ++++++++++++++
> >  4 files changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 09d927603433..84a4aa566c02 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
> >  		goto out;
> >  
> >  	error = __vfs_removexattr(idmap, dentry, name);
> > +	if (error)
> > +		goto out;
> 
> Shouldn't this be simply "return error" rather than a goto to nothing
> but "return error"?

Ok, no problem. I can change that.

Thanks

Roberto

> >  
> > -	if (!error) {
> > -		fsnotify_xattr(dentry);
> > -		evm_inode_post_removexattr(dentry, name);
> > -	}
> > +	fsnotify_xattr(dentry);
> > +	security_inode_post_removexattr(dentry, name);
> > +	evm_inode_post_removexattr(dentry, name);
> >  
> >  out:
> >  	return error;
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 67410e085205..88452e45025c 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -149,6 +149,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
> >  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> >  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *name)
> > +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> > +	 const char *name)
> >  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> >  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 664df46b22a9..922ea7709bae 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -380,6 +380,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
> >  int security_inode_listxattr(struct dentry *dentry);
> >  int security_inode_removexattr(struct mnt_idmap *idmap,
> >  			       struct dentry *dentry, const char *name);
> > +void security_inode_post_removexattr(struct dentry *dentry, const char *name);
> >  int security_inode_need_killpriv(struct dentry *dentry);
> >  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
> >  int security_inode_getsecurity(struct mnt_idmap *idmap,
> > @@ -940,6 +941,10 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
> >  	return cap_inode_removexattr(idmap, dentry, name);
> >  }
> >  
> > +static inline void security_inode_post_removexattr(struct dentry *dentry,
> > +						   const char *name)
> > +{ }
> > +
> >  static inline int security_inode_need_killpriv(struct dentry *dentry)
> >  {
> >  	return cap_inode_need_killpriv(dentry);
> > diff --git a/security/security.c b/security/security.c
> > index ce3bc7642e18..8aa6e9f316dd 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2452,6 +2452,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
> >  	return evm_inode_removexattr(idmap, dentry, name);
> >  }
> >  
> > +/**
> > + * security_inode_post_removexattr() - Update the inode after a removexattr op
> > + * @dentry: file
> > + * @name: xattr name
> > + *
> > + * Update the inode after a successful removexattr operation.
> > + */
> > +void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> > +{
> > +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > +		return;
> > +	call_void_hook(inode_post_removexattr, dentry, name);
> > +}
> > +
> >  /**
> >   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
> >   * @dentry: associated dentry

