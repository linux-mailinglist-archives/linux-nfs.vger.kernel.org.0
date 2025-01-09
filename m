Return-Path: <linux-nfs+bounces-9039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC9A08171
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 21:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E6D3A90AD
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5711FF7D4;
	Thu,  9 Jan 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZrHTAO7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B422F43
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455172; cv=none; b=HYKWk1pyTDRkMiYVK7qNXrUfAYYZtJ4V1PmIQSvjPNssNQ+ayTKNWkHC4JFeUeLpuc8QiI0uyvzx33JVYjGI6Nxox2BtVrqcsTwFMKolZz9iGqIAtLjkmlJX6+XxBL49mAR3Thj0re+JZwJ6Clfm15r4lHh5oJv3zZb8Dusjarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455172; c=relaxed/simple;
	bh=8pCaiINX/OSYGt96dSdbCjV0DvZ6Ud2+zcdhBawlcLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d9aJK7LN0lnrx1rfMrjpLImL6wjyPG8D/X2DY+MG9oNV+VboQh/ct2LjjSXab0FdA6b2ITWSycL2xYlMCOZPuK4AEdnGWWjZFHqmF1sm7bImD5zATUOMHAIcsCYTPDl/Xd1akV7hYEKmhrXlbBoZDLns1uf0MBRftRcPMK+M1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZrHTAO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626A0C4CEE5;
	Thu,  9 Jan 2025 20:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736455171;
	bh=8pCaiINX/OSYGt96dSdbCjV0DvZ6Ud2+zcdhBawlcLo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gZrHTAO7D49rAQstqbQ9oiItZFK1Qfp3FVKGPBRgn3Iwh9qBjNLPaiCO1jrXjWSQH
	 720khVsQpdpoF8pSEggZIU0dlUnOdsyZ5QA4tB9lJiw/4ksJIwMR+50AFUfyceikVw
	 xPa34OICqOIdXKrh3D87WbjS/TunoU0tD06HdMYIRxEVM+IGjHzmP+a4paQdd5tXVh
	 MpFG3o+lj8MPXyp0ot96IHxm3/R/0bdxvQGQ7WbZcg0g5ZVktowaNtyZz33F9LyN0T
	 vH92Df6RkVgFmSUfwqJ6OiTECsWEkepRyugK9UdzYAWQYIrUiqS7jD+FLOzlw22ker
	 EhCLeSen9H/DA==
Message-ID: <de074aa01c4a209ba66884d42e1545eb12f3770b.camel@kernel.org>
Subject: Re: [PATCH 1/3] nfsdctl: convert to xlog()
From: Jeff Layton <jlayton@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>
Cc: Steve Dickson <steved@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
	linux-nfs@vger.kernel.org
Date: Thu, 09 Jan 2025 15:39:30 -0500
In-Reply-To: <Z4Axui-NRCuI0Epi@aion>
References: <20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org>
	 <20250109-lockd-nl-v1-1-108548ab0b6b@kernel.org> <Z4Axui-NRCuI0Epi@aion>
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

On Thu, 2025-01-09 at 15:29 -0500, Scott Mayhew wrote:
> On Thu, 09 Jan 2025, Jeff Layton wrote:
>=20
> > Convert all of the fprintf(stderr, ...) calls to xlog(L_ERROR, ...)
> > calls.  Change the -d option to not take an argument, and add a -s
> > option that will make nfsdctl log to syslog instead of stderr.
>=20
> I think there should be few xlog(D_GENERAL) calls, otherwise we'll wind
> up getting bug reports from users saying they turned on debug logging
> and they're not getting any output.  I was working on a similar patch,
> with before each of the nl_send_auto() calls.
>=20
> xlog(D_GENERAL, "%s: sending netlink message", __func__);
>=20
> Even a single "nfsdctl started" log message would be better than
> nothing.
>=20

Good point. The autostart one, in particular probably needs something.

> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  utils/nfsdctl/nfsdctl.adoc |   3 ++
> >  utils/nfsdctl/nfsdctl.c    | 103 ++++++++++++++++++++++++-------------=
--------
> >  2 files changed, 59 insertions(+), 47 deletions(-)
> >=20
> > diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> > index c5921458a8e81e749d264cc7dd8344889ec71ac5..2114693042594297b7c5d86=
00ca16813a0f2356c 100644
> > --- a/utils/nfsdctl/nfsdctl.adoc
> > +++ b/utils/nfsdctl/nfsdctl.adoc
> > @@ -30,6 +30,9 @@ To get information about different subcommand usage, =
pass the subcommand the
> >  *-h, --help*::
> >    Print program help text
> > =20
> > +*-s, --syslog*::
> > +  Log to syslog instead of to stderr (the default)
> > +
> >  *-V, --version*::
> >    Print program version
> > =20
>=20
> You updated the adoc file but didn't regenerate the man page.
>=20

Yeah, forgot to git add it. I'll include it in the next version.

> > diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> > index b138f06d8b5504e4bf0362041ba36a68aeb12508..11fa4363907a0897ddf79f2=
1916f9e25b9e88dbb 100644
> > --- a/utils/nfsdctl/nfsdctl.c
> > +++ b/utils/nfsdctl/nfsdctl.c
> > @@ -45,8 +45,6 @@
> >   * gcc -I/usr/include/libnl3/ -o <prog-name> <prog-name>.c -lnl-3 -lnl=
-genl-3
> >   */
> > =20
> > -static int debug_level;
> > -
> >  struct nfs_version {
> >  	uint8_t	major;
> >  	uint8_t	minor;
> > @@ -390,7 +388,7 @@ static struct nl_sock *netlink_sock_alloc(void)
> >  		return NULL;
> > =20
> >  	if (genl_connect(sock)) {
> > -		fprintf(stderr, "Failed to connect to generic netlink\n");
> > +		xlog(L_ERROR, "Failed to connect to generic netlink");
> >  		nl_socket_free(sock);
> >  		return NULL;
> >  	}
> > @@ -409,18 +407,18 @@ static struct nl_msg *netlink_msg_alloc(struct nl=
_sock *sock)
> > =20
> >  	id =3D genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
> >  	if (id < 0) {
> > -		fprintf(stderr, "%s not found\n", NFSD_FAMILY_NAME);
> > +		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
> >  		return NULL;
> >  	}
> > =20
> >  	msg =3D nlmsg_alloc();
> >  	if (!msg) {
> > -		fprintf(stderr, "failed to allocate netlink message\n");
> > +		xlog(L_ERROR, "failed to allocate netlink message");
> >  		return NULL;
> >  	}
> > =20
> >  	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
> > -		fprintf(stderr, "failed to allocate netlink message\n");
> > +		xlog(L_ERROR, "failed to allocate netlink message");
> >  		nlmsg_free(msg);
> >  		return NULL;
> >  	}
> > @@ -462,7 +460,7 @@ static int status_func(struct nl_sock *sock, int ar=
gc, char ** argv)
> > =20
> >  	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> >  	if (!cb) {
> > -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> > +		xlog(L_ERROR, "failed to allocate netlink callbacks");
> >  		ret =3D 1;
> >  		goto out;
> >  	}
> > @@ -480,7 +478,7 @@ static int status_func(struct nl_sock *sock, int ar=
gc, char ** argv)
> >  	while (ret > 0)
> >  		nl_recvmsgs(sock, cb);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> > +		xlog(L_ERROR, "Error: %s", strerror(-ret));
> >  		ret =3D 1;
> >  	}
> >  out_cb:
> > @@ -521,14 +519,14 @@ static int threads_doit(struct nl_sock *sock, int=
 cmd, int grace, int lease,
> > =20
> >  	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> >  	if (!cb) {
> > -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> > +		xlog(L_ERROR, "failed to allocate netlink callbacks");
> >  		ret =3D 1;
> >  		goto out;
> >  	}
> > =20
> >  	ret =3D nl_send_auto(sock, msg);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "send failed (%d)!\n", ret);
> > +		xlog(L_ERROR, "send failed (%d)!", ret);
> >  		goto out_cb;
> >  	}
> > =20
> > @@ -541,7 +539,7 @@ static int threads_doit(struct nl_sock *sock, int c=
md, int grace, int lease,
> >  	while (ret > 0)
> >  		nl_recvmsgs(sock, cb);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> > +		xlog(L_ERROR, "Error: %s", strerror(-ret));
> >  		ret =3D 1;
> >  	}
> >  out_cb:
> > @@ -586,13 +584,13 @@ static int threads_func(struct nl_sock *sock, int=
 argc, char **argv)
