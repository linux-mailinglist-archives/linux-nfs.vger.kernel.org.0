Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1851835EE
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 17:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCLQPO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 12:15:14 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:42581 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgCLQPN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Mar 2020 12:15:13 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 764ABE07D9
        for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2020 17:15:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 764ABE07D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1584029711; bh=qYUCrS4Wn5gbng3eCqVtNEG71sv57E1ak+mNPNGUPCg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=y8kdpOcOblLEPMi03E2m9fGLDd0dkK6HICKFseSJRNC64EiXccG5lSYcCsdAtKuL6
         UVEo9hD5zcei5NBSMWrWKVLOkpKGxDWKcpTyce8xE+dzs4nMzU5KrItS+UbMzn+9fK
         qJfsqYv8JXb4LupkgqmOVEkGthqEEDV6Vkq4AFlM=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 6AB87120262;
        Thu, 12 Mar 2020 17:15:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 3D62F100076;
        Thu, 12 Mar 2020 17:15:11 +0100 (CET)
Date:   Thu, 12 Mar 2020 17:15:10 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <530167624.4533477.1584029710746.JavaMail.zimbra@desy.de>
In-Reply-To: <20200311195613.26108-4-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com> <20200311195613.26108-4-fllinden@amazon.com>
Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: NFSv4.2: query the server for extended attribute support
Thread-Index: MDwlLLyBBH3+dOprCluNI/1+/8upHQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Frank,

----- Original Message -----
> From: "Frank van der Linden" <fllinden@amazon.com>
> To: "Trond Myklebust" <trond.myklebust@hammerspace.com>, "Anna Schumaker" <anna.schumaker@netapp.com>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Cc: "Frank van der Linden" <fllinden@amazon.com>
> Sent: Wednesday, March 11, 2020 8:56:03 PM
> Subject: [PATCH 03/13] NFSv4.2: query the server for extended attribute support

