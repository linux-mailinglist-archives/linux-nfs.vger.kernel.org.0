Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5622E1C7FD4
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2020 03:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgEGBcE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 May 2020 21:32:04 -0400
Received: from fieldses.org ([173.255.197.46]:48322 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgEGBcE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 6 May 2020 21:32:04 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id AA86B26D5; Wed,  6 May 2020 21:32:03 -0400 (EDT)
Date:   Wed, 6 May 2020 21:32:03 -0400
To:     Kenneth D'souza <kdsouza@redhat.com>
Cc:     linux-nfs@vger.kernel.org, bfields@redhat.com, agaikwad@redhat.com
Subject: Re: [PATCH] nfsd4: Make "info" file json compatible.
Message-ID: <20200507013203.GD21307@fieldses.org>
References: <20200501062230.19693-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501062230.19693-1-kdsouza@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 01, 2020 at 11:52:30AM +0530, Kenneth D'souza wrote:
> Currently the output returned by client_info_show() is not
> pure json, fix it so user space can pass the file properly.

Gah, I said JSON, but the promise was that these files would be YAML,
which I believe is a superset of JSON.

I'd prefer not to make major backwards-incompatible changes.

--b.

> 
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
> Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c107caa56525..f2a14f95ffa6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2341,19 +2341,24 @@ static int client_info_show(struct seq_file *m, void *v)
>  	if (!clp)
>  		return -ENXIO;
>  	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
> -	seq_printf(m, "clientid: 0x%llx\n", clid);
> -	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
> -	seq_printf(m, "name: ");
> +	seq_printf(m, "{\n");
> +	seq_printf(m, "\t\"clientid\": \"0x%llx\",\n", clid);
> +	seq_printf(m, "\t\"address\": \"%pISpc\",\n", (struct sockaddr *)&clp->cl_addr);
> +	seq_printf(m, "\t\"name\": ");
>  	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
> -	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> +	seq_printf(m, ", ");
> +	seq_printf(m, "\n\t\"minor version\": %d,\n", clp->cl_minorversion);
>  	if (clp->cl_nii_domain.data) {
> -		seq_printf(m, "Implementation domain: ");
> +		seq_printf(m, "\t\"Implementation domain\": ");
>  		seq_quote_mem(m, clp->cl_nii_domain.data,
>  					clp->cl_nii_domain.len);
> -		seq_printf(m, "\nImplementation name: ");
> +		seq_printf(m, ", ");
> +		seq_printf(m, "\n\t\"Implementation name\": ");
>  		seq_quote_mem(m, clp->cl_nii_name.data, clp->cl_nii_name.len);
> -		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
> +		seq_printf(m, ", ");
> +		seq_printf(m, "\n\t\"Implementation time\": \"[%lld, %ld]\"\n",
>  			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
> +		seq_printf(m, "}\n");
>  	}
>  	drop_client(clp);
>  
> -- 
> 2.21.1
