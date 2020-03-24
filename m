Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5093B191352
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2020 15:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCXOfw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 10:35:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50334 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgCXOfv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Mar 2020 10:35:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OEX21B065800;
        Tue, 24 Mar 2020 14:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=uvDrFvOPKAtLVLthlbJ7GLpS4M2BczAcaaNrTynzHec=;
 b=mpfaXWPlfyUjOrj+EWJmgXVZ+r0XMZ9Y+NzzlcvfytOXm2xhS2kNtiI9HKp/KmgwOXYp
 5xaq2u6BAurfYebap0yzoSQPjBrARXkrNQzMdBal2J8WzteVtcRJctGMFZ4iQH1xPziJ
 PT+XLJvWINcIlH0DXae27ne83hbrbLRWlhOfhIuVdFBMcrwDY3ALrpPRWT4vq9bXV54v
 ZuYI2Itff6+4rUqb+6+XaSwZcIEx5bOLgy+2k5pDLB7wZt+KwB/hwS6xDGui9hz7wleg
 vrYmzYvis9rxf9FuEBPvA+CEBK5jN/yaWv218K/rmUkvL2aNQWExGiU2aNfmqIoWDjNW fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ywavm4n08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 14:35:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OEWGdx144132;
        Tue, 24 Mar 2020 14:35:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yxw4pdemv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 14:35:39 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02OEZbsN005282;
        Tue, 24 Mar 2020 14:35:38 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 07:35:37 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: fix race between cache_clean and cache_purge
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200324143356.GA11065@fieldses.org>
Date:   Tue, 24 Mar 2020 10:35:36 -0400
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Yihao Wu <wuyihao@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
Message-Id: <C35C0261-6DE6-4AFA-AA07-10B988F6012A@oracle.com>
References: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
 <8B2BC124-6911-46C9-9B01-A237AC149F0A@oracle.com>
 <20200324143356.GA11065@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=818 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=880 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240079
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 24, 2020, at 10:33 AM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Tue, Mar 24, 2020 at 09:38:55AM -0400, Chuck Lever wrote:
>> Mechanically this looks OK, but I would feel more comfortable
>> if a domain expert could review this. Neil, Trond, Bruce?
> 
> Looks right to me.
> 
> Reviewed-by: J. Bruce Fields <bfields@redhat.com>

Thanks, Bruce! I've added your R-b.

--
Chuck Lever



