Return-Path: <linux-nfs+bounces-10980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F6BA7836F
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 22:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73A47A2997
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0991D204C3F;
	Tue,  1 Apr 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4Xoxw8H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456D1DBB2E
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540255; cv=none; b=c2OJlx5CO7xYblCaIh2fvFMYUXVy8fd/1JO2L1uS9izVS+npjIGZxrWs0fYMbVJSOawnQSZzXipTeEznTxtAaT5qpyIyCAIT7osAnjj7Pk0yvpZx5NGA7UA2ALQ8+Vtj8vRK/LAfNtob5ICJQEJl1N8SEI22doH49tqvPtA7KLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540255; c=relaxed/simple;
	bh=YwJJiZiaswv6PNMXHWEmCy9oEkFgAID7KD+OA+K9Sy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kU8CVpj7KAY+e+f4ekkGYEQs2WfiNYuyjQx1++qSipccqjHRo/r4CBYlpVF/d2qChIEQuPphonOK1Av65iDZbS1g6vj1GEpqpzz3x//DkR/AsFAbnhpeAEaLh0mQd6LD0wla6L0qQLg5G2BSicL2cX6WUn3BWzynAJLP2Xfq1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4Xoxw8H; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso9504099a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 01 Apr 2025 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743540252; x=1744145052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o08cwUPKURl79MOO27l+yFqUkA3MVoVqrdPYzQIyUo=;
        b=R4Xoxw8H9sZGj5BC33A2KWBAJ9DCaclXSyQWtjaUNfAgC4VNhcYbVCktE0wkE6G3Gu
         c9IgJblyf4/wEoXTXdCdfI+WBuxSOmUZ8C5xpC+EiKQPAgM4CEOM8I+vOrXK5wvw8GIp
         kyCdY4HvNy3G8V90bhODlhFYljn3Rl/cdDQLKrzxysed9WhjnCV22nbUsh/s63EHCNue
         e4cF8VnVmR9oMD/hMOeDf2ohYjHV4AZM9007ja73ZfyPJrHBfgrXGlEVCbvlYRai/o1j
         5k6Hs8XKGmYtHy1OoagqaGxJ/6sovn0jKccO+vaLr2aQXL0rPXqTlfzxDY+zI4RkIwoJ
         y50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540252; x=1744145052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o08cwUPKURl79MOO27l+yFqUkA3MVoVqrdPYzQIyUo=;
        b=CU3horeBKEF7GaI1HV41aSMjm3li5aOuqHH7LqZ0CZKDDrda3WoeEEFLsGlT+jkf4X
         BV+4keJPPIE7SqoSVAZTSmK+8cY6/+Oe4qMYpBgmnayU6uJDGbTB0vxeTXWEndCts1vO
         EVWFMAB4R2rmyIEPUKSKHf58HE1k0RxfgYGm6331sBl7ysdq5j7q0+UtuiU/xfcH9pZJ
         SHXKyxfLmNAxTXOD0RBtN15miI5u20UXbXEXW1PvtUptY+CxvH6O4osbY8litYPwxHku
         nIZTV4Yi98vuCRHG43QFroiWuEft7uQW8gcsZyObZsB1U112NebKhK9MIPcmebKWBx/h
         lzbg==
X-Gm-Message-State: AOJu0Yy+Tctn5wGFkSi24CPnSlpgtl7yYlY80GwIAp8sQjZKvRVxMD55
	z3bi6Ym3CIacugG6JIjbu4Nhu287vciD0WEjTz91xzILOZ0NdFTgbMi9rjipE3yhbCYfiHAT9l8
	+GEAhJOAvGQlAdBXIGQW2Ztmum8o=
X-Gm-Gg: ASbGncurCM5XrMrW9UCe6/g6+0lJGSdaPOqMJX9ckAHconym7zcSIEvriw1fTaoFbJz
	2286o1gCtrq/hFFBuX6UH2yxbLp26k3UYlXjpxX+QbLteEXTyjSI9csxWAXxs/BQQvz6YgJdqSW
	OjPM05+0n9wyqJXr9KYmJPzARMolzOPHhm/YXmlg4d
X-Google-Smtp-Source: AGHT+IFZ3vDKfqYFeqkW+L3WitrmVCiANf6CjE0w5FK7PrCTzjnLSSoG0Wx+WnxQAbG0U+Y4gQ9+n2JtRafkPrUhvjg=
X-Received: by 2002:a05:6402:84f:b0:5e8:bced:9ee5 with SMTP id
 4fb4d7f45d1cf-5edfd1229f5mr10788631a12.18.1743540251896; Tue, 01 Apr 2025
 13:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPwv0JktC7Kb4cibSbioNAAZ9FeWs6aHeLRXDk_6MKUik1j3mg@mail.gmail.com>
 <Z-wk-sJXi0dzttM_@kernel.org> <CAPwv0J=m9N6oBy+_Y-cVeBaT5_feqsc36+sb=ECrXezFXO68wA@mail.gmail.com>
 <CAPwv0J=rYJJEzrXOcVtMVDc7xNeEbSPdWVis_nAGinPc=fd6ng@mail.gmail.com>
