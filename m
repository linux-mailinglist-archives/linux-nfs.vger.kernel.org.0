Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DBD221837
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 01:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGOXFs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 19:05:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:43924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgGOXFs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 Jul 2020 19:05:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D11F4B1ED;
        Wed, 15 Jul 2020 23:05:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Thu, 16 Jul 2020 09:05:39 +1000
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: nfs4_show_superblock considered harmful :-)
In-Reply-To: <20200715185456.GE15543@fieldses.org>
References: <871rn38suc.fsf@notabene.neil.brown.name> <20200529220608.GA22758@fieldses.org> <87a71n7dek.fsf@notabene.neil.brown.name> <20200715185456.GE15543@fieldses.org>
Message-ID: <87k0z4xtto.fsf@notabene.neil.brown.name>
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

On Wed, Jul 15 2020, J. Bruce Fields wrote:

> On Mon, Jun 01, 2020 at 12:01:07PM +1000, NeilBrown wrote:
>> On Fri, May 29 2020, J. Bruce Fields wrote:
>>=20
>> > On Fri, May 29, 2020 at 10:53:15AM +1000, NeilBrown wrote:
>> >>  I've received a report of a 5.3 kernel crashing in
>> >>  nfs4_show_superblock().
>> >>  I was part way through preparing a patch when I concluded that
>> >>  the problem wasn't as straight forward as I thought.
>> >>
>> >>  In the crash, the 'struct file *' passed to nfs4_show_superblock()
>> >>  was NULL.
>> >>  This file was acquired from find_any_file(), and every other caller
>> >>  of find_any_file() checks that the returned value is not NULL (though
>> >>  one BUGs if it is NULL - another WARNs).
>> >>  But nfs4_show_open() and nfs4_show_lock() don't.
>> >>  Maybe they should.  I didn't double check, but I suspect they don't
>> >>  hold enough locks to ensure that the files don't get removed.
>> >
>> > I think the only lock held is cl_lock, acquired in states_start.
>> >
>> > We're starting here with an nfs4_stid that was found in the cl_stateids
>> > idr.
>> >
>> > A struct nfs4_stid is freed by nfs4_put_stid(), which removes it from
>> > that idr under cl_lock before freeing the nfs4_stid and anything it
>> > points to.
>> >
>> > I think that was the theory....
>> >
>> > One possible problem is downgrades, like nfs4_stateid_downgrade.
>> >
>> > I'll keep mulling it over, thanks.
>>=20
>
> Oops, I neglected this a while....
>
>> I had another look at code and maybe move_to_close_lru() is the problem.
>> It can clear remove the files and clear sc_file without taking
>> cl_lock.  So some protection is needed against that.
>>=20
>> I think that only applies to nfs4_show_open() - not show_lock etc.
>> But I wonder it is might be best to include some extra protection
>> for each different case, just in case some future code change
>> allow sc_file to become NULL before the state is detached.
>>=20
>> I'd feel more comforatable about nfs4_show_superblock() if it ignored
>> nf_inode and just used nf_file - it is isn't NULL.  It looks like it
>> can never be set from non-NULL to NULL.
>
> But then that means we've always got a reference on the inode, doesn't
> it?  So I still don't understand the nf_inode comment.

My main problem with nf_inode is the comment

/*
 * A representation of a file that has been opened by knfsd. These are hash=
ed
 * in the hashtable by inode pointer value. Note that this object doesn't
 * hold a reference to the inode by itself, so the nf_inode pointer should
 * never be dereferenced, only used for comparison.
 */

That comment is incompatible with the code in
nfsd_file_mark_find_or_create() and with the code in
nfs4_show_superblock().

>
> So maybe the NULL checks are mainly all we need.
>
> Also it looks to me like ls_file lasts as long as the layout stateid, so
> maybe it's OK.
>
> --b.
>
> commit 4eef57aa4fc0
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Wed Jul 15 13:31:36 2020 -0400
>
>     nfsd4: fix NULL dereference in nfsd/clients display code
>=20=20=20=20=20
>     Reported-by: NeilBrown <neilb@suse.de>
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ab5c8857ae5a..08b8376c74d7 100644
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

You'll need to add nfsd_file_put(file) toward the end of this function.
Otherwise, I think this patch is a step in the right direction.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8Pi8UACgkQOeye3VZi
gbnw/g//eW30ZHMCFJfrqhtTLXbHK0gcrr2M/p+2hO9ReuRIe4w3s+7TmYD0Nv+t
YlL5bvwwlGQqXv1H62GEIUP/3CNgJWBQJBk4B+jMW8nPAdHOp3wsNTqsTNuv40dk
nN6YGrHOuQUuxZx3gs9wAvijxyNwZgmSLmS+ndA7lDYgGSZioPvGsTOa/wX0bRLk
reNf0pcDhtf7qrCYYTKwi/LexdkruHjHp/3pnAa6mEp3jFq1tTNLlreWllzHrXrM
IrSw3ViCEZYcPlVPpExOyb8WmquxHnp9NxDQ5xT9rL84HyKQhZ/G8M6Eq3hWeL0T
sV+qPawzlhuZQhdZAOrr1ncx0cB2DEPAZQr6D6EKYTJ2VeThcsywTYIDg6irCOsG
pguSiIqPlzr75Ca3hFG/vXlyYCyDJ9zdW6MzSLyDQYEddCLpxUufj1elKXY36Bqd
N0q/LMcz6J8ck71OcPvpt5E6gDt3X70iRXZt51LPWlEjfvt9mB5pT0gPmf6KYAzf
kNtF89a2XDsDMEtBpiYw5qXbKISEW0nofjSWH0mOqySUbheuuLLCfgf9Yw66a4D/
O37rHZXX27t3iMVsnqBdbhuVSCZeWOHZoWLXQvgYWf+vZN77wnIVoq9aXoNs0bWH
V/V2VlH2q046YQ3g/9TCkKp27cHCwdZ3/F3eHXM4wHz0DK+vKPc=
=2TFy
-----END PGP SIGNATURE-----
--=-=-=--
