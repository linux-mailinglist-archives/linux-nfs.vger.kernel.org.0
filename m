Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90678702B55
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 13:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbjEOLVa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbjEOLVW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 07:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88899189;
        Mon, 15 May 2023 04:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A1A622A2;
        Mon, 15 May 2023 11:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29F6C433EF;
        Mon, 15 May 2023 11:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684149676;
        bh=i8R4ZHlQNtjYj8yfNoBTP4YCAmQ9Q1y7fL64MkEt668=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=essTLvsZbf+9I99/Sz/ANCYPD1SvFqzuHuxe4Bp+km8E47gAhoPQgmE4NYTXsDByS
         2+Cy9XvSVERsN8iXM/NHeFXPxMiYzx0GHItjVreqyd/1dymaxMeEzlBLaYrg2m/pZ9
         B3Ja09Sb34qOMEg4uPOWDAof7ZJC0PXNLYlJb0STfrA3Hjep/nWKdljpFx3jPTftJZ
         paowHtVBgw6rUL07k9y2UCKIFWLWVd3vmbOaV3f6+H0Q8yN1i5AF+NddWKtMNf+x41
         D+B/OaNIhiP7Nc0SamjltMMsIcw0ZwbED5aBixk0LQ10pOqO9DLv7YKSsaTdD354xf
         aAJbrfwmPV0Tg==
Message-ID: <338aa895e02c795329c980cee67463faef0fc57e.camel@kernel.org>
Subject: Re: [PATCH v3] NFSD: Remove open coding of string copy
From:   Jeff Layton <jlayton@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-hardening@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 May 2023 07:21:14 -0400
In-Reply-To: <20230515024044.2677124-1-azeemshaikh38@gmail.com>
References: <20230515024044.2677124-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-05-15 at 02:40 +0000, Azeem Shaikh wrote:
> Instead of open coding a __dynamic_array(), use the __string() and
> __assign_str() helper macros that exist for this kind of use case.
>=20
> Part of an effort to remove deprecated strlcpy() [1] completely from the
> kernel[2].
>=20
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>=20
> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  fs/nfsd/trace.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 4183819ea082..72a906a053dc 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
>  		__field(u32, cl_id)
>  		__field(unsigned long, authflavor)
>  		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
> -		__array(unsigned char, netid, 8)
> +		__string(netid, netid)
>  	),
>  	TP_fast_assign(
>  		__entry->cl_boot =3D clp->cl_clientid.cl_boot;
>  		__entry->cl_id =3D clp->cl_clientid.cl_id;
> -		strlcpy(__entry->netid, netid, sizeof(__entry->netid));
> +		__assign_str(netid, netid);
>  		__entry->authflavor =3D authflavor;
>  		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
>  				  clp->cl_cb_conn.cb_addrlen)
>  	),
>  	TP_printk("addr=3D%pISpc client %08x:%08x proto=3D%s flavor=3D%s",
>  		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
> -		__entry->netid, show_nfsd_authflavor(__entry->authflavor))
> +		__get_str(netid), show_nfsd_authflavor(__entry->authflavor))
>  );
> =20
>  TRACE_EVENT(nfsd_cb_setup_err,

Reviewed-by: Jeff Layton <jlayton@kernel.org>
