Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1B617A25
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 10:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKCJoB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 05:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiKCJn7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 05:43:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B35DE000;
        Thu,  3 Nov 2022 02:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98C5961DE9;
        Thu,  3 Nov 2022 09:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563B0C433D7;
        Thu,  3 Nov 2022 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667468637;
        bh=XzEvIrX1GsJ9EJXjvZzaDHnIgE7EMAXUzm9XgvvGA7Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t8PHRGgiyQduCdaSCfdlX7Pcura6DQWd5KeEQhVc8rr1ozBzsuw+z4zbTe9DGy6dc
         isIQI+INlKVjQW7nbmAxU+qC0ub2oiZcbZXSblzBXokVY15hsCfBtcJzScFPn4/tTJ
         +jtLjI6UVhzhSdWMvOtKM8EhyGeikyrSxE0ynWOLPlV4fyryKNGaccc1tcTZrII7V4
         1qOCGg5IrEiSQPWsdGc5N2MXB84QJWUz1rHk2hAPKRb+H+oAMDYHs2+uB1gjK+i+J8
         f3+PeJ2AyrwvgXr+twxTipCh4fXOwDttYxBWmmO2i6U3eZeK5MUIOT8Uz3Sh31me58
         2aFSSFU7GLdGw==
Message-ID: <6e67efff3f5f72d7bcdf90b972cd758e0e98e853.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: svc: Remove unnecessary (void*) conversions
From:   Jeff Layton <jlayton@kernel.org>
To:     Li zeming <zeming@nfschina.com>, chuck.lever@oracle.com,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Nov 2022 05:43:55 -0400
In-Reply-To: <20221103013510.3062-1-zeming@nfschina.com>
References: <20221103013510.3062-1-zeming@nfschina.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-11-03 at 09:35 +0800, Li zeming wrote:
> The iov_base pointer does not need to cast the type.
>=20
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  include/linux/sunrpc/svc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index daecb009c05b..4b0eead91c94 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -222,7 +222,7 @@ static inline __be32 svc_getu32(struct kvec *iov)
> =20
>  static inline void svc_ungetu32(struct kvec *iov)
>  {
> -	__be32 *vp =3D (__be32 *)iov->iov_base;
> +	__be32 *vp =3D iov->iov_base;
>  	iov->iov_base =3D (void *)(vp - 1);
>  	iov->iov_len +=3D sizeof(*vp);
>  }

Reviewed-by: Jeff Layton <jlayton@kernel.org>
