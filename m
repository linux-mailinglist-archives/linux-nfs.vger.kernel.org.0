Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C9D7E2498
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Nov 2023 14:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjKFNX0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Nov 2023 08:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjKFNXZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Nov 2023 08:23:25 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD46D61;
        Mon,  6 Nov 2023 05:23:19 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso3027385b3a.0;
        Mon, 06 Nov 2023 05:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699276999; x=1699881799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fr+joEsWrYcl8ukIVzt78+UYYlxwhETFVKbvjb+usu8=;
        b=By6wrBo1B0uZy29mrn25OOZ2LOVyVyyRTd+F41JPqTgtnA5kgjI7z0FckjiVhwxM3N
         9SIrHMpCDx2nmh6rT/GVgOnpVwBDGdQXDn5fwQLAldytcNUbXkm7CmOXI2L9920ZKMzb
         D4DPnhVnRh92mQDZabyXLnmlS/NdUo3V6LSRx8Xb1HjsW4uoeI85vbDc2XFThZJmHUd+
         SmQtAz5R2A7lmkKrn9cGG3RYGil/4IgfalNHcj3u3sc4S8Bs1ZQi6JjCFPJ1RWbEfcnG
         iA3r+7vRai2HdufWo/07aJw6Fai+Qb7NYyRw3MK8ACxLO/yHS5EMSg57Krh2JaWNLJst
         UHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699276999; x=1699881799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr+joEsWrYcl8ukIVzt78+UYYlxwhETFVKbvjb+usu8=;
        b=oucrPaFNKW+2MuYHf3j9qXTUthqq5XpU5owqGnnJSGLdpDBtOqwogzaZ/FlP411K/1
         FQg0nq2sxccZB/qJDbR4JemXXQuOhQifvS/tdNMZ4iNEuVJVbhICjuQwWlfYEsx5m3I+
         Z4ymjSKvUfyZPySLO90w5W/+/VTsrtsvnNWe9Iy9kIDEmtixzp52MDBr5WjZinDk73sb
         PvnSbM9/5aBmIav6gV/aXR2zc8larzsw0QPYtVKRz5QGcc/bOmKUHN5xdN2e6t//FE0e
         FPpV6r4hAHHZZJajeQm1q5UDMaBM1IjcY8vIfQ6iBkEVxQbGba626kNjwLoEo4sKaMZa
         0qsA==
X-Gm-Message-State: AOJu0YyNIdVHXg9rFGmPEnVXLc3IMTw7vdmrtdG6uouWh/Z29RGDNnBk
        l0XXjsoF1AGrS5lv7aKCCME=
X-Google-Smtp-Source: AGHT+IES65Beeo5CtT0KG2gVpssf1mIWeJn7zOSJ55OXkJjOpdHjEhG2JP0PsCRTcF1nhxyE/FWrSw==
X-Received: by 2002:a05:6a20:8e1f:b0:174:210c:34b0 with SMTP id y31-20020a056a208e1f00b00174210c34b0mr27396156pzj.0.1699276998794;
        Mon, 06 Nov 2023 05:23:18 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ge8-20020a17090b0e0800b00277371fd346sm1370106pjb.30.2023.11.06.05.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 05:23:17 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id CB5EB815CB68; Mon,  6 Nov 2023 20:23:14 +0700 (WIB)
Date:   Mon, 6 Nov 2023 20:23:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Daire Byrne <daire@dneg.com>,
        Charles Hedrick <hedrick@rutgers.edu>,
        Linux NFS <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: Re: autofs mount/umount hangs with recent kernel?
