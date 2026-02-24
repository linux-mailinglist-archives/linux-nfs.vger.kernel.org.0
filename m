Return-Path: <linux-nfs+bounces-19167-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFBVN5Z8nWmAQAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19167-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 11:25:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39F1854AE
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 11:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33B393005AC9
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8778377541;
	Tue, 24 Feb 2026 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MChaKYxW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F771428F4
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928696; cv=pass; b=L7T1i+ZaKiCCaknd2DvfEmBao1wuMiCBvotKKk2muvdBlLz7k2xoyaCGeduJInw2qXmI2dr/NeVUN5WRcO/ff8zB0wvoPfUSFa9yWhYlJMV5h2FgH5m+GMbIJcCI8HDsxI5uCouRwSUuZIQm/SYGIHWDedGvP1wtv611V6mCjiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928696; c=relaxed/simple;
	bh=hHRJy8QJuXqrZvRYe1s2e7pWgh0LxMfTN14cPF1l6/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2TDPhV9wze7rdDqqcL/4Uhx4VsHtfVxz9jCJyabOJHeK4LskscWPQEyg+B08YxiIq6I9xdK0wbMGKQ61oQIMUgCGsSeI2Aj3XQeghdXXv5ptEofEmO3MKdS9M/LyNmJ/+BdjqhVw+qM8LECy3ISPXIMYBUJeBIk/HuHpSFzKXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MChaKYxW; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65c0e2cbde1so9192247a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 02:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771928694; cv=none;
        d=google.com; s=arc-20240605;
        b=ggAn/8kIgTyD5TO6DNzV2fdbx1e37EOvxkJeAzvHihG2ZmPT3teX3uU2ZN8UaxpJMg
         8tcaORXx0P8BZsd7zAuVp9yQmsa1cieaDKXbqVzWnv64nDjPahORB0h9RC9tlGMF4GXm
         M+zviLWQvG+66spfW0FXSvmFWAaJnrbuWgI5mTlv6HX60kiJkCBUT3/EWhIJdPBYla6V
         HezouurbqzCgLu/wcEIRSv5T6H1Lr0HxJ9cnfHDt3NhtK1LH+Vuo0tOQ+zye/HBXJGIy
         RyB4KqDGkDebut7F5hq9ec0uKmYCtoGPLPiL/ygtvEZqjd/D/yrvlVFrwXhA3QYbYuf2
         /eoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4CfP6ijHdd5S7Ck6QpALkZNQy7jw70n0RYyKMKxeBg=;
        fh=LzhgMuUhYfIxi+ZW1hjrWjYsZNKiLfFs5wHUkVsPyLM=;
        b=Y6fcrvbvLAE1jrhuwqTfDFdAvfqzbcCs6YHTC1JsRqcEZGtMyFijo9qQ68vXTjqOr0
         6h7NdFILEbRWL6fw1Yquc92B7dYJgI8MFu4LCJSvYAiau6LBO9gR4BsPevSf4zm6yfEn
         WeGkBId/pygEmNo5atjG4325bt+CRcL4EbeRUAttcguv3OSXMBVMgMAw6iTWzQDK9wpR
         N20kVY9tK0thTlRofepn4WgC8UfOG7rXLn8jvs+Nl5PzpXxwgiiQYGFnD4huGL6U1vrS
         K6wvc3qiuYZy4r5gqSA+OrWYihVexnMgxCFEW9IJ7xP87trYnmBhBEtIPMBgIEG3CinY
         MLuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771928694; x=1772533494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4CfP6ijHdd5S7Ck6QpALkZNQy7jw70n0RYyKMKxeBg=;
        b=MChaKYxWvD+DZlEUZHvsI5mLm5EpSg1ddwUMmGClKk5+7mOWr0YwhCy2KJSflhFQYR
         +d+KHhkDKi9kCl6afnU1ilBRws0fBmZmNBPo/EsPCJ/c2UbUJFpQI+5aYObhN6pGo9gD
         CtypBg9If3bVDqJcbqCJjW6ymIJJLHkhCHMHe8Qs6rLZrSpYL3Nplxcn3OH8+jUr25kI
         WeDzG8yTRbMDSiUD0b5URHmZnxqE+YllpX4S+3nP4cd4zRlYo6ToCH+mSJ/X1IW2QT3a
         LJP5HdmauhUvgYH/bgElNAnrLRz/2mxp/cVF6Bq0+TlllmQDpEDKT0ifOg/ZJNn9mvL7
         dGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771928694; x=1772533494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4CfP6ijHdd5S7Ck6QpALkZNQy7jw70n0RYyKMKxeBg=;
        b=cYKu0Tk6pBGMmCFQcVnK9fFHglG6jyfK5Ymhmbh5Qi+VTcZ9qe0v2t0sD/9iA+TfjW
         J1MlhcjJX0YrCY3T74JNiyny32u5bJbHGLEZGVDzER7PF8IEEmN+LgbykXHHdoCJyZKD
         tEf/cFMEw5foxI7IIVlZKtBfB9gQXWIzwZtmcvUk9M4dAV1DPKjzb1M5iYf+k06Lbdx3
         7OPDILfGORm61HPO7XfHjOzitgt6IFB5c5P6N6kv2QJyMVmLkaYUuDoN5S8xrBXXgZP8
         u9hMYGxBnCpLiKPFPsTDkM+wMGYyH84YqgNRUz+Sd8Ju5N29G035S1K+elhageGePISd
         u4dg==
