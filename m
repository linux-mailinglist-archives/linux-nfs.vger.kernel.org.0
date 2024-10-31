Return-Path: <linux-nfs+bounces-7593-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1459B79E7
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 12:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EC285489
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 11:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179219C553;
	Thu, 31 Oct 2024 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7wpw97n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0019C54E
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375001; cv=none; b=d+GP5RZibQATF4s45DARGsyPdkSsT5JmAXSB+YI1nnCwNhboDvDCcM2VPYxMbLjcf2pU6ytswk0/miHBmy/z13jxaWwlg7CIOQjo3cEwcQjVM7Fl1KvBBx0iyPHxCue9dzf+bc7SSYH5PyjRjiov87aO/igHZ2dQSLT6XXFfcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375001; c=relaxed/simple;
	bh=o5vqNloM4cH8YhSyiyrTOl5WoZYoPa+3RUDCCYlLnY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpwVhClAdZ91qnDOt70XetF8tj3/YlX4rS5htbY9lfB/MzAKKMQRNBLgVAZHPf7I6ysPpIHegOnGrxGEte/N33yEb26Ozy3dktTjhfuux0UUE5YPrHEpApe47C6WhMocsdW6xI56/NIRYE4sTmyt4+SuycoLGeJlOC4butKC2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7wpw97n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDA2C4CED2;
	Thu, 31 Oct 2024 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730374999;
	bh=o5vqNloM4cH8YhSyiyrTOl5WoZYoPa+3RUDCCYlLnY4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=E7wpw97ndBAz7IPJjGG8tkVPQaID3rEHZJVDDPklCM7MBEoL6o7la1o/JAwy/Tq+o
	 NB9PwjilEB1KcMpc31zdFcHYkAi/3ASGBNTyIjqUN+9s4d7I904SZ9I2mkMVlAnuhq
	 kwe19dgHPcQBBYxuLLWNMfiXHb+B0tUa8ertYRIhizTANpwwxIJQjO9JQNt0SlGhMD
	 QLArOeBqY9ARLGZ++QZ2i8UWc7eMs+6KrWHgFktWItelE/4N8dHj2jAkhsFDhiqNPV
	 LS/fzxekhoOJwFiiD1WIXs93Atb4Og0yGQFQ8VmdJcvyE6dQgTEu1Zzt4kZ7hRiKmK
	 c8WV1vzXASZKQ==
Message-ID: <0f27eb1d81cefcb791f26ad8619deec6df80f94b.camel@kernel.org>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for
 NFSv4 reexport
From: Jeff Layton <jlayton@kernel.org>
To: Rick Macklem <rick.macklem@gmail.com>, Chuck Lever III
	 <chuck.lever@oracle.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>, Linux NFS Mailing List
	 <linux-nfs@vger.kernel.org>
Date: Thu, 31 Oct 2024 07:43:18 -0400
In-Reply-To: <CAM5tNy5yyiE-e4gN50daU06xLjB8Z=SWrz1W9pMJ8am5vPeYCw@mail.gmail.com>
References: <20241023152940.63479-1-snitzer@kernel.org>
	 <20241023155846.63621-1-snitzer@kernel.org>
	 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
	 <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com>
	 <CAGOwBeX7xw7cPRXGO5RmLQUgzOjqr-7Bh4EhV=hONpXCAqsX-g@mail.gmail.com>
	 <91F0EACF-76BC-49EE-9340-AC60F641B8B2@oracle.com>
	 <CALXu0UcAw7xkObkVFFTi6d-F69_qrDwf9pTE+8We3k14CvywmA@mail.gmail.com>
	 <B67E796E-1539-437C-9F54-091D178E0171@oracle.com>
	 <CALXu0Uf4DfcgOqExZ8RYeHY8-fx_fzqCsqAUJogV2Dx8DMgJzQ@mail.gmail.com>
	 <2FAFA39C-09C0-4FCC-948F-B6D0518BE5B5@oracle.com>
	 <CAM5tNy5yyiE-e4gN50daU06xLjB8Z=SWrz1W9pMJ8am5vPeYCw@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41app1) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-30 at 15:48 -0700, Rick Macklem wrote:
