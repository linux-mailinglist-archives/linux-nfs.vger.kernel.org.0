Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2665DD0C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjADTp0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 14:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbjADTpY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 14:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA7F6353
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 11:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672861475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5kUsDQ9dHINmXw0lFwmXGv2yYEPyZJ7hjfUcBAuzU0=;
        b=QGrUEJHnoRIriMbc1m8X8/Dk1ItpE7w0cAvM60RFbQ7G+IO3Wo4dqrwc4M7ONdwwcQYY6U
        d3c4ZCJNuYzY1iAx7QM0l4+ddqzV82wso+4PsmUi/SWOEecO+YQXQwcitDAz9cG71qf9Bq
        ap0QzCcq0WHRTeEkmpnIpQ+Wxsv4WuA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-457-dyH6jqnpO2u7z71dypR58w-1; Wed, 04 Jan 2023 14:44:34 -0500
X-MC-Unique: dyH6jqnpO2u7z71dypR58w-1
Received: by mail-qk1-f199.google.com with SMTP id s7-20020a05620a0bc700b006e08208eb31so11934036qki.3
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 11:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5kUsDQ9dHINmXw0lFwmXGv2yYEPyZJ7hjfUcBAuzU0=;
        b=kVMJ6KNKquiSfsvlPMnVL+ELfkeCIlp+B2JzQVYL7XZAMpjbA7c6+Pcf/YGFfNg2CU
         KaHS0EOzHHO/wUri0il3vrPQBGHcYZTk9nmNRXYB8QZpVdkXlaL1t/xLN5l7hqdwAiKT
         bbtL7J2h3nfZVq/dMO9TroUn+pys+KhHDLVEEkiPlqE3+ZYfXKKAC2/cxF9QBAWrVpmL
         zSx3Htbm+RREwBOgKIkl7EXpdU+woTofhOHDHP1hXp0tr/W2StIAD7NBS32nbN8kJdhG
         4gOGQ9J8FJNUD7JiC9dzmFwvJF/JNkGJBZEln0hsN929j5bo2bAtpD++/9toeNouei/f
         L+NA==
X-Gm-Message-State: AFqh2kpMReHNIX7gMZcZrS/3azUDSqlGEpIMxl7NAWa7aeDbqABm+7zl
        /0QcUlEu+DHpDcbRak2sFdSvIZAilnUauMh5gerNS14MGhEfx3bYUL4Wtn2hStrl2syk9I+Y28m
        uhxmxv0lcMtsTtS2LqWog
X-Received: by 2002:a0c:efc4:0:b0:532:f53:923d with SMTP id a4-20020a0cefc4000000b005320f53923dmr727406qvt.50.1672861473886;
        Wed, 04 Jan 2023 11:44:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvF2fnOe1217rcAL3S5KU0YsFSzUz6QbjLmzanTw6RkWGNRbvbTohd7dh7OSHhZRmdg+y4t9g==
X-Received: by 2002:a0c:efc4:0:b0:532:f53:923d with SMTP id a4-20020a0cefc4000000b005320f53923dmr727387qvt.50.1672861473593;
        Wed, 04 Jan 2023 11:44:33 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id dt45-20020a05620a47ad00b006ec771d8f89sm24385398qkb.112.2023.01.04.11.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:44:33 -0800 (PST)
Message-ID: <d28e127dbeb85efb1d4189a998655244fe580c49.camel@redhat.com>
Subject: Re: weird smp memory-barrier issue with nfsd filecache code
From:   Jeff Layton <jlayton@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        David Howells <dhowells@redhat.com>
Date:   Wed, 04 Jan 2023 14:44:32 -0500
In-Reply-To: <5316FDA2-F413-434D-9E39-A87EEB447D69@hammerspace.com>
References: <4c566912cddf72718d0308a2f26bf38d0829901c.camel@redhat.com>
         <5316FDA2-F413-434D-9E39-A87EEB447D69@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-04 at 19:40 +0000, Trond Myklebust wrote:
