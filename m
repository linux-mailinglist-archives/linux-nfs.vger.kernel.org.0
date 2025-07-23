Return-Path: <linux-nfs+bounces-13204-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DECB0ECD3
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 10:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EBA1C852BA
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031A227A47E;
	Wed, 23 Jul 2025 08:07:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07127AC30
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258048; cv=none; b=W8psSxH53tUbTp//R6XcBxZVo13SrePcV/pbeZTtw4ntvVWK+OooSD0bOLeUBNmQmq5NyR2cSwwPB88Qo4DimVG51pwoeZpN3nzqBNp1bXjaMW3+wtBSs9yE/X1DKuJNxBAu2A34YTl7QOUzgBWfVutAo5ZES81gsIgQeaGF9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258048; c=relaxed/simple;
	bh=tCP9n0IDHtgekJYfd4kryRcz6S9i9CfkeTw6lMD9Ra4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WpoCaeBKYlKWE0GuLSR7d2xKZ616cof4q678i4Ez4Xg8OZZRJ3AqGRnVi+OVsWLPavmq4zqozbR3qAPcg/y/kHnMq1NceuzcATcraT5JXKAON0p0C29Fmap+hJ35NuCnA/ooqHbFvrm7vi5lqXpk3du1QIIO3ySCc39N26X4fRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ueUVR-0034tV-PL;
	Wed, 23 Jul 2025 08:07:19 +0000
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
In-reply-to: <ddaf94dd-30a2-4136-8dff-542b4433308c@oracle.com>
References: <>, <ddaf94dd-30a2-4136-8dff-542b4433308c@oracle.com>
Date: Wed, 23 Jul 2025 18:07:18 +1000
Message-id: <175325803891.2234665.5884275341421351947@noble.neil.brown.name>

On Wed, 23 Jul 2025, Harshvardhan Jha wrote:
> On 08/04/25 4:01 PM, Mark Brown wrote:
> > On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
> >> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>
> >> Once a task calls exit_signals() it can no longer be signalled. So do
> >> not allow it to do killable waits.
> > We're seeing the LTP acct02 test failing in kernels with this patch
> > applied, testing on systems with NFS root filesystems:
> >
> > 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-g6=
0fe84aaf
> > 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1 =
#1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
> > 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '/p=
roc/config.gz'
> > 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run is=
 0h 01m 30s
> > 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '/p=
roc/config.gz'
> > 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> > 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acct_=
v3'
> > 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
> > 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
> > 10280 05:03:10.064653  acct02.c:193: TINFO: =3D=3D entry 1 =3D=3D
> > 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm !=3D 'acct02_helper' (=
'acct02')
> > 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode !=3D 32768 (0)
> > 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid !=3D 2466 (2461)

It seems that the acct02 process got logged..
Maybe the vfork attempt (trying to run acct02_helper) got half way an
aborted.
It got far enough that accounting got interested.
It didn't get far enough to update the ppid.
I'd be surprised if that were even possible....

If you would like to help debug this, changing the

+       if (unlikely(current->flags & PF_EXITING))

to

+       if (unlikely(WARN_ON(current->flags & PF_EXITING)))

would provide stack traces so we can wee where -EINTR is actually being
returned.  That should provide some hints.

NeilBrown


