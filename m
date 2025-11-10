Return-Path: <linux-nfs+bounces-16224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3647C44EA1
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 05:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 379E734606F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 04:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1C21B9C0;
	Mon, 10 Nov 2025 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkCje6Am"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB728E59E
	for <linux-nfs@vger.kernel.org>; Mon, 10 Nov 2025 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762749225; cv=none; b=Ts0EMIR5Kigmi+58PRD/zEVCX7CTS+urKP+40hlC9+N4AQLO5cDWLlQnmPQHxzeTNkPugyFWkm4DPWSJUNmZRNsOUnEZLf0vv66LKCEv/6xkjnQi/sAjACl3HESoqGbpBoEFCUkUEb83krcAPeaV8YOqAXJ8drZEMDlwaXnrYg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762749225; c=relaxed/simple;
	bh=w8sy6LbULc/UxZXqx2ftURwAETXPCBr6iiP2o/qfkp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBEBW3tCVgrOjlxoHOgCaYc9j+YanxpDiNNCm3unAyFB0jP9CP2rwndccVtank8JzY+4VW+gQ1Yu0IKpCjpaWmiaK1vzJSAy+uvx+g5tTx5uqvnWAPQDV8vdlN/ZrZ7botrtpR5s+FriylqXCupBb21cjFtsLnTzTRolymXLoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkCje6Am; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b72134a5125so366017266b.0
        for <linux-nfs@vger.kernel.org>; Sun, 09 Nov 2025 20:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762749221; x=1763354021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/w123mRKvVh/UdPsQx0J7UGRQ/9XO7IHRYSSqSkZ3U=;
        b=RkCje6AmNPPjbcJxZsUP93i6e1jikcc3jnMdn8DH2qbkhAfwhsY3x/AjayS22pB/am
         36z3bCDEnl9FUrN7KneiWJE+/LTzgnchOL5khLVFaGGOPMxVvq5ueygNOGbpVsT3x28g
         P4/bSluGINmtY/ch0u7tVCEbDaubYUH7lbQcpIQW8hHln7dBcrCCUIg7ocxuaLxrVSIQ
         PkVNbBbnxrmuBWWB1bdpxo1clfX5clgAyeCRwUOwN3Qo82e8SetAI8FcTju6g8WFA6Lf
         Ms9Wr/xyL/dKGbdRi2Qn62OjjMMnXICra0yQIo3LvRmyP26wSRSMxYj7xmQnpsmieQqw
         k0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762749221; x=1763354021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/w123mRKvVh/UdPsQx0J7UGRQ/9XO7IHRYSSqSkZ3U=;
        b=X8cJHxr+p7mPOr7z7dTfHyP0wWMMONrCx5xYKBvCJxeVyYQ8vqHI299uFZQcBb3kXT
         +fSd0rEcNb9i4hrRZ2fI1Cu0NXyxvv5O4et+JsdD4U7ZMD00nSWAVoRXaUd6q7mTUABY
         tEOX2fUKVLQQ8dqbSgtb61ZjjPkGtd+Rv34Kl/Ts3zW2isVy8uPUZA7VytAc5+u4Amqg
         gv6602w/f3cUKyXFzOpHz9qGBI04Tl4AFDBBa4b4hG+TvH10x9/Sx97Z6h8MKhPm2rOe
         cai68z+HRx0Sk2srNZLSt78u9vasiA5bOTm5/GicVjGVxMUt+n/odG4XFadBfY6BhIMw
         VGAg==
X-Gm-Message-State: AOJu0YyrgcRyIVCS8g7XPV8ZIzdL/gjiuNCmYjKPpFm3X3Uh3p5hx9K6
	uO+lAEKFeKdl0li1ibVpF72uNrzooGd7exJ+j87cbuClx1QL4/a71B0oC7gLlI+PYztPcVV/9ZR
	r17LqPE7/rswJZhsBQEmyYIsk3NhSxGw=
X-Gm-Gg: ASbGncsd/rMC9KDRqSFNsqd34pQX4Vm5HjoM5HnC9G/2+/4AE8mh1lQWj23g+mvvCAn
	RPnhiYnyEKQwuVgft2QAqf+QuWHB1/dRhKwYyuU+SEiySqJpQ/FBzl6Mz0Bpy0H+/leL1Foto1x
	fFrZhavdXV1OvcO/gQsH9U1Q7GWgClGzgEmI5hqBUvlz6aVSAKotMkiJOD2ebSzoBPztRjcjeT8
	eeRSocPnuj3VAuDdAgTT2R8CPoMuYTK6f//sra1F9jWljSbLTlj9tWS4VY=
