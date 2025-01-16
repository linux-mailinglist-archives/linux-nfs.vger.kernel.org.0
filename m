Return-Path: <linux-nfs+bounces-9297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB21A13970
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 12:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD287A44B7
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F71DE3A5;
	Thu, 16 Jan 2025 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRAo+2BS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8671DC1A7
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028251; cv=none; b=bxacWcTCIUrJ2dAgiKjWw2zX0D6+rC5k5VnY0l05krpss3WCY/v5ctWtgtHoZIurS6D9IJbp/PA71l21pKudxrU7k70q/mN401uCYg+FLGxxOdj7bu7LuM9Mn5sCP2K6Ul+9jiMPfLdOn7sZLGDvxu0+369h5TVWowFaFS0HvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028251; c=relaxed/simple;
	bh=AeE5w7WmpTBpW3/JySKZEm0bAFJ401NHlJiO4qsIWIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8GCm0faocQ+zcT9Ps6uQvl+0FFe0Ph4rALfnl9kc+OIEDQCN1usoi0FuGu5KF1JLiY7MtX9SAMJX6Nt7guLVX4i9fepaHTqbs8ztnTTt0y5KsO+ChYUOpDXwxjMU6DWc5bQDlGtw+w8sqxJ3jNvgMINW/32P8snUC2Yl4CFxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRAo+2BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E0DC4CED6;
	Thu, 16 Jan 2025 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737028251;
	bh=AeE5w7WmpTBpW3/JySKZEm0bAFJ401NHlJiO4qsIWIg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jRAo+2BSyEOR5E1gn9+WDG4EOP/JH7nCRLvSLts3/WKxF94u1liefbQ31flOo0OiD
	 gKQtZa3t+7nNC/gvzgAtd/J6aaOBvP9ebWH3JmS8k9e0STCjLdGlWGpfqYG8XlANPJ
	 yrgZV+7Sm7zdJFT1siMlJS+8RggD6J4VLznKT09h7voFJ5MD+V9iyA9ohO6QR5pBgk
	 jlBQrItuN2VWPiRo2Kt7Exsbpobe+5aCnYFeyGPd2VvsQ7nvdsVPj5CAIWjRPIFJ+P
	 7ueCnJGgUV3ivUm4oyikj2FbXt8llHpoVWO9JgARycwZSd0FDxR/3dtu8vN0wrvBD/
	 PHIrdGKxU8WbA==
Message-ID: <d44b8886de16ef0455b8f0e7df34f089c0fab288.camel@kernel.org>
Subject: Re: [nfs-utils PATCH] nfsdctl: debug logging fixups
From: Jeff Layton <jlayton@kernel.org>
To: Steve Dickson <steved@redhat.com>, Scott Mayhew <smayhew@redhat.com>
Cc: yoyang@redhat.com, linux-nfs@vger.kernel.org
Date: Thu, 16 Jan 2025 06:50:49 -0500
In-Reply-To: <45246f77-40ce-43c7-bdbf-c8cb2b4dea68@redhat.com>
References: <0068c0d811976aca15818b60192a96ca017893f8.camel@kernel.org>
	 <20250115170051.8947-1-smayhew@redhat.com>
	 <590522bf-77f6-4e31-a2fb-5613f68c87da@redhat.com>
	 <d38c1f357704e0b1a5b1ec47d3a84d47f8976d80.camel@kernel.org>
	 <00fd29bc-205a-4c02-8c98-3c3876a2d0a7@redhat.com>
	 <a3b6842838d9d32c93879ddf803a1f1cd37fb370.camel@kernel.org>
	 <45246f77-40ce-43c7-bdbf-c8cb2b4dea68@redhat.com>
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

On Wed, 2025-01-15 at 15:53 -0500, Steve Dickson wrote:
>=20
> On 1/15/25 1:33 PM, Jeff Layton wrote:
> > On Wed, 2025-01-15 at 12:47 -0500, Steve Dickson wrote:
> > >=20
> > > On 1/15/25 12:35 PM, Jeff Layton wrote:
> > > > On Wed, 2025-01-15 at 12:32 -0500, Steve Dickson wrote:
> > > > >=20
> > > > > On 1/15/25 12:00 PM, Scott Mayhew wrote:
> > > > > > Move read_nfsd_conf() out of autostart_func() and into main(). =
 Remove
