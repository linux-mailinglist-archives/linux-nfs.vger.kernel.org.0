Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6C58330A
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiG0TJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiG0TJJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:09:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85FD624AA
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:48:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f15so14157914edc.4
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D0ehqmHLp4mc+/jn9TYycOgC3q2dMgSDmL5bFw3Bak4=;
        b=Qp/bnQb90z4g2UKr7d3eVcI3Su6pHWUP1ay7DQzbknWSeqxO9v2lmOIewS1e747TIH
         ctvHR4cOXslHoP3/Jt53WRpQ2C3mKcKbfy1L8ifG1GU8svG3a0MxHBR6C+bo0pmN1eJq
         wsLPKJLL2pN8NQIKCOonUAIsQ8Koaj5NYiiOgKFXLgYVGYHg1LKpvvPVx0n8W7Qp1X9b
         lgo2N4WeepoMAV5DuxJCrpLwaeU50T4U4FSbQ1hVdgHymu+9Iu9eyemjstBrfzi4L0uc
         88cP1cJ6YU7desTYWQGdpqD1REHvO1hcqgVWQBs4Dpdq/OI6vtagf0j79jAfPSk8dOnW
         T4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D0ehqmHLp4mc+/jn9TYycOgC3q2dMgSDmL5bFw3Bak4=;
        b=fg43DV/kXX7X5BHemK9JiN+AJxZGC/rcl5Bc/zt9fN/tOFBgiL2ZpxutJJj1kUsrq4
         bI6SZK/uYmf6W1yE4OGnGeg+fj5Q8lXdVb6fpsvprRqt2Twt6KEI2im+yCGYMD28PcI/
         P9QZ3x7k4QUFXFnpodOSF+CeJsO2yANmr7tafjHbAL5bcXi7/Zb3Op+VVC4PSKGhOOQI
         egYaw6Xap2MQjybV5hNSMIQmoTQ79gZQDctIe8Z0n3thIsphEMqeZ59PT71rqKfb8gBT
         KbtMuOM6R9x78SuwOO+gGE5Tktzbm7JPN88BdrmuvfJs/cFeKfMZPNBHunxPVGRDmH2i
         56pg==
X-Gm-Message-State: AJIora8rWt95T6ibrYtnqiVatIHbbttfiScNRf8fl9IiKjjMhi5kwwzN
        CBTQSOw169UUOwQLJRGYdTP1C1vO05AWm5xZwa+77mBI
X-Google-Smtp-Source: AGRyM1uHYbuHgiSnvidDa66HFgMKrPNo1vcUmEeeryrjUcAPqr9xgUtOT5CEt9wfIWJvEn6NcqqPYWnc9jHK7b+m438=
X-Received: by 2002:a05:6402:5193:b0:43b:e957:cdef with SMTP id
 q19-20020a056402519300b0043be957cdefmr19343131edd.345.1658947738099; Wed, 27
 Jul 2022 11:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
 <CAN-5tyEgRvvFq51kdT-ROo-ew71JE610Da=Cqf_Ya4dgYxEmKg@mail.gmail.com>
 <CAN-5tyEjNjEbR7YC7MMiYgCNEL0MdjRW+CZM71uZG1iO+YHwRQ@mail.gmail.com>
 <4F2D66E7-2D88-4A29-9115-B6F6D292F195@oracle.com> <CAN-5tyGs-N2gJrfyXt8Un2hm4Mw-iJZ22dP433im8vjK9uZgYw@mail.gmail.com>
 <FAD3BEB0-BF61-431F-BA38-10350D8F8B9B@oracle.com> <CAN-5tyFEK91=aDb2_oweevS+t8t342i02L+1a-t4w_YZu0zr3g@mail.gmail.com>
