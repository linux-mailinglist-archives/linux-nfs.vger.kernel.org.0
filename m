Return-Path: <linux-nfs+bounces-12067-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62781ACC344
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 11:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A30C16BC73
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6AD204C3B;
	Tue,  3 Jun 2025 09:38:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609C2BD04
	for <linux-nfs@vger.kernel.org>; Tue,  3 Jun 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943504; cv=none; b=WRul7Wsl8QC/eP3OgyFmoTRWHBWqvqQEMtpJrdlWjWb7cbuGj147D2StJhEh8gBqvEg4ACA75mGs+E+049vAJELj/OkE9GMe8xtkPB+0l4qfgBL5cD+9r9rFcy+c1uxwDNsv79Z4mn2T2ZO417yUQsOoTKJHeZXCl+Bh3TI88hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943504; c=relaxed/simple;
	bh=IB032qsp2887c7Ok5kbpqpTQvBFl43MFeUSsFjqPH8w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ak4aRXRFvVbVxrE4aZ9lzcqG6daZJMuM0Bi3ewrK/qwrNavRycdWayPQK89xHPL0c4pCkksn77Un6Hq7uw0Yc+XDUoJ0geIJXZxrNivQpDM42vxX++CoANbo4eRO22wfzl3AuRLlsI8apT/9qaBmAyGmIlP3FHvIpn6AJnP715w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddbb34fc1cso2320565ab.1
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jun 2025 02:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748943502; x=1749548302;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOX2874ohwBkFW6x8Q+3RcT0hX/nbGdRgutYAjuBqkw=;
        b=CY9Kqk+Gmx0iMu3EcExX2l7GI2ZebaJXIT3bNtBEutsuLuK/uNepswTzbfH59lQzow
         A6d3yr3pRtRL4ScYs1EWSMT3dB2+2ebVmY2fq6FE6ge8JM/70g6EZJIiEV5ZueyyUTOP
         sy4o3FT4mW9ugyPCc3cAIziWN7cWIwmkH/P6STsv57No4wQ5YsiA5M8qrbuEeW98as/2
         4QuGYLg1GsypmsbwRQ/jYcSviqKryfh/xr2/ybVi9O7YZDbeE+6T/uifK4rjeelKNWYA
         1qzUTg9gQVv7EPS8G8lsLKn+P2VIf7R0tDBj6QmGa4fa7RY4+zOBRXzlyavbQ6j84aTp
         WGbw==
X-Forwarded-Encrypted: i=1; AJvYcCX4yb6jotqvklmokl7jf+Cxj6u7q0yjSkpiLLjen+o8PPONrTBGMwX3ltsZVUBg1Ko7xwlb//Lc3tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYP2yKk2BtM08aQ6R3PEkwefTrTrk1aT3FSGjpHoF5/hXFluiE
	LJmCXtlkcCZMhYpgSNtHIC/tfRmqvbBUEDf/YIEkDSUvgg1bWW/0dbYh3zKz+Qc71KQGhV4Y0bA
	7QudlHddAkDQN38b3SFSlsmBh5YyaAetB4LagGs+UtdQCE/XMBJHLRmWHKJI=
X-Google-Smtp-Source: AGHT+IGlhvLlcTJ+bj1kA/KxYsHLiv/nvIdD9C5SD8Vs6GdVK1MK1r4rqHmEpz9JTOWCBs4j32zvcZ1ctY1cd2001kr+JRjSxn/x
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4515:10b0:3dd:b5c6:4225 with SMTP id
 e9e14a558f8ab-3ddb5c64337mr28480175ab.6.1748943502310; Tue, 03 Jun 2025
 02:38:22 -0700 (PDT)
Date: Tue, 03 Jun 2025 02:38:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683ec28e.050a0220.55ceb.000b.GAE@google.com>
Subject: [syzbot] Monthly nfs report (Jun 2025)
From: syzbot <syzbot+listc06ab228b356f0d07b0c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfs maintainers/developers,

This is a 31-day syzbot report for the nfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 16 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 20162   Yes   INFO: task hung in nfsd_nl_listener_set_doit
                  https://syzkaller.appspot.com/bug?extid=d1e76d963f757db40f91
<2> 2398    No    INFO: task hung in nfsd_umount
                  https://syzkaller.appspot.com/bug?extid=b568ba42c85a332a88ee
<3> 927     No    INFO: task hung in nfsd_nl_version_get_doit
                  https://syzkaller.appspot.com/bug?extid=41bc60511c2884783c27
<4> 810     No    INFO: task hung in nfsd_nl_threads_get_doit
                  https://syzkaller.appspot.com/bug?extid=c0831b61d6ade1e2d098
<5> 799     No    INFO: task hung in nfsd_nl_rpc_status_get_dumpit
                  https://syzkaller.appspot.com/bug?extid=68f089d6e18e8b1d41eb
<6> 777     No    INFO: task hung in nfsd_nl_listener_get_doit
                  https://syzkaller.appspot.com/bug?extid=4207adf14e7c0981d28d
<7> 319     Yes   INFO: task hung in nfsd_nl_threads_set_doit
                  https://syzkaller.appspot.com/bug?extid=e7baeb70aa00c22ed45e
<8> 49      No    INFO: task hung in nfsd_nl_version_set_doit
                  https://syzkaller.appspot.com/bug?extid=f56732cee5a3c93a262f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

