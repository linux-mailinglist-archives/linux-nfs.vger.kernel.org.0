Return-Path: <linux-nfs+bounces-10760-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77879A6C8E7
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 11:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B283B29E2
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 10:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AC41F03F0;
	Sat, 22 Mar 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="c78i+Hg4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F171DF24A
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742637934; cv=none; b=JTWJ0JOeOuuuoA9nIxQPNg0MTxSBzw0K3dQv8ggZ0p4CM9OTyGgkO6JO/X86/sMVySI21m7JsojYmJJY434l6beQXxNMO81Vxjdxrov90eGxdY0lb+AGxiSGvwSeD1IZhKoHjzFtezN173KknG3bPdINzMcvyV4qk/eTUHQzqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742637934; c=relaxed/simple;
	bh=b1Hx+7xfBW5MSWqH5EZu6I6aDn8zwajNjam9MQMTQqM=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=u5D9KXKyLFGLqeHaPY5620wJd6HtteF6Uozq82o9eA/DyZgIw5rrsRkuYgRpeQYtFgfvqOf38zYQq40psFZu+oSjoITwBl1KUdcwNbzfl/gss3/8XU6uIdmiEvC+7MWH8TEfcUSWbJgccxLCmn1RjZ242fCInaiOE9ydbQNgArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=c78i+Hg4; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742637920; x=1742897120;
	bh=TwPS1MGbjPieDtWqakTC4Xz/2T71pRrakHXiwGyShCk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=c78i+Hg4ON1Z9S0/+r2KAZJPQadTcx+yLrmbnOuJRXZqoopjOFSn1muySJ8KiXMtp
	 hBr4m8IiRTkmPKKnYXejD7/Pp1SSJgpaf0BUqfOV0KYqbM2iqFbqswj9gXiniXH9vQ
	 h+hIgVFncEniwzD5QNid+Vb4wCU1/+YdIPl7kMn0vem+dviXIGsLCbV9XGwiA+2Ios
	 cojTfeFyW9gFZVxt52J9FsRDvXLFXtDsbNTEqSoJoF9ngcNpQfeTF9oA9a4Qly3QTH
	 fb7LFoeTfP6M7BV1VD6tSQcGKtaxnrbr41oieBusbILmP6xKUaT/Lzn6g0KUGcK00F
	 Y+NGpDoO7Re3A==
Date: Sat, 22 Mar 2025 10:05:13 +0000
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From: John <therealgraysky@proton.me>
Subject: kernel panic when starting nfsd on OpenWrt with kernel 6.12.19
Message-ID: <xD3JWWvIeTEG7_-UtXFNOaGpYHZL9Dr4beYme8ebQZiBvaBcTu3u7Q9GxE7cJrGRYsfTjC2BPxBTuyl1TijqjUP8_nC4tpcfekVKuBtDp68=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 3b487953af4380089b82b95f7020215500df21e0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Starting nfsd with kernel 6.12.19 triggers a kernel panic. Using the 6.6.83=
 kernel is rock solid. I confirmed this on two x86/64 machines (Intel-N150 =
based and AMD 8845H-based). Posting here seeking debug advice. It is not cl=
ear to me if this is something in the kernel code or in something else with=
in the distro.

