Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC35A4CC6
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 15:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiH2NAy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiH2NAj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 09:00:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835E4BF49
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 05:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 825CCB80EB8
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 12:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4A6C433C1;
        Mon, 29 Aug 2022 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661777503;
        bh=fSUdkxbja7lcfVQ73jNZARex9PizyyXNu3LKmqOmIVo=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=SgPCPfSO9d63dDJc5tNlbzSBu3yrJn8CmeKGgb0nfPIZI/Wr+utP6C8jOpmNZsCyL
         n5TEA+GNbSwPPTDqBJGJJf3GYnqWhTehZ5qAoPudAyICHexX5cgtpPgDL2lLFG5zHc
         zfemtDDPzygW3tQ2cdkIWVV9VuUtIM+XYx0wgqAe1KHOTCxdgDdGiIANMo5zfYUZV9
         Af9OoYvPLJtSJqWreZKcNPLrmq6fMopX5rRJXjrxmnNe/evw3fF0REelEC2cW5PWkd
         irgNX3jJ2Zd33rue6PDBGI3EDWhRneLkesTriXRU2EJ9HlI9axMO6YLXj2Rzs/sIkR
         lDQEkW3tNWS/w==
Message-ID: <91b52aee40b0d6b4aeb94ea53e3e93a0504df5d8.camel@kernel.org>
Subject: Re: [PATCH v2 2/7] SUNRPC: Fix svcxdr_init_encode's buflen
 calculation
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 29 Aug 2022 08:51:41 -0400
In-Reply-To: <166171262829.21449.4256057697517661592.stgit@manet.1015granger.net>
References: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
         <166171262829.21449.4256057697517661592.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-08-28 at 14:50 -0400, Chuck Lever wrote:
> Commit 2825a7f90753 ("nfsd4: allow encoding across page boundaries")
> added an explicit computation of the remaining length in the rq_res
> XDR buffer.
>=20
> The computation appears to suffer from an "off-by-one" bug. Because
> buflen is too large by one page, XDR encoding can run off the end of
> the send buffer by eventually trying to use the struct page address
> in rq_page_end, which always contains NULL.
>=20
> Fixes: bddfdbcddbe2 ("NFSD: Extract the svcxdr_init_encode() helper")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 5a830b66f059..0ca8a8ffb47e 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -587,7 +587,7 @@ static inline void svcxdr_init_encode(struct svc_rqst=
 *rqstp)
>  	xdr->end =3D resv->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
>  	buf->len =3D resv->iov_len;
>  	xdr->page_ptr =3D buf->pages - 1;
> -	buf->buflen =3D PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages);
> +	buf->buflen =3D PAGE_SIZE * (rqstp->rq_page_end - buf->pages);
>  	buf->buflen -=3D rqstp->rq_auth_slack;
>  	xdr->rqst =3D NULL;
>  }
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
