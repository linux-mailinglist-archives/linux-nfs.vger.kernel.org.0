Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C6E31A0ED
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 15:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBLOvb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 09:51:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55278 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBLOv2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 09:51:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CEo9Un059967;
        Fri, 12 Feb 2021 14:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sdNGUUmROP9eCP619YK4/aCa+ij+yHNFEZPAldGUUPE=;
 b=dma+CIxIVZl9liOX/l1Zo3w0Ex1pCgbHXoIRLaeLuT4xobj8gx4pqTp7S6uY0IcNUjGn
 CsTmQ/7spATwoomoFzhJbyw8YWpWuPwSAxcOg7OhUOqzYM1VkmdkxwpgsaJK+nZUcH/r
 pg49LNjXSS+Ndc+blq1zmE7tkLZTRJlwrD22AUHrZAZYbbPSOpYL5Iiovk22GEY1Lxw2
 rh4PxKfJ07ze5YYVFRomaWan0prkkQeTa8Gw3GcVPoKaFo4iqRm8T94H4VJFqxCywtGD
 XAdXTPynrTxgTizyMiY01bOuVJGBjCbIo49saDWItYV2f+cJFoejaTJLfERCLsb8zB+j CQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmaujs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 14:50:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CEo7A5108855;
        Fri, 12 Feb 2021 14:50:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 36j4pt2eva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 14:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu3mQ66FYqsD3qQrrJteoIPO7P41A1NZdQtBCQSkodAgJ/8TnI+bWIxas87F8+ws7mhHdeNN4UfX8klLowlIuJyOwRHvCWp2vRSzx8d/E3GTQKV+u9tz+vCIxBbfUifVhfqQJ06lqBn0pzVGwGQRfzEFt8672QBqVy6qNpdqo4fzHioEcqlZc7TVnWx9mMA4BllSiyTSTTjQzHkgqX6eJEMYQpANyo8igwzgrYeRZbrYtWrQ8iSh/gQFkwqc3p4wLWEmFHW03mNfcFPn8W6qWIyjHFguljnv5AoyM7+VoQoLedLJoG8+88DBO15GR55VP0kquNiD1dyE2KTiPCQ03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdNGUUmROP9eCP619YK4/aCa+ij+yHNFEZPAldGUUPE=;
 b=ETgxZBeMm27Z9ny/eumDUxZg4cR5eoZklnacBTrQCeiFCptGjvJxFDfZbp2EVTsDQgGw6Wxu3xXE44wdodH3ZSzk7LsONmd6gdQj3JjSMCmRZvXJKF+K0VNabRkQyTl+4g2dI/VSttQCMyjQXj9bnSlv0TOYrEyZfE7IOdBawr/o7K5x88uBHChOPYEA0KbmEEt0kUNtQBhMKiTTNIEAXh3mYQS7TnmC8d68hUar8CCeJV3LKxt4D/zZLvybcnwswYxbsLA0Xu+ihq2BnJq3eZL5voacRO6xUszmRtnAPOp3xw4zVf8MWjtI5ZXcWjAnRLUuQC13MRt36emX0oMHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdNGUUmROP9eCP619YK4/aCa+ij+yHNFEZPAldGUUPE=;
 b=Fp3QKAHNbRFXgcN0hSXZdks3W6y69/3uVu0zN7DVZhnp2I/5TZlwsylLijCqr9McunUD3/N/jpOEF1Ywkve80tJUtEooXQv+UDEhFncw6S3/IgZZb0U6klgxSbBGh/TQqX+DyW5rUXt8iTM1wbbqbZeSJ6O0pH4ixHcY+Lh88G4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3047.namprd10.prod.outlook.com (2603:10b6:a03:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Feb
 2021 14:50:43 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.031; Fri, 12 Feb 2021
 14:50:42 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] svcrdma: Hold private mutex while invoking
 rdma_accept()
Thread-Topic: [PATCH v1] svcrdma: Hold private mutex while invoking
 rdma_accept()
Thread-Index: AQHXAMPXmeY62ULkGUCUAaBhXd4JEapUmXKAgAAB5IA=
Date:   Fri, 12 Feb 2021 14:50:42 +0000
Message-ID: <1103A656-BAB3-40C4-A935-3D432073AD83@oracle.com>
References: <161308170145.1097.4777972218876421176.stgit@klimt.1015granger.net>
 <20210212144355.GA1696322@nvidia.com>
