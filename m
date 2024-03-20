Return-Path: <linux-nfs+bounces-2423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3E5881876
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 21:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70ADEB22166
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 20:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5885933;
	Wed, 20 Mar 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+J5QwI3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3E8562D
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965795; cv=none; b=aL42cMMABwhnOeTA6KEgkiYsI3ygBxqP4jN1bBbISWAWfTrvydmJV4N2BlFvDKp1h6McOSi2B/hv39n/5Lda0jDJdsyUGxsQtFVHKFJeYaFPv+u9OxF04ZO9+22CcC6ICQ55mc91nfD2Q42ip3OvWq2pXPXlHgq5spIMbmAPyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965795; c=relaxed/simple;
	bh=aaWag7s75uls9ly8EM2lv8LyqNBLBVbhkJkdOlQtkXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJrHltvbha8Maw2V3HkKtEQI1zJ//w7FzMknWbaqOab2656jpYhOreXce8HsDKk0PstQG4jfaLWoKa6rEV9RyjlDvqG30lVItF6AB8leEOKI82MBX69RT8mcPFQRlfH54ExVQPJCyZB+40QPwAi8/aIEsT2Pll7APEiatYkNVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+J5QwI3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710965791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+Kk/BUKv8PG/TpHfvLu4Z1KhVRmLQHhW8LYTSvPYqk=;
	b=e+J5QwI31WClsr5GUNEhE+/0PUzn8RPdlEawpxXZpNIAKyqINH8EGCl3D6MQK9w0MaDstz
	yRxmsN0htwThWPv+VE0NEgCn610OaxlI6S2bIWgU5d8JAwCbrNGf0HLZ3J0OuFXlX8Mvf/
	lvMWTRGPB13CYDzkX0LDFSSRq9rYBFU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-5GetgXOKOpa9hb0zW4LxxQ-1; Wed, 20 Mar 2024 16:16:30 -0400
X-MC-Unique: 5GetgXOKOpa9hb0zW4LxxQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-60a2b82039bso2943927b3.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 13:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965790; x=1711570590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+Kk/BUKv8PG/TpHfvLu4Z1KhVRmLQHhW8LYTSvPYqk=;
        b=M+mArPiMkeBBtFmfqKwGzF3o1VG/dZLPOtV+TZ/95dOaE3UTlDkJMShhWjUGQ43qrw
         xZxOVwanUvrGd+X7ABqpr7a4rS6VqWYclx6fRK1JDUQATFrbBICNX5a+rqO25yzLmCdB
         +/L58dEhWqFMBT/0LxVa7YSadP6iRKD+TelWV64e2fFrEkdFGMJY1vCfDBoZh2/1J9wc
         CPGWV6e6Srm0OV+67rH0sTvB0VDFtzq3u1jAlZknJWWYMZCR92jgSRmuHZ6rPONhkhCD
         /+2CRw5w9gH+X4jJyjJcEza6NmuX/x2uWgnRwadeLeOJkHg2BfKJtT97sY4MOVbWsF0d
         Vi4A==
X-Gm-Message-State: AOJu0YxiJMRGJvFFTTeRvgjr7r+PBS2u0QJFdOaDWw5Z96PrXq3aROFT
	SSyJQznCfWcfdR+43yZdMdPtzyCVu6XtY85LGpU6G11OraPYcC8jbehvHuU1zoNF1GncddV1JvL
	SOhiHifnf+sG5QUC+6Qytb9UGx9LzvjQjPKwvXEjb/Z1u+xo9GNre77BJh//RQL6cU/ss5yb+oz
	kdFkLk+SJ2It7yKGB/PyU6biGT+33Pe3bG
X-Received: by 2002:a0d:d004:0:b0:610:b930:816f with SMTP id s4-20020a0dd004000000b00610b930816fmr11280866ywd.41.1710965789763;
        Wed, 20 Mar 2024 13:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGah1kVFlxHsiam9w3OzbyreHM6ggtf3+q1Ic05IzP9AAIUlZ2igfqqdLrbZuK44q9AlprsB5nMGS9Bh2IwyZk=
