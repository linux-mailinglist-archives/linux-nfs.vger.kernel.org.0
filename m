Return-Path: <linux-nfs+bounces-4313-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B59917569
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 03:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0128E1C2157F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 01:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002C2FBEA;
	Wed, 26 Jun 2024 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWhVP8Qc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D0F9F7
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363860; cv=none; b=DQFjUqhKHXrH16Yjj8CguWpA/uN02RZhi8kidN8NtPLwoIee+lbixDHjr1Nnr2kyZ8iVRo1iyu/D8eFxBE+rtKfQfmmuS4HgvWFo95UVbNfY3H7SmTl8Hb2ODJSX6u/jnDB9QI7IJo8SD7TcW/LDAe6RMPbjATbhXMy/grqrdDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363860; c=relaxed/simple;
	bh=RanB83JCua53snnlKpBzLXmLJxpfunoD6Kv2toHIoX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4pHX4xbxL80LimlLFsipUPHbTRHntbKOMhDY6/hz/7xD6jLdY9kagUcWOr/4Clq1HxUZaDUhO6ya7dnvNtuaN1uVjYMMDdIdGZkHpcXP0Rn99C/uafI3QjrSzx9Y0ewp6n0yO+ZPimpa/uitP+aR5nX3YnEKV166o+NG/zaFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWhVP8Qc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c80637d8adso4149073a91.0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 18:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719363859; x=1719968659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zw2LEMFrFU4ANGwZ4NvKKxkhXCqFf3rZcubwBMnbiFc=;
        b=KWhVP8QcAHq6PAa/gZ1izFVn7/nUk4yR5vfMM4J86er2j7znAEOV9fsoCJ2zC1egni
         PKf9hUd0iF1zcODOZh4k01TTt/vqtuxj5mjA+ZF8rDUmApFzVbGBM3XX4adlRM/6VMyM
         Lm90xuIDbimEhDFt8Zaqva+RjitQm5KzlQu+8lvWWkwWNeU2vENTt4QItfscG4XQkK6E
         CYZDdleUd+gNpZnIRq59DQTdD9COIxkVEunv92tWy1syasamkp9v5rVVri0o8SRWk+Yf
         aWKdcBTzElpi+53Lkx+TTOi55uPdBcuPtBaP62F10k0kDgNYxkA3n1ujrv+FDjOj5y0V
         9jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719363859; x=1719968659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zw2LEMFrFU4ANGwZ4NvKKxkhXCqFf3rZcubwBMnbiFc=;
        b=dzhv9Z+or6MIMGw+MCM8uj3p2PTqQZoRRuQ4eVzijz72+Sd9fTRJ8dbwbneeFS0jx7
         2YRbs9n95E/QlzrKVMx9GQ2dU5uqnFRXfgotrwfIrHVcl9wSaRZkxgDJRO7pLuPHpT6T
         5mE57oBCGHLd/Bcx4Q6EMy3e2SbfnGCCO0u9jwUsVvCIyNrMJhZbN97GMbPAdQ/xDSLf
         ZkO86pjMYxe1kwq9Qhu0b5Ob48f4rrq1s5VIlGvrQeX1XB46aCogyuH6NjUb0tyDC7nS
         9aag1GBsynjwMucUlG2jKAUhkMxcKVsEge4skNu7l6IUDs3qI7KFIenCUFaCjgu09FE2
         O4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCW3BfYsB0agj9O0oMa6GepCCnNf+IJDzUO+FR5dLe5vYQ9Er+/92I4NwKpl8xUdiJfQHE2o9fh0ilOIPG75qzRipux7CzQ4K0M1
X-Gm-Message-State: AOJu0YyANAZzkeo734GYEKTN0kH7por1Fhdhf6iO+QnWOdkjTNbnpLhK
	u1vTOXjDb6ovbAaBMymWvR3rqI+daMyAh7ZrU3Ajn/25HFnIWLZPVPVQ9ZQTuS2T5mRR8x0J6rj
	Nbn9UgPWqa5dHDukdcFX+rdNDPg==
