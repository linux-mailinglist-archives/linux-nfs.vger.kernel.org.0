Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D964265DCA6
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 20:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjADTV0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 14:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbjADTVJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 14:21:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4671A202
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 11:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672860026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4Xt0fm06g6xbBT6oz+Nl9xwzNaIm++/wMnBFBdrYMQ4=;
        b=S+oN60w/dSfv5R+hgt1/6WvDHmQWLxXVXZWYftV+ZMonK7wMcKk8cBWPiLOPOnM2Yjh/KN
        qP88jdaADIhWO+lFGkde52HRk3dO/4hAqz9BQFUF78RboSTGLRGtlw8V+zsC9DY38sshKO
        Hmlt3MJRqxRFBWZKzyLh8hg+imJtI94=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-336-bl3b8bugMxKRDZjwF4GLDA-1; Wed, 04 Jan 2023 14:20:17 -0500
X-MC-Unique: bl3b8bugMxKRDZjwF4GLDA-1
Received: by mail-vs1-f70.google.com with SMTP id m63-20020a677142000000b003ce30446ff5so2052787vsc.23
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 11:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xt0fm06g6xbBT6oz+Nl9xwzNaIm++/wMnBFBdrYMQ4=;
        b=y43i+s5FlzcVBz3Lt3OKV32X+DY/1jpkZ3PfiDEFR4h8f44OmwmH3MnnYnL9LpVZOf
         LpEnQWmzNvUWYIKIB0QRtL4sma5Gwc8YjfuIPkORv2t63RpN0/+0BzcKkDNOmHtYJ8In
         ZbSDsVkaZoES/Qwnmt/1gdWvh1F2gij8hDKbnj88Uw8qVE6P961tqGyKL+bkvALNcmBL
         7yUCPMZYEb72akMGodTpj5wvP4SM1mfCCSnOzFHsbeqmabBMrzcN+TabSroaKU7uULlQ
         RBe0dQvxoQ7ESrnO1TlCD47DtVxkt4Xwk+BNcx1sfebDeKsHp4pgnkN3c+0+aH/Vxg0O
         +Pog==
X-Gm-Message-State: AFqh2krNyTWDl+O5Y8G1LL/EmsmxWPUytmZmrSG/8itRMuhCu01/Jjgt
        pqT05vbMfoIU8ZmNQ3Ok9DEcrdpiJBmHaaT1uTy7OW2J3OHZRWvhC1Ad2GguuznjIjj6DEtFntU
        t2BXYiY+so1Do55s1LRdNx/5BXBfjdd4c1L1dk6e5fPUCeZChZyOYdnRSREv2jyYnYweFwDk=
X-Received: by 2002:a67:c21d:0:b0:3ce:871e:1a2e with SMTP id i29-20020a67c21d000000b003ce871e1a2emr7209291vsj.23.1672860016985;
        Wed, 04 Jan 2023 11:20:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXveEaKETLKUqh/7AM6dmNQaT7QKB4dgU4Fli2FW0YZv2LhdP/KmHIx7n4HE79VJNP8XJ/39Cw==
X-Received: by 2002:a67:c21d:0:b0:3ce:871e:1a2e with SMTP id i29-20020a67c21d000000b003ce871e1a2emr7209262vsj.23.1672860016583;
        Wed, 04 Jan 2023 11:20:16 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b00704c9015e68sm23913399qkb.116.2023.01.04.11.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:20:16 -0800 (PST)
Message-ID: <4c566912cddf72718d0308a2f26bf38d0829901c.camel@redhat.com>
Subject: weird smp memory-barrier issue with nfsd filecache code
From:   Jeff Layton <jlayton@redhat.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        David Howells <dhowells@redhat.com>
Date:   Wed, 04 Jan 2023 14:20:15 -0500
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I had a report of a crash today. The kernel in question is older but has
a backport of the most recent nfsd filecache patches. In particular
nfsd_file_do_acquire is pretty much identical to the current mainline
code:

