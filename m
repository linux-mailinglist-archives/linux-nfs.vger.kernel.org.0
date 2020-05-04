Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15891C46CD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2020 21:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgEDTJz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 May 2020 15:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDTJy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 May 2020 15:09:54 -0400
X-Greylist: delayed 155 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 May 2020 12:09:54 PDT
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7943C061A0E;
        Mon,  4 May 2020 12:09:54 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 708A426D5; Mon,  4 May 2020 15:09:54 -0400 (EDT)
Date:   Mon, 4 May 2020 15:09:54 -0400
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 15/20] nfsd: use crypto_shash_tfm_digest()
Message-ID: <20200504190954.GC2757@fieldses.org>
References: <20200502053122.995648-1-ebiggers@kernel.org>
 <20200502053122.995648-16-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502053122.995648-16-ebiggers@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 01, 2020 at 10:31:17PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Instead of manually allocating a 'struct shash_desc' on the stack and
> calling crypto_shash_digest(), switch to using the new helper function
> crypto_shash_tfm_digest() which does this for us.
> 
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: J. Bruce Fields <bfields@redhat.com>

if you need it.

--b.

> ---
>  fs/nfsd/nfs4recover.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index a8fb18609146a2..9e40dfecf1b1a6 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -127,16 +127,8 @@ nfs4_make_rec_clidname(char *dname, const struct xdr_netobj *clname)
>   		goto out;
>  	}
>  
> -	{
> -		SHASH_DESC_ON_STACK(desc, tfm);
> -
> -		desc->tfm = tfm;
> -
> -		status = crypto_shash_digest(desc, clname->data, clname->len,
> -					     cksum.data);
> -		shash_desc_zero(desc);
> -	}
> -
> +	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
> +					 cksum.data);
>  	if (status)
>  		goto out;
>  
> @@ -1148,7 +1140,6 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
>  	struct crypto_shash *tfm = cn->cn_tfm;
>  	struct xdr_netobj cksum;
>  	char *principal = NULL;
> -	SHASH_DESC_ON_STACK(desc, tfm);
>  
>  	/* Don't upcall if it's already stored */
>  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
> @@ -1170,16 +1161,14 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
>  	else if (clp->cl_cred.cr_principal)
>  		principal = clp->cl_cred.cr_principal;
>  	if (principal) {
> -		desc->tfm = tfm;
>  		cksum.len = crypto_shash_digestsize(tfm);
>  		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
>  		if (cksum.data == NULL) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -		ret = crypto_shash_digest(desc, principal, strlen(principal),
> -					  cksum.data);
> -		shash_desc_zero(desc);
> +		ret = crypto_shash_tfm_digest(tfm, principal, strlen(principal),
> +					      cksum.data);
>  		if (ret) {
>  			kfree(cksum.data);
>  			goto out;
> @@ -1343,7 +1332,6 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  	struct crypto_shash *tfm = cn->cn_tfm;
>  	struct xdr_netobj cksum;
>  	char *principal = NULL;
> -	SHASH_DESC_ON_STACK(desc, tfm);
>  
>  	/* did we already find that this client is stable? */
>  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
> @@ -1381,14 +1369,12 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  			principal = clp->cl_cred.cr_principal;
>  		if (principal == NULL)
>  			return -ENOENT;
> -		desc->tfm = tfm;
>  		cksum.len = crypto_shash_digestsize(tfm);
>  		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
>  		if (cksum.data == NULL)
>  			return -ENOENT;
> -		status = crypto_shash_digest(desc, principal, strlen(principal),
> -					     cksum.data);
> -		shash_desc_zero(desc);
> +		status = crypto_shash_tfm_digest(tfm, principal,
> +						 strlen(principal), cksum.data);
>  		if (status) {
>  			kfree(cksum.data);
>  			return -ENOENT;
> -- 
> 2.26.2
