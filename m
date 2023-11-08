Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C757E4F92
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Nov 2023 04:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjKHDmi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Nov 2023 22:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHDmh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Nov 2023 22:42:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7413818C;
        Tue,  7 Nov 2023 19:42:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D38C433C7;
        Wed,  8 Nov 2023 03:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699414955;
        bh=FHJSt6kZtXx4ILd8DGDkhSrjysEg2O+K9F8kVqG0aKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWEeWkK0SMRDXg+vLARaKDp4eY6YdEa64mOvnmuTXOWdMjYfWETtJUiPu3qY3Hysk
         4LSEpc9dYfkzYX7g+al6cSuLAgDYpKHRP2mup9JRPb9e/5zjchsBgqWnDrbYowWf9o
         JXJkdsYkju/REM9+kegMkELz/TLUR8XEO8gftnzeUcG4ZPPkXz4HlcwoiX57arxoOR
         497OH+iqcR3VxDUMU3A+OR05jPgcI/pWScJ13aPmc7QdGcMKr+TCrdqSlbH3XAXWDw
         +hlzM/DVqfzlLBER49uo8vk6c6avLr24JVCdZ+gCZ+w6p5P9GNfkudf47jMAr59Ou4
         Ltd6ELYpy6t/w==
Date:   Tue, 7 Nov 2023 19:42:31 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     j.granados@samsung.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
        fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu
Subject: Re: [PATCH 2/4] aio: Remove the now superfluous sentinel elements
 from ctl_table array
Message-ID: <20231108034231.GB2482@sol.localdomain>
References: <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_fs-v1-2-7176632fea9f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_fs-v1-2-7176632fea9f@samsung.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 07, 2023 at 02:44:21PM +0100, Joel Granados via B4 Relay wrote:
> [PATCH 2/4] aio: Remove the now superfluous sentinel elements from ctl_table array

The commit prefix should be "fs:".

> Remove sentinel elements ctl_table struct. Special attention was placed in
> making sure that an empty directory for fs/verity was created when
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not defined. In this case we use the
> register sysctl call that expects a size.
[...]
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index d071a6e32581..8191bf7ad706 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -122,8 +122,8 @@ void __init fsverity_init_info_cache(void);
>  
>  /* signature.c */
>  
> -#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  extern int fsverity_require_signatures;
> +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  int fsverity_verify_signature(const struct fsverity_info *vi,
>  			      const u8 *signature, size_t sig_size);
>  
> diff --git a/fs/verity/init.c b/fs/verity/init.c
> index a29f062f6047..e31045dd4f6c 100644
> --- a/fs/verity/init.c
> +++ b/fs/verity/init.c
> @@ -13,7 +13,6 @@
>  static struct ctl_table_header *fsverity_sysctl_header;
>  
>  static struct ctl_table fsverity_sysctl_table[] = {
> -#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  	{
>  		.procname       = "require_signatures",
>  		.data           = &fsverity_require_signatures,
> @@ -23,14 +22,17 @@ static struct ctl_table fsverity_sysctl_table[] = {
>  		.extra1         = SYSCTL_ZERO,
>  		.extra2         = SYSCTL_ONE,
>  	},
> -#endif
> -	{ }
>  };
>  
>  static void __init fsverity_init_sysctl(void)
>  {
> +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  	fsverity_sysctl_header = register_sysctl("fs/verity",
>  						 fsverity_sysctl_table);
> +#else
> +	fsverity_sysctl_header = register_sysctl_sz("fs/verity",
> +						 fsverity_sysctl_table, 0);
> +#endif
>  	if (!fsverity_sysctl_header)
>  		panic("fsverity sysctl registration failed");

This does not make sense, and it causes a build error when CONFIG_FS_VERITY=y
and CONFIG_FS_VERITY_BUILTIN_SIGNATURES=n.

I think all you need to do is delete the sentinel element, the same as
everywhere else.  I just tested it, and it works fine.

BTW, the comments for register_sysctl_sz() and __register_sysctl_table() are
outdated, as they still say "A completely 0 filled entry terminates the table."

- Eric
