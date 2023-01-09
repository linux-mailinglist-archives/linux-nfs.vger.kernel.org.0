Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DE7662C8B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 18:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjAIRUf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 12:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjAIRUe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 12:20:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0B9186B4;
        Mon,  9 Jan 2023 09:20:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309H5GGG000903;
        Mon, 9 Jan 2023 17:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iXXphUTEqw/G09IDn9ievfTsTe3qtzP1r5GOEypV4KE=;
 b=vxizb6poo38eA854v+XPxoz9JiQQIlujLt/HYO+3MhCg4XeZhlfvNxYfMVRmdjco23a/
 rvwRFxHO5b6p/1hg9U7dnhwgrvZMUNpxp6k16BUZVhi+fLW8yTaBbztQExMCueRkG1D2
 eJdKbaupESNViUqbreIWc43tPHwknsxhsVSRqCKAOR+Lzk1n0pRGkNGBnuScCjck25+V
 3POz4wAmmwaNxRItMrQFCcxAD5WOHTFl0VeQwdOA9XPuTk0IHRsYq6AKxlQk2kOG353A
 2J0UHNRujQar6GaeT8Px/HW1Abf4XPUfhYqWgu+bPhIgG0f1/D8ydry5Ja14FcPD2h5J oA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0nqn8a19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 17:20:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309Gb9RR017591;
        Mon, 9 Jan 2023 17:20:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy6ah6ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 17:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBnCLAzln3lbQ360nWQpkhgQDCSnPDtFlsckzUfP1CRPwsT4K59kwQpswyWtC29E/OxBtP48NxAtZ00fNOHVaLtzKvYpAl4ZnWpZOgDK4t6NtCskBxIRn9FNjM1cUZwhiVIgeJrXAI5IFwGk1u4DWLgW0wPyRH9WJNosEJWswKJV1OeNGXsxxLuoO2TMI1qQgwCHq+lL9ySFQpJbzRvGif5qz4NJKpvemqLtXPbpuVWtZQ1nakgcOPQ9jCSrJ2peIrfrBDOByQsWZKfMVXOLpTGF73H0Hj/dOkk2l4VlBZ4pZuRK7GqRwu+SzrzHjK4qZPCBnTThDFDXEvTvKIUmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXXphUTEqw/G09IDn9ievfTsTe3qtzP1r5GOEypV4KE=;
 b=UWEPKk39rxCJzPL9t9IKxpbOuoquJQGxHBmBgH1ua+rgBdfbspjhlHAqbh4sKoaM8CtUBqKPwjD0Nw6R/VQEsX5myuhNSHPuhtBLWaVEwj3kc008mqpNNhsz2l/hAUrYN0lyIZXNjUVZnzbHvp0z9svRKc+43BzKknHJE4bR4yqgwge4UQ3WW5oy48tU7uAp9B4L87RH81d5Q48L9R6QrEiDJQEJlM/AkbYTSa0BrXLdk/MMfEBZVMVkhIE8wCtv50EFvJZYJZg90NnBNIa5LSlBSyJ7a+Uw2Fi+1FvI1bameklBa2iYfS3oTg80jGWyoEonTbLeiz4tAt3tMltZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXXphUTEqw/G09IDn9ievfTsTe3qtzP1r5GOEypV4KE=;
 b=AgkWHGKrz/ExXkqVqxsJcfIJo4SA+bYOg625Ypp+gC0TyXnNFnwpndWkZEBsJafex6U4DvE1XI6LHyzZViicPN1qjrTY+f72usQZykODtlw2ncOH9r1MOYhkghDR8XQ7Wfsm2ATX5tEvM/wDnUjXax0t+dm+izTEOW6M0GLs31I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 17:20:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 17:20:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Topic: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Index: AQHZIq8GJkROOS2NVU+FmVsgVWlM/a6UhAWAgAA+nYCAAPy6AIAAB+QAgABlFgCAAAaNgIAACKyAgAAZ/wCAAAJiAA==
Date:   Mon, 9 Jan 2023 17:20:23 +0000
Message-ID: <F3D352E5-A9D9-4166-82C4-874CF7512F63@oracle.com>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
 <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <6F61B478-A0FF-4E28-A7DE-8DAA6E11B128@hammerspace.com>
 <DB31E56A-42D7-4B62-83CD-3D96AC4A4C20@oracle.com>
 <1B9DE484-2543-44CC-83DB-46A3A9A9BEA9@hammerspace.com>
 <537596E2-2D63-4042-A308-5720C41B5DBE@oracle.com>
