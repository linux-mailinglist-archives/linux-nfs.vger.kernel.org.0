Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D584A60D9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Feb 2022 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiBAP6a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Feb 2022 10:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237158AbiBAP63 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Feb 2022 10:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643731109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZypiyxpCcuEyM1ySNhbfCIbOxAuGxHr+z3CxNGHnfjY=;
        b=Jj700g1OYIjy6mGWwZvq+vNdkmVO4Wge1hQUGg8xCF5cZOD4PyKfcXdxKJ0eyP6uKh38V+
        PC+S/nPdvVDYy1x0/nC2gy8oS6IF+S3G1RQYcWvGJmcTxUhxgKU+7vR34/l+isXaPSBctK
        7wp3tgteL59LVIYkrFwNFqAtlMPiu3s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-lHUZM5_SNsKzIfdytcskqw-1; Tue, 01 Feb 2022 10:58:28 -0500
X-MC-Unique: lHUZM5_SNsKzIfdytcskqw-1
Received: by mail-ed1-f69.google.com with SMTP id k10-20020a50cb8a000000b00403c8326f2aso8929351edi.6
        for <linux-nfs@vger.kernel.org>; Tue, 01 Feb 2022 07:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZypiyxpCcuEyM1ySNhbfCIbOxAuGxHr+z3CxNGHnfjY=;
        b=V/fFRIG+daCDqiZM7zyTgYZcOZzCdPogdbokMKWlREgw7gcq3FVHI96DMKNYP7RERl
         dFC5bncRDJ09yZwxdmntOiTbcL3dNstZ5ETi3VPpZVlxssOxg4SyttHo08aF1XoPhl/t
         7+R90j3MsL0LbBSgYQI3sFZGAbD2mWQk4PRnuHCzC8EMVtujUhgKTzoFCqjsB04MJW/A
         p6VidP6Pn0iHKiWCXQi6JhpavBQOLraw1SXidTDQtsPw4zniRLEfhZQw14kB4GYbWShu
         kxQIDy4FePTYOLAuLdDtOGHi+Nn1uoKg7N/BHmvaF0+VzZ0pGe7i3YtRt30dZa/nz8+M
         DGKw==
X-Gm-Message-State: AOAM531CMzRcJi5fdUxrgCc2OiXIsrDpxQWa82WymEzqQUJkjHgNk7l4
        Wceg00xe4HA+BIh4gh4O2TRDdWMWHb/MbLegQtZdGp13aQqHO3ZCnom8VVO90p+pWiZ1N6hSq8h
        RLmpVOqDa9A2zOQYBpQ30wrW/H5GRr+VRYwNk
X-Received: by 2002:a17:907:7412:: with SMTP id gj18mr20670572ejc.379.1643731089947;
        Tue, 01 Feb 2022 07:58:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAXXRNfi79z+IRrxEZ6ehC7ctExBt43WBCgEzdheEe3PjVycV4BiR0wCaq9ljqrYVmp//CcLshb8N0YYFDsBw=
X-Received: by 2002:a17:907:7412:: with SMTP id gj18mr20670541ejc.379.1643731089374;
 Tue, 01 Feb 2022 07:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com> <20220127194952.63033-2-Anna.Schumaker@Netapp.com>
In-Reply-To: <20220127194952.63033-2-Anna.Schumaker@Netapp.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 1 Feb 2022 10:57:31 -0500
Message-ID: <CALF+zOmodpOP4HqNZykYQVCcr+i11r6bNSWpGViAnfJzVwHsbw@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] rpcctl: Add a rpcctl.py tool
To:     schumaker.anna@gmail.com
Cc:     "Dickson, Steve" <steved@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 27, 2022 at 2:50 PM <schumaker.anna@gmail.com> wrote:
>
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> This will be used to print and manipulate the sunrpc sysfs directory
> files. Running without arguments prints both usage information and the
> location of the sunrpc sysfs directory.
>
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> --
> v7: Check entire line for "sysfs" instead of just the start of the line
> ---
>  tools/rpcctl/rpcctl.py | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100755 tools/rpcctl/rpcctl.py
>
> diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
> new file mode 100755
> index 000000000000..9737ac4a9740
> --- /dev/null
> +++ b/tools/rpcctl/rpcctl.py
> @@ -0,0 +1,25 @@
> +#!/usr/bin/python3
> +import argparse
> +import pathlib
> +import sys
> +
> +with open("/proc/mounts", 'r') as f:
> +    mount = [ line.split()[1] for line in f if "sysfs" in line ]
> +    if len(mount) == 0:
> +        print("ERROR: sysfs is not mounted")
> +        sys.exit(1)
> +
> +sunrpc = pathlib.Path(mount[0]) / "kernel" / "sunrpc"
> +if not sunrpc.is_dir():
> +    print("ERROR: sysfs does not have sunrpc directory")
> +    sys.exit(1)
> +
> +parser = argparse.ArgumentParser()
> +
> +def show_small_help(args):
> +    parser.print_usage()
> +    print("sunrpc dir:", sunrpc)
> +parser.set_defaults(func=show_small_help)
> +
> +args = parser.parse_args()
> +args.func(args)
> --
> 2.35.0
>

