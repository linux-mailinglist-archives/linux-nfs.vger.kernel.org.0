Return-Path: <linux-nfs+bounces-10552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE3CA5C9E3
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 16:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D393A5D16
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C43126157C;
	Tue, 11 Mar 2025 15:56:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66C25F97F
	for <linux-nfs@vger.kernel.org>; Tue, 11 Mar 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708568; cv=none; b=KYlARgKFqFuEOZPEcEChaBqco9GqIHgSUx59p+j1HcWxe4k3VzntuQ3UpQdryxjQXyug79ixId0jVzGzzzsVsnnlnCC4fmQt/u0gOqMvQRvpVnzEG1zC46RuYzM5FiGbTkJdXQbFiJkJY5M5Bg6ITT+ZxlPiyQOQdWooI7EAUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708568; c=relaxed/simple;
	bh=sc10Pl/zyyF8BPF2JK1mZI7HV2hkrXbUl05fR/5+oFc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oJhkkqHi+LVoT7UWyet4d4kIQaaSCFaicZ6KJcp938V3SrAxeuIIdtkn3yeWsqH87Njou3dvgDvkJvQWb2MX83NLPbc2bXM9CSPOtctQnMnyzMUoNWO4Tn+JjQpEeMc8iwwOi0cMYwScOwmq1yz2EHplmiT14ojAF1McgPxoe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85aec8c9633so1156680639f.0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Mar 2025 08:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708565; x=1742313365;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRrgZHOV3bUp6D7hSoq5Vx4W3eVh7jENoQ0JRVmYyRo=;
        b=pNw6V2V1QmiYGbVI5jOZ0ywxZXiYKx7hIobBVRnYuHUx8BJ3Q+CcKQYOKkhRwpR5Uc
         nMVJlu9ePO1wAMS4kWMSAQYUZMcrSPoFtDMhesUU2jcJikkE6KnS3IedRJaBYz64Ngxe
         Z7Dg9SXCqc4CXjUo2LtxGAWSrRJ9Kaj2mMxZUAWkCbh/mO9EDFHjB74UI5H8c1KIiCvz
         Lc0qG5L9QfOo5ZSlKD9Xsv+M1iwvczhgH5Twe0+f3piYovyPOTK3lPwuZ2rWKBS95U3f
         wtvAkJB537caZsgqv3nwLwiIQOfW7N4bFGKfB4YP906Njj9GdYlCEIwhw4Rg/n9OujKe
         bJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWWE1JJUw2ltfrDS5beKRr45pt5aRjqAnu+aB9KXYv7VPhjLqSxkW2maWwpzf75zKwx3BqhQjGRTKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoWA4N/Z0vds5vpqAAjF7C0wbpnNwrAAgfLAGKGL//jdfzP0jZ
	KxIAUUhGbeG7IPVSrdRRoE4fYPAoC1xl5clI5tGkAkA2zUz0F0g67w2ZLqmfwwiYZuH13Ia6zfi
	xpoLkeHjDaT0Fzuzt+8F9VXlPlrut84GOhCw7FmCbwoe55dUuGPLCqCQ=
X-Google-Smtp-Source: AGHT+IHxXFdrlN/sWn5qmnyi6aWSNe1Tfz8GvTH5kIuQ4yiObhgacWvV92BKVdx3Qc4jr17Dky5O7qoBZ1EQgvO7cpheIb/kTS5Z
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:3d4:244b:db20 with SMTP id
 e9e14a558f8ab-3d4419296b0mr188445365ab.16.1741708565295; Tue, 11 Mar 2025
 08:56:05 -0700 (PDT)
Date: Tue, 11 Mar 2025 08:56:05 -0700
In-Reply-To: <000000000000ba5cfd0609d55c40@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d05d15.050a0220.1939a6.001a.GAE@google.com>
Subject: Re: [syzbot] [tipc?] [nfs?] INFO: rcu detected stall in sys_unshare (9)
From: syzbot <syzbot+872bccd9a68c6ba47718@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, bristot@kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, jmaloy@redhat.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, juri.lelli@redhat.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, vineeth@bitbyteword.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176de7a8580000
start commit:   45ec2f5f6ed3 Merge tag 'mtd/fixes-for-6.8-rc7' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b890ca180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154fbfe2180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/rt: Remove default bandwidth control

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

