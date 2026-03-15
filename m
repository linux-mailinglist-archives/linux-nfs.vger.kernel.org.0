Return-Path: <linux-nfs+bounces-20176-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIv0DB6YtmksEAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20176-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 12:29:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C27A290879
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 12:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD6C300F502
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F90303A1E;
	Sun, 15 Mar 2026 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhQs5LMX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591F17C220;
	Sun, 15 Mar 2026 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773574171; cv=none; b=MC5EBrlDJH3GJZwkkyPztc3hqpzu4ywfPh/+xDex4u3LMhDLlzwgKJsz59WNQzRtJ9qk0lQLnNZbfCMRdycVfIl+idgV4xO9xKgOyzlKPlPw6T8KDVlzKVUoiyMF57drqoUz3r+4l4cI1tX0JPm3ibvU+zmijMckDQUfNvrOfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773574171; c=relaxed/simple;
	bh=JiZAIMsgKWoQPTPMNeQtHx0ql9Hc/e2f4+6fhTjYDgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0nKwfGiCcwSFPHsWp7Pw6EkRwTdhLefOZVkTZ4SmQ8Y/4OyUrq96W3tvRiB+AKWSsxAh3w2e/XcPSsJ0kLEkjCljTDbpt0wBtwktqwsZW4fnZmVfKmcMSToV2uLoRFJZWrj78lxcVud1fHnjqQv8RqhFnWTs36/mLDmrluQHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhQs5LMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58755C4CEF7;
	Sun, 15 Mar 2026 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773574171;
	bh=JiZAIMsgKWoQPTPMNeQtHx0ql9Hc/e2f4+6fhTjYDgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mhQs5LMXGMN2RYNZ0SdSbcqXGOk1gLqoaJaxwXnJcxyxwaqVkSqIENn+o1tt2Flwo
	 lHvK9Kki+S9nQYSagcdZjNnSsf/c8MAbyYha4+oCCt/Asykg6SJz7oCuH1H2/aX328
	 0NffBhNaGh8p1fENVzIOx2UVIobxpSqbiSJFwdSRm0Iy18j6hcvt9zLqm1WYi5eynK
	 cLyFMeA5mOj4SVLQmdZ45Fts66Ymdv3Qgc9LGAWm2FOUMfEAwfTFew5gXUbwb6ZN3p
	 qG46itSftW7rOKLfAYzr4has4HhcyWLWS0Ob2XlSnPpVVqIaAZX6k2y8dOUpBx7a5w
	 s/TwpgFkv/iLA==
Message-ID: <73c3a6a03fbe30a4f4b05c7fe58b3dceda87c45b.camel@kernel.org>
Subject: Re: [regression] Large rsize/wsize (1MB) causes EIO after
 2b092175f5e3 ("NFS: Fix inheritance of the block sizes when automounting")
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Salvatore Bonaccorso	
 <carnil@debian.org>, Maik Nergert <maik.nergert@uni-hamburg.de>, Valentin
 SAMIR	 <valentin.samir@magellium.fr>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, 1128834@bugs.debian.org
Date: Sun, 15 Mar 2026 07:29:27 -0400
In-Reply-To: <0f9572e731939f365f6708f58b258bee89d6245a.camel@kernel.org>
References: <177349021750.3039212.10211295677877269201@eldamar.lan>
	 <0f9572e731939f365f6708f58b258bee89d6245a.camel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20176-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[phedre.fr:url]
