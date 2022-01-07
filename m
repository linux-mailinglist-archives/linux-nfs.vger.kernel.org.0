Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD23487EE2
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 23:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiAGWTQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 17:19:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40490 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbiAGWTP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 17:19:15 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207LlBFg021264;
        Fri, 7 Jan 2022 22:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oZNO1qVhgL/LSqXpTjeOaJWc74/fyUnCul6R25P+RBA=;
 b=FrbbpnUbftrcSsLBshvtMXU0oiFsZkkgyTfl2QSYuO+HSwZoBAwhbLEBKddrdixeo/b7
 27ioJyQcoW6QNhDuzDJ2DrQ1w9+owTTybY0eh+BQwWGF7koilneshemeuIcb2lJqwTx8
 H4ebxqSpYR/yR2jR6D1lQVYbI5h0zKpfnzW5XnQH1CAiPGRlkowRKcoWz78uEuUCJ8/T
 2SCs+ewQ+J9t59Vr/fnkJuR9+lwNpEwdkVg4e5/6z+KHrZVp9QqZZgevvWnpuPWUZ4Tc
 rJJg1q6e01Z6tzaqdNfS0tKAaSS27gILTRiz/FaQ63HGTQK135c2paL90yfIpJTWkRde ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4va33yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 22:19:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207MFmXM176205;
        Fri, 7 Jan 2022 22:19:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3020.oracle.com with ESMTP id 3dej4tcsek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 22:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvZy9WP8kEsQyh7V59yQJun/yYonmF2VmxMImi6AvNME5FdU9slLQ4JkHliTep0Aba/ALmf76mBp/lxkWqwTD2neXNTeqfDNITux8yn0IigeTPsPiFo0e2Psjj90m9xhA5tdhUsyrEeYxSIhHulCz9+zKB0pwlEwPlD0uFdJEYd7W29jl+c8pSTo2Xys9Yv2/4ZYTDohi0gMhLVlx/xdWgvO7XN06KgQEryA048oRwePOVOhtrAATqjgaOwB0Acj2InmH3xMfsOHpHsQH4i3R4OpYCKl1QALQo5yfYsyS4Dv6McAPmSCPwIQ7M2PtUPREbCoJq1fxvNfr+qaFhzlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZNO1qVhgL/LSqXpTjeOaJWc74/fyUnCul6R25P+RBA=;
 b=MufPU/Hvfv38R7TJFehtgWaEKlGVJ9Zii1D3z51sMOhxd7YrsLMkG4PVhc7jSnflrHVOHkh1522YFZPBmbmobci3giAv3CTHD4NFuc4SeYQPpZ8lqK8AYisJJ8m8Q93t1iQtaKFih1il2hIMcUSgksMi0kdLb7WPpH1e1SKaElTv+cv6Q8Un4WzSfUTsr4FBolFFBLQz4eDv5RezPJA4tSXuOJ3JaMMdgc3pHP8xu+THsVCod1LrwZQnPLzjkIYBkIXGHPHK24fFmrnEAKfT20RrEd6rhxXu/Aa6+d7upMWPwwfyNYGVWRynwInrWnaN0Oqmsx3UkuQ9zPwuKvo5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZNO1qVhgL/LSqXpTjeOaJWc74/fyUnCul6R25P+RBA=;
 b=fFqO1DgATnLQDfeDOGcNWxwzIBMI5g2fbOywDpbFHPY6XllgS6cvwnGCbpSMrRh7J/9BHuBRvT1GSWXkYGxFtmo7c6MaYZZsBe6N4U4SsQ3EvL40i6x8HLWRImVpzbOGiJseVFTyPgSX/AnPy12y11uhaHCHTgJ54V2F+QIKKQ0=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5002.namprd10.prod.outlook.com (2603:10b6:610:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 22:19:10 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%8]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 22:19:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS testing
