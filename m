Return-Path: <linux-nfs+bounces-9029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4ACA07CBD
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 17:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917C01653ED
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB6218AA5;
	Thu,  9 Jan 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWt3Oni9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC942185B3
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438507; cv=none; b=BCdcIYx/ByqdPkaQ1q9mnLrDBTaWOl7gL04ZPX7ThIyLvLeCYr3awII20Dp0Xpdsok1UQngKI5jTjjC71jiQrjKdufQp7nc+4mUCfpr7mWpi8HlO8SrhpoQBJW+cUUpIktd+busEp2OIcteXf6kEJkagnq3FrUWeP7bfyuMvMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438507; c=relaxed/simple;
	bh=ikNjW+i/4PBaGvleJ1Ec/S600BLomK0HhIsBOOzPHR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTsopXLe8XDy9E0mdWtfwqBIb1e1iw78sfG3Vcr8Mc75WedLzzxW7yGVRaKbggcJaCzUNnKLg2bva/jawOQUjv4fKEjAsL++MypdrfL+GvaGs2nIz+Ms954oOQ0mwo/1HrU0kHylQ8Z/R9aiYlpLFOG3Wya36rj4MkU81/7QXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWt3Oni9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089A9C4CED2;
	Thu,  9 Jan 2025 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736438507;
	bh=ikNjW+i/4PBaGvleJ1Ec/S600BLomK0HhIsBOOzPHR0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aWt3Oni9zlkSLAY+zhJiG9wCAPim/+VCXqYC03fSf6zy1Xa9Co7WVXUNMyPNprCVL
	 C7sDyP+PB74A7noZ4pV5ZaGteTjP81+nABGi5o/k4suVq1ULAvGkO/8evA4aI441rr
	 wX0fXMg+v4RJWWFAO2nn90RtYzEPMhohrU1zVfOeDdeA/2/dswbPPpnVB5fojKPDzo
	 RfeNGQw6EoIEqtQOY6HNKyoWxIQxlJwbUGhMyYe8w2C5jGAHWLcJN3c45JK/XRZ6qv
	 AAEndjxo8FxQvaN30OgKUH5BNkDETo4FpBhxRMFn3/4bC62Qk6WxFaa2zmHYKnxAev
	 zbkRFpnMprw5g==
Message-ID: <08555231d6181e8a59fbfa780d2164a1c81a0ce6.camel@kernel.org>
Subject: Re: [nfs-utils PATCH] nfsdctl: tweak the version subcommand behavior
From: Jeff Layton <jlayton@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Date: Thu, 09 Jan 2025 11:01:45 -0500
In-Reply-To: <Z3_r_FuHcKO-EVUD@aion>
References: <20250108225439.814872-1-smayhew@redhat.com>
	 <52d4ff32bb0c598e97946e478c70fa3c718254d2.camel@kernel.org>
	 <Z3_r_FuHcKO-EVUD@aion>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-09 at 10:32 -0500, Scott Mayhew wrote:
