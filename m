Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434C426DCCB
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIQN24 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Sep 2020 09:28:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59538 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgIQN2y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Sep 2020 09:28:54 -0400
X-Greylist: delayed 3430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 09:28:53 EDT
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HCUijQ088710;
        Thu, 17 Sep 2020 12:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=9A1CPC/O8ESI8f5UgbMN5OipUWWq4ilrKiKNSyl5mnc=;
 b=VHXehe+c700z2ppeNSd882931+OjSAjjA9DkQsMy4cipjHXKKOXWIJ/skBJVaMSBozPE
 V9mLxBvMbSLZdjZIm+H3fwYRW6w+jvVYQGhKnDdFZN0CYMIcChpxF5MQ9/23zf9HLqvT
 d0CBJMl5zZeg5WJP6wmBer68DD27u7okw8uNHeqrQGubUxGtImTXlRakZ3roe9Q5yKvf
 MwBGFxaN6uAN4venLjs1ffGOdFPGodoeroy/5dmcB43Ls/VvHbEnSVy2RJKcu/T1z5Wj
 jUCFHxgV6uIkkLlA6g8NDC4p4HOaazJ7L4jT2U2uSugyQncpzlVk0FgeLRSND9yGA1/5 LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33j91dtncy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 12:31:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HCUohQ089786;
        Thu, 17 Sep 2020 12:31:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33h893php6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 12:31:30 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08HCVNIF011007;
        Thu, 17 Sep 2020 12:31:24 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 12:31:22 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH RFC 01/21] NFSD: Add SPDK header for fs/nfsd/trace.c
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200917061315.GA625@infradead.org>
Date:   Thu, 17 Sep 2020 08:31:21 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <257B5364-6C52-41C3-A0E2-5B2F3512C79C@oracle.com>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
 <160029253817.29208.3156039915028547893.stgit@klimt.1015granger.net>
 <20200917061315.GA625@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170098
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 17, 2020, at 2:13 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Wed, Sep 16, 2020 at 05:42:18PM -0400, Chuck Lever wrote:
>> Clean up.
>> 
>> The file was contributed in 2014 by Christoph Helwig in commit
>> 31ef83dc0538 ("nfsd: add trace events").
> 
> s/SPDK/SPDX/

<snicker>


--
Chuck Lever



