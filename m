Return-Path: <linux-nfs+bounces-21304-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO4eIJto82ky2QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21304-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:35:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DF4A41A9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD2F300D960
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A536C9C2;
	Thu, 30 Apr 2026 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4hs873S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68842668E
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559704; cv=pass; b=qVeGfdhMF4lpZkEf2keZ5O+q2TprXrzOWLsEYFIa65ZbKEPKKVK288h3DZc3aBxNdZ3Za8HOMpYLJGIFMZVFB7CkZD3aL+TwHQYlFwWZVWJSLLh52IXIWKpIXbTiJLAn5yiXyKD8wswkvmKxHNL3OJEJTzhpK/QgaeWlQMxjCrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559704; c=relaxed/simple;
	bh=Fy8ZtNPjCW1mGJY3zPBpzN/COMHnA7ElhrQ+y3qBUvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROdVvZesV34d/LkLgEpo588UwSDSfwcPrAlvzIaFtARCXLfkLVUeqgmil6oD0awjAFJ2QP8lm+cVnkkGTeiMUQSUaRG0b3mgm8wMa9tN9VuOtQC+UDJm0JKZUj0j3GuEYBH4xkf+7b8dmKB/izwJ5YwA0LFRIbOaGbAHsybfN8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4hs873S; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501725d888so842506d50.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 07:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777559702; cv=none;
        d=google.com; s=arc-20240605;
        b=IOWCAS87sZlNQ/uJW9+h7fbv4DQW5Y+WPJTEqO6iIRYswRlBUkD3/+HlSZ0mBovALf
         tWVYe7S74QRFPsDn8/5CTc3r/2AoO/iRQmkBrtNuxvxoCuctL02PvRpJlF04nQMRXn4d
         fuG9gG2hg3MHDdo/kos8HLxClhnBMi8TVKo0t01/FftU+KN6GLjSLeX6277xOlFFf1Fi
         o0gkF9usovTgkBZm6631pgluVCpVUlOA5jw9gmKc/bPxL9w5S101BEBJi8n5iMs/o2CG
         zKh/T0mf+Fw5QftoX6+Vpbx/MXpB+6yh1U0wNi49qFU/oIOwLT3HgPmg9jXiY+eLGH4D
         0dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f9WLVfwxIH9uSoGVtrrlQYpWwsHIK1wdWnj9/ORawtU=;
        fh=v+Uf6WfrUu2vXidSRGwVhqepOMjmZd2euL/20ZDCWfc=;
        b=cwhoZ1gG5aoyLprFEN7FqcTjUvywjHAKvuYHV0l+SHPbKcAN3seUO2jHkrmyCIO0JO
         O+zgCrzLsok1B8fLC3IbjsnICQAjf75sTqz81w0CGIlN3txV2G5F/H7z0DhVJ2qLd2jv
         KQiqn5nJx2dbgMNpy5nGMLtBHoMIDE7qGfEm9aTCxIc22F2pAt6/+0e+IBHJcvkS1Byc
         PxUex10aHCs9GGqZiE7Xz27XtKGn+5hmZvqAqcu2HHiaaU2wLHG8b5r1w4dxq+oY1bJ5
         OkoGL3Ad4gpaLoO3ve3ye9L7n3MFX6nYndivrVd6N+jLDBeZwGK/bHtefcfjL62pHFq4
         oMcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777559702; x=1778164502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9WLVfwxIH9uSoGVtrrlQYpWwsHIK1wdWnj9/ORawtU=;
        b=j4hs873SUUHE7qIjJtbfQCYgMRjfvOz+i99gV5BXDwdYTZHZu51Zq3jwfHAQ43aKgk
         ZhCrSaA6DU3lZOLZqDhsM8O+aA0FJ34Ux6fnbErN5dhwuIl6ieTvVxFfrZeWR03wgKs3
         E5cMGBw22XnciOWr9kM80vnJFPS3kBzl204gPyYNUuiHTPFfwtpYzqRsgeV5J4l2yPSd
         jE0bKGZJVFxg8FA52NspWgymzT6g7pM+wnBvyxtE9YvX/M1Z4uk+fQJXUrqb7mjODN4S
         zHdcqyRUs0Wm7Ky57H/tBgMzSXPWDKuJYgWe89DnSlzf88eMn4BjwToMoIZ70msVRqx/
         pg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777559702; x=1778164502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9WLVfwxIH9uSoGVtrrlQYpWwsHIK1wdWnj9/ORawtU=;
        b=UF75pgaBr0nrJxRBY6dXvlIlGFrPemGHVZoSVRfXoeVCiu8IauCMNb1T189OwzgbZ7
         UE26zQyS9vST7X/3xX2qNmThS3Fa19gtq1wusW+nffb+5I1CzAgUjnj7uYAFNVYbjpNJ
         izCMMYCeZ8EvddW7+9XaJTWU6Tn9o1+pUDsuXtbZQwvvL9WlmuazY3yXxzbqYmNUwN6s
         ierNO2OR2J5AB3+mityayIUTKFJXled3OXoqMH+Xj/wbk0HDewWrQx9JoiGMN9NCoaiq
         aCBxokPvRFVOsXVIDJPe74ybbmAUYr3JUpcS8MlkAzIrD0AYGYss2BglS4WTTc2Z7BH2
         8Qvw==
