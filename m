Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B8F1EC380
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2020 22:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgFBULM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jun 2020 16:11:12 -0400
Received: from fieldses.org ([173.255.197.46]:33898 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgFBULL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Jun 2020 16:11:11 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 50CC84EF4; Tue,  2 Jun 2020 16:11:11 -0400 (EDT)
Date:   Tue, 2 Jun 2020 16:11:11 -0400
To:     Kenneth D'souza <kdsouza@redhat.com>
Cc:     linux-nfs@vger.kernel.org, bfields@redhat.com
Subject: Re: [PATCH] nfs4_setfacl: Add file name to error output.
Message-ID: <20200602201111.GE1769@fieldses.org>
References: <20200601192754.5413-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601192754.5413-1-kdsouza@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applied.--b.

On Tue, Jun 02, 2020 at 12:57:54AM +0530, Kenneth D'souza wrote:
> Currently when a user tries to set acl's recursively and if
> the operation fails the user is not aware on which file the error
> occured. This patch adds file name to error output.
> 
> Example:
> nfs4_setfacl -R -s A:dfg:6:RWX /nfsmount
> Failed setxattr operation: /nfsmount/test: Operation not permitted
> An error occurred during recursive file tree walk.
> 
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
> ---
>  libnfs4acl/nfs4_set_acl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/libnfs4acl/nfs4_set_acl.c b/libnfs4acl/nfs4_set_acl.c
> index 8a53f05..45e42fa 100644
> --- a/libnfs4acl/nfs4_set_acl.c
> +++ b/libnfs4acl/nfs4_set_acl.c
> @@ -61,13 +61,13 @@ int nfs4_set_acl(struct nfs4_acl *acl, const char *path)
>  		goto out_free;
>  	} else if (res < 0) {
>  		if (errno == EOPNOTSUPP)
> -			fprintf(stderr,"Operation to set ACL not supported.\n");
> +			fprintf(stderr,"Operation to set ACL not supported: %s\n", path);
>  		else if (errno == ENODATA)
> -			fprintf(stderr,"ACL Attribute not found on file.\n");
> +			fprintf(stderr,"ACL Attribute not found on file: %s\n", path);
>  		else if (errno == EREMOTEIO)
>  			fprintf(stderr,"An NFS server error occurred.\n");
>  		else
> -			perror("Failed setxattr operation");
> +			printf("Failed setxattr operation: %s: %s\n", path, strerror(errno));
>  	}
>  
>  out_free:
> -- 
> 2.21.1
