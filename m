Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304CB625D7C
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiKKOue (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 09:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiKKOuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 09:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238AA532CE;
        Fri, 11 Nov 2022 06:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2E7CB8262E;
        Fri, 11 Nov 2022 14:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2715C433C1;
        Fri, 11 Nov 2022 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668178217;
        bh=iCLjWMPbfoh16X7pYdvXNGmxZTqAzxVpz4NBBs8pJhs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o1B3isv3nOETepxAnGjwTi1UtBQLXiNIdvIaTRvA+NqqGwYzmtm7Kf4jw0reiB8uo
         NUZvtzNz0eVeWcpooIGWlstMbzi/0DETeBtpclSiu77iF96/GhicS9gWIn2FH8s82/
         0ZRUjWzeGzReWnEpbJrUFQoY8ocbsBV4u2yI5IXc2zufZw/cDu8pVg5qi3E4jxsgF7
         QYpnUuO1tF1ptMI3qAze4kemGU9ztFZOZScBeQb/gCPIKwdKtvO7X4vtXHUclhklPM
         HdkEEQjkRPNnV5Om6UMXvNnpDHYgJx2iHkpzVdqr2C9hn6C60kRD0IAQYoED3hFDA2
         siv5EOaT2V8Kg==
Message-ID: <a962c50bf96528468e33a91bbde016cf780a2d78.camel@kernel.org>
Subject: Re: [PATCH -next] NFSD: Use struct_size() helpler in alloc_session()
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 11 Nov 2022 09:50:15 -0500
In-Reply-To: <20221111091835.151942-1-xiujianfeng@huawei.com>
References: <20221111091835.151942-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-11-11 at 17:18 +0800, Xiu Jianfeng wrote:
> Use struct_size() helper to simplify the code, no functional changes.
>=20
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  fs/nfsd/nfs4state.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2ec981fd2985..97badca3135e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1833,13 +1833,12 @@ static struct nfsd4_session *alloc_session(struct=
 nfsd4_channel_attrs *fattrs,
>  	int numslots =3D fattrs->maxreqs;
>  	int slotsize =3D slot_bytes(fattrs);
>  	struct nfsd4_session *new;
> -	int mem, i;
> +	int i;
> =20
> -	BUILD_BUG_ON(NFSD_MAX_SLOTS_PER_SESSION * sizeof(struct nfsd4_slot *)
> -			+ sizeof(struct nfsd4_session) > PAGE_SIZE);
> -	mem =3D numslots * sizeof(struct nfsd4_slot *);
> +	BUILD_BUG_ON(struct_size(new, se_slots, NFSD_MAX_SLOTS_PER_SESSION)
> +		     > PAGE_SIZE);
> =20
> -	new =3D kzalloc(sizeof(*new) + mem, GFP_KERNEL);
> +	new =3D kzalloc(struct_size(new, se_slots, numslots), GFP_KERNEL);
>  	if (!new)
>  		return NULL;
>  	/* allocate each struct nfsd4_slot and data cache in one piece */

Reviewed-by: Jeff Layton <jlayton@kernel.org>
