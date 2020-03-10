Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176AB18089F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2020 20:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgCJT5s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 15:57:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJT5r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Mar 2020 15:57:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AJsvLk171914;
        Tue, 10 Mar 2020 19:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=5TdS/swJ2qCUSYqzHswQW79s0rEWYtxS4lEC4gF9SJM=;
 b=WxewXYrAgof5YYAWzPkuodDAriD4p75kQgWin5XLaq9LaMZrTSMlygDpwdmK1kLFDVAI
 L//PlXziWxrlVUyiwP0ffHeNR0L+2TtAieWrYMfqUrp7IK1qF8hKGvRF+ri6GD74HaoI
 R8P0kxMkZHeQYfqoB1W34fqU4wn9fqRsynDpDZ/UgrXwTuf6jJKWrDr3/n5TrLGFOQB0
 c8tQL1ZlmR/p9mG12NS0M9K5OpQu4RvxYRV2ABXOnR8H2hd8y+HsrbSNSGmCOAECVpvW
 sXoz/Nl8s4xX4cfzZhn2r7MCsaux4KIi+9kHVyZDJ10j4ndpPTsIW0Fm1ClT2Nw4xRvf yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ym31ufsdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 19:57:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AJuNMG181179;
        Tue, 10 Mar 2020 19:57:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2yp8nv8eu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 19:57:39 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AJvb8x000982;
        Tue, 10 Mar 2020 19:57:38 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 12:57:37 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH] fix krb5p mount not providing large enough buffer in
 rq_rcvsize
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyHegg96s7mr1YeoPbVd0UA7_cd2GEPYNWx98uUcx-0ARw@mail.gmail.com>
Date:   Tue, 10 Mar 2020 15:57:36 -0400
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF0659E0-8F04-4005-96D0-5D513881EDFE@oracle.com>
References: <CAN-5tyHegg96s7mr1YeoPbVd0UA7_cd2GEPYNWx98uUcx-0ARw@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100115
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga-

> On Mar 10, 2020, at 2:58 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> Ever since commit 2c94b8eca1a26 "SUNRPC: Use au_rslack when computing
> reply buffer size". It changed how "req->rq_rcvsize" is calculated. It
> used to use au_cslack value which was nice and large and changed it to
> au_rslack value which turns out to be too small.
>=20
> Since 5.1, v3 mount with sec=3Dkrb5p fails against an Ontap server
> because client's receive buffer it too small.

Can you be more specific? For instance, why is 100 bytes adequate for
Linux servers, but not OnTAP?

Is this explanation for the current value not correct?

  51 /* length of a krb5 verifier (48), plus data added before arguments =
when
  52  * using integrity (two 4-byte integers): */


> For GSS, au_rslack is calculated from GSS_VERF_SLACK value which is
> currently 100. And it's not enough. Changing it to 104 works and then
> au_rslack is recalculated based on actual received mic.len and not
> just the default buffer size.
>=20
> I would like to propose to change it to something a little larger than
> 104, like 120 to give room if some other server might reply with
> something even larger.

Why does it need to be larger than 104?


> Thoughts? Will send an actual patch if no objections to this one.
>=20
> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
> index 24ca861..44ae6bc 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -50,7 +50,7 @@
> #define GSS_CRED_SLACK         (RPC_MAX_AUTH_SIZE * 2)
> /* length of a krb5 verifier (48), plus data added before arguments =
when
>  * using integrity (two 4-byte integers): */
> -#define GSS_VERF_SLACK         100
> +#define GSS_VERF_SLACK         120
>=20
> static DEFINE_HASHTABLE(gss_auth_hash_table, 4);
> static DEFINE_SPINLOCK(gss_auth_hash_lock);

--
Chuck Lever



