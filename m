Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A9064AFBE
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 07:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiLMGTR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 01:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiLMGTR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 01:19:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CA61C138
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 22:19:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3044B80EA3
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 06:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF23C433D2;
        Tue, 13 Dec 2022 06:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670912353;
        bh=WJwzWyV+Ay6DXnMG6Bulehh50COINLX9jzWtDKqHP6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTNINr6j+fp1B7/yvXnlOQKiPACvxosCP2qQP15qZi7VuuNz+YcuejP14LVyYLRWZ
         lkPsxeuot5x6LMNL4NxWAW3aJbW10XFSu7efYrisQTWStEittdyZDlBoLsQjg4Lz4W
         JtKnP8dvBaYu5GpSEStzBGu+l8xSvdUSXcbK11tA=
Date:   Tue, 13 Dec 2022 07:19:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        hdthky0@gmail.com, linux-nfs@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH v3 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Message-ID: <Y5gZXoq9dABj8ehu@kroah.com>
References: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 12, 2022 at 02:50:11PM -0800, Dai Ngo wrote:
> Problem caused by source's vfsmount being unmounted but remains
> on the delayed unmount list. This happens when nfs42_ssc_open()
> return errors.
> 
> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
> for the laundromat to unmount when idle time expires.
> 
> We don't need to call nfs_do_sb_deactive when nfs42_ssc_open
> return errors since the file was not opened so nfs_server->active
> was not incremented. Same as in nfsd4_copy, if we fail to
> launch nfsd4_do_async_copy thread then there's no need to
> call nfs_do_sb_deactive
> 
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8beb2bc4c328..b79ee65ae016 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>  	return status;
>  }
>  
> -static void
> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> -{
> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
> -	mntput(ss_mnt);
> -}
> -
>  /*
>   * Verify COPY destination stateid.
>   *
> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>  {
>  }
>  
> -static void
> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> -{
> -}
> -
>  static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>  				   struct nfs_fh *src_fh,
>  				   nfs4_stateid *stateid)
> @@ -1771,7 +1759,7 @@ static int nfsd4_do_async_copy(void *data)
>  			default:
>  				nfserr = nfserr_offload_denied;
>  			}
> -			nfsd4_interssc_disconnect(copy->ss_mnt);
> +			/* ss_mnt will be unmounted by the laundromat */
>  			goto do_callback;
>  		}
>  		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> @@ -1852,8 +1840,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	if (async_copy)
>  		cleanup_async_copy(async_copy);
>  	status = nfserrno(-ENOMEM);
> -	if (nfsd4_ssc_is_inter(copy))
> -		nfsd4_interssc_disconnect(copy->ss_mnt);
> +	/*
> +	 * source's vfsmount of inter-copy will be unmounted
> +	 * by the laundromat
> +	 */
>  	goto out;
>  }
>  
> -- 
> 2.9.5
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
