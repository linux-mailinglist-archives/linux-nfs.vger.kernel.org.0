Return-Path: <linux-nfs+bounces-16668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C27E1C7D33B
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 16:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1614634DAEA
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACA1DDC37;
	Sat, 22 Nov 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7tfDbBW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A0136672;
	Sat, 22 Nov 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826211; cv=none; b=EbyMPc0FAMliDsY6XI/lnU4w0fWXhoc1J2eWqITGxwdJO8sTuDZjeiZSW64NG1BVsAFOxpt85/OY7BJYlTX+YQWHqDcGxwmkYTIJbS2Lkmiq82cxQyK1ZrUy3Kc4WpLCM6jGz3OUIxRUwH2+ecU7SrbtdPIsRwaxVKeACRyTayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826211; c=relaxed/simple;
	bh=TdFJ8BpALh/11PCovxqPkoECL5VlIs5MHHYqAmc5QF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=klBhfUgw2r1Y9ab5zdre5oFb570E0W71vy2R5yLsl21IUrGTr6uAYEtlPMqwwdIpCVV7p/PYzHET8mA4uXKLhofJeC8usG8HKgb4O044su4+3NLGlR9Cjn1mZuXAUmCREUZfis0mgK+penqialMvSytEfJHFFX6l1tk0sUEmriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7tfDbBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CCFC4CEF5;
	Sat, 22 Nov 2025 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763826210;
	bh=TdFJ8BpALh/11PCovxqPkoECL5VlIs5MHHYqAmc5QF0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Y7tfDbBWKz2muymuAlyQqXKIhcptxgwlg+rmr6VBLUxvMzE7fHLUY+nCRaduL5kl5
	 ri4OPzULyu0bDZbIbxL0MaoSFlqm4jUvpPdKbekba6Fg+7B3pI5B8qRD2JhDoqGdNR
	 aiyNXlSWRCi0mfs9QlWd2bZK8wIWaWdK2takDdj81e4qt0QhvVUvn/v+2c0px3Lt8Y
	 9FsPjvESTCL724RLE5CW6eTtUD4nZoTnA57C8fAv8LQc3+EAUMt8JktFeEGe09b9Ri
	 fE/G7NlSikywK+2E4yNV3zWThIt6Z+I6fxZvdD2h0MrNCd3p5t/P6KGTquqsZCSPaY
	 yg3Q+obTqcJvw==
Message-ID: <8090316eab1a1b973ab81a8f3c088caa7052d89d.camel@kernel.org>
Subject: Re: [REGRESSION] nfs: Large amounts of GETATTR calls after file
 renaming on v5.10.241
From: Trond Myklebust <trondmy@kernel.org>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Ahmed,
 Aaron"	 <aarnahmd@amazon.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
 "regressions@lists.linux.dev"
	 <regressions@lists.linux.dev>, "linux-nfs@vger.kernel.org"
	 <linux-nfs@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>
Date: Sat, 22 Nov 2025 10:43:29 -0500
In-Reply-To: <2025112203-paddle-unweave-c0a2@gregkh>
References: <F84F6626-B709-4083-9512-5F48FE370977@amazon.com>
	 <2025112203-paddle-unweave-c0a2@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-22 at 07:56 +0100, gregkh@linuxfoundation.org wrote:
> On Fri, Nov 21, 2025 at 06:56:31PM +0000, Ahmed, Aaron wrote:
> > Hi,
> >=20
> > We have had customers report a regression on kernels versions
> > 5.10.241 and above in which file renaming causes large amounts of
> > GETATTR calls to made due to inode revalidation. This regression
> > was pinpointed via bisected to commit 7378c7adf31d ("NFS: Don't set
> > NFS_INO_REVAL_PAGECACHE in the inode cache validity") which is a
> > backport of 36a9346c2252 (=E2=80=9CNFS: Don't set NFS_INO_REVAL_PAGECAC=
HE
> > in the inode cache validity=E2=80=9D).=20
> >=20
> > We were able to reproduce It with this script:
> > REPRO_PATH=3D/mnt/efs/repro
> > do_read()
> > {
> > =C2=A0=C2=A0=C2=A0 for x in {1..50}
> > =C2=A0=C2=A0=C2=A0 do
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat $1 > /dev/null
> > =C2=A0=C2=A0=C2=A0 done
> > =C2=A0=C2=A0=C2=A0 grep GETATTR /proc/self/mountstats
> > }
> >=20
> > echo foo > $REPRO_PATH/bar
> > echo "After create, before read:"
> > grep GETATTR /proc/self/mountstats
> >=20
> > echo "First read:"
> > do_read $REPRO_PATH/bar
> >=20
> > echo "Sleeping 5s, reading again (should look the same):"
> > sleep 5
> > do_read $REPRO_PATH/bar
> >=20
> > mv $REPRO_PATH/bar $REPRO_PATH/baz
> > echo "Moved file, reading again:"
> > do_read $REPRO_PATH/baz
> >=20
> > echo "Immediately performing another set of reads:"
> > do_read $REPRO_PATH/baz
> >=20
> > echo "Cleanup, removing test file"
> > rm $REPRO_PATH/baz
> > which performs a few read/writes. On kernels without the regression
> > the number of GETATTR calls remains the same while on affected
> > kernels the amount increases after reading renamed file.=20
> >=20
> > This original commit comes from a series of patches providing
> > attribute revalidation updates [1]. =C2=A0However, many of these patche=
s
> > are missing in v.5.10.241+. Specifically, 13c0b082b6a9 (=E2=80=9CNFS:
> > Replace use of NFS_INO_REVAL_PAGECACHE when checking cache
> > validity=E2=80=9D) seems like a prerequisite patch and would help remed=
y
> > the regression.
>=20
> Can you please send the needed backports to resolve this issue as you
> can test and verify that this resolves the problem?
>=20
> thanks,
>=20
> greg k-h

Ah... If I'm correctly reading the changelog
in=C2=A0https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.10.241, it
looks as if commit 36a9346c2252 got pulled in by the stable patch
automation as a dependency for commit b01f21cacde9 ("NFS: Fix the
setting of capabilities when automounting a new filesystem").

I do agree with Aaron's assessment that patch does depend on the rest
of the series that was merged into Linux 5.13. It cannot be cherry-
picked on its own.

However what exactly was the dependency that caused it to be pulled
into 5.10.241 in the first place? Was that logged anywhere?
I just checked out v5.10.241 and applied "git revert --signoff
36a9346c2252", and that appears to work just fine, and I don't see any
other obvious code dependency there, so I'm curious about what
happened.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

