Return-Path: <linux-nfs+bounces-15253-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A20BDAF12
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 20:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CC174E8215
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB1B1F4295;
	Tue, 14 Oct 2025 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRX7ddMY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8322AE8E
	for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466460; cv=none; b=mavoP3jRX22PN0A40en219DUHbGA0qLZzEGSWzXoiuV5OSZip73Ey0S4q2Bof/a0qAZ7W1uCfQCh0LQGokcDLocd2reJJjQbiCygANPB2pf18OH5rMqNJLYVAIdmO0LEDqSnx14cQggYx3X6agB7h72pBcpCdNqX+ekpwn+N3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466460; c=relaxed/simple;
	bh=RB74I7aLFP9qio5yu8di8G1iTGBsm2anqMXvHShWuJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdqwxOuDil3T8gFkDvPhUirM1zKnsuoG1qGhZavFJbFD+L3jzTjDd7xGzB9qna3rq8eXd3MUG3rIf/8GZGTb+rVhpLxAWqZOiZRjOyHrv6pU0536QYiM3JhABXMRA9N2huHW6Mf1ZeMO6B/B4irldGnTD+w8+kUP53+YJQ1v650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRX7ddMY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78defc1a2afso117933896d6.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Oct 2025 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760466458; x=1761071258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSfTQUEeojQQB/O4AumuztWKmGZiVkZuY+HewObt1DM=;
        b=PRX7ddMYMmH5UjMSvlec7gbIoWkdzrabslLufLYe1hkjMH56gfmaRi0Et2DsFQLKaL
         Mu75410tlrPqwEX6wG6a3D90VZyZplLi6iIOw4VC++d0wYppFM7uOGpt7GIBc25G0hSj
         7459r/HKJZdiw5FHGIOBuHvw8H6yEPNGP3dnTNS282lI9chf4fBCMMPJZwLtauuvp7Yc
         S/9l2TvCUan4OdDaERCqn7mRNvhx0QT/GvyjP9zb7P4Yoln153KGfp17UHH6MnvJnJYc
         PLf1rT49hCcDo8NaVAuwlhOTpxSnScbHY/gEpMiH0kWixgHssIvEtVN6EHJufpgYXWYW
         c1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466458; x=1761071258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSfTQUEeojQQB/O4AumuztWKmGZiVkZuY+HewObt1DM=;
        b=cmO8esebmAoJWnd4CpfKKR8+4APAVZhqMVp1xaH4CsVbisabH9EUeLOMnKsxB+N7Qf
         GAgJIhUBs3jR22S/KXst/hjtjYbujE/5B8d9/nwgbtBftvmle+mMY69gwmQgPPWYQZYZ
         IW+IPT9/Stm1ppFQRpDk6WvvzGnoAtqfPImIWZCCHfdErD+C0FcSRGUZERXsvDiuyUs3
         l/780emsxHBXZfCljt1tuLdGKTnq4ACqMBEb1zFHWiw2qnlP+8Wba6c1nQK7adH6FlHS
         gvfKHloFFAa1vLFEgr3eGGk1OwBm8BNw7uU5MPGj+bT2K7dv9wUVwXesb0iE98p3+/W3
         VLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0HzwHlsvvdMn5smiOR1aa7/3CoXh9oUHNEfu4Ckevr5GV6TEvPzBcCTQmFMrmrme6sILCAkZhdMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUo1uWjoGKoXMgMQ398EoFNsNxYljLG2+aqotzGRRMI4EAgHqG
	cqYxPpTm4KsimKPUQfLcNkHQh0nkHQ5htvN7OQtnrB20f6CJBgGt2WuAdp/4duP5RtMXBJeL4WP
	YWgEQrsdNQmg1w8Q+CIsUp3loi2KgLQ8=
X-Gm-Gg: ASbGnctIDq2CLOTq+dtfAeWHb8l8+Bu6svliiyXrsON3E3MNXhMlxhP3OL6oP4UotMl
	zV3Ii0AkBBKbEt46e4NRHWPX0zor4oMvx6eM++5o4qfp07V5UbGqVF7+lyZxNNxlItDJqlKEFv0
	qCFr3fxZn+0vwfzCKxHtrQgiaXKmZ/sr4fIJ3SBXwehFYd2fZmXbkZ/y7OYujNLDjY8MigNPbpC
	bKTLpG3wrIk6JGv7eTiuUdu5RdzkAmJtWis4e5DG/lof7jSkRXCGemuwZbBvWto4DOgg6DGmEzm
	/3B/Ofb4jqEkITJvFyRfZEv3bOKqhwdG7jILnw9erB0ReLEEvSHGrPX9cRkampmbjNtvpIS6Mx2
	zk5cjKF7cI+0A3Wt4WxSHOlf65xljrP8lPauKH3k=
