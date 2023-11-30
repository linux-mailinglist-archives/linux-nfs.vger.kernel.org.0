Return-Path: <linux-nfs+bounces-194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED37FECDC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 11:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E1BB20EFC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBE41DDC7;
	Thu, 30 Nov 2023 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcLfdoSU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FD3C073;
	Thu, 30 Nov 2023 10:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53103C433C7;
	Thu, 30 Nov 2023 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701340340;
	bh=HOjF+ggEGZVQckUoqiyH9FoyAEK63YTupFSMkKbKimU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcLfdoSU1zOGHdZ/HTs1NAUSyqpVBXd4pL2J+DmFSOjBcTFy5YC+nkAFssnB29WyX
	 fsmgoFdUC7k+EAr8omZrGfgPB2AsChEc/xNf8vE0vjT4Dgs2HebR2gF3v9Qbu7MF/J
	 OrHXpfWo4j97lMHmzwAmm8Q3D8cP7jHgNIck6jbEUaZAVbTQglh5kjXfEHB2OtRoSE
	 f8oDGk1njXU607fNKWu5xmAhS4dQhtqZm4F2CBuJogKyf8R7tqjzvTIDn22go/pBKh
	 llpAuT2SrY0V1UbEGXXTdNDeaLN/FkJ+lwbVLxEMYMEia3+XVUYFTibMnNAyYW8Yvt
	 SNEq3C32na2EQ==
Date: Thu, 30 Nov 2023 11:32:17 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
	netdev@vger.kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v5 2/3] NFSD: convert write_version to netlink command
Message-ID: <ZWhksS5C6mcvVPEN@lore-desk>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
 <20231129162832.4b36f96b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0RPUHzhMsRv9aFE"
Content-Disposition: inline
In-Reply-To: <20231129162832.4b36f96b@kernel.org>


--i0RPUHzhMsRv9aFE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 29 Nov 2023 18:12:44 +0100 Lorenzo Bianconi wrote:
> > +      -
> > +        name: status
> > +        type: u8
>=20
> u8? I guess...

here we need just 0 or 1 I would say. Do you suggest create something like =
an
enum?

> > +/**
> > + * nfsd_nl_version_get_doit - Handle verion_get dumpit
>=20
> doesn't match the function name (do -> dump)

ack, I will fix it.

>=20
> > +			/* NFSv{2,3} does not support minor numbers */
> > +			if (i < 4 && j)
> > +				continue;
> > +
> > +			if (i =3D=3D 4 && !nfsd_minorversion(nn, j, NFSD_TEST))
> > +				continue;
> > +
> > +			hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> > +					  cb->nlh->nlmsg_seq, &nfsd_nl_family,
> > +					  0, NFSD_CMD_VERSION_GET);
>=20
> Why not iput()?

ack, I will fix it.

Regards,
Lorenzo

>=20
> > +			if (!hdr)
> > +				goto out;
> > +
> > +			if (nla_put_u32(skb, NFSD_A_SERVER_VERSION_MAJOR, i) ||
> > +			    nla_put_u32(skb, NFSD_A_SERVER_VERSION_MINOR, j))
> > +				goto out;
> > +
> > +			genlmsg_end(skb, hdr);
> > +		}
> > +	}
>=20

--i0RPUHzhMsRv9aFE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZWhksAAKCRA6cBh0uS2t
rMT+AP9Cg3y7E22p898lhYFQsmWgouk4y5paFB9vbTxLwIullAEAz/AhE01+XzAD
DNcVda0rXXEIIFxtUvrJAnDnR2Sragc=
=YDI6
-----END PGP SIGNATURE-----

--i0RPUHzhMsRv9aFE--

