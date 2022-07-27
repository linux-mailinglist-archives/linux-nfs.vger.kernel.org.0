Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1278E582A8B
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiG0QS7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 12:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiG0QS7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 12:18:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691353D5A6
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 09:18:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w5so9636347edd.13
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6C3shnyidiu4ynzugFyQYE6sb8PShvAPEf/z5Kb0OOQ=;
        b=ZQmNoA33EmQ/0x965VXLh9cISWmNA3Hq2oY92bGkZBDDaLYQEcvZZjL+YCX1M0R8yL
         2kc049J+IhSXH22CpPCoOA8vqwJR3pFYKY5MxQtPdZatpr4q7pXreXW3yuJbYDUuos7X
         sfaW87jc9Gq6WKmswWnLuE4h03rrwNIQMSq0L0Mmt37vIcxEN3N3UlXMMll2/VCT3Kdh
         FEABZCDfT++c0Upmnrb9snYyeuf87Sce5jeURDAyL3rsdI915VBRACBpGQYzycwRgiBf
         4+3Mi1M/bqz8/koCCpq4E33ZPewHkSfYAXZg/CSBeY4FBrWQ9SpYZSS7+4QSJfuTT1Sz
         FPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6C3shnyidiu4ynzugFyQYE6sb8PShvAPEf/z5Kb0OOQ=;
        b=xIyJ7gFlM3P/At/6RMRXel9EYEaofs9+wCVTbh++aJPaxwBcwOdXR+lu+wNpEasB6U
         N9S1iL8yD+XVB+YHUPDVdjC+bAL/+OhsmYE2fEmp+CirBVYPhdZa7gZyz+vpHD4EWBqI
         2F+dMi/dKrv3uQR67lXYv48pDbO+xiGKYLZFCeeS81x/0zshUx7GeLaIObWUwUvjkiVx
         UxhjhXTbHOYf9skTiJBQMPT62qHnpZ5us/MueQq0G3mbxwpEaLw30hkQWZnr3tZqVACm
         uTtlE0ox55hLxXvFS0/RFHsA4W1mURhrxonRFiEYO134g9qmzXzAkV8FX1FiNYmCyVOz
         ldOQ==
X-Gm-Message-State: AJIora9ECBq3P7O4PSxudQpAP5gSfde3BiX3hpwhDLdka8w83YURSkuM
        13m0VNDz7jacle4FiaiJdZ4MxVlkh5CgHpWOxtg4By5ErFU=
X-Google-Smtp-Source: AGRyM1tBOgy5iAaIP68bxEDslNuuYeTMIUVTxZ1JySFMTGltZsM/NDEX5y3gG1wIwJwDSicqaVbTrHjlt8n0x21BGoQ=
X-Received: by 2002:a05:6402:1cae:b0:43b:a3d8:854a with SMTP id
 cz14-20020a0564021cae00b0043ba3d8854amr23482122edb.276.1658938735765; Wed, 27
 Jul 2022 09:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net> <CAN-5tyEgRvvFq51kdT-ROo-ew71JE610Da=Cqf_Ya4dgYxEmKg@mail.gmail.com>
In-Reply-To: <CAN-5tyEgRvvFq51kdT-ROo-ew71JE610Da=Cqf_Ya4dgYxEmKg@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 27 Jul 2022 12:18:44 -0400
Message-ID: <CAN-5tyEjNjEbR7YC7MMiYgCNEL0MdjRW+CZM71uZG1iO+YHwRQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Put struct nfsd4_copy on a diet
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
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

Hi Chuck,

To make it compile I did:
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7196bcafdd86..f6deffc921d0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1536,7 +1536,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
        if (status)
                goto out;

-       status =3D nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
+       status =3D nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
        if (status)
                goto out;

But when I tried to run the nfstest_ssc. The first test (intra01) made
the server oops:

