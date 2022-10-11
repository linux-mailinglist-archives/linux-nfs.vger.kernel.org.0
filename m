Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22F05FB0A9
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 12:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJKKom convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 11 Oct 2022 06:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJKKoh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 06:44:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24B8C03A
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 03:44:31 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oiCkK-0005Jm-08; Tue, 11 Oct 2022 12:44:24 +0200
Message-ID: <2b693b7b-aadd-5353-154c-37a175fc5b99@leemhuis.info>
Date:   Tue, 11 Oct 2022 12:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
Cc:     Robert Dinse <nanook@eskimo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Bug 216560 - Kernel 6.0.0 Use after Free Error in NFS code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1665485071;7582346c;
X-HE-SMSGID: 1oiCkK-0005Jm-08
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216560 :

> reated attachment 302961 [details]
> Config file used ot compile 6.0.0
> 
> NFS Use after Free Call Trace.
> This is on an i7-6850k based server that is running Ubuntu 22.04 and serves as an NFS server as well as virtual machine host.  It is equipped with 128GB of RAM and both SATA hard drives and PCI flash drives for storage.  The configuration file used to compile this kernel is attached as config-6.0.0.  Anything else you need please let me know.  Compiled with gcc 12.2.0.
> 
> 
> [45414.551153] ------------[ cut here ]------------
> [45414.551158] refcount_t: underflow; use-after-free.
> [45414.551169] WARNING: CPU: 11 PID: 2289 at lib/refcount.c:87 refcount_dec_not_one+0x68/0x70
> [45414.551177] Modules linked in: vhost_net vhost vhost_iotlb tap tcp_diag inet_diag unix_diag xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink rpcsec_gss_krb5 nfsv4 nfs fscache netfs bridge stp llc binfmt_misc nls_iso8859_1 quota_v2 quota_tree snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel intel_rapl_msr snd_intel_dspcfg snd_intel_sdw_acpi intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common snd_hda_codec snd_hda_core x86_pkg_temp_thermal intel_powerclamp snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device snd_timer eeepc_wmi mei_me kvm_intel snd asus_wmi kvm platform_profile ledtrig_audio iTCO_wdt intel_pmc_bxt sparse_keymap rapl intel_cstate mei intel_wmi_thunderbolt iTCO_vendor_support soundcore wmi_bmof mac_hid sch_fq_codel nct6775 nct6775_core hwmon_vid coretemp nfsd parport_pc ppdev
> [45414.551237]  auth_rpcgss nfs_acl lp lockd parport grace sunrpc ramoops reed_solomon efi_pstore pstore_blk pstore_zone ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 multipath linear dm_mirror dm_region_hash dm_log raid1 nouveau video i2c_algo_bit drm_ttm_helper ttm drm_display_helper cec rc_core drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops raid10 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel mxm_wmi aesni_intel crypto_simd cryptd drm nvme e1000e i2c_i801 ahci lpc_ich i2c_smbus r8169 xhci_pci nvme_core libahci xhci_pci_renesas realtek wmi
> [45414.551282] CPU: 11 PID: 2289 Comm: nfsd Not tainted 6.0.0 #1
> [45414.551284] Hardware name: ASUS All Series/X99-E, BIOS 2101 07/10/2019
> [45414.551286] RIP: 0010:refcount_dec_not_one+0x68/0x70
> [45414.551288] Code: d3 6e 00 83 e3 01 74 0f 48 8b 5d f8 b8 01 00 00 00 c9 c3 cc cc cc cc 48 c7 c7 38 1a 64 99 c6 05 36 65 53 01 01 e8 bf c4 6a 00 <0f> 0b eb da 0f 1f 40 00 55 48 89 e5 41 54 49 89 f4 53 48 89 fb e8
> [45414.551290] RSP: 0018:ffffa6f041a5bb80 EFLAGS: 00010282
> [45414.551292] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
> [45414.551293] RDX: ffff89763fce0568 RSI: 0000000000000001 RDI: ffff89763fce0560
> [45414.551295] RBP: ffffa6f041a5bb88 R08: 0000000000000000 R09: ffffa6f041a5bb18
> [45414.551296] R10: 00000000ffffe664 R11: 0000000000000665 R12: ffff8963d049b1a0
> [45414.551297] R13: ffff8963d049b1a0 R14: 0000000000000000 R15: ffff897218d09e90
> [45414.551298] FS:  0000000000000000(0000) GS:ffff89763fcc0000(0000) knlGS:0000000000000000
> [45414.551300] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [45414.551301] CR2: 00007fea43472718 CR3: 000000015686a005 CR4: 00000000003726e0
> [45414.551303] Call Trace:
> [45414.551304]  <TASK>
> [45414.551308]  __nfsd_file_close_inode+0x1ca/0x210 [nfsd]
> [45414.551340]  nfsd_file_fsnotify_handle_event+0x85/0x120 [nfsd]
> [45414.551362]  fsnotify_handle_inode_event.isra.0+0x6f/0xe0
> [45414.551365]  fsnotify+0x615/0x9b0
> [45414.551368]  vfs_unlink+0x22d/0x2d0
> [45414.551372]  nfsd_unlink+0x128/0x2f0 [nfsd]
> [45414.551394]  nfsd4_remove+0x52/0x100 [nfsd]
> [45414.551411]  nfsd4_proc_compound+0x431/0x6f0 [nfsd]
> [45414.551425]  ? nfs4svc_decode_compoundargs+0x380/0x410 [nfsd]
> [45414.551440]  nfsd_dispatch+0x15a/0x250 [nfsd]
> [45414.551451]  svc_process_common+0x295/0x600 [sunrpc]
> [45414.551485]  ? nfsd_svc+0x3f0/0x3f0 [nfsd]
> [45414.551504]  ? nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
> [45414.551522]  svc_process+0xba/0x100 [sunrpc]
> [45414.551544]  nfsd+0xd1/0x190 [nfsd]
> [45414.551555]  kthread+0xd1/0xf0
> [45414.551558]  ? kthread_complete_and_exit+0x20/0x20
> [45414.551560]  ret_from_fork+0x22/0x30
> [45414.551563]  </TASK>
> [45414.551563] ---[ end trace 0000000000000000 ]---

See the ticket for more details.

Side note: I wonder if these two are related, but this is not my area of
expertise, so be warned that it might be something totally different:
https://lore.kernel.org/all/166486048770.14457.133971372966856907@noble.neil.brown.name/
https://bugzilla.linux-nfs.org/show_bug.cgi?id=394

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v5.19..v6.0
https://bugzilla.kernel.org/show_bug.cgi?id=216560
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
