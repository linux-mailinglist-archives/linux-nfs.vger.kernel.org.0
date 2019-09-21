Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C5AB9D80
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2019 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407492AbfIULCr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Sep 2019 07:02:47 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:33498 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407491AbfIULCr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Sep 2019 07:02:47 -0400
Received: by mail-wm1-f45.google.com with SMTP id r17so11305540wme.0
        for <linux-nfs@vger.kernel.org>; Sat, 21 Sep 2019 04:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hvEA70HlyF9iXrQMAOlvpAh81SOSfZzOL+w7Eq8RYCY=;
        b=gi5u32TMAyov3h+W0lQVZE5eMxtnJNLaAlYm0A0vrb3wVjsfwlozbJw+v1vfNvWen5
         R7KWM/ZBwndUCUT1j45Y3WcbR8qTLHY8Sp1hsLHBKZMoK35fBzxOnUa9u3CweQmgpX7D
         RNhCSDOYVynA23WJuOh8Ve4M9hkQlnkUrxPrAN4ogdKSx//4BlKQAiakvAuZsEjNFfe0
         WXhVssn2WmdUXbyH2p6foithMtHiteWVkT/D4q7xB8QwIez1J0WgTn/UIr7E/D6rqFYa
         czQFKFqQIdATzn0UrPox1tahOBk2jJrfb5jpcvmu3H0JVCZGeTuLa1X1eFfILT6PCB+Y
         OT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hvEA70HlyF9iXrQMAOlvpAh81SOSfZzOL+w7Eq8RYCY=;
        b=GtsK6KdERiEEgn9jXj/GVMHorvwqAtDDOXoSgBe75peZktxnNz3SGtOXgDuTzmoMkk
         PSJciYjg6eYblRoZhM7IxQ4YkYQhL39zdUkAikzdOYLHdc3ntk1h9PXnvUDoS71qwiVW
         WO///dsl0i/jbDwwZKzL1u1aAykQ6NlpXajilXaSd4hauBRwwebQX5kbDLdugrj532Ou
         f2YOv2y6awFmF9pWKd8skyL5CLCpuMxVC+6XXw32XarcaSDDxK4Qi0K8SqafeaHEEOla
         rG7cjMlDJOio8tp2ifSAArBD1UMGgIz67oHa/GqY7mvH1rnlg5/qOoMrKVWBWDwTsiXx
         RKhw==
X-Gm-Message-State: APjAAAV7CvWosrx7fFC/EdqfPFcdfBbUy2vUy8Y1eNmtTjqBoW5l6eAI
        dCwdth4wd49rbegzi1zRWPVL8bt+
X-Google-Smtp-Source: APXvYqw9GkRVI3USm3GKKmIzWzG1iJNi79Zc2HPAqHH29LT8ZQmLAU9kstMFi9IcbZQnJL0/S1QcKQ==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr6729524wmf.80.1569063764992;
        Sat, 21 Sep 2019 04:02:44 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id g185sm8763909wme.10.2019.09.21.04.02.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 04:02:44 -0700 (PDT)
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
 <675724ca-bdb4-324b-b3ec-2fba608b8358@gmail.com>
Message-ID: <0b76213e-426b-0654-5b69-02bfead78031@gmail.com>
Date:   Sat, 21 Sep 2019 14:02:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <675724ca-bdb4-324b-b3ec-2fba608b8358@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/21/19 10:59 AM, Alkis Georgopoulos wrote:
> I.e. the problem probably is that when NFS_MAX_READAHEAD=15 was 
> implemented, rsize was 512k; now that rsize=1M, this results in 
> readaheads of 15M, which cause all the traffic and lags.


I filed a bug report for this:
https://bugzilla.kernel.org/show_bug.cgi?id=204939

A quick work around is to run on the clients, after the NFS mounts:

for f in $(awk '/^v[0-9]/ { print $4 }' < /proc/fs/nfsfs/volumes); do
     echo 4 > /sys/devices/virtual/bdi/$f/read_ahead_kb
done

Btw the mail title is wrong, the workaround above causes the netboot
traffic to drop from e.g. 1160MB to 221MB in any network speed;
it was just more observable in lower speeds.

Thank you very much,
Alkis Georgopoulos