[ 9569.551100] CPU: 0 PID: 2861 Comm: nfsd Not tainted 5.19.0-rc6+ #73
[ 9569.552385] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[ 9569.555043] RIP: 0010:nfsd4_copy+0x28b/0x4e0 [nfsd]
[ 9569.556662] Code: 24 38 49 89 94 24 10 01 00 00 49 8b 56 08 48 8d
79 08 49 89 94 24 18 01 00 00 49 8b 56 10 48 83 e7 f8 49 89 94 24 20
01 00 00 <48> 8b 06 48 89 01 48 8b 86 04 04 00 00 48 89 81 04 04 00 00
48 29
[ 9569.561792] RSP: 0018:ffffb092c0c97dd0 EFLAGS: 00010282
[ 9569.563112] RAX: ffff99b5465c2460 RBX: ffff99b5a68828e0 RCX: ffff99b5853=
b6000
[ 9569.565196] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff99b5853=
b6008
[ 9569.567140] RBP: ffffb092c0c97e10 R08: ffffffffc0bf3c24 R09: 00000000000=
00228
[ 9569.568929] R10: ffff99b54b0e9268 R11: ffff99b564326998 R12: ffff99b5543=
dfc00
[ 9569.570477] R13: ffff99b5a6882950 R14: ffff99b5a68829f0 R15: ffff99b546e=
dc000
[ 9569.572052] FS:  0000000000000000(0000) GS:ffff99b5bbe00000(0000)
knlGS:0000000000000000
[ 9569.573926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9569.575281] CR2: 0000000000000000 CR3: 0000000076c36002 CR4: 00000000001=
706f0
[ 9569.577586] Call Trace:
[ 9569.578220]  <TASK>
[ 9569.578770]  ? nfsd4_proc_compound+0x3d2/0x730 [nfsd]
[ 9569.579945]  nfsd4_proc_compound+0x3d2/0x730 [nfsd]
[ 9569.581055]  nfsd_dispatch+0x146/0x270 [nfsd]
[ 9569.581987]  svc_process_common+0x365/0x5c0 [sunrpc]
[ 9569.583122]  ? nfsd_svc+0x350/0x350 [nfsd]
[ 9569.583986]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
[ 9569.585129]  svc_process+0xb7/0xf0 [sunrpc]
[ 9569.586169]  nfsd+0xd5/0x190 [nfsd]
[ 9569.587170]  kthread+0xe8/0x110
[ 9569.587898]  ? kthread_complete_and_exit+0x20/0x20
[ 9569.588934]  ret_from_fork+0x22/0x30
[ 9569.589759]  </TASK>
[ 9569.590224] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event
intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul
vmw_balloon ghash_clmulni_intel joydev pcspkr btusb btrtl btbcm
btintel snd_ens1371 uvcvideo snd_ac97_codec videobuf2_vmalloc ac97_bus
videobuf2_memops videobuf2_v4l2 videobuf2_common snd_seq snd_pcm
videodev bluetooth mc rfkill ecdh_generic ecc snd_timer snd_rawmidi
snd_seq_device snd vmw_vmci soundcore i2c_piix4 auth_rpcgss sunrpc
ip_tables xfs libcrc32c sr_mod cdrom sg ata_generic crc32c_intel
ata_piix nvme ahci libahci nvme_core t10_pi crc64_rocksoft serio_raw
crc64 vmwgfx drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops vmxnet3 drm libata
[ 9569.610612] CR2: 0000000000000000
[ 9569.611375] ---[ end trace 0000000000000000 ]---
[ 9569.612424] RIP: 0010:nfsd4_copy+0x28b/0x4e0 [nfsd]
[ 9569.613472] Code: 24 38 49 89 94 24 10 01 00 00 49 8b 56 08 48 8d
79 08 49 89 94 24 18 01 00 00 49 8b 56 10 48 83 e7 f8 49 89 94 24 20
01 00 00 <48> 8b 06 48 89 01 48 8b 86 04 04 00 00 48 89 81 04 04 00 00
48 29
[ 9569.617410] RSP: 0018:ffffb092c0c97dd0 EFLAGS: 00010282
[ 9569.618487] RAX: ffff99b5465c2460 RBX: ffff99b5a68828e0 RCX: ffff99b5853=
b6000
[ 9569.620097] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff99b5853=
b6008
[ 9569.621710] RBP: ffffb092c0c97e10 R08: ffffffffc0bf3c24 R09: 00000000000=
00228
[ 9569.623398] R10: ffff99b54b0e9268 R11: ffff99b564326998 R12: ffff99b5543=
dfc00
[ 9569.625019] R13: ffff99b5a6882950 R14: ffff99b5a68829f0 R15: ffff99b546e=
dc000
[ 9569.627456] FS:  0000000000000000(0000) GS:ffff99b5bbe00000(0000)
knlGS:0000000000000000
[ 9569.629249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9569.630433] CR2: 0000000000000000 CR3: 0000000076c36002 CR4: 00000000001=
706f0
[ 9569.632043] Kernel panic - not syncing: Fatal exception



