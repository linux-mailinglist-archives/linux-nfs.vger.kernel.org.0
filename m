Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B22638E3C
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Nov 2022 17:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKYQ2Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Nov 2022 11:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYQ2P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Nov 2022 11:28:15 -0500
Received: from odysseus.grml.info (odysseus.grml.info [136.243.234.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA66B193DF
        for <linux-nfs@vger.kernel.org>; Fri, 25 Nov 2022 08:28:13 -0800 (PST)
Received: by odysseus.grml.info (Postfix, from userid 105)
        id BC76140283; Fri, 25 Nov 2022 17:28:11 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
Received: from localhost (localhost.localdomain [127.0.0.1])
        by odysseus.grml.info (Postfix) with ESMTP id 9623940283;
        Fri, 25 Nov 2022 17:27:57 +0100 (CET)
Date:   Fri, 25 Nov 2022 17:27:57 +0100
From:   Michael Prokop <mika@debian.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>,
        linux-nfs@vger.kernel.org,
        Andras Korn <korn-debbugs@elan.rulez.org>,
        Marco d'Itri <md@linux.it>
Subject: Re: [PATCH 4/4] systemd: Apply all sysctl settings through udev rule
 when NFS-related modules are loaded
Message-ID: <2022-11-25T17-23-34@devnull.michael-prokop.at>
References: <20221125130725.1977606-1-carnil@debian.org>
 <20221125130725.1977606-5-carnil@debian.org>
 <2022-11-25T14-20-47@devnull.michael-prokop.at>
 <Y4DrlX+oZyjYtrS8@eldamar.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="StY/WRLeopVAnrKQ"
Content-Disposition: inline
In-Reply-To: <Y4DrlX+oZyjYtrS8@eldamar.lan>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--StY/WRLeopVAnrKQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

* Salvatore Bonaccorso [Fri Nov 25, 2022 at 05:21:41PM +0100]:
> On Fri, Nov 25, 2022 at 02:29:35PM +0100, Michael Prokop wrote:
> > * Salvatore Bonaccorso [Fri Nov 25, 2022 at 02:07:25PM +0100]:

> > > --- /dev/null
> > > +++ b/systemd/60-nfs.rules
> > > @@ -0,0 +1,21 @@
> > > +# Ensure all NFS systctl settings get applied when modules load
> > > +
> > > +# sunrpc module supports "sunrpc.*" sysctls
> > > +ACTION=3D=3D"add", SUBSYSTEM=3D=3D"module", KERNEL=3D=3D"sunrpc", \
> > > +  RUN+=3D"/sbin/sysctl -q --pattern ^sunrpc --system"
> > [...]
> >=20
> > Thanks for taking care of this problem, Salvatore!
>=20
> Thanks to you for prodding about it, hope to bring the issue bit
> forward with the series proposal.

ACK, thanks, I highly appreciate your efforts!

> > AFAICT even latest busybox's sysctl does not support the `--pattern`
> > option yet:
> >=20
> > | sysctl: unrecognized option '--pattern'
> > | BusyBox v1.35.0 (Debian 1:1.35.0-4) multi-call binary.
> > | [....]
> >=20
> > So any initramfs that uses busybox and its sysctl (like in Debian)
> > and trying to apply above udev rules might fail?
>=20
> But would this actually be a problem for us here? There is no hook
> script which would copy the 60-nfs.rules (not relevant in initrd) to
> the initrd. The rule only would apply on module load outside the
> initrd.

Indeed, I also think that as long as this udev rule doesn't end up
in the initrd there shouldn't be any problem with it.

> There is only a subset of rules which would be copied into initrd,
> like the ones in hook/udev. But 60-nfs.rules would be specific to
> nfs-utils, which does not provide a initramfs-tools hook to include
> the rules into initrd.

Good point, thanks for checking and clarifying.

> Now the question you raise, is, do they need to be handled actually
> already as well in initrd? You are correct, when handled through the
> previous mechanism with modrobe.d configuration, 50-nfs.conf was added
> to initramfs:
>=20
> usr/lib/modprobe.d/50-nfs.conf=20
>=20
> (and causing the issues seen).
>=20
> Please correct me if I missed something from the picture.

No, I think you're right and AFAICS we shouldn't see the issues we
originally noticed any longer. Thanks! :)

regards
-mika-

--StY/WRLeopVAnrKQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEM8yxNkAa/shDo4djlqh4crfqNzcFAmOA7QsACgkQlqh4crfq
Nzdt5A/+LQU9++lFSYw1BXUibfmBxW2d3ylhNBDJa9dVJ8tQo+svJ6HQAWES4efF
lEahq1fa0dtsEfHRnRJMVAnwM3CQ0oWUsK5s7SRyMF4iUTcWCwk3F0am7sKx6yzf
71NqNGzdbSCr0MLCdRSklRqd6slAqwUXet9ZutT81hDv0grg/KuQgjs0k9EA57Ju
dXlIyBZ3r7LrG3RYqRk5aaAcztrEpxs9OFy65QK/ggjR3qcgor8lb2M7hmmrdNxx
1vpJaU4NpEcq8s/BoP45aPl1sJmfxTYG0xYNW1zl45fq/pcdlTQMVzetDfR9wY3N
4zn2/yEJKqUyrEtPjGiqtslq+kMhpHcUTuA2JSQo0JKRXq+c2bvFqzsitGiB6bHm
fAYp9HabihRF3Z7bdsxzVYE9WmXBaeBZKnyQz3BgsH8KlotCGXRtfnJ6SJ05EQHo
drOq348hvSLI57Z+WKgOqp+DlSVdvhNtRLhgiUsPhOkcAdAesFa4gq6vrecxBaQr
yvV0PTz/JAtJPfUmVY0YBriSq9yNW2guDVTfDkK4a/nNGmj3fEYJDQNXmPMUQhPl
uaNsmmVv5g3fxjdM0r6ubGke89TafRso9Ca9omwGVy65GOFY+p+cUiztblHQw4KN
RkwfImGb3YWP4FjyOKxaXKx6apPYJv1AdZPnk3jGIddmyf6eKCg=
=N8l5
-----END PGP SIGNATURE-----

--StY/WRLeopVAnrKQ--
