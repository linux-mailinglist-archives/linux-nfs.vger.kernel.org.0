Return-Path: <linux-nfs+bounces-6903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4707D99225D
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 01:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0631C212C4
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 23:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D018BC16;
	Sun,  6 Oct 2024 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H1a93JSt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zx/6VsAy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H1a93JSt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zx/6VsAy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B21C6B2;
	Sun,  6 Oct 2024 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728257793; cv=none; b=e9HLXnhZbaTWGhTKm7EngVJENJJzr6l/KmcV+1uyddat+D1XjZZ4Q2sJ75DYA4i930TaXjbVQALP5vF0D+yg9OuX70PRS8KKSumRK2XO6dHEC/HX9zmPUJMW0C0B24gvAeFSS1wK7oPUg64INehIpDRe1LNbg/pAPZvELoxBu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728257793; c=relaxed/simple;
	bh=lkl/Iv1pnYEDGnjOGVOpxy+8DCxwfBTlVP95TcDD3KI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cvaqazLSyt028GsqHJ85te/yhn1A3zzv7FHFkhvCplnqJdEWGjIih2G2kD5+FkpDyexb2G9lGHhTyqwUov0yklifMQOdyi3ABmqqP3+vT0sqrMX/dkuZLHbNKPhBJhd/ceBNWC654i9NXBpDSK8BxXMHvya0uwUQS6KnIn6ybuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H1a93JSt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zx/6VsAy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H1a93JSt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zx/6VsAy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B18741F850;
	Sun,  6 Oct 2024 23:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728257785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBCDMwUUm+ErpFI9J3tWNPWcjlFguC7LAGucOzpTgtE=;
	b=H1a93JStqot5oMa9lOHwvNFfSf9nr8tWcvJdWq+W17aKsnVO/k1rLZsRotrNWZ1eKRkZtw
	Vj0MxlC8e9H6gPE2aO8GV5qqAtgKkg8urK+7fpG4sX4ZGqcp1HitD7x2qgVfFAjwIuzK/g
	iSJWGNDlSvq0cOcIrxZN0PFomJkMfeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728257785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBCDMwUUm+ErpFI9J3tWNPWcjlFguC7LAGucOzpTgtE=;
	b=Zx/6VsAygew1gGzo21WD2HYlzksY4y9xzSTQ6mQX3tyQwsUgZxSCzevxUla/sK0LiPOxS+
	+MYSjqmrnBBnNqAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H1a93JSt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Zx/6VsAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728257785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBCDMwUUm+ErpFI9J3tWNPWcjlFguC7LAGucOzpTgtE=;
	b=H1a93JStqot5oMa9lOHwvNFfSf9nr8tWcvJdWq+W17aKsnVO/k1rLZsRotrNWZ1eKRkZtw
	Vj0MxlC8e9H6gPE2aO8GV5qqAtgKkg8urK+7fpG4sX4ZGqcp1HitD7x2qgVfFAjwIuzK/g
	iSJWGNDlSvq0cOcIrxZN0PFomJkMfeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728257785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBCDMwUUm+ErpFI9J3tWNPWcjlFguC7LAGucOzpTgtE=;
	b=Zx/6VsAygew1gGzo21WD2HYlzksY4y9xzSTQ6mQX3tyQwsUgZxSCzevxUla/sK0LiPOxS+
	+MYSjqmrnBBnNqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D7F513240;
	Sun,  6 Oct 2024 23:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bPrsLPYeA2dkZwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 06 Oct 2024 23:36:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
