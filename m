Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2891C149DDE
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 00:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAZXlX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jan 2020 18:41:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33593 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAZXlW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jan 2020 18:41:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so8916263wrq.0
        for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2020 15:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=excelero-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=xCecFVB3n4Ly9Lh0tA8pFsJerE+4MYE4LuKQ89ZQ9f0=;
        b=F7GuCm0IjBtUXL3o8MvL92BRsffHsOmlspEtHaUtI2GLIhEjcMhtVxDEPWzK8sGg0m
         LBIgcbhnA99wCtwaknmjU4W/zcBhZkpEu5rEoXOsiHOqPnBVnzjvvWh3zKTrsyX+bedi
         J6LzzPOe+Yz3EC5ibjOEpupKroBoi6ag5mAgWp7pvUc3W2biFizVfKrGdDYhgdlbXXk5
         ULGV2e7B3VaIHVNv/MLLIq1FEz8Ad6zJuki+G1AlceYOnBd9rgQBoN1tOgBIEpHWj17K
         W84DyWVo2cBvxG/QJd/hAhIduth2I2ehJRzPL+BW/bYCg5acVeblpla65wlmveGqHKZz
         0KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=xCecFVB3n4Ly9Lh0tA8pFsJerE+4MYE4LuKQ89ZQ9f0=;
        b=aYD7gY3wjwwiqcDKw6tBkHl7/u4LUGR8u7SHe07pZkalMznjMhp1mETQ3+2sSVIgK2
         D01xaMRyXLeH148dqAoR4Pq+H3a+VcudRnEj/aaiNeizHMj6zjH2zi3G1hKg7XN3kohF
         8/xBzAHqRsT7qfYYYhQHAiLuqQe/Ad2/opcZGHNA71wzf8w3RmUcmFZPkqZJXP28asRP
         3P08FBA2mEB4UAc/RfLV+t7rAc1V3/3PJOIn556CWssGrQ2ZsA8K0qLBvisMKUa/Ra0i
         W6+uKKD2wO1bF1JYmNgJ1OJRqqCT4iQex+twOufoClFHdBOT4aVXOzb7FJtmy6seIPNS
         AchA==
X-Gm-Message-State: APjAAAXrsuZNvFbd+4l/x46lzfRkJtuvk17wzVtSEcfu1mSr77YpKqrN
        Jze+ZnKXzUxrqkDXwz1S40V4F2xA3jI=
X-Google-Smtp-Source: APXvYqzIkcsKdBvH2Oys0E6rkT5w0VbqhdLJhQF05CTEho1BLYylaQwDkS0Fnj0NtIdUGifKZwlt+w==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr17910716wru.395.1580082079687;
        Sun, 26 Jan 2020 15:41:19 -0800 (PST)
Received: from [192.168.0.41] (dslb-088-065-211-141.088.065.pools.vodafone-ip.de. [88.65.211.141])
        by smtp.gmail.com with ESMTPSA id z8sm17910226wrq.22.2020.01.26.15.41.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2020 15:41:19 -0800 (PST)
To:     linux-nfs@vger.kernel.org
From:   Sven Breuner <sven@excelero.com>
Subject: Remove single NFS client performance bottleneck: Only 4 nfsd active
Message-ID: <a8a528c7-80bd-befc-59f8-00135d85a2bf@excelero.com>
Date:   Mon, 27 Jan 2020 00:41:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I'm using the kernel NFS client/server and am trying to read as many small files 
per second as possible from a single NFS client, but seem to run into a bottleneck.

Maybe this is just a tunable that I am missing, because the CPUs on client and 
server side are mostly idle, the 100Gbit (RoCE) network links between client and 
server are also mostly idle and the NVMe drives in the server are also mostly 
idle (and the server has enough RAM to easily fit my test data set in the 
ext4/xfs page cache, but also a 2nd read of the data set from the RAM cache 
doesn't change the result much).

This is my test case:
# Create 1.6M 10KB files through 128 mdtest processes in different directories...
$ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d /mnt/nfs/mdtest -i 1 -I 
100 -z 1 -b 128 -L -u -w 10240 -e 10240 -C

# Read all the files through 128 mdtest processes (the case that matters 
primarily for my test)...
$ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d /mnt/nfs/mdtest -i 1 -I 
100 -z 1 -b 128 -L -u -w 10240 -e 10240 -E

The result is about 20,000 file reads per sec, so only ~200MB/s network throughput.

I noticed in "top" that only 4 nfsd processes are active, so I'm wondering why 
the load is not spread across more of my 64 /proc/fs/nfsd/threads, but even the 
few nfsd processes that are active use less than 50% of their core each. The 
CPUs are shown as >90% idle in "top" on client and server during the read phase.

I've tried:
* CentOS 7.5 and 7.6 kernels (3.10.0-...) on client and server; and Ubuntu 18 
with 4.18 kernel on server side
* TCP & RDMA
* Mounted as NFSv3/v4.1/v4.2
* Increased tcp_slot_table_entries to 1024

...but all that didn't change the fact that only 4 nfsd processes are active on 
the server and thus I'm getting the same result already if /proc/fs/nfsd/threads 
is set to only 4 instead of 64.

Any pointer to how I can overcome this limit will be greatly appreciated.

Thanks in advance

Sven