>=20
> > On Jan 4, 2023, at 14:20, Jeff Layton <jlayton@redhat.com> wrote:
> >=20
> > I had a report of a crash today. The kernel in question is older but ha=
s
> > a backport of the most recent nfsd filecache patches. In particular
> > nfsd_file_do_acquire is pretty much identical to the current mainline
> > code:
> >=20
> > [1803883.048506] BUG: kernel NULL pointer dereference, address: 0000000=
000000020
> > [1803883.048972] #PF: supervisor read access in kernel mode
> > [1803883.049378] #PF: error_code(0x0000) - not-present page
> > [1803883.049798] PGD 0 P4D 0=20
> > [1803883.050171] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [1803883.050563] CPU: 16 PID: 3591 Comm: nfsd Kdump: loaded Tainted: G =
          OE    --------- ---  5.14.0-210.jlayton.nfsd92.2.el9.x86_64 #1
> > [1803883.051386] Hardware name: Supermicro Super Server/H11SSL-NC, BIOS=
 1.0b 04/27/2018
> > [1803883.051820] RIP: 0010:nfsd_file_do_acquire+0x7fb/0x8b0 [nfsd]
> > [1803883.052286] Code: 00 00 00 41 bc 00 00 27 18 e9 46 fc ff ff 89 c2 =
e9 df fb ff ff 48 8b 6c 24 20 65 48 ff 05 d5 57 cc 3e 49 8b 45 28 8b 74 24 =
08 <48> 8b 78 20 e8 9c 5d ff ff 89 c7 e8 95 27 ff ff 41 89 c4 e9 30 fc
> > [1803883.053180] RSP: 0018:ffffb4ca5269fc40 EFLAGS: 00010206
> > [1803883.053639] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000=
00000000002
> > [1803883.054106] RDX: 0000000080000000 RSI: 0000000000000002 RDI: ffff9=
c9722b6af40
> > [1803883.054576] RBP: ffff9c90265f0000 R08: 0000000000000006 R09: 00000=
0000000062b
> > [1803883.055056] R10: 0000000000000866 R11: 000000000000062b R12: ffffb=
4ca55e7d000
> > [1803883.055544] R13: ffff9c936c971ea0 R14: ffff9c936c971ea0 R15: ffff9=
c936c971ee0
> > [1803883.056067] FS:  0000000000000000(0000) GS:ffff9c9b0f700000(0000) =
knlGS:0000000000000000
> > [1803883.056577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [1803883.057093] CR2: 0000000000000020 CR3: 0000000c3e450000 CR4: 00000=
000003506e0
> > [1803883.057621] Call Trace:
> > [1803883.058155]  <TASK>
> > [1803883.058700]  nfs4_get_vfs_file+0x3dd/0x410 [nfsd]
> > [1803883.059283]  nfsd4_process_open2+0x412/0x9f0 [nfsd]
> > [1803883.059854]  nfsd4_open+0x282/0x4b0 [nfsd]
> > [1803883.060398]  nfsd4_proc_compound+0x44b/0x6f0 [nfsd]
> > [1803883.060966]  nfsd_dispatch+0x149/0x270 [nfsd]
> > [1803883.061520]  svc_process_common+0x3bc/0x5e0 [sunrpc]
> > [1803883.062099]  ? nfsd_svc+0x190/0x190 [nfsd]
> > [1803883.062667]  ? nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
> > [1803883.063238]  svc_process+0xb7/0xf0 [sunrpc]
> > [1803883.063826]  nfsd+0xd5/0x190 [nfsd]
> > [1803883.064408]  kthread+0xd9/0x100
> > [1803883.064959]  ? kthread_complete_and_exit+0x20/0x20
> > [1803883.065501]  ret_from_fork+0x22/0x30
> > [1803883.066052]  </TASK>
> > [1803883.066592] Modules linked in: mst_pciconf(OE) mst_pci(OE) overlay=
 nfsd nfs_acl binfmt_misc dm_cache_smq dm_cache dm_persistent_data dm_bio_p=
rison dm_bufio rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ne=
tfs rbd libceph dns_resolver 8021q garp mrp stp llc bonding nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_de=
frag_ipv4 rfkill ip_set nf_tables nfnetlink rpcrdma sunrpc rdma_ucm ib_srpt=
 ib_isert iscsi_target_mod target_core_mod ipmi_ssif ib_iser libiscsi scsi_=
transport_iscsi intel_rapl_msr ib_umad intel_rapl_common rdma_cm ib_ipoib i=
w_cm amd64_edac edac_mce_amd ib_cm kvm_amd kvm mlx5_ib mlx4_ib ib_uverbs ir=
qbypass rapl pcspkr ib_core joydev acpi_ipmi i2c_piix4 k10temp ipmi_si ipmi=
_devintf ipmi_msghandler acpi_cpufreq xfs libcrc32c raid1 sd_mod sg mlx5_co=
re ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect crct10dif_pcl=
mul sysimgblt crc32_pclmul nvme
> > [1803883.066656]  fb_sys_fops crc32c_intel ahci mpt3sas drm_ttm_helper =
nvme_core ttm libahci mlxfw ghash_clmulni_intel igb mlx4_core tls nvme_comm=
on drm libata raid_class psample scsi_transport_sas t10_pi ccp pci_hyperv_i=
ntf sp5100_tco dca i2c_algo_bit dm_mirror dm_region_hash dm_log dm_mod fuse
> > [1803883.074377] CR2: 0000000000000020
> >=20
> > We got a coredump from this one, and I did a bit of analysis:
> >=20
> > wait_for_construction:
> >        wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIB=
LE);
> >=20
> >        /* Did construction of this file fail? */
> >        if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> >                trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf=
);
> >                if (!open_retry) {
> >                        status =3D nfserr_jukebox;
> >                        goto out;
> >                }
> >                open_retry =3D false;
> >                if (refcount_dec_and_test(&nf->nf_ref))
> >                        nfsd_file_free(nf);
> >                goto retry;
> >        }
> >=20
> >        this_cpu_inc(nfsd_file_cache_hits);
> >=20
> >        status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file=
), may_flags));     <<<< CRASH HERE
> > out:
> >        if (status =3D=3D nfs_ok) {
> >                if (open)
> >                        this_cpu_inc(nfsd_file_acquisitions);
> >                *pnf =3D nf;
> >        } else {
> >                if (refcount_dec_and_test(&nf->nf_ref))
> >                        nfsd_file_free(nf);
> >                nf =3D NULL;
> >        }
> >=20
> > out_status:
> >        put_cred(key.cred);
> >        if (open)
> >                trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf,=
 status);
