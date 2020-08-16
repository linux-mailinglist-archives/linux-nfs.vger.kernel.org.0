Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE67C245982
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Aug 2020 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgHPUqI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Aug 2020 16:46:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgHPUqH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Aug 2020 16:46:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07GKcGYq130379;
        Sun, 16 Aug 2020 20:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=/pAe/qvT32tvwfj2SYWP0UGFSaRcjNpBSN/laXwb55A=;
 b=xIgfXCASjR43s/ERaXcc1IVNnmrN7T0p/1Dv729KXSZP8X6shfWMxNse7pKm/pVAzJI9
 oBFhWnHxchpU4suT1QEvbzY9Nxehr9NmIxdMoRkcYQNVnNSMWxLTKisJCIhRo+DW5blp
 nsxlD2FpJ8VO6XC7hc7INQ8kVBcTJXOaTLufrs3GGmxslcRatN/H68zR/j4QAthkgQh3
 BkwzEzxByLjn0FcXbkWFZTi7Op2zCVSX7hx7NTRWXwmf6K0lzVH/+qLGMd+NYyZEd9m6
 fp3jFSRQUkqUk1YCb3ApKuO3kIer2/ad5bnaPfv125AdwG7+l4S39rlGYKI/omuLgehO Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32x8bmuhed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 16 Aug 2020 20:46:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07GKcYp0089869;
        Sun, 16 Aug 2020 20:46:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32xsfp9wy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 20:46:03 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07GKk16p004848;
        Sun, 16 Aug 2020 20:46:02 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Aug 2020 13:46:01 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
Date:   Sun, 16 Aug 2020 16:46:00 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F20E4EC5-71DD-4A92-A583-41BEE177F53C@oracle.com>
References: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
 <20200809202739.GA29574@fieldses.org> <20200809212531.GB29574@fieldses.org>
 <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
 <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
 <20200810201001.GC13266@fieldses.org>
 <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008160171
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

> On Aug 11, 2020, at 9:31 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
>> On Aug 10, 2020, at 4:10 PM, Bruce Fields <bfields@fieldses.org> wrote:
>> 
>> On Mon, Aug 10, 2020 at 04:01:00PM -0400, Chuck Lever wrote:
>>> Roughly the same result with this patch as with the first one. The
>>> first one is a little better. Plus, I think the Solaris NFS server
>>> hands out write delegations on v4.0, and I haven't heard of a
>>> significant issue there. It's heuristics may be different, though.
>>> 
>>> So, it might be that NFSv4.0 has always run significantly slower. I
>>> will have to try a v5.4 or older server to see.
>> 
>> Oh, OK, I was assuming this was a regression.
> 
> Me too. Looks like it is: NFSv4.0 always runs slower, but I see
> it get significantly worse between v5.4 and 5.5. I will post more
> quantified results soon.

It took me a while to get plausible bisection results. The problem
appears in the midst of the NFSD filecache patches merged in v5.4.

In order of application:

5920afa3c85f ("nfsd: hook nfsd_commit up to the nfsd_file cache")
961.68user 5252.40system 20:12.30elapsed 512%CPU, 2541 DELAY errors
These results are similar to v5.3.

fd4f83fd7dfb ("nfsd: convert nfs4_file->fi_fds array to use nfsd_files")
Does not build

eb82dd393744 ("nfsd: convert fi_deleg_file and ls_file fields to nfsd_file")
966.92user 5425.47system 33:52.79elapsed 314%CPU, 1330 DELAY errors

Can you take a look and see if there's anything obvious?


--
Chuck Lever



