Return-Path: <linux-nfs+bounces-11029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC8A7E592
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506A4188E38A
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5113182CD;
	Mon,  7 Apr 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqMU5jls"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF320551E
	for <linux-nfs@vger.kernel.org>; Mon,  7 Apr 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041387; cv=none; b=Kfp8qFavi+tKPAALNkhDifwaT2Tc+/H1Kz7gdZjPQueW9iQ9+gfn3Sq+bVqASVPyt2qkH0bhekfPeBdyp/Jlrc08TZeUk9ybvxXKQxYoRELnKWB3uaQN7AIE2CGruY7hMZlX6lqTxLuvqtQHmN8G3ouPKy9FColPZo/TcK+BE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041387; c=relaxed/simple;
	bh=KuAmy9Vq8ZNNyHTnSex0eFHb33EYDE3OkwJOc3YxigQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyRLES+9KPzhZzTZnMFM9cmx9d0oIgqdXV02le2iGGLyGouJv7YOCuAoo68qs6/d+ghxisga6IMiprz5sp/JEcttB/bUxwRrJc/setWEOp6UDQR8tfxLX1x5AYYJI8t1v3FQp/eE5EBCZEQxrNoeuhjsESip1sFLGxguvg8PUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqMU5jls; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744041384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3KvLX/GQV9fk5+ldPfOFdJJy6+7Pb4RYy7qLR+2JtE=;
	b=MqMU5jlsbCwRybizL8jOt282QnhR7hrcPqDvx4IvayPz1pZYPQPrFL9QUjhM3AOXmA8KrZ
	1PmpjbqrDmF7yYaTaZa1lBBH8Q7aC/46/yrkQ4hFjC+TCgphAxzWRMDjWp7BFZqm3fCglL
	pVLzlRCD5NrAv2Uxd/VjiXYlXOfgqZ8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-8TEvYxzvMP2eSpXn2reLAA-1; Mon, 07 Apr 2025 11:56:23 -0400
X-MC-Unique: 8TEvYxzvMP2eSpXn2reLAA-1
X-Mimecast-MFC-AGG-ID: 8TEvYxzvMP2eSpXn2reLAA_1744041382
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e67df8c373so4986054a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 07 Apr 2025 08:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041381; x=1744646181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3KvLX/GQV9fk5+ldPfOFdJJy6+7Pb4RYy7qLR+2JtE=;
        b=I45WizodFGYfkcv3j9IOggMmEyOv88yj7cV6EGudxIhVsaQhzm48t4cHWmHPQME3fq
         QcB7hwrriLsxt8wuCa86yQuFG3Pq18bJK9/FR3gFA9sYjC5J7q4CZXuY8ApWVPyDL9ty
         7kwgE2p7rMdv/hxSf3+PbmTq8yD7ZA+0zyjvprBQPCb4CG4/TK5b1W21z7lmZ5y27GRd
         Dm8FrvO01rIpjG1rNsUUaL5ji+uSrvCXH/kMgsVUDwt4t2QRPjBKBTcpGoSXiUcb24sp
         2RhNdI0QTUloC/hQeMcoxLzMHmS925WynjPfpGzuj6iFgUmCO5kx4Puxj7tiLon4VLUw
         t5AA==
X-Forwarded-Encrypted: i=1; AJvYcCVdIR9DfgkepBeN0+GdHD5Pf+hbHhql9GjAvcav07EeqcRRtiYo7zgz4fVgtQlvx3BAYorTffpbXQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxynOmKizIqiuQGmmypNTSvs6oSOqcOoUCxcpwWRan8fMILIizl
	3AwWEMqHgCWndoy1UfsXSGdsIq6yD/t4MHBCS62zYHWDxbx4BFWExS7bhvljnpfbI10pYx3hR3f
	YY2OhTLMINIP8N5kOJzS05quuf5zemdiNDqxqNjwWCYQyEW22Cfzzdv34gUOFx8Q7u/SEUvCYIt
	Tcl4OzB4Q+ubJNzyBtvwEG4CWJv4FCIzXKbypvdnrdJFA=
X-Gm-Gg: ASbGncsiFhufV3Ifw6mhWH2l/DGYZucLaz+WOYNTN8wlVB+RudQjq7slHMRrnW7/sXP
	yx620GEBWQ+jHH+2TddMDD+WhxVQOE8ibxoQOC0X/8gMl2uS9L/FebSKzNfRrnpJJGLbE0l5NIC
	Zu8ezTTADfpZO193t0fiWn5bKH5kvBe90=
