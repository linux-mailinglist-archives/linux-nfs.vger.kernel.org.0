Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72EDFB825A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404615AbfISUUn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 16:20:43 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53826 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404612AbfISUUn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 16:20:43 -0400
Received: by mail-wm1-f54.google.com with SMTP id i16so6154799wmd.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1rPgzaHa8+lSuPYRKvyMnKyNIwFv/u0gPR5c24Tediw=;
        b=OwMCjBnYzdMm4gMVjQSc+uZMoHhxGTMvPSKi0Z/q7tS6it5GkYO1sONFlmvetKUXDQ
         1hl4KlZwTelngSuDW+wzK5jN8l4+yRcxdFmTWdzXRZ1zGJ4y6kSi4E6+IRxXOunCDG9z
         2mIjlPqHb7d2SuGbYme1cQSw5brdEEN1+UH0HuGjr9GQRlJDpY0e6WWVrNl6EoHyXIG5
         xZD0FIcHMiL9BPong11cvTBpRfDoaflRRaaYxeTw9y+HkrfoVz/P9qhEe+ubdhWdq4Zs
         syNvIphUY3i8q+NOH26Z65HNqzFegVWyPZvTh4/sLmhoXcMTLRBA44nzCmEgjPfbjt8j
         AIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1rPgzaHa8+lSuPYRKvyMnKyNIwFv/u0gPR5c24Tediw=;
        b=LfS9oLK17vwSNoO+WP8vnB0KKaluP4SpVmKS1su7o++rpeo8G6kd1OtbtOl6iL1J9H
         oiRnXho7BNKZJFzujZ+Oy+cMe1ijGvFi7OW3PKbZkq7eXjBRZuX0DK2o6j8DaD6wLA9z
         BbjzmHjLTWIbLS91uJOBbBHJqDTs7dSQXl9g1nhQHDrR+h3eo50jrfq+LhV4WHr5Lh2/
         IPmPgopepOcSxvp8OQ1rItjtT6dgbqjrG4BN0wl8uFLAQBBseMYUT2LBCt5HxUJBpp0x
         CT5q/G/xuxM1sTwrfZ1L3H9rzRZwc7hODRQImIzoDgqc5tBRyqPayNxY0cpQOkKnX36n
         NXtQ==
X-Gm-Message-State: APjAAAWG1TmIkelsaANLQ8swNt+oDYAuMbz9WV9fDS770kmRyrbaOqZK
        PnB1N0fQO5Vumr2J3PxucZUleOst
X-Google-Smtp-Source: APXvYqxR0tgb48x/R4fQ11LExQMeKQtuDNoLzu/iTYI6ELdFaJAXeuXN0YA2Izyk0nE9D2KV5t8Crw==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr4010046wmk.11.1568924441041;
        Thu, 19 Sep 2019 13:20:41 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id n12sm5028375wmk.41.2019.09.19.13.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 13:20:40 -0700 (PDT)
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
 <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
 <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
 <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
 <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
 <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
 <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
 <1d5f6643330afd2c04350006ad2a60e83aebb59d.camel@hammerspace.com>
From:   Alkis Georgopoulos <alkisg@gmail.com>
Message-ID: <5601db40-ee2f-262d-7d01-5c589c9a07eb@gmail.com>
Date:   Thu, 19 Sep 2019 23:20:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1d5f6643330afd2c04350006ad2a60e83aebb59d.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/19/19 11:05 PM, Trond Myklebust wrote:
> There are plenty of operations that can take longer than 700 ms to
> complete. Synchronous writes to disk are one, but COMMIT (i.e. the NFS
> equivalent of fsync()) can often take much longer even though it has no
> payload.
> 
> So the problem is not the size of the WRITE payload. The real problem
> is the timeout.
> 
> The bottom line is that if you want to keep timeo=7 as a mount option
> for TCP, then you are on your own.
> 

The problem isn't timeo at all.
If I understand it correctly, when I try to launch firefox over nfsroot, 
NFS will wait until it fills 1M before "replying" to the application.
Thus the applications will launch a lot slower, as they get "disk 
feedback" in larger chunks and not "snappy".

In numbers:
timeo=600,rsize=1M => firefox opens in 30 secs
timeo=600,rsize=32k => firefox opens in 20 secs

Anyway, thank you very much for your time and feedback.

Kind regards,
Alkis Georgopoulos
