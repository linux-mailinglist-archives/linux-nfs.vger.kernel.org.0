Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5853FDDBE
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Sep 2021 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbhIAOWw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Sep 2021 10:22:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18776 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236539AbhIAOWv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Sep 2021 10:22:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181DV602022792;
        Wed, 1 Sep 2021 14:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7dtNQcxsbkYPJR3V8T5/4Cg9narbAvLUxRPW3cloTeQ=;
 b=XwyLUioJIt+BIV3M/cZHqAk60pvLKCrQagdA+6VxGse6BRy6zQXi+HJSrbSjAiNaJxzx
 Wks4gAibJsfa3KH2q+LrhwFTLyuGEX6iPjvvTtzJH7Iqk+cK0jBiLVA/dEDznCqSH99A
 vFfGv1wbN4Av71uhSVlV6YrJruX7LbBiglyHjhygcGJzLlNzgq8IozPZPkZQd7wUzO6M
 5LCNjbRAnBFlqcjrkfqphC3EisO2Z9+yOA5Y8W84HJrHngq5pGZ/msbTFFhGaRZSdFmO
 94bNABOP+JYScmrvP3GaI1UHOFpOEfEJqzMnNChD2estJotS9cyG/6h6/v9QV3KKKUOn eQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7dtNQcxsbkYPJR3V8T5/4Cg9narbAvLUxRPW3cloTeQ=;
 b=pGRARGHy5lj4TLf1shl9gMU0S3D17iceB+z3/WsEhnVyta9oF/2rt6d9dJN98ummuB8L
 rUaEvTVXaavj8+nHBEaU5nE8xEtKUE1atatntsK/cZ5pU3R4D/qvtFM3Ep25JHIeKtPC
 bRgr1NkEjGGXxAG5AY3CpQsH5jb6LHYawYK9Xg4AImDYvq49oU1moH7AkxZiwmEK7QXu
 UztPHZG4VL2AAXVDmK5IKb9roA3DIijrWjPlt/DDYCxPsLviq7qMmMIc1tssAwoOZjNg
 LHWx6z+gSx5LwfKgzOFGoTqH17HnkB8emnr0yk4eAbN7/NUTK6uIMMctaVTfWSQ+/stP AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aserr4pp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 14:21:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181E6PR6036522;
        Wed, 1 Sep 2021 14:21:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 3arpf6gcya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 14:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eReJQq/pGPED/O7OccilBnRp5f712+NGayZrCZh5jaSkt8Bs+9uHos2wq19UBaC9bx4yowPmv3d7+I5Kb68YIvE9Eo0RvTpnjOnWqyVTMt1REHToRcNErUEt+hUXGZob4OAztUhzg1oWpPPnMYgkC/JiurZgY9/bzmp/nJegMR3wAAsbghBCm9iCDgOtLArVRuaLNViDQ19nB6PrCxtmUiVAtIeNRrxxsJ/qXX0QJ138fDbmuZWi75+/CJFFHmIjZ1Hmky9sRuY8kX8lTO8MdkQB36NHUjrE+WaVADu+pzwlxueNl4DTWSQa7l0q56saVFEVa9O0ztBIOjm7YVU1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dtNQcxsbkYPJR3V8T5/4Cg9narbAvLUxRPW3cloTeQ=;
 b=EfU9+AdavFZ7q7KtL99n2JrFH8MJZbwobjPnYYeLEhNvPRyIuHoT4v5EHhZjO4tmkoT6kRZpHhAf5C3nMfpGoHv9+Ldz+T/G3BbEbPk35ayW3sZ1/yAtorh5KyhxbcqCcNEOM187bsArH8LMfjHm2T1DOfPcMDoqJ3PKaMb1nYoO6GTGZq5UF5gHch18WhdJFAVxC9ONbucjBezBGjC5IuFSd1SpTUB9VzzbJ7I4Gh3MAADWNi+26CRGqSB6T91qta36mlM2KOHNFsSK+FEceo3AtXUpnu+nFCK0yKP/igTHWEZAxaxR+kqfhP8hVNQ6Bcz5uifjBEYiPJYNQYbXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dtNQcxsbkYPJR3V8T5/4Cg9narbAvLUxRPW3cloTeQ=;
 b=Fn1QAD+Ntok9ytprLpT14ooSD/I/Is7pK6V/dMxhz28NI+4eIzA5tfLlP6ZLJJiAZme3xyEDh1OEL21jxx2YD3ldYKCJP07WwKPkuMGZJR25jiR7bKCePNa4wTDre/vwqqapUvMbWGHMp8Ekx6MUMnsGrBtD9Kk/KMn7Sx1sqqE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 14:21:40 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 14:21:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2 v2] NFSD: drop support for ancient filehandles
