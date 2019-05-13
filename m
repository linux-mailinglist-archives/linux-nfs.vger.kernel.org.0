Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00061B081
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2019 08:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfEMGtt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 May 2019 02:49:49 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34454 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbfEMGtt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 May 2019 02:49:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TRZiBTY_1557730186;
Received: from ali-186590dcce93-2.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TRZiBTY_1557730186)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 May 2019 14:49:46 +0800
To:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, caspar@linux.alibaba.com
From:   Yihao Wu <wuyihao@linux.alibaba.com>
Subject: [PATCH v2 0/2] Fix two bugs CB_NOTIFY_LOCK failing to wake a water
Message-ID: <346806ac-2018-b780-4939-87f29648017c@linux.alibaba.com>
Date:   Mon, 13 May 2019 14:49:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch set fix bugs related to CB_NOTIFY_LOCK. These bugs cause
poor performance in locking operation. And this patchset should also fix
the failure when running xfstests generic/089 on a NFSv4.1 filesystem.

Yihao Wu (2):
  NFSv4.1: Again fix a race where CB_NOTIFY_LOCK fails to wake a waiter
  NFSv4.1: Fix bug only first CB_NOTIFY_LOCK is handled

 fs/nfs/nfs4proc.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

-- 
1.8.3.1
