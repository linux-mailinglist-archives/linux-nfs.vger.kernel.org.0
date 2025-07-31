Return-Path: <linux-nfs+bounces-13335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAFFB175E2
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B577B956C
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8CD1D799D;
	Thu, 31 Jul 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jxa6kWZi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680E101EE
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984712; cv=none; b=R1lfAfR9XIQClJOLgOhUKfj0Ljo8RxOdMZOZnpr38HZap4gDCB3cZS+os/UwKZKKpBcuJv+y1cdvdSIm5f/XsXaWfpDTnDp+4GwM+RBElEaMPFfjjqnPUkRY03YVdF52SRPqeQk1kfY30A2RUzPczvps5qEGHI4CnPo1ltGCXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984712; c=relaxed/simple;
	bh=nkDWy34SayzIGOHaqpOPJJ64cggSw3mGbQFjwr/POsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGPKUXnxGl/eUkQJwwal1oCoD/c5ni29lF2elhDdljoccqjrn7hnEpkZT7OzG4fJ5K3MCuVxtfl5TXHrJ8xrPHrgvzmXwDccOTIEKXhXLaDmSv1IkCjXwRgf3mgRsCzfWZfWhPSVty084X1r5DAD02011wmF9e8Dt/ea2ymj99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jxa6kWZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0F3C4CEEF;
	Thu, 31 Jul 2025 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984712;
	bh=nkDWy34SayzIGOHaqpOPJJ64cggSw3mGbQFjwr/POsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jxa6kWZiTRVXKvlJbCwhBeJXyTz08dvQGYOsNtU9gPDhmG0wsukPxVMN80PCTVVLc
	 RmZBwCIb0FgncYafg/yQUloDuSF0svX3BnSKh06f4DFRfgQ6pOebwXEXNDWSuE1z9Z
	 phR1OpIyErsK1miO7Ph4yLTZ30QL7TQWou/c7OnSnMJi9d8ucBqLhlaEA5DnGm4sS3
	 iPMl+rO4Cipzg46j4GfYJGFnDlfudfR2Bnx0toxKOMnBnuMuduUsPBpp2p9eI3kkya
	 zaBt+dZJFsujsPFnEg6NPFh5Q/06r4hSAdFnGg8/q3k3xSBpD+pBW8ommHaCFLrsZ9
	 JmsRWL1Wj0a9A==
Date: Thu, 31 Jul 2025 13:58:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: mount NFS with localio
Message-ID: <aIuux1V2l5jNaikF@kernel.org>
References: <CAAiJnjoNd37p6kqSZSOPzYup_fWaHZgJv3gEpfThpxn--MqpqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiJnjoNd37p6kqSZSOPzYup_fWaHZgJv3gEpfThpxn--MqpqA@mail.gmail.com>

On Wed, Jul 30, 2025 at 03:43:00PM +0300, Anton Gavriliuk wrote:
> Hi
> 
> How to mount NFS with localio on Fedora Server 42 (6.15.8 kernel) ?
> 
> Localio enabled in kernel
> 
> [root@23-127-77-5 ~]# cat /boot/config-6.15.8-200.fc42.x86_64 | grep -i localio
> CONFIG_NFS_COMMON_LOCALIO_SUPPORT=m
> CONFIG_NFS_LOCALIO=y
> 
> [root@23-127-77-5 ~]# lsmod | grep -i localio
> nfs_localio            36864  2 nfsd,nfs
> sunrpc                925696  30
> nfs_localio,nfsd,rpcrdma,nfsv4,auth_rpcgss,lockd,rpcsec_gss_krb5,nfs_acl,nfs
> 
> [root@23-127-77-5 ~]# mount -t nfs 127.0.0.1:/mnt /mnt1
> [root@23-127-77-5 ~]#
> [root@23-127-77-5 ~]# mount | grep -i mnt1
> 127.0.0.1:/mnt on /mnt1 type nfs4
> (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)
> 
> So /mnt1 is mounted with localio ?

Should be.

One way to tell, albeit less ironclad, is that performance improves
(reduced use of network/sunrpc is also a tell-tale).

But see commit 62d2cde203def ("NFS: add localio to sysfs")
It adds semi-useful exposure of whether LOCALIO is active for a given
rpc client.  I say "semi-useful" because I'm left wanting on the
reliability of this interface (particularly when pnfs flexfiles is
used, the separate NFS client that is established to connect to the
local NFSD over v3 isn't getting added to sysfs for some reason.. not
put time to fixing that yet).  But for simple loopback NFS mount that
doesn't use pnfs flexfiles it _should_ work, e.g.:

  # cat /sys/fs/nfs/0\:46/localio
  1

I've found that the best way to _know_ LOCALIO enabled is to use trace
points, but yeah that is kind of obscure and certainly not common in
production.

These tracepoints really showcase LOCALIO is being used:

 echo 1 > /sys/kernel/tracing/events/sunrpc/svc_process/enable
 echo 1 > /sys/kernel/tracing/events/nfs_localio/nfs_localio_enable_client/enable
 echo 1 > /sys/kernel/tracing/events/nfs_localio/nfs_localio_disable_client/enable
 echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_open_fh/enable

(NOTE: it is only with this patch applied that the nfs_local_open_fh
tracepoint is made much more useful, otherwise it'd only show if the
function failed to open the fh.. unfortunately not yet picked up for
upstream:
https://lore.kernel.org/linux-nfs/20250724193102.65111-9-snitzer@kernel.org/
)

 echo nop > /sys/kernel/debug/tracing/current_tracer
 echo 1 > /sys/kernel/debug/tracing/tracing_on

With these enabled, mounting NFS via loopback and doing a simple dd
shows the following in: cat /sys/kernel/debug/tracing/trace

            nfsd-10448   [024] .....  4316.520916: svc_process: addr=192.168.1.106 xid=0xcf2cdbdf service=nfslocalio vers=1 proc=UUID_IS_LOCAL
  kworker/u194:0-9772    [042] .....  4316.520951: nfs_localio_enable_client: server=192.168.1.106 NFSv3
  kworker/u194:0-9772    [042] .....  4316.647334: nfs_local_open_fh: fhandle=0x4d34e6c1 mode=READ|WRITE result=0

Also, enabling various nfsd tracepoints and seeing the absence of them
is telling.  Similarly, enabling tracepoints for NFSD's underlying
filesystem (e.g. xfs) and seeing the process that is triggering the
trace isn't nfsd showcases LOCALIO being used, e.g.:

with LOCALIO:

  kworker/u194:3-9540    [027] .....  5155.011380: xfs_file_direct_write: dev 259:16 ino 0x3e00008f disize 0xb7a0 pos 0xc000 bytecount 0xa000

without LOCALIO:

            nfsd-10448   [034] .....  5730.314274: xfs_file_direct_write: dev 259:16 ino 0x3e00008f disize 0xb7a0 pos 0xc000 bytecount 0xa000

Hope this helps,
Mike