In-Reply-To: <537596E2-2D63-4042-A308-5720C41B5DBE@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5574:EE_
x-ms-office365-filtering-correlation-id: 1ab209f8-0503-4d1f-5a27-08daf265cacd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: izO506vH9w5i8o03pBkH0ETqQobySRWUIBPZ7rH24vaiVnlI7ImkBNsiAV6CKFT1um/rC8+kTnjRLMhyqdozwqdBVZ9jOcls+iqbEMMQ++A6tf3C8aRHmyELnkOEFDXlaX8tYlJF6MsNgTpglTCJk8O+A+t349qwjjmLxLfvggMdYoSKumlPuaXtmC3aYJ73+is89DFVK2HCjiQFfpxS/GPvETCrmu59cwArCIIPpv5aK7pirB+lW9sYR5bYBLuh476gPwhwadFoNI4A16tOSEoWGd0XCwPQzuaW3alU7dEaqcgaWwqhhIUNZHgwXznfUEyyHBOxOktwoBzRDxBGqonZNsv+7Mq+eowptf10QXQ2OauhMZjTwc5+0txI+c0IbR9Qr4anE5yZzVcG4uqvSFmDxs1+mPxdYGxfwjkflPmAS2M7bduWRue27mzQTvDarNlO5S6pCaKsHxEwrag/4bOqaDnGooTm5iXXBitw75Lx78/IhyWPU390EN2uxOcP/Ur+3FlXjMfJucflQdgAJNnWxl2ysmxWYIkM8IgsOECi6fG9N6WYpu1Twp/r+RKeY3cLMwQv6ovB+h8vH6xCLC9N5xoPz6ADY6jqqSe3ffkWt68CZWija9BUO6JmfyzXT8/P2VcDLsYw2eCGPCZVcbhijnqycdyNzE/GI7SDNK4vFM1dNy4rxRZmsYhmUkMtLAqxgOAy3iWsq+XtP3DDmhIVaOzIa++9B7BEdBT4Q5Mv426GZK3I4mdirLbBgSUQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(8936002)(316002)(6486002)(83380400001)(478600001)(38100700002)(66946007)(53546011)(66556008)(4326008)(966005)(36756003)(54906003)(6916009)(2906002)(6512007)(66446008)(33656002)(186003)(8676002)(64756008)(71200400001)(76116006)(91956017)(2616005)(26005)(38070700005)(66476007)(122000001)(41300700001)(6506007)(86362001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mLiVIAxXzaHnNXFZYBxfpC9txyeO2nVvQRI45VtT6a2Z3Wc4vfbD7ZT+WjT+?=
 =?us-ascii?Q?Jeqid/2GSe46Lf3MuVqEETNqWmLmicncRv8wznfkqyc7VfrcpGcgizljgpgS?=
 =?us-ascii?Q?kU5cjVyatriAaFifCwQZFwHOD44GxUWRx2YobgT14bVWEh6rVwFdgzjAZI7x?=
 =?us-ascii?Q?PVkup4j76eiGfAwxP5AUwy0opQTTuiV8msjPq2dnFbFgTwPDnWj6vOi8rtMQ?=
 =?us-ascii?Q?A1A2n26cw2togETIU3/TnbH4Q5i/GZBysfCX1IzetU+Jk+1faxOeLtXQFj++?=
 =?us-ascii?Q?zUsZKt+KGow9kOjNFIdnOTYKLcCjRPi34IrzARzoNFlv4Jog1M7X4l/sgEAE?=
 =?us-ascii?Q?zbhRXM9n1kzSUT+DqRszMvpV+UrC0J5ym2A9/vwba8Gyh9fvuDOIQSvxwu2j?=
 =?us-ascii?Q?R4UVQHCsSabYGJbjsoXBvMYuRp5xiqaslo+xyzwo5c5QUv6TOwRFJOF8G7+w?=
 =?us-ascii?Q?lUpbqCcpTzjPzAgRaJNBlgEpF8SdKG2JQ8iUL9/xeHTZrykCNt1fWvLPGGnS?=
 =?us-ascii?Q?jN1rvWyTZ/DWII0GAr4u1AthjKUWi48/d1r3Ti9YXck87nRdfeunqujBHTLA?=
 =?us-ascii?Q?JWkeW1YFAgpDDoHarKG7gyQXX31D164GUuBQ7zv11B/ev/hY+4X0CXn2VGf7?=
 =?us-ascii?Q?F4nAYnhCHCz5rm1Kx78Foy6q6PanLo8jE+xJDoyUsEgn7zpUj//2drQvDtzD?=
 =?us-ascii?Q?d9gABXs0Xcl1TFqLzE8o9hxzDRCjrdZFzjIIsuENKSTLvFS49bsHrB2w7vOP?=
 =?us-ascii?Q?n7+9q9O1HSUANm0t50HGk5JMNbY+l6RWAvKKk9qWqS4uwdE8qtRdbarxpfc4?=
 =?us-ascii?Q?gX9GSS+FvnvZzvjaCuvGXfq0uZOxyJ6MUAOoRNbEgWQ12CQ1lSTwhYbB35s8?=
 =?us-ascii?Q?rAh+Plhcw4oqHSTz33ehpbG3M9IqKmRksYUneCaoyD4TzW8dIMBvpQ0RzBhq?=
 =?us-ascii?Q?hRKj4DxT9uwr8HF66+/LprlNujzp0b+rt69dWSdkeQ8h03u800NHI6MWVLpt?=
 =?us-ascii?Q?k3uAALEeF5twBgXrYnu8ryDM6axvAf9u7iN8pgLVu9T1J7OHrQBhqcs5Eztv?=
 =?us-ascii?Q?klwn+Vihsq5L+a0bAA++Lc8jxWdgZljSjotFTjVEBF0IM/22bu7ujGmn817w?=
 =?us-ascii?Q?xZq61+0SSWHuvdc3fPQZ7sD8rZRPfWghDm8RQ7SUARVQ93kSCP0bfRmFj2/c?=
 =?us-ascii?Q?sdvu1v9C3gF/U8AId9oIZsv6Hg5lTcrH+akFvD+QGMvH3XPoYJBo/2v+GSiS?=
 =?us-ascii?Q?qd7mhGkE+YsYdmzWvjyIML738MX59FhIMdgMUx7SaYLhd0WQlghbz8v/AoYn?=
 =?us-ascii?Q?9qENdK0dK0YV2jL+aU5ylSVrRuE1Xx29UYPV3m5Q9krOXXf+VeOOIMerzfHT?=
 =?us-ascii?Q?O/Wv8K1abGvLRFd6feOjCo8U6f0kg10MGgHz1TOgaHRaTPZs53a3rkqs5whm?=
 =?us-ascii?Q?yZNid7vF40SMUL53hVTK6v5ReHJY3Al4biBQv/POIYsnw60NFf8UP+cIibQr?=
 =?us-ascii?Q?q8aQrQ71SK+DHj9AyyE6EEJEsLQdG4mFhZB4P3vuoQxRawEOR0cCcW00Lo3b?=
 =?us-ascii?Q?0m9Jvo7TMMEYrmT4X83WoZWolCraLI3oviJ5MCfMMwk1qJGN8GLTvRaRN/76?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9243A45E0834DD4295BE6C327D527FEE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kRp7Qhg45l+OoTPxKpYkWfS3y1AudBChJHyvP3zWYwizauZwhn5Jy71mbaf9?=
 =?us-ascii?Q?TnFoivqSwk5XviAKmWN4IGjXZJFjw4OQhyu6sQeoSzWKRE2Y3njxENO6vE3y?=
 =?us-ascii?Q?YtXyRJiZT1YseYm5rfHlo4W3970haFyMRvlsTwxU7YfNFrx9Z1+Edm8Hy2Ss?=
 =?us-ascii?Q?wCVrVvNA6nPMdDEXXFWw7/2gTyURzC8uVZei2gwUKUkedYANpOvSR0VEQ3XC?=
 =?us-ascii?Q?t6nFUclQlkPNrdMVtZDQmzZ1EOg/3pU0LxOpSB9IeKVtj+mIkoR4c9dOz3hC?=
 =?us-ascii?Q?zHGnrv8zcH2vGC7mYT+B3cHjbvyhkYaaN1I8+S04ag1CpBcOdKPgeLcm9nNQ?=
 =?us-ascii?Q?iPh8msopseh3ALq5+fwDzGv7w13P4Z/rItJMOe8lPUY2dWIUHXF46EZSyNf8?=
 =?us-ascii?Q?WboP1csgHzGi2v5d2z2HoBEfpJop932QRfZu/xnQuY1G4D3ZgSf27a42PA69?=
 =?us-ascii?Q?iuo9wy8BR9mdNBHuxTAflgcQgvCDUuXV39Noq0z4uTf1FQ3qABZpb2QBgBBb?=
 =?us-ascii?Q?xwqwXG3T8PvXybiEnli54LabAtdcjxW98Hsg58JbL71g/f67x6pfEwcEpM1z?=
 =?us-ascii?Q?3x29rbQDEHpx3BP6M6QHynhqMY5HUxN04OZ8WGlTUfu0g+JnIGY8OBDU6zLK?=
 =?us-ascii?Q?ywqWxML+WDt5A0Cxt2lLsmiIJP5sOG7rY4YkUunkUgQYs8+jHMPOUC+vFI5F?=
 =?us-ascii?Q?4gXAd+olas1eFpCCAOdETaHZmgINyD+SSDemrAOvkXa187YUH9mL1BSksM2c?=
 =?us-ascii?Q?drX0Cbu5tH/IHsIlgmyPvROAoVJbJ6nEZS6/xVq9XfU/PotMd/y4BYW/VrgA?=
 =?us-ascii?Q?jt8tnGdfFbIm6x+2z+urXcGLubTisr6ZSyQ7t3baBqecKi5YFE+Pej4Xl9xp?=
 =?us-ascii?Q?wMQnxl0AilkWV2mMNiDMnydawmsk9kvyUzLgn8wpgLiJnvfT6T9LPdvVZhqK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab209f8-0503-4d1f-5a27-08daf265cacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 17:20:23.3952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSoTcIT11zV5rsu7UWjKIxlLoCNEQAgFIeGNzDRcui2r3XxKP11jaq8b/Nj7cA6OvFIDD4dE9GF97+Ju4mzkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_11,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090124
X-Proofpoint-GUID: VDZApFfp1Bb567aLDVur7S9Isx7evdN7
X-Proofpoint-ORIG-GUID: VDZApFfp1Bb567aLDVur7S9Isx7evdN7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 9, 2023, at 12:11 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jan 9, 2023, at 10:38 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>>=20
>>=20
>>=20
>>> On Jan 9, 2023, at 10:07, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>>>=20
>>>=20
>>>=20
>>>> On Jan 9, 2023, at 9:44 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Jan 9, 2023, at 03:42, Krzysztof Kozlowski <krzysztof.kozlowski@li=
naro.org> wrote:
>>>>>=20
>>>>> On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
>>>>>> On 08/01/2023 18:09, Trond Myklebust wrote:
>>>>>>> Hi Krzysztof,
>>>>>>>=20
>>>>>>>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski=
@linaro.org> wrote:
>>>>>>>>=20
>>>>>>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Le=
arn why this is important at https://aka.ms/LearnAboutSenderIdentification]
>>>>>>>>=20
>>>>>>>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>>>>>>>>> Hi,
>>>>>>>>>=20
>>>>>>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the defau=
lt
>>>>>>>>> KConfig value for READ_PLUS") as one leading to NULL pointer exce=
ption
>>>>>>>>> when mounting NFS root on NFSv4 client:
>>>>>>>>>=20
>>>>>>>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>>>>>>>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: =
Invalid
>>>>>>>>> argument
>>>>>>>>> [   26.199478] 8<--- cut here ---
>>>>>>>>> [   26.201366] Unable to handle kernel NULL pointer dereference a=
t
>>>>>>>>> virtual address 00000004
>>>>>>>>> ...
>>>>>>>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>>>>>>>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x1=
78/0x358
>>>>>>>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x3=
04
>>>>>>>>>=20
>>>>>>>>> Full OOPS attached. Full log available here:
>>>>>>>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>>>>>>>>=20
>>>>>>>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the co=
mmit is
>>>>>>>>> not the cause, but rather making it default caused the regression=
.
>>>>>>>>>=20
>>>>>>>>> I did not make the bisect yet which commit introduced it, if ever=
y
>>>>>>>>> config includes NFS_V4_2_READ_PLUS.
>>>>>>>>=20
>>>>>>>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed=
 to:
>>>>>>>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>>>>>>>>=20
>>>>>>>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
>>>>>>>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>>> Date:   Thu Jul 21 14:21:34 2022 -0400
>>>>>>>>=20
>>>>>>>> NFS: Replace the READ_PLUS decoding code
>>>>>>>>=20
>>>>>>>> We now take a 2-step process that allows us to place data and hole
>>>>>>>> segments directly at their final position in the xdr_stream withou=
t
>>>>>>>> needing to do a bunch of redundant copies to expand holes. Due to =
the
>>>>>>>> variable lengths of each segment, the xdr metadata might cross pag=
e
>>>>>>>> boundaries which I account for by setting a small scratch buffer s=
o
>>>>>>>> xdr_inline_decode() won't fail.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>>=20
>>>>>>>> With a trace:
>>>>>>>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
>>>>>>>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: I=
nvalid
>>>>>>>> argument
>>>>>>>> [   25.986237] random: crng init done
>>>>>>>> [   26.264564] 8<--- cut here ---
>>>>>>>> [   26.266823] Unable to handle kernel NULL pointer dereference at
>>>>>>>> virtual address 00000fe8
>>>>>>>> ...
>>>>>>>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x30=
4
>>>>>>>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
>>>>>>>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
>>>>>>>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x7=
90
>>>>>>>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
>>>>>>>> [   26.625570]  worker_thread from kthread+0xf4/0x128
>>>>>>>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Is this test being run against a 6.2-rc2 server, or is it an older =
server platform? We know there were bugs in older server implementations, s=
o the question is whether this might be a problem with handling a bad/corru=
pt RPC reply from the server, or whether it is happening against code that =
is supposed to have been fixed?
>>>>>>=20
>>>>>> I would say that buggy server should not cause NULL pointer derefere=
nces
>>>>>> on the client. Otherwise this is a perfect recipe for a rogue server=
 in
>>>>>> the network to start crashing clients and running exploits... Imagin=
e a
>>>>>> compromised machine (through some other means) in a local company
>>>>>> network running now a server with NFS share "HR salary data" or "HR
>>>>>> planned layoffs", where unsuspected people in that network access it
>>>>>> leading to exploit of NFS code on their side...
>>>>>>=20
>>>>>> Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
>>>>>>=20
>>>>>> Which points that it is not latest stable, so anyway I need to updat=
e.
>>>>>=20
>>>>> I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
>>>>> latest stable and I can reproduce the issue. Therefore:
>>>>> 1. It is visible on two stable (one new, one old) kernels on the serv=
er,
>>>>> 2. Buggy or rogue server should not cause NULL pointer on remote devi=
ces...
>>>>>=20
>>>>=20
>>>> The nfsd READ_PLUS code is borked up and until 6.2-rc1. I thought we h=
ad a server option to disable that code, but it seems as if that is not the=
 case.
>>>> Chuck + Anna, can we please send a stable patch to rip out that code a=
ltogether from all the older versions? If we want to enable READ_PLUS by de=
fault on the client, then we cannot do so if the majority of NFSv4.2 server=
s out there are running a borked implementation.
>>>>=20
>>>> I do agree that we cannot allow buggy
>>>=20
>>> or malicious, or non-Linux,
>>>=20
>>>=20
>>>> servers to cause memory corruption in the client code, so I propose th=
at we revert the Kconfig default setting change again until both the client=
 code and the legacy servers have been fixed.
>>>=20
>>> I stand ready to receive and apply server-side fixes, as you suggested.
>>>=20
>>> However IMO it would be most responsible to go straight for a client co=
de fix. The Kconfig setting is a red herring (as delicious as that might so=
und). Any thoughts about how difficult that fix might be?
>>>=20
>>=20
>> A client fix is necessary, but not sufficient.
>=20
> No argument from me. There is a problem on both sides.
>=20
>=20
>> The older server READ_PLUS code is slower than ordinary read for several=
 filesystems, since it relies upon the (often poor) performance of lseek(SE=
EK_HOLE). Leaving legacy servers as is, would therefore still cause regress=
ions for clients that default to trying READ_PLUS, even if the code is fixe=
d to not Oops.
>=20
> Backporting eeadcb757945 ("NFSD: Simplify READ_PLUS") to stable kernels w=
ould address both concerns.

And by "both concerns" I mean it addresses the possible performance
regression and the server's malformed RPC reply.

The client code still needs to be fixed.

--
Chuck Lever



