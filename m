Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC1B5FB0C8
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJKKvy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJKKvx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 06:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF91839C;
        Tue, 11 Oct 2022 03:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6801C60AF5;
        Tue, 11 Oct 2022 10:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DBCC433C1;
        Tue, 11 Oct 2022 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665485510;
        bh=q2XfsOUAahFWISvR8k6hG1WkuJbaOBA1bg4n2wOxQVk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pTAFpExYsc2F++CKQApqazvjv0LwwKoWe9UGFmRJD8Azpx30l8tbQujOkvDv6hg0r
         c/0J3pUbWlscUGTfqiFEdg/ow1L771JFiY4LChD3GeKUudrvuttp5IVpnSYNHYgj4W
         vdG+9Glbtz55uf6QTDjgqytsBjjZjPcnAaJZqe08Admey/pu7TmLfQwxbu0ngrh4o0
         ihoYVKreR0raY47eyZ3uPiZzLtqFnq4/TDyF1wGQ0BpHk+6wE27OwlNmIxMnFvNC9E
         v98dqCuGxFjJ3ixckx3zg1SFNxW34XQzm2ue0slyYjvVDy0JuG96A8Uyb6vxSF7Hxk
         /Tcp1c/TiTc5g==
Message-ID: <c705f102538694155a27c7136157b4de719bf6c0.camel@kernel.org>
Subject: Re: Bug 216560 - Kernel 6.0.0 Use after Free Error in NFS code
From:   Jeff Layton <jlayton@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Robert Dinse <nanook@eskimo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Date:   Tue, 11 Oct 2022 06:51:48 -0400
In-Reply-To: <2b693b7b-aadd-5353-154c-37a175fc5b99@leemhuis.info>
References: <2b693b7b-aadd-5353-154c-37a175fc5b99@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-10-11 at 12:44 +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
>=20
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D216560 :
>=20
> > reated attachment 302961 [details]
> > Config file used ot compile 6.0.0
> >=20
> > NFS Use after Free Call Trace.
> > This is on an i7-6850k based server that is running Ubuntu 22.04 and se=
rves as an NFS server as well as virtual machine host.  It is equipped with=
 128GB of RAM and both SATA hard drives and PCI flash drives for storage.  =
The configuration file used to compile this kernel is attached as config-6.=
0.0.  Anything else you need please let me know.  Compiled with gcc 12.2.0.
> >=20
> >=20
> > [45414.551153] ------------[ cut here ]------------
> > [45414.551158] refcount_t: underflow; use-after-free.
> > [45414.551169] WARNING: CPU: 11 PID: 2289 at lib/refcount.c:87 refcount=
_dec_not_one+0x68/0x70
> > [45414.551177] Modules linked in: vhost_net vhost vhost_iotlb tap tcp_d=
iag inet_diag unix_diag xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT n=
f_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat nf_conntrack nf_def=
rag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink rpcsec_gss_krb5 nfsv4 nfs fscac=
he netfs bridge stp llc binfmt_misc nls_iso8859_1 quota_v2 quota_tree snd_h=
da_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel int=
el_rapl_msr snd_intel_dspcfg snd_intel_sdw_acpi intel_rapl_common intel_unc=
ore_frequency intel_uncore_frequency_common snd_hda_codec snd_hda_core x86_=
pkg_temp_thermal intel_powerclamp snd_hwdep snd_pcm snd_seq_midi snd_seq_mi=
di_event snd_rawmidi snd_seq snd_seq_device snd_timer eeepc_wmi mei_me kvm_=
intel snd asus_wmi kvm platform_profile ledtrig_audio iTCO_wdt intel_pmc_bx=
t sparse_keymap rapl intel_cstate mei intel_wmi_thunderbolt iTCO_vendor_sup=
port soundcore wmi_bmof mac_hid sch_fq_codel nct6775 nct6775_core hwmon_vid=
 coretemp nfsd parport_pc ppdev
> > [45414.551237]  auth_rpcgss nfs_acl lp lockd parport grace sunrpc ramoo=
ps reed_solomon efi_pstore pstore_blk pstore_zone ip_tables x_tables autofs=
4 btrfs blake2b_generic zstd_compress raid456 async_raid6_recov async_memcp=
y async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 multipath linear=
 dm_mirror dm_region_hash dm_log raid1 nouveau video i2c_algo_bit drm_ttm_h=
