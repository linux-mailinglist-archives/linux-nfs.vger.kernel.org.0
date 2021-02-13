Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E252531AE83
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 00:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhBMXbA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Feb 2021 18:31:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53738 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhBMXa5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Feb 2021 18:30:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DNTZsh185513;
        Sat, 13 Feb 2021 23:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UBrs/Q5/ureWbuxa/eiiib9O3Q0U98jMODMT6+TozBM=;
 b=C4ii506MMiK8S3Exj3wXMlOUodtTuSPFGdfW7PDTfBXxnr19LAQWAy4avpFGTFvXJosm
 aKBbMqA8GAOtCc2fewBA3uIrxZhbb3XYpCsum8O+mTaanWFXsbq59fr9yub240rcvSd4
 T2qBBtpX44e0z95CWmBJyfIRwpLqTmtLUtZQ8CoNjRqVOf2CBvDfeHQ4jZBjvHZ6Xe3e
 vEkeL4erh63fC+nrR2Zfd5VJmBW6WnQn3uqD1G7iBqpmZ/HI1Bs+7tQNd988ruvz9NwJ
 ZRYNvasAgADAQmIMY0AsupEWufnM/N/XhtyDklvbBzDu8F5OKNbmJo/+eIOjPuMIYPkq +g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36pd9a0kw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 23:30:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11DNTvr8107347;
        Sat, 13 Feb 2021 23:30:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 36p6k046f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Feb 2021 23:30:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC9Ew0AMSMTRzP+wFSGjCzcKxfNXATDoDGP/7MjRdzEISDNcH5AJdbqcLJswbS1QlWgsAXlBUeYvRHOfTxH0jak/DOdbrPaRFU+ePdAM18xOkBMpNBmazI1nn7uJko2KpXTubXqPJrWN/UXQpNDbJOW0QVXIu5IXiSyuF3m1TNgYBoDbnQQDGuelkx3xgsyMEd0JV0NdSJ1is+BJybHMrpB+9PXzlrm4nj4wwX+mkQxrDYp+xiqycBpnMeHEMmXaax3AU3q3U34TsvQcATS5wP1SD82HfPYc1BlXlrrksSuMol6qz3/QvyyjSYpLHvM6sck0qcKNVacxej1TAvndRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBrs/Q5/ureWbuxa/eiiib9O3Q0U98jMODMT6+TozBM=;
 b=M7zmE6yfUS/AbPBFlP04lH5CZC+aY7d0J8Tjovl8gkQ/+LfLjfCvoOIuqLT7FLp/0DGTGa+lQlO/lyJ309HlPvQkqD4zVJoCt1Az3JPifo3zgNFrjOJWVecN9LkxUhzniwA8qtNwezk6t+JwuBiDlFohYZXQhuFJTZbGWYgd9Wr2qz/8syOAEguP0jzii2ZGnzNIbQ5yq9AC+msKHeF9xnUrQATUSqcZhp+4gAwVRPdrvpP6KtjkX0eogz0zAcGoKR/8shlwFpXKHVjuS0N/rItzwSoOviCgIHTJbl/DZ+mSX2qrCHO35Me9urC5y6W4TJZ/AD43SWx8z1q2l/LQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBrs/Q5/ureWbuxa/eiiib9O3Q0U98jMODMT6+TozBM=;
 b=bwIu1RVfe30Bm2w3DjD0JiWDs0jDgalTmLkHGDnHSigIJDEHjZ7T4fpdNBXYTHMHpwnzcQyWpfmaB9SmOoItbFAIhVEw/BtXKhobaw9N5vG2iKxf7QiK5XySFjPfuaYEtNrSuBguvAJmWTQ9RUyU+6Fzhrs6JIFObCKzWnThfvU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2645.namprd10.prod.outlook.com (2603:10b6:a02:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sat, 13 Feb
 2021 23:30:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.038; Sat, 13 Feb 2021
 23:30:02 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpWoMoAgAAEs4CAABZCgA==
Date:   Sat, 13 Feb 2021 23:30:02 +0000
Message-ID: <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
 <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
 <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
In-Reply-To: <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77dab3f3-e186-419a-7de2-08d8d077497b
x-ms-traffictypediagnostic: BYAPR10MB2645:
x-microsoft-antispam-prvs: <BYAPR10MB264569D9BF3325C9D32E721C938A9@BYAPR10MB2645.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ii2nmUoCTpH0ZcbDXU1VFl4rtev6vnV+d0PdLEYClyVtM3A3Czw2+VDJr16h65G89zW9SqtRDDUFTG8IzoGZ7CBBmpuUIuKO9F+Fr2G2U5QLwcfXT5mtG00BH7Fb52xkcCN2wHywdJBKSblA0EWKqx4OegZ74gNmWbHFcDZ4XPtog50kYkGHyL1dtl0Gp+5BAANtj/qVMC1vyDPNzSH25vP6y8gFZmPNFAF07njqdIY5SwTBGDTJiNdDATHD+OwSql5d2cNcGpRFL499TaqBkljaaGPLiupBiPU+Q3YrLoMWNkhVW+PBjPVUN5HCfl3k+9c8zjVTIQBcarH9JyBIKDjA2iATr0VmAuNFOYMBKX7cI7JvwecwNFQEd/dBP+gZycN1wBzfGA3zE3RcDFtDns4u7HGnfhDy+wi9VbRp0qqyTnHMi58i3QBMnfNzFN4iy3vExHp6doI/+UNfxFZE792pOCNzJeFSrMMs14pSCCbDVd9XH/1GQ5AHgYB8bGLfbKIv4r7KliCM3DW8wguYJvQAfRHifEotdqvAcdt/m3iNBbJwWnNEZMbZ37K9l9ngnLd7Ki6n6AkGZ0i2xy8Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(366004)(376002)(66476007)(54906003)(2906002)(4326008)(33656002)(316002)(66556008)(2616005)(6916009)(66446008)(91956017)(6512007)(26005)(83380400001)(8676002)(6506007)(53546011)(8936002)(66946007)(186003)(76116006)(64756008)(86362001)(478600001)(71200400001)(6486002)(5660300002)(36756003)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QObLIxjrW3ugydfUtQiWF/Hm8DkZpQFL/oQMl3Xk6M9sVmESUpbilH+MxHvt?=
 =?us-ascii?Q?jAETSqU0AnTUq6QcEPpvkXl5YqBSaEhIC0xddg6srYZT1mkyqOcKR9/8dP3w?=
 =?us-ascii?Q?k+g4gPIj/2cVfhPJ8aj/mDytjhldhhVUXwo6pwsUJB2jDqBEc1u7up5GUPrv?=
 =?us-ascii?Q?LH8FCBqEI4yWFk/rqsby50ornk/TESqjaX1SYsxj1ExiGQ8jX4gnxh7PY5Ex?=
 =?us-ascii?Q?pGMoNRZe/4BHU2l/2gF/S+ZvZSKb+yP/sD4SN1lpbsvuWl6lQZdDrKGp1/r7?=
 =?us-ascii?Q?AjI8/foH8SL1CmLalYRiswi/gR4KJNWnABIQQh71+ZJcGZMLRyV392US5N8F?=
 =?us-ascii?Q?noW0otmPm9qMXHdgXnimx29tIYm0P3FPzb/5xWDmTN9BJsK6zACa58cMVBWc?=
 =?us-ascii?Q?oDBv9AhYSrwHJASaWi12v83WqB11ZenGh0Au6IGy3hfo2cR2fPKY5sTWbJaQ?=
 =?us-ascii?Q?4Z6iLbprZizFpiKqxzpi+xwTiBcVctvJqdPp8uyc633eJEhMS6kX/y8tfC40?=
 =?us-ascii?Q?gLr9bYFDs3KrQt9ZBfl4in4a7LEgB4R5+FWsQB/J8EPetW+XPJOn5rd8ir4Y?=
 =?us-ascii?Q?Cs6Xvpf2iuAafwAVbnGBeUlM10cGVKMi1O0MMHP3Cp7YG1+n8CT3Tku6Krm9?=
 =?us-ascii?Q?9qPQhUO16sbA+oYXSVsswVfypc2qDi7tHU1eusLF7oYYl/sFN4wPdFFJCNco?=
 =?us-ascii?Q?5vTCih3IZx0kHzsjKAXlER3AeNjF3P9twGVKEDduwAPgVQGbXnEK6ffHvXb3?=
 =?us-ascii?Q?cRm0CZC1D5xY2luwDKb0iGMC0L9iNwdP0Qn/fv+dz9ffrw+GsPx12zXmHnIV?=
 =?us-ascii?Q?cWmPRR+7ih5okcuh728LLwGj3x5ozgujLm+vdm2Yq24LuoJo8s0xIJ9zCwPK?=
 =?us-ascii?Q?t0PPKV0PWvwYa8k40KTCvUcnpZ1vGthtiMuKusL+HfkndNpDELc4qy5yKGwp?=
 =?us-ascii?Q?D0/1ySmICssmxb8plIlNNGCLYW45x2cTVc+9lazIHKHHl7pLNqKdbuZ5wf/h?=
 =?us-ascii?Q?feg1huS4kYhNLPAhb6t5SGnFnDzP4yh/wZPuYLoWiWmClDw5N3qyHWxIrSX6?=
 =?us-ascii?Q?dsEhDTokC0E9fX4MFycSIKDr5Ksv8H7POfiwvuQ5w9+fHP2j5L+wi4eH894i?=
 =?us-ascii?Q?caFeYmlz3Q0B7jCFTwzz5qrk546SSUx141pSh5KomPqSGP7HddoaBwsriDDj?=
 =?us-ascii?Q?i6mm9HAc5QAAM8uBHPfmyTOGvZDindm3s6Ql/7PDo9gXrESZFeYHCyYAmAfe?=
 =?us-ascii?Q?8uciRniIK2aI+x9/rbVNONQHmufQOXAfru5uL/287rjNTvHfUfEBz8tXMtvI?=
 =?us-ascii?Q?x+katEleCktQ1REi8lRVAJ7C?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFBD76DF31B89C40BD09948E371C4CA2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dab3f3-e186-419a-7de2-08d8d077497b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2021 23:30:02.4783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbJyQt3NandKu9HdwfQxTnjkoweviDSkrM8uS4IRkGRifapAhMkEMlfRzVjkta/tGNwVX+63b8cFqZOGglu6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2645
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102130216
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9894 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130215
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 13, 2021, at 5:10 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sat, 2021-02-13 at 21:53 +0000, Chuck Lever wrote:
>> Hi Trond-
>>=20
>>> On Feb 13, 2021, at 3:25 PM, trondmy@kernel.org wrote:
>>>=20
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> Use a counter to keep track of how many requests are queued behind
>>> the
>>> xprt->xpt_mutex, and keep TCP_CORK set until the queue is empty.
>>=20
>> I'm intrigued, but IMO, the patch description needs to explain
>> why this change should be made. Why abandon Nagle?
>>=20
>=20
> This doesn't change the Nagle/TCP_NODELAY settings. It just switches to
> using the new documented kernel interface.
>=20
> The only change is to use TCP_CORK so that we don't send out partially
> filled TCP frames, when we can see that there are other RPC replies
> that are queued up for transmission.
>=20
> Note the combination TCP_CORK+TCP_NODELAY is common, and the main
> effect of the latter is that when we turn off the TCP_CORK, then there
> is an immediate forced push of the TCP queue.

The description above suggests the patch is just a
clean-up, but a forced push has potential to change
the server's behavior.

I'm trying to assess what kind of additional testing
would be valuable.


>> If you expect a performance impact, the description should
>> provide metrics to show it.
>=20
> I don't have a performance system to measure the improvement
> accurately.

Then let's have Daire try it out, if possible.


> However I am seeing an notable improvement with the
> equivalent client change. Specifically, xfstests generic/127 shows a
> ~20% improvement on my VM based test rig.

>> (We should have Daire try this change with his multi-client
>> setup).
>>=20
>>=20
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> include/linux/sunrpc/svcsock.h | 2 ++
>>> net/sunrpc/svcsock.c           | 8 +++++++-
>>> 2 files changed, 9 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/include/linux/sunrpc/svcsock.h
>>> b/include/linux/sunrpc/svcsock.h
>>> index b7ac7fe68306..bcc555c7ae9c 100644
>>> --- a/include/linux/sunrpc/svcsock.h
>>> +++ b/include/linux/sunrpc/svcsock.h
>>> @@ -35,6 +35,8 @@ struct svc_sock {
>>>         /* Total length of the data (not including fragment
>>> headers)
>>>          * received so far in the fragments making up this rpc: */
>>>         u32                     sk_datalen;
>>> +       /* Number of queued send requests */
>>> +       atomic_t                sk_sendqlen;
>>=20
>> Can you take advantage of xpt_mutex: update this field
>> only in the critical section, and make it a simple
>> integer type?

I see why atomic_inc(&sk_sendqlen); has to happen outside
the mutex. However, it seems a little crazy/costly to have
both of these serialization primitives.

I haven't found a mutex_unlock() that will report that there
are no waiters to wake up, though.


>>>         struct page *           sk_pages[RPCSVC_MAXPAGES];      /*
>>> received data */
>>> };
>>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>>> index 5a809c64dc7b..231f510a4830 100644
>>> --- a/net/sunrpc/svcsock.c
>>> +++ b/net/sunrpc/svcsock.c
>>> @@ -1171,18 +1171,23 @@ static int svc_tcp_sendto(struct svc_rqst
>>> *rqstp)
>>>=20
>>>         svc_tcp_release_rqst(rqstp);
>>>=20
>>> +       atomic_inc(&svsk->sk_sendqlen);
>>>         mutex_lock(&xprt->xpt_mutex);
>>>         if (svc_xprt_is_dead(xprt))
>>>                 goto out_notconn;
>>> +       tcp_sock_set_cork(svsk->sk_sk, true);
>>>         err =3D svc_tcp_sendmsg(svsk->sk_sock, &msg, xdr, marker,
>>> &sent);
>>>         xdr_free_bvec(xdr);
>>>         trace_svcsock_tcp_send(xprt, err < 0 ? err : sent);
>>>         if (err < 0 || sent !=3D (xdr->len + sizeof(marker)))
>>>                 goto out_close;
>>> +       if (atomic_dec_and_test(&svsk->sk_sendqlen))
>>> +               tcp_sock_set_cork(svsk->sk_sk, false);
>>>         mutex_unlock(&xprt->xpt_mutex);
>>>         return sent;
>>>=20
>>> out_notconn:
>>> +       atomic_dec(&svsk->sk_sendqlen);
>>>         mutex_unlock(&xprt->xpt_mutex);
>>>         return -ENOTCONN;
>>> out_close:
>>> @@ -1192,6 +1197,7 @@ static int svc_tcp_sendto(struct svc_rqst
>>> *rqstp)
>>>                   (err < 0) ? err : sent, xdr->len);
>>>         set_bit(XPT_CLOSE, &xprt->xpt_flags);
>>>         svc_xprt_enqueue(xprt);
>>> +       atomic_dec(&svsk->sk_sendqlen);
>>>         mutex_unlock(&xprt->xpt_mutex);
>>>         return -EAGAIN;
>>> }
>>> @@ -1261,7 +1267,7 @@ static void svc_tcp_init(struct svc_sock
>>> *svsk, struct svc_serv *serv)
>>>                 svsk->sk_datalen =3D 0;
>>>                 memset(&svsk->sk_pages[0], 0, sizeof(svsk-
>>>> sk_pages));
>>>=20
>>> -               tcp_sk(sk)->nonagle |=3D TCP_NAGLE_OFF;
>>> +               tcp_sock_set_nodelay(sk);
>>>=20
>>>                 set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
>>>                 switch (sk->sk_state) {
>>> --=20
>>> 2.29.2
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



