Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699043FBB60
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbhH3SD3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 14:03:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55632 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238134AbhH3SD2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 14:03:28 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UGigfM032706;
        Mon, 30 Aug 2021 18:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kQz3zGKadex6RYSP1KKhIl1SMIjPU7QubS+WoU9JVuY=;
 b=BeOHxEWH6MYyCmav3MYqGdqYcZPqJeVsslZ2Cm9OhrhOYVpfwZyfKZGe+QxQbAUrslm2
 GsXcjiCh2EyYdo0MQxhb6Hmk0UUc6W4741RzID3oT43XSz8+EeWyOSrM5MIR7mON5zrm
 za5AnalLfXJ7ff9WcLdE99aVN1oVZiqjOD+fkOY91pmYMu0lpZfjxVEOMbZUPj0J09ie
 bLEvSbpNPyhDkRYoD+8O59H0q4OrUznvBo+GsoN2vEzVQfo5kDvd1b8vboPbRwi2pnpU
 f1o5xq3wEkO5kjSXwV07gN+OUmKvMQ2/CeqpfRHB7tG5DGLUqSK6HpQMDPGKIctUVrtm VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kQz3zGKadex6RYSP1KKhIl1SMIjPU7QubS+WoU9JVuY=;
 b=LwlMdjPyY+GFebkBftuDOqTPjWFd+odgqA1p0CsqF5Zy2iJQ78BgLjuBJqgrKXFih1q5
 xJmhHeNQEky4S784aqzSbKBKQNd4YTRJxctWAqU90Ps/bq+Xa3cT/I9pbi+w1kYQod19
 JekH5D417Q0aEEm3hwhr4sA6qRU4+AOh5lP5Uip2YQaLWU1/A/fjzokzSZc5kcPBsEQv
 jJLCA+N4X7N4ojN2ZmVBcghertwKitx4OFmTOra11eoswXkMIooupij3JLlds7CPR/IM
 3XRd73F8/qZ0AjZ6Xl/jTuNiBJzrBN4fIaSdRhPDyw7CbkW6Ca1pkzS+zD8/XLpS+8uf sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxsj9et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 18:02:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UHtmnY156283;
        Mon, 30 Aug 2021 18:02:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3020.oracle.com with ESMTP id 3aqxwrux78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 18:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9J2zaK6eWIVjhe880Mi4f9K3ogKFEoLMP7OMcGfYwacg3KAKNbwLABBf05SiAAlQK8SybIVf8Q2Nc1sr/7XI5ovvMOZb1ZmFQ4gALAPGkU2wd8Ei14hFUKg0Zols+eTtY5NS+BavUKjZIK4Acvbv3zHK2CxqBykWc/kwVr9kp36Oabf2xtY6EJUAhftU7EFWNHE/hCFpuNfQBWCXFjO9oEJOBeqBmykFPR6YMvStY8jSE3kSH2fjplnTaBg+aFVRTelDtht1A0JixHraYZAEIFhjsdIVOw51v15e4bSQxXexC10U54SSf62aklQtsEyr+TZUayB3kxzZcZ4mxnE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQz3zGKadex6RYSP1KKhIl1SMIjPU7QubS+WoU9JVuY=;
 b=H7dAffMZrVz8SHpJP0qMIN68HhknAY0IC5QfKEXrDkmXaq7Duz0OTSpQ5lHAroC8iqAbE+IHJUqoyzHTMbydakhBfQUCqUKeBdIdDcJtAiAeeDHYQVUw+VMPIw86vW/i5Ty3jx1JuL11wCtqd1Z+UphpV5Kcnz9+9aL5CCt8/S4AMm1zRGEg88SdXGmNfreueAaijalRotcJBR9o1RcvVaSrAa0yhTF5iUUR9dQmAjm1CVh4ZFskCLO5rN6mbSWVaDn9SIJtnZfD7YYfZC8pdndtI22dx1shWoqzKyfDVH/Ie3xt3z3Ov4GHB8hy++3nGcy69hXmK5EAkHEYcwgvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQz3zGKadex6RYSP1KKhIl1SMIjPU7QubS+WoU9JVuY=;
 b=RslzPv5X1ecrpkPNzpFFo8fUXL5IKnAWs1x3i04ZllwtBgikVEWJ0Ys4P9UQQQIwtF4AkaMJowszpWs9sCWeK/Son1ysB+10VNdO7+gdBL1E7zpkzgxxFKbUQtpFCzI7kdFXkZNz71+m81x7eUqGBfcwLI0xVNOrhpfSjg882Bg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3383.namprd10.prod.outlook.com (2603:10b6:a03:15c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Mon, 30 Aug
 2021 18:02:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 18:02:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Topic: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Index: AQHXnb+EPQ6bfsCh/km34j6ENph6pKuMRqKAgAAFyYCAAALCgIAAB7UA
Date:   Mon, 30 Aug 2021 18:02:26 +0000
Message-ID: <C73DE4AF-9C1D-4694-839B-D88EABAA6DAC@oracle.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com>
 <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
 <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
 <04f975f95126921f3d239a7a9d80ced2d88b05ff.camel@hammerspace.com>
In-Reply-To: <04f975f95126921f3d239a7a9d80ced2d88b05ff.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f35a846-2dac-4082-350c-08d96be053b1
x-ms-traffictypediagnostic: BYAPR10MB3383:
x-microsoft-antispam-prvs: <BYAPR10MB3383A2D46232E9A6EECA485A93CB9@BYAPR10MB3383.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnDZMKQk1Il47OtRNVDaCLpoEmP5CG8sm5QwG9kZ1IRwKTS/3/FkYLi57+I1o10GBv5uV++US2UVDOuw+ZNdjwYZ9SlQc96KhTLtGqi6WGbtJeaHPbyEUFVYbHLK3aYX02Fd5ZJKDSgdilAtu/QhzewR5K5kypk13GlqyFvZwncGjv0THfOB4b4ekyPi4yHu5VVrIkSWjIcJKSJ/fwY2hONN4stmB655FyXrCpbb23Hnbam5MKaZ/Aq+/XXQlr2//D9Raero8kFHBrFg1EYAdbJ/dJLUOLTple1M2dMFo936QmuCetTuddTgPN+qgE3Ad+uqB5uSLk2MDwY5O6+kmDgY180Tp4vAYWjhXGqs+ircWAJCMpb5s9u+5Tet42W2bhsZjVM5B+xjrDChcAqJMrO/9rMhK00/L8q0rIq5fx30ZRhdZInHTb5faUjDDILT1xjJBV9bvHXDV57cUqN+q5tHcibB5db0rRoanlgCf5jD/qoZbAjgQssaFT79lDbtSoQkc6hoXxzIVXgZBd8Su7rf7ipGpVw5kC2FVF8qYUaXKzq6E0J2YDkygaJj16kafGkEqxhIrTohvzgXzScTILoQ7JWrTGf+I9SU0dZ/EkzuyYYzq6jLKV2OIQ07lTzFwm6de/KDLaS0wJ61/PX2J/OpsMNfywK/UEGL2+bL6hWI4Oc+05gi/uSs8XFYALzcgCo0w7i39VvDpFShqB4FrUgfbcyReOORxYta7EmHA54PXqUZb24s5WFvH4GTFNoQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(366004)(39860400002)(376002)(6486002)(86362001)(6916009)(36756003)(4326008)(122000001)(2616005)(478600001)(38100700002)(2906002)(91956017)(76116006)(38070700005)(71200400001)(6512007)(5660300002)(64756008)(83380400001)(26005)(54906003)(33656002)(53546011)(66556008)(66446008)(8676002)(8936002)(6506007)(316002)(66946007)(66476007)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EHm9YNZSB7eDH/ynGkan4J28Ccn1h7gWZpz8o7KUecjfbEiaP/U5HspMLGac?=
 =?us-ascii?Q?b77Z+WsHq6kCQK/4x6LRSrFft8Vg5lSkCMepZdH8b5YaQfs6zQmek3eeYrJs?=
 =?us-ascii?Q?VOhRrQUVMEoQficbkRNOZkIMt8kPsq7pAX+WxELF/iJ3LXsuWPbiHQt0GFLj?=
 =?us-ascii?Q?7tRSggzcrZiheDxuu/I0YsBC//StHn7ZnZiLESI/Lav6eHM8AvWFM4oxCB/z?=
 =?us-ascii?Q?oproDlOE49zBnnyfy1tcxY0A6rzwLQfMAdpZY7LrguwGoctXCktHDtllkE0i?=
 =?us-ascii?Q?gl7TZRmjQwhIwsea+qSQjr7M3x+DwypLniijGdaFwsG+EeQeOOwfW3lK7E+u?=
 =?us-ascii?Q?Se95eYNDau9s8/2A9iFG4hJXMFauaNSfedJPjTX/wFAyTwk/rKFKDOswRzVk?=
 =?us-ascii?Q?y22xoQAeHJ1l2Auqeas/Y7ba+DsGnrEtvqxz+iuH05QLH1/D8gvwn5iodNfA?=
 =?us-ascii?Q?l+18Wv/1Nxk22NkkPTorgxF/7kfgIBrPdp8kt9TZ043qZ6Psf4uhvRQsBJtx?=
 =?us-ascii?Q?OJWr128L9VSND9fx+a5S4G2YZwXGG+H7SbcqDb6eASEt8yXNh/K0NhNVgeJj?=
 =?us-ascii?Q?J7/cGxt4XnyFKN4oN5a0frbSIDVhwHrgcRX1cpOspy7MsrTnkdRBHfeg0Kqo?=
 =?us-ascii?Q?Tllu0UVl6xw44vej/21vjBpp2JnqmfLM9AgNBFMrIV01N3ZeOGzqMF2RlD4J?=
 =?us-ascii?Q?mcX9VB72Cmsf5jWwyXCQHz/2TidK20qHBKHH5iRkm2teKnY/YPFAsLmd8mv2?=
 =?us-ascii?Q?5v5HHTvpMzbaLqu/GujFiwWqVyfXDP33QzkaC6qZgh6+Y5h2qFBhrTVMd/RG?=
 =?us-ascii?Q?MFDD2VCJlatiPsyQSyTMKWMMaeGsz8tYYRbhKcC01bGMWxbUUnXQrLvm7FCg?=
 =?us-ascii?Q?pbQYQlp9f7tCtWbgCmi9Gog5LfnTlW9kGJCWMqjVuKqfiZ+EjV3cMSYmLvWW?=
 =?us-ascii?Q?FLtBA6CmQsD2NLw1f5CvD4pxX4h3/cPtuctL/c8L+EuZymZImFarqqlzlvm5?=
 =?us-ascii?Q?MNWfNQ7mrK/+L/CEOSck9fBFU4YR1V0m8ujO8uXpR0hSTaaE//P8ohnnd25r?=
 =?us-ascii?Q?LG+RWsBodrF1LiP/XQQjN+6nrrYCDaSvFvsOqsr59LD8Eb6GMvlhD3uXoCSB?=
 =?us-ascii?Q?+GJ/XSWQAF4KDS5J8Yx63zZ8mmMI8tFay7taMlulNKguCsAB7RMPHe5Dctki?=
 =?us-ascii?Q?6cGKYtl0samRO9Lm7Wh/hDPYnlb0KVkh5XvWQl4ykKP/fWktjAZ7Q5KAD4Dh?=
 =?us-ascii?Q?tx2SJbUnU7p7ZNDDvTGxyAOWtnBkRynRiA4//u3o/bApgqNYi/7Rxk5UzwDp?=
 =?us-ascii?Q?LaRArrif15zc8lx1I06jk+zW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9598E8FA26120D4F82B45EA52CEA8624@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f35a846-2dac-4082-350c-08d96be053b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 18:02:26.9210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AB0BRU9UJPcMbuL8z9mc3BTvP089ulgsE3UmTupAghJJBOkTo8PO0z3zT6CMgqExm4os/HIW3Mk3YZcTUs3uog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3383
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300120
X-Proofpoint-GUID: jtVFN2ePTqTZX8rB8k_sFmEMfQ9lYB78
X-Proofpoint-ORIG-GUID: jtVFN2ePTqTZX8rB8k_sFmEMfQ9lYB78
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 30, 2021, at 1:34 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-08-30 at 13:24 -0400, Olga Kornievskaia wrote:
>> On Mon, Aug 30, 2021 at 1:04 PM Chuck Lever III
>> <chuck.lever@oracle.com> wrote:
>>>=20
>>> Hi Olga-
>>>=20
>>>> On Aug 30, 2021, at 12:53 PM, Olga Kornievskaia
>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>=20
>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>=20
>>>> Given the patch "Always provide aligned buffers to the RPC read
>>>> layers",
>>>> RPC over RDMA doesn't need to look at the tail page and add that
>>>> space
>>>> to the write chunk.
>>>>=20
>>>> For the RFC 8166 compliant server, it must not write an XDR
>>>> padding
>>>> into the write chunk (even if space was provided). Historically
>>>> (before RFC 8166) Solaris RDMA server has been requiring the
>>>> client
>>>> to provide space for the XDR padding and thus this client code
>>>> has
>>>> existed.
>>>=20
>>> I don't understand this change.
>>>=20
>>> So, the upper layer doesn't provide XDR padding any more. That
>>> doesn't
>>> mean Solaris servers still aren't going to want to write into it.
>>> The
>>> client still has to provide this padding from somewhere.
>>>=20
>>> This suggests that "Always provide aligned buffers to the RPC read
>>> layers" breaks our interop with Solaris servers. Does it?
>>=20
>> No, I don't believe "Always provide aligned buffers to the RPC read
>> layers" breaks the interoperability. THIS patch would break the
>> interop.
>>=20
>> If we are not willing to break the interoperability and support only
>> servers that comply with RFC 8166, this patch is not needed.
>=20
> Why? The intention of the first patch is to ensure that we do not have
> buffers that are not word aligned. If Solaris wants to write padding
> after the end of the file, then there is space in the page buffer for
> it to do so. There should be no need for an extra tail in which to
> write the padding.

The RPC/RDMA protocol is designed for hardware-offloaded direct data
placement. That means the padding, which isn't data, must be directed
to another buffer.

This is a problem with RPC/RDMA v1 implementations. RFC 5666 was
ambiguous, so there are implementations that write XDR padding into
Write chunks. This is why RFC 8166 says SHOULD NOT instead of MUST
NOT.

I believe rpcrdma-version-two makes it a requirement not to use XDR
padding in either Read or Write data payload chunks.


> This means that the RDMA and TCP cases should end up doing the same
> thing for the case of the Solaris server: the padding is written into
> the page buffer. There is nothing written to the tail in either case.

"Always provide" can guarantee that the NFS client makes aligned
requests for buffered I/O, but what about NFS direct I/O from user
space? The NIC will place the data payload in the application
buffer, but there's no guarantee that the NFS READ request will be
aligned or that the buffer will be able to sink the extra padding
bytes.

We would definitely consider it an error if an unaligned RDMA Read
leaked the link-layer's 4-byte padding into a sink buffer.

So, "Always provide" is nice for the in-kernel NFS client, but I
don't believe it allows the way xprtrdma behaves to be changed.


>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>> ---
>>>> net/sunrpc/xprtrdma/rpc_rdma.c | 15 ---------------
>>>> 1 file changed, 15 deletions(-)
>>>>=20
>>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c
>>>> b/net/sunrpc/xprtrdma/rpc_rdma.c
>>>> index c335c1361564..2c4146bcf2a8 100644
>>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>>>> @@ -255,21 +255,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt
>>>> *r_xprt, struct xdr_buf *xdrbuf,
>>>>               page_base =3D 0;
>>>>       }
>>>>=20
>>>> -     if (type =3D=3D rpcrdma_readch)
>>>> -             goto out;
>>>> -
>>>> -     /* When encoding a Write chunk, some servers need to see an
>>>> -      * extra segment for non-XDR-aligned Write chunks. The
>>>> upper
>>>> -      * layer provides space in the tail iovec that may be used
>>>> -      * for this purpose.
>>>> -      */
>>>> -     if (type =3D=3D rpcrdma_writech && r_xprt->rx_ep-
>>>>> re_implicit_roundup)
>>>> -             goto out;
>>>> -
>>>> -     if (xdrbuf->tail[0].iov_len)
>>>=20
>>> Instead of checking for a tail, we could check
>>>=20
>>>         if (xdr_pad_size(xdrbuf->page_len))
>>>=20
>>> and provide some tail space in that case.
>>=20
>> I don't believe this is any different than what we have now. If the
>> page size is non-4byte aligned then, we would still allocate size for
>> the padding which "SHOULD NOT" be there. But yes it is allowed to be
>> there.
>>=20
>> The problem, as you know from our offline discussion, is allocating
>> the tail page and including it in the write chunk for the Nvidia
>> environment where Nvidia doesn't support use of data (user) pages and
>> nfs kernel allocated pages in the same segment.
>>=20
>> Alternatively, my ask is then to change rpcrdma_convert_iovs() to
>> return 2 segs instead of one: one for the pages and another for the
>> tail.
>>=20
>>>=20
>>>> -             rpcrdma_convert_kvec(&xdrbuf->tail[0], seg, &n);
>>>> -
>>>> -out:
>>>>       if (unlikely(n > RPCRDMA_MAX_SEGS))
>>>>               return -EIO;
>>>>       return n;
>>>> --
>>>> 2.27.0
>>>>=20
>>>=20
>>> --
>>> Chuck Lever
>>>=20
>>>=20
>>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



