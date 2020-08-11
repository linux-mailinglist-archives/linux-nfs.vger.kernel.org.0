Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF2E241B95
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Aug 2020 15:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgHKNbT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Aug 2020 09:31:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52888 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgHKNbS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Aug 2020 09:31:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BDMZ6t111475;
        Tue, 11 Aug 2020 13:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=dCuPkRHVtlGTBwawhtjYhHzb8Ba5cRhPHEh51UEwKpc=;
 b=HPYfBXO+kKSgOleD8Jk6SZ2NOqTF/2FRVeubCRrqQw4ceI6kXncjIOR77vWXdX7FAVAJ
 /M+1raUFmz6dgiAu1JAp6Y63fXrLPU+lQ/1kcEGl50d737omRMGUPE74gv0WMNrGTVyc
 OCjZ8QzNS/ZymGpM+d9CRdfaJBZWeTVupQfrwGr0FXv/I7HjyTT91tIhEVfSxn9aw0mW
 SK9Z4zERgk6oVFJnFD7X3c+oIeC490CjS+NGulXnuTsQa4Ff4rLo/wyc7dgWDJ21OfzH
 0e2DsN6VlaQnJV4w3/TMitDbAGzMx+GdGdDy8SFh9fm3nbb2w0OL1QaQxgnXodHIClYj 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32t2ydjyjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 13:31:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BDSUTo151469;
        Tue, 11 Aug 2020 13:31:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32t5yypkgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 13:31:13 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07BDV83x008803;
        Tue, 11 Aug 2020 13:31:13 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 13:31:08 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200810201001.GC13266@fieldses.org>
Date:   Tue, 11 Aug 2020 09:31:07 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
References: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
 <20200809202739.GA29574@fieldses.org> <20200809212531.GB29574@fieldses.org>
 <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
 <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
 <20200810201001.GC13266@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110093
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 10, 2020, at 4:10 PM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Mon, Aug 10, 2020 at 04:01:00PM -0400, Chuck Lever wrote:
>> Roughly the same result with this patch as with the first one. The
>> first one is a little better. Plus, I think the Solaris NFS server
>> hands out write delegations on v4.0, and I haven't heard of a
>> significant issue there. It's heuristics may be different, though.
>> 
>> So, it might be that NFSv4.0 has always run significantly slower. I
>> will have to try a v5.4 or older server to see.
> 
> Oh, OK, I was assuming this was a regression.

Me too. Looks like it is: NFSv4.0 always runs slower, but I see
it get significantly worse between v5.4 and 5.5. I will post more
quantified results soon.


--
Chuck Lever



