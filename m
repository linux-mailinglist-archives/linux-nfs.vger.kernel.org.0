Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A0018B98C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 15:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCSOj5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 10:39:57 -0400
Received: from fieldses.org ([173.255.197.46]:46684 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgCSOj5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Mar 2020 10:39:57 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id BC0D483B; Thu, 19 Mar 2020 10:39:56 -0400 (EDT)
Date:   Thu, 19 Mar 2020 10:39:56 -0400
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        trond.myklebust@hammerspace.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/13] client side user xattr (RFC8276) support
Message-ID: <20200319143956.GC1546@fieldses.org>
References: <20200311195613.26108-1-fllinden@amazon.com>
 <CAFX2Jf=g2Pv62cnciB4VG6HTndJSrtfeSR_oVu9PmiBez8_Upw@mail.gmail.com>
 <20200317230339.GA3130@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317230339.GA3130@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 17, 2020 at 11:03:39PM +0000, Frank van der Linden wrote:
> On Thu, Mar 12, 2020 at 04:09:51PM -0400, Anna Schumaker wrote:
> > I'm curious if you've tried xfstests with your patches? There are a
> > handful of tests using xattrs that might be good to check with, too:
> > 
> > anna@gouda % grep xattr -l tests/generic/[0-9][0-9][0-9]
> > tests/generic/037
> > tests/generic/062
> > tests/generic/066
> > tests/generic/093
> > tests/generic/117
> > tests/generic/337
> > tests/generic/377
> > tests/generic/403
> > tests/generic/425
> > tests/generic/454
> > tests/generic/489
> > tests/generic/523
> > tests/generic/529
> > tests/generic/556
> > 
> > Thanks,
> > Anna
> 
> I ran did a "check -nfs -g quick" run of xfstests-dev. The following tests
> were applicable to extended attributes:
> 
> generic/020     fail   Doesn't compute MAX_ATTR right for NFS, passes
>                        after fixing that.
> generic/037     pass
> generic/062     fail   It unconditionally expects the "system" and
>                        "trusted" namespaces to be there too, not
>                        easily fixed.
> generic/066     pass
> generic/093     fail   Capabilities use the "security" namespace, can't
>                        work on NFS.
> generic/097     fail   "trusted" namespace explicitly used, can't work
>                        on NFS.
> generic/103     fail   fallocate fails on NFS, not xattr related
> generic/117     pass
> generic/377     fail   Doesn't expect the "system.nfs4acl" attribute to
>                        show up in listxattr.  Can be fixed by filtering
>                        out only "user" namespace xattrs.
> generic/403     fail   Uses the "trusted" namespace, but does not really
>                        need it. Works if converted to the "user" namespace.
> generic/454     pass
> generic/523     pass
> 
> 
> In other words, there were no problems with the patches themselves, but
> xfstests will need some work to work properly.
> 
> I can send a few simple fixes in for xfstests, but a few need a bit more
> work, specifically the ones that expected certain xattr namespaces to be
> there. Right now there is a "_require_attr" check function, that probably
> needs to be split up in to "_require_attr_user, _require_attr_system", etc
> functions, which is a bit more work.

I just took a quick look at common/attr and all I see in _require_attrs
is:

	attr -s "user.xfstests" -V "attr" $TEST_DIR/syscalltest

What am I missing?

--b.
