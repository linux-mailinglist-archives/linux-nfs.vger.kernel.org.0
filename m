Return-Path: <linux-nfs+bounces-1029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F0582A8F9
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 09:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2378B27EB0
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFEBE56E;
	Thu, 11 Jan 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TUVNsday"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic313-15.consmr.mail.bf2.yahoo.com (sonic313-15.consmr.mail.bf2.yahoo.com [74.6.133.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3DE10A2F
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704961212; bh=Ufx5rIOzslZrIE1fgKAMS0hK+TCR3JnfrICcjOFNjVk=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=TUVNsdayAuoDhEgqvg7os5sC0z0cph1Y475NQPK9Oz8ygkH7ACE5JDBIzjYItuIn27B5lbxuuBpeG2/HeNhRpwD5Ua/uD7Ey16EkbE98+7SKKlpM39XW6a+CUHeGPjISmTqj4YK1vEJqopoC6z4LZYkbsLFCjxhCeChEEpMk9jrEa2zJ1RbTzawiC/dkcowBH8WSuq2IMhrcV1HpfmTheqcilk+gHJ97kc/8GKQzekC1jZVcm0yTZOjS8v9n1sQbxWevc3siZOnECwgP9Vu72Fdx8AwpY4YVNBSObu1Ig036In8a33lzBVt7DilHwAVMuzH86l5T2chylDMB/XFCUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704961212; bh=6Y5m5V7txkMjX0dEsVYtbLYVgEOdGt5unrlXuYnF67a=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=YKHME696I7HFHbfaiLgm+SFzu8PuTGKixgmId8zm1tnJcqubbr9K1mvmSqIPgc0vyp3YKsHa3SM3tNpaQydj7w0PlkHUB4o9icM79pRPwjK3gfo3NOECGb2Guo+uqerm0v8/P3XmTrd4qyeqQchynbQZ5ryJm9eCeiAfohoG1XAF2lJnRSVTj7dHhP+LEkrM9YAKJIag45l6AmgZPF1IFeLZPO+bCIuxqwdsOIyMemVMmatVIvS4Xfq6BqUx7SdVOShmXrcCOcnR7UR65Kw3hM99wLXUPHsoytYG61E+fgmfDHtk5SFbYtuOTR3jMp5jesOTumgjiRpvDuXBrIVycw==
X-YMail-OSG: iekjkz8VM1nx2vHQ2wd_XfQkRf1RvfEN6jswCBVV0XIOzqu51m09vCkhI_kJdkX
 CNijaJ0VvyxyUB3rKrFuBoXyotw7Crw1MN9at9yUmxFBWFdTknPWaD_GjPVymXMvWFjTYw9z5lgX
 JlMaNvze4e1JLkgJsWTBp3_ezVqa9VqWhEJNrgtoBQfJM0Upi8EshkmCeC7MbE01PNqHpTs.IgX_
 M.d8R72UiXhxLn_JcqAmTT2fL__ucT85K2XGHsJ1ws8PGy5tPdGt50MonKOxRfRCcyekjWSS.JrO
 iQ03ebKBc3CxpGGIoSUn4kYXEqbIjdwQyWjF7RDcJLmi3aIs_h1VslNhDzO50As6q2cYdhdAmrmD
 p8PJ2C9yK.8ITTNC9Nm66ALtnki0IFmgOu.BZzcbKzC6s0zeylMG8yUeEaf1uEg4vl6nHYdudGEQ
 8peveM5zwWZwTA7R7X3zxAzEo.lerJZ_TNq28oxYgoVO_q4ZmhkOCS.QHvMHA.9B72mBih1n.pZ.
 ijwOVKi2nUQbPc4LWKGrTYak3Nzu0CbM7A4YPKyEGR4mNldwI66dVUGNvmM1oyNSG0pgPMHcVfRD
 mMjmIOoC060ljF9yRr2ZMKqdn505GDmLC0m11kni0FUKbEcZxwRLvVXNhVaZjMU7_.81_nlq26K1
 kqOQR_OLBPTCeL.8SbqryWrnuyy4iCSyPBNV9wU60bYnI5Sq5B1J1Cj2bEltZovLZE6BGl5hwfqf
 EcxZBoUOIADdIE09LC43GRGOQtUAgrb4LbtRwDjTtmc5LluUFEsnFZPkD.7k1rAbUagGqsMdOYU9
 vFtHp7VgRypZ_ISZ0OFgVeLycWfQUJi4LpP4FAl.xWb_Fn93RyvsjmaxcA8HjDR5q6ycMkHx96ro
 xumUHs7e0pJCulj3bfRmpt5JRl.c41y6FVggDWNcU0AN4Q3TVZ1TwWQ5yGAMsowP07DGJ2.0yKLt
 1Ai2K_e0KRVPQJMxisZ0CoFG92zvsdPx5pEqcDpuRMOHx3knwix0klYTMqoa91beVJ00YTP97MGm
 rFFCOKIeJCugPWDhHe7d5rLlQEA4XeUzwO5wpOdG9dotwGn1C187WyVpFb34fvhkER0tFB4Iba51
 0Aeo5iEZ0Pvna8MPk8lS1S4q91DkndgoRx4cS0Kz_Rj3zhzT7LaHAcOUXBVQ.dKVg80nCBOtn2ve
 cQePaXAcA5nVtjzcwjFgohgu45fge10A2XVuJmmjRFfZfzs.oeljJVwAqMCDE5g1SCeB6tmKQnGd
 XiVs4ddM4OINRs.JgYEiIHEnybOyB70eWmbxAjlxgiwtyuJOLtFH5qNWY0gE8DhfdhF2Ce72ax73
 .fHjliWUw.grlvGnifRW02MahI1UI6WBvQru_y1waVMWIjV4ftNQzJ.mLELCUj03rQs9dvOU5GVC
 XQ_t5ZagR.rY5Hh6snUNpKo0tw1f2dwyQjT4lQ7e8rAzo_LwLULBIn9A20tRwEpHuFh6nPXHWF_X
 QJngtykdkZdV6fvoX2w0eRSp4luzcM499LWcJ.sjhzT_KijMZl8kBVC05v_96alT1UaXWeFzSfu4
 weNh.emKuAYVJ6.83y.teGB3tDbmXEaKL2sxny05Mn5HZ.jP14XbImjHx6OHJ7sn2.3GmyXA_XQ6
 mBEMoxGsySbuS80rVMoCjt7ZA8pwG05SJ.35E9ssx6CSOfCglME7iyd_fnL7PPM9ipcyY.Z57jrd
 3puCfAjUO40_cHVKBHmB0oh2CrYDa8AYPgvhLuLjf8V4EoC_xid_bnEQEJcKcK6EEp_CdIH_OVIw
 tSeNVoJDKKVori.GHUGOBa.EAtWGayLK.e6YcDCB04YPjPaq3QDiEZR2YFWKzOQ_cgAaw_iRsH8h
 D3VE16V4mbcjJoRheoO6r4ELVFw0XBkrbkly7ENx2oMhzAnQfneiDsPCyLoBuqaNRbxDUxcMCOP4
 w6enPGKQnnQ_o9xiFcIdvwiqXeveiCuCjZHh.l96Gx47sLO9QPDy0tF_gYK5yZmT.8CcX.25B8nX
 jMBY.bgwJZ9b.X1o6ES3Mux6NYeRHo_ui.0po7Y9YNLlNkiL1iHYYA5f0cZSC0RbuYyE63rVBKl5
 crFumxRBq_JU9O7IV_CAb_IyzItFo4nd9cJplyFJH7aUAJSO3wNBnOvbtUDjC9Hsin0jfo470Brf
 DPseilnWA2sPYEsXVeLf4F0MLAR8JPdBTFDjiIvUVMmgjp4bftUOwjpo3czYlOeWlZLjg0g2e8hO
 1FwezlK.cICJ0mfYspHJmYJxJ7Z467Ulcx_U3pufVxOcG2wNX_Bc-
