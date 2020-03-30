Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49C7197F0C
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2020 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgC3Owu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Mar 2020 10:52:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50862 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgC3Owu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Mar 2020 10:52:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UEqWSe013635;
        Mon, 30 Mar 2020 14:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=kMC4U/Ms+NfU2AWkx+VH44TYA7qDNnFYjVBE9WI71QA=;
 b=qoB7jhbJAZcVUqZwcEguopm9wZoE8f+oqXR7RQxEebTC5KPObOmBlDJJMu09/NVToBHl
 VSvCTRTkG+81+TyfVRbt3nhKMH+yGZnRKhdfCPDkxOVmwzU3S5oLr7R5jj/6LE4NB/0P
 p5Or7IYV0HpjejNchhUbg0C+c9xMIWpi2fAct8asrG92I8hHDnvSo2DaXOgip3lxAK8C
 kX5gnRXm/4H+lrAfMI3YRTcKIxs9aFAgK1KbuUJ7MW0dHEtd5EXyWpfpvfnFqfq4/0is
 xC+wzagivjY7fdgIwgbnGSfAcohtUZV4av3lv7goH5x2rdq+EuwhjnR+RA0A9aX7WTqb LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 303aqhamj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 14:52:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UEp6Nm078912;
        Mon, 30 Mar 2020 14:52:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 302gc9h4xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 14:52:43 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02UEqfAT026457;
        Mon, 30 Mar 2020 14:52:42 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Mar 2020 07:52:41 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] nfsd: memory corruption in nfsd4_lock()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <80e1506f0a997f1f925990fe12c4469947b7b184.camel@kernel.org>
Date:   Mon, 30 Mar 2020 10:52:40 -0400
Cc:     Jeff Layton <jlayton@kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BDFAB55-80A2-45D0-BC3B-CFB626AD2017@oracle.com>
References: <7E365A05-4D39-4BF9-8E44-244136173FC7@oracle.com>
 <d169e942-03e4-0a4b-8c45-56f4c26cd45c@virtuozzo.com>
 <80e1506f0a997f1f925990fe12c4469947b7b184.camel@kernel.org>
To:     Vasily Averin <vvs@virtuozzo.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300141
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 30, 2020, at 6:22 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2020-03-27 at 07:50 +0300, Vasily Averin wrote:
>> Dear Chuck,
>> please use following patch instead.

Somehow this did not make it to my inbox on Friday, but Jeff's
Reviewed-by did show up today. I'll apply this one, thanks!


>> -----
>> New struct nfsd4_blocked_lock allocated in find_or_allocate_block()
>> does not initialized nbl_list and nbl_lru.
>> If conflock allocation fails rollback can call list_del_init()
>> access uninitialized fields and corrupt memory.
>>=20
>> v2: just initialize nbl_list and nbl_lru right after nbl allocation.
>>=20
>> Fixes: 76d348fadff5 ("nfsd: have nfsd4_lock use blocking locks for =
v4.1+ lock")
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>> fs/nfsd/nfs4state.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 369e574c5092..1b2eb6b35d64 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -266,6 +266,8 @@ find_or_allocate_block(struct nfs4_lockowner *lo, =
struct knfsd_fh *fh,
>> 	if (!nbl) {
>> 		nbl=3D kmalloc(sizeof(*nbl), GFP_KERNEL);
>> 		if (nbl) {
>> +			INIT_LIST_HEAD(&nbl->nbl_list);
>> +			INIT_LIST_HEAD(&nbl->nbl_lru);
>> 			fh_copy_shallow(&nbl->nbl_fh, fh);
>> 			locks_init_lock(&nbl->nbl_lock);
>> 			nfsd4_init_cb(&nbl->nbl_cb, =
lo->lo_owner.so_client,
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



