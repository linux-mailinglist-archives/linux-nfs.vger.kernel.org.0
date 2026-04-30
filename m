Return-Path: <linux-nfs+bounces-21311-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDZtA+1282mt4AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21311-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:36:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D684A4E2A
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98C733028E85
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1512731ED7C;
	Thu, 30 Apr 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0M0pTcD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852320E334
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563329; cv=pass; b=uY3zBGj/YaET/E67gn4y9xG58toISDtFAi7FzkBfyJ0WjtY/vNDapwZ1bc86x643+AYovO0kPgZTRc7NXxSKO+kFU2LyKPX+PvwpmHvrkGsfHHs4OCsRE9Nm+WiYux1rgcBYvrXFr3xYoYrhycapOzhylIq342s6v2CBh414tjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563329; c=relaxed/simple;
	bh=Yj7/nxx+XD82W6hviebfJiP15W37SyFcLLKTPxtkp4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mc1Z9vl3ra6fepUeR7MX97brSOqT/Ytk1mv/Efwa/NagnkeiHSCzOl0wua9C5Xgt9Zj2zADhjyLvXz+GYoOU9BkxJWqBoOFUxJIIi9/rvgBGQHfdr5ktPU+84Ot9S1rd8PanzGYx4A/6/GF97Ctt2MiEatLEjIVdooT5XaJPEnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0M0pTcD; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9358bc9c50so157177366b.1
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 08:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777563326; cv=none;
        d=google.com; s=arc-20240605;
        b=I5Lwa0ju+jG+ZvRKG0cQEcGri68Xu98Q2jJGchGAjuKdQdSYnycSn3l7nw5MT+5R1o
         GeG4LX1uql0q60w7jO/DS9r0L+QzWkRKI1cu66sdZTqEkEi2BRS++eZewp6VhkPWFKm8
         zKPlW6okMtlRB8Qa9WKLwk+qxdcxjjnqVnh0cOFNEiCgP0VcwY3ZTzGbSAa+MdKnKulm
         wtUgjUwSd0tII70opCkGda5cY8J9IK6EDMmI0fdZz3RbhUOuMhWjnoXXATPyHlR9DcgV
         /BWPT3EVsRbGc+D87vYDKadlWcshaX6th2cN6Lsi3nQgI4jpYige2PGlZDvSfAyXoNGp
         ftQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k5oj0V4W1uOtbSGW47HJAqzc/Y5yOk7s4YxDCsWnmWw=;
        fh=yQIaDcQLFR4Wo6LgTkjVf6dzGh30IiFh8vLuBy55Sfo=;
        b=R9iM+yFYrgqL2oLmtPlrGfeN/5DZe7Hn+NkmktvwrJugk3QKvtZG6lrvzEN/g9IbB8
         cmaNLfQGOs9HqLSRWkSa8c5V2CjRH28bAMVrH2NDGM6ohUdPYKnYiRxpomra34ZUg4t6
         SZ8rp4XNxtzC44d6vDFBio7QSfRebCf/a70jRaJjwCLW3rlcZ+v4w9TdpIrtMM5WDzOb
         V6aClSeEw8QYTcF1nAfJUdH0wBkB2GQP31Ky4ZJN3PusSdh46Ai8GWWZyfcYD204kS6l
         8AWczToJFmhdBc3W0cJZFq86WIU0A3nrk/0KYuB30uTCct57v9YIjYM9Y6qaeKiTl4/A
         heMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777563326; x=1778168126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5oj0V4W1uOtbSGW47HJAqzc/Y5yOk7s4YxDCsWnmWw=;
        b=U0M0pTcD28BIdsSf7fQr6E/hZpvoxBZ5AzxlwowuZ9T0ngevA5DhjXEElmEBHD6UO5
         ilghl76Xb8PjXd6P5IAL1aFmAZc7dlk5HyX0/tWQD0PLl4W+POk0jz3j5Isf1DPaeLEW
         2jvSV+voIfdNXato4SZmEKAElL2MlIcWONi/TCJKkPVmTAOS+p9k35I8okNHkfrOqd+s
         0pcsDpkxGqe/VaXkkD1BaYVtMT2ORs4vVSlc3VZxbnIor2tr7nzwgxSn1rhwUdUD7iFo
         1aLoC4wsniN0dYW19eS335TdQnNXapAKsw85Vyj60Y9MXIUyNQfa7l4yLUeRJycDfpFJ
         n7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563326; x=1778168126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k5oj0V4W1uOtbSGW47HJAqzc/Y5yOk7s4YxDCsWnmWw=;
        b=MNqmxsGMfEdNbGEJ3DRbsJ7A8kShH0sCJqocXUC79fXd+rdnjRJ5A7VxZbd/RyvWdu
         BzY85oCmNPRJgvUsHG1FAMTQhvowXZH0rRKGr/NwUTED0a/94NKLU3Ljf9Ay9gw+SjrZ
         cn34a6amIdYnGEDMgf6TmvgPnN9B36xFFwVluK2axsX3INBdX+VwOmWoE+741HaINYG8
         fpoVU/NvtAhqKZCpvIvB4rDYpXSAC56TiEp6cD+NWe9vXBCpd6MfsS2C/idn/DBu6mf7
         mZlkzkf9TEsTzEV3tJJy6BYUVhWcLxh1S31aL4kkzciUjSK4BNZRD2vMCGKj8XEjxWm4
         uovw==
