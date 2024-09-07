Return-Path: <linux-nfs+bounces-6312-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5522D96FEB2
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2024 02:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30CD1F2334C
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2024 00:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A741870;
	Sat,  7 Sep 2024 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz/1JqsZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C24A18
	for <linux-nfs@vger.kernel.org>; Sat,  7 Sep 2024 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725668616; cv=none; b=LfTB/M5US1shdEr6mpn52tR2VUCkYemXOWuQQaRnlKM8ZRBooZmP3jBeuJS7fik/S9aUnAcqwjqRaIgMwERNDbC4IblsDWnerWjmYuPzUCQR5b3HHNdXLAIxziQtMuEuWKl9+i8Gwu6wnlqguD1GrYP6k8jNmaZoE5X9GJvs/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725668616; c=relaxed/simple;
	bh=N8w0gHkefs2G7iN52rDGKjFaYRLLMKl9/T/5kMHSPJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoSirPTss1ZnPLSDhyT+eOkmW/5laflnfY7ZWV6I+5ixCqKkv9I3jaw+Z8vfeSeOJW8x6HszvPUdD5ameIZ679sz3DcnVXMpUvSumiij5Zo21ztgGDJuffswAPQoXu39EAqDeHKcpjZ6JVj+WmbOuXmuAfnu/uvpXMwJB08Ytv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz/1JqsZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2053f6b8201so24146115ad.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2024 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725668615; x=1726273415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjSU66S/f+8RiSnLys5xZd1fAKQ8KFLn6Xv8kRdnvyQ=;
        b=Jz/1JqsZZLEGPdfF/8okkNol0gQnHuDHRMbHdvQZ4PK5WU95HgeDaxAfQKvWpeci3r
         +R1f4HgyedxXNCh8JP4vxeZYAX4rUIwfJ5IUyPftGGZC6LbHycJOpNIhMtv1dEJvVXuH
         dXDOliAwlPFNdYeVUM8vB/+KzkczjtAmrkSecT12dwtc9VKKzq6/JM/aPRmPerhuHK22
         Ss2LdPw//5JWNx2Qbhir3TsSB1LfYRJkUrssfw1pqlPxuskoNnd7JcP0vf3O9+IX66JR
         YgpYymJhjm+SYe1/VWVBiHiiwTjBZcqXeBhEStqkom2VyJK25LCMQYn01AbLoqSNaDOk
         jbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725668615; x=1726273415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjSU66S/f+8RiSnLys5xZd1fAKQ8KFLn6Xv8kRdnvyQ=;
        b=GVYfAJv4d0sQgqIX7JTR7jP9GwPzqw1lF0IkVocmLDJ5t0Uj9hyU9fziW26hQ3wjse
         IRvvnsZpa++R1gEShB47GkEgUg76UVh0IudB83Cm5NTQm/9EXX4FEafwdW1q49kPXMAG
         k/wHWZ5sbXtEL2jrR8ykTcsyPo/VTqaoOcDiyIN3ZZWaa5YXEIHM1ZF9kbQtsjrUrJgX
         Ixo8w0wo+Vj7TqAg4chXpw78Rcq9b8ta4LWMULOHIfb1I4yxMz9NFwrqwP+0xTtYB9EP
         JVwwQPSkt4F18LgeLf6fNIkywOL4b2DhqQIr2khcUNkKQcr7e/84FkKmscVvxxVA7GrK
         aLJA==
X-Gm-Message-State: AOJu0YzmVmgEn9ra/gfG4MwGzayUVACTTKNyNdkXkTAiDmq8pM0bh1hq
	L5P9F+zkb9xqQw587uzWq3CZfCYOhJYGNAQRYVlEr63rVKw1V8Fp8Cvt1hFmEElZd2qI49KqLQ+
	4aTmEKf94nIDVPlU1+czn5pDn6w==
X-Google-Smtp-Source: AGHT+IGyMM4QKRvP/2JPOcy3NjBJy6bR304KXsjARlZe6np2F0XkE4e04e8Wu1GiIWK3J1HzqWOoGCL1qHYPrcwO7DI=
X-Received: by 2002:a17:902:e806:b0:207:6d2:45ef with SMTP id
 d9443c01a7336-20706d24737mr23963525ad.37.1725668614673; Fri, 06 Sep 2024
 17:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7VdgPaiKGtVg8de7HXcv3Nu8fibhhae9vp=pWgrX-EVA@mail.gmail.com>
 <fca5699d-0c25-4b1a-8280-e559641f7cf4@oracle.com>
In-Reply-To: <fca5699d-0c25-4b1a-8280-e559641f7cf4@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Fri, 6 Sep 2024 17:23:24 -0700
Message-ID: <CAM5tNy73dq2hjcD5pvKS+vFk=718_WgeR2AmzvsQnc2t+gJSpg@mail.gmail.com>
Subject: Re: Yet another newbie question w.r.t. kernel patching
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:52=E2=80=AFPM Anna Schumaker <anna.schumaker@oracl=
e.com> wrote:
>
> Hi Rick,
>
> On 9/6/24 3:55 PM, Rick Macklem wrote:
> > Hi,
> >
> > Another newbie question that hopefully someone won't mind answering....
> > There are a few functions in fs/nfs/nfs3acl.c (nfs3_prepare_get_acl(),.=
..)
> > that my patch uses for NFSv4. I just copied them into nfs42proc.c to ge=
t
> > things to build, but that obviously is just a hack.
> >
> > So, the question is...what should I do with functions chared between th=
e
> > NFSv3 and NFSv4 clients?
> > - Put them in some new file in fs/nfs_common, maybe?
>
> Since they're shared between client modules, and not the server, you coul=
d probably put this in a new file under fs/nfs/. Maybe fs/nfs/acl.c?
Sounds good. Thanks, rick

>
> >
> > Thanks in advance for your help, rick
> > ps: If you create a new file, do you just update the Makefile or is the=
re
> >        more trickery involved?
> >
>
> Yeah, you should just need to update the Makefile.
>
> I hope this helps,
> Anna

