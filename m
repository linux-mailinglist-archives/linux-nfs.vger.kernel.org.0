Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7DB7832D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 03:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfG2Bzu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Jul 2019 21:55:50 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64301 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726216AbfG2Bzu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Jul 2019 21:55:50 -0400
X-IronPort-AV: E=Sophos;i="5.64,320,1559491200"; 
   d="scan'208";a="72402861"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Jul 2019 09:55:48 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 218384CDE65E;
        Mon, 29 Jul 2019 09:55:48 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 29 Jul 2019 09:55:52 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] CACHE: Fix test script as delegation being introduced
To:     <bfields@fieldses.org>
CC:     <linux-nfs@vger.kernel.org>
References: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com>
 <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com>
 <89d5612e-9af6-8f2e-15d8-ff6af29d508a@redhat.com>
 <016101d5359b$c71f06c0$555d1440$@mindspring.com>
 <4d6599c3-2280-e919-b60f-905f86452ac1@cn.fujitsu.com>
Message-ID: <2d2f5b86-682a-e5d3-b9d9-18573c84073d@cn.fujitsu.com>
Date:   Mon, 29 Jul 2019 09:54:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4d6599c3-2280-e919-b60f-905f86452ac1@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 218384CDE65E.ABCB9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi bruce.

Sorry for my late reply. Our mail system has some problem that ignores your reply.

I Get the reply by google seach.

We tested the option "clientaddr=0.0.0.0" and the test case also fails.

Thanks

On Mon, Apr 08, 2019 at 10:47:56AM +0800, Su Yanjun<suyj.fnst@cn.fujitsu.com>  wrote:
> When we run nfstest_cache with nfsversion=4, it fails.
> As i know nfsv4 introduces delegation, so nfstest_cache runs fail
> since nfsv4.
> 
> The test commandline is as below:
> ./nfstest_cache --nfsversion=4 -e /nfsroot --server 192.168.102.143
> --client 192.168.102.142 --runtest acregmax_data --verbose all
> 
> This patch adds compatible code for nfsv3 and nfsv4.
> When we test nfsv4, just use 'chmod' to recall delegation, then
> run the test. As 'chmod' will modify atime, so use 'noatime' mount option.

I don't think a chmod is a reliable way to recall delegations.

Maybe mount with "clientaddr=0.0.0.0"?  From the nfs man page:

	Can  specify a value of IPv4_ANY (0.0.0.0) or equivalent IPv6
	any address  which will  signal to the NFS server that this NFS
	client does not want delegations.

(I wonder if that documentation's still accurate for versions >= 4.1?)

--b.
> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> ---
> test/nfstest_cache | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/test/nfstest_cache b/test/nfstest_cache
> index 0838418..a31d48f 100755
> --- a/test/nfstest_cache
> +++ b/test/nfstest_cache
> @@ -165,8 +165,13 @@ class CacheTest(TestUtil):
> fd = None
> attr = 'data' if data_cache else 'attribute'
> header = "Verify consistency of %s caching with %s on a file" %
> (attr, self.nfsstr())
> +
> # Mount options
> - mtopts = "hard,intr,rsize=4096,wsize=4096"
> + if self.nfsversion >= 4:
> + mtopts = "noatime,hard,intr,rsize=4096,wsize=4096"
> + else: + mtopts = "hard,intr,rsize=4096,wsize=4096"
> +
> if actimeo:
> header += " actimeo = %d" % actimeo
> mtopts += ",actimeo=%d" % actimeo
> @@ -216,6 +221,11 @@ class CacheTest(TestUtil):
> if fstat.st_size != dlen:
> raise Exception("Size of newly created file is %d, should have been
> %d" %(fstat.st_size, dlen))
> + if self.nfsversion >= 4:
> + # revoke delegation
> + self.dprint('DBG3', "revoke delegation")
> + self.clientobj.run_cmd('chmod +x %s' % self.absfile)
> +
> if acregmax:
> # Stat the unchanging file until acregmax is hit
> # each stat doubles the valid cache time
> 
> -- 
> 2.7.4
> 
>



