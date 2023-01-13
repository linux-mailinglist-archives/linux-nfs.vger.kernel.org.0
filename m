Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB55C66A0E2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 18:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjAMRnP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 13 Jan 2023 12:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAMRmw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 12:42:52 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6B18B750
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 09:29:15 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id p96so3126138qvp.13
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 09:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DaxMQYrDmGaF4UOufODkCg8zG26olyUN9kdhHg+rpy4=;
        b=2sg805kdM3jBvZ7Ri71yWW8Y/Wx5tJqM9PCLPPzvmqFBEAReY7z0Qro6wTEiTzPEbC
         CacrGenwD0oPk9nKCZ8P3ftDcnAA1zTeLiWf69MW+15Hd5+TH4ZleWLR4HFNAqJEqhlc
         qFH1pg9EuWh2FRfiq/wGYl+tL0vIuR5GBJP+oETboKVAn0g0g17rYWPBCRYMq1PveqXj
         827xTLJEhT/5lSH/zDE7/ThiuWzvDbRmcMbczg2shFYzaAtxRz7adeqPZd5a6fz4yee2
         ORhL8rJk9Gdw/76y9AA0zOcOpE3EZYmkQzVakMc5QBZ0u/s8tw/vtuNcBDfmKLvOmnEr
         Y+JQ==
X-Gm-Message-State: AFqh2krfk4AZpVlRE7AdWpm/zuZYDEQWpgf3kl62ISWCGD1SfShVGGN4
        X7iwvZF6a+Z+F/CFAfKAYA==
X-Google-Smtp-Source: AMrXdXuh9zn/qqa0r97HcR0u4vb28plbzw/Pgirw1rJkZjCioJnichKzTY+/DDn7D7Nvhdt9xJCdZQ==
X-Received: by 2002:a05:6214:350d:b0:4c6:90c6:b427 with SMTP id nk13-20020a056214350d00b004c690c6b427mr119445179qvb.39.1673630954363;
        Fri, 13 Jan 2023 09:29:14 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b00705c8cce5dcsm2186072qkb.111.2023.01.13.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:29:14 -0800 (PST)
Message-ID: <4dcdb8161d2590527610a18c92c9f64329709f8d.camel@kernel.org>
Subject: Re: a dead lock of 'umount.nfs4 /nfs/scratch -l'
From:   Trond Myklebust <trondmy@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Charles Edward Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 13 Jan 2023 12:29:13 -0500
In-Reply-To: <20230114010628.D465.409509F4@e16-tech.com>
References: <5B9215E4-99FF-4C52-901F-8D909DD165BD@oracle.com>
         <FBFF4BF0-EC67-472B-9B8A-A0891B1EFA90@hammerspace.com>
         <20230114010628.D465.409509F4@e16-tech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2023-01-14 at 01:06 +0800, Wang Yugui wrote:
> Hi,
> 
> > 
> > > On Jan 13, 2023, at 09:41, Chuck Lever III
> > > <chuck.lever@oracle.com> wrote:
> > > 
> > > 
> > > 
> > > > On Jan 12, 2023, at 4:30 AM, Wang Yugui
> > > > <wangyugui@e16-tech.com> wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > > Hi,
> > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > We noticed a dead lock of 'umount.nfs4 /nfs/scratch -l'
> > > > > 
> > > > > reproducer:
> > > > > 
> > > > > mount /dev/sda1 /mnt/test/
> > > > > mount /dev/sda2 /mnt/scratch/
> > > > > systemctl restart nfs-server.service
> > > > > mount.nfs4 127.0.0.1:/mnt/test/ /nfs/test/
> > > > > mount.nfs4 127.0.0.1:/mnt/scratch/ /nfs/scratch/
> > > > > systemctl stop nfs-server.service
> > > > > umount -l /nfs/scratch #OK
> > > > > umount -l /nfs/test #dead lock
> > > > > 
> > > > > Best Regards
> > > > > Wang Yugui (wangyugui@e16-tech.com)
> > > > > 2023/01/11
> > > > > 
> > > > > > kernel: 6.1.5-rc1
> > > > 
> > > > This problem happen on kernel 6.2.0-rc3+(upstream) too.
> > > 
> > > Can you clarify:
> > > 
> > > - By "deadlock" do you mean the system becomes unresponsive, or
> > > that
> > >  just the mount is stuck?
> > > 
> > > - Can you reproduce in a non-loopback scenario: a separate client
> > > and
> > >  server?
> > > 
> > 
> > I’m not seeing how the use of the ‘-l’ flag is at all relevant
> > here. The exact same thing will happen if you don’t use ‘-l’. All
> > the latter does is hide the fact that it is happening from user
> > space.
> > 
> > As far as I’m concerned, this is pretty much expected behaviour
> > when you turn off the server before unmounting. It means that the
> > client can’t flush any remaining dirty data to the server and it
> > can’t clean up state. So just don’t do that?
> 
> In the case, 'df -h' will fail to work without the 'umount -l'.
> 
> so I thought we should make 'umount -l' to works.
> 

The NFS filesystem doesn't know or care about the flags you use to call
the umount() system call. That's all handled by the VFS.
All NFS knows is that the VFS told it to clean up the super block
because it is no longer in use.

The calls to nfs4_proc_destroy_session() and nfs4_destroy_clientid()
will both eventually time out and allow the unmount to complete. So it
is not as if this is a permanent hang that forces you to reboot.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


