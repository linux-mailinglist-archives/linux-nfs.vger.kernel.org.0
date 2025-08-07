Return-Path: <linux-nfs+bounces-13487-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD705B1DC65
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 19:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B4616507A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE98E25DB1C;
	Thu,  7 Aug 2025 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRbJrhxX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812D3208
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587382; cv=none; b=A0juwqdOIlQN+aDlBU1GHV5BRfwQhw8EP+0GmM272/lk5+tiV6/KAABW2L+QYFh2qhg3r/0LeTTLqZVNRO7FhLkFOwNsmO89xiRAsJNN+5deWAZWEvyuQheXbWAELAaU3cg/Ef8cWOOXFEIXUAHuDYAfA+YtBWJ8PePVMJd8ybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587382; c=relaxed/simple;
	bh=0ne9adInAslElKAoqoqeH2yISf4OPB22MnqzjshGzMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vt0jUv26L9mffP29NmTF6ca5daNgJt36tYTDabxHIE5T9WidPJrf30/af3PkHfXw2L7Ya197alDTg9oLQTgebURN6cyleaZsQjylzYr0Xn9m0R9IpqGQGWtc3DDAGv/xxhedtxXGwk340baHm+lt2MCFnopfgXR/SrlGOrUFUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRbJrhxX; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b06d6cb45fso16005011cf.1
        for <linux-nfs@vger.kernel.org>; Thu, 07 Aug 2025 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754587380; x=1755192180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAQkiA8ntnnbbnkuYYUovCaX5gBUtvcHAIMPWia5+ls=;
        b=FRbJrhxX1oYMiS6LB6p3skQsCCha0cbVBCInETa7GrnJNakkKRA50tlBkinuiYzhX7
         D8te+ikD6SEoj99cUm4EzfT6ACWMMLp6x+gIuHMjaNVqAiVR3EGGUiShvHjpoKjMKwH8
         TWMKopAcwOEdwU815VkYrIfYPOv68Af9k1dDNMkrr4iZjgrIkrWirKp3EpyFrzKSYaEW
         v8gb7/rr2lHRRNLpFA6O21yspYJrxWtBQRcTyRjOXHf4u3OnDLmlgjr1nzVOTIOMUzcR
         fKTnxAexCtdrffh9RoFgHXZcJgEUTfUfrcDOBeLIFXL7iA+fLS5VuhMQogFVEew+81kL
         2MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587380; x=1755192180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAQkiA8ntnnbbnkuYYUovCaX5gBUtvcHAIMPWia5+ls=;
        b=ryuBC27W7GZ7xIJwq0LrvelHhEC2OsMAvuoFhQ62XEafvmCpbK8E37Vfgt/hIK4qWP
         ovVG0kY46G9BD/VmYGkZBdk/jbPAJhOMyWWEzlZEElwS1fcjGJTHSNuqVsCtXd3aJZqJ
         rxvcLZsjwXTplS9t/u/14R3b73sE45ypztWxD9CnCRyjgwtxXoMnZ+tdibOGKBdHgUmX
         m4UsbW+buShCv/R5nk42ybHLXcTpUF2gw0Kdn6y7yD+MWlQX2ztVdKskicQkjDtr1IZH
         RFZBbCsMzl8VzzUOHsKFyLWMhOWcdIV5ZP5k1shE6KxxC/FqLqwxMJf9yDNvydxD1/i0
         2juQ==
X-Gm-Message-State: AOJu0YxxtGKYpfaiEnKKmdZQ24GwHZ73h9oB9iSnEf3dOwqdNdYroKrS
	i63kvtbGpwWOBDFmMudn48jEqyxBiuvuM5yEG4Oyurt3qlyaChjE+nLWfZB7T1ipq6QqgQ8M+gv
	kreliEiGH/wg5QnvXMsxikaU7jF0KixTiZ+orwdU=
X-Gm-Gg: ASbGncvgUEe7g7p/+egamMCLC434lglsLB2e1nohtZSEFeAdPFnvWJvaQ4zWpLnAaAg
	4cioezc6IW4OqQr8ZYyV0Pe04zG3i4UFd7JQOWe7ToZ0cVd2mr5CFgOiiSoydMp5Z8chVGVHWM8
	l2X0rTQqUtUe40DlL8e4K8S331p0fp0b91twmLu6XRFRAajwXyonNBg7GQaY25W7rfQuPKckvGU
	PUvVWFFoHYwoCzHJF0=
