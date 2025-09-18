Return-Path: <linux-nfs+bounces-14589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B279B874DD
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 00:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E9566253
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 22:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BD02FDC27;
	Thu, 18 Sep 2025 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="c83GlalR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZZlqxm6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569F2D6E41;
	Thu, 18 Sep 2025 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236375; cv=none; b=rTi17tcrFqN+2IvY7fklZmBH6TpFg6dA+scMwbRR58i2EX/qOHqD4Am5dXoJ5ogXLvoSdjo11MkYo0kpOh8By0vsx3l851hWyPYc770C8h8sgK9FCto5i1JOeGLLUGyuRvBg2uX8RW0wzDIH+fQb0kho/i/eDuiaDI3qIYwTDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236375; c=relaxed/simple;
	bh=HyGnjyKlCM602IrSwMYMHAJP68YruUdiAq2NkI/xWqw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=neRYgBzFaAautKAWImDsAiQaOwImRqiv0yx39i/30fReammh/Oxp1SLEAsc9t1MmKjaEznWe/3fxCvJj+n0oY4IJgUM6iQX6H1lSOBulPnqX/yaGXhRAXbsd40gTo0PFw51kMBnfazLChuqiogVlBH0+Boge1tT06Gq3wZ+Eeg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=c83GlalR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZZlqxm6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 55008EC028E;
	Thu, 18 Sep 2025 18:59:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 18 Sep 2025 18:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758236372; x=1758322772; bh=0SSS+ZBcnDjbykuv7R2lc1pAt58w0XXPuqu
	HN1E3nag=; b=c83GlalRGDTWroBRbOs+nbdP5pAODTd0lLMIF7aFwt0kZMKhZk9
	hj3UBEpAiu7Z/ZwKgI4dPc9LVRjLhpxn44X6UmAFOk0Ou/q2em0J0hFCVVPhXFu/
	A5Bmnx3uVMAOXocaGs1l0nl5my3sYQ4vLHbevaFJ/o9EM1uLglNmBxeXRjsUkcPv
	9gAkdTnzysW0LHkJrGQMR4BT/v4FrtiFzMjP0Fk4aDHzNZx6MOiluGPL8R4LCdbE
	TxK/G9G8M3UKwg6uQh1R/HoGIa4kAeLD03tstC0xBavve9ZEF1bRBTW+uHgMpzNV
	fNCQ/WYjpNrFpC5HOgppERKR+s6x5TmvmSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758236372; x=
	1758322772; bh=0SSS+ZBcnDjbykuv7R2lc1pAt58w0XXPuquHN1E3nag=; b=Y
	ZZlqxm6lQcSHNItGrV0Qp15fhhdQSOPm6iUl8bkf88ozxnd7noKUxBhz8WwfGDdA
	hHxg9beq8LZIP5yTPxrzgRaF0sRcqJhH2vwr4rHJPWZdzfKKAiLcLDFsyL2QFxn/
	rpgnz7frriAEMRlhT5XrFUVpssQAD9TD02uvJWhVnjuqGzfcnNG2JOpbyT7Wo3Mk
	PB8qbv9mYaNvR5Y1yPj+uBEn4nAslNYVEwSzZaj3hM9jK/Td7XdcmLkVyphyGiHY
	oW74/IFdJzNv2THPXan59Nuyol0WWRX2enjQjqTo5WwyzYo5GlJjt+IUXxrT0ovo
	AKf2pS1pJgVrBViO0COlw==
X-ME-Sender: <xms:047MaIF38ijYqMCvWFQ2vJQRFbGQNiE3-qYk0QuZUpeRkDsBbzspwA>
    <xme:047MaNJnTfzaZzkBNN47oZwG664rX4H_t1qRFNNXOpJTOIRg4Eh-dzldlzlIBvekk
    G8SqD6E6jLNXw>
X-ME-Received: <xmr:047MaIkEO-XlN_vOrFyFEKK6a9aNHr4zLLAdtlfUqEn1X7ALPJxQpw21Q9WxsHFM2IFSdJzFRw_5Em0DlA6JJKe_uGE8J3yD0myGecyNXxZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    dvueetleekjeekveetteevtdekgeeludeifedtfeetgfdttdeljefglefgveffieenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlh
    hpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtth
    hopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopeihuhhkuhgrihefsehhuhgrfigvihdrtg
    homhdprhgtphhtthhopeihihdriihhrghngheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:047MaGwJqzB470xnqentec5rkOZkhQhk3nxr3HzaYpb-EJWmZxmClQ>
    <xmx:047MaCt-hO5z37ql_p4gspyHf-9kM0usKjicGFmZ4NB_GycNDplqyA>
    <xmx:047MaIHKS5KuzzXK_MaGPQeLgwLW2hAvBf0bq-qsbAceNl0uayz5KA>
    <xmx:047MaI7uskXEqEGHKsVdcaD4nzWjWvKmaNxaUOTi7VyicRHMR91laQ>
    <xmx:1I7MaELCCMQWinRF-_Xv0CJ0KO9ChgQILXVDNyYei_EPloWq2gxbZSyG>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 18:59:27 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: 34bd5595-8f3f-4c52-a1d5-d782fc99efb9@huawei.com
