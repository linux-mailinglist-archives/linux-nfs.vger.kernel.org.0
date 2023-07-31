Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A49769BEF
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 18:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjGaQLZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 12:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjGaQLY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 12:11:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27100197
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 09:11:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95001611F9
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 16:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76142C433C7;
        Mon, 31 Jul 2023 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690819882;
        bh=xmTlKBz8x2vU7luZnsk+NExJUT8/KLPO2Q4rjFr7Psg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=klRV4BWK641XQRwY3M+B8/zoKUBrlMPSHTbksl1Fw7aCVsjbYeSd72xYZYR3xIwJ/
         vt9So6uSqMPIWEKqkiqB5Vb427OqLnm+mVOTWuLHsrgjz+CdPeShYZGlRRpmygnZtV
         eZ7T0QDoXocRNh1EARzPX+MTFPo2/yZnaglAsimUjtJr8/unpdP7G9Vn6M+3OWp59a
         /Cbho11z1wvGyESISsFnRIPleQU5e3cH8ZS7Q1zDk+LfdmmuCcSqijtUrtxmh1o4c4
         +FGqwB8OACUeccfXBW8aAr64RY69u8SoR3P3jxKIXONCNOmqX0fUM501HsAl/fKHEf
         5McyLuChC/utQ==
Message-ID: <b519542134a605daa2d41742b1bfd0e8a1a2f436.camel@kernel.org>
Subject: Re: [PATCH v4 1/2] SUNRPC: add verbose parameter to
 __svc_print_addr()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com
Date:   Mon, 31 Jul 2023 12:11:20 -0400
In-Reply-To: <169058239308.32308.14184895022271604035@noble.neil.brown.name>
References: <cover.1690569488.git.lorenzo@kernel.org>
        , <5b0eff4e3ef9bf9621f5095189933f60def40f0d.1690569488.git.lorenzo@kernel.org>
         <169058239308.32308.14184895022271604035@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Sat, 2023-07-29 at 08:13 +1000, NeilBrown wrote:
> On Sat, 29 Jul 2023, Lorenzo Bianconi wrote:
> > Introduce verbose parameter to utility routine in order to reduce outpu=
t
> > verbosity. This is a preliminary patch to add rpc_status entry in nfsd
> > debug filesystem in order to dump pending RPC requests debugging
> > information.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  include/linux/sunrpc/svc_xprt.h | 12 ++++++------
> >  net/sunrpc/svc_xprt.c           |  2 +-
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc=
_xprt.h
> > index a6b12631db21..1715d4c6bd6b 100644
> > --- a/include/linux/sunrpc/svc_xprt.h
> > +++ b/include/linux/sunrpc/svc_xprt.h
> > @@ -209,21 +209,21 @@ static inline unsigned short svc_xprt_remote_port=
(const struct svc_xprt *xprt)
> >  }
> > =20
> >  static inline char *__svc_print_addr(const struct sockaddr *addr,
> > -				     char *buf, const size_t len)
> > +				     char *buf, const size_t len,
> > +				     bool verbose)
> >  {
> >  	const struct sockaddr_in *sin =3D (const struct sockaddr_in *)addr;
> >  	const struct sockaddr_in6 *sin6 =3D (const struct sockaddr_in6 *)addr=
;
> > =20
> >  	switch (addr->sa_family) {
> >  	case AF_INET:
> > -		snprintf(buf, len, "%pI4, port=3D%u", &sin->sin_addr,
> > -			ntohs(sin->sin_port));
> > +		snprintf(buf, len, "%pI4, %s%u", &sin->sin_addr,
> > +			 verbose ? "port=3D" : "", ntohs(sin->sin_port));
>=20
> I would move the "," into the verbose part too.
> so
>    verbose ? ", port=3D" : " "
>=20
> Other than that, I like this approach.
>=20

If we're separating fields in the main seqfile by ' ', then we probably
want to use a different delimiter here in the !verbose case. Maybe ':'
or ',' instead?

Also, ntohs is going to return a short, so the format should probably be
using "%hu" for the port.

>=20
> >  		break;
> > =20
> >  	case AF_INET6:
> > -		snprintf(buf, len, "%pI6, port=3D%u",
> > -			 &sin6->sin6_addr,
> > -			ntohs(sin6->sin6_port));
> > +		snprintf(buf, len, "%pI6, %s%u", &sin6->sin6_addr,
> > +			 verbose ? "port=3D" : "", ntohs(sin6->sin6_port));
> >  		break;
> > =20
> >  	default:
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 62c7919ea610..16b794d291a4 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(svc_xprt_copy_addrs);
> >   */
> >  char *svc_print_addr(struct svc_rqst *rqstp, char *buf, size_t len)
> >  {
> > -	return __svc_print_addr(svc_addr(rqstp), buf, len);
> > +	return __svc_print_addr(svc_addr(rqstp), buf, len, true);
> >  }
> >  EXPORT_SYMBOL_GPL(svc_print_addr);
> > =20
> > --=20
> > 2.41.0
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
