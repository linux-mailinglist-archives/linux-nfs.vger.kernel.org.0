Return-Path: <linux-nfs+bounces-21312-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMOWOnqC82kY4wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21312-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 18:25:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F06A4A5A5C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A25B4300FB64
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5B43DA56;
	Thu, 30 Apr 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi+Nvgn1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449B31327D
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566272; cv=pass; b=CFdzJm+L5isUR1Orhcl6oKW5opKIsOCFTDWo8xi25clsliMiFFFbZcdh9DGgysuZqtV24MbT4PW7PcEUimIHglkLxqnR6laEpvJ/yKiKK+QoOgxJhKjHjgUcw6M2RjiveBocbuwJYmPuWTl3gr8Uyqc0k+TFD8qT3TR26M8dLSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566272; c=relaxed/simple;
	bh=it8gCg6Gl6V5nZBDpB8gaCWQpxpXktp2/J7U7WJRZCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5ZnlR/Z88FQFuiPPjYX0HoNqSOmNlZZioPSdmcdKVOsoJMxGPFg4OG1bDlwpKnsB1dfJBEa29CU/PPmgR3NqLE06CkfaNwx1Vfuk1SwSV6946Dy+b4/7ksbenrFIDJEzg8a8agYkuc4n0fX8s/C7Rq7u5FWxv97F4yw3spwnwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi+Nvgn1; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so368306a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 09:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777566269; cv=none;
        d=google.com; s=arc-20240605;
        b=Wn1XeZp6dEKvRmlVnsUG/eQlZf7LpikwQUGsf42luSP1C+H2ymUhu0jSwiGNvGR/dx
         CzCppdIrxXLyZ3ZNvsHLZhdqgVzloF9ukgPFlvw1m5NMx8gW7qYw98cac3dHzWHvyCSK
         sbQ0oaMs+06h5ZUtUEu+LavQg8FKxtVN3JwXWUylSevUhohpgaeWPGex3ofre1/8iVib
         nvr0B/86ieb/1u2eypLInvAVwvDg7BxWlcjn5rNEYgaOnuLTbMaGv5XeY7Oyqm2Ce2j9
         CJudV/IJ3KAenoVRy/q7XEhk6jaOrh8/zwG3TKKKMG72MqeD0eSdhSJVlkprhXy59/MH
         JQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zUarJleI3ys3E3geomUIhIOelYwTNdzSv6IADKgyPDc=;
        fh=w4w5ZotjEZPwxGgG77j9ziu17EPR5+Ca7MsiqRob8OY=;
        b=P6wc7mzXUHrvdGs8yuBQkqQpdpld5/RZDh861BhzVUJU4Shl+FdfdA3GOS3A6YdI82
         2wZk+Hnj7boRv4F1ash3oMb5jt5SP14ngnk9K4Q5X1yl9QnT0t/XiQdIHCaSBWiSUeDq
         HDIbpWNSxDZJoSJLXrhU+0SsAV2yNhHbhkaMtS5pbzmy4ru1/5gLyWfRtPIR13ni5O3f
         /u/c3+cCuBRQQhv2slEiL6UkJfP1VpBF2IWrv7LcbiNCf0UM14ZZiOoXInQkGraf/7cr
         V+sU153UydNBwG+Eyi5tKgN47BcWPi9ubBiPKfxwTu+VnNXmf/mrcv3+qxJrPrBunKMR
         mWJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777566269; x=1778171069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUarJleI3ys3E3geomUIhIOelYwTNdzSv6IADKgyPDc=;
        b=Wi+Nvgn1NAAl8/0/qhkjP0EDuLbo9bvCpyuAk98LnubdU7cG8boJ3B3EJj02OHi9tJ
         2jRfO5FhuewCGgZKoMYcZQOLUZmj5pLbH9qrRaQ7kqYxkGuUdteSnR5TIFpI4TAETeDs
         uJ0T9vTUcs6I2do5q7sdmO9IYPweCT4So4TsKMWXp3EoGKF+OU99TgqcU36w7ROsxvrd
         1M36nRTCOEvIm7vp5DGemVcQth1d+SgA6IaDFN4ov7sHYSO0o5KIO2SBMdiUpveO+0to
         +scqIQsUM+96uaAg73XFLqoU2wCIyiEb2WVwJ8VipbR/njg2CA5ZmRk4ema6oonuYge+
         WEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777566269; x=1778171069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zUarJleI3ys3E3geomUIhIOelYwTNdzSv6IADKgyPDc=;
        b=RRflSOkrDI1kSxHQVe4vD1nF7HM/awLySMhl8k1Po8+Z34zdDsmeiXwpFoH2u3L0A2
         HrxzMA+i63TPoHWWLiOn7ZLis8llN7rX8C8EzCrh5Cudf2k2G0nJdb663ZnPV165Lx22
         KEDEge+uMABqKzgB9JjcMG3ImB3UkW1UZvOEVwPOlLv7RNiQKi7V8lRs9adSTSUwaAA7
         pSo2BQkH24W6iS3sspc14UxkP5zJtn2vj8OPcAeU0WQjGIQj0JdhTMFj5BcQVusV1FNj
         Ug2Ucecyl2iwUA3AbXHTpINQGcbcRxArjvZgQucWZtTW31dNnnLXGJoae8iucRTVWTN8
         qlHw==
