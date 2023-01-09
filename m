Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E70662AB1
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 17:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbjAIQAG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 11:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjAIP7p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 10:59:45 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBFF3C71F
        for <linux-nfs@vger.kernel.org>; Mon,  9 Jan 2023 07:59:36 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id h7so2260271pfq.4
        for <linux-nfs@vger.kernel.org>; Mon, 09 Jan 2023 07:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0WJHHuQRO+OwAj7tSo/0relzblKjlGwor8Jh56l5IO0=;
        b=a7CqbDCLWGjwc/dJaZILaz16vcbOkmP4pQ5pF3z4Z4wj1GIRj04u1XkbVNpCLssUFo
         Gaa7cb7FdUU9goOrriWkCzGaWm5NliXuRFWut41BgiZrRMojZKQcyl143QQNE9bz0O80
         u3O7Bzo52iVCc7qYUcDeBy48MwmoNcOkZo37MDiLGz96YzxzshEv7QAYK45HTO3LUJs5
         uCjcEftDfqgmD+pHmdoDuGrgdBaLJ5kBIQKPQO88skG/pciN+c6Qh2PTrHHwU57FOy7V
         Zvp8QZ8fbUnL9LxSVY3g4x426e84pIbmRG4/xQEtRJ2oWqXoTuvaXZ8OJQ6VL8GhKP1/
         i5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WJHHuQRO+OwAj7tSo/0relzblKjlGwor8Jh56l5IO0=;
        b=PZ38T2WYU39WgxRA8IV63klISOLgLAVRdN2Fb6RRjrhjLQhc+A9pOj3b5t8+2nFDPc
         Wqxf+Euer/pQ3YQ01iTQ1D5atZHFi6yxEtWUBn5CDnehsctK2Sa0UjH0peTrtMBrFRqn
         OutwDLTg8SMfgUe4ogM0/1pvtLQNwFE4Lo5rRtt0VI5b+wwIm9GqGFv/41tMytVeLDct
         fWPMBvD2tG1Xo1spwHabq77DVFS9NR2s5z1euzgPrlWO9GL4kvILxjZ82p0mOfV69tg1
         tQ3CtJjcqRdpAYeDZbAYtk0OEU71Q8bzSOO2+/8WCFekQ+MyJn3+Xu0kBTAl72Yj81vK
         TytQ==
X-Gm-Message-State: AFqh2koFl/7REAbxhuuf34HjJObQtBJpS/ki6psPWBTYkqKtuec8Ra0U
        qWTd2qXN68INv/NZzHbpkS2zKjGTtWXGYV6fHXE2l9GubHc=
X-Google-Smtp-Source: AMrXdXta4Y7vJpod7tKi+fxHK1H9fiWlQAqrQ5TU3EFX+4LM8ljo8jsrEOBAe1dPobWHISleTaDstaOhD7qmZRwHtF4=
X-Received: by 2002:a05:6a00:2c87:b0:583:1387:6f50 with SMTP id
 ef7-20020a056a002c8700b0058313876f50mr1404465pfb.29.1673279976155; Mon, 09
 Jan 2023 07:59:36 -0800 (PST)
MIME-Version: 1.0
References: <1671411353-31165-1-git-send-email-dai.ngo@oracle.com>
 <28572446-B32A-461F-A9C1-E60F79B985D3@oracle.com> <CAN-5tyEL1FvvCMgg=NWrHcAvLdXFKZQ_p1T8gRhH9hUoD3jPhA@mail.gmail.com>
 <e46fdd1c-3a61-9849-e06a-f7df8dd78622@oracle.com> <CAN-5tyECjk5z8wsJ28GU_j0nL7eNwzv7Vt=dVc4UGvYgZqDYJg@mail.gmail.com>
 <CAN-5tyGdbhvNHXKRqxX48X3nvpUDPgfrM4++a2SPcuxJunkxmQ@mail.gmail.com> <85c49a4e-632a-dd5e-f56b-af28312dbb8b@oracle.com>
