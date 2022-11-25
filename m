Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA3638B5F
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 14:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKYNiN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 08:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYNiM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 08:38:12 -0500
X-Greylist: delayed 498 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 05:38:09 PST
Received: from odysseus.grml.info (odysseus.grml.info [136.243.234.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76B212A92
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 05:38:09 -0800 (PST)
Received: by odysseus.grml.info (Postfix, from userid 105)
        id B8AA3416F8; Fri, 25 Nov 2022 14:29:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
Received: from localhost (localhost.localdomain [127.0.0.1])
        by odysseus.grml.info (Postfix) with ESMTP id 52D0C40283;
        Fri, 25 Nov 2022 14:29:35 +0100 (CET)
Date:   Fri, 25 Nov 2022 14:29:35 +0100
From:   Michael Prokop <mika@debian.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org,
        Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>
Subject: Re: [PATCH 4/4] systemd: Apply all sysctl settings through udev rule
 when NFS-related modules are loaded
Message-ID: <2022-11-25T14-20-47@devnull.michael-prokop.at>
References: <20221125130725.1977606-1-carnil@debian.org>
 <20221125130725.1977606-5-carnil@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7NwO/uecqw5YxyZh"
Content-Disposition: inline
In-Reply-To: <20221125130725.1977606-5-carnil@debian.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--7NwO/uecqw5YxyZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

* Salvatore Bonaccorso [Fri Nov 25, 2022 at 02:07:25PM +0100]:

> sysctl settings (e.g.  /etc/sysctl.conf and others) are normally loaded
> once at boot.  If the module that implements some settings is no yet
> loaded, those settings don't get applied.
>=20
> Various NFS modules support various sysctl settings.  If they are loaded
> after boot, they miss out.
>=20
> Add a new udev rule configuration to udev/rules.d/60-nfs.rules to apply
> the relevant settings when the module is loaded.
>=20
> Placing it in the systemd directory similarly as the coice for the
> original commit afc7132dfb21 ("systemd: Apply all sysctl settings when
> NFS-related modules are loaded").
[...]

> --- /dev/null
> +++ b/systemd/60-nfs.rules
> @@ -0,0 +1,21 @@
> +# Ensure all NFS systctl settings get applied when modules load
> +
> +# sunrpc module supports "sunrpc.*" sysctls
> +ACTION=3D=3D"add", SUBSYSTEM=3D=3D"module", KERNEL=3D=3D"sunrpc", \
> +  RUN+=3D"/sbin/sysctl -q --pattern ^sunrpc --system"
[...]

Thanks for taking care of this problem, Salvatore!

AFAICT even latest busybox's sysctl does not support the `--pattern`
option yet:

| sysctl: unrecognized option '--pattern'
| BusyBox v1.35.0 (Debian 1:1.35.0-4) multi-call binary.
| [....]

So any initramfs that uses busybox and its sysctl (like in Debian)
and trying to apply above udev rules might fail?

regards
-mika-

--7NwO/uecqw5YxyZh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEM8yxNkAa/shDo4djlqh4crfqNzcFAmOAwzwACgkQlqh4crfq
NzcsBBAAndEOIhSMBIOEl+jjmL4XsloDjW3B5EjE6942goTBloxukF09rZi6DZeS
79pnlvVtOFQ48HGG4v87q1G0MXVU+8GezMQSDVVphJyHGJjdKCUKOlcXdkZAiU9F
kRXMicfJISSrEYovkho/vFMQRAbvv5a1kCcCkE6vIWRnVupu7wjVlZ3wvr0ckd5P
ThZhpkEsIMQys+VW/6RZwSBVaYDe/Ieu9NDDHf2PqXSY4U9oloK+CreIrLKn3dpF
QFybUOjq2x0wwF7AgwzbYqviXzw086+Lq4e93jdV8ispQ9FHF7I5VrDp2RYbbqSk
LjhTQaLrvxv85S/fwENEE3aHdWsvd6FBxjbcB+PtefbUty2ClRkHgQ22QZ3/CfXd
ozGLPPa97zIOztnQ53ck9+sK7N4V3L4AcIwFaiah0phT75sFcNnEgrDD2Wyjk/EX
WOEyVT09zyQ0CogUoCIRhYb3v5qly3ATVT2FEon1yFRs38BAKsQajrgVnXJMyfiJ
1/Xp5goTU7xVdtysSCHjrFNO0dcA5AK/WB3wdHmXJTf/xtjFpNHIhr1gz7oOpoi5
5uHRZ+J/xiNmNre5ALlENwd8t/IieKF/H8s1sfUUBWdSIlOgFqDgzLHOm13dMCAO
5cUiDpWpvS1t1ooSrE/1ghwCgGQ/NwDd1EJs5hOGgz8Q8N9guYM=
=4KJg
-----END PGP SIGNATURE-----

--7NwO/uecqw5YxyZh--
