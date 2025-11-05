Return-Path: <linux-nfs+bounces-16039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 946BDC34005
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 06:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBA334EB713
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 05:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7077826F476;
	Wed,  5 Nov 2025 05:48:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143026ED54
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762321686; cv=none; b=cZRl4IlavP29aYEs2ZDUaWMjW4vdWpSVIbkDl0GJQG1crKEqnofcJZ19w0QSITd2WApy5lIoLt4lG6J8LysyELsi/n9B3+syCMO4N4WgLR6tnBodQqK5lclSHua5/8FgRGhUoxbXMlcxJ9+PbgbhGydQoFFwWtQH9wLt7D6cLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762321686; c=relaxed/simple;
	bh=GlQIhOpVt8G+BVYMy665LNIo97/TwQy9Ja+ALJ1AUDo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W+yNlQlJBJEHCrZPbY14ZEHesQEzzKscR1QSqAZnVw6TmZa8Rj1PtFW2G44UQOxBjRg145GDpp1CxZhrN8Qtbx24D9CxksEjQncInGv19x0BJM23M7Zgvl0JqEB2gtv31lgK2T4LEZqUKWbduCqE35luYOd6cXB5H67oZ8eET20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940d88b8c15so606292239f.2
        for <linux-nfs@vger.kernel.org>; Tue, 04 Nov 2025 21:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762321683; x=1762926483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4XDLXqrEs29g4qhc4+ZUYTByJ5LUyYE6CBWzXLnGEU=;
        b=bzxpXBRZTu8PfKkruUecyA3msWIJOMC2x2h8hxJfAnQEWvLukLKk3NGe1Iidp7JIlf
         9dLDLc/I4pSN1crCuBu+xSYNOfLJy0ZoouRSJYe0e1C5yXR4mP6/8AB7EqxuKpnIL7XN
         I4hgRX7VXvhMSNaypOBK9x9gcRUqnyayLBgek/xE05TT7ad3lBVB5xyhLwcZuFwaCm7W
         h86UAPu5MDTVT42DtHKFKA4puvoRMkd0L+gXWrvtxenxiwmJ0i3EMs8SouPBCcpwjdu0
         CicISitXdHdKNrd9B7Mj+gOmVDFncUsbKYHC/s2qEQBcK36cPDoQXBpFJWczhzn4E0LH
         jCSg==
X-Forwarded-Encrypted: i=1; AJvYcCU7z5Q2+oHk58KFIu508eD2yrYY5G4TE0AGHy1agkXtHuFnB3g5ZFujf5qExNrl/vPwfQt/GjKCjuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIcS/NuMHtVApVodFoVgqdZXLLfwKukOE1uw5GbwWd1OvuYfX
	Da9ZTq2HmD6EdZoL65ayUZo4PgUkQ5RJNSKvaBEdq0zSIAa0LYwJtrtyPG+sEu/qfeEKPdt3Hbz
	BcWlUP9gJQHMO2hvjqxqGJcbFw/L991uZKkrFgB54LLhwx6czMi9OkryOomI=
X-Google-Smtp-Source: AGHT+IFp+75P9fzMNP6tFwZqfyhcKVqnVaql1CMi2hGDeHUR9fDxpaS8IRIyJ/54rHYeSSnjNRL0DzJ+OpUzQhVJDknW+FXvnEk4
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29c9:b0:945:9f2d:592f with SMTP id
 ca18e2360f4ac-94869ebc957mr295259839f.17.1762321683439; Tue, 04 Nov 2025
 21:48:03 -0800 (PST)
Date: Tue, 04 Nov 2025 21:48:03 -0800
In-Reply-To: <68132c08.050a0220.14dd7d.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ae513.050a0220.baf87.0009.GAE@google.com>
Subject: Re: [syzbot] [nfs?] [netfs?] INFO: task hung in anon_pipe_write
From: syzbot <syzbot+ef2c1c404cbcbcc66453@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, idryomov@gmail.com, jack@suse.cz, 
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	m@maowtm.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 290434474c332a2ba9c8499fe699c7f2e1153280
Author: Tingmao Wang <m@maowtm.org>
Date:   Sun Apr 6 16:18:42 2025 +0000

    fs/9p: Refresh metadata in d_revalidate for uncached mode too

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10be532f980000
start commit:   5bc1018675ec Merge tag 'pci-v6.15-fixes-3' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f5bd2a76d9d0b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=ef2c1c404cbcbcc66453
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15631270580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a0b0d4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/9p: Refresh metadata in d_revalidate for uncached mode too

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

