Return-Path: <linux-nfs+bounces-16092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B204CC37BBF
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 21:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569E918C5052
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 20:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F30337B9D;
	Wed,  5 Nov 2025 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtWhSZrr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C634A790
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374720; cv=none; b=roslFlK80M73Sm/pYdZU8wlu0D4CiX1BN349WsHLQAcbXewR9hYcSuAB0brOZCcGYHC94w+cma1FPs9eAS57UuZXtvnht19FgIbRDwGECx83yrqPEUC7SIy276tKt+K54zS0hp3vyBqOhL5Ti+BEelayCO04Ym0lLc+bannGBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374720; c=relaxed/simple;
	bh=VgFfwipGc5WPqeq9ftmpxnpOY1z1a2MgJ842/OHDC4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTQcPbKvirJO4DnDiMUCGIw8d0dBrdrrqV8urgCvrCdNUH8SdAwJ1p9BqjsI+TM/eabWPN0X/TAq/dMgY7P8ruCK7ZcGqq5HerZYKviHL03m5MGikouef7EW5uT0Oai6tmvhv2Ew26KmGA2UCBRQmVNnQLGayHNzsV/pkZOWV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtWhSZrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960B7C4CEF5;
	Wed,  5 Nov 2025 20:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374719;
	bh=VgFfwipGc5WPqeq9ftmpxnpOY1z1a2MgJ842/OHDC4o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YtWhSZrr5eqMySwNo4Zol8OaIcktPTUUdn4DVXu0h+Cl+3V4qfNR6sm/iDgBghtfc
	 NLwtlMP0q2FFbPwqTZCAsW4Y+KQccUALWOGtOz/dk5xUTqBZ8YtYRvIKGTrTuYlxe2
	 n9LA/vbWuDtXPgGAtxs5F85BzXhyBH/YZXWJFyGO2DDgXWfeTrOUBRN2N9vqiBvh47
	 qBDkHNcnsnWcSNFMpHciWy+2U5TZD0s3gDhAc+E++19sXXbwMzkLmXxxwv4QPQNwCC
	 sHVj/lakqQiLVzY47jJMwW0EfyXrtmNoMRWoYILTzo1ymY1Be5DR522UWVYk6sbjmW
	 wV38t1hI9DqAA==
Message-ID: <c1e50faa0d4e52d9bf3f416a082d1a878272a514.camel@kernel.org>
Subject: Re: [nfsv4] Re: [NFS-Ganesha-Devel] Clarification on delegation
 behavior for same-client conflicting OPEN
From: Trond Myklebust <trondmy@kernel.org>
To: Rick Macklem <rick.macklem@gmail.com>, Jeff Layton
 <jlayton@poochiereds.net>
Cc: Suhas Athani <Suhas.Athani@ibm.com>, "devel@lists.nfs-ganesha.org"	
 <devel@lists.nfs-ganesha.org>, "linux-nfs@vger.kernel.org"	
 <linux-nfs@vger.kernel.org>, "nfsv4@ietf.org" <nfsv4@ietf.org>, Kaleb
 KEITHLEY	 <kkeithle@ibm.com>, Frank Filz <ffilz@ibm.com>, Rajesh Prasad	
 <Rajesh.Prasad3@ibm.com>
Date: Wed, 05 Nov 2025 15:31:59 -0500
In-Reply-To: <CAM5tNy7oO32h1pW+Gcyno65WRGUR5tAVwsFF+f4WRBqBKG9ZxQ@mail.gmail.com>
References: 
	<DM4PR15MB62545DA30C0BB065DE454D9E9AFBA@DM4PR15MB6254.namprd15.prod.outlook.com>
	 <b1451224bfa93fc8a6f94e4da2fe327fe366cd0f.camel@poochiereds.net>
	 <CAM5tNy7oO32h1pW+Gcyno65WRGUR5tAVwsFF+f4WRBqBKG9ZxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 12:18 -0800, Rick Macklem wrote:
> On Fri, Oct 31, 2025 at 7:29=E2=80=AFAM Jeff Layton <jlayton@poochiereds.=
net>
> wrote:
> >=20
> > On Thu, 2025-10-30 at 17:35 +0000, Suhas Athani via Devel wrote:
> > >=20
> > > Hello NFS community,
> > >=20
> > > We=E2=80=99re seeking clarification on server behavior for OPEN
> > > delegations when the same client issues a potentially conflicting
> > > OPEN on a file for which it already holds a delegation.
> > >=20
> > > Context and RFC references
> > >=20
> > > =C2=A0*
> > > =C2=A0=C2=A0 RFC 8881(10.4 Open Delegation)
> > > =C2=A0=C2=A0=C2=A0 -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=80=9CThere must be no current OPEN=
 conflicting with the
> > > requested delegation.=E2=80=9D
> > > =C2=A0=C2=A0=C2=A0 -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=80=9CThere should be no current de=
legation that conflicts with
> > > the delegation being requested.=E2=80=9D
> > >=20
> > > =C2=A0*
> > > =C2=A0=C2=A0 RFC 8881(10.4.1 Open Delegation and Data Caching)
> > > =C2=A0=C2=A0=C2=A0 -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For delegation handling, READs/WRITEs =
without OPEN are
> > > treated as the functional equivalents of a corresponding type of
> > > OPEN, and the server =E2=80=9Ccan use the client ID associated with t=
he
> > > current session to determine if the operation has been done by
> > > the holder of the delegation (in which case, no recall is
> > > necessary) or by another client (in which case, the delegation
> > > must be recalled and I/O not proceed until the delegation is
> > > returned or revoked).=E2=80=9D
> > >=20
> > > =C2=A0*
> > > =C2=A0=C2=A0 Historical reference: RFC 5661 (obsoleted by RFC 8881) c=
arries
> > > the same sections 10.4 and 10.4.1
> > > Questions
> > > 1) Same-client conflicting OPEN:
> > >=20
> > > =C2=A0*
> > > =C2=A0=C2=A0 If a client holds an OPEN_DELEGATE_READ on a file and th=
en the
> > > same client issues an OPEN that requires write access (or
> > > otherwise conflicts), should the server:
> > > =C2=A0*
> > >=20
> > >=20
> > >=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0 -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Allow the OPEN to complete immediately=
 without recalling
> > > the delegation (i.e., no recall necessary for same-client), per
> > > RFC 8881 10.4.1; or
> > >=20
> > > =C2=A0*
> > > =C2=A0=C2=A0 Recall the delegation anyway and delay the operation unt=
il
> > > DELEGRETURN?
> The only thing I'll add to what Jeff said is.. for the case of
> CLAIM_DELEGATE_CUR
> or CLAIM_DELEG_CUR_FH you do not want to recall and wait for a
> DELEGRETURN,
> since these Opens need to be done before the client can DELEGRETURN.
>=20
> Also, a client is being dumb if it does any Opens on the FH other
> than the
> above 2 Claim types while it holds a Write delegation. However, I
> don't
> the the RFC forbids it, so I'd say just do it. (A Write delegation
> allows
> Reading/Writing, opening for any acces/deny case locally in the
> client.
> The server recalls the write delegation when another client requests
> any
> Open for the FH.

RFC8881 strongly encourages clients to send OPENs in parallel. If you
want to build servers that don't support doing so, then that is of
course your right...

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

