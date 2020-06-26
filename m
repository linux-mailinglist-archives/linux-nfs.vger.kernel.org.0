Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF3420B62C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgFZQr2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 12:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgFZQr2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 12:47:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E1C03E979;
        Fri, 26 Jun 2020 09:47:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 52F92879E; Fri, 26 Jun 2020 12:47:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 52F92879E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593190047;
        bh=aPpev6+jbpMjykTXQYkoFzkRvxyLE0DzAEOYxd8rSiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQ7eCI8VvZx5C558KfIaB1SEBm2kT5+g8WAks5U1BkF+e8Ug1ZPeK0J0/UAGpVtvB
         +1k/uOO7Qz8/iuJZyz7BZZHHq3e1G4xlhf+9ch3aNUeYLzj/Ky3iev+kj3yaQtlbR2
         DiOGzvPQ9EWdDEhat+BWw5GAmOJbTJPHEaFn/PwY=
Date:   Fri, 26 Jun 2020 12:47:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0e37e9d19bded16b8ab9@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, LKML <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: unable to handle kernel paging request in rb_erase
Message-ID: <20200626164727.GB3565@fieldses.org>
References: <0000000000005016dd05a5e6b308@google.com>
 <20200603043435.13820-1-hdanton@sina.com>
 <20200603144326.GA2035@fieldses.org>
 <20200604035359.2516-1-hdanton@sina.com>
 <20200604215812.GC3458@fieldses.org>
 <20200625210229.GE6605@fieldses.org>
 <CACT4Y+b_byN4xT+-42M6XtHv=QKRrgD2aSH+Hd0CDJ=v+OYWPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b_byN4xT+-42M6XtHv=QKRrgD2aSH+Hd0CDJ=v+OYWPA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 26, 2020 at 12:32:42PM +0200, Dmitry Vyukov wrote:
> So far this crash happened only once:
> https://syzkaller.appspot.com/bug?extid=0e37e9d19bded16b8ab9
> 
> For continuous fuzzing on syzbot it usually means either (1) it's a
> super narrow race or (2) it's a previous unnoticed memory corruption.
> 
> Simpler bugs usually have much higher hit counts:
> https://syzkaller.appspot.com/upstream
> https://syzkaller.appspot.com/upstream/fixed
> 
> If you did a reasonable looking for any obvious bugs in the code that
> would lead to such failure, it can make sense to postpone any
> additional actions until we have more info.
> If no info comes, at some point syzbot will auto-obsolete it, and then
> then we can assume it was (2).

OK, thanks.

It's a big heavily used data structure, if there was random memory
corruption then I guess this wouldn't be a surprising way for it to show
up.

--b.
