Return-Path: <linux-nfs+bounces-3146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B3F8BACC3
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 14:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E0B1C20EB9
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1715357F;
	Fri,  3 May 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euTKUyXY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD97152788;
	Fri,  3 May 2024 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740536; cv=none; b=V1xq2vylZ8gvEQzKthAXuhDplw22Lvitedkgk+thivv5zB4Yo4rUWGnEJdVTLPEuJvdDro7NJCz0gIeF4WguYYFX+++crsYSB0iB8J9jRwuNVZ2CMcSXlkQTJIbztgVOb3DgWOYXMdMhPKKJfU5IR7q3aNa7+2zxTR0LUZolZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740536; c=relaxed/simple;
	bh=GmZ5L8T1pqxa1hc7nHK6JLmX7g5vBxYUL5gKbPt9ZIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wg7FdRHA3fhDhw0Js4l/nGqjCmZuSrHF4/YqhwKpmvEOj8R2m/QLjuU5FLlIke50lT9uVBviw9esN1gDR6nx8rWhzHfZfyG/zJy+4ioDnOBc15i8IQRdol8N7D9n/CNFyNf0cajE05JBQGi9eRJmByWA882F1lYvpkXHfhwOn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euTKUyXY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fa455cd94so7003548a12.2;
        Fri, 03 May 2024 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714740534; x=1715345334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y5k4LZDSx2AIqs23NmgFSme0AlhbpWJougf2C8BhMM=;
        b=euTKUyXY8UVmIJp2OGg6dvymEwvnrqYQVwPgssapxCsKkX37yeIhExilod/Dn25AY3
         +0H6OxEx3ay5rASBbulZ2iMWTL9fkTd17KUslDdRz+HHuPu7rPTIiz6Rl2RnXFlWL76u
         Lgvl6ft3kLvRHBppPBu2UtdP9cuh7wcsv/wIDXXX12nJoCP3H4n70Q22jfUX8Ybi7arP
         5U9HW9g8XMSm/aPvf9JKBABT3id/auhSFqHGH6blAYpv5qRt8D/Nvbm6JGi904aIDoqt
         o7mztdAHXIZDEFL5gBuhYbX6T03K3TmA7Gj8wC/x3HcHGiF6kWnz7e5BBlIwH4VWes/8
         7aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740534; x=1715345334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Y5k4LZDSx2AIqs23NmgFSme0AlhbpWJougf2C8BhMM=;
        b=VMkrh1WGdSmsoRv9wAXdarXi8KjibQJ54asNKEbLKCGNf4CeortZbmS74VrOrDVM0I
         YI/UNb+h+mgedaXVJa62qFEyfPC9A4Xal3cv6TvxFPPCMfxh0PCrGYZu1nlwfw631/nA
         kl1zIW/OSLGv81v1SCyeD+2Bk2hxJK+y7JwC8wnittOlyRvgr6TCdkRUQZYyeclCQ9hv
         GTRiVngsrj8EgIdZEINgT6Rad7r1kV1FGPRrehkrSCErZkcYgbbCZ1bHa00uLhakBQwE
         ZWpgIAwWlpzwZAcZdbrK5SEe/T61BG01/6/CmAzil5JP/htAGu/RQQuORrCvLiwFik6K
         yydA==
X-Forwarded-Encrypted: i=1; AJvYcCXUZo0jyKZUtxUuNy6FWR/ry0uoEUi1+xWKQT03QzVcW5q9ez3nRyUKVU8EWdLPrqxvXHj6SfOIHvV9Gs1KkiVNVhcjD3n2yerrNr9/IlDxS/MmewmvPXYLnKkmkkFbV7DbZdlMX9i1wfAjziYkRoRS
X-Gm-Message-State: AOJu0Yxv0CL2BaPRQkWlSoGvLgI9HrV/Q25V7kAvd90zQ9QDIy+1a/LB
	5bSLMQGqZcrcVVx2rU2wmGBrOgxloaSwzSNXwAeX48e6SsXqJs+Jt/FfQNUVOHz8KC/8qswIjNg
	9dlk6TQ6/Fk1WJrHgVeAJhgVdpgo=
X-Google-Smtp-Source: AGHT+IG/+cPDi8XmRteN8iGgp/HY5GfisHcVrygGBl1hI+oPOsdzF9I13aUiDQgWCbghPd1bzWGj7YXlpBQ8mS26X4g=
X-Received: by 2002:a17:90a:9f88:b0:2a4:b831:5017 with SMTP id
 o8-20020a17090a9f8800b002a4b8315017mr2359132pjp.48.1714740533994; Fri, 03 May
 2024 05:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502195800.3252-1-stephen.smalley.work@gmail.com> <70273db57aa4b6df43ae1f73e6bf3b80abf0c599.camel@kernel.org>
