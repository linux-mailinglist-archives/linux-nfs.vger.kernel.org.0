Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2FB7AE310
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Sep 2023 02:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjIZAtq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 20:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIZAtp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 20:49:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B5B3;
        Mon, 25 Sep 2023 17:49:39 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5789ffc8ae0so4947834a12.0;
        Mon, 25 Sep 2023 17:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695689379; x=1696294179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqABUg4Xa7t7luyvOxZ/d67MGJaTAXsL+8PXX+Bo8IQ=;
        b=gy2672S071+NORSj+4r1IW5CVJ/RIg8lpyoyjdwvAnl4BCtag03PQcgwAGkgdglfmo
         VKcIpk4efUpEHlgnFU8+qhOjaSYGmCMP/KuYY+EBkiZF9gg7jk66zT4EjZ8/Sb8/CurO
         Qbj3yPvD2uY6/40Uu7C3MHLB+jydHTNrCA86NEAaNAhauGPyrU2YxRbJqM6V/wFtJH2o
         t7otlZ/QBVNk3sTs2v68065tal/GzTMW9iqxD0gcV5sYdHOB9BITwntLt24monvZpQF0
         rrMt5iN/os9jJgwpJHHxwU+dbGsZBg33vqJv71kE9zT3gG2i+DgrJZCUWP5uweB345BN
         i7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695689379; x=1696294179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqABUg4Xa7t7luyvOxZ/d67MGJaTAXsL+8PXX+Bo8IQ=;
        b=e9wj2o4+x+P+Cd8r/+Y4YekX0IprgTfdoMuV2/RG+FIgEdwvnLCRc2vcSRlEYqGJvS
         jAjV2GDqQs48SkBFpx8C1NBwIMnI/z7t324Es62WklqnAS+uaHtBGRunWfhHIUKXCUho
         APzy2umg0NbK/oyjEs25SHrckI29elaQdr7DtDmUaxK7ZMYhagH8XMjSyqmKi7qaenOu
         FDSzxya31UksQbjkaYPkXcurCxVFq2mamgTp5qIb8w4/ZYdoGi2WULyWZa3bXdWBPN3S
         BgEh5Lh8TevPWukv4x7Z7rJRnCq4H5OBBEWPzhdBXgjpm1ZqnINinh0Ul7oyep3ZEPzq
         zJWA==
X-Gm-Message-State: AOJu0YwcugYPPW2IcANV/rmUIHuhcXer8Mb0Pr58UFdPfI45Lw+K3zky
        9cRqne1iyHFmI1dAtdY8tHG9pOFNWBbNXw==
X-Google-Smtp-Source: AGHT+IF2fdCU386NjzNRFdfoWXHJ5nCCt8hffaO7qUJ6NGt1OWpSqbq34clR6isrcu4YMrpDCIO54Q==
X-Received: by 2002:a05:6a20:9704:b0:15d:42d5:6cc1 with SMTP id hr4-20020a056a20970400b0015d42d56cc1mr5813780pzc.33.1695689378885;
        Mon, 25 Sep 2023 17:49:38 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001b54d064a4bsm9529216plg.259.2023.09.25.17.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 17:49:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C539380696DC; Tue, 26 Sep 2023 07:49:35 +0700 (WIB)
Date:   Tue, 26 Sep 2023 07:49:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, greg@greg.net.au
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Network File System <linux-nfs@vger.kernel.org>
Subject: Re: Fwd: kernel 6.4/6.5 nfs 4.1 unresponsive
Message-ID: <ZRIqn6zmc4jEimwj@debian.me>
References: <d9255749-bf1e-c498-ace6-048d36fa962f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UccGjiI+YGKADNfL"
Content-Disposition: inline
In-Reply-To: <d9255749-bf1e-c498-ace6-048d36fa962f@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--UccGjiI+YGKADNfL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 06:14:03PM +0700, Bagas Sanjaya wrote:
> #regzbot introduced: v6.3..v6.4 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217815
> #regzbot title: nfs server not responding loop on Synology NAS devices
>=20

The reporter replied on Bugzilla that this regression is caused by out-of-t=
ree
i40 driver, so:

#regzbot invalid: out-of-tree module regression

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--UccGjiI+YGKADNfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRIqnwAKCRD2uYlJVVFO
oxqWAQDU673SqON3sxt5Uzny90pqdeRMG9m6KOEk5JtlxLeU+gD9EHzplPl2ghuX
TPFJVnPZukADvFovkU/y3agd8Ahr4wA=
=BzE9
-----END PGP SIGNATURE-----

--UccGjiI+YGKADNfL--
