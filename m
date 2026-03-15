Return-Path: <linux-nfs+bounces-20174-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLMHEOhvtmmMBgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20174-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 09:38:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B563290411
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 09:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333123022962
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F824E4AF;
	Sun, 15 Mar 2026 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCOKD+UN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66996245012
	for <linux-nfs@vger.kernel.org>; Sun, 15 Mar 2026 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563877; cv=pass; b=pdcLBeYLcjDs4fLJBpkJtsxn/fmFrpM1irZ/WDYGOWy9DrwL3LVeVylw5pCofGqCbxl3p+R7sdTBth1MVQ5sq3ss7dHfRIrqzlJh/gmzYwSBeghp2sCgQpkNWT4792OBIM6/IjXNTN7Uh3JHvELFb8w63WLziJIkkDdEzXiCHhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563877; c=relaxed/simple;
	bh=kYvpmUsx3zfdl5+qbJr0a8puIn6OtSFPU7f+rQIcCsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XPpDZPUye13/9Z233gBURfxh82V1juxcW5pKkf5GfzxQlDpwFH9u9wN6gahrMGP+nXpUK+r0qRaQr3qPzRhBPWuXvpEtyS6Kw5EtkOVtEjhZvvAqNYFY+6/ogcn5/j4CEbK6l4Bie1uZryl8OxOcUEpJpDp69u+d51Qdv7LqL5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCOKD+UN; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so585785466b.2
        for <linux-nfs@vger.kernel.org>; Sun, 15 Mar 2026 01:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773563873; cv=none;
        d=google.com; s=arc-20240605;
        b=P1Lz4f+z7Rgg2QVCaegzABEIo46DvW3UH4LgTKGpf4XkgV/0/MCzX5/cZmS5Wr4GeW
         AblTFYVzzCyVgg6c3A4pKavMfBXfR59GQWwlq3jAPgjo6EHPwhTCBFTmQVOgRy+UL1xL
         zgUBjEbBHvk1DIRQXeEL6r6dpvsVgP3vRhV5TYC2W4myXnJiK6k78Mxyfo27el1AWt69
         LWlWXBztgP/QkRAQnq+vmT6zKWvhtV0+MDGO8NCkP8afhAFDigj7A8W/sG/Il8Lundr7
         i2WqXtV3G++iWQHMMxsUotre59xZ6Nxx3SLIO46211EpEiXXmNUFImde3nt7fMuJ2jzd
         qq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Shi9by71WCATsbE8XDzkJJHi90XwrNC3rti1RzxWIT4=;
        fh=lTaB37POhsOuEVbiExY8vDUl5FurBfrMUA9zPAaPTnM=;
        b=GRapmyzf0AvZfCnhun3ugDsOBm7vGMxGqFeYJ2k1mHzQdfJWLfusP/NxYkTJlhEHFb
         UnFpsvo8NARL8NqSbLJdNTD0bV/H4lDO37PPOCaj6W/ugUt/ypL4SRPTMkgZLZNgqSDD
         uy/ax0knXsDiwMk9sePm31AQwDr8h3cTymEvE2UvhIpd6W0BwTo7I+0luh+/wOcDv4h/
         cs6Ksf1oojWSMUsjLK8rm/U9MdJ9RVWMOQanCkP12WqxbTJCPfz3MpN5C7csu5YPQbWB
         MbDVUNF+sjcmf4CUBBrt7KP458M2KFyiBzltKjJlH47zGLZhIaGsdVRIflpuGCD2rcYO
         rh/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773563873; x=1774168673; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Shi9by71WCATsbE8XDzkJJHi90XwrNC3rti1RzxWIT4=;
        b=TCOKD+UNRqHxHOK6RbnSM8foXSRlb84PZpscI1b/8aT+6YF4A4DgmUXJxSKzdc3eQs
         Ym+NY+EK7pOEqM1soo8+Zc3MHSnf8BxaMyxrZpJMChvkcxr2cTUcmOsV7YooYZ1AV5Xl
         BcagyL4zHD8/9dktoxKG05vkDEL05ntmSOU+6sJWqDKsd4OkuGE+WLrV7iHNvfSTezba
         bwWbTPXEjE2Gu4uzMThQxKRKRQ0UeY+OFV7kDwiXhUDbF7cwsh7tdNm5QnkwyplMePqn
         Sz3qomRp6/tKUFfSd7j8jrYBHsPS+dO6egmCPegA0qn7AcivnqNSTYD6YagIl+iZVHuV
         NGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773563873; x=1774168673;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Shi9by71WCATsbE8XDzkJJHi90XwrNC3rti1RzxWIT4=;
        b=qQo0n6B0E1BWFYEJgHZAw+yRI71MCD12DXHewKCr5w8Dv1USPLWLUuq86TEHp7bNCs
         bvAe7JsbmKhjgsWnUt8LUmD7jJHxIlCe0fARG7pDsJIn0OhTflklM9oI2OAe0cGCr/nA
         Gnsvswc0SBbNeE5jkNNFuKHJ5uJtxl6bC2voCcVg7RQGSg4up9y34A48iJt/QRQFsWsq
         E8xmI9czjlCeKluoYQQPlvF9cjzK01bOXVwPg2qEv6KZo/eL5ASdXhvr9xpZHQHVHzCb
         c2vjpKDqitbFHs4vDQh7HsqJVmjf17RxD0tNffV8QW00fs+XGObuNJQvIpdKpdP1j2ry
         PoKQ==