In-Reply-To: <85c49a4e-632a-dd5e-f56b-af28312dbb8b@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 9 Jan 2023 10:59:24 -0500
Message-ID: <CAN-5tyEbbHVFGEBMN3o6UAqqimSL_KdtkGPfsotNW-WhXNj9XQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
To:     dai.ngo@oracle.com
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 6, 2023 at 4:23 PM <dai.ngo@oracle.com> wrote:
>
>
> On 1/6/23 12:11 PM, Olga Kornievskaia wrote:
> > On Thu, Jan 5, 2023 at 4:11 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >> On Thu, Jan 5, 2023 at 3:00 PM <dai.ngo@oracle.com> wrote:
> >>> Hi Olga,
> >>>
> >>> On 1/5/23 8:10 AM, Olga Kornievskaia wrote:
> >>>> On Tue, Jan 3, 2023 at 11:14 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>>>>
> >>>>>> On Dec 18, 2022, at 7:55 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>>>>>
> >>>>>> Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
> >>>>>> server's export when the mount completes. After the copy is done
> >>>>>> nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
> >>>>>> server and it searches nfsd_ssc_mount_list for a matching entry
> >>>>>> to do the clean up.
> >>>>>>
> >>>>>> The problems with this approach are (1) the need to search the
> >>>>>> nfsd_ssc_mount_list and (2) the code has to handle the case where
> >>>>>> the matching entry is not found which looks ugly.
> >>>>>>
> >>>>>> The enhancement is instead of nfsd4_setup_inter_ssc returning the
> >>>>>> vfsmount, it returns the nfsd4_ssc_umount_item which has the
> >>>>>> vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
> >>>>>> it's passed with the nfsd4_ssc_umount_item directly to do the
> >>>>>> clean up so no searching is needed and there is no need to handle
> >>>>>> the 'not found' case.
> >>>>>>
> >>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>>>>> ---
> >>>>>> V2: fix compile error when CONFIG_NFSD_V4_2_INTER_SSC not defined.
> >>>>>>      Reported by kernel test robot.
> >>>>> Hello Dai - I've looked at this, nothing to comment on so far. I
> >>>>> plan to go over it again sometime this week.
> >>>>>
> >>>>> I'd like to hear from others before applying it.
> >>>> I have looked at it and logically it seems ok to me.
> >>> Thank you for reviewing the patch.
> >>>
> >>>>    I have tested it
> >>>> (sorta. i'm rarely able to finish). But I keep running into the other
> >>>> problem (nfsd4_state_shrinker_count soft lockup that's been already
> >>>> reported). I find it interesting that only my destination server hits
> >>>> the problem (but not the source server). I don't believe this patch
> >>>> has anything to do with this problem, but I found it interesting that
> >>>> ssc testing seems to trigger it 100%.
> >>> It's strange that you and Mike keep having this problem, I've been trying
> >>> to reproduce the problem using Mike's procedure with no success.
> >>>
> >>>   From Mike's report it seems that the struct delayed_work, part of the
> >>> nfsd_net, was freed when nfsd4_state_shrinker_count was called. I'm trying
> >>> to see why this could happen. Currently we call unregister_shrinker from
> >>> nfsd_exit_net. Perhaps there is another path that the nfsd_net can be
> >>> freed?
> >>>
> >>> Can you share your test procedure so I can try?
> >> I have nothing special. I have 3 RHEL8 VMs running upstream kernels. 2
> >> servers and 1 client. I'm just running nfstest_ssc --runtest inter01.
> >> Given that the trace says it's kswapd that has this trace, doesn't it
> >> mean my VM is stressed for memory perhaps. So perhaps see if you can
> >> reduce your VM memsize? My VM has 2G of memory.
> >>
> >> I have reverted a1049eb47f20 commit but that didn't help.
> > Ops. I reverted the wrong commit(s). Reverted 44df6f439a17,
> > 3959066b697b, and the tracepoint one for cb_recall_any. I can run
> > clean thru the ssc tests with this new patch.
>
> Can you elaborate on the nfsd4_state_shrinker_count soft lockup
> encountered when running the ssc tests with the above commits?
> I'd like to make sure these are the same problems that Mike
> reported.

I do believe it's the same as Mike's:

[ 3950.448053] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [khugepaged:36]
[ 3950.452509] Modules linked in: nfsv4 dns_resolver nfs nfsd lockd
grace fuse xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ipt_REJECT nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge
stp llc bnep vmw_vsock_vmci_transport vsock intel_rapl_msr
intel_rapl_common crct10dif_pclmul crc32_pclmul vmw_balloon
ghash_clmulni_intel snd_seq_midi snd_seq_midi_event joydev pcspkr
snd_ens1371 snd_ac97_codec ac97_bus snd_seq btusb btrtl btbcm btintel
snd_pcm bluetooth rfkill snd_timer ecdh_generic snd_rawmidi ecc
snd_seq_device snd soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc
ip_tables xfs libcrc32c sr_mod cdrom sg crc32c_intel nvme ata_generic
vmwgfx drm_ttm_helper ttm serio_raw drm_kms_helper syscopyarea
nvme_core t10_pi sysfillrect sysimgblt fb_sys_fops ahci crc64_rocksoft
crc64 libahci ata_piix vmxnet3 libata drm
[ 3950.467923] CPU: 1 PID: 36 Comm: khugepaged Tainted: G        W
     6.1.0-rc7+ #107
[ 3950.469642] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[ 3950.471890] RIP: 0010:try_to_grab_pending+0xf7/0x230
[ 3950.472941] Code: 00 4d 3b 27 74 63 4c 89 e7 e8 65 f1 f2 00 e8 a0
23 0b 00 48 89 ef e8 08 c9 3a 00 48 8b 45 00 f6 c4 02 74 01 fb be 08
00 00 00 <48> 89 df e8 21 d5 3a 00 48 89 df e8 e9 c8 3a 00 48 8b 13 b8
fe ff
[ 3950.476751] RSP: 0018:ffff88805a6d71d8 EFLAGS: 00000202
[ 3950.477839] RAX: 0000000000000296 RBX: ffff88801c701b58 RCX: ffffffff8a14d5b8
[ 3950.479317] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88805a6d7238
[ 3950.480799] RBP: ffff88805a6d7238 R08: ffffed10038e036c R09: ffffed10038e036c
[ 3950.482319] R10: ffff88801c701b5f R11: ffffed10038e036b R12: ffff888057c3f6c0
[ 3950.483847] R13: 0000000000000296 R14: 0000000000000000 R15: ffff88801c701b58
[ 3950.485345] FS:  0000000000000000(0000) GS:ffff888057c80000(0000)
knlGS:0000000000000000
[ 3950.487056] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3950.488265] CR2: 0000563b65c0bcd8 CR3: 0000000024df4005 CR4: 00000000001706e0
[ 3950.489802] Call Trace:
[ 3950.490320]  <TASK>
[ 3950.490826]  mod_delayed_work_on+0x7c/0xf0
[ 3950.491692]  ? queue_delayed_work_on+0x70/0x70
[ 3950.492645]  ? __rcu_read_unlock+0x4e/0x250
[ 3950.493603]  ? list_lru_count_one+0x73/0xc0
[ 3950.494539]  nfsd4_state_shrinker_count+0x3f/0x70 [nfsd]
[ 3950.496149]  do_shrink_slab+0x49/0x490
[ 3950.496971]  ? _find_next_bit+0x7c/0xc0
[ 3950.497802]  shrink_slab+0x113/0x400
[ 3950.498692]  ? cgroup_rstat_flush_locked+0x64/0x560
[ 3950.499766]  ? set_shrinker_bit+0xb0/0xb0
[ 3950.500589]  ? _raw_spin_unlock_irqrestore+0x40/0x40
[ 3950.501673]  ? mem_cgroup_iter+0x14e/0x2f0
[ 3950.502580]  shrink_node+0x556/0xd10
[ 3950.503373]  do_try_to_free_pages+0x203/0x8c0
[ 3950.504324]  ? shrink_node+0xd10/0xd10
[ 3950.505109]  ? __isolate_free_page+0x240/0x240
[ 3950.506104]  ? try_to_compact_pages+0x225/0x460
[ 3950.507069]  try_to_free_pages+0x166/0x320
[ 3950.507932]  ? reclaim_pages+0x2c0/0x2c0
[ 3950.508756]  ? find_busiest_group+0x25f/0x590
[ 3950.509710]  __alloc_pages_slowpath.constprop.120+0x59d/0x1250
[ 3950.511047]  ? __next_zones_zonelist+0x6e/0xa0
[ 3950.511997]  ? warn_alloc+0x140/0x140
[ 3950.512773]  ? __isolate_free_page+0x240/0x240
[ 3950.513787]  ? find_busiest_group+0x590/0x590
[ 3950.514735]  __alloc_pages+0x43f/0x460
[ 3950.515519]  ? __alloc_pages_slowpath.constprop.120+0x1250/0x1250
[ 3950.516817]  ? __rcu_read_unlock+0x4e/0x250
[ 3950.517763]  alloc_charge_hpage+0x138/0x310
[ 3950.518681]  collapse_huge_page+0xfc/0xec0
[ 3950.519575]  ? dequeue_entity+0x1fe/0x760
[ 3950.520440]  ? __collapse_huge_page_isolate.isra.65+0xb80/0xb80
[ 3950.521747]  ? _raw_spin_lock_irqsave+0x8d/0xf0
[ 3950.522740]  ? _raw_spin_unlock_irqrestore+0x40/0x40
[ 3950.523794]  ? __schedule+0x575/0xf70
[ 3950.524620]  ? lock_timer_base+0x9c/0xc0
[ 3950.525527]  ? detach_if_pending+0x22/0x190
[ 3950.526500]  ? preempt_count_sub+0x14/0xc0
[ 3950.527406]  ? _raw_spin_unlock_irqrestore+0x1e/0x40
[ 3950.528506]  ? vm_normal_page+0xd7/0x1b0
[ 3950.529378]  hpage_collapse_scan_pmd+0x8c5/0xad0
[ 3950.530339]  ? collapse_huge_page+0xec0/0xec0
[ 3950.531288]  ? hugepage_vma_check+0x276/0x2a0
[ 3950.532266]  khugepaged+0x653/0xaf0
[ 3950.533039]  ? collapse_pte_mapped_thp+0x7c0/0x7c0
[ 3950.534069]  ? set_next_entity+0xb1/0x2b0
[ 3950.534894]  ? __list_add_valid+0x3f/0x80
[ 3950.535790]  ? preempt_count_sub+0x14/0xc0
[ 3950.536681]  ? _raw_spin_unlock+0x15/0x30
[ 3950.537529]  ? finish_task_switch+0xe5/0x3e0
[ 3950.538481]  ? __switch_to+0x2fa/0x680
[ 3950.539374]  ? add_wait_queue+0x110/0x110
[ 3950.540284]  ? _raw_spin_lock_irqsave+0x8d/0xf0
[ 3950.541246]  ? blake2s_compress_generic+0x741/0x1310
[ 3950.542295]  ? collapse_pte_mapped_thp+0x7c0/0x7c0
[ 3950.543353]  kthread+0x160/0x190
[ 3950.544036]  ? kthread_complete_and_exit+0x20/0x20
[ 3950.545051]  ret_from_fork+0x1f/0x30
[ 3950.545836]  </TASK>