X-Sonic-MF: <email200202@yahoo.com>
X-Sonic-ID: 4450a33c-aef9-49e1-b3fc-345f56f6adb5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Thu, 11 Jan 2024 08:20:12 +0000
Received: by hermes--production-gq1-78d49cd6df-t49qq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 97d1b92ffe0fdce95aeca671c72f318c;
          Thu, 11 Jan 2024 08:20:06 +0000 (UTC)
Message-ID: <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>
Date: Thu, 11 Jan 2024 19:20:02 +1100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: email200202 <email200202@yahoo.com>
Content-Language: en-US
To: regressions@lists.linux.dev
Cc: kernel@gentoo.org, stable@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [REGRESSION] After kernel upgrade 6.1.70 to 6.1.71, the computer
 hangs during shutdown
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
References: <58ac38ae-4d64-4a53-81e0-35785961c41c.ref@yahoo.com>
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


#regzbot introduced: v6.1.70..v6.1.71


After kernel upgrade 6.1.70 to 6.1.71, the computer hangs during shutdown.

The problem is related to NFS service. Stopping NFS service hangs:

# /etc/init.d/nfs  stop
  * Caching service dependencies ... [ ok ]
  * Stopping NFS mountd ... [ ok ]
  * Stopping NFS daemon ... [ ok ]

