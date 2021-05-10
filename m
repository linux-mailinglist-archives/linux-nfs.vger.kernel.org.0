Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA7237980D
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 21:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhEJT6G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 15:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232024AbhEJT6D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 May 2021 15:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620676617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOhDyMi2j5obiVrIEG0/wQvVrKKFmyhmxf6OzxpCNuc=;
        b=cVQT5kPK72lzYJyWa7ktkJ64B11fRVku+yvGxkvLlD8RgQwLeZ2QJFVZSrvtUFNNFDX/HD
        YTMsUDct+BC7B7keovm4BxqwI9wwgnr6N4QwX55EXenxBIQ0VwqaWeyfE1f7f9DL4muTaj
        AwhXuY1dDvTdcS0No0h+gJYt4KINxMU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-3onIqVq0OR6xjZkhgp8DGg-1; Mon, 10 May 2021 15:56:55 -0400
X-MC-Unique: 3onIqVq0OR6xjZkhgp8DGg-1
Received: by mail-yb1-f199.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so21055864ybo.11
        for <linux-nfs@vger.kernel.org>; Mon, 10 May 2021 12:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOhDyMi2j5obiVrIEG0/wQvVrKKFmyhmxf6OzxpCNuc=;
        b=knYrFESZbXSSpr8U8rax0dVDVUvo6pAJo3lWT++AWed4S6By+PYBWY0hUGgOeIiQz1
         X6a5GfJy+ifBUafyC0M+zg4I/QUaVQsyWQ1SbwRGyzROMZmZ6MUYAI3sGV4Sgy3Qy9jy
         qJSHpoJjsbaj5aV+eimt+eAXV/Zcr6X7uj6ROK0UHp1SVFyMYINQgZYXH7yGPxsZTrnS
         KfcypNYh2yBaV4XvycgtiUtg3d9LpUnlZusmmwXoN1PrbM1DdhL+HsycGOcHGJpxDdE6
         M2Bq12yWWs3WzXsKLOCcgCl7HUx2jNg3Q9gz3zd4XyRsihed8bpz6lvX96gjRSA2byzk
         Vj8A==
X-Gm-Message-State: AOAM533l8ifCOOvSAPYnGtNImC+9CF7eTuitWimO/zV6iKhGN1AWBgCO
        zUwz+Mf9Eq9KjoXuacOcTEnXiCXHMZIo61E0tvYAb7hnnxQ/3FD2Vo49z/r1HgV9v73t6NgZPNi
        87AhlCzzNkB8FlwFDADZwx6Pyc92D3H5GJmhF
X-Received: by 2002:a05:6902:566:: with SMTP id a6mr1886353ybt.102.1620676614933;
        Mon, 10 May 2021 12:56:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1sxadC5wvEdpTFGhheNwdvQjenGuQgp5fg+kSXWv9X5XBrvowYE0fyh1Qgd1mJZtwu+slLr1chXlFukNWKFA=
X-Received: by 2002:a05:6902:566:: with SMTP id a6mr1886320ybt.102.1620676614629;
 Mon, 10 May 2021 12:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066202717.94415.8666073108309704792.stgit@klimt.1015granger.net>
