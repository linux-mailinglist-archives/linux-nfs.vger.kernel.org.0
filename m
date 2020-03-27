Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AD195AE7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 17:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgC0QRh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 12:17:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54424 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0QRh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 12:17:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RG9IDw058327;
        Fri, 27 Mar 2020 16:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ifzydEkRzcd+TfN60tproxdUjK1ynrT0NgdmlzigR3s=;
 b=r1xzZARy/9t34VBDnKrzhLEF5NxL2v89Gg6qNMgKrCWkfz42IPqxRZWGsza5uLxWC+/i
 f7nD4XSmLxOxGF5Mcdgo1EylGAP+EcQ0f5LsEapiMABce4nWBE+GqMDrmLhQaooFVlt6
 4dCArhmUeWydgbqlxMqWFxTtQn64/UxxTpsOczNQb3T5Y0wqou6iwt3VRiD/6leQpL2Q
 eiSdjDAOLSwD6dDLbHnMLMWigOQv6EjOrJZrObNbnPpT7ptaDpMeqWm024sWWRrXMdyI
 3/QfOPHzMwX/5xY3ONrB8HBkFnbxztyZ0PPOkpodh7kSswi/CihLM3x8H75uI2EJ0Rq/ 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 301m49g97g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 16:17:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RG7uSL092425;
        Fri, 27 Mar 2020 16:15:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3006rajju6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 16:15:26 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02RGFKOG014819;
        Fri, 27 Mar 2020 16:15:23 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Mar 2020 09:15:20 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] SUNRPC/cache: don't allow invalid entries to be flushed
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200327155309.GA135601@pick.fieldses.org>
Date:   Fri, 27 Mar 2020 12:15:18 -0400
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>,
        "kinglongmee@gmail.com" <kinglongmee@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <413957A3-FDF3-4201-8131-7BBAFDDFD88D@oracle.com>
References: <20200114165738.922961-1-trond.myklebust@hammerspace.com>
 <20200206163322.GB2244@fieldses.org>
 <8dc1ed17de98e4b59fb9e408692c152456863a20.camel@hammerspace.com>
 <20200207181817.GC17036@fieldses.org> <20200326204001.GA25053@fieldses.org>
 <1a0ce8bb1150835f7a25126df2524e8a8fb0e112.camel@hammerspace.com>
 <20200327015012.GA107036@pick.fieldses.org>
 <80c83f5543d7d758a165be167d3bf0b2175e57f8.camel@hammerspace.com>
 <20200327155309.GA135601@pick.fieldses.org>
To:     Bruce Fields <bfields@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270144
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 27, 2020, at 11:53 AM, J. Bruce Fields <bfields@redhat.com> =
wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> Trond points out in 277f27e2f277 that we allow invalid cache entries =
to
> persist indefinitely.  That fix, however, reintroduces the problem =
fixed
> by Kinglong Mee's d6fc8821c2d2 "SUNRPC/Cache: Always treat the invalid
> cache as unexpired", where an invalid cache entry is immediately =
removed
> by a flush before mountd responds to it.  The result is that the =
server
> thread that should be waiting for mountd to fill in that entry instead
> gets an -ETIMEDOUT return from cache_check().  Symptoms are the server
> becoming unresponsive after a restart, reproduceable by running pynfs
> 4.1 test REBT5.
>=20
> Instead, take a compromise approach: allow invalid cache entries to be
> removed after they expire, but not to be removed by a cache flush.
>=20
> Fixes: 277f27e2f277 "SUNRPC/cache: Allow garbage collection..."
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Thanks, Bruce. checkpatch.pl is complaining loudly about the style of
the short commit descriptions. I'll fix those up before applying it to
nfsd-5.7.


> ---
> include/linux/sunrpc/cache.h | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/cache.h =
b/include/linux/sunrpc/cache.h
> index 532cdbda43da..10891b70fc7b 100644
> --- a/include/linux/sunrpc/cache.h
> +++ b/include/linux/sunrpc/cache.h
> @@ -209,8 +209,11 @@ static inline void cache_put(struct cache_head =
*h, struct cache_detail *cd)
>=20
> static inline bool cache_is_expired(struct cache_detail *detail, =
struct cache_head *h)
> {
> -	return  (h->expiry_time < seconds_since_boot()) ||
> -		(detail->flush_time >=3D h->last_refresh);
> +	if (h->expiry_time < seconds_since_boot())
> +		return true;
> +	if (!test_bit(CACHE_VALID, &h->flags))
> +		return false;
> +	return detail->flush_time >=3D h->last_refresh;
> }
>=20
> extern int cache_check(struct cache_detail *detail,
> --=20
> 2.25.1
>=20

--
Chuck Lever



