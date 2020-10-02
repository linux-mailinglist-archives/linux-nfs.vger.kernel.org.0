Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A022819FE
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbgJBRo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 13:44:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41688 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBRo6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 13:44:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092HZRg1085019;
        Fri, 2 Oct 2020 17:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=l2UNO2YNoDQNHXYdO38iaikDx7u/tLWrzRS36kF1bqU=;
 b=MGbfXxaTTodkj1SYVrJSGGVDz4QGbPeknz/hb9J70skJklnyadrqJ7ZQzHVz3tikivhI
 cEaBDMD6QP1LIei5AhD++mTSdmR7mo+A0/Ddcutx7BtASMktLn/H99Zp9BNfREIV/pcy
 FD4EhAKFLNnGPreoCH6IWHn6kbEPp9mEvCGUNOH7rZmx8Lt9Hm2NeS2srkNQP6dOHHeb
 078X51I88+fFTnQnmXF4ZZVZPJWZwaDMlIJk2x039rP9Pd/sjvuEk/G4aUHm/iuiVLY3
 NKDyTDrQxHk7KzBaX7FSC7XvODKaTWfakaVEt5LX+IwQZpx17njZFuN5GcpmVuUn+5LR rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33sx9nm3t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 17:44:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092HVIWO081332;
        Fri, 2 Oct 2020 17:44:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33uv2jmg1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Oct 2020 17:44:55 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 092Hirhf015335;
        Fri, 2 Oct 2020 17:44:54 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Oct 2020 10:44:53 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v3 00/15] nfsd_dispatch() clean up
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201002174255.GB31151@fieldses.org>
Date:   Fri, 2 Oct 2020 13:44:51 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1156EA12-2D90-4D60-A9A2-C892576D412E@oracle.com>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
 <20201002173908.GA31151@fieldses.org> <20201002174255.GB31151@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020130
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 2, 2020, at 1:42 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Fri, Oct 02, 2020 at 01:39:08PM -0400, J. Bruce Fields wrote:
>> I'm seeing a pynfs4.0 GATT9 regression.  That's a test that attempts a
>> compound with 90 GETATTR ops each a request for all mandatory
>> attributes.  The test expects OK or RESOURCE but looks like its getting
>> a corrupted response?  (I haven't looked at the wire traffic yet.)  I
>> think it's one of the final patches changing how errors are returned.
> 
> Also some other tests that send compounds with lots of ops:
> 
> GATT9    st_getattr.testLotsofGetattrsFile                        : FAILURE
>           nfs4lib.InvalidCompoundRes: Invalid COMPOUND result:
>           Truncated response list.
> COMP6    st_compound.testLongCompound                             : FAILURE
>           COMPOUND with len=150 argarry got Invalid COMPOUND
>           result: Truncated response list., expected
>           NFS4ERR_RESOURCE
> COMP4    st_compound.testInvalidMinor                             : FAILURE
>           nfs4lib.InvalidCompoundRes: Invalid COMPOUND result:
>           Truncated response list.
> 
> Bisect lands on the last patch ("Hoist status code...").

Excellent, thanks for the test results. I'll take a look.


--
Chuck Lever