X-Forwarded-Encrypted: i=1; AFNElJ+tdIcOfFD6sLdn4wLEXbKwp3khFwxHZmuwtToeGo2aJYgZhxudL1ccZWNa3m3glg7EEXkO+iCOKlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8EqJe+f8fR7HoN7VHrmtucAqORNl8YQ+30OmxwAxu2gee3Vn
	Iy4ruBnG9lfoAltLMMX092Hf3y3Hh4uwYtN9pobNgXyxy8ySPClLUa5jOfBJDOaY/fH2ZQUnsDL
	u3B3IjrnC4SQ1lpoUfgtF6tFO+bk3hTF7
X-Gm-Gg: AeBDietuoMjZB0oz1gfBcFJ/BkDeOjo+jE2eXLvC6TaxSGR8H/ZOtZ72jLJ4BaweDZq
	OPikeXr1Ww43Qcnf7rzF7kuchDxT9GAkKLEwWpFtqPw5d5BJenejoG/53G91WnkJwUNSHSmGndO
	zsc+pAC6C4KtQTPlMsTCbrxRSUTwHCBwAQ5s5VH9U3jiey93H+hqEbbttu6mfUKPC58rtBqaE0U
	z//2337SrhoVirRpA31Nv12iiF5uliwlOsthTyEf1fkUZJa78FWkXVCZlYMybVpU7PQNX9AvCQU
	8I0ebuWUtGPVwUVO5UpHyaBWiwhUnLSUnzWjj1ia5l4kE6hTZsrPEJaZkvxZ
X-Received: by 2002:a05:690e:2285:b0:651:c6e0:6be5 with SMTP id
 956f58d0204a3-65c18c71022mr1948392d50.18.1777559702090; Thu, 30 Apr 2026
 07:35:02 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 07:34:47 -0700
X-Gm-Features: AVHnY4I8bo0Cci11esfXopKIYYwFyryqfAnYFyiI8-dg0mz7_s5elCWdTD2aJwI
Message-ID: <CAM5tNy44_s=4thbohL=mX8rdF7gwNyqLPGKBiO9ncd-0Aw+s8g@mail.gmail.com>
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>, Linux Nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B74DF4A41A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21304-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kuleuven.be:email]

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
I don't know, but I doubt it.
Are you using either "intr" or "soft" mount options.
If you can avoid those, it might help. ("soft" with a short timeout can be
particularly troubling.)

rick

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

