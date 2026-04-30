Return-Path: <linux-nfs+bounces-21306-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM5oGRNw82m42gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21306-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:06:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABE4A46CF
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10218301176B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8C19D074;
	Thu, 30 Apr 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duK63xnY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8731D555
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561387; cv=pass; b=DDoWA+pO3mL2wt58kN57RgA26GrzCDi7PxTMk7HGVV2TVD+5YvpW8iPPZUKpfN+uxK1QrHD4/l2r+FfEUYKScT7zxJm8J/z6fGIhDZ6F/K6G43TQcxv1GcmkZi9Ddv5RpixWw5xtV1db86BVyKWrog6sFixzZsdLhQVC6//I1X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561387; c=relaxed/simple;
	bh=HXcTYJlYg/JOffbCCfmdJ7cgTDAvs//yo63mUfHqAAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugPNrZCbDHIDdpkJShrNrorZM/MG+Y29o+apaHE0OoWTDGCGM2alsRSzjYWTUYZ1ukC+QcqusJH2y2sGBg6XM1tsedUzy5DA1dEcqEjiPfrzQYSxuRlJgG6m2WiW6PlrkRbbZE+u0pBYpqK2o/R2KxxRcfLUgaAttLW8T+JFZe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duK63xnY; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67b7c77865dso535303a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 08:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777561384; cv=none;
        d=google.com; s=arc-20240605;
        b=N1tSJziqNFJ2x1XrTbOVQ/Jgfl28XyUJvU00H0R4pbuFBQlCXTiULRtotGqdhy2Kn3
         AMPaZ8cZMwNq/vPgZj3WYVi6lF+6BvtLboJ5ljQ6EF2n1B3zlAFcHdy/cAfN6/tvEkrY
         l+gK1CMLQ5KzW6zq3BNiIhXC0PDyYBFhGLfV4XX1S5KOn2mLqsTfzPW1ieLUolbHcDtr
         N0huNtYCfjOzeSVru5qR3gsVVLG8KRHKg+SlO2dsPGh6ab9bTy/G2MFGYOGz/yIshAKh
         320VesV+ZgVKSclm0HCz3yQlwoP7bhOwSHxUXn5wcmhZtOh3h4LP7Lqwe2wv5V9V3Wao
         0ATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wc2SHkHMJ7Bkl/rwiBKp8hiEXyNyJHHZQC8+Y1YMBVU=;
        fh=nAvpV1wxSpB/q/btRXHAu52ZuzyM8eCywc8Uzk3Zup0=;
        b=I67DTkZ19Hj3aNM6fr1yJdWxTAH862OT/CPwPQgoooEd4pmBF0OSi6mzlO6+D7TTeM
         k1prOx15dI0vZbeu61B/xT01leLvUw+oExDQG2EAR+F52TlUb7cvBJmRT2N176C5Sw/7
         b4uO2ncymXBJVGU7VCYWTh+pkT45o4zmoYkn8nMsq7MXOuAZDlrjxlkECOa2/fhGsKfv
         nPc6TE4KrEQEfwYQjXnC0ZFzH5wpj/EMhzF/M2usmlu5gmFj8L7O9Uinp2+6xriSTYSb
         TP7h1/MVDbx7qhzzoE+DECt9OXYTGP0TF4rrcraW+sxePn5wxYHp59VEdaOpZtMTVkGo
         P4Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777561384; x=1778166184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc2SHkHMJ7Bkl/rwiBKp8hiEXyNyJHHZQC8+Y1YMBVU=;
        b=duK63xnYSeEBcyySyFoeFF4lkZxJ7p4xA65AVfa0GVaQCES3Ic3jeMYPkgKFdlY4oi
         T5o9/6tR/RSmWymtjrnjzlhQIcVUSGbAHPjFcRKlhtAWVr8bxZ9Sf7D2XmFzcAoJbx7l
         NNVJZlcfhmrRuZaAzBJD6TkXHzR56xY8/AXI819UbXlAayWWP1KD8/kIe09lFpCp7Hju
         W6Zi/NJpLtDZoHfFUoXMn79Fpr/AlXe6YtYsPzl35AL6V1ZHm5jxIkraww8DGdmE+pP8
         UksusNwmIP8Moj54w3qsRUoAicotz5NcvHylTHxLz50Wo+o9HUrytyKli0kJTxvVXGow
         lqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777561384; x=1778166184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wc2SHkHMJ7Bkl/rwiBKp8hiEXyNyJHHZQC8+Y1YMBVU=;
        b=SE7YsaQcXQ8twroJw7pKDMCy/heWwnUYw/+axsTzO+nwh8oQzi+VUqYVCYSB7ycAGm
         AebrbrlmniUEUYPjGfjzNrwo4JztWorpjjPfedHlyP6CwMjqcI+Hik/iG4OF5qY4lQrD
         ymRTe5LE7vQrT1cOWCgbbIIYN5wHsXXnZYKtbNZgBhFns9bEa8ACXWyD5ToIsCmipSMS
         KtzgUW/4DIIYvrZVN710ow3OBVsOj+Y1Id9on6VVkyJzltA2W08dp8ko/UaCVn2Im2s2
         Su0Tq4vVW8kVWhhjmWTWnaQYVM/0NEXpJKWXfmGPANab+qBcAbB7ck4OueAgh+0JMvXw
         Fz6A==
