Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68304B13D8
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 18:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbiBJRGe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 12:06:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbiBJRGb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 12:06:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D0ABC11
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644512791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqcFHkrCMZND7jQ0sYdFTWwJe1vtUYTO7um4P+ZKYHM=;
        b=HoD5yDTxU4gZoyVRPFgam/LUZuQadPPUq6qYBTUhCFga4g27/roqQ5NZfwYlY5EFvYiJop
        28k+HE1f4UmcS1NtyX4+91frtYmLLVEQJ3RpA49RF+tJUuKUJ5za+nBuEiYfEn7hYFSM1P
        HJpwAEPzKfGMJXJUgWVkIcYBzw5mjl4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-RhnlD5LBNuCC3-NoaKFgKw-1; Thu, 10 Feb 2022 12:06:29 -0500
X-MC-Unique: RhnlD5LBNuCC3-NoaKFgKw-1
Received: by mail-lj1-f197.google.com with SMTP id p6-20020a2e8046000000b0023e1f44053bso2856273ljg.0
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 09:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqcFHkrCMZND7jQ0sYdFTWwJe1vtUYTO7um4P+ZKYHM=;
        b=gS1uIxn3Ub/R69fZorQaJAtAeilocX0Gdyl2+K4AcPzAwm1qEkR0w1kcPUl/7mEoEf
         pjVGBGWmAE6nF6aSrq5nBYmOzOYD6S2QckkRMAw3BN7bxGweveK6BabPlhCxWE8MZp+L
         Cr0YjP2QbnpwZZtOz58dEt0qKeo8CyzZlgPXF7PoeGw4T4KjOlv+nOj8aGDzQ1JVmg8Y
         hydbCs2DKfxCwLufxWp3YBJYKEllPJUhOUkTDyq7ZMk1MmNxUIQNNFbQHxH/Tg5265Av
         BJeAzZHPQqB2LP+hP83B375ht72ocaxp/scTjMsvEm1+owYHdUIPuwRQiSIBcSHY7/Pu
         0gYQ==
X-Gm-Message-State: AOAM532oVo/dnS+7l21H1Exh7HhcYHYifNq8ur9eezOT4uxLkfNHBdqA
        vh/jeOPLt1ZVfaVk8wf1XX0S43psmZXB1pFMCP6Lj++Ar5ALM3vo49Y97wExjOYo7bQ1z+APj8X
        hS4oXI2LSd0zQGvfgIHojlcpC1RQyGHQzLkk0
X-Received: by 2002:a05:651c:507:: with SMTP id o7mr5411215ljp.56.1644512786659;
        Thu, 10 Feb 2022 09:06:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQb/w/zmSYEojHTtDoFcsE6qSqDJZyx77ndyZezFVj6+0qZJPON3VwBelkyS1E0YVeRTVSlHdOev4DnLqt3eQ=
X-Received: by 2002:a05:651c:507:: with SMTP id o7mr5411188ljp.56.1644512786331;
 Thu, 10 Feb 2022 09:06:26 -0800 (PST)
MIME-Version: 1.0
References: <CA+-cMpFmMr8FQKODmR5JAB8rZhzptZ_KPX5DasLM_sbvbko+GA@mail.gmail.com>
 <CA+-cMpHHeK1zSMTQiYtd5GuL2UVp8n-BY228aeUUrQq5KCOc2A@mail.gmail.com>
 <CAFX2Jfk4QquitkteegAXBfF0HMM0cGiCgLJPfdhESPBuDswrbw@mail.gmail.com>
 <CA+-cMpG8pbARdWSHyQG0mcg8ZJi6UntZSJk8555+OE5Ra5C2aw@mail.gmail.com>
 <CA+-cMpGC5r7poAjQ65Tm97cEcyjMoZUzYCdfBnD-CziS-yKsOA@mail.gmail.com> <CA+-cMpH3D2YjE8cc_JPHdeW451WZaSN9seZUR4L-9Jre1VgToA@mail.gmail.com>
