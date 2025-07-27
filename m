Return-Path: <linux-nfs+bounces-13264-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5DFB12DC6
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 06:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4E44A075A
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 04:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293717A2FC;
	Sun, 27 Jul 2025 04:51:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCA20E6
	for <linux-nfs@vger.kernel.org>; Sun, 27 Jul 2025 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753591865; cv=none; b=IowiG/VN+JOdhI9lhLjsBqifb0b45nsxi1b+zN5kUzLfOh/S0/eE0MPoBI6Cp47qeUxQwBZHV6vVD8MtwPcN+1Csw1pszC2TfDaGCmrtOAoxRYjIP65f3fe0AXmuRuVltcp3PMAB6B44HOGKwzNpcTzKFfAH0HGofhJPbdzBU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753591865; c=relaxed/simple;
	bh=FaElcyjfIxJBkb7B15WeFUn8G6/fTpZTiAhPSM6CWjM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZCpsaa5QPcwYF94eQkjtubNGwPXheeYWhH1uHrupGKL8raahV6VkkNS9G4sJqW/5KQXobMuVllw3yhLH7HTi2W9GZL1bByZ91Fquddy1TLyX9A+DqVrifTeQFmHjidpK8mwM2ExCiMNS2D0gxktdmIPynSklgUIqaFJUGA18Mwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uftLU-003aFd-2A;
	Sun, 27 Jul 2025 04:50:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Harshvardhan Jha" <harshvardhan.j.jha@oracle.com>
Cc: "Mark Brown" <broonie@kernel.org>, trondmy@kernel.org,
 linux-nfs@vger.kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Anna Schumaker" <anna@kernel.org>
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
In-reply-to: <c5d1eb2b-2697-4413-983c-0650eab389e9@oracle.com>
References: <>, <c5d1eb2b-2697-4413-983c-0650eab389e9@oracle.com>
Date: Sun, 27 Jul 2025 14:50:48 +1000
Message-id: <175359184844.2234665.17719114991555307336@noble.neil.brown.name>

On Fri, 25 Jul 2025, Harshvardhan Jha wrote:
> On 23/07/25 1:37 PM, NeilBrown wrote:
> > On Wed, 23 Jul 2025, Harshvardhan Jha wrote:
> >> On 08/04/25 4:01 PM, Mark Brown wrote:
> >>> On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
> >>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>>
> >>>> Once a task calls exit_signals() it can no longer be signalled. So do
> >>>> not allow it to do killable waits.
> >>> We're seeing the LTP acct02 test failing in kernels with this patch
> >>> applied, testing on systems with NFS root filesystems:
> >>>
> >>> 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-=
g60fe84aaf
> >>> 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc=
1 #1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
> >>> 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '=
/proc/config.gz'
> >>> 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run =
is 0h 01m 30s
> >>> 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '=
/proc/config.gz'
> >>> 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=
=3Dy
> >>> 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acc=
t_v3'
> >>> 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
> >>> 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
> >>> 10280 05:03:10.064653  acct02.c:193: TINFO: =3D=3D entry 1 =3D=3D
> >>> 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm !=3D 'acct02_helper'=
 ('acct02')
> >>> 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode !=3D 32768 (0)
> >>> 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid !=3D 2466 (2461)
> > It seems that the acct02 process got logged..
> > Maybe the vfork attempt (trying to run acct02_helper) got half way an
> > aborted.
> > It got far enough that accounting got interested.
> > It didn't get far enough to update the ppid.
> > I'd be surprised if that were even possible....
> >
> > If you would like to help debug this, changing the
> >
> > +       if (unlikely(current->flags & PF_EXITING))
> >
> > to
> >
> > +       if (unlikely(WARN_ON(current->flags & PF_EXITING)))
> >
> > would provide stack traces so we can wee where -EINTR is actually being
> > returned.  That should provide some hints.
> >
> > NeilBrown
>=20
> Hi Neil,
>=20
> Upon this addition I got this in the logs

Thanks for testing.  Was there anything new in the kernel logs?  I was
expecting a WARNING message followed by a "Call Trace".

If there wasn't, then this patch cannot have caused the problem.
If there was, then I need to see it.

Thanks,
NeilBrown


>=20
> <<<test_start>>>
> tag=3Dacct02 stime=3D1753444172
> cmdline=3D"acct02"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> tst_kconfig.c:88: TINFO: Parsing kernel config
> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
> tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-w1ozKKlJ6n/LTP_acc4RRfLh as
> tmpdir (nfs filesystem)
> tst_test.c:2004: TINFO: LTP version: 20250530-105-gda73e1527
> tst_test.c:2007: TINFO: Tested kernel:
> 6.15.8-1.bug38227970.el9.rc2.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 25
> 02:03:04 PDT 2025 x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config
> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
> tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
> tst_kconfig.c:88: TINFO: Parsing kernel config
> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
> acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> acct02.c:238: TINFO: Verifying using 'struct acct_v3'
> acct02.c:191: TINFO: =3D=3D entry 1 =3D=3D
> acct02.c:82: TINFO: ac_comm !=3D 'acct02_helper' ('acct02')
> acct02.c:131: TINFO: ac_exitcode !=3D 32768 (0)
> acct02.c:139: TINFO: ac_ppid !=3D 88929 (88928)
> acct02.c:181: TFAIL: end of file reached
>=20
> HINT: You _MAY_ be missing kernel fixes:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D4d9570158b626
>=20
> Summary:
> passed=C2=A0 =C2=A00
> failed=C2=A0 =C2=A01
> broken=C2=A0 =C2=A00
> skipped=C2=A0 0
> warnings 0
> incrementing stop
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D0 cstime=3D20
>=20
> <<<test_end>>>
>=20
>=20
> Thanks & Regards,
>=20
> Harshvardhan