Message-ID: <ZUjowgTNt3uW-p4y@debian.me>
References: <CAPt2mGNPSi-+3WdeMsOjkJ2vOqZcRE2S6i=eqi+UA2RmzywAyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ce7L8x7nY1fZntQ6"
Content-Disposition: inline
In-Reply-To: <CAPt2mGNPSi-+3WdeMsOjkJ2vOqZcRE2S6i=eqi+UA2RmzywAyg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--ce7L8x7nY1fZntQ6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 09:40:44AM +0000, Daire Byrne wrote:
> Hi,
>=20
> We have large compute clusters that, amongst other things, spend their
> day mounting & unounting lots of Linux NFS servers via autofs. This
> has worked fine for many years and client kernel versions and was
> working without incident even with our current v6.3.x production
> kernels.
>=20
> During the v6.6-rc cycle while testing that kernel, I noticed that
> every now and then, the umount/mount would hang randomly and the
> compute host would get stuck and not complete it's work until a
> reboot. I thought I'd wait until v6.6 was released and check again -
> the issue persists.
>=20
> I have not had the opportunity to test the v6.4 & v6.5 kernels in
> between yet. The stack traces look something like this:
>=20
> [202752.264187] INFO: task umount.nfs:58118 blocked for more than 245 sec=
onds.
> [202752.264237]       Tainted: G            E      6.6.0-1.dneg.x86_64 #1
> [202752.264267] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [202752.264296] task:umount.nfs      state:D stack:0     pid:58118
> ppid:1      flags:0x00004002
> [202752.264304] Call Trace:
> [202752.264308]  <TASK>
> [202752.264313]  __schedule+0x30b/0xa10
> [202752.264327]  schedule+0x68/0xf0
> [202752.264332]  io_schedule+0x16/0x40
> [202752.264337]  __folio_lock+0xfc/0x220
> [202752.264346]  ? srso_alias_return_thunk+0x5/0x7f
> [202752.264353]  ? __pfx_wake_page_function+0x10/0x10
> [202752.264361]  truncate_inode_pages_range+0x441/0x460
> [202752.264411]  truncate_inode_pages_final+0x41/0x50
> [202752.264425]  nfs_evict_inode+0x1a/0x40 [nfs]
> [202752.264476]  evict+0xdc/0x190
> [202752.264485]  dispose_list+0x4d/0x70
> [202752.264491]  evict_inodes+0x16b/0x1b0
> [202752.264499]  generic_shutdown_super+0x3e/0x160
> [202752.264507]  kill_anon_super+0x17/0x50
> [202752.264513]  nfs_kill_super+0x27/0x50 [nfs]
> [202752.264556]  deactivate_locked_super+0x35/0x90
> [202752.264562]  deactivate_super+0x42/0x50
> [202752.264568]  cleanup_mnt+0x109/0x170
> [202752.264574]  __cleanup_mnt+0x12/0x20
> [202752.264580]  task_work_run+0x61/0x90
> [202752.264588]  exit_to_user_mode_prepare+0x1d8/0x200
> [202752.264596]  syscall_exit_to_user_mode+0x1c/0x40
> [202752.264603]  do_syscall_64+0x48/0x90
> [202752.264609]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [202752.264617] RIP: 0033:0x7fcb9befeba7
> [202752.264622] RSP: 002b:00007ffdd63ef348 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a6
> [202752.264628] RAX: 0000000000000000 RBX: 00005561e35da010 RCX:
> 00007fcb9befeba7
> [202752.264632] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
> 00005561e35da1e0
> [202752.264634] RBP: 00005561e35da1e0 R08: 00005561e35dbfa0 R09:
> 00005561e35db790
> [202752.264637] R10: 00007ffdd63eeda0 R11: 0000000000000246 R12:
> 00007fcb9c442d78
> [202752.264640] R13: 0000000000000000 R14: 00005561e35db2c0 R15:
> 00007ffdd63f0dcb
> [202752.264648]  </TASK>
>=20
> [202752.264658] INFO: task mount.nfs:60827 blocked for more than 122 seco=
nds.
> [202752.264686]       Tainted: G            E      6.6.0-1.dneg.x86_64 #1
> [202752.264713] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [202752.264743] task:mount.nfs       state:D stack:0     pid:60827
> ppid:60826  flags:0x00004000
> [202752.264751] Call Trace:
> [202752.264753]  <TASK>
> [202752.264757]  __schedule+0x30b/0xa10
> [202752.264763]  ? srso_alias_return_thunk+0x5/0x7f
> [202752.264771]  schedule+0x68/0xf0
> [202752.264776]  schedule_preempt_disabled+0x15/0x30
> [202752.264782]  rwsem_down_write_slowpath+0x2b3/0x640
> [202752.264788]  ? try_to_wake_up+0x242/0x5f0
> [202752.264797]  ? __x86_indirect_jump_thunk_r15+0x20/0x20
> [202752.264803]  ? wake_up_q+0x50/0x90
> [202752.264809]  down_write+0x55/0x70
> [202752.264815]  super_lock+0x44/0x130
> [202752.264821]  ? kernfs_activate+0x54/0x60
> [202752.264828]  ? srso_alias_return_thunk+0x5/0x7f
> [202752.264833]  ? kernfs_add_one+0x11f/0x160
> [202752.264841]  grab_super+0x2e/0x80
> [202752.264847]  grab_super_dead+0x31/0xe0
> [202752.264855]  ? srso_alias_return_thunk+0x5/0x7f
> [202752.264860]  ? sysfs_create_link_nowarn+0x22/0x40
> [202752.264865]  ? srso_alias_return_thunk+0x5/0x7f
> [202752.264871]  ? __pfx_nfs_compare_super+0x10/0x10 [nfs]
> [202752.264915]  sget_fc+0xd4/0x280
> [202752.264921]  ? __pfx_nfs_set_super+0x10/0x10 [nfs]
> [202752.264965]  nfs_get_tree_common+0x86/0x520 [nfs]
> [202752.265009]  nfs_try_get_tree+0x5c/0x2e0 [nfs]
> [202752.265052]  ? srso_alias_return_thunk+0x5/0x7f
> [202752.265058]  ? try_module_get+0x1d/0x30
> [202752.265064]  ? srso_alias_return_thunk+0x5/0x7f
> [202752.265068]  ? get_nfs_version+0x29/0x90 [nfs]
> [202752.265111]  ? srso_alias_return_thunk+0x5/0x7f
> [202752.265116]  ? nfs_fs_context_validate+0x4fe/0x710 [nfs]
> [202752.265163]  nfs_get_tree+0x38/0x60 [nfs]
> [202752.265202]  vfs_get_tree+0x2a/0xe0
> [202752.265207]  ? capable+0x19/0x20
> [202752.265213]  path_mount+0x2fe/0xa90
> [202752.265219]  ? putname+0x55/0x70
> [202752.265226]  do_mount+0x80/0xa0
> [202752.265233]  __x64_sys_mount+0x8b/0xe0
> [202752.265240]  do_syscall_64+0x3b/0x90
> [202752.265245]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [202752.265250] RIP: 0033:0x7fbf5d4ff26a
> [202752.265253] RSP: 002b:00007ffeb24fdd98 EFLAGS: 00000202 ORIG_RAX:
> 00000000000000a5
> [202752.265258] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007fbf5d4ff26a
> [202752.265261] RDX: 000055c814e78100 RSI: 000055c814e771e0 RDI:
> 000055c814e77320
> [202752.265264] RBP: 00007ffeb24fdfb0 R08: 000055c814e85510 R09:
> 000000000000006d
> [202752.265266] R10: 0000000000000004 R11: 0000000000000202 R12:
> 00007fbf5e2307e0
> [202752.265269] R13: 00007ffeb24fdfb0 R14: 00007ffeb24fde90 R15:
> 000055c814e855a0
> [202752.265277]  </TASK>
>=20
> And like I said, the mount/umount against the server hangs
> indefinitely on the client. It is somewhat interesting that autofs
> still tries to trigger a subsequent mount even though the umount has
> not completed.
>=20
> The NFS servers are running RHEL8.5 and we are using NFSv3. I also
> reproduced it with a fairly recent nfs-utils-2.6.2 on the client
> compute hosts.
>=20
> Because these happen quite rarely, it takes time and many clients and
> mount/umount cycles to reproduce, so I thought I'd post here before
> working through the bisect testing. If you think this is better as a
> kernel.org bugzilla ticket, I'm happy to do that too.
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: v6.5..v6.6

--=20
An old man doll... just what I always wanted! - Clara

--ce7L8x7nY1fZntQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUjowgAKCRD2uYlJVVFO
o7IwAP9DsSr/mJ9kz/lpJb8+LA0eTKCjju+vzkoWgJ3NMX+ePAEA2b8L/6KUSPYo
NAH1ijhluRkl1Ulei5ZjCRQdGnFwvAE=
=0FBA
-----END PGP SIGNATURE-----

--ce7L8x7nY1fZntQ6--
