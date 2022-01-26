Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFCB49CE34
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 16:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbiAZP3q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 10:29:46 -0500
Received: from mta-102a.oxsus-vadesecure.net ([51.81.61.66]:50035 "EHLO
        nmtao102.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236282AbiAZP3p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 10:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; bh=yWIPBjc/ayFOp93Cwz9DigadpSLQ2JBCspo6Ne
 84kdI=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1643210983;
 x=1643815783; b=jSPMGqKRLGwHGOxypYMvG0E9w2AGhWXhZYUDmEWW9w97ZVVZ35FSrDU
 yQBc18nTbDq/1sLp99NiuPpqO/UfoUNkS9dROjcsJlGyPU8BdO/CelPxjkBYbqnwBeZWns+
 zSO60FZzKosOqDEMrGZDjuWLCyJp2SNCAWtSjVzh3TtTTb2WX9izPRXKfAMfRZWThoykcXc
 ttHuUoVT/9Euk5U87ALOXrAUk0HfzUB34rHwy10erVvNCGt1gSGltLBQ8MqUYrPfxVTqtyj
 BOrgxNNY3b4qEQvporFCZnhJWs18PyYnPjXuFDBfCXLibC4u59OJGydOH7Td3kA/MfxKRRx
 Vfw==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao02p with ngmta
 id be366a9f-16cddbaed22bb2a2; Wed, 26 Jan 2022 15:29:43 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Volodymyr Khomenko'" <volodymyr@vastdata.com>
Cc:     <linux-nfs@vger.kernel.org>
References: <CANkgwes_79iE9MGvzGu_tLjNVZprTjTMNzohADRU6pw4Z3xC_w@mail.gmail.com> <20220126141053.GA29832@fieldses.org>
In-Reply-To: <20220126141053.GA29832@fieldses.org>
Subject: RE: [PATCH] pynfs minor: fixed Environment._maketree to use proper stateid during file write
Date:   Wed, 26 Jan 2022 07:29:43 -0800
Message-ID: <0bc601d812c9$8b52b750$a1f825f0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQIVDtIiHTx/S/b9xSLpXT6P8f1wowI/AdUDq+l8q6A=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Fri, Jan 21, 2022 at 03:06:57PM +0200, Volodymyr Khomenko wrote:
> >
> 
> > From 63c0711f9cd8f8c0aaff7d0116a42b5001bddcd2 Mon Sep 17 00:00:00
> 2001
> > From: Volodymyr Khomenko <Khomenko.Volodymyr@gmail.com>
> > Date: Fri, 21 Jan 2022 14:52:28 +0200
> > Subject: [PATCH] Minor: fixed Environment._maketree (used by init) to
> > use  proper stateid during file write
> >
> > _maketree is a part of generic init sequence for server41tests so the
code
> should be generic.
> > Using zero stateid (when "other" and "seqid" are both zero, the
> > stateid is treated as a special anonymous stateid) is a special
> > use-case of anonymous access so it must not be used during generic
> initialization.
> 
> OK, applying, but I'm a little wary.  If a server isn't accepting the zero
stateid
> here then I think that's a server bug.

Yea, that makes me nervous about a server bug also. Maybe we should have
explicit special stateid tests.

It's always tricky because initialization of the tree requires a bunch of
stuff to work before it's explicitly tested...

Frank

> > Signed-off-by: Volodymyr Khomenko <Khomenko.Volodymyr@gmail.com>
> > ---
> >  nfs4.1/server41tests/environment.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/nfs4.1/server41tests/environment.py
> > b/nfs4.1/server41tests/environment.py
> > index 14b0902..0b7c976 100644
> > --- a/nfs4.1/server41tests/environment.py
> > +++ b/nfs4.1/server41tests/environment.py
> > @@ -198,7 +198,7 @@ class Environment(testmod.Environment):
> >                  log.warning("could not create /%s" % b'/'.join(path))
> >          # Make file-object in /tree
> >          fh, stateid = create_confirm(sess, b'maketree', tree +
[b'file'])
> > -        res = write_file(sess, fh, self.filedata)
> > +        res = write_file(sess, fh, self.filedata, stateid=stateid)
> >          check(res, msg="Writing data to /%s/file" % b'/'.join(tree))
> >          res = close_file(sess, fh, stateid)
> >          check(res)
> > --
> > 2.25.1
> >

