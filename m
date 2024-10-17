Return-Path: <linux-nfs+bounces-7232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32409A259B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83321C208EA
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB41DE4F5;
	Thu, 17 Oct 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NSmFYHNq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666B1DE4D3
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176869; cv=none; b=JSBtcFJbcIJX9MuInHIBUlf3MZevFDyvnwn6DG218PPLkOfReId2BSpolFuw6BKxXJ6eu5VMj+1ELR8LA1JlJzo/N30/TemH13rS803b8CCqUSpTxwXii7cY94DxqbaffVPcjZ4Ea1okFmOUIvDdOU5LvXJoGRsSkkDpUpYL7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176869; c=relaxed/simple;
	bh=aPFi16dTpGtSmfoTVzGeOMSB6a/MnGXB2j2S2hHCDEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNgyhap4yIlinsuVVkcovnvrxwwh/LxU70liDOY1Q3ow8Vx4qdteip0Cgg5dPgfyYLLQWmfGtwzdxamwcH+r4EcDkYy/H3e9OEAMlcUoxROuwPCZGMlgoKB2uGAbo4FaYXTr+Uwhx1Izm9n2WzsJBDnZvJwqtB4Y4uFV8xCxmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NSmFYHNq; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e290e857d56so1028663276.1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729176863; x=1729781663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy5MkDBxA1s3HnIZfrqDdrowqL2bpIiIb4waOMHS1vY=;
        b=NSmFYHNq/aW3/VrIkLPTKsxHvmUEn58+D//NA/5E+VpsZxxEd0EiUidTj+ARRRo+EV
         ABum5RovixdfY+3z378IFcNa01Ock4yYsX4+1/bvhwNImgBoGfucrte/Jndi+9y0Yy4I
         Vz8XwXDZ4qko5lByq4luWlUPjWxP1E6f7Ac/9j8T6+qUSe3OxF4Bfr0pljAhrw4xlzKW
         ddo3d3Y0xhnPirwBFgl4ApOGg8/mESKlDpJ4CYsY1YFAcjeFIsTfTxwbveIgDBATCR/d
         dpHy/bPjch2Hc20dDiUURxO1fngPCUo/PhXB8pUCdO7MDVj/VMFWw0e4WjdCmJXD+erM
         FRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729176863; x=1729781663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uy5MkDBxA1s3HnIZfrqDdrowqL2bpIiIb4waOMHS1vY=;
        b=ut6WjnR9eqHGcwdkXf2DK7uqNHNZr/ZIXCG8J6EnRRXw+WZCfPOLR1AkoUXLuHjZzz
         E3bHmmdt68i/1P0btpO9G6h5iOovCh3f8mRhBAMIKzbbX26sL5RQnYrPu61hGrFeRSgz
         dmzFUifgwJr3ywa5diutRSzKbspbugJzfK/8K9Hwvo6htMz8brYO3+t7svlgtKwCt9D/
         JtywBzu6XMe6qAiU9dJCTfpOEW8kUsQhLmh6Im5+UgsvAPIFGSCklNe/yvlo2gilcc7N
         VFQcT5OB8F/3asjSkMdKx6XhgdIJzniM+FKYZI7stD5p2fzMfpgqgrqX8sDXBLHz1N8a
         LRFg==
X-Forwarded-Encrypted: i=1; AJvYcCV7I4XlgZ2hMuCxXXk3XydX364PCoZ78KRB16szWljWYXOz4jllui8yrADR0lZpCn6zsKlPo8hUMW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsEEJekyB7g7GSM/qm3h9lUG9wg5MIZ2LoD8fHD4KHWT+cKo+t
	Mqav1s1aB727lkn5lYAou9jEfTd4z2IqV9bwDn0/9Hv5w+T9RZV4MMwFubyFt9yH0ebDGq4eqW0
	9TCb32hzcEnB7iWTfsu8u3vEpfhdht1aZIxsF
