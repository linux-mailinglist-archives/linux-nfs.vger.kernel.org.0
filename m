Return-Path: <linux-nfs+bounces-16841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404DC9ABE7
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 09:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB52F4E148D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 08:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A093074A0;
	Tue,  2 Dec 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bbbrFs6+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169DE3054FB
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764665216; cv=none; b=ie14inozyHvN7Cw2b7DzsvaCOkbK88jsuhUH7AR+mcQYRmhyGCZxoOz7qjvlutDetPUIfifQKcWjnOBZzih06lKgp88kquHjv98V0Uwe2WmbFywWQMjn/SN48vvlYKuX6qRylFEdX8yGU6b4YCvQGsXbjaWtyuo10GcbPY1cnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764665216; c=relaxed/simple;
	bh=qcpxFQirLzafdSnNIq92XhuOn+HzWCu4AcZ2SW0UjqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4BtovtT16OSWETXotPi2ZIS7lixpGiMSlwqLsp45WyqcvfhSweKr0cXqz/Cw49yQshYAhueM5Sx6N9flD6dD+ko2corIGOYQTfwtqL2WY5sBA95x8LXUY82BF81FL13uTKJaSWyp8AKD4J+jGSR8lpj0vlGHPZQ8WnFL/MQx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bbbrFs6+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee0ce50b95so53517141cf.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Dec 2025 00:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1764665213; x=1765270013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dxvySic7ZCI3Kve7CCt8lN1Lme0d3OPvrFfTikR164w=;
        b=bbbrFs6+5vw0v4zASrPuLyid+iafPWKvHeYf/XOZ4RlTfrAcYHZVAdk6e+pk3VUvT5
         48D6eTBCgo/3krpFsqeWdnF8GCD9YaUPsH9bnVDmtOnvHdlmeiRQ7K1+nPucKysf1DKV
         mmqSSKGrjMO7aaGrUT4vdZIAqeiNk+895+LjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764665213; x=1765270013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxvySic7ZCI3Kve7CCt8lN1Lme0d3OPvrFfTikR164w=;
        b=glJPt8akjHQJewNFQLm6FwkCznTJ6WMaEfGRgBGfeAxyC13dZ/kDaCWmNoeeuY9HYK
         wffZ2rtywVbgbll3Lw6WzhEFGCLrWErw2QvzDWkvd+CH3wCYif1Bd9bFe0jsGmt7zz2a
         Evx8OwH8vY8YhCm12FZaGbgqkz4ULoc1s+nG9s+EKtuibyOxrLzu3GRdyYxIffsdM5mh
         wYRysEUXzknuIW9/cz/rqfVstkD11lCbsqHcETr22MeO2wwZvBJawC3C/BRVpHeQq10u
         jL1ssGwwCGuuIUMrsIGcvTF4c5sEzMx9cxZuCNJKvVb8SJpsdsUWxxqo4cXh4M1sQrUV
         fLxA==
X-Forwarded-Encrypted: i=1; AJvYcCVIwkygshoFDXnQJyWQmTuiB4CNykTuHxVo0JTp7uYNx7tlQzn5vYMlHh59XBOF9Qjp//9sht8ry6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV++ITKddGB91gS2pA9cgI/pUSXki3qW6Usa8hVDM2To3n/Lgb
	I/RKo6ANIYnO9r6JgThq56xY9TbYT1k97SJhehoSRtOnu4iZaSRPPRKTGnBmTgNxNL3aqtW4d2c
	/KgTOmXlftZYa2IMmCM0qUL3xgj7uC8mCIQgyZ0JybQ==
X-Gm-Gg: ASbGncvPgSmn3ceL8fsE6eJVcgjGQKTw7iMSLEHAHbpyNfYBxqlvVnrZj3rYp/mUbbF
	cE+Gzro8ecImWXdc4Iais/VmWxT7F0iyCxKmlKptsYzhltD1GoLVdLlxCVHyzpdgBqZapNrrb1S
	0I41NzKONXgGgRsT0jbbOMpns/hsD58BidrTegx3hH1PrgVn6T3c6DLGzH6qMTgsoFdFlDz4EHn
	9FtPAh+cRDf5V4Z47qrrpU8PsbHxvHgFq37gJ3e9RSDBokke5UrYsMQ34347gx4NcJC8w==
X-Google-Smtp-Source: AGHT+IEmdgKRfEJt7lhW9JewHKYA/V5LXGRt+5HoCO1i6voev0VJmL65LKUm+BLjfUqBCpppRBhIODxs9MlwVlA6duw=
X-Received: by 2002:ac8:7dc2:0:b0:4ee:1f69:fdeb with SMTP id
 d75a77b69052e-4f0088dcc91mr26981181cf.11.1764665212783; Tue, 02 Dec 2025
 00:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113002050.676694-1-neilb@ownmail.net> <20251113002050.676694-7-neilb@ownmail.net>
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool> <176454037897.634289.3566631742434963788@noble.neil.brown.name>
 <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com>
 <20251201083324.GA3538@ZenIV> <CAJfpegs+o01jgY76WsGnk9j41LS5V0JQSk--d6xsJJp4VjTh8Q@mail.gmail.com>
 <20251201170813.GH3538@ZenIV>
In-Reply-To: <20251201170813.GH3538@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 2 Dec 2025 09:46:41 +0100
X-Gm-Features: AWmQ_blWv82I_AJ0z54S1o3oAiX82VQ2RDfse7yanE0u3ZklpA9ZzlQdeqtb1vo
Message-ID: <CAJfpegtJDJL7T0-Uj664xOm4N2e6fyJp_XwFecHX_9e9ipUyEw@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 18:08, Al Viro <viro@zeniv.linux.org.uk> wrote:

> Then as far as VFS is concerned, it's an equivalent of "we'd done
> a dcache lookup and revalidate told us to bugger off", which does
> *not* need locking the parent - the same sequence can very well
> happen without touching any inode locks.

Okay.

> IOW, from the point of view of locking protocol changes that's not
> a removal at all.
>
> Or do you need them serialized for fuse-internal purposes?

Not as far as I can see. As to any fuse filesystem being reliant on
this behavior, I think that's unlikely, though it's sort of documented
in the libfuse APIs as:

 * To avoid a deadlock this function must not be called in the
 * execution path of a related filesystem operation or within any code
 * that could hold a lock that could be needed to execute such an
 * operation. As of kernel 4.18, a "related operation" is a lookup(),
 * symlink(), mknod(), mkdir(), unlink(), rename(), link() or create()
 * request for the parent, and a setattr(), unlink(), rmdir(),
 * rename(), setxattr(), removexattr(), readdir() or readdirplus()
 * request for the inode itself.

Why the locking was added in the first place?  Oversight, probably.

Thanks,
Miklos