Might want to rework some of the directory related code to ensure you
handle disappearing entries.  Got Tracebacks (see below) while running
a series of tests that would:
- mount
- run some IO
- umount


[root@dwysocha-fedora-node1 nfs-utils]# while true; do
./tools/rpcctl/rpcctl.py xprt; done | grep -B 5 -A 5 Traceback
Traceback (most recent call last):
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
    args.func(args)
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 112, in list_all
    xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 112, in <listcomp>
    xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
  File "/usr/lib64/python3.10/pathlib.py", line 1032, in glob
    for p in selector.select_from(self):
  File "/usr/lib64/python3.10/pathlib.py", line 492, in _select_from
    for starting_point in self._iterate_directories(parent_path,
is_dir, scandir):
  File "/usr/lib64/python3.10/pathlib.py", line 482, in _iterate_directories
    for p in self._iterate_directories(path, is_dir, scandir):
  File "/usr/lib64/python3.10/pathlib.py", line 471, in _iterate_directories
    with scandir(parent_path) as scandir_it:
FileNotFoundError: [Errno 2] No such file or directory:
'/sys/kernel/sunrpc/xprt-switches/switch-4'
Traceback (most recent call last):
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
    args.func(args)
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 112, in list_all
    xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 112, in <listcomp>
    xprts = [ Xprt(f) for f in (sunrpc / "xprt-switches").glob("**/xprt-*") ]
  File "/usr/lib64/python3.10/pathlib.py", line 1032, in glob
    for p in selector.select_from(self):
  File "/usr/lib64/python3.10/pathlib.py", line 492, in _select_from
    for starting_point in self._iterate_directories(parent_path,
is_dir, scandir):
  File "/usr/lib64/python3.10/pathlib.py", line 482, in _iterate_directories
    for p in self._iterate_directories(path, is_dir, scandir):
  File "/usr/lib64/python3.10/pathlib.py", line 471, in _iterate_directories
    with scandir(parent_path) as scandir_it:
FileNotFoundError: [Errno 2] No such file or directory:
'/sys/kernel/sunrpc/xprt-switches/switch-2'




[root@dwysocha-fedora-node1 nfs-utils]# while true; do
./tools/rpcctl/rpcctl.py client; done | grep -B 10 -A 10 Traceback
Traceback (most recent call last):
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
    args.func(args)
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
    self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
  File "/usr/lib64/python3.10/pathlib.py", line 1159, in readlink
    path = self._accessor.readlink(self)
FileNotFoundError: [Errno 2] No such file or directory:
'/sys/kernel/sunrpc/rpc-clients/clnt-3/switch'
Traceback (most recent call last):
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
    args.func(args)
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
    self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
  File "/usr/lib64/python3.10/pathlib.py", line 1159, in readlink
    path = self._accessor.readlink(self)
FileNotFoundError: [Errno 2] No such file or directory:
'/sys/kernel/sunrpc/rpc-clients/clnt-7/switch'
Traceback (most recent call last):
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
    args.func(args)
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
    self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 148, in __init__
    self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 148, in <listcomp>
    self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 49, in __init__
    self.read_state()
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 81, in read_state
    self.state = ','.join(f.readline().split()[1:])
OSError: [Errno 19] No such device
Traceback (most recent call last):
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
    args.func(args)
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
    self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 148, in __init__
    self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 148, in <listcomp>
    self.xprts = [ Xprt(p) for p in self.path.iterdir() if p.is_dir() ]
  File "/usr/lib64/python3.10/pathlib.py", line 1015, in iterdir
    for name in self._accessor.listdir(self):
FileNotFoundError: [Errno 2] No such file or directory:
'/sys/kernel/sunrpc/rpc-clients/clnt-9/../../xprt-switches/switch-2'
Traceback (most recent call last):
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 230, in <module>
    args.func(args)
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in list_all
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 209, in <listcomp>
    clients = [ RpcClient(f) for f in (sunrpc / "rpc-clients").iterdir() ]
  File "/mnt/build/nfs-utils/./tools/rpcctl/rpcctl.py", line 195, in __init__
    self.switch = XprtSwitch(path / (path / "switch").readlink(), sep=",")
  File "/usr/lib64/python3.10/pathlib.py", line 1159, in readlink
    path = self._accessor.readlink(self)
FileNotFoundError: [Errno 2] No such file or directory:
'/sys/kernel/sunrpc/rpc-clients/clnt-5/switch'
^C