> > =20
> >  			/* empty string? */
> >  			if (targv[i][0] =3D=3D '\0') {
> > -				fprintf(stderr, "Invalid threads value %s.\n", targv[i]);
> > +				xlog(L_ERROR, "Invalid threads value %s.", targv[i]);
> >  				return 1;
> >  			}
> > =20
> >  			pool_threads[i] =3D strtol(targv[i], &endptr, 0);
> >  			if (!endptr || *endptr !=3D '\0') {
> > -				fprintf(stderr, "Invalid threads value %s.\n", argv[1]);
> > +				xlog(L_ERROR, "Invalid threads value %s.", argv[1]);
> >  				return 1;
> >  			}
> >  		}
> > @@ -621,14 +619,14 @@ static int fetch_nfsd_versions(struct nl_sock *so=
ck)
> > =20
> >  	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> >  	if (!cb) {
> > -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> > +		xlog(L_ERROR, "failed to allocate netlink callbacks");
> >  		ret =3D 1;
> >  		goto out;
> >  	}
> > =20
> >  	ret =3D nl_send_auto(sock, msg);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "send failed: %d\n", ret);
> > +		xlog(L_ERROR, "send failed: %d", ret);
> >  		goto out_cb;
> >  	}
> > =20
> > @@ -641,7 +639,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock=
)
> >  	while (ret > 0)
> >  		nl_recvmsgs(sock, cb);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> > +		xlog(L_ERROR, "Error: %s", strerror(-ret));
> >  		ret =3D 1;
> >  	}
> >  out_cb:
> > @@ -690,7 +688,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
> > =20
> >  		a =3D nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_PROTO_VERSION=
);
> >  		if (!a) {
> > -			fprintf(stderr, "Unable to allocate version nest!\n");
> > +			xlog(L_ERROR, "Unable to allocate version nest!");
> >  			ret =3D 1;
> >  			goto out;
> >  		}
> > @@ -707,14 +705,14 @@ static int set_nfsd_versions(struct nl_sock *sock=
)
> > =20
> >  	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> >  	if (!cb) {
> > -		fprintf(stderr, "Failed to allocate netlink callbacks\n");
> > +		xlog(L_ERROR, "Failed to allocate netlink callbacks");
> >  		ret =3D 1;
> >  		goto out;
> >  	}
> > =20
> >  	ret =3D nl_send_auto(sock, msg);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "Send failed: %d\n", ret);
> > +		xlog(L_ERROR, "Send failed: %d", ret);
> >  		goto out_cb;
> >  	}
> > =20
> > @@ -727,7 +725,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
> >  	while (ret > 0)
> >  		nl_recvmsgs(sock, cb);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> > +		xlog(L_ERROR, "Error: %s", strerror(-ret));
> >  		ret =3D 1;
> >  	}
> >  out_cb:
> > @@ -752,7 +750,7 @@ static int update_nfsd_version(int major, int minor=
, bool enabled)
> >  	/* the kernel doesn't support this version */
> >  	if (!enabled)
> >  		return 0;
> > -	fprintf(stderr, "This kernel does not support NFS version %d.%d\n", m=
ajor, minor);
> > +	xlog(L_ERROR, "This kernel does not support NFS version %d.%d", major=
, minor);
> >  	return -EINVAL;
> >  }
> > =20
> > @@ -794,7 +792,7 @@ static int version_func(struct nl_sock *sock, int a=
rgc, char ** argv)
> > =20
> >  			ret =3D sscanf(str, "%c%d.%d\n", &sign, &major, &minor);
> >  			if (ret < 2) {
> > -				fprintf(stderr, "Invalid version string (%d) %s\n", ret, str);
> > +				xlog(L_ERROR, "Invalid version string (%d) %s", ret, str);
> >  				return -EINVAL;
> >  			}
> > =20
> > @@ -806,7 +804,7 @@ static int version_func(struct nl_sock *sock, int a=
rgc, char ** argv)
> >  				enabled =3D false;
> >  				break;
> >  			default:
> > -				fprintf(stderr, "Invalid version string %s\n", str);
> > +				xlog(L_ERROR, "Invalid version string %s", str);
> >  				return -EINVAL;
> >  			}
> > =20
> > @@ -839,14 +837,14 @@ static int fetch_current_listeners(struct nl_sock=
 *sock)
