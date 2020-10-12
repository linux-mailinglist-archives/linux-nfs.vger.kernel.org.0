Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1328BA98
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Oct 2020 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgJLOSR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Oct 2020 10:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgJLOSR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Oct 2020 10:18:17 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E6CC0613D0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Oct 2020 07:18:16 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BC1A469C3; Mon, 12 Oct 2020 10:18:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BC1A469C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602512293;
        bh=uYhgJgcssUBTSg6k4zfkFbXUgYkm1howPZsjUJC3+ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DoSNWomi0GTToM3Zf0pkhOUZDovDtABdMQCkg9jeRSo80Mho253CMPt6tyvEA/YLQ
         H7vgVbfAanq773TTZlchCSvOsqxmg5HcBLr1Kuc694bqZYeEVVZK6msVnz5IZoiLhV
         7S9FYeUGucolfbjcMq/jdswaLt2kwkHJkHpUQx6s=
Date:   Mon, 12 Oct 2020 10:18:13 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Artur Molchanov <arturmolchanov@gmail.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] net/sunrpc: Fix return value for sysctl
 sunrpc.transports
Message-ID: <20201012141813.GB26571@fieldses.org>
References: <20C3D746-91F5-45E1-B105-0A1B1ABAA9BB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20C3D746-91F5-45E1-B105-0A1B1ABAA9BB@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 12, 2020 at 01:00:45AM +0300, Artur Molchanov wrote:
> Fix returning value for sysctl sunrpc.transports.
> Return error code from sysctl proc_handler function proc_do_xprt instead of number of the written bytes.
> Otherwise sysctl returns random garbage for this key.
> 
> Since v1:
> - Handle negative returned value from memory_read_from_buffer as an error

Thanks, applying for 5.10.--b.

> 
> 
> Signed-off-by: Artur Molchanov <arturmolchanov@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  net/sunrpc/sysctl.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
> index 999eee1ed61c..e81a28f30f1d 100644
> --- a/net/sunrpc/sysctl.c
> +++ b/net/sunrpc/sysctl.c
> @@ -70,7 +70,13 @@ static int proc_do_xprt(struct ctl_table *table, int write,
>  		return 0;
>  	}
>  	len = svc_print_xprts(tmpbuf, sizeof(tmpbuf));
> -	return memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, len);
> +	*lenp = memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, len);
> +
> +	if (*lenp < 0) {
> +		*lenp = 0;
> +		return -EINVAL;
> +	}
> +	return 0;
>  }
>  
>  static int
> -- 
> 2.20.1