Thread-Topic: [PATCH 1/2 v2] NFSD: drop support for ancient filehandles
Thread-Index: AQHXniJ+kER9qvwCX02XHPl3DPX7UquOzgSAgABvEQA=
Date:   Wed, 1 Sep 2021 14:21:39 +0000
Message-ID: <F517668C-DD79-4358-96AE-1566B956025A@oracle.com>
References: <20210827151505.GA19199@lst.de>
 <163038488360.7591.7865010833762169362@noble.neil.brown.name>
 <20210901074407.GB18673@lst.de>
In-Reply-To: <20210901074407.GB18673@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed05c10c-980c-45d1-3988-08d96d53d050
x-ms-traffictypediagnostic: SJ0PR10MB5647:
x-microsoft-antispam-prvs: <SJ0PR10MB5647DECF8D60EB4E5DEA60CF93CD9@SJ0PR10MB5647.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJNa93KwOqqRSYhok9zGFONXFtxsSwGzxOacXzdHuZ6oyCxvjM+iG9dPUxyU/Psoc2pFpFamiF275CeKGnyRB6GnUtPSAmFGbQPylgjEhj/nY1mTqt2mQGOnDxXLzxLYP3kpxuZ7soh34Lq/eRsUV8qIk0m7vw7dsNHv/R3TSO82IXYSjHXh9jXBSgeDKCzZiaTBCQqjZ9AsaZqU9EPNa+zuFWC7rYWmERxnInQxMQyMjK0Vq7sv7U3AFL43P/er+nY8uAVfRrYR9PkfstwBPxHODqRIoqdZLonAADpJ/qMfX93RCfLkd4xC9y5Nm1zBsZb3GxYbAq3t2g0kIedYnBhBjDSA4xMAWVoH6SrRi8atTded4SLQ6CZv7KYyb28LHk3kl0OOq3hu5ukNkbsVACziJcQhNuLqXpoeWhwfKgogNYG3vX/WaHWvoj29ELx2RwBKzPGzdXrAeNvXD8bA+V4sJHZ1cc47kqDpYB0bCMuSGoE9peSlQuvCEHIU1HARXYaAgMnLIlH+sKCZ2ISIWq2Q8mewBxnKfTwp6EvgkoNPqjTjLix9l1tAf/oFZi+4R2Ku6M43eK0ThI1ljeFMD+vKJLk/rEaDMVmnaUghNKvOQiiLGoJFKoIQtPAMfdEVvuVw0WFAr5NDyaKdB7um8CRuo3ALAN/LmE3BuradqgChLdXyJiUQ/VvjRwjmWBf8RSw4OZL6nO21tu8WLZ0iQGBArsgZZtm1gOJr5s+rEKpMrPbyAmzBidIl4JA5Ujil
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39860400002)(396003)(376002)(4744005)(8936002)(36756003)(86362001)(122000001)(478600001)(38100700002)(6486002)(5660300002)(2616005)(6512007)(2906002)(71200400001)(76116006)(316002)(26005)(33656002)(54906003)(186003)(6506007)(53546011)(66556008)(66476007)(8676002)(38070700005)(64756008)(66446008)(6916009)(4326008)(91956017)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSNI+U6kajEPa3Pl5CMmQAWmeRa3zCHBLZdmq1dRg7eEVhRElmRZ8C00zLbo?=
 =?us-ascii?Q?pjB9bD2aJoXi0KgypIyH8//DiHi34nkLHjThn7cLHTC2QzE+lBT0ANWE8FaW?=
 =?us-ascii?Q?BmRvYZwWXXEKEeDIePubSddIVDU2+ogFuaoLLFsTfYe7JPeKgL+kQuT+++fC?=
 =?us-ascii?Q?2fhzz4Wa9iH9rgejIAu8Fen/9eWwSr5Yd2GYX5S3Y1Ta/9u3Eal+1+HfNrnF?=
 =?us-ascii?Q?8npGGPPbsGK4NUsr/ZPMi6j3OsXl/JrA9GAyzE1n8ba2Q+34CuUEPfg8Y407?=
 =?us-ascii?Q?+cYVTkUK1yC6FKlg8m7b5f2I/n0DUkwOLPm5SXS4B767Keozbm8qmcjB7hvO?=
 =?us-ascii?Q?UBnZbyxgfbrtOB77ozURGHuVQPAB0Xl8Xmx0yJy4skTVkHfP83WxhJU197YA?=
 =?us-ascii?Q?csFcD5vZI2QpnofWoJE5JR9hHZk6vCnIvIuk5OFtE8re8KL+NRPieXIIPi9G?=
 =?us-ascii?Q?FCWZ2z0/+BFbr19sgwixpNutJg5yVRYREdr0AYxtxq6ba/wKfWVSmY3BrXU5?=
 =?us-ascii?Q?7GzKuTj5Fk14PxKJNSOJ7f7tFSlazNlr0zYw1ynN3jmkUFag20JBohqyWI63?=
 =?us-ascii?Q?AOryVIB1tvfTSfC/8BLxgTcnOUoEj2tI+IUaYqRheU7Pa8+Tv6+VUOGwKvH9?=
 =?us-ascii?Q?YZBuLjqOzWeCzPwfkfDQo++Mgulo5o62FiNEjIHENko8obqpfkKwIqo5n4oY?=
 =?us-ascii?Q?8glufoshuuRJkJaFGAnAZ+Ih9lfKuzW8KXIHk+2PJPcuN2exk6kkHeQyHj2V?=
 =?us-ascii?Q?qeWE8QeXVzlFKd8sFTgMcQ7cDLFdKM4/us5RX+4rFAIn7JW7cuR5059oL+SR?=
 =?us-ascii?Q?HycYOHblZGhD12pCs34ppYHWekdwA1EskCSQlpE5vA6Uvr6aTPXr5d5n/Qon?=
 =?us-ascii?Q?jTKZferGqPRX3gK3io0fiUrOpZwLtSyH2tMI6ksPHqvUoAHDCyN95KcQUgCw?=
 =?us-ascii?Q?WKQcOpnwY87lX7orqyJFkpFg6R4/WGO4rzvg/FJDPmUE49lNP1aRYJHV9jR/?=
 =?us-ascii?Q?CMRLVOz0SXdE5r0G4zOooAaIrGRz5bV7jeMuu6GmYO4SBIN6tJpPEewn93SC?=
 =?us-ascii?Q?fTc2M6XDstHldodEazCd5UVbMY8/0/5QCjiFwTEhx+LN8fI2daRksOFvoC+Y?=
 =?us-ascii?Q?tuePZWMwJ1+yqctm1r8dWh3bDrRCfaFqLx/fiqJsgkA2XpCVWfSTLGw9B2Sf?=
 =?us-ascii?Q?jTO2BuLNh3BRrw/H2dONM6++6etXje73I35jR4Ou41R9yYG2MVL8BYJXjl3y?=
 =?us-ascii?Q?TQZrLXAfk7gbPTi8irBEdkQoOj2IOW/Iy/IUs6QB/v2iOOAPIRIKOBNait33?=
 =?us-ascii?Q?C0hDQrJdH1rAyI2Iq+dDaFzQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63C116C289A9EA45A1EE61834C228110@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed05c10c-980c-45d1-3988-08d96d53d050
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 14:21:39.3152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDpwoYtGf8hR1CThGecYeFfIHUZbpalRJJK3HkG+JVBiOAKbwi0Q0WK+XhCFL6fxVgNye0A+IhdnaVLFq39f1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010084
X-Proofpoint-GUID: YC4Y2H-n1XhawBwrQ04xBZkL7xOuf5RP
X-Proofpoint-ORIG-GUID: YC4Y2H-n1XhawBwrQ04xBZkL7xOuf5RP
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 1, 2021, at 3:44 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> The content looks fine, but I still think moving the definition out of
> the uapi and removing the ancient file handles are different things
> that should be separate patches with separate commit logs explaining
> the story.

Was thinking the same thing when looking at v1 of this patch set.
Neil, it's a nit, of course, but would you split this patch up,
please and thanks?

--
Chuck Lever