On Tue, Jul 26, 2022 at 3:45 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> Chuck,
>
> Are there pre-reqs for this series? I had tried to apply the patches
> on top of 5-19-rc6 but I get the following compile error:
>
> fs/nfsd/nfs4proc.c: In function =E2=80=98nfsd4_setup_inter_ssc=E2=80=99:
> fs/nfsd/nfs4proc.c:1539:34: error: passing argument 1 of
> =E2=80=98nfsd4_interssc_connect=E2=80=99 from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>   status =3D nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
>                                   ^~~~~~~~~~~~~
> fs/nfsd/nfs4proc.c:1414:43: note: expected =E2=80=98struct nl4_server *=
=E2=80=99 but
> argument is of type =E2=80=98struct nl4_server **=E2=80=99
>  nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>                         ~~~~~~~~~~~~~~~~~~~^~~
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:249: fs/nfsd/nfs4proc.o] Error 1
> make[1]: *** [scripts/Makefile.build:466: fs/nfsd] Error 2
> make: *** [Makefile:1843: fs] Error 2
>
> On Fri, Jul 22, 2022 at 4:36 PM Chuck Lever <chuck.lever@oracle.com> wrot=
e:
> >
> > While testing NFSD for-next, I noticed svc_generic_init_request()
> > was an unexpected hot spot on NFSv4 workloads. Drilling into the
> > perf report, it shows that the hot path in there is:
> >
> > 1208         memset(rqstp->rq_argp, 0, procp->pc_argsize);
> > 1209         memset(rqstp->rq_resp, 0, procp->pc_ressize);
> >
> > For an NFSv4 COMPOUND,
> >
> >         procp->pc_argsize =3D sizeof(nfsd4_compoundargs),
> >
> > struct nfsd4_compoundargs on my system is more than 17KB! This is
> > due to the size of the iops field:
> >
> >         struct nfsd4_op                 iops[8];
> >
> > Each struct nfsd4_op contains a union of the arguments for each
> > NFSv4 operation. Each argument is typically less than 128 bytes
> > except that struct nfsd4_copy and struct nfsd4_copy_notify are both
> > larger than 2KB each.
> >
> > I'm not yet totally convinced this series never orphans memory, but
> > it does reduce the size of nfsd4_compoundargs to just over 4KB. This
> > is still due to struct nfsd4_copy being almost 500 bytes. I don't
> > see more low-hanging fruit there, though.
> >
> > ---
> >
> > Chuck Lever (11):
> >       NFSD: Shrink size of struct nfsd4_copy_notify
> >       NFSD: Shrink size of struct nfsd4_copy
> >       NFSD: Reorder the fields in struct nfsd4_op
> >       NFSD: Make nfs4_put_copy() static
> >       NFSD: Make boolean fields in struct nfsd4_copy into atomic bit fl=
ags
> >       NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
> >       NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
> >       NFSD: Refactor nfsd4_do_copy()
> >       NFSD: Remove kmalloc from nfsd4_do_async_copy()
> >       NFSD: Add nfsd4_send_cb_offload()
> >       NFSD: Move copy offload callback arguments into a separate struct=
ure
> >
> >
> >  fs/nfsd/nfs4callback.c |  37 +++++----
> >  fs/nfsd/nfs4proc.c     | 165 +++++++++++++++++++++--------------------
> >  fs/nfsd/nfs4xdr.c      |  30 +++++---
> >  fs/nfsd/state.h        |   1 -
> >  fs/nfsd/xdr4.h         |  54 ++++++++++----
> >  5 files changed, 163 insertions(+), 124 deletions(-)
> >
> > --
> > Chuck Lever
> >
