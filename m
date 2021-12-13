Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2180473524
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 20:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbhLMTmy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 14:42:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1586 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240557AbhLMTmx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 14:42:53 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDIjBou005529;
        Mon, 13 Dec 2021 19:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fX7stzimltRd7BNthARxH6OvVmDWpp/+A1xhdI1veiw=;
 b=OFE1QlZHMs8oLGlj+SnZcrtSGk3D56cTC/M+2KaGH8zMNrmnKhnwMkEuhpVblqCzB+tB
 KnZsrzdNYa089jR/sy9cP25CZmLF795hUlWO8Nu17HTaNHF0/zrrYbIZM68KOvoQ8FeY
 uClh/K6xqdwu+YGLu3aFUA6sq8cl8/OHczJHHn+vwfyoP9m/3cEtMa4//7diSwTpPyXO
 9hRQKfN5fJOWB0G7Co8owMCYB9yDijSsLPPjSXy9nlklgrdj/xO3HJc/jIrf0GkbmJNw
 QK5DgRpdhSbg1jbYqKTK7v3w0h4X2liUDjwoYdduQoV7c7TRVNwLjRV2ZWv2YkfQQQb+ Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u1bqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 19:42:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDJPm2G007347;
        Mon, 13 Dec 2021 19:42:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3030.oracle.com with ESMTP id 3cvj1crf8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 19:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+iMaFIfTDlhAG4JpviOLaB6eVF93eqB+n6Yx/qC6e4bEYEeNfltWkA6aFAL+MOrbbv1WynqdMHqllhsSqpLt9L3r24LvJI6ai2MMLyaTMX14jbx5BIv6BBxCPzTHdQzcHA/9CpXECtcrRbH99pPMuEvEDR+ID9vZ7BR2q5v39NKB5Ip653JBlNgBEDArXodU8b6cKj0EYjpgHNNCuehO5NSrE4UitcVMEeTkTIEHYWoSMmq9D6fF9czTGAowjERiaxiTsjy510EeWEHch36plw/dPoidyCidFogIkIPtuLSKeHHmehBkfWx3qQ8hYcPgG25fMHzNcxgfRWrgtYYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX7stzimltRd7BNthARxH6OvVmDWpp/+A1xhdI1veiw=;
 b=BAX3Csa6Kuh7aDbFsFFjhKQByQ3HVMQ58lmtJRCWhbLCtXy++47K7iYm/lfugEr7iRXJYjqTBtOVhNiI9xwMseKXGiv15VCsEJQFv9WxKA7BPdYhk+EABuY7ed8eJW46KoYQhCQ1wKcd009Gx4PkFuen12m+5IUDkfBa14u1SXcyT0jg6wsunuJWL2o9jkgfk6D3yALGn28cg8ex1dSpGhqAXRgpftZUYV/ToCanFTSKhEhjEFsYLTYg7DnPp4jucdC+/8SqvzbPq/oqij2tqUdtMmLbavJahwDF4Gx2Q5qYvqfGmQV5LGZ9/omgUJU/TYMo5Z1M/oo+NaXyQvO52w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX7stzimltRd7BNthARxH6OvVmDWpp/+A1xhdI1veiw=;
 b=rmzR2QI28HGiyqLGPSUsFFwVAWQdsUIRkMv/01NKzGTYASmwkT9ji4KgL5IWkG0RgMy20Fhq2SmTE3zwBcIabYbYaFywbiUqWK1Mjt+ste4ard1ZkQKUz8v1khBdsuwBaO/7JFAkrcrk76ghnNgeUWfY+OCWmUf+XLaKoUCbblg=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3896.namprd10.prod.outlook.com (2603:10b6:610:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 19:42:12 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::ed9e:450f:88c8:853%8]) with mapi id 15.20.4778.016; Mon, 13 Dec 2021
 19:42:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Rick Macklem <rmacklem@uoguelph.ca>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: knfsd server returns writeverf of all 0 bits (but was not
 rebooted)
Thread-Topic: knfsd server returns writeverf of all 0 bits (but was not
 rebooted)
