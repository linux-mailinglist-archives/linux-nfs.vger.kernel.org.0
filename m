Return-Path: <linux-nfs+bounces-16678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9079AC7E207
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347103AB2CF
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767A227BA4;
	Sun, 23 Nov 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjSxjjDC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C219145355
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763909728; cv=none; b=N9scfDmZtzOpH7z3ph1wFyGe2zzVjIpAvdWpXkbZ/5h4cpycheZZUfak+zez6g8ISnOIHHQdqaLYsgx14EG7++58g5owt2qls5It7m2Wovem3fl4GD9xzyQdlMIWLCa9kLJf968UfBVPWIbfdx/gUWWUjjOD4zWjdcC46XmiQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763909728; c=relaxed/simple;
	bh=vChghRH5mo3x8/u0TR1OZDeNryp/g3r3qWDKP4RscqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UUUgsTDkxlTWvHQ4HOdd5TbgLX2bVS+s/AZKCjYM/b+H+rFGe+eWlGgME6nhZwx390g6Sosc1kMG/JafhwzxZJc7FQaT4mLlJGKgdAFrJjWdAc9grfGSBQ5OmCyabkJzjkD32saDh/P3j2RYXwRLOAbUEVPoR9dnyai4fZijYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjSxjjDC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b735ce67d1dso543481066b.3
        for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763909724; x=1764514524; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vChghRH5mo3x8/u0TR1OZDeNryp/g3r3qWDKP4RscqY=;
        b=YjSxjjDCQ9TGyDYh7YZulp5T8dtxytpxoq0vW+B2sBumgd6iof98g/YI5R4k73/VYe
         XPNEiW2dC8Iz+B5vWLeyUNgYOcP4QytcGWLn1rI//T3rkWIyXxzrbYgDJdGhETgqsNie
         c0p68ulpcQudqffekJQZSozg5zZbXDW7Xcr4KybilvhrQV3+F5kY/1hRYq49EJA4DKk6
         ggUSueijZwmuWF27NPUve2K5LNNXMjfGdf7LDzeDzuB6Zf/4Vdh9NEGAFvK2a55SGK1h
         4J2eY+L607EQR4Za1IFnYtkLYwg8pYySIVw2xhaY1Ze01KAY2skvmqTAFqGrs+jZrax0
         KBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763909724; x=1764514524;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vChghRH5mo3x8/u0TR1OZDeNryp/g3r3qWDKP4RscqY=;
        b=Uh7qZlLp18Yb3Xe26SvehV16nJis6itatci2tzpqmopQ9fgTf80cH3xUe0D+hulame
         mpuZKa6RcLmP7+LSKnqyNAUECRHci7fAI2lCoXZp8GOn02NV+7MrMk21c2xOZckfSRGz
         oMn04Ar8FPi88tdJ4NZPWkNXlB6JHlvavTUB55Bhf2IBmI5aipFXTquZNfBU/CKPlnTz
         NHHvj0qqMX+3LZIgZrY9YzgEj8lG+AQPZyh35ZKD5VsXUHxK+GHkpwMv3Yi/+K+nkV25
         jjA+p09lZW3dz4W9BwZd6nhGX7TxrVcuj2Lu3rMlj8onS8axwgOLS+ITaJjpdTyLq4mv
         nmLA==
X-Gm-Message-State: AOJu0Yz982CxA50ZG+LO/LZrplcUhc0O/oQeABo9CToByw9eu7ZtoeYk
	NTVr7kCKNYCI16IQlnRHKkUNWxR5yLh6lpsjOYfjzTh9WWBeJN9h8TTwbKu+Jxud4cLKWDNlsSL
	EHurZzGtxhkHaWyHtoxRxxxcPH45X6iKrtT1E
X-Gm-Gg: ASbGncsbKKzGjp2AWxUYGPae8vAtBiv5c6rOmIxhaqyodhNPWLPRQPoG44yVUv//zRJ
	4Mubl5p5kjBpA9nKlgig0SCwWmzkjcOhl6ZFSMbiTBcbKQga861u2DOe6fWW7vGi/V25R2neQb1
	ZpmqLR1VYb761q7uWQy2ID5QNGAp1FR6cxDUcXgaSxd2XQb19c3hlceEedhY8QD5cHq+XoIoOW8
	JTmfWWWr54P9e2sC5jTrblFDSvfd7IWWzOdF89BDd6pw9H1uU4jwdk0v3q49pgjQscn1Q==
X-Google-Smtp-Source: AGHT+IFq9XyMjZXl3XmOgzCJvi+5acqKmdSUPwkW6qDpB4xkRTgW7/dsr9C4qF2JZWrK+HbgxA7LcvhtlqAJkIDPeKE=
X-Received: by 2002:a17:907:720b:b0:b73:5693:4ec1 with SMTP id
 a640c23a62f3a-b767189bf61mr848046466b.57.1763909724353; Sun, 23 Nov 2025
 06:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org>
In-Reply-To: <20251119005119.5147-1-cel@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Sun, 23 Nov 2025 15:54:48 +0100
X-Gm-Features: AWmQ_bmMeP_SpD-6inV81gng5NFTeL8pWAPDbZPtYBmg5RORGpf_d6cWDOl8824
Message-ID: <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
To: linux-nfs@vger.kernel.org
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

As said the patch works, but are there any tests in the Linux NFS
testsuite which cover ACLs with multiple users and groups, at OPEN and
SETATTR time?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