> > > > > > hard-coded NFSD_FAMILY_NAME in the first error message in
> > > > > > netlink_msg_alloc() and make the error messages in netlink_msg_=
alloc()
> > > > > > more descriptive/unique.
> > > > > >=20
> > > > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > > > ---
> > > > > > SteveD - this would go on top of Jeff's "nfsdctl: add support f=
or new
> > > > > > lockd configuration interface" patches.
> > > > > Got it...
> > > > >=20
> > > > > >=20
> > > > > >     utils/nfsdctl/nfsdctl.c | 8 ++++----
> > > > > >     1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > >=20
> > > > > > diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> > > > > > index 003daba5..f81c78ae 100644
> > > > > > --- a/utils/nfsdctl/nfsdctl.c
> > > > > > +++ b/utils/nfsdctl/nfsdctl.c
> > > > > > @@ -436,7 +436,7 @@ static struct nl_msg *netlink_msg_alloc(str=
uct nl_sock *sock, const char *family
> > > > > >    =20
> > > > > >     	id =3D genl_ctrl_resolve(sock, family);
> > > > > >     	if (id < 0) {
> > > > > > -		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
> > > > > > +		xlog(L_ERROR, "failed to resolve %s generic netlink family",=
 family);
> > > > > >     		return NULL;
> > > > > >     	}
> > > > > >    =20
> > > > > > @@ -447,7 +447,7 @@ static struct nl_msg *netlink_msg_alloc(str=
uct nl_sock *sock, const char *family
> > > > > >     	}
> > > > > >    =20
> > > > > >     	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
> > > > > > -		xlog(L_ERROR, "failed to allocate netlink message");
> > > > > > +		xlog(L_ERROR, "failed to add generic netlink headers to netl=
ink message");
> > > > > >     		nlmsg_free(msg);
> > > > > >     		return NULL;
> > > > > >     	}
> > > > > > @@ -1509,8 +1509,6 @@ static int autostart_func(struct nl_sock =
*sock, int argc, char ** argv)
> > > > > >     		}
> > > > > >     	}
> > > > > >    =20
> > > > > > -	read_nfsd_conf();
> > > > > > -
> > > > > >     	grace =3D conf_get_num("nfsd", "grace-time", 0);
> > > > > >     	ret =3D lockd_configure(sock, grace);
> > > > > >     	if (ret) {
> > > > > > @@ -1728,6 +1726,8 @@ int main(int argc, char **argv)
> > > > > >     	xlog_syslog(0);
> > > > > >     	xlog_stderr(1);
> > > > > >    =20
> > > > > > +	read_nfsd_conf();
> > > > > > +
> > > > > >     	/* Parse the preliminary options */
> > > > > >     	while ((opt =3D getopt_long(argc, argv, "+hdsV", pre_optio=
ns, NULL)) !=3D -1) {
> > > > > >     		switch (opt) {
> > > > > Ok... at this point we a prettier error message
> > > > > $ nfsdctl nlm
> > > > > nfsdctl: failed to resolve lockd generic netlink family
> > > > >=20
> > > > > But the point of this argument is:
> > > > >=20
> > > > > Get information about NLM (lockd) settings in the current net
> > > > > namespace. This subcommand takes no arguments.
> > > > >=20
> > > > > How is that giving information from the running lockd?
> > > > >=20
> > > > > What am I missing??
> > > > >=20
> > > >=20
> > > > You're missing a kernel that has the required netlink interface. To
> > > > test this properly, you'll need to patch your kernel, until that pa=
tch
> > > > makes it upstream.
> > > Okay... I figured it was something like that. But doesn't make sense =
to
> > > wait until the patch is in upstream so the argument can be properly
> > > tested? Why add an argument that will always fail?
> > >=20
> >=20
> > Why can't it be properly tested? It's just a matter of running a more
> > recent kernel that has the right interfaces. That should be in linux-
> > next soon (if not already).
> I'm doing my testing on a 6.13.0-0.rc6 which will soon be
> a 6.14 kernel... its my understanding the needed kernel
> patch will be in the 6.15 kernel... Please correct me
> if that is not true.
>=20
> >=20
> > I think the question is whether we want to wait until the kernel
> > interfaces trickle out into downstream distro kernels before we ship
> > any userland support in an upstream project (nfs-utils).
> Yes! As soon as the kernel support hits the upstream kernel,
> we will be good to go. I just don't want to put a feature
> in that will fail %100 of the time.
>=20
> >=20
> > If you want to wait until it hits Fedora Rawhide kernels, then you're
> > looking at about 10-12 weeks from now. If you want to wait until it
> > makes it into a stable Fedora release kernel then we're looking at
> > about 6 months from now.
> nfsdctl is in all current Fedora stable releases, which
> is the reason I'm pushing back. I do not want to put something
> in that will make it fail. That just does not make sense to me.
>=20
> >=20
> > I'll note that that it took 6 months to get the original nfsdctl
> > patches merged because of the lag on kernel patches making it into
> > distros, and I think that was way too long.
> It took that long because there were issues with the command.
> In which I was glad to help debug some of the issues...
>=20
> New technology takes time to develop... I just think this
> is one of those cases.
>=20

Ok, your call. To be clear though, that patch is part of my solution
for this bug.

    https://issues.redhat.com/browse/RHEL-71698

If you're going to delay it for several months, then can I trouble you
to come up with a fix for it that you find acceptable?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>

