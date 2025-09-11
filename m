Return-Path: <linux-nfs+bounces-14270-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BCFB5293A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 08:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8DF561849
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5331A9B24;
	Thu, 11 Sep 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avq8eo7b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AA145A05
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573355; cv=none; b=IozrlzUFy2smVwKD1edQPFa8xyUHExYUooTnNeKOyT1NwkoXiukWTJ/h/uV0vble7GUYT5G1IO7JlWZ0lD0IVtO4Nuue8L4iIhzfXxowS9SHfrA0WRbROCXHfH8ASfM0f9pspXLPVXrq/2AOcMOqJNGjXESPI73jGpXuB3gRA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573355; c=relaxed/simple;
	bh=yDdSLJUdDVHxAsMMzTxLQxzZ40RaFNEHOB49Hw4kkxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dxbuDFu2Du6xBaRNNpLWfk1I17vRoRe2Q/KlN89VzYw5efOEn05ehAH//UnxVSxEggB9H+FZ7qwSsxGi6eIdXy2nmskDjn3AMHu8lHEAnIoGjkI8EuK9syICY4fdGd1z8N/fw9COERQv1pP3fTJH7uSnORQ8E7l3ErzyjY8GR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avq8eo7b; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-322695f899aso298929fac.1
        for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757573352; x=1758178152; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hek5xLo9Ad3Ih9RRUrNGxqtHJl+e2/o7G5OUyKypt1k=;
        b=avq8eo7b1EmXljIgmRWm3K8s/A8vWbXV47Cv7qyS08mpETaSCZpT6zqv+cCplFZH8L
         VxtBNEy9p3o38RVg77sepPuQuapxppJEz8wYXvgGOKtxCR+OYWrYB/vY6ZKWTJOhcgO2
         lpShi6sj/t1npyKhqfImKJqLUe6ZvMwZGSXirnmPCiC06HNbccxj2LCd0rX6d3dZtzvI
         Je4QTEYXPSQ6XPXc29vi9vaU/j4sIrAifbvsQhlYHMRjJtJ1QhnNHjjA5xj1ZNUYh1s9
         PxIRljG6C8j0zf5jHEzD/dxE9EyaeV5fC5Xi/kVIo70duMM635d4iNLChk8nrUmCPRuZ
         QosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757573352; x=1758178152;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hek5xLo9Ad3Ih9RRUrNGxqtHJl+e2/o7G5OUyKypt1k=;
        b=B5cjnqekFYNJmSjKoZAsg2YmvRSX2qGm3fzuE/Tk+uBc4Oj7+SSMky2yGjzahb2oBw
         tkB8ltK9hn8LavLO0Yl/gmbCMk1PF7N5T1uKvNt0jiJM4IyqLel0aSKJWQf9Q+IMTgXA
         TimD2+xA8I1FRk+XpWNBZwdhO1Eql3IiYV/2Znq8gDLGqfm+d55USvCNbxsL47+iTiqS
         zmAEBss0dkAfenyzp6XBeEBqBXQRg2bHEZ9h2nUo/oLlrQfWj9Ty6unM4BIdLhSQCLT0
         /BCOu9b3fdtdJOgAeK0JrlKHjWSVDgNVCt36CNSlKlfK3SYL8IrcXXyBH9tumGCaQmU6
         aK9Q==
X-Gm-Message-State: AOJu0Ywv/t7U+OnUfTczhmWZP3RCh0Pm4KqeSKO4LdVbAhDb9zGRc6Lh
	onHjMCs86v0V1t3x14cLoAro3bh9QCC5YjVDCiUs4cLqY38iXaHhdANa1neTVvxVgowXCpQC1Xd
	qvEhKgAcfRWULRXJAU9f0GunC9/lbvQs49Sxv
X-Gm-Gg: ASbGncsqOauXcgCwSbfKExJOiuXplN4+y5fuE4CZNzxtkQAhvouIZt4+Dgc64/ywZIx
	M2ENo/q0rqimQSCAIaTVcM4qqemw6vrJePHLa1NpjCvwHcic/1uQ/9J2mvCgSDRbZrjhQHP12k3
	td8Ml3SIEIxdLNgndUKBXam7J2gHv9ybwzoi26mpFDEN9q30tsZ2qLPlnaMTDbcY8buRHdff612
	VMl5g6txOjffpUTxMfXWec2sfAN