In-Reply-To: <162066202717.94415.8666073108309704792.stgit@klimt.1015granger.net>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 10 May 2021 15:56:18 -0400
Message-ID: <CALF+zO=W1YgWXehHRKsrsBCZHe48qNwO=OMx7PQ_dJY7z+Tg-A@mail.gmail.com>
Subject: Re: [PATCH RFC 21/21] NFSD: Add tracepoints to observe clientID activity
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 10, 2021 at 11:53 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> We are especially interested in capturing clientID conflicts.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |    9 +++++++--
>  fs/nfsd/trace.h     |   37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a61601fe422a..528cabffa1e9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3180,6 +3180,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>                         }
>                         /* case 6 */
>                         exid->flags |= EXCHGID4_FLAG_CONFIRMED_R;
> +                       trace_nfsd_clid_existing(conf);
>                         goto out_copy;
>                 }
>                 if (!creds_match) { /* case 3 */
> @@ -3188,15 +3189,18 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>                                 trace_nfsd_clid_cred_mismatch(conf, rqstp);
>                                 goto out;
>                         }
> +                       trace_nfsd_clid_new(new);
>                         goto out_new;
>                 }
>                 if (verfs_match) { /* case 2 */
>                         conf->cl_exchange_flags |= EXCHGID4_FLAG_CONFIRMED_R;
> +                       trace_nfsd_clid_existing(conf);
>                         goto out_copy;
>                 }
>                 /* case 5, client reboot */
>                 trace_nfsd_clid_verf_mismatch(conf, rqstp, &verf);
>                 conf = NULL;
> +               trace_nfsd_clid_new(new);
>                 goto out_new;
>         }
>
> @@ -3996,10 +4000,12 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>                 if (same_verf(&conf->cl_verifier, &clverifier)) {
>                         copy_clid(new, conf);
>                         gen_confirm(new, nn);
> +                       trace_nfsd_clid_existing(new);
>                 } else
>                         trace_nfsd_clid_verf_mismatch(conf, rqstp,
>                                                       &clverifier);
> -       }
> +       } else
> +               trace_nfsd_clid_new(new);
>         new->cl_minorversion = 0;
>         gen_callback(new, setclid, rqstp);
>         add_to_unconfirmed(new);
> @@ -4017,7 +4023,6 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>         return status;
>  }
>
> -
>  __be32
>  nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>                         struct nfsd4_compound_state *cstate,
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 523045c37749..6ddff13e3181 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -626,6 +626,43 @@ TRACE_EVENT(nfsd_clid_verf_mismatch,
>         )
>  );
>
> +DECLARE_EVENT_CLASS(nfsd_clid_class,
> +       TP_PROTO(const struct nfs4_client *clp),
> +       TP_ARGS(clp),
> +       TP_STRUCT__entry(
> +               __field(u32, cl_boot)
> +               __field(u32, cl_id)
> +               __array(unsigned char, addr, sizeof(struct sockaddr_in6))
> +               __field(unsigned long, flavor)
> +               __array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
> +               __field(unsigned int, namelen)
> +               __dynamic_array(unsigned char, name, clp->cl_name.len)
> +       ),
> +       TP_fast_assign(
> +               memcpy(__entry->addr, &clp->cl_addr,
> +                       sizeof(struct sockaddr_in6));
> +               __entry->flavor = clp->cl_cred.cr_flavor;
> +               memcpy(__entry->verifier, (void *)&clp->cl_verifier,
> +                      NFS4_VERIFIER_SIZE);
> +               __entry->namelen = clp->cl_name.len;
> +               memcpy(__get_dynamic_array(name), clp->cl_name.data,
> +                       clp->cl_name.len);
> +       ),
> +       TP_printk("addr=%pISpc name='%.*s' verifier=0x%s flavor=%s client=%08x:%08x\n",
> +               __entry->addr, __entry->namelen, __get_str(name),
> +               __print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE),
> +               show_nfsd_authflavor(__entry->flavor),
> +               __entry->cl_boot, __entry->cl_id)
> +);
> +
> +#define DEFINE_CLID_EVENT(name) \
> +DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
> +       TP_PROTO(const struct nfs4_client *clp), \
> +       TP_ARGS(clp))
> +
> +DEFINE_CLID_EVENT(new);
> +DEFINE_CLID_EVENT(existing);
> +
>  /*
>   * from fs/nfsd/filecache.h
>   */
>
>

I just got this oops when testing duplicate hostnames and having
enabled these tracepoints with:
trace-cmd start -e nfsd:nfsd_clid*