>
> Thanks,
> -Dai
>
>
> >
> >>
> >>> Thanks,
> >>> -Dai
> >>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>>> fs/nfsd/nfs4proc.c      | 94 +++++++++++++++++++------------------------------
> >>>>>> fs/nfsd/xdr4.h          |  2 +-
> >>>>>> include/linux/nfs_ssc.h |  2 +-
> >>>>>> 3 files changed, 38 insertions(+), 60 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>>>>> index b79ee65ae016..6515b00520bc 100644
> >>>>>> --- a/fs/nfsd/nfs4proc.c
> >>>>>> +++ b/fs/nfsd/nfs4proc.c
> >>>>>> @@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block *sb);
> >>>>>>    * setup a work entry in the ssc delayed unmount list.
> >>>>>>    */
> >>>>>> static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
> >>>>>> -             struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
> >>>>>> +             struct nfsd4_ssc_umount_item **nsui)
> >>>>>> {
> >>>>>>         struct nfsd4_ssc_umount_item *ni = NULL;
> >>>>>>         struct nfsd4_ssc_umount_item *work = NULL;
> >>>>>>         struct nfsd4_ssc_umount_item *tmp;
> >>>>>>         DEFINE_WAIT(wait);
> >>>>>> +     __be32 status = 0;
> >>>>>>
> >>>>>> -     *ss_mnt = NULL;
> >>>>>> -     *retwork = NULL;
> >>>>>> +     *nsui = NULL;
> >>>>>>         work = kzalloc(sizeof(*work), GFP_KERNEL);
> >>>>>> try_again:
> >>>>>>         spin_lock(&nn->nfsd_ssc_lock);
> >>>>>> @@ -1326,12 +1326,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
> >>>>>>                         finish_wait(&nn->nfsd_ssc_waitq, &wait);
> >>>>>>                         goto try_again;
> >>>>>>                 }
> >>>>>> -             *ss_mnt = ni->nsui_vfsmount;
> >>>>>> +             *nsui = ni;
> >>>>>>                 refcount_inc(&ni->nsui_refcnt);
> >>>>>>                 spin_unlock(&nn->nfsd_ssc_lock);
> >>>>>>                 kfree(work);
> >>>>>>
> >>>>>> -             /* return vfsmount in ss_mnt */
> >>>>>> +             /* return vfsmount in (*nsui)->nsui_vfsmount */
> >>>>>>                 return 0;
> >>>>>>         }
> >>>>>>         if (work) {
> >>>>>> @@ -1339,10 +1339,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
> >>>>>>                 refcount_set(&work->nsui_refcnt, 2);
> >>>>>>                 work->nsui_busy = true;
> >>>>>>                 list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
> >>>>>> -             *retwork = work;
> >>>>>> -     }
> >>>>>> +             *nsui = work;
> >>>>>> +     } else
> >>>>>> +             status = nfserr_resource;
> >>>>>>         spin_unlock(&nn->nfsd_ssc_lock);
> >>>>>> -     return 0;
> >>>>>> +     return status;
> >>>>>> }
> >>>>>>
> >>>>>> static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
> >>>>>> @@ -1371,7 +1372,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd_net *nn,
> >>>>>>    */
> >>>>>> static __be32
> >>>>>> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>>>> -                    struct vfsmount **mount)
> >>>>>> +                     struct nfsd4_ssc_umount_item **nsui)
> >>>>>> {
> >>>>>>         struct file_system_type *type;
> >>>>>>         struct vfsmount *ss_mnt;
> >>>>>> @@ -1382,7 +1383,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>>>>         char *ipaddr, *dev_name, *raw_data;
> >>>>>>         int len, raw_len;
> >>>>>>         __be32 status = nfserr_inval;
> >>>>>> -     struct nfsd4_ssc_umount_item *work = NULL;
> >>>>>>         struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> >>>>>>
> >>>>>>         naddr = &nss->u.nl4_addr;
> >>>>>> @@ -1390,6 +1390,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>>>>                                          naddr->addr_len,
> >>>>>>                                          (struct sockaddr *)&tmp_addr,
> >>>>>>                                          sizeof(tmp_addr));
> >>>>>> +     *nsui = NULL;
> >>>>>>         if (tmp_addrlen == 0)
> >>>>>>                 goto out_err;
> >>>>>>
> >>>>>> @@ -1432,10 +1433,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>>>>                 goto out_free_rawdata;
> >>>>>>         snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
> >>>>>>
> >>>>>> -     status = nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
> >>>>>> +     status = nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
> >>>>>>         if (status)
> >>>>>>                 goto out_free_devname;
> >>>>>> -     if (ss_mnt)
> >>>>>> +     if ((*nsui)->nsui_vfsmount)
> >>>>>>                 goto out_done;
> >>>>>>
> >>>>>>         /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
> >>>>>> @@ -1443,15 +1444,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>>>>         module_put(type->owner);
> >>>>>>         if (IS_ERR(ss_mnt)) {
> >>>>>>                 status = nfserr_nodev;
> >>>>>> -             if (work)
> >>>>>> -                     nfsd4_ssc_cancel_dul_work(nn, work);
> >>>>>> +             nfsd4_ssc_cancel_dul_work(nn, *nsui);
> >>>>>>                 goto out_free_devname;
> >>>>>>         }
> >>>>>> -     if (work)
> >>>>>> -             nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
> >>>>>> +     nfsd4_ssc_update_dul_work(nn, *nsui, ss_mnt);
> >>>>>> out_done:
> >>>>>>         status = 0;
> >>>>>> -     *mount = ss_mnt;
> >>>>>>
> >>>>>> out_free_devname:
> >>>>>>         kfree(dev_name);
> >>>>>> @@ -1474,8 +1472,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> >>>>>>    */
> >>>>>> static __be32
> >>>>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> >>>>>> -                   struct nfsd4_compound_state *cstate,
> >>>>>> -                   struct nfsd4_copy *copy, struct vfsmount **mount)
> >>>>>> +             struct nfsd4_compound_state *cstate, struct nfsd4_copy *copy)
> >>>>>> {
> >>>>>>         struct svc_fh *s_fh = NULL;
> >>>>>>         stateid_t *s_stid = &copy->cp_src_stateid;
> >>>>>> @@ -1488,7 +1485,8 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> >>>>>>         if (status)
> >>>>>>                 goto out;
> >>>>>>
> >>>>>> -     status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
> >>>>>> +     status = nfsd4_interssc_connect(copy->cp_src, rqstp,
> >>>>>> +                             &copy->ss_nsui);
> >>>>>>         if (status)
> >>>>>>                 goto out;
> >>>>>>
> >>>>>> @@ -1506,61 +1504,42 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> >>>>>> }
> >>>>>>
> >>>>>> static void
> >>>>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
> >>>>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
> >>>>>>                         struct nfsd_file *dst)
> >>>>>> {
> >>>>>> -     bool found = false;
> >>>>>>         long timeout;
> >>>>>> -     struct nfsd4_ssc_umount_item *tmp;
> >>>>>> -     struct nfsd4_ssc_umount_item *ni = NULL;
> >>>>>>         struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
> >>>>>>
> >>>>>>         nfs42_ssc_close(filp);
> >>>>>>         nfsd_file_put(dst);
> >>>>>>         fput(filp);
> >>>>>>
> >>>>>> -     if (!nn) {
> >>>>>> -             mntput(ss_mnt);
> >>>>>> -             return;
> >>>>>> -     }
> >>>>>>         spin_lock(&nn->nfsd_ssc_lock);
> >>>>>>         timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> >>>>>> -     list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
> >>>>>> -             if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
> >>>>>> -                     list_del(&ni->nsui_list);
> >>>>>> -                     /*
> >>>>>> -                      * vfsmount can be shared by multiple exports,
> >>>>>> -                      * decrement refcnt. If the count drops to 1 it
> >>>>>> -                      * will be unmounted when nsui_expire expires.
> >>>>>> -                      */
> >>>>>> -                     refcount_dec(&ni->nsui_refcnt);
> >>>>>> -                     ni->nsui_expire = jiffies + timeout;
> >>>>>> -                     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
> >>>>>> -                     found = true;
> >>>>>> -                     break;
> >>>>>> -             }
> >>>>>> -     }
> >>>>>> +     list_del(&ni->nsui_list);
> >>>>>> +     /*
> >>>>>> +      * vfsmount can be shared by multiple exports,
> >>>>>> +      * decrement refcnt. If the count drops to 1 it
> >>>>>> +      * will be unmounted when nsui_expire expires.
> >>>>>> +      */
> >>>>>> +     refcount_dec(&ni->nsui_refcnt);
> >>>>>> +     ni->nsui_expire = jiffies + timeout;
> >>>>>> +     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
> >>>>>>         spin_unlock(&nn->nfsd_ssc_lock);
> >>>>>> -     if (!found) {
> >>>>>> -             mntput(ss_mnt);
> >>>>>> -             return;
> >>>>>> -     }
> >>>>>> }
> >>>>>>
> >>>>>> #else /* CONFIG_NFSD_V4_2_INTER_SSC */
> >>>>>>
> >>>>>> static __be32
> >>>>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> >>>>>> -                   struct nfsd4_compound_state *cstate,
> >>>>>> -                   struct nfsd4_copy *copy,
> >>>>>> -                   struct vfsmount **mount)
> >>>>>> +                     struct nfsd4_compound_state *cstate,
> >>>>>> +                     struct nfsd4_copy *copy)
> >>>>>> {
> >>>>>> -     *mount = NULL;
> >>>>>>         return nfserr_inval;
> >>>>>> }
> >>>>>>
> >>>>>> static void
> >>>>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
> >>>>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *filp,
> >>>>>>                         struct nfsd_file *dst)
> >>>>>> {
> >>>>>> }
> >>>>>> @@ -1700,7 +1679,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
> >>>>>>         memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
> >>>>>>         memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
> >>>>>>         memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
> >>>>>> -     dst->ss_mnt = src->ss_mnt;
> >>>>>> +     dst->ss_nsui = src->ss_nsui;
> >>>>>> }
> >>>>>>
> >>>>>> static void cleanup_async_copy(struct nfsd4_copy *copy)
> >>>>>> @@ -1749,8 +1728,8 @@ static int nfsd4_do_async_copy(void *data)
> >>>>>>         if (nfsd4_ssc_is_inter(copy)) {
> >>>>>>                 struct file *filp;
> >>>>>>
> >>>>>> -             filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> >>>>>> -                                   &copy->stateid);
> >>>>>> +             filp = nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
> >>>>>> +                             &copy->c_fh, &copy->stateid);
> >>>>>>                 if (IS_ERR(filp)) {
> >>>>>>                         switch (PTR_ERR(filp)) {
> >>>>>>                         case -EBADF:
> >>>>>> @@ -1764,7 +1743,7 @@ static int nfsd4_do_async_copy(void *data)
> >>>>>>                 }
> >>>>>>                 nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> >>>>>>                                        false);
> >>>>>> -             nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
> >>>>>> +             nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
> >>>>>>         } else {
> >>>>>>                 nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >>>>>>                                        copy->nf_dst->nf_file, false);
> >>>>>> @@ -1790,8 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >>>>>>                         status = nfserr_notsupp;
> >>>>>>                         goto out;
> >>>>>>                 }
> >>>>>> -             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy,
> >>>>>> -                             &copy->ss_mnt);
> >>>>>> +             status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
> >>>>>>                 if (status)
> >>>>>>                         return nfserr_offload_denied;
> >>>>>>         } else {
> >>>>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> >>>>>> index 0eb00105d845..36c3340c1d54 100644
> >>>>>> --- a/fs/nfsd/xdr4.h
> >>>>>> +++ b/fs/nfsd/xdr4.h
> >>>>>> @@ -571,7 +571,7 @@ struct nfsd4_copy {
> >>>>>>         struct task_struct      *copy_task;
> >>>>>>         refcount_t              refcount;
> >>>>>>
> >>>>>> -     struct vfsmount         *ss_mnt;
> >>>>>> +     struct nfsd4_ssc_umount_item *ss_nsui;
> >>>>>>         struct nfs_fh           c_fh;
> >>>>>>         nfs4_stateid            stateid;
> >>>>>> };
> >>>>>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
> >>>>>> index 75843c00f326..22265b1ff080 100644
> >>>>>> --- a/include/linux/nfs_ssc.h
> >>>>>> +++ b/include/linux/nfs_ssc.h
> >>>>>> @@ -53,6 +53,7 @@ static inline void nfs42_ssc_close(struct file *filep)
> >>>>>>         if (nfs_ssc_client_tbl.ssc_nfs4_ops)
> >>>>>>                 (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
> >>>>>> }
> >>>>>> +#endif
> >>>>>>
> >>>>>> struct nfsd4_ssc_umount_item {
> >>>>>>         struct list_head nsui_list;
> >>>>>> @@ -66,7 +67,6 @@ struct nfsd4_ssc_umount_item {
> >>>>>>         struct vfsmount *nsui_vfsmount;
> >>>>>>         char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
> >>>>>> };
> >>>>>> -#endif
> >>>>>>
> >>>>>> /*
> >>>>>>    * NFS_FS
> >>>>>> --
> >>>>>> 2.9.5
> >>>>>>
> >>>>> --
> >>>>> Chuck Lever
> >>>>>
> >>>>>
> >>>>>
