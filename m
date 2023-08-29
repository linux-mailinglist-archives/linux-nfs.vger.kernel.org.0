Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9913678CEB7
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 23:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjH2VXO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbjH2VXJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 17:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000361BC
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 14:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90E1F611D1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 21:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A196C433C8;
        Tue, 29 Aug 2023 21:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693344185;
        bh=axgUO/Z+gQt+ODy28e0TXxlDPZ0LOi4DkKA6emrd69c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ud1EEc3dCYBewHFdkDkvalFqOq8TitfdvHQtbk62ct3vEEEKOvVxHYi6Hqb02XpzR
         9cS0VpQbQOnOGlPljlfU6FC5okoTMUFUEIngNj6edABh5jfJsvHSvA/ntJl8J7mpNq
         W0Q4XTXK84FZGXt99w2Ad9v0I8m7VO2KXfPNSOwuQEMVuvNnMpduMKKCVUu2+ifmea
         4CTpWnwpVyJNTvNNp/zV+4wWU4+/FoUBcbi9kvoVLye/MlVxTQs51BaYNhwl4OpUDl
         mCcHpyHslKLydmH7TlBfEWyS/wOUZFtV86FAeYacRGZu6BgdssawrlpB6hIhStS5WA
         qa++nEpD+vatA==
Message-ID: <65f510cdc17fa3e0d2fce9362dd47ddb8b3d8d9c.camel@kernel.org>
Subject: Re: [PATCH v2] SUNRPC: Fix the recent bv_offset fix
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 29 Aug 2023 17:23:04 -0400
In-Reply-To: <169322894408.11188.14223137341540815863.stgit@bazille.1015granger.net>
References: <169322894408.11188.14223137341540815863.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Mon, 2023-08-28 at 09:23 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Jeff confirmed his original fix addressed his pynfs test failure,
> but this same bug also impacted qemu: accessing qcow2 virtual disks
> using direct I/O was failing. Jeff's fix missed that you have to
> shorten the bio_vec element by the same amount as you increased
> the page offset.
>=20
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Fixes: c96e2a695e00 ("sunrpc: set the bv_offset of first bvec in svc_tcp_=
sendmsg")
> Tested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/svcsock.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> v2:
> - Correct Maxim's email addresses.
>=20
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 2eb8df44f894..589020ed909d 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1244,8 +1244,10 @@ static int svc_tcp_sendmsg(struct socket *sock, st=
ruct xdr_buf *xdr,
>  	if (ret !=3D head->iov_len)
>  		goto out;
> =20
> -	if (xdr_buf_pagecount(xdr))
> +	if (xdr_buf_pagecount(xdr)) {
>  		xdr->bvec[0].bv_offset =3D offset_in_page(xdr->page_base);
> +		xdr->bvec[0].bv_len -=3D offset_in_page(xdr->page_base);
> +	}
> =20
>  	msg.msg_flags =3D MSG_SPLICE_PAGES;
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
