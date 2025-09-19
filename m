Return-Path: <linux-nfs+bounces-14590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 294B7B8779A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 02:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD04B7C32C2
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 00:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DAA1D5170;
	Fri, 19 Sep 2025 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBpfnA9e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F81A2C0B
	for <linux-nfs@vger.kernel.org>; Fri, 19 Sep 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758241898; cv=none; b=dnIJ6rFtL3UBjG3Fdy/m7+KUtfo0G2+wgFFYSOoqCC8gXNAKxT8wF0RDxisM7nuTadNa0a1o+3FVgOP94r0/soFS04cnohSiYGHkzBqkuXxKoJNnPJFDzJoXfKeyYqi8aLH8juNMoHTf3Gphbu2eCZuAVJ6FZzKwLaLz0e0DE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758241898; c=relaxed/simple;
	bh=ta84hi8vfmNKKg/K/M1kYEhTjSoRASeKBQQ3jOhkjQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdwV+7KadteqG6MwyAxh1a2ctgxukS99O5iBeaVIBZA+k5MptLu+LZ22H2gmq67DsizI0SkgNXunsBxqTjsAJKOyBMHZo6ob8SqEFYaX5yerOkY8An/vNx9W6knsuRGNaVedbAzR2MXDgQ1SYS/r3wJetgLRFTuX/Kzb1A3LSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBpfnA9e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758241895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EbKxXs7P70mzuP1FQtd9qzl11t3hb9wmi3bXREbnrE=;
	b=NBpfnA9edU32lIiAGMDrpnvG7QDU8BN6NzclfS18UTQjDrVRKtP44rrweQkDCUBW5ttBch
	boZJRplOVgM2m96x3zG4G7SCTRacWy9IWzanXRi4FWTxjpO1LLMPIpiqmuk0G+LbP56UVY
	RorJhAKMbZ59Q2RtJWNyaD1V+isgdnw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-pfRWc7teOVmSsqGpSd01Sw-1; Thu, 18 Sep 2025 20:31:34 -0400
X-MC-Unique: pfRWc7teOVmSsqGpSd01Sw-1
X-Mimecast-MFC-AGG-ID: pfRWc7teOVmSsqGpSd01Sw_1758241893
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b600d0a59bso7175341cf.0
        for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 17:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758241893; x=1758846693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EbKxXs7P70mzuP1FQtd9qzl11t3hb9wmi3bXREbnrE=;
        b=Nrhje8Hu1mcjCbre0EJy2hwxskcIxodmnMgALkgdoh7BurfWFaseQKg2vIClWXeGBi
         khqbv2sDYmTf1I6frlZNLp1NKuVagWhiDP2S2G2JaTsDBniR8JBG3iFzOKC3nD/TdQ8j
         XJAY1hUzpe+3DwRU1MBpT++lPDTZ2VPnnauZPdH/iPU8I6ZjiP8RXwT66+6kB+QLEme6
         s8yI6//VxFWus9I4LAqZ7CHJd9JVQQ1I4qN5fUbAmLd0YcbsOKQNJKXwKssgHRKIJvUV
         ELgkzS5bdkZAT6qb9E3UOkMDDDZMjBjR0fj9DSPm9oMBmLNs7z8H89LgROY+/C7ra6m2
         7Umw==
X-Forwarded-Encrypted: i=1; AJvYcCVVcM0OBZgwlJ+WceVysR7ER4vxQ0qRY+H2CjaQ1RgN4vzlDChY4Ojcw9yTrxLY95/S16OKnkgYn40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcFZBhipfGLZ4B7d9cJR45q7g/h9YVpK+ysbc5ZVcqcB+bRrT
	nZjaVIJQv7dFmoUdhKeC+1AdxtXjLPSBo4Smdp3DjLMCUpfrxYuZ4cDLexatM8CwJ/pglEWmFn8
	e48/pGumcLNEKcUQnfDDRbuMcz9sCkynKLrRbra2dyo6cfXQpjXxY6rt3iJFUwhiRHKPgNantDL
	xrN1h2z9WSEHEh5pMKr62ImnQysu6/B4qJMD3b
X-Gm-Gg: ASbGncuQrrwot1rUeyMZQm8szCT1EA0Euq39FcDpTgPLCPf9gJWaok83KyE48pb0oNu
	naDeyyywgMFvy/E6RWQUhflIqCPfomhJhKJQ6EQqHcbP79rjD470dGuR3UFhjwpDBw+JrcFUwY+
	n0Fs2w/xLxqfRLvY2aVRQeg3NdgNBI7PjrK6r5a0el+RoqPMeBiRhskkwiJBim0922zQ+QcjkKC
	x8Cq79M0pbRXckBvuXJFMTr
X-Received: by 2002:a05:622a:592:b0:4b5:d5d7:ffc7 with SMTP id d75a77b69052e-4c07285c31amr11578701cf.13.1758241893564;
        Thu, 18 Sep 2025 17:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOF7t/GOh+pz/auEaRWMJjUb9HKwbfFG1RlDt5SeM/WzP2D/CVmIjgpu10Rz/d+zn01GyXtpN3lR/7JbFR5tQ=