In-Reply-To: <CAPwv0J=rYJJEzrXOcVtMVDc7xNeEbSPdWVis_nAGinPc=fd6ng@mail.gmail.com>
From: Rik Theys <rik.theys@gmail.com>
Date: Tue, 1 Apr 2025 22:43:59 +0200
X-Gm-Features: AQ5f1JpNIrY7WUSSiGyWsmBcRmhjoUI3KasqHEcexx5C2__qAT90D6XAeJZP8xs
Message-ID: <CAPwv0JmRGT9b4LeubKABWOsc97U0i6_kJyMAJQ2K7qoexSB=zA@mail.gmail.com>
Subject: Re: Memory reclaim and high nfsd usage
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 1, 2025 at 10:07=E2=80=AFPM Rik Theys <rik.theys@gmail.com> wro=
te:
>
> Hi,
>
> On Tue, Apr 1, 2025 at 9:31=E2=80=AFPM Rik Theys <rik.theys@gmail.com> wr=
ote:
> >
> > Hi,
> >
> > On Tue, Apr 1, 2025 at 7:40=E2=80=AFPM Mike Snitzer <snitzer@kernel.org=
> wrote:
> > >
> > > On Mon, Mar 31, 2025 at 09:05:54PM +0200, Rik Theys wrote:
> > > > Hi,
> > > >
> > > > Our fileserver is currently running 6.12.13 with the following 3
> > > > patches (from nfsd-testing) applied to it:
> > > >
> > > > - fix-decoding-in-nfs4_xdr_dec_cb_getattr
> > > > - skip-sending-CB_RECALL_ANY
> > > > - fix-cb_getattr_status-fix
> > > >
> > > > Frequently the load on the system goes up and top shows a lot of
> > > > kswapd and kcompact threads next to nfsd threads. During these peri=
od
> > > > (which can last for hours), users complain about very slow NFS acce=
ss.
> > > > We have approx 260 systems connecting to this server and the number=
 of
