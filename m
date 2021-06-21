Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1894F3AF8B7
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jun 2021 00:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhFUWoP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 18:44:15 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:53042 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhFUWoP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 18:44:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1716254|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.153505-0.00121214-0.845283;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KVuc6qQ_1624315318;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KVuc6qQ_1624315318)
          by smtp.aliyun-inc.com(10.147.44.129);
          Tue, 22 Jun 2021 06:41:58 +0800
Date:   Tue, 22 Jun 2021 06:41:58 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "Frank Filz" <ffilzlnx@mindspring.com>
Subject: Re: any idea about auto export multiple btrfs snapshots?
Cc:     "'NeilBrown'" <neilb@suse.de>, <linux-nfs@vger.kernel.org>
In-Reply-To: <001901d766c5$cf427af0$6dc770d0$@mindspring.com>
References: <20210621225541.3CEB.409509F4@e16-tech.com> <001901d766c5$cf427af0$6dc770d0$@mindspring.com>
Message-Id: <20210622064158.98CA.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> 
> OK thanks for the information. I think they will just work in nfs-ganesha as
> long as the snapshots or subvols are mounted within an nfs-ganesha export or
> are exported explicitly. nfs-ganesha has the equivalent of knfsd's
> nohide/crossmnt options and when nfs-ganesha detects crossing a filesystem
> boundary will lookup the filesystem via getmntend and listing btrfs subvols
> and then expose that filesystem (via the fsid attribute) to the clients
> where at least the Linux nfs client will detect a filesystem boundary and
> create a new mount entry for it.


Not only exported explicitly, but also kept in the same hierarchy.

If we export 
/mnt/test		#the btrfs
/mnt/test/sub1	# the btrfs subvol 1
/mnt/test/sub2	# the btrfs subvol 2

we need to make sure we will not access '/mnt/test/sub1' through '/mnt/test'
from nfs client.

current safe export:
#/mnt/test		#the btrfs, not exported
/mnt/test/sub1	# the btrfs subvol 1
/mnt/test/sub2	# the btrfs subvol 2


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/22


