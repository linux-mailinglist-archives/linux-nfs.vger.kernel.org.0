Return-Path: <linux-nfs+bounces-20169-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lHbwChGBtWne1AAAu9opvQ
	(envelope-from <linux-nfs+bounces-20169-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 16:38:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86728DB7E
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 16:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2C0C301875C
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BAC299A87;
	Sat, 14 Mar 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NePozfoX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092614884C;
	Sat, 14 Mar 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773502730; cv=none; b=sqXztvxZ27lSD8mlT1CSglzu0t9H6D3WnlY+YJW4nt2XaFzkzHRDcvf/Kzn7RMgtGcuID2BRPbFLITAgMop4qI+9Ap+KbyMVzJPqGtYapDe2Gd74E6WiciQ7nKqE8dh+lnnnpTLD9PLoZ2a49+XXw5S2iNCmdrtnppXkClikX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773502730; c=relaxed/simple;
	bh=sRS5obwVHvW69iBDR4yOT0LCxPx0QCIPcbag+FY45Pk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOw0uHwXMjty0JuJKrkTas/SR6+sT398Eo5ufIS2fdh+3usMcaFsEPiSmMtNAtMeaKua5I5P5PuFC13ZtJFZcKTHeecHq1sm8/aNUXD2cc2kxibnH5woUg4tDbaQHp2Mh6H6Hoj1SAwVvgmiQIxW8QDuU9e2l4FvPipu0Rc1Tys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NePozfoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71CBC116C6;
	Sat, 14 Mar 2026 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773502730;
	bh=sRS5obwVHvW69iBDR4yOT0LCxPx0QCIPcbag+FY45Pk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NePozfoXTkpYMN5iZ+LKP4BmWlVa4RO0W7Kj/xcuWVTY4E+AmEzTli85Geq2zbfSp
	 GjrAFqcOMAiM8cAeohFYelZryWzIzczc4nBjLH7vdUy856EdLZoPNjq5zGycyNncAH
	 97Mq/K0vP2jTMomZFqR7oqP5E18D6sxAPVFes3PdjuR3aSBjLgnT2Vm1iqGGjzJCGR
	 iNVk99wpl4vlAnqmr++2MN5P5rUWkycv94B7gxA8MXwWb6FrjEGFnxwxjl72oebRSe
	 aVWqGLXZy3pUCD+giRCmpCYpaCqP7YZAPF/AXVgrLNP9AsMk7x2EZPyOy19zcYuEg5
	 Q2IH4sAHwtRzA==
Message-ID: <0f9572e731939f365f6708f58b258bee89d6245a.camel@kernel.org>
Subject: Re: [regression] Large rsize/wsize (1MB) causes EIO after
 2b092175f5e3 ("NFS: Fix inheritance of the block sizes when automounting")
From: Trond Myklebust <trondmy@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>, Maik Nergert	
 <maik.nergert@uni-hamburg.de>, Valentin SAMIR
 <valentin.samir@magellium.fr>,  Anna Schumaker	 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, 1128834@bugs.debian.org
Date: Sat, 14 Mar 2026 11:38:49 -0400
In-Reply-To: <177349021750.3039212.10211295677877269201@eldamar.lan>
References: <177349021750.3039212.10211295677877269201@eldamar.lan>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20169-lists,linux-nfs=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,phedre.fr:url,hammerspace.com:email]
X-Rspamd-Queue-Id: 7C86728DB7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Salvatore,

