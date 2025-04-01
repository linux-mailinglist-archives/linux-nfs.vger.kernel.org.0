Return-Path: <linux-nfs+bounces-10978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A3A782C9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B846A7A2F67
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124D720F07E;
	Tue,  1 Apr 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKxBDv+A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F801E5B81
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743535882; cv=none; b=uB7FBR0S4C6+nTlXDXA7X1YEfaSyWo/9kaUnDBGx3Uz2YNVwH7ecLhA0MAm6l7z/p/67nH+7FDh+B7nM68bosGfi0RPwj8Qy0JIRLaPriRs+B6e6ei90DUB4N9/mNyowiRCRdLt1AAI5+nw48+75ZRt8meAqmwQCnjXyNY2D7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743535882; c=relaxed/simple;
	bh=IVCvYASVxlplUxW3XU9Ser9QTotiAn0KYxL4hUvT6uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3t6aaG4i5Gs4IMtqMIaBqatD4Gnrr0lSe7wHzEkk2stlUlQPlrkwe0u2lihe9tV36vZTWAAnjCzNkTzCEOEdTBTt0GQfl75mMfWcmpHUflCGP9YowXWwIBiqNDjb9Ri8luhgdlb3B9cs+klaNWbUOU0FOF/WwUPQla+oAo760g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKxBDv+A; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so9009484a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 01 Apr 2025 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743535877; x=1744140677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXgft1fVIw9RAeoX9J4VlgHHT88tq6S/UKtUqiODGTo=;
        b=RKxBDv+AD3xzbb5Gvnsrsi8SQ+ynzTfQrxB+vVUzq2iBY+RQjTAlRYeNjSqk8ad3Y9
         RkOtAGEkKumxe5VM3VzDBSxQDSFpiSO/imPHPNawScRV+y2Mi8k/7sekER3/oPwm/EgN
         MclYOucqLWJKCC8xll/idu003v6ZtFZd3Kv/CALhZ0MHPLiA0N8I2Vup205swH1OFytC
         3iYO3V6/5res3+ornuSdw7Mbl5IJlzCefJADdZeVg62q5SdYfMBT9V8KFlbyOM6llpCa
         B/BAr/0J3WjLV54g/PgGV6A1TNWBbeTQjjAhs8yJoNKrOgrUQyswWNUHBK2yDgHivypm
         YXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743535877; x=1744140677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXgft1fVIw9RAeoX9J4VlgHHT88tq6S/UKtUqiODGTo=;
        b=R+HRefqYAyH7nQ5UaFuno+27Y/DEKO7QbCCBgeJZQRogmDQ639VbAEIu3UCxQFKLYF
         c+4Fg89DEuIXC+c4WmhqWT7cGu7Q3+gKyp7abpUn6x0OYdcdoMDyUmrVbczDMvmN2Ni2
         PZQP/pcl1L3VaGgjnhh/JlLqXF93ZPz2Zp6r9pl+Z4LAicpWxZ0pTIuFPNr7r5a2HBNZ
         RfCBdFZLsovBHdyxz1lUgHDxeb8CiZ67yjIKHHmkilKRLUnnEnliD8SAkl9nXhi2NmRU
         63t/58gMDhF7/NNdxsPxQbfrP5VZdeINpDaLuPsz8tVBV1JYol2SnkLwfXjohimfgzO/
         A1Tg==
X-Gm-Message-State: AOJu0YwfzwDsCLYZsB9Of+WrnMw2iM7qz/JGOP6qGVIBDY5fWfd9tauF
	/X61DELiIGSdt52Fq8EyuOiCWFkLit6N0jF7NBnG/DCzSOLiBM5r0niqTkiQRZUvUSg4mZovaqt
	ABLfRK/iQHG2aYnHi2vb7ek+Nfg4=
X-Gm-Gg: ASbGncsBAQ8f2YZbufGWrOzo7EomH1RnSmIW4Kz4J9HpKi/qgjFPZyCCkIUy/XMK/Jj
	mMP4WUH8PqHgzz06bdgCWoxTEPaT+kekfCpx8iAUtRiAx8wTnsWJD0oQiYSa9096iQHjXJqxNaN
	H2ag1rJrM5Oio5OsD8ubgKTOudn0LjBYen/80wFS5Jg4a+8x+hxe8=