X-Forwarded-Encrypted: i=1; AFNElJ+JD7GvS895Eu4js6oUoSC7s+er314yLrNuyCOuXl9Ss5TKrLqRvna68vyJR6CltJ2RgKfYdIWQ6s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+CQboassV1G4wdi+6YuSFlRaoKy8tOkt0fw01G2H8Xeq6exL
	vv/TYsURZliTHLR79o9pNFFicwcCBqXqrPv+BZiaZakkk7ro0ZkBNjClbMk6pEzICvIYc1A0JRx
	2SWbgGxGY2OYKyESVHu7D4B0pjGUpf3iO
X-Gm-Gg: AeBDieu8QAT9C4pKYa/nlH4rLJhQSE6eOAhZuI7TSwd7vAF0GkmDvTdwWdoO8/9uBTR
	fXe/TgknK4WYAfMaVesMZb9wc79/OWW3zPF7wgTsADOWesAQXAV8HYIb2nOxwadJlJnu8z9LKbG
	hE6sow1DXCg80iBcP7XagKEfyIye/76guIMoUM6KWjW5ISrdEbrkKiGlMclc3Barn7qLgo3bPpT
	bdlYQxfMqG1DwvgpliPObBwmwNOZiTGCsLQyV0aT4u3V6cyUvZFUsPj3G9Vm13l/QkfNBYl86na
	1MC43BACQGkxTCnaqS2Ajxp9Ab+137KE815gX4gbViNZojRMQA==
X-Received: by 2002:a17:907:a0a:b0:ba9:2223:93a9 with SMTP id
 a640c23a62f3a-bbac9b47600mr258299366b.33.1777563325597; Thu, 30 Apr 2026
 08:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
 <CB5BA5C0-15AA-49D0-96B9-2017F6617903@hammerspace.com> <cf6fd710-e11b-425b-949a-d5acb509eec7@esat.kuleuven.be>
 <CAM5tNy6rbQE-QDGD9-YffYn0Z+MsaCNOOpHAetnBKbW7Pn0_dw@mail.gmail.com> <3bee225b-3a3f-47a0-a38e-ce08196595ab@esat.kuleuven.be>
In-Reply-To: <3bee225b-3a3f-47a0-a38e-ce08196595ab@esat.kuleuven.be>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 30 Apr 2026 08:35:14 -0700
X-Gm-Features: AVHnY4ImwqAUyT_z9zHeIaDZ5YfKYpbRwpgnNLj8HnibUNtPjZfoIYDDDx1vZKg
Message-ID: <CAM5tNy63vtAAh1DsBFgPMiXDZReUCimR8nii=WFiAUv8LsJctQ@mail.gmail.com>
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>, Linux Nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 74D684A4E2A
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
	TAGGED_FROM(0.00)[bounces-21311-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kuleuven.be:email]