In-Reply-To: <CAN-5tyFEK91=aDb2_oweevS+t8t342i02L+1a-t4w_YZu0zr3g@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 27 Jul 2022 14:48:46 -0400
Message-ID: <CAN-5tyFQdb22wLpBJ7V_8=NefyRs5a-GGumojBuwj4HZsUu9Pg@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Put struct nfsd4_copy on a diet
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 27, 2022 at 2:21 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Wed, Jul 27, 2022 at 2:04 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
> >
> >
> >
> > > On Jul 27, 2022, at 1:52 PM, Olga Kornievskaia <aglo@umich.edu> wrote=
:
> > >
> > > After applying Dai's patch I got further... I hit the next panic
> > > (below)... before that it ran into a failure for "inter01" failed wit=
h
> > > ECOMM. On hte trace, after the COPY is places the server returns
> > > ESTALE in CB_OFFLOAD, then close is failed with BAD_SESSION (just
> > > basically something really wrong happened on the server)... After
> > > failing a new more tests in the similar fashion.. On cleanup the oops
> > > happens.
> >
> > What test should I run to reproduce this?
>
> I'm running "./nfstest_ssc". It ran thru all with "inter15" being
> last, then started "cleanup" and that's what panic-ed the server.
>
> It's been a while since I tested ssc... so i'll undo all the patched
> and re-run the tests to make sure that before code worked.

It looks like the code got broken before this patch set. The ESTALE in
CB_OFFLOAD leading to ECOM error happens without your patches. And
then the kernel panic. I'll do my best to git bisect where the problem
occurred first.