X-Google-Smtp-Source: AGHT+IGvoDiSgP0oO5xruCzn2Jro6mS+CFnedqFIpGuTIlXCKYzcWE2ST0N+F9LNrAxub3SKeP2/vcXekXnpFD2EtZk=
X-Received: by 2002:a05:6402:40cc:b0:5ed:1444:7914 with SMTP id
 4fb4d7f45d1cf-5edfdd23b76mr13732314a12.28.1743535877000; Tue, 01 Apr 2025
 12:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPwv0JktC7Kb4cibSbioNAAZ9FeWs6aHeLRXDk_6MKUik1j3mg@mail.gmail.com>
 <Z-wk-sJXi0dzttM_@kernel.org>
In-Reply-To: <Z-wk-sJXi0dzttM_@kernel.org>
From: Rik Theys <rik.theys@gmail.com>
Date: Tue, 1 Apr 2025 21:31:05 +0200
X-Gm-Features: AQ5f1JpLdh8BUINVWTfSTBwhslY81BBFxE2PpAZx5aNA-2W0brjNjXCT2tpVPrI
Message-ID: <CAPwv0J=m9N6oBy+_Y-cVeBaT5_feqsc36+sb=ECrXezFXO68wA@mail.gmail.com>
Subject: Re: Memory reclaim and high nfsd usage
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 1, 2025 at 7:40=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> wr=
ote:
>
> On Mon, Mar 31, 2025 at 09:05:54PM +0200, Rik Theys wrote:
> > Hi,
> >
> > Our fileserver is currently running 6.12.13 with the following 3
> > patches (from nfsd-testing) applied to it:
> >
> > - fix-decoding-in-nfs4_xdr_dec_cb_getattr
> > - skip-sending-CB_RECALL_ANY
> > - fix-cb_getattr_status-fix
> >
> > Frequently the load on the system goes up and top shows a lot of
> > kswapd and kcompact threads next to nfsd threads. During these period
> > (which can last for hours), users complain about very slow NFS access.
> > We have approx 260 systems connecting to this server and the number of
> > nfs client states (from the states files in the clients directory) are
> > around 200000.
>
> Are any of these clients connecting to a server from the same host?
> Only reason I ask is I fixed a recursion deadlock that manifested in
> testing when memory was very low and LOCALIO used to loopback mount on
> the same host.  See:
>
> ce6d9c1c2b5cc785 ("NFS: fix nfs_release_folio() to not deadlock via kcomp=
actd writeback")
> https://git.kernel.org/linus/ce6d9c1c2b5cc785
>
> (I suspect you aren't using NFS loopback mounts at all otherwise your
> report would indicate breadcrumbs like I mentioned in my commit,
> e.g. "task kcompactd0:58 blocked for more than 4435 seconds").

Normally the server does not NFS mount itself. We also don't have any
"blocked task" messages reported in dmesg.

>
> > When I look at our monitoring logs, the system has frequent direct
> > reclaim stalls (allocstall_movable, and some allocstall_normal) and
> > pgscan_kswapd goes up to ~10000000. The kswapd_low_wmark_hit_quickly
> > is about 50. So it seems the system is out of memory and is constantly
> > trying to free pages? If I understand it correctly the system hits a
> > threshold which makes it scan for pages to free, frees some pages and
> > when it stops it very quickly hits the low watermark again?
> >
> > But the system has over 150G of memory dedicated to cache, and
> > slab_reclaim is only about 16G. Why is the system not dropping more
> > caches to free memory instead of constantly looking to free memory? Is
> > there a tunable that we can set so the system will prefer to drop
> > caches and increase memory usage for other nfsd related things? Any
> > tips on how to debug where the memory pressure is coming from, or why
> > the system decides to keep the pages used for cache instead of freeing
> > some of those?

The issue is currently not happening, but I've looked at some of our
sar statistics from today:

# sar -B
04:00:00 PM  pgpgin/s pgpgout/s   fault/s  majflt/s  pgfree/s
pgscank/s pgscand/s pgsteal/s    %vmeff
04:00:00 PM   6570.43  37504.61   1937.60      0.20 337274.24
10817339.49      0.00  10623.60      0.10
04:10:03 PM   6266.09  28821.33   4392.91      0.65 266336.28
8464619.82      0.00   7756.98      0.09
04:20:05 PM   6894.44  33790.76  12713.86      1.86 271167.36
9689653.88      0.00   8123.21      0.08
04:30:03 PM   6839.52  24451.70   1693.22      0.76 237536.27
9268350.05     11.73   5339.54      0.06
04:40:05 PM   6197.73  28958.02   4260.95      0.33 306245.10
9797882.50      0.00   7892.46      0.08
04:50:02 PM   4252.11  31658.28   1849.64      0.58 297727.92
6885422.57      0.00   7541.08      0.11

# sar -r
04:00:00 PM kbmemfree   kbavail kbmemused  %memused kbbuffers
kbcached  kbcommit   %commit  kbactive   kbinact   kbdirty
04:00:00 PM   3942896 180501232   2652336      1.35  29594476
138477148   3949924      1.50  48038428 120797592     13324
04:10:03 PM   4062416 180601484   2564852      1.31  29574180
138589324   3974652      1.51  47664880 121277920    157472
04:20:05 PM   4131172 180150888   3013128      1.54  29669384
138076684   3969232      1.51  47325688 121184212      4448
04:30:03 PM   4112388 180835756   2344936      1.20  30338956
138145972   3883420      1.48  49014976 120205032      5072
04:40:05 PM   3892332 179390408   3428992      1.75  30559972
137103196   3852380      1.46  48939020 119461684    306336
04:50:02 PM   4328220 180002072   3197120      1.63  30873116
136567640   3891224      1.48  49335740 118841092      3412

# sar -W
04:00:00 PM  pswpin/s pswpout/s
04:00:00 PM      0.09      0.29
04:10:03 PM      0.33      0.60
04:20:05 PM      0.20      0.38
04:30:03 PM      0.69      0.33
04:40:05 PM      0.36      0.72
04:50:02 PM      0.30      0.46

If I read this correctly, the systems is scanning scanning for free
pages (pgscand) and freeing some of them (pgfree), but the efficiency
is low (%vmeff).
At the same time, the amount of memory used (kbmemused / %memused) is
quite low as most of the memory is used as cache. There's approx 120G
of inactive memory.
So I'm at loss as to why the system is performing these page scans and
stalling instead of dropping some of the cache and using that instead.

>
> All good questions, to which I don't have immediate answers (but
> others may).
>
> Just FYI: there is a slow-start development TODO to leverage 6.14's
> "DONTCACHE" support (particularly in nfsd, but client might benefit
> some too) to avoid nfsd writeback stalls due to memory being
> fragmented and reclaim having to work too hard (in concert with
> kcompactd) to find adequate pages.
>
> > I've ran a perf record for 10s and the top 4 of the events seem to be:
> >
> > 1. 54% is swapper in intel_idle_ibrs
> > 2. 12% is swapper in intel_idle
> > 3. 7.43% is nfsd in native_queued_spin_lock_slowpath:
> > 4. 5% is kswapd0 in __list_del_entry_valid_or_report
>
> 10s is pretty short... might consider a longer sample and then use the
> perf.data to generate a flamegraph, e.g.:
>
> - Download Flamegraph project: git clone https://github.com/brendangregg/=
FlameGraph
>   you will likely need to install some missing deps, e.g.:
>   yum install perl-open.noarch
> - export FLAME=3D/root/git/FlameGraph
> - perf record -F 99 -a -g sleep 120
>   - this will generate a perf.data output file.
>
> Once you have perf.data output, generate a flamegraph file (named
> perf.svg) using these 2 commands:
> perf script | $FLAME/stackcollapse-perf.pl > out.perf-folded
> $FLAME/flamegraph.pl out.perf-folded > perf.svg
>
> Open the perf.svg image with your favorite image viewer (a web browser
> works well).
>
> I just find flamegraph way more useful than 'perf report' ranked
> ordering.

That's a very good idea, thanks. I will try that when the issue returns.

>
> > Are there any know memory management changes related to NFS that have
> > been introduced that could explain this behavior? What steps can I
> > take to debug the root cause of this? Looking at iftop there isn't
> > much going on regarding throughput. The top 3 NFS4 server operations
> > are sequence 9563/s), putfh(9032/s) and getattr (7150/s).
>
> You'd likely do well to expand the audience to include MM too (now cc'd).

Thanks. All ideas on how I can determine the root cause of this is apprecia=
ted.


Regards,
Rik

