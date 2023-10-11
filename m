Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2B7C58C2
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346324AbjJKQC5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 11 Oct 2023 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbjJKQC4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 12:02:56 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBA5B7;
        Wed, 11 Oct 2023 09:02:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4S5HG14sGQz9y5C7;
        Wed, 11 Oct 2023 23:47:21 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwC3WrYCxyZlgBb+AQ--.32343S2;
        Wed, 11 Oct 2023 17:02:24 +0100 (CET)
Message-ID: <b51baf7741de1fdee8b36a87bd2dde71184d47a8.camel@huaweicloud.com>
Subject: Re: [PATCH v3 02/25] ima: Align ima_post_path_mknod() definition
 with LSM infrastructure
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 11 Oct 2023 18:02:07 +0200
In-Reply-To: <a733fe780a3197150067ad35ed280bf85e11fa97.camel@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
         <20230904133415.1799503-3-roberto.sassu@huaweicloud.com>
         <a733fe780a3197150067ad35ed280bf85e11fa97.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwC3WrYCxyZlgBb+AQ--.32343S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1ftrykJw1fCrWfGw1UGFg_yoW7JrWxpF
        Wkt3WDG395Ary7uF10vFW5Aa4Fv392qF45GFZag3WSyF9Igrn0gFsa9F4Y9ryrKFWvkryx
        XF15tr98uw4jyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5TqOgAAs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-10-11 at 10:38 -0400, Mimi Zohar wrote:
> On Mon, 2023-09-04 at 15:33 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Change ima_post_path_mknod() definition, so that it can be registered as
> > implementation of the path_post_mknod hook. Since LSMs see a umask-stripped
> > mode from security_path_mknod(), pass the same to ima_post_path_mknod() as
> > well.
> > Also, make sure that ima_post_path_mknod() is executed only if
> > (mode & S_IFMT) is equal to zero or S_IFREG.
> > 
> > Add this check to take into account the different placement of the
> > path_post_mknod hook (to be introduced) in do_mknodat().
> 
> Move "(to be introduced)" to when it is first mentioned.
> 
> > Since the new hook
> > will be placed after the switch(), the check ensures that
> > ima_post_path_mknod() is invoked as originally intended when it is
> > registered as implementation of path_post_mknod.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  fs/namei.c                        |  9 ++++++---
> >  include/linux/ima.h               |  7 +++++--
> >  security/integrity/ima/ima_main.c | 10 +++++++++-
> >  3 files changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index e56ff39a79bc..c5e96f716f98 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4024,6 +4024,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> >  	struct path path;
> >  	int error;
> >  	unsigned int lookup_flags = 0;
> > +	umode_t mode_stripped;
> >  
> >  	error = may_mknod(mode);
> >  	if (error)
> > @@ -4034,8 +4035,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> >  	if (IS_ERR(dentry))
> >  		goto out1;
> >  
> > -	error = security_path_mknod(&path, dentry,
> > -			mode_strip_umask(path.dentry->d_inode, mode), dev);
> > +	mode_stripped = mode_strip_umask(path.dentry->d_inode, mode);
> > +
> > +	error = security_path_mknod(&path, dentry, mode_stripped, dev);
> >  	if (error)
> >  		goto out2;
> >  
> > @@ -4045,7 +4047,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> >  			error = vfs_create(idmap, path.dentry->d_inode,
> >  					   dentry, mode, true);
> >  			if (!error)
> > -				ima_post_path_mknod(idmap, dentry);
> > +				ima_post_path_mknod(idmap, &path, dentry,
> > +						    mode_stripped, dev);
> >  			break;
> >  		case S_IFCHR: case S_IFBLK:
> >  			error = vfs_mknod(idmap, path.dentry->d_inode,
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 910a2f11a906..179ce52013b2 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -32,7 +32,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
> >  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
> >  			      enum kernel_read_file_id id);
> >  extern void ima_post_path_mknod(struct mnt_idmap *idmap,
> > -				struct dentry *dentry);
> > +				const struct path *dir, struct dentry *dentry,
> > +				umode_t mode, unsigned int dev);
> >  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
> >  extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
> >  extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> > @@ -114,7 +115,9 @@ static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
> >  }
> >  
> >  static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
> > -				       struct dentry *dentry)
> > +				       const struct path *dir,
> > +				       struct dentry *dentry,
> > +				       umode_t mode, unsigned int dev)
> >  {
> >  	return;
> >  }
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 365db0e43d7c..76eba92d7f10 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -696,18 +696,26 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> >  /**
> >   * ima_post_path_mknod - mark as a new inode
> >   * @idmap: idmap of the mount the inode was found from
> > + * @dir: path structure of parent of the new file
> >   * @dentry: newly created dentry
> > + * @mode: mode of the new file
> > + * @dev: undecoded device number
> >   *
> >   * Mark files created via the mknodat syscall as new, so that the
> >   * file data can be written later.
> >   */
> >  void ima_post_path_mknod(struct mnt_idmap *idmap,
> > -			 struct dentry *dentry)
> > +			 const struct path *dir, struct dentry *dentry,
> > +			 umode_t mode, unsigned int dev)
> >  {
> >  	struct integrity_iint_cache *iint;
> >  	struct inode *inode = dentry->d_inode;
> >  	int must_appraise;
> >  
> > +	/* See do_mknodat(), IMA is executed for case 0: and case S_IFREG: */
> > +	if ((mode & S_IFMT) != 0 && (mode & S_IFMT) != S_IFREG)
> > +		return;
> > +
> 
> There's already a check below to make sure that this is a regular file.
> Are both needed?

You are right, I can remove the first check.

Thanks

Roberto

> >  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> >  		return;
> >  

