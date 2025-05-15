Return-Path: <linux-nfs+bounces-11744-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF10AB870B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C614E79BC
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40829B797;
	Thu, 15 May 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezkAEutj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA929B791;
	Thu, 15 May 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313516; cv=none; b=aqir4XPnaMseUID5sf6oiZG8ON3f3ajDhluoF5ia+e4eaiJ0M1qiftORp4gWauyGMjf9CjlleewWOpQdPk+puOFjq877Ce9kB3JtA7ntERGBWjkOm8Z6Fp5G4YQERYr6IQ5my/2/sw4iKlLPYmDNNZP15J2Ujj0cajI/f21pUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313516; c=relaxed/simple;
	bh=G8k+8FBDrUkBoOmsIZo6Bj15fNVHLvvwVZ61RK0ICyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyHTygjwTJ6bQc+D3A47kA30uRxycjNSYyNwonVdnVeyyybbiDvTCoHbo5nUkJUaqwVOHmP46jxSGuP7IEyylkzL5C6A9ifZa4z0POpjzfWuqSZTs4cZt4vTayXoTAARG1kBkwbXJEFPsDjug9x105PsPw9xDD9FzVudWBcuX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezkAEutj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE03C4CEE7;
	Thu, 15 May 2025 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313516;
	bh=G8k+8FBDrUkBoOmsIZo6Bj15fNVHLvvwVZ61RK0ICyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezkAEutjuFuChTgLNdI7+uPiPBasjT8wXpBhEpC7KhDAoFkmoHyj4A8c1nOHwBEHB
	 UNHKm+lOF7+/qGeD1NAEoBiedy0rxHy4kS6+gDErSJ7DpgVdkdCf8RLm3P9bANiKjq
	 iP4J66jJGj/+c+kD7PThkvQTqBtBha4W8aymWejTiq48JNLTKLNPkDAg+LQT3ciLhb
	 Fq3TJn4yIVJBz0ZG5eeg2B3IEARPwlZT5IrrV/YJlABLfWKntjfh5nNiI8USwbAcnO
	 lijdI1vByJkuN7D4Pd4Dq2gOFS7rFsNSrGjNSG9L/g7JpwnJ8YPBAqKY6H5lGSP4N5
	 l5WZUI75QCp1g==
Date: Thu, 15 May 2025 15:51:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 1/2] NFS: support the kernel keyring for TLS
Message-ID: <aCXjaDas4aJkoS7-@kernel.org>
References: <20250515115107.33052-1-hch@lst.de>
 <20250515115107.33052-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515115107.33052-2-hch@lst.de>

On Thu, May 15, 2025 at 01:50:55PM +0200, Christoph Hellwig wrote:
> Allow tlshd to use a per-mount key from the kernel keyring similar
> to NVMe over TCP.
> 
> Note that tlshd expects keys and certificates stored in the kernel
> keyring to be in DER format, not the PEM format used for file based keys
> and certificates, so they need to be converted before they are added
> to the keyring, which is a bit unexpected.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfs/fs_context.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 13f71ca8c974..9e94d18448ff 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -96,6 +96,8 @@ enum nfs_param {
>  	Opt_wsize,
>  	Opt_write,
>  	Opt_xprtsec,
> +	Opt_cert_serial,
> +	Opt_privkey_serial,
>  };
>  
>  enum {
> @@ -221,6 +223,8 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>  	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
>  	fsparam_u32   ("wsize",		Opt_wsize),
>  	fsparam_string("xprtsec",	Opt_xprtsec),
> +	fsparam_s32("cert_serial",	Opt_cert_serial),
> +	fsparam_s32("privkey_serial",	Opt_privkey_serial),
>  	{}
>  };
>  
> @@ -551,6 +555,32 @@ static int nfs_parse_version_string(struct fs_context *fc,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_KEYS
> +static int nfs_tls_key_verify(key_serial_t key_id)
> +{
> +	struct key *key = key_lookup(key_id);
> +	int error = 0;
> +
> +	if (IS_ERR(key)) {
> +		pr_err("key id %08x not found\n", key_id);
> +		return PTR_ERR(key);
> +	}
> +	if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
> +	    test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
> +		pr_err("key id %08x revoked\n", key_id);
> +		error = -EKEYREVOKED;
> +	}
> +
> +	key_put(key);
> +	return error;
> +}

This is equivalent nvme_tls_key_lookup() so would it be more senseful
to call it nfs_tls_key_lookup()? I'm also a bit puzzled how the code
will associate nfs_keyring to all this (e.g., with keyring_search as
done in nvme_tls_psk_lookup())?

> +#else
> +static inline int nfs_tls_key_verify(key_serial_t key_id)
> +{
> +	return -ENOENT;
> +}
> +#endif /* CONFIG_KEYS */
> +
>  /*
>   * Parse a single mount parameter.
>   */
> @@ -807,6 +837,18 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>  		if (ret < 0)
>  			return ret;
>  		break;
> +	case Opt_cert_serial:
> +		ret = nfs_tls_key_verify(result.int_32);
> +		if (ret < 0)
> +			return ret;
> +		ctx->xprtsec.cert_serial = result.int_32;
> +		break;
> +	case Opt_privkey_serial:
> +		ret = nfs_tls_key_verify(result.int_32);
> +		if (ret < 0)
> +			return ret;
> +		ctx->xprtsec.privkey_serial = result.int_32;
> +		break;
>  
>  	case Opt_proto:
>  		if (!param->string)
> -- 
> 2.47.2
> 

I get the change i.e., keep keys opaque, and it is a reasonable goal.
However, the keyring-key association is where I get lost, so if you
could help me out with that a bit, we could make progress :-)

BR, Jarkko

