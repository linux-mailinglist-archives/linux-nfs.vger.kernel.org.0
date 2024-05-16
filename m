Return-Path: <linux-nfs+bounces-3267-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48228C7B22
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2024 19:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D57B22540
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC1156661;
	Thu, 16 May 2024 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAKpgEE5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9B143C4A;
	Thu, 16 May 2024 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880603; cv=none; b=VmG2hFhS3PTosXJHjoKWUKx6ooPVYG4XApr0VNcqTVJ/0i3l6Ixw30wTJht/ogpCRxD6Mw2C5RQIxdqbLBUUwqa+8SnIMOGiC6B7Ii/grhn1jEo8qFw5KeUpTXjAzHPeO3z8Ym7/eMq4PAokTcxPCgIyFRT5tnOOnlt7bY2n2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880603; c=relaxed/simple;
	bh=2WISbF7wr1UQ6QrZ8DNpBDCwB2PAslb271dHM9dCefs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8ilrMH5rA42zc1SlxWnDCa4Gc+2ziE22d6j6drvebbZazuHVFyGvwOd/eZTp0pn3YpRupbY5efEawmHWCGzAeYlH6OEk6alP5x1QgDmPUK1OW8OuBlTRVbXemEErSQI9fhFvoyKC206n1RwkjzMdGmFsYGV6lz+xsBxhckqTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAKpgEE5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b620677a4fso346590a91.1;
        Thu, 16 May 2024 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715880601; x=1716485401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aat/IOsyQWrNfg97/tdHRNgUNiYn+C35nigQA0eI+rE=;
        b=GAKpgEE5UnEeEosAjZ9/VcE6mexMKFqh3zWfLf4+aA1Qtuspo9TLNr2YuKETh67NQX
         Ouyyy7CXW7TsqLE+xrjn5sL1OhpMMWvJ2cu1ZyTCpHf1U7fz2Au8eWaSqE1AU7yVYK3p
         brIo9sPphSn38YrdE8vLTwqv9Ra7ZkUJAc7SJ2AF/VPkRsXX+uR9sVkoCTGCFTY9l4CB
         6ycuE6LyaPeUyxw8BpL15qPUm5wSpPTC4rYj06M4prLny5UJyFfg9YDVFaWjXPQ3lJ9c
         EavkbONIouAnn+q5ZHPEAOZIOHuuYrUJsj/2B3I9yt/5EUn0DWD+0Mm9D9Edo6fKoenF
         ZCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715880601; x=1716485401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aat/IOsyQWrNfg97/tdHRNgUNiYn+C35nigQA0eI+rE=;
        b=FZ4th64CxrEfZba77nziffXX5XSPHuN79uRWx4XUmo6xV2p878sb5c/qGy2sdzhmJr
         VEEC8SUdzLI/1fOAGOJ7IuGH4YMBQ2aaxmhxkvEjOzpyMo+Be2vPVw1KnVX/CXkQkiDx
         BLYT6y96Ubgabpbjzn40U5eheg98CIRLS2jOTvIUBFAxELpt25cRlKmMkZMK378kSdad
         tfORFZVCiXXcOzoVCsOH5s6lk8c5dzvCFiNmRZBGzSQa4v6Wh7VvOq2B52navzd+UuX/
         kG3HYtydX3A/vH7rQJSW1tdcgBTid6O/ko2JQhrciSaUO58e4VVXTy12O20s6mN9xa0S
         rwHA==
X-Forwarded-Encrypted: i=1; AJvYcCWbtjXx9uZTfLA8fPxBaN3dm/mvXd0Q7fSRD8c72pYTbGPnPLk8+PeJuryoXBhU6zWj3xhRIgThL8dK9t6r/ORRrs/A4B66e4r4eeM+3+dsDe4x7uEamdEcIXSi8+c9+cHx7o/Wpz2iaFl/0sfnj2aY
X-Gm-Message-State: AOJu0Yy+Lj3sPci2AstXuPCpeUMH25q+wnuMmiBnRDRmT+Egv1bv1qHs
	NYTU8+R/ecvCHiWpjhIGK1i/z77pW5TegU2Aw7KwIco5jHfaYfEOMG0oIhV15ALDMD9aNEXgMHV
	3xn+P5dUZJyK7V2HSU0T8onU6gGS3tQ==
