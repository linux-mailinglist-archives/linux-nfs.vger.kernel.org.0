Return-Path: <linux-nfs+bounces-22806-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +82/MKkWPGrZjggAu9opvQ
	(envelope-from <linux-nfs+bounces-22806-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:40:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D276C0698
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:40:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ftZN5FMj;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22806-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22806-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B0F0301C946
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565A3DD847;
	Wed, 24 Jun 2026 17:40:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCCC3DD52C;
	Wed, 24 Jun 2026 17:40:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322854; cv=none; b=GY7C1uhPNtOys+QdyIEBQAcSbqxGTwWgULUYbT3u2P5N1CNy81j5wgpgL04y2p4PljXfma1DBO6ZJvHLSUIMkSp5fvax18sYOjBUqYPLez31T/DkLgOxYL3VlA3DxO+vPG/70+rE+TT2Vza5vDGZgdNpIsw8kUlKME4dmGI5n9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322854; c=relaxed/simple;
	bh=taTjQ2E+gAZ0MH0aKhoFsHBfoQOqaOz9pQSiNtNH7Rw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mdTGxrAlDRKqj0goV7tXUOEWP1PmlrJ1rWrX3TsuzJBwl7HBdWk504gSkz/6bmF9bLUMGufJdbhK1+KCj5TIWQ145++T72CNRdk8m+PFGALIspHc3Nz3HXtlzMuYmi1s2T69D72qi0g4VIqstCmyvl0u+xcWTIKe6LXj5VI/kEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftZN5FMj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFD31F00A3A;
	Wed, 24 Jun 2026 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322851;
	bh=Pgn/VEgIrLmNwajq3UvGjWPMFY3iHxHxLsrU3go3Occ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ftZN5FMjsK+u48mFhmCe39UZNEpCu43knI4iHV2ssn9LC9vUZLGKdTmvYn64dFKPh
	 Dd/G0miL8Os0VGwvKgsRJZInFoaJ9Doe/QyzFrqZ7UR74VpR/xbph/3hALvGFkcRX6
	 zVqGXnqZh2bV51omHuQX3HY3l+TMlpngdOK1m712bzGxMjNWV/nFCAUsJYzAZrSUd1
	 lAw9gSAtixuMz+Kmuu235Tg8MfJ7rR966EptZsmBazaH8nj83mHXf5axziE3nFT0o7
	 9125rDGL6zyq60OhC16Wzh4DijPc3qWGBnTalT7x4iGRSCaZHg51+Mn+rwEAKwIi8l
	 yRjq6UchKHQVA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9679AF40092;
	Wed, 24 Jun 2026 13:40:50 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 13:40:50 -0400
X-ME-Sender: <xms:ohY8aj0UwhcI91WWq2w1KtDNQrjfcsWkcSfiWelekZQmnxIpHCGY_A>
    <xme:ohY8as4_nOVKZQWTM95GgvyJ4AGR7akoQAPyEHJUqA8FKK6ymJwvFEofEeTOy-e0A
    8lxvz0NgHzAynlm1XFXOknhogf3mtX638MKY9ebTtmWItMQGH9Drkoo>
X-ME-Proxy-Cause: dmFkZTFGjxciZgABQIbAOdNCY9jS63ZZMwWqilOlJGzI6kmQ/SVlQ//XBITfCxErZVxqbc
    3TfJ83SAPRyheCFVFBUeKvfrRC1qOuDFrwNM5gHFuSb+cCSYotKmJ49w8JZNfz493lDILy
    nFHOikG1tU00sXgA2Jd1pUtwqQelXW3oueKg3IM+pL27w6zVGnvageAVxhrleHFMCZOgvI
    Gto5iyqVPh3QiNPNTajmmk3YDOUexjsB1h+6XYtNXHoJ4gh9UKv0Q8fEgcvwW3JMkxBckY
    DbnXOJYfvrO1coRt9KCJd5JJ6UgJe35hoBzDmVCV1pwCskf8yLElsbNs97HNZRNhdw2sb5
    P7+mEqrl6MiDQvY7LKS9pL4ewu//cy6a/gGmOoe9syd2zyFw8K3BHoxmYQf8oSJ5vErw82
    b+OgEiVqzo1DWtaMb2jaGVKiBO043L0o6b6/WEqCpSNT5uxygL+lCBuSBmF8TSlnpJvug7
    gnEAMX69fdyE/CFXsPnghX2xdBku4lTcYjZOkdri9akoPVZDfKEK+RP1AzIUUxjJONp+NJ
    UhjmQRA0AZlKnsZ6Uwo/qjF64qjGx4U20f+2SLQPQfqFghMlM+PUb67C75Sv4ortwMv4/7
    mS6WAtW83fEJG+Q8yFZYlsmJ1DCGZpQT2BYnS3g9RoZkNdHeAWZMDTzJxA3A
X-ME-Proxy: <xmx:ohY8as9pwMDkrR5-awNrAO6nZVYBK0QqIgvjCgaCs-7kEUTVg3dSvg>
    <xmx:ohY8agJVZ0xpKA5QHPoVd3ddcaM1w0VvmGphRaHcv_r9khbJp6MTdw>
    <xmx:ohY8algRIgBGb-aRDmecorb6Ua-bDizeQh4VLUmWMgugU9JxHmiaVQ>
    <xmx:ohY8ag5ZYxJJAtG4eHyC_tWL2IkvGZXHmDmrSWPVjYeKm5myTsD5vQ>
    <xmx:ohY8atYRSvZkh9p2ONdga1hvW-li4r4npKb0ySkftf892mAZJjtHsDKG>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6C58DB6006F; Wed, 24 Jun 2026 13:40:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3DnrUNbOo8B
Date: Wed, 24 Jun 2026 13:40:29 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: Shuangpeng <shuangpeng.kernel@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <cfbe2028-c317-4d43-bc87-6004224be128@app.fastmail.com>
In-Reply-To: <4EB31731-B511-44E6-9019-760EED0A2BD1@gmail.com>
References: <4EB31731-B511-44E6-9019-760EED0A2BD1@gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free in xprt_put
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shuangpeng.kernel@gmail.com,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shuangpengkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22806-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30D276C0698

Hi Shuangpeng,

On Sat, Jun 6, 2026, at 10:16 PM, Shuangpeng wrote:
> Hi Kernel Maintainers,
>
> I hit the following KASAN report while testing current upstream kernel:
>
> KASAN: slab-use-after-free in xprt_put
>
> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
>
> To help trigger the bug more reliably, we applied a minimal diagnostic=
 patch
> that only adds delays and print statements.
>
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/98a27c1e3c0dc5489f117efa7c254593
>
> I=E2=80=99m happy to test debug patches or provide additional informat=
ion.
>
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

There have been a handful of fixes in this area that were just merged
upstream. Any chance you can check if the problem is still there with
Linus's current tree (or with -rc1 when it releases after the weekend)?

Thanks,
Anna

>
>
> [  170.638952][   T24]=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  170.641053][   T24] BUG: KASAN: slab-use-after-free in xprt_put=20
> (./include/linux/instrumented.h:112=20
> ./include/linux/atomic/atomic-instrumented.h:400=20
> ./include/linux/refcount.h:389 ./include/linux/refcount.h:432=20
> ./include/linux/refcount.h:450 ./include/linux/kref.h:64=20
> net/sunrpc/xprt.c:2195)
> [  170.643027][   T24] Write of size 4 at addr ffff8881092e1000 by tas=
k=20
> kworker/1:0/24
> [  170.645020][   T24]
> [  170.645344][   T24] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX =
+=20
> PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  170.645349][   T24] Workqueue: events rpc_free_client_work
> [  170.645375][   T24] Call Trace:
> [  170.645390][   T24]  <TASK>
> [  170.645394][   T24]  dump_stack_lvl (lib/dump_stack.c:94=20
> lib/dump_stack.c:120)
> [  170.645451][   T24]  print_report (mm/kasan/report.c:378=20
> mm/kasan/report.c:482)
> [  170.645514][   T24]  kasan_report (mm/kasan/report.c:595)
> [  170.645525][   T24]  kasan_check_range (mm/kasan/generic.c:?=20
> mm/kasan/generic.c:200)
> [  170.645530][   T24]  xprt_put (./include/linux/instrumented.h:112=20
> ./include/linux/atomic/atomic-instrumented.h:400=20
> ./include/linux/refcount.h:389 ./include/linux/refcount.h:432=20
> ./include/linux/refcount.h:450 ./include/linux/kref.h:64=20
> net/sunrpc/xprt.c:2195)
> [  170.645535][   T24]  rpc_free_client_work (net/sunrpc/clnt.c:991)
> [  170.645541][   T24]  process_scheduled_works=20
> (kernel/workqueue.c:3314 kernel/workqueue.c:3397)
> [  170.645557][   T24]  worker_thread (kernel/workqueue.c:3478)
> [  170.645577][   T24]  kthread (kernel/kthread.c:436)
> [  170.645590][   T24]  ret_from_fork (arch/x86/kernel/process.c:158)
> [  170.645624][   T24]  ret_from_fork_asm=20
> (arch/x86/entry/entry_64.S:245)
> [  170.645631][   T24]  </TASK>
> [  170.645633][   T24]
> [  170.657540][   T24] Freed by task 0 on cpu 1 at 165.626544s:
> [  170.657945][   T24]  kasan_save_track (mm/kasan/common.c:57=20
> mm/kasan/common.c:78)
> [  170.658274][   T24]  kasan_save_free_info (mm/kasan/generic.c:584)
> [  170.658632][   T24]  __kasan_slab_free (mm/kasan/common.c:253=20
> mm/kasan/common.c:285)
> [  170.658965][   T24]  __rcu_free_sheaf_prepare=20
> (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:2940)
> [  170.659363][   T24]  rcu_free_sheaf (mm/slub.c:5850)
> [  170.659693][   T24]  rcu_core (kernel/rcu/tree.c:2617=20
> kernel/rcu/tree.c:2869)
> [  170.659997][   T24]  handle_softirqs (kernel/softirq.c:622)
> [  170.660335][   T24]  __irq_exit_rcu (kernel/softirq.c:656=20
> kernel/softirq.c:496 kernel/softirq.c:735)
> [  170.660657][   T24]  sysvec_apic_timer_interrupt=20
> (arch/x86/kernel/apic/apic.c:1061 arch/x86/kernel/apic/apic.c:1061)
> [  170.661058][   T24]  asm_sysvec_apic_timer_interrupt=20
> (./arch/x86/include/asm/idtentry.h:697)
> [  170.661480][   T24]
> [  170.661645][   T24] The buggy address belongs to the object at=20
> ffff8881092e1000
> [  170.661645][   T24]  which belongs to the cache kmalloc-2k of size=20
> 2048
> [  170.662610][   T24] The buggy address is located 0 bytes inside of
> [  170.662610][   T24]  freed 2048-byte region [ffff8881092e1000,=20
> ffff8881092e1800)
>
> Best,
> Shuangpeng

