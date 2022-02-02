Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2189D4A74A3
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 16:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiBBPdU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Feb 2022 10:33:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230120AbiBBPdT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Feb 2022 10:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643815999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcZyagxSAlt/rhxT7bS3IRxtr/x6PRT/yV6ozIczlII=;
        b=e7twmKH4iXHgk0lpDRpQaqzWIsvclyPv4W8Al6CuxBLjbTUoKjWybq7irv9AvOjm/RCs0q
        Q/qFjbM58IkUXguuMsRDHfHbfC6Cj/uGKzYlNqzIJxq2Oe/4qT2nlvIYDw4IL/tfFxTJgB
        3SYUtiubv8Eu+No9v0QPRiE3nkrFFp8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-J7LNwemJPgagZWp1o2QhYw-1; Wed, 02 Feb 2022 10:33:18 -0500
X-MC-Unique: J7LNwemJPgagZWp1o2QhYw-1
Received: by mail-qt1-f200.google.com with SMTP id h5-20020ac87765000000b002cff8751c63so15740507qtu.3
        for <linux-nfs@vger.kernel.org>; Wed, 02 Feb 2022 07:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IcZyagxSAlt/rhxT7bS3IRxtr/x6PRT/yV6ozIczlII=;
        b=4KhI9k3Ujiu9KTzXoz/NzwCm9GE0GDzIpTgxhpGOzSW1hvkhpiYCNYDncECrf2NV9H
         CTnRSTcNUZ+RP81a0eat4FRtjoNqY2ELMk9FQxxxPqf9e6btOIr1hTq4i+DM9UeCl2k3
         sVCgEkOnAHGWA5maKJksA4XWlkBOlai6bhu4WqGJlY3hIcegEAfCUOh+8MHAKX+wCDzS
         S0ZLZcJzXRjMqRDgV4MMJ3513TpH/Ed5oXgblMVG+VMcLQ+/fmgI4d3YgT50O5nL15Ur
         J2MAWFJf+6ge4JfNRn34Lcxf0hQgtX8HpZog204X6AWzqxx9W4PTk5N66FnRnIH3KvFG
         9uaA==
X-Gm-Message-State: AOAM533p5ZKpueP67w5Va3s8NcrFTnHV1wPQbRdgU6bk6sB7N8N/k+1V
        mSv3C0iXQneeVjSroNsz3w0eWQdBvVAVQvjoUupWx6e6OssEV1U8Ch0mP9Tkjx16nBrqqKGOVPq
        2zB897daTdZgQtXs/Cqvq
X-Received: by 2002:a05:622a:1446:: with SMTP id v6mr14677185qtx.523.1643815997744;
        Wed, 02 Feb 2022 07:33:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMuGVjABmo22Djky2NiNzI/e8REXFJ8gSvTeIsr2qqIQ46dDgufe7zk/L/5JY7fsrW4w4c3g==
X-Received: by 2002:a05:622a:1446:: with SMTP id v6mr14677152qtx.523.1643815997410;
        Wed, 02 Feb 2022 07:33:17 -0800 (PST)
Received: from [172.31.1.6] ([71.161.85.11])
        by smtp.gmail.com with ESMTPSA id 187sm11739096qkm.63.2022.02.02.07.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 07:33:17 -0800 (PST)
Message-ID: <0b953bc7-9f50-e23b-9802-c5552b149ce8@redhat.com>
Date:   Wed, 2 Feb 2022 10:33:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 1/9] rpcctl: Add a rpcctl.py tool
Content-Language: en-US
To:     David Wysochanski <dwysocha@redhat.com>, schumaker.anna@gmail.com
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
 <20220127194952.63033-2-Anna.Schumaker@Netapp.com>
 <CALF+zOmodpOP4HqNZykYQVCcr+i11r6bNSWpGViAnfJzVwHsbw@mail.gmail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <CALF+zOmodpOP4HqNZykYQVCcr+i11r6bNSWpGViAnfJzVwHsbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Dave!

On 2/1/22 10:57, David Wysochanski wrote:
> On Thu, Jan 27, 2022 at 2:50 PM <schumaker.anna@gmail.com> wrote:
> 
> Might want to rework some of the directory related code to ensure you
> handle disappearing entries.  Got Tracebacks (see below) while running
> a series of tests that would:
> - mount
> - run some IO
> - umount
I guess I'm curious what your exception is...