> On Thu, 09 Jan 2025, Jeff Layton wrote:
>=20
> > On Wed, 2025-01-08 at 17:54 -0500, Scott Mayhew wrote:
> > > The section for the 'nfsdctl version' subcommand on the man page stat=
es
> > > that the minorversion is optional, and if omitted it will cause all
> > > minorversions to be enabled/disabled, but it currently doesn't work t=
hat
> > > way.
> > >=20
> > > Make it work that way, with one exception.  If v4.0 is disabled, then
> > > 'nfsdctl version +4' will not re-enable it; instead it must be
> > > explicitly re-enabled via 'nfsdctl version +4.0'.  This mirrors the w=
ay
> > > /proc/fs/nfsd/versions works.
> > >=20
> >=20
> > The question is: do we want to mirror that particular quirk in the
> > interface? I'm not sure if there was a logical reason for making +4
> > work that way in the /proc interface, so it's not clear to me that we
> > want to replicate that here.
>=20
> Digging thru my email archive it seems that the reason for that was to
> deal with really old kernels that understood +4/-4 but not +4.0/-4.0.
> Since old kernels obviously won't have a netlink interface for nfsd it
> seems we can drop this quirk at least.
> >=20
> > Honestly, it may be better to just require explicit minorversions in
> > this interface and not worry about trying to interpret what +4
> > means.=C2=A0You'd need to specify "+4.1 +4.2" instead of just saying "+=
4",
> > but that doesn't seem too onerous.
> >=20
> > Thoughts?
>=20
> It seems to me main alternatives are=20
>=20
> 1. Drop the special handling for v4.0 but allow +4/-4 to always
> enable/disable all minor versions, including v4.0.  So a small
> adjustment to this patch.
>=20
> 2. Require the minor versions to be explicitly specified for v4.  So allo=
w
> +2/-2/+3/-3, but emit an error if +4/-4 is specified.  Maybe emit an erro=
r
> if +2.0/-2.0/+3.0/-3.0 is specified.
>=20
> 3. Leave the code alone (so +4/-4 would be interpreted as +4.0/-4.1) and
> just update the man page.
>=20
> 4. Make the 'nfsdctl version' behavior consistent with the nfs.conf optio=
n
> handling in 'nfsdctl autostart'.  Currently thats:
>=20
>         * vers4=3Dy turns on all minor versions.  vers4.x=3Dn on top of t=
hat
>           will turn off those specific minor versions.
>         * vers4=3Dn turns off all minor versions.  vers4.x=3Dy on top of
>           that has no effect.
>=20
> I don't really have a strong preference as long as the behavior matches
> whatever the man page says it is.  If I had to vote I'd just say go with
> option 3, but if it's important for the behaviors of the different
> subcommands to be consistent, then we really don't have a choice and
> have to go with option 4.
>=20

Now that you've laid them out, I think option #1 sounds best. Having to
specify a minorversion is a departure from the current interface, and
probably more effort than it's worth.

The behavior in #1 also seems the most intuitive if we're going to keep
the ability to accept a value that doesn't have a minorversion.