X-Google-Smtp-Source: AGHT+IGmiVC7gYQBUDbomHIqZbmtLIIpclNMfkjqDZdGOtc7wTUYCIL3VLFqTiv85pKXJYZWq+aYZ50hTGb7eNMPras=
X-Received: by 2002:a17:906:ee81:b0:b3b:5fe6:577a with SMTP id
 a640c23a62f3a-b72e02ca0f7mr732413066b.8.1762749221098; Sun, 09 Nov 2025
 20:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rmuH59F9dpvrop0f+8XfVnK6fZHyqLhb10UsYfa6XJgw@mail.gmail.com>
 <CANT5p=od_-93SNQtvaid7yrW_XTqCN5_MJS=cYzgydrPkhtJ3g@mail.gmail.com> <176250668306.634289.13564785727214953785@noble.neil.brown.name>
In-Reply-To: <176250668306.634289.13564785727214953785@noble.neil.brown.name>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Mon, 10 Nov 2025 10:03:29 +0530
X-Gm-Features: AWmQ_bk32tbfD6OqXKo53ju4QIj_F2W_AKI7BVPkrgz0meM0VSwzMFM7IZ6p3kA
Message-ID: <CANT5p=ohyQZcnYWN49JD8XfwmShPy43dT1Zb=7-Jn4vrZej6KQ@mail.gmail.com>
Subject: Re: Requesting a client side feature to enable/disable serialization
 of open/close in NFSv4 clients
To: NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org, Bharath SM <bharathsm.hsk@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 2:41=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
>
> On Fri, 07 Nov 2025, Shyam Prasad N wrote:
> > On Tue, Nov 4, 2025 at 11:18=E2=80=AFAM Shyam Prasad N <nspmangalore@gm=
ail.com> wrote:
> > >
> > > Hi Trond,
> > >
> > > Several months ago, Neil from SUSE provided this workaround for their
> > > customer to allow the NFS clients to work around a bug on the server:
> > > https://code.opensuse.org/kernel/kernel-source/c/d543ea1660582777ca7f=
8a8f91afd048de09b7b6?branch=3D377837fd53dbd7a6c35cff41d5c42ab1224512b0
> > > However, I see that this change is not present in the mainline kernel=
.
> > >
> > > I would like to request this feature on the NFSv4.1 clients in the
> > > mainline kernel too, so that we can have this support in all distros
> > > in the future.
> > > This is a useful low-risk change that will provide a fallback in case
> > > of servers that don't implement this scenario properly.
> > > Let me know what you think.
> > >
> > > --
> > > Regards,
> > > Shyam
> >
> > Looks like Neil's email ID has changed since. Updating the email ID.
> >
> > Hi Neil,
> > Is there a specific reason why you did not submit this patch upstream?
> >
>
> I didn't submit it because I didn't think it was appropriate for
> upstream and I was confident that it wouldn't be accepted.
>
> We don't work around bugs in servers - that would give the server
> vendors an excuse not to fix them.
>
> I implemented that patch for SUSE because earlier kernels *did*
> serialise all opens for v4.1.  When we released a newer kernel to our
> customers which removed the serialisation, that created a regression for
> some and we take regressions seriously.  But it wasn't a regression in
> the kernel (which upstream takes seriously), it was a regression in the
> customer's experience (which SUSE takes seriously, but the kernel
> community is less invested in).
>
> If a buggy server exposed a weakness in the Linux client (e.g.  could
> cause a crash or an infinite loop), then I think we should address that.
> If a server raised the possibility of ambiguity in the specification,
> then we should consider addressing that.  But this is a case of the
> server clearly behaving incorrectly in way that doesn't harm the client
> and isn't ambiguous.  So I don't think the upstream client should work
> around this bug.
>
> It would be much better to ask the server vendor to fix their server (or
> use a different server).
>
> NeilBrown

Hi Neil,

Thanks for that clarification.
I'm working with the server team on Azure Files side on this one.
However, till the server fix is done and deployed, I was hoping that
we can unblock the customer using this workaround. They are not using
SLES as their clients, which is why we cannot provide them this
workaround.

Since this could be a quite useful knob to have on the client even in
the future (for other servers), I thought this could be a good
candidate to have the changes upstream.

--=20
Regards,
Shyam