X-Forwarded-Encrypted: i=1; AFNElJ/lfCixXE+8AjEb9cM2HW1EJV8rnpdm8oXt5vOu59Pz8Q7UELomxvP4bpBsOn9iDPB5kuBLKoONq1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4xs4P0otq3R468gk7grOJqlWEVLkiz9Ru2VKN7jjfOUN8Pfu
	umGk2Thw2GT9jNRtCOxSd07EOVIalmS+wTM4IyHpOPaOB7+oQOHJuRCjjhm9OfHP7Au1XprGP/x
	r1HBk+3Qmp4uq5VvHZZQz0pZPOSWh2Q==
X-Gm-Gg: AeBDiesWkLumPSDtXnBNnF00LAKs9B0BU2pMnOEwJoegHkDOKKw2ZJHyAcnrCusJcR6
	S8Wkla+gs8RIdNHY1nawdOuYDe+dYwUFTFy4MdcyrRR2dRL7TUdgOi+1ErxVS3M8KBNmFvRWKTX
	6xuMMuTbNrHlNfmeekK63MOg3OVTA6rGjhL5OfPIWttWzWA9pDa0YalpBHOajMFRGUcwQqSKpsS
	pPLgm24ATweUiJ0u/qp2POWa5cFbpjvEfcO4M6WJBp9dJDAA/s5gBiUsFZS6L0jXFi1Wel9gFs+
	eEKQkKSJVoVpsVDVO+/qBz3r0vpW0VoMeIIQVod20sKwDKHf5Q==
X-Received: by 2002:aa7:da4d:0:b0:678:a5d1:ca74 with SMTP id
 4fb4d7f45d1cf-67b5e1b6a61mr1105785a12.16.1777566268774; Thu, 30 Apr 2026
 09:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
 <CB5BA5C0-15AA-49D0-96B9-2017F6617903@hammerspace.com> <cf6fd710-e11b-425b-949a-d5acb509eec7@esat.kuleuven.be>
 <CAM5tNy6rbQE-QDGD9-YffYn0Z+MsaCNOOpHAetnBKbW7Pn0_dw@mail.gmail.com>
 <3bee225b-3a3f-47a0-a38e-ce08196595ab@esat.kuleuven.be> <CAM5tNy63vtAAh1DsBFgPMiXDZReUCimR8nii=WFiAUv8LsJctQ@mail.gmail.com>
In-Reply-To: <CAM5tNy63vtAAh1DsBFgPMiXDZReUCimR8nii=WFiAUv8LsJctQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 30 Apr 2026 09:24:17 -0700
X-Gm-Features: AVHnY4IxvSS5hRReX2ODM3mYM3sEESS4T6PeoC5XIQQC_Xv-8YtbCufFGXvwpQ8
Message-ID: <CAM5tNy75wkmkHXMhmu0c4ANroXX6Q-Tt5GjS-D7T9FOhRnpmLg@mail.gmail.com>
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>, Linux Nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F06A4A5A5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21312-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,kuleuven.be:email]

On Thu, Apr 30, 2026 at 8:35=E2=80=AFAM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Thu, Apr 30, 2026 at 8:27=E2=80=AFAM Rik Theys <Rik.Theys@esat.kuleuve=
n.be> wrote:
> >
> > Hi,
> >
> > On 4/30/26 5:02 PM, Rick Macklem wrote:
> > > On Thu, Apr 30, 2026 at 7:26=E2=80=AFAM Rik Theys <Rik.Theys@esat.kul=
euven.be> wrote:
> > >> Hi Benjamin,
> > >>
> > >> On 4/30/26 3:27 PM, Benjamin Coddington wrote:
> > >>> On 30 Apr 2026, at 2:53, Rik Theys wrote:
> > >>>
> > >>>> Hi,
> > >>>>
> > >>>> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrep=
o) that is an NFS client to a RHEL10 server.
> > >>>>
> > >>>> Lately we've noticed that NFS performance is very poor for certain=
 workloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and now =