> > 10284 05:03:10.076572  acct02.c:183: TFAIL: end of file reached
> > 10285 05:03:10.076790 =20
> > 10286 05:03:10.087439  HINT: You _MAY_ be missing kernel fixes:
> > 10287 05:03:10.087741 =20
> > 10288 05:03:10.087979  https://git.kernel.org/pub/scm/linux/kernel/git/to=
rvalds/linux.git/commit/?id=3D4d9570158b626
> > 10289 05:03:10.088201 =20
> > 10290 05:03:10.088414  Summary:
> > 10291 05:03:10.088618  passed   0
> > 10292 05:03:10.098852  failed   1
> > 10293 05:03:10.099212  broken   0
> > 10294 05:03:10.099454  skipped  0
> > 10295 05:03:10.099675  warnings 0
> >
> > I ran a bisect which zeroed in on this commit (log below), I didn't look
> > into it properly but the test does start and exit a test program to
> > verify that accounting records get created properly which does look
> > relevant.
>=20
> Hi there,
> I faced the same issue and reverting this patch fixed the issue.
> Is this an issue introduced by this patch or it's due to the ltp
> testcase being outdated?
>=20
> Thanks & Regards,
> Harshvardhan
>=20
> >
> > git bisect start
> > # status: waiting for both good and bad commits
> > # bad: [0af2f6be1b4281385b618cb86ad946eded089ac8] Linux 6.15-rc1
> > git bisect bad 0af2f6be1b4281385b618cb86ad946eded089ac8
> > # status: waiting for good commit(s), bad commit known
> > # good: [38fec10eb60d687e30c8c6b5420d86e8149f7557] Linux 6.14
> > git bisect good 38fec10eb60d687e30c8c6b5420d86e8149f7557
> > # good: [fd71def6d9abc5ae362fb9995d46049b7b0ed391] Merge tag 'for-6.15-ta=
g' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> > git bisect good fd71def6d9abc5ae362fb9995d46049b7b0ed391
> > # good: [93d52288679e29aaa44a6f12d5a02e8a90e742c5] Merge tag 'backlight-n=
ext-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
> > git bisect good 93d52288679e29aaa44a6f12d5a02e8a90e742c5
> > # good: [2cd5769fb0b78b8ef583ab4c0015c2c48d525dac] Merge tag 'driver-core=
-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> > git bisect good 2cd5769fb0b78b8ef583ab4c0015c2c48d525dac
> > # bad: [25757984d77da731922bed5001431673b6daf5ac] Merge tag 'staging-6.15=
-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> > git bisect bad 25757984d77da731922bed5001431673b6daf5ac
> > # good: [28a1b05678f4e88de90b0987b06e13c454ad9bd6] Merge tag 'i2c-for-6.1=
5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> > git bisect good 28a1b05678f4e88de90b0987b06e13c454ad9bd6
> > # good: [92b71befc349587d58fdbbe6cdd68fb67f4933a8] Merge tag 'objtool-urg=
ent-2025-04-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > git bisect good 92b71befc349587d58fdbbe6cdd68fb67f4933a8
> > # good: [5e17b5c71729d8ce936c83a579ed45f65efcb456] Merge tag 'fuse-update=
-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
> > git bisect good 5e17b5c71729d8ce936c83a579ed45f65efcb456
> > # good: [344a50b0f4eecc160c61d780f53d2f75586016ce] staging: gpib: lpvo_us=
b_gpib: struct gpib_board
> > git bisect good 344a50b0f4eecc160c61d780f53d2f75586016ce
> > # bad: [9e8f324bd44c1fe026b582b75213de4eccfa1163] NFSv4: Check for delega=
tion validity in nfs_start_delegation_return_locked()
> > git bisect bad 9e8f324bd44c1fe026b582b75213de4eccfa1163
> > # good: [df210d9b0951d714c1668c511ca5c8ff38cf6916] sunrpc: Add a sysfs fi=
le for adding a new xprt
> > git bisect good df210d9b0951d714c1668c511ca5c8ff38cf6916
> > # good: [bf9be373b830a3e48117da5d89bb6145a575f880] SUNRPC: rpc_clnt_set_t=
ransport() must not change the autobind setting
> > git bisect good bf9be373b830a3e48117da5d89bb6145a575f880
> > # good: [c81d5bcb7b38ab0322aea93152c091451b82d3f3] NFSv4: clp->cl_cons_st=
ate < 0 signifies an invalid nfs_client
> > git bisect good c81d5bcb7b38ab0322aea93152c091451b82d3f3
> > # bad: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Don't allow wai=
ting for exiting tasks
> > git bisect bad 14e41b16e8cb677bb440dca2edba8b041646c742
> > # good: [0af5fb5ed3d2fd9e110c6112271f022b744a849a] NFSv4: Treat ENETUNREA=
CH errors as fatal for state recovery
> > git bisect good 0af5fb5ed3d2fd9e110c6112271f022b744a849a
> > # first bad commit: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Do=
n't allow waiting for exiting tasks
>=20