> > > Link: https://issues.redhat.com/browse/RHEL-72477
> > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > ---
> > >  utils/nfsdctl/nfsdctl.8    |  9 ++++--
> > >  utils/nfsdctl/nfsdctl.adoc |  5 +++-
> > >  utils/nfsdctl/nfsdctl.c    | 58 +++++++++++++++++++++++++++++++++++-=
--
> > >  3 files changed, 64 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
> > > index b08fe803..835d60b4 100644
> > > --- a/utils/nfsdctl/nfsdctl.8
> > > +++ b/utils/nfsdctl/nfsdctl.8
> > > @@ -2,12 +2,12 @@
> > >  .\"     Title: nfsdctl
> > >  .\"    Author: Jeff Layton
> > >  .\" Generator: Asciidoctor 2.0.20
> > > -.\"      Date: 2024-12-30
> > > +.\"      Date: 2025-01-08
> > >  .\"    Manual: \ \&
> > >  .\"    Source: \ \&
> > >  .\"  Language: English
> > >  .\"
> > > -.TH "NFSDCTL" "8" "2024-12-30" "\ \&" "\ \&"
> > > +.TH "NFSDCTL" "8" "2025-01-08" "\ \&" "\ \&"
> > >  .ie \n(.g .ds Aq \(aq
> > >  .el       .ds Aq '
> > >  .ss \n[.ss] 0
> > > @@ -172,7 +172,10 @@ MINOR: the minor version integer value
> > >  .nf
> > >  .fam C
> > >  The minorversion field is optional. If not given, it will disable or=
 enable
> > > -all minorversions for that major version.
> > > +all minorversions for that major version.  Note however that if NFSv=
4.0 was
> > > +previously disabled, it can only be re\-enabled by explicitly specif=
ying the
> > > +minorversion (this mirrors the behavior of the /proc/fs/nfsd/version=
s
> > > +interface).
> > >  .fam
> > >  .fi
> > >  .if n .RE
> > > diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> > > index c5921458..20e9bf8e 100644
> > > --- a/utils/nfsdctl/nfsdctl.adoc
> > > +++ b/utils/nfsdctl/nfsdctl.adoc
> > > @@ -91,7 +91,10 @@ Each subcommand can also accept its own set of opt=
ions and arguments. The
> > >      MINOR: the minor version integer value
> > > =20
> > >    The minorversion field is optional. If not given, it will disable =
or enable
> > > -  all minorversions for that major version.
> > > +  all minorversions for that major version.  Note however that if NF=
Sv4.0 was
> > > +  previously disabled, it can only be re-enabled by explicitly speci=
fying the
> > > +  minorversion (this mirrors the behavior of the /proc/fs/nfsd/versi=
ons
> > > +  interface).
> > > =20
> > >    Note that versions can only be set when there are no nfsd threads =
running.
> > > =20
> > > diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> > > index 722bf4a0..d86ff80e 100644
> > > --- a/utils/nfsdctl/nfsdctl.c
> > > +++ b/utils/nfsdctl/nfsdctl.c
> > > @@ -761,6 +761,32 @@ static int update_nfsd_version(int major, int mi=
nor, bool enabled)
> > >  	return -EINVAL;
> > >  }
> > > =20
> > > +static bool v40_is_disabled(void)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < MAX_NFS_VERSIONS; ++i) {
> > > +		if (nfsd_versions[i].major =3D=3D 0)
> > > +			break;
> > > +		if (nfsd_versions[i].major =3D=3D 4 && nfsd_versions[i].minor =3D=
=3D 0)
> > > +			return !nfsd_versions[i].enabled;
> > > +	}
> > > +	return false;
> > > +}
> > > +
> > > +static int get_max_minorversion(void)
> > > +{
> > > +	int i, max =3D 0;
> > > +
> > > +	for (i =3D 0; i < MAX_NFS_VERSIONS; ++i) {
> > > +		if (nfsd_versions[i].major =3D=3D 0)
> > > +			break;
> > > +		if (nfsd_versions[i].major =3D=3D 4 && nfsd_versions[i].minor > ma=
x)
> > > +			max =3D nfsd_versions[i].minor;
> > > +	}
> > > +	return max;
> > > +}
> > > +
> > >  static void version_usage(void)
> > >  {
> > >  	printf("Usage: %s version { {+,-}major.minor } ...\n", taskname);
> > > @@ -778,7 +804,8 @@ static void version_usage(void)
> > > =20
> > >  static int version_func(struct nl_sock *sock, int argc, char ** argv=
)
> > >  {
> > > -	int ret, i;
> > > +	int ret, i, j, max_minor;
> > > +	bool v40_disabled;
> > > =20
> > >  	/* help is only valid as first argument after command */
> > >  	if (argc > 1 &&
> > > @@ -792,6 +819,9 @@ static int version_func(struct nl_sock *sock, int=
 argc, char ** argv)
> > >  		return ret;
> > > =20
> > >  	if (argc > 1) {
> > > +		v40_disabled =3D v40_is_disabled();
> > > +		max_minor =3D get_max_minorversion();
> > > +
> > >  		for (i =3D 1; i < argc; ++i) {
> > >  			int ret, major, minor =3D 0;
> > >  			char sign =3D '\0', *str =3D argv[i];
> > > @@ -815,9 +845,29 @@ static int version_func(struct nl_sock *sock, in=
t argc, char ** argv)
> > >  				return -EINVAL;
> > >  			}
> > > =20
> > > -			ret =3D update_nfsd_version(major, minor, enabled);
> > > -			if (ret)
> > > -				return ret;
> > > +			/*
> > > +			 * The minorversion field is optional. If omitted, it should
> > > +			 * cause all the minor versions for that major version to be
> > > +			 * enabled/disabled.
> > > +			 *
> > > +			 * HOWEVER, we do not enable v4.0 in this manner if it was
> > > +			 * previously disabled - it has to be explicitly enabled
> > > +			 * instead.  This is to retain the behavior of the old
> > > +			 * /proc/fs/nfsd/versions interface.
> > > +			 */
> > > +			if (major =3D=3D 4 && ret =3D=3D 2) {
> > > +				for (j =3D 0; j <=3D max_minor; ++j) {
> > > +					if (j =3D=3D 0 && enabled && v40_disabled)
> > > +						continue;
> > > +					ret =3D update_nfsd_version(major, j, enabled);
> > > +					if (ret)
> > > +						return ret;
> > > +				}
> > > +			} else {
> > > +				ret =3D update_nfsd_version(major, minor, enabled);
> > > +				if (ret)
> > > +					return ret;
> > > +			}
> > >  		}
> > >  		return set_nfsd_versions(sock);
> > >  	}
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