> On Wed, Oct 30, 2024 at 10:08=E2=80=AFAM Chuck Lever III <chuck.lever@ora=
cle.com> wrote:
> >=20
> > CAUTION: This email originated from outside of the University of Guelph=
. Do not click links or open attachments unless you recognize the sender an=
d know the content is safe. If in doubt, forward suspicious emails to IThel=
p@uoguelph.ca.
> >=20
> >=20
> >=20
> >=20
> > > On Oct 30, 2024, at 12:37=E2=80=AFPM, Cedric Blancher <cedric.blanche=
r@gmail.com> wrote:
> > >=20
> > > On Wed, 30 Oct 2024 at 17:15, Chuck Lever III <chuck.lever@oracle.com=
> wrote:
> > > >=20
> > > >=20
> > > >=20
> > > > > On Oct 30, 2024, at 10:55=E2=80=AFAM, Cedric Blancher <cedric.bla=
ncher@gmail.com> wrote:
> > > > >=20
> > > > > On Tue, 29 Oct 2024 at 17:03, Chuck Lever III <chuck.lever@oracle=
.com> wrote:
> > > > > >=20
> > > > > > > On Oct 29, 2024, at 11:54=E2=80=AFAM, Brian Cowan <brian.cowa=
n@hcl-software.com> wrote:
> > > > > > >=20
> > > > > > > Honestly, I don't know the usecase for re-exporting another s=
erver's
> > > > > > > NFS export in the first place. Is this someone trying to shar=
e NFS
> > > > > > > through a firewall? I've seen people share remote NFS exports=
 via