X-Received: by 2002:a0d:d004:0:b0:610:b930:816f with SMTP id
 s4-20020a0dd004000000b00610b930816fmr11280848ywd.41.1710965789369; Wed, 20
 Mar 2024 13:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140923.16598-1-npache@redhat.com> <ZfnQoTn-xN72HppD@aion>
In-Reply-To: <ZfnQoTn-xN72HppD@aion>
From: Nico Pache <npache@redhat.com>
Date: Wed, 20 Mar 2024 14:16:03 -0600
Message-ID: <CAA1CXcBqcyXma1kGwvfAQ5T24dmuH_Or9RPrVqxDoVq=N4Se3w@mail.gmail.com>
Subject: Re: [BUG REPORT] not ok 1 Derive Kc subkey for camellia128-cts-cmac
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:51=E2=80=AFAM Scott Mayhew <smayhew@redhat.com> =
wrote:
>
> Hi,
>
> On Thu, 07 Mar 2024, Nico Pache wrote:
>
> > Hi,
> >
> > One of the RFC 6803 key derivation kunit subtests is failing.
> >
> > cki-project data warehouse : https://datawarehouse.cki-project.org/issu=
e/2514
> >
> > Arches: X86_64, ARM64, S390x, ppc64le
> > First Appeared: ~6.8.rc2
> >
> > TRACE:
> > # Subtest: RFC 6803 key derivation
> >     # RFC 6803 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/=
gss_krb5_test.c:63
> >     Expected err =3D=3D 0, but
> >         err =3D=3D -110 (0xffffffffffffff92)
> >         not ok 1 Derive Kc subkey for camellia128-cts-cmac
> >         ok 2 Derive Ke subkey for camellia128-cts-cmac
> >         ok 3 Derive Ki subkey for camellia128-cts-cmac
> >         ok 4 Derive Kc subkey for camellia256-cts-cmac
> >         ok 5 Derive Ke subkey for camellia256-cts-cmac
> >         ok 6 Derive Ki subkey for camellia256-cts-cmac
> >     # RFC 6803 key derivation: pass:5 fail:1 skip:0 total:6
> >     not ok 1 RFC 6803 key derivation
>
> This was broken by:
> c72a870926c2 kunit: add ability to run tests after boot using debugfs
>
> __kunit_test_suites_init() runs any time a kernel module is loaded, via
> the "kunit_mod_nb" notifier_block... even if the kernel module has no
> kunit tests.  But now __kunit_test_suites_init() also locks a mutex,
> which is a problem if a kunit test itself needs to load a kernel module
> (which the gss_krb5_test module does).
>
> This fixes it for me:
>
> ---8<---
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 088489856db8..18af9453632b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -707,6 +707,9 @@ int __kunit_test_suites_init(struct kunit_suite * con=
st * const suites, int num_
>  {
>         unsigned int i;
>
> +       if (num_suites =3D=3D 0)
> +               return 0;
> +
>         if (!kunit_enabled() && num_suites > 0) {
>                 pr_info("kunit: disabled\n");
>                 return 0;
> ---8<---
>
Nice find! Would you mind posting a patch?

-- Nico

> More detail below:
>
> Here's the modprobe command where I loaded the gss_krb5_test module.  Thi=
s
> process has the "kunit_run_lock" mutex locked:
>
> PID: 1468     TASK: ffff9aed0ac20000  CPU: 0    COMMAND: "modprobe"
>  #0 [ffffba974196f6f8] __schedule at ffffffff83fd85f5
>  #1 [ffffba974196f7b0] schedule at ffffffff83fd9672
>  #2 [ffffba974196f7c8] schedule_timeout at ffffffff83fe0308
>  #3 [ffffba974196f818] wait_for_completion_timeout at ffffffff83fda3d4
>  #4 [ffffba974196f878] kunit_try_catch_run at ffffffffc0d5e851 [kunit]
>  #5 [ffffba974196f8c8] kunit_run_tests at ffffffffc0d5c0ea [kunit]
>  #6 [ffffba974196fb78] __kunit_test_suites_init at ffffffffc0d5c9af [kuni=
t]
>  #7 [ffffba974196fb98] kunit_module_notify at ffffffffc0d5ba4b [kunit]
>  #8 [ffffba974196fc08] notifier_call_chain at ffffffff8314647a
>  #9 [ffffba974196fc40] blocking_notifier_call_chain_robust at ffffffff831=
46565
> #10 [ffffba974196fc88] load_module at ffffffff831e1935
> #11 [ffffba974196fde8] __do_sys_init_module at ffffffff831e1fba
> #12 [ffffba974196fec0] do_syscall_64 at ffffffff83fc3461
> #13 [ffffba974196fee8] do_user_addr_fault at ffffffff830979df
> #14 [ffffba974196ff28] exc_page_fault at ffffffff83fc9c7f
> #15 [ffffba974196ff50] entry_SYSCALL_64_after_hwframe at ffffffff840000ea
>     RIP: 00007ff1f272b4ae  RSP: 00007ffd45db8f68  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 000055bf4c0c4b20  RCX: 00007ff1f272b4ae
>     RDX: 000055bf4b204e79  RSI: 0000000000099691  RDI: 000055bf4cbfd130
>     RBP: 00007ffd45db9020   R8: 000055bf4c0c4010   R9: 0000000000000007
>     R10: 0000000000000001  R11: 0000000000000246  R12: 000055bf4b204e79
>     R13: 0000000000040000  R14: 000055bf4c0c4c50  R15: 000055bf4c0c4390
>     ORIG_RAX: 00000000000000af  CS: 0033  SS: 002b
>
> Here's the kunit test case running.  It's trying to allocate "cmac(camell=
ia)"
> via crypto_alloc_shash():
>
> PID: 1508     TASK: ffff9aed155d0000  CPU: 1    COMMAND: "kunit_try_catch=
"
>  #0 [ffffba974194fba0] __schedule at ffffffff83fd85f5
>  #1 [ffffba974194fc58] schedule at ffffffff83fd9672
>  #2 [ffffba974194fc70] schedule_timeout at ffffffff83fe0308
>  #3 [ffffba974194fcc0] wait_for_completion_killable_timeout at ffffffff83=
fda708
>  #4 [ffffba974194fd20] crypto_larval_wait at ffffffff83747fb4
>  #5 [ffffba974194fd38] crypto_alg_mod_lookup at ffffffff83748252
>  #6 [ffffba974194fd70] crypto_alloc_tfm_node at ffffffff83748492
>  #7 [ffffba974194fdb0] krb5_kdf_feedback_cmac at ffffffffc0d76bb2 [rpcsec=
_gss_krb5]
>  #8 [ffffba974194fe30] kdf_case at ffffffffc0d800a8 [gss_krb5_test]
>  #9 [ffffba974194fe80] kunit_try_run_case at ffffffffc0d5bb54 [kunit]
> #10 [ffffba974194fee8] kunit_generic_run_threadfn_adapter at ffffffffc0d5=
e797 [kunit]
> #11 [ffffba974194fef8] kthread at ffffffff8313eda5
> #12 [ffffba974194ff30] ret_from_fork at ffffffff830414a1
> #13 [ffffba974194ff50] ret_from_fork_asm at ffffffff830039ab
>
> Here the crypto manager is trying to modprobe the camellia kernel module =
via a
> usermodehelper call:
>
> PID: 1511     TASK: ffff9aed04630000  CPU: 3    COMMAND: "cryptomgr_probe=
"
>  #0 [ffffba974195fb88] __schedule at ffffffff83fd85f5
>  #1 [ffffba974195fc40] schedule at ffffffff83fd9672
>  #2 [ffffba974195fc58] schedule_timeout at ffffffff83fe03c1
>  #3 [ffffba974195fca8] wait_for_completion_state at ffffffff83fdb06d
>  #4 [ffffba974195fd18] call_usermodehelper_exec at ffffffff83130313
>  #5 [ffffba974195fd68] __request_module at ffffffff831e325d
>  #6 [ffffba974195fe28] crypto_alg_mod_lookup at ffffffff83748220
>  #7 [ffffba974195fe60] crypto_grab_spawn at ffffffff83749ff7
>  #8 [ffffba974195fe98] cmac_create at ffffffff8375c2f0
>  #9 [ffffba974195fed8] cryptomgr_probe at ffffffff83754a93
> #10 [ffffba974195fef8] kthread at ffffffff8313eda5
> #11 [ffffba974195ff30] ret_from_fork at ffffffff830414a1
> #12 [ffffba974195ff50] ret_from_fork_asm at ffffffff830039ab
>
> And here's the resulting modprobe command, which is stuck waiting on the
> "kunit_run_lock" mutex:
>
> PID: 1512     TASK: ffff9aed143fafc0  CPU: 2    COMMAND: "modprobe"
>  #0 [ffffba9741957990] __schedule at ffffffff83fd85f5
>  #1 [ffffba9741957a48] schedule at ffffffff83fd9672
>  #2 [ffffba9741957a60] schedule_preempt_disabled at ffffffff83fd9cb5
>  #3 [ffffba9741957a68] __mutex_lock.constprop.0 at ffffffff83fdc57a
>  #4 [ffffba9741957ae8] __kunit_test_suites_init at ffffffffc0d5c95a [kuni=
t]
>  #5 [ffffba9741957b08] kunit_module_notify at ffffffffc0d5ba4b [kunit]
>  #6 [ffffba9741957b78] notifier_call_chain at ffffffff8314647a
>  #7 [ffffba9741957bb0] blocking_notifier_call_chain_robust at ffffffff831=
46565
>  #8 [ffffba9741957bf8] load_module at ffffffff831e1935
>  #9 [ffffba9741957d58] __do_sys_init_module at ffffffff831e1fba
> #10 [ffffba9741957e30] do_syscall_64 at ffffffff83fc3461
> #11 [ffffba9741957e48] __vm_munmap at ffffffff833bcdeb
> #12 [ffffba9741957ee8] do_syscall_64 at ffffffff83fc3470
> #13 [ffffba9741957f50] entry_SYSCALL_64_after_hwframe at ffffffff840000ea
>     RIP: 00007f8ba092b4ae  RSP: 00007ffc771e0378  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 00005572137e6e40  RCX: 00007f8ba092b4ae
>     RDX: 0000557211c4de79  RSI: 0000000000080451  RDI: 00007f8b9ff90010
>     RBP: 00007ffc771e0430   R8: 00005572137e6010   R9: 0000000000000007
>     R10: 0000000000000001  R11: 0000000000000246  R12: 0000557211c4de79
>     R13: 0000000000040000  R14: 00005572137e73b0  R15: 00005572137e6400
>     ORIG_RAX: 00000000000000af  CS: 0033  SS: 002b
>
> The camellia module doesn't even have any kunit tests, so __kunit_test_su=
ites_init()
> is waiting to lock the "kunit_run_lock" mutex for nothing:
>
> crash> module -o | grep num_kunit
>   [0x478] int num_kunit_init_suites;
>   [0x488] int num_kunit_suites;
> crash> mod | grep camellia
> ffffffffc0da15c0  camellia_x86_64                ffffffffc0d99000    5734=
4  (not loaded)  [CONFIG_KALLSYMS]
> crash> px 0xffffffffc0da15c0+0x478
> $1 =3D 0xffffffffc0da1a38
> crash> px 0xffffffffc0da15c0+0x488
> $2 =3D 0xffffffffc0da1a48
> crash> rd 0xffffffffc0da1a38
> ffffffffc0da1a38:  0000000000000000                    ........
> crash> rd 0xffffffffc0da1a48
> ffffffffc0da1a48:  0000000000000000                    ........
>
> -Scott
> > --
> > 2.44.0
> >
> >
>