elper ttm drm_display_helper cec rc_core drm_kms_helper syscopyarea sysfill=
rect sysimgblt fb_sys_fops raid10 crct10dif_pclmul crc32_pclmul ghash_clmul=
ni_intel mxm_wmi aesni_intel crypto_simd cryptd drm nvme e1000e i2c_i801 ah=
ci lpc_ich i2c_smbus r8169 xhci_pci nvme_core libahci xhci_pci_renesas real=
tek wmi
> > [45414.551282] CPU: 11 PID: 2289 Comm: nfsd Not tainted 6.0.0 #1
> > [45414.551284] Hardware name: ASUS All Series/X99-E, BIOS 2101 07/10/20=
19
> > [45414.551286] RIP: 0010:refcount_dec_not_one+0x68/0x70
> > [45414.551288] Code: d3 6e 00 83 e3 01 74 0f 48 8b 5d f8 b8 01 00 00 00=
 c9 c3 cc cc cc cc 48 c7 c7 38 1a 64 99 c6 05 36 65 53 01 01 e8 bf c4 6a 00=
 <0f> 0b eb da 0f 1f 40 00 55 48 89 e5 41 54 49 89 f4 53 48 89 fb e8
> > [45414.551290] RSP: 0018:ffffa6f041a5bb80 EFLAGS: 00010282
> > [45414.551292] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
000000027
> > [45414.551293] RDX: ffff89763fce0568 RSI: 0000000000000001 RDI: ffff897=
63fce0560
> > [45414.551295] RBP: ffffa6f041a5bb88 R08: 0000000000000000 R09: ffffa6f=
041a5bb18
> > [45414.551296] R10: 00000000ffffe664 R11: 0000000000000665 R12: ffff896=
3d049b1a0
> > [45414.551297] R13: ffff8963d049b1a0 R14: 0000000000000000 R15: ffff897=
218d09e90
> > [45414.551298] FS:  0000000000000000(0000) GS:ffff89763fcc0000(0000) kn=
lGS:0000000000000000
> > [45414.551300] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [45414.551301] CR2: 00007fea43472718 CR3: 000000015686a005 CR4: 0000000=
0003726e0
> > [45414.551303] Call Trace:
> > [45414.551304]  <TASK>
> > [45414.551308]  __nfsd_file_close_inode+0x1ca/0x210 [nfsd]
> > [45414.551340]  nfsd_file_fsnotify_handle_event+0x85/0x120 [nfsd]
> > [45414.551362]  fsnotify_handle_inode_event.isra.0+0x6f/0xe0
> > [45414.551365]  fsnotify+0x615/0x9b0
> > [45414.551368]  vfs_unlink+0x22d/0x2d0
> > [45414.551372]  nfsd_unlink+0x128/0x2f0 [nfsd]
> > [45414.551394]  nfsd4_remove+0x52/0x100 [nfsd]
> > [45414.551411]  nfsd4_proc_compound+0x431/0x6f0 [nfsd]
> > [45414.551425]  ? nfs4svc_decode_compoundargs+0x380/0x410 [nfsd]
> > [45414.551440]  nfsd_dispatch+0x15a/0x250 [nfsd]
> > [45414.551451]  svc_process_common+0x295/0x600 [sunrpc]
> > [45414.551485]  ? nfsd_svc+0x3f0/0x3f0 [nfsd]
> > [45414.551504]  ? nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
> > [45414.551522]  svc_process+0xba/0x100 [sunrpc]
> > [45414.551544]  nfsd+0xd1/0x190 [nfsd]
> > [45414.551555]  kthread+0xd1/0xf0
> > [45414.551558]  ? kthread_complete_and_exit+0x20/0x20
> > [45414.551560]  ret_from_fork+0x22/0x30
> > [45414.551563]  </TASK>
> > [45414.551563] ---[ end trace 0000000000000000 ]---
>=20
> See the ticket for more details.
>=20
> Side note: I wonder if these two are related, but this is not my area of
> expertise, so be warned that it might be something totally different:
> https://lore.kernel.org/all/166486048770.14457.133971372966856907@noble.n=
eil.brown.name/
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
>=20

Thanks for the bug report, Thorsten.

Neil's bug is probably different and was already fixed with an earlier
patch. The stack trace above though looks like it may be related to bug
#394.

Chuck has some patches that may address this, but they're still under
review at the moment:

https://lore.kernel.org/linux-nfs/0392D2DB-B0D3-46BC-BAE9-259A2EEDFD4A@orac=
le.com/T/


> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
>=20
> #regzbot introduced: v5.19..v6.0
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216560
> #regzbot ignore-activity
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>=20
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.