> > =20
> >  	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> >  	if (!cb) {
> > -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> > +		xlog(L_ERROR, "failed to allocate netlink callbacks");
> >  		ret =3D 1;
> >  		goto out;
> >  	}
> > =20
> >  	ret =3D nl_send_auto(sock, msg);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "send failed: %d\n", ret);
> > +		xlog(L_ERROR, "send failed: %d", ret);
> >  		goto out_cb;
> >  	}
> > =20
> > @@ -859,7 +857,7 @@ static int fetch_current_listeners(struct nl_sock *=
sock)
> >  	while (ret > 0)
> >  		nl_recvmsgs(sock, cb);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> > +		xlog(L_ERROR, "Error: %s", strerror(-ret));
> >  		ret =3D 1;
> >  	}
> >  out_cb:
> > @@ -994,7 +992,7 @@ static int update_listeners(const char *str)
> >  	 */
> >  	ret =3D getaddrinfo(addr, port, &hints, &res);
> >  	if (ret) {
> > -		fprintf(stderr, "getaddrinfo of \"%s\" failed: %s\n",
> > +		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s",
> >  			addr, gai_strerror(ret));
> >  		return -EINVAL;
> >  	}
> > @@ -1046,7 +1044,7 @@ static int update_listeners(const char *str)
> >  	}
> >  	return 0;
> >  out_inval:
> > -	fprintf(stderr, "Invalid listener update string: %s", str);
> > +	xlog(L_ERROR, "Invalid listener update string: %s", str);
> >  	return -EINVAL;
> >  }
> > =20
> > @@ -1076,7 +1074,7 @@ static int set_listeners(struct nl_sock *sock)
> > =20
> >  		a =3D nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_SOCK_ADDR);
> >  		if (!a) {
> > -			fprintf(stderr, "Unable to allocate listener nest!\n");
> > +			xlog(L_ERROR, "Unable to allocate listener nest!");
> >  			ret =3D 1;
> >  			goto out;
> >  		}
> > @@ -1091,14 +1089,14 @@ static int set_listeners(struct nl_sock *sock)
> > =20
> >  	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> >  	if (!cb) {
> > -		fprintf(stderr, "Failed to allocate netlink callbacks\n");
> > +		xlog(L_ERROR, "Failed to allocate netlink callbacks");
> >  		ret =3D 1;
> >  		goto out;
> >  	}
> > =20
> >  	ret =3D nl_send_auto(sock, msg);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "Send failed: %d\n", ret);
> > +		xlog(L_ERROR, "Send failed: %d", ret);
> >  		goto out_cb;
> >  	}
> > =20
> > @@ -1111,7 +1109,7 @@ static int set_listeners(struct nl_sock *sock)
> >  	while (ret > 0)
> >  		nl_recvmsgs(sock, cb);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> > +		xlog(L_ERROR, "Error: %s", strerror(-ret));
> >  		ret =3D 1;
> >  	}
> >  out_cb:
> > @@ -1188,14 +1186,14 @@ static int pool_mode_doit(struct nl_sock *sock,=
 int cmd, const char *pool_mode)
