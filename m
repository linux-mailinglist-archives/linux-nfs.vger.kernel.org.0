Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66DF31FDC5
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 18:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhBSRVf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 12:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSRVf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 12:21:35 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8493C061756;
        Fri, 19 Feb 2021 09:20:54 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d8so14861916ejc.4;
        Fri, 19 Feb 2021 09:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHhz1KT9c2LKcLUC0DzO36WEiHbnqm0z++7FywL/tuQ=;
        b=N8TBz4RwewzCmJd03lPfMFXvbyBn0IuO4u//QVuwWImsj40ip1PVOtQCyc2JEO6r70
         EQyXcGwHMhFaEkh5Spx1/Dc6AIQYw20uTDblHvjA07IaGMc56SeIg9lzYmMPNHjPQCK0
         2b7ybUGP30yKsfwxeNJisEgUu+JjDGWPQerxFbEGgeD7UkONG0f84g3rHUO+E6XlJSr7
         wwHRvz2F4Z9UUAISLSLO+p1Lxrgm0fCRxCWpYC9gZbeUndKjTGOpi6K1MXKiRBIB3Rwk
         zsMa+DhG4YznI7VSAlt06lZdijLuVuXkN5ZKqCHH7IbeFYA2d8O43mBbVR959yeMW2qC
         yvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHhz1KT9c2LKcLUC0DzO36WEiHbnqm0z++7FywL/tuQ=;
        b=i6AI7n3J4EFGxgjCqfXdBnVa2MDStMX7h/MgKKfeESPqQTnAXQ2RbUGPIq4lYFG+1V
         7XmRWnJy2nFMRY8nAfXA/xcFKm377r3QQ9e/h+3LSMFx/68fc7INrtKjFZYqclple7xW
         6zNsCpTY5jnLx+maBTsc0jjLByvDHsvrtHDCq7O30vkXYZufYDLYutTh9iTKinCYCj3M
         yxbEJFvYj/iqyT63UOTKzctcz/99dE8gwC5gjt9q5XGxGQzu3XjGoUFQ6mMLb67k5EaL
         OEotqwpG9iT7N5kAdJ8mdM4sEBPHoJpoSK1GPcNpEHw1xwwp9XUDc5W9R8I/zUl/HDmh
         Ab9Q==
X-Gm-Message-State: AOAM5336OftrXTPK/214/lJ87q8D99eVLsbfxF6DXvosdlLuP0if5Qh1
        kmJkaf6jrA00IWxlhV1W4AgNQcwLhL4rsjwnBTY=
X-Google-Smtp-Source: ABdhPJwftaOBR2h+vgda1jIxROpU1ExJYjdDBtKDbDhziEvTcgSsSrvr28jwOb3hy4/HlYzskHRhOn3UKYx8DC6Lnw0=
X-Received: by 2002:a17:906:145b:: with SMTP id q27mr9875777ejc.432.1613755253494;
 Fri, 19 Feb 2021 09:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20210218195046.19280-2-olga.kornievskaia@gmail.com> <20210219081908.GQ2087@kadam>
In-Reply-To: <20210219081908.GQ2087@kadam>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 19 Feb 2021 12:20:46 -0500
Message-ID: <CAN-5tyGrDtfLBXg42XLzp2med482QWPKN_KGXwNH_SP3V5buew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] NFSv4 account for selinux security context when
 deciding to share superblock
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <schumaker.anna@gmail.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond/Anna,

I'd like your opinion here. Some static checking flags a "ctx"
assignment in nfs_fill_super() in the new patch. In an existing code
there is a check for it is NULL before dereferencing. However, "ctx"
can never be null. nfs_get_tree_common() which calls nfs_fill_super()
and passes in "ctx" gets it from the passed in "fs_context". If the
passed in arg can be null then we are dereferencing in var assignment
so things would blow up there. So "ctx" can never be null.

Should I create another clean up patch to remove the check for null
ctx in nfs_fill_super() to make static analyzers happy?

