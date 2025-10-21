Return-Path: <linux-nfs+bounces-15460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC4BF6DA9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A743AE6AF
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5AB2741D1;
	Tue, 21 Oct 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWubOkVe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC013E02A
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054346; cv=none; b=rLWxPsicTq2Iz0ohNVGS4EbrfQ+3+m2Q8ddfVYICCACrERHICwpcTTOnRNZY5+3umuLeH6nLvUXI+xuVyTG/BmZq01zdypu98ODRrN/1ZwRhrQ9g7M0mzEa1fc6lSpoM6mPRnUBBXzpeBhOKz63eNva59m+yasxKkMJL576C+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054346; c=relaxed/simple;
	bh=6z7n4KuqrhQPbBAKYglQk0SQzzh7907XwN4euGR3gv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NosQFFWmCZAFXy0FvNg9xh2LDUBS22bpmr/zB/U+UnN3dhW57H2rBAUJQeYYtQb/+QA9KIfvYD6AiIHKaje2dpuHZ0PVPBT5ShHeLb9BteN2e92i55PYsk1oi/HQGKDRd1DJMdp7yoWcusS+mM/i8dztqppfFjSSvgeqTBDJnGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWubOkVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E00C4CEF1;
	Tue, 21 Oct 2025 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761054346;
	bh=6z7n4KuqrhQPbBAKYglQk0SQzzh7907XwN4euGR3gv4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JWubOkVeOffpkVA8gJRcbc7J77wcMWS6EWMWCYVl+qFZAtuldmAOcxW61q0/7VFp2
	 yMUDWSVXQPkEtXh6063KazXpvLJvtRX6QJHxaqAiKO2AetQOn3NGNRgd6fniHxjnT5
	 F1iDW6nASXp85mCsw7615LlTrEKc4VFCx28pf/64dakCSrCYRtZCX8aBRVq4aKSr/6
	 L6CuI98El6CNLssX3wwbmhfgE/o9y/lfjJM0aNXdOz+//FZeaYV8widyqAcclp3CWv
	 rws8brx5jCsSWqHzoakukX8m5oqS49hSrexkYOxIXCgmgXT576Wb9RG+7Ip6A25k+U
	 YvEGjMsOxNRSA==
Message-ID: <69a5c24ebe6ce9eab9fb5f6f3a6b4d74fc6597d1.camel@kernel.org>
Subject: Re: [PATCH v5 0/4] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever	 <chuck.lever@oracle.com>
Date: Tue, 21 Oct 2025 09:45:44 -0400
In-Reply-To: <4a2ab6a7-9af5-4d86-9b54-34a4f4a9682d@kernel.org>
References: <20251020162546.5066-1-cel@kernel.org>
	 <aPZkYqyFZ4SGnMbF@kernel.org>
	 <c5e0409a-5fce-4adc-bdd4-584a7c384c95@kernel.org>
	 <1ddb2a85a04320f6b8db6b2436ff63852dcfbbc9.camel@kernel.org>
	 <4a2ab6a7-9af5-4d86-9b54-34a4f4a9682d@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 09:35 -0400, Chuck Lever wrote:
> On 10/21/25 7:12 AM, Jeff Layton wrote:
> > On Mon, 2025-10-20 at 12:44 -0400, Chuck Lever wrote:
> > > On 10/20/25 12:33 PM, Mike Snitzer wrote:
> > > > On Mon, Oct 20, 2025 at 12:25:42PM -0400, Chuck Lever wrote:
> > > > Just a bit concerned about removing IOCB_SYNC in that
> > > > we're altering stable_how to be NFS_FILE_SYNC.
> > > Commit 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()") introduces
> > > the first use of IOCB_ flags in NFSD's write path, and it uses
> > > IOCB_DSYNC. The patch has Reviewed-by's from Christoph, Neil, and
> > > Jeff.
> > >=20
> > > Should we be concerned that IOCB_DSYNC does not persist time stamp
> > > changes that might be lost during an unplanned server boot?
> > >=20
> > > As a reminder to the thread, Section 3.3.7 of RFC 1813 says:
> > >=20
> > >          If stable is FILE_SYNC, the server must commit the data
> > >          written plus all file system metadata to stable storage
> > >          before returning results.
> > >=20
> > > The text is a bit blurry about whether "file system metadata" means
> > > all of the outstanding metadata changes for every file, or just the
> > > metadata changes for the target file handle.
> > >=20
> > > NFSD has historically treated DATA_SYNC and FILE_SYNC identically,
> > > as the Linux NFS client does not use DATA_SYNC (IIRC).
> > >=20
> >=20
> > Surely it just meant for the one file.
>=20
> Well yes that is the traditional understanding. I'm merely pointing out
> that the actual text is not quite as specific as what we've come to
> understand.
>=20
>=20
> > FILE_SYNC is only applicable to
> > WRITE/COMMIT operations and those only deal with a single file at a
> > time.
>=20
> True but you may recall that NFSD's COMMIT used to ignore the range
> arguments and flush the whole file. Some file systems used to flush
> all dirty data in this case, IIRC.
>=20
> There's always been a bit of a mismatch between the spec and what NFSD
> has implemented.
>=20
>=20
> > If the client gets back FILE_SYNC on a write, it should _not_
> > assume that all outstanding dirty data to all files has been sync'ed.
>=20
> Agreed.
>=20
> But back to Mike's point.
>=20
> - The spec says NFS_DATA_SYNC means persist file data.
>=20
> - The spec says NFS_FILE_SYNC means persist file data and file
>   attributes.
>=20
> - After consulting with the section describing COMMIT, I think that
>   COMMIT is supposed to persist both file data and attributes.
>=20
> And my reading of the code in fs/nfsd/vfs.c is that NFSD does the
> equivalent of NFS_DATA_SYNC in all of these cases, and has done for
> as long as I cared to chase the commit log.
>=20
> Moveover, commit 3f3503adb332 did not introduce this behavior.
>=20
> Previous to that commit, nfsd_vfs_write() passed RWF_SYNC to
> vfs_iter_write(). This API uses kiocb_set_rw_flags() to convert the RWF
> flag into an IOCB flag. kiocb_set_rw_flags does this:
>=20
>         kiocb_flags |=3D (__force int) (flags & RWF_SUPPORTED);
>         if (flags & RWF_SYNC)
>                 kiocb_flags |=3D IOCB_DSYNC;
>=20
> And that's where I copied IOCB_DSYNC from. The use of RWF_SYNC was
> introduced in 2016 by commit 24368aad47dc ("nfsd: use RWF_SYNC").
>=20
> So we've tacitly agreed to let NFSD fall short of the specs in this
> regard for some time. However I don't believe this is documented
> anywhere.
>=20
> Based on this reasoning, IOCB_DSYNC is historically correct for the
> DIRECT WRITE path and its fallbacks. I'm guessing that an O_DIRECT WRITE
> is going to persist the written data but won't persist file attribute
> changes either.
>=20

I think that's the case, generally.

> I'm open to making NFSD adhere more strictly to the spec language, but
> I bet there will be a performance impact. Maybe that impact will be
> unnoticeable on modern storage devices.
>=20

Ok, I had missed the context that we had been doing this all along
anyway. In that case, IOCB_DSYNC seems like it's probably acceptable.
We likely have bigger cache coherency problems outstanding than
potential timestamp rollbacks anyway.

Alternately, we could just return NFS_DATA_SYNC, but then we'd have to
deal with follow-on commits.
--=20
Jeff Layton <jlayton@kernel.org>