I get the following from dmesg:
Kernel BUG at nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd] [verbose debug=
 info unavailable]
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 2 UID: 0 PID: 17091 Comm: rpc.nfsd Not tainted 6.12.19 #0
Hardware name: iKOOLCORE R2Max/R2Max, BIOS v1.1 12/17/2024
RIP: 0010:nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
Code: 89 de 48 c7 c7 e0 20 95 a0 e8 08 fc ff ff 41 89 c4 85 c0 0f 85 ce 2d =
00 00 48 c7 c7 58 dd 95 a0 45 31 e4 e8 8e 7a 0b e1 eb 08 <0f> 0b 41 bc f4 f=
f ff ff 48 83 c4 08 44 89 e0 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc9000613bc98 EFLAGS: 00010282
RAX: 0000000000000049 RBX: ffff888105e06000 RCX: 0000000000000000
RDX: ffff88846fb21920 RSI: ffff88846fb1d980 RDI: ffff88846fb1d980
RBP: ffffc9000613bcc0 R08: 0000000000000000 R09: ffffffff824b56c8
R10: ffffffff8249d688 R11: 0000000000000003 R12: ffffffff82736400
R13: ffff888105e06000 R14: ffff888105e06000 R15: ffffc9000613bcd0
FS:  00007f1a404e5b28(0000) GS:ffff88846fb00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1a40411000 CR3: 000000010d47a006 CR4: 0000000000370ef0
Call Trace:
 <TASK>
 ? show_regs.part.0+0x1d/0x20
 ? __die+0x52/0x91
 ? die+0x2a/0x50
 ? do_trap+0x103/0x110
 ? do_error_trap+0x6c/0x90
 ? nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
 ? exc_invalid_op+0x4f/0x70
 ? nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
 ? asm_exc_invalid_op+0x1b/0x20
 ? nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
 ? nfsd4_probe_callback_sync+0xff6/0x25b0 [nfsd]
 nfsd4_client_tracking_init+0x39/0x150 [nfsd]
 nfs4_state_start_net+0x2ce/0x370 [nfsd]
 nfsd_svc+0x1a0/0x2d0 [nfsd]
 nfssvc_encode_voidres+0x19a1/0x1be0 [nfsd]
 ? simple_transaction_get+0xb7/0xe0
 ? nfssvc_encode_voidres+0x18f0/0x1be0 [nfsd]
 nfssvc_encode_voidres+0x1a3/0x1be0 [nfsd]
 vfs_write+0xcb/0x390
 ? putname+0x4c/0x60
 ksys_write+0x57/0xd0
 __x64_sys_write+0x14/0x20
 x64_sys_call+0x79/0x1780
 do_syscall_64+0x7b/0x190
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f1a404c9659
Code: c3 8b 07 85 c0 75 24 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d =
89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> e9 82 d8 ff f=
f 41 54 b8 02 00 00 00 55 48 89 f5 be 00 88 08 00
RSP: 002b:00007fff99aeb2c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f1a404c9659
RDX: 0000000000000003 RSI: 000000000040d360 RDI: 0000000000000003
RBP: 00007f1a404e5b28 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000020000 R14: 0000000000409112 R15: 00007f1a40430dd0
 </TASK>
Modules linked in: xt_connlimit pppoe ppp_async nf_conncount i915 xt_state =
xt_helper xt_conntrack xt_connmark xt_connlabel xt_connbytes xt_CT wireguar=
d video pppox ppp_mppe ppp_generic nft_redir nft_nat nft_masq nft_flow_offl=
oad nft_fib_inet nft_ct nft_chain_nat nf_nat nf_flow_table_inet nf_flow_tab=
le nf_conntrack_netlink nf_conntrack libchacha20poly1305 ipt_REJECT iavf i4=
0e curve25519_x86_64 chacha_x86_64 cdc_ncm cdc_ether aqc111 zstd xt_time xt=
_tcpudp xt_tcpmss xt_statistic xt_recent xt_quota xt_pkttype xt_owner xt_mu=
ltiport xt_mark xt_mac xt_limit xt_length xt_hl xt_ecn xt_dscp xt_comment x=
t_cgroup xt_addrtype xt_TCPMSS xt_LOG xt_HL xt_DSCP xt_CLASSIFY xt_CHECKSUM=
 wmi usbnet unix_diag ts_kmp ts_fsm ts_bm slhc sch_cake poly1305_x86_64 nft=
_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_quota nft_queue=
 nft_numgen nft_log nft_limit nft_hash nft_fib_ipv6 nft_fib_ipv4 nft_fib nf=
t_compat nfnetlink_queue nf_tables nf_reject_ipv4 nf_log_syslog nf_defrag_i=
pv6 nf_defrag_ipv4 macvlan lzo_rle lzo libie
 libeth libcurve25519_generic libchacha iptable_mangle iptable_filter ipt_E=