> > =20
> >  	cb =3D nl_cb_alloc(NL_CB_CUSTOM);
> >  	if (!cb) {
> > -		fprintf(stderr, "failed to allocate netlink callbacks\n");
> > +		xlog(L_ERROR, "failed to allocate netlink callbacks");
> >  		ret =3D 1;
> >  		goto out;
> >  	}
> > =20
> >  	ret =3D nl_send_auto(sock, msg);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "send failed (%d)!\n", ret);
> > +		xlog(L_ERROR, "send failed (%d)!", ret);
> >  		goto out_cb;
> >  	}
> > =20
> > @@ -1208,7 +1206,7 @@ static int pool_mode_doit(struct nl_sock *sock, i=
nt cmd, const char *pool_mode)
> >  	while (ret > 0)
> >  		nl_recvmsgs(sock, cb);
> >  	if (ret < 0) {
> > -		fprintf(stderr, "Error: %s\n", strerror(-ret));
> > +		xlog(L_ERROR, "Error: %s", strerror(-ret));
> >  		ret =3D 1;
> >  	}
> >  out_cb:
> > @@ -1245,7 +1243,7 @@ static int pool_mode_func(struct nl_sock *sock, i=
nt argc, char **argv)
> > =20
> >  		/* empty string? */
> >  		if (*targv[0] =3D=3D '\0') {
> > -			fprintf(stderr, "Invalid threads value %s.\n", targv[0]);
> > +			xlog(L_ERROR, "Invalid threads value %s.", targv[0]);
> >  			return 1;
> >  		}
> >  		pool_mode =3D targv[0];
> > @@ -1397,7 +1395,7 @@ static int autostart_func(struct nl_sock *sock, i=
nt argc, char ** argv)
> > =20
> >  			threads[idx++] =3D strtol(n->field, &endptr, 0);
> >  			if (!endptr || *endptr !=3D '\0') {
> > -				fprintf(stderr, "Invalid threads value %s.\n", n->field);
> > +				xlog(L_ERROR, "Invalid threads value %s.", n->field);
> >  				ret =3D -EINVAL;
> >  				goto out;
> >  			}
> > @@ -1470,7 +1468,8 @@ static void usage(void)
>=20
> You missed some other changes in the usage() function (some boilerplate
> stuff in the printf's).
>=20
> -Scott
> >  /* Options given before the command string */
> >  static const struct option pre_options[] =3D {
> >  	{ "help", no_argument, NULL, 'h' },
> > -	{ "debug", required_argument, NULL, 'd' },
> > +	{ "debug", no_argument, NULL, 'd' },
> > +	{ "syslog", no_argument, NULL, 's' },
> >  	{ "version", no_argument, NULL, 'V' },
> >  	{ },
> >  };
> > @@ -1524,7 +1523,7 @@ static int run_commandline(struct nl_sock *sock)
> >  		if (!ret)
> >  			ret =3D run_one_command(sock, argc, argv);
> >  		if (ret)
> > -			fprintf(stderr, "Error: %s\n", strerror(ret));
> > +			xlog(L_ERROR, "Error: %s", strerror(ret));
> >  		free(line);
> >  	}
> >  	return 0;
> > @@ -1533,23 +1532,25 @@ static int run_commandline(struct nl_sock *sock=
)
> >  int main(int argc, char **argv)
> >  {
> >  	int opt, ret;
> > -	struct nl_sock *sock =3D netlink_sock_alloc();
> > -
> > -	if (!sock) {
> > -		fprintf(stderr, "Unable to allocate netlink socket!");
> > -		return 1;
> > -	}
> > +	struct nl_sock *sock;
> > =20
> >  	taskname =3D argv[0];
> > =20
> > +	xlog_syslog(0);
> > +	xlog_stderr(1);
> > +
> >  	/* Parse the preliminary options */
> > -	while ((opt =3D getopt_long(argc, argv, "+hd:V", pre_options, NULL)) =
!=3D -1) {
> > +	while ((opt =3D getopt_long(argc, argv, "+hdsV", pre_options, NULL)) =
!=3D -1) {
> >  		switch (opt) {
> >  		case 'h':
> >  			usage();
> >  			return 0;
> >  		case 'd':
> > -			debug_level =3D atoi(optarg);
> > +			xlog_config(D_ALL, 1);
> > +			break;
> > +		case 's':
> > +			xlog_syslog(1);
> > +			xlog_stderr(0);
> >  			break;
> >  		case 'V':
> >  			// FIXME: print_version();
> > @@ -1557,6 +1558,14 @@ int main(int argc, char **argv)
> >  		}
> >  	}
> > =20
> > +	xlog_open(basename(argv[0]));
> > +
> > +	sock =3D netlink_sock_alloc();
> > +	if (!sock) {
> > +		xlog(L_ERROR, "Unable to allocate netlink socket!");
> > +		return 1;
> > +	}
> > +
> >  	if (optind > argc) {
> >  		usage();
> >  		return 1;
> >=20
> > --=20
> > 2.47.1
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

