Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6CB8E02
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 11:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405761AbfITJsI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 05:48:08 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:33819 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405677AbfITJsI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 05:48:08 -0400
Received: by mail-wm1-f42.google.com with SMTP id y135so9145653wmc.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ih3ww9GaSYbHCJImisvEseicScRjhP+yOR33GnQTWVk=;
        b=nLEfOoGVfGQsuBJ9i+sbVnZ0PCtkoscWnxJiCmU0ArBIDZy32QCRCE2gucAFzLS8MZ
         VTC5hVenOIIcT+ZGkqGUWztG0EI++lh5hWHF9vC6Dp2SqnfMFy4wpmyqBf4JH2O8eeKy
         w4dhNxxocOo10898ueMakdSv3U4f3jyX6q6sL5nR3diYGxLA6Uha7c16gmIhbp4S2OM6
         jfBNQFj3/Zd1fYsMJx0G0fO1LoAghiDiYaw9kNl3XoB1rjMnlicPX6QJBlNhu7RMiGe+
         f+Y+FpDsuMkZVgWGdmQJFyCTODIrfa1iUnOxtHm0ePOYSlMpclwnKrjIs/PyFBj7vzu4
         3wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ih3ww9GaSYbHCJImisvEseicScRjhP+yOR33GnQTWVk=;
        b=YDmkuHfapf7XU6N/zU+CGFok6sYlucWdSazVEx6Vdt+zFkJ5RDrUFQ5fQ551Xq23ge
         P9mo4Ec7gD+MDsuBUFvMOFRVJI/yBKdvHUb9i8pEr0IHVoRwzJOSdWK3mT1Xf0VC5V0k
         qMffBbM6hcG3SkiSNkG/aZzLOEb8C7s6YwzqV3Nes6VaEYNKfvUVDE7jwafpaacddbkk
         mn62fU4zi4o7AC/17fKilpc1JzZ2dTKq9kcKUs7xEc2Cm03eWtDgum599xEdxInF7a3Q
         7g8Rj3hRHT4HR8p+wyO5BKQIoaFYgRXr8FxPo4RrmRx0sXb9JJDDNctZoKpLMTwLClb6
         TxYw==
X-Gm-Message-State: APjAAAVvDx9tUT4dZXmZX3ujfqIrJCOKR1swfEURCWIe2ss04Q33N8xY
        R4kZF96Tum/WlDTPeV+b8XuBYj31
X-Google-Smtp-Source: APXvYqzXJnOO2jABoIZbHZSDDF7+1NFAZWetTer52MrHLOmsgQHgGrtfoySohKwQAq5//m4UlwqPIw==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr2519056wmk.61.1568972886022;
        Fri, 20 Sep 2019 02:48:06 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id y72sm1730295wmc.26.2019.09.20.02.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 02:48:05 -0700 (PDT)
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
From:   Alkis Georgopoulos <alkisg@gmail.com>
To:     Trond Myklebust <trondmy@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
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
Message-ID: <1e7c9896-eb1b-9d7c-fff0-6df2b3d96392@gmail.com>
Date:   Fri, 20 Sep 2019 12:48:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0213704b-3930-5be6-bd3d-dbaabc24a270@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/20/19 12:25 PM, Alkis Georgopoulos wrote:
> This is likely not the exact issue I'm experiencing, as I'm testing e.g.
> with glibc 2.27-3ubuntu1 on Ubuntu 18.04 and kernel 5.0.
> 
> New benchmark, measuring the boot time of a netbooted client,
> from right after the kernel is loaded to the display manager screen:
> 
> 1) On 10 Mbps:
> a) tcp,timeo=600,rsize=32K: 304 secs
> b) tcp,timeo=600,rsize=1M: 618 secs
> 
> 2) On 100 Mbps:
> a) tcp,timeo=600,rsize=32K: 40 secs
> b) tcp,timeo=600,rsize=1M: 84 secs
> 
> 3) On 1000 Mbps:
> a) tcp,timeo=600,rsize=32K: 20 secs
> b) tcp,timeo=600,rsize=1M: 24 secs
> 
> 32K is always faster, even on full gigabit.
> Disk access on gigabit was *significantly* faster to result in 4 seconds 
> lower boot time. In the 10/100 cases, rsize=1M is pretty much unusable.
> There are no writes involved, they go in a local tmpfs/overlayfs.
> Would it make sense for me to measure the *boot bandwidth* in each case, 
> to see if more things (readahead) are downloaded with rsize=1M?


I did test the boot bandwidth.
On ext4-over-NFS, with tmpfs-and-overlayfs to make root writable:

2) On 100 Mbps:
a) tcp,timeo=600,rsize=32K: 471MB
b) tcp,timeo=600,rsize=1M: 1250MB

So it is indeed slower because it's transferring more things that the 
client doesn't need.
Maybe it is a different or a new aspect of the readahead issue that you 
guys mentioned above.
Is it possible that NFS is always sending 1MB chunks even when the 
actual data inside them is lower?

If you want me to test more things, I can;
if you consider it a problem with glibc etc that shouldn't involve this 
mailing list, I can try to report it there...

Thank you,
Alkis Georgopoulos
