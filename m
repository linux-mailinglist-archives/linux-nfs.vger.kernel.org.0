Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7544DA043
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 17:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350120AbiCOQlW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 12:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350113AbiCOQlW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 12:41:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2165657157;
        Tue, 15 Mar 2022 09:40:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFQuww026510;
        Tue, 15 Mar 2022 16:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UeacShVvmenO3FzERXORWiVtacfRBY2GJVUHQxwdBGw=;
 b=03s5kGV496Q22viUjrRegvk14LtbCfkIR2G/Y/hllu1PfgCRxQRne61jkn70on6uxxfj
 k42tSHh7WgQUgwX6O2QptoTLnGcxf9ua7hEOkYlZqmBFRmmEA03mP08pMq/zF7hqE4lk
 k2QkVxHOGHzg7JYCpjCHwWX0FhG1qwlcTqALWcI4e2Df5hScDyVHgZD+rYmCd4GnWwhA
 uf3+Wnqsm1qLpaGeYUW+eKo2bXVZ/N7sEUsj04E8kALqcXhsZoEYTUXwcJdhi5CSSIIS
 tTvCT1n8sNeapR1YX7vgscmCVOVfLFhBq6pymkTRKc/3f90aY0Sgwq7CETpnVmvoDrNW Tg== 
Received: from userp3030.oracle.com ([156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rkr8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:40:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FGQpV3153590;
        Tue, 15 Mar 2022 16:40:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 3et65pp2gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 16:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNmFRyKNvR/7lwm9wSFDZQeKMzNbmO7Nv+QFwRrSIv3LS9QtAy6KBlLLkucpwFfZyLcIe1JKcKfcReLOogENcdodNB4g5t4xx/P6hIqI/8idkyDObIfx3N1tYSZhjViD0LjR1zzrtpLKo/6ViZpRtJnuu0FD5GSSb3QxcCiNuuwEneZhkXzU/0lbRQ2jINBfFYLcuK7aDLB4ofouE8vhgiZughrWUG/lIW+zMIDR03g/CHCHg+rO9PgWcqtvntDXHKDTYzRlWVBCgLjDJhZ2cVcfSEBtKyzKy2QfyfheTJIgKwWR0Q+LgiJ3cJ6dExGZLe7h9Axecyt2GrZ5TXVe/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeacShVvmenO3FzERXORWiVtacfRBY2GJVUHQxwdBGw=;
 b=I38SMs++CwnOevc/I/pJiiXluo2Rm9ysOzMO1Lt7/la3z8He41wGo84hFZOLiaKZeoQIBpFBxVhEu+NdZk22G7RQrc2RLdvqZ66gdlyC/0o7f1F9xeFJArnzFpehpsVbo5SrsYcG3UVOtWpLoYP5fEFWxj4Vnkwt/HGrZ/b/qVtbyNZVa44Kr364iAurH1BaUvXQm6N6t+P4mOvtWPJHdCBP1kfR916oj6/5WlatfVA5ERTixcQwh4/aKcAJSuVvtQJReN6GjJFRi9KxpNm6gjMr+CSwprzRYZQtTT9QJ8cg6xISPQLcNkUMIzf/oll//QSTqkLfeZpNiU1VIzA0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeacShVvmenO3FzERXORWiVtacfRBY2GJVUHQxwdBGw=;
 b=wOlV+zazs3c7v6QDKws2F0XN3vyJu0P3k/zhHyzYYebFxD9DqJbJBuZSvKAmWVux36xo5TwKSYGd0475yZf8xQVMjjK/7bx3PrcpR2P+xNewNWlSKadlpwNzDn7+T+biP2ifjpA+5cBbRr6VhCY2CUeE00XaurNYvdRwaJAiUCM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB3893.namprd10.prod.outlook.com (2603:10b6:610:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 16:39:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 16:39:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: prevent integer overflow on 32 bit systems
Thread-Topic: [PATCH v2] NFSD: prevent integer overflow on 32 bit systems
Thread-Index: AQHYOIIiG1b4nLELAUOop5poNWiQ3KzAoJWAgAACdACAAAKQAA==
Date:   Tue, 15 Mar 2022 16:39:58 +0000
Message-ID: <5AC86875-3CBC-4DA7-BAB2-46DA35324842@oracle.com>
References: <20220315153406.GA1527@kili>
 <C81665CA-D2FB-45EC-BE01-7384B567356B@oracle.com>
 <6229c1c4ab4b82d59503b8c5cd4d909f0e165e2e.camel@hammerspace.com>
In-Reply-To: <6229c1c4ab4b82d59503b8c5cd4d909f0e165e2e.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b93b9889-cee0-4054-bf44-08da06a271c3
x-ms-traffictypediagnostic: CH2PR10MB3893:EE_
x-microsoft-antispam-prvs: <CH2PR10MB389396D163ECBE856F2B842993109@CH2PR10MB3893.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0x8tD1Y7bYNlnZXpXKDE7q8E6ptW4BkMYj3xtJkdqS7z+gqF2rosLjXLyWpayilhgwO5P4H8AsJxkG8mJ49uPOoxTO0D29q5JKmhdaEhm+IOIOlD4NV1jSj1p7pnjOknJEw7oYmTT7jnwP4ZWj6zRZpNC0GYy2dxoYRbo/svGavOBi/KhmKTvlaHWiaCeTlXufumFB/3thrq/pdoHWm0/Q5kPlCFOFMz5vfyN/r0X3hxOST25+DL0MwP4R0U5RQjIQwcnyqGP6PBiOEdHvN6FFWTMOLUvWt3+43mTDhZSSsKvbGOT5wIK/JNTyFpuZC1VAJDWvDz2+rloGVcSnSnuILfHxIGkQK5KVfh5wdOXI3VAwuzwTVIxYe/ak4LiJEZSEyBXbV9l0KuOv1abhIVnE0xdJHvj6p/bwBOMGONvLdqIyN38fqyR3SjZuxPxLB4a6LqS/m75G+aHhemVUzpjwOotjzLKKApQF2sOj4WZejuBqeBoBTWjFkcGNW2KiyhnMbKWFXBuqapMnHQABBovK2vIOQ1umbGLfUQcoBqOaxSBA/KsbzhcSjM2jpdL9Z6EtzztGtJ9WwxYNEVsaSlPy2a1Rcjh4HdwWPZVjIUR5Y2vNTA7+X6ZzTwho52mB1yt5A/jfsHHeUu9uQXuVa7fEoEH9okNwHNOO2eMia6bE6Jva3kqWN76a5ukxIQDdIujQ3hWLHt1z69sHu6dLn94AY8arNTHuVnAsx/RhTlsMp0r0R6lWsW4bF3ZNZZSwk9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6636002)(38070700005)(110136005)(86362001)(54906003)(122000001)(316002)(36756003)(186003)(26005)(66476007)(8936002)(66556008)(66446008)(64756008)(4326008)(66946007)(8676002)(76116006)(91956017)(508600001)(6486002)(71200400001)(33656002)(6512007)(53546011)(2616005)(6506007)(4744005)(38100700002)(5660300002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RK2l/s+l6XBtsMtx5/gVMhoPePDRUIgq10cvLp7ELpKFax1YmsOcG1kdM3Az?=
 =?us-ascii?Q?P1qjXbXT0GWRq+204ZJZ3ZaW9t72HmIJMxWB/5Ybk4py2Gb3Lg4lar1Y/TIH?=
 =?us-ascii?Q?S/zhvAj3F2zomnQFpONeXtshLl00ubJZLqv1L8Uwhpa9w/SkuyqOjO7iVPd6?=
 =?us-ascii?Q?y5ivqGOxGxZELdT4O+TOyMVhybp0Fp50Ls4ZMGopw4PW+bG0aZSJJg5bsGBJ?=
 =?us-ascii?Q?6PLNZaF8nCICcL3NLww1sqfmUGIOhgi60+eNQxNmYrwm5WRvWIj+vI48NVBa?=
 =?us-ascii?Q?UfRAbziK3XcqG+YCCiJLhGUQ0Q2xTjbwiMwoYNqkjLcbPVPt3vW0zEVZk5NA?=
 =?us-ascii?Q?RJfR+MEiUDNuCPhjg4VpctOIMAqlJEvQOjX6zMq4dFAL0toa9e49LeFk3oxa?=
 =?us-ascii?Q?iGyH/c/i0ng2btkfjn42tYa6w/r/ldyWNbebnA3kXlMrlaknBgvLj/8M0Sw9?=
 =?us-ascii?Q?qwvkhbdBjGtoEAtnP7+BZRNP7xBDu+/c2CNGUT0hbhHNW1X2Qi0dBGi87Vic?=
 =?us-ascii?Q?CW5u1IhkpgBwO0I+GOrNFEmUWevkk0qxyFKAMYTumPI905ebZa/xn0vyGMZu?=
 =?us-ascii?Q?Nji5pc+HgGQrIj+BPK26CbpAbZ9INi7qsY74LCJFOUNBEckZYtv8WqurYVMF?=
 =?us-ascii?Q?L3IQuVBK8L6jiZCHJVBrn+8Ytz+X6dENZRbBSqJcKntidd23TklDt+pJD4Ab?=
 =?us-ascii?Q?b3c0YDiK0mfcD6mgW0+FJWezQNgfJ/NyvBXYTyFtvWwlQyKto/KgRpWbNM1j?=
 =?us-ascii?Q?ihKOeZjVn8afKHyQD2T5BjxHQi+bXwlEzPyxQD9zT0lgX8vtSsohjmdzo1S5?=
 =?us-ascii?Q?gC81mlTtRPcPOufjX01cOhHROvTuh2lSWDWbqIKC8Kr5G6HhbnKRUhOZRPY4?=
 =?us-ascii?Q?TOfZqXYLEL5Ugxju0Ds+ck6Pf0VcUC3ytgcan4LimcsPnpnYCcVa+787rc/U?=
 =?us-ascii?Q?2pRy3Tq2026f85t9eZ6R8QrLQ8rAvFlITpNDI859+cY1+j37gWpXS49aYiHW?=
 =?us-ascii?Q?5pbDPL24F5i3aLlvXrdU5MBYIGMUWdDeubR5CH43Jx7SqdbMkg1IRqvU+k3z?=
 =?us-ascii?Q?9aPCwKmNTgs50AgalxOAvBENYEZWRVMrlPfcgeykU6cS9+vW+fN4w/NEU1mX?=
 =?us-ascii?Q?+H8Q62jmjLo7nT1l3krfuJJzHpW2dFaGwrvmbUzH3P8w/ZjAxxidWs+foua4?=
 =?us-ascii?Q?CianW7zZuggjEoVlz05eN3fFU3YfuHgzvkjk1suEkoM/voIvcYh3Htki6IY2?=
 =?us-ascii?Q?3kqq+J3uHAcq9AGHSLKDFTiIgkMrCuvBhTJgdLQbQYtEhPi9ZwVYkKMKgcIa?=
 =?us-ascii?Q?xn8LsDqb69w1aVOK6er0ftSzOLng10B4T1Ss6hTnUfxnUwvNncoJ56MEX/s+?=
 =?us-ascii?Q?XVbzgfROHAKEGHY0EBhp1368hL+vmFKOMRnokymZX6nN0j+d7PEyct9Eu41T?=
 =?us-ascii?Q?mezVauXAE7qoi2u/63i3EWDBjv/8qJ0IoUhHYkL0vvaCmT99+TzRgg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <642259286CD92949AA72C30CFB9D2F8B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93b9889-cee0-4054-bf44-08da06a271c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 16:39:58.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqxg5Xx1jac3FDmzYlKAGLs1bcm70SrOFEhhLh49eX+D3dggt2n7r2ObRVPm5Y5o5KXrRk3XbCMa/SbIns92UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3893
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150103
X-Proofpoint-ORIG-GUID: ooNUHeEoz5dH0EbrYuxBwIv2FhrGBt6t
X-Proofpoint-GUID: ooNUHeEoz5dH0EbrYuxBwIv2FhrGBt6t
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 15, 2022, at 12:30 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Tue, 2022-03-15 at 16:22 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Mar 15, 2022, at 11:34 AM, Dan Carpenter
>>> <dan.carpenter@oracle.com> wrote:
>>>=20
>>> On a 32 bit system, the "len * sizeof(*p)" operation can have an
>>> integer overflow.
>>>=20
>>> c: stable@vger.kernel.org
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>=20
>> Trond, this patch was To: me, but either you or I can take this.
>> Please let me know your preference.
>>=20
>=20
> I don't mind either way. If you've got it applied already, then let's
> send it through your tree.

I've applied this one and "prevent underflow in nfssvc_decode_writeargs".
Thanks, Trond and Dan!


--
Chuck Lever