X-Google-Smtp-Source: AGHT+IFAeSQ/ViWVIJyPgVNAJ7ehGOs/SJ/7ObuIKwaKRHx71xmAgZNhVLHXkRFBpfhnlbApXYXu02RI5iI2ygZdxzw=
X-Received: by 2002:a05:622a:1a0a:b0:4b0:6cef:19d2 with SMTP id
 d75a77b69052e-4b0aed031fcmr934201cf.8.1754587379771; Thu, 07 Aug 2025
 10:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALzt5Pk81rdgaBhk=s+cHEeSAP3rFrrsD3Q3Sx5rCsi_jkWuqQ@mail.gmail.com>
 <1473033738.919249.1754584380847.JavaMail.zimbra@desy.de>
In-Reply-To: <1473033738.919249.1754584380847.JavaMail.zimbra@desy.de>
From: Haihua Yang <yanghh@gmail.com>
Date: Thu, 7 Aug 2025 10:22:49 -0700
X-Gm-Features: Ac12FXz3lkv8BPmnlAjKcCuGjtI6b4tWhPlK5bkmA4DribFLIpP-uoQvdscodVE
Message-ID: <CALzt5P=Ls6AcBEvEFtCqw7==ZnR21tRJGDeDe+3V1jxArh2beA@mail.gmail.com>
Subject: Re: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayout Scenario
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tigran,
I forgot to mention in the previous email, after step 4, client also
sends a reply to the CB_LAYOUTRECALL. But when retrying the
LAYOUTCOMMIT afterword, it still uses seqid 1.
From what I observed in the Linux implementation, the retry logic
doesn=E2=80=99t update the request arguments, so the client ends up resendi=
ng
the same LAYOUTCOMMIT with the old seqid.

Regards,
Haihua Yang


On Thu, Aug 7, 2025 at 9:33=E2=80=AFAM Mkrtchyan, Tigran
<tigran.mkrtchyan@desy.de> wrote:
>
>
>
> ----- Original Message -----
> > From: "Haihua Yang" <yanghh@gmail.com>
> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
> > Sent: Thursday, 7 August, 2025 18:14:57
> > Subject: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayout =
Scenario
>
> > I'm observing a consistent failure of LAYOUTCOMMIT when the NFS client
> > accesses a pNFS share using filelayout. Below is the sequence of
> > events:
> >  1, The client opens a file for writing and successfully receives a
> > layout (stateid with seqid =3D 1).
> >  2, The client writes data to the data server (DS) successfully.
> >  3, The NFS server sends a CB_LAYOUTRECALL (stateid with seqid =3D 2)
> > due to some change on the server side.
> >  4, The client sends a LAYOUTCOMMIT (still with seqid =3D 1), followed
> > by a LAYOUTRETURN (with seqid =3D 2).
> >  5, The server responds to LAYOUTCOMMIT with NFS4ERR_OLD_STATEID.
> >  6, The server responds to LAYOUTRETURN with NFS4ERR_OK.
> >  7, The client retries LAYOUTCOMMIT (still using seqid =3D 1).
> >  8, The server replies with NFS4ERR_BAD_STATEID because the state was
> > already removed when processing the LAYOUTRETURN.
> >
> > It seems there may be two issues with the Linux NFS client=E2=80=99s be=
havior:
> >  1, The client should not send LAYOUTRETURN before receiving a
> > non-retryable response to LAYOUTCOMMIT.
> >  2, After receiving a CB_LAYOUTRECALL, the client should not continue
> > using the old seqid.
>
> I think this question should go to NFSv4 IETF working group list.
> Noetheless, rfc8881 says:
>
>    For CB_LAYOUTRECALL arguments, the client MUST send a response to the =
recall before using the seqid.
>
> So, it sounds, as long as the client hasn't responded to CB_LAYOUTRECALL,=
 the 'valid' seqid is 1. Thus,
> LAYOUTCOMMIT seqid=3D1, LAYOUTRETURN seqid=3D2 looks correct.
>
> See: https://datatracker.ietf.org/doc/html/rfc8881#layout_stateid
>
> Best regards,
>    Tigran.
>
> >
> > Would you consider this a bug in the client? Or is there something I
> > may have misunderstood in the protocol behavior?
> >
> > Thanks,
> > Haihua Yang