X-Google-Smtp-Source: AGHT+IFU6XFIR+qGieXOiN15wCcKNp7saGyGYeqcKac09vSAanvqo/pyqL6UQId++kEk6bi2MHN+oNsiaYZwxnbnOWI=
X-Received: by 2002:a05:6214:f6b:b0:804:19ef:45dd with SMTP id
 6a1803df08f44-87b2101d85amr393750166d6.25.1760466457838; Tue, 14 Oct 2025
 11:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014133551.82642-1-dhowells@redhat.com>
In-Reply-To: <20251014133551.82642-1-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 14 Oct 2025 13:27:26 -0500
X-Gm-Features: AS18NWDSIxnc3mGWD21jCuzZgR1tbiQpCXCnv_rdJ8bZ8-EdEWCR6tu4SyA_6UY
Message-ID: <CAH2r5muBUFcGWZ+-d8OteT=k7xVk1sK97URmKfwF5saq4ms2Zw@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs, afs, bash: Fix miscomparison of foreign user IDs
 in the VFS
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Marc Dionne <marc.dionne@auristor.com>, Jeffrey Altman <jaltman@auristor.com>, 
	Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org, 
	openafs-devel@openafs.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Additionally, filesystems (CIFS being a notable example) may also have us=
er
identifiers that aren't simple integers

Yes - this is a bigger problem for cifs.ko (although presumably NFS
since they use user@domain for NFSv4.1 and 4.2, instead of small 32
bit uids, could have some overlapping issues as well).

In the protocols, users are represented (e.g. in ACLs and in ownership
info returned by the server) as globally unique "SIDs" which are much
larger than UIDs and so can be safely mapped across large numbers of
systems.

On Tue, Oct 14, 2025 at 8:36=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Al, Christian,
>
> Here's a pair of fixes that deal with some places the VFS mishandles
> foreign user ID checks.  By "foreign" I mean that the user IDs from the
> filesystem do not belong in the same number space as the system's user ID=
s.
> Network filesystems are prime examples of this, but it may also impact
> things like USB drives or cdroms.
>
> Take AFS as example: Whilst each file does have a numeric user ID, the fi=
le
> may be accessed from a world-accessible public-facing server from some
> other organisation with its own idea of what that user ID refers to.  IDs
> from AFS may also collide with the system's own set of IDs and may also b=
e
> unrepresentable as a 32-bit UID (in the case of AuriStor servers).
>
> Further, kAFS uses a key containing an authentication token to specify th=
e
> subject doing an RPC operation to the server - and, as such, this needs t=
o
> be used instead of current_fsuid() in determining whether the current use=
r
> has ownership rights over a file.
>
> Additionally, filesystems (CIFS being a notable example) may also have us=
er
> identifiers that aren't simple integers.
>
> Now the problem in the VFS is that there are a number of places where it
> assumes it can directly compare i_uid (possibly id-mapped) to either than
> on another inode or a UID drawn from elsewhere (e.g. current_uid()) - but
> this doesn't work right.
>
> This causes the write-to-sticky check to work incorrectly for AFS (though
> this is currently masked by a workaround in bash that is slated to be
> removed) whereby open(O_CREAT) of such a file will fail when it shouldn't=
.
>
> Two patches are provided:
>
>  (1) Add a pair of inode operations, one to compare the ownership of a pa=
ir
>      of inodes and the other to see if the current process has ownership
>      rights over an inode.  Usage of this is then extended out into the
>      VFS, replacing comparisons between i_uid and i_uid and between i_uid
>      and current_fsuid().  The default, it the inode ops are unimplemente=
d,
>      is to do those direct i_uid comparisons.
>
>  (2) Fixes the bash workaround issue with regard to AFS, overriding the
>      checks as to whether two inodes have the same owner and the check as
>      to whether the current user owns an inode to work within the AFS
>      model.
>
> kAFS uses the result of a status-fetch with a suitable key to determine
> file ownership (if the ADMINISTER bit is set) and just compares the 64-bi=
t
> owner IDs to determine if two inodes have the same ownership.
>
> Note that chown may also need modifying in some way - but that can't
> necessarily supply the information required (for instance, an AuriStor YF=
S ID
> is 64 bits, but chown can only handle a 32-bit integer; CIFS might use a
> GUID).
>
> The patches can be found here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dafs-sticky-2
>
> Thanks,
> David
>
> David Howells (2):
>   vfs: Allow filesystems with foreign owner IDs to override UID checks
>   afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
>
>  Documentation/filesystems/vfs.rst |  21 ++++
>  fs/afs/dir.c                      |   2 +
>  fs/afs/file.c                     |   2 +
>  fs/afs/internal.h                 |   3 +
>  fs/afs/security.c                 |  46 +++++++++
>  fs/attr.c                         |  58 ++++++-----
>  fs/coredump.c                     |   2 +-
>  fs/inode.c                        |  11 +-
>  fs/internal.h                     |   1 +
>  fs/locks.c                        |   7 +-
>  fs/namei.c                        | 161 ++++++++++++++++++++++++------
>  fs/remap_range.c                  |  20 ++--
>  include/linux/fs.h                |   6 +-
>  13 files changed, 269 insertions(+), 71 deletions(-)
>
>


--=20
Thanks,

Steve