X-Gm-Message-State: AOJu0YwIHzCq9NSldh8FHvG7wxcu77fG//baL6Sz88wPbuO6jrBk4gEX
	ED5waI8zGxDW45kL/IMhrVGFH47gEImYOeBXYnANevmwEHvAOAXImqFPwkLiaSw0Y9kNvw2xZJo
	Mk3G9Lkg2FwAQpB/JoRAXvTGR5OLD4qC42d2K1ww=
X-Gm-Gg: ATEYQzwLUeZx6paN03fPCw9Eb1q6bY7SaMXsPrizLSZufu57bsNHybYe6uY0RH+tMUN
	AxNy30wePNKWNQ9C/+yJH18PEkTIuDVIAK08dWAGr28L4MWxnMZlMhkE19M0b8ponKVv78pNnhp
	Qfdfc6VhUUgUjUQe9hEtuOaBasR7hDTNsfZMNDno607COWHX8eIlfTnzZwP9jEycvjkPXA6IoNF
	mID7ZhS7XPIvbQaA7Fu/H3W7Gn5ziuPv6+xrfks2VVnYEqjMHm/iiCsT34GQMgn+6yyL6sp1t2F
	wdXFbwYrmVPdeFL6uC+zpjwgyG1qwp8IC4LtzlZySFuRLgwiDA==
X-Received: by 2002:a17:907:9346:b0:b93:cae3:5834 with SMTP id
 a640c23a62f3a-b97650b517cmr522066266b.13.1773563873213; Sun, 15 Mar 2026
 01:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177349021750.3039212.10211295677877269201@eldamar.lan> <0f9572e731939f365f6708f58b258bee89d6245a.camel@kernel.org>
