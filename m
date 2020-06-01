Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ABA1EA6A1
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2020 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgFAPO6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Jun 2020 11:14:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39803 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727013AbgFAPO6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Jun 2020 11:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591024496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pCrXJ03db7VYYYF7gmziJuuKS894/lFYNW1XlUnGtHY=;
        b=QJAcpt3An2lkA1ewwsnbl/wR4um+X4Ie2T/7f1B5vjbLFRQ8bEuX2vnQyfVR2uNsOWrq7x
        1zZTMu14jCHs1iQsNiUZ5KGig8mbkCGZ3SIe87U/pU6Jpa+NpVUiw68nkd+ai1PU+mmhtV
        kQf8lhHf7sxDAxzb4N63Ib6+HDHTnOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-L0Ifay-oNR-USfFWJ-nOEQ-1; Mon, 01 Jun 2020 11:14:51 -0400
X-MC-Unique: L0Ifay-oNR-USfFWJ-nOEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BD3D18FE895;
        Mon,  1 Jun 2020 15:14:50 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-242.rdu2.redhat.com [10.10.116.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AC525D9C9;
        Mon,  1 Jun 2020 15:14:50 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 2F6B81203A7; Mon,  1 Jun 2020 11:14:49 -0400 (EDT)
Date:   Mon, 1 Jun 2020 11:14:49 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     "Su, Yanjun" <suyj.fnst@cn.fujitsu.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "mora@netapp.com" <mora@netapp.com>
Subject: Re: [About] about nfscache problem
Message-ID: <20200601151449.GA170596@pick.fieldses.org>
References: <8ad54ded2abb484e8df280bd257242bb@G08CNEXMBPEKD05.g08.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad54ded2abb484e8df280bd257242bb@G08CNEXMBPEKD05.g08.fujitsu.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 28, 2020 at 07:18:31AM +0000, Su, Yanjun wrote:
> Hi Bruce
> 
> >On Mon, Apr 20, 2020 at 08:13:51AM +0000, Su, Yanjun wrote:
> >> At this time, the nfscache problem has not progressed for long time. Do we still need to follow it?
> >>
> >> The problem is as below
> >> The test commandline is as below:
> >> ./nfstest_cache --nfsversion=4 -e /nfsroot --server 192.168.102.143
> >> --client 192.168.102.142 --runtest acregmax_data --verbose all
> >>
> >> More detail info is here:
> >> https://linuxlists.cc/l/17/linux-nfs/t/3063683/(patch)_cache:_fix_test_script_as_delegation_being_introduced
> >>
> >> This patch adds compatible code for nfsv3 and nfsv4.
> >> When we test nfsv4, just use 'chmod' to recall delegation, then
> >> run the test. As 'chmod' will modify atime, so use 'noatime' mount option.
> >>
> >> After a discusion with you, a chmod is a reliable way to recall delegations.
> >>
> >> Can you contact mora and make a decision for it?
> 
> >I don't have any better way to contact him than the address cc'd above.
> 
> >Remind me what the problem is? How is the test failing?
> 
> When we run nfstest_cache with nfsversion=4, it fails.
> As i know nfsv4 introduces delegation, so nfstest_cache runs fail since
> nfsv4.
> 
> The test commandline is as below:
> ./nfstest_cache --nfsversion=4 -e /nfsroot --server 192.168.102.143
> --client 192.168.102.142 --runtest acregmax_data --verbose all
> 
> This patch adds compatible code for nfsv3 and nfsv4.
> When we test nfsv4, just use 'chmod' to recall delegation, then
> run the test. As 'chmod' will modify atime, so use 'noatime' mount option.

So, you patch nfstest as below, then run the test, and the test fails?

--b.

> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com><mailto:%3Csuyj.fnst@cn.fujitsu.com%3E>
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
> header = "Verify consistency of %s caching with %s on a file" % (attr,
> self.nfsstr())
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
> raise Exception("Size of newly created file is %d, should have been %d"
> %(fstat.st_size, dlen))
> + if self.nfsversion >= 4:
> + # revoke delegation
> + self.dprint('DBG3', "revoke delegation")
> + self.clientobj.run_cmd('chmod +x %s' % self.absfile)
> +
> if acregmax:
> # Stat the unchanging file until acregmax is hit
> # each stat doubles the valid cache time
> 
> 

