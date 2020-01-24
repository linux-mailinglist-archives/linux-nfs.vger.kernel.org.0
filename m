Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70831475E9
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2020 02:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgAXBK0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jan 2020 20:10:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57596 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgAXBK0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jan 2020 20:10:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00O13EgG031004;
        Fri, 24 Jan 2020 01:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=x1mzMLcC+Uu2MaYf4VG/oRc7oCropfa+Q2fhaSfdPyk=;
 b=r75BjgCeDSnnq6sJFWEwPaPpR0VEDT82SwrrkoErDxcUFhrXiqqBZCjvHGaysGE9mJmW
 3Yc0WX0eLYmm6KkF91MLtgKVri19w8nx/4RJPind105dWwSKRgCaheBqs41rO488L5M3
 X/UZbESe5BEHJ6aKxIKzr5Jbk2Re7n3StcVT5hIpg+xGgapAR0oOvV9wh4qMV94PH0tl
 njkoezyjaGdKeYIzKBa+4O4/0Cg30kgmuyG2AZSRetLxm10nkZCL0XwIDlpGGbX8CAN7
 kwRu9gE3yWYTociMhovRIf+QpG++3Lmd2OCzYFmTGdHAwyNvnmIokGJPRSeM6YdgAgtL XA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xksyqp1h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 01:10:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00O13JrY087737;
        Fri, 24 Jan 2020 01:10:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xqnrs31n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 01:10:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00O1ALhd020929;
        Fri, 24 Jan 2020 01:10:22 GMT
Received: from localhost (/10.145.179.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 17:10:21 -0800
Date:   Thu, 23 Jan 2020 17:10:19 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: A NFS, xfs, reflink and rmapbt story
Message-ID: <20200124011019.GA8247@magnolia>
References: <20200123083217.flkl6tkyr4b7zwuk@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123083217.flkl6tkyr4b7zwuk@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240006
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 23, 2020 at 04:32:17PM +0800, Murphy Zhou wrote:
> Hi,
> 
> Deleting the files left by generic/175 costs too much time when testing
> on NFSv4.2 exporting xfs with rmapbt=1.
> 
> "./check -nfs generic/175 generic/176" should reproduce it.
> 
> My test bed is a 16c8G vm.

What kind of storage?

> NFSv4.2  rmapbt=1   24h+

<URK> Wow.  I wonder what about NFS makes us so slow now?  Synchronous
transactions on the inactivation?  (speculates wildly at the end of the
workday)

I'll have a look in the morning.  It might take me a while to remember
how to set up NFS42 :)

--D

> NFSv4.2  rmapbt=0   1h-2h
> xfs      rmapbt=1   10m+
> 
> At first I thought it hung, turns out it was just slow when deleting
> 2 massive reflined files.
> 
> It's reproducible using latest Linus tree, and Darrick's deferred-inactivation
> branch. Run latest for-next branch xfsprogs.
> 
> I'm not sure it's something wrong, just sharing with you guys. I don't
> remember I have identified this as a regression. It should be there for
> a long time.
> 
> Sending to xfs and nfs because it looks like all related. :)
> 
> This almost gets lost in my list. Not much information recorded, some
> trace-cmd outputs for your info. It's easy to reproduce. If it's
> interesting to you and need any info, feel free to ask.
> 
> Thanks,
> 
> 
> 7)   0.279 us    |  xfs_btree_get_block [xfs]();
> 7)   0.303 us    |  xfs_btree_rec_offset [xfs]();
> 7)   0.301 us    |  xfs_rmapbt_init_high_key_from_rec [xfs]();
> 7)   0.356 us    |  xfs_rmapbt_diff_two_keys [xfs]();
> 7)   0.305 us    |  xfs_rmapbt_init_key_from_rec [xfs]();
> 7)   0.306 us    |  xfs_rmapbt_diff_two_keys [xfs]();
> 7)               |  xfs_rmap_query_range_helper [xfs]() {
> 7)   0.279 us    |    xfs_rmap_btrec_to_irec [xfs]();
> 7)               |    xfs_rmap_lookup_le_range_helper [xfs]() {
> 1)   0.786 us    |  _raw_spin_lock_irqsave();
> 7)               |      /* xfs_rmap_lookup_le_range_candidate: dev 8:34 agno 2 agbno 6416 len 256 owner 67160161 offset 99284480 flags 0x0 */
> 7)   0.506 us    |    }
> 7)   1.680 us    |  }