X-Rspamd-Queue-Id: 8C27A290879
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-03-14 at 11:38 -0400, Trond Myklebust wrote:
> Hi Salvatore,
>=20
> On Sat, 2026-03-14 at 13:23 +0100, Salvatore Bonaccorso wrote:
> > Control: forwarded -1
> > https://lore.kernel.org/regressions/177349021750.3039212.10211295677877=
269201@eldamar.lan
> > Control: tags -1 + upstream
> >=20
> > Hi Trond, hi Anna
> >=20
> > In Debian we got reports of a NFS client regression where large
> > rsize/wsize (1MB) causes EIO after the commit 2b092175f5e3 ("NFS: Fix
> > inheritance of the block sizes when automounting") and its backports
> > to the stable series. The report in full is at:
> > https://bugs.debian.org/1128834
> >=20
> > Maik reported:
> > > after upgrading from Linux 6.1.158 to 6.1.162, NFS client writes
> > > fail with input/output errors (EIO).
> > >=20
> > > Environment:
> > > - Debian Bookworm
> > > - Kernel: 6.1.0-43-amd64 (6.1.162-1)
> > > - NFSv4.2 (also reproducible with 4.1)
> > > - Default mount options include rsize=3D1048576,wsize=3D1048576
> > >=20
> > > Reproducer:
> > > dd if=3D/dev/zero of=3D~/testfile bs=3D1M count=3D500
> > > or
> > > dd if=3D/dev/zero of=3D~/testfile bs=3D4k count=3D100000
> > >=20
> > > On different computers and VMs!
> > >=20
> > >=20
> > > Result:
> > > dd: closing output file: Input/output error
> > >=20
> > > Workaround:
> > > Mount with:
> > > rsize=3D65536,wsize=3D65536
> > >=20
> > > With reduced I/O size, the issue disappears completely.
> > >=20
> > > Impact:
> > > - File writes fail (file >1M)
> > > - KDE Plasma crashes due to corrupted cache/config writes
> > >=20
> > > The issue does NOT occur on kernel 6.1.0-42 (6.1.158).
> >=20
> > I was not able to reproduce the problem, and it turned out that it
> > seems to be triggerable when on NFS server side a Dell EMC (Isilion)
> > system was used. So the issue was not really considered initially as
> > beeing "our" issue.
> >=20
> > Valentin SAMIR, a second user affected, did as well report the issue
> > to Dell, and Dell seems to point at a client issue instead. Valentin
> > writes:
> >=20
> > > We are facing the same issue. Dell seems to point to a client
> > > issue:
> > > The kernel treats the max size as the nfs payload max size whereas
> > > OneFs treat the max size as the overall compound packet max size
> > > (everything related to NFS in the call). Hence when OneFS receives
> > > a
> > > call with a payload of 1M, the overall NFS packet is slightly
> > > bigger
> > > and it returns an NFS4ERR_REQ_TOO_BIG.
> > >=20
> > > So the question is: should max req size/max resp size be treated as
> > > the
> > > nfs payload max size or the whole nfs packet max size?
> >=20
> > His reply in https://bugs.debian.org/1128834#55=C2=A0contains a quote f=
rom
> > the response Valentin got from Dell, I'm full quoting it here for
> > easier followup in case needed:
> >=20
> > > I have been looking at the action plan output we captured.
> > > Specifically around when you first mounted and then repro'ed the
> > > error.
> > >=20
> > > Looking at the pcap we gathered, firstly, lets concentrate on the
> > > "create session" calls between Client / Node.
> > > Here we can these max sizes advertised - per screenshot.
> > >=20
> > >=20
> > > Frame 17: 306 bytes on wire (2448 bits), 306 bytes captured (2448
> > > bits)
> > > Ethernet II, Src: SuperMicroCo_1d:7d:b2 (ac:1f:6b:1d:7d:b2), Dst:
> > > MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a)
> > > Internet Protocol Version 4, Src: 172.22.1.132, Dst: 172.22.16.29
> > > Transmission Control Protocol, Src Port: 810, Dst Port: 2049, Seq:
> > > 613, Ack: 277, Len: 240
> > > Remote Procedure Call, Type:Call XID:0x945b7e1d
> > > Network File System, Ops(1): CREATE_SESSION
> > > =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > =C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > > =C2=A0=C2=A0=C2=A0 minorversion: 2
> > > =C2=A0=C2=A0=C2=A0 Operations (count: 1): CREATE_SESSION
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: CREATE_SESSION (43=
)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=
ientid: 0x36adef626e919bf4
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
qid: 0x00000001
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cs=
a_flags: 0x00000003, CREATE_SESSION4_FLAG_PERSIST,
> > > CREATE_SESSION4_FLAG_CONN_BACK_CHAN
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cs=
a_fore_chan_attrs
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdr pad size: 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max req size: 1049620
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size: 1049480
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size cached: 7584
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max ops: 8
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max reqs: 64
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cs=
a_back_chan_attrs
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdr pad size: 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max req size: 4096
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size: 4096
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size cached: 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max ops: 2
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max reqs: 16
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cb=
_program: 0x40000000
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fl=
avor: 1
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
amp: 2087796144
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
chine name: srv-transfert.ad.phedre.fr
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ui=
d: 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gi=
d: 0
> > > =C2=A0=C2=A0=C2=A0 [Main Opcode: CREATE_SESSION (43)]
> > >=20
> > >=20
> > > And the Node responds, as expected confirming the max size of
> > > 1048576.
> > >=20
> > >=20
> > > Frame 19: 194 bytes on wire (1552 bits), 194 bytes captured (1552
> > > bits)
> > > Ethernet II, Src: MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a), Dst:
> > > IETF-VRRP-VRID_3f (00:00:5e:00:01:3f)
> > > Internet Protocol Version 4, Src: 172.22.16.29, Dst: 172.22.1.132
> > > Transmission Control Protocol, Src Port: 2049, Dst Port: 810, Seq:
> > > 321, Ack: 853, Len: 128
> > > Remote Procedure Call, Type:Reply XID:0x945b7e1d
> > > Network File System, Ops(1): CREATE_SESSION
> > > =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > =C2=A0=C2=A0=C2=A0 Status: NFS4_OK (0)
> > > =C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > > =C2=A0=C2=A0=C2=A0 Operations (count: 1)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: CREATE_SESSION (43=
)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 St=
atus: NFS4_OK (0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
ssionid: f49b916e62efad36f200000006000000
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
qid: 0x00000001
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cs=
r_flags: 0x00000002,
> > > CREATE_SESSION4_FLAG_CONN_BACK_CHAN
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cs=
r_fore_chan_attrs
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdr pad size: 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max req size: 1048576
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size: 1048576
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size cached: 7584
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max ops: 8
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max reqs: 64
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cs=
r_back_chan_attrs
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdr pad size: 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max req size: 4096
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size: 4096
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size cached: 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max ops: 2
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max reqs: 16
> > > =C2=A0=C2=A0=C2=A0 [Main Opcode: CREATE_SESSION (43)]
> > >=20
> > >=20
> > > Now if we look later on in the sequence when the Client sends the
> > > write request to the Node - we see in the frame, the max size is as
> > > expected 1048576
> > >=20
> > >=20
> > > Frame 747: 1998 bytes on wire (15984 bits), 1998 bytes captured
> > > (15984 bits)
> > > Ethernet II, Src: SuperMicroCo_1d:7d:b2 (ac:1f:6b:1d:7d:b2), Dst:
> > > MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a)
> > > Internet Protocol Version 4, Src: 172.22.1.132, Dst: 172.22.16.29
> > > Transmission Control Protocol, Src Port: 810, Dst Port: 2049, Seq:
> > > 1054149, Ack: 6009, Len: 1932
> > > [345 Reassembled TCP Segments (1048836 bytes): #84(1448),
> > > #85(5792),
> > > #87(5792), #89(1448), #90(1448), #92(4344), #94(4344), #96(2896),
> > > #98(1448), #99(2896), #101(4344), #103(4344), #105(1448),
> > > #106(1448),
> > > #108(2896), #110(1448), #111(2896)]
> > > Remote Procedure Call, Type:Call XID:0xb45b7e1d
> > > Network File System, Ops(4): SEQUENCE, PUTFH, WRITE, GETATTR
> > > =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > =C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > > =C2=A0=C2=A0=C2=A0 minorversion: 2
> > > =C2=A0=C2=A0=C2=A0 Operations (count: 4): SEQUENCE, PUTFH, WRITE, GET=
ATTR
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: SEQUENCE (53)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: PUTFH (22)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: WRITE (38)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 St=
ateID
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of=
fset: 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
able: FILE_SYNC4 (2)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Wr=
ite length: 1048576
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Da=
ta: <DATA>
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: GETATTR (9)
> > > =C2=A0=C2=A0=C2=A0 [Main Opcode: WRITE (38)]
> > >=20
> > >=20
> > > However we then see the Node reply a short time later with (as
> > > below)
> > > REQ_TOO_BIG - meaning the max size has been exceeded.
> > >=20
> > > Frame 749: 114 bytes on wire (912 bits), 114 bytes captured (912
> > > bits)
> > > Ethernet II, Src: MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a), Dst:
> > > IETF-VRRP-VRID_3f (00:00:5e:00:01:3f)
> > > Internet Protocol Version 4, Src: 172.22.16.29, Dst: 172.22.1.132
> > > Transmission Control Protocol, Src Port: 2049, Dst Port: 810, Seq:
> > > 6009, Ack: 1056081, Len: 48
> > > Remote Procedure Call, Type:Reply XID:0xb45b7e1d
> > > Network File System, Ops(1): SEQUENCE(NFS4ERR_REQ_TOO_BIG)
> > > =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > =C2=A0=C2=A0=C2=A0 Status: NFS4ERR_REQ_TOO_BIG (10065)
> > > =C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > > =C2=A0=C2=A0=C2=A0 Operations (count: 1)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: SEQUENCE (53)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 St=
atus: NFS4ERR_REQ_TOO_BIG (10065)
> > > =C2=A0=C2=A0=C2=A0 [Main Opcode: SEQUENCE (53)]
> > >=20
> > >=20
> > > Why is this?
> > >=20
> > > The reason for this seems to be related to the Client.
> > >=20
> > > From the Cluster side, the max rsize/wsize is the overall compound
> > > packet max size (everything related to NFS in the call)
> > >=20
> > > So for example with a compound call in nfsv4.2 - this might include
> > > the below type detail which does not exceed the overall size
> > > 1048576:
> > >=20
> > > [
> > > COMPOUND header
> > > SEQUENCE ....
> > > PUTFH ...
> > > WRITE header
> > > WRITE payload
> > > ]=C2=A0=C2=A0=C2=A0=C2=A0 (overall) < 1mb
> > >=20
> > >=20
> > > However the Client instead uses r/wsize from mount option, as a
> > > limit
> > > for the write payload.
> > >=20
> > > So with the same example
> > > COMPOUND header
> > > SEQUENCE ....
> > > PUTFH ...
> > > WRITE header
> > >=20
> > > [
> > > WRITE payload
> > > ]=C2=A0=C2=A0=C2=A0 (write) < 1mb
> > >=20
> > > But overall this ends up being 1mb + all the overhead of write
> > > header, compound header, putfh etc
> > > Puts it over the channel limit of=C2=A0 1048576 and hence the error
> > > returned.
> > >=20
> > > So it seems here the Client ignores that value and insists on the
> > > WRITE with a payload =3D=3D wszie; which in total with WRITE overhead
> > > and
> > > all other requests in COMPOUND (PUTFH, etc) exceeds maxrequestsize,
> > > which prompts NFS4ERR_REQ_TOO_BIG.
> > >=20
> > >=20
> > > And as you can see, once you reduce the size within the mount
> > > options
> > > on the Client side, it no longer exceeds its limits.
> > > Meaning you don't get the I/O error.
> >=20
> > So question, are we behaving here correctly or is it our Problem, or
> > is the
> > issue still considered on Dell's side?
> >=20
> > #regzbot introduced: 2b092175f5e301cdaa935093edfef2be9defb6df
> > #regzbot monitor: https://bugs.debian.org/1128834=C2=A0
> >=20
> > How to proceeed from here?
>=20
>=20
> The Linux NFS client uses the 'maxread' and 'maxwrite' attributes (see
> RFC8881 Sections 5.8.2.20. and 5.8.2.21.) to decide how big a payload
> to request/send to the server in a READ/WRITE COMPOUND.
>=20
> If Dell's implementation is returning a size of 1MB, then the Linux
> client will use that value. It won't cross check with the max request
> size, because it assumes that since both values derive from the server,
> there will be no conflict between them.

This seems like a wrong interpretation to me.

Servers use the max_request_size to properly size their receive
buffers, and the client is responsible for adhering to that value. I
don't think you can stick a bunch of operations in a request compound
and then put a huge WRITE at the end that blows out max_request_size,
and expect the server to be OK with that.

ISTM the client should clamp the length down to something shorter that
allows the request to fit. Maybe drop the last folio and force another
request? Performance would suck but it would work.

All that said, the server in this case isn't sizing max_request_size
with enough overhead for the client to actually achieve a full 1M
write, which is just dumb. Dell should fix that.

--=20
Jeff Layton <jlayton@kernel.org>

