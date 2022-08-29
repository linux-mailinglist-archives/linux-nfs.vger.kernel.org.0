Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21665A4E87
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiH2Ntl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiH2Ntk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 09:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF0996749
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 06:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29C7D60E65
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 13:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46253C433D7;
        Mon, 29 Aug 2022 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661780976;
        bh=T0UKPz07TRsnqwC25JVYc7iV3n614QIpJp+EIFVd+h8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=hrLkAm6FAyll1PZivQoNxrRnscuqcfOqrIbE1JzuAV6VJwfLP1wwq+5/MK4w1M8B/
         0YAa8WSUbKVRoQyY7RACgvMgcauWXfaPiHnXjMSDxz0Gj5j+mTvhYHhRzctNJIo5fs
         f3SRWpmunzqcSwRg+XdxApjdjBndROYhrFxpB3WVSsZ4s/bKkklsWxOGxmudKP4GzV
         fHaLGD+8N8kcZAGycC4Jp99rJHkTOBbXHC8gy0E4kP3w3AL22VSATMv7qmZzKbuVAX
         C+hdZykDUUsGfYH6mP9ZfsYmvgn8biKSAFbV5WbGurTlD6LFaqe2Ce9k3dK4YnFP4/
         LW32WepXa3hlA==
Message-ID: <a3dbd2a8e63d17710ee650674a0f2b320f7bdd26.camel@kernel.org>
Subject: Re: [PATCH v2 6/7] SUNRPC: Fix typo in xdr_buf_subsegment's kdoc
 comment
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 29 Aug 2022 09:49:34 -0400
In-Reply-To: <166171265398.21449.11749625023129698282.stgit@manet.1015granger.net>
References: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
         <166171265398.21449.11749625023129698282.stgit@manet.1015granger.net>
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
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xdr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 482586c23fdd..8ad637ca703e 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1575,7 +1575,7 @@ EXPORT_SYMBOL_GPL(xdr_buf_from_iov);
>   *
>   * @buf and @subbuf may be pointers to the same struct xdr_buf.
>   *
> - * Returns -1 if base of length are out of bounds.
> + * Returns -1 if base or length are out of bounds.
>   */
>  int xdr_buf_subsegment(const struct xdr_buf *buf, struct xdr_buf *subbuf=
,
>  		       unsigned int base, unsigned int len)
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
