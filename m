Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297D476FB96
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjHDIDy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 04:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjHDIDx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 04:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFFE1702
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691136185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZN4MCb7eSdLYYeeRWzp17IRrKbjEv1XUmfo5ruYXhk=;
        b=BfW7SZbTCYi4MMxFVRfS+MzQHWXFZ6NitADrg/aQ5EkniTLiXt+p3DkLknsWmfJ7tHOzqc
        ughJVzhy12l6YI6+a8cX2nFKqSAYtpk6xnS5i51kgvSIcqpOwNywkcXnaiAz4JQN1Sn3X0
        Kj/MYvYH0q/kWn8ngKL13Nl/RbRa2/s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-ILeNXK8hO4-530bVl486JA-1; Fri, 04 Aug 2023 04:03:03 -0400
X-MC-Unique: ILeNXK8hO4-530bVl486JA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63cf52407d7so20640746d6.0
        for <linux-nfs@vger.kernel.org>; Fri, 04 Aug 2023 01:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691136183; x=1691740983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZN4MCb7eSdLYYeeRWzp17IRrKbjEv1XUmfo5ruYXhk=;
        b=ljhPUG+U+27MfkKCWSOg09IlvHS84qkINzXV+1DACWtCZ29v089iDW8QASvcTtxC7P
         isrfn0UVnZJvAVi5Bsj/oXuPBBSX5S5YOMtuUBulQOpRaIDjiiRIz17s2CpC9Jf71Dlb
         gOqb842U30lh25dVRUJ1bCDTUv//fhog74bDwpTwiHOz/OjVv5GQSv6xglp21PfWjpiH
         Y9WcY6N9yc8eBTSGucmW4Og59B084UtNyuK6nusarJN08+M3GqmKhh0AvpdjqASleolJ
         p6sT8cWmKPjmEG4bWV9A5MRZ2ZcP2r1DEExPs7Mj9XeVW97dOFfX/1xda0eOFhr8B97e
         4/8Q==
X-Gm-Message-State: AOJu0YwBr+OtHmjPtN36GGBspHdYH5tHjbgmdkZe5soqkXFWKhBuKRbU
        M7az6eq3N04h1IquOFI+tnffXCsNB3C6zN4KWA1l7S6YyuVn2xYa594l6ThaU1TpVul/Av8LKvy
        hm+7ebu4XLexE8Wv7L+Zg
X-Received: by 2002:ad4:5808:0:b0:62f:f6ed:857e with SMTP id dd8-20020ad45808000000b0062ff6ed857emr976329qvb.55.1691136183138;
        Fri, 04 Aug 2023 01:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECUBTQYEE6Jusx6hRgCscLJikjqMLk421QEt/sW65KJKtfHBr0LU2/4t3gGSRYa6C48yY8zw==
X-Received: by 2002:ad4:5808:0:b0:62f:f6ed:857e with SMTP id dd8-20020ad45808000000b0062ff6ed857emr976317qvb.55.1691136182868;
        Fri, 04 Aug 2023 01:03:02 -0700 (PDT)
Received: from localhost (mob-176-247-93-114.net.vodafone.it. [176.247.93.114])
        by smtp.gmail.com with ESMTPSA id a2-20020a0ca982000000b0063d7740b5d2sm503895qvb.46.2023.08.04.01.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:03:02 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:02:57 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-nfs@vger.kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v4 2/2] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZMywsSb9Qz7K3V/f@lore-rh-laptop>
References: <cover.1690569488.git.lorenzo@kernel.org>
 <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>
 <ZMQVX5RlQaWt5wkn@tissot.1015granger.net>
 <169058229140.32308.9984914710358617790@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yZioOiVPm9KFfq5z"
Content-Disposition: inline
In-Reply-To: <169058229140.32308.9984914710358617790@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--yZioOiVPm9KFfq5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 29 Jul 2023, Chuck Lever wrote:
> > On Fri, Jul 28, 2023 at 08:44:04PM +0200, Lorenzo Bianconi wrote:

[...]

> >=20
> > Neil said:
> >=20
> > > I suggest you add add a counter to the rqstp which is incremented from
> > > even to odd after parsing a request - including he v4 parsing needed =
to
> > > have a sable ->opcnt - and then incremented from odd to even when the
> > > request is complete.
> > > Then this code samples the counter, skips the rqst if the counter is
> > > even, and resamples the counter after collecting the data.  If it has
> > > changed, the drop the record.
> >=20
> > I don't see a check if the status counter is even.
>=20
> ...and there does need to be one.  If the counter is even, then the
> fields are meaningless and unstable.  The RQ_BUSY check is, I think,
> meant to check if the fields are meaningful, but they aren't meaningful
> until some time after RQ_BUSY is clear.
>=20
> I would replace the "RQ_BUSY not set" test with "counter is even"

ack, I will fix it.

>=20
> >=20
> > Also, as above, I'm not sure atomic_read() is necessary here. Maybe
> > just READ_ONCE() ? Neil, any thoughts?
>=20
> Agree - we don't need an atomic as there is a single writer.
> I think
>   smp_store_release(rqstp->counter, rqstp->counter|1)
> to increment it after parsing the request.  This makes it abundantly
> clear the value will be odd, and ensures that if another thread sees the
> 'odd' value, then it can also see the results of the parse.
>=20
> To increment after processing the request,
>    smp_store_release(rqstp->counter, rqstp->counter + 1)
>=20
> Then
>   counter =3D smp_load_acquire(rqstp->counter);
>   if ((counter & 1) =3D=3D 0)
> to test if it is even before reading the state.  This ensure that if it
> sees "odd' it will see the results of the parse.
>=20
> and
>   if ((smp_load_acquire(counter) =3D=3D counter)  continue;
>=20
> before trusting that the data we read was consistent.
>=20
> Note that we "release" *after* something and "acquire" *before"
> something.
> I think it helps to always think about what the access is "before" or
> "after" when reasoning about barriers.
> checkpatch will want a comment before these acquire and release
> operation.  I recommend using the corresponding word "before" or "after"
> in that comment.


ack, I will add it.

Regards,
Lorenzo

>=20
> NeilBrown
>=20

--yZioOiVPm9KFfq5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZMywrgAKCRA6cBh0uS2t
rB8rAP9/cJT1egOk95+jOJMdkrjNwhCXPsCeSbPUhknQ6k2pXgEA8DQtcGppIOCV
WFTwlCEsvM8vaMIQct7WTsKLcA8yYw8=
=U5uw
-----END PGP SIGNATURE-----

--yZioOiVPm9KFfq5z--