CN ip_tables forcedeth e1000e drm_display_helper drm_buddy crc_ccitt cdc_ac=
m bnx2 atlantic af_packet_diag sch_teql sch_sfq sch_multiq sch_gred sch_fq =
sch_ets sch_codel em_text em_nbyte em_meta em_cmp act_skbmod act_simple act=
_pedit act_csum sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_rou=
te cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred act_gact c=
onfigs evdev drivetemp i2c_piix4 i2c_smbus i2c_dev xt_set ip_set_list_set i=
p_set_hash_netportnet ip_set_hash_netport ip_set_hash_netnet ip_set_hash_ne=
tiface ip_set_hash_net ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ip=
portip ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ipmac ip_set_hash_=
ip ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set nfnetlink=
 dwmac_intel ip6t_rt ip6t_mh ip6t_ipv6header ip6t_hbh ip6t_frag ip6t_eui64 =
ip6t_ah ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_=
reject_ipv6 nfsv4 dwmac_generic
 stmmac_platform stmmac nfsd nfs bonding ixgbe igbvf e1000 amd_xgbe ifb sct=
p udp_tunnel ip6_udp_tunnel mdio netlink_diag udp_diag tcp_diag raw_diag in=
et_diag rpcsec_gss_krb5 auth_rpcgss oid_registry veth lockd sunrpc grace dn=
s_resolver nls_utf8 pcs_xpcs macsec ena ecdh_generic ecc xxhash_generic cry=
pto_user algif_skcipher algif_rng algif_hash algif_aead af_alg sha512_ssse3=
 sha512_generic sha1_ssse3 sha1_generic seqiv sha3_generic jitterentropy_rn=
g drbg md5 kpp hmac geniv rng des_generic libdes cts chacha20poly1305 blake=
2b_generic authencesn authenc arc4 crypto_acompress nls_iso8859_1 nls_cp437=
 r8169 mdio_devres xhci_plat_hcd iTCO_wdt iTCO_vendor_support fsl_mph_dr_of=
 ehci_platform ehci_fsl igb igc vfat fat btrfs zstd_decompress zstd_compres=
s zstd_common xxhash xor raid6_pq lzo_decompress lzo_compress libcrc32c dm_=
mirror dm_region_hash dm_log dm_crypt dm_mod dax tg3 realtek phylink mii li=
bphy tpm cbc sha256_ssse3 sha256_generic encrypted_keys trusted
---[ end trace 0000000000000000 ]---
RIP: 0010:nfsd4_probe_callback_sync+0x1094/0x25b0 [nfsd]
Code: 89 de 48 c7 c7 e0 20 95 a0 e8 08 fc ff ff 41 89 c4 85 c0 0f 85 ce 2d =
00 00 48 c7 c7 58 dd 95 a0 45 31 e4 e8 8e 7a 0b e1 eb 08 <0f> 0b 41 bc f4 f=
f ff ff 48 83 c4 08 44 89 e0 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc9000613bc98 EFLAGS: 00010282
RAX: 0000000000000049 RBX: ffff888105e06000 RCX: 0000000000000000
RDX: ffff88846fb21920 RSI: ffff88846fb1d980 RDI: ffff88846fb1d980
RBP: ffffc9000613bcc0 R08: 0000000000000000 R09: ffffffff824b56c8
R10: ffffffff8249d688 R11: 0000000000000003 R12: ffffffff82736400
R13: ffff888105e06000 R14: ffff888105e06000 R15: ffffc9000613bcd0
FS:  00007f1a404e5b28(0000) GS:ffff88846fb00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1a40411000 CR3: 000000010d47a006 CR4: 0000000000370ef0

Here is /etc/exports:
/mnt/data/nfs        10.9.8.0/24(ro,fsid=3Droot,no_subtree_check,insecure,a=
sync,all_squash,pnfs,anonuid=3D99,anongid=3D99)
/mnt/data/nfs/misc   10.9.8.0/24(ro,no_subtree_check,insecure,async,all_squ=
ash,pnfs,anonuid=3D99,anongid=3D99)