X-Google-Smtp-Source: AGHT+IEC/e8B9bvWYJGdkYitFHAdMa2I/6bkKtlUK7WfNCcFucOghJpz8jeJiVKP03ns+rhV30ploAfbUF7iwLYsi7M=
X-Received: by 2002:a17:90b:4f4e:b0:2a5:16c2:8551 with SMTP id
 98e67ed59e1d1-2b6cc76d83fmr20380275a91.19.1715880601324; Thu, 16 May 2024
 10:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503130905.16823-1-stephen.smalley.work@gmail.com>
 <171497439414.9775.6998904788791406674@noble.neil.brown.name> <CAEjxPJ6DTNY3p9MmdV0K1A7No7joczGTeOe26Q4wr6yujk9zKA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6DTNY3p9MmdV0K1A7No7joczGTeOe26Q4wr6yujk9zKA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 16 May 2024 13:29:49 -0400
Message-ID: <CAEjxPJ6y=WmGqRkj+Qrj9x5+-u74=DEt0JCWmCpRu4EZufpmkg@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: set security label during create operations
To: NeilBrown <neilb@suse.de>
Cc: selinux@vger.kernel.org, linux-nfs@vger.kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:52=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, May 6, 2024 at 1:46=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
> >
> > On Fri, 03 May 2024, Stephen Smalley wrote:
> > > When security labeling is enabled, the client can pass a file securit=
y
> > > label as part of a create operation for the new file, similar to mode
> > > and other attributes. At present, the security label is received by n=
fsd
> > > and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> > > called and therefore the label is never set on the new file. This bug
> > > may have been introduced on or around commit d6a97d3f589a ("NFSD:
> > > add security label to struct nfsd_attrs"). Looking at nfsd_setattr()
> > > I am uncertain as to whether the same issue presents for
> > > file ACLs and therefore requires a similar fix for those.
> > >
> > > An alternative approach would be to introduce a new LSM hook to set t=
he
> > > "create SID" of the current task prior to the actual file creation, w=
hich
> > > would atomically label the new inode at creation time. This would be =
better
> > > for SELinux and a similar approach has been used previously
> > > (see security_dentry_create_files_as) but perhaps not usable by other=
 LSMs.
> > >
> > > Reproducer:
> > > 1. Install a Linux distro with SELinux - Fedora is easiest
> > > 2. git clone https://github.com/SELinuxProject/selinux-testsuite
> > > 3. Install the requisite dependencies per selinux-testsuite/README.md
> > > 4. Run something like the following script:
> > > MOUNT=3D$HOME/selinux-testsuite
> > > sudo systemctl start nfs-server
> > > sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
> > > sudo mkdir -p /mnt/selinux-testsuite
> > > sudo mount -t nfs -o vers=3D4.2 localhost:$MOUNT /mnt/selinux-testsui=
te
> > > pushd /mnt/selinux-testsuite/
> > > sudo make -C policy load
> > > pushd tests/filesystem
> > > sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
> > >       -e test_filesystem_filetranscon_t -v
> > > sudo rm -f trans_test_file
> > > popd
> > > sudo make -C policy unload
> > > popd
> > > sudo umount /mnt/selinux-testsuite
> > > sudo exportfs -u localhost:$MOUNT
> > > sudo rmdir /mnt/selinux-testsuite
> > > sudo systemctl stop nfs-server
> > >
> > > Expected output:
> > > <eliding noise from commands run prior to or after the test itself>
> > > Process context:
> > >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > > Created file: trans_test_file
> > > File context: unconfined_u:object_r:test_filesystem_filetranscon_t:s0
> > > File context is correct
> > >
> > > Actual output:
> > > <eliding noise from commands run prior to or after the test itself>
> > > Process context:
> > >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > > Created file: trans_test_file
> > > File context: system_u:object_r:test_file_t:s0
> > > File context error, expected:
> > >       test_filesystem_filetranscon_t
> > > got:
> > >       test_file_t
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > v3 removes the erroneous and unnecessary change to NFSv2 and updates =
the
> > > description to note the possible origin of the bug. I did not add a
> > > Fixes tag however as I have not yet tried confirming that.
> >
> > I think this bug has always been present - since label support was
> > added.
> > Commit d6a97d3f589a ("NFSD: add security label to struct nfsd_attrs")
> > should have fixed it, but was missing the extra test that you provide.
> >
> > So
> > Fixes: 0c71b7ed5de8 ("nfsd: introduce file_cache_mutex")
> > might be appropriate - it fixes the patch, though not a bug introduced
> > by the patch.
> >
> > Thanks for this patch!
> > Reviewed-by: NeilBrown <neilb@suse.de>
>
> FWIW, I finally got around to testing Linux v5.14 and it did pass
> these NFS tests so this was a regression. I haven't been able to
> bisect yet.

Seems to have broken sometime between v5.19 and v6.0. Still bisecting.

