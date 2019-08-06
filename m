Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF882B7E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 08:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfHFGKG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 02:10:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6774 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731714AbfHFGKG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 02:10:06 -0400
X-IronPort-AV: E=Sophos;i="5.64,352,1559491200"; 
   d="scan'208";a="73049970"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Aug 2019 14:09:59 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 559164CDFCCD
        for <linux-nfs@vger.kernel.org>; Tue,  6 Aug 2019 14:10:02 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 6 Aug 2019 14:10:03 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
Subject: NFS issues about aio and dio test
To:     <linux-nfs@vger.kernel.org>
CC:     <cuiyue-fnst@cn.fujitsu.com>
Message-ID: <975395cc-62f2-843f-cc71-82339b2869cd@cn.fujitsu.com>
Date:   Tue, 6 Aug 2019 14:08:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 559164CDFCCD.AA02B
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







