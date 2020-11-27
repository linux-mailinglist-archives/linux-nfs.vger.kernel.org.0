Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB02C6A28
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Nov 2020 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbgK0Qu5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Nov 2020 11:50:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56342 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbgK0Qu5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Nov 2020 11:50:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ARGn8ii108739;
        Fri, 27 Nov 2020 16:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=UIKuec5qeE47/nOvATqqZIzzjIGBQTIQDf5aL7QLAWI=;
 b=SlCQRYTRrWzbOlpYWTCOnCmq2Qjj5bPz2rJ40ocEEJO97vLJYXDxvGVtdRrHZC1XqaER
 YTpi3okP7hd/OwvgAf4FS+vPYl7es2GZWQl5PHldxQUcwUHi7IVzlvGltoKqntBNmhy6
 EuB2ZgVlCWHvlP8Zfls/6Tn57IQ21mvmMpzbJ8CHPZBietn/rHrXVB9YJ15SHVQGXVm6
 QOIGaeGbLnuC8ndqdeC0g0QZ3PGmEVeJ23GSdTPuguN/6NHE9S/7Zywy17DoLVKS+19N
 j6RfZqW9SPoLWWbG6SuV7V+FODLCp+sS//i7XR2E+u5t4Z7aB1OFKlZ8CdEZFt2N9fLt DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 351kwhj15j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 16:50:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ARGo3jM053422;
        Fri, 27 Nov 2020 16:50:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 351kwj9re4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 16:50:48 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ARGolrc014556;
        Fri, 27 Nov 2020 16:50:47 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Nov 2020 08:50:47 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] sunrpc: clean-up cache downcall
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201127161451.17922-1-rbergant@redhat.com>
Date:   Fri, 27 Nov 2020 11:50:46 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F08098E1-7E04-4ECA-852A-C93E837E4EBF@oracle.com>
References: <20201127161451.17922-1-rbergant@redhat.com>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270098
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Roberto-

I spotted some mechanical problems.


> On Nov 27, 2020, at 11:14 AM, Roberto Bergantinos Corpas =
<rbergant@redhat.com> wrote:
>=20
> We can simplifly code around cache_downcall unifying memory

^simplifly^simplify

> allocations using kvmalloc, this have the benefit of getting rid of

^, this have^. This has

> cache_slow_downcall (and queue_io_mutex), and also matches userland
> allocation size and limits
>=20
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>

Assuming Bruce is copacetic with this patch, the change looks
appropriate for the v5.11 merge window. However, this patch
doesn't appear to apply to v5.10-rc5. Might be because
27a1e8a0f79e ("sunrpc: raise kernel RPC channel buffer size")
was already merged?


> ---
> net/sunrpc/cache.c | 41 +++++++++++------------------------------
> 1 file changed, 11 insertions(+), 30 deletions(-)
>=20
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index baef5ee43dbb..1347ecae9c84 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -777,7 +777,6 @@ void cache_clean_deferred(void *owner)
>  */
>=20
> static DEFINE_SPINLOCK(queue_lock);
> -static DEFINE_MUTEX(queue_io_mutex);
>=20
> struct cache_queue {
> 	struct list_head	list;
> @@ -905,44 +904,26 @@ static ssize_t cache_do_downcall(char *kaddr, =
const char __user *buf,
> 	return ret;
> }
>=20
> -static ssize_t cache_slow_downcall(const char __user *buf,
> -				   size_t count, struct cache_detail =
*cd)
> -{
> -	static char write_buf[8192]; /* protected by queue_io_mutex */
> -	ssize_t ret =3D -EINVAL;
> -
> -	if (count >=3D sizeof(write_buf))
> -		goto out;
> -	mutex_lock(&queue_io_mutex);
> -	ret =3D cache_do_downcall(write_buf, buf, count, cd);
> -	mutex_unlock(&queue_io_mutex);
> -out:
> -	return ret;
> -}
> -
> static ssize_t cache_downcall(struct address_space *mapping,
> 			      const char __user *buf,
> 			      size_t count, struct cache_detail *cd)
> {
> -	struct page *page;
> -	char *kaddr;
> +	char *write_buf;
> 	ssize_t ret =3D -ENOMEM;
>=20
> -	if (count >=3D PAGE_SIZE)
> -		goto out_slow;
> +	if (count >=3D 32768) { /* 32k is max userland buffer, lets =
check anyway */
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
>=20
> -	page =3D find_or_create_page(mapping, 0, GFP_KERNEL);
> -	if (!page)
> -		goto out_slow;
> +	write_buf =3D kvmalloc(count + 1, GFP_KERNEL);
> +	if (!write_buf)
> +		goto out;
>=20
> -	kaddr =3D kmap(page);
> -	ret =3D cache_do_downcall(kaddr, buf, count, cd);
> -	kunmap(page);
> -	unlock_page(page);
> -	put_page(page);
> +	ret =3D cache_do_downcall(write_buf, buf, count, cd);
> +	kvfree(write_buf);
> +out:
> 	return ret;
> -out_slow:
> -	return cache_slow_downcall(buf, count, cd);
> }
>=20
> static ssize_t cache_write(struct file *filp, const char __user *buf,
> --=20
> 2.21.0
>=20

--
Chuck Lever



