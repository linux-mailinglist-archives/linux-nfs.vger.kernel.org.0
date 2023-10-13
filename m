Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59AE7C83B2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 12:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjJMKuW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjJMKuV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 06:50:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808F983;
        Fri, 13 Oct 2023 03:50:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27083C433C7;
        Fri, 13 Oct 2023 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697194219;
        bh=DzSNKGUIOplO8sJNh8KxYOTCM0wZruRzV+sDINeuiuw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WIYBIrWqt+1m2hEQ5p/ex1u9HHp76dZN75gyHctuMJR7bTbhuf8TE1VZ2NNjFfI+1
         Zh5eSQTkzmuyrjYpqM/M+qk4pxyMfqcq/VyjFQNH7VYBV6b37wHHx7yzqZBqf30v5C
         H2I9Ce0dt6YYxOl4xxQgsg5DRpewUn+WW309WOB3fZUeYaeTWYh0M8WO2FrQ7fjoqT
         7vxps82CdzE4DmbAX+jsYUQwL4j20dXnD2YLHBj/d5QXDZcfWkVf6us/i8XW4Hm02N
         /5m+YEW6b92BiF8WkYl7mUPPznNw+md4+VO7lEh1broEBkSJehnKGCawgFqp4pu2h6
         SyevNkm15J2JQ==
Message-ID: <5258379d69957db51c5db6f3175898f41be67fc5.camel@kernel.org>
Subject: Re: [PATCH] NFS: Clean up errors in nfs_page.h
From:   Jeff Layton <jlayton@kernel.org>
To:     chenguohua@jari.cn, trond.myklebust@hammerspace.com,
        anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 13 Oct 2023 06:50:16 -0400
In-Reply-To: <2f52e71b.943.18b2705b8cb.Coremail.chenguohua@jari.cn>
References: <2f52e71b.943.18b2705b8cb.Coremail.chenguohua@jari.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-10-13 at 11:12 +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
>=20
> ERROR: space required after that ',' (ctx:VxO)
>=20
> Signed-off-by: JiangHui Xu <xujianghui@cdjrlc.com>
> ---
>  include/linux/nfs_page.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
> index 1c315f854ea8..6a3c54bd2c40 100644
> --- a/include/linux/nfs_page.h
> +++ b/include/linux/nfs_page.h
> @@ -122,7 +122,7 @@ struct nfs_pageio_descriptor {
>  /* arbitrarily selected limit to number of mirrors */
>  #define NFS_PAGEIO_DESCRIPTOR_MIRROR_MAX 16
> =20
> -#define NFS_WBACK_BUSY(req)	(test_bit(PG_BUSY,&(req)->wb_flags))
> +#define NFS_WBACK_BUSY(req)	(test_bit(PG_BUSY, &(req)->wb_flags))
> =20
>  extern struct nfs_page *nfs_page_create_from_page(struct nfs_open_contex=
t *ctx,
>  						  struct page *page,

In general, we don't usually take patches that just clean up whitespace
damage or stylistic problems. Doing so makes backporting harder as you
end up having to pull in extra patches to fix up minor differences
before bringing in substantive patches.

If you're fixing a real bug in the same area, then sure, go ahead and
fix up the style in the surrounding code, but if these patches don't
fix real bugs then I'd suggest not taking them.
--=20
Jeff Layton <jlayton@kernel.org>
