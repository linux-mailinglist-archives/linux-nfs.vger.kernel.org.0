Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865F91B18FF
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2020 00:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDTWED (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTWEC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 18:04:02 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C9EC061A0C
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 15:04:02 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id ED4A5C53; Mon, 20 Apr 2020 18:04:01 -0400 (EDT)
Date:   Mon, 20 Apr 2020 18:04:01 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Achilles Gaikwad <agaikwad@redhat.com>
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        kdsouza@redhat.com
Subject: Re: [PATCH v3] nfsd4: add filename to states output
Message-ID: <20200420220401.GB3571@fieldses.org>
References: <20200420125031.GA44720@nevermore.foobar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420125031.GA44720@nevermore.foobar.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 20, 2020 at 06:20:31PM +0530, Achilles Gaikwad wrote:
> Add filename to states output for ease of debugging.

Thanks!

The results may be surprising for disconnected dentries.  E.g., start a
"tail -f" on a file on an NFS export, then reboot the server and give
the client a chance to recover, and then look at /proc/fs/nfsd/clients,
and you'll just see

	filename: "/"

But, I suppose it's still nice to print the pathname when it's
available.  The one improvement I can think of is to print something
like "<disconnected>" in that case.  I'm not sure where that logic would
go.

--b.

> 
> Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
> Signed-off-by: Kenneth Dsouza <kdsouza@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index e32ecedece0f..27338640959d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2404,6 +2404,11 @@ static void states_stop(struct seq_file *s, void *v)
>  	spin_unlock(&clp->cl_lock);
>  }
>  
> +static void nfs4_show_fname(struct seq_file *s, struct nfsd_file *f)
> +{
> +         seq_printf(s, "filename: \"%pD2\"", f->nf_file);
> +}
> +
>  static void nfs4_show_superblock(struct seq_file *s, struct nfsd_file *f)
>  {
>  	struct inode *inode = f->nf_inode;
> @@ -2449,6 +2454,8 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
>  
>  	nfs4_show_superblock(s, file);
>  	seq_printf(s, ", ");
> +	nfs4_show_fname(s, file);
> +	seq_printf(s, ", ");
>  	nfs4_show_owner(s, oo);
>  	seq_printf(s, " }\n");
>  	nfsd_file_put(file);
> @@ -2480,6 +2487,8 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
>  	nfs4_show_superblock(s, file);
>  	/* XXX: open stateid? */
>  	seq_printf(s, ", ");
> +	nfs4_show_fname(s, file);
> +	seq_printf(s, ", ");
>  	nfs4_show_owner(s, oo);
>  	seq_printf(s, " }\n");
>  	nfsd_file_put(file);
> @@ -2506,6 +2515,8 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
>  	/* XXX: lease time, whether it's being recalled. */
>  
>  	nfs4_show_superblock(s, file);
> +	seq_printf(s, ", ");
> +	nfs4_show_fname(s, file);
>  	seq_printf(s, " }\n");
>  
>  	return 0;
> @@ -2524,6 +2535,8 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
>  	/* XXX: What else would be useful? */
>  
>  	nfs4_show_superblock(s, file);
> +	seq_printf(s, ", ");
> +	nfs4_show_fname(s, file);
>  	seq_printf(s, " }\n");
>  
>  	return 0;
> -- 
> 2.25.3
