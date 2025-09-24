Return-Path: <linux-nfs+bounces-14640-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCD7B9A236
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2787B1890C2F
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C51D88AC;
	Wed, 24 Sep 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7FgbujZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DE8C11
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722436; cv=none; b=kX2ujOD36xkNIV0zA3PtAwIOxgnqD5ka+USiG1eATFdlSzVwO1HxkNRnvh6fkBjVqVlHTNxuu+Y8A7q888xHZi8Zy/wUHA6OF2oQGBYF3/tiDhtPMYo4XRcfAWwJl78FN8HuuxVdrEiMo3MZDl5gvscOONF53gK18FjdaTO9tCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722436; c=relaxed/simple;
	bh=Hzre3hI7m201ow9M8ukwr5917YA6rfoc5DLkKIOiiUY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TmXbQ+yrqSeVkFcUEb9BSEEI8Qm28/fOFaFoySJiYnnfreO9qpo8qhJbn21ZAgTxfGJrJ0gRi46KuVMQOceSkT2SlyLvrgLSnFqLlg4GvYuB+Rq5fRojiuo6OkUNb1gTHtMXRq87AvorY/1LcMiQsA5n/n3WJ8piZTuE7A8HYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7FgbujZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8649EC4CEE7;
	Wed, 24 Sep 2025 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758722436;
	bh=Hzre3hI7m201ow9M8ukwr5917YA6rfoc5DLkKIOiiUY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=l7FgbujZi0x0QTyOWsNMkQ5H+tG7/8uz8Mwpl5eI0hxJ5hgWc6E+AzbFtH91Y7wK9
	 /UuB7l/v1kBSq6z+uqYeEQnyzX0jd1npS8vDrRvL2uvZVNTi0OLrfjM0ORUrxe/vKr
	 8Lr9WRmkQ2jdepCFBhPGRQmyNGA00mCEMdg+lXSoqk/lJa+4pUCMKDne+qIVYXTmIZ
	 GPKOijg8XV4h3yMo8VBrnNB0+qXCb/3BeHJUJcU9e9CUuJrLftswG14bSNFRDwtR+S
	 DE5AXiP5jJ/4sVivk6tamor7zSjsNIHLLgQoC8eQKpaLhbVHcLMb8CC0ylw8rn+axQ
	 ABbYyLqe7nzgQ==
Message-ID: <a7da6afa-c7e2-48e5-8e99-43695bf502e5@kernel.org>
Date: Wed, 24 Sep 2025 10:00:34 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] NFSD: filecache: add STATX_DIOALIGN and
 STATX_DIO_READ_ALIGN support
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
 NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
References: <20250922141137.632525-1-cel@kernel.org>
 <20250922141137.632525-2-cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20250922141137.632525-2-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/25 7:11 AM, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
> 
> Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get DIO alignment
> attributes from the underlying filesystem and store them in the
> associated nfsd_file. This is done when the nfsd_file is first
> opened for each regular file.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

v3 of this patch is the one that should be included for the client
series you plan to merge.

