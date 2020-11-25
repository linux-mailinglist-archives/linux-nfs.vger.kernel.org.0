Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC752C428E
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 16:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgKYPB6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 10:01:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgKYPB6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 10:01:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0APEsZGI083184;
        Wed, 25 Nov 2020 15:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=QCA3n8x3xxs5+syQvLQrX1DWZySaUGuBt/E8NAnp1hQ=;
 b=fWFIyzeVi8q8q3LkRvoLxHyGk8bms1qDlT8v0yI7BmJb9nxTD0YIbTIP7B4wVgmRzGvm
 jObfVEqqfJuDlrYTlo7C513yEZQYHQVGKC2zzadNCnP7pGM81bLK3rY6GwU/jbD8abng
 HYL5adN2g39s5iEbd04f1INqWJXrrF/JgdAilh4rMmZL41Gm/M2Jor3oSz/WTaWi5Q4P
 CwyXSzLyCFQQUWCsAoL5qCGZbooP0c/QfUMQoy7Uc63ega7mkSnUaUMm0a9pfp/yndnl
 kpsA2bWdJB0pZD7i5faV8NEtHc9plwBT6d4KHdXlteCb+YDQOtBuh1wEXFKWmI5PZGWk fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 351kwh9s6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Nov 2020 15:01:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0APEtvt2081626;
        Wed, 25 Nov 2020 14:59:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 351kwf6uhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 14:59:42 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0APExdK5024913;
        Wed, 25 Nov 2020 14:59:39 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Nov 2020 06:59:39 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nfsd: Fix error return code in nfsd_file_cache_init()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201125141758.GB2811@fieldses.org>
Date:   Wed, 25 Nov 2020 09:59:37 -0500
Cc:     Trond Myklebust <trond.myklebust@primarydata.com>,
        richard.sharpe@primarydata.com,
        Dros Adamson <dros@primarydata.com>,
        Jeff Layton <jeff.layton@primarydata.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BFFAE931-5403-4790-8A2C-0E669FAEE292@oracle.com>
References: <20201125083933.2386059-1-huangguobin4@huawei.com>
 <20201125141758.GB2811@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>,
        Huang Guobin <huangguobin4@huawei.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250095
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 25, 2020, at 9:17 AM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Wed, Nov 25, 2020 at 03:39:33AM -0500, Huang Guobin wrote:
>> Fix to return PTR_ERR() error code from the error handling case =
instead of
>> 0 in function nfsd_file_cache_init(), as done elsewhere in this =
function.
>>=20
>> Fixes: 65294c1f2c5e7("nfsd: add a new struct file caching facility to =
nfsd")
>> Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
>> ---
>> fs/nfsd/filecache.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index c8b9d2667ee6..a8a5b555f08b 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -686,6 +686,7 @@ nfsd_file_cache_init(void)
>> 		pr_err("nfsd: unable to create fsnotify group: %ld\n",
>> 			PTR_ERR(nfsd_file_fsnotify_group));
>> 		nfsd_file_fsnotify_group =3D NULL;
>> +		ret =3D PTR_ERR(nfsd_file_fsnotify_group);
>=20
> I think you meant to add that one line earlier.
>=20
> Otherwise fine, but it looks like an unlikely case so can probably =
wait
> for the merge window.

Applied for the v5.11 merge window with Bruce's suggested change,
and pushed to the cel-next branch in

  git://git.linux-nfs.org/projects/cel/cel-2.6.git

or

  https://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dsummary


>> 		goto out_notifier;
>> 	}
>>=20
>> --=20
>> 2.22.0

--
Chuck Lever



