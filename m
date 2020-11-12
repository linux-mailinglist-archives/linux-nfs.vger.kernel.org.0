Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27942B0EF6
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 21:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKLUVU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 15:21:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbgKLUVT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 15:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605212477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJZAYbex2UR2k+6qOoyVMj/JRQIsnBs1bAGeBUbuM7Y=;
        b=E2VucqqnIDfIX8Vxh8e8rjqkZhUn45+f8BadTQKKCfQZwvDRdHCH+L8mtytXbut+ltdpNC
        0jtRM97IDEBVlkEm5Y5RBraA4V2oTjZ18m69JCrPFNrZV6UfL/4Z3z6GJ4pJIe0sfhsYcd
        QWfZGkMzIEVptrHDL/kft8vBeUPNzdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-xZN_dyA7N3a7zZYGHL4oqw-1; Thu, 12 Nov 2020 15:21:13 -0500
X-MC-Unique: xZN_dyA7N3a7zZYGHL4oqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9205F802B6F;
        Thu, 12 Nov 2020 20:21:12 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-113-97.rdu2.redhat.com [10.10.113.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6197A76642;
        Thu, 12 Nov 2020 20:21:12 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 995781A0018; Thu, 12 Nov 2020 15:21:11 -0500 (EST)
Date:   Thu, 12 Nov 2020 15:21:11 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix oops in the rpc_xdr_buf event class
Message-ID: <20201112202111.GL4526@aion.usersys.redhat.com>
References: <20201112201732.1689680-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112201732.1689680-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 12 Nov 2020, Scott Mayhew wrote:

> Backchannel rpc tasks don't have task->tk_client set, so it's necessary
> to check it for NULL before dereferencing.

This fixes an oops triggered by the following reproducer:

# echo 1 >/sys/kernel/debug/tracing/events/sunrpc/rpc_xdr_sendto/enable
# mount localhost:/export /mnt/t
# cat /mnt/t/file
# date >/export/file

[  112.033689] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
[  112.037302] PGD 0 P4D 0
[  112.038492] Oops: 0000 [#1] SMP PTI
[  112.040106] CPU: 2 PID: 1547 Comm: NFSv4 callback Kdump: loaded Not tainted 4.18.0-247.el8.x86_64 #1
[  112.043259] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[  112.047166] RIP: 0010:trace_event_raw_event_rpc_xdr_buf_class+0x6d/0xf0 [sunrpc]
[  112.049321] Code: ba 38 00 00 00 4c 89 e6 48 89 e7 e8 fd 03 45 f2 48 85 c0 74 4c 41 0f b7 95 f0 00 00 00 48 89 e7 89 50 08 49 8b 95 b8 00 00 00 <8b> 52 04 89 50 0c 48 8b 55 00 48 89 50 10 48 8b 55 08 48 89 50 18
[  112.053443] RSP: 0018:ffffb8eb012f3ce0 EFLAGS: 00010286
[  112.054393] RAX: ffff9892c7098618 RBX: 0000000000000003 RCX: 0000000000000000
[  112.055663] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb8eb012f3ce0
[  112.056957] RBP: ffff989339d99808 R08: 0000000000000000 R09: ffff9892c7098618
[  112.058233] R10: ffff9892c709860c R11: ffff9892c7060e00 R12: ffff98932d693318
[  112.059478] R13: ffff989328a8dd00 R14: ffff989339d998e0 R15: ffff98931d3e5f28
[  112.060759] FS:  0000000000000000(0000) GS:ffff98933bb00000(0000) knlGS:0000000000000000
[  112.062247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.063266] CR2: 0000000000000004 CR3: 000000002a20a002 CR4: 0000000000760ee0
[  112.064533] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  112.065772] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  112.067015] PKRU: 55555554
[  112.067504] Call Trace:
[  112.068006]  xprt_transmit+0x2f4/0x420 [sunrpc]
[  112.068813]  ? __rpc_sleep_on_priority_timeout+0xe0/0xe0 [sunrpc]
[  112.069886]  ? call_bc_encode+0x20/0x20 [sunrpc]
[  112.070691]  call_bc_transmit+0x33/0x40 [sunrpc]
[  112.071509]  __rpc_execute+0x85/0x3c0 [sunrpc]
[  112.072290]  ? kvm_clock_get_cycles+0xd/0x10
[  112.073048]  ? ktime_get+0x36/0xa0
[  112.073667]  rpc_run_bc_task+0x7c/0xb0 [sunrpc]
[  112.074471]  bc_svc_process+0x28e/0x300 [sunrpc]
[  112.075381]  nfs41_callback_svc+0x12d/0x1a0 [nfsv4]
[  112.076246]  ? finish_wait+0x80/0x80
[  112.076922]  ? nfs_map_gid_to_group+0x130/0x130 [nfsv4]
[  112.077833]  kthread+0x116/0x130
[  112.078415]  ? kthread_flush_work_fn+0x10/0x10
[  112.079173]  ret_from_fork+0x35/0x40
[  112.079818] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache intel_rapl_msr intel_rapl_common isst_if_common nfit libnvdimm kvm_intel kvm snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg soundwire_intel irqbypass soundwire_generic_allocation snd_soc_core crct10dif_pclmul snd_compress crc32_pclmul soundwire_cadence soundwire_bus iTCO_wdt ghash_clmulni_intel iTCO_vendor_support snd_hda_codec qxl drm_ttm_helper ttm snd_hda_core snd_hwdep drm_kms_helper snd_seq snd_seq_device syscopyarea snd_pcm sysfillrect sysimgblt fb_sys_fops pcspkr snd_timer joydev drm snd soundcore virtio_balloon i2c_i801 lpc_ich nfsd nfs_acl lockd grace auth_rpcgss sunrpc ip_tables xfs libcrc32c ahci libahci libata crc32c_intel serio_raw virtio_console virtio_net net_failover failover virtio_blk
[  112.095079] CR2: 0000000000000004

-Scott
> 
> Fixes: c509f15a5801 ("SUNRPC: Split the xdr_buf event class")
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  include/trace/events/sunrpc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index 2477014e3fa6..2a03263b5f9d 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -68,7 +68,8 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
>  
>  	TP_fast_assign(
>  		__entry->task_id = task->tk_pid;
> -		__entry->client_id = task->tk_client->cl_clid;
> +		__entry->client_id = task->tk_client ?
> +				     task->tk_client->cl_clid : -1;
>  		__entry->head_base = xdr->head[0].iov_base;
>  		__entry->head_len = xdr->head[0].iov_len;
>  		__entry->tail_base = xdr->tail[0].iov_base;
> -- 
> 2.25.4
> 

