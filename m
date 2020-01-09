Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C73135CE3
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2020 16:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAIPgt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jan 2020 10:36:49 -0500
Received: from fieldses.org ([173.255.197.46]:54982 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgAIPgs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 Jan 2020 10:36:48 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 4D276AAD; Thu,  9 Jan 2020 10:36:48 -0500 (EST)
Date:   Thu, 9 Jan 2020 10:36:48 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     "Su, Yanjun" <suyj.fnst@cn.fujitsu.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "mora@netapp.com" <mora@netapp.com>
Subject: Re: [PATCH] CACHE: Fix test script as delegation being introduced
Message-ID: <20200109153648.GA20670@fieldses.org>
References: <890610570fcd48d8b28b30e89f1f0038@G08CNEXMBPEKD05.g08.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890610570fcd48d8b28b30e89f1f0038@G08CNEXMBPEKD05.g08.fujitsu.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 09, 2020 at 01:54:51AM +0000, Su, Yanjun wrote:
> Any ping about the 1 year old problem?
> Cc mora:
> Did you test nfs cache with nfs version 4?
> Or maybe the test case is not suitable for v4?

I don't run it personally.  Jorge, is it expected to fail in the
presence of delegations?

> Sorry for my late reply. Our mail system has some problem that ignores your reply.
> 
> I Get the reply by google seach.
> 
> We tested the option "clientaddr=0.0.0.0" and the test case also fails.
> 
> Thanks
> 
> On Mon, Apr 08, 2019 at 10:47:56AM +0800, Su Yanjun<suyj.fnst@cn.fujitsu.com>  wrote:
> 
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
> 
> I don't think a chmod is a reliable way to recall delegations.

If you run the chmod from the same client, it won't necessarily revoke
the delegation.

If you run it from another client or run it directly on the server, it
should.

> Maybe mount with "clientaddr=0.0.0.0"?  From the nfs man page:
> 
>     Can  specify a value of IPv4_ANY (0.0.0.0) or equivalent IPv6
>     any address  which will  signal to the NFS server that this NFS
>     client does not want delegations.
> 
> (I wonder if that documentation's still accurate for versions >= 4.1?)

Probably not.  I don't think there's a way to turn off delegations from
the linux client.

The server may have a way to turn off delegations.  E.g. on a linux
server "echo 0>/proc/sys/fs/leases-enable" before starting knfsd should
do it.

--b.
