Return-Path: <linux-nfs+bounces-17334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E5CE479A
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 02:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9193013EC6
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C154652;
	Sun, 28 Dec 2025 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8MO9Mbi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5BA1F956
	for <linux-nfs@vger.kernel.org>; Sun, 28 Dec 2025 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766885711; cv=none; b=mA0AOHedQhgrok7b18DOKxb8neCedNGwMlI604o+U+2eti5qFz8wAVpFoW3K5/+CxgyTkgFkox/xUWJ9Db5O+CAXYQO9v1qVVyKoejkAzwtVMfQJqlYJAdTI+U7wRMc5CVOGvkJcX6beuGzaykVwX62dB/bq0FQjpgXduL1Fd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766885711; c=relaxed/simple;
	bh=fmmL9HWmaEP0RpNRgy/s+tq2xpNI8J68pezMwOFzmxI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=loBxKswbH7gSJMKAVAaXQ33sLVLn8HiTdzGy1+sp4gN+2jsSUT9WIBUDtezi5xktHdP6txVv5wglh840F9nncqhy66oRcD5FhqqJxxQQaLkfXTh6y5VQ8sbE0i1RqrQAP00d9oRANsWbOvUUerV1jqaQOM9unPeCRniTJrJU7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8MO9Mbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B84C116C6;
	Sun, 28 Dec 2025 01:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766885710;
	bh=fmmL9HWmaEP0RpNRgy/s+tq2xpNI8J68pezMwOFzmxI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Q8MO9Mbi7XByFoaz2a7mljf25Df9eQB4eBBoZh4FpC5aOcCciBhX/Jk2ZbGh9q0Cw
	 SG+hVyLS5CZGRSXc755xUUAjL6swepGU7J6BU2UFAA5O1ms0nt2H4eXDsmOr3qOJVt
	 KHoST4X6W/TykEw1n7/ZB+e+e5fuxCy3KpDafr1NgbWMhzSnLY4Jvnk54MXI7AL5zi
	 0kqwWq6gPg+2ymeVdmcpZ8hZ0vDnZEakMxVOOSl0QOPe8OeRdLwQ6yDHeaGoRdFKU9
	 d3LY0boRst6Ys7KJCS4stESyRc5WK8rZg5vh0vDc2vCY0Ub6Ko9VVO9dfHilOssixs
	 QG8WXohOdU9yw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5E8FFF4006D;
	Sat, 27 Dec 2025 20:35:09 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 27 Dec 2025 20:35:09 -0500
X-ME-Sender: <xms:TYlQaS-WyhfecsiVxzdTx1uLzxMx5e8UH4r4rjRSjxcO5r_gpWt_FA>
    <xme:TYlQadj_EjV93WhkBb3jj09JXh4am0_-49eu7_1BzFYgoUe7X0aMZe8TRWExYmtMk
    lTBKdGqJ0zWYPUdPr390DgmIXmV7IGYU_FMRczrlnHUDno9i7niw6cl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepsggtohguughinhhgse
    hhrghmmhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhl
    vghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgtrhihphhtoh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TYlQacePlnO67dou49AyNRundh8Ey-3nEmKXyQ-3QmrFMACxRB-lWg>
    <xmx:TYlQaaP_c3p4LvTHX8dfK0uwj7zldYoDvHxjWSjGyYFASH-zBCPPag>
    <xmx:TYlQafuaF-Lrq8eeX7CJxU1Ggbsat6cpEgfJJ7nOAun0AggZht0RfA>
    <xmx:TYlQaTBfYjVYbvo5Gzt2DYRQGKV_bom3R9LCz224Qpef_g3HpKj-iw>
    <xmx:TYlQaWZ8xQOsokuRklQXTQXWnZ9ZOnnsQwyy-0xfrKbsP9CQFoq2ck6X>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 37CBB780054; Sat, 27 Dec 2025 20:35:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvjXdGNJ2cw-
Date: Sat, 27 Dec 2025 20:34:18 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <bc74d1a3-d128-486e-939a-f7b3dc560931@app.fastmail.com>
In-Reply-To: 
 <0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding@hammerspace.com>
References: <cover.1766848778.git.bcodding@hammerspace.com>
 <0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v1 6/7] NFSD: Add filehandle crypto functions and helpers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Dec 27, 2025, at 12:04 PM, Benjamin Coddington wrote:
