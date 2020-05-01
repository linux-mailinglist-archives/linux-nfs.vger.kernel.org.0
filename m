Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B271C1D92
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 21:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgEATEE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729839AbgEATEE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 15:04:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D846DC061A0C;
        Fri,  1 May 2020 12:04:03 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b1so8715544qtt.1;
        Fri, 01 May 2020 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=UA0ayibRE5dL2/MbtrvDBj4QFREYWSaM6IfMZBxoU6E=;
        b=nY7+EmtE6R+Rvr46ZWuNaBGDCd/udsPKPGmA1fQqvrw0jS6G45hSMCYTgXguPLV7Mp
         jciSDtT8voRHswQ2yPttVTO7f1DGXxRmuEPZrgly0o958cFk8x7+tDNnYcucyu32bqyz
         Ox4QlZwpU/B7Svv3vXx0gJbgNqgmoSfKZwxUjDVf21Zb32pXLCxiDBYyBmEQQkwonceW
         Kyal8IZ1emAKdY/wM78jL7xb3Zm9qPzKJRdbMlu4LqqtoKrrffZ/bXuVhv353cUnOYLK
         q0oFZ7oDwV+8Vwcwb4H59PaK0N1oZq6bR1kybaNgHR+sMT+9MJBnaVAcRDDryGs0CVmH
         emTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UA0ayibRE5dL2/MbtrvDBj4QFREYWSaM6IfMZBxoU6E=;
        b=srYB5qkWZ00mAlGpIkkPQ9EFr6HxdNaDlgnzNJ41W7FuELQ2FILPe8efnIvHhN/FYF
         3PMm9UhUPvEnDnMIGgwJYwCWnFpFLQ2p9E3bGmr3LnXQzuJnYDY3oVcdyPrDuZd30d5k
         +lF+KmAZW6bAVSoeJaxl8ENOYQe/h2ydth79RIb1BQzbhrnfeCoCYdJlr+3WQfGze7gb
         kB3yUsYQY0EZoSfGSXprKmXsmmWrrJEbzjJFg3JJFgXZSL2E6tt2MCtQDvdytv6Mmlon
         DI7tN5TdlifLEDI5oxq4ifD93S+sQdOirl4zb2kKZZxHvSnejA3cJdODfU5tW9B4CGUy
         uchA==
X-Gm-Message-State: AGi0Pubh0yBnAg5+whbfHDBweKfkr8HbJjtNuG0ej1zjiDjPT/uu66SK
        2G3HV5IOW5gUt0ek72fB09zEQr6A
X-Google-Smtp-Source: APiQypLWr7CIek9YkleTx0gwqgRbBy8H8s47k2Fdny5/JBoHfiPIUwZvybeAoG5oJDvhaxYMH2+1+w==
X-Received: by 2002:ac8:745:: with SMTP id k5mr5188702qth.379.1588359842698;
        Fri, 01 May 2020 12:04:02 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p10sm3113670qtu.14.2020.05.01.12.04.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 12:04:01 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041J40qM026981;
        Fri, 1 May 2020 19:04:00 GMT
Subject: [PATCH RFC] Frequent connection loss using krb5[ip] NFS mounts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org
Date:   Fri, 01 May 2020 15:04:00 -0400
Message-ID: <20200501184301.2324.22719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

Over the past year or so I've observed that using sec=krb5i or
sec=krb5p with NFS/RDMA while testing my Linux NFS client and server
results in frequent connection loss. I've been able to pin this down
a bit.

The problem is that SUNRPC's calls into the kernel crypto functions
can sometimes reschedule. If that happens between the time the
server receives an RPC Call and the time it has unwrapped the Call's
GSS sequence number, the number is very likely to have fallen
outside the GSS context's sequence number window. When that happens,
the server is required to drop the Call, and therefore also the
connection.

I've tested this observation by applying the following naive patch to
both my client and server, and got the following results.

I. Is this an effective fix?

With sec=krb5p,proto=rdma, I ran a 12-thread git regression test
(cd git/; make -j12 test).

Without this patch on the server, over 3,000 connection loss events
are observed. With it, the test runs on a single connection. Clearly
the server needs to have some kind of mitigation in this area.


II. Does the fix cause a performance regression?

Because this patch affects both the client and server paths, I
tested the performance differences between applying the patch in
various combinations and with both sec=krb5 (which checksums just
the RPC message header) and krb5i (which checksums the whole RPC
message.

fio 8KiB 70% read, 30% write for 30 seconds, NFSv3 on RDMA.

-- krb5 --

unpatched client and server:
Connect count: 3
read: IOPS=84.3k, 50.00th=[ 1467], 99.99th=[10028] 
write: IOPS=36.1k, 50.00th=[ 1565], 99.99th=[20579]

patched client, unpatched server:
Connect count: 2
read: IOPS=75.4k, 50.00th=[ 1647], 99.99th=[ 7111]
write: IOPS=32.3k, 50.00th=[ 1745], 99.99th=[ 7439]

unpatched client, patched server:
Connect count: 1
read: IOPS=84.1k, 50.00th=[ 1467], 99.99th=[ 8717]
write: IOPS=36.1k, 50.00th=[ 1582], 99.99th=[ 9241]

patched client and server:
Connect count: 1
read: IOPS=74.9k, 50.00th=[ 1663], 99.99th=[ 7046]
write: IOPS=31.0k, 50.00th=[ 1762], 99.99th=[ 7242]

-- krb5i --

unpatched client and server:
Connect count: 6
read: IOPS=35.8k, 50.00th=[ 3228], 99.99th=[49546]
write: IOPS=15.4k, 50.00th=[ 3294], 99.99th=[50594]

patched client, unpatched server:
Connect count: 5
read: IOPS=36.3k, 50.00th=[ 3228], 99.99th=[14877]
write: IOPS=15.5k, 50.00th=[ 3294], 99.99th=[15139]

unpatched client, patched server:
Connect count: 3
read: IOPS=35.7k, 50.00th=[ 3228], 99.99th=[15926]
write: IOPS=15.2k, 50.00th=[ 3294], 99.99th=[15926]

patched client and server:
Connect count: 3
read: IOPS=36.3k, 50.00th=[ 3195], 99.99th=[15139]
write: IOPS=15.5k, 50.00th=[ 3261], 99.99th=[15270]


The good news:
Both results show that I/O tail latency improves significantly when
either the client or the server has this patch applied.

The bad news:
The krb5 performance result shows an IOPS regression when the client
has this patch applied.


So now I'm trying to understand how to come up with a solution that
prevents the rescheduling/connection loss issue without also
causing a performance regression.

Any thoughts/comments/advice appreciated.

---

Chuck Lever (1):
      SUNRPC: crypto calls should never schedule

--
Chuck Lever
