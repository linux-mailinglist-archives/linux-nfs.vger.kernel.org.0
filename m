Return-Path: <linux-nfs+bounces-18489-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAyLNPG2d2nKkQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18489-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:48:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 118BE8C335
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01D12301ECC7
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 18:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114021B185;
	Mon, 26 Jan 2026 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="d4Z9krWN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C423909C
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453243; cv=pass; b=J+TXaG4m4bKhkvWQcMf0ne5Hz5fBqYaNTqOJb6zW4HZBd4fQx25EGtklhh/iSYmQ3TzU0lTLp9S5ZWdxl/RXtxKuP2OtecwligLtWZRGKQhpe9X6XTup6MN9QmUnYSVWaXU/qsZWnLBpyjIGdYo24mMlBEG1j4wF8F0e5TBhc1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453243; c=relaxed/simple;
	bh=IZHjI7M9SjsJijYHozwPswNP24maYSofnn5wMM7tBSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poIZVKAgsglRabs4vujbgC8gBFltL0WYxuugai+RFui4ajJGxo8MzZn0zA6tDKA4+eLun2miE+pyHDWWEs5rhB3eD1T54kwZx0acViAUDQn48kCFoI+KlHgPCbJ5hZmkWbnRYDc/QyfMX1hnYMPcAxpJ6qJPbA/zp1GG6bAQjwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=d4Z9krWN; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b872f1c31f1so665258266b.0
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 10:47:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769453240; cv=none;
        d=google.com; s=arc-20240605;
        b=c/KbrCMJJlvos3hyk/ABmQnfnNLiW5yYhgx9mrka2uJrCcbK3vTky/MPySAjVqk7JY
         LYHbIRi8CG5ZmkC/s0NBOAHoSl+mCE1Yyw0RbAT074SNdnvX+fygw7ZkQ5P7mFIFfZM4
         3NGCMg3/ZiuQyswHhKt5jNNXMXLPxWidKe4EmWptBLfuiIiagtzffLim5tAkGjX+viHH
         lHNvoDrFHo9WbWVIk6Ajl9tNQtScc2SlWPrNZEVMz9+lVc6gxBb9nX5OsNUwfcoXa9rA
         fe2upnZAtqHx6W2wa0xH4yjgUgC+Tu2t9y6fstd/n6eXfTv9aZXr3KwCnMH9hHQgMfDb
         0PCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jluY+QdZPsnvUGNuYyY0FkLRLXhcHj70xPTyOqWZtAc=;
        fh=fHHF/Ols5kY+nXCl9h0bqkW/1GiNipAqlLa1h6uk2iA=;
        b=d7vyvEAUQM99heDJbanOwclkGW+nVYFsXWo7LrmSnva3D6Qlib7GPT8C/mUHO0Fla3
         XxvwfUo7g8c6Eqcd1ZvEncsmZNqFDwzi2ifIYEQICSlyMQDzgLthB/1GXGGqXSF0mGGi
         z7GnQtZ5+iE9hBGxu5ROlqjGKbZ9jSamRVoO5zPIL2VRLl8/j6SHujaDg33k6O7ktxaQ
         3NS+5pU94hECjgT/unglR/8FYE8ltc7NWXOrvDbESPTGIRCsytBPz4gyXY2a2mB5U6RI
         uNgeucspw30CKuRVoWrPkHD9CDJBI3y17f/TinoLHee3EPoDyAp/UbpXwc4GPsgSnalP
         yS6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1769453240; x=1770058040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jluY+QdZPsnvUGNuYyY0FkLRLXhcHj70xPTyOqWZtAc=;
        b=d4Z9krWNmJ1X0Ns2jxGG9V30IiFlx2iK0ns8lLuNWxN8zds3Cmjznh5cSCitNtdawg
         4i3uYH8NxZ1k+0jsJcvf4/kVj2Z59+7eR6zGUmf8gRUy/e7F0sHTjPP0GNj/av+KN5gK
         3lKEkZX3maB1VotBdrkW9rDDd7IeV0H+nOzl6xX+ZAtLCHOcEVplsEI3dmphZRYiB3uJ
         /3hBW18VlvyTcWalBd6ph5ypH+eJam2upkf77GHpOPGeIs4d1+TamEMy3Ir/Or56CcYH
         2fBMQVoPw4KrXzuqviXhUlN1BWT9fbZO1Ab9AE37ueMIWYkbTOuKRz9tBSv9/x1tEXIE
         m8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769453240; x=1770058040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jluY+QdZPsnvUGNuYyY0FkLRLXhcHj70xPTyOqWZtAc=;
        b=kUmbf6+4F27Z1jhMtClmE0wkOu5TucnZddsNIGu1wonMAeE7p7oaLuxy43yJw5Bbxj
         Iyb1EPBy4qSPZZA76Wpmx8cfVYjQF7TY11JY/dzFKWSPWU4AB9aG4CyweRXGnN+NCgSf
         7eLwyUGlZUbTLum3Y2w8U1VUgC29x54Eb5VUJgQewD9MVukhii9p73FejB9N3phiJnV7
         UaOnzbqughzq+FwecPUFOHEOWOC7KxiDU3VqnQWpJUnNV5UCSeDGmN/qPzTnMWRl2ulG
         fC9JmcufIzxmcKONEBxWsgWU7Z6GSQXl2JpzN9sscSPegFo3+HXTZWgS83KQYwZobiYu
         UMfg==