> >        return status;
> >=20
> > open_file:
> >        trace_nfsd_file_alloc(nf);
> >        nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
> >        if (nf->nf_mark) {
> >                if (open) {
> >                        status =3D nfsd_open_verified(rqstp, fhp, may_fl=
ags,
> >                                                    &nf->nf_file);
> >                        trace_nfsd_file_open(nf, status);
> >                } else
> >                        status =3D nfs_ok;
> >        } else
> >                status =3D nfserr_jukebox;
> >        /*
> >         * If construction failed, or we raced with a call to unlink()
> >         * then unhash.
> >         */
> >        if (status =3D=3D nfs_ok && key.inode->i_nlink =3D=3D 0)
> >                status =3D nfserr_jukebox;
> >        if (status !=3D nfs_ok)
> >                nfsd_file_unhash(nf);
> >        clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
> >        smp_mb__after_atomic();
> >        wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> >        goto out;
> >=20
> > Relevant disassembly:
> >=20
> > /usr/src/debug/kernel-5.14.0-210.jlayton.nfsd92.2.el9/linux-5.14.0-210.=
jlayton.nfsd92.2.el9.x86_64/./include/linux/fs.h: 1348                     =
                 =20
> > 0xffffffffc1368883 <nfsd_file_do_acquire+0x7f3>:        mov    0x28(%r1=
3),%rax
> > /usr/src/debug/kernel-5.14.0-210.jlayton.nfsd92.2.el9/linux-5.14.0-210.=
jlayton.nfsd92.2.el9.x86_64/fs/nfsd/filecache.c: 1145                      =
                 =20
