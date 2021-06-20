Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7ED3ADE49
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Jun 2021 14:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhFTM33 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Jun 2021 08:29:29 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:60932 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhFTM31 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Jun 2021 08:29:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1967406|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.148466-0.00233928-0.849195;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KVAB6Id_1624192033;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KVAB6Id_1624192033)
          by smtp.aliyun-inc.com(10.147.43.230);
          Sun, 20 Jun 2021 20:27:13 +0800
Date:   Sun, 20 Jun 2021 20:27:14 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-Reply-To: <20210618152631.F3DE.409509F4@e16-tech.com>
References: <162397637680.29912.2268876490205517592@noble.neil.brown.name> <20210618152631.F3DE.409509F4@e16-tech.com>
Message-Id: <20210620202713.AE85.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> It seems more fixes are needed.

when compare btrfs subvol with xfs crossmnt, we found out
a new feature difference.

/mnt/test		xfs
/mnt/text/xfs2	 another xfs(crossmnt)
nfsd4_encode_dirent_fattr() report "/mnt/test/xfs2" + "/";


but 
/mnt/test		btrfs
/mnt/test/sub1	 btrfs subvol
nfsd4_encode_dirent_fattr() report "/mnt/test/" + "sub1";

for '/mnt/test/sub1',  nfsd should treat the mountpoint as
'/mn/test/sub1', rather than '/mnt/test'?

I'm sorry that yet no patch is avaliable, kernel source is quite
difficult for me.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/20

