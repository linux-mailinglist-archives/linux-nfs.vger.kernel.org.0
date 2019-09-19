Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31702B8392
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 23:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393054AbfISVmj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 17:42:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37992 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390391AbfISVmi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 17:42:38 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so11419577iol.5
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:in-reply-to:references:organization
         :mime-version:date:user-agent:content-transfer-encoding;
        bh=8m0YRk8aR+TG/n7mWkiVqeJIEoiZuMNQMUlQ92wO2dc=;
        b=uDHqG+789pYvvCYuAoNZ8o9tmrCZMU1o2UmiSf5l1CkdBvZi3w2/FD0lLSkR93FRpn
         +7CFnH66dczwfZfjhs6ec9BKklUX4pHIeUT0lUAO4Porx4I2Qda2jnYN013CaELYP+Ux
         tQLY33N3gFOICmt26c620WwH4qFM49lkzONS4NX/SeYizBwOKU+ODn+FDghOVggXLONG
         wAIvwBqMMdjF06zBgVRQKB9h6JFSU8he0QPVcDegtRwOgdRWMN3t933aOiBVhDgTCCFt
         rAfvR58iZGlWw71TivRMoEuk6l5aV/GrDKczzfnoczKiyo8/STzCJeNjlEKP3zgMjt6r
         0YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:in-reply-to
         :references:organization:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=8m0YRk8aR+TG/n7mWkiVqeJIEoiZuMNQMUlQ92wO2dc=;
        b=PVlWX73x4DrfwR2sW+R/ZluWxvfIYSpXWnwFvCfXL+C14Nhr37VXqfKzbP+lgjrUae
         cZgnajVaJEKiJ0W/rvuUMuZU88Y8lQorKaopRpl6/Z6D/RHUuoiCqaZyTOWiBXdyXsz0
         fiJIQA8LrQKSWrnEbxzNCmyBlQNzxUQoN9e13jfDQU0B6GNp9WpjWqRWEV3UbHJ0oaKp
         FmEaAT24kv4XIFQ8ujF/UkH/YB3j3EHaRfI7FBXIaJPcIX2NqgPDBlvOvIXS1G/frq8x
         ZLI2FT7a9ahb8inZSiY7mkMZSnTNlBTiZtZed5OnV5m73/vutZA4/1uO2src0jIjf122
         Jb6w==
X-Gm-Message-State: APjAAAUWiGy7wV9z8ChhLujNJR/ieUzbyHB8v171Z4oFCq+D23qhveGi
        JQrfG12YVDr2ZWANHg+FATWgdePj5A==
X-Google-Smtp-Source: APXvYqzGMvLVGk/CUVppUfZ7Zj6LTtdheHY/IKhwJH4//FgPuGJk3yCjowUZXZg7RzBsyaumdRW4+Q==
X-Received: by 2002:a6b:c302:: with SMTP id t2mr1952593iof.217.1568929357757;
        Thu, 19 Sep 2019 14:42:37 -0700 (PDT)
Received: from leira (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id x26sm6879553ioa.37.2019.09.19.14.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 14:42:36 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trondmy@hammerspace.com>
Message-ID: <503c22ad34b3f3a15015b7384bcad469b2899cb4.camel@hammerspace.com>
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
To:     Daniel Forrest <dforrest@wisc.edu>
Cc:     "alkisg@gmail.com" <alkisg@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
In-Reply-To: <20190919211912.GA21865@cosmos.ssec.wisc.edu>
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
         <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
         <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
         <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
         <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
         <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
         <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
         <1d5f6643330afd2c04350006ad2a60e83aebb59d.camel@hammerspace.com>
         <5601db40-ee2f-262d-7d01-5c589c9a07eb@gmail.com>
         <d7ea48b4cd665eced45783bf94d6b1ff1f211960.camel@hammerspace.com>
         <20190919211912.GA21865@cosmos.ssec.wisc.edu>
Organization: Hammerspace Inc
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 19 Sep 2019 17:42:26 -0400
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2019-09-19 at 16:19 -0500, Daniel Forrest wrote:
> On Thu, Sep 19, 2019 at 08:40:41PM +0000, Trond Myklebust wrote:
> > On Thu, 2019-09-19 at 23:20 +0300, Alkis Georgopoulos wrote:
> > > On 9/19/19 11:05 PM, Trond Myklebust wrote:
> > > > There are plenty of operations that can take longer than 700 ms
> > > > to
> > > > complete. Synchronous writes to disk are one, but COMMIT (i.e.
> > > > the
> > > > NFS
> > > > equivalent of fsync()) can often take much longer even though
> > > > it
> > > > has no
> > > > payload.
> > > > 
> > > > So the problem is not the size of the WRITE payload. The real
> > > > problem
> > > > is the timeout.
> > > > 
> > > > The bottom line is that if you want to keep timeo=7 as a mount
> > > > option
> > > > for TCP, then you are on your own.
> > > > 
> > > 
> > > The problem isn't timeo at all.
> > > If I understand it correctly, when I try to launch firefox over
> > > nfsroot, 
> > > NFS will wait until it fills 1M before "replying" to the
> > > application.
> > > Thus the applications will launch a lot slower, as they get
> > > "disk 
> > > feedback" in larger chunks and not "snappy".
> > > 
> > > In numbers:
> > > timeo=600,rsize=1M => firefox opens in 30 secs
> > > timeo=600,rsize=32k => firefox opens in 20 secs
> > > 
> > 
> > That's a different problem, and is most likely due to readahead
> > causing
> > your client to read more data than it needs to. It is also true
> > that
> > the maximum readahead size is proportional to the rsize and that
> > maybe
> > it shouldn't be.
> > However the VM layer is supposed to ensure that the kernel doesn't
> > try
> > to read ahead more than necessary. It is bounded by the maximum we
> > set
> > in the NFS layer, but it isn't supposed to hit that maximum unless
> > the
> > readahead heuristics show that the application may need it.
> > 
> > -- 
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> 
> What may be happening here is something I have noticed with glibc.
> 
> - statfs reports the rsize/wsize as the block size of the filesystem.
> 
> - glibc uses the block size as the default buffer size for
> fread/fwrite.
> 
> If an application is using fread/fwrite on an NFS mounted file with
> an
> rsize/wsize of 1M it will try to fill a 1MB buffer.
> 
> I have often changed mounts to use rsize/wsize=64K to alleviate this.
> 

That sounds like an abuse of the filesystem block size. There is
nothing in the POSIX definition of either fread() or fwrite() that
requires glibc to do this: 
https://pubs.opengroup.org/onlinepubs/9699919799/functions/fread.html
https://pubs.opengroup.org/onlinepubs/9699919799/functions/fwrite.html


-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



