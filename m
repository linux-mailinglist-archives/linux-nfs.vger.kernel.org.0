Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D188350C1B
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 03:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhDABvC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 21:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233236AbhDABup (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 21:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617241844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VQyuwHF3WWP+qSjkHaZSx/EjMcX4n0qR7hgwFVZxo9U=;
        b=C7uXcwNusHHKK9JGEjqU3AME7wBLAE32uurG/+PLjzWoMiIy4yNw774Ze9m2N0pOp1uG7o
        xmRj7yh7gf9qLr7b1fYIdCjK/Jsf9EWvkVynU6C2sSof1CsftDmF1chH6n5jUFGALDEztM
        CS1Oqs0YFUWYNLIGao6gWPD+pbqq7XI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-ap62gtpFN3WlzPKACuB--A-1; Wed, 31 Mar 2021 21:50:41 -0400
X-MC-Unique: ap62gtpFN3WlzPKACuB--A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8BD2107ACCD;
        Thu,  1 Apr 2021 01:50:40 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-115-11.rdu2.redhat.com [10.10.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7A1C5D9CA;
        Thu,  1 Apr 2021 01:50:40 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id AA8FA12063A; Wed, 31 Mar 2021 21:50:39 -0400 (EDT)
Date:   Wed, 31 Mar 2021 21:50:39 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within
 the last hole
Message-ID: <YGUm7/HE3HqVJik2@pick.fieldses.org>
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 31, 2021 at 03:28:19PM -0400, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> According to the RFC 7862, "if the server cannot find a
> corresponding sa_what, then the status will still be NFS4_OK,
> but sr_eof would be TRUE". If there is a file that ends with
> a hole and a SEEK request made for sa_what=SEEK_DATA with
> an offset in the middle of the last hole, then the server
> has to return OK and set the eof. Currently the linux server
> returns ERR_NXIO.

Makes sense, but I think you can use the return value from vfs_llseek
instead of checking the file size again.  E.g.:

	seek->seek_pos = vfs_llseek(nfs->nf_file, seek->seek_offset, whence);
	if (seek->seek_pos == -ENXIO)
		seek->seek_eof = true;
	else if (seek->seek_pos < 0)
		status = nfserrno(seek->seek_pos);

--b.

> 
> Fixes: 24bab491220fa ("NFSD: Implement SEEK")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfsd/nfs4proc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index e13c4c81fb89..2e7ceb9f1d5d 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1737,9 +1737,13 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	 *        should ever file->f_pos.
>  	 */
>  	seek->seek_pos = vfs_llseek(nf->nf_file, seek->seek_offset, whence);
> -	if (seek->seek_pos < 0)
> -		status = nfserrno(seek->seek_pos);
> -	else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> +	if (seek->seek_pos < 0) {
> +		if (whence == SEEK_DATA &&
> +		    seek->seek_offset < i_size_read(file_inode(nf->nf_file)))
> +			seek->seek_eof = true;
> +		else
> +			status = nfserrno(seek->seek_pos);
> +	} else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
>  		seek->seek_eof = true;
>  
>  out:
> -- 
> 2.18.2
> 