In-Reply-To: <20210212144355.GA1696322@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95afaed9-9267-451d-d77f-08d8cf659280
x-ms-traffictypediagnostic: BYAPR10MB3047:
x-microsoft-antispam-prvs: <BYAPR10MB30470367870E44BD03A0279D938B9@BYAPR10MB3047.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wAsPFkbU7qD1WuMW1Bhyht34bEE+apKDlWPHiR1bm1mNPvseIGY8NeHl5kvFmSIt5Ufdyp8WxcJLIVEUvZUtKlvklxUkjLPFB+1ObVtBeQEu1uSFUIbqEXD2QTGLw5BEry28w689F1j5bEMmEp/5EmhzQQif0cfoDQgIzZ+D+F9dp91ta+y/sIbaLPPY6aAL7hvPg+0Se8bCnW26T+uGTDCaNqQO9ZeRktz8SZnc7ZaOkINNag5U6vjsHidOmf0oUBLH7CS3P9owhQ8IWbRc/qKN1GPzpHu54IOsA+QRTwsBCxghja9Ab50VFUJT/p5b0elF8pLhWDW5DogzFZfVe/AGAZPJqFrEXL8cbeOWT7a1ZIoWtHb9Eb5CD7m/OaYzu8CnT7skIYrZUa20GZVEFvxKRMnRgnS5Tp6toZDX8XdufMzy5p0pFtk+ugc4w3i1vX08cg3PCE68lMwIpUJmZhD931/Y5UBbTCukjkVi+inqE9KqKxmXcB8bts+gjgrW2y5nUBEWovYbI42Q9idIQOpp0pWUiMK7kJYzDwRZXhGFowZcsMhI0aHuNCaARUYTTWS1LDMSsUHsZwHPD0vYow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(396003)(366004)(6486002)(54906003)(8936002)(316002)(6512007)(83380400001)(4326008)(8676002)(478600001)(64756008)(186003)(66446008)(66556008)(66476007)(66946007)(71200400001)(5660300002)(44832011)(86362001)(26005)(2616005)(76116006)(91956017)(53546011)(6506007)(33656002)(6916009)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GlOxvo3AgGP997vooEowojG+44NkGca58/cFubGCt8ELOPh0gCS1xZGr2BHA?=
 =?us-ascii?Q?+aQ1I5FI3ozyeDaRJMtHXtt0o2VvJ8XqNUOxX3dyDPdC3RLUK+5MHNfzRJqX?=
 =?us-ascii?Q?sH1ZOIJY8WjMSYT+QpQZ+WwlSlAdPetNu4QAwOOju+mzkJRQZVCaLGEr2Rfx?=
 =?us-ascii?Q?pha5sRTyUxNCx00PUcFbbxih0mQP8Too4bf/maoZGsF8+4DeXfM9W1ydBkic?=
 =?us-ascii?Q?Tj7AawBbkjaTFNZsuVrsT+lmiwzlAdmoacS3j6EvfJc6pvqlyjoAq2e5U1Si?=
 =?us-ascii?Q?5SkiPULimRcxWGJguTnAo1LOEReHBq9ycWrYn5UZGgirMEUKf4b6OJACkmgL?=
 =?us-ascii?Q?owR8qjc0Kq3cQlK97zkqktFQ+NjEKEgn3kZAxbKWQ05pTMQlEFP0V7ZlPBbA?=
 =?us-ascii?Q?yYk/4HpDn0FsWkoSi7i0VWET0gPkFENVI29JO1GmnWDbI0DVXOAHqoq3ule8?=
 =?us-ascii?Q?JdROb92TEGrxYjz8+j7sKaDVlw6RKRqh/0fbxtszYi6OzWw6J9PvZRLY4UEX?=
 =?us-ascii?Q?9Gvf70nHjClqvgHbqQb0WS3h5TeZ/2zWku8Vcirh3Cn1ytsPANps/hCROTrX?=
 =?us-ascii?Q?1/RS15v8w99eidVhfkRGPJwDc0zMaMcG+QFVFwTyzXvjXENNE+1ehhJFz7MJ?=
 =?us-ascii?Q?8ZrK+krMcI1h2Yy73CEAdBNkvj7FDB3rh9LvIhP9vtY6x8Gvtk6ywILfYjTG?=
 =?us-ascii?Q?I2Q6OltkoIoHHsgvHT5MkoIzN3qDQpHkfalxMuTSztJGiIFHGP5mWADtLMig?=
 =?us-ascii?Q?B2jdKVAu5EtHFtJ7Tp96/KJyXeaSbhjCEr3+DWq3Sn6QLQd98RYCOpeTDRvq?=
 =?us-ascii?Q?pRhOfGMETJ5/IS/uLl0w62rEGyRD3Kaw9HMErqM15uvA4LJALrDYZPjRpvmm?=
 =?us-ascii?Q?LgFyx4XNKdgNftiQ6d6xUnBeqoSTIMkunkeU+8Z6pMWlqCA4Yt5YWKtRc2pu?=
 =?us-ascii?Q?5VqT6iRMi2ew7wXJaMYCC7fNagrb0/LHHuvvlnEfpk9j7D08uC37/PBFtHxl?=
 =?us-ascii?Q?D5AaGATtQFX3QapPt1JlYD6/U02BX0qF52AJSiUK9Zg6xE/vYPKtYOs9rdTp?=
 =?us-ascii?Q?+nNUR8o70k1STmYG00m4HuoPkluNx/p4bz1fv2Zl2oTzCNBcVE6ysvJVpJu2?=
 =?us-ascii?Q?dtMHnIc1mLzkK3hrFBE30QF96ahiOCYFNFwJyR/aSV5TpVMaqxjK6ZWCSz61?=
 =?us-ascii?Q?Lp1aISDUbnAcouabKfyrKcc6yP2zP9q2nJc/Bz7LsB46R1o7+aAvVaMq491u?=
 =?us-ascii?Q?nG11nzZpzr2UiH/B2G7g+2B+mKOIt3UUeIpuWWC7EMZ6Bp8Wysl07giDrbQe?=
 =?us-ascii?Q?F2iZCDpb1WLTK9IngI0jwLlL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C526F7BCE329E4FB6A7732F0A696CD5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95afaed9-9267-451d-d77f-08d8cf659280
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 14:50:42.8075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viglYLlJFI6FF4qRXT4luA0sBCrdGS7q/7TuMmeSCw97RsGMKaZPnXC4Ij6wtxkOKYwpWPYOXlUDisQMYOtAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3047
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=837 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=945 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120116
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jason-

