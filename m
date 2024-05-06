Return-Path: <linux-nfs+bounces-3171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9BD8BD2E6
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 18:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB5B1F2152F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6315665D;
	Mon,  6 May 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq6JQNYT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65972137744;
	Mon,  6 May 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013099; cv=none; b=QiV0CWDpDrmTuNChQtUSgJmEfnJXp0kdGFxUHU1gloaiSMPGrxP47vvKjnVSQtesSSyxZtADLeS0PQQx/PV8lyz7yp+dXNVWXQM1pUwMOhULvEcwhP+rNqMbZscLYseEUEv+4RW/rKDaciijlLMeX8jI0cdYbSFg3RhzNbB/Olw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013099; c=relaxed/simple;
	bh=8dSu5OUf4aL6t7cBki8n9BViUwsxV++G2jh1J3aVvkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppvBkJN5NYGyVi++xDQSa95JyMo8b1WYK2GIINQAQlkNNWVSFEOFW+Hav6GPJxSVCWQneL3Hs6ht/7fL8af2j7ln+TG90U1TB5WqNJgKxjt5oHLhBEBlpsM5YIvV6gFX1CyPCn+QS45p07uoSni7fDHXkljH2YvZb0SB30ncqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq6JQNYT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1171854a12.3;
        Mon, 06 May 2024 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715013098; x=1715617898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZYzqMI4a34TBdeHoO+OcvRoLuw5bJXTxl6XLoPFdTU=;
        b=bq6JQNYTVmGHUi7chnvVo/T5C0GWEcNkBWgUrmJyPpP8cP1JwB4ngKPw/CUdTMUVJ2
         VZ31dIAcBbU/wIOPgM/F3QSPtFfD5fNx0DYiwt7Gnm+G85XjjIuzAS6vWLV43bkX0CB0
         OOJl0kboEr2bRFmWAZ2EgC6KAr+3NS70A0af5b96fP3eDM6d9tnPTuGUOvXp0gSS5IXM
         Lqd8H//4NpVKEbS+DqNzIZjwWWr3GUfIRtEkQIM70dd7OOLxogAOvVL2qMcNICumBhGU
         87Z7ObaSqCCXc5YghUBb/LNoTx/KrVB/JlBpRGWUG49fJaVYk+yfufcXr4ibJZkx8FXw
         1TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715013098; x=1715617898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZYzqMI4a34TBdeHoO+OcvRoLuw5bJXTxl6XLoPFdTU=;
        b=grewcvEqhyR1mHX2tqelifMAwp+NL/8KMnY+uG8IMu9vtaYL4hixw0k3fxXrRUdUm4
         Mf3omVtOc31VCAgfCL8uRm2GqI5BD07WkiH+fT+cgI8u08bvaQgewne0pM+dWCahOlr3
         5pcBEXHy+2YPMPjDLKBmam5onK/6zgNbhRKSBgtoUk9B1sIdY+Ql3ZPo28umtU5EJiuj
         kFMo3Xu0VrK+V4dv00ePwse0WAGdOJSiul8l59pbLZOAKioZGhEt5OKwGp+J5+DCaVCF
         NWMSVWAObSUk4XGUlmADVfw1+WIrVw+eTvZ+Sm8II+a/tePeIu2O0ZOA2OZZZTZoyBQS
         IITQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0zfYPrQcgNO1rJnKlTFaySspEUa/RlsfEbHO6opgC+Q746FmOK0s8TOung/WF73ex3GUKYr4V0ZSc5DlYlE8NfNmZ+2Yw8ugXSx0Z7rvTUSKFYxY/mimjKQ3aGNZh3TvVPVjrD6q+DvgYt4ilWt6a
X-Gm-Message-State: AOJu0YxZcT+0GHobZ3+3t1G7D95IeSq8OGcdgaiHmD/zwIsm+9kyEUcP
	ftjvA6n2UX2PYYE3gmKA+htPXYdac/BAtdkHk0RtLDSJv4DGorASPAptSTIn/Vjw8oKyITOE+HP
	fSlC94iPA8QKqKikt7QAhF5QMamk=
X-Google-Smtp-Source: AGHT+IF5fO7Xh9sTtZ3HipswRhggNjgY82it0ZdBxZVyLU8eQ001kl///r/CLlTpVuW4VE8j+8wHYH3nLxjJdrJW//k=
X-Received: by 2002:a17:90a:8581:b0:2b2:7c42:bf6e with SMTP id
 m1-20020a17090a858100b002b27c42bf6emr8220162pjn.12.1715013097473; Mon, 06 May
 2024 09:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503130905.16823-1-stephen.smalley.work@gmail.com> <171497439414.9775.6998904788791406674@noble.neil.brown.name>
In-Reply-To: <171497439414.9775.6998904788791406674@noble.neil.brown.name>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 May 2024 12:31:26 -0400
Message-ID: <CAEjxPJ6W7UGvPUMt82+_tB2MPmcmG7JaUjH6HhgjwTqOzQL_xA@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: set security label during create operations
To: NeilBrown <neilb@suse.de>
Cc: selinux@vger.kernel.org, linux-nfs@vger.kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 1:46=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 03 May 2024, Stephen Smalley wrote:
> > When security labeling is enabled, the client can pass a file security
> > label as part of a create operation for the new file, similar to mode
> > and other attributes. At present, the security label is received by nfs=
d
> > and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> > called and therefore the label is never set on the new file. This bug
> > may have been introduced on or around commit d6a97d3f589a ("NFSD:
> > add security label to struct nfsd_attrs"). Looking at nfsd_setattr()
> > I am uncertain as to whether the same issue presents for
> > file ACLs and therefore requires a similar fix for those.
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
> > v3 removes the erroneous and unnecessary change to NFSv2 and updates th=
e
> > description to note the possible origin of the bug. I did not add a
> > Fixes tag however as I have not yet tried confirming that.
>
> I think this bug has always been present - since label support was
> added.
> Commit d6a97d3f589a ("NFSD: add security label to struct nfsd_attrs")
> should have fixed it, but was missing the extra test that you provide.
>
> So
> Fixes: 0c71b7ed5de8 ("nfsd: introduce file_cache_mutex")
> might be appropriate - it fixes the patch, though not a bug introduced
> by the patch.
>
> Thanks for this patch!
> Reviewed-by: NeilBrown <neilb@suse.de>
>
> NeilBrown

Thanks for confirming. Do we need to also check for the ACL case in
nfsd_attrs_valid() or is that covered in some other way?