X-Forwarded-Encrypted: i=1; AJvYcCX10NnUUWhtgUglzQIaM0iD9xPIFdwndm/CNdZMiIHdbV76vxvhfl/RkwIsgUk59ZSnvki/R6xv66o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEB1M6EQkEBTJNW94gMoU+MGVWuk6Sn8z92YFieXZB/MI8jzS
	OITQznr5BeecWQ0Kfd/M9AZf+41Ur+Fzfn+E3uWJ3J+g9cmMXVzzfR0gu48gIJYV7qa9w6pTKVH
	uz+ij+llT7wicU3oDCG+tQ2HCSksWUaF5zQ==
X-Gm-Gg: ATEYQzw3WWdNNLm6lAuEpDYinwUh9hc1A90mGQIJ+ehII2KAjWx9+otEi1neryUljEK
	t1zSUqUcswlN7aaXQqGCzolzu/e62avFPKLC3EWqZOXG63q7dOC210Kdy6AeNbVsBtqiw0ZB4qu
	huruVfOC8bfyF9WR1UBNThY+uMP3ZOkpQLCkvXFKLT4WrN3/UVskBR+Njg/nVAfk5X/4VASGXWb
	bkCRZaljHg6A+URjWHgZO7kbno4PKQSlsXQt/gscb3fzH6rKWFzx4HyIIkIWviA615aKcbz3hXm
	0FLF0Q==
X-Received: by 2002:a05:6402:13c2:b0:65c:23f0:a7f7 with SMTP id
 4fb4d7f45d1cf-65ea4f1a749mr6987443a12.20.1771928693804; Tue, 24 Feb 2026
 02:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=orpQdzqxjNronnnKUo5HFGjuVwkwpjiGHQRmwh8es0Pw@mail.gmail.com>
 <20260224051729.GB1762976@ZenIV>
In-Reply-To: <20260224051729.GB1762976@ZenIV>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 24 Feb 2026 15:54:38 +0530
X-Gm-Features: AaiRm52xL9joVWGaho_Wba2a4d4msaJGHOfSe3rD-ekT6QA6DAsfPGrW7BKXMFM
Message-ID: <CANT5p=pDDjRGF1_vCKvmK+PvXpMQTOquZEEdddFN9mUdTiksHw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Support to split superblocks during remount
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19167-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.org.uk:email]
X-Rspamd-Queue-Id: 5C39F1854AE
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:44=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Tue, Feb 17, 2026 at 10:15:58AM +0530, Shyam Prasad N wrote:
> > Filesystems today use sget/sget_fc at the time of mount to share
> > superblocks when possible to reuse resources. Often the reuse of
> > superblocks is a function of the mount options supplied. At the time
> > of umount, VFS handles the cleaning up of the superblock and only
> > notifies the filesystem when the last of those references is dropped.
> >
> > Some mount options could change during remount, and remount is
> > associated with a mount point and not the superblock it uses. Ideally,
> > during remount, the mount API needs to provide the filesystem an
> > option to call sget to get a new superblock (that can also be shared)
> > and do a put_super on the old superblock.
> >
> > I do realize that there are challenges here about how to transparently
> > failover resources (files, inodes, dentries etc) to the new
> > superblock.
>
> That's putting it way too mildly.  A _lot_ of places rely upon the follow=
ing:
>         * any struct inode instance belongs to the same superblock throug=
h the
> entire lifetime.  ->i_sb is assign-once and can be accessed as such.
>         * any struct dentry instance belongs to the same superblock throu=
gh
> the entire lifetime; ->d_sb is assign-once and can be accessed as such.  =
If it's
> postive, the corresponding inode will belong to the same superblock.
>         * any struct mount instance is associated with the same superbloc=
k
> through the entire lifetime; ->mnt_sb is assign-once and can be accessed =
as such.
>         * any opened file is associated with the same dentry and mount th=
rough
> the entire lifetime; mount and dentry are from the same superblock.
>
> Exclusion that would required to cope with the possibility of the above
> being violated would cost far too much, and that's without going into the
> amount of analysis needed to make sure that things wouldn't break.
>
> Which filesystem do you have in mind?

The following code use sget* with test functions today:
afs, btrfs, ceph, fuse, gfs2, nfs, ubifs, smb/client
... which means that they can share superblocks.

If those test functions use mount options to decide whether to share a
superblock (at least nfs and smb clients do this), those mount options
can change during remount.
At this point, the filesystems do not even have visibility into other
mounts that share the superblock. Hence they cannot even fail such
remounts.
Side effect of such remounts is that changes to mount options will
apply to all mounts that share the superblock, whether the user
intended to do that or not.

--=20
Regards,
Shyam