On Sat, 2026-03-14 at 13:23 +0100, Salvatore Bonaccorso wrote:
> Control: forwarded -1
> https://lore.kernel.org/regressions/177349021750.3039212.1021129567787726=
9201@eldamar.lan
> Control: tags -1 + upstream
>=20
> Hi Trond, hi Anna
>=20
> In Debian we got reports of a NFS client regression where large
> rsize/wsize (1MB) causes EIO after the commit 2b092175f5e3 ("NFS: Fix
> inheritance of the block sizes when automounting") and its backports
> to the stable series. The report in full is at:
> https://bugs.debian.org/1128834
>=20
> Maik reported:
> > after upgrading from Linux 6.1.158 to 6.1.162, NFS client writes
> > fail with input/output errors (EIO).
> >=20
> > Environment:
> > - Debian Bookworm
> > - Kernel: 6.1.0-43-amd64 (6.1.162-1)
> > - NFSv4.2 (also reproducible with 4.1)
> > - Default mount options include rsize=3D1048576,wsize=3D1048576
> >=20
> > Reproducer:
> > dd if=3D/dev/zero of=3D~/testfile bs=3D1M count=3D500
> > or
> > dd if=3D/dev/zero of=3D~/testfile bs=3D4k count=3D100000
> >=20
> > On different computers and VMs!
> >=20
> >=20
> > Result:
> > dd: closing output file: Input/output error
> >=20
> > Workaround:
> > Mount with:
> > rsize=3D65536,wsize=3D65536
> >=20
> > With reduced I/O size, the issue disappears completely.
> >=20
> > Impact:
> > - File writes fail (file >1M)
> > - KDE Plasma crashes due to corrupted cache/config writes
> >=20
> > The issue does NOT occur on kernel 6.1.0-42 (6.1.158).
>=20
> I was not able to reproduce the problem, and it turned out that it
> seems to be triggerable when on NFS server side a Dell EMC (Isilion)
> system was used. So the issue was not really considered initially as
> beeing "our" issue.
>=20
> Valentin SAMIR, a second user affected, did as well report the issue
> to Dell, and Dell seems to point at a client issue instead. Valentin
> writes:
>=20
> > We are facing the same issue. Dell seems to point to a client
> > issue:
> > The kernel treats the max size as the nfs payload max size whereas
> > OneFs treat the max size as the overall compound packet max size
> > (everything related to NFS in the call). Hence when OneFS receives
> > a
> > call with a payload of 1M, the overall NFS packet is slightly
> > bigger
> > and it returns an NFS4ERR_REQ_TOO_BIG.
> >=20
> > So the question is: should max req size/max resp size be treated as
> > the
> > nfs payload max size or the whole nfs packet max size?
>=20
> His reply in https://bugs.debian.org/1128834#55=C2=A0contains a quote fro=
m
> the response Valentin got from Dell, I'm full quoting it here for
> easier followup in case needed:
>=20
> > I have been looking at the action plan output we captured.
> > Specifically around when you first mounted and then repro'ed the
> > error.
> >=20
> > Looking at the pcap we gathered, firstly, lets concentrate on the
> > "create session" calls between Client / Node.
> > Here we can these max sizes advertised - per screenshot.
> >=20
> >=20
> > Frame 17: 306 bytes on wire (2448 bits), 306 bytes captured (2448
> > bits)
> > Ethernet II, Src: SuperMicroCo_1d:7d:b2 (ac:1f:6b:1d:7d:b2), Dst:
> > MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a)
> > Internet Protocol Version 4, Src: 172.22.1.132, Dst: 172.22.16.29
> > Transmission Control Protocol, Src Port: 810, Dst Port: 2049, Seq:
> > 613, Ack: 277, Len: 240
> > Remote Procedure Call, Type:Call XID:0x945b7e1d
> > Network File System, Ops(1): CREATE_SESSION
> > =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > =C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > =C2=A0=C2=A0=C2=A0 minorversion: 2
> > =C2=A0=C2=A0=C2=A0 Operations (count: 1): CREATE_SESSION
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: CREATE_SESSION (43)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clie=
ntid: 0x36adef626e919bf4
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seqi=
d: 0x00000001
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csa_=
flags: 0x00000003, CREATE_SESSION4_FLAG_PERSIST,
> > CREATE_SESSION4_FLAG_CONN_BACK_CHAN
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csa_=
fore_chan_attrs
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdr pad size: 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max req size: 1049620
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size: 1049480
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size cached: 7584
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max ops: 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max reqs: 64
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csa_=
back_chan_attrs
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdr pad size: 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max req size: 4096
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size: 4096
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size cached: 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max ops: 2
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max reqs: 16
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cb_p=
rogram: 0x40000000
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flav=
or: 1
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stam=
p: 2087796144
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mach=
ine name: srv-transfert.ad.phedre.fr
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uid:=
 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gid:=
 0
