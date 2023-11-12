Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6F7E8F6B
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Nov 2023 11:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjKLKC4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Nov 2023 05:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKLKC4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Nov 2023 05:02:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E942D57
        for <linux-nfs@vger.kernel.org>; Sun, 12 Nov 2023 02:02:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEBEC433C8;
        Sun, 12 Nov 2023 10:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699783372;
        bh=rUoOBAjueXlqWwGHysic5LlTJg1pxMZI4wgDQs9dqQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4+MTj4pS6OH0uPX0/K30/qMUcqWv4wZB1KneUjoFM3Y8oGjc+bznbB55g6ZqHLYC
         EqVSkxBTNpoEUn+G7obe9xY/m0fmYYr8nRijrxtqBSMUYuGf/66i0ea1JPea3QqMyJ
         nFlTsblpETMZv6eW5nupgq+0wHByq6aqoUjxxUJqjEoo7Uv5Llqyys9W1xmylg9eV/
         YNlUN1HdBIN97ogyXYELaBz3LveWR6QNc0MvFOoLKrj5ojA2eH9SFaE8xJQhQvJ90u
         AC9hKw4a/r0H7MnfLINUDiAzmu2aF7TxCqidgV0sbE8O19sqb8zTAcOyU7aSgxwzn2
         oUkKF+z6pNl1w==
Date:   Sun, 12 Nov 2023 11:02:48 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        neilb@suse.de, chuck.lever@oracle.com, netdev@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v4 0/3] convert write_threads, write_version and
 write_ports to netlink commands
Message-ID: <ZVCiyNQtkumDheU4@lore-desk>
References: <cover.1699095665.git.lorenzo@kernel.org>
 <7fdd6dd0d8ab75181eb350f78a4822a039cacaa5.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3348koQSGuKi5nQ"
Content-Disposition: inline
In-Reply-To: <7fdd6dd0d8ab75181eb350f78a4822a039cacaa5.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--O3348koQSGuKi5nQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 2023-11-04 at 12:13 +0100, Lorenzo Bianconi wrote:
> > Introduce write_threads, write_version and write_ports netlink
> > commands similar to the ones available through the procfs.
> >=20
> > Changes since v3:
> > - drop write_maxconn and write_maxblksize for the moment
> > - add write_version and write_ports commands
> > Changes since v2:
> > - use u32 to store nthreads in nfsd_nl_threads_set_doit
> > - rename server-attr in control-plane in nfsd.yaml specs
> > Changes since v1:
> > - remove write_v4_end_grace command
> > - add write_maxblksize and write_maxconn netlink commands
> >=20
> > This patch can be tested with user-space tool reported below:
> > https://github.com/LorenzoBianconi/nfsd-netlink.git
> > This series is based on the commit below available in net-next tree
> >=20
> > commit e0fadcffdd172d3a762cb3d0e2e185b8198532d9
> > Author: Jakub Kicinski <kuba@kernel.org>
> > Date:   Fri Oct 6 06:50:32 2023 -0700
> >=20
> >     tools: ynl-gen: handle do ops with no input attrs
> >=20
> >     The code supports dumps with no input attributes currently
> >     thru a combination of special-casing and luck.
> >     Clean up the handling of ops with no inputs. Create empty
> >     Structs, and skip printing of empty types.
> >     This makes dos with no inputs work.
> >=20
> > Lorenzo Bianconi (3):
> >   NFSD: convert write_threads to netlink commands
> >   NFSD: convert write_version to netlink commands
> >   NFSD: convert write_ports to netlink commands
> >=20
> >  Documentation/netlink/specs/nfsd.yaml |  83 ++++++++
> >  fs/nfsd/netlink.c                     |  54 ++++++
> >  fs/nfsd/netlink.h                     |   8 +
> >  fs/nfsd/nfsctl.c                      | 267 +++++++++++++++++++++++++-
> >  include/uapi/linux/nfsd_netlink.h     |  30 +++
> >  tools/net/ynl/generated/nfsd-user.c   | 254 ++++++++++++++++++++++++
> >  tools/net/ynl/generated/nfsd-user.h   | 156 +++++++++++++++
> >  7 files changed, 845 insertions(+), 7 deletions(-)
> >=20
>=20
> Nice work, Lorenzo! Now comes the bikeshedding...

Hi Jeff,

>=20
> With the nfsdfs interface, we sort of had to split things up into
> multiple files like this, but it has some drawbacks, in particular with
> weird behavior when people do things out of order.

what do you mean with 'weird behavior'? Something not expected?

>=20
> Would it make more sense to instead have a single netlink command that
> sets up ports and versions, and then spawns the requisite amount of
> threads, all in one fell swoop?

I do not have a strong opinion about it but I would say having a dedicated
set/get for each paramater allow us to have more granularity (e.g. if you w=
ant
to change just a parameter we do not need to send all of them to the kernel=
).
What do you think?

>=20
> That does presuppose we can send down a variable-length frame though,
> but I assume that is possible with netlink.

sure, we can do it.

Regards,
Lorenzo

> --=20
> Jeff Layton <jlayton@kernel.org>

--O3348koQSGuKi5nQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVCiyAAKCRA6cBh0uS2t
rCw6AP4yRnIjTe20tqbyK1mIQW5bBBVwB6998gEvWHYq2QQTjgEA0uG1yKHW6SnT
CSl+2TYnPRirP/q0n46N9DzH9IimugU=
=r1if
-----END PGP SIGNATURE-----

--O3348koQSGuKi5nQ--