> > > > > > > Samba in an attempt to avoid paying their NAS vendor for SMB =
support.
> > > > > > > (I think it's "standard equipment" now, but 10+ years ago? No=
t
> > > > > > > always...) But re-exporting another server's NFS exports? Hav=
en't seen
> > > > > > > anyone do that in a while.
> > > > > >=20
> > > > > > The "re-export" case is where there is a central repository
> > > > > > of data and branch offices that access that via a WAN. The
> > > > > > re-export servers cache some of that data locally so that
> > > > > > local clients have a fast persistent cache nearby.
> > > > > >=20
> > > > > > This is also effective in cases where a small cluster of
> > > > > > clients want fast access to a pile of data that is
> > > > > > significantly larger than their own caches. Say, HPC or
> > > > > > animation, where the small cluster is working on a small
> > > > > > portion of the full data set, which is stored on a central
> > > > > > server.
> > > > > >=20
> > > > > Another use case is "isolation", IT shares a filesystem to your
> > > > > department, and you need to re-export only a subset to another
> > > > > department or homeoffice. Part of such a scenario might also be p=
olicy
> > > > > related, e.g. IT shares you the full filesystem but will do NOTHI=
NG
> > > > > else, and any further compartmentalization must be done in your o=
wn
> > > > > department.
> > > > > This is the typical use case for gov NFS re-export.
> > > >=20
> > > > It's not clear to me from this description why re-export is
> > > > the right tool for this job. Please explain why ACLs are not
> > > > used in this case -- this is exactly what they are designed
> > > > to do.
> > >=20
> > > 1. IT departments want better/harder/immutable isolation than ACLs
> >=20
> > So you want MAC, and the storage administrator won't set
> > that up for you on the NFS server. NFS doesn't do MAC
> > very well if at all.
> >=20
> >=20
> > > 2. Linux NFSv4 only implements POSIX draft ACLs, not full Windows or
> > > NFSv4 ACLs. So there is no proper way to prevent ACL editing,
> > > rendering them useless in this case.
> >=20
> > Er. Linux NFSv4 stores the ACLs as POSIX draft, because
> > that's what Linux file systems can support. NFSD, via
> > NFSv4, makes these appear like NFSv4 ACLs.
> >=20
> > But I think I understand.
> >=20
> >=20
> > > There is a reason why POSIX draft ACls were abandoned - they are not
> > > fine-granted enough for real world usage outside the Linux universe.
> > > As soon as interoperability is required these things just bite you
> > > HARD.
> >=20
> > You, of course, have the ability to run some other NFS
> > server implementation that meets your security requirements
> > more fully.
> >=20
> >=20
> > > Also, just running more nfsd in parallel on the origin NFS server is
> > > not a better option - remember the debate of non-2049 ports for nfsd?
> >=20
> > I'm not sure where this is going. Do you mean the storage
> > administrator would provide NFS service on alternate
> > ports that each expose a separate set of exports?
> >=20
> > So the only option Linux has there is using containers or
> > libvirt. We've continued to privately discuss the ability
> > for NFSD to support a separate set of exports on alternate
> > ports, but it doesn't look feasible. The export management
> > infrastructure and user space tools would need to be
> > rewritten.
> >=20
> >=20
> > > > And again, clients of the re-export server need to mount it
> > > > with local_lock. Apps can still use locking in that case,
> > > > but the locks are not visible to apps on other clients. Your
> > > > description does not explain why local_lock is not
> > > > sufficient or feasible.
> > >=20
> > > Because:
> > > - it breaks applications running on more than one machine?
> >=20
> > Yes, obviously. Your description needs to mention that is
> > a requirement, since there are a lot of applications that
> > don't need locking across multiple clients.
> >=20
> >=20
> > > - it breaks use cases like NFS--->SMB bridges, because without lockin=
g
> > > the typical Windows .NET application will refuse to write to a file
> >=20
> > That's a quagmire, and I don't think we can guarantee that
> > will work. Linux NFS doesn't support "deny" modes, for
> > example.
> >=20
> >=20
> > > - it breaks even SIMPLE things like Microsoft Excel
> >=20
> > If you need SMB semantics, why not use Samba?
> >=20
> > The upshot appears to be that this usage is a stack of
> > mismatched storage protocols that work around a bunch of
> > local IT bureaucracy. I'm trying to be sympathetic, but
> > it's hard to say that /anyone/ would fully support this.
> >=20
> >=20
> > > Of course the happy echo "hello Linux-NFSv4-only world" >/nfs/file
> > > will always work.
> > >=20
> > > > > Of course no one needs the gov customers, so feel free to break l=
ocking.
> > > >=20
> > > >=20
> > > > Please have a look at the patch description again: lock
> > > > recovery does not work now, and cannot work without
> > > > changes to the protocol. Isn't that a problem for such
> > > > workloads?
> > >=20
> > > Nope, because of UPS (Uninterruptible power supply). Either everythin=
g
> > > is UP, or *everything* is DOWN. Boolean.
> >=20
> > Power outages are not the only reason lock recovery might
> > be necessary. Network partitions, re-export server
> > upgrades or reboots, etc. So I'm not hearing anythying
> > to suggest this kind of workload is not impacted by
> > the current lock recovery problems.
> >=20
> >=20
> > > > In other words, locking is already broken on NFSv4 re-export,
> > > > but the current situation can lead to silent data corruption.
> > >=20
> > > Would storing the locking information into persistent files help, ie.
> > > files which persist across nfsd server restarts?
> >=20
> > Yes, but it would make things horribly slow.
> >=20
> > And of course there would be a lot of coding involved
> > to get this to work.
> I suspect this suggestion might be a fair amount of code too
> (and I am certainly not volunteering to write it), but I will mention it.
>=20
> Another possibility would be to have the re-exporting NFSv4 server
> just pass locking ops through to the backend NFSv4 server.
> - It is roughly the inverse of what I did when I constructed a flex files
>   pNFS server. The MDS did the locking ops and any I/O ops. were
>   passed through to the DS(s). Of course, it was hoped the client
>   would use layouts and bypass the MDS for I/O.
>=20

How do you handle reclaim in this case? IOW, suppose the backend server
crashes but the reexporter stays up. How do you coordinate the grace
periods between the two so that the client can reclaim its lock on the
backend?

>=20
> >=20
> > What if we added an export option to allow the re-export
> > server to continue handling locking, but default it to
> > off (which is the safer option) ?
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