In-reply-to: <EEC2DC14-EBE9-4F41-9BBE-47F9DDD110C7@oracle.com>
References: <>, <EEC2DC14-EBE9-4F41-9BBE-47F9DDD110C7@oracle.com>
Date: Mon, 07 Oct 2024 10:36:15 +1100
Message-id: <172825777599.1692160.7897699757454912990@noble.neil.brown.name>
X-Rspamd-Queue-Id: B18741F850
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 07 Oct 2024, Chuck Lever III wrote:
>=20
>=20
> > On Oct 6, 2024, at 6:29=E2=80=AFPM, Pali Roh=C3=A1r <pali@kernel.org> wro=
te:
> >=20
> > On Monday 07 October 2024 09:13:17 NeilBrown wrote:
> >> On Mon, 07 Oct 2024, Chuck Lever wrote:
> >>> On Fri, Sep 13, 2024 at 08:52:20AM +1000, NeilBrown wrote:
> >>>> On Fri, 13 Sep 2024, Pali Roh=C3=A1r wrote:
> >>>>> Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do not =
bypass
> >>>>> only GSS, but bypass any authentication method. This is problem speci=
ally
> >>>>> for NFS3 AUTH_NULL-only exports.
> >>>>>=20
> >>>>> The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
> >>>>> section 2.3.2, to allow mounting NFS2/3 GSS-only export without
> >>>>> authentication. So few procedures which do not expose security risk u=
sed
> >>>>> during mount time can be called also with AUTH_NONE or AUTH_SYS, to a=
llow
> >>>>> client mount operation to finish successfully.
> >>>>>=20
> >>>>> The problem with current implementation is that for AUTH_NULL-only ex=
ports,
> >>>>> the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX mou=
nt
> >>>>> attempts which confuse NFS3 clients, and make them think that AUTH_UN=
IX is
> >>>>> enabled and is working. Linux NFS3 client never switches from AUTH_UN=
IX to
> >>>>> AUTH_NONE on active mount, which makes the mount inaccessible.
> >>>>>=20
> >>>>> Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT implement=
ation
> >>>>> and really allow to bypass only exports which have some GSS auth flav=
or
> >>>>> enabled.
> >>>>>=20
> >>>>> The result would be: For AUTH_NULL-only export if client attempts to =
do
> >>>>> mount with AUTH_UNIX flavor then it will receive access errors, which
> >>>>> instruct client that AUTH_UNIX flavor is not usable and will either t=
ry
> >>>>> other auth flavor (AUTH_NULL if enabled) or fails mount procedure.
> >>>>>=20
> >>>>> This should fix problems with AUTH_NULL-only or AUTH_UNIX-only export=
s if
> >>>>> client attempts to mount it with other auth flavor (e.g. with AUTH_NU=
LL for
> >>>>> AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only export).
> >>>>=20
> >>>> The MAY_BYPASS_GSS flag currently also bypasses TLS restrictions.  With
> >>>> your change it doesn't.  I don't think we want to make that change.
> >>>=20
> >>> Neil, I'm not seeing this, I must be missing something.
> >>>=20
> >>> RPC_AUTH_TLS is used only on NULL procedures.
> >>>=20
> >>> The export's xprtsec=3D setting determines whether a TLS session must
> >>> be present to access the files on the export. If the TLS session
> >>> meets the xprtsec=3D policy, then the normal user authentication
> >>> settings apply. In other words, I don't think execution gets close
> >>> to check_nfsd_access() unless the xprtsec policy setting is met.
> >>=20
> >> check_nfsd_access() is literally the ONLY place that ->ex_xprtsec_modes
> >> is tested and that seems to be where xprtsec=3D export settings are stor=
ed.
> >>=20
> >>>=20
> >>> I'm not convinced check_nfsd_access() needs to care about
> >>> RPC_AUTH_TLS. Can you expand a little on your concern?
> >>=20
> >> Probably it doesn't care about RPC_AUTH_TLS which as you say is only
> >> used on NULL procedures when setting up the TLS connection.
> >>=20
> >> But it *does* care about NFS_XPRTSEC_MTLS etc.
> >>=20
> >> But I now see that RPC_AUTH_TLS is never reported by OP_SECINFO as an
> >> acceptable flavour, so the client cannot dynamically determine that TLS
> >> is required.
> >=20
> > Why is not RPC_AUTH_TLS announced in NFS4 OP_SECINFO? Should not NFS4
> > OP_SECINFO report all possible auth methods for particular filehandle?
>=20
> SECINFO reports user authentication flavors and pseudoflavors.
>=20
> RPC_AUTH_TLS is not a user authentication flavor, it is merely
> a query to see if the server peer supports RPC-with-TLS.
>=20
> So far the nfsv4 WG has not been able to come to consensus
> about how a server's transport layer security policies should
> be reported to clients. There does not seem to be a clean way
> to do that with existing NFSv4 protocol elements, so a
> protocol extension might be needed.

Interesting...

The distinction between RPC_AUTH_GSS_KRB5I and RPC_AUTH_GSS_KRB5P is not
about user authentication, it is about transport privacy.

And the distinction between xprtsec=3Dtls and xprtsec=3Dmtls seems to be
precisely about user authentication.

I would describe the current pseudo flavours as not "a clean way" to
advise the client of security requirements, but they are at least
established practice.

RPC_AUTH_SYS_TLS  seems to me to be an obvious sort of pseudo flavour.

But I suspect all these arguments and more have already been discussed
within the working group and people can sensibly have different
opinions.

Thanks for helping me understand NFS/TLS a bit better.

NeilBrown



>=20
>=20
> >> So there is no value in giving non-tls clients access to
> >> xprtsec=3Dmtls exports so they can discover that for themselves.  The
> >> client needs to explicitly mount with tls, or possibly the client can
> >> opportunistically try TLS in every case, and call back.
> >>=20
> >> So the original patch is OK.
> >>=20
> >> NeilBrown
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20


