Return-Path: <linux-nfs+bounces-17911-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E86D25A6C
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 17:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E998F310D049
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440393B8D53;
	Thu, 15 Jan 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxkV/2AH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A82C159E
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493262; cv=none; b=FbsiTLKvaYxkkfJPwEZIXElV3qWHywf+DIa0bJ2nJHvcrDaeZuyRDQIBHHb2i5EcR3uax7Tbz/4syHF2YCDdf6ik17yCvcWuoKQ17+W+chAKvF995IeqxTHUnyk/LK07w8NrvU2c1mrJZtCMJ18FIdLSy2b0xNAiDsCWvm6fSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493262; c=relaxed/simple;
	bh=x596PaRllNdpIS5h9hbxK5VONKk86ckOfrPn2xRuoYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rI9giCEYQYwck2BY2ZDgPjcLis62EBx9ftl2636t5amExlpdDIlDnC4N2JzFPecgEFtp3hIj3/61bpWL3LjLEVe+QnLqxPkAqg6gCiJmiCgHroe4Iqtc1iwO+qCURsNA1zIc8x6H5xZft4pNfmvoUtOAxj34+J+LZqnbmbZPUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxkV/2AH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d2c96215so927152f8f.3
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 08:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768493256; x=1769098056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bL4KgiUjakccFp8GDyIgH1rXwphyq4QxNLCwr+nqA/M=;
        b=VxkV/2AHa5JQBaAQICa5sas+eHcjykHVbERA704p8HnhoB2mMgb2rXtLkj//IoI3AC
         btn2Bo5JoPN2LhEwuy2ibPdWaRYrkxUqhWKpHXYu25u25lBKAdozXbYixKpAMtZ02Slu
         JDCQ+F2JeKsgrI2ECJhZmapjAM6rD1QMf0a1zcDwvvTHhTF/e4Grrujl3C0HJWL/fueg
         zchtSCwwaxIcmPAZlJqJGfqrQOC37L/Efl7Qg+KF2AnkfZtpGUdhgm+mw96D5jkAgJcR
         k3Kyx1PWB8XnuzwCmwkhZdLLB5YFkYUOgi1FOGKxlbpnPHLOvuZnm5rPR8enVS/t8dJz
         t8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768493256; x=1769098056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bL4KgiUjakccFp8GDyIgH1rXwphyq4QxNLCwr+nqA/M=;
        b=TAQjJUwjcA2yC5YPwOGmBclngWV/i0JipM16CIuItwwECpHXCWjyZ8HfcapInz00M4
         CXRntCx9JNf97bIhseriEEfkKhTixA+S4UwmZqOAE282jQusSix0rjs9/ECX4Mwn8GOG
         eXUqZuZZZT8nJUa1vY8sm/bj/6J30xHDN/3JNYJcOwbgcuHhN716VIeY4mCkzS8cEhFI
         zvrpeRIiTpI4EvoKAqUzEqe+6hrMA+KMw6crbt1l6bS6173hGR1TgPU5aWestYe2WtIN
         TEEldop2uFS3YQZeF/ZUL9bHEPvXUWDW8s85qYB8nylQzAmOY/n0RDAz91iGNyejfGr4
         Of8w==
X-Forwarded-Encrypted: i=1; AJvYcCU4kXbCTWz6wLMLuc3JN4nB5gMIXdoEY/jGyIlqR/jFdP9t+QOOdlhkifQpbdTx1LybRgn0GmF5jrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHrUGAEcpETijIRmjK2Rl2F2clW3tXcaoaRFvR9dkD7nY3CtW
	WKmARzRMOHUu+5+bB8I4IFcR75u/OxHHFwAdFE6U5DAJoKU0SuOtKrtJJA59hpYZg4v7l7xZCwe
	HEPmWkWcRML5vJ66AHohy1ATEw2175OE=
X-Gm-Gg: AY/fxX7nutXP1E3epMryI8j21qcOQ4W62YgNsBvr8xPK87qq671GtIGUJ/YnaviRQk/
	clBvyzRYyU9cMZdbNsSsxfzKkfQVJu82lMfK9WvC5Fd8aEE0AncBSCzh9X3q81ZdiqQwHq6L70c
	ecGCHl6bouoWYNS15WJN8ahNzOPHI/V+fUUlSqGJZf9+oUyW+hpC1kTiYeaqOL3qH0ZDPutBGFf
	E2oGygTovwjvj9i1t7cKEWE0rpYsGVyCAui15jLkVM8ZAlT9Tk1EQSMijhKYTLpMzR6ZZm3XHnp
	V37/fBtlbYCKg0prcSpOi2ks63aUeA==
X-Received: by 2002:a05:6000:2303:b0:42f:a025:92b3 with SMTP id
 ffacd0b85a97d-4342d3895a7mr7282018f8f.2.1768493256065; Thu, 15 Jan 2026
 08:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
In-Reply-To: <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 17:07:24 +0100
X-Gm-Features: AZwV_QiiOfVz5MjHOOW7TnQI8q-5ZkSKoahnBApAROcQQgB7iPXfsZHV_rRz004
Message-ID: <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 4:42=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 15/01/2026 04:23, Christoph Hellwig escreveu:
>
> [...]
>
> >
> > I still wonder what the use case is here.  Looking at Andr=C3=A9's orig=
inal
> > mail it states:
> >
> > "However, btrfs mounts may have volatiles UUIDs. When mounting the exac=
t same
> > disk image with btrfs, a random UUID is assigned for the following disk=
s each
> > time they are mounted, stored at temp_fsid and used across the kernel a=
s the
> > disk UUID. `btrfs filesystem show` presents that. Calling statfs() howe=
ver
> > shows the original (and duplicated) UUID for all disks."
> >
> > and this doesn't even talk about multiple mounts, but looking at
> > device_list_add it seems to only set the temp_fsid flag when set
> > same_fsid_diff_dev is set by find_fsid_by_device, which isn't documente=
d
> > well, but does indeed seem to be done transparently when two file syste=
ms
> > with the same fsid are mounted.
> >
> > So Andr=C3=A9, can you confirm this what you're worried about?  And btr=
fs
> > developers, I think the main problem is indeed that btrfs simply allows
> > mounting the same fsid twice.  Which is really fatal for anything using
> > the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid use=
r.
> >
>
> Yes, I'm would like to be able to mount two cloned btrfs images and to
> use overlayfs with them. This is useful for SteamOS A/B partition scheme.
>
> >> If so, I think it's time to revert the behavior before it's too late.
> >> Currently the main usage of such duplicated fsids is for Steam deck to
> >> maintain A/B partitions, I think they can accept a new compat_ro flag =
for
> >> that.
> >
> > What's an A/B partition?  And how are these safely used at the same tim=
e?
> >
>
> The Steam Deck have two main partitions to install SteamOS updates
> atomically. When you want to update the device, assuming that you are
> using partition A, the updater will write the new image in partition B,
> and vice versa. Then after the reboot, the system will mount the new
> image on B.
>

And what do you expect to happen wrt overlayfs when switching from
image A to B?

What are the origin file handles recorded in overlayfs index from image A
lower worth when the lower image is B?

Is there any guarantee that file handles are relevant and point to the
same objects?

The whole point of the overlayfs index feature is that overlayfs inodes
can have a unique id across copy-up.

Please explain in more details exactly which overlayfs setup you are
trying to do with index feature.

FWIW, the setup you are describing sounds very familiar.
I am pretty sure that a similar setup with squashfs and OpenWRT [1]
was the use case to add the uuid=3Doff overlayfs mount options.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/32532923.JtPX5UtSzP@fgdesktop/

