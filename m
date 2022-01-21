Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F2E4967E7
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jan 2022 23:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiAUWcj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jan 2022 17:32:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3488 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbiAUWcj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jan 2022 17:32:39 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LKGmBs008938;
        Fri, 21 Jan 2022 22:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+f0QSPJ3XtJmXAiOdEZP1CR0zf4+C0AE3Z10llxStHo=;
 b=OHZQX6l3JBUDVzXD2Zy4JfOFIDuzYxdxlojDU4OLMr31yzeOpPHTWUwvXFTrI1qS8JS7
 +dWRpnpZDTKv22ey/dUy5QsYxQ6RjbLwHHnB30ajJK99LGC95BeUKDsPvCSA4M8blUmz
 PgHM3sIuUnIbz3oey4qlH4cLh9VeEqdHoNnhTah5dB98BZSavtzzdLmgJp//HDKEiADN
 UkbqC0SOgCn6ahRpJlGQ36KwSc2eZPXSMjsZTiXjNZbLMal5MInSmEQnPqOAIirPNc5e
 lZQazW/ZihOkwmf3quxZxEF1rKxGVkiHNj9QgDqq7jCJ7xSPrawnUbh4AHsKWFRJzuZY aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhy9tt6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 22:32:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LMKqmE119810;
        Fri, 21 Jan 2022 22:32:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3030.oracle.com with ESMTP id 3dqj0wknu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 22:32:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzGfbweIMkOPehKoxKkerPYdHbdppeNaIDv+yrmQHN+HCK55dwXBn+p/TZwdZA8rg3zZKa2uY5v5wX4n4DzxopA/vSB5R+pL/B8sW6Nzck7rvLor9FSNOTTjrM7oTlrWxFfii0gH1KSYCTHTNmR6QB4raAp3fpFcwuNfq1Lw8d+AdcpDvQfvuk/op7AHNLnWdITv2oYUZ7nw6TS3uFHXgnyYtskCDi9fcoVqxHNw9D0i67v5n5yvouc6EKWnM/NZrL1SRNBILAYHVzOJYBr44ouB36ohxwSAYF+Z49Wv1kRmPPyO9VTrCbdTXAtq04C9fsXBaWEr+zBt+alTWsoJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f0QSPJ3XtJmXAiOdEZP1CR0zf4+C0AE3Z10llxStHo=;
 b=EbyO4Ex1Ku7GkIG+ICY3iHv0Su2uubihZqkVe4zQUa+AkMiQBxRWoR0ENBT0M0OImRkJlFrOM0dE6WsnREl/DfkLwG535fmPOKJZ8hp2oqVzBZeKq7MqRhRcaxwWxF7O59w3/PKzUvDsN8hfxoOkmnrHh/1nv1uhlP03SJK2ayLiugv1nuLpNH0ipTxDwKhafvme+fmZRGUwA/UWMhXTA9Xpmar0tuBdCB0XxNW9V7xQJO0fTVe9VD3dp6GWmz8xq+MT/GxanQF2aE9pup1rP16WFbhL7dlAXt2dpzayhEXuZKkI+usvgPF6FQQHl0KzDVyk8TiQEMNtmSbCi8B9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f0QSPJ3XtJmXAiOdEZP1CR0zf4+C0AE3Z10llxStHo=;
 b=c0Dgzwti2bNfqiT/Q3Sa/osUiaK8XeRWKmdy5lBuCSd/BG/g87zJmxbnptVg6PAI2p/3OGRW3Rgo4bfDVUH83f1OCkwXOWm6xx39GvEWtQ4XRzj6uA0AROugqB9nw1Om0dMJAO8XF+R8HlfgEOeppTYUXP+T+RL0p0XqHrAu6+A=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CO1PR10MB4755.namprd10.prod.outlook.com (2603:10b6:303:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 22:32:28 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 22:32:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Aloni <dan.aloni@vastdata.com>
CC:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Topic: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Thread-Index: AQHYDvfTRZNTkkSWjkWDIwR2Vc39WaxuD5oA
Date:   Fri, 21 Jan 2022 22:32:28 +0000
Message-ID: <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
 <20220121185023.260128-1-dan.aloni@vastdata.com>
In-Reply-To: <20220121185023.260128-1-dan.aloni@vastdata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a4d885e-780b-4618-9c79-08d9dd2de816
x-ms-traffictypediagnostic: CO1PR10MB4755:EE_
x-microsoft-antispam-prvs: <CO1PR10MB475548E2DF99EAC7353485EF935B9@CO1PR10MB4755.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4HDyClmxnYrkdcMVkVqFIRKvGUjQHy3L1iFfMKfqu1YpsD8CALoLAX/4UvNdJct3JVNiqUBhHix7dfWSuLXxzwL667TvluSflNe1x/31EW+u2MlkBP3seIBCbvxzgwCDqTGB+nWdacYZDFeTx67wdddjQ3TGrhFwKhDa6FHTcHoYalQ51tA+uqFPxmlwX9Pv2E6XLSlvuX3/l92CC2NDjpuvuX4eHtXGOZCIumqSGnmOrNsv2JObMjAteu33HVXuU4wrRea38G1YSjuFT88dNcqMJvuUyK2F627V2NXlF8nrYkSpwk5C377fblLFLWXiAxZszNWrf21wsr5sqsnH8LM1i4qPkk9kYFztcQcIYpSdzc2bkUuyevrHVqLbZC/3QUKm5205FN+WnnFwBe7rjmG7oUp/zdp3EpBeBXQj9Updn4j8tl4A9UJpo0E44yuZ3Ik8V05Cy8gHN6j7FmDy8ntGroYrVswFIsDhzsDSAKIpdWW5D1mNwmHggvxrARvYBjxPh/jl08NEVnFQCGApFE/C3jUP+f86oBbZP8tEMaI7Av4zfe8/EdYzFK3wS87jd4RT5xh3O3/lKmrWsCqRIvL+Wox/GNsgB4GHRomX8L1cZK1bW9bndjjsNBeg4TUnZsldidH99mvGzXyuFj3uCpZ9pTOAWmHDoyv1zP7tja8guCmaZxy9/47LXazGeNEy39884SDBkHjk+iQmWo+xrxVn/8y543kA/Y/+7ne/DQfRDRiMKasf3I95yMigg+R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(6486002)(6916009)(6512007)(316002)(38100700002)(8676002)(66446008)(66556008)(5660300002)(122000001)(4326008)(83380400001)(66476007)(76116006)(64756008)(38070700005)(66946007)(33656002)(36756003)(86362001)(53546011)(2906002)(186003)(508600001)(6506007)(2616005)(71200400001)(8936002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RBzNPTBwndnSzpaA+flNT9Y+A6FzgFRtk3vD3wKQtQWUAzfKB+1Ep12l1Az/?=
 =?us-ascii?Q?4WoDiHg9FudtaP/NXI3shd0bPbhmB58HtSrR9UUQtqU3k3s4QisJSsD0ipfw?=
 =?us-ascii?Q?L+7BX4Ci/M9bBercQdBo8CqFi6vKGSqBnHxxIqWkJaFUySbVcPVcrxJbKHzM?=
 =?us-ascii?Q?brRQUWdsWhNhGTFz4Kf0H4oWKOh0BFA+NsuvtVoXa6zFzkL+IrJnYzI/VZyB?=
 =?us-ascii?Q?ms+9QAhReh9ict9hQpEq5zASiv/tHKnQpDoa+RJUMoS88lyOrKPCu1s8a3zS?=
 =?us-ascii?Q?FHh9IPWYNcXpFYXlXtIyCDUAR7L7em5+EVAhHFQDGvRT0LHJcLIRX6JmO8Bn?=
 =?us-ascii?Q?whEv1gB1gCokaxmgNOJVt1DDsts9pv0IkYP2HlsQNvvTUFzNFUH4Bvm6XHwH?=
 =?us-ascii?Q?3yTYHbOWVL0LeE8KLEy42mV5EY459VJpJt/91UYxPhl9vaEey1e+vRAnOBsB?=
 =?us-ascii?Q?t160DIJ0BPeJIMucTkWyBExvrMDyr2bOQjB3b4NqXX/0i41p2ryX5efjJ2YC?=
 =?us-ascii?Q?yef2esJiNC7Dw3FxzJYPRhzYccN+cTeJBycFi7FkxKYWg6c2RUEcC+dHK7WI?=
 =?us-ascii?Q?SHhFXuv/5Sd7GnmYlP3oRFuMWDj5273OT5RT7SuKTmdQShlHHc0XU9BARFYh?=
 =?us-ascii?Q?PlHkZXEZwyUqYnvMk+ja/9vksUNHK4+SPQymhCtWgysCBIctEk27Ys9NJsa/?=
 =?us-ascii?Q?DQmGFKLKQTmSIGlXaBAmSoJhRaux4jui9dR+nqYS8z41jU5ISWizZxvhS6HN?=
 =?us-ascii?Q?5kUXxlkYfPFHUHk0EFsjCBfHZd4Mx4JaaMcAA0LvCOEyeRnAT3sma6MBoeAd?=
 =?us-ascii?Q?WnoHE+Hrg2173p63feJnBz+LLIvFjOdhRLuUaPTu7IPsL2+uIXJmMlfHXlUF?=
 =?us-ascii?Q?7B6pHSNYQfC4OW1E8eo60JzkePy0urw2TfXc9/ZnITj4Hp+my31c/Tkre2/A?=
 =?us-ascii?Q?lR0wWvt58hTgOjn+x2eByFHZ4VTKgZfUmQVaJJ4EX+pRYfZxQ7j4Na04ucFb?=
 =?us-ascii?Q?nfyu2ry930dfzQuJSZ3iU0e1YCIo79MYzGlDd/gCgQ2tl1u+ZiTKReAAASOV?=
 =?us-ascii?Q?YS5mFbXy766H9v9OaTtRXqqLDdl/8T57filYuR+axJ+Os7QyGDKrb+I2pe2C?=
 =?us-ascii?Q?bZpepYrUderYy0jBxYESiigsF6dvX9eVXgOPxZM9y5K00qNjrAgw0sn6pUya?=
 =?us-ascii?Q?HRZHPpYJpe67EacFuougGwlsjtTtikSzKXShbwCC4qBIG2TXslRRqx6Nsjie?=
 =?us-ascii?Q?i+jIUHdERaS++emeD8UzG5kE7FLnvPvJULHL9tNWQ6m+49FqJOQZnQ5uYkJA?=
 =?us-ascii?Q?4XS5xqTqHgpnB4e/sF1siITI7yD7xj+1hpAaxag7V9lr3Z4bIaapGyIx0y4/?=
 =?us-ascii?Q?miQmkyjRZVcdkb5oLFJbremsQGYLwjh/g2FfkVaBmnOCD1chgBhZTn+CzFCP?=
 =?us-ascii?Q?1xGIaNGW3zDcnBXyG6S/wFQd9Env97XwEhOJUHJef2Jel9xz5YPDRb7F2RZg?=
 =?us-ascii?Q?4aLRPQQrjktOSSbUUsUSMcWQx3qP5krQYU5DpPXfZ24XgVxqIHbEm8wEMqHe?=
 =?us-ascii?Q?Yrhw+xsqra8ZQvOjYFPNtmjaAQZ6D6RDvwFjrZo9rViKUgWUf9cnhKNdfjR1?=
 =?us-ascii?Q?8b6ayrmCr3hxxs20cTeGqKQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96AC6051E3DA91489ACEFF489D6AD16B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4d885e-780b-4618-9c79-08d9dd2de816
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 22:32:28.5448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyG40JJjhu4N7VwbuK6C5EpFEUq6/kmvrFuOq//XmL/Ase4C2QRve4sFpu2/mOvBkTfMaw5y7y/1QR/LFaepEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4755
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210141
X-Proofpoint-GUID: 5cM5RZ4ZTDKho6EcLGV5wlkDQTJ4Uayb
X-Proofpoint-ORIG-GUID: 5cM5RZ4ZTDKho6EcLGV5wlkDQTJ4Uayb
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan!

NFS server patches should be sent to me these days.

$ scripts/get_maintainer.pl fs/nfsd
Chuck Lever <chuck.lever@oracle.com> (supporter:KERNEL NFSD, SUNRPC, AND LO=
CKD SERVERS)
linux-nfs@vger.kernel.org (open list:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS=
)
linux-kernel@vger.kernel.org (open list)


> On Jan 21, 2022, at 1:50 PM, Dan Aloni <dan.aloni@vastdata.com> wrote:
>=20
> Due to change 8cfb9015280d ("NFS: Always provide aligned buffers to the
> RPC read layers"), a read of 0xfff is aligned up to server rsize of
> 0x1000.
>=20
> As a result, in a test where the server has a file of size
> 0x7fffffffffffffff, and the client tries to read from the offset
> 0x7ffffffffffff000, the read causes loff_t overflow in the server and it
> returns an NFS code of EINVAL to the client. The client as a result
> indefinitely retries the request.

An infinite loop in this case is a client bug.

Section 3.3.6 of RFC 1813 permits the NFSv3 READ procedure
to return NFS3ERR_INVAL. The READ entry in Table 6 of RFC
5661 permits the NFSv4 READ operation to return
NFS4ERR_INVAL.

Was the client side fix for this issue rejected?


> This fixes the issue at server side by trimming reads past NFS_OFFSET_MAX=
.

It's OK for the server to return a short READ in this case,
so I will indeed consider a change to make that happen. But
see below for comments specific to this patch.


> Fixes: 8cfb9015280d ("NFS: Always provide aligned buffers to the RPC read=
 layers")
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> ---
> fs/nfsd/vfs.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 738d564ca4ce..754f4e9ff4a2 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1046,6 +1046,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> 	__be32 err;
>=20
> 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
> +
> +	if (unlikely(offset + *count > NFS_OFFSET_MAX))
> +		*count =3D NFS_OFFSET_MAX - offset;

Can @offset ever be larger than NFS_OFFSET_MAX?

Does this check have any effect on NFSv4 READ operations?


> +
> 	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> 	if (err)
> 		return err;
> --=20
> 2.23.0
>=20

--
Chuck Lever



