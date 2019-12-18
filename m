Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2EE124F34
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 18:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLRRY7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 12:24:59 -0500
Received: from fieldses.org ([173.255.197.46]:37590 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfLRRY7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Dec 2019 12:24:59 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id AE7E81C24; Wed, 18 Dec 2019 12:24:58 -0500 (EST)
Date:   Wed, 18 Dec 2019 12:24:58 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Subject: Re: [PATCH v2 00/12] nfsd: avoid 32-bit time_t
Message-ID: <20191218172458.GA24295@fieldses.org>
References: <20191213141046.1770441-1-arnd@arndb.de>
 <CAK8P3a11e1OsP+KR5rYPyYo_nMz=y2_fqb6ZCmaQ_RUFcoEkrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a11e1OsP+KR5rYPyYo_nMz=y2_fqb6ZCmaQ_RUFcoEkrQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 18, 2019 at 06:21:06PM +0100, Arnd Bergmann wrote:
> On Fri, Dec 13, 2019 at 3:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Hi Bruce, Chuck,
> >
> > NFSd is one of the last areas of the kernel that is not y2038 safe
> > yet, this series addresses the remaining issues here.
> >
> > I did not get any comments for the first version I posted [1], and
> > I hope this just means that everything was fine and you plan to
> > merge this soon ;-)
> >
> > I uploaded a git branch to [2] for testing.
> >
> > Please review and merge for linux-5.6 so we can remove the 32-bit
> > time handling from that release.
> 
> I've included the update y2038 nfsd branch from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-nfsd-v2
> 
> in my y2038 branch now, so it should be part of linux-next from the coming
> snapshot. My plan is to send a linux-5.6 pull request to the nfsd
> maintainers for
> this branch unless we find bugs in linux-next or I get more review comments.

Sorry for the silence.  The patches look fine to me, so I took them from
your git branch and applied them to my local tree (after fixing up some
minor conflicts with the copy patches) and then saw some
delegation-related test failures, which I haven't had the chance to
investigate yet.  Hopefully before the end of the week.

--b.
