Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6BF5B7A99
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiIMTM5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 15:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIMTM5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 15:12:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C08263F36
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 12:12:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m1so18980027edb.7
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date;
        bh=cifjMWu40U+aheJTofCk0sZ2GPleCK2AUlpVDHejNg0=;
        b=fAj1Uc1BaaoUgaaWKzp5lXdr3AcKiptQ6V0W8Npo3mBrlGSUNmKY41TUBnlG8TjoTa
         1i845kt4YRQCqnE7thOFqLk/W66sicI0xZnrCIDBvfv1BPNHND3t9izx9KvCuCkJzLKC
         33FotUIjzJFfEOL3MvWY2yjeDQlcB8c7bdxo5SErjumcYTOZcOxrc8pBgqRIR1x6wQA3
         dELItRiF5rbpmCrIKgeGVVx3Fp5bpiM5Wi/TwI4b0+WXCa/VfOamoKWGAR6fpevpVIiw
         82d1yMKRt5bil24q0j4PsvboW2J0DD0Mtu1XaYGZ2F0ca4h2v8O0Yl7LEeGPziIQ3apa
         5dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cifjMWu40U+aheJTofCk0sZ2GPleCK2AUlpVDHejNg0=;
        b=mCP6sRldGHX1tuQ5KwQ8na8hyDew61NwbstrXzxuOFq9XLfbC6SAM9/O2xSFlu03oa
         So+Lt3LPVs4+aeOstiPYtWPxWFQWpSIhToxNwtmlvO0Cam6WtIKoKq2aGyFtrzwc21CT
         6sqefMCTgq+IXMmJXrSuQ0I5aRyW+j7QljBWCxN3x2XOxF13FZVW3yuP6PPvbWsqd0Y2
         3tvCfiRDXAjxAD+NkfBJklWHSt7MUe/GFnFi3T467SF/4sfmtJXSxb6Ajz3+sie7UD54
         4SZQCa+NZvGYwgiexF3YplUcRLvd4Au2MspVccuOVCSh9imWrmXjcog4QxtIXlznqfqT
         hQRw==
X-Gm-Message-State: ACgBeo1qIEkHewr0p13vAp6JmMa4zE87/MrgPdG9b9LnGl0wAvq7M/ol
        lNimIBSDsd6Uh8fS7BfC6TQlq9RohgCtqPUU+D8l8Nqq
X-Google-Smtp-Source: AA6agR540FWLQf6K2TijgShpVF18bD2u5enTq22iiCKx+fryHIqYZzwGcVVJxEcZApzu+dm8p54CgwVZT64eYAKs/EE=
X-Received: by 2002:a05:6402:4305:b0:451:7b78:f2e0 with SMTP id
 m5-20020a056402430500b004517b78f2e0mr12104733edc.342.1663096373717; Tue, 13
 Sep 2022 12:12:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:4ece:b0:773:db39:8961 with HTTP; Tue, 13 Sep 2022
 12:12:53 -0700 (PDT)
In-Reply-To: <f85356b31470779736f60500b0a89561db9cf8de.camel@kernel.org>
References: <CAALSs0ZuC2FLuk3PsiXKCc+3vZoAz5UWPaX+D7WV8JcpP8_Ueg@mail.gmail.com>
 <8201ede6bcb5d6ab77bb4cce08f3b6c6776a43af.camel@kernel.org>
 <CAALSs0bxqODBzN0V67ExMCnOJFi_+9vZ0_zK1DTGOomb+H-D7Q@mail.gmail.com> <f85356b31470779736f60500b0a89561db9cf8de.camel@kernel.org>
From:   Isak <netamego@gmail.com>
Date:   Tue, 13 Sep 2022 21:12:53 +0200
Message-ID: <CAALSs0bq2hnU45XwXQxY07pxDAy=eSWCMGrAZgD9+9KQ8qyi3w@mail.gmail.com>
Subject: Re: nfs client strange behavior with cpuwait and memory writeback
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thank you very much Jeff. Understood. That explains why I have high cpu
iowait and high latency (nfsiostat) when launching a dd to an NFS
filesystem without the sync option. Surely my vm.dirty tunables are wrong
for the workload. Maybe more RAM is needed.

