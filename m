Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313DC767863
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jul 2023 00:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjG1WNV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 18:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjG1WNV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 18:13:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36B8448A
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 15:13:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FB11218F2;
        Fri, 28 Jul 2023 22:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690582398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kLMwARu70gSWHYmOi4s/pBx0/Zye4clT032Nwsd9pg=;
        b=GL5f8UPGCBqf5bI6EnP0t5asS2RNnPTLrcDGq6asxy1Kj5jHd6x4wxaLnKy0PSZd8RSOPW
        jMOcPZeugnZEbEdvgmpJy3eHv7mmI2JGKw/uPTLjXig6gMWakTjdaiaKvl79bwwGBYEzlE
        nnuKbvEpttL4Lg3L7ov5zgm3PJxHEUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690582398;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kLMwARu70gSWHYmOi4s/pBx0/Zye4clT032Nwsd9pg=;
        b=tG7T+6hB4gbdKGJQint0g5MQXbOKCQ69VHgNsqY25cJdkM4HanWXyCd1x7nx3JN56GgoYV
        k8fANwawybUloqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5092B133F7;
        Fri, 28 Jul 2023 22:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kD9cAXw9xGRyXAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 28 Jul 2023 22:13:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: Re: [PATCH v4 1/2] SUNRPC: add verbose parameter to __svc_print_addr()
In-reply-to: <5b0eff4e3ef9bf9621f5095189933f60def40f0d.1690569488.git.lorenzo@kernel.org>
References: <cover.1690569488.git.lorenzo@kernel.org>,
 <5b0eff4e3ef9bf9621f5095189933f60def40f0d.1690569488.git.lorenzo@kernel.org>
Date:   Sat, 29 Jul 2023 08:13:13 +1000
Message-id: <169058239308.32308.14184895022271604035@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 29 Jul 2023, Lorenzo Bianconi wrote:
> Introduce verbose parameter to utility routine in order to reduce output
> verbosity. This is a preliminary patch to add rpc_status entry in nfsd
> debug filesystem in order to dump pending RPC requests debugging
> information.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/linux/sunrpc/svc_xprt.h | 12 ++++++------
>  net/sunrpc/svc_xprt.c           |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xpr=
t.h
> index a6b12631db21..1715d4c6bd6b 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -209,21 +209,21 @@ static inline unsigned short svc_xprt_remote_port(con=
st struct svc_xprt *xprt)
>  }
> =20
>  static inline char *__svc_print_addr(const struct sockaddr *addr,
> -				     char *buf, const size_t len)
> +				     char *buf, const size_t len,
> +				     bool verbose)
>  {
>  	const struct sockaddr_in *sin =3D (const struct sockaddr_in *)addr;
>  	const struct sockaddr_in6 *sin6 =3D (const struct sockaddr_in6 *)addr;
> =20
>  	switch (addr->sa_family) {
>  	case AF_INET:
> -		snprintf(buf, len, "%pI4, port=3D%u", &sin->sin_addr,
> -			ntohs(sin->sin_port));
> +		snprintf(buf, len, "%pI4, %s%u", &sin->sin_addr,
> +			 verbose ? "port=3D" : "", ntohs(sin->sin_port));

I would move the "," into the verbose part too.
so
   verbose ? ", port=3D" : " "

Other than that, I like this approach.

NeilBrown

>  		break;
> =20
>  	case AF_INET6:
> -		snprintf(buf, len, "%pI6, port=3D%u",
> -			 &sin6->sin6_addr,
> -			ntohs(sin6->sin6_port));
> +		snprintf(buf, len, "%pI6, %s%u", &sin6->sin6_addr,
> +			 verbose ? "port=3D" : "", ntohs(sin6->sin6_port));
>  		break;
> =20
>  	default:
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 62c7919ea610..16b794d291a4 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(svc_xprt_copy_addrs);
>   */
>  char *svc_print_addr(struct svc_rqst *rqstp, char *buf, size_t len)
>  {
> -	return __svc_print_addr(svc_addr(rqstp), buf, len);
> +	return __svc_print_addr(svc_addr(rqstp), buf, len, true);
>  }
>  EXPORT_SYMBOL_GPL(svc_print_addr);
> =20
> --=20
> 2.41.0
>=20
>=20

