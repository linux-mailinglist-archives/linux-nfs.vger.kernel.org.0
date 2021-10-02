Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8130841F97C
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Oct 2021 05:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhJBDQD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 23:16:03 -0400
Received: from out20-171.mail.aliyun.com ([115.124.20.171]:50565 "EHLO
        out20-171.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhJBDQC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 23:16:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05779839|-1;BR=01201311R631S71rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00602563-0.000194357-0.99378;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.LTMzpPw_1633144456;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LTMzpPw_1633144456)
          by smtp.aliyun-inc.com(10.147.41.143);
          Sat, 02 Oct 2021 11:14:16 +0800
Date:   Sat, 02 Oct 2021 11:14:19 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org
Subject: a 'Text file busy' case caused by nfs server
Message-Id: <20211002111419.2C83.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

a 'Text file busy' case caused by nfs server.

nfs server: T7610, export /nfs 
	back-end filesystem: btrfs, xfs
nfs client1: T620, mount.nfs4 T7610:/nfs /nfs
nfs client2: T630, mount.nfs4 T7610:/nfs /nfs

linux kernel: 5.10.68, 5.15.0-rc3
	nfs server/client use the same kernel version

The steps to reproduce:
1, nfs client1
	cp /usr/bin/ls /nfs/ls.a
	cat /usr/bin/ls >/nfs/ls.b; chmod a+x /nfs/ls.b
	/nfs/ls.a >/dev/null
	/nfs/ls.b >/dev/null
	It works well.

2, nfs client2 
	/nfs/ls.a >/dev/null
	/nfs/ls.b >/dev/null
	it works well.

3, nfs server
	/nfs/ls.a >/dev/null
		-bash: /nfs/ls.a: Text file busy
		'Text file busy' happen
	/nfs/ls.b >/dev/null
		-bash: /nfs/ls.b: Text file busy
		'Text file busy' happen

	systemctl stop nfs-server.service
	/nfs/ls.a >/dev/null
	/nfs/ls.b >/dev/null
	it works well.

This 'Text file busy' happen when we exec/access the file through the
back-end filesystem directly, not through the nfs client/server.

so this is caused by some file handle(execute attr, and write mode?)
hold by nfs server?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/02


