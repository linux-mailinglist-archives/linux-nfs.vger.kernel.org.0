Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5430581055
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2019 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHECoB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Aug 2019 22:44:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12794 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726666AbfHECoB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Aug 2019 22:44:01 -0400
X-IronPort-AV: E=Sophos;i="5.64,348,1559491200"; 
   d="scan'208";a="72965382"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Aug 2019 10:43:57 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 3BA784CDB941
        for <linux-nfs@vger.kernel.org>; Mon,  5 Aug 2019 10:44:00 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 5 Aug 2019 10:44:03 +0800
To:     <linux-nfs@vger.kernel.org>
CC:     <cuiyue-fnst@cn.fujitsu.com>
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
Subject: BUG,
Message-ID: <bbc5ed2e-d517-0a5a-1add-1c846d00e88a@cn.fujitsu.com>
Date:   Mon, 5 Aug 2019 10:42:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 3BA784CDB941.AB978
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

When I tested xfstests generic/465 with NFS, there was something unexpected.

When memory of NFS server was 10G, test passed.
But when memory of NFS server was 4G, test failed.

Fail message was as below.
     non-aio dio test
     encounter an error: block 4 offset 0, content 62
     aio-dio test
     encounter an error: block 1 offset 0, content 62

All of the NFS versions(v3 v4.0 v4.1 v4.2) have  this problem.
Maybe something is wrong about NFS's I/O operation.

Thanks in advance.