[1803883.048506] BUG: kernel NULL pointer dereference, address: 00000000000=
00020
[1803883.048972] #PF: supervisor read access in kernel mode
[1803883.049378] #PF: error_code(0x0000) - not-present page
[1803883.049798] PGD 0 P4D 0=20
[1803883.050171] Oops: 0000 [#1] PREEMPT SMP NOPTI
[1803883.050563] CPU: 16 PID: 3591 Comm: nfsd Kdump: loaded Tainted: G     =
      OE    --------- ---  5.14.0-210.jlayton.nfsd92.2.el9.x86_64 #1
[1803883.051386] Hardware name: Supermicro Super Server/H11SSL-NC, BIOS 1.0=
b 04/27/2018
[1803883.051820] RIP: 0010:nfsd_file_do_acquire+0x7fb/0x8b0 [nfsd]
[1803883.052286] Code: 00 00 00 41 bc 00 00 27 18 e9 46 fc ff ff 89 c2 e9 d=
f fb ff ff 48 8b 6c 24 20 65 48 ff 05 d5 57 cc 3e 49 8b 45 28 8b 74 24 08 <=
48> 8b 78 20 e8 9c 5d ff ff 89 c7 e8 95 27 ff ff 41 89 c4 e9 30 fc
[1803883.053180] RSP: 0018:ffffb4ca5269fc40 EFLAGS: 00010206
[1803883.053639] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0000002
[1803883.054106] RDX: 0000000080000000 RSI: 0000000000000002 RDI: ffff9c972=
2b6af40
[1803883.054576] RBP: ffff9c90265f0000 R08: 0000000000000006 R09: 000000000=
000062b
[1803883.055056] R10: 0000000000000866 R11: 000000000000062b R12: ffffb4ca5=
5e7d000
[1803883.055544] R13: ffff9c936c971ea0 R14: ffff9c936c971ea0 R15: ffff9c936=
c971ee0
[1803883.056067] FS:  0000000000000000(0000) GS:ffff9c9b0f700000(0000) knlG=
S:0000000000000000
[1803883.056577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1803883.057093] CR2: 0000000000000020 CR3: 0000000c3e450000 CR4: 000000000=
03506e0
[1803883.057621] Call Trace:
[1803883.058155]  <TASK>
[1803883.058700]  nfs4_get_vfs_file+0x3dd/0x410 [nfsd]
[1803883.059283]  nfsd4_process_open2+0x412/0x9f0 [nfsd]
[1803883.059854]  nfsd4_open+0x282/0x4b0 [nfsd]
[1803883.060398]  nfsd4_proc_compound+0x44b/0x6f0 [nfsd]
[1803883.060966]  nfsd_dispatch+0x149/0x270 [nfsd]
[1803883.061520]  svc_process_common+0x3bc/0x5e0 [sunrpc]
[1803883.062099]  ? nfsd_svc+0x190/0x190 [nfsd]
[1803883.062667]  ? nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
[1803883.063238]  svc_process+0xb7/0xf0 [sunrpc]
[1803883.063826]  nfsd+0xd5/0x190 [nfsd]
[1803883.064408]  kthread+0xd9/0x100
[1803883.064959]  ? kthread_complete_and_exit+0x20/0x20
[1803883.065501]  ret_from_fork+0x22/0x30
[1803883.066052]  </TASK>
[1803883.066592] Modules linked in: mst_pciconf(OE) mst_pci(OE) overlay nfs=
d nfs_acl binfmt_misc dm_cache_smq dm_cache dm_persistent_data dm_bio_priso=
n dm_bufio rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache netfs =
rbd libceph dns_resolver 8021q garp mrp stp llc bonding nft_fib_inet nft_fi=
b_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 n=
ft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag=
_ipv4 rfkill ip_set nf_tables nfnetlink rpcrdma sunrpc rdma_ucm ib_srpt ib_=
isert iscsi_target_mod target_core_mod ipmi_ssif ib_iser libiscsi scsi_tran=
sport_iscsi intel_rapl_msr ib_umad intel_rapl_common rdma_cm ib_ipoib iw_cm=
 amd64_edac edac_mce_amd ib_cm kvm_amd kvm mlx5_ib mlx4_ib ib_uverbs irqbyp=
ass rapl pcspkr ib_core joydev acpi_ipmi i2c_piix4 k10temp ipmi_si ipmi_dev=
intf ipmi_msghandler acpi_cpufreq xfs libcrc32c raid1 sd_mod sg mlx5_core a=
st drm_vram_helper drm_kms_helper syscopyarea sysfillrect crct10dif_pclmul =
sysimgblt crc32_pclmul nvme
[1803883.066656]  fb_sys_fops crc32c_intel ahci mpt3sas drm_ttm_helper nvme=
_core ttm libahci mlxfw ghash_clmulni_intel igb mlx4_core tls nvme_common d=
rm libata raid_class psample scsi_transport_sas t10_pi ccp pci_hyperv_intf =
sp5100_tco dca i2c_algo_bit dm_mirror dm_region_hash dm_log dm_mod fuse
[1803883.074377] CR2: 0000000000000020

We got a coredump from this one, and I did a bit of analysis:

wait_for_construction:
        wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE)=
;

        /* Did construction of this file fail? */
        if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
                trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
                if (!open_retry) {
                        status =3D nfserr_jukebox;
                        goto out;
                }
                open_retry =3D false;
                if (refcount_dec_and_test(&nf->nf_ref))
                        nfsd_file_free(nf);
                goto retry;
        }

        this_cpu_inc(nfsd_file_cache_hits);

        status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), =
