Return-Path: <linux-nfs+bounces-14271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AEFB52940
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 08:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D561BC70D3
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B721DF97D;
	Thu, 11 Sep 2025 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgKkmaPN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DD255248
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573572; cv=none; b=C7o4kzwNNvivQUPFWX+mKsfX+RuSxV5qjDn+QpW2sU2xvOnqmzF5Ta6RJ9NtOgYKjsLhMbdtcQX8Wcv676tLqSV46YArk+JQcmVLsLM4ZhkGI/fHtwUD6eXqPbUbLoxW3SMMBHHdI7Aylj/d0IVEv6UANTQTfE4iIvfbxtMg+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573572; c=relaxed/simple;
	bh=4FSDHluQu7g7Yaxe2x8ngDmMEgh4W+wJ6MiCxsSPiKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TjPQajVkTTAbzCAjcycwfuIKZgB2f4iYJwwiCBWCewQ/cIxXjpyeMK90GsWhkwc3kIXuScBMFYwD/hj2rtPfgeEa6pc+DsbiM5fRnNM2Wo1VkX60TqxIpIhF/u4wJYJKiJUCoynnO1PZAA2osihdYM/JmjBDQCMa3ubrH9gnLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgKkmaPN; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30ccea8a199so347918fac.2
        for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 23:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757573570; x=1758178370; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eDjqyWMuqm1SqRPklszWSNC62y8RZXNPhibLfJcNNY=;
        b=GgKkmaPNd9mGgn06kmNM0/D1VgFdpkApS57kPh2AHzfsORJInaqPmFe94d7XL4LU5l
         DM68zcMxQ26Lw/JqYpYZH4mR1eJcxk/m0qhclgBMdc3H8mUeX+Qi/IMxEV+Nd2qKnKZb
         I+7zBrKwksMth+K8Xx7iyEvjCk4SyCtGQa+rrwR8j9Bg8J7TO24LDi0o/K0MBiFZhwR/
         CZK8N4OWmq0AtX+mZJTtsFYUaBETybCdT9n2KoL/Q3Mhn6AYChgDNPNPbsvOUxK26FHG
         GQDw/14cCis0a0ZjIs2ni8hqfGJoVb4G0GHZgDlYQYDuXQ5nhTS7g8t3G6YRCY79wzMW
         cjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757573570; x=1758178370;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eDjqyWMuqm1SqRPklszWSNC62y8RZXNPhibLfJcNNY=;
        b=cpSBB2s+3L9wkhXT8ssbxjquNAkX7S8uhol84br9RRsR85F6bpEdDE2+nqU9/iqMi1
         19RwQTN7F/vwREZCKJ/RIU/aTqNiJlpRYMpS19iLIeXqovpGnJ7zOfYZr/Svwnkenrsj
         gln/502tLGqT+VfFdDJB9igp6TmXIpRunDYIJqfP1llyl7jnBrv0C53Mht/yl7BNAzNh
         v9e9/NPefwY1Lb790wfy/BIPcrUj7iZ5Cm06aGb/MAobyVjscqAXM5OjsUC7TwdODoAF
         lCDu5b2ngNkTmXCrfVj5AOJA3mNbHp2HMYFHWb88AM18eyX5BYk5KylrbpO892F3tHKZ
         ysdg==
X-Gm-Message-State: AOJu0YzEejZlbMGChEGRNSIKvT+eTD3vgARSI3gFisyNf/gS3DQq9PYS
	WRslb0qT9mbVdpwtECqMoaup86IyEPQfD/SjXSzPVu6ShlBW59MlHuugF+mau+MlEqLDOKSz3YQ
	ikkX8UOp7VqYOAPnDCDl36AQxM2gAVBrs9w==
X-Gm-Gg: ASbGncv/bRKDBUwKV543beVGrWZlYSVCHXSluBtKqPxCDOpzpWi2A/1934p124ZE3Wp
	AHAdY4cVI4ibAktnysipLrzG/9TJ6ByyQ9OPkAERurMWMxoYN0p5gdib1JxCM5ljbBmxlMIksGC
	kyrMJLcAgRB9AARu2DGIyOLCiZXjFD0h+oWfMB3netkM+t6XTQ4GtDbs87K6aOYFo9lG2zu2EQT
	0MdVGY=
X-Google-Smtp-Source: AGHT+IEtCoYunK8SpF9UDzISuToiDgmbzRjoKGvdQTx0uFYTmKQV3T9AsG5VIlhCYRYOSHm8yJ6dOILr+tWA1PlpPyc=
X-Received: by 2002:a05:6870:c10f:b0:31d:736d:ebdd with SMTP id
 586e51a60fabf-32262f9b8a8mr7909777fac.13.1757573570005; Wed, 10 Sep 2025
 23:52:50 -0700 (PDT)
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
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
 <236e7b3e86423b6cdacbce9a83d7a00e496e020a.camel@kernel.org>
 <11a66cd2-7ffb-4082-a8cd-ae34a48530af@oracle.com> <72dff4694962ff72dec90e4071ef993134dfae27.camel@kernel.org>
 <118e8e22-39f8-4cb8-87c8-81637ca280e2@oracle.com>
