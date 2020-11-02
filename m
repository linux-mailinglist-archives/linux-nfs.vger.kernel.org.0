Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D8B2A2E96
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 16:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgKBPsE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 10:48:04 -0500
Received: from smtp-o-3.desy.de ([131.169.56.156]:39700 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgKBPsE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 10:48:04 -0500
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 10:48:02 EST
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 76E7D60618
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 16:38:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 76E7D60618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1604331522; bh=B2NpVlT2Tqs0vVEaNi5d49PtS4bqkN5GJUxAFWVig3A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=z1Ha0Di5ZZ/W9yBCfN5n1aQj+7oYfYJAhNKYskJokuIw7Huc7Dj4dxL98pX0nxRN/
         IvgFr+gA3UbO3q2bBOnxBdyVjoIrALBRILsoNnyzp9gDUqup4Fnrl+2v/sXbfeyiH+
         GyQTJ30vBPXSfDh0sdGlORIHNxVZRZICWnLf9Fh4=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [IPv6:2001:638:700:1038::1:83])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 6B35CA0586;
        Mon,  2 Nov 2020 16:38:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 429F41001A7;
        Mon,  2 Nov 2020 16:38:42 +0100 (CET)
Date:   Mon, 2 Nov 2020 16:38:42 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     trondmy <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1976524196.5308081.1604331522179.JavaMail.zimbra@desy.de>
In-Reply-To: <1604325011-29427-12-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com> <1604325011-29427-12-git-send-email-dwysocha@redhat.com>
Subject: Re: [PATCH 11/11] NFS: Bring back nfs_dir_mapping_need_revalidate()
 in nfs_readdir()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3953)
Thread-Topic: Bring back nfs_dir_mapping_need_revalidate() in nfs_readdir()
Thread-Index: bZwTZ0y3Ndl+CBQ6m+AoYTaYUIw26w==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dave,

----- Original Message -----
> From: "David Wysochanski" <dwysocha@redhat.com>
> To: "trondmy" <trondmy@hammerspace.com>, "Anna Schumaker" <anna.schumaker@netapp.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Monday, 2 November, 2020 14:50:11
> Subject: [PATCH 11/11] NFS: Bring back nfs_dir_mapping_need_revalidate() in nfs_readdir()

> commit 79f687a3de9e ("NFS: Fix a performance regression in readdir")
> removed nfs_dir_mapping_need_revalidate() in an attempt to fix a
> performance regression, but had the effect that with NFSv3 the
> pagecache would never expire while a process was reading a directory.
> An earlier patch addressed this problem by allowing the pagecache
> to expire but the current process to continue using the last cookie
> returned by the server when searching the pagecache, rather than
> always starting at 0.  Thus, bring back nfs_dir_mapping_need_revalidate()
> so that nfsi->cache_validity & NFS_INO_INVALID_DATA will be seen
> and nfs_revalidate_mapping() will be called with NFSv3 as well,
> making it behave the same as NFSv4.
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
> fs/nfs/dir.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index cbd74cbdbb9f..aeb086fb3d0a 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -872,6 +872,17 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
> 	return status;
> }
> 
> +static bool nfs_dir_mapping_need_revalidate(struct inode *dir)
> +{
> +	struct nfs_inode *nfsi = NFS_I(dir);
> +
> +	if (nfs_attribute_cache_expired(dir))
> +		return true;
> +	if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
> +		return true;
> +	return false;
> +}

Is this the same as:

static bool nfs_dir_mapping_need_revalidate(struct inode *dir)
{
        struct nfs_inode *nfsi = NFS_I(dir);

        return nfs_attribute_cache_expired(dir) || nfsi->cache_validity & NFS_INO_INVALID_DATA);
}

Tigran.

> +
> /* The file offset position represents the dirent entry number.  A
>    last cookie cache takes care of the common case of reading the
>    whole directory.
> @@ -903,7 +914,7 @@ static int nfs_readdir(struct file *file, struct dir_context
> *ctx)
> 	 * to either find the entry with the appropriate number or
> 	 * revalidate the cookie.
> 	 */
> -	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode))
> +	if (ctx->pos == 0 || nfs_dir_mapping_need_revalidate(inode))
> 		res = nfs_revalidate_mapping(inode, file->f_mapping);
> 	if (res < 0)
> 		goto out;
> --
> 1.8.3.1
