Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A222A798768
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Sep 2023 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjIHMzZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Sep 2023 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjIHMzY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Sep 2023 08:55:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B219AB;
        Fri,  8 Sep 2023 05:55:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA56C433C9;
        Fri,  8 Sep 2023 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694177719;
        bh=5UrZavcjPgOqABU589fSS46E/YZyUyE7h1ODOiEr+Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1ocHcn38rHTuaClDLwPDGl6YZjY5UQPsUk6vkAWOyjgpEQ3cjhmTeTxJH4ldrCd8
         KSvlkBOVobzFPJAhtqte3lOapjyLQU6Crb1elh7++siqDg8umoGSAPEudGdoNC2KvD
         DUxjsaSPkUrfl4tUN46niaPa4V+bWYePEsRXT+KCFMwtqe+l9ulgt5cuR4RdF3trAT
         hSpC+iQ9pf3A/mplv/p8VmjK3kukxaZPtOl+6xSUuZnXTdaeGWotwQBxInPjJcha7P
         zjeaZRpX1pu4bcrLxOWIMclwkBYZdPB2ebkkaqDAnW+AOg/4M/fS9QPFkSf7xPs4he
         6bDbY/17aIkUg==
Date:   Fri, 8 Sep 2023 14:55:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Subject: Re: [PATCH RFC] nfs4: add a get_acl stub handler
Message-ID: <20230908-bandbreite-orgel-065607d1b281@brauner>
References: <20230907-kdevops-v1-1-c2015c29d634@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907-kdevops-v1-1-c2015c29d634@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 07, 2023 at 01:32:36PM -0400, Jeff Layton wrote:
> In older kernels, attempting to fetch that system.posix_acl_access on
> NFSv4 would return -EOPNOTSUPP, but in more recent kernels that returns
> -ENODATA.
> 
> Most filesystems that don't support POSIX ACLs leave the SB_POSIXACL
> flag clear, which cues the VFS to return -EOPNOTSUPP in this situation.
> We can't do that with NFSv4 since that flag also cues the VFS to avoid
> applying the umask early.
> 
> Fix this by adding a stub get_acl handler for NFSv4 that always returns
> -EOPNOTSUPP.
> 
> Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I suspect that this problem popped in due to some VFS layer changes. I
> haven't identified the patch that broke it, but I think this is probably
> the least invasive way to fix it.
> 
> Another alternative would be to return -EOPNOTSUPP on filesystems that
> set SB_POSIXACL but that don't set get_acl or get_inode_acl.
> 
> Thoughts?

Yes: I hate POSIX ACLs. ;)

Before the VFS rework to only rely on i_op->*acl* methods POSIX ACLs
were set using sb->s_xattr handlers. So when a filesystem raised
SB_POSIXACL but didn't set sb->s_xattr handlers for POSIX ACLs we would:

__vfs_getxattr()
-> xattr_resolve_name()
  // no match so return EOPNOTSUPP

No we have

vfs_get_acl()
-> __get_acl()
   -> i_op->get_acl
   // no get_acl inode method return ENODATA

So as a bugfix to backport I think you should do exactly what you do
here because I'm not sure if some fs relies on ENODATA to be returned if
no get_acl inode method is set. There's a lot of quirkiness everywhere.
But we should look through all callers and if nothing relies on EINVAL
just start returning EOPNOTSUPP if no get_acl i_op is set.

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
