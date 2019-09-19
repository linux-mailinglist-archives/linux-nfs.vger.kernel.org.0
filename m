Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24CDB8153
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 21:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390262AbfISTVV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 15:21:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36580 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfISTVV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 15:21:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so4322044wrd.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yx5c1eDpPIEUL85UUwQ2AAQSAYipNiEwUcjrgRxGjII=;
        b=C1bLP/ONd/VKxOyuMZ49Ak1tLwfdxNlb8EoCD1TQ9wDyBd5MYGdplZVygwKGd9/zqF
         mRyRT4u7Gc3ar9FPBlxjKYl1V5e9UqnHLCSHwaESe1MQBS8k60CyVstBG0beRojfYmAb
         VdjMR3pTb4eDOrtbR8+KjGupdtwcQeQctTJwUQWCCHNlZ2KKKbNFIBxZXibcOESpf6JV
         K5jAlGHpFJScMhtuk3ny+6VZnf67XCKY3l+/ONF53MAT5iK6JyAvdhFienvcTdFxk9Zi
         iJO1olVdSl+rpvIDKDlaYLMo5Cz4UdAW13NiBmUIcCkPYC7Z/G2gIYqt/2sp8rlO3DAc
         W/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yx5c1eDpPIEUL85UUwQ2AAQSAYipNiEwUcjrgRxGjII=;
        b=Z3TyAWAA9mSl5h/4PVmatjH/UXcOf/XKkEN3KpL7O4oGulyMa4pZERGkBkkbCw3RcS
         JG7tbGJ7KsoF205PgFktAxgxCgRYDgenEj9nBznjHMwMxJa6QKQ3e/5MirwPzxuribxR
         ME5YFe4OFH26QlMiVpwSaaaSVPQQuDLWhecykdD76fBNp26RlHN+gNHhTlbjtSuH3DJs
         FbRsD9fmrrrf2Y7aMxEVxetBkJGxR7/0DnI7SBnqs0Os1Z5pXRwgZ9SDf0eVx/tHTQup
         RUQOAnj7jXaqHtr6UH6ZtdNPbK1LXVGuAHlgdYiMl9Emt5bo65k6ROOJr4R13nDpuf2I
         GHJA==
X-Gm-Message-State: APjAAAUX9raWOcWGrWp2cP3ygE6q/WF8SRKB8+CJatCd94s2rIgknPh1
        8IzH2z2upJgPH2u2ftEIvG19TCxg
X-Google-Smtp-Source: APXvYqxbh5qJp+foMgCMLPbo5ZUshA8h8rbsyHAXid/eQPUTD0rEKAklznUyVnkVzI6VYnk1+KnmQQ==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr8453206wrm.114.1568920878763;
        Thu, 19 Sep 2019 12:21:18 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id f3sm7628650wrq.53.2019.09.19.12.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 12:21:18 -0700 (PDT)
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
 <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
 <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
 <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
From:   Alkis Georgopoulos <alkisg@gmail.com>
Message-ID: <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
Date:   Thu, 19 Sep 2019 22:21:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/19/19 7:11 PM, Trond Myklebust wrote:
> No. It is not a problem, because nfs-utils defaults to using TCP
> mounts. Fragmentation is only a problem with UDP, and we stopped
> defaulting to that almost 2 decades ago.
> 
> However it may well be that klibc is still defaulting to using UDP, in
> which case it should be fixed. There are major Linux distros out there
> today that don't even compile in support for NFS over UDP any more.


I haven't tested with UDP at all; the problem was with TCP.
I saw the problem in klibc nfsmount with TCP + NFS 3,
and in `mount -t nfs -o timeo=7 server:/share /mnt` with TCP + NFS 4.2.

Steps to reproduce:
1) Connect server <=> client at 10 or 100 Mbps.
Gigabit is also "less snappy" but it's less obvious there.
For reliable results, I made sure that server/client/network didn't have 
any other load at all.

2) Server:
echo '/srv *(ro,async,no_subtree_check)' >> /etc/exports
exportfs -ra
truncate -s 10G /srv/10G.file
The sparse file ensures that disk IO bandwidth isn't an issue.

3) Client:
mount -t nfs -o timeo=7 192.168.1.112:/srv /mnt
dd if=/mnt/10G.file of=/dev/null status=progress

4) Result:
dd there starts with 11.2 MB/sec, which is fine/expected,
and it slowly drops to 2 MB/sec after a while,
it lags, omitting some seconds in its output line,
e.g. 507510784 bytes (508 MB, 484 MiB) copied, 186 s, 2,7 MB/s^C,
at which point "Ctrl+C" needs 30+ seconds to stop dd,
because of IO waiting etc.

In another terminal tab, `dmesg -w` is full of these:
[  316.404250] nfs: server 192.168.1.112 not responding, still trying
[  316.759512] nfs: server 192.168.1.112 OK

5) Remarks:
With timeo=600, there are no errors in dmesg.
The fact that timeo=7 (the nfsmount default) causes errors, proves that 
some packets need more than 0.7 secs to arrive.
Which in turn explains why all the applications open extremely slowly 
and feel sluggish on netroot = 100 Mbps, NFS, TCP.

Lowering rsize,wsize from 1M to 32K solves all those issues without any 
negative side effects that I can see. Even on gigabit, 32K makes 
applications a lot more snappy so it's better even there.
On 10 Mbps, rsize=1M is completely unusable.

So I'm not sure where rsize=1M is a better default. Is it only for 10G+ 
connections?

Thank you very much,
Alkis Georgopoulos