X-Gm-Message-State: AOJu0YwKGJuQIpWs+VNYLuxaLrUQC8zgsXoV8vbXMJSNdUzLNtXDKKSN
	goRBUIUD1YO+x5FULT/ynMJK+75MmSle3d4fNzWKeWD5Opm3358c0Ul/HdcUNAuuv8Mb1/hDMW/
	xO5d/oT2u7r9AgY7VQgtGt/lcxvHNsLv2dx60lnGqjXI5TXyxvsiipYlYnFcG
X-Gm-Gg: AZuq6aIrTIpZ8jmNwsDCxp1ZX/6QYM5yKyjVeP1tWYXYFTOIKLPqmnL3F3OdtMPEgLE
	v9rNUVCsrvMnTeZ2qA1aeGU0Za/+p5ACyPH4ttOTBFhXbvXq5Upzn3sZwqTVZQHYy0MFGivCQvM
	m5le3AbTtUTMRGP7yT8ARwJRI7foi+utSaF1VTdWO8DDff3HcTEkmDswITg7IEOv90g5OiH1pG/
	sz1JTXTFjSW7wwMYu5GdIvM79vLDoRq243W5uIWkNFPCSsWs9er0L4jAzq87Vplkrfr2A==
X-Received: by 2002:a17:907:9686:b0:b87:1839:2600 with SMTP id
 a640c23a62f3a-b8d20e2938fmr383258166b.33.1769453239866; Mon, 26 Jan 2026
 10:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPt2mGNAGaO8hP9u4M+oH0_w0dbSNAmDF=g0jyb26ED5R_mhOA@mail.gmail.com>
 <a1b6c46f-e49d-4ae6-ae5e-3c08ed40e359@app.fastmail.com> <CAPt2mGNL4neF1NX7_1=9svnNz_iXhadHw0AEjZ_B-50-vwNtUg@mail.gmail.com>
 <723418cf-cec6-4afc-906e-b93a55e85fc9@app.fastmail.com>
