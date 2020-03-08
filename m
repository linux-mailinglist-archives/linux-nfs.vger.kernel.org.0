Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90AD17D549
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Mar 2020 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCHRrQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Mar 2020 13:47:16 -0400
Received: from mailomta1-re.btinternet.com ([213.120.69.94]:26788 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgCHRrQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Mar 2020 13:47:16 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200308174713.YAF16865.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sun, 8 Mar 2020 17:47:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1583689633; 
        bh=MgatK+4FHcWh3IlaOJnDEIMpRwe8HhketPCBA2Zzp+o=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=GbeFN2nEpHxB+7YbuGEM+WJT0PDRuxjaI/Gyl+dTnp4n04m6mUFM7sMcnWmFTs7iRW9uqL1Hv3tkUZTilbcLs0lkuSEnF+nlmOYpSUEfgMTeWhP7bCRGGbOnptF0oqVCBCKJe150OULlxRz/5RXlrpO1rpfotmSG3F6qphlgrZZQYzVQJbtWTIotVSc2nrs5vDl5y+KI425qdKp6I6fM/AGobI7wWozO47RYHVI6tPnWC4qR2qQ5I7R73FaByApDtSyfny4REXgueKjEv4yzB5P3jTdFFqL0PpRszN8dufpVnnafITwHc+CwKJ9ZptrjTeHNcGfrG3I0GAIrMNQ1+A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.51.79.181]
X-OWM-Source-IP: 31.51.79.181 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrudduiedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepfedurdehuddrjeelrddukedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurdejledrudekuddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegrnhhnrgdrshgthhhumhgrkhgvrhesnhgvthgrphhprdgtohhmqedprhgtphhtthhopeeosghfihgvlhgushesfhhivghlughsvghsrdhorhhgqedprhgtphhtthhopeeolhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgr
        ihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhmrgihhhgvfiesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeoshhtvghphhgvnhdrshhmrghllhgvhidrfihorhhksehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeothhrohhnugdrmhihkhhlvggsuhhstheshhgrmhhmvghrshhprggtvgdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.79.181) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A16DE04FEE9DA; Sun, 8 Mar 2020 17:47:13 +0000
Message-ID: <dc704637496883ac7c21c196aeae4e1ab37f76fa.camel@btinternet.com>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@fieldses.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-nfs@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Date:   Sun, 08 Mar 2020 17:47:07 +0000
In-Reply-To: <20200306220132.GD3175@aion.usersys.redhat.com>
References: <20200303225837.1557210-1-smayhew@redhat.com>
         <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
         <20200304143701.GB3175@aion.usersys.redhat.com>
         <CAEjxPJ7A1KRJ3+o0-edW3byYBSjGa7=KnU5QaYCiVt6Lq6ZfpA@mail.gmail.com>
         <20200306220132.GD3175@aion.usersys.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2020-03-06 at 17:01 -0500, Scott Mayhew wrote:
> On Wed, 04 Mar 2020, Stephen Smalley wrote:
> 
> > On Wed, Mar 4, 2020 at 9:37 AM Scott Mayhew <smayhew@redhat.com>
> > wrote:
> > > On Wed, 04 Mar 2020, Richard Haines wrote:
> > > > I built and tested this patch on selinux-next (note that the
> > > > NFS module
> > > > is a few patches behind).
> > > > The unlabeled problem is solved, however using:
> > > > 
> > > > mount -t nfs -o
> > > > vers=4.2,rootcontext=system_u:object_r:test_filesystem_file_t:s
> > > > 0
> > > > localhost:$TESTDIR /mnt/selinux-testsuite
> > > > 
> > > > I get the message:
> > > >     mount.nfs: an incorrect mount option was specified
> > > > with a log entry:
> > > >     SELinux: mount invalid.  Same superblock, different
> > > > security
> > > > settings for (dev 0:42, type nfs)
> > > > 
> > > > If I use "fscontext=" instead then works okay. Using no context
> > > > option
> > > > also works. I guess the rootcontext= option should still work
> > > > ???
> > > 
> > > Thanks for testing.  It definitely wasn't my intention to break
> > > anything, so I'll look into it.
> > 
> > I'm not sure that rootcontext= should be supported or is
> > supportable
> > over labeled NFS.
> 
> Should rootcontext= be supported for NFS versions < 4.2?  If not then
> maybe it that option should be rejected for nfs and nfs4 fstypes in
> selinux_set_mnt_opts().
> 
> > It's primary use case is to allow assigning a specific context
> > other
> > than the default policy-defined one
> > to the root directory for filesystems that support labeling but
> > don't
> > have existing labels on their root
> > directories, e.g. tmpfs mounts.  Even if we set the rootcontext
> > based
> > on rootcontext= during mount(2),
> > it would likely get overridden by subsequent attribute fetches from
> > the server I would think (e.g. it probably
> > already switches to the context from the server after 30 seconds or
> 
> Yes, that's what happens.  If we wanted to retain that behavior
> moving
> forward, then we need to avoid calling nfs_setsecurity() for the root
> inode when the rootcontext= option was used.  To do that, I think
> we'd
> need to add a flag that could be passed back to NFS via the
> set_kern_flags parameter of selinux_set_mnt_opts().
> 
> > so?). As long as the separate context= option
> > continues to work correctly on NFS, I'm not overly concerned about
> > this.
> 
> Yep, the context= option still works.
> > I should note that we are getting similar errors though when trying
> > to
> > specify any context-related
> > mount options on NFS via the new fsconfig(2) system call, see
> > https://github.com/SELinuxProject/selinux-kernel/issues/49
I've done further testing and found that with this patch the
fsconfig(2) problem is also resolved for nfs (provided the rootcontext
is not specified).

> > I don't know if this change in when security_sb_set_mnt_opts() will
> > alter that situation any.
> > 
> > Also, FYI, we have recently made it possible to run the
> > selinux-testsuite without errors within a labeled NFS
> > mount.  If you clone
> > https://github.com/SELinuxProject/selinux-testsuite/ and follow the
> > README.md
> > instructions including the NFS section and run ./tools/nfs.sh, it
> > will
> > export and mount the testsuite directory
> > via labeled NFS over loopback and run all tests that can be
> > supported
> > over NFS, and then runs a few specific
> > tests for context= mount options (but not the other mount options
> > at
> > present).  It still needs some further
> > enhancements as per
> > https://github.com/SELinuxProject/selinux-testsuite/issues/32#issuecomment-582992492
> > but it at least provides some degree of regression testing.
Could you describe how I could test these, also are there any other
SELinux tests that may be useful (with howto's). I'm almost ready to
post another set of RFC test patches, but can add more.

> 
> Thanks.  I ran this a few times and aside from an exportfs bug
> everything passed.  I'll be sure to run this in the future too.
> 
> -Scott
> 

