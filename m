Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF10311EA1F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 19:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfLMSXV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 13:23:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59064 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbfLMSXV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 13:23:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDIEtVi179089;
        Fri, 13 Dec 2019 18:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Wg9Cdl0upjNBwwnH+MGzpRTCePKvAfBt0cxN3PMC6OE=;
 b=q5tPiNb3Ulac48t/L9aVotA/6wT26YDjHxTDD9plxZcrl+ZiF52LXYkPacnDRO/F3CGS
 0FVPXrR/O03rDTJmkCRtP0phwOhULG4V8t6S6Q+depYoaafRCCUxnXPuJd/SEG8K9NIY
 aUFQhfgbfcvNwHqGPCrB/DxenVUPX0jJDK9aBGI2bEpl7EU7vUQ20CBNerLsxNwDKWdW
 CIyzaTHsYD36+AKu0vPEcquTPLYuZpeI1nqzNsPzknEXcFmMi55F/n0FU7Z8U7G36cSi
 oM3g1AkZAXs82QmM5OSxNHz0Ra2Ujqbag9Lw8V5swXIpL6s/U746TCrJjf/p5wTjmn4k uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4nqgy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 18:23:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDIEGMw109798;
        Fri, 13 Dec 2019 18:23:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wvdwq5j3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 18:23:13 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDIN9O3010194;
        Fri, 13 Dec 2019 18:23:09 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 10:23:09 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 10/12] nfsd: use boottime for lease expiry alculation
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAK8P3a3RXqVqpeTmOrEGtXyeMGZV+5g_QzywGgLnfvi2GMDx=g@mail.gmail.com>
Date:   Fri, 13 Dec 2019 13:23:08 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BBB37836-D835-4EB7-8593-080BF60BDA38@oracle.com>
References: <20191213141046.1770441-1-arnd@arndb.de>
 <20191213141046.1770441-11-arnd@arndb.de>
 <CBC9899C-12BE-466E-8809-EA928AAE1F11@oracle.com>
 <CAK8P3a3RXqVqpeTmOrEGtXyeMGZV+5g_QzywGgLnfvi2GMDx=g@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130143
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 13, 2019, at 11:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Fri, Dec 13, 2019 at 5:26 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>> On Dec 13, 2019, at 9:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index 24534db87e86..508d7c6c00b5 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -823,7 +823,12 @@ static const struct rpc_program cb_program = {
>>> static int max_cb_time(struct net *net)
>>> {
>>>      struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>> -     return max(nn->nfsd4_lease/10, (time_t)1) * HZ;
>>> +
>>> +     /* nfsd4_lease is set to at most one hour */
>>> +     if (WARN_ON_ONCE(nn->nfsd4_lease > 3600))
>>> +             return 360 * HZ;
>> 
>> Why is the WARN_ON_ONCE added here? Is it really necessary?
> 
> This is to ensure the kernel doesn't change to a larger limit that
> requires a 64-bit division on a 32-bit architecture.
> 
> With the old code, dividing by 10 was always fast as
> nn->nfsd4_lease was the size of an integer register. Now it
> is 64 bit wide, and I check that truncating it to 32 bit again
> is safe.

OK. That comment should state this reason rather than just repeating
what the code does. ;-)


>> (Otherwise these all LGTM).
> 
> Thanks for taking a look.
> 
>      Arnd

--
Chuck Lever



