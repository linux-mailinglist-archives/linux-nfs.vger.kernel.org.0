Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02F32C6D4E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Nov 2020 23:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbgK0Wmr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Nov 2020 17:42:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51908 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732251AbgK0WmY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Nov 2020 17:42:24 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ARJEmP5042268;
        Fri, 27 Nov 2020 19:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=CT5pAs2J3lrRhLGZpVn9LaNyTB4z1l53ogqxPyPXkss=;
 b=LEsNCNFYGwgrZMf+nDv7hFssfinlomDj6t1jr24jtF7wntVsjxu7ytaMuYLQiWFqBMzZ
 tK1zpL2AHVq8Zp78uGqVgZBGHDLKMW/vSJ0ddR5wiAwwG/X5aq4pKXBf2AU3/wdmskZK
 l7a1VBGWbnbR191T9yCPCWvtG72GO5tS36Ftgys+8Lj6uN55NC33YjtSdMlSEX3I0SR4
 aDiyfby4YsNBR9+CNX03h9dbk7cyRWuIpafNEBr22bpwIEhC2iTV/l+kUvH2bglyyHfT
 BT82lzShSj4EJu3YurGYuCGLQZiXYh8soBtfmKS5EjXgWKYwDGMBUuIptCWMuM7Ihb/9 nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 351kwhjd4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 19:14:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ARJ6Afo029399;
        Fri, 27 Nov 2020 19:14:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 351n2mjrhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 19:14:47 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ARJEjre005676;
        Fri, 27 Nov 2020 19:14:47 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Nov 2020 11:14:45 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] sunrpc: clean-up cache downcall
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201127183831.25012-1-rbergant@redhat.com>
Date:   Fri, 27 Nov 2020 14:14:44 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EE331A2-2E73-4B3F-8787-4DAC2EEAF078@oracle.com>
References: <20201127183831.25012-1-rbergant@redhat.com>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270113
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 27, 2020, at 1:38 PM, Roberto Bergantinos Corpas =
<rbergant@redhat.com> wrote:
>=20
> We can simplify code around cache_downcall unifying memory
> allocations using kvmalloc. This has the benefit of getting rid of
> cache_slow_downcall (and queue_io_mutex), and also matches userland
> allocation size and limits
>=20
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>


Thanks, Roberto.

I see from linux-nfs history that Bruce explicitly asked for
this change, so applied for the next merge window. See the
cel-next topic branch in:

 git://git.linux-nfs.org/projects/cel/cel-2.6.git

or

 https://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dsummary


> ---
> net/sunrpc/cache.c | 41 +++++++++++------------------------------
> 1 file changed, 11 insertions(+), 30 deletions(-)
>=20
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 20c93b68505e..1a2c1c44bb00 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -778,7 +778,6 @@ void cache_clean_deferred(void *owner)
>  */
>=20
> static DEFINE_SPINLOCK(queue_lock);
> -static DEFINE_MUTEX(queue_io_mutex);
>=20
> struct cache_queue {
> 	struct list_head	list;
> @@ -906,44 +905,26 @@ static ssize_t cache_do_downcall(char *kaddr, =
const char __user *buf,
> 	return ret;
> }
>=20
> -static ssize_t cache_slow_downcall(const char __user *buf,
> -				   size_t count, struct cache_detail =
*cd)
> -{
> -	static char write_buf[32768]; /* protected by queue_io_mutex */
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