Cc: "Li Lingfeng" <lilingfeng3@huawei.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "yangerkun" <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
 "Hou Tao" <houtao1@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>, leo.lilong@huawei.com
Subject: Re: [Question] nfsd: possible reordering between nf->nf_file
 assignment and NFSD_FILE_PENDING clearing?
In-reply-to: <e27254b5-22cf-4578-9623-d2d8de54aeca@huaweicloud.com>
References: <e27254b5-22cf-4578-9623-d2d8de54aeca@huaweicloud.com>
Date: Fri, 19 Sep 2025 08:59:25 +1000
Message-id: <175823636555.1696783.2385271688831175643@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 19 Sep 2025, 34bd5595-8f3f-4c52-a1d5-d782fc99efb9@huawei.com wrote:
> Hi,

You probably need to backport

Commit: 8238b4579866 ("wait_on_bit: add an acquire memory barrier")

NeilBrown


>=20
> On 2025/9/18 21:57, Li Lingfeng wrote:
> > Recently, we encountered a null pointer dereference on a relatively old
> > 5.10 kernel that does not include commit c4c649ab413ba ("NFSD: Convert
> > filecache to rhltable"), which exhibited the same behavior as described
> > in [1]. I was wondering if it might be caused by the reordering between
> > the assignment of nf->nf_file and the clearing of NFSD_FILE_PENDING.
> >=20
> > Just to mention, I don't believe the analysis in [1] is entirely accurate,
> > since hlist_add_head_rcu includes a write barrier.
> >=20
> > We haven't encountered this issue on newer kernel versions, but the
> > assignment of nf->nf_file and the clearing of NFSD_FILE_PENDING appear
> > consistent across different versions.
> >=20
> > Our expected outcome should be like this:
> >                 T1                                    T2
> > nfsd_read
> >  nfsd_file_acquire_gc
> >   nfsd_file_do_acquire
> >    nfsd_file_lookup_locked
> >     // get nfsd_file from nfsd_file_rhltable
> >                                         nfsd_read
> >                                          nfsd_file_acquire_gc
> >                                           nfsd_file_do_acquire
> >                                            nfsd_file_alloc
> >                                             nf->nf_flags // set NFSD_FILE=
_PENDING
> >                                            rhltable_insert // insert to n=
fsd_file_rhltable
> >                                            nf->nf_file =3D file // set nf=
_file
> >    wait_on_bit
> >    // wait NFSD_FILE_PENDING to be cleared
> >                                            clear_and_wake_up_bit // clear=
 NFSD_FILE_PENDING
> >    // get file after being awakened
> >  file =3D nf->nf_file
> >=20
> > Or like this:
> >                 T1                                    T2
> > nfsd_read
> >  nfsd_file_acquire_gc
> >   nfsd_file_do_acquire
> >    nfsd_file_lookup_locked
> >     // get nfsd_file from nfsd_file_rhltable
> >                                         nfsd_read
> >                                          nfsd_file_acquire_gc
> >                                           nfsd_file_do_acquire
> >                                            nfsd_file_alloc
> >                                             nf->nf_flags // set NFSD_FILE=
_PENDING
> >                                            rhltable_insert // insert to n=
fsd_file_rhltable
> >                                            nf->nf_file =3D file // set nf=
_file
> >                                            clear_and_wake_up_bit // clear=
 NFSD_FILE_PENDING
> >    // get file directly
> >  file =3D nf->nf_file
> >=20
> > But is it possible that due to reordering, it ends up like this:
> >                 T1                                    T2
> > nfsd_read
> >  nfsd_file_acquire_gc
> >   nfsd_file_do_acquire
> >    nfsd_file_lookup_locked
> >     // get nfsd_file from nfsd_file_rhltable
> >                                         nfsd_read
> >                                          nfsd_file_acquire_gc
> >                                           nfsd_file_do_acquire
> >                                            nfsd_file_alloc
> >                                             nf->nf_flags // set NFSD_FILE=
_PENDING
> >                                            rhltable_insert // insert to n=
fsd_file_rhltable
> >                                            clear_and_wake_up_bit // clear=
 NFSD_FILE_PENDING
> >    // get file directly
> >  file =3D nf->nf_file
> >                                            nf->nf_file =3D file // set nf=
_file
> >  // Null dereference due to uninitialized file pointer.
> >=20
> > [1]: https://lore.kernel.org/all/20230818065507.1280625-1-haydenw.kernel@=
gmail.com/
> >=20
> > Any suggestion will be appreciated.
> >=20
> > Thanks,
> > Lingfeng.
> >=20
>=20
> I would like to provide a reproducible test case, though it might not be
> entirely precise.
>=20
> The test case mimics the nfsd_file_acquire workflow and consists of three
> threads: main thread, thread1, and thread2, where:
>=20
> * Thread1 acts as the writer, simulating the open_file workflow.
> * Thread2 acts as the reader, simulating the wait_for_construction workflow.
> * The main thread runs multiple iterations to ensure that thread1 and threa=
d2
>   can execute concurrently in each round.
>=20
> The test case is as follows:
>=20
>=20
> // writer
> static int thread_func1(void *data)
> {
> 	struct foo *nf;
> 	void *file;
>=20
> 	nf =3D &global_nf;
>=20
> 	while (!kthread_should_stop()) {
> 		wait_for_completion(&comp_start1);
> 		if (kthread_should_stop()) break;
>=20
> 		/* Simulate the open_file process in nfsd_file_acquire() */
> 		__set_bit(FOO_PENDING, &nf->nf_flags);
> 		hlist_add_head_rcu(&nf->nf_node, &foo_hashtbl[ghashval].nfb_head);
> 		file =3D foo_filp_open();
>=20
> 		/* Test whether the following two lines of code will cause memory reorder=
ing */
> 		nf->nf_file =3D file;
> 		clear_bit_unlock(FOO_PENDING, &nf->nf_flags);
>=20
> 		smp_mb__after_atomic();
> 		wake_up_bit(&nf->nf_flags, FOO_PENDING);
>=20
> 		complete(&comp_end1);
> 	}
> 	if (file)
> 		kfree(file);
> 	pr_info("thread_func1: exit\n");
> 	return 0;
> }
>=20
> // reader
> static int thread_func2(void *data)
> {
> 	void *file;
> 	struct foo *nf;
>=20
> 	nf =3D &global_nf;
>=20
> 	while (!kthread_should_stop()) {
> 		wait_for_completion(&comp_start2);
> 		if (kthread_should_stop()) break;
>=20
> 		/* Simulate the wait_for_construction process in nfsd_file_acquire() */
> retry:
> 		rcu_read_lock();
> 		nf =3D foo_find_locked(ghashval);
> 		rcu_read_unlock();
> 		if (!nf)
> 			goto retry;
>=20
> 		wait_on_bit(&nf->nf_flags, FOO_PENDING, TASK_UNINTERRUPTIBLE);
> 		file =3D nf->nf_file;
> 		if (!file)
> 			WARN_ON(1);
> 		else
> 			kfree(file);
>=20
> 		complete(&comp_end2);
> 	}
> 	pr_info("thread_func2: exit\n");
> 	return 0;
> }
>=20
> static int main_thread_func(void *data)
> {
> 	u64 iters =3D 0;
>=20
> 	while (!kthread_should_stop()) {
> 		iters++;
> 		if (iters % 1000000 =3D=3D 0)
> 			pr_info("main_thread_func: started %llu iterations\n", iters);
>=20
> 		/* Start both threads */
> 		complete(&comp_start1);
> 		complete(&comp_start2);
> 		/* wait for both to finish */
> 		wait_for_completion(&comp_end1);
> 		wait_for_completion(&comp_end2);
>=20
> 		/* Reset completions */
> 		reinit_completion(&comp_end1);
> 		reinit_completion(&comp_end2);
> 		reinit_completion(&comp_start1);
>         	reinit_completion(&comp_start2);
>=20
> 		hlist_del_rcu(&global_nf.nf_node);
>                 global_nf.nf_file =3D 0;
>                 global_nf.nf_flags =3D 0;
> 	}
>=20
> 	pr_info("main_thread_func: exit\n");
>=20
> 	return 0;
> }
>=20
>=20
> I compiled and executed this test case on ARM64. The experimental results s=
how that
> after approximately 6,000,000 rounds, the "file is null" warning in thread2=
 was
> triggered, indicating that reordering occurred between the file assignment =
and flag
> clearance operations in thread1.
>=20
>=20
> [107632.795543] My module is being loaded
> [107632.800255] Threads started successfully
> [107637.656469] main_thread_func: started 1000000 iterations
> [107642.520876] main_thread_func: started 2000000 iterations
> [107646.919550] main_thread_func: started 3000000 iterations
> [107651.545742] main_thread_func: started 4000000 iterations
> [107655.577054] main_thread_func: started 5000000 iterations
> [107660.507772] main_thread_func: started 6000000 iterations
> [107663.212711] ------------[ cut here ]------------
> [107663.218265] WARNING: CPU: 26 PID: 10603 at /path/to/nfsd/mod3/order_tes=
t.c:142 thread_func2+0xa0/0xe0 [order_test]
>=20
>=20
> When I placed an smp_mb() between 'wait_on_bit' and 'file =3D nf->nf_file' =
in thread2,
> the warning *no longer* occurred.
>=20
> 		wait_on_bit(&nf->nf_flags, FOO_PENDING, TASK_UNINTERRUPTIBLE);
> +		smp_mb();
> 		file =3D nf->nf_file;
>=20
> I hope this test case proves helpful for investigating the aforementioned m=
emory
> reordering issue.
>=20
> Best regards,
> Tengda
>=20
>=20