In-Reply-To: <0f9572e731939f365f6708f58b258bee89d6245a.camel@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Sun, 15 Mar 2026 09:37:00 +0100
X-Gm-Features: AaiRm53lx2Rext5tx_9LFihL487zIPFQcKSK7OjjKbblhizl4WAa5Huhd5vIME0
Message-ID: <CA+1jF5p57oj4Jhkqy_MYqKpijmjSVU+1WeV+DH2waEszg5rwhQ@mail.gmail.com>
Subject: Re: [regression] Large rsize/wsize (1MB) causes EIO after
 2b092175f5e3 ("NFS: Fix inheritance of the block sizes when automounting")
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, 1128834@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20174-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,phedre.fr:url]
X-Rspamd-Queue-Id: 8B563290411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 4:38=E2=80=AFPM Trond Myklebust <trondmy@kernel.org=
> wrote:
>
> Hi Salvatore,
>
> On Sat, 2026-03-14 at 13:23 +0100, Salvatore Bonaccorso wrote:
> > Control: forwarded -1
> > https://lore.kernel.org/regressions/177349021750.3039212.10211295677877=
269201@eldamar.lan
> > Control: tags -1 + upstream
> >
> > Hi Trond, hi Anna
> >
> > In Debian we got reports of a NFS client regression where large
> > rsize/wsize (1MB) causes EIO after the commit 2b092175f5e3 ("NFS: Fix
> > inheritance of the block sizes when automounting") and its backports
> > to the stable series. The report in full is at:
> > https://bugs.debian.org/1128834
> >
> > Maik reported:
> > > after upgrading from Linux 6.1.158 to 6.1.162, NFS client writes
> > > fail with input/output errors (EIO).
> > >
> > > Environment:
> > > - Debian Bookworm
> > > - Kernel: 6.1.0-43-amd64 (6.1.162-1)
> > > - NFSv4.2 (also reproducible with 4.1)
> > > - Default mount options include rsize=3D1048576,wsize=3D1048576
> > >
> > > Reproducer:
> > > dd if=3D/dev/zero of=3D~/testfile bs=3D1M count=3D500
> > > or
> > > dd if=3D/dev/zero of=3D~/testfile bs=3D4k count=3D100000
> > >
> > > On different computers and VMs!
> > >
> > >
> > > Result:
> > > dd: closing output file: Input/output error
> > >
> > > Workaround:
> > > Mount with:
> > > rsize=3D65536,wsize=3D65536
> > >
> > > With reduced I/O size, the issue disappears completely.
> > >
> > > Impact:
> > > - File writes fail (file >1M)
> > > - KDE Plasma crashes due to corrupted cache/config writes
> > >
> > > The issue does NOT occur on kernel 6.1.0-42 (6.1.158).
> >
> > I was not able to reproduce the problem, and it turned out that it
> > seems to be triggerable when on NFS server side a Dell EMC (Isilion)
> > system was used. So the issue was not really considered initially as
> > beeing "our" issue.
> >
> > Valentin SAMIR, a second user affected, did as well report the issue
> > to Dell, and Dell seems to point at a client issue instead. Valentin
> > writes:
> >
> > > We are facing the same issue. Dell seems to point to a client
> > > issue:
> > > The kernel treats the max size as the nfs payload max size whereas
> > > OneFs treat the max size as the overall compound packet max size
> > > (everything related to NFS in the call). Hence when OneFS receives
> > > a
> > > call with a payload of 1M, the overall NFS packet is slightly
> > > bigger
> > > and it returns an NFS4ERR_REQ_TOO_BIG.
> > >
> > > So the question is: should max req size/max resp size be treated as
> > > the
> > > nfs payload max size or the whole nfs packet max size?
> >
> > His reply in https://bugs.debian.org/1128834#55 contains a quote from
> > the response Valentin got from Dell, I'm full quoting it here for
> > easier followup in case needed:
> >
> > > I have been looking at the action plan output we captured.
> > > Specifically around when you first mounted and then repro'ed the
> > > error.
> > >
> > > Looking at the pcap we gathered, firstly, lets concentrate on the
> > > "create session" calls between Client / Node.
> > > Here we can these max sizes advertised - per screenshot.
> > >
> > >
> > > Frame 17: 306 bytes on wire (2448 bits), 306 bytes captured (2448
> > > bits)
> > > Ethernet II, Src: SuperMicroCo_1d:7d:b2 (ac:1f:6b:1d:7d:b2), Dst:
> > > MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a)
> > > Internet Protocol Version 4, Src: 172.22.1.132, Dst: 172.22.16.29
> > > Transmission Control Protocol, Src Port: 810, Dst Port: 2049, Seq:
> > > 613, Ack: 277, Len: 240
> > > Remote Procedure Call, Type:Call XID:0x945b7e1d
> > > Network File System, Ops(1): CREATE_SESSION
> > >     [Program Version: 4]
> > >     [V4 Procedure: COMPOUND (1)]
> > >     Tag: <EMPTY>
> > >     minorversion: 2
> > >     Operations (count: 1): CREATE_SESSION
> > >         Opcode: CREATE_SESSION (43)
> > >             clientid: 0x36adef626e919bf4
> > >             seqid: 0x00000001
> > >             csa_flags: 0x00000003, CREATE_SESSION4_FLAG_PERSIST,
> > > CREATE_SESSION4_FLAG_CONN_BACK_CHAN
> > >             csa_fore_chan_attrs
> > >                 hdr pad size: 0
> > >                 max req size: 1049620
> > >                 max resp size: 1049480
> > >                 max resp size cached: 7584
> > >                 max ops: 8
> > >                 max reqs: 64
> > >             csa_back_chan_attrs
> > >                 hdr pad size: 0
> > >                 max req size: 4096
> > >                 max resp size: 4096
> > >                 max resp size cached: 0
> > >                 max ops: 2
> > >                 max reqs: 16
> > >             cb_program: 0x40000000
> > >             flavor: 1
> > >             stamp: 2087796144
> > >             machine name: srv-transfert.ad.phedre.fr
> > >             uid: 0
> > >             gid: 0
> > >     [Main Opcode: CREATE_SESSION (43)]
> > >
> > >
> > > And the Node responds, as expected confirming the max size of
> > > 1048576.
> > >
> > >
> > > Frame 19: 194 bytes on wire (1552 bits), 194 bytes captured (1552
> > > bits)
> > > Ethernet II, Src: MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a), Dst:
> > > IETF-VRRP-VRID_3f (00:00:5e:00:01:3f)
> > > Internet Protocol Version 4, Src: 172.22.16.29, Dst: 172.22.1.132
> > > Transmission Control Protocol, Src Port: 2049, Dst Port: 810, Seq:
> > > 321, Ack: 853, Len: 128
> > > Remote Procedure Call, Type:Reply XID:0x945b7e1d
> > > Network File System, Ops(1): CREATE_SESSION
> > >     [Program Version: 4]
> > >     [V4 Procedure: COMPOUND (1)]
> > >     Status: NFS4_OK (0)
> > >     Tag: <EMPTY>
> > >     Operations (count: 1)
> > >         Opcode: CREATE_SESSION (43)
> > >             Status: NFS4_OK (0)
> > >             sessionid: f49b916e62efad36f200000006000000
> > >             seqid: 0x00000001
> > >             csr_flags: 0x00000002,
> > > CREATE_SESSION4_FLAG_CONN_BACK_CHAN
> > >             csr_fore_chan_attrs
> > >                 hdr pad size: 0
> > >                 max req size: 1048576
> > >                 max resp size: 1048576
> > >                 max resp size cached: 7584
> > >                 max ops: 8
> > >                 max reqs: 64
> > >             csr_back_chan_attrs
> > >                 hdr pad size: 0
> > >                 max req size: 4096
> > >                 max resp size: 4096
> > >                 max resp size cached: 0
> > >                 max ops: 2
> > >                 max reqs: 16
> > >     [Main Opcode: CREATE_SESSION (43)]
> > >
> > >
> > > Now if we look later on in the sequence when the Client sends the
> > > write request to the Node - we see in the frame, the max size is as
> > > expected 1048576
> > >
> > >
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
> > >     [Program Version: 4]
> > >     [V4 Procedure: COMPOUND (1)]
> > >     Tag: <EMPTY>
> > >     minorversion: 2
> > >     Operations (count: 4): SEQUENCE, PUTFH, WRITE, GETATTR
> > >         Opcode: SEQUENCE (53)
> > >         Opcode: PUTFH (22)
> > >         Opcode: WRITE (38)
> > >             StateID
> > >             offset: 0
> > >             stable: FILE_SYNC4 (2)
> > >             Write length: 1048576
> > >             Data: <DATA>
> > >         Opcode: GETATTR (9)
> > >     [Main Opcode: WRITE (38)]
> > >
> > >
> > > However we then see the Node reply a short time later with (as
> > > below)
> > > REQ_TOO_BIG - meaning the max size has been exceeded.
> > >
> > > Frame 749: 114 bytes on wire (912 bits), 114 bytes captured (912
> > > bits)
> > > Ethernet II, Src: MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a), Dst:
> > > IETF-VRRP-VRID_3f (00:00:5e:00:01:3f)
> > > Internet Protocol Version 4, Src: 172.22.16.29, Dst: 172.22.1.132
> > > Transmission Control Protocol, Src Port: 2049, Dst Port: 810, Seq:
> > > 6009, Ack: 1056081, Len: 48
> > > Remote Procedure Call, Type:Reply XID:0xb45b7e1d
> > > Network File System, Ops(1): SEQUENCE(NFS4ERR_REQ_TOO_BIG)
> > >     [Program Version: 4]
> > >     [V4 Procedure: COMPOUND (1)]
> > >     Status: NFS4ERR_REQ_TOO_BIG (10065)
> > >     Tag: <EMPTY>
> > >     Operations (count: 1)
> > >         Opcode: SEQUENCE (53)
> > >             Status: NFS4ERR_REQ_TOO_BIG (10065)
> > >     [Main Opcode: SEQUENCE (53)]
> > >
> > >
> > > Why is this?
> > >
> > > The reason for this seems to be related to the Client.
> > >
> > > From the Cluster side, the max rsize/wsize is the overall compound
> > > packet max size (everything related to NFS in the call)
> > >
> > > So for example with a compound call in nfsv4.2 - this might include
> > > the below type detail which does not exceed the overall size
> > > 1048576:
> > >
> > > [
> > > COMPOUND header
> > > SEQUENCE ....
> > > PUTFH ...
> > > WRITE header
> > > WRITE payload
> > > ]     (overall) < 1mb
> > >
> > >
> > > However the Client instead uses r/wsize from mount option, as a
> > > limit
> > > for the write payload.
> > >
> > > So with the same example
> > > COMPOUND header
> > > SEQUENCE ....
> > > PUTFH ...
> > > WRITE header
> > >
> > > [
> > > WRITE payload
> > > ]    (write) < 1mb
> > >
> > > But overall this ends up being 1mb + all the overhead of write
> > > header, compound header, putfh etc
> > > Puts it over the channel limit of  1048576 and hence the error
> > > returned.
> > >
> > > So it seems here the Client ignores that value and insists on the
> > > WRITE with a payload =3D=3D wszie; which in total with WRITE overhead
> > > and
> > > all other requests in COMPOUND (PUTFH, etc) exceeds maxrequestsize,
> > > which prompts NFS4ERR_REQ_TOO_BIG.
> > >
> > >
> > > And as you can see, once you reduce the size within the mount
> > > options
> > > on the Client side, it no longer exceeds its limits.
> > > Meaning you don't get the I/O error.
> >
> > So question, are we behaving here correctly or is it our Problem, or
> > is the
> > issue still considered on Dell's side?
> >
> > #regzbot introduced: 2b092175f5e301cdaa935093edfef2be9defb6df
> > #regzbot monitor: https://bugs.debian.org/1128834
> >
> > How to proceeed from here?
>
>
> The Linux NFS client uses the 'maxread' and 'maxwrite' attributes (see
> RFC8881 Sections 5.8.2.20. and 5.8.2.21.) to decide how big a payload
> to request/send to the server in a READ/WRITE COMPOUND.

So maxread and/or maxwrite MUST NOT be larger than the clients maximum RPC =
size?

>
> If Dell's implementation is returning a size of 1MB, then the Linux
> client will use that value. It won't cross check with the max request
> size, because it assumes that since both values derive from the server,
> there will be no conflict between them.

Maybe add an assert()-like warning to syslog if there is a mismatch?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

