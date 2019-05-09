Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0982183E1
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2019 04:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEICqB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 22:46:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55694 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEICqB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 May 2019 22:46:01 -0400
Received: by mail-io1-f72.google.com with SMTP id v11so638201ion.22
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2019 19:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t+LnHVTlAHrwSUZToYSE0usv9aUEGmgN35Wv7GBtso0=;
        b=KD3biM1PipUvXnaonpFomhKy/pAAodwt+8r3nq0AI9cBAopAVNBEAuqtrlGtpAaUWO
         z7mZfW9AsDo3227dJwKjAcJTxA64E3JkAlT+j73yEWB1lHqOegU1+xvf8pbTR5Zvw1ON
         SWfIQiORoFoXmJ/gYGFvAIZlL+fA9dWyr+1HSoJoaJLyrjpqycmpvcs544pgVlFgGNRs
         DaqZJmq9KVrXEa/NJHHTnymn8jr0kzicj3/mnDC6/6c/NCTY7lYo9QAQ7Iy3npJPhy1F
         2zWCN3Km6amyWwMV8dHNbQrXOL1GCCiXZFNO6ExWmoBMkTR3C/gOPYVm3w3UNHJcUWRQ
         lsNw==
X-Gm-Message-State: APjAAAXi9zYo4bl8WnbvY4ebdi/bNV4U0smYaBZwa19yzQI+r9mjm/FS
        Mzzjdwxa5tCzI2iI1+0dexMfe3aspcNvvNQ11B/GLoWCXa8a
X-Google-Smtp-Source: APXvYqwPDePWWmUVjjlYHBlu+L9U/cbg7vrQRey6SZG7pdn+3I3dif76UNV96Al+d/pDP6Q+cln4wd8CUO1OkuzLR5URUAXhuLE3
MIME-Version: 1.0
X-Received: by 2002:a5d:914e:: with SMTP id y14mr1045110ioq.77.1557369960910;
 Wed, 08 May 2019 19:46:00 -0700 (PDT)
Date:   Wed, 08 May 2019 19:46:00 -0700
In-Reply-To: <000000000000c3e9dc0588695e22@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004dd97205886b7337@google.com>
Subject: Re: WARNING: locking bug in nfs_get_client
From:   syzbot <syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com>
To:     anna.schumaker@netapp.com, bcodding@redhat.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        rbergant@redhat.com, syzkaller-bugs@googlegroups.com,
        trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

syzbot has bisected this bug to:

commit 950a578c6128c2886e295b9c7ecb0b6b22fcc92b
Author: Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Thu Apr 25 13:36:51 2019 +0000

     NFS: make nfs_match_client killable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e40aaca00000
start commit:   31ccad9b Add linux-next specific files for 20190508
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13e40aaca00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15e40aaca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63cd766601c6c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=228a82b263b5da91883d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140fdce8a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134dce02a00000

Reported-by: syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com
Fixes: 950a578c6128 ("NFS: make nfs_match_client killable")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
