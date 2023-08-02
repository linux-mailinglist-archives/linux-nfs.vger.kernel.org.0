Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30276C8E2
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 11:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjHBJAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 05:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjHBJAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 05:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B619115
        for <linux-nfs@vger.kernel.org>; Wed,  2 Aug 2023 01:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690966760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BsRdhAPoDFOlmfZATYPnuHgcjefANO1gCw0OykxlqrE=;
        b=D3zye+1oYz+o4pGJCWiEEae+xTmEBgJDwriypLJhbE8iG2e6CIXFx8yBa6NjBa+7b/a6Rm
        z7S7WqWDJw9Q/jPivmlxkm7/jR/lUzuKUfYN5kg/sFFk+YQf+P3C0s6UpvXRaM6Q/6f0zW
        OCnhHdT1BMr2BaTPpP80r4nsjyWvcNU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-x5-7bkRiM1-P2LrnXGMJew-1; Wed, 02 Aug 2023 04:59:18 -0400
X-MC-Unique: x5-7bkRiM1-P2LrnXGMJew-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63cf6da7d40so64563546d6.2
        for <linux-nfs@vger.kernel.org>; Wed, 02 Aug 2023 01:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690966758; x=1691571558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsRdhAPoDFOlmfZATYPnuHgcjefANO1gCw0OykxlqrE=;
        b=VpIXhCUQPYA9GUjNCcfLEPqh5ebgdXUxOBgWM7cBBB6gkX/odVi1fMjvrBYQpHaiqI
         HJWfvzGMrMZTN5NTDQffUuIho8tT4Gx1lPwtd5VkA+7DzasH1NHfSP+5m/T1yYd0L422
         cPgf0FCIeqaoRGTKguyKlA/O7Mm4AZHiYXaAz+WcmV+SqU/r2uVBEVTOlOXJcEd4sP6c
         l71ZaG0VoM38cLWdfZc+5gIm77ETBz+1d+r1xt5UBI3ZCpsuOcSex+aMlojpCi91267p
         tW7H2khZnEQ+BEbjCnt1G/ql7ADtBKCsjsKU9KMqsqPPff8ED1Lpou7yIDV51FWR5jor
         58sw==
X-Gm-Message-State: ABy/qLZJw7WudPtBsCg+Lz7wV0zNN3Yz5tzkZw/Wzw+Rnyte2gyaPVOb
        xYQHYS4RTTKZAtbWdg0GmKLudXR8tRe43qw+3O3j0WHgMKRr97oRJm7CEeVUFF2QHER8W/BK2vi
        jaTmQBp5D+TbIE7RSjzmD
X-Received: by 2002:a0c:fd86:0:b0:62d:fe06:3e17 with SMTP id p6-20020a0cfd86000000b0062dfe063e17mr14505773qvr.22.1690966758213;
        Wed, 02 Aug 2023 01:59:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGh3NbyN5V3HHrUPDqcm1qjigiAIXTl6mRvUSZhtVWKt7QaObXv2SU35ef+flWgAmOrDwlpFw==
X-Received: by 2002:a0c:fd86:0:b0:62d:fe06:3e17 with SMTP id p6-20020a0cfd86000000b0062dfe063e17mr14505765qvr.22.1690966757961;
        Wed, 02 Aug 2023 01:59:17 -0700 (PDT)
Received: from localhost (mob-176-247-92-44.net.vodafone.it. [176.247.92.44])
        by smtp.gmail.com with ESMTPSA id g5-20020a0cdf05000000b0063d316af55csm5310271qvl.3.2023.08.02.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:59:17 -0700 (PDT)
Date:   Wed, 2 Aug 2023 10:58:58 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: Re: [PATCH v4 2/2] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZMoa0kQdTACKVj4P@lore-rh-laptop>
References: <cover.1690569488.git.lorenzo@kernel.org>
 <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>
 <169058300693.32308.16341899855806134699@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BzK2WmqwUxEnPIGD"
Content-Disposition: inline
In-Reply-To: <169058300693.32308.16341899855806134699@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--BzK2WmqwUxEnPIGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 29 Jul 2023, Lorenzo Bianconi wrote:
> > Introduce rpc_status entry in nfsd debug filesystem in order to dump
> > pending RPC requests debugging information.
> >=20

Hi Neil,

thx for the review.

> > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c         |   4 +-
> >  fs/nfsd/nfsctl.c           |  10 +++
> >  fs/nfsd/nfsd.h             |   2 +
> >  fs/nfsd/nfssvc.c           | 122 +++++++++++++++++++++++++++++++++++++
> >  include/linux/sunrpc/svc.h |   1 +
> >  net/sunrpc/svc.c           |   2 +-
> >  6 files changed, 137 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index f0f318e78630..b7ad3081bc36 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2497,8 +2497,6 @@ static inline void nfsd4_increment_op_stats(u32 o=
pnum)
> > =20
> >  static const struct nfsd4_operation nfsd4_ops[];
> > =20
> > -static const char *nfsd4_op_name(unsigned opnum);
> > -
> >  /*
> >   * Enforce NFSv4.1 COMPOUND ordering rules:
> >   *
> > @@ -3628,7 +3626,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
> >  	}
> >  }
> > =20
> > -static const char *nfsd4_op_name(unsigned opnum)
> > +const char *nfsd4_op_name(unsigned opnum)
> >  {
> >  	if (opnum < ARRAY_SIZE(nfsd4_ops))
> >  		return nfsd4_ops[opnum].op_name;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 35d2e2cde1eb..f2e4f4b1e4d1 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -57,6 +57,8 @@ enum {
> >  	NFSD_RecoveryDir,
> >  	NFSD_V4EndGrace,
> >  #endif
> > +	NFSD_Rpc_Status,
>=20
> I think NFSD_Rpc_Status needs to come before the CONFIG_NFSD_V4 block.
> Otherwise the comment above (which I apparently approved) makes even
> less sense than it does now.
> (Maybe just remove the comment??)

ack, right. I will fix it.

>=20
> > +
> >  	NFSD_MaxReserved
> >  };
> > =20
> > @@ -195,6 +197,13 @@ static inline struct net *netns(struct file *file)
> >  	return file_inode(file)->i_sb->s_fs_info;
> >  }
> > =20

[...]

> > +#endif /* CONFIG_NFSD_V4 */
> > +
> > +			/* In order to detect if the RPC request is pending and
> > +			 * RPC info are stable we check if rq_status_counter
> > +			 * has been incremented during the handler processing.
> > +			 */
> > +			if (status_counter !=3D atomic_read(&rqstp->rq_status_counter))
> > +				continue;
> > +
> > +			seq_printf(m,
> > +				   "0x%08x, 0x%08lx, 0x%08x, NFSv%d, %s, %016lld,",
>=20
> Please drop the commas.
> It might be defensible to have commas and no spaces by comparing with
> /proc/fs/nfsd/supported_krb5_enctypes, but the dominant pattern is to
> use only spaces to separate fields on /proc files.

ack, I will fix it.

Regards,
Lorenzo

>=20
> Thanks,
> NeilBrown
>=20

--BzK2WmqwUxEnPIGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZMoazQAKCRA6cBh0uS2t
rPPbAP9ZVS6gaPqlts9MpZMX8vn2TeZKpDufOP+PDhMFH/PlLQD+MIs6Axu3aFeD
y+PrvOVP4VhdEI/J8lXKlzeKVwcX3ww=
=gKoI
-----END PGP SIGNATURE-----

--BzK2WmqwUxEnPIGD--

