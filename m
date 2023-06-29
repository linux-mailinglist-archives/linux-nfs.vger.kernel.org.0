Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DE7428F0
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjF2Oyo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 10:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjF2Oyn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 10:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF32D63
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 07:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BB016156E
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 14:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589A9C433C8;
        Thu, 29 Jun 2023 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688050480;
        bh=/NFFVxnrjmsCs9ZQJ96SotqiX+g/TQP2lg5gZ5cdeQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGNpqKEYR7iIrMSwdtXRML4ijBTF0CPgXjL7EWPuUg4t6OVKdcVtoZnTzLTwxNA/s
         O6RWHvjwb87+DtrozXxwN0rM7K5VX89NGURHvWGRmgvFc3+8pTU/Jx8cRhJcjedZ29
         wrsYbCxSnTR9ayR1EjT9+/+ZKsMZNgv58VioMzLlNok349ObnVRXA9yoivkkVGye1g
         WKrydibs90rjTCCjV9zTxsjo8jvXSJUZsP1d0vcVQwI7XrsRIPDTGUpXX5qXOw8dAT
         OBcHaP4lGMA/mecZLv3JLwgj9RwTn8hzcIHJW83gGb33xHgUU/OhRYPXXmZZ5fB96N
         vVVeWpnwjomgQ==
Date:   Thu, 29 Jun 2023 10:54:38 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 2/5] NFSD: Enable write delegation support for
 NFSv4.1+ client
Message-ID: <ZJ2bLhHFmOBcX940@manet.1015granger.net>
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
 <1688006176-32597-3-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688006176-32597-3-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 28, 2023 at 07:36:13PM -0700, Dai Ngo wrote:
> This patch grants write delegations for OPEN with NFS4_SHARE_ACCESS_WRITE
> if there is no conflict with other OPENs.
> 
> Write delegation conflicts with another OPEN, REMOVE, RENAME and SETATTR
> are handled the same as read delegation using notify_change,
> try_break_deleg.
> 
> The write delegation support is for NFSv4.1+ client only since the NFSv4.0
> Linux client behavior is not compliant with RFC 7530 Section 16.7.5. It
> expects the server to look ahead in the compound to find a stateid in order
> to determine whether the client that sends the GETATTR is the same client
> that holds the write delegation. RFC 7530 spec does not call for the server
> to look ahead in order to service the GETATTR op.

Here (and the comment below) I would rather state this issue in
terms of protocol constraints.

"The NFSv4.0 protocol does not enable a server to determine that a
conflicting GETATTR originated from the client holding the
delegation versus coming from some other client. With NFSv4.1 and
later, the SEQUENCE operation that begins each COMPOUND contains a
client ID, so delegation recall can be safely squelched in this case.

With NFSv4.0, therefore, the server must recall or send a CB_GETATTR
(per RFC 7530 Section 16.7.5) even when the GETATTR originates from
the client holding that delegation.

An NFSv4.0 client can trigger a pathological situation if it always
sends a DELEGRETURN preceded by a conflicting GETATTR in the same
COMPOUND. COMPOUND execution will always stop at the GETATTR and the
DELEGRETURN will never get executed. The server eventually revokes
the delegation, which can result in loss of open or lock state."

Comments and further edits welcome!


> Tracepoint added to track whether read or write delegation is granted.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++-----------
>  fs/nfsd/trace.h     |  1 +
>  2 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6e61fa3acaf1..f971919b04c7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
>  
>  static struct nfs4_delegation *
>  alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
> -		 struct nfs4_clnt_odstate *odstate)
> +		struct nfs4_clnt_odstate *odstate, u32 dl_type)
>  {
>  	struct nfs4_delegation *dp;
>  	long n;
> @@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>  	INIT_LIST_HEAD(&dp->dl_recall_lru);
>  	dp->dl_clnt_odstate = odstate;
>  	get_clnt_odstate(odstate);
> -	dp->dl_type = NFS4_OPEN_DELEGATE_READ;
> +	dp->dl_type = dl_type;
>  	dp->dl_retries = 1;
>  	dp->dl_recalled = false;
>  	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
> @@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	struct nfs4_delegation *dp;
>  	struct nfsd_file *nf;
>  	struct file_lock *fl;
> +	u32 dl_type;
>  
>  	/*
>  	 * The fi_had_conflict and nfs_get_existing_delegation checks
> @@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	if (fp->fi_had_conflict)
>  		return ERR_PTR(-EAGAIN);
>  
> -	nf = find_readable_file(fp);
> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +		nf = find_writeable_file(fp);
> +		dl_type = NFS4_OPEN_DELEGATE_WRITE;
> +	} else {
> +		nf = find_readable_file(fp);
> +		dl_type = NFS4_OPEN_DELEGATE_READ;
> +	}
>  	if (!nf) {
>  		/*
>  		 * We probably could attempt another open and get a read
> @@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		return ERR_PTR(status);
>  
>  	status = -ENOMEM;
> -	dp = alloc_init_deleg(clp, fp, odstate);
> +	dp = alloc_init_deleg(clp, fp, odstate, dl_type);
>  	if (!dp)
>  		goto out_delegees;
>  
> -	fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
> +	fl = nfs4_alloc_init_lease(dp, dl_type);
>  	if (!fl)
>  		goto out_clnt_odstate;
>  
> @@ -5570,8 +5577,13 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
>  /*
>   * Attempt to hand out a delegation.
>   *
> - * Note we don't support write delegations, and won't until the vfs has
> - * proper support for them.
> + * Note we don't support write delegations for NFSv4.0 client since the Linux
> + * client behavior is not compliant with RFC 7530 Section 16.7.5 with regard
> + * to handle the conflict GETATTR. It expects the server to look ahead in the
> + * compound (PUTFH, GETATTR, DELEGRETURN) to find a stateid in order to
> + * determine whether the client that sends the GETATTR is the same with the
> + * client that holds the write delegation. RFC 7530 spec does not call for
> + * the server to look ahead in order to service the conflict GETATTR op.
>   */
>  static void
>  nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> @@ -5590,8 +5602,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		case NFS4_OPEN_CLAIM_PREVIOUS:
>  			if (!cb_up)
>  				open->op_recall = 1;
> -			if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ)
> -				goto out_no_deleg;
>  			break;
>  		case NFS4_OPEN_CLAIM_NULL:
>  			parent = currentfh;
> @@ -5606,6 +5616,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  				goto out_no_deleg;
>  			if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
>  				goto out_no_deleg;
> +			if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE &&
> +					!clp->cl_minorversion)
> +				goto out_no_deleg;
>  			break;
>  		default:
>  			goto out_no_deleg;
> @@ -5616,8 +5629,13 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  
>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>  
> -	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> -	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
> +		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> +	} else {
> +		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
> +		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> +	}
>  	nfs4_put_stid(&dp->dl_stid);
>  	return;
>  out_no_deleg:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 72a906a053dc..56f28364cc6b 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -607,6 +607,7 @@ DEFINE_STATEID_EVENT(layout_recall_release);
>  
>  DEFINE_STATEID_EVENT(open);
>  DEFINE_STATEID_EVENT(deleg_read);
> +DEFINE_STATEID_EVENT(deleg_write);
>  DEFINE_STATEID_EVENT(deleg_return);
>  DEFINE_STATEID_EVENT(deleg_recall);
>  
> -- 
> 2.39.3
> 
