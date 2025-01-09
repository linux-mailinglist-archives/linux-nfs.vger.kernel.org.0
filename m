Return-Path: <linux-nfs+bounces-9024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB727A07C0D
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 16:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3861D3A6CD6
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC88021D598;
	Thu,  9 Jan 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq/aDMND"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B621D004
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436740; cv=none; b=qT7DBF2wpiUYPCq02WZIh2cLsjzqR2LvS3TnKMXED5CIvbLo38sYxqknXq5Ljg5n+m3xCCMzMe8bVBH6AmqpE3WRwLuxVX/jdB2rcuqWzV3L+4M/oPnWwXdsFfFhT6BJQfMmGq4btfQfTVEdceNh1ZEGCI/a+sOCb0I5Y4EEoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436740; c=relaxed/simple;
	bh=YIPlrcZNUnRriyqeGkOdwCSyyILP8JyQf90YrUe/qAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6COKltzSIoh7zS5uj85KR+PH/b0P/OSg/NzMb7FTqZ0M6HpXhHxDoNQp/k2vPO01JnprW3ZiSv+bT+WWVI0RHld3GGIVO39rpMvI+ReGZZWdnvxm5piX37F1KrSTzqldXk8NzO+85VSMKnukdoiWHKtDcaNWSOJ+Ey2V6vQb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cq/aDMND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736436736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVTtl6WUzBFkfxEC56RyoPfujCjfwWswBwKpDrO6cNQ=;
	b=Cq/aDMNDQTMVlbeu2oSj3qqqGACSv9izGxoPo3YvVxgW6oVqbiAsNfN9VDB/JvE0PE57q2
	+cIS4hPjzOpwzyLcJvz90EWknBlRLxcDguP9imSlN/ckv0U+HWj5XvqaStWmU7NNPMKxtK
	F6j0iOgNHD4+QltZFp78U5WV+YDZ938=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-WuJAJYsyNVi8_YRRWkwRVg-1; Thu,
 09 Jan 2025 10:32:14 -0500
X-MC-Unique: WuJAJYsyNVi8_YRRWkwRVg-1
X-Mimecast-MFC-AGG-ID: WuJAJYsyNVi8_YRRWkwRVg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA7DD1955DCC;
	Thu,  9 Jan 2025 15:32:13 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.211])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BE541954B24;
	Thu,  9 Jan 2025 15:32:13 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 103D72E9FFC; Thu, 09 Jan 2025 10:32:12 -0500 (EST)
Date: Thu, 9 Jan 2025 10:32:12 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfsdctl: tweak the version subcommand behavior
Message-ID: <Z3_r_FuHcKO-EVUD@aion>
References: <20250108225439.814872-1-smayhew@redhat.com>
 <52d4ff32bb0c598e97946e478c70fa3c718254d2.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <52d4ff32bb0c598e97946e478c70fa3c718254d2.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, 09 Jan 2025, Jeff Layton wrote:

> On Wed, 2025-01-08 at 17:54 -0500, Scott Mayhew wrote:
> > The section for the 'nfsdctl version' subcommand on the man page states
> > that the minorversion is optional, and if omitted it will cause all
> > minorversions to be enabled/disabled, but it currently doesn't work that
> > way.
> >=20
> > Make it work that way, with one exception.  If v4.0 is disabled, then
> > 'nfsdctl version +4' will not re-enable it; instead it must be
> > explicitly re-enabled via 'nfsdctl version +4.0'.  This mirrors the way
> > /proc/fs/nfsd/versions works.
> >=20
>=20
> The question is: do we want to mirror that particular quirk in the
> interface? I'm not sure if there was a logical reason for making +4
> work that way in the /proc interface, so it's not clear to me that we
> want to replicate that here.

Digging thru my email archive it seems that the reason for that was to
deal with really old kernels that understood +4/-4 but not +4.0/-4.0.
Since old kernels obviously won't have a netlink interface for nfsd it
seems we can drop this quirk at least.
>=20
> Honestly, it may be better to just require explicit minorversions in
> this interface and not worry about trying to interpret what +4
> means.=A0You'd need to specify "+4.1 +4.2" instead of just saying "+4",
> but that doesn't seem too onerous.
>=20
> Thoughts?

It seems to me main alternatives are=20

1. Drop the special handling for v4.0 but allow +4/-4 to always
enable/disable all minor versions, including v4.0.  So a small
adjustment to this patch.

2. Require the minor versions to be explicitly specified for v4.  So allow
+2/-2/+3/-3, but emit an error if +4/-4 is specified.  Maybe emit an error
if +2.0/-2.0/+3.0/-3.0 is specified.

3. Leave the code alone (so +4/-4 would be interpreted as +4.0/-4.1) and
just update the man page.

4. Make the 'nfsdctl version' behavior consistent with the nfs.conf option
handling in 'nfsdctl autostart'.  Currently thats:

        * vers4=3Dy turns on all minor versions.  vers4.x=3Dn on top of that
          will turn off those specific minor versions.
        * vers4=3Dn turns off all minor versions.  vers4.x=3Dy on top of
          that has no effect.

I don't really have a strong preference as long as the behavior matches
whatever the man page says it is.  If I had to vote I'd just say go with
option 3, but if it's important for the behaviors of the different
subcommands to be consistent, then we really don't have a choice and
have to go with option 4.