> > 0xffffffffc1368887 <nfsd_file_do_acquire+0x7f7>:        mov    0x8(%rsp=
),%esi
> > 0xffffffffc136888b <nfsd_file_do_acquire+0x7fb>:        mov    0x20(%ra=
x),%rdi         <<< CRASH HERE
> >=20
> > crash> struct -o nfsd_file
> > struct nfsd_file {
> >   [0x0] struct rhash_head nf_rhash;
> >   [0x8] struct list_head nf_lru;
> >  [0x18] struct callback_head nf_rcu;
> >  [0x28] struct file *nf_file;
> >  [0x30] const struct cred *nf_cred;
> >  [0x38] struct net *nf_net;
> >  [0x40] unsigned long nf_flags;
> >  [0x48] struct inode *nf_inode;
> >  [0x50] refcount_t nf_ref;
> >  [0x54] unsigned char nf_may;
> >  [0x58] struct nfsd_file_mark *nf_mark;
> >  [0x60] ktime_t nf_birthtime;
> > }
> >=20
> > nf_file is 0x28 bytes into that struct, so the mov at +0x7f3 is probabl=
y
> > the dereferencing of that. That means that the addr of the nfsd_file is
> > (probably) in %r13. Based on that, nf_file looks like a legit address.
> >=20
> > crash> struct nfsd_file ffff9c936c971ea0
> > struct nfsd_file {
> >  nf_rhash =3D {
> >    next =3D 0xffffb4ca55ef9209
> >  },
> >  nf_lru =3D {
> >    next =3D 0xffff9c936c971ea8,
> >    prev =3D 0xffff9c936c971ea8
>=20
> The above means nf_lru is not hashed (next=3D=3Dprev=3D=3D&nf_lru)
>=20

It's hashed, but it is not on the LRU. We only put them on the LRU once
there are no more active users as that makes the LRU scanning more
efficient. No need to look at nfsd_files that have active users.

> >  },
> >  nf_rcu =3D {
> >    next =3D 0xffff9c93995c3218,
> >    func =3D 0x0
> >  },
> >  nf_file =3D 0xffff9c9b3b080600,
> >  nf_cred =3D 0xffff9c9423a55a40,
> >  nf_net =3D 0xffffffffa200cd40 <init_net>,
> >  nf_flags =3D 0x1,
>=20
> The above value would normally imply it is hashed (nf_flags=3D=3D(1<<NFSD=
_FILE_HASHED))
>=20
> >  nf_inode =3D 0xffff9c9c204c5500,
> >  nf_ref =3D {
> >    refs =3D {
> >      counter =3D 0x2
> >    }
> >  },
> >  nf_may =3D 0x2,
> >  nf_mark =3D 0xffff9c9633a85b40,
> >  nf_birthtime =3D 0x668a348ce435a
> > }
> >=20
> > In this code, one task is opening a file for the cache and another is
> > waiting on the construction to complete. After we open the file, we
> > populate the nf_file field, clear NFSD_FILE_PENDING and wake up anyone
> > waiting on it.
> >=20
> > Here though, the waiter had finished waiting but when it went to fetch
> > nf->nf_file in the register, it still appeared to be NULL. In the core,
> > it is populated with a valid file pointer however.
> >=20
> > clear_bit_unlock does a full barrier (on x86) before clearing the bit.
> > According to memory-barriers.txt, wait_on_bit should imply a read memor=
y
> > barrier.
> >=20
> > Why was %rax zeroed out?
> > --=20
>=20
> Are you sure the back ported values for NFSD_FILE_HASHED and NFSD_FILE_PE=
NDING are correct?
>=20

Yes. They are the same.
--=20
Jeff Layton <jlayton@redhat.com>