When you apply it, please remove "Signed-off-by: Chuck ..." and
replace it with:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  fs/nfsd/filecache.c     | 34 ++++++++++++++++++++++++++++++++++
>  fs/nfsd/filecache.h     |  4 ++++
>  fs/nfsd/nfsfh.c         |  4 ++++
>  fs/nfsd/trace.h         | 27 +++++++++++++++++++++++++++
>  include/trace/misc/fs.h | 22 ++++++++++++++++++++++
>  5 files changed, 91 insertions(+)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 75bc48031c07..78cca0d751ac 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -231,6 +231,9 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
>  	refcount_set(&nf->nf_ref, 1);
>  	nf->nf_may = need;
>  	nf->nf_mark = NULL;
> +	nf->nf_dio_mem_align = 0;
> +	nf->nf_dio_offset_align = 0;
> +	nf->nf_dio_read_offset_align = 0;
>  	return nf;
>  }
>  
> @@ -1048,6 +1051,35 @@ nfsd_file_is_cached(struct inode *inode)
>  	return ret;
>  }
>  
> +static __be32
> +nfsd_file_get_dio_attrs(const struct svc_fh *fhp, struct nfsd_file *nf)
> +{
> +	struct inode *inode = file_inode(nf->nf_file);
> +	struct kstat stat;
> +	__be32 status;
> +
> +	/* Currently only need to get DIO alignment info for regular files */
> +	if (!S_ISREG(inode->i_mode))
> +		return nfs_ok;
> +
> +	status = fh_getattr(fhp, &stat);
> +	if (status != nfs_ok)
> +		return status;
> +
> +	trace_nfsd_file_get_dio_attrs(inode, &stat);
> +
> +	if (stat.result_mask & STATX_DIOALIGN) {
> +		nf->nf_dio_mem_align = stat.dio_mem_align;
> +		nf->nf_dio_offset_align = stat.dio_offset_align;
> +	}
> +	if (stat.result_mask & STATX_DIO_READ_ALIGN)
> +		nf->nf_dio_read_offset_align = stat.dio_read_offset_align;
> +	else
> +		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
> +
> +	return nfs_ok;
> +}
> +
>  static __be32
>  nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
>  		     struct svc_cred *cred,
> @@ -1166,6 +1198,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
>  			}
>  			status = nfserrno(ret);
>  			trace_nfsd_file_open(nf, status);
> +			if (status == nfs_ok)
> +				status = nfsd_file_get_dio_attrs(fhp, nf);
>  		}
>  	} else
>  		status = nfserr_jukebox;
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 24ddf60e8434..e3d6ca2b6030 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -54,6 +54,10 @@ struct nfsd_file {
>  	struct list_head	nf_gc;
>  	struct rcu_head		nf_rcu;
>  	ktime_t			nf_birthtime;
> +
> +	u32			nf_dio_mem_align;
> +	u32			nf_dio_offset_align;
> +	u32			nf_dio_read_offset_align;
>  };
>  
>  int nfsd_file_cache_init(void);
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 3edccc38db42..3eb724ec9566 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -696,8 +696,12 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
>  		.mnt		= fhp->fh_export->ex_path.mnt,
>  		.dentry		= fhp->fh_dentry,
>  	};
> +	struct inode *inode = d_inode(p.dentry);
>  	u32 request_mask = STATX_BASIC_STATS;
>  
> +	if (S_ISREG(inode->i_mode))
> +		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
> +
>  	if (fhp->fh_maxsize == NFS4_FHSIZE)
>  		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
>  
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index a664fdf1161e..6e2c8e2aab10 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1133,6 +1133,33 @@ TRACE_EVENT(nfsd_file_alloc,
>  	)
>  );
>  
> +TRACE_EVENT(nfsd_file_get_dio_attrs,
> +	TP_PROTO(
> +		const struct inode *inode,
> +		const struct kstat *stat
> +	),
> +	TP_ARGS(inode, stat),
> +	TP_STRUCT__entry(
> +		__field(const void *, inode)
> +		__field(unsigned long, mask)
> +		__field(u32, mem_align)
> +		__field(u32, offset_align)
> +		__field(u32, read_offset_align)
> +	),
> +	TP_fast_assign(
> +		__entry->inode = inode;
> +		__entry->mask = stat->result_mask;
> +		__entry->mem_align = stat->dio_mem_align;
> +		__entry->offset_align = stat->dio_offset_align;
> +		__entry->read_offset_align = stat->dio_read_offset_align;
> +	),
> +	TP_printk("inode=%p flags=%s mem_align=%u offset_align=%u read_offset_align=%u",
> +		__entry->inode, show_statx_mask(__entry->mask),
> +		__entry->mem_align, __entry->offset_align,
> +		__entry->read_offset_align
> +	)
> +);
> +
>  TRACE_EVENT(nfsd_file_acquire,
>  	TP_PROTO(
>  		const struct svc_rqst *rqstp,
> diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
> index 0406ebe2a80a..7ead1c61f0cb 100644
> --- a/include/trace/misc/fs.h
> +++ b/include/trace/misc/fs.h
> @@ -141,3 +141,25 @@
>  		{ ATTR_TIMES_SET,	"TIMES_SET" },	\
>  		{ ATTR_TOUCH,		"TOUCH"},	\
>  		{ ATTR_DELEG,		"DELEG"})
> +
> +#define show_statx_mask(flags)					\
> +	__print_flags(flags, "|",				\
> +		{ STATX_TYPE,		"TYPE" },		\
> +		{ STATX_MODE,		"MODE" },		\
> +		{ STATX_NLINK,		"NLINK" },		\
> +		{ STATX_UID,		"UID" },		\
> +		{ STATX_GID,		"GID" },		\
> +		{ STATX_ATIME,		"ATIME" },		\
> +		{ STATX_MTIME,		"MTIME" },		\
> +		{ STATX_CTIME,		"CTIME" },		\
> +		{ STATX_INO,		"INO" },		\
> +		{ STATX_SIZE,		"SIZE" },		\
> +		{ STATX_BLOCKS,		"BLOCKS" },		\
> +		{ STATX_BASIC_STATS,	"BASIC_STATS" },	\
> +		{ STATX_BTIME,		"BTIME" },		\
> +		{ STATX_MNT_ID,		"MNT_ID" },		\
> +		{ STATX_DIOALIGN,	"DIOALIGN" },		\
> +		{ STATX_MNT_ID_UNIQUE,	"MNT_ID_UNIQUE" },	\
> +		{ STATX_SUBVOL,		"SUBVOL" },		\
> +		{ STATX_WRITE_ATOMIC,	"WRITE_ATOMIC" },	\
> +		{ STATX_DIO_READ_ALIGN,	"DIO_READ_ALIGN" })

-- 
Chuck Lever


