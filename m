Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132063EFC4
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Dec 2022 12:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiLALoc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Dec 2022 06:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiLALob (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Dec 2022 06:44:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F019D80B
        for <linux-nfs@vger.kernel.org>; Thu,  1 Dec 2022 03:44:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55384B81F15
        for <linux-nfs@vger.kernel.org>; Thu,  1 Dec 2022 11:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7D7C433C1;
        Thu,  1 Dec 2022 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669895068;
        bh=+Djz83ttlR4v6J3lkgiBTyrL/P156r42LXK+kAKwQBw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nXWxCzuJFhqsuIkFfTTev8weo2V0hYLDgjh/UPR+RFffGF7l6UyMPeyia27VnZjKH
         5fOav5jGyKXvm5HJjrVbHvFdLBn1yUryfjwaVlU3GE+1NoKwnpKANxoKw2243gzfgC
         HIHy8KGnRoy4eW4WiCE1rFdxNsU+V6gUVv+jeEegYjoPelHEyFtwDR+vi9F6spKtZW
         fTC4xep5hBmUdb8Aa4FXZzSUShiWqGi9QHCOXZAbCExmGS2OFIeaCENyY0PUwn/KKW
         gJWyO05vj3J9keeooqZzAgppvUPIwa+mrHsKi3oedFJnhWI41MQeGAaqvVTjEJKCPb
         05vrJBbW/DPOA==
Message-ID: <23eddc9b078dd50f48d6bc7b0084f456dd4f1f9d.camel@kernel.org>
Subject: Re: [PATCH] NFS: Allow very small rsize & wsize again
From:   Jeff Layton <jlayton@kernel.org>
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com
Cc:     tom@talpey.com
Date:   Thu, 01 Dec 2022 06:44:26 -0500
In-Reply-To: <20221130203047.1303804-1-anna@kernel.org>
References: <20221130203047.1303804-1-anna@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-11-30 at 15:30 -0500, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> 940261a19508 introduced nfs_io_size() to clamp the iosize to a multiple
> of PAGE_SIZE. This had the unintended side effect of no longer allowing
> iosizes less than a page, which could be useful in some situations.
>=20
> UDP already has an exception that causes it to fall back on the
> power-of-two style sizes instead. This patch adds an additional
> exception for very small iosizes.
>=20
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Fixes: 940261a19508 ("NFS: Allow setting rsize / wsize to a multiple of P=
AGE_SIZE")
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  fs/nfs/internal.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 647fc3f547cb..ae7d4a8c728c 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -739,12 +739,10 @@ unsigned long nfs_io_size(unsigned long iosize, enu=
m xprt_transports proto)
>  		iosize =3D NFS_DEF_FILE_IO_SIZE;
>  	else if (iosize >=3D NFS_MAX_FILE_IO_SIZE)
>  		iosize =3D NFS_MAX_FILE_IO_SIZE;
> -	else
> -		iosize =3D iosize & PAGE_MASK;
> =20
> -	if (proto =3D=3D XPRT_TRANSPORT_UDP)
> +	if (proto =3D=3D XPRT_TRANSPORT_UDP || iosize < PAGE_SIZE)
>  		return nfs_block_bits(iosize, NULL);
> -	return iosize;
> +	return iosize & PAGE_MASK;
>  }
> =20
>  /*

Looks good. Thanks, Anna.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