X-Received: by 2002:a05:622a:592:b0:4b5:d5d7:ffc7 with SMTP id
 d75a77b69052e-4c07285c31amr11578471cf.13.1758241893044; Thu, 18 Sep 2025
 17:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918024638.3540302-1-jiyin@redhat.com> <171be190855386179087a52f713a9a0b0f742528.camel@kernel.org>
 <a814a6f7-43fc-4b80-af5f-91273a00394f@oracle.com>
In-Reply-To: <a814a6f7-43fc-4b80-af5f-91273a00394f@oracle.com>
From: Jianhong Yin <jiyin@redhat.com>
Date: Fri, 19 Sep 2025 08:31:21 +0800
X-Gm-Features: AS18NWAj6sASG_Zw72IIHZI20VQWSlG7-hlseDl9GudkEgLO5sPcS5eT4CwzlKM
Message-ID: <CAFAKQ63_NjdZMnbVZtx35oai=XbOUyCdd5CjST73PqKkFT_h8A@mail.gmail.com>
Subject: Re: [PATCH] pynfs: fix nfs4server.py TypeError problem
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, bcodding@redhat.com, 
	Jianhong Yin <yin-jianhong@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:10=E2=80=AFPM Calum Mackay <calum.mackay@oracle.c=
om> wrote:
>
> On 18/09/2025 10:51 am, Jeff Layton wrote:
> > On Thu, 2025-09-18 at 10:46 +0800, Jianhong Yin wrote:
> >> without this patch, we will always get follow error:
> >> '''
> >> [root@rhel-9-latest nfs4.1]# python3 ./nfs4server.py -r -v --is_ds --e=
xports=3Dds_exports --port=3D12345
> >> Mounting (4, 0) on '/config'
> >> Traceback (most recent call last):
> >>    File "/usr/src/pynfs/nfs4.1/./nfs4server.py", line 2115, in <module=
>
> >>      S =3D NFS4Server(port=3Dopts.port,
> >>    File "/usr/src/pynfs/nfs4.1/./nfs4server.py", line 577, in __init__
> >>      self.mount(ConfigFS(self), path=3D"/config")
> >>    File "/usr/src/pynfs/nfs4.1/./nfs4server.py", line 620, in mount
> >>      for comp in nfs4lib.path_components(path):
> >>    File "/usr/src/pynfs/nfs4.1/nfs4lib.py", line 552, in path_componen=
ts
> >>      for c in path.split(b'/'):
> >> TypeError: must be str or None, not bytes
> >> '''
> >>
> >> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> >> ---
> >>   nfs4.1/nfs4lib.py | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/nfs4.1/nfs4lib.py b/nfs4.1/nfs4lib.py
> >> index d3a1550..984c57c 100644
> >> --- a/nfs4.1/nfs4lib.py
> >> +++ b/nfs4.1/nfs4lib.py
> >> @@ -549,7 +549,7 @@ def parse_nfs_url(url):
> >>   def path_components(path, use_dots=3DTrue):
> >>       """Convert a string '/a/b/c' into an array ['a', 'b', 'c']"""
> >>       out =3D []
> >> -    for c in path.split(b'/'):
> >> +    for c in path.split('/'):
> >>           if c =3D=3D b'':
> >>               pass
> >>           elif use_dots and c =3D=3D b'.':
> >
> > Looks reasonable:
> >
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>
> Thank you both.
>
> I have a little backlog of pynfs fixes to apply, which I'll get to next
> week.

Great! Looking forward to the update next week; and will test it and
provide feedback.

BTW: Now nfs4server.py mds start process still have lots of fail, like:
'''
  File "/usr/src/pynfs/nfs4.1/xdrdef/nfs4_pack.py", line 4534, in
pack_nfs_resop4
    self.pack_EXCHANGE_ID4res(data.opexchange_id)
  File "/usr/src/pynfs/nfs4.1/xdrdef/nfs4_pack.py", line 2665, in
pack_EXCHANGE_ID4res
    self.pack_EXCHANGE_ID4resok(data.eir_resok4)
  File "/usr/src/pynfs/nfs4.1/xdrdef/nfs4_pack.py", line 2649, in
pack_EXCHANGE_ID4resok
    self.pack_opaque(to_str(data.eir_server_scope))
  File "/usr/local/lib/python3.9/site-packages/xdrlib3/__init__.py",
line 121, in pack_string
    self.pack_fstring(n, s)
  File "/usr/local/lib/python3.9/site-packages/xdrlib3/__init__.py",
line 113, in pack_fstring
    data =3D data + (n - len(data)) * b"\0"
TypeError: can only concatenate str (not "bytes") to str
'''
seems we need adding some type converting in xdrgen.py? (I'm not sure)

Thanks!
Jianhong

>
>
> cheers,
> c.
>


