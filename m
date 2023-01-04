Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9D365DDD0
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 21:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjADUrg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 15:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjADUrf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 15:47:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F713EB1
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 12:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672865212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwuzZAfhoX99cBm/9lHNMj6wSkWIrBzPjdvIo2qyqQ4=;
        b=iy7r/A7FarwQpDQFZNnX+91fi7qwjr5LlYg1PTyUfWJwDSGzJmaeKTUm8p7px4B29tWiDe
        kmHpuU2cKntbVmzL8eKxhXVwwxhiN62RA44JexDVnU2M0DUrLK/foLrhbACqkk4RG/yxMv
        t3z03ZJTexIxb5g906fjLCcSC8XJK3s=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-XNKeE5hhOm20de0guWavWA-1; Wed, 04 Jan 2023 15:46:51 -0500
X-MC-Unique: XNKeE5hhOm20de0guWavWA-1
Received: by mail-vs1-f70.google.com with SMTP id a62-20020a671a41000000b003c08f2a8d7bso8078164vsa.14
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 12:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwuzZAfhoX99cBm/9lHNMj6wSkWIrBzPjdvIo2qyqQ4=;
        b=Lt25c5Swv8r9Cv99hCNo8B+XxeNcQ6vdz3tZ4jwLIHXcurgM1Y+0hwYqKnWKQZ2GpK
         1VWpzboPEVvI6zIfZ0X8j85bTxJgyITrWhaFG8m6DFbBTYddy/iYySbSiQcvn/+osCNB
         B4AIytRJGRUA1YCd7qPIRCkFRtCMOukZsUprafSzj5vCxL642x0gYypIWU0d2G/bfBT7
         +QEGy26Bih3X0xzV1TfZ2WrHtn5n+23Au17Ha2nW7NWeoS73PY1Jnu9X5XE5QFXZl0L/
         7Oj2F3c6/EPPC6Hn+mCEmFgNxwHu5mAgcJPu7tbKykXKJy82Cld+4t8T34itijQ8XGC9
         sarQ==
X-Gm-Message-State: AFqh2kpJDqD6Sex91uYkhZXo3S/bPMHBFExh+NJlQmnXRYhY40HggKRL
        hR2g4KRaqALaTR0dpAZ08oTlMmez+9ZmeEJEtXl/GxjYTYIF6rWhoaL8woCjV/qDTz0qifTwvZY
        oqdGXbrjaalQclYcyeS1b
X-Received: by 2002:a67:ee8a:0:b0:3b1:3a0b:50b0 with SMTP id n10-20020a67ee8a000000b003b13a0b50b0mr21420973vsp.24.1672865210327;
        Wed, 04 Jan 2023 12:46:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtQC/pbseVi7avkQ3H2rLJJFrCulZnm9neR6KT1k1ut3n2snMwqoUgqEFrkobHgNja5HKcZiQ==
X-Received: by 2002:a67:ee8a:0:b0:3b1:3a0b:50b0 with SMTP id n10-20020a67ee8a000000b003b13a0b50b0mr21420962vsp.24.1672865210010;
        Wed, 04 Jan 2023 12:46:50 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id br36-20020a05620a462400b006fc3fa1f589sm24444645qkb.114.2023.01.04.12.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:46:49 -0800 (PST)
Message-ID: <00e29eb2d90fcf6211d9e6b51946915df9998577.camel@redhat.com>
Subject: Re: weird smp memory-barrier issue with nfsd filecache code
From:   Jeff Layton <jlayton@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        David Howells <dhowells@redhat.com>
Date:   Wed, 04 Jan 2023 15:46:48 -0500
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

Ahh, I think I see the bug, and it's not where I had originally thought.

In the !open case here, the pointer is not set, and we currently expect
the caller to (eventually) do it. This is racy since other callers may
see this object once the PENDING bit is cleared.

I'm working on a fix now. Thanks for the sanity check!

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

--=20
Jeff Layton <jlayton@redhat.com>