7.0.2). For example cloning git repositories is extremely slow.
> > >>>>
> > >>>> Looking at the server side there don't seem to be any saturations =
of the disk or network subsystems.
> > >>>>
> > >>>> I've taken a network dump between the client and server. In that d=
ump I see that the server frequently responds to requests from the client w=
ith NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these mismat=
ches? Is this always a client issue, or can this be caused by the server?
> > >>> This is something you shouldn't normally see and probably indicates=
 a bug or
> > >>> serious problem.  From the client side you'd only expect this if yo=
u're
> > >>> doing a lot of task signaling so that the userland processes abando=
n RPCs.
> > >> Would there be any indications in the logs if this is the case?
> > >>
> > >>
> > >>> A packet capture is the best way to determine if the server is mis-=
reporting
> > >>> the sequencing problem, or if the client's sequencing is incorrect.=
  Given
> > >>> your description of the symptoms I'd also check to make sure your u=
nderlying
> > >>> network isn't doing something totally nuts like duplicating packets=
.
> > >> My previous capture was on the client, which is where I observed the
> > >> NFS4ERR_SEQ_MISORDERED messages. I've now taken a capture on the ser=
ver
> > >> and there I do see some duplicate packets, but not a large percentag=
e.
> > >> Should the NFS server not notice this is a duplicate packet and igno=
re it?
> > > Maybe it would be helpful if I gave you an explanation of when the se=
rver
> > > should (probably a MUST in RFC terminology) reply NFS4ERR_SEQ_MISORDE=
RED.
> > >
> > > The first operation in most RPCs (for NFSv4.1/4.2) is SEQUENCE.
> > > If you look in SEQUENCE, when the session and slot# are the same as a
> > > previous RPC, the seq# normally increases by 1.
> > >
> > > If it is exact the same seq#, that should be a duplicate RPC (rest of=
 RPC
> > > should be identical) and it should have been sent on a different TCP =
connection.
> > > This should not generate a NFS4ERR_SEQ_MISORDERED error.
> > >
> > > If the seq# is any value other than the same as or one greater than
> > > the previous RPC with same session and slot#, the server should
> > > reply NFS4ERR_SEQ_MISORDERED.
> > > --> If this happens, the server is behaving correctly, afaik.
> > >        Then, is this a client bug or a client feature?
> > >        That is more difficult to answer and maybe the Linux client
> > >        specialists can comment?
> > >        (I'd say it's probably a bug if neither "intr" nor "soft" opti=
ons
> > >          are on the mount.)
> > >
> > Looking at the capture it seems that for the requests that trigger this
> > NFS4ERR_SEQ_MISORDERED, the sessionid is always the same. The slot id
> > varies (maybe these are different mounts all using the same tcp
> > connection, or concurrent I/O?). The seqid always seems to be 1, which
> > seems odd?
> The seq# =3D=3D 1 is correct if (and only if) that is the first use of th=
at slot#.
Oh, and I should mention that "first use" isn't as simple as it sounds.
If the size of the slot table for a session shrinks and then grows again,
"first use" would be the first time a slot in the "grow range" is used afte=
r
the growth. (I think? I'm actually the FreeBSD NFS guy and I've never
implemented slot table shrinkage/growth in FreeBSD. My impression is
that growth is easy to get right, shrinkage not.)

Others who really understand what happens when a slot table shrinks
and then grows may have to help out here.

rick

>
> The snippet you posted does not help, because it does not go from the
> start of the capture (which probably needs to be when the mount operation
> is done).
>
> You have to wade through it from the beginning looking for any entry
> that has the same session and slot#. (Sorry, I don't know a clever way
> to do this, if the capture is large. And, no, I am not volunteering to do
> that for you;-)
>
> rick
>
> >
> > I've checked a few of them in the capture and it's always 1 for the seq=
id.
> >
> > Regards,
> >
> > Rik
> >
> > --
> > Rik Theys
> > System Engineer
> > KU Leuven - Dept. Elektrotechniek (ESAT)
> > Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
> > +32(0)16/32.11.07
> > ----------------------------------------------------------------
> > <<Any errors in spelling, tact or fact are transmission errors>>
> >