> Query the server for extended attribute support, and record it
> as the NFS_CAP_XATTR flag in the server capabilities.
> 
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
> fs/nfs/nfs4proc.c         | 14 ++++++++++++--
> fs/nfs/nfs4xdr.c          | 23 +++++++++++++++++++++++
> include/linux/nfs_fs_sb.h |  1 +
> include/linux/nfs_xdr.h   |  1 +
> 4 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 69b7ab7a5815..47bbd7db9d18 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3742,6 +3742,7 @@ static void nfs4_close_context(struct nfs_open_context
> *ctx, int is_sync)
> static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh
> *fhandle)
> {
> 	u32 bitmask[3] = {}, minorversion = server->nfs_client->cl_minorversion;
> +	u32 fattr4_word2_nfs42_mask;
> 	struct nfs4_server_caps_arg args = {
> 		.fhandle = fhandle,
> 		.bitmask = bitmask,
> @@ -3763,6 +3764,13 @@ static int _nfs4_server_capabilities(struct nfs_server
> *server, struct nfs_fh *f
> 	if (minorversion)
> 		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT;
> 
> +	fattr4_word2_nfs42_mask = FATTR4_WORD2_NFS42_MASK;
> +
> +	if (minorversion >= 2) {

I am not sure you need this extra check as by querying for  FATTR4_WORD0_SUPPORTED_ATTRS
server already will return FATTR4_WORD2_XATTR_SUPPORT if supported.

Tigran.

> +		bitmask[2] |= FATTR4_WORD2_XATTR_SUPPORT;
> +		fattr4_word2_nfs42_mask |= FATTR4_WORD2_XATTR_SUPPORT;
> +	}
> +
> 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
> 	&res.seq_res, 0);
> 	if (status == 0) {
> 		/* Sanity check the server answers */
> @@ -3775,7 +3783,7 @@ static int _nfs4_server_capabilities(struct nfs_server
> *server, struct nfs_fh *f
> 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS41_MASK;
> 			break;
> 		case 2:
> -			res.attr_bitmask[2] &= FATTR4_WORD2_NFS42_MASK;
> +			res.attr_bitmask[2] &= fattr4_word2_nfs42_mask;
> 		}
> 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
> 		server->caps &= ~(NFS_CAP_ACLS|NFS_CAP_HARDLINKS|
> @@ -3783,7 +3791,7 @@ static int _nfs4_server_capabilities(struct nfs_server
> *server, struct nfs_fh *f
> 				NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|
> 				NFS_CAP_OWNER_GROUP|NFS_CAP_ATIME|
> 				NFS_CAP_CTIME|NFS_CAP_MTIME|
> -				NFS_CAP_SECURITY_LABEL);
> +				NFS_CAP_SECURITY_LABEL|NFS_CAP_XATTR);
> 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
> 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
> 			server->caps |= NFS_CAP_ACLS;
> @@ -3811,6 +3819,8 @@ static int _nfs4_server_capabilities(struct nfs_server
> *server, struct nfs_fh *f
> 		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
> 			server->caps |= NFS_CAP_SECURITY_LABEL;
> #endif
> +		if (res.has_xattr)
> +			server->caps |= NFS_CAP_XATTR;
> 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
> 				sizeof(server->attr_bitmask));
> 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 47817ef0aadb..bebc087a1433 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -4201,6 +4201,26 @@ static int decode_attr_time_modify(struct xdr_stream
> *xdr, uint32_t *bitmap, str
> 	return status;
> }
> 
> +static int decode_attr_xattrsupport(struct xdr_stream *xdr, uint32_t *bitmap,
> +				    uint32_t *res)
> +{
> +	__be32 *p;
> +
> +	*res = 0;
> +	if (unlikely(bitmap[2] & (FATTR4_WORD2_XATTR_SUPPORT - 1U)))
> +		return -EIO;
> +	if (likely(bitmap[2] & FATTR4_WORD2_XATTR_SUPPORT)) {
> +		p = xdr_inline_decode(xdr, 4);
> +		if (unlikely(!p))
> +			return -EIO;
> +		*res = be32_to_cpup(p);
> +		bitmap[2] &= ~FATTR4_WORD2_XATTR_SUPPORT;
> +	}
> +	dprintk("%s: XATTR support=%s\n", __func__,
> +		*res == 0 ? "false" : "true");
> +	return 0;
> +}
> +
> static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t
> attrlen)
> {
> 	unsigned int attrwords = XDR_QUADLEN(attrlen);
> @@ -4371,6 +4391,9 @@ static int decode_server_caps(struct xdr_stream *xdr,
> struct nfs4_server_caps_re
> 	if ((status = decode_attr_exclcreat_supported(xdr, bitmap,
> 				res->exclcreat_bitmask)) != 0)
> 		goto xdr_error;
> +	status = decode_attr_xattrsupport(xdr, bitmap, &res->has_xattr);
> +	if (status != 0)
> +		goto xdr_error;
> 	status = verify_attr_len(xdr, savep, attrlen);
> xdr_error:
> 	dprintk("%s: xdr returned %d!\n", __func__, -status);
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 465fa98258a3..d881f7a38bc9 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -281,5 +281,6 @@ struct nfs_server {
> #define NFS_CAP_OFFLOAD_CANCEL	(1U << 25)
> #define NFS_CAP_LAYOUTERROR	(1U << 26)
> #define NFS_CAP_COPY_NOTIFY	(1U << 27)
> +#define NFS_CAP_XATTR		(1U << 28)
> 
> #endif
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 94c77ed55ce1..5076fe42c693 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1178,6 +1178,7 @@ struct nfs4_server_caps_res {
> 	u32				has_links;
> 	u32				has_symlinks;
> 	u32				fh_expire_type;
> +	u32				has_xattr;
> };
> 
> #define NFS4_PATHNAME_MAXCOMPONENTS 512
> --
> 2.16.6
