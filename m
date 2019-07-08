Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD6761946
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 04:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfGHCVl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jul 2019 22:21:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35115 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726105AbfGHCVl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 Jul 2019 22:21:41 -0400
X-IronPort-AV: E=Sophos;i="5.63,464,1557158400"; 
   d="scan'208";a="70900599"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Jul 2019 10:21:36 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id E6D914CDDD5C;
        Mon,  8 Jul 2019 10:21:37 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 8 Jul 2019 10:21:42 +0800
Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <ffilzlnx@mindspring.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com>
Message-ID: <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com>
Date:   Mon, 8 Jul 2019 10:20:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: E6D914CDDD5C.AD7B1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ang ping?

在 2019/7/3 9:34, Su Yanjun 写道:
> Hi Frank
>
> We tested the pynfs of NFSv4.0 on the latest version of the kernel 
> (5.2.0-rc7).
> I encountered a problem while testing st_lock.testOpenUpgradeLock. The 
> problem is now as follows:
> **************************************************
> LOCK24 st_lock.testOpenUpgradeLock : FAILURE
>            OP_LOCK should return NFS4_OK, instead got
>            NFS4ERR_BAD_SEQID
> **************************************************
> Is this normal?
>
> The case is as follows:
> Def testOpenUpgradeLock(t, env):
>     """Try open, lock, open, downgrade, close
>
>     FLAGS: all lock
>     CODE: LOCK24
>     """
>     c= env.c1
>     C.init_connection()
>     Os = open_sequence(c, t.code, lockowner="lockowner_LOCK24")
>     Os.open(OPEN4_SHARE_ACCESS_READ)
>     Os.lock(READ_LT)
>     Os.open(OPEN4_SHARE_ACCESS_WRITE)
>     Os.unlock()
>     Os.downgrade(OPEN4_SHARE_ACCESS_WRITE)
>     Os.lock(WRITE_LT)
>     Os.close()
>
> After investigation, there was an error in unlock->lock. When 
> unlocking, the lockowner of the file was not released, causing an 
> error when locking again.
> Will nfs4.0 support 1) open-> 2) lock-> 3) unlock-> 4) lock this 
> function?
>
>
>


