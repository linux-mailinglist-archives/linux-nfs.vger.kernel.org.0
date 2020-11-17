Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430C22B5F2F
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 13:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKQMej (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Nov 2020 07:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKQMej (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Nov 2020 07:34:39 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D812222A;
        Tue, 17 Nov 2020 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605616478;
        bh=zK6rNQLrytrMC8Ni88fzOidkRREbmgHDpIg6P9eEFKU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xRGUABE85i5yy6Ck7mPio5aCI9UsivA7hhj9+Rc+IcrZcGSFprx/726z/1FnfkwLl
         2VhJA1BPkcVDlO0cOgUYvCv3SC8efLHbvMTBSsNz472lQ5oK0aZY0jh2DqxnVTxC4+
         s6lCvPStMPhO6+23tDdcI3xju3Cst9ffoXTRrzeQ=
Message-ID: <fc008fc00c50baedbb763d166d33c0bc772f048c.camel@kernel.org>
Subject: Re: [PATCH 4/4] nfs: support i_version in the NFSv4 case
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Date:   Tue, 17 Nov 2020 07:34:36 -0500
In-Reply-To: <1605583086-19869-4-git-send-email-bfields@redhat.com>
References: <20201117031601.GB10526@fieldses.org>
         <1605583086-19869-1-git-send-email-bfields@redhat.com>
         <1605583086-19869-4-git-send-email-bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-11-16 at 22:18 -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> Currently when knfsd re-exports an NFS filesystem, it uses the ctime as
> the change attribute.  But obviously we have a real change
> attribute--the one that was returned from the original server.  We
> should just use that.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 4034102010f0..ca85f81d1b9e 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1045,6 +1045,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
>  	} else {
>  		sb->s_time_min = S64_MIN;
>  		sb->s_time_max = S64_MAX;
> +		sb->s_flags |= SB_I_VERSION;
>  	}
>  
> 
>  	sb->s_magic = NFS_SUPER_MAGIC;

I don't think we want this change. This will make file_update_time
attempt to bump the i_version field itself using the routines in
iversion.h. This will almost certainly do the wrong thing.

-- 
Jeff Layton <jlayton@kernel.org>

