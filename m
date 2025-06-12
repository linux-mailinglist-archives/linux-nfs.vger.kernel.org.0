Return-Path: <linux-nfs+bounces-12396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C6EAD7DA7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 23:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5607A6627
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F109F2DCC09;
	Thu, 12 Jun 2025 21:38:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7C214225
	for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764289; cv=none; b=NmsjaFM918n9N3KLM6exef1pOhrHke10NVhOgyZjMj60mRab0x+m3Rt7IVQ3GObBdJNOFwhiU1CYnb2Ckx5IOlmweUMCLYpEM6eBWtUdeLT2kSTR9FHpT0w/wRn7Rm06a1U2fycolPBnTTEMXcYX5o+G5Ww5kcfY5GvL/aR5Q5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764289; c=relaxed/simple;
	bh=ghXJGWovtlevUxhJ6b02bvIr70MGxHrQEahbVyzbrUc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ckIZqW7yEaOtd6xeoSIT2bkJq4xRo+xeN6+2Tb7fnZXUe7cbydSnvCj+50/jLiA9lUzkNWS8lhtoR1XA52GqRNXmUV4+E5iOtFvuE3BhfLZ3G8WMSEOmvibyF9YexEmGQnwTZ8Pi5gpcaV5QVPwEYD1iWqvAOUEY7e8I3lS8voE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddcb80387dso14808275ab.1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 14:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749764286; x=1750369086;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEPUJZD4frWaLI++xX7CIld0+KosWT7GVS1O1Tac6wg=;
        b=Xjs/sqiyRlJFwDTaBYDscNomkpa4Qsrrb0qRuRDLF07E8pXIIwssK0nx1lrL2IM2Yy
         QIwvz58QpAdX06jKnPy/RTPqRCdhVn2trQA+CApDoUrK5K5l7vqJBwhaREAWEKyX0OLD
         kn5DXdGNv95n5PxPC4G2gKHtLx/zi7HopAoL3NIjbvEL50A8RcT+q+c5xaoNW8/arVx6
         WwCy0yzK2xEAPmkDGov/rWA5LGUVxrC6WIodedhkUFW7PvWuXKSVIw4PcUFbCtQrraoq
         C2VJOYbyLMhY3LsCQFuLWTPGq5JTQPW9jpL6vSAsd+/pWOUGu4a/w/FPN3r3vdvBcHjE
         jccQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2yNDdoLCNBoU1uuy+lJjxOj8SG0t7YSJVu6fQn7Z60bdb+UkkA/BA78kPkKMaG54zLK/ikFTJGT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsFpR/mwhIEaZQVi6vPoaaIwcYLe5NXC7u8uKdb8yX5tcL12S
	uriG4CMyxel/MT6IphKm3IafOuIklDRKTwNuwcIbCNs3bKZLC4zaAStx2J/oorGhKgRPyC/t0wz
	VhTCG66TmqB9BlROXksXXOrcQTN4SN8gho8XmC4bah1h5dnzNFnK6Kfb+GPc=
X-Google-Smtp-Source: AGHT+IF+g3z+jimjn66TfaQax+CXm+mlRYr8TXr4NCKN/KCdEPYOvVhC6OITFg0tBDAXeokvhpFRmFoDLM7MgO8PxvmHpu81LDA7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3605:b0:3dd:b540:b795 with SMTP id
 e9e14a558f8ab-3de0167404dmr1585665ab.3.1749764286354; Thu, 12 Jun 2025
 14:38:06 -0700 (PDT)
Date: Thu, 12 Jun 2025 14:38:06 -0700
In-Reply-To: <20250612211610.4129612-1-kuni1840@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684b48be.050a0220.be214.0292.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfs?] WARNING in remove_proc_entry (8)
From: syzbot <syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com>
To: anna@kernel.org, chuck.lever@oracle.com, dai.ngo@oracle.com, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jlayton@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neil@brown.name, 
	netdev@vger.kernel.org, okorniev@redhat.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com, trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com
Tested-by: syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com

Tested on:

commit:         27605c8c Merge tag 'net-6.16-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1033d9d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4c8362784bb7796
dashboard link: https://syzkaller.appspot.com/bug?extid=a4cc4ac22daa4a71b87c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1143d9d4580000

Note: testing is done by a robot and is best-effort only.

