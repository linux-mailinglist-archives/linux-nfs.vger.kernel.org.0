Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C51D1351
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfJIP4Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 11:56:16 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44082 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731375AbfJIP4P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 11:56:15 -0400
Received: by mail-yb1-f195.google.com with SMTP id v1so886109ybo.11
        for <linux-nfs@vger.kernel.org>; Wed, 09 Oct 2019 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Ln0YUpui1l5u4leOPHnrNb6Lgm/QIBgB+ZVuAiUy8w=;
        b=ZGrGna3YflCpOCkFr+51FoWbPoBZyCgu32dhSDfsWtne939irPiTJGi/XOTdQg5fJn
         xYZeN8BJKb8ZavKwA9EnX7sc54eCk+7EI8hccaLa2VYhvUIpl/FFC5T4Ou9+TKzfP0J7
         5CnUMxQfJDPTDzTVF56OUNMqNHr8pNB0Wmtn1deIeJLRvhnmUzRYT48I9JOo1pvxxpEa
         SgBZB2pqZ8Rz1cDb15KmZQxBbjsyIJ+Ihimx8Jou91CTANYwOVqVMYn4hucmE88hB3cS
         2WF4irK3g52gaQkqrmUk9yv6U+ELg4rDRFerDkSG9gtB+2OHvqPuiHbWafQ4cvvFnAXy
         Uzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Ln0YUpui1l5u4leOPHnrNb6Lgm/QIBgB+ZVuAiUy8w=;
        b=dVDbWdvQWy+jq6oSCrwHN3B59UzsZuMlQkXXf9IlX/vRbNS3gUGhIcbjFZh/m3v9jZ
         uV6uUh5LSATQ6+qUh8DD15u7X09M/xdOQWexnIjwMlPBmm+yzcUTfJuuqGCPQWpPEkPG
         cNuhw/9UMkqfImYRBLt2sn5TNnfsspIcKTIYqLAIsZAi6+5tqBsmGAxSoTX9tVqtcaZd
         2ZunxWkYDY43qxUyQ5r1yW4dpSjm5QP4ZP9ESLrX2xGP0MH/HwDvMTplj9C+y7B+UoGB
         IJM0gPpA5PZTLZJUXZPkcZr5MPlVM309EtKY0QgnGeEDj2xWDV1HU2uRMiHbJxkcT6vS
         45cQ==
X-Gm-Message-State: APjAAAXebp6bB7aKxcMnDA5AdDf/87BJRuYqqB+ZBVPMLlZ58qhbRuQz
        XXkdEi+K7M+CsE9bR4bGPoI94QTNC2ZOTjnNXpDC/Q==
X-Google-Smtp-Source: APXvYqwMyiTX5g5dR7nddh59AONVcZxhJ68MkHqeoAgnb4qV6+Q/6oHv2xfFvkdDINp6zoyEkK8sri51ooJ7k7v6q0w=
X-Received: by 2002:a25:cac3:: with SMTP id a186mr2793931ybg.9.1570636574333;
 Wed, 09 Oct 2019 08:56:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:c02:0:0:0:0:0 with HTTP; Wed, 9 Oct 2019 08:56:13 -0700 (PDT)
X-Originating-IP: [162.243.96.244]
In-Reply-To: <CADyTPExOnxS+FS6Uqoxu3jNWRy93SQri4Xo1+00aiiVru8XDkg@mail.gmail.com>
References: <CADyTPExOnxS+FS6Uqoxu3jNWRy93SQri4Xo1+00aiiVru8XDkg@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Wed, 9 Oct 2019 15:56:13 +0000
Message-ID: <CADyTPEzLDMb+KWLifm8zQTctVyuA+2EprbhHQBEfL8c01OYktw@mail.gmail.com>
Subject: Re: PROBLEM: nfs? crash in Linux 5.3 (possible regression)
To:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/20/19, Nick Bowler <nbowler@draconx.ca> wrote:
> I hit this oops on Linux 5.3 yesterday.  The crash itself occurred while
> compiling Linux (source and build dirs on NFS).  Afterwards, the system
> remained mostly alive but my NFS mounts became very busted with lots
> (but not all) I/O operations appearing to hang forever.

