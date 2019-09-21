Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9587B9CFA
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2019 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbfIUHwJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Sep 2019 03:52:09 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:56112 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfIUHwJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Sep 2019 03:52:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id a6so4683550wma.5
        for <linux-nfs@vger.kernel.org>; Sat, 21 Sep 2019 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pb1aOunaeiDAs7Pp/ZKpYPmWd7gVISMFOM6pRizj5rA=;
        b=fFjBmexVYc8BqxiVa/Y7Bq+PVicPyB7am8pvIhYky2pxDfCOjfUHVy7exuwPJlHTzm
         o3QfKu1KBJgVkeVgShBGthZwMCTtqSGdfOAvgHiqg/unnXc8iyyS63hPe2Z+IvdwhMZC
         IjaEMcRmblyYibktD5JEOHExdcYv6r+4g235Qdg+PZ9Bhbd1os5TxGJLEhfdghyIy2M0
         OlPy76nCGPrZ4ijZB6DDAdIv0t9hThOAIqSdLiOCxz+L1eaZ4hyZtGT6EtzzG0KpJWuf
         TZaT9Bts7LKawlsA/tuHQ524eU17OtuaUQvcvfRTnf0z5EVMGsfw2AvEgCvxT70/kmvG
         lsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pb1aOunaeiDAs7Pp/ZKpYPmWd7gVISMFOM6pRizj5rA=;
        b=slrZEzC8rXM/6UPVfQHNS8yF8AKVi3b8UGhtIQM9+sCRZOESCvzfAfJhUYmTEeKGxb
         7rGqIwyk824vm6cZeyJawQ4BSx0fv0JTS9KjsJgtV5WDd1/LR3xypwfKNqyhW+2VquoB
         PVCxKFR/lSUdE/wSRKP6IN42jjYZfS5F+mFP5dJ9x/fGQS4n+5DcuNbaEoVhm0phBA6Q
         AtY62nYEGPBqe6Y+I4RUUYU+iPGU0tQlD3B8mHRiZQesDCWDj8uXZwZkmP3XH6oDFZ+0
         vQpNYQrSxNBHeMUgWNeJpyR8P7Jmaset0jP8/HgZRZ4AQr7mBRjHWjHkmuHV/uTMPoHb
         pbDQ==
X-Gm-Message-State: APjAAAVZLu6g3NEIiQaDe2j51G0PkzGiqh6F5rP8iGUW89qv/nh/YkCL
        0rICNQefITXbc+FDMLyXc67pp1wX
X-Google-Smtp-Source: APXvYqxrH8CtC9T3jUp7u2oi93j5h1aTGYZeTxCYG5H2eCZWjZE1hpfJQ2NG55QTBU74Wx8vmXd89Q==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr6604467wmg.50.1569052326836;
        Sat, 21 Sep 2019 00:52:06 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id a3sm4826848wmc.3.2019.09.21.00.52.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 00:52:06 -0700 (PDT)
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
Message-ID: <ddf47f3c-d27e-972b-fd38-1fdfeaa105a3@gmail.com>
Date:   Sat, 21 Sep 2019 10:52:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6fa596e9-b154-310e-9685-7663731618ba@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I think it's caused by the kernel readahead, not glibc readahead.
TL;DR: This solves the problem:
echo 4 > /sys/devices/virtual/bdi/0:58/read_ahead_kb

Question: how to configure NFS/kernel to automatically set that?

Long version:
Doing step (4) below results in tremendous speedup:

1) mount -t nfs -o tcp,timeo=600,rsize=1048576,wsize=1048576 
10.161.254.11:/srv/ltsp /mnt

2) cat /proc/fs/nfsfs/volumes
We see the DEV number from there, e.g. 0:58

3) cat /sys/devices/virtual/bdi/0:58/read_ahead_kb
15360
I assume that this means the kernel will try to read ahead up to 15 MB 
for each accessed file. *THIS IS THE PROBLEM*. For non-NFS devices, this 
value is 128 (KB).

4) echo 4 > /sys/devices/virtual/bdi/0:58/read_ahead_kb

5) Test. Traffic now should be a *lot* less, and speed a *lot* more.
E.g. my NFS booting tests:
  - read_ahead_kb=15360 (the default) => 1160 MB traffic to boot
  - read_ahead_kb=128 => 324MB traffic
  - read_ahead_kb=4 => 223MB traffic

So the question that remains, is how to properly configure either NFS or 
the kernel, to use small readahead values for NFS.

I'm currently doing it with this workaround:
for f in $(awk '/^v[0-9]/ { print $4 }' < /proc/fs/nfsfs/volumes); do 
echo 4 > /sys/devices/virtual/bdi/$f/read_ahead_kb; done

Thanks,
Alkis
