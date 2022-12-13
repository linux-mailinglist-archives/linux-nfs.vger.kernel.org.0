Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5F64AFBC
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 07:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiLMGRo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 01:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiLMGRm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 01:17:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92171BDE
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 22:17:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 152FCCE129A
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 06:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5861C433D2;
        Tue, 13 Dec 2022 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670912255;
        bh=dI9FM7s8lpPHRmBaz4QphmdmpKfShpn5IHWSYlQY4/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5nEvdvC14VYaB3GT4IJEZwulxnO01xIpWhQT+2hA+fg+AW8WN7GCEUtZT9MBV0C3
         vM3Gp+tj0FZ3XFTuPkXjiinLlPNYW+boIdT1afRYwfrvInlv6/jB6pYruwA700yMt2
         /XiwZVqPqNiZmoRc6aGhugIrk6id71ZrUZnueSWg=
Date:   Tue, 13 Dec 2022 07:17:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        hdthky0@gmail.com, linux-nfs@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH v2 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Message-ID: <Y5gY/BHp2HGwUEhn@kroah.com>
References: <1670857869-14618-1-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670857869-14618-1-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 12, 2022 at 07:11:09AM -0800, Dai Ngo wrote:
> Problem caused by source's vfsmount being unmounted but remains
> on the delayed unmount list. This happens when nfs42_ssc_open()
> return errors.
> 
> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
> for the laundromat to unmount when idle time expires.
> 
> Removed unneeded check for NULL nfsd_net and added pr_warn
> if vfsmount not found on delayed unmount list.
> 
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8beb2bc4c328..84646df60212 100644
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
> @@ -1526,10 +1519,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>  	nfsd_file_put(dst);
>  	fput(filp);
>  
> -	if (!nn) {
> -		mntput(ss_mnt);
> -		return;
> -	}
>  	spin_lock(&nn->nfsd_ssc_lock);
>  	timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>  	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
> @@ -1548,10 +1537,8 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>  		}
>  	}
>  	spin_unlock(&nn->nfsd_ssc_lock);
> -	if (!found) {
> -		mntput(ss_mnt);
> -		return;
> -	}
> +	if (!found)
> +		pr_warn("vfsmount not found on delayed unmount list\n");
>  }
>  
>  #else /* CONFIG_NFSD_V4_2_INTER_SSC */
> @@ -1572,11 +1559,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
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
> @@ -1762,7 +1744,7 @@ static int nfsd4_do_async_copy(void *data)
>  		struct file *filp;
>  
>  		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> -				      &copy->stateid);
> +					&copy->stateid);
>  		if (IS_ERR(filp)) {
>  			switch (PTR_ERR(filp)) {
>  			case -EBADF:
> @@ -1771,7 +1753,7 @@ static int nfsd4_do_async_copy(void *data)
>  			default:
>  				nfserr = nfserr_offload_denied;
>  			}
> -			nfsd4_interssc_disconnect(copy->ss_mnt);
> +			/* ss_mnt will be unmounted by the laundromat */
>  			goto do_callback;
>  		}
>  		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> @@ -1852,8 +1834,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
