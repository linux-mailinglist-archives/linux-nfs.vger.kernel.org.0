Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD838BBB2
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 03:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbhEUBkT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 21:40:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233904AbhEUBkT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 21:40:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85FF5ABD0;
        Fri, 21 May 2021 01:38:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <SteveD@RedHat.com>
Cc:     "Petr Vorel" <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>
Subject: Re: Re: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
In-reply-to: <289c5819-917a-39a7-9aa4-2a27ae7248c0@RedHat.com>
References: <20210422191803.31511-1-pvorel@suse.cz>,
 <20210422202334.GB25415@fieldses.org>, <YILQip3nAxhpXP9+@pevik>,
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>,
 <162122673178.19062.96081788305923933@noble.neil.brown.name>,
 <289c5819-917a-39a7-9aa4-2a27ae7248c0@RedHat.com>
Date:   Fri, 21 May 2021 11:38:50 +1000
Message-id: <162156113063.19062.9406037279407040033@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 21 May 2021, Steve Dickson wrote:
> Well.... it appears you guys did not compile with the --with-systemd
> config flag... Because if you did you would have seeing this compile error
> the in systemd code: 
> 
> /usr/bin/ld: ../support/nfs/.libs/libnfs.a(cacheio.o): in function `stat':
> /usr/include/sys/stat.h:455: undefined reference to `etab'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:560: nfs-server-generator] Error 1
> make[1]: Leaving directory '/home/src/up/nfs-utils/systemd'
> make: *** [Makefile:479: all-recursive] Error 1
> 
> It turns out the moving of export_test() in to the libexport.a
> is causing any binary linking with libexport.a to have a 
> global definition of struct state_paths etab;
> 
> The reason is export_test() calls qword_add(). Now qword_add()
> does not use an etab, but the file qword_add() lives in is
> cacheio.c which does have a extern struct state_paths etab
> which is the reason libnfs.a(cacheio.o) is mentioned in
> the error. At least that is what I *think* is going on... 
> The extern came from  commit a15bd94.

Thanks for finding and analysis that!  I'd rather fix this "properly" so
we don't more pointless declaration of "etab".  We already have one in
svcgssd.c.

I have two patches which make this problem go away.  I'll post them as a
followup.

Thanks,
NeilBrown
