Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A74AC905
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 20:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiBGTBw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 14:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiBGS63 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 13:58:29 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A62C0401DA
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 10:58:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cf2so16148219edb.9
        for <linux-nfs@vger.kernel.org>; Mon, 07 Feb 2022 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RmZDWGmZVmsBpXkAYONLwh0fIHxdkykHX9fioNMzMdo=;
        b=bxJhoZnbG8yoxKLDZjyFm4/LUUKEUwaeVYUT2tJGKeU+4hD4KzbNLNO9DXTpMJTezm
         J0D56Q8612LQ/zQBPwXrQ2G1x1HeksdLc/Dw2/0JC3S7O6IDuxJBBqkHfAFJRsV37D04
         syPWte7aZcfL3DdaofHB+1IqQ8ZzPNnvxm4hcKcJ7nlt/MBJcsK574NUOkVk/2AyG40L
         q5+OV26wkcozymmXTz+sRg37C8VAJnlaJbE9H+oF0FQjvmhecd+p5ECxv2rCltoIqBkI
         rgFonQqzwCK9rVKaStDghu22OZe/IRHthBiDYMuEimNY8kzCuoqkYuA2K8v3hiX51cUK
         Q34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RmZDWGmZVmsBpXkAYONLwh0fIHxdkykHX9fioNMzMdo=;
        b=WAliUyuLWE58oGqIekg8NQfep/YSduoePBikrRw5EFeCAXK9nvRkGskMNBnmZa2A/U
         qdfokJH3J48otN3JRkwGS4qpDxlbCIT2roOXAKzFsv8nwk/S6ONWpHQ+aSg4tVI42oUx
         nGdmBL1FKOWxds+26MhpUAf3jW+x7zy4KwXW/9yfnrs3FTi/lGiqthedgrKRUZkU3iV/
         gdZ7MnQV4ug/0aIxenMkpOhpQg/V8X5zJPuF9hJ9VCHFZ0l4P554gZi1QH6/O2ne03lj
         qUCFiASqPV0foBmKH85t9hhJmbOZ+3D+Pqjs/n1Mt2QUWLbpc43HPNfC1TvfZUbme5Sm
         nFeA==
X-Gm-Message-State: AOAM531US8BNIqktMrsEkuGZDLR6ZEWtLmdmnVqv08obQgMNWYslWkZW
        2ecOxOJwACSjdEYj9SbKytmyeHS52Kc1NKzQ8vzYIKHUZqdPlh+L
X-Google-Smtp-Source: ABdhPJzZiB73wsZJ5rxezHCagYL7n8OR/DkTB1o1jk68o+J7F+syWan3dbaBmWFx6/2BO6QQkEw8iWaLUe7pzuYIWfs=
X-Received: by 2002:a05:6402:371:: with SMTP id s17mr851727edw.315.1644260306367;
 Mon, 07 Feb 2022 10:58:26 -0800 (PST)
MIME-Version: 1.0
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 7 Feb 2022 18:57:50 +0000
Message-ID: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>
Subject: NFSv4 versus NFSv3 parallel client op/s
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

As part of my ongoing investigations into high latency WAN NFS
performance with only a single client (for the purposes of then
re-exporting), I have been looking at the metadata performance
differences between NFSv3 and NFSv4.2.

High latency seems to be a particularly good way of highlighting the
parallel/concurrency performance limitations with a single NFS client.
So I took a client 200ms away from the server and ran things like
open() and stat() calls to many files & directories using simultaneous
threads (200+) to see how many requests and operations we could keep
in flight simultaneously.

The executive summary is that NFSv4 is around 10x worse than NFSv3 and
an NFSv4 client clearly flatlines at around 180 ops/s with 200ms. By
comparison, an NFSv3 client can do around 1,500 ops/s (access+lookup)
with the same test.

On paper, NFSv4 is more compelling over the WAN as it should reduce
round trips with things like compound operations and delegations, but
that's only good if it can do lots of them simultaneously too.

Comparing the slot table/xport stats between the two protocols while
running the benchmark highlights the difference:

NFSv3
opts: rw,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregmin=3D3=
600,acregmax=3D3600,acdirmin=3D3600,acdirmax=3D3600,hard,nocto,noresvport,p=
roto=3Dtcp,nconnect=3D4,timeo=3D600,retrans=3D10,sec=3Dsys,mountaddr=3D10.2=
5.22.17,mountvers=3D3,mountport=3D20048,mountproto=3Dudp,fsc,local_lock=3Dn=
one
xprt: tcp 0 1 2 0 0 85480 85380 0 6549783 0 102 166291 6296122
xprt: tcp 0 1 2 0 0 85827 85727 0 6575842 0 102 149914 6322130
xprt: tcp 0 1 2 0 0 85674 85574 0 6577487 0 102 131288 6320278
xprt: tcp 0 1 2 0 0 84943 84843 0 6505613 0 102 182313 6251396

NFSv4.2
opts: rw,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregmin=
=3D3600,acregmax=3D3600,acdirmin=3D3600,acdirmax=3D3600,hard,nocto,noresvpo=
rt,proto=3Dtcp,nconnect=3D4,timeo=3D600,retrans=3D10,sec=3Dsys,clientaddr=
=3D10.25.112.8,fsc,local_lock=3Dnone
xprt: tcp 0 0 2 0 0 301 301 0 1439 0 9 80 1058
xprt: tcp 0 0 2 0 0 294 294 0 1452 0 10 79 1085
xprt: tcp 0 0 2 0 0 292 292 0 1443 0 10 102 1055
xprt: tcp 0 0 2 0 0 287 286 0 1407 0 9 64 1067

So either we aren't putting things into the slot table quickly enough
for it to scale up, or it just isn't scaling for some other reason.

The max slots of 101 for NFSv3 and 10 for NFSv4.2 probably accounts
for the aggregate difference of 10x I see in benchmarking?

I tried increasing the /sys/module/nfs/parameters/max_session_slots
from 64 to 128 on the client (modprobe.conf & reboot) but it didn't
seem to make much difference. Maybe it's a server side limit then and
the lowest is being used:

fs/nfsd/stat.h:
#define NFSD_SLOT_CACHE_SIZE            2048
/* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
#define NFSD_CACHE_SIZE_SLOTS_PER_SESSION       32

I'm sure there are probably good reasons for these values (like
stopping a client from hogging the queue) but is this the reason I see
such a big difference in the performance of concurrency for a single
client over high latencies?

Why do I feel like in writing this all down, I have probably answered
my own question...

Cheers,

Daire
