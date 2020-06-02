Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C031EC34E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2020 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgFBUAQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jun 2020 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBUAQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Jun 2020 16:00:16 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F421DC08C5C0
        for <linux-nfs@vger.kernel.org>; Tue,  2 Jun 2020 13:00:15 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 784F436E1; Tue,  2 Jun 2020 16:00:14 -0400 (EDT)
Date:   Tue, 2 Jun 2020 16:00:14 -0400
To:     "Su, Yanjun" <suyj.fnst@cn.fujitsu.com>
Cc:     "bfields@redhat.com" <bfields@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "mora@netapp.com" <mora@netapp.com>
Subject: Re: Re: [About] about nfscache problem
Message-ID: <20200602200014.GD1769@fieldses.org>
References: <694b44377eae4adca7273de471807be7@G08CNEXMBPEKD05.g08.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694b44377eae4adca7273de471807be7@G08CNEXMBPEKD05.g08.fujitsu.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 02, 2020 at 12:50:43AM +0000, Su, Yanjun wrote:
> >On Thu, May 28, 2020 at 07:18:31AM +0000, Su, Yanjun wrote:
> >> This patch adds compatible code for nfsv3 and nfsv4.
> 
> >> When we test nfsv4, just use 'chmod' to recall delegation, then
> 
> >> run the test. As 'chmod' will modify atime, so use 'noatime' mount option.
> 
> >So, you patch nfstest as below, then run the test, and the test fails?
> 
> It tests ok when appling the patch.

So you're just asking that this patch be applied to nfstest?

Sorry, I don't think I can help.

--b.

> > Signed-off-by: Su Yanjun <suyj.fnst@xxxxxxxxxxxxxx><mailto:%3Csuyj.fnst@xxxxxxxxxxxxxx%3E>
> 
> > ---
> 
> > test/nfstest_cache | 12 +++++++++++-
> 
> > 1 file changed, 11 insertions(+), 1 deletion(-)
> 
> >
> 
> > diff --git a/test/nfstest_cache b/test/nfstest_cache
> 
> > index 0838418..a31d48f 100755
> 
> > --- a/test/nfstest_cache
> 
> > +++ b/test/nfstest_cache
> 
> > @@ -165,8 +165,13 @@ class CacheTest(TestUtil):
> 
> > fd = None
> 
> > attr = 'data' if data_cache else 'attribute'
> 
> > header = "Verify consistency of %s caching with %s on a file" % (attr,
> 
> > self.nfsstr())
> 
> > +
> 
> > # Mount options
> 
> > - mtopts = "hard,intr,rsize=4096,wsize=4096"
> 
> > + if self.nfsversion >= 4:
> 
> > + mtopts = "noatime,hard,intr,rsize=4096,wsize=4096"
> 
> > + else: + mtopts = "hard,intr,rsize=4096,wsize=4096"
> 
> > +
> 
> > if actimeo:
> 
> > header += " actimeo = %d" % actimeo
> 
> > mtopts += ",actimeo=%d" % actimeo
> 
> > @@ -216,6 +221,11 @@ class CacheTest(TestUtil):
> 
> > if fstat.st_size != dlen:
> 
> > raise Exception("Size of newly created file is %d, should have been %d"
> 
> > %(fstat.st_size, dlen))
> 
> > + if self.nfsversion >= 4:
> 
> > + # revoke delegation
> 
> > + self.dprint('DBG3', "revoke delegation")
> 
> > + self.clientobj.run_cmd('chmod +x %s' % self.absfile)
> 
> > +
> 
> > if acregmax:
> 
> > # Stat the unchanging file until acregmax is hit
> 
> > # each stat doubles the valid cache time
> 
> >
> 
> >
> 
> 
> 