X-Received: by 2002:a05:6402:400e:b0:5eb:534e:1c6c with SMTP id 4fb4d7f45d1cf-5f0b3be049bmr11538872a12.20.1744041381629;
        Mon, 07 Apr 2025 08:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7GHCRLNHd2TMRdtzrgeS0httJX7ywHRdsiGjsVwwkzFni4y5XbEVVw6bVA1jXBVwM92gl0KpBe23O0r/jg/Q=
X-Received: by 2002:a05:6402:400e:b0:5eb:534e:1c6c with SMTP id
 4fb4d7f45d1cf-5f0b3be049bmr11538857a12.20.1744041381314; Mon, 07 Apr 2025
 08:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322001306.41666-1-okorniev@redhat.com> <20250322001306.41666-3-okorniev@redhat.com>
 <8556bbf14b11dcb29798374d93f6da27bd1735b7.camel@kernel.org>
In-Reply-To: <8556bbf14b11dcb29798374d93f6da27bd1735b7.camel@kernel.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Mon, 7 Apr 2025 11:56:10 -0400
X-Gm-Features: ATxdqUGABosh31JM0KBP8xX3UiDn7brsiAB27CtdOYCPSAjJUz_YT7mJ381Ar5o
Message-ID: <CACSpFtBrJs8PbAbbBBybW_Gn7LR1r9vVSppGa4VVEWMBt_2osA@mail.gmail.com>
Subject: Re: [PATCH 2/3] nfsd: adjust nfsd4_spo_must_allow checking order
To: Jeff Layton <jlayton@kernel.org>
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org, neilb@suse.de, 
	Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 11:36=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2025-03-21 at 20:13 -0400, Olga Kornievskaia wrote:
> > Prior to this patch, some non-4.x NFS operations such as NLM
> > calls have to go thru export policy checking would end up
> > calling nfsd4_spo_must_allow() function and lead to an
> > out-of-bounds error because no compound state structures
> > needed by nfsd4_spo_must_allow() are present in the svc_rqst
> > request structure.
> >
> > Instead, do the nfsd4_spo_must_allow() checking after the
> > may_bypass_gss check which is geared towards allowing various
> > calls such as NLM while export policy is set with sec=3Dkrb5:...
> >
> > Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/export.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 88ae410b4113..02f26cbd59d0 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -1143,15 +1143,6 @@ __be32 check_nfsd_access(struct svc_export *exp,=
 struct svc_rqst *rqstp,
> >                       return nfs_ok;
> >       }
> >
> > -     /* If the compound op contains a spo_must_allowed op,
> > -      * it will be sent with integrity/protection which
> > -      * will have to be expressly allowed on mounts that
> > -      * don't support it
> > -      */
> > -
> > -     if (nfsd4_spo_must_allow(rqstp))
> > -             return nfs_ok;
> > -
> >       /* Some calls may be processed without authentication
> >        * on GSS exports. For example NFS2/3 calls on root
> >        * directory, see section 2.3.2 of rfc 2623.
> > @@ -1168,6 +1159,14 @@ __be32 check_nfsd_access(struct svc_export *exp,=
 struct svc_rqst *rqstp,
> >                               return 0;
> >               }
> >       }
> > +     /* If the compound op contains a spo_must_allowed op,
> > +      * it will be sent with integrity/protection which
> > +      * will have to be expressly allowed on mounts that
> > +      * don't support it
> > +      */
> > +     if (nfsd4_spo_must_allow(rqstp))
> > +             return nfs_ok;
> > +
> >
> >  denied:
> >       return nfserr_wrongsec;
>
> Is this enough to fully fix the OOB problem? It looks like you could
> still get past the may_bypass_gss if statement above this with a
> carefully crafted RPC.

A crafted RPC can and thus Neil's patch that checks the version in
nfsd4_spo_must_allow is needed.

I still feel changing the order would be beneficial as it would take
care of realistic requests.

> Maybe the right fix is to make nfsd4_spo_must_allow() check the rq_prog
> and rq_vers fields to ensure that this is NFSv4? It can just return
> false if it's not.
>
> --
> Jeff Layton <jlayton@kernel.org>
>


