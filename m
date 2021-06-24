Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EE83B32D1
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhFXPug (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Jun 2021 11:50:36 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33033 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232313AbhFXPuf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Jun 2021 11:50:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UdXlSez_1624549692;
Received: from bogon(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UdXlSez_1624549692)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jun 2021 23:48:14 +0800
Date:   Thu, 24 Jun 2021 23:48:11 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agruenba@redhat.com" <agruenba@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/2] nfs: NFSv3: fix SGID bit dropped when inheriting
 ACLs
Message-ID: <YNSpOw8I/y4p3lmT@bogon>
References: <1624430335-10322-1-git-send-email-hsiangkao@linux.alibaba.com>
 <1624430335-10322-2-git-send-email-hsiangkao@linux.alibaba.com>
 <26c10bd670d4a4672470baf2c30db7af7b7aa593.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26c10bd670d4a4672470baf2c30db7af7b7aa593.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Thu, Jun 24, 2021 at 01:13:50PM +0000, Trond Myklebust wrote:
> On Wed, 2021-06-23 at 14:38 +0800, Gao Xiang wrote:
> > generic/444 fails with NFSv3 as shown above, "
> >      QA output created by 444
> >      drwxrwsr-x
> >     -drwxrwsr-x
> >     +drwxrwxr-x
> > ", which tests "SGID inheritance with default ACLs" fs regression
> > and looks after the following commits:
> > 
> > a3bb2d558752 ("ext4: Don't clear SGID when inheriting ACLs")
> > 073931017b49 ("posix_acl: Clear SGID bit when setting file
> > permissions")
> > 
> > commit 055ffbea0596 ("[PATCH] NFS: Fix handling of the umask when
> > an NFSv3 default acl is present.") sets acls explicitly when
> > when files are created in a directory that has a default ACL.
> > However, after commit a3bb2d558752 and 073931017b49, SGID can be
> > dropped if user is not member of the owning group with
> > set_posix_acl() called.
> > 
> > Since underlayfs will handle ACL inheritance when creating
> > files in a directory that has the default ACL and the umask is
> > supposed to be ignored for such case. Therefore, I think no need
> > to set acls explicitly (to avoid SGID bit cleared) but only apply
> > client umask if the default ACL of the parent directory doesn't
> > exist.
> 
> Hmm... Has this patch been tested with a Solaris server? Your assertion
> above appears to be true for Linux servers, but this code needs to
> interoperate with non-Linux draft posix acl compatible servers too.

Sigh.. I'm not quite sure about the Solaris side since I don't have
the environment. In principle, I just think ACL inheritance should
be an underlayfs behavior rather than some nfs-specific behavior
so I assume no risk with this patch applied.

With my premature short-time glance about illumos nfs client
implementation, I don't find such setacl call  (correct me if
I'm missing...) 
https://github.com/illumos/illumos-gate/blob/9ecd05bdc59e4a1091c51ce68cce2028d5ba6fd1/usr/src/uts/common/fs/nfs/nfs3_vnops.c#L2224

(And if someone has such Solaris environment, it would be much
 helpful to check this...)

> 
> I've already taken the other patch in this series, since that one
> appears correct, and doesn't have any interoperability consequences.

Thanks all!

Thanks,
Gao Xiang

> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