In-Reply-To: <70273db57aa4b6df43ae1f73e6bf3b80abf0c599.camel@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 3 May 2024 08:48:42 -0400
Message-ID: <CAEjxPJ6O-Zo=7xJ9j2=mOLEO0dWPYx9AHVRtPqaUPYx9rbsVpA@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: set security label during create operations
To: Jeffrey Layton <jlayton@kernel.org>
Cc: selinux@vger.kernel.org, linux-nfs@vger.kernel.org, chuck.lever@oracle.com, 
	neilb@suse.de, paul@paul-moore.com, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 6:34=E2=80=AFPM Jeffrey Layton <jlayton@kernel.org> =
wrote:
>
> On Thu, 2024-05-02 at 15:58 -0400, Stephen Smalley wrote:
> > When security labeling is enabled, the client can pass a file security
> > label as part of a create operation for the new file, similar to mode
> > and other attributes. At present, the security label is received by nfs=
d
> > and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> > called and therefore the label is never set on the new file. I couldn't
> > tell if this has always been broken or broke at some point in time. Loo=
king
> > at nfsd_setattr() I am uncertain as to whether the same issue presents =
for
> > file ACLs and therefore requires a similar fix for those. I am not over=
ly
> > confident that this is the right solution.
> >
> > An alternative approach would be to introduce a new LSM hook to set the
> > "create SID" of the current task prior to the actual file creation, whi=
ch
> > would atomically label the new inode at creation time. This would be be=
tter
> > for SELinux and a similar approach has been used previously
> > (see security_dentry_create_files_as) but perhaps not usable by other L=
SMs.
> >
> > Reproducer:
> > 1. Install a Linux distro with SELinux - Fedora is easiest
> > 2. git clone https://github.com/SELinuxProject/selinux-testsuite
> > 3. Install the requisite dependencies per selinux-testsuite/README.md
> > 4. Run something like the following script:
> > MOUNT=3D$HOME/selinux-testsuite
> > sudo systemctl start nfs-server
> > sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
> > sudo mkdir -p /mnt/selinux-testsuite
> > sudo mount -t nfs -o vers=3D4.2 localhost:$MOUNT /mnt/selinux-testsuite
> > pushd /mnt/selinux-testsuite/
> > sudo make -C policy load
> > pushd tests/filesystem
> > sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
> >       -e test_filesystem_filetranscon_t -v
> > sudo rm -f trans_test_file
> > popd
> > sudo make -C policy unload
> > popd
> > sudo umount /mnt/selinux-testsuite
> > sudo exportfs -u localhost:$MOUNT
> > sudo rmdir /mnt/selinux-testsuite
> > sudo systemctl stop nfs-server
> >
> > Expected output:
> > <eliding noise from commands run prior to or after the test itself>
> > Process context:
> >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > Created file: trans_test_file
> > File context: unconfined_u:object_r:test_filesystem_filetranscon_t:s0
> > File context is correct
> >
> > Actual output:
> > <eliding noise from commands run prior to or after the test itself>
> > Process context:
> >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > Created file: trans_test_file
> > File context: system_u:object_r:test_file_t:s0
> > File context error, expected:
> >       test_filesystem_filetranscon_t
> > got:
> >       test_file_t
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2 introduces a nfsd_attrs_valid() helper and uses it as suggested by
> > Jeffrey Layton <jlayton@kernel.org>.
> >
> >  fs/nfsd/nfsproc.c | 2 +-
> >  fs/nfsd/vfs.c     | 2 +-
> >  fs/nfsd/vfs.h     | 8 ++++++++
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index 36370b957b63..3e438159f561 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -389,7 +389,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> >                * open(..., O_CREAT|O_TRUNC|O_WRONLY).
> >                */
> >               attr->ia_valid &=3D ATTR_SIZE;
> > -             if (attr->ia_valid)
> > +             if (nfsd_attrs_valid(attr))
> >                       resp->status =3D nfsd_setattr(rqstp, newfhp, &att=
rs,
> >                                                   NULL);
> >       }
>
> This function is for NFSv2, which doesn't support any inode attributes
> that aren't represented in ia_valid. We could leave this as-is, but
> this is fine too.

Sorry, I got over-eager with trying to fix all ia_valid checks. It's
actually wrong so I'll send a 3rd version without it.

