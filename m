Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BDC5801F7
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 17:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGYPgQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 11:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiGYPgP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 11:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D468BC98
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 08:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF8D61299
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 15:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FC3C341CE;
        Mon, 25 Jul 2022 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658763374;
        bh=KWhkr6dv6kMPdpQRLgSOQGz0NeUN+ogX31BZZWSHJ1g=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=CeiIW/LcwPr1UP4tlbaDUiqgT/kuULuyAl5YK7aUsri2QxOSy8SGnEv0XfbMZE0z+
         zswFApI0OU/UQ9OnFF9I4c3OBhAGJtVdGbDfFFYsXoIeh+hauLURbjJF4cvXJsn2wE
         qz+h2eJ6M4EQz5jbUwdaoiCvyCJHZtbTeJOOS88AkUFIjdAXYKoylhqZEtl86R6bb5
         E//LKcd+k2AQJg/aAAhb0gK757NVMd9g39+BYzjxrftuUNi4rijPm7F5K9bJi+jTUU
         7wo7qtmzO2/Dv0ccuiPzDAQ3D4LW1iIwW9+vEZdzEJVSsamxF77v1Y8ktdp9+96xSw
         tkiqsJTxEqrTA==
Message-ID: <59534604ed620c0b7e9ec565a4f1505ca0910420.camel@kernel.org>
Subject: Re: [PATCH v1 1/8] NFSD: Optimize nfsd4_encode_operation()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 25 Jul 2022 11:36:12 -0400
In-Reply-To: <A87D312E-1042-451A-A1B7-438351BCE368@oracle.com>
References: <165852051841.11198.2929614302983292322.stgit@manet.1015granger.net>
         <A87D312E-1042-451A-A1B7-438351BCE368@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-07-22 at 20:12 +0000, Chuck Lever III wrote:
>=20
> > On Jul 22, 2022, at 4:08 PM, Chuck Lever <chuck.lever@oracle.com> wrote=
:
> >=20
> > write_bytes_to_xdr_buf() is a generic way to place a variable-length
> > data item in an already-reserved spot in the encoding buffer.
> > However, it is costly, and here, it is unnecessary because the
> > data item is fixed in size, the buffer destination address is
> > always word-aligned, and the destination location is already in
> > @p.
> >=20
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> > fs/nfsd/nfs4xdr.c |    3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 2acea7792bb2..b52ea7d8313a 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -5373,8 +5373,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *=
resp, struct nfsd4_op *op)
> > 						so->so_replay.rp_buf, len);
> > 	}
> > status:
> > -	/* Note that op->status is already in network byte order: */
> > -	write_bytes_to_xdr_buf(xdr->buf, post_err_offset - 4, &op->status, 4)=
;
> > +	*p =3D op->status;
> > }
> >=20
> > /*=20
>=20
> I hit "Send" too soon. Here's the cover letter for this series.
>=20
> write_bytes_to_xdr_buf() is a generic mechanism by which to push
> an arbitrary set of bytes to an arbitrary alignment within an
> xdr_buf. It's expensive to use, though.
>=20
> I found several hot paths in the server's NFSv4 reply encoders
> that write a 4-byte XDR data item on a 4-byte alignment, and
> thus can use the classic "*p =3D cpu_to_be32(yada)" form instead
> of write_bytes_to_xdr_buf().
>=20
> This series replaces some write_bytes_to_xdr_buf() call sites.
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

Nice cleanup. This series looks good to me (and it's a net-negative LoC
too).

Reviewed-by: Jeff Layton <jlayton@kernel.org>