On Fri, Feb 19, 2021 at 3:19 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Olga,
>
> url:    https://github.com/0day-ci/linux/commits/Olga-Kornievskaia/Add-new-hook-to-compare-new-mount-to-an-existing-mount/20210219-035957
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> config: i386-randconfig-m021-20210215 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> fs/nfs/super.c:1061 nfs_fill_super() error: we previously assumed 'ctx' could be null (see line 1029)
>
> vim +/ctx +1061 fs/nfs/super.c
>
> 62a55d088cd87d Scott Mayhew      2019-12-10  1021  static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
> f7b422b17ee5ee David Howells     2006-06-09  1022  {
> 54ceac45159860 David Howells     2006-08-22  1023       struct nfs_server *server = NFS_SB(sb);
> f7b422b17ee5ee David Howells     2006-06-09  1024
> f7b422b17ee5ee David Howells     2006-06-09  1025       sb->s_blocksize_bits = 0;
> f7b422b17ee5ee David Howells     2006-06-09  1026       sb->s_blocksize = 0;
> 6a74490dca8974 Bryan Schumaker   2012-07-30  1027       sb->s_xattr = server->nfs_client->cl_nfs_mod->xattr;
> 6a74490dca8974 Bryan Schumaker   2012-07-30  1028       sb->s_op = server->nfs_client->cl_nfs_mod->sops;
> 5eb005caf5383d David Howells     2019-12-10 @1029       if (ctx && ctx->bsize)
>                                                             ^^^
> Check for NULL
>
> 5eb005caf5383d David Howells     2019-12-10  1030               sb->s_blocksize = nfs_block_size(ctx->bsize, &sb->s_blocksize_bits);
> f7b422b17ee5ee David Howells     2006-06-09  1031
> 6a74490dca8974 Bryan Schumaker   2012-07-30  1032       if (server->nfs_client->rpc_ops->version != 2) {
> 54ceac45159860 David Howells     2006-08-22  1033               /* The VFS shouldn't apply the umask to mode bits. We will do
> 54ceac45159860 David Howells     2006-08-22  1034                * so ourselves when necessary.
> 54ceac45159860 David Howells     2006-08-22  1035                */
> 1751e8a6cb935e Linus Torvalds    2017-11-27  1036               sb->s_flags |= SB_POSIXACL;
> 54ceac45159860 David Howells     2006-08-22  1037               sb->s_time_gran = 1;
> 20fa1902728698 Peng Tao          2017-06-29  1038               sb->s_export_op = &nfs_export_ops;
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1039       } else
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1040               sb->s_time_gran = 1000;
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1041
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1042       if (server->nfs_client->rpc_ops->version != 4) {
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1043               sb->s_time_min = 0;
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1044               sb->s_time_max = U32_MAX;
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1045       } else {
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1046               sb->s_time_min = S64_MIN;
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1047               sb->s_time_max = S64_MAX;
> 54ceac45159860 David Howells     2006-08-22  1048       }
> f7b422b17ee5ee David Howells     2006-06-09  1049
> ab88dca311a372 Al Viro           2019-12-10  1050       sb->s_magic = NFS_SUPER_MAGIC;
> 54ceac45159860 David Howells     2006-08-22  1051
> ab88dca311a372 Al Viro           2019-12-10  1052       /* We probably want something more informative here */
> ab88dca311a372 Al Viro           2019-12-10  1053       snprintf(sb->s_id, sizeof(sb->s_id),
> ab88dca311a372 Al Viro           2019-12-10  1054                "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
> 1fcb79c1b21801 Deepa Dinamani    2019-03-26  1055
> ab88dca311a372 Al Viro           2019-12-10  1056       if (sb->s_blocksize == 0)
> ab88dca311a372 Al Viro           2019-12-10  1057               sb->s_blocksize = nfs_block_bits(server->wsize,
> ab88dca311a372 Al Viro           2019-12-10  1058                                                &sb->s_blocksize_bits);
> f7b422b17ee5ee David Howells     2006-06-09  1059
> ab88dca311a372 Al Viro           2019-12-10  1060       nfs_super_set_maxbytes(sb, server->maxfilesize);
> 52a2a3a4af9af7 Olga Kornievskaia 2021-02-18 @1061       server->has_sec_mnt_opts = ctx->has_sec_mnt_opts;
>                                                                                    ^^^^^^^^^^^^^^^^^^^^^
> Unchecked dereference.  Is the earlier NULL check necessary?  (Actually
> on my system with a built cross function DB, I see that the earlier
> NULL check can be removed.  If the cross function DB were built then
> Smatch would not have printed this warning about inconsistent NULL
> checks).
>
> f7b422b17ee5ee David Howells     2006-06-09  1062  }
> f7b422b17ee5ee David Howells     2006-06-09  1063
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
