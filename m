Return-Path: <linux-nfs+bounces-12899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C8AF92D7
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 14:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EECC4A7E5E
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709272D8DA3;
	Fri,  4 Jul 2025 12:38:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84EF2D8771
	for <linux-nfs@vger.kernel.org>; Fri,  4 Jul 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632707; cv=none; b=nlpU2GtbQNVtId5y4oFzCCW/LmP07eaJdlaAbcAHxNWxglUEHF2cAJbe7g5/6JtZO5jBGsGTP0aKM/r0I/LUwjbsd60cEnaziIcA/hxvF49TBM8TjODqJ0ssgngTL+dIOU7xQ6ngf7jRvspBmKxaeMBS65ZNnIklBpx7IlFzqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632707; c=relaxed/simple;
	bh=6+6EkI/JGBIZUO61CrURGw6GZ/6fWgN0VwyEURRIf0g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DeGR9CUtgbsLQqR4powkIV+m8DRFw+qaYBD/PvB1RMbZTlPKEAbQj5voK3PciAA3UHP4ZNYKhyVPhivRu/MS50Bc1e6XntaKmHjDS8f+WK2xKZbv5jx11FdW/TzQVhEaWICPUzViMbn6P68XyUCViE8pl9Ape8002nV9HA7HCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e055be2288so8114775ab.3
        for <linux-nfs@vger.kernel.org>; Fri, 04 Jul 2025 05:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751632705; x=1752237505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/KobVGwWj+yczhWyCQpLBwTo6ncGhSmFGCWV6CIOFs=;
        b=euVHwTRczDHlvrt6rNHgL9VpKI7o7AApuWAOFDTO8WW8hT1DqHVvakrgncFnyaLe7r
         ehRXDvm7sJ444GcwFz9Pfj2q0Xj8hPwlKZ7eeHnkiraVZ7S05SIZ83UIwKksEH5mhsbw
         jpydn+fjsmx6lbhFtBBGZOlt9WHfT7uPOx6btioHmv7aXttC76R0o+xI6qndzNP0Hn6y
         K0b6iB8Q3D8qJTHdPluDGbMt4+QxzlDOUBckAfPK0mV58tChZxgWGZOdFnKOhISTfaf4
         IXEIco5N9RxD/ap/8QfkgGS9Xl2j/f+0VaGVuRBSjmkd4JQF4C9prndCQvn+JJ9acb+f
         z4nw==
X-Forwarded-Encrypted: i=1; AJvYcCUMjneR9p1s7m3ex8qcnGn77K5Cnjbb7/c3VI/R+6ADHgfWbGFLmytnb7nKRKvPyZxVoSgIR6tc7mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHL4XiLTQaYgFGZfe3CT9cOaU3cotdjongqfYSLGLxtfeFE2nT
	CTkNQAk4A78gWjszhWXKY356kDeiN6kt1DLU6kHqDO0lfrSBQNo4WIVbowbd3WWL54e9ITSl5kq
	fhCyTPP3gbEpQpEpXVolg4/IS06MdvUDgBWr9dfWPCGvzfxOYlicYitXp2cI=
X-Google-Smtp-Source: AGHT+IHzxUq7frs9QYdd32isezGYus9fInAceYhr1eZ0hV+0oBhibkmx8qJmCDhr3bZ+mhwBZuuapmxFzLFc+oIhsG5DAuaRutf3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:3e0:51b3:6f3f with SMTP id
 e9e14a558f8ab-3e1371fb2f0mr16977865ab.21.1751632704915; Fri, 04 Jul 2025
 05:38:24 -0700 (PDT)
Date: Fri, 04 Jul 2025 05:38:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6867cb40.a70a0220.29cf51.001b.GAE@google.com>
Subject: [syzbot] Monthly nfs report (Jul 2025)
From: syzbot <syzbot+listdc1ca7bb566f225a8ae2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfs maintainers/developers,

This is a 31-day syzbot report for the nfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfs

During the period, 0 new issues were detected and 1 were fixed.
In total, 9 issues are still open and 17 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 20778   Yes   INFO: task hung in nfsd_nl_listener_set_doit
                  https://syzkaller.appspot.com/bug?extid=d1e76d963f757db40f91
<2> 2447    No    INFO: task hung in nfsd_umount
                  https://syzkaller.appspot.com/bug?extid=b568ba42c85a332a88ee
<3> 939     No    INFO: task hung in nfsd_nl_version_get_doit
                  https://syzkaller.appspot.com/bug?extid=41bc60511c2884783c27
<4> 827     No    INFO: task hung in nfsd_nl_threads_get_doit
                  https://syzkaller.appspot.com/bug?extid=c0831b61d6ade1e2d098
<5> 817     No    INFO: task hung in nfsd_nl_rpc_status_get_dumpit
                  https://syzkaller.appspot.com/bug?extid=68f089d6e18e8b1d41eb
<6> 804     No    INFO: task hung in nfsd_nl_listener_get_doit
                  https://syzkaller.appspot.com/bug?extid=4207adf14e7c0981d28d
<7> 324     Yes   INFO: task hung in nfsd_nl_threads_set_doit
                  https://syzkaller.appspot.com/bug?extid=e7baeb70aa00c22ed45e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