>=20
> > Link: https://issues.redhat.com/browse/RHEL-72477
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  utils/nfsdctl/nfsdctl.8    |  9 ++++--
> >  utils/nfsdctl/nfsdctl.adoc |  5 +++-
> >  utils/nfsdctl/nfsdctl.c    | 58 +++++++++++++++++++++++++++++++++++---
> >  3 files changed, 64 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
> > index b08fe803..835d60b4 100644
> > --- a/utils/nfsdctl/nfsdctl.8
> > +++ b/utils/nfsdctl/nfsdctl.8
> > @@ -2,12 +2,12 @@
> >  .\"     Title: nfsdctl
> >  .\"    Author: Jeff Layton
> >  .\" Generator: Asciidoctor 2.0.20
> > -.\"      Date: 2024-12-30
> > +.\"      Date: 2025-01-08
> >  .\"    Manual: \ \&
> >  .\"    Source: \ \&
> >  .\"  Language: English
> >  .\"
> > -.TH "NFSDCTL" "8" "2024-12-30" "\ \&" "\ \&"
> > +.TH "NFSDCTL" "8" "2025-01-08" "\ \&" "\ \&"
> >  .ie \n(.g .ds Aq \(aq
> >  .el       .ds Aq '
> >  .ss \n[.ss] 0
> > @@ -172,7 +172,10 @@ MINOR: the minor version integer value
> >  .nf
> >  .fam C
> >  The minorversion field is optional. If not given, it will disable or e=
nable
> > -all minorversions for that major version.
> > +all minorversions for that major version.  Note however that if NFSv4.=
0 was
> > +previously disabled, it can only be re\-enabled by explicitly specifyi=
ng the
> > +minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
> > +interface).
> >  .fam
> >  .fi
> >  .if n .RE
> > diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> > index c5921458..20e9bf8e 100644
> > --- a/utils/nfsdctl/nfsdctl.adoc
> > +++ b/utils/nfsdctl/nfsdctl.adoc
> > @@ -91,7 +91,10 @@ Each subcommand can also accept its own set of optio=
ns and arguments. The
> >      MINOR: the minor version integer value
> > =20
> >    The minorversion field is optional. If not given, it will disable or=
 enable
> > -  all minorversions for that major version.
> > +  all minorversions for that major version.  Note however that if NFSv=
4.0 was
> > +  previously disabled, it can only be re-enabled by explicitly specify=
ing the
> > +  minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
> > +  interface).
> > =20
> >    Note that versions can only be set when there are no nfsd threads ru=
nning.
> > =20
> > diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> > index 722bf4a0..d86ff80e 100644
> > --- a/utils/nfsdctl/nfsdctl.c
> > +++ b/utils/nfsdctl/nfsdctl.c
> > @@ -761,6 +761,32 @@ static int update_nfsd_version(int major, int mino=
r, bool enabled)
> >  	return -EINVAL;
> >  }
> > =20
> > +static bool v40_is_disabled(void)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < MAX_NFS_VERSIONS; ++i) {
> > +		if (nfsd_versions[i].major =3D=3D 0)
> > +			break;
> > +		if (nfsd_versions[i].major =3D=3D 4 && nfsd_versions[i].minor =3D=3D=
 0)
> > +			return !nfsd_versions[i].enabled;
> > +	}
> > +	return false;
> > +}
> > +
> > +static int get_max_minorversion(void)
> > +{
> > +	int i, max =3D 0;
> > +
> > +	for (i =3D 0; i < MAX_NFS_VERSIONS; ++i) {
> > +		if (nfsd_versions[i].major =3D=3D 0)
> > +			break;
> > +		if (nfsd_versions[i].major =3D=3D 4 && nfsd_versions[i].minor > max)
> > +			max =3D nfsd_versions[i].minor;
> > +	}
> > +	return max;
> > +}
> > +
> >  static void version_usage(void)
> >  {
> >  	printf("Usage: %s version { {+,-}major.minor } ...\n", taskname);
> > @@ -778,7 +804,8 @@ static void version_usage(void)
> > =20
> >  static int version_func(struct nl_sock *sock, int argc, char ** argv)
> >  {
> > -	int ret, i;
> > +	int ret, i, j, max_minor;
> > +	bool v40_disabled;
> > =20
> >  	/* help is only valid as first argument after command */
> >  	if (argc > 1 &&
> > @@ -792,6 +819,9 @@ static int version_func(struct nl_sock *sock, int a=
rgc, char ** argv)
> >  		return ret;
> > =20
> >  	if (argc > 1) {
> > +		v40_disabled =3D v40_is_disabled();
> > +		max_minor =3D get_max_minorversion();
> > +
> >  		for (i =3D 1; i < argc; ++i) {
> >  			int ret, major, minor =3D 0;
> >  			char sign =3D '\0', *str =3D argv[i];
> > @@ -815,9 +845,29 @@ static int version_func(struct nl_sock *sock, int =
argc, char ** argv)
> >  				return -EINVAL;
> >  			}
> > =20
> > -			ret =3D update_nfsd_version(major, minor, enabled);
> > -			if (ret)
> > -				return ret;
> > +			/*
> > +			 * The minorversion field is optional. If omitted, it should
> > +			 * cause all the minor versions for that major version to be
> > +			 * enabled/disabled.
> > +			 *
> > +			 * HOWEVER, we do not enable v4.0 in this manner if it was
> > +			 * previously disabled - it has to be explicitly enabled
> > +			 * instead.  This is to retain the behavior of the old
> > +			 * /proc/fs/nfsd/versions interface.
> > +			 */
> > +			if (major =3D=3D 4 && ret =3D=3D 2) {
> > +				for (j =3D 0; j <=3D max_minor; ++j) {
> > +					if (j =3D=3D 0 && enabled && v40_disabled)
> > +						continue;
> > +					ret =3D update_nfsd_version(major, j, enabled);
> > +					if (ret)
> > +						return ret;
> > +				}
> > +			} else {
> > +				ret =3D update_nfsd_version(major, minor, enabled);
> > +				if (ret)
> > +					return ret;
> > +			}
> >  		}
> >  		return set_nfsd_versions(sock);
> >  	}
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