Shouldn't rpcctl fail after a umount or is your
concern about how the command is failing?

steved.
> 
> 
> [root@dwysocha-fedora-node1 nfs-utils]# while true; do
> ./tools/rpcctl/rpcctl.py xprt; done | grep -B 5 -A 5 Traceback
> Traceback (most recent call last):
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
>      args.func(args)
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 112, in list_all
>      xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 112, in <listcomp>
>      xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
>    File "/usr/lib64/python3.10/pathlib.py", line 1032, in glob
>      for p in selector.select_from(self):
>    File "/usr/lib64/python3.10/pathlib.py", line 492, in _select_from
>      for starting_point in self._iterate_directories(parent_path,
> is_dir, scandir):
>    File "/usr/lib64/python3.10/pathlib.py", line 482, in _iterate_directories
>      for p in self._iterate_directories(path, is_dir, scandir):
>    File "/usr/lib64/python3.10/pathlib.py", line 471, in _iterate_directories
>      with scandir(parent_path) as scandir_it:
> FileNotFoundError: [Errno 2] No such file or directory:
> '/sys/kernel/sunrpc/xprt-switches/switch-4'
> Traceback (most recent call last):
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
>      args.func(args)
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 112, in list_all
>      xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 112, in <listcomp>
>      xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
>    File "/usr/lib64/python3.10/pathlib.py", line 1032, in glob
>      for p in selector.select_from(self):
>    File "/usr/lib64/python3.10/pathlib.py", line 492, in _select_from
>      for starting_point in self._iterate_directories(parent_path,
> is_dir, scandir):
>    File "/usr/lib64/python3.10/pathlib.py", line 482, in _iterate_directories
>      for p in self._iterate_directories(path, is_dir, scandir):
>    File "/usr/lib64/python3.10/pathlib.py", line 471, in _iterate_directories
>      with scandir(parent_path) as scandir_it:
> FileNotFoundError: [Errno 2] No such file or directory:
> '/sys/kernel/sunrpc/xprt-switches/switch-2'
> 
> 
> 
> 
> [root@dwysocha-fedora-node1 nfs-utils]# while true; do
> ./tools/rpcctl/rpcctl.py client; done | grep -B 10 -A 10 Traceback
> Traceback (most recent call last):
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
>      args.func(args)
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
>      self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
>    File "/usr/lib64/python3.10/pathlib.py", line 1159, in readlink
>      path = self._accessor.readlink(self)
> FileNotFoundError: [Errno 2] No such file or directory:
> '/sys/kernel/sunrpc/rpc-clients/clnt-3/switch'
> Traceback (most recent call last):
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
>      args.func(args)
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
>      self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
>    File "/usr/lib64/python3.10/pathlib.py", line 1159, in readlink
>      path = self._accessor.readlink(self)
> FileNotFoundError: [Errno 2] No such file or directory:
> '/sys/kernel/sunrpc/rpc-clients/clnt-7/switch'
> Traceback (most recent call last):
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
>      args.func(args)
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
>      self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 148, in __init__
>      self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 148, in <listcomp>
>      self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 49, in __init__
>      self.read_state()
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 81, in read_state
>      self.state = ','.join(f.readline().split()[1:])
> OSError: [Errno 19] No such device
> Traceback (most recent call last):
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
>      args.func(args)
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
>      self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 148, in __init__
>      self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 148, in <listcomp>
>      self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
>    File "/usr/lib64/python3.10/pathlib.py", line 1015, in iterdir
>      for name in self._accessor.listdir(self):
> FileNotFoundError: [Errno 2] No such file or directory:
> '/sys/kernel/sunrpc/rpc-clients/clnt-9/../../xprt-switches/switch-2'
> Traceback (most recent call last):
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
>      args.func(args)
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
>      clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
>    File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
>      self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
>    File "/usr/lib64/python3.10/pathlib.py", line 1159, in readlink
>      path = self._accessor.readlink(self)
> FileNotFoundError: [Errno 2] No such file or directory:
> '/sys/kernel/sunrpc/rpc-clients/clnt-5/switch'
> ^C
> 