>
> > > [  842.455939] list_del corruption. prev->next should be
> > > ffff9aaa8b5f0c78, but was ffff9aaab2713508. (prev=3Dffff9aaab2713510)
> > > [  842.460118] ------------[ cut here ]------------
> > > [  842.461599] kernel BUG at lib/list_debug.c:53!
> > > [  842.462962] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > > [  842.464587] CPU: 1 PID: 500 Comm: kworker/u256:28 Not tainted 5.18=
.0 #70
> > > [  842.466656] Hardware name: VMware, Inc. VMware Virtual
> > > Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> > > [  842.470309] Workqueue: nfsd4 laundromat_main [nfsd]
> > > [  842.471898] RIP: 0010:__list_del_entry_valid.cold.3+0x37/0x4a
> > > [  842.473792] Code: e8 02 d8 fe ff 0f 0b 48 c7 c7 c0 bb b6 b0 e8 f4
> > > d7 fe ff 0f 0b 48 89 d1 48 89 f2 48 89 fe 48 c7 c7 70 bb b6 b0 e8 dd
> > > d7 fe ff <0f> 0b 48 89 fe 48 c7 c7 38 bb b6 b0 e8 cc d7 fe ff 0f 0b 4=
8
> > > 89 ee
> > > [  842.479607] RSP: 0018:ffffa996c0ca7de8 EFLAGS: 00010246
> > > [  842.481828] RAX: 000000000000006d RBX: ffff9aaa8b5f0c60 RCX: 00000=
00000000002
> > > [  842.484769] RDX: 0000000000000000 RSI: ffffffffb0b64d55 RDI: 00000=
000ffffffff
> > > [  842.487252] RBP: ffff9aaab9b62000 R08: 0000000000000000 R09: c0000=
000ffff7fff
> > > [  842.489939] R10: 0000000000000001 R11: ffffa996c0ca7c00 R12: ffffa=
996c0ca7e50
> > > [  842.492215] R13: ffff9aaab9b621b0 R14: fffffffffffffd12 R15: ffff9=
aaab9b62198
> > > [  842.494406] FS:  0000000000000000(0000) GS:ffff9aaafbe40000(0000)
> > > knlGS:0000000000000000
> > > [  842.496939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  842.498759] CR2: 000055a8b4e96010 CR3: 0000000003a18001 CR4: 00000=
000001706e0
> > > [  842.500957] Call Trace:
> > > [  842.501740]  <TASK>
> > > [  842.502479]  _free_cpntf_state_locked+0x36/0x90 [nfsd]
> > > [  842.504157]  laundromat_main+0x59e/0x8b0 [nfsd]
> > > [  842.505594]  ? finish_task_switch+0xbd/0x2a0
> > > [  842.507247]  process_one_work+0x1c8/0x390
> > > [  842.508538]  worker_thread+0x30/0x360
> > > [  842.509670]  ? process_one_work+0x390/0x390
> > > [  842.510957]  kthread+0xe8/0x110
> > > [  842.511938]  ? kthread_complete_and_exit+0x20/0x20
> > > [  842.513422]  ret_from_fork+0x22/0x30
> > > [  842.514533]  </TASK>
> > > [  842.515219] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
> > > iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
> > > xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
> > > nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
> > > vmw_vsock_vmci_transport vsock intel_rapl_msr snd_seq_midi
> > > snd_seq_midi_event intel_rapl_common crct10dif_pclmul crc32_pclmul
> > > vmw_balloon ghash_clmulni_intel pcspkr joydev btusb uvcvideo btrtl
> > > btbcm btintel videobuf2_vmalloc videobuf2_memops snd_ens1371
> > > videobuf2_v4l2 snd_ac97_codec ac97_bus videobuf2_common snd_seq
> > > videodev snd_pcm bluetooth rfkill mc snd_timer snd_rawmidi
> > > ecdh_generic snd_seq_device ecc snd soundcore vmw_vmci i2c_piix4
> > > auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg ata_generi=
c
> > > nvme nvme_core t10_pi crc32c_intel crc64_rocksoft serio_raw crc64
> > > vmwgfx vmxnet3 drm_ttm_helper ata_piix ttm drm_kms_helper syscopyarea
> > > sysfillrect sysimgblt fb_sys_fops ahci libahci drm libata
> > > [  842.541753] ---[ end trace 0000000000000000 ]---
> > > [  842.543403] RIP: 0010:__list_del_entry_valid.cold.3+0x37/0x4a
> > > [  842.545170] Code: e8 02 d8 fe ff 0f 0b 48 c7 c7 c0 bb b6 b0 e8 f4
> > > d7 fe ff 0f 0b 48 89 d1 48 89 f2 48 89 fe 48 c7 c7 70 bb b6 b0 e8 dd
> > > d7 fe ff <0f> 0b 48 89 fe 48 c7 c7 38 bb b6 b0 e8 cc d7 fe ff 0f 0b 4=
8
> > > 89 ee
> > > [  842.551346] RSP: 0018:ffffa996c0ca7de8 EFLAGS: 00010246
> > > [  842.552999] RAX: 000000000000006d RBX: ffff9aaa8b5f0c60 RCX: 00000=
00000000002
> > > [  842.555151] RDX: 0000000000000000 RSI: ffffffffb0b64d55 RDI: 00000=
000ffffffff
> > > [  842.557503] RBP: ffff9aaab9b62000 R08: 0000000000000000 R09: c0000=
000ffff7fff
> > > [  842.559694] R10: 0000000000000001 R11: ffffa996c0ca7c00 R12: ffffa=
996c0ca7e50
> > > [  842.561956] R13: ffff9aaab9b621b0 R14: fffffffffffffd12 R15: ffff9=
aaab9b62198
> > > [  842.564300] FS:  0000000000000000(0000) GS:ffff9aaafbe40000(0000)
> > > knlGS:0000000000000000
> > > [  842.567357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  842.569273] CR2: 000055a8b4e96010 CR3: 0000000003a18001 CR4: 00000=
000001706e0
> > > [  842.571598] Kernel panic - not syncing: Fatal exception
> > > [  842.573674] Kernel Offset: 0x2e800000 from 0xffffffff81000000
> > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > [ 1101.134589] ---[ end Kernel panic - not syncing: Fatal exception ]=
---
> > >
> > > On Wed, Jul 27, 2022 at 1:15 PM Chuck Lever III <chuck.lever@oracle.c=
om> wrote:
> > >>
> > >>
> > >>
> > >>> On Jul 27, 2022, at 12:18 PM, Olga Kornievskaia <aglo@umich.edu> wr=
ote:
> > >>>
> > >>> Hi Chuck,
> > >>
> > >> Sorry for the delay, I was traveling.
> > >>
> > >>> To make it compile I did:
> > >>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > >>> index 7196bcafdd86..f6deffc921d0 100644
> > >>> --- a/fs/nfsd/nfs4proc.c
> > >>> +++ b/fs/nfsd/nfs4proc.c
> > >>> @@ -1536,7 +1536,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> > >>>       if (status)
> > >>>               goto out;
> > >>>
> > >>> -       status =3D nfsd4_interssc_connect(&copy->cp_src, rqstp, mou=
nt);
> > >>> +       status =3D nfsd4_interssc_connect(copy->cp_src, rqstp, moun=
t);
> > >>>       if (status)
> > >>>               goto out;
> > >>
> > >> Yes, same bug was reported by the day-0 kbot. v1 was kind of an RFC,
> > >> as I hadn't fully tested it. Sorry for mislabeling it.
> > >>
> > >> I will post a v2 of this series with this fixed and with Dai's
> > >> fix for nfsd4_decode_copy(). Stand by.
> > >>
> > >>
> > >>> But when I tried to run the nfstest_ssc. The first test (intra01) m=
ade
> > >>> the server oops:
> > >>>
> > >>> [ 9569.551100] CPU: 0 PID: 2861 Comm: nfsd Not tainted 5.19.0-rc6+ =
#73
> > >>> [ 9569.552385] Hardware name: VMware, Inc. VMware Virtual
> > >>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> > >>> [ 9569.555043] RIP: 0010:nfsd4_copy+0x28b/0x4e0 [nfsd]
> > >>> [ 9569.556662] Code: 24 38 49 89 94 24 10 01 00 00 49 8b 56 08 48 8=
d
> > >>> 79 08 49 89 94 24 18 01 00 00 49 8b 56 10 48 83 e7 f8 49 89 94 24 2=
0
> > >>> 01 00 00 <48> 8b 06 48 89 01 48 8b 86 04 04 00 00 48 89 81 04 04 00=
 00
