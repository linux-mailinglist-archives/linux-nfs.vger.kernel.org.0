Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08B719ED5B
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Apr 2020 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgDESf2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Apr 2020 14:35:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgDESf1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Apr 2020 14:35:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 035ITKQn062753;
        Sun, 5 Apr 2020 18:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=76aUSOkgKUdsEwfXVDOy+zJla8Ciy7zeZNM3rDpEth8=;
 b=UQPtmYhSCPY/8qKvVQQ3Zid5p6IR+GWVKbhfIVuhwpY+VaGiQeNQW365GgZI0KjZCm+Q
 E/icqFe03WjiAELrAOBKBEhsSpFa1ApE/K6Lp/+N2P+DrEUDtBqX+HIjfvy/9eSWhxP7
 I2IiE0skOttH1czt3wwRo/Nq6Bk9RvyOLgiIvyJXqiQ+K3hpXxKw11iiQth1iP11L5JH
 n4VOrF+O7myZdFem/x4OAcFzhGVUjtHatlmODi7JVUTNoW49TE64XYJ3pfK3S1ZH1hx6
 Rx8M8Qaf/tnx3CB09ICHxLuPJxPbOMiMA2g8MzAIHou6axoo9E6VQeCbI0pc+CYc1Gz4 Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 306jvmumc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 18:35:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 035IQUHf126709;
        Sun, 5 Apr 2020 18:35:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3073sng4j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 18:35:17 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 035IZFGx026862;
        Sun, 5 Apr 2020 18:35:16 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Apr 2020 11:35:14 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] SUNRPC/cache: Fix unsafe traverse caused double-free
 in cache_purge
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <25dcf75e-65b1-b6e8-1fe5-81a193ed4189@linux.alibaba.com>
Date:   Sun, 5 Apr 2020 14:35:13 -0400
Cc:     Bruce Fields <bfields@fieldses.org>, Neil Brown <neilb@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <93CF97D8-1E4B-4310-9C51-9D373424D0BF@oracle.com>
References: <4568a7cf87f110b8e59fda6f53fda34c550ab403.1586108200.git.wuyihao@linux.alibaba.com>
 <e0dd0339-a15e-814d-ac5a-5f51bc15d73c@linux.alibaba.com>
 <0308EB8A-A8B7-412C-8F93-A444DE47CB1D@oracle.com>
 <25dcf75e-65b1-b6e8-1fe5-81a193ed4189@linux.alibaba.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004050170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004050170
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 5, 2020, at 2:31 PM, Yihao Wu <wuyihao@linux.alibaba.com> =
wrote:
>=20
>>> net/sunrpc/cache.c | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
>>> index af0ddd28b081..b445874e8e2f 100644
>>> --- a/net/sunrpc/cache.c
>>> +++ b/net/sunrpc/cache.c
>>> @@ -541,7 +541,9 @@ void cache_purge(struct cache_detail *detail)
>>> 	dprintk("RPC: %d entries in %s cache\n", detail->entries, =
detail->name);
>>> 	for (i =3D 0; i < detail->hash_size; i++) {
>>> 		head =3D &detail->hash_table[i];
>>> -		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
>>=20
>> If review/testing shows you need to respin this patch, I note that =
"tmp" is
>> now unused and should be removed. I've pulled v3 into my testing =
branch and
>> made that minor change. Thanks!
>>=20
>>=20
>>> +		while (!hlist_empty(head)) {
>>> +			ch =3D hlist_entry(head->first, struct =
cache_head,
>>> +					 cache_list);
>>> 			sunrpc_begin_cache_remove_entry(ch, detail);
>>> 			spin_unlock(&detail->hash_lock);
>>> 			sunrpc_end_cache_remove_entry(ch, detail);
>>> --=20
>>> 2.20.1.2432.ga663e714
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>=20
> Thanks a lot, Chuck!
>=20
> If it needs further changes by me, I'll fix the unused 'tmp' along =
with them.
>=20
> BTW, if you and Neil think it's proper to add Signed-off-by Neil too =
later,
> please do, since the bug fix owes to Neil's idea :-)

Actually a "Suggested-by:" tag is appropriate for attribution. I'll add:

Suggested-by: NeilBrown <neilb@suse.de>

to what I have in my tree.


--
Chuck Lever



