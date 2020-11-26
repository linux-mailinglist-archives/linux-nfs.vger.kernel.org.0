Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FD22C5247
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Nov 2020 11:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbgKZKrT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Nov 2020 05:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbgKZKrS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Nov 2020 05:47:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31780C0613D4
        for <linux-nfs@vger.kernel.org>; Thu, 26 Nov 2020 02:47:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r3so1644569wrt.2
        for <linux-nfs@vger.kernel.org>; Thu, 26 Nov 2020 02:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3mV/EEGxRzs9QncXkXZkjJlbs5xEn9qBREYM67uga2I=;
        b=QufE6fmdRg44Eb7472ctXWdB13HcDkNXEGlf8Cm4G/1xhnxxgRrNP5ehyU0tml4z5s
         V1lBKYV0qEBlXQiMkLphs1NZfyHBWcSw1Gd9b43PlhXImWjko5H5JRuembPGC0PmzxdQ
         gI9OFsVJClxQoAH99G2gyjNdWKCKAhir3ccq683cw6Hle6GpKADZIUKAo8iwx4LZ7fes
         nqjwJvpn0HC75YQJsR17ZRr4wRF558cXTEi/8PmE/hzRDPlU1s/9EIeXQBw4XDwxrn1b
         Gaq5voqRr9drH1KklSvQC6cMYVkCjF0EDAqf+ieT8RejB+PS3xkSgKQTqBlnVDOjP01r
         Lq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3mV/EEGxRzs9QncXkXZkjJlbs5xEn9qBREYM67uga2I=;
        b=FRdfRKnL+lCHG0RXt7NOkY8gEFL6jWc9WUv+nb5QE1/kQMTI0Jp1030D22FFGSocpA
         tmeMeMDylHLX84gGJN1dLoiyFkMMXnFy5nrPlYBrFiis+1ZtLdaAuOgys7zbewGYSYgE
         7pR8SOPfZXvWcCSNTd1R92MSfsO4csb6sopL7OJAtFBVWxzhkpdzHLbHfq0GosdJOA1U
         gtwDjQtDR17cnPWXsy8fqy4gwb+S8l5QEMDzkkRlrMDtVBLQ7qVIVjtFiVP/EXkvPHWz
         odNmxybAFXgeA86FxY4o3h6vn9zGv5i9mMJss0SndjmsITXu4zDJMcSot7snqhAVLEFV
         syUg==
X-Gm-Message-State: AOAM5324vN43dM5BEC/vP8teWslyctSbGtSTdeMShgJGLHzCorAuhFqH
        j4e3QIW2CRmKGF4NQkZZqgA6xA==
X-Google-Smtp-Source: ABdhPJx1rqBmUCH2DkdlQb9o47nS8OXGcVbwjDxIuIpl4gnwgF0czyLT6AK94YvBbpf4oA7OCDCbFA==
X-Received: by 2002:adf:902d:: with SMTP id h42mr2989099wrh.175.1606387635907;
        Thu, 26 Nov 2020 02:47:15 -0800 (PST)
Received: from gmail.com ([77.126.21.248])
        by smtp.gmail.com with ESMTPSA id d2sm8193116wrn.43.2020.11.26.02.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:15 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:47:12 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: NFS v3 soft mount semantics affected by commit ce368536d
Message-ID: <20201126104712.GA4023536@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Scott, Trond,

Commit ce368536dd614452407dc31e2449eb84681a06af ("nfs: nfs_file_write()
should check for writeback errors") seems to have affected NFS v3 soft
mount behavior, causing applications to fail on a slow band connection
with a properly functioning server. I checked this with recent Linux
5.10-rc5, and on 5.8.18 to where this commit is backported.

Question: while the NFS v4 protocol talks about a soft mount timeout
behavior at "RFC7530 section 3.1.1" (see reference and patchset
addressing it in [1]), is it valid to assume that a similar guarantee
for NFS v3 soft mounts is expected?

The reason why it is important, is because the fulfilment of this
guarantee seemed to have changed with this recent patch.

Details on reproduction - using the following mount option:

    vers=3,rsize=1048576,wsize=1048576,soft,proto=tcp,timeo=50,retrans=16

This is done along with rate limiting on the outgoing interface:

    tc qdisc add dev eth0 root tbf rate 4000kbit latency 1ms burst 1540

And performing following parallel work on the mountpoint:

    for i in `seq 1 100` ; do (dd if=/dev/zero of=x$i &) ; done

Result is that EIOs are returned to `dd`, whereas without this commit
the IOs simply performed slowly, and no errors observed by dd. It
appears in traces that the NFS layer is doing the retries.

[1] https://patchwork.kernel.org/project/linux-nfs/cover/20190328205239.29674-1-trond.myklebust@hammerspace.com/

-- 
Dan Aloni