But what about dd to NFS filesystem mounted with Sync (Test 2)?. As I
understood (from your free lessons) VM.dirty tunables don't have much sense
in that scenario because a fsync is done after 1MB write (in my case). I
have high cpuwait and low NFS latency (nfsiostat).How is This posible?This
is extruding my brain. If dd is launched with oflag=3Ddirect in the same NF=
S
filesystem (mounted with Sync), page cache is not used and there isn't
cpuwait.


Thank you very much.

2022-09-13 13:51 GMT+02:00, Jeff Layton <jlayton@kernel.org>:
> On Mon, 2022-09-12 at 21:00 +0200, Isak wrote:
>> El lun, 12 sept 2022 a las 12:40, Jeff Layton (<jlayton@kernel.org>)
>> escribi=C3=B3:
>> >
>> > On Sun, 2022-09-11 at 20:58 +0200, Isak wrote:
>> > > Hi everybody!!!
>> > >
>> > > I am very happy writing my first email to one of the Linux mailing
>> > > list.
>> > >
>> > > I have read the faq and i know this mailing list is not a user help
>> > > desk but i have strange behaviour with memory write back and NFS.
>> > > Maybe someone can help me. I am so sorry if this is not the right
>> > > "forum".
>> > >
>> > > I did three simple tests writing to the same NFS filesystem and the
>> > > behavior of the cpu and memory is extruding my brain.
>> > >
>> > > The Environment:
>> > >
>> > > - Linux RedHat 8.6, 2 vCPU (VMWare VM) and 8 GB RAM (but same
>> > > behavior
>> > > with Red Hat 7.9)
>> > >
>> > > - One nfs filesystem mounted with sync and without sync
>> > >
>> > > 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_with_sync type nfs
>> > > (rw,relatime,sync,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D=
255,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x.2x=
x.1xx,mountvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,add=
r=3D1x.1x.2xx.1xx)
>> > >
>> > > 1x.1x.2xx.1xx:/test_fs on /mnt/test_fs_without_sync type nfs
>> > > (rw,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,h=
ard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D1x.1x.2xx.1xx=
,mountvers=3D3,mountport=3D2050,mountproto=3Dudp,local_lock=3Dnone,addr=3D1=
x.1x.2xx.1xx:)
>> > >
>> > > - Link between nfs client and nfs server is a 10Gb (Fiber) and iperf=
3
>> > > data show the link works at maximum speed. No problems here. I know
>> > > there are nfs options like nconnect to improve performance but I am
>> > > interested in linux kernel internals.
>> > >
>> > > The test:
>> > >
>> > > 1.- dd in /mnt/test_fs_without_sync
>> > >
>> > > dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
>> > > 5000+0 records in
>> > > 5000+0 records out
>> > > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 21.4122 s, 245 MB/s
>> > >
>> > > * High cpuwait
>> > > * High nfs latency
>> > > * Writeback in use
>> > >
>> > > Evidences:
>> > > https://zerobin.net/?43f9bea1953ed7aa#TaUk+K0GDhxjPq1EgJ2aAHgEyhntQ0=
NQzeFF51d9qI0=3D
>> > >
>> > > https://i.stack.imgur.com/pTong.png
>> > >
>> > >
>> > >
>> > > 2.- dd in /mnt/test_fs_with_sync
>> > >
>> > > dd if=3D/dev/zero of=3Dtest.out bs=3D1M count=3D5000
>> > > 5000+0 records in
>> > > 5000+0 records out
>> > > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 35.6462 s, 147 MB/s
>> > >
>> > > * High cpuwait
>> > > * Low nfs latency
>> > > * No writeback
>> > >
>> > > Evidences
>> > > https://zerobin.net/?0ce52c5c5d946d7a#ZeyjHFIp7B+K+65DX2RzEGlp+Oq9rC=
idAKL8RpKpDJ8=3D
>> > >
>> > > https://i.stack.imgur.com/Pf1xS.png
>> > >
>> > >
>> > >
>> > > 3.- dd in /mnt/test_fs_with_sync and oflag=3Ddirect
>> > >
>> > > dd if=3D/dev/zero of=3Dtest.out bs=3D1M oflag=3Ddirect count=3D5000
>> > > 5000+0 records in
>> > > 5000+0 records out
>> > > 5242880000 bytes (5.2 GB, 4.9 GiB) copied, 34.6491 s, 151 MB/s
>> > >
>> > > * Low cpuwait
>> > > * Low nfs latency
>> > > * No writeback
>> > >
>> > > Evidences:
>> > > https://zerobin.net/?03c4aa040a7a5323#bScEK36+Sdcz18VwKnBXNbOsi/qFt/=
O+qFyNj5FUs8k=3D
>> > >
>> > > https://i.stack.imgur.com/Qs6y5.png
>> > >
>> > >
>> > >
>> > >
>> > > The questions:
>> > >
>> > > I know write back is an old issue in linux and seems is the problem
>> > > here.I played with
>> > > vm.dirty_background_bytes/vm.dirty_background_ratio
>> > > and vm.dirty_background_ratio/vm.dirty_background_ratio (i know only
>> > > one is valid) but whatever value put in this tunables I always have
>> > > iowait (except from dd with oflag=3Ddirect)
>> > >
>> > > - In test number 2. How is it possible that it has no nfs latency bu=
t
>> > > has a high cpu wait?
>> > >
>> > > - In test number 2. How is it possible that have almost the same cod=
e
>> > > path than test number 1? Test number 2 use a nfs filesystem mounted
>> > > with sync option but seems to use pagecache codepath (see flame
>> > > graph)
>> > >
>> >
>> > "sync" just means that the write codepaths do an implicit fsync of the
>> > written range after every write. The data still goes through the
>> > pagecache in that case. It just does a (synchronous) flush of the data
>> > to the server and a commit after every 1M (in your case).
>>
>> Thank you very much Jeff. Understood. My mistake. I thought that, with
>> the nfs sync option, page cache was actually not used. What about test
>> 2 (with Sync) regarding to cpuwait? Seems like a CPU accounting
>> "problem"? I have high cpuwait and low NFS latency (nfsiostat). If dd
>> is launched with oflag=3Ddirect in the same NFS filesystem (mounted with
>> Sync), page cache is not used and there isn't cpuwait.
>>
>> >
>> > >
>> > > - In test number 1. Why isn't there a change in cpuwait behavior whe=
n
>> > > vm.dirty tunables are changed? (i have tested a lot of combinations)
>> > >
>> > >
>> >
>> > Depends on which tunables you're twiddling, but you have 8G of RAM and
>> > are writing a 5G file. All of that should fit in the pagecache without
>> > needing to flush anything before all the writes are done. I imagine th=
e
>> > vm.dirty tunables don't really come into play in these tests, other
>> > than
>> > maybe the background ones, and those shouldn't really affect your
>> > buffered write throughput.
>>
>> My understanding (surely wrong) about page cache in Linux is that we
>> actually have two caches. One is "read cache" and the other is "write
>> cache" aka dirty pages so write cache should not exceed the parameter
>> vm.dirty_bytes or vm.dirty_ratio so I don't think 5gb file in 8gb RAM
>> with low vm.dirty_ratio does much buffering.
>>
>
> Not exactly.
>
> The VM has two sets of thresholds: dirty_bytes and dirty_ratio, along
> with "background" versions of the same tunables. Most distros these days
> don't work the "bytes" values, but work with the "ratio" ones, primarily
> because memory sizes can vary wildly and that gives better results.
>
> The dirty_ratio indicates the point where the client starts forcibly
> flushing pages in order to satisfy new allocation requests. If you want
> to do a write, you have to allocate pages to hold the data and that will
> block until the ratio of dirty memory to clean is below the threshold.
>
> The dirty_background_ratio indicates the point where the VM starts more
> aggressively flushing data in the background, but that doesn't usually
> affect userland activity. Your allocations won't block when you exceed
> the background ratio, for instance so you can just keep writing and
> filling memory.
>
> Ideally, you never want to hit the dirty_ratio, and if things are tuned
> well, you never will as long as background writeback is keeping up with
> the rate of page dirtying.
> --
> Jeff Layton <jlayton@kernel.org>
>