On Thu, Apr 30, 2026 at 8:27=E2=80=AFAM Rik Theys <Rik.Theys@esat.kuleuven.=
be> wrote:
>
> Hi,
>
> On 4/30/26 5:02 PM, Rick Macklem wrote:
> > On Thu, Apr 30, 2026 at 7:26=E2=80=AFAM Rik Theys <Rik.Theys@esat.kuleu=
ven.be> wrote:
> >> Hi Benjamin,
> >>
> >> On 4/30/26 3:27 PM, Benjamin Coddington wrote:
> >>> On 30 Apr 2026, at 2:53, Rik Theys wrote:
> >>>
> >>>> Hi,
> >>>>
> >>>> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo)=
 that is an NFS client to a RHEL10 server.
> >>>>
> >>>> Lately we've noticed that NFS performance is very poor for certain w=
orkloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and now 7.=
0.2). For example cloning git repositories is extremely slow.
> >>>>
> >>>> Looking at the server side there don't seem to be any saturations of=
 the disk or network subsystems.
> >>>>
> >>>> I've taken a network dump between the client and server. In that dum=
p I see that the server frequently responds to requests from the client wit=
h NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these mismatch=
es? Is this always a client issue, or can this be caused by the server?
> >>> This is something you shouldn't normally see and probably indicates a=
 bug or
> >>> serious problem.  From the client side you'd only expect this if you'=
re
> >>> doing a lot of task signaling so that the userland processes abandon =
RPCs.
> >> Would there be any indications in the logs if this is the case?
> >>
> >>
> >>> A packet capture is the best way to determine if the server is mis-re=
porting
> >>> the sequencing problem, or if the client's sequencing is incorrect.  =
Given
> >>> your description of the symptoms I'd also check to make sure your und=
erlying
> >>> network isn't doing something totally nuts like duplicating packets.
> >> My previous capture was on the client, which is where I observed the
> >> NFS4ERR_SEQ_MISORDERED messages. I've now taken a capture on the serve=
r
> >> and there I do see some duplicate packets, but not a large percentage.
> >> Should the NFS server not notice this is a duplicate packet and ignore=
 it?
> > Maybe it would be helpful if I gave you an explanation of when the serv=
er
> > should (probably a MUST in RFC terminology) reply NFS4ERR_SEQ_MISORDERE=
D.
> >
> > The first operation in most RPCs (for NFSv4.1/4.2) is SEQUENCE.
> > If you look in SEQUENCE, when the session and slot# are the same as a
> > previous RPC, the seq# normally increases by 1.
> >
> > If it is exact the same seq#, that should be a duplicate RPC (rest of R=
PC
> > should be identical) and it should have been sent on a different TCP co=
nnection.
> > This should not generate a NFS4ERR_SEQ_MISORDERED error.
> >
> > If the seq# is any value other than the same as or one greater than
> > the previous RPC with same session and slot#, the server should
> > reply NFS4ERR_SEQ_MISORDERED.
> > --> If this happens, the server is behaving correctly, afaik.
> >        Then, is this a client bug or a client feature?
> >        That is more difficult to answer and maybe the Linux client
> >        specialists can comment?
> >        (I'd say it's probably a bug if neither "intr" nor "soft" option=
s
> >          are on the mount.)
> >
> Looking at the capture it seems that for the requests that trigger this
> NFS4ERR_SEQ_MISORDERED, the sessionid is always the same. The slot id
> varies (maybe these are different mounts all using the same tcp
> connection, or concurrent I/O?). The seqid always seems to be 1, which
> seems odd?
The seq# =3D=3D 1 is correct if (and only if) that is the first use of that=
 slot#.

The snippet you posted does not help, because it does not go from the
start of the capture (which probably needs to be when the mount operation
is done).

You have to wade through it from the beginning looking for any entry
that has the same session and slot#. (Sorry, I don't know a clever way
to do this, if the capture is large. And, no, I am not volunteering to do
that for you;-)

rick

>
> I've checked a few of them in the capture and it's always 1 for the seqid=
.
>
> Regards,
>
> Rik
>
> --
> Rik Theys
> System Engineer
> KU Leuven - Dept. Elektrotechniek (ESAT)
> Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
> +32(0)16/32.11.07
> ----------------------------------------------------------------
> <<Any errors in spelling, tact or fact are transmission errors>>
>

