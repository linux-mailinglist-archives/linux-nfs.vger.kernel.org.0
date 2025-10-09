Return-Path: <linux-nfs+bounces-15104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B999BCA8CC
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 20:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7744D4FBD5C
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361B023D7D4;
	Thu,  9 Oct 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="pee99wnx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C31DF75D
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033903; cv=none; b=WbCf0PNGN4N/7IYy84af0RJA43WL+9rWsZ79cwIB2FSgEvd/21IMBZ9sy1PqZOeAL0ddLvhdG3DTFDkggQhOa9Y5K29S8RWkNVtBZE+UfIr5CCS0d1zL9ZHk4LzARYx4uBZn3D5UorKcrB0No24tUziUdSBLlyGaPJ/YYUdnhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033903; c=relaxed/simple;
	bh=cRvQZ49FO54cYCVc0BlbkbukgcXBMRbkOzTwnfNZygc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSOVAVJLDJm5/E+lrVOOgraAG0Fikcvs7eIdSIdZjjWDf8arx1QyUomoxvW8w7gkgO376kaUyHTHS5V0asHYPrlQmlO0ZNcvu7Ug+yGMmib+VwxKCoz8pM3KAvj4VbuNLish0I9qqFef/Pk9C9KUhf3MiMnR2b+wClhDXC5Ke4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=pee99wnx; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5906665139cso1601285e87.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 Oct 2025 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1760033899; x=1760638699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WBfawLIGoTEeX3HGTflGpkzUuwIMNiNXOmxwvGE3G4=;
        b=pee99wnxSPRIMjcqm3+ObvIVUTkwvYNQ+S/Qgyr7a1KKqbPySaEMcz867c+SshIJgV
         DofSLhCtIDnSSYyeXG1mDr6QKYF0b1D9XPN0O6hwTrTWQp3HW7FDxJzAUlYrl2Rc7Y3r
         PDN6Q1z4/Q7yeSqFiPEW48NmoQMnQyPzKwwPCbafzKLCNnn3H96R1etT+wZunBiL+XLc
         sApRlApwLrVy6uT1YBARvYUQRaeVhczObDtN7n9wYt4aJWVKwxEh3bDsvQ8wxYU4a1eQ
         qoKwzYByRGxIN3yfXhbLaLp/4IFnlwxWJbooP897MhgrhVTz5k/OKHX/9MU1T6eJ+nxD
         8cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760033899; x=1760638699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WBfawLIGoTEeX3HGTflGpkzUuwIMNiNXOmxwvGE3G4=;
        b=maGwZLRtNLqA5HAroXqJB1t5vCuFcyRlAeecEjw06R2naDKn4hWDq8kq2ABHiluIDH
         BmHcDb46RnwXa/2doe160/GHN6FZQcrfNgyfeAQBBtU96LseHbMUFRTjJnmYfkeJZ1We
         6ooIcySLp6So9lBf4FGSIFVw5N5MUQLZNijbAESU8IrfL7P+wev9baGrgUray6+Prwv6
         pVOIKMKuycaDYJKtPt4/Ylvvpf9X0OXg6vTZcoVAB9Yi3mE+Nbbxjpj+zXTh8TG/kkbx
         vLrccvCxVGR56qoIT3hPE5ZR9lsNR+DyoMXYxqGUQQNpLFhsZLQbr1ONbKd0vcMV+PjL
         4tzw==
X-Forwarded-Encrypted: i=1; AJvYcCW8WOx4DKnKm1n/PFFcdLnMv+5pdw3QpaF4h3G2f4eL4/2qSViWVwAOAtdKAH/LT5bbRA4baxMzbe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVQD2bn7eOEcDqnL8BjYqpR9hUg9oiSLmeAQU5nw738ygoySd
	lZWogep/R1jjaSyPBe28btsdSkdUk6a+/PqLZohG6/zpDFNtQPkGiws4poVmCVgLVXaGi/KbFMi
	rydFBrdtstP2VHjQOKzQ02NGFWu3kBo0=
X-Gm-Gg: ASbGncsrLyh1IKXQErLD/6ANwtSqZnMZuCw9Gc/5ULJXGc9khTH8QpS6ncB7HCOjRbn
	19EaelS+9dCs4fUShd9CtwGLJCDzccgb+cbV/XAGIBViRUepMiSlJBBc6CV2/VEgngkpvvE2eTr
	rmM8i6sOlfEsDE6VpMeNq0eQKwQ75UBzhKZGlKCARKnRI1oSAS2eGqO7TYi7S7rlxMbXrBuQcy/
	Ed1nnLLSrl7z+5ohiNTrcBj0qYGABX1JhM3gLqqtHNZmmOo8V6g2Kl1J9C3Qh8SL55huyLf6F4=
X-Google-Smtp-Source: AGHT+IFbac4fAum6hee5Iw/+lGWx/ADLvmdsaha9pb7Xo/zyvUOgQzAPQGZpgAmoplVQLFcwh6dFHxiuj9AGmv7ASKE=
X-Received: by 2002:a05:651c:985:b0:365:e848:b7a2 with SMTP id
 38308e7fff4ca-37609ea3aa8mr20842481fa.33.1760033899269; Thu, 09 Oct 2025
 11:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009173835.83690-1-okorniev@redhat.com> <176003277769.4149.545859393892148978.b4-ty@oracle.com>
In-Reply-To: <176003277769.4149.545859393892148978.b4-ty@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 9 Oct 2025 14:18:07 -0400
X-Gm-Features: AS18NWDuE_kKkRMPvdBtlD5EPT-Pm3iU0JCzbuUD0XhYZ6EJaMcGQV_6uDDHzbs
Message-ID: <CAN-5tyG4-SybxVuGrixG04PRNEOAwdOYYdaWGNx72XfmMNtQiQ@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from
 supported attributes
To: Chuck Lever <cel@kernel.org>
Cc: jlayton@kernel.org, Olga Kornievskaia <okorniev@redhat.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, 
	tom@talpey.com, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 2:07=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> On Thu, 09 Oct 2025 13:38:35 -0400, Olga Kornievskaia wrote:
> > RFC 7862 Section 4.1.2 says that if the server supports CLONE it MUST
> > support clone_blksize attribute.
> >
> >
>
> Applied to nfsd-testing, thanks!

I just realized that NFSD4_2_SECURITY_ATTRS value is larger so
FATTR4_WORD2_CLONE_BLKSIZE should be before that. Do you want me to do
v3?

>
> [1/1] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attribu=
tes
>       commit: fcc43f116744ac6d34f2bd77c1be34e8171d3d3c
>
> --
> Chuck Lever <chuck.lever@oracle.com>
>

