Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11A76A401
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 00:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjGaWPU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGaWPT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 18:15:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7E6B2
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 15:15:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9FC2D21FD4;
        Mon, 31 Jul 2023 22:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690841716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNS3V/2grMP0yG96HXAVD+rwC4dfDVur5DHPovpj+uw=;
        b=Rg8kbnhDi3ow5U58dDtQex//DPJUBsT3oBnUP0w1efkx6BTjHoJelYsO8egokGpOZrI8qk
        Wrq905Yr6LJQg2mkBMKt5ivwG8FzQAR8UqgHTTtBfRiI0riPihKzropenXzniB4z+713vR
        pD8Ss9YTAjWkpSngmh6MJYoKnc/U/Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690841716;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNS3V/2grMP0yG96HXAVD+rwC4dfDVur5DHPovpj+uw=;
        b=MFa4qAGAIrsZf0aCqhvj3ZOq378RAPSnHk9p7eUCDtbB27m9uPbgmuqWqZu08G8W6srg8Z
        lL3rGR3k0+jqytCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCD8A133F7;
        Mon, 31 Jul 2023 22:15:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JmenG3IyyGTaJAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 22:15:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, chuck.lever@oracle.com
Subject: Re: [PATCH v4 1/2] SUNRPC: add verbose parameter to __svc_print_addr()
In-reply-to: <b519542134a605daa2d41742b1bfd0e8a1a2f436.camel@kernel.org>
References: <cover.1690569488.git.lorenzo@kernel.org>,
 <5b0eff4e3ef9bf9621f5095189933f60def40f0d.1690569488.git.lorenzo@kernel.org>,
 <169058239308.32308.14184895022271604035@noble.neil.brown.name>,
 <b519542134a605daa2d41742b1bfd0e8a1a2f436.camel@kernel.org>
Date:   Tue, 01 Aug 2023 08:15:11 +1000
Message-id: <169084171153.32308.15857155053964820267@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 01 Aug 2023, Jeff Layton wrote:
> On Sat, 2023-07-29 at 08:13 +1000, NeilBrown wrote:
> > On Sat, 29 Jul 2023, Lorenzo Bianconi wrote:
> > > Introduce verbose parameter to utility routine in order to reduce output
> > > verbosity. This is a preliminary patch to add rpc_status entry in nfsd
> > > debug filesystem in order to dump pending RPC requests debugging
> > > information.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  include/linux/sunrpc/svc_xprt.h | 12 ++++++------
> > >  net/sunrpc/svc_xprt.c           |  2 +-
> > >  2 files changed, 7 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc=
_xprt.h
> > > index a6b12631db21..1715d4c6bd6b 100644
> > > --- a/include/linux/sunrpc/svc_xprt.h
> > > +++ b/include/linux/sunrpc/svc_xprt.h
> > > @@ -209,21 +209,21 @@ static inline unsigned short svc_xprt_remote_port=
(const struct svc_xprt *xprt)
> > >  }
> > > =20
> > >  static inline char *__svc_print_addr(const struct sockaddr *addr,
> > > -				     char *buf, const size_t len)
> > > +				     char *buf, const size_t len,
> > > +				     bool verbose)
> > >  {
> > >  	const struct sockaddr_in *sin =3D (const struct sockaddr_in *)addr;
> > >  	const struct sockaddr_in6 *sin6 =3D (const struct sockaddr_in6 *)addr;
> > > =20
> > >  	switch (addr->sa_family) {
> > >  	case AF_INET:
> > > -		snprintf(buf, len, "%pI4, port=3D%u", &sin->sin_addr,
> > > -			ntohs(sin->sin_port));
> > > +		snprintf(buf, len, "%pI4, %s%u", &sin->sin_addr,
> > > +			 verbose ? "port=3D" : "", ntohs(sin->sin_port));
> >=20
> > I would move the "," into the verbose part too.
> > so
> >    verbose ? ", port=3D" : " "
> >=20
> > Other than that, I like this approach.
> >=20
>=20
> If we're separating fields in the main seqfile by ' ', then we probably
> want to use a different delimiter here in the !verbose case. Maybe ':'
> or ',' instead?

Aren't the address and the port two different fields?
Colon is normal for separating host and port, but as IPv6 addresses
contain colons, you would need [IP::V6]:port which is probably isn't
really an improvement.
I would leave address and port as separate fields.

>=20
> Also, ntohs is going to return a short, so the format should probably be
> using "%hu" for the port.

Probably.

Thanks,
NeilBrown

>=20
> >=20
> > >  		break;
> > > =20
> > >  	case AF_INET6:
> > > -		snprintf(buf, len, "%pI6, port=3D%u",
> > > -			 &sin6->sin6_addr,
> > > -			ntohs(sin6->sin6_port));
> > > +		snprintf(buf, len, "%pI6, %s%u", &sin6->sin6_addr,
> > > +			 verbose ? "port=3D" : "", ntohs(sin6->sin6_port));
> > >  		break;
> > > =20
> > >  	default:
> > > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > > index 62c7919ea610..16b794d291a4 100644
> > > --- a/net/sunrpc/svc_xprt.c
> > > +++ b/net/sunrpc/svc_xprt.c
> > > @@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(svc_xprt_copy_addrs);
> > >   */
> > >  char *svc_print_addr(struct svc_rqst *rqstp, char *buf, size_t len)
> > >  {
> > > -	return __svc_print_addr(svc_addr(rqstp), buf, len);
> > > +	return __svc_print_addr(svc_addr(rqstp), buf, len, true);
> > >  }
> > >  EXPORT_SYMBOL_GPL(svc_print_addr);
> > > =20
> > > --=20
> > > 2.41.0
> > >=20
> > >=20
> >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

