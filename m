Return-Path: <linux-nfs+bounces-16814-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 872FCC97C2A
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 15:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6C5634314A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4983191B1;
	Mon,  1 Dec 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FkfFon9r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012DC2AE70
	for <linux-nfs@vger.kernel.org>; Mon,  1 Dec 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597808; cv=none; b=TwLA5LNpRnx8NtAq6nODtCYHkZTFGW4ZYCBm07ZaqIBDde7lFrxd6Y4gRcYV7iGrh69+4WTFdeUfmqmJ3BewiOAozmtaaEqdDSGvo7yNZnrv5ZwELTn7uLEa8L54lkSIZTSSwCMdw4kP0ucuVWU9sULP4Lqr+S+TYJj/TTLEUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597808; c=relaxed/simple;
	bh=hCy7wy8vuqNWE9XYZr4j0RcbaKs2mtvp9/lvu/KlWYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFIJhMnWEYSV57sYLnYPUFueBi6JRtigkUkqgNi4xvnErjRdxFDnGYriU5OdVAvcXO2ACn3P72SpqCZohpfHawRbFtorMj5W+oLABLrxnzrlTEK80RxNU7foo1WmhXbzZZ2WbTklODrCsy3UaHmLMlkooOi29PVBr+6XHMyaF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FkfFon9r; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2ed01b95dso413933585a.0
        for <linux-nfs@vger.kernel.org>; Mon, 01 Dec 2025 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1764597805; x=1765202605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1KFCs0NTdHYBkqxI4V4hinYQFxLArElxZO4emBYMw68=;
        b=FkfFon9riFZP2+XU+g2VaYYn06uepSkuy9/zBDlsT2pqHns8/0ZBLiJ1s2GV6cRufh
         WqXV1LAbgrNim5FHXu4zni/oRVi393yItyxPnWXDAadLZuv9etnTz9YmlbLH+jQFHVBo
         kmqApRvttkaK8yzWZVzXCi8dr0qb2dtJ9uU9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764597805; x=1765202605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KFCs0NTdHYBkqxI4V4hinYQFxLArElxZO4emBYMw68=;
        b=FDXbByJwLRApvEyEttDEWzCUnqT3iMotfvYJeVJVn5mk4isYb5YIY05n6DB2o+TW01
         wPI5i1PJGYjMOttWVmLXWEf4ULnpxDKhqmljbxJul69ZGF9Q1DPQ5P4HsmHGwPmtovMp
         fiA7foxwTGIvSqNI/P+J1hZQOKv6MwFFWEKy182/wtM3OIPh0xvWo8kG/B9O3X+fwKp6
         LFfpYNk7QVVGPGAaKiA8KhNMdL3LNWd+ritgRdcoB8zF/gu7Lp04czEOw3tv4T/3bAse
         hK2yfUqbv0evPn5X+4Zz8VFEgYIm/aAVkP38SmLy7izi6gHds0zVHJNO36u76Kf8bU/x
         14wA==
X-Forwarded-Encrypted: i=1; AJvYcCX8jMb/xA/3D5+lHy00Zgbn88oww+cxtnDXrv/thxnXgtj8wQI7PXkyLZITKexhQrTp/swOXLw8Q/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIjDyWEFqgNif/C3mRRQRemcCNQluIS7NHoFQouPUwM8+c5eV
	tw79dI1oACuQH2k4fFB27ACmZKEwjz/6B7LSDMgDcEjqEuKrUOP5Msn3dH7zI0hfoXhMzyKgITZ
	gCLeWyKG2RpWzV46tW+T4/Il804nrmhfmDK3ujTJUFg==
X-Gm-Gg: ASbGncu8EeeortGEU/OQ6QfRMF0IAnTCIWxl3IV8gGkibB5o25HxyRM0NujdXwhn3iK
	65hTZZNfQDnj35XYXFoQaXuIBL3ksaUo8kSWv+XXe8ctdKkvBLZBgsuqpgiW3qY1pyVBQYJg2oE
	jMfKa+pNYtNl8uqO4L5808IFSy1tEXdnFn3C2p5XEvKWSgJM8qxtgRJ4vIbn3NeSkTXAU0H/0Ux
	AuOq+pDaV9WUHTk/cc+oO9KCov/EK4etP6/wqcHDHQa0PCn/ij5KTNcU1l1hqLc2MqqBMfLgyS1
	Oour
X-Google-Smtp-Source: AGHT+IH9e15mSm8msBABqerYeTx3rQAzok2GPl6sP70EZC9oepRn4XZPxnLCpaxN3VQQU2c5RJNRlXYj4bdaGtAuEGs=
X-Received: by 2002:a05:620a:4691:b0:8b2:6ac5:bcb1 with SMTP id
 af79cd13be357-8b33d1d0d7fmr4629786785a.31.1764597803090; Mon, 01 Dec 2025
 06:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113002050.676694-1-neilb@ownmail.net> <20251113002050.676694-7-neilb@ownmail.net>
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool> <176454037897.634289.3566631742434963788@noble.neil.brown.name>
 <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com> <20251201083324.GA3538@ZenIV>
