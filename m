Return-Path: <linux-nfs+bounces-1012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8B829E2C
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 17:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622D0283CA2
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1744CB24;
	Wed, 10 Jan 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLfGljyB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41E4CB21;
	Wed, 10 Jan 2024 16:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBC2C43394;
	Wed, 10 Jan 2024 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704902628;
	bh=XjZmS98jemUfSMvfl6MkC5FkeGQg7w5vQFY4Rpydk1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fLfGljyBtQZYFpyHBIuZhaSGiSPpIciWk4sNw4l1T8gnH7Rmx0zphATq6vo5O3cwc
	 kIEXQx8qCq9fdS54e7+u5l3fXvjbHeQRVVj8rALDzgi0yzaxjmuuvJLpXZwCUo5T9e
	 4K+wgJQvEw44Jqm+HEnsv8TAiKdHbZFnw1sT1QiIsJTgE4YTPc0pwlEVcwLUXxpdUY
	 LNxy0Zhz/svUff4rrOyfxUNwX1fJmFVcnGW0twRtvB6V46s+xPIvsymdlc6X3imrMQ
	 O2Y9JyQTeiClUEZ0/co/CSsXNQAgr5woFwv+JTrQ8r2jjbYU8k59vWxKeOYjG4UqDy
	 vUlkJ+CnuJ2zg==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-429994e51fdso14914261cf.1;
        Wed, 10 Jan 2024 08:03:48 -0800 (PST)
X-Gm-Message-State: AOJu0Yxo602OiKbEzWVeDN9BbpQyPgvHi/CH5Qe9OaCTWbBPkFDotnvu
	bPrYr8bNtSVm15H/E3i1NFZowI+k0Et+sWdvnVE=
X-Google-Smtp-Source: AGHT+IHp3rYjErxZB206UIBrQSWufVdxDVAIZBP3yErJAG90R/tEdvjEjmDDOAa3Yb1hVsXO8lcm7OEKhPrTOhlYN/Y=
X-Received: by 2002:ac8:5aca:0:b0:429:9987:3ac8 with SMTP id
 d10-20020ac85aca000000b0042999873ac8mr1407197qtd.47.1704902627500; Wed, 10
 Jan 2024 08:03:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f7f6d4490ac08013ef78481ff5c7840f41b1bb4.camel@kernel.org>
In-Reply-To: <2f7f6d4490ac08013ef78481ff5c7840f41b1bb4.camel@kernel.org>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 10 Jan 2024 11:03:31 -0500
X-Gmail-Original-Message-ID: <CAFX2Jfk=NtaRo1jO03AxUF+WxVU-vpQ5LiQ2z+LYHbmB36y3=A@mail.gmail.com>
Message-ID: <CAFX2Jfk=NtaRo1jO03AxUF+WxVU-vpQ5LiQ2z+LYHbmB36y3=A@mail.gmail.com>
Subject: Re: fstests generic/465 failures on NFS
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, 
	Trond Myklebust <trondmy@hammerspace.com>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Wed, Jan 10, 2024 at 9:30=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> I've been seeing some failures of generic/465 across all NFS versions
> for a long time. I finally had some time to track down the cause, but
> I'm not quite sure whether it's fixable.
>
> The test failures usually look like this (though often at a random
> offset):
>
> SECTION       -- default
> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 kdevops-nfs-default 6.7.0-g2f76af849100 #80=
 SMP PREEMPT_DYNAMIC Wed Jan 10 06:33:59 EST 2024
> MKFS_OPTIONS  -- kdevops-nfsd:/export/kdevops-nfs-default-fstests-s
> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 kdevops-nfsd:/e=
xport/kdevops-nfs-default-fstests-s /media/scratch
>
> generic/465 8s ... - output mismatch (see /data/fstests-install/xfstests/=
results/kdevops-nfs-default/6.7.0-g2f76af849100/default/generic/465.out.bad=
)
>     --- tests/generic/465.out   2024-01-10 06:39:53.500389434 -0500
>     +++ /data/fstests-install/xfstests/results/kdevops-nfs-default/6.7.0-=
g2f76af849100/default/generic/465.out.bad      2024-01-10 08:57:00.53614670=
1 -0500
>     @@ -1,3 +1,4 @@
>      QA output created by 465
>      non-aio dio test
>     +encounter an error: block 117 offset 0, content 0

Looking through my test history, I have this one mostly passing but
with the occasional failure that looks like this.

>      aio-dio test
>     ...
>     (Run 'diff -u /data/fstests-install/xfstests/tests/generic/465.out /d=
ata/fstests-install/xfstests/results/kdevops-nfs-default/6.7.0-g2f76af84910=
0/default/generic/465.out.bad'  to see the entire diff)
> Ran: generic/465
> Failures: generic/465
> Failed 1 of 1 tests
>
> The test kicks off a thread that tries to read the file using DIO while
> the parent task writes 1M blocks of 'a' to it sequentially using DIO. It
> expects that the reader will always see 'a' in the read result, or a
> short read. In the above case, it got back a read with '\0' in it.
>
> The blocks in this test are 1M, so this block starts at offset
> 122683392. Looking at a capture, I caught this:
>
> 65161  40.392338 192.168.122.173 =E2=86=92 192.168.122.227 NFS 3702 V4 Ca=
ll WRITE StateID: 0x9e68 Offset: 123207680 Len: 524288 ; V4 Call READ_PLUS =
StateID: 0x9e68 Offset: 122683392 Len: 524288  ; V4 Call READ_PLUS StateID:=
 0x9e68 Offset: 123207680 Len: 524288
> 65171  40.393230 192.168.122.173 =E2=86=92 192.168.122.227 NFS 3286 V4 Ca=
ll WRITE StateID: 0x9e68 Offset: 122683392 Len: 524288
> 65172  40.393401 192.168.122.227 =E2=86=92 192.168.122.173 NFS 182 V4 Rep=
ly (Call In 65161) WRITE
> 65181  40.394844 192.168.122.227 =E2=86=92 192.168.122.173 NFS 6794 V4 Re=
ply (Call In 65161) READ_PLUS
> 65195  40.395506 192.168.122.227 =E2=86=92 192.168.122.173 NFS 6794 V4 Re=
ply (Call In 65161) READ_PLUS
>
> It looks like the DIO writes got reordered here so the size of the file
> probably increased briefly before the second write got processed, and
> the read_plus got processed in between the two.
>
> While we might be able to force the client to send the WRITEs in order
> of increasing offset in this situation, the server is under no
> obligation to process concurrent RPCs in any particular order. I don't
> think this is fundamentally fixable due to that.
>
> Am I wrong? If not, then I'll plan to send an fstests patch to skip this
> test on NFS.

I'm cool with this one being skipped. I'm assuming it passing in my
setup is mostly accidental, which means it's not a very useful test.

Anna

> --
> Jeff Layton <jlayton@kernel.org>