In-Reply-To: <723418cf-cec6-4afc-906e-b93a55e85fc9@app.fastmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Mon, 26 Jan 2026 18:46:43 +0000
X-Gm-Features: AZwV_QitG9U95zMPuu0EeI3lKkMjvzT3pA4gMO7dxpWtQ9ELKVieXU_dt7gvhlE
Message-ID: <CAPt2mGNkGbWujzTzxoTGTvAWoOL9aUUhN93SEJQYJTQyV4xu7Q@mail.gmail.com>
Subject: Re: knfsd read iops limits?
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[dneg.com,quarantine];
	R_DKIM_ALLOW(-0.20)[dneg.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-18489-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daire@dneg.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[dneg.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 118BE8C335
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 at 16:31, Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Sun, Jan 25, 2026, at 6:45 PM, Daire Byrne wrote:
> > On Sun, 25 Jan 2026 at 16:19, Chuck Lever <cel@kernel.org> wrote:
> >>
> >>
> >>
> >> On Sun, Jan 25, 2026, at 7:26 AM, Daire Byrne wrote:
> >> > Hi,
> >> >
> >> > We recently came across a workload that consisted of 100s of clients
> >> > under (cgroup) memory pressure and so their page cache was all but
> >> > exhausted. This resulted in lots of repeat small 4k-8k random reads
> >> > hitting our NFS servers which maxed out their CPUs and flatlined
> >> > performance.
> >> >
> >> > Uniquely, the data being read easily fit in the server's page cache so
> >> > there was no backend IO to limit throughput.
> >> >
> >> > The fix was to put in place a system to kill workloads under such
> >> > memory pressure. But it piqued my curiosity, so I decided to do some
> >> > simple benchmarks to see where the server limits are.
> >> >
> >> > I ran something like this across 200 client hosts simultaneously using
> >> > NFSv3 to reproduce:
> >> >
> >> >  fio --directory /hosts/nfs1/xfs1/ --name test-file --direct=0
> >> > --buffered=1 --size=1g --time_based --runtime=600s --bs=4096
> >> > --rw=randread --numjobs=2
> >> >
> >> > By reading the same small file from many hosts, we are essentially
> >> > serving from server page cache so can rule out disk IO (I even tried
> >> > files on /dev/shm)
> >> >
> >> > The main things I found:
> >> > * across a wide range of server hardware, we top out around 300k-400k
> >> > read iops/s.
> >> > * whether the server has 24/48/96 cores, the results were pretty much the same.
> >> > * 24 knfsd threads is the optimal with more threads reducing
> >> > performance until threads=ncores
> >> > * multiple nics (bonded) or single socket (no numa) makes little or no
> >> > difference
> >> > * different nic hardware make little difference (2x100g, 4x25g,
> >> > broadcom, mellanox etc).
> >> > * various network tuning (queues, txqueuelen, qdisc, etc) makes little
> >> > difference.
> >> > * NFSv4.2 has less read iops/s (160k/s) but it also has sequence &
> >> > pufh ops too (+ 2x160k/s).
> >> > * increasing nconnect (>1) reduces aggregate read iops performance (8 -> 120k/s)
> >> >
> >> > It feels like there is some thread locking contention limitation such
> >> > that the number of CPUs and/or knfsd threads reaches some plateau and
> >> > throwing more cores/threads at the workload just results in more CPU
> >> > time spent spinning but you get no more performance out.
> >> >
> >> > The top level perf report looks something like the attached (for v6.18).
> >> >
> >> > Like I said, we can work around this pretty rare workload (random
> >> > small reads from server page cache), but it just piqued my interest as
> >> > to what the underlying (knfsd) server limit is (it doesn't seem to be
> >> > hardware).
> >>
> >> At risk of being glib, the performance data suggests your workload is
> >> tickling one or more contended spin locks. To collect more information
> >> about the contended spin locks, see
> >>
> >>   Documentation/locking/lockstat.rst
> >
> > Yea, good idea. I ran a quick test (200 NFSv3 clients, 4k randread)
> > and attached the resulting top locks (abbreviated).
> >
> > Again, this is for the latest v6.18 kernel. A couple of expensive
> > looking locks, but the xpt_mutex/svc_tcp_sendto seems to have the
> > highest overall cost?
>
> There's kind of no denying it, the xpt_mutex numbers are shitty.
> The maximum hold time on that mutex is 293379.40 usecs, with a
> mean hold time of nearly 16 usec, giving it the worst mean wait
> time by an order of magnitude. And it's not even a contended lock.
>
> It's probably not easy for you to bisect, is it...

I can certainly bisect through some generations of kernel, but I'm not
sure there has ever been a "good" one when it comes to this extreme
(niche) workload (4k read iops).

We have a few generations of hardware and OS versions like RHEL8
(4.18), RHEL9 (5.14) and mainline (v6.18) in production, but I see
similar performance plateaus for this workload in all cases (~300k
iops/s).

But it could well be that they are all limited for different reasons
(lock contentions). I distinctly remember seeing high
nfsd_file_lru_remove & nfsd_file_put (perf lock record) contention on
the RHEL9 (5.14) kernel which I don't see now on mainline.

I'm happy to record the lockstat report for this workload across a few
different kernel versions if that is of interest to anyone.

Daire

> > I do remember seeing a lot of contention around the file cache in
> > older kernels but I think lots of improvements were made to that circa
> > v6.0.
> >
> > If I do a "local" 4k random read fio on the server to /dev/shm with
> > 200 workers, you get silly numbers like 2 million iops/s. I don't know
> > if that is a particularly valid test of just the backend storage
> > contention (when reading completely from page cache).
> >
> > Daire
> >
> > Attachments:
> > * lockstat.txt
>
> --
> Chuck Lever

