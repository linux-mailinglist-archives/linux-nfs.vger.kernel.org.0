Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B660539938F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhFBTfg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 15:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBTff (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 15:35:35 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A24C061756
        for <linux-nfs@vger.kernel.org>; Wed,  2 Jun 2021 12:33:52 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DCA9DABC; Wed,  2 Jun 2021 15:33:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DCA9DABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1622662429;
        bh=vnePtqLLv/MP76cagFCkP2Eo47v2jknjimICAmKccLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARFzj7VigTW/fAY3mvSoMbb9ycYvFC3fPdu/EOF73Wmc8bw0LB4vQS8Y1I2kFrqU5
         X+Iu/YkN6yPOwTKkCqkBeAmImZAOoATQOAQN7Pk6iWEQrdRevGEgtfWhmjvhkvph+W
         R9oJ0H8IODRkKhKgFzBAAXIJVPW01PTqhaJFHGko=
Date:   Wed, 2 Jun 2021 15:33:49 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 1/1] nfsd4: Expose the callback address and state of
 each NFS4 client
Message-ID: <20210602193349.GA6995@fieldses.org>
References: <20210602175139.436357-1-dwysocha@redhat.com>
 <20210602175139.436357-2-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602175139.436357-2-dwysocha@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applied.--b.

On Wed, Jun 02, 2021 at 01:51:39PM -0400, Dave Wysochanski wrote:
> In addition to the client's address, display the callback channel
> state and address in the 'info' file.
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c404c6ec52af..967912b4a7dd 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2358,6 +2358,21 @@ static void seq_quote_mem(struct seq_file *m, char *data, int len)
>  	seq_printf(m, "\"");
>  }
>  
> +static const char *cb_state2str(int state)
> +{
> +	switch (state) {
> +	case NFSD4_CB_UP:
> +		return "UP";
> +	case NFSD4_CB_UNKNOWN:
> +		return "UNKNOWN";
> +	case NFSD4_CB_DOWN:
> +		return "DOWN";
> +	case NFSD4_CB_FAULT:
> +		return "FAULT";
> +	}
> +	return "UNDEFINED";
> +}
> +
>  static int client_info_show(struct seq_file *m, void *v)
>  {
>  	struct inode *inode = m->private;
> @@ -2386,6 +2401,8 @@ static int client_info_show(struct seq_file *m, void *v)
>  		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
>  			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
>  	}
> +	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
> +	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
>  	drop_client(clp);
>  
>  	return 0;
> -- 
> 2.31.1
