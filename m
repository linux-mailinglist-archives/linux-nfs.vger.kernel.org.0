Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA145B9CFE
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2019 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfIUIAA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Sep 2019 04:00:00 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44144 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfIUIAA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Sep 2019 04:00:00 -0400
Received: by mail-wr1-f42.google.com with SMTP id i18so8885140wru.11
        for <linux-nfs@vger.kernel.org>; Sat, 21 Sep 2019 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wRY7ntwHwK+MmLMqCnDMO88VxMH+VfJTPS92c7S1Yro=;
        b=DOBF8q3PEiVwTi8KRIEoJK/yvAppNgKf1wZ7Dm/DtZaT/M26+Nn9VFtscPAktsRljl
         as26zb+O/WdP+KAikffGF9N8KC9Leu86hmXO4gGw8H+cnjjJl/lPUN27whZ2LbnUHb4u
         z+yqFUGenMbQfaBwPQnM/Tk1ROe2+7iLJhwJLj1kt6wQjIwgdJnzl1MBnMmN6qpt6Mwz
         DqtktXxKWQgfrTm1PiTuILZjlrXwggppDOhMmJTKrWRBEoR9JF4bSJ8y570HW+l8BSO7
         hN0K+4D9jGr8ld/WEx5NylMGAKmh4AoPBes+bzEFZ1V4QFUmrPs1vWmuKxL/1nzk6WQN
         jkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wRY7ntwHwK+MmLMqCnDMO88VxMH+VfJTPS92c7S1Yro=;
        b=l6vAFbwlqTlXlh2o8vmRlpOEkN5HUWP8VZglCtqkyxtDeBCNQsStsak9vEnVelIpnE
         MsK3qmmDivvf+8+uryT29uyI+iyx4JS3wUXadiDb3wyQuk0UGkhwrnxQGsi0qP5m67WP
         UJtgYb9vR5V4V+gChE1EZm6J1r5yf3rCQNd/pvC9uamJTlshSM34avGalKbjXMPyQp31
         7ZE1BVN6HjDyBgVIK4ZK9JHDJnvAOnyAmv80+PNJzAaccvQFZnVq1AtQT+QpMx1C/LCo
         8uLrecKTCvxE1vJnzI9azo22nHMB4ZywE7iZtD1nDbxs5BDQV46F/rL6yytM9gMiVHBI
         iGTg==
X-Gm-Message-State: APjAAAVXnSNyBnFzJb/MgB9xLEYh/Zk8qWLWar2aeOlSoJX6U71pHftt
        gfhziI54fGEioXdcW4SsX2LapP9K
X-Google-Smtp-Source: APXvYqyBMc+EXvS7tX6dXtxHde4nYu4LsfdgxLOninQpKbp2V3Jssnf6S+QEOdk/Amaa6s/3u10Nqw==
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr14362696wre.193.1569052796781;
        Sat, 21 Sep 2019 00:59:56 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id u25sm3510669wml.4.2019.09.21.00.59.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 00:59:56 -0700 (PDT)
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
From:   Alkis Georgopoulos <alkisg@gmail.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
 <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
 <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
 <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
 <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
 <1d5f6643330afd2c04350006ad2a60e83aebb59d.camel@hammerspace.com>
 <5601db40-ee2f-262d-7d01-5c589c9a07eb@gmail.com>
 <d7ea48b4cd665eced45783bf94d6b1ff1f211960.camel@hammerspace.com>
 <20190919211912.GA21865@cosmos.ssec.wisc.edu>
 <503c22ad34b3f3a15015b7384bcad469b2899cb4.camel@hammerspace.com>
 <20190919221601.GA30751@cosmos.ssec.wisc.edu>
 <0213704b-3930-5be6-bd3d-dbaabc24a270@gmail.com>
 <1e7c9896-eb1b-9d7c-fff0-6df2b3d96392@gmail.com>
 <6fa596e9-b154-310e-9685-7663731618ba@gmail.com>
 <ddf47f3c-d27e-972b-fd38-1fdfeaa105a3@gmail.com>
Message-ID: <675724ca-bdb4-324b-b3ec-2fba608b8358@gmail.com>
Date:   Sat, 21 Sep 2019 10:59:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ddf47f3c-d27e-972b-fd38-1fdfeaa105a3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/21/19 10:52 AM, Alkis Georgopoulos wrote:
> I think it's caused by the kernel readahead, not glibc readahead.
> TL;DR: This solves the problem:
> echo 4 > /sys/devices/virtual/bdi/0:58/read_ahead_kb
> 
> Question: how to configure NFS/kernel to automatically set that?
> 
> Long version:
> Doing step (4) below results in tremendous speedup:
> 
> 1) mount -t nfs -o tcp,timeo=600,rsize=1048576,wsize=1048576 
> 10.161.254.11:/srv/ltsp /mnt
> 
> 2) cat /proc/fs/nfsfs/volumes
> We see the DEV number from there, e.g. 0:58
> 
> 3) cat /sys/devices/virtual/bdi/0:58/read_ahead_kb
> 15360
> I assume that this means the kernel will try to read ahead up to 15 MB 
> for each accessed file. *THIS IS THE PROBLEM*. For non-NFS devices, this 
> value is 128 (KB).
> 
> 4) echo 4 > /sys/devices/virtual/bdi/0:58/read_ahead_kb
> 
> 5) Test. Traffic now should be a *lot* less, and speed a *lot* more.
> E.g. my NFS booting tests:
>   - read_ahead_kb=15360 (the default) => 1160 MB traffic to boot
>   - read_ahead_kb=128 => 324MB traffic
>   - read_ahead_kb=4 => 223MB traffic
> 
> So the question that remains, is how to properly configure either NFS or 
> the kernel, to use small readahead values for NFS.
> 
> I'm currently doing it with this workaround:
> for f in $(awk '/^v[0-9]/ { print $4 }' < /proc/fs/nfsfs/volumes); do 
> echo 4 > /sys/devices/virtual/bdi/$f/read_ahead_kb; done
> 
> Thanks,
> Alkis



Quoting https://lkml.org/lkml/2010/2/26/48
 > nfs: use 2*rsize readahead size
 > With default rsize=512k and NFS_MAX_READAHEAD=15, the current NFS
 > readahead size 512k*15=7680k is too large than necessary for typical
 > clients.

I.e. the problem probably is that when NFS_MAX_READAHEAD=15 was 
implemented, rsize was 512k; now that rsize=1M, this results in 
readaheads of 15M, which cause all the traffic and lags.
