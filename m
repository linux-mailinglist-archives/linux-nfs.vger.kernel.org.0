Return-Path: <linux-nfs+bounces-19268-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJuEAjInoGk6fwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19268-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 11:57:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA41A4B91
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 11:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 370A6315EEE6
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF44321457;
	Thu, 26 Feb 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fll9pnSd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB4318EE6
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103148; cv=pass; b=HFNbZ5NCPbPPD/O2FCJijn37Xgo7+LlE2H687QE3kUhRiUzGRpHnuRuYBHApkcDatPBnaZrkFEjg0aUje4RIhb15yQUvEAOChnPnnjuCDHGrVFywQXVgVhJelE9pvZfx7WCARXxfBv+oTgcMMSMruN1yo+3RG6ANulnMS7rSFlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103148; c=relaxed/simple;
	bh=uNIEmYhNC6ZvOLcIlJfYv1rGfJaWuhKEKGWZv05nuQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RR95brhm1rWaXHs/j+QP9rS1+ccbHNyxzwGYrHoPQ4Pjq60cDT7LXqWXHtWE+TJxI5NAtJmYdPgOuuUrNqdapD0E+eaRF/cZ3Mrp7+KndDfvKtuwEaV7tV0Z3/qEYTnyFQOQ+DLGYcj3lkhYw+FndRVWgRnbdmdmz5hW40vNeSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fll9pnSd; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9047e72201so96572366b.2
        for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 02:52:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772103145; cv=none;
        d=google.com; s=arc-20240605;
        b=aJzuvxE5fGwBVMSNwOVK+M+K7R2OM20+qXuYg5l3NslXAlMaiosUJlUJY5HdxoA7PG
         jFdB0ldjrN8Buw0ISonNHUnoINANhIsHdGz3C57WbanGe1R9boCt/u50gr1Wrf6rzRgy
         X+DBMgYE3zeC8P4lcQQBF7M8WTEZ5ocGtRXNi+XO5nmFMCWuHw7aXmkokRxQ0IsEW/EF
         23gcb7GZE0lhe6Bl0NBJlBUncrmCY+XUoIMlu1jwy5ppiWMyKWGNlvsXc1M96Kgz+IbB
         CVLX/b5a5MEpMI0xqxySf8/HACqCHuN53EweWdPi5aqzp8HyRWoE+EZ3Kk9wytGwz1BK
         GJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uNIEmYhNC6ZvOLcIlJfYv1rGfJaWuhKEKGWZv05nuQA=;
        fh=5SSmRZVorIZRjCeH+esVEr1UlyeXyNj7ywzDP5EbMlA=;
        b=ON0solfiTz3Y3wXuo/z2hHIrJ1TXfpy9de4mhi+BX4LAsiIg4S5w04PcyyMziydurq
         /X9rPZlTI5qWuNqF7jec3Yg6t0rimjUTdMxUkzW+k+NtXUc+tG7KXi58yZ+9bVOj+wnr
         JKGm0kMcgEHGcdxjkf/bAawDtj10X9j20CVKSUWyMKF48ToX3yL2BSi0g7iCMdhYG5gs
         qvlYPJ04mq/MNTLW8ZLrCWtEXOtMJSs4AjIZNue8hzSkDlpvkB4nO087E1qxE55JqKpK
         Zp4/IxmLg9qpf3ESlbklXFjOlZ0AHa8GkxRk4F71y4CC/OK5VIbYb+pXb210v7/Rcqa7
         5s4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772103145; x=1772707945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNIEmYhNC6ZvOLcIlJfYv1rGfJaWuhKEKGWZv05nuQA=;
        b=Fll9pnSdW79y2MULk5uZqAheMngCKZAnc7zl1fIdNWSqPpKTDGcdawonFDOqo+YvCN
         sC5uA/o9NUMxnS1I5NFTHiL1c8G75bNBTOQ1lttRy4w0FxEtFUKbuumn76kvkdAv0EBq
         gsrEpNHGitIF2warmK5JNO51wWGGApnWGOAIOOlu4SwEtd1TpbZL9O4eDXnYnyNDtwXS
         OWP+VmY1WjUyljyhCy8qnvMDMU64gDln+j+CvDHDxupf3EoSbsaWeUmg9lw9Buql9PDw
         +j0wBlEWlx3b62kAaiE2cApLdLKAPEyC41fA15ZfUdeq9+MZXxGbyl9qKarQNm+AWVwp
         0clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772103145; x=1772707945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uNIEmYhNC6ZvOLcIlJfYv1rGfJaWuhKEKGWZv05nuQA=;
        b=iFKy1RMKIxHnwLdpXrorvX+d58p7LtIXhX23UIMP8exi+n2md9MVeirx8Mj+mmOOgl
         glqTeLMAdOsHmN3wgX/YCQIZdUr4AI3h0u1C9xi9twRaj3XB+6gu17Medz9+oaYBkYLS
         uhA0nVBlyyyXjqYBIxyOp0Xi097DQ7ay5haxV5KYoiFnk+z1cmnlZixc2EIPKSAAd+8M
         InOJFBda04OHBvjz2PordwLhZUrIH+Q1Js7GASLF7eNRwv4JO2h8aqjw3hslApvj8/Kf
         CT4RyeDLAWzDQ1yx7CcZ4j7vhBKOLyoVOPTJf9xa/eqYEYMBxJPPY4YV+B1dNlr53wHt
         +S1A==
