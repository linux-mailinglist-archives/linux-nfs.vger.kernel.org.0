Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67DAE7B605
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2019 01:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfG3XDk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 19:03:40 -0400
Received: from fieldses.org ([173.255.197.46]:41902 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfG3XDk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Jul 2019 19:03:40 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id DADB82010; Tue, 30 Jul 2019 19:03:39 -0400 (EDT)
Date:   Tue, 30 Jul 2019 19:03:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: nfsd: Fix three possible null-pointer dereferences
Message-ID: <20190730230339.GD3544@fieldses.org>
References: <20190724082803.1077-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724082803.1077-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 24, 2019 at 04:28:03PM +0800, Jia-Ju Bai wrote:
> In nfs4_xdr_dec_cb_recall(), nfs4_xdr_dec_cb_layout() and
> nfs4_xdr_dec_cb_notify_lock(), there is an if statement to check whether
> cb is NULL.
> 
> When cb is NULL, the three functions all call:
>     decode_cb_op_status(..., &cb->cb_status);
> 
> Thus, possible null-pointer dereferences may occur.
> 
> To fix these possible bugs, -EINVAL is returned when cb is NULL.
> 
> These bugs are found by a static analysis tool STCheck written by us.

Thanks!  But I think actually the correct fix is just to remove the NULL
checks entirely.

--b.

> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/nfsd/nfs4callback.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 397eb7820929..55949a158b6b 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -516,7 +516,8 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
>  		status = decode_cb_sequence4res(xdr, cb);
>  		if (unlikely(status || cb->cb_seq_status))
>  			return status;
> -	}
> +	} else
> +		return -EINVAL;
>  
>  	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>  }
> @@ -608,7 +609,9 @@ static int nfs4_xdr_dec_cb_layout(struct rpc_rqst *rqstp,
>  		status = decode_cb_sequence4res(xdr, cb);
>  		if (unlikely(status || cb->cb_seq_status))
>  			return status;
> -	}
> +	} else
> +		return -EINVAL;
> +
>  	return decode_cb_op_status(xdr, OP_CB_LAYOUTRECALL, &cb->cb_status);
>  }
>  #endif /* CONFIG_NFSD_PNFS */
> @@ -667,7 +670,9 @@ static int nfs4_xdr_dec_cb_notify_lock(struct rpc_rqst *rqstp,
>  		status = decode_cb_sequence4res(xdr, cb);
>  		if (unlikely(status || cb->cb_seq_status))
>  			return status;
> -	}
> +	} else
> +		return -EINVAL;
> +	
>  	return decode_cb_op_status(xdr, OP_CB_NOTIFY_LOCK, &cb->cb_status);
>  }
>  
> -- 
> 2.17.0
