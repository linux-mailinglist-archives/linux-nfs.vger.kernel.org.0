Return-Path: <linux-nfs+bounces-22253-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k4LaDdd7IGq84AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22253-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 21:09:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0F63AC3E
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 21:09:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=euU2EJvP;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22253-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22253-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39C8E3056828
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EC03909AB;
	Wed,  3 Jun 2026 19:09:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAE3502A3
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 19:09:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513746; cv=pass; b=C7K2k2D31tynx7LFZfTNPyx/ez65J6e4E6LW2PSLt4PCacOP4fY+Bvra8FppbGhC+ZTdEjOJ1F4TRZ8a75r/aCdg4hE5r7jfzXhoQxtqM8PWdgWsHYgjbIMoHeF/A7y8UFGwAJX0wmk3oVGPbuJ996aIVx6CLOth6CpH4jC3pyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513746; c=relaxed/simple;
	bh=KoIqLl9ia/cQ3vvTGufqzPvmoTqJlnriFaNn4bzxdYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrHbZHv1e3S937J4AisFB5mLoEcI8pjd6tw2Tw6AvUX6tZzmVRoLXT5BC154OS40KVtrIxcL+5FSW0C8i6gkVmE052+oJaI2yCpRgcAXgI8ReDOcFSU8Mz0KA6/yV07FRFW/lpbp4ZMRlvl0U0eM88rF6CtpHoT2b7Qt4IAwUhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euU2EJvP; arc=pass smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so1620a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 12:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780513744; cv=none;
        d=google.com; s=arc-20240605;
        b=jnWaYHuIE0XwRvHsMsPSAGzO3uP9aHi1HP3ytY9Ct97/LoJ+nCaGzCG3YREPpUqc2a
         eWfa9J12Z6Ne/B1XmAMpgPOm1TxNvXtGwBhiJw/YpzpN1XQ7FoRdt7NzOriId/nO1HKS
         6Zs7sgano9NjcmTuojBXh0CAUqTLeAty13RbTVjIR0CEzNCn5qsIb6571TcQHxSVsetB
         JraI9ySedBqhEdP2+r97DjBvWGMzeQHbTDL+EaKTLDWSVYN6KCB+JOE6PFjb8zGRSkkD
         CafQG7+hEaVUcvz64+H5SmeoIQxJ99HuSDNGRkoH8XCHPqYHOkajuSiZVEhNBtwFai4j
         xeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BTBjbh7gzisLP+SJ/i8ZyWlLdf3Qeg+7FNqKvmHqeM=;
        fh=RR3mVOHweUxgKOtNp4R+k0XzbgVlzALrpiHOV2D2AwI=;
        b=Fx4le+NeEqC6uyUhWmGCkNAxYwym8J8nWWfvGfW7BLvSAPHC4nZKJtPwuOj8AIEeWr
         ukWhI+aMUx/eJxstiAMi9xy2l2bicEimHbMZ+PoNpHLV2jU6a6FvNb6Oz8ybDneSudsl
         b7FSEj7jzZJjmv0usYQW4TiHz+muxSzi0b5hR7IpiZcLSdTk65NehBvmTvJJtIfHoG1I
         oJNG0bt8Kibicrponjte/FP5fKndilV4zX3ItynTwqE2e9PMdKnFiI2B7ayHQZT/aXtF
         6Xo1JogzSUbH8TXpIz8XCkOE+ePCjsVRBQ5eKoIOxZI/VhVOAUVpKwXj0MKSd8wyLCHR
         UH5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780513744; x=1781118544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BTBjbh7gzisLP+SJ/i8ZyWlLdf3Qeg+7FNqKvmHqeM=;
        b=euU2EJvPIcSobslZIDTlm+KwhLhzm6mgfDMMta+3eb2yKyjbYfepdHd3kR0Ot4BcFy
         eIxT3OepTnUat/zOspR105lTPURT1d8qChCGwOIoQ1EH1ZJlcRoudFcpnZmbGS+Uz5dv
         5ieFUy7zCxM82v9AeayWk8mi4nvDz2Z8WD19zdeNAWnFBR2uM5k5JbG5ApBUfcs2za+J
         6pfGO0Q/TNMQyak3vLNzXEM0/5jx2JWmj2nP3Bc/xZAZVbl14PnI3xuZmwNsCC0O1C78
         lGouqM0Ex6saVn7EPFJc78vZBzffYCLOCyGAhuCtQutiQG7/AqvOO/KK+crCM+GO69X/
         YTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513744; x=1781118544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BTBjbh7gzisLP+SJ/i8ZyWlLdf3Qeg+7FNqKvmHqeM=;
        b=EpPE9QwNR5dKYE7JVZRfn3bL3m1+9C57MkGMwPh0FCA/TjzidXe7KI9xF5VOEFY1Qo
         GxGoMzawqCxmXHUQNv8NtvwPt383iJdXI+lGhoxzJiQMx7V42bRCSJW8YUUDHYwyFRKn
         PAluEkp1jQHL5QW/rmZmSMTNa2buvA3VvnE/V5Z8x6E8L87bqKkpPuf84O+19w2lRiyy
         7TTvl3bPXsRRikStWjrgoc445+zAU0qkUdzves6dZQFrX7eNXLd+NOg8qW18qr70Bds3
         H5dFlAunjbxT0QyXms+avGBpHYDAZBZXBjQceV4z2vk52BPq8A3NjEdb9QzBbEDGC3lg
         O0Dg==
