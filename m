Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04349613A3C
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 16:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiJaPjT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiJaPjQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 11:39:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3DDFE3
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 08:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36FE6B818EB
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 15:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77169C433C1;
        Mon, 31 Oct 2022 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230752;
        bh=6+We/lCvchKROpxIJsfdevseumZ3gCHXZA9GaYlZG6M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UcKuMsrzzQsjNDT+KiGIRWihu/h/Z/bp9RMhpzwKssG09ZtA1DAXx57ESfmRoS9Xp
         k20lUHDRWEkwjSKhQnxCFz4loxzabyiUtxUGi33wS7N/Fxe8OK6ktZ3ziSezLahs0h
         COFfauXvaaz+4FK2w+eVdR50FphdnyqDyOzR1qczMS9JmJAHNcnYmB0nG/KKE2ZBh0
         lmfrSEEO3KRlnBuzrTH9MitAqqi3DnUJQlVQ5dw1YlJYX4eSK/GJcIB3xmF+Sq4SwK
         wm+uicbQHTOMbDC1GMTA4m4X5V1RSVvjYNZKEWRxXhAHYfWsDC0vOcZ9mp49ZLELn0
         6tuVa66sGmTJA==
Message-ID: <997d75d350a8c879f5ebf5b14b0e818adc576370.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Fix licensing header in filecache.c
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     hch@lst.de
Date:   Mon, 31 Oct 2022 11:39:11 -0400
In-Reply-To: <166722440655.129596.2850004689493079984.stgit@klimt.1015granger.net>
References: <166722440655.129596.2850004689493079984.stgit@klimt.1015granger.net>
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

On Mon, 2022-10-31 at 09:53 -0400, Chuck Lever wrote:
> Add a missing SPDX header.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 965c7b13fddc..dcf9c6ca412a 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1,5 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Open file cache.
> + * The NFSD open file cache.
>   *
>   * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
>   */
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
