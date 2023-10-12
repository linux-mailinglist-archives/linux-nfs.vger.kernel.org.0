Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D47B7C6DDB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 14:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347228AbjJLMUl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 12 Oct 2023 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbjJLMUg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 08:20:36 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A497126;
        Thu, 12 Oct 2023 05:20:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4S5pKy2DbRz9xv4k;
        Thu, 12 Oct 2023 20:07:34 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3EJJg5CdlX2YTAg--.31697S2;
        Thu, 12 Oct 2023 13:19:58 +0100 (CET)
Message-ID: <2336abd6ae195eda221d54e3c2349a4760afaff2.camel@huaweicloud.com>
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
Date:   Thu, 12 Oct 2023 14:19:41 +0200
In-Reply-To: <c16551704db68c6e0ba89c729c892e9401f05dfc.camel@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
         <20230904133415.1799503-3-roberto.sassu@huaweicloud.com>
         <a733fe780a3197150067ad35ed280bf85e11fa97.camel@linux.ibm.com>
         <b51baf7741de1fdee8b36a87bd2dde71184d47a8.camel@huaweicloud.com>
         <8646e30b0074a2932076b5a0a792b14be034de98.camel@linux.ibm.com>
         <16c8c95f2e63ab9a2fba8cba919bf129d0541b61.camel@huaweicloud.com>
         <c16551704db68c6e0ba89c729c892e9401f05dfc.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwC3EJJg5CdlX2YTAg--.31697S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF15CrWfCFWxAFW7Aw1rXrb_yoWxXry7pF
        W8J3WDGrs8Xry7Cr10va15Aa4Sq347tr1UXrn0gw17tryDtF1DXF1fWr4Y9ryrKr4UGr1U
        XF1Utr9xu3yUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5TzGQAAsC
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-10-12 at 07:42 -0400, Mimi Zohar wrote:
> On Thu, 2023-10-12 at 09:29 +0200, Roberto Sassu wrote:
> > On Wed, 2023-10-11 at 15:01 -0400, Mimi Zohar wrote:
> > > On Wed, 2023-10-11 at 18:02 +0200, Roberto Sassu wrote:
> > > > On Wed, 2023-10-11 at 10:38 -0400, Mimi Zohar wrote:
> > > > > On Mon, 2023-09-04 at 15:33 +0200, Roberto Sassu wrote:
> > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > 
> > > > > > Change ima_post_path_mknod() definition, so that it can be registered as
> > > > > > implementation of the path_post_mknod hook. Since LSMs see a umask-stripped
> > > > > > mode from security_path_mknod(), pass the same to ima_post_path_mknod() as
> > > > > > well.
> > > > > > Also, make sure that ima_post_path_mknod() is executed only if
> > > > > > (mode & S_IFMT) is equal to zero or S_IFREG.
> > > > > > 
> > > > > > Add this check to take into account the different placement of the
> > > > > > path_post_mknod hook (to be introduced) in do_mknodat().
> > > > > 
> > > > > Move "(to be introduced)" to when it is first mentioned.
> > > > > 
> > > > > > Since the new hook
> > > > > > will be placed after the switch(), the check ensures that
> > > > > > ima_post_path_mknod() is invoked as originally intended when it is
> > > > > > registered as implementation of path_post_mknod.
> > > > > > 
> > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > ---
> > > > > >  fs/namei.c                        |  9 ++++++---
> > > > > >  include/linux/ima.h               |  7 +++++--
> > > > > >  security/integrity/ima/ima_main.c | 10 +++++++++-
> > > > > >  3 files changed, 20 insertions(+), 6 deletions(-)
> > > > > > 
> > > > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > > > index e56ff39a79bc..c5e96f716f98 100644
> > > > > > --- a/fs/namei.c
> > > > > > +++ b/fs/namei.c
> > > > > > @@ -4024,6 +4024,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > > > > >  	struct path path;
> > > > > >  	int error;
> > > > > >  	unsigned int lookup_flags = 0;
> > > > > > +	umode_t mode_stripped;
> > > > > >  
> > > > > >  	error = may_mknod(mode);
> > > > > >  	if (error)
> > > > > > @@ -4034,8 +4035,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > > > > >  	if (IS_ERR(dentry))
> > > > > >  		goto out1;
> > > > > >  
> > > > > > -	error = security_path_mknod(&path, dentry,
> > > > > > -			mode_strip_umask(path.dentry->d_inode, mode), dev);
> > > > > > +	mode_stripped = mode_strip_umask(path.dentry->d_inode, mode);
> > > > > > +
> > > > > > +	error = security_path_mknod(&path, dentry, mode_stripped, dev);
> > > > > >  	if (error)
> > > > > >  		goto out2;
> > > > > >  
> > > > > > @@ -4045,7 +4047,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > > > > >  			error = vfs_create(idmap, path.dentry->d_inode,
> > > > > >  					   dentry, mode, true);
> > > > > >  			if (!error)
> > > > > > -				ima_post_path_mknod(idmap, dentry);
> > > > > > +				ima_post_path_mknod(idmap, &path, dentry,
> > > > > > +						    mode_stripped, dev);
> > > > > >  			break;
> > > > > >  		case S_IFCHR: case S_IFBLK:
> > > > > >  			error = vfs_mknod(idmap, path.dentry->d_inode,
> > > > > > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > > > > > index 910a2f11a906..179ce52013b2 100644
> > > > > > --- a/include/linux/ima.h
> > > > > > +++ b/include/linux/ima.h
> > > > > > @@ -32,7 +32,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
> > > > > >  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
> > > > > >  			      enum kernel_read_file_id id);
> > > > > >  extern void ima_post_path_mknod(struct mnt_idmap *idmap,
> > > > > > -				struct dentry *dentry);
> > > > > > +				const struct path *dir, struct dentry *dentry,
> > > > > > +				umode_t mode, unsigned int dev);
> > > > > >  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
> > > > > >  extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
> > > > > >  extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> > > > > > @@ -114,7 +115,9 @@ static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
> > > > > >  }
> > > > > >  
> > > > > >  static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
> > > > > > -				       struct dentry *dentry)
> > > > > > +				       const struct path *dir,
> > > > > > +				       struct dentry *dentry,
> > > > > > +				       umode_t mode, unsigned int dev)
> > > > > >  {
> > > > > >  	return;
> > > > > >  }
> > > > > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > > > > index 365db0e43d7c..76eba92d7f10 100644
> > > > > > --- a/security/integrity/ima/ima_main.c
> > > > > > +++ b/security/integrity/ima/ima_main.c
> > > > > > @@ -696,18 +696,26 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> > > > > >  /**
> > > > > >   * ima_post_path_mknod - mark as a new inode
> > > > > >   * @idmap: idmap of the mount the inode was found from
> > > > > > + * @dir: path structure of parent of the new file
> > > > > >   * @dentry: newly created dentry
> > > > > > + * @mode: mode of the new file
> > > > > > + * @dev: undecoded device number
> > > > > >   *
> > > > > >   * Mark files created via the mknodat syscall as new, so that the
> > > > > >   * file data can be written later.
> > > > > >   */
> > > > > >  void ima_post_path_mknod(struct mnt_idmap *idmap,
> > > > > > -			 struct dentry *dentry)
> > > > > > +			 const struct path *dir, struct dentry *dentry,
> > > > > > +			 umode_t mode, unsigned int dev)
> > > > > >  {
> > > > > >  	struct integrity_iint_cache *iint;
> > > > > >  	struct inode *inode = dentry->d_inode;
> > > > > >  	int must_appraise;
> > > > > >  
> > > > > > +	/* See do_mknodat(), IMA is executed for case 0: and case S_IFREG: */
> > > > > > +	if ((mode & S_IFMT) != 0 && (mode & S_IFMT) != S_IFREG)
> > > > > > +		return;
> > > > > > +
> > > > > 
> > > > > There's already a check below to make sure that this is a regular file.
> > > > > Are both needed?
> > > > 
> > > > You are right, I can remove the first check.
> > > 
> > > The question then becomes why modify hook the arguments?   
> > 
> > We need to make sure that ima_post_path_mknod() has the same parameters
> > as the LSM hook at the time we register it to the LSM infrastructure.
> 
> I'm trying to understand why the pre hook parameters and the missing
> IMA parameter are used, as opposed to just defining the new
> post_path_mknod hook like IMA.

As an empyrical rule, I pass the same parameters as the corresponding
pre hook (plus idmap, in this case). This is similar to the
inode_setxattr hook. But I can be wrong, if desired I can reduce.

Thanks

Roberto

> thanks,
> 
> Mimi
> 
> > 
> > > > 
> > > > > >  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> > > > > >  		return;
> > > > > >  
> > > > 
> > > 
> > 
> 