> > > > nfs client states (from the states files in the clients directory) =
are
> > > > around 200000.
> > >
> > > Are any of these clients connecting to a server from the same host?
> > > Only reason I ask is I fixed a recursion deadlock that manifested in
> > > testing when memory was very low and LOCALIO used to loopback mount o=
n
> > > the same host.  See:
> > >
> > > ce6d9c1c2b5cc785 ("NFS: fix nfs_release_folio() to not deadlock via k=
compactd writeback")
> > > https://git.kernel.org/linus/ce6d9c1c2b5cc785
> > >
> > > (I suspect you aren't using NFS loopback mounts at all otherwise your
> > > report would indicate breadcrumbs like I mentioned in my commit,
> > > e.g. "task kcompactd0:58 blocked for more than 4435 seconds").
> >
> > Normally the server does not NFS mount itself. We also don't have any
> > "blocked task" messages reported in dmesg.
> >
> > >
> > > > When I look at our monitoring logs, the system has frequent direct
> > > > reclaim stalls (allocstall_movable, and some allocstall_normal) and
> > > > pgscan_kswapd goes up to ~10000000. The kswapd_low_wmark_hit_quickl=
y
> > > > is about 50. So it seems the system is out of memory and is constan=
tly
> > > > trying to free pages? If I understand it correctly the system hits =
a
> > > > threshold which makes it scan for pages to free, frees some pages a=
nd
> > > > when it stops it very quickly hits the low watermark again?
> > > >
> > > > But the system has over 150G of memory dedicated to cache, and
> > > > slab_reclaim is only about 16G. Why is the system not dropping more
> > > > caches to free memory instead of constantly looking to free memory?=
 Is
> > > > there a tunable that we can set so the system will prefer to drop
> > > > caches and increase memory usage for other nfsd related things? Any
> > > > tips on how to debug where the memory pressure is coming from, or w=
hy
> > > > the system decides to keep the pages used for cache instead of free=
ing
> > > > some of those?

Could this be related to
https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/commit/?h=3Dlinux-6.12.y&id=3De21ce310556ec40b5b2987e02d12ca7109a33a61:

mm: fix error handling in __filemap_get_folio() with FGP_NOWAIT
commit 182db972c9568dc530b2f586a2f82dfd039d9f2a upstream.

This is fixed in a later 6.12.x kernel, but we're still running
6.12.13 currently.

Regards,
Rik

> >
> > The issue is currently not happening, but I've looked at some of our
> > sar statistics from today:
> >
> > # sar -B
> > 04:00:00 PM  pgpgin/s pgpgout/s   fault/s  majflt/s  pgfree/s
> > pgscank/s pgscand/s pgsteal/s    %vmeff
> > 04:00:00 PM   6570.43  37504.61   1937.60      0.20 337274.24
> > 10817339.49      0.00  10623.60      0.10
> > 04:10:03 PM   6266.09  28821.33   4392.91      0.65 266336.28
> > 8464619.82      0.00   7756.98      0.09
> > 04:20:05 PM   6894.44  33790.76  12713.86      1.86 271167.36
> > 9689653.88      0.00   8123.21      0.08
> > 04:30:03 PM   6839.52  24451.70   1693.22      0.76 237536.27
> > 9268350.05     11.73   5339.54      0.06
> > 04:40:05 PM   6197.73  28958.02   4260.95      0.33 306245.10
> > 9797882.50      0.00   7892.46      0.08
> > 04:50:02 PM   4252.11  31658.28   1849.64      0.58 297727.92
> > 6885422.57      0.00   7541.08      0.11
> >
> > # sar -r
> > 04:00:00 PM kbmemfree   kbavail kbmemused  %memused kbbuffers
> > kbcached  kbcommit   %commit  kbactive   kbinact   kbdirty
> > 04:00:00 PM   3942896 180501232   2652336      1.35  29594476
> > 138477148   3949924      1.50  48038428 120797592     13324
> > 04:10:03 PM   4062416 180601484   2564852      1.31  29574180
> > 138589324   3974652      1.51  47664880 121277920    157472
> > 04:20:05 PM   4131172 180150888   3013128      1.54  29669384
> > 138076684   3969232      1.51  47325688 121184212      4448
> > 04:30:03 PM   4112388 180835756   2344936      1.20  30338956
> > 138145972   3883420      1.48  49014976 120205032      5072
> > 04:40:05 PM   3892332 179390408   3428992      1.75  30559972
> > 137103196   3852380      1.46  48939020 119461684    306336
> > 04:50:02 PM   4328220 180002072   3197120      1.63  30873116
> > 136567640   3891224      1.48  49335740 118841092      3412
> >
> > # sar -W
> > 04:00:00 PM  pswpin/s pswpout/s
> > 04:00:00 PM      0.09      0.29
> > 04:10:03 PM      0.33      0.60
> > 04:20:05 PM      0.20      0.38
> > 04:30:03 PM      0.69      0.33
> > 04:40:05 PM      0.36      0.72
> > 04:50:02 PM      0.30      0.46
> >
> > If I read this correctly, the systems is scanning scanning for free
> > pages (pgscand) and freeing some of them (pgfree), but the efficiency
> > is low (%vmeff).
> > At the same time, the amount of memory used (kbmemused / %memused) is
> > quite low as most of the memory is used as cache. There's approx 120G
> > of inactive memory.
> > So I'm at loss as to why the system is performing these page scans and
> > stalling instead of dropping some of the cache and using that instead.
> >
> > >
> > > All good questions, to which I don't have immediate answers (but
> > > others may).
> > >
> > > Just FYI: there is a slow-start development TODO to leverage 6.14's
> > > "DONTCACHE" support (particularly in nfsd, but client might benefit
> > > some too) to avoid nfsd writeback stalls due to memory being
> > > fragmented and reclaim having to work too hard (in concert with
> > > kcompactd) to find adequate pages.
> > >
> > > > I've ran a perf record for 10s and the top 4 of the events seem to =
be:
> > > >
> > > > 1. 54% is swapper in intel_idle_ibrs
> > > > 2. 12% is swapper in intel_idle
> > > > 3. 7.43% is nfsd in native_queued_spin_lock_slowpath:
> > > > 4. 5% is kswapd0 in __list_del_entry_valid_or_report
> > >
> > > 10s is pretty short... might consider a longer sample and then use th=
e
> > > perf.data to generate a flamegraph, e.g.:
> > >
> > > - Download Flamegraph project: git clone https://github.com/brendangr=
egg/FlameGraph
> > >   you will likely need to install some missing deps, e.g.:
> > >   yum install perl-open.noarch
> > > - export FLAME=3D/root/git/FlameGraph
> > > - perf record -F 99 -a -g sleep 120
> > >   - this will generate a perf.data output file.
> > >
> > > Once you have perf.data output, generate a flamegraph file (named
> > > perf.svg) using these 2 commands:
> > > perf script | $FLAME/stackcollapse-perf.pl > out.perf-folded
> > > $FLAME/flamegraph.pl out.perf-folded > perf.svg
> > >
> > > Open the perf.svg image with your favorite image viewer (a web browse=
r
> > > works well).
> > >
> > > I just find flamegraph way more useful than 'perf report' ranked
> > > ordering.
> >
> > That's a very good idea, thanks. I will try that when the issue returns=
.
>
> The kswapd process started to consume some cpu again, so I've followed
> this procedure. See the file in attach.
>
> Does this show some sort of locking contention?
>
> Regards,
> Rik
>
> >
> > >
> > > > Are there any know memory management changes related to NFS that ha=
ve
> > > > been introduced that could explain this behavior? What steps can I
> > > > take to debug the root cause of this? Looking at iftop there isn't
> > > > much going on regarding throughput. The top 3 NFS4 server operation=
s
> > > > are sequence 9563/s), putfh(9032/s) and getattr (7150/s).
> > >
> > > You'd likely do well to expand the audience to include MM too (now cc=
'd).
> >
> > Thanks. All ideas on how I can determine the root cause of this is appr=
eciated.
> >
> >
> > Regards,
> > Rik
>
>
>
> --
>
> Rik



--=20

Rik

