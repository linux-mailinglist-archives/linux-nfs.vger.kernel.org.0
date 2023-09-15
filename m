Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197827A2962
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 23:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjIOVar (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjIOVa1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 17:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907CD3
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 14:30:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADBBC433C7;
        Fri, 15 Sep 2023 21:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694813422;
        bh=IE5p4JSNZrnyQ5NkdKwOkBCLR+K9s6w7E8lMOvmGkbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1NeY9/8VUQSHYDjJBNn8tCXWgerij/LLyG3APed862kRhI4C1xLMJlh+UTkqaBvR
         0SRSr94DRfSHke09mcE1ttBDzbNPkzSUfCAJe5/jTOmOxufcshb9yb/MUViDU5ETxH
         db0NzEoNEH+iiirOXn4jo1A5IEJo32yG8vR4te9pyA3Zdb05HqpZOWqjkwgEBDN5wj
         LwI5uAuPqHUrL4sLxBCnj9rYhEOwR5vUf//bYOrqYsVhe0xow3oJG22m93M3O9C8zw
         zcaNep4e6VQYUXj791AFheQP4F/sHR8ojwkoXCC9b+fpV2k16eY3W3LBsEEjGzieCh
         FCVcjyLDCgR1Q==
Date:   Fri, 15 Sep 2023 23:30:18 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: Re: [PATCH v8 0/3] add rpc_status netlink support for NFSD
Message-ID: <ZQTM6l7NrsVHFoR5@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ZQSvV/eZOohnQulw@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j3NQQk77BtSnZXGh"
Content-Disposition: inline
In-Reply-To: <ZQSvV/eZOohnQulw@tissot.1015granger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--j3NQQk77BtSnZXGh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> >  Documentation/netlink/specs/nfsd_server.yaml |  97 +++++++++
> >  fs/nfsd/Makefile                             |   3 +-
> >  fs/nfsd/nfs_netlink_gen.c                    |  32 +++
> >  fs/nfsd/nfs_netlink_gen.h                    |  22 ++
> >  fs/nfsd/nfsctl.c                             | 204 +++++++++++++++++++
> >  fs/nfsd/nfsd.h                               |  16 ++
> >  fs/nfsd/nfssvc.c                             |  15 ++
> >  fs/nfsd/state.h                              |   2 -
> >  include/linux/sunrpc/svc.h                   |   1 +
> >  include/uapi/linux/nfsd_server.h             |  49 +++++
> >  10 files changed, 438 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/netlink/specs/nfsd_server.yaml
> >  create mode 100644 fs/nfsd/nfs_netlink_gen.c
> >  create mode 100644 fs/nfsd/nfs_netlink_gen.h
> >  create mode 100644 include/uapi/linux/nfsd_server.h
>=20
> Hi Lorenzo -
>=20
> I've applied these three to nfsd-next with the following changes:
>=20
> - Renaming as we discussed
> - Replaced the nested compound_op attribute -- may require some user
>   space tooling changes
> - Simon's Smatch bug fixed
> - Squashed 1/3 and 2/3 into one patch
> - Added Closes/Acked-by etc

Hi Chuck,

Thanks for addressing the points above.

>=20
> If you spot a bug, send patches against nfsd-next and I can squash
> them in.

ack, I will do

>=20
> I was wondering if you have a little more time to try adding one or
> two control cmds. write_threads and v4_end_grace might be simple
> ones to start with. No problem if you are "done" with this project,
> I can add these over time.

sure, no worries. I will look into them soon :)

Regards,
Lorenzo

>=20
> --=20
> Chuck Lever

--j3NQQk77BtSnZXGh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQTM6gAKCRA6cBh0uS2t
rOHrAQCVFojQGWe8/TmloGIv2WM6LrjFK5Ah0jd13B7EX4mYkgEA66jlWMccoFRN
O1vvSPGzoln8cUd0NrEQ5f0l5xZe2g0=
=kiJ0
-----END PGP SIGNATURE-----

--j3NQQk77BtSnZXGh--