> In order to improve the security of knfsd servers, create a method to
> encrypt and decrypt filehandles.
>
> Filehandle encryption begins by checking for an allocated encfh_buf for
> each knfsd thread.  It not yet allocated, nfsd performs JIT alloation and
> proceeds to encrypt or decrypt.
>
> In order to increase entropy, filehandles are encrypted in two passes.  In
> the first pass, the fileid is expanded to the AES block size and encrypted
> with the server's key and a salt from the fsid.  In the second pass, the
> entirety of the filehandle is encrypted starting with the block containing
> the results of the first pass.  Decryption reverses this operation.
>
> This approach ensures that the same fileid values are encrypted differently
> for differing fsid values.  This protects against comparisons between the
> same fileids across different exports that may not be encrypted, which
> could ease the discovery of the server's private key.  Additionally, it
> allows the fsid to be encrypted uniquely for each filehandle.
>
> The filehandle's auth_type is used to indicate that a filehandle has been
> encrypted.
>
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/nfsd/nfsfh.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsfh.h |  13 ++++
>  2 files changed, 178 insertions(+)
>
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18..86bdced0f905 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -11,6 +11,7 @@
>  #include <linux/exportfs.h>
> 
>  #include <linux/sunrpc/svcauth_gss.h>
> +#include <crypto/skcipher.h>
>  #include "nfsd.h"
>  #include "vfs.h"
>  #include "auth.h"
> @@ -137,6 +138,170 @@ static inline __be32 check_pseudo_root(struct 
> dentry *dentry,
>  	return nfs_ok;
>  }
> 
> +static int fh_crypto_init(struct svc_rqst *rqstp)
> +{
> +	struct encfh_buf *fh_encfh = (struct encfh_buf *)rqstp->rq_crypto;
> +
> +	/* This knfsd has not allocated buffers and reqest yet: */
> +	if (!fh_encfh) {
> +		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +
> +		fh_encfh = kmalloc(sizeof(struct encfh_buf), GFP_KERNEL);
> +		if (!fh_encfh)
> +			return -ENOMEM;
> +
> +		skcipher_request_set_sync_tfm(&fh_encfh->req, nn->encfh_tfm);
> +		rqstp->rq_crypto = fh_encfh;
> +	}
> +	memset(fh_encfh->a_buf, 0, NFS4_FHSIZE);
> +	memset(fh_encfh->b_buf, 0, NFS4_FHSIZE);
> +	return 0;
> +}
> +
> +static int fh_crypto(struct svc_fh *fhp, bool encrypting)
> +{
> +	struct encfh_buf *encfh = (struct encfh_buf *)fhp->fh_rqstp->rq_crypto;
> +	int err, pad, hash_size, fileid_offset;
> +	struct knfsd_fh *fh = &fhp->fh_handle;
> +	struct scatterlist fh_sgl[2];
> +	struct scatterlist hash_sg;
> +	u8 *a_buf = encfh->a_buf;
> +	u8 *b_buf = encfh->b_buf;
> +	u8 iv[16];
> +
> +	/* blocksize */
> +	int bs = crypto_sync_skcipher_blocksize(
> +				crypto_sync_skcipher_reqtfm(&encfh->req));
> +
> +	/* always renew as it gets transformed: */
> +	memset(iv, 0, sizeof(iv));
> +
> +	fileid_offset = fh_fileid_offset(fh);
> +	sg_init_table(fh_sgl, 2);
> +
> +	if (encrypting) {
> +		/* encryption */
> +		memcpy(&a_buf[fileid_offset], &fh->fh_raw[fileid_offset],
> +				fh->fh_size - fileid_offset);
> +		memcpy(b_buf, fh->fh_raw, fileid_offset);
> +
> +		/* encrypt the fileid using the fsid as iv: */
> +		memcpy(iv, fh_fsid(fh), min(sizeof(iv), key_len(fh->fh_fsid_type)));
> +
> +		/* pad out the fileid to block size */
> +		hash_size = fh_fileid_len(fh);
> +		pad = (bs - (hash_size & (bs - 1))) & (bs - 1);
> +		hash_size += pad;
> +
> +		sg_set_buf(&fh_sgl[0], &a_buf[fileid_offset], hash_size);
> +		sg_mark_end(&fh_sgl[1]);  /* don't need sg1 yet */
> +		sg_init_one(&hash_sg, &b_buf[fileid_offset], hash_size);
> +
> +		skcipher_request_set_crypt(&encfh->req, fh_sgl, &hash_sg, hash_size, iv);
> +		err = crypto_skcipher_encrypt(&encfh->req);
> +		if (err)
> +			goto out;
> +
> +		/* encrypt the fsid + fileid with zero iv, starting with the last
> +		 * block of the hashed fileid */
> +		memset(iv, 0, sizeof(iv));
> +
> +		/* calculate the new padding: */
> +		hash_size += key_len(fh->fh_fsid_type) + 4;
> +		pad = (bs - (hash_size & (bs - 1))) & (bs - 1);
> +		hash_size += pad;
> +
> +		sg_unmark_end(&fh_sgl[1]); /* now we use it */
> +		sg_set_buf(&fh_sgl[0], &b_buf[hash_size-bs], bs);
> +		sg_set_buf(&fh_sgl[1], b_buf, hash_size-bs);
> +		sg_init_one(&hash_sg, a_buf, hash_size);
> +
> +		skcipher_request_set_crypt(&encfh->req, fh_sgl, &hash_sg, hash_size, iv);
> +		err = crypto_skcipher_encrypt(&encfh->req);
> +
> +		if (!err) {
> +			memcpy(&fh->fh_raw[4], a_buf, hash_size);
> +			fh->fh_auth_type = FH_AT_ENCRYPTED;
> +			fh->fh_fileid_type = fh->fh_size; /* we'll use this in decryption */
> +			fh->fh_size = hash_size + 4;
> +		}
> +	} else {
> +		/* decryption */
> +		int fh_size = fh->fh_size - 4;
> +		memcpy(b_buf, &fh->fh_raw[4], fh_size);
> +
> +		/* first, we decode starting with the last hashed block and zero iv */
> +		hash_size = fh_size;
> +		sg_set_buf(&fh_sgl[0], &a_buf[fh_size - bs], bs);
> +		sg_set_buf(&fh_sgl[1], a_buf, fh_size - bs);
> +		sg_init_one(&hash_sg, b_buf, fh_size);
> +
> +		skcipher_request_set_crypt(&encfh->req, &hash_sg, fh_sgl, hash_size, iv);
> +		err = crypto_skcipher_decrypt(&encfh->req);
> +		if (err)
> +			goto out;
> +
> +		/* Now we're dealing with the original fh_size: */
> +		fh_size = fh->fh_fileid_type;
> +
> +		/* a_buf now has the decrypted fsid and header: */
> +		memcpy(fh->fh_raw, a_buf, fileid_offset);
> +
> +		/* now we set the iv to the decrypted fsid value */
> +		memset(iv, 0, sizeof(iv));;
> +		memcpy(iv, &a_buf[4], min(sizeof(iv), key_len(fh->fh_fsid_type)));
> +
> +		/* align to block size */
> +		hash_size = fh_size - fileid_offset;
> +		pad = (bs - (hash_size & (bs - 1))) & (bs - 1);
> +		hash_size += pad;
> +
> +		/* decrypt only the fileid: */
> +		sg_set_buf(&fh_sgl[0], &b_buf[fileid_offset], hash_size);
> +		sg_mark_end(&fh_sgl[1]);
> +		sg_init_one(&hash_sg, &a_buf[fileid_offset], hash_size);
> +
> +		skcipher_request_set_crypt(&encfh->req, &hash_sg, fh_sgl, hash_size, iv);
> +		err = crypto_skcipher_decrypt(&encfh->req);
> +
> +		if (!err) {
> +			fh->fh_size = fh_size;
> +			/* copy in the fileid */
> +			memcpy(&fh->fh_raw[fileid_offset], &b_buf[fileid_offset], hash_size);
> +			/* trim the leftover hash padding */
> +			memset(&fh->fh_raw[fh->fh_size], 0, NFS4_FHSIZE - fh->fh_size);
> +		}
> +	}
> +	// add a tracepoint to show the error;
> +	// if decrypting, we want nfserr_badhandle
> +out:
> +	return err;
> +}
> +
> +/* we should never get here without calling fh_init first */
> +int fh_encrypt(struct svc_fh *fhp)
> +{
> +	if (!(fhp->fh_export->ex_flags & NFSEXP_ENCRYPT_FH))
> +		return 0;
> +
> +	if (fh_crypto_init(fhp->fh_rqstp))
> +		return -ENOMEM;
> +
> +	return fh_crypto(fhp, true);
> +}
> +
> +/* Lets try to decrypt, no matter the export setting */
> +static int fh_decrypt(struct svc_fh *fhp)
> +{
> +	if (fhp->fh_handle.fh_auth_type != FH_AT_ENCRYPTED)
> +		return 0;
> +
> +	if (fh_crypto_init(fhp->fh_rqstp))
> +		return -ENOMEM;
> +
> +	return fh_crypto(fhp, false);
> +}
> +
>  /*
>   * Use the given filehandle to look up the corresponding export and
>   * dentry.  On success, the results are used to set fh_export and
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index f29bb09af242..786f34e72304 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -60,6 +60,9 @@ struct knfsd_fh {
>  #define fh_fsid_type		fh_raw[2]
>  #define fh_fileid_type		fh_raw[3]
> 
> +#define FH_AT_PLAIN		0
> +#define FH_AT_ENCRYPTED	1
> +
>  static inline u32 *fh_fsid(const struct knfsd_fh *fh)
>  {
>  	return (u32 *)&fh->fh_raw[4];
> @@ -284,6 +287,16 @@ static inline bool fh_fsid_match(const struct 
> knfsd_fh *fh1,
>  	return true;
>  }
> 
> +static inline size_t fh_fileid_offset(const struct knfsd_fh *fh)
> +{
> +	return key_len(fh->fh_fsid_type) + 4;
> +}
> +
> +static inline size_t fh_fileid_len(const struct knfsd_fh *fh)
> +{
> +	return fh->fh_size - fh_fileid_offset(fh);
> +}
> +
>  /**
>   * fh_want_write - Get write access to an export
>   * @fhp: File handle of file to be written
> -- 
> 2.50.1

I'd feel more comfortable if the crypto community had a look
to ensure that we're utilizing the APIs in the most efficient
way possible. Adding linux-crypto ...


-- 
Chuck Lever