Thanks for your review.


> On Feb 12, 2021, at 9:43 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Thu, Feb 11, 2021 at 05:15:30PM -0500, Chuck Lever wrote:
>> RDMA core mutex locking was restructured by d114c6feedfe ("RDMA/cma:
>> Add missing locking to rdma_accept()") [Aug 2020]. When lock
>> debugging is enabled, the RPC/RDMA server trips over the new lockdep
>> assertion in rdma_accept() because it doesn't call rdma_accept()
>> from its CM event handler.
>>=20
>> As a temporary fix, have svc_rdma_accept() take the mutex
>> explicitly. In the meantime, let's consider how to restructure the
>> RPC/RDMA transport to invoke rdma_accept() from the proper context.
>>=20
>> Calls to svc_rdma_accept() are serialized with calls to
>> svc_rdma_free() by the generic RPC server layer.
>>=20
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> Fixes line

Wasn't clear to me which commit should be listed. d114c6feedfe ?


>> ---
>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 ++
>> 1 file changed, 2 insertions(+)
>=20
> It could even be right like this..
>=20
> This should be inside the lock though:
>=20
>        newxprt->sc_cm_id->event_handler =3D svc_rdma_cma_handler;

OK.


> But this really funny looking, before it gets to accept the handler is
> still the listen handler so any incoming events will just be
> discarded.

Yeah, not clear to me why two CM event handlers are necessary.
If they are truly needed, a comment would be helpful.


> However the rdma_accept() should fail if the state machine has been
> moved from the accepting state, and I think the only meaningful event
> that can be delivered here is disconnect. So the rdma_accept() failure
> does trigger destroy_id, which is the right thing on disconnect anyhow.

The mutex needs to be released before the ID is destroyed, right?


--
Chuck Lever