[  408.119259] ------------[ cut here ]------------
[  408.136659] fmt: 'addr=%pISpc name='%.*s' verifier=0x%s flavor=%s
client=%08x:%08x
[  408.136659]
[  408.136659] ' current_buffer: '            nfsd-1117    [001] ....
 408.844043: nfsd_clid_new: addr=192.168.122.8:676 name=''
[  408.136831] WARNING: CPU: 4 PID: 15097 at kernel/trace/trace.c:3759
trace_check_vprintf+0x9f9/0x1040
[  408.149530] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw ip6table_security
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_mangle iptable_raw iptable_security ip_set rfkill nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
cachefiles intel_rapl_msr intel_rapl_common joydev virtio_balloon nfsd
i2c_piix4 auth_rpcgss nfs_acl lockd grace sunrpc drm ip_tables xfs
libcrc32c crct10dif_pclmul crc32_pclmul crc32c_intel virtio_net
ata_generic ghash_clmulni_intel net_failover virtio_console serio_raw
pata_acpi virtio_blk failover qemu_fw_cfg
[  408.176536] CPU: 4 PID: 15097 Comm: trace-cmd Kdump: loaded Not
tainted 5.13.0-rc1-chuck-nfsd+ #12
[  408.180288] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  408.182731] RIP: 0010:trace_check_vprintf+0x9f9/0x1040
[  408.184912] Code: 00 00 49 8b 94 24 b0 20 00 00 48 8b 74 24 30 4c
89 4c 24 18 48 c7 c7 00 65 6c ba 44 89 44 24 10 4c 89 54 24 08 e8 e5
a2 bd 01 <0f> 0b 4c 8b 54 24 08 44 8b 44 24 10 4c 8b 4c 24 18 e9 c8 fc
ff ff
[  408.192521] RSP: 0018:ffff888115617a30 EFLAGS: 00010282
[  408.194732] RAX: 0000000000000000 RBX: 0000000000000013 RCX: 0000000000000000
[  408.197706] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffffed1022ac2f3c
[  408.200667] RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8881e3d20a0b
[  408.203621] R10: ffffed103c7a4141 R11: 0000000000000001 R12: ffff888110984000
[  408.206571] R13: ffffffffc0ef9b80 R14: ffff8881109850b0 R15: ffff8881109860b0
[  408.209537] FS:  00007fc70350b740(0000) GS:ffff8881e3d00000(0000)
knlGS:0000000000000000
[  408.212887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  408.215297] CR2: 00005638a21aa9c8 CR3: 000000010c53a000 CR4: 00000000000406e0
[  408.218245] Call Trace:
[  408.219335]  trace_event_printf+0x9d/0xc0
[  408.221041]  ? trace_print_hex_dump_seq+0x120/0x120
[  408.223137]  trace_raw_output_nfsd_clid_class+0x175/0x1f0 [nfsd]
[  408.225936]  print_trace_line+0x75c/0x1430
[  408.227709]  ? tracing_buffers_read+0x820/0x820
[  408.229637]  ? _raw_spin_unlock_irqrestore+0xa/0x20
[  408.231710]  ? trace_find_next_entry_inc+0x10f/0x1b0
[  408.233815]  s_show+0xc1/0x3d0
[  408.235431]  seq_read_iter+0x93c/0xfe0
[  408.237042]  ? lru_cache_add+0x176/0x290
[  408.238722]  seq_read+0x311/0x4c0
[  408.246280]  ? seq_read_iter+0xfe0/0xfe0
[  408.247937]  ? vm_iomap_memory+0x1d0/0x1d0
[  408.249705]  ? inode_security+0x43/0xe0
[  408.251393]  vfs_read+0x111/0x400
[  408.252841]  ksys_read+0xdd/0x1a0
[  408.254279]  ? __ia32_sys_pwrite64+0x1b0/0x1b0
[  408.256138]  do_syscall_64+0x40/0x80
[  408.257670]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  408.259767] RIP: 0033:0x7fc703600442