then it hangs


Shutdown does not hang when NFS service is removed.

# rc-update  del  nfs

I had this kernel error in the log:

Jan 10 17:32:25 [rpc.mountd] Caught signal 15, un-registering and exiting.
Jan 10 17:32:25 [kernel] [ 2005.560991] ------------[ cut here ]------------
Jan 10 17:32:25 [kernel] [ 2005.560996] kernel BUG at net/sunrpc/svc.c:576!
Jan 10 17:32:25 [kernel] [ 2005.561004] invalid opcode: 0000 [#1] 
PREEMPT SMP PTI
Jan 10 17:32:25 [kernel] [ 2005.561012] CPU: 0 PID: 8079 Comm: nfsd 
Tainted: P           O       6.1.71-gentoo #1
Jan 10 17:32:25 [kernel] [ 2005.561017] Hardware name: Gigabyte 
Technology Co., Ltd. X58A-UD3R/X58A-UD3R, BIOS FB 08/24/2010
Jan 10 17:32:25 [kernel] [ 2005.561020] RIP: 0010:svc_destroy+0x1f/0x56
Jan 10 17:32:25 [kernel] [ 2005.561033] Code: 5b 5d 41 5c 41 5d c3 cc cc 
cc cc 55 48 8d 6f ec 53 48 89 fb 48 83 c7 44 e8 b6 6c 5f ff 48 8b 53 1c 
48 8d 43 1c 48 39 c2 74 02 <0f> 0b 48 8b 53 2c 48 8d 43 2c 48 39 c2 74 
02 0f 0b 48 89 ef e8 6b
Jan 10 17:32:25 [kernel] [ 2005.561038] RSP: 0018:ffffc90001edbee8 
EFLAGS: 00010287
Jan 10 17:32:25 [kernel] [ 2005.561043] RAX: ffff88816c1a1c30 RBX: 
ffff88816c1a1c14 RCX: 0000000000000000
Jan 10 17:32:25 [kernel] [ 2005.561047] RDX: ffff88813dfcc018 RSI: 
0000000000000286 RDI: ffff88890bc9b9c0
Jan 10 17:32:25 [kernel] [ 2005.561051] RBP: ffff88816c1a1c00 R08: 
ffff88810310b600 R09: 0000000000000000
Jan 10 17:32:25 [kernel] [ 2005.561055] R10: ffff8881bc3b4000 R11: 
ffff8881bc3b4000 R12: ffffffff82e061c0
Jan 10 17:32:25 [kernel] [ 2005.561058] R13: ffff8881bc0e8000 R14: 
ffff88810310b600 R15: ffffc90002323c80
Jan 10 17:32:25 [kernel] [ 2005.561062] FS:  0000000000000000(0000) 
GS:ffff88890bc00000(0000) knlGS:0000000000000000
Jan 10 17:32:25 [kernel] [ 2005.561067] CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Jan 10 17:32:25 [kernel] [ 2005.561071] CR2: 000055e971e376f8 CR3: 
000000000260a000 CR4: 00000000000006f0
Jan 10 17:32:25 [kernel] [ 2005.561075] Call Trace:
Jan 10 17:32:25 [kernel] [ 2005.561079]  <TASK>
Jan 10 17:32:25 [kernel] [ 2005.561082]  ? __die_body+0x15/0x57
Jan 10 17:32:25 [kernel] [ 2005.561091]  ? die+0x2b/0x44
Jan 10 17:32:25 [kernel] [ 2005.561097]  ? do_trap+0x76/0xf9
Jan 10 17:32:25 [kernel] [ 2005.561102]  ? svc_destroy+0x1f/0x56
Jan 10 17:32:25 [kernel] [ 2005.561108]  ? svc_destroy+0x1f/0x56
Jan 10 17:32:25 [kernel] [ 2005.561114]  ? do_error_trap+0x69/0x93
Jan 10 17:32:25 [kernel] [ 2005.561119]  ? svc_destroy+0x1f/0x56
Jan 10 17:32:25 [kernel] [ 2005.561126]  ? exc_invalid_op+0x49/0x5d
Jan 10 17:32:25 [kernel] [ 2005.561133]  ? svc_destroy+0x1f/0x56
Jan 10 17:32:25 [kernel] [ 2005.561139]  ? asm_exc_invalid_op+0x16/0x20
Jan 10 17:32:25 [kernel] [ 2005.561148]  ? svc_destroy+0x1f/0x56
Jan 10 17:32:25 [kernel] [ 2005.561155]  ? svc_destroy+0x12/0x56
Jan 10 17:32:25 [kernel] [ 2005.561161]  nfsd+0x13d/0x162
Jan 10 17:32:25 [kernel] [ 2005.561170]  ? svc_put+0x2f/0x2f
Jan 10 17:32:25 [kernel] [ 2005.561176]  kthread+0xd0/0xd8
Jan 10 17:32:25 [kernel] [ 2005.561183]  ? 
kthread_complete_and_exit+0x16/0x16
Jan 10 17:32:25 [kernel] [ 2005.561189]  ret_from_fork+0x22/0x30
Jan 10 17:32:25 [kernel] [ 2005.561196]  </TASK>
Jan 10 17:32:25 [kernel] [ 2005.561198] Modules linked in: snd_seq_dummy 
snd_seq snd_seq_device nvidia_uvm(PO) bluetooth ecdh_generic ecc bridge 
stp llc ipv6 crc_ccitt ch341 usbserial nvidia_drm(PO) nvidia_modeset(PO) 
nvidia(PO) tda10048 tda8290 iTCO_wdt iTCO_vendor_support tda18271 it87 
hwmon_vid dm_crypt coretemp dm_multipath dm_mod kvm_intel dax video 
snd_hda_codec_realtek snd_hda_codec_generic kvm drm_kms_helper irqbypass 
ledtrig_audio i2c_i801 pcspkr serio_raw drm i2c_smbus snd_hda_intel 
i2c_core snd_intel_dspcfg fb_sys_fops syscopyarea snd_hda_codec 
sysfillrect lpc_ich snd_hda_core sysimgblt mfd_core snd_hwdep uhci_hcd 
rtc_cmos wmi
Jan 10 17:32:25 [kernel] [ 2005.561274] ---[ end trace 0000000000000000 ]---
Jan 10 17:32:25 [kernel] [ 2005.561277] RIP: 0010:svc_destroy+0x1f/0x56
Jan 10 17:32:25 [kernel] [ 2005.561284] Code: 5b 5d 41 5c 41 5d c3 cc cc 
cc cc 55 48 8d 6f ec 53 48 89 fb 48 83 c7 44 e8 b6 6c 5f ff 48 8b 53 1c 
48 8d 43 1c 48 39 c2 74 02 <0f> 0b 48 8b 53 2c 48 8d 43 2c 48 39 c2 74 
02 0f 0b 48 89 ef e8 6b

The problem is always reproducible. Steps to reproduce:
1. Update to kernel 6.1.71
2. Start nfs service
3. Try to shutdown
4. The computer hangs

Reverting the following 3 commits fixed the problem in kernel 6.1.71:

f9a01938e07910224d4a2fd00583725d686c3f38
bb4f791cb2de1140d0fbcedfe9e791ff364021d7
03d68ffc48b94cc1e15bbf3b4f16f1e1e4fa286a