> > >>> 48 29
> > >>> [ 9569.561792] RSP: 0018:ffffb092c0c97dd0 EFLAGS: 00010282
> > >>> [ 9569.563112] RAX: ffff99b5465c2460 RBX: ffff99b5a68828e0 RCX: fff=
f99b5853b6000
> > >>> [ 9569.565196] RDX: 0000000000000001 RSI: 0000000000000000 RDI: fff=
f99b5853b6008
> > >>> [ 9569.567140] RBP: ffffb092c0c97e10 R08: ffffffffc0bf3c24 R09: 000=
0000000000228
> > >>> [ 9569.568929] R10: ffff99b54b0e9268 R11: ffff99b564326998 R12: fff=
f99b5543dfc00
> > >>> [ 9569.570477] R13: ffff99b5a6882950 R14: ffff99b5a68829f0 R15: fff=
f99b546edc000
> > >>> [ 9569.572052] FS:  0000000000000000(0000) GS:ffff99b5bbe00000(0000=
)
> > >>> knlGS:0000000000000000
> > >>> [ 9569.573926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >>> [ 9569.575281] CR2: 0000000000000000 CR3: 0000000076c36002 CR4: 000=
00000001706f0
> > >>> [ 9569.577586] Call Trace:
> > >>> [ 9569.578220]  <TASK>
> > >>> [ 9569.578770]  ? nfsd4_proc_compound+0x3d2/0x730 [nfsd]
> > >>> [ 9569.579945]  nfsd4_proc_compound+0x3d2/0x730 [nfsd]
> > >>> [ 9569.581055]  nfsd_dispatch+0x146/0x270 [nfsd]
> > >>> [ 9569.581987]  svc_process_common+0x365/0x5c0 [sunrpc]
> > >>> [ 9569.583122]  ? nfsd_svc+0x350/0x350 [nfsd]
> > >>> [ 9569.583986]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> > >>> [ 9569.585129]  svc_process+0xb7/0xf0 [sunrpc]
> > >>> [ 9569.586169]  nfsd+0xd5/0x190 [nfsd]
> > >>> [ 9569.587170]  kthread+0xe8/0x110
> > >>> [ 9569.587898]  ? kthread_complete_and_exit+0x20/0x20
> > >>> [ 9569.588934]  ret_from_fork+0x22/0x30
> > >>> [ 9569.589759]  </TASK>
> > >>> [ 9569.590224] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_c=
m
> > >>> iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
> > >>> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
> > >>> nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bn=
ep
> > >>> vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event
> > >>> intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul
> > >>> vmw_balloon ghash_clmulni_intel joydev pcspkr btusb btrtl btbcm
> > >>> btintel snd_ens1371 uvcvideo snd_ac97_codec videobuf2_vmalloc ac97_=
bus
> > >>> videobuf2_memops videobuf2_v4l2 videobuf2_common snd_seq snd_pcm
> > >>> videodev bluetooth mc rfkill ecdh_generic ecc snd_timer snd_rawmidi
> > >>> snd_seq_device snd vmw_vmci soundcore i2c_piix4 auth_rpcgss sunrpc
> > >>> ip_tables xfs libcrc32c sr_mod cdrom sg ata_generic crc32c_intel
> > >>> ata_piix nvme ahci libahci nvme_core t10_pi crc64_rocksoft serio_ra=
w
> > >>> crc64 vmwgfx drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillr=
ect
> > >>> sysimgblt fb_sys_fops vmxnet3 drm libata
> > >>> [ 9569.610612] CR2: 0000000000000000
> > >>> [ 9569.611375] ---[ end trace 0000000000000000 ]---
> > >>> [ 9569.612424] RIP: 0010:nfsd4_copy+0x28b/0x4e0 [nfsd]
> > >>> [ 9569.613472] Code: 24 38 49 89 94 24 10 01 00 00 49 8b 56 08 48 8=
d
> > >>> 79 08 49 89 94 24 18 01 00 00 49 8b 56 10 48 83 e7 f8 49 89 94 24 2=
0
> > >>> 01 00 00 <48> 8b 06 48 89 01 48 8b 86 04 04 00 00 48 89 81 04 04 00=
 00
> > >>> 48 29
> > >>> [ 9569.617410] RSP: 0018:ffffb092c0c97dd0 EFLAGS: 00010282
> > >>> [ 9569.618487] RAX: ffff99b5465c2460 RBX: ffff99b5a68828e0 RCX: fff=
f99b5853b6000
> > >>> [ 9569.620097] RDX: 0000000000000001 RSI: 0000000000000000 RDI: fff=
f99b5853b6008
> > >>> [ 9569.621710] RBP: ffffb092c0c97e10 R08: ffffffffc0bf3c24 R09: 000=
0000000000228
> > >>> [ 9569.623398] R10: ffff99b54b0e9268 R11: ffff99b564326998 R12: fff=
f99b5543dfc00
> > >>> [ 9569.625019] R13: ffff99b5a6882950 R14: ffff99b5a68829f0 R15: fff=
f99b546edc000
> > >>> [ 9569.627456] FS:  0000000000000000(0000) GS:ffff99b5bbe00000(0000=
)
> > >>> knlGS:0000000000000000
> > >>> [ 9569.629249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >>> [ 9569.630433] CR2: 0000000000000000 CR3: 0000000076c36002 CR4: 000=
00000001706f0
> > >>> [ 9569.632043] Kernel panic - not syncing: Fatal exception
> > >>>
> > >>>
> > >>>
> > >>> On Tue, Jul 26, 2022 at 3:45 PM Olga Kornievskaia <aglo@umich.edu> =
wrote:
> > >>>>
> > >>>> Chuck,
> > >>>>
> > >>>> Are there pre-reqs for this series? I had tried to apply the patch=
es
> > >>>> on top of 5-19-rc6 but I get the following compile error:
> > >>>>
> > >>>> fs/nfsd/nfs4proc.c: In function =E2=80=98nfsd4_setup_inter_ssc=E2=
=80=99:
> > >>>> fs/nfsd/nfs4proc.c:1539:34: error: passing argument 1 of
> > >>>> =E2=80=98nfsd4_interssc_connect=E2=80=99 from incompatible pointer=
 type
> > >>>> [-Werror=3Dincompatible-pointer-types]
> > >>>> status =3D nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
> > >>>>                                 ^~~~~~~~~~~~~
> > >>>> fs/nfsd/nfs4proc.c:1414:43: note: expected =E2=80=98struct nl4_ser=
ver *=E2=80=99 but
> > >>>> argument is of type =E2=80=98struct nl4_server **=E2=80=99
> > >>>> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rq=
stp,
> > >>>>                       ~~~~~~~~~~~~~~~~~~~^~~
> > >>>> cc1: some warnings being treated as errors
> > >>>> make[2]: *** [scripts/Makefile.build:249: fs/nfsd/nfs4proc.o] Erro=
r 1
> > >>>> make[1]: *** [scripts/Makefile.build:466: fs/nfsd] Error 2
> > >>>> make: *** [Makefile:1843: fs] Error 2
> > >>>>
> > >>>> On Fri, Jul 22, 2022 at 4:36 PM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
> > >>>>>
> > >>>>> While testing NFSD for-next, I noticed svc_generic_init_request()
> > >>>>> was an unexpected hot spot on NFSv4 workloads. Drilling into the
> > >>>>> perf report, it shows that the hot path in there is:
> > >>>>>
> > >>>>> 1208         memset(rqstp->rq_argp, 0, procp->pc_argsize);
> > >>>>> 1209         memset(rqstp->rq_resp, 0, procp->pc_ressize);
> > >>>>>
> > >>>>> For an NFSv4 COMPOUND,
> > >>>>>
> > >>>>>       procp->pc_argsize =3D sizeof(nfsd4_compoundargs),
> > >>>>>
> > >>>>> struct nfsd4_compoundargs on my system is more than 17KB! This is
> > >>>>> due to the size of the iops field:
> > >>>>>
> > >>>>>       struct nfsd4_op                 iops[8];
> > >>>>>
> > >>>>> Each struct nfsd4_op contains a union of the arguments for each
> > >>>>> NFSv4 operation. Each argument is typically less than 128 bytes
> > >>>>> except that struct nfsd4_copy and struct nfsd4_copy_notify are bo=
th
> > >>>>> larger than 2KB each.
> > >>>>>
> > >>>>> I'm not yet totally convinced this series never orphans memory, b=
ut
> > >>>>> it does reduce the size of nfsd4_compoundargs to just over 4KB. T=
his
> > >>>>> is still due to struct nfsd4_copy being almost 500 bytes. I don't
> > >>>>> see more low-hanging fruit there, though.
> > >>>>>
> > >>>>> ---
> > >>>>>
> > >>>>> Chuck Lever (11):
> > >>>>>     NFSD: Shrink size of struct nfsd4_copy_notify
> > >>>>>     NFSD: Shrink size of struct nfsd4_copy
> > >>>>>     NFSD: Reorder the fields in struct nfsd4_op
> > >>>>>     NFSD: Make nfs4_put_copy() static
> > >>>>>     NFSD: Make boolean fields in struct nfsd4_copy into atomic bi=
t flags
> > >>>>>     NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
> > >>>>>     NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
> > >>>>>     NFSD: Refactor nfsd4_do_copy()
> > >>>>>     NFSD: Remove kmalloc from nfsd4_do_async_copy()
> > >>>>>     NFSD: Add nfsd4_send_cb_offload()
> > >>>>>     NFSD: Move copy offload callback arguments into a separate st=
ructure
> > >>>>>
> > >>>>>
> > >>>>> fs/nfsd/nfs4callback.c |  37 +++++----
> > >>>>> fs/nfsd/nfs4proc.c     | 165 +++++++++++++++++++++---------------=
-----
> > >>>>> fs/nfsd/nfs4xdr.c      |  30 +++++---
> > >>>>> fs/nfsd/state.h        |   1 -
> > >>>>> fs/nfsd/xdr4.h         |  54 ++++++++++----
> > >>>>> 5 files changed, 163 insertions(+), 124 deletions(-)
> > >>>>>
> > >>>>> --
> > >>>>> Chuck Lever
> > >>>>>
> > >>
> > >> --
> > >> Chuck Lever
> > >>
> > >>
> > >>
> >
> > --
> > Chuck Lever
> >
> >
> >