X-Forwarded-Encrypted: i=1; AJvYcCVGvDi0ZQWmACC7Mfbc3giIYUoVA+nfuHJsMQFsw9cFIDKCK0NDp83zuGUjggl+ikNGrkLNFrhJLcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnoSHtaZt5hAZuaY1zIaLuH9nlIYkKYYZl6MOqkBvZokdwhhD
	FGC6AYCE06uiJU9RhQVuSFN/r1SIZfyq5Si1GtAJ04OcmiBiver5AKO2sH1RuRKtiXR0gciT+PJ
	AqBkRnQP4cdpm/wwlPTVhZ/AoSD6Louw=
X-Gm-Gg: ATEYQzwlEwCBssWMhuoQSkERZIUo/dGIPXVfNv6rtDr+nMe7Frj44u/ab2+oJhZIaXa
	FZINkaVZ0ao314R0MphqW/DKx3OrCdfO6H9rhZP/pl8+KSIA6ONSjjGacAdB2wxduKwhsbzbbq8
	wD4kL/E8zqZBROf3TdHhICw6L4Pt2F6+CCbKh/SL4VN5AD1b75qBATubszI4ybYwC3RfmBNv6wQ
	+RgzNV4bCQJrh66lODN+5gGNdS5ZS2d+j66SBwSccjYHXYHG+pGkT4lTfeR5jYv0PetkMiJJTz7
	h1jNlkC+sV4L6XcvgPhraIxtxxJSr1C7vC0HbCBn2pSPy7FdUsmq
X-Received: by 2002:a17:907:6d23:b0:b83:e7e:3732 with SMTP id
 a640c23a62f3a-b93516f96e2mr222252966b.30.1772103145106; Thu, 26 Feb 2026
 02:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224163908.44060-1-cel@kernel.org> <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
In-Reply-To: <20260226-alimente-kunst-fb9eae636deb@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Feb 2026 11:52:14 +0100
X-Gm-Features: AaiRm53mcTQaleH3x734v1P1hXc7pPYlX4ZMwyjoEVpA_Orzt5TlXYhMMZxDzbQ
Message-ID: <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.com>, NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19268-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63DA41A4B91
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 9:48=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Feb 24, 2026 at 11:39:06AM -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Kernel subsystems occasionally need notification when a filesystem
> > is unmounted. Until now, the only mechanism available is the fs_pin
> > infrastructure, which has limited adoption (only BSD process
> > accounting uses it) and VFS maintainers consider it deprecated.
> >
> > Add an SRCU notifier chain that fires during mount teardown,
> > following the pattern established by lease_notifier_chain in
> > fs/locks.c. The notifier fires after processing stuck children but
> > before fsnotify_vfsmount_delete(), at which point SB_ACTIVE is
> > still set and the superblock remains fully accessible.

Did you see commit 74bd284537b34 ("fsnotify: Shutdown fsnotify
before destroying sb's dcache")?

Does it make the fsnotify_sb_delete() hook an appropriate place
for this cleanup?

We could send an FS_UNMOUNT event on sb, the same way as we send
it on inode in fsnotify_unmount_inodes().

>
> What I don't understand is why you need this per-mount especially
> because you say above "when a filesystem is mounted. Could you explain
> this in some more details, please?
>

The confusing thing is that FS_UNMOUNT/IN_UNMOUNT are sent
for inotify when the sb is destroyed, not when the mount is unmounted.

If we wanted we could also send FS_UNMOUNT in fsnotify_vfsmount_delete(),
but that would be too confusing.

I think the only reason that we did not add fanotify support for FAN_UNMOUN=
T
is this name confusion, but there could be other reasons which I don't
remember.

> Also this should take namespaces into account somehow, right? As Al
> correctly observed anything that does CLONE_NEWNS and inherits your
> mountable will generate notifications. Like, if systemd spawns services,
> if a container runtime start, if someone uses unshare you'll get
> absolutely flooded with events. I'm pretty sure that is not what you
> want and that is defo not what the VFS should do...
>
> Another thing: These ad-hoc notifiers are horrific. So I'm pitching
> another idea and I hope that Jan and Amir can tell me that this is
> doable...
>
> Can we extend fsnotify so that it's possible for a filesystem to
> register "internal watches" on relevant objects such as mounts and
> superblocks and get notified and execute blocking stuff if needed.
>

You mean like nfsd_file_fsnotify_group? ;)

> Then we don't have to add another set of custom notification mechanisms
> but have it available in a single subsystem and uniformely available.
>

I don't see a problem with nfsd registering for FS_UNMOUNT
event on sb (once we add it).

As a matter of fact, I think that nfsd can already add an inode
mark on the export root path for FS_UNMOUNT event.

Thanks,
Amir.