In-Reply-To: <20251201083324.GA3538@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 1 Dec 2025 15:03:08 +0100
X-Gm-Features: AWmQ_bkq-c147coZVJ_xFCYJz0AMxHeF-U02i3W2hF6lAiCeAU2r572GvtMCvDY
Message-ID: <CAJfpegs+o01jgY76WsGnk9j41LS5V0JQSk--d6xsJJp4VjTh8Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to start_removing()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>, 
	Christian Brauner <brauner@kernel.org>, Val Packett <val@packett.cool>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Stefan Berger <stefanb@linux.ibm.com>, "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003a97430644e4717c"

--0000000000003a97430644e4717c
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 09:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Dec 01, 2025 at 09:22:54AM +0100, Amir Goldstein wrote:
>
> > I don't think there is a point in optimizing parallel dir operations
> > with FUSE server cache invalidation, but maybe I am missing
> > something.
>
> The interesting part is the expected semantics of operation;
> d_invalidate() side definitely doesn't need any of that cruft,
> but I would really like to understand what that function
> is supposed to do.
>
> Miklos, could you post a brain dump on that?

This function is supposed to invalidate a dentry due to remote changes
(FUSE_NOTIFY_INVAL_ENTRY).  Originally it was supplied a parent ID and
a name and called d_invalidate() on the looked up dentry.

Then it grew a variant (FUSE_NOTIFY_DELETE) that was also supplied a
child ID, which was matched against the looked up inode.  This was
commit 451d0f599934 ("FUSE: Notifying the kernel of deletion."),
Apparently this worked around the fact that at that time
d_invalidate() returned -EBUSY if the target was still in use and
didn't unhash the dentry in that case.

That was later changed by commit bafc9b754f75 ("vfs: More precise
tests in d_invalidate") to unconditionally unhash the target, which
effectively made FUSE_NOTIFY_INVAL_ENTRY and FUSE_NOTIFY_DELETE
equivalent and the code in question unnecessary.

For the future, we could also introduce FUSE_NOTIFY_MOVE, that would
differentiate between a delete and a move, while
FUSE_NOTIFY_INVAL_ENTRY would continue to be the common (deleted or
moved) notification.

Attaching untested patch to remove this cruft.

Thanks,
Miklos

--0000000000003a97430644e4717c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-notify_inval_entry-and-notify_delete-are-equivalent.patch"
Content-Disposition: attachment; 
	filename="fuse-notify_inval_entry-and-notify_delete-are-equivalent.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_min7x5320>
X-Attachment-Id: f_min7x5320

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jCmluZGV4IGVjYWVjMGZl
YTNhMS4uZDlkZmZjMzI2YTI2IDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rpci5jCisrKyBiL2ZzL2Z1
c2UvZGlyLmMKQEAgLTE0MTcsMzQgKzE0MTcsOSBAQCBpbnQgZnVzZV9yZXZlcnNlX2ludmFsX2Vu
dHJ5KHN0cnVjdCBmdXNlX2Nvbm4gKmZjLCB1NjQgcGFyZW50X25vZGVpZCwKIAkJZF9pbnZhbGlk
YXRlKGVudHJ5KTsKIAlmdXNlX2ludmFsaWRhdGVfZW50cnlfY2FjaGUoZW50cnkpOwogCi0JaWYg
KGNoaWxkX25vZGVpZCAhPSAwICYmIGRfcmVhbGx5X2lzX3Bvc2l0aXZlKGVudHJ5KSkgewotCQlp
bm9kZV9sb2NrKGRfaW5vZGUoZW50cnkpKTsKLQkJaWYgKGdldF9ub2RlX2lkKGRfaW5vZGUoZW50
cnkpKSAhPSBjaGlsZF9ub2RlaWQpIHsKLQkJCWVyciA9IC1FTk9FTlQ7Ci0JCQlnb3RvIGJhZGVu
dHJ5OwotCQl9Ci0JCWlmIChkX21vdW50cG9pbnQoZW50cnkpKSB7Ci0JCQllcnIgPSAtRUJVU1k7
Ci0JCQlnb3RvIGJhZGVudHJ5OwotCQl9Ci0JCWlmIChkX2lzX2RpcihlbnRyeSkpIHsKLQkJCXNo
cmlua19kY2FjaGVfcGFyZW50KGVudHJ5KTsKLQkJCWlmICghc2ltcGxlX2VtcHR5KGVudHJ5KSkg
ewotCQkJCWVyciA9IC1FTk9URU1QVFk7Ci0JCQkJZ290byBiYWRlbnRyeTsKLQkJCX0KLQkJCWRf
aW5vZGUoZW50cnkpLT5pX2ZsYWdzIHw9IFNfREVBRDsKLQkJfQotCQlkb250X21vdW50KGVudHJ5
KTsKLQkJY2xlYXJfbmxpbmsoZF9pbm9kZShlbnRyeSkpOwotCQllcnIgPSAwOwotIGJhZGVudHJ5
OgotCQlpbm9kZV91bmxvY2soZF9pbm9kZShlbnRyeSkpOwotCQlpZiAoIWVycikKLQkJCWRfZGVs
ZXRlKGVudHJ5KTsKLQl9IGVsc2UgewotCQllcnIgPSAwOwotCX0KKwllcnIgPSAwOworCWlmIChj
aGlsZF9ub2RlaWQgIT0gMCAmJiBnZXRfbm9kZV9pZChkX2lub2RlKGVudHJ5KSkgIT0gY2hpbGRf
bm9kZWlkKQorCQllcnIgPSAtRU5PRU5UOwogCWRwdXQoZW50cnkpOwogCiAgdW5sb2NrOgo=
--0000000000003a97430644e4717c--