In-Reply-To: <CA+-cMpH3D2YjE8cc_JPHdeW451WZaSN9seZUR4L-9Jre1VgToA@mail.gmail.com>
From:   Rahul Rathore <rrathore@redhat.com>
Date:   Thu, 10 Feb 2022 22:36:14 +0530
Message-ID: <CA+-cMpHgPH6jFL=4tgCM5=hciFh6V3SJa18BoD2q5Xgx+jXdvw@mail.gmail.com>
Subject: Re: Testing Results - Add a tool for using the new sysfs files - rpcctl
To:     Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Schumaker Anna <Anna.Schumaker@netapp.com>
Cc:     David Wysochanski <dwysocha@redhat.com>,
        Gonzalo Siero Humet <gsierohu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Anna,

Hope you are well.

Yes , now making the NIC down doesn't show any call traces.

However, I am adding to Yesterday's mail.

When my NFS Server IP is 192.168.122.127, it allowed to change switch
to 192.168.122.30. However, nfs connection then was in syn_sent and
nfs was not responding.

Now, if I set my IP back to 192.168.122.127, the command simply hangs.
I am attaching the last 10 lines of strace.
# strace -T -tt -f -v -s 4096 -o /tmp/out.txt ./tools/rpcctl/rpcctl.py
switch set --id 2 --dstaddr 192.168.122.127