X-Google-Smtp-Source: AGHT+IEHOYGcOyWu3hwUEy/AfhyZEI5EDu0uVuC7K4Mms2ye9CmG4VcR0zrZF8fe9H8WwzqtKDzp2Cj2C+YInDulRhA=
X-Received: by 2002:a05:6870:2e09:b0:314:9683:3759 with SMTP id
 586e51a60fabf-32265437abcmr8609310fac.50.1757573352167; Wed, 10 Sep 2025
 23:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com> <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com> <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com> <236e7b3e86423b6cdacbce9a83d7a00e496e020a.camel@kernel.org>
In-Reply-To: <236e7b3e86423b6cdacbce9a83d7a00e496e020a.camel@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 11 Sep 2025 08:49:00 +0200
X-Gm-Features: Ac12FXxapantSV9qhlkkBY3Sx68Tp1FP2Wf87_uR6-_v-lISBbyrLOKR8dUp6io
Message-ID: <CALXu0UeSJbNeZ_TqSxu84ZPJ6FK7PiF7qcgMsGtvHY_URFL3SQ@mail.gmail.com>
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 13:10, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Tue, 2025-09-09 at 18:06 +0200, Cedric Blancher wrote:
> > On Tue, 10 Jun 2025 at 07:34, Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Mon, Jun 09, 2025 at 10:16:24AM -0400, Chuck Lever wrote:
> > > > > Date:   Wed May 21 16:50:46 2008 +1000
> > > > >
> > > > >     dcache: Add case-insensitive support d_ci_add() routine
> > > >
> > > > My memory must be quite faulty then. I remember there being significant
> > > > controversy at the Park City LSF around some patches adding support for
> > > > case insensitivity. But so be it -- I must not have paid terribly close
> > > > attention due to lack of oxygen.
> > >
> > > Well, that is when the ext4 CI code landed, which added the unicode
> > > normalization, and with that another whole bunch of issues.
> >
> > Well, no one likes the Han unification, and the mess the Unicode
> > consortium made from that,
> > But the Chinese are working on a replacement standard for Unicode, so
> > that will be a lot of FUN =:-)
> >
> > > > > That being said no one ever intended any of these to be exported over
> > > > > NFS, and I also question the sanity of anyone wanting to use case
> > > > > insensitive file systems over NFS.
> > > >
> > > > My sense is that case insensitivity for NFS exports is for Windows-based
> > > > clients
> > >
> > > I still question the sanity of anyone using a Windows NFS client in
> > > general, but even more so on a case insensitive file system :)
> >
> > Well, if you want one and the same homedir on both Linux and Windows,
> > then you have the option between the SMB/CIFS and the Windows NFSv4.2
> > driver (I'm not counting the Windows NFSv3 driver due lack of ACL
> > support).
> > Both, as of September 2025, work fine for us for production usage.
> >
> > > > Does it, for example, make sense for NFSD to query the file system
> > > > on its case sensitivity when it prepares an NFSv3 PATHCONF response?
> > > > Or perhaps only for NFSv4, since NFSv4 pretends to have some recognition
> > > > of internationalized file names?
> > >
> > > Linus hates pathconf any anything like it with passion.  Altough we
> > > basically got it now with statx by tacking it onto a fast path
> > > interface instead, which he now obviously also hates.  But yes, nfsd
> > > not beeing able to query lots of attributes, including actual important
> > > ones is largely due to the lack of proper VFS interfaces.
> >
> > What does Linus recommend as an alternative to pathconf()?
> >
> > Also, AGAIN the question:
> > Due lack of a VFS interface and the urgend use case of needing to
> > export a case-insensitive filesystem via NFSv4.x, could we please get
> > two /etc/exports options, one setting the case-insensitive boolean
> > (true, false, get-default-from-fs) and one for case-preserving (true,
> > false, get-default-from-fs)?
> >
> > So far LInux nfsd does the WRONG thing here, and exports even
> > case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
> > server does it correctly.
> >
> > Ced
>
> I think you don't want an export option for this.
>
> It sounds like what we really need is a mechanism to determine whether
> the inode the client is doing a GETATTR against lies on a case-
> insensitive mount.

<rant>
It might sound rude, but after reading that I had to empty my bottle
of bromhydrate de scopolamine renaudin.
The topic of returning the correct booleans for fattr_case_insensitive
and fattr_case_preserving in Linux has been running in circles since
(at least) 2008, covering all kinds of bug reports (CITI, Suse, RH,
....) and mailing lists.
So far NOTHING ever happened, except "more research", "no time" and so
on, while other platforms like the Windows Server 2019 platform and
the Exceed/OpenText NFS4 server just did it correctly.
Exceed NFS client handles it correctly.
</rant>

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

