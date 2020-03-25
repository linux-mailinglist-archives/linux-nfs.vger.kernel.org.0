Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290E2192B11
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 15:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgCYOZT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 10:25:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58944 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbgCYOZT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 10:25:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PEN70S041067;
        Wed, 25 Mar 2020 14:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=j1z/HOmNY64xDbmB5Zqy+Jd7SCvvXY3IV0n6ZJaKKSY=;
 b=Ftp3oD2Kpjn2qPLikoYZd4zRH269AMPNJrVPWXLvtI40pklZL8XH9dBtpk9Vr7rvJp+N
 +mtK98lwmSVRtprU7Riek0AL530CT6thz+E9T6RNKGKUzA1T/eHwsL5BWJCh4Fz9Euzk
 FO/jFn5Is5YqyOscsBXdqJ3GdKZLOLB8+4SaHObGYxCSeOCQA/wDBMbH0gzzM/h9H3lt
 bodOeyNRaDYu3rAoY8SIAWAxM4moQUGbYox6hnkG3yn2HHAMlRQzCxG0g71saeR5LZPX
 yps0RLpnnuuxAAWU5o4S/VTvXRllLGFUIRwim6K50EMfegqGVX1NsxU2cDW5sy+8bsoh Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ywavma10t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 14:25:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PENcaq026276;
        Wed, 25 Mar 2020 14:25:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3003ghtqgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 14:25:01 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PEOtYB024470;
        Wed, 25 Mar 2020 14:24:58 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 07:24:55 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: fix race between cache_clean and cache_purge
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <5372f88d-efb7-25a3-789f-53bfa7bb6f26@linux.alibaba.com>
Date:   Wed, 25 Mar 2020 10:24:54 -0400
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>,
        "neilb@suse.com" <neilb@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AA6A103-6A9C-40CF-A625-B7A29B0D6BA0@oracle.com>
References: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
 <8B2BC124-6911-46C9-9B01-A237AC149F0A@oracle.com>
 <13c45bdcb67d689bfcb4f4b720b631e56c662f2b.camel@hammerspace.com>
 <CCFA2CA8-150C-432C-B939-9085B791FE74@oracle.com>
 <5372f88d-efb7-25a3-789f-53bfa7bb6f26@linux.alibaba.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250119
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 25, 2020, at 2:37 AM, Yihao Wu <wuyihao@linux.alibaba.com> =
wrote:
>=20
> On 2020/3/25 1:46 AM, Chuck Lever wrote:
>>>>> ---
>>>>> net/sunrpc/cache.c | 3 +++
>>>>> 1 file changed, 3 insertions(+)
>>>>>=20
>>>>> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
>>>>> index bd843a81afa0..3e523eefc47f 100644
>>>>> --- a/net/sunrpc/cache.c
>>>>> +++ b/net/sunrpc/cache.c
>>>>> @@ -524,9 +524,11 @@ void cache_purge(struct cache_detail *detail)
>>>>> 	struct hlist_node *tmp =3D NULL;
>>>>> 	int i =3D 0;
>>>>>=20
>>>>> +	spin_lock(&cache_list_lock);
>>>>> 	spin_lock(&detail->hash_lock);
>>>>> 	if (!detail->entries) {
>>>>> 		spin_unlock(&detail->hash_lock);
>>>>> +		spin_unlock(&cache_list_lock);
>>>>> 		return;
>>>>> 	}
>>>>>=20
>>>>> @@ -541,6 +543,7 @@ void cache_purge(struct cache_detail *detail)
>>>>> 		}
>>>>> 	}
>>>>> 	spin_unlock(&detail->hash_lock);
>>>>> +	spin_unlock(&cache_list_lock);
>>>>> }
>>>>> EXPORT_SYMBOL_GPL(cache_purge);
>>>=20
>>> Hmm... Shouldn't this patch be dropping cache_list_lock() when we =
call
>>> sunrpc_end_cache_remove_entry()? The latter does call both
>>> cache_revisit_request() and cache_put(), and while they do not
>>> explicitly call anything that holds cache_list_lock, some of those =
cd-
>>>> cache_put callbacks do look as if there is potential for deadlock.
>> I see svc_export_put calling dput, eventually, which might_sleep().
>=20
> Wow that's a little strange. If svc_export_put->dput might_sleep, why =
can we
> spin_lock(&detail->hash_lock); in cache_purge in the first place?
>=20
> And I agree with Trond those cd->cache_put callbacks are dangerous. I =
will look
> into them today.
>=20
> But if we dropping cache_list_lock when we call =
sunrpc_end_cache_remove_entry,
> cache_put is not protected, and this patch won't work anymore, right?

IMHO Neil's proposed solution seems pretty safe, and follows a =
well-understood
pattern.

It would be nice (but not 100% necessary) if the race you found was =
spelled out
in the patch description.

Thanks!


--
Chuck Lever