In-Reply-To: <118e8e22-39f8-4cb8-87c8-81637ca280e2@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 11 Sep 2025 08:52:00 +0200
X-Gm-Features: Ac12FXx0phWcY6eMWr47lCO2W_Yefp5h5fIHhVr49_pNjPeHn_DEy3uF4LX0qbY
Message-ID: <CALXu0UcjABO82T-fevW7M0Hmdu_p6dKb9FwO=Hddco4B7-JCXA@mail.gmail.com>
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 16:35, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On 9/10/25 10:30 AM, Jeff Layton wrote:
> > On Wed, 2025-09-10 at 10:14 -0400, Chuck Lever wrote:
> >> On 9/10/25 7:10 AM, Jeff Layton wrote:
> >>> On Tue, 2025-09-09 at 18:06 +0200, Cedric Blancher wrote:
> >>>> On Tue, 10 Jun 2025 at 07:34, Christoph Hellwig <hch@infradead.org> wrote:
> >>>>>
> >>>>> On Mon, Jun 09, 2025 at 10:16:24AM -0400, Chuck Lever wrote:
> >>>>>>> Date:   Wed May 21 16:50:46 2008 +1000
> >>>>>>>
> >>>>>>>     dcache: Add case-insensitive support d_ci_add() routine
> >>>>>>
> >>>>>> My memory must be quite faulty then. I remember there being significant
> >>>>>> controversy at the Park City LSF around some patches adding support for
> >>>>>> case insensitivity. But so be it -- I must not have paid terribly close
> >>>>>> attention due to lack of oxygen.
> >>>>>
> >>>>> Well, that is when the ext4 CI code landed, which added the unicode
> >>>>> normalization, and with that another whole bunch of issues.
> >>>>
> >>>> Well, no one likes the Han unification, and the mess the Unicode
> >>>> consortium made from that,
> >>>> But the Chinese are working on a replacement standard for Unicode, so
> >>>> that will be a lot of FUN =:-)
> >>>>
> >>>>>>> That being said no one ever intended any of these to be exported over
> >>>>>>> NFS, and I also question the sanity of anyone wanting to use case
> >>>>>>> insensitive file systems over NFS.
> >>>>>>
> >>>>>> My sense is that case insensitivity for NFS exports is for Windows-based
> >>>>>> clients
> >>>>>
> >>>>> I still question the sanity of anyone using a Windows NFS client in
> >>>>> general, but even more so on a case insensitive file system :)
> >>>>
> >>>> Well, if you want one and the same homedir on both Linux and Windows,
> >>>> then you have the option between the SMB/CIFS and the Windows NFSv4.2
> >>>> driver (I'm not counting the Windows NFSv3 driver due lack of ACL
> >>>> support).
> >>>> Both, as of September 2025, work fine for us for production usage.
> >>>>
> >>>>>> Does it, for example, make sense for NFSD to query the file system
> >>>>>> on its case sensitivity when it prepares an NFSv3 PATHCONF response?
> >>>>>> Or perhaps only for NFSv4, since NFSv4 pretends to have some recognition
> >>>>>> of internationalized file names?
> >>>>>
> >>>>> Linus hates pathconf any anything like it with passion.  Altough we
> >>>>> basically got it now with statx by tacking it onto a fast path
> >>>>> interface instead, which he now obviously also hates.  But yes, nfsd
> >>>>> not beeing able to query lots of attributes, including actual important
> >>>>> ones is largely due to the lack of proper VFS interfaces.
> >>>>
> >>>> What does Linus recommend as an alternative to pathconf()?
> >>>>
> >>>> Also, AGAIN the question:
> >>>> Due lack of a VFS interface and the urgend use case of needing to
> >>>> export a case-insensitive filesystem via NFSv4.x, could we please get
> >>>> two /etc/exports options, one setting the case-insensitive boolean
> >>>> (true, false, get-default-from-fs) and one for case-preserving (true,
> >>>> false, get-default-from-fs)?
> >>>>
> >>>> So far LInux nfsd does the WRONG thing here, and exports even
> >>>> case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
> >>>> server does it correctly.
> >>>>
> >>>> Ced
> >>>
> >>> I think you don't want an export option for this.
> >>>
> >>> It sounds like what we really need is a mechanism to determine whether
> >>> the inode the client is doing a GETATTR against lies on a case-
> >>> insensitive mount.
> >>>
> >>> Is there a way to detect that in the kernel?
> >>
> >> Agreed, I would prefer something automatic rather than an explicit
> >> export option. The best approach is to set this behavior on the
> >> underlying file system via its mount options or on-disk settings.
> >> That way, remote and local users see the exact same CS behavior.
> >>
> >> An export option would enable NFSD to lie about case sensitivity.
> >> Maybe that's what is needed? I don't really know. It seems like
> >> a potential interoperability disaster.
> >>
> >
> > There is also the issue that exports can span filesystems. If you have
> > one fs that is case-sensitive mounted on another that is not, and then
> > you export the whole mess, the results sound sketchy.
> >
> >> Moreover, as we determined the last time this thread was active,
> >> ext4 has a per-directory case insensitivity setting. The NFS
> >> protocol's CS attribute is per file system. That's a giant mismatch
> >> in semantics, and I don't know what to do about that. An export
> >> option would basically override all of that -- as a hack -- but
> >> would get us moving forward. Again, perhaps there are some
> >> significant risks to this approach.
> >>
> >
> > The spec is written such that case-sensitivity applies to the whole fs,
> > but in practical terms, would there be any harm in allowing this to be
> > set more granularly?
> >
> > Existing servers would still work fine in that case, and I don't think
> > it would be an issue for the Linux client at least.
>
> Yep, the issue is how existing NFS client implementations treat
> fattr4_case_insensitive and fattr4_case_preserving. Research is
> needed.
>

It is per-filesystem.

Windows 10/11 NTFS has an optional per-directory, but that causes all
kinds of trouble, and per-directory case-insensitivity might be
depreciated soon again (ReFS chokes on it).

My recommendation is to stick with the per-filesystem setting.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