X-Forwarded-Encrypted: i=1; AFNElJ/BA5RLFYF/B+28xi6U4Ys+Bi0yJXRiLLXwMegSWoaAmdsyopRvC7gWtEkPOiG6zQdGLd2/ssoNYxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQdBFgHIUvugO1ogpH/wdlTX5QixATShqTxESSywtBYMYZs96
	lAS5YzTmUVTIn5upqtWH7qZUJOukLKyGQO0e+L+wFf4X3FUlLeRlbVFAoLs4XVeI5+VwlM5vvcr
	2xcav5xSQH3KynNbPGDYnqLDsNnsXogMD
X-Gm-Gg: AeBDievPr2Zb69m7traUnAzLPrhT2mGrErfHFGCAQVATYFGD22OhA7VBUrYTa3uzRFo
	R0U2QHzxDmZ82iZuZrrfZK/eAdYRnROkqeiAeuhBYreGU+mK5ZzCnfZ9MhnuztFEj3J9fsJI4xl
	fw8sjipe5XlHAtJ/k9gUpXg3nNayr3NiREH0EciFTpWe6zA4jDnGVeIlKzkcvSNQRZETOF+51NT
	iDd74SvI0ZhcivWIWcamV/z76vEAR+48UnC2+ClVeQ5SztsTpkFbdL66WMi0daCv1tJojaRD4uk
	bU3M/Z3cJgy+DmOyrfmCWs6mHD5KGV0U5nSeRlc7CaaR0W6qpg==
X-Received: by 2002:a05:6402:210f:b0:670:8b30:a8a7 with SMTP id
 4fb4d7f45d1cf-67b5d69c49cmr1891491a12.0.1777561354090; Thu, 30 Apr 2026
 08:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
 <CB5BA5C0-15AA-49D0-96B9-2017F6617903@hammerspace.com> <cf6fd710-e11b-425b-949a-d5acb509eec7@esat.kuleuven.be>
In-Reply-To: <cf6fd710-e11b-425b-949a-d5acb509eec7@esat.kuleuven.be>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 30 Apr 2026 08:02:22 -0700
X-Gm-Features: AVHnY4KmlQ06JdsDMC_pp-9f3J1C7ijOP9PvU35VqoU3ziAjiGMgb_U--wTDnac
Message-ID: <CAM5tNy6rbQE-QDGD9-YffYn0Z+MsaCNOOpHAetnBKbW7Pn0_dw@mail.gmail.com>
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>, Linux Nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C5ABE4A46CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21306-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,kuleuven.be:email]

On Thu, Apr 30, 2026 at 7:26=E2=80=AFAM Rik Theys <Rik.Theys@esat.kuleuven.=
be> wrote:
>
> Hi Benjamin,
>
> On 4/30/26 3:27 PM, Benjamin Coddington wrote:
> > On 30 Apr 2026, at 2:53, Rik Theys wrote:
> >
> >> Hi,
> >>
> >> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo) t=
hat is an NFS client to a RHEL10 server.
> >>
> >> Lately we've noticed that NFS performance is very poor for certain wor=
kloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and now 7.0.=
2). For example cloning git repositories is extremely slow.
> >>
> >> Looking at the server side there don't seem to be any saturations of t=
he disk or network subsystems.
> >>
> >> I've taken a network dump between the client and server. In that dump =
I see that the server frequently responds to requests from the client with =
NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these mismatches=
? Is this always a client issue, or can this be caused by the server?
> > This is something you shouldn't normally see and probably indicates a b=
ug or
> > serious problem.  From the client side you'd only expect this if you're
> > doing a lot of task signaling so that the userland processes abandon RP=
Cs.
>
> Would there be any indications in the logs if this is the case?
>
>
> >
> > A packet capture is the best way to determine if the server is mis-repo=
rting
> > the sequencing problem, or if the client's sequencing is incorrect.  Gi=
ven
> > your description of the symptoms I'd also check to make sure your under=
lying
> > network isn't doing something totally nuts like duplicating packets.
>
> My previous capture was on the client, which is where I observed the
> NFS4ERR_SEQ_MISORDERED messages. I've now taken a capture on the server
> and there I do see some duplicate packets, but not a large percentage.
> Should the NFS server not notice this is a duplicate packet and ignore it=
?
Maybe it would be helpful if I gave you an explanation of when the server
should (probably a MUST in RFC terminology) reply NFS4ERR_SEQ_MISORDERED.

The first operation in most RPCs (for NFSv4.1/4.2) is SEQUENCE.
If you look in SEQUENCE, when the session and slot# are the same as a
previous RPC, the seq# normally increases by 1.

If it is exact the same seq#, that should be a duplicate RPC (rest of RPC
should be identical) and it should have been sent on a different TCP connec=
tion.
This should not generate a NFS4ERR_SEQ_MISORDERED error.

If the seq# is any value other than the same as or one greater than
the previous RPC with same session and slot#, the server should
reply NFS4ERR_SEQ_MISORDERED.
--> If this happens, the server is behaving correctly, afaik.
      Then, is this a client bug or a client feature?
      That is more difficult to answer and maybe the Linux client
      specialists can comment?
      (I'd say it's probably a bug if neither "intr" nor "soft" options
        are on the mount.)

rick

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
>

