Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7144AFFCE
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 23:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiBIWCb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 17:02:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiBIWC3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 17:02:29 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103BE00ED7E
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 14:02:26 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee0c.dynamic.kabel-deutschland.de [95.90.238.12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CE25861E6478B;
        Wed,  9 Feb 2022 23:02:23 +0100 (CET)
Message-ID: <d16aac1e-a3aa-309a-0130-c60147c980d1@molgen.mpg.de>
Date:   Wed, 9 Feb 2022 23:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] NFS: LOOKUP_DIRECTORY is also ok with symlinks
Content-Language: en-US
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, it+linux-nfs@molgen.mpg.de,
        Anna Schumaker <Anna.Schumaker@netapp.com>
References: <20220208183823.1391397-1-trondmy@kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220208183823.1391397-1-trondmy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear Trond,


Am 08.02.22 um 19:38 schrieb trondmy@kernel.org:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Commit ac795161c936 (NFSv4: Handle case where the lookup of a directory
> fails) [1], part of Linux since 5.17-rc2, introduced a regression, where
> a symbolic link on an NFS mount to a directory on another NFS does not
> resolve(?) the first time it is accessed:
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Fixes: ac795161c936 ("NFSv4: Handle case where the lookup of a directory fails")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Thank you for fixing it so quickly. My colleague verified, that it fixes 
our issue.

Tested-by: Donald Buczek <buczek@molgen.mpg.de>


Kind regards,

Paul


> ---
>   fs/nfs/dir.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index e128503728f2..6dee4e12d381 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2051,14 +2051,14 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
>   	if (!res) {
>   		inode = d_inode(dentry);
>   		if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
> -		    !S_ISDIR(inode->i_mode))
> +		    !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
>   			res = ERR_PTR(-ENOTDIR);
>   		else if (inode && S_ISREG(inode->i_mode))
>   			res = ERR_PTR(-EOPENSTALE);
>   	} else if (!IS_ERR(res)) {
>   		inode = d_inode(res);
>   		if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
> -		    !S_ISDIR(inode->i_mode)) {
> +		    !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))) {
>   			dput(res);
>   			res = ERR_PTR(-ENOTDIR);
>   		} else if (inode && S_ISREG(inode->i_mode)) {