X-Google-Smtp-Source: AGHT+IF4BETg4WlnuzT53Gh/cdWBrtsjlDmAY8f5yoaCyRGV/AmnnbO7us8OduWzaQrCm0ScRX/M8h94LxecAuFgGGw=
X-Received: by 2002:a17:90a:1283:b0:2c3:11fa:41f with SMTP id
 98e67ed59e1d1-2c8582db392mr6904552a91.45.1719363858505; Tue, 25 Jun 2024
 18:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d489e2d7-d4ed-424b-8994-6abf36a01e06@oracle.com>
 <CAN-5tyFQpEdSnco8SZWY_nsZVdYhAg+x_EAMmbWW5uYutyDA9g@mail.gmail.com>
 <2f5cb9b7-3d8e-4ec6-a357-557c484431c4@oracle.com> <CAN-5tyE5XpM750=9rG0cfp4WHRxOtXAwvViVmc4kQEVnA1dmTw@mail.gmail.com>
 <fdd4e4ce-65eb-438e-88c0-2688b7fa196b@oracle.com>
In-Reply-To: <fdd4e4ce-65eb-438e-88c0-2688b7fa196b@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 25 Jun 2024 18:04:08 -0700
Message-ID: <CAM5tNy6eLnWd7vLU-K00OJsFxLpWr_S2g8fhbE0ZMMVgonBZZw@mail.gmail.com>
Subject: Re: ktls-utils: question about certificate verification
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 12:48=E2=80=AFPM Calum Mackay <calum.mackay@oracle.=
com> wrote:
>
> On 25/06/2024 6:31 pm, Olga Kornievskaia wrote:
> > On Fri, Jun 21, 2024 at 1:39=E2=80=AFPM Calum Mackay <calum.mackay@orac=
le.com> wrote:
> >>
> >> On 21/06/2024 4:33 pm, Olga Kornievskaia wrote:
> >>> Hi Calum,
> >>>
> >>> My surprise was to find that having the DNS name in CN was not
> >>> sufficient when a SAN (with IP) is present. Apparently it's the old
> >>> way of automatically putting the DNS name in CN and these days it's
> >>> preferred to have it in the SAN.
> >>>
> >>> If the infrastructure doesn't require pnfs (ie mounting by IP) then i=
t
> >>> doesn't matter where the DNS name is put in the certificate whether i=
t
> >>> is in CN or the SAN. However, I found out that for pnfs server like
> >>> ONTAP, the certificate must contain SAN with ipAddress and dnsName
> >>
> >> Noted, thanks very much Olga, that's useful.
> >>
> >>> extensions regardless of having DNS in CN. I have not tried doing
> >>> wildcards (in SAN for the DNS name) but I assumed gnuTLS would accept
> >>> them. I should try it.
> >>
> >> Wildcard didn't seem to work for me in CN, but I may not have tried it
> >> in SAN; I'll do that too.
> >
> > I have tried to use a wildcard in the SAN and that didn't work for me.
> > How about you? Specifically, I tried in the SAN
> > "DS:netapp*.linux.fake" and tried to mount netapp119.linux.fake which
> > failed with "certificate owner unexpected" (meaning certificate didnt
> > find anything match to netapp119.linux.fake.
I don't know if this helps, but at least for the OpenSSL libraries, wildcar=
ds
can optionally match a component in a DNS name or multiple components.
For example:
*.linux.fake could match netapp119.linux.fake, but not
netapp119.subnet.linux.fake
OR
*.linux.fake could match both netapp119.linux.fake and
netapp119.subnet.linux.fake
OR
*.linux.fake does not match anything.

Which of the above is true depends on whether an argument to X509_check_hos=
t()
is set to X509_CHECK_FLAG_MULTI_LABEL_WILDCARDS, 0, or
X509_CHECK_FLAG_NO_WILDCARDS.
- I made X509_CHECK_FLAG_NO_WILDCARDS the default in FreeBSD, but it
  can optionally be set to either of the other values.

I don't know if you guys use a similar call? rick

>
> hi Olga, yes, exactly the same here. Wildcards don't work for me in
> either CN or SAN.
>
> What I've been doing in my testing, when the host full DNS name is > 64
> chars, is to use the simple hostname as the CN (for ease of
> identification in e.g. "trust list") and the full DNS name in a SAN DNS:
> extension, and that is working well.
>
> thanks,
> calum.
>
>

