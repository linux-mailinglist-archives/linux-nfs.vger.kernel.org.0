Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295B7DB55B
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 09:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjJ3InS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 04:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjJ3InR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 04:43:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F1AB;
        Mon, 30 Oct 2023 01:43:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4250FC433C7;
        Mon, 30 Oct 2023 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698655395;
        bh=xUUBnEzx5bke2+28JgdYEHbvIfQzUUFXXsOQ+iz0rGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4HGx57mG57AaY9MNBVEmLiSXnJYwd2H4v5e5uUXIlr4M80wlepa0PG8CsZJZaJ1P
         dGDUEJ8YJBE9oCP0Ii+hToJrIghlNHFuj69sweWDVE1uHA1fFjnaLctMT7ZSw2lH1/
         wpewVfkydBhu/NuEc12OvHh0MfFMStuoJbA7ACX0=
Date:   Mon, 30 Oct 2023 09:43:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ChenXiaoSong <chenxiaosongemail@foxmail.com>
Cc:     trond.myklebust@hammerspace.com, chenxiaosong@kylinos.cn,
        Anna.Schumaker@netapp.com, sashal@kernel.org,
        liuzhengyuan@kylinos.cn, huangjinhui@kylinos.cn,
        liuyun01@kylinos.cn, huhai@kylinos.cn, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt
 file writeout due to fatal errors"
Message-ID: <2023103055-anaerobic-childhood-c1f1@gregkh>
References: <tencent_BEDA418B8BD86995FBF3E92D4F9F5D342C0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_BEDA418B8BD86995FBF3E92D4F9F5D342C0A@qq.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 30, 2023 at 04:39:11PM +0800, ChenXiaoSong wrote:
> Hi Trond and Greg:
> 
> LTS 4.19 reported null-ptr-deref BUG as follows:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000080
> Call Trace:
>  nfs_inode_add_request+0x1cc/0x5b8
>  nfs_setup_write_request+0x1fa/0x1fc
>  nfs_writepage_setup+0x2d/0x7d
>  nfs_updatepage+0x8b8/0x936
>  nfs_write_end+0x61d/0xd45
>  generic_perform_write+0x19a/0x3f0
>  nfs_file_write+0x2cc/0x6e5
>  new_sync_write+0x442/0x560
>  __vfs_write+0xda/0xef
>  vfs_write+0x176/0x48b
>  ksys_write+0x10a/0x1e9
>  __se_sys_write+0x24/0x29
>  __x64_sys_write+0x79/0x93
>  do_syscall_64+0x16d/0x4bb
>  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
> 
> The reason is: generic_error_remove_page set page->mapping to NULL when nfs
> server have a fatal error:
> 
> nfs_updatepage
>   nfs_writepage_setup
>     nfs_setup_write_request
>       nfs_try_to_update_request // return NULL
>         nfs_wb_page // return 0
>           nfs_writepage_locked // return 0
>             nfs_do_writepage // return 0
>               nfs_page_async_flush // return 0
>                 nfs_error_is_fatal_on_server
>                 generic_error_remove_page
>                   truncate_inode_page
>                     delete_from_page_cache
>                       __delete_from_page_cache
>                         page_cache_tree_delete
>                           page->mapping = NULL // this is point
>       nfs_create_request
>         req->wb_page    = page // the page is freed
>       nfs_inode_add_request
>         mapping = page_file_mapping(req->wb_page)
>           return page->mapping
>         spin_lock(&mapping->private_lock) // mapping is NULL
> 
> It is reasonable by reverting the patch "89047634f5ce NFS: Don't interrupt
> file writeout due to fatal errors" to fix this bug?

Try it and see, but note, that came from the 4.19.99 release which was
released years ago, are you sure you are using the most recent 4.19.y
release?

> This patch is one patch of patchset [Fix up soft mounts for NFSv4.x](https://lore.kernel.org/all/20190407175912.23528-1-trond.myklebust@hammerspace.com/),
> the patchset replace custom error reporting mechanism. it seams that we
> should merge all the patchset to LTS 4.19, or all patchs should not be
> merged. And the "Fixes:" label is not correct, this patch is a refactoring
> patch, not for fixing bugs.

If we missed some patches, that should be added on top of the current
tree, please let us know the git commit ids of them after you have
tested them that they work properly, and we will gladly apply them.

thanks,

greg k-h