X-Forwarded-Encrypted: i=1; AFNElJ8h8TRc/gtj/WFWjVK1jYhl7vSuYE2VgFATGTIYlGD7LHCMynPDIM/voeAA06HKc+AsUBWFCFGdMFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzOT8s9M6Zr05Up6EjPMmXHQve0jmR4vBu/NpigRS0LGM+s4e
	Kn3utZNtS5wFM1vcz45nCCLuNMgZ0ZTI/gwyEmFjQNudTmqAbtK4+OBujRQs+wfnGqGgE54cHHW
	hXQfqjbM+Uyx7uCCBEyOsnlcW17qaOqWQnIHr80Tr
X-Gm-Gg: Acq92OHXOJcyAfFi0KqGKTPtWiKl18vSKTRgtYW5flZIKxRMQYBsfey3/42EQULQ3+f
	YlNsl3MzTkDmCBLAnbkgquJMiFYaC6Axlu6n+Mxpdoq1h8bPyVPL3yz+I1Opil4ki8mO19xw6UB
	8+SXFUMbDIHJdomG8v0RuX14we9BCZfy0IsxIRXi7ai4bd5xaIV5t4k+j31APZUngwr3rotHQsk
	5ULHv2yBJz/UEofueNwVnuEoca48fZtJlys5SVQmiYToX/iWUj5a3qEcItdzZ6womVzK1qVG3Od
	xFfuZpDFuIWuFZtiDoTRocSL3zXUzzF3lR5qy+9Xg9xKU2jr
X-Received: by 2002:aa7:d294:0:b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-68f12dc72c7mr5570a12.7.1780513743150; Wed, 03 Jun 2026 12:09:03
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV> <20260603182454.GX2636677@ZenIV>
 <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
 <20260603185324.GA2636677@ZenIV> <20260603190225.GB2636677@ZenIV>
In-Reply-To: <20260603190225.GB2636677@ZenIV>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 21:08:26 +0200
X-Gm-Features: AVHnY4IxxlNTB4Lk88aYUMiy55vdsorSgUlDA_6cJFrKOhsQwOKgMzOyo629T00
Message-ID: <CAG48ez34NaE5DCdC=VQWFRPds6JHwGq2YJDF5e6XUtGPNfQq+g@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22253-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.org.uk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3A0F63AC3E

On Wed, Jun 3, 2026 at 9:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, Jun 03, 2026 at 07:53:24PM +0100, Al Viro wrote:
> > On Wed, Jun 03, 2026 at 08:46:07PM +0200, Jann Horn wrote:
> > > On Wed, Jun 3, 2026 at 8:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > > > On Wed, Jun 03, 2026 at 07:15:23PM +0100, Al Viro wrote:
> > > > > On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> > > > >
> > > > > > Fix it by taking rcu_read_lock() around the mount::mnt_ns acces=
s, like
> > > > > > in __prepend_path().
> > > > >
> > > > > > +   /*
> > > > > > +    * Containing namespace.
> > > > > > +    * Normally protected by namespace_sem, but there are also =
lockless
> > > > > > +    * readers (which must use RCU to guard against the namespa=
ce being
> > > > > > +    * freed).
> > > > > > +    */
> > > > > > +   struct mnt_namespace *mnt_ns;
> > > > >
> > > > > Umm...  It's somewhat subtle - at the very least you need to expl=
ain why
> > > > > there will be an RCU delay between umount_tree() clearing that an=
d
> > > > > having the sucker freed.
> > > >
> > > > Something along the lines of "removals from namespace are serialize=
d on
> > > > namespace_sem and guaranteed to happen no later than the active
> > > > refcount on namespace reaches zero; freeing of namespace happens on=
ly
> > > > after the passive refcount hitting zero and there's an RCU delay be=
tween
> > > > dropping the last active ref and dropping the passive one that had =
been
> > > > implicitly held by the fact of having actives", perhaps?  Only in
> > > > more readable form than that, please...
> > >
> > > Hm, like this?
> > >
> > > Containing namespace (active).
> >
> > Umm...  That's actually "active or has _just_ dropped the last active
> > reference and didn't get around to scheduling decrement of passive refc=
ount
> > yet", unfortunately.

Ah, right, I see, because the mounts of non-anonymous namespaces are
only cleared in put_mnt_ns() after the active reference drop.

> > Hell knows - "active or deactivating", perhaps?
>
> Note that "active" in such context is easy to mistake for "active referen=
ce",
> which it definitely isn't - it does not contribute to active refcount.
> Mounts within a namespace do not pin it - it's the other way round; they
> are guaranteed to stay live until they leave the sucker.  Anything that
> hasn't left by the time the active refcount of namespace drops to zero
> will get pushed out (and killed off unless there are other references to
> any such mounts)

(And there's also that weird detail of how, for anonymous namespaces,
the active refcount isn't used and AFAICS never actually drops to
zero...)

So I guess I'll write "Containing namespace (active or deactivating,
non-refcounted)."?

