Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB274DAE6
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 18:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGJQTp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGJQTo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 12:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D8B106
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 09:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C101610A2
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 16:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418F3C433C7;
        Mon, 10 Jul 2023 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689005982;
        bh=en7QKplx5pilJyCKBzL8WRSMhtpkM1Rm+EM7uGdVrME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6eXKJJXO5ry+Qmpta3CAr6xlBpbyKh9E81VSMdir92JSQqHp9pXCopjaPjiWYAsp
         GLkPib/No7goRpI36FqVvJ1Yf8iY7NmpZAWNWDBI/JA70T2Dj0tkD8i/GmM1l2lnBk
         ddRK4nwgMlqczIt2+6r5o9cnQrX0V+n8UcDD4q9uUKfIPQ0JzMUknbDCOJ+WP9a800
         zTC/BKE5wwxAZnJqJKpeU8V0TF0V1K/oOM9/hpaMD4ROmX7IpLU8nJkpUiVBiwuUh4
         eAOY0bXdukjWw/FgSXpmNHwtwGCovSC6Q1on/2KxNRuB5L5bTVyDgJmUdG6WdJcsgo
         Fmt5Hux6h96hw==
Date:   Mon, 10 Jul 2023 18:19:39 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [RFC] NFSD: add rpc_status entry in nfsd debug filesystem
Message-ID: <ZKwvmyff/aqwsTBk@lore-desk>
References: <bac972c22c5acfa43969bb1bf164341b16ea045c.1688032742.git.lorenzo@kernel.org>
 <ZJ2NUPdX0KqvaUlr@manet.1015granger.net>
 <ZKwkulG5mZFRnFFD@lore-desk>
 <E916B0DD-7470-4F2C-A7F8-13DB070CC593@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0JFP51DTI3ifb8uE"
Content-Disposition: inline
In-Reply-To: <E916B0DD-7470-4F2C-A7F8-13DB070CC593@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--0JFP51DTI3ifb8uE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 10, Chuck Lever III wrote:
>=20
>=20
> > On Jul 10, 2023, at 11:33 AM, Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >=20
> >>> + for (i =3D 0; i < serv->sv_nrpools; i++) {
> >>> + struct svc_rqst *rqstp;
> >>> +
> >>> + seq_puts(m, "XID        | FLAGS      | PROG       |");
> >>> + seq_puts(m, " VERS       | PROC\t|");
> >>> + seq_puts(m, " REMOTE - LOCAL IP ADDR");
> >>> + seq_puts(m, "\t\t\t\t\t\t\t\t   | NFS4 COMPOUND OPS\n");
> >>> + list_for_each_entry_rcu(rqstp,
> >>> + &serv->sv_pools[i].sp_all_threads,
> >>> + rq_all) {
> >>> + if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> >>> + continue;
> >>> +
> >>> + seq_printf(m,
> >>> +    "0x%08x | 0x%08lx | 0x%08x | NFSv%d      | %s\t|",
> >>> +    be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
> >>> +    rqstp->rq_prog, rqstp->rq_vers,
> >>> +    svc_proc_name(rqstp));
> >>> +
> >>> + if (rqstp->rq_addr.ss_family =3D=3D AF_INET) {
> >>> + seq_printf(m, " %pI4 - %pI4\t\t\t\t\t\t\t   |",
> >>> +    &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
> >>> +    &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
> >>> + } else if (rqstp->rq_addr.ss_family =3D=3D AF_INET6) {
> >>> + seq_printf(m, " %pI6 - %pI6 |",
> >>> +    &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
> >>> +    &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
> >>> + } else {
> >>> + seq_printf(m, " Unknown address family: %hu\n",
> >>> +    rqstp->rq_addr.ss_family);
> >>> + continue;
> >>> + }
> >>> +#ifdef CONFIG_NFSD_V4
> >>> + if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> >>> +     rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> >>> + /* NFSv4 compund */
> >>> + struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> >>> + struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> >>> +
> >>> + while (resp->opcnt < args->opcnt) {
> >>> + struct nfsd4_op *op =3D &args->ops[resp->opcnt++];
> >>> +
> >>> + seq_printf(m, " %s", nfsd4_op_name(op->opnum));
> >>> + }
> >>> + }
> >>> +#endif /* CONFIG_NFSD_V4 */
> >>> + seq_puts(m, "\n");
> >>=20
> >> My only quibble here is that the file format needs to be parsable
> >> by scripts as well as readable by humans. I'm not sure I have a
> >> specific comment, but it's something that needs some attention and
> >> verification (with, say, a sample user space tool, hint hint).
> >=20
> > maybe we can add a csv hanlder, what do you think? not sure.
>=20
> I suggested JSON to Jeff as another option, but I don't think we want
> to swing that far in the other direction.
>=20
> There are plenty of examples of /sys files that are both parsable and
> human-friendly. I'll leave it to you to find one or two formats that
> seem capable of the task at hand, and let's pick from one of those.

ok, I will take a look. In the meantime I posted a new revision to continue=
 the
discussion.

Regartds,
Lorenzo

>=20
>=20
> --
> Chuck Lever
>=20
>=20

--0JFP51DTI3ifb8uE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZKwvmwAKCRA6cBh0uS2t
rIW3AP0Vr7Sgk2hss85aXUXAHIVtRv1GPpX8NYQBGcTY2Fv5mgD+MWNw+1qJNrYl
38ktfYWIV3ysfgHNklo9G4jZHUGLRgQ=
=9OJa
-----END PGP SIGNATURE-----

--0JFP51DTI3ifb8uE--
