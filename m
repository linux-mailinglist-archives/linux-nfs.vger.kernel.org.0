Return-Path: <linux-nfs+bounces-20336-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G//ESWewWmFUAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20336-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 21:10:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBB92FCECE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 21:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C29A1304117F
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3884536998B;
	Mon, 23 Mar 2026 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvolYivQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CA39A7FB
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296487; cv=none; b=MGbPJQgkhHUdoMnd+1FH6pFdZFv4E8E7wrdQP2QT6hoMtU8th2+ToNjxiiDkxQ4ZfNeFvgV3YO3li3RP21svLs6xK5wo/HVM4XsyVv3UJXhfWx260iyZduI35LcBPfVWXtQ+Bripcppm5dLHmDYtwgZZRJ30GT3VjTQJKMmA6II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296487; c=relaxed/simple;
	bh=8bDHM55eYb5EpXeSFqK+swbFyF3Z2jonbgr15yJK1FU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ojyuc+ls0y/siNxXyyXpkEukotj7vapAIyD2LCDLE7bvRz0NBY6rFsw56AsQn5dkZYMj9j4v10/UuVN79+HyJLr/6EZ6LKa8iawyBLF3e3pRtpCFfMW1+Glaf7iLQaxvsqAD2x1gt3THEr0wt3SIoOPK58xvr3wb+cuHbB192HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvolYivQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9261BC4CEF7;
	Mon, 23 Mar 2026 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774296487;
	bh=8bDHM55eYb5EpXeSFqK+swbFyF3Z2jonbgr15yJK1FU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nvolYivQGqv3og1Kh8kM/8nSOtS/RyXy8rRcDXYpGNtv6B7BnkfKYJEaxq+nha7mk
	 +/yVplzbNvGuLHpWGGp51t0PTOt8eEshOEDngn+PL3fmqt2FwlhJYDLeljYBpRaXn4
	 iCCwHOgiec6igQ5GO1Dy/AeVW/fYN4SA3gdzdB9NmkeavVwNA7AUA5xyIFNFN8DGZx
	 WtwSlQFtBCAb5pGymSLkojJd1HSZ9uun0Pj44NfdBca6iWpQm6PH6OLnJRZ2P4pT6x
	 krTZAUIlWvsPgqHmlwKqWitw+Qlcog6mapqqNG62PebufiIdUCWrPZbQP/ltGmtpmw
	 cC36u4tQcNWkw==
Message-ID: <b81829af10a86c9d201ddde31c25d523865b781a.camel@kernel.org>
Subject: Re: [PATCH 1/1] nfsdctl: check for listeners before starting threads
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, steved@redhat.com, 
	linux-nfs@vger.kernel.org
Date: Mon, 23 Mar 2026 16:08:04 -0400
In-Reply-To: <CAN-5tyEQe5KrqKNy_HtMfciyrKsxLm8Xu=ugUEBpH+gtf7OYGw@mail.gmail.com>
References: <20260323182142.79465-1-okorniev@redhat.com>
	 <24a15058d09d238ab627a6359ca9241e6aa499ce.camel@kernel.org>
	 <CAN-5tyEQe5KrqKNy_HtMfciyrKsxLm8Xu=ugUEBpH+gtf7OYGw@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20336-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEBB92FCECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 15:57 -0400, Olga Kornievskaia wrote:
> On Mon, Mar 23, 2026 at 2:52=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Mon, 2026-03-23 at 14:21 -0400, Olga Kornievskaia wrote:
> > > When a thread command is executed and yet no listeners have been
> > > added prior to it, instead of failing with EIO error print an
> > > informative error. Also, "thread 0" command should not error
> > > regardless of the listener status.
> > >=20
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  utils/nfsdctl/nfsdctl.c | 52 ++++++++++++++++++++++++++++++++-------=
--
> > >  1 file changed, 41 insertions(+), 11 deletions(-)
> > >=20
> > > diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> > > index 6a20d180..d03e2c9f 100644
> > > --- a/utils/nfsdctl/nfsdctl.c
> > > +++ b/utils/nfsdctl/nfsdctl.c
> > > @@ -162,6 +162,9 @@ static const char *nfsd4_ops[] =3D {
> > >       [OP_REMOVEXATTR]        =3D "OP_REMOVEXATTR",
> > >  };
> > >=20
> > > +static int fetch_current_listeners(struct nl_sock *sock);
> > > +static int print_listeners(int output);
> > > +
> > >  static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *e=
rr,
> > >                        void *arg)
> > >  {
> > > @@ -720,7 +723,7 @@ static int threads_func(struct nl_sock *sock, int=
 argc, char **argv)
> > >       uint8_t cmd =3D NFSD_CMD_THREADS_GET;
> > >       int *pool_threads =3D NULL;
> > >       int minthreads =3D -1;
> > > -     int opt, pools =3D 0;
> > > +     int opt, pools =3D 0, zero_threads =3D 0;
> > >=20
> > >       optind =3D 1;
> > >       while ((opt =3D getopt_long(argc, argv, "hm:", threads_options,=
 NULL)) !=3D -1) {
> > > @@ -762,12 +765,31 @@ static int threads_func(struct nl_sock *sock, i=
nt argc, char **argv)
> > >                       }
> > >=20
> > >                       pool_threads[i] =3D strtol(targv[i], &endptr, 0=
);
> > > +                     if (!pool_threads[i])
> > > +                             zero_threads++;
> > >                       if (!endptr || *endptr !=3D '\0') {
> > >                               xlog(L_ERROR, "Invalid threads value %s=
.", argv[1]);
> > >                               return 1;
> > >                       }
> > >               }
> > >       }
> > > +     /* check if there are listeners added */
> > > +     if (fetch_current_listeners(sock)) {
> > > +             xlog(L_ERROR, "Unable to determine if listeners were ad=
ded\n");
> > > +             return 1;
> > > +     }
> > > +     if (!print_listeners(0)) {
> > > +             if (zero_threads && zero_threads =3D=3D pools) {
> > > +                     /* Note: we can never have a server with thread=
s and no
> > > +                      * listeners. If we ever add functionality to r=
emove
> > > +                      * listeners on an active server, we need to re=
visit this.
> > > +                      */
> > > +                     return 0;
> > > +             }
> > > +             xlog(L_ERROR, "No listeners added, not starting threads=
\n");
> > > +             return 1;
> > > +     }
> > > +
> > >       return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL,=
 minthreads);
> > >  }
> > >=20
> > > @@ -1077,9 +1099,9 @@ out:
> > >       return ret;
> > >  }
> > >=20
> > > -static void print_listeners(void)
> > > +static int print_listeners(int output)
> >=20
> > Maybe instead of adding the "output" parameter, you could just add a
> > count_listeners() function?
>=20
> Well, I thought would need to do all the work of print_listener(), I
> would assume we'd want to do all the checks done by print_listener
> before it prints the value or in my case count it as a listener. And
> thus I opted for re-using the function but adding the count.
>=20
> If you think it's sufficient to just check if sock->name is non-empty
> and active and do no further checking, I can.
>=20

The "active" flag is only used on the set side of things. Anything read
by "get" is considered active. If you fetch_current_listeners() first,
then I think you can just check that nfsd_socket_count is non-zero.
--=20
Jeff Layton <jlayton@kernel.org>

