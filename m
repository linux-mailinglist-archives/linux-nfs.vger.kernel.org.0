Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA195222F4A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jul 2020 01:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgGPXnr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 19:43:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:51462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgGPXnr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Jul 2020 19:43:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56D08AB89;
        Thu, 16 Jul 2020 23:43:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 17 Jul 2020 09:43:40 +1000
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: nfs4_show_superblock considered harmful :-)
In-Reply-To: <20200716171958.GB18568@fieldses.org>
References: <871rn38suc.fsf@notabene.neil.brown.name> <20200529220608.GA22758@fieldses.org> <87a71n7dek.fsf@notabene.neil.brown.name> <20200715185456.GE15543@fieldses.org> <20200716171958.GB18568@fieldses.org>
Message-ID: <87tuy7vxeb.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16 2020, J. Bruce Fields wrote:

> On Wed, Jul 15, 2020 at 02:54:56PM -0400, J. Bruce Fields wrote:
>> commit 4eef57aa4fc0
>> Author: J. Bruce Fields <bfields@redhat.com>
>> Date:   Wed Jul 15 13:31:36 2020 -0400
>>=20
>>     nfsd4: fix NULL dereference in nfsd/clients display code
>>=20=20=20=20=20
>>     Reported-by: NeilBrown <neilb@suse.de>
>>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index ab5c8857ae5a..08b8376c74d7 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -507,6 +507,16 @@ find_any_file(struct nfs4_file *f)
>>  	return ret;
>>  }
>>=20=20
>> +static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
>> +{
>> +	struct nfsd_file *ret;
>> +
>> +	spin_lock(&f->fi_lock);
>> +	ret =3D nfsd_file_get(f->fi_deleg_file);
>> +	spin_unlock(&f->fi_lock);
>> +	return ret;
>> +}
>> +
> ...
>> @@ -2513,7 +2527,9 @@ static int nfs4_show_deleg(struct seq_file *s, str=
uct nfs4_stid *st)
>>=20=20
>>  	ds =3D delegstateid(st);
>>  	nf =3D st->sc_file;
>> -	file =3D nf->fi_deleg_file;
>> +	file =3D find_deleg_file(nf);
>> +	if (!file)
>> +		return 0;
>>=20=20
>>  	seq_printf(s, "- ");
>>  	nfs4_show_stateid(s, &st->sc_stateid);
>
> Oops, I added a "get" without a corresponding "put".
>
> --b.
>
> commit 8d2edfe45286
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Wed Jul 15 13:31:36 2020 -0400
>
>     nfsd4: fix NULL dereference in nfsd/clients display code
>=20=20=20=20=20
>     We hold the cl_lock here, and that's enough to keep stateid's from go=
ing
>     away, but it's not enough to prevent the files they point to from goi=
ng
>     away.  Take fi_lock and a reference and check for NULL, as we do in
>     other code.
>=20=20=20=20=20
>     Reported-by: NeilBrown <neilb@suse.de>
>     Fixes: 78599c42ae3c ("nfsd4: add file to display list of client's ope=
ns")
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ab5c8857ae5a..9d45117c8c18 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -507,6 +507,16 @@ find_any_file(struct nfs4_file *f)
>  	return ret;
>  }
>=20=20
> +static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
> +{
> +	struct nfsd_file *ret;
> +
> +	spin_lock(&f->fi_lock);
> +	ret =3D nfsd_file_get(f->fi_deleg_file);

A test on f->fi_deleg_file being non-NULL would make this look safer.
It would  also make the subsequent test on the return value appear sane.

Thanks,
NeilBrown

> +	spin_unlock(&f->fi_lock);
> +	return ret;
> +}
> +
>  static atomic_long_t num_delegations;
>  unsigned long max_delegations;
>=20=20
> @@ -2444,6 +2454,8 @@ static int nfs4_show_open(struct seq_file *s, struc=
t nfs4_stid *st)
>  	oo =3D ols->st_stateowner;
>  	nf =3D st->sc_file;
>  	file =3D find_any_file(nf);
> +	if (!file)
> +		return 0;
>=20=20
>  	seq_printf(s, "- ");
>  	nfs4_show_stateid(s, &st->sc_stateid);
> @@ -2481,6 +2493,8 @@ static int nfs4_show_lock(struct seq_file *s, struc=
t nfs4_stid *st)
>  	oo =3D ols->st_stateowner;
>  	nf =3D st->sc_file;
>  	file =3D find_any_file(nf);
> +	if (!file)
> +		return 0;
>=20=20
>  	seq_printf(s, "- ");
>  	nfs4_show_stateid(s, &st->sc_stateid);
> @@ -2513,7 +2527,9 @@ static int nfs4_show_deleg(struct seq_file *s, stru=
ct nfs4_stid *st)
>=20=20
>  	ds =3D delegstateid(st);
>  	nf =3D st->sc_file;
> -	file =3D nf->fi_deleg_file;
> +	file =3D find_deleg_file(nf);
> +	if (!file)
> +		return 0;
>=20=20
>  	seq_printf(s, "- ");
>  	nfs4_show_stateid(s, &st->sc_stateid);
> @@ -2529,6 +2545,7 @@ static int nfs4_show_deleg(struct seq_file *s, stru=
ct nfs4_stid *st)
>  	seq_printf(s, ", ");
>  	nfs4_show_fname(s, file);
>  	seq_printf(s, " }\n");
> +	nfsd_file_put(file);
>=20=20
>  	return 0;
>  }

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8Q5iwACgkQOeye3VZi
gbkgVw/7B6AED/Dyay+AmC5fSq9d1f65zxJWQkFAn1wQ6fTXGIMhGFgqWH2JSY9y
7v38meJfAUcvhjclBNX3nngJaNLeEBFo4YlmMJkuHR4aIFDAIN6BabuJX2dUrvsW
D4PBPX6mfPLywkMuWFoxGANkP8BGXUMHN7gU/9+rvHdKEupnocSEiay9+dyBvC3H
le0JDW63hHiWHsEWWu1LnQ28JfaVoVUhy7gv4n7/eHiRaP4rZTbS+ArCskAeEC5N
fJ1ZT+h3AxiyPlqiliNLSkj3XBKw3XYlyQFpx3FIEoqVFZ3Nav6MEsu/4eFbmkRm
jgoGC3DtFOAS/OMOdBzSzsEmXLht+D+KUBZLS66MBHkrBqzLcpkxKgI32NPQUu/n
UyIetlGfHoxM0w8S4hRQqSf/y9qg8n7lML/bHwqJW7E0wKWov1OTy0YL9B929duS
HS5zmuWSNWTsZyyjY9X5HajyK2AsObACBdxTV59Rtc4Hokt8oaCVdPIdKnBAkKBL
+1nfB9a6u7ZaV/yxvbJKkodcwhRxCLt63TT0B8CWpbUuk3oiOCkI0gfhm8WXaQhR
FuewuTNHDwXFDDBjYsdFM0jdkHEd7BBfoCbQwodv9qFgzst0xUC4Y3hgRCFJsZRv
urHnXluv3cXPPmv+tUVQ1ayaZG8Q/YQ3OIrArbXoPwjracBtdRI=
=jfBQ
-----END PGP SIGNATURE-----
--=-=-=--