Thread-Topic: NFS testing
Thread-Index: AQHYBA5nmFP/WdT6jkuMOPZXYQwnKqxYIRGA
Date:   Fri, 7 Jan 2022 22:19:09 +0000
Message-ID: <CDF41C32-7A4E-40B5-9E54-6C0DCEAC03FB@oracle.com>
References: <20220107213443.GG26961@fieldses.org>
In-Reply-To: <20220107213443.GG26961@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2fb3bf3-63db-4bbc-af0d-08d9d22bba48
x-ms-traffictypediagnostic: CH0PR10MB5002:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5002C8953EACB9AB40AB55D8934D9@CH0PR10MB5002.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NEOFlzBwvWuhJLMkGM/izlS/xFtHGih2TwfL9qYS0XXw4tibT4JQ3NPV8OGgPwhCZfTPTwpJjRJcan4P7gykSFf0x8jb0zNlEFmgLxw5lyX+re2/7WI12rumVeTVGcX5HJbZhII+UYsxRwoTS81ES2IGuk6bnVOXat2s86vYy6hxzJhwyhVQNi5kaMmCLcj1EgCn2numAhSYQF5lSIWha5L1WY8GOMVxJ10WHJVCRZcBYsQldk2OOmdJBUM8enXHfzRpvBUUKgefUc52HpX0mE34oLLvQ8Ozu61nDxMO93gW6XvCjfQvDqmuJIH6ftnVMFrKEZLF17pOD6qkwcVMmQ5uYSIUnYXvPQ2SRWFEaScjpjywFAX1fVN6NYZ3Sl1WxPIYC2IUMAEmBhcc2g4X2y5yWbPJVdLr9dp+SAFPFPneHGCeZ1zWV8eG3p3OQNZ3dU5hIYLdz6nxvzDKWrqrKSBCMGWS+0LIEhE0nDLhWcyPNKKpz4G1em6Q6bVbw3djCh/Vj+MVvn3ykZZe+e1LpwR1Bkwm27GdL1M14QJDjcUBHYJnd7Xkq745cLlRHo+lxAR6Ty5B7maoam+YYi2as1il9IbIIFBsIoTZ99GlOJ1vzOUl37KARgzGcMWCt4epBKd6X1bLNKkoeaNY+k2c+5+z0jNK3QMuMr3Fs+SlJF4WoKHXegqVhtlV/MgRN+Yz95xRLAPnw0Je3/2kl0mS/jI63qKnIlM4bQX1zoNyZl0uM0iRrTtlbO7BKdWbv1u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(3480700007)(86362001)(6506007)(122000001)(6512007)(6486002)(316002)(38100700002)(7116003)(8676002)(6916009)(8936002)(66556008)(83380400001)(36756003)(66446008)(53546011)(508600001)(66476007)(26005)(71200400001)(4326008)(38070700005)(64756008)(76116006)(5660300002)(2906002)(2616005)(186003)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9w22nxxzJjc8Fvc/+VqzOanDP1Jb8gxLX944bSFKuXISCpUqGOp0BghHXcE+?=
 =?us-ascii?Q?1qNNPZ6bK78MwQG6a5MDvglqX1JGWu2UMsKk1QXewblyh1avNQ5qWz1iMfAF?=
 =?us-ascii?Q?qu+4J8ggdYP0r9GgB8+59huTQYZxkQvSbHNpDsKmTnZQSYleU6zzu8I2ZtTA?=
 =?us-ascii?Q?k+R1qmk7gJ2LBeBxNBwjLfJqZK+AADSQAkbQB73wjN274sHQEO4HjSlqiBWB?=
 =?us-ascii?Q?77WM1fOs0LrJUKE1ANWJey7wI0KSi5v345wuOPwsYogreU8XbQhrmsUbqo7V?=
 =?us-ascii?Q?bbxcn8Tgy9TPH9LZt7Qb4Z5BI3B7ls/RYmJAoliYQ4hbaMpJ/F7dT9wssYZ1?=
 =?us-ascii?Q?KjGJhyuZmWIEObAscAI/sa+Cil0khVFHHTl0Ssa6wFUFGkYkgnCf31ySGTAN?=
 =?us-ascii?Q?epibqEWD5vvBI1Cb27snNpubeDOjidyjpHl9EUHHnkZ0cKz1kUdgSRlcmqwa?=
 =?us-ascii?Q?+lah65GAyIJXpoiMMAbuYcCqA6UaM4IMp5vp4gS2OxHn95hH0pujZMfLF60K?=
 =?us-ascii?Q?6bkOcrKXvo1b6TeylYruBVJmecSJ5N4wyc2jXEAtPgnAUHwGQL/uQfBrkFNz?=
 =?us-ascii?Q?vbhNDlzJjq4tjfyvfEHkuhkTACbbqxxYIJS5gxIYtbBmk4/denDXScoiKmqD?=
 =?us-ascii?Q?5LnS2ozpze080qkhtXJYRIYVzRm8sr5wva9YPOoxnCssIqW9T6kwqA8VPu74?=
 =?us-ascii?Q?wfcQTZN3MciILFUsC3UCcea8kka1OCZ1rOTXbfhSuw3ELgVCBBvOWxp3ZSW5?=
 =?us-ascii?Q?Gr65IDHaVgVxvTviCIA4HnQRaZpUA4xFAo4f8oZY2+kNOtaf6r6sit0/wNRK?=
 =?us-ascii?Q?ExzlqYDpxR8VipUnztiFoMZUQnfzrcNm9/j5uQaxY2YKl0TxZNfmx9YdEWWK?=
 =?us-ascii?Q?TtSkSLCDnf3oFRGhsDxkcHIC1cdwp8mU2qvMtagzqcMqTyPxiqMT1Gtf+MV8?=
 =?us-ascii?Q?HB6SsqvugVNm/hJTcW8IBfZwenA56zJpQL3zd9nkMbGWC4vTv0J3gnYPMfZ0?=
 =?us-ascii?Q?mZkPGl3A79120Ea8h43SuqLZGJJskaShjDg9/2bxBejHdgUTN8etmQDq1uPZ?=
 =?us-ascii?Q?ulPIM2j8z5KeEoZ7M47lsj4U9V7+uA+skWwI5XvmFooWfa5RzDbb0J6VgMAc?=
 =?us-ascii?Q?FpTaXliB2UMOb4w4iT5AKXHyhCDFz+wke69Nuu0PNeWZL9KNnnI0MAPtpIQE?=
 =?us-ascii?Q?eoReS6fpVS5G7g0GD6nWnA8KSCQIylttxMbKKOymPgXu+xGL5vrLGxonezj/?=
 =?us-ascii?Q?+D+ApC47ahN70Ve1v8zgymiYjJwCrse1cV/Ffhd9bYBdXh+pJUQITkKPjfF/?=
 =?us-ascii?Q?9Npx/Mp9LCaMPEJ5cMqDpuIAM8fuO3XzkamwdhY2KSUiahuIwtLsnFcn//9I?=
 =?us-ascii?Q?29vU5duPfipv1kG1epSJVl2e9GRD8QKPdDKG3svnUe8PiAyctQhkm3WC3SD2?=
 =?us-ascii?Q?tO3cPDTMNhu1J7XwWkPzu5m0nQN6cJ0TXPAx1LKamj8aYaZkE5pTO7Tvws80?=
 =?us-ascii?Q?Xm+bagX0QxoTcu2rsccIztf4EnOqaNc/CBL+JuerVs1uaBybZpb5LwemiYRD?=
 =?us-ascii?Q?lZG+kwg7eEvNnoCVn3O8vlVxRFxBWcLNJlMijiMZZkMa4h4EpG7TB3OK+Csp?=
 =?us-ascii?Q?6E8dnWsahAqsq+IbUqpOPww=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C682370A4FEB0F47B80817E09463B23F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fb3bf3-63db-4bbc-af0d-08d9d22bba48
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 22:19:09.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gK9+7+jToMuut34Oe9ePpmsynhKB+oRUWvxx8ooQx5I2cjOWbGqnBydTcAr2qPnJgPYs6phveGOtLKz/Xo4IFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5002
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10220 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070132
X-Proofpoint-ORIG-GUID: YEIwDKwJgSRv9WEh7_20IC-IykFZUlRQ
X-Proofpoint-GUID: YEIwDKwJgSRv9WEh7_20IC-IykFZUlRQ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 7, 2022, at 4:34 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> Chuck was asking about the regular NFS testing I do.  Cc'ing the list in
> case this is useful to anyone else.
>=20
> We'd really like to set up regular testing on some kind of common
> infrastructure that more people can get to.  I'm not sure how to get
> there yet.

[ useful stuff snipped ]

A little context: Since Bruce has announced he is stepping away from
his NFSD maintainer role, I'd like to help give him a breather with
his testing responsibilities too. We've been talking about shifting
some of this testing to a public CI infrastructure like kernelci.org.

And in the short term, obviously I want to ensure that NFSD pull
requests are adequately exercised...

It would be nice to have a facility that automatically grabbed new
commits pushed to our for-next branches and ran tests on a variety
of platforms, much like GitHub Actions does. The kernelci.org
infrastructure is intriguing to me, though their usual case is
booting up a single guest to run a series of tests. In our community,
there usually needs to be a client host and a separate server host.=20


--
Chuck Lever



