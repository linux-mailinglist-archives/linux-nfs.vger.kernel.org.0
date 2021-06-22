Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F433B1036
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jun 2021 00:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFVWu6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Jun 2021 18:50:58 -0400
Received: from out20-49.mail.aliyun.com ([115.124.20.49]:56917 "EHLO
        out20-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhFVWu6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Jun 2021 18:50:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04515028|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0139422-0.00183774-0.98422;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.KWS3tMs_1624402119;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KWS3tMs_1624402119)
          by smtp.aliyun-inc.com(10.147.41.187);
          Wed, 23 Jun 2021 06:48:40 +0800
Date:   Wed, 23 Jun 2021 06:48:41 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Frank Filz <ffilz@redhat.com>
Subject: Re: any idea about auto export multiple btrfs snapshots?
Cc:     Frank Filz <ffilzlnx@mindspring.com>, 'NeilBrown' <neilb@suse.de>,
        linux-nfs@vger.kernel.org
In-Reply-To: <f2581d9f-dfe4-3280-80de-31683c9e647d@redhat.com>
References: <20210622064158.98CA.409509F4@e16-tech.com> <f2581d9f-dfe4-3280-80de-31683c9e647d@redhat.com>
Message-Id: <20210623064840.ABD8.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> On 6/21/21 3:41 PM, Wang Yugui wrote:
> > Hi,
> >
> >> OK thanks for the information. I think they will just work in nfs-ganesha as
> >> long as the snapshots or subvols are mounted within an nfs-ganesha export or
> >> are exported explicitly. nfs-ganesha has the equivalent of knfsd's
> >> nohide/crossmnt options and when nfs-ganesha detects crossing a filesystem
> >> boundary will lookup the filesystem via getmntend and listing btrfs subvols
> >> and then expose that filesystem (via the fsid attribute) to the clients
> >> where at least the Linux nfs client will detect a filesystem boundary and
> >> create a new mount entry for it.
> >
> > Not only exported explicitly, but also kept in the same hierarchy.
> >
> > If we export
> > /mnt/test		#the btrfs
> > /mnt/test/sub1	# the btrfs subvol 1
> > /mnt/test/sub2	# the btrfs subvol 2
> >
> > we need to make sure we will not access '/mnt/test/sub1' through '/mnt/test'
> > from nfs client.
> >
> > current safe export:
> > #/mnt/test		#the btrfs, not exported
> > /mnt/test/sub1	# the btrfs subvol 1
> > /mnt/test/sub2	# the btrfs subvol 2
> >
> 
> What's the problem with exporting /mnt/test AND then exporting sub1 and sub2 as crossmnt exports? As far as I can tell, that seems to work just fine with nfs-ganesha.

I'm not sure what will happen on nfs-ganesha.

crossmnt(kernel nfsd) failed to work when exporting /mnt/test,/mnt/test/sub1,
/mnt/test/sub2.

# /bin/find /nfs/test/
/nfs/test/
find: File system loop detected; ¡®/nfs/test/sub1¡¯ is part of the same file system loop as ¡®/nfs/test/¡¯.
/nfs/test/.snapshot
find: File system loop detected; ¡®/nfs/test/.snapshot/sub1-s1¡¯ is part of the same file system loop as ¡®/nfs/test/¡¯.
find: File system loop detected; ¡®/nfs/test/.snapshot/sub2-s1¡¯ is part of the same file system loop as ¡®/nfs/test/¡¯.
/nfs/test/dir1
/nfs/test/dir1/a.txt
find: File system loop detected; ¡®/nfs/test/sub2¡¯ is part of the same file system loop as ¡®/nfs/test/¡¯

/bin/find report 'File system loop detected', it means that vfs cache(
based on st_dev + st_ino?) on nfs client side will have some problem?

In fact, I was exporting /mnt/test  for years too.
but btrfs subvols means multiple filesystems(different st_dev),  in theory, we
needs to use it based on nfs crossmnt.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/23