Well that took a long time but I completed the bisection.  I had to
disable CONFIG_JUMP_LABEL because this option was apparently causing
almost every kernel between 5.2 and 5.3-rc1 to be unbootable for some
reason which made successful bisection impossible.

The first commit which exhibits the oops described is 218e6424e711
("keys: Garbage collect keys for which the domain has been removed").

The immediately preceding 8 commits are "skipped" because they crash
quite differently from the issue seen in Linux 5.3.  After 218e6424e711
the observed crash is always exactly the same.

However the crash in the "skipped" kernels occurs under similar
circumstances with significantly more catastrophic results: the system
becoming completely non-responsive (I think basically every user process
is killed), nothing is saved, making it difficult to obtain logs.  I can
try netconsole or something if it would help.

# only skipped commits left to test
# possible first bad commit:
[218e6424e711ceee31eeba93212fed8ee92d6a11] keys: Garbage collect keys
for which the domain has been removed
# possible first bad commit:
[3b6e4de05e9ee2e2f94e4a3fe14d945e2418d9a8] keys: Include target
namespace in match criteria
# possible first bad commit:
[0f44e4d976f96c6439da0d6717238efa4b91196e] keys: Move the user and
user-session keyrings to the user_namespace
# possible first bad commit:
[b206f281d0ee14969878469816a69db22d5838e8] keys: Namespace keyring
names
# possible first bad commit:
[dcf49dbc8077e278ddd1bc7298abc781496e8a08] keys: Add a 'recurse' flag
for keyring searches
# possible first bad commit:
[355ef8e15885020da88f5ba2d85ce42b1d01f537] keys: Cache the hash value
to avoid lots of recalculation
# possible first bad commit:
[f771fde82051976a6fc0fd570f8b86de4a92124b] keys: Simplify key
description management
# possible first bad commit:
[3b8c4a08a471d56ecaaca939c972fdf5b8255629] keys: Kill off
request_key_async{,_with_auxdata}
# possible first bad commit:
[7743c48e54ee9be9c799cbf3b8e3e9f2b8d19e72] keys: Cache result of
request_key*() temporarily in task_struct

Thanks,
  Nick