may_flags));     <<<< CRASH HERE
out:
        if (status =3D=3D nfs_ok) {
                if (open)
                        this_cpu_inc(nfsd_file_acquisitions);
                *pnf =3D nf;
        } else {
                if (refcount_dec_and_test(&nf->nf_ref))
                        nfsd_file_free(nf);
                nf =3D NULL;
        }

out_status:
        put_cred(key.cred);
        if (open)
                trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, st=
atus);
        return status;

open_file:
        trace_nfsd_file_alloc(nf);
        nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
        if (nf->nf_mark) {
                if (open) {
                        status =3D nfsd_open_verified(rqstp, fhp, may_flags=
,
                                                    &nf->nf_file);
                        trace_nfsd_file_open(nf, status);
                } else
                        status =3D nfs_ok;
        } else
                status =3D nfserr_jukebox;
        /*
         * If construction failed, or we raced with a call to unlink()
         * then unhash.
         */
        if (status =3D=3D nfs_ok && key.inode->i_nlink =3D=3D 0)
                status =3D nfserr_jukebox;
        if (status !=3D nfs_ok)
                nfsd_file_unhash(nf);
        clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
        smp_mb__after_atomic();
        wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
        goto out;

Relevant disassembly:

/usr/src/debug/kernel-5.14.0-210.jlayton.nfsd92.2.el9/linux-5.14.0-210.jlay=
ton.nfsd92.2.el9.x86_64/./include/linux/fs.h: 1348                         =
             =20
0xffffffffc1368883 <nfsd_file_do_acquire+0x7f3>:        mov    0x28(%r13),%=
rax
/usr/src/debug/kernel-5.14.0-210.jlayton.nfsd92.2.el9/linux-5.14.0-210.jlay=
ton.nfsd92.2.el9.x86_64/fs/nfsd/filecache.c: 1145                          =
             =20
0xffffffffc1368887 <nfsd_file_do_acquire+0x7f7>:        mov    0x8(%rsp),%e=
si
0xffffffffc136888b <nfsd_file_do_acquire+0x7fb>:        mov    0x20(%rax),%=
rdi         <<< CRASH HERE

crash> struct -o nfsd_file
struct nfsd_file {
   [0x0] struct rhash_head nf_rhash;
   [0x8] struct list_head nf_lru;
  [0x18] struct callback_head nf_rcu;
  [0x28] struct file *nf_file;
  [0x30] const struct cred *nf_cred;
  [0x38] struct net *nf_net;
  [0x40] unsigned long nf_flags;
  [0x48] struct inode *nf_inode;
  [0x50] refcount_t nf_ref;
  [0x54] unsigned char nf_may;
  [0x58] struct nfsd_file_mark *nf_mark;
  [0x60] ktime_t nf_birthtime;
}

nf_file is 0x28 bytes into that struct, so the mov at +0x7f3 is probably
the dereferencing of that. That means that the addr of the nfsd_file is
(probably) in %r13. Based on that, nf_file looks like a legit address.

crash> struct nfsd_file ffff9c936c971ea0
struct nfsd_file {
  nf_rhash =3D {
    next =3D 0xffffb4ca55ef9209
  },
  nf_lru =3D {
    next =3D 0xffff9c936c971ea8,
    prev =3D 0xffff9c936c971ea8
  },
  nf_rcu =3D {
    next =3D 0xffff9c93995c3218,
    func =3D 0x0
  },
  nf_file =3D 0xffff9c9b3b080600,
  nf_cred =3D 0xffff9c9423a55a40,
  nf_net =3D 0xffffffffa200cd40 <init_net>,
  nf_flags =3D 0x1,
  nf_inode =3D 0xffff9c9c204c5500,
  nf_ref =3D {
    refs =3D {
      counter =3D 0x2
    }
  },
  nf_may =3D 0x2,
  nf_mark =3D 0xffff9c9633a85b40,
  nf_birthtime =3D 0x668a348ce435a
}

In this code, one task is opening a file for the cache and another is
waiting on the construction to complete. After we open the file, we
populate the nf_file field, clear NFSD_FILE_PENDING and wake up anyone
waiting on it.

Here though, the waiter had finished waiting but when it went to fetch
nf->nf_file in the register, it still appeared to be NULL. In the core,
it is populated with a valid file pointer however.

clear_bit_unlock does a full barrier (on x86) before clearing the bit.
According to memory-barriers.txt, wait_on_bit should imply a read memory
barrier.

Why was %rax zeroed out?
--=20
Jeff Layton <jlayton@redhat.com>