18937 11:28:58.225547 close(3)          = 0 <0.000010>
18937 11:28:58.225608 mprotect(0x7f7c83128000, 4096, PROT_READ) = 0 <0.000015>
18937 11:28:58.225993 brk(0x55d7df53d000) = 0x55d7df53d000 <0.000029>
18937 11:28:58.227163 openat(AT_FDCWD,
"/sys/kernel/sunrpc/xprt-switches/switch-2/xprt-3-tcp/dstaddr",
O_WRONLY|O_CREAT|O_TRUNC|O_CLOEXEC, 0666) = 3 <0.000030>
18937 11:28:58.227241 newfstatat(3, "", {st_dev=makedev(0, 0x17),
st_ino=25021, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0,
st_blksize=4096, st_blocks=0, st_size=4096, st_atime=1644251948 /*
2022-02-07T11:39:08.446981173-0500 */, st_atime_nsec=446981173,
st_mtime=1644510538 /* 2022-02-10T11:28:58.225300241-0500 */,
st_mtime_nsec=225300241, st_ctime=1644510538 /*
2022-02-10T11:28:58.225300241-0500 */, st_ctime_nsec=225300241},
AT_EMPTY_PATH) = 0 <0.000013>
18937 11:28:58.227349 ioctl(3, TCGETS, 0x7ffe44427570) = -1 ENOTTY
(Inappropriate ioctl for device) <0.000016>
18937 11:28:58.227407 lseek(3, 0, SEEK_CUR) = 0 <0.000010>
18937 11:28:58.227449 ioctl(3, TCGETS, 0x7ffe44427390) = -1 ENOTTY
(Inappropriate ioctl for device) <0.000010>
18937 11:28:58.227503 lseek(3, 0, SEEK_CUR) = 0 <0.000010>
18937 11:28:58.227551 write(3, "192.168.122.127",
15[root@rrathore-upstream-sysfs ~]#
[root@rrathore-upstream-sysfs ~]#
[root@rrathore-upstream-sysfs ~]# tail /tmp/out.txt
18937 11:28:58.225547 close(3)          = 0 <0.000010>
18937 11:28:58.225608 mprotect(0x7f7c83128000, 4096, PROT_READ) = 0 <0.000015>
18937 11:28:58.225993 brk(0x55d7df53d000) = 0x55d7df53d000 <0.000029>
18937 11:28:58.227163 openat(AT_FDCWD,
"/sys/kernel/sunrpc/xprt-switches/switch-2/xprt-3-tcp/dstaddr",
O_WRONLY|O_CREAT|O_TRUNC|O_CLOEXEC, 0666) = 3 <0.000030>
18937 11:28:58.227241 newfstatat(3, "", {st_dev=makedev(0, 0x17),
st_ino=25021, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0,
st_blksize=4096, st_blocks=0, st_size=4096, st_atime=1644251948 /*
2022-02-07T11:39:08.446981173-0500 */, st_atime_nsec=446981173,
st_mtime=1644510538 /* 2022-02-10T11:28:58.225300241-0500 */,
st_mtime_nsec=225300241, st_ctime=1644510538 /*
2022-02-10T11:28:58.225300241-0500 */, st_ctime_nsec=225300241},
AT_EMPTY_PATH) = 0 <0.000013>
18937 11:28:58.227349 ioctl(3, TCGETS, 0x7ffe44427570) = -1 ENOTTY
(Inappropriate ioctl for device) <0.000016>
18937 11:28:58.227407 lseek(3, 0, SEEK_CUR) = 0 <0.000010>
18937 11:28:58.227449 ioctl(3, TCGETS, 0x7ffe44427390) = -1 ENOTTY
(Inappropriate ioctl for device) <0.000010>
18937 11:28:58.227503 lseek(3, 0, SEEK_CUR) = 0 <0.000010>
18937 11:28:58.227551 write(3, "192.168.122.127", 15


So in the new Kernel I see issues with xprt set which I sent yesterday
and IP doesn't set to previous for switch which I explained above.

Regards,
Rahul


On Wed, Feb 9, 2022 at 10:50 PM Rahul Rathore <rrathore@redhat.com> wrote:
>
> Hello Anna,
>
> I am yet to do more tests.
>
> However, I will share what I have done till now.
>
> I have upgraded to 5.16.5-200.fc35.x86_64 and some of the problems have
> disappeared.
>
> However, some still exist.
>
> 1- I am still unable to run xprt commands.
>
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 3 --offline
> [Errno 22] Invalid argument
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 3 192.168.122.29 --offline
> usage: rpcctl.py [-h] {client,switch,xprt} ...
> rpcctl.py: error: unrecognized arguments: 192.168.122.29
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 3 --dstaddr 192.168.122.29 --offline
> [Errno 22] Invalid argument
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 3 192.168.122.127 --offline
> usage: rpcctl.py [-h] {client,switch,xprt} ...
> rpcctl.py: error: unrecognized arguments: 192.168.122.127
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 1 --dstaddr 192.168.122.29 --offline
> [Errno 95] Operation not supported
> [root@rrathore-upstream-sysfs nfs-utils]#
>
> If I am doing something wrong, kindly provide some examples.
>
> 2- However, the switch command worked.
>
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py switch
> set --id 2 --dstaddr 192.168.122.30
> switch 2: xprts 1, active 1, queue 1
> xprt 3: tcp, 192.168.122.30
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py switch
> switch 0: xprts 1, active 1, queue 0
> xprt 0: local, /var/run/rpcbind.sock [main]
> switch 1: xprts 1, active 1, queue 0
> xprt 1: local, /var/run/gssproxy.sock [main]
> switch 2: xprts 1, active 1, queue 1
> xprt 3: tcp, 192.168.122.30
>
> Now I see:-
> [root@rrathore-upstream-sysfs nfs-utils]# ss | grep -i nfs
> tcp   SYN-SENT 0      1                        192.168.122.125:883
> 192.168.122.30:nfs
>
> This is picking correct info:-
>
> cat /sys/kernel/debug/sunrpc/rpc_clnt/*/xprt/info
> addr:  192.168.122.30
> port:  2049
> state: 0x15
> netid: tcp
> addr:  192.168.122.30
> port:  2049
> state: 0x15
>
>
> I am not sure of the motive of this command. Is the motive to set IP of NFS
> Server to set/change from Client.
>
> Though the current O/P and all is correct. But in this manner NFS will
> suffer. cd / ls or any other operation over nfs will hang like below:-
>
> [root@rrathore-upstream-sysfs nfs-utils]# df -h
>
> ^C
>
> If the motive was to set NFS Server IP, then it fails to do so as my NFS
> Server IP is still an old one and not 192.168.122.30.
>
>
> Just a suggestion, if you can post some examples in your man page it will
> be great.
>
>
> I am still performing some tests. Will keep you posted.
>
> Regards,
> Rahul



-- 

Thanks & Regards,

Rahul Rathore

STSE| Global Support Services
Red Hat India Private Limited, Pune
Ext: 8367125| Mob-9651798912 |IRC: rrathore

