Return-Path: <linux-nfs+bounces-5230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA041947196
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 01:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F897B20AC1
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Aug 2024 23:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51941139CE3;
	Sun,  4 Aug 2024 23:16:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6C1755C
	for <linux-nfs@vger.kernel.org>; Sun,  4 Aug 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722813364; cv=none; b=LoQP84OFaIRNqoP/9xj6j8vQ7jofERQBPHsls9ZjGKCWI2+rePwXn23wQjy1KElVDIYGCjZOZyyUC+sGOGXG37BqpQhnw2pmuTMXiePc7DPFRx/B7CHBEA0IcYkjfMqVkETziOmJcuHd1mzI2fHz7ot0meqmEEr0v6nZ3KP0RMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722813364; c=relaxed/simple;
	bh=9PV9AfTpJZbNBBWpH/BCpyTS50q62l5g3ctRYxZW8MU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BfN8JSczLtf3CejxecGCWFn2X0ZRyw4fNC1eG8PCARgcQ7be4iu2/I9eEDxi2NtG0DdrAtzY/OGRQLpq7EAoryzl5gDlFHazfcrwMHI+JZdy5AE+3ug8KJ2anO49n5QjdHp8iUykBpszBgrVCo81KrhU9cFyj6q1raRo3zyi910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso1370580139f.0
        for <linux-nfs@vger.kernel.org>; Sun, 04 Aug 2024 16:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722813362; x=1723418162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWk/0YoGbb8Utpd84fDk+7sPr8KnZbi2EHV8pG46Pv0=;
        b=jPykmzpdLjG0S/ZB8L3TTC3/LaogW4nWkB2rUgE12/KMAkf/g6ertDUvGIQ0uoeRHF
         IOD9ZX+b0KTyT+x+fhVr9Tp0xN2/+G4apzbfepW5kl4keASzcarpbQPg8vE6l2kntt0X
         12HzDDicfc6F7w3QuX6u0tlHQkIKtGmEKiOTQq6cymtjWmzEewkMZk1vGJ5ew0rOHLoE
         i9yGs8VkvZmcVFpPL7A5htdFd/DucmNpEWFRYGaEx9/alSNjFedtGCMYi1v9hmQzVMny
         LmxBI7oz4m5C8+2TZyDuXt6D95zlG4VwyuZD1IVb9ALBHkOxBnvhAgMPk8cfT5aq1QxV
         /E4A==
X-Forwarded-Encrypted: i=1; AJvYcCVDJe9YmnWcCsUlNBDqNaaHWBhmZrS8knMS1QxRfEjf7lXfXmqrHgspMWUUtQayDlgD3zuZ3pWy29NtJ8s6zftPYTvJu75fT2ZZ
X-Gm-Message-State: AOJu0YwBCln9uAjZmFZE7YEhRQTcP1VTQW86s4gD2BX0hSRhkjUOemwY
	4tb7ZSQWgRwXup8gIr2mU6Apyphmk8if5cQPlruwYjjd7srWy0s4njIEbbs57DyFAJ/wvNteQjW
	+FaZFnEhqeDPXOXXMyyOo78TgMzsaRPoRQ7PffJhZuPmD8XKXz6KDaKw=
X-Google-Smtp-Source: AGHT+IHLtfiZv3zhPfytIBJAweL1MBhjeajwYmXHFLBYFEydLENCH/5+XTQ0AiXTN+fjkLLxWMOr/wqjKPU6YlTMfp0FVgeHvUTJ
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d5:b0:809:b914:a53a with SMTP id
 ca18e2360f4ac-81fd42b997emr30452039f.0.1722813362094; Sun, 04 Aug 2024
 16:16:02 -0700 (PDT)
Date: Sun, 04 Aug 2024 16:16:02 -0700
In-Reply-To: <0000000000004385ec06198753f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076525c061ee3be52@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
From: syzbot <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, dai.ngo@oracle.com, 
	jlayton@kernel.org, kolga@netapp.com, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, lorenzo@kernel.org, neilb@suse.de, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 16a471177496c8e04a9793812c187a2c1a2192fa
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Tue Apr 23 13:25:44 2024 +0000

    NFSD: add listener-{set,get} netlink command

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16af38d3980000
start commit:   ee78a17615ad Add linux-next specific files for 20240606
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15af38d3980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11af38d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8c69ee180de0793
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e76d963f757db40f91
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173f2eac980000

Reported-by: syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com
Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

