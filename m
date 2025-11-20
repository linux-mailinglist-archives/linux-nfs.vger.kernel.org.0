Return-Path: <linux-nfs+bounces-16639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E5DC765BB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 22:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5449A4E01E0
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17F72F999F;
	Thu, 20 Nov 2025 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDPfe7Nj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C82C21C1
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673825; cv=none; b=qS9grvi4BRql+HqL6dTAIjRyYQWFYorgLMxlFmktMElgcy3RCymuXv3R3VMxu7q93S3Daevehg2/+LpActS/PW9wraVA3coigSCPBQ6FN4Sji2KzhAWw+E1PnVVXwo4vNKo6ShpTsiUMoprxoSbY3gzkUzKutkk5im4uaToE5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673825; c=relaxed/simple;
	bh=e4M3eNKCoU74Eo0/pZlYbyJi0fi06AYvB+KoAvQYGks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kgXailEK3fqK/wNFeL9YNYrayjYxiqSgKxDY6mjPsexx0Yfys1RubZmmkcSU5bEQtPXgS05O/S3XK8zry8UPLFZs22oBFJB1GBkMuFDB52deyPKKXlaOU/aDNf5ybsKJeKtZGsrBjWt8clOvuYG9O7vOQPp3znRrpdtuwW288Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDPfe7Nj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso1905288a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763673822; x=1764278622; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4M3eNKCoU74Eo0/pZlYbyJi0fi06AYvB+KoAvQYGks=;
        b=eDPfe7NjrYi+LXizFSF+7eRbyfA453xfKLoj0ODNM1qiUMncXNcbQ4aDRSw5rLcwyK
         3157vJGR5xA4QbaVbRSgognQz7zBSiqD7GAiLaaKY8c0NNzYdlVXW1CqejilWJrLiUgm
         cPebQpOe6Mikm78pZADFw9/MZJ/CnooPdHEZtW22tcLJeQkA29mLXOO5ixUwXS+MCWcx
         ST9nO1PoIW7g2aIstRGbayYd2RAwIVDJ1LsLv3kry3zWt6hoslbw5VMsAoZAR5erUo6m
         x/6WYELEqi+XUC3g+Kl/vLHXiMux3st3Dc5cW4xLTnFY0f1I9AzcBFa9uu2xPySzqXUG
         U2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673822; x=1764278622;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4M3eNKCoU74Eo0/pZlYbyJi0fi06AYvB+KoAvQYGks=;
        b=bdnA5Xg0AtaiZzc+n4jxaWIwEiE2kRwutkvbVB6cGYFaI8/FtebIxliz9c+nzAK0YS
         hi1DheWVDiMQt/vbluAEwJ7C0ULKlZxmz3UOvuvwtfUlGZuhK8vj7tEI/T8Y9Nfnq/Ws
         veRkRcEVCPSbXMpgVxN/KFHAQvu1MpvJtO3sefqOHWoLPgLPpB7dRveyzlXU0Q5JikqB
         XHTCGZHp/aTrOr4pEXk4sA/5oG968Q8O3H8VgJjt7mw87kQzz/5WFSfuF+hdctAbLQS8
         yBetguQTntwYGYM68gJonY3RyJX4Hkyycodh/vbkVb7n9CGMc56g4OzoAIYt/gv/FnX4
         qtLA==
X-Gm-Message-State: AOJu0YzoF+H4aURtjpsTc/fzvd55uE+h4qFjdU9axQchFeiOL9FKK7Q6
	gHFAZZ6UvmYrZo7jX0kC76/mfVzjeRHDx7XbGR2RC/xiDannM3gXrQqXIk6ICELX/ITRZFWwEw2
	c/AWKoVwVq9BmC2BoJzvTsXSYaHrW5Og1B0lNZ/4=
X-Gm-Gg: ASbGncuvtXzQWp0Cr60/N6iXZMio0rnGZRU8uqk+r4YYLy+eIczeLrI9a/QO6dw01Dv
	3qp0pFZRZs1bi0xALB2CCnzg0liAEf2H23YWEukvf6KFVfm0Witjqyx89h/UQKsgBohimQvQkGW
	kAUt7d3f94E10f1e3Jlt9BOGjR3sH2UG1z5zns67CjWj2Rhr/FEUjwc+00hDvYJ/QHQSnIk8Ssx
	THaKqge65di6I8QJSPK3NiVtXYKK2hJcFvK+VohuYyFcUeijIRmfiCF0yNpulKsCrfERXY=
X-Google-Smtp-Source: AGHT+IG1/GHANuv+gq8YZVpLBbCOylwJMnJNYajjzporSM/Mjs6Vc0uBliuJyDWxpIgu/V/RGD8NFIPtJTBHOJ62cxk=
X-Received: by 2002:a05:6402:2714:b0:640:b1cf:f800 with SMTP id
 4fb4d7f45d1cf-64554320e36mr159492a12.4.1763673821966; Thu, 20 Nov 2025
 13:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org>
In-Reply-To: <20251119005119.5147-1-cel@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Thu, 20 Nov 2025 22:22:00 +0100
X-Gm-Features: AWmQ_bn62Tkfc2Ni90bWjMsLINkUpuhLtWUMSa7MlUsfDR_QVmofxXBWWII5IDM
Message-ID: <CA+1jF5q1CE0vxHx+_MJ+Oak9mLuGQ3dVBq0qJOZVcrjoFepH6g@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
To: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> An NFSv4 client that sets an ACL with a named principal during file
> creation retrieves the ACL afterwards, and finds that it is only a
> default ACL (based on the mode bits) and not the ACL that was
> requested during file creation. This violates RFC 8881 section
> 6.4.1.3: "the ACL attribute is set as given".
>
> The issue occurs in nfsd_create_setattr(), which calls
> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> However, nfsd_attrs_valid() checks only for iattr changes and
> security labels, but not POSIX ACLs. When only an ACL is present,
> the function returns false, nfsd_setattr() is skipped, and the
> POSIX ACL is never applied to the inode.
>
> Subsequently, when the client retrieves the ACL, the server finds
> no POSIX ACL on the inode and returns one generated from the file's
> mode bits rather than returning the originally-specified ACL.
>
> Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> Cc: Roland Mainz <roland.mainz@nrubsig.org>
> X-Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <cel@kernel.org>

Yes, it works on all affected clients,platforms (Windows
ms-nfs41-client, Windows Exceed NFS4 client, OSX).
Thank you.

Windows test code is at
https://github.com/kofemann/ms-nfs41-client/blob/master/tests/atomiccreatef=
ilewithacl/atomiccreatefilewithacl.ps1

The only thing I did not test was exporting a NFSv4+ filesystem with
Linux CIFS server, and letting Windows CIFS client create a file with
an ACL.

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