> > =C2=A0=C2=A0=C2=A0 [Main Opcode: CREATE_SESSION (43)]
> >=20
> >=20
> > And the Node responds, as expected confirming the max size of
> > 1048576.
> >=20
> >=20
> > Frame 19: 194 bytes on wire (1552 bits), 194 bytes captured (1552
> > bits)
> > Ethernet II, Src: MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a), Dst:
> > IETF-VRRP-VRID_3f (00:00:5e:00:01:3f)
> > Internet Protocol Version 4, Src: 172.22.16.29, Dst: 172.22.1.132
> > Transmission Control Protocol, Src Port: 2049, Dst Port: 810, Seq:
> > 321, Ack: 853, Len: 128
> > Remote Procedure Call, Type:Reply XID:0x945b7e1d
> > Network File System, Ops(1): CREATE_SESSION
> > =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > =C2=A0=C2=A0=C2=A0 Status: NFS4_OK (0)
> > =C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > =C2=A0=C2=A0=C2=A0 Operations (count: 1)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: CREATE_SESSION (43)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Stat=
us: NFS4_OK (0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sess=
ionid: f49b916e62efad36f200000006000000
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seqi=
d: 0x00000001
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csr_=
flags: 0x00000002,
> > CREATE_SESSION4_FLAG_CONN_BACK_CHAN
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csr_=
fore_chan_attrs
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdr pad size: 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max req size: 1048576
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size: 1048576
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size cached: 7584
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max ops: 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max reqs: 64
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csr_=
back_chan_attrs
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdr pad size: 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max req size: 4096
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size: 4096
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max resp size cached: 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max ops: 2
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 max reqs: 16
> > =C2=A0=C2=A0=C2=A0 [Main Opcode: CREATE_SESSION (43)]
> >=20
> >=20
> > Now if we look later on in the sequence when the Client sends the
> > write request to the Node - we see in the frame, the max size is as
> > expected 1048576
> >=20
> >=20
> > Frame 747: 1998 bytes on wire (15984 bits), 1998 bytes captured
> > (15984 bits)
> > Ethernet II, Src: SuperMicroCo_1d:7d:b2 (ac:1f:6b:1d:7d:b2), Dst:
> > MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a)
> > Internet Protocol Version 4, Src: 172.22.1.132, Dst: 172.22.16.29
> > Transmission Control Protocol, Src Port: 810, Dst Port: 2049, Seq:
> > 1054149, Ack: 6009, Len: 1932
> > [345 Reassembled TCP Segments (1048836 bytes): #84(1448),
> > #85(5792),
> > #87(5792), #89(1448), #90(1448), #92(4344), #94(4344), #96(2896),
> > #98(1448), #99(2896), #101(4344), #103(4344), #105(1448),
> > #106(1448),
> > #108(2896), #110(1448), #111(2896)]
> > Remote Procedure Call, Type:Call XID:0xb45b7e1d
> > Network File System, Ops(4): SEQUENCE, PUTFH, WRITE, GETATTR
> > =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > =C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > =C2=A0=C2=A0=C2=A0 minorversion: 2
> > =C2=A0=C2=A0=C2=A0 Operations (count: 4): SEQUENCE, PUTFH, WRITE, GETAT=
TR
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: SEQUENCE (53)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: PUTFH (22)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: WRITE (38)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Stat=
eID
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offs=
et: 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stab=
le: FILE_SYNC4 (2)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Writ=
e length: 1048576
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Data=
: <DATA>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: GETATTR (9)
> > =C2=A0=C2=A0=C2=A0 [Main Opcode: WRITE (38)]
> >=20
> >=20
> > However we then see the Node reply a short time later with (as
> > below)
> > REQ_TOO_BIG - meaning the max size has been exceeded.
> >=20
> > Frame 749: 114 bytes on wire (912 bits), 114 bytes captured (912
> > bits)
> > Ethernet II, Src: MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a), Dst:
> > IETF-VRRP-VRID_3f (00:00:5e:00:01:3f)
> > Internet Protocol Version 4, Src: 172.22.16.29, Dst: 172.22.1.132
> > Transmission Control Protocol, Src Port: 2049, Dst Port: 810, Seq:
> > 6009, Ack: 1056081, Len: 48
> > Remote Procedure Call, Type:Reply XID:0xb45b7e1d
> > Network File System, Ops(1): SEQUENCE(NFS4ERR_REQ_TOO_BIG)
> > =C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > =C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > =C2=A0=C2=A0=C2=A0 Status: NFS4ERR_REQ_TOO_BIG (10065)
> > =C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > =C2=A0=C2=A0=C2=A0 Operations (count: 1)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opcode: SEQUENCE (53)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Stat=
us: NFS4ERR_REQ_TOO_BIG (10065)
> > =C2=A0=C2=A0=C2=A0 [Main Opcode: SEQUENCE (53)]
> >=20
> >=20
> > Why is this?
> >=20
> > The reason for this seems to be related to the Client.
> >=20
> > From the Cluster side, the max rsize/wsize is the overall compound
> > packet max size (everything related to NFS in the call)
> >=20
> > So for example with a compound call in nfsv4.2 - this might include
> > the below type detail which does not exceed the overall size
> > 1048576:
> >=20
> > [
> > COMPOUND header
> > SEQUENCE ....
> > PUTFH ...
> > WRITE header
> > WRITE payload
> > ]=C2=A0=C2=A0=C2=A0=C2=A0 (overall) < 1mb
> >=20
> >=20
> > However the Client instead uses r/wsize from mount option, as a
> > limit
> > for the write payload.
> >=20
> > So with the same example
> > COMPOUND header
> > SEQUENCE ....
> > PUTFH ...
> > WRITE header
> >=20
> > [
> > WRITE payload
> > ]=C2=A0=C2=A0=C2=A0 (write) < 1mb
> >=20
> > But overall this ends up being 1mb + all the overhead of write
> > header, compound header, putfh etc
> > Puts it over the channel limit of=C2=A0 1048576 and hence the error
> > returned.
> >=20
> > So it seems here the Client ignores that value and insists on the
> > WRITE with a payload =3D=3D wszie; which in total with WRITE overhead
> > and
> > all other requests in COMPOUND (PUTFH, etc) exceeds maxrequestsize,
> > which prompts NFS4ERR_REQ_TOO_BIG.
> >=20
> >=20
> > And as you can see, once you reduce the size within the mount
> > options
> > on the Client side, it no longer exceeds its limits.
> > Meaning you don't get the I/O error.
>=20
> So question, are we behaving here correctly or is it our Problem, or
> is the
> issue still considered on Dell's side?
>=20
> #regzbot introduced: 2b092175f5e301cdaa935093edfef2be9defb6df
> #regzbot monitor: https://bugs.debian.org/1128834=C2=A0
>=20
> How to proceeed from here?


The Linux NFS client uses the 'maxread' and 'maxwrite' attributes (see
RFC8881 Sections 5.8.2.20. and 5.8.2.21.) to decide how big a payload
to request/send to the server in a READ/WRITE COMPOUND.

If Dell's implementation is returning a size of 1MB, then the Linux
client will use that value. It won't cross check with the max request
size, because it assumes that since both values derive from the server,
there will be no conflict between them.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

