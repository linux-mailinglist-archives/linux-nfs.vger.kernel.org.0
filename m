Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69A52785CE
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIYL2T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 07:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgIYL2S (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 25 Sep 2020 07:28:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EADE20717;
        Fri, 25 Sep 2020 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601033298;
        bh=0qBWR99wLEdw3Mdk8ebyUqm3qW4QtbL6m4S65p6z35M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jc3SKVW+FxNdmlp5Xxhb3DtrfvOgoiSfyY/pDUuYmedimLssoUNMDjP80yVqzX/pr
         +s5kRKeekM98Xj+it3g8OerfS8kRF7h6Fl1d4mXkJKGgPZnO1Kp5lP7JEJdp5b+4d8
         oIG6w+xbnn1gdPGOmLrkd95NDbFhLgvMYnHDYL7U=
Date:   Fri, 25 Sep 2020 12:27:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] nfs: remove incorrect fallthrough label
Message-ID: <20200925112722.GA4841@sirena.org.uk>
References: <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
 <20200917214545.199463-1-ndesaulniers@google.com>
 <CAKwvOdnziDJbRAP77K+V885SCuORfV4SmHDnSLUxhUGSSLMq_Q@mail.gmail.com>
 <ca629208707903da56823dd57540d677df2da283.camel@perches.com>
 <734165bbee434a920f074940624bcef01fcd9d60.camel@perches.com>
 <CAFX2Jf=JjVOjDKj_rpst35a+fqbiq4OpVFjztaeKcbTSNapnCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <CAFX2Jf=JjVOjDKj_rpst35a+fqbiq4OpVFjztaeKcbTSNapnCg@mail.gmail.com>
X-Cookie: Onward through the fog.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2020 at 02:11:59PM -0400, Anna Schumaker wrote:
> On Thu, Sep 24, 2020 at 2:08 PM Joe Perches <joe@perches.com> wrote:

> > Real reason why not:

> I'm planning to take this patch through the NFS tree for 5.10 (along
> with the patch that apparently causes the problem). I didn't think it
> was urgent so I haven't gotten around to pushing it out yet, but I'll
> do so in the next few hours.

FWIW NFS is quite widely used by CI systems so any build breaks with it
in -next have a pretty big knock on effect on testing, even beyond the
distruption people working on the build test side of things.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9t1BoACgkQJNaLcl1U
h9AQfgf/QGhP/HeYW+S1uZwXjRE61tdtxw8+QQillMq6Sd9RuOXGNcbRKgJfQ7H2
8Zt6U8pwlrPUGWpbrHzKM2dZ9qarLmCpqxdGWParPmJF6D1Hy8zo0R7tojGFQxA8
kGQCzBlw0nYHitjwAEISJABPMJRugrKOXSFOZJ4jYN/XwJ1Hip+q4l6K8eVz24af
QxpcMNdbpSYYBeMaPKI7JeHl6fAdTP9hdG9oMEf1yNJ7P8nfx35KZ3UilPMkUzMI
yZrx4vNyWE0xXRE+xn4DKgwbTrXQZnAxbZvG8RE+ntoQa1I+52MKzfZ04FaqYnXz
jsmdG833nCS8zVmHwt7nxNr8aqL2qQ==
=CEEL
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
