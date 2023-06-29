Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8F742907
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 17:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjF2PCf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 11:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjF2PCf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 11:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092E930C5
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 08:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7482D6156F
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 15:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2F2C433C0;
        Thu, 29 Jun 2023 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688050952;
        bh=tLcCgoJ08Zvh5IP3/r7ziUFGtuzxch5Uen6IZ6Sx3Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=biZzo1gxxL72wg9pK7Zvn5aLpOhSJhwb6hIcHFTx4/VufDNzTDi7R8/4Br6ScJu3g
         1/s7XAtQ48GXrMgXrdl82LOxo6/LtSYtIQ6spBq+YY5ygE4R8DAF81aDjfoCplP0da
         soBNKntGR7ra3v9xdU0sADQ6DJ6OT47syHYrw22eDPL6Kcn2tWu32K0tPvN0PvuBz2
         AVGK27OXbtPPgyaSHCFkMv+Celd8DtgrGvjZcZmZUhEEupSOzz7L6oAeEhdHTk5exs
         Q+BcDiKxXUqRoMwMWCZlfWV+qsbETdRXzOKn1iL13Id1gqiJd9c84S3Ka4h+uJXZYn
         mI2LneDlrXBZg==
Date:   Thu, 29 Jun 2023 11:02:30 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 4/5] NFSD: allow client to use write delegation
 stateid for READ
Message-ID: <ZJ2dBnw2PZOMB0oQ@manet.1015granger.net>
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
 <1688006176-32597-5-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688006176-32597-5-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 28, 2023 at 07:36:15PM -0700, Dai Ngo wrote:
> Allow NFSv4 client to use write delegation stateid for READ operation.
> Per RFC 8881 section 9.1.2. Use of the Stateid and Locking.

I'm wondering if this fix should precede 2/5 to prevent breakage
during a bisect. Jeff, what do you think?


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 16 ++++++++++++++--
>  fs/nfsd/nfs4xdr.c  |  9 +++++++++
>  fs/nfsd/xdr4.h     |  2 ++
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5ae670807449..3fa66cb38780 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -942,8 +942,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	/* check stateid */
>  	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>  					&read->rd_stateid, RD_STATE,
> -					&read->rd_nf, NULL);
> -
> +					&read->rd_nf, &read->rd_wd_stid);
> +	/*
> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> +	 * delegation stateid used for read. Its refcount is decremented
> +	 * by nfsd4_read_release when read is done.
> +	 */
> +	if (!status && (read->rd_wd_stid->sc_type != NFS4_DELEG_STID ||
> +			delegstateid(read->rd_wd_stid)->dl_type !=
> +			NFS4_OPEN_DELEGATE_WRITE)) {
> +		nfs4_put_stid(read->rd_wd_stid);
> +		read->rd_wd_stid = NULL;
> +	}
>  	read->rd_rqstp = rqstp;
>  	read->rd_fhp = &cstate->current_fh;
>  	return status;
> @@ -953,6 +963,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  static void
>  nfsd4_read_release(union nfsd4_op_u *u)
>  {
> +	if (u->read.rd_wd_stid)
> +		nfs4_put_stid(u->read.rd_wd_stid);
>  	if (u->read.rd_nf)
>  		nfsd_file_put(u->read.rd_nf);
>  	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index b35855c8beb6..833634cdc761 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4125,6 +4125,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	struct file *file;
>  	int starting_len = xdr->buf->len;
>  	__be32 *p;
> +	fmode_t o_fmode = 0;
>  
>  	if (nfserr)
>  		return nfserr;
> @@ -4144,10 +4145,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	maxcount = min_t(unsigned long, read->rd_length,
>  			 (xdr->buf->buflen - xdr->buf->len));
>  
> +	if (read->rd_wd_stid) {
> +		/* allow READ using write delegation stateid */
> +		o_fmode = file->f_mode;
> +		file->f_mode |= FMODE_READ;
> +	}
>  	if (file->f_op->splice_read && splice_ok)
>  		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
>  	else
>  		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
> +	if (o_fmode)
> +		file->f_mode = o_fmode;
> +
>  	if (nfserr) {
>  		xdr_truncate_encode(xdr, starting_len);
>  		return nfserr;
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 510978e602da..3ccc40f9274a 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -307,6 +307,8 @@ struct nfsd4_read {
>  	struct svc_rqst		*rd_rqstp;          /* response */
>  	struct svc_fh		*rd_fhp;            /* response */
>  	u32			rd_eof;             /* response */
> +
> +	struct nfs4_stid	*rd_wd_stid;		/* internal */
>  };
>  
>  struct nfsd4_readdir {
> -- 
> 2.39.3
> 