X-Google-Smtp-Source: AGHT+IGB+JWQW/OGhh1CM1ibfSC+A2nV8Euoort0xc+V+erLnsw2qw27PjzOwh3YJZIhK34sXSErdtF1EiIuWcdbKy8=
X-Received: by 2002:a25:9087:0:b0:e29:7e0a:38f4 with SMTP id
 3f1490d57ef6-e297e0a3a18mr4276392276.52.1729176863657; Thu, 17 Oct 2024
 07:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com> <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
In-Reply-To: <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Oct 2024 10:54:12 -0400
Message-ID: <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, 
	"mic@digikod.net" <mic@digikod.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "anna@kernel.org" <anna@kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:30=E2=80=AFAM Trond Myklebust
<trondmy@hammerspace.com> wrote:
> On Wed, 2024-10-16 at 19:05 -0400, Paul Moore wrote:
> > On Wed, Oct 16, 2024 at 10:23=E2=80=AFAM Christian Brauner
> > <brauner@kernel.org> wrote:
> > >
> > > On Thu, Oct 10, 2024 at 05:26:41PM +0200, Micka=C3=ABl Sala=C3=BCn wr=
ote:
> > > > When a filesystem manages its own inode numbers, like NFS's
> > > > fileid shown
> > > > to user space with getattr(), other part of the kernel may still
> > > > expose
> > > > the private inode->ino through kernel logs and audit.
> > > >
> > > > Another issue is on 32-bit architectures, on which ino_t is 32
> > > > bits,
> > > > whereas the user space's view of an inode number can still be 64
> > > > bits.
> > > >
> > > > Add a new inode_get_ino() helper calling the new struct
> > > > inode_operations' get_ino() when set, to get the user space's
> > > > view of an
> > > > inode number.  inode_get_ino() is called by generic_fillattr().
> > > >
> > > > Implement get_ino() for NFS.
> > > >
> > > > Cc: Trond Myklebust <trondmy@kernel.org>
> > > > Cc: Anna Schumaker <anna@kernel.org>
> > > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Jan Kara <jack@suse.cz>
> > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > ---
> > > >
> > > > I'm not sure about nfs_namespace_getattr(), please review
> > > > carefully.
> > > >
> > > > I guess there are other filesystems exposing inode numbers
> > > > different
> > > > than inode->i_ino, and they should be patched too.
> > >
> > > What are the other filesystems that are presumably affected by this
> > > that
> > > would need an inode accessor?
> >
> > I don't want to speak for Micka=C3=ABl, but my reading of the patchset =
was
> > that he was suspecting that other filesystems had the same issue
> > (privately maintained inode numbers) and was posting this as a RFC
> > partly for clarity on this from the VFS developers such as yourself.
> >
> > > If this is just about NFS then just add a helper function that
> > > audit and
> > > whatever can call if they need to know the real inode number
> > > without
> > > forcing a new get_inode() method onto struct inode_operations.
> >
> > If this really is just limited to NFS, or perhaps NFS and a small
> > number of filesystems, then a a helper function is a reasonable
> > solution.  I think Micka=C3=ABl was worried that private inode numbers
> > would be more common, in which case a get_ino() method makes a bit
> > more sense.
> >
> > > And I don't buy that is suddenly rush hour for this.
> >
> > I don't think Micka=C3=ABl ever characterized this as a "rush hour" iss=
ue
> > and I know I didn't.  It definitely caught us by surprise to learn
> > that inode->i_no wasn't always maintained, and we want to find a
> > solution, but I'm not hearing anyone screaming for a solution
> > "yesterday".
> >
> > > Seemingly no one noticed this in the past idk how many years.
> >
> > Yet the issue has been noticed and we would like to find a solution,
> > one that is acceptable both to the VFS and LSM folks.
> >
> > Can we start with compiling a list of filesystems that maintain their
> > inode numbers outside of inode->i_no?  NFS is obviously first on that
> > list, are there others that the VFS devs can add?
> >
>
> Pretty much any filesystem that uses 64-bit inode numbers has the same
> problem: if the application calls stat(), 32-bit glibc will happily
> convert that into a call to fstatat64() and then cry foul if the kernel
> dares return an inode number that doesn't fit in 32 bits.

Okay, good to know, but I was hoping that there we could come up with
an explicit list of filesystems that maintain their own private inode
numbers outside of inode-i_ino.

--=20
paul-moore.com