> [  796.050025] BUG: kernel NULL pointer dereference, address: 00000000000=
00014
> [  796.051280] #PF: supervisor read access in kernel mode
> [  796.053063] #PF: error_code(0x0000) - not-present page
> [  796.054636] PGD 0 P4D 0
> [  796.055688] Oops: 0000 [#1] PREEMPT SMP
> [  796.056768] CPU: 2 PID: 190 Comm: kworker/2:2 Tainted: G        W     =
  5.3.0 #6
> [  796.057953] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.=
M./B450 Gaming-ITX/ac, BIOS P3.30 05/17/2019
> [  796.059329] Workqueue: events key_garbage_collector
> [  796.060623] RIP: 0010:keyring_gc_check_iterator+0x27/0x30
> [  796.061845] Code: 44 00 00 48 83 e7 fc b8 01 00 00 00 f6 87 80 00 00 0=
0 21 75 19 48 8b 57 58 48 39 16 7c 05 48 85 d2 7f 0b 48 8b 87 a0 00 00 00 <=
0f> b6 40 14 c3 0f 1f 40 00 48 83 e7 fc e9 27 eb ff ff 0f 1f 80 00
> [  796.064638] RSP: 0018:ffffb40fc0757df8 EFLAGS: 00010282
> [  796.066058] RAX: 0000000000000000 RBX: ffffa14338caed80 RCX: ffffb40fc=
0757e40
> [  796.067531] RDX: ffffa1433ae85558 RSI: ffffb40fc0757e40 RDI: ffffa1433=
ae85500
> [  796.069014] RBP: ffffb40fc0757e40 R08: 0000000000000000 R09: 000000000=
000000f
> [  796.070513] R10: 8080808080808080 R11: 0000000000000001 R12: ffffffffa=
4cd6180
> [  796.072025] R13: ffffa14338caee10 R14: ffffa14338caedf0 R15: ffffa1433=
ffeff00
> [  796.073567] FS:  0000000000000000(0000) GS:ffffa14340480000(0000) knlG=
S:0000000000000000
> [  796.075171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  796.076785] CR2: 0000000000000014 CR3: 0000000747ce6000 CR4: 000000000=
03406e0
> [  796.078445] Call Trace:
> [  796.080091]  assoc_array_subtree_iterate+0x55/0x100
> [  796.081770]  keyring_gc+0x3f/0x80
> [  796.083447]  key_garbage_collector+0x330/0x3d0
> [  796.085155]  process_one_work+0x1cb/0x320
> [  796.086869]  worker_thread+0x28/0x3c0
> [  796.088603]  ? process_one_work+0x320/0x320
> [  796.090335]  kthread+0x106/0x120
> [  796.092053]  ? kthread_create_on_node+0x40/0x40
> [  796.093810]  ret_from_fork+0x1f/0x30
> [  796.095569] Modules linked in: sha1_ssse3 sha1_generic cbc cts rpcsec_=
gss_krb5 auth_rpcgss nfsv4 nfs lockd grace ext4 crc16 mbcache jbd2 iwlmvm m=
ac80211 libarc4 amdgpu iwlwifi snd_hda_codec_realtek snd_hda_codec_generic =
kvm_amd gpu_sched kvm snd_hda_codec_hdmi drm_kms_helper irqbypass k10temp s=
yscopyarea sysfillrect sysimgblt fb_sys_fops video ttm cfg80211 snd_hda_int=
el snd_hda_codec drm snd_hwdep rfkill snd_hda_core backlight snd_pcm evdev =
snd_timer snd soundcore efivarfs dm_crypt hid_generic igb hwmon i2c_algo_bi=
t sr_mod cdrom sunrpc dm_mod
> [  796.104033] CR2: 0000000000000014
> [  796.106304] ---[ end trace 695aee10f9202347 ]---
> [  796.108585] RIP: 0010:keyring_gc_check_iterator+0x27/0x30
> [  796.110894] Code: 44 00 00 48 83 e7 fc b8 01 00 00 00 f6 87 80 00 00 0=
0 21 75 19 48 8b 57 58 48 39 16 7c 05 48 85 d2 7f 0b 48 8b 87 a0 00 00 00 <=
0f> b6 40 14 c3 0f 1f 40 00 48 83 e7 fc e9 27 eb ff ff 0f 1f 80 00
> [  796.115773] RSP: 0018:ffffb40fc0757df8 EFLAGS: 00010282
> [  796.118209] RAX: 0000000000000000 RBX: ffffa14338caed80 RCX: ffffb40fc=
0757e40
> [  796.120683] RDX: ffffa1433ae85558 RSI: ffffb40fc0757e40 RDI: ffffa1433=
ae85500
> [  796.123176] RBP: ffffb40fc0757e40 R08: 0000000000000000 R09: 000000000=
000000f
> [  796.125668] R10: 8080808080808080 R11: 0000000000000001 R12: ffffffffa=
4cd6180
> [  796.128104] R13: ffffa14338caee10 R14: ffffa14338caedf0 R15: ffffa1433=
ffeff00
> [  796.130493] FS:  0000000000000000(0000) GS:ffffa14340480000(0000) knlG=
S:0000000000000000
> [  796.132923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  796.135266] CR2: 0000000000000014 CR3: 0000000747ce6000 CR4: 000000000=
03406e0
