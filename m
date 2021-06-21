Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF643AEBD6
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFUO57 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 10:57:59 -0400
Received: from out20-61.mail.aliyun.com ([115.124.20.61]:37786 "EHLO
        out20-61.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFUO57 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 10:57:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07265381|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.20121-0.00778115-0.791009;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KVltmq8_1624287340;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KVltmq8_1624287340)
          by smtp.aliyun-inc.com(10.147.42.135);
          Mon, 21 Jun 2021 22:55:41 +0800
Date:   Mon, 21 Jun 2021 22:55:41 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "Frank Filz" <ffilzlnx@mindspring.com>
Subject: Re: any idea about auto export multiple btrfs snapshots?
Cc:     "'NeilBrown'" <neilb@suse.de>, <linux-nfs@vger.kernel.org>
In-Reply-To: <000001d766aa$a16b3470$e4419d50$@mindspring.com>
References: <162425113589.17441.4163890972298681569@noble.neil.brown.name> <000001d766aa$a16b3470$e4419d50$@mindspring.com>
Message-Id: <20210621225541.3CEB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> > I think the problem is that the submount doesn't appear in /proc/mounts.
> > "nfsd_fh()" in nfs-utils needs to be able to map from the uuid for a filesystem to
> > the mount point.  To do this it walks through /proc/mounts checking the uuid of
> > each filesystem.  If a filesystem isn't listed there, it obviously fails.
> > 
> > I guess you could add code to nfs-utils to do whatever "btrfs subvol list" does to
> > make up for the fact that btrfs doesn't register in /proc/mounts.
> > 
> > NeilBrown
> 
> I've been watching this with interest for the nfs-ganesha project. We recently were made aware that we weren't working with btrfs subvols, and I added code so that in addition to using getmntent (essentially /proc/mounts) to populate filesystems, we also scan for btrfs subvols and with that we are able to export subvols. My question is does a snapshot look any different than a subvol? If they show up in the subvol list then we shouldn't need to do anything more for nfs-ganesha, but if there's something else needed to discover them, then we may need additional code in nfs-ganesha. I have not yet had a chance to check out exporting a snapshot yet.

>  My question is does a snapshot look any different than a subvol?

No difference between btrfs subvol and snapshot in theory.

but the btrfs subvol number in product env is usually fixed,
and the btrfs snapshot number is usually dynamic.

For fixed-number btrfs subvol/snapshot, it is OK to put them in the same
hierarchy, and then export all in /etc/exports static, as a walk around.

For dynamic-number btrfs snapshot number, we needs a dynamic way to
export them in nfs.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/21