Thread-Index: AQHX7VIEQoc8yG9ZVUucpKOORDcyuqww2GaA
Date:   Mon, 13 Dec 2021 19:42:12 +0000
Message-ID: <E98AB758-5406-449B-96E7-C7FBD0BA98B3@oracle.com>
References: <YQXPR0101MB09686CB60B96426316F4252ADD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR0101MB09686CB60B96426316F4252ADD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5782ab39-14d1-4d04-d6a2-08d9be70a880
x-ms-traffictypediagnostic: CH2PR10MB3896:EE_
x-microsoft-antispam-prvs: <CH2PR10MB389600AE3BCFC0A2D30867F193749@CH2PR10MB3896.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWTeOr5SfA8bNGM0BHfQQbCCMS+sijO4B9MYw2wpw732HVTmq1c7Ilhs5nOFlZ/VcBl3rDS6Q+gdMATem/8YjMwqnufp8LnzRo3bNOZaktBTl27I4M/R9i72+IaYp4HFezWyww7v8A6oOP5lknC8gjKsuUh/AFo5RWwoPD2OM/sZObh//bY8ulBmYqdGBkq2J7xIyWy/jzTqa8swqakigXJoEYPq8lh/HYLsAIOdmgyYQMrDrl9oVdDqkplcJuh3kaM4fg8qAekDFMl6Imb9MGoD3biaD+0nuffILGwXNXMjUn2xDQ1voZYdu89FSa/viq2CjxmMLodOzIEBI+vzwEEA6NlrYLJKXHFB/8Ct0uXjAxaoFaDBgiHA04DfqPrw7K/cbxd2znosKXWHjmlNJ4pPMtzsYregpGAUFyPdu0aU6Og601612KS0IKJytuifqntu5wfr2QMu/Oi5tYBs84n6MyW1eDeAQxWH4ANFOV/fgjpOEgOjjXi6gAKd0ThxERHsuGQn1I9BbEvFO2qWuiXOnIs/OKBegnyP0taQ4TC/TJz+VofB60lDwDfUQyP+W1IDM8vq1ATWkoe20sqp/YPGw67MeixpG6OdCATGMrAUrq5lebdZB3Fv4CkAj8+HSj/E2oSxBK4BYx0h/0GInxnKTxQtAkOapMorymldX5oo6FYC5egENYIecu49WE6aJfg2vuMcb4NxwuVbCbAoC9BDrgY5LgGBm3VBM9XsDis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(6506007)(26005)(66556008)(64756008)(66446008)(66476007)(508600001)(71200400001)(186003)(53546011)(76116006)(83380400001)(5660300002)(33656002)(6486002)(38100700002)(36756003)(6916009)(296002)(316002)(8936002)(122000001)(4326008)(2616005)(4744005)(8676002)(38070700005)(2906002)(66946007)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pHq/5yG8KiUHxX8fH0K1+D9G54idFsIb4S6llU/ToGF8jPO33LDbj2+A4IQz?=
 =?us-ascii?Q?3SD1D9RQUa1Vujv9VN01HWYxOxXURQz/pZ5zPh7cRIoARUcbvRoelio+keGh?=
 =?us-ascii?Q?uOjodSke2pj3cndo0ef872xhdRco5qb04Tvz1Pg+Cbknqh6GIUrfAks2qlDF?=
 =?us-ascii?Q?hbHPooxtijuppzixKtFZ/iWCz7lbE69arK6eHBNWtLRftJyhMPPL3kLLedMm?=
 =?us-ascii?Q?hpT8iG97BLFclaOE5ozHNU2HMFhs8rwP5bM6qExrk1VmaDnQ+363f8Qg4Xl8?=
 =?us-ascii?Q?3yKlcGvIb9O3fwhOo4juX74/fQpTR4LqOhCFUTs+gCp4n8jY6c/6rr6f8b8G?=
 =?us-ascii?Q?/H92y3PwOQhqfXEJSLq50m7NeTiAzCQ41bMyrq5/YHasYF9/WdJGB8iXEzLA?=
 =?us-ascii?Q?OEjhnSIAPEdegeG1VHr6MiVADIou+Ten1JQS4UOr6IQBjFQGJjyYBZ6wytJQ?=
 =?us-ascii?Q?6JGJ/dZJcSq5QDlo8yef723zpO3Mu9jaRThgtvj5vch9T4s4WForgO9mc7Gk?=
 =?us-ascii?Q?nsWrvCWELRsALLcjQXPPMazFiGrbtZCrvi2e8y+2s1ajwimqq5jR8RHvy3Pu?=
 =?us-ascii?Q?glj9yx9x9VsIJq+dxgMEs0rnJgfIarEaM+1m565g+b7AVdDgQrbGz8krB/rH?=
 =?us-ascii?Q?zbeubpYQa8PG2l9DeQ4KuAK8UUgfOxZSdVQ6dRlCASUefFsmQ83qT1N/dLKg?=
 =?us-ascii?Q?z+F+B9RZ5HcVn7s5JMRiTJsvCKIesLk1aXsu+Fa/iRGz8IzqWzdexI7dbwB+?=
 =?us-ascii?Q?BQ/kWkzH46wULua+1rPb+DYbvQQ5BUBK5gcdu7jeXfBSa+3bqo0DhK19yDJD?=
 =?us-ascii?Q?LBVsfl2xt9k1wkKEJcI8q5T42K3Z/2WlvOSzJdhIgxRNXo3jVY3/AIyLc0aM?=
 =?us-ascii?Q?g6OFLSGrYMdq427qbgmpq8p0rLvyncqM0OEwOOxKoknhlJMVqkIkUD3OmkvK?=
 =?us-ascii?Q?NRbsRWfX7KWVblw7vygf3RWPJaEs8eJGvJmJck7r5hX3Xpa1G+J3vnIu6GIS?=
 =?us-ascii?Q?MiJpycV7PMnMlHUYxBgu50EtEyUsEENYG1V64HnOIBdSHrcICLQNA8KmxaPx?=
 =?us-ascii?Q?4zlyga8V+NFjYI96IB//E18cjCYfvuwegUQZSRcwIX3LLZoPp+U6l8AQ97xX?=
 =?us-ascii?Q?Ip16/COAUAJgpC/Hoe2K2UWgzVCHVWonGvoAxi5aWwkajpK3rpisIhRDH8NC?=
 =?us-ascii?Q?+NKblBLebk4dnRubxCZcJPWDlJmAPwtOOAfroubS6IEtZHtEuqgsDhQV4Qfo?=
 =?us-ascii?Q?9GUEqXLyX3aODaJ6YXf1SKHVJs2dCnN6do6TcI/DLT34fY8lI34QLJ5dhZNF?=
 =?us-ascii?Q?/D0NWZ7WwMhnjBHuIgyLoISj8do7yqoYpchhKf9CqJwsQayUBS0T0LWtqLTe?=
 =?us-ascii?Q?OODRSW482JOr1QW4rP+gDITZ330t2mlE3TEpO83hd9MA+SDKCHHuaXrGHW+B?=
 =?us-ascii?Q?72pIoEA4PVKvnLU164l0VQLGY0ttqxfq5kNaSnLqy8vyJQmyJ0x1sPncultZ?=
 =?us-ascii?Q?Imn8ESA2Y26bvQuCj1MYycbSHXp5223sIra88boxsi570lWOJ+1Ppwv034FN?=
 =?us-ascii?Q?c43degIJOF9CIu65VXYTinPF6E9yQLELvt8KT4biiZY+vga/RCtmSENzq1up?=
 =?us-ascii?Q?c8riC4/jodIXL2xANmieE+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E588D74E46786348A29385B45853A986@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5782ab39-14d1-4d04-d6a2-08d9be70a880
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 19:42:12.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ob10gJXnDOb5dtXMYmOSVOEF5v615KTMFb2nD0xvpzr8TtnhBkMZw3Ziy8c62WaFXBHBEd//vurBBq0ehLneiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3896
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130119
X-Proofpoint-ORIG-GUID: N5dITHTTde_gZnSIvnxOu6FTfO3KQ7jx
X-Proofpoint-GUID: N5dITHTTde_gZnSIvnxOu6FTfO3KQ7jx
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Rick-

> On Dec 9, 2021, at 6:15 PM, Rick Macklem <rmacklem@uoguelph.ca> wrote:
>=20
> Hi,
>=20
> When testing against the knfsd in a Linux 5.15.1 kernel, I received a
> write reply with FILE_SYNC and a writeverf of all 0 bytes.
> (Previous write verifiers were not all 0 bytes.)
>=20
> The server seemed to be functioning normally and had not rebooted.
>=20
> Is this intended behaviour?
>=20
> Normally I would not expect the writeverf in a Write operation reply
> to change unless the server had rebooted, but I can see there might
> be circumstances where the knfsd server wants all non-FILE_SYNC
> writes to be redone by the client and would choose to change the
> writeverf.
> However, changing it to all 0 bytes seems particularly odd?

I don't immediately see a code path for WRITE or COMMIT that would
set the verifier to zeroes. When Linux NFSD resets its write verifier,
it sets it to the current time.

Do you have a reproducer you can share?


--
Chuck Lever



