Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56AC3B72CA
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhF2NAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 09:00:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7688 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232908AbhF2NAn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 09:00:43 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TCu60Z020599;
        Tue, 29 Jun 2021 12:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tqhfOt4HU/DforIjkmoSUt6dGHsIEqag5j5RDpxgI3Q=;
 b=KQnK90Ap9YXTIwgsjeLVXuHNzS7fUC/+QwrQ+dkZJNrawG188mlbomWAwgfx3kvwPY/1
 e+GsYGSFIhhA580wmwdGCHZikG3+qrqzyns9DKpVyFvcZ3CfNv+dQO0ac8HZ2qJuujmt
 nUzlay1uZag1fSzD67aU6w7c/7LThElHi6zIFNK1Fqjk76/g5fIDkydmiUIPxojswaT5
 8lMsyV82MGiyfkvKAJptg7csR4m41qqv4CBy40DliLbiX1xl+6QiwGfAVgO61MuWB55S
 mORlpWBGRlUd2zHlnvx1eEmaxRB8T3la8vINExwHFSjLuGHCcDDfXGJ7HLO4LnHlkwCa LA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6pqbhx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 12:58:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15TCu3xh058080;
        Tue, 29 Jun 2021 12:58:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 39dt9eqkra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 12:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS+VVO5AJJQa7GjE2SQwlfrKlFbXx4LVNIdEgEJPixnXetPjxegxYSZ+2XBzSuF2cmnEpy5UZdnke57r2SnFJ+IXynnAUu9+4VaPA6nENy50IRf/8jpEp6/lJQayPUgDOxnCHjnSjw3/5D3v+RGKBpnSEVjYtoRhjvhY7FCAaElAdql8yrMCO/O8UMACOwiOCfetOYyMhWqx6mnWEPk7GwxnjEq9m1Ae+RfYOH0vvJvA+GlMQty8s2ZUQBrhiBHmMPYEjNSxhv41TEwxdPrOobqE2t9EW4wobK1LGobAqVXUZfQ7IMTcE9oDUgJWTuWC7RACV4H7ItzdXyGHO5S/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqhfOt4HU/DforIjkmoSUt6dGHsIEqag5j5RDpxgI3Q=;
 b=F15X9faK15dp6WytnSV1aCZEFCXbHIiLooe5Xxh7Iy3HGRUSWROe/tksEkiVcBydN8YUCWptZLqXBvv/TYV1dGzCmkoyQajoi/lRCL8EEhKTSBkyx81QFeRGCfSz60GSOdOxG8FylmIhf/pFTTkbZ4KurZErungIjSt1i3tM6OCnADWagKwablX8IXV6JKDvDRzJS3L1GYN38ScHprZ67oZo3os5r/DK+raGQAu56jd93/7BQt+SZZf5cbYnSlkc4fllJaoF27jpuzeEt1B1AdbySjbZ2FscMsJDm5EnriLK3LCeW7mjRWEexcz4rVDyEu6/8ma195dqXpKkj5M+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqhfOt4HU/DforIjkmoSUt6dGHsIEqag5j5RDpxgI3Q=;
 b=oQvf/WjlCnUr3T16iFbk0WXxdBzrqKtTYJzYOgdi+KrDD1yU2F0887nPIdDQGXTBuYifMRFu9rU5FFHl6CKmUM0K7Dbq051cusx5W4TRJKuUQkY33z/aGhT1m/l3cSxZYaIgsgMPtTM+FnB7YF8h/AlJri34zCsyLFzhOLcf0xs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5408.namprd10.prod.outlook.com (2603:10b6:a03:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 12:58:08 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 12:58:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: Re: client's caching of server-side capabilities
Thread-Topic: client's caching of server-side capabilities
Thread-Index: AQHXbFuOOfOdlv3jtEGkiccADhbLQKsp+uwAgAD5LQA=
Date:   Tue, 29 Jun 2021 12:58:08 +0000
Message-ID: <B0CA736F-E3E8-4446-9A6E-3ADCDD7F8736@oracle.com>
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
 <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
In-Reply-To: <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb43947d-4817-4b4a-2a5f-08d93afd8b2b
x-ms-traffictypediagnostic: SJ0PR10MB5408:
x-microsoft-antispam-prvs: <SJ0PR10MB540822E4A8B9902735B4708F93029@SJ0PR10MB5408.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnKysb+PMmKlbmBbihe5v5BKKBnHAgp39Tw0WKN2I24HDzu9jj1FJrOvo9aTNV0qhR/lfkizVU2W7oPCN2Hcxjjc1XnQOh6sNOrZUR5gnXLDx9fzq9w06sjnp8FdQuXtS7c941FPjQ8nfdVQRNGcT6fxTl/wo+WcwLhbXjoNDNEQHvGlwe2wqQr5w6x6yCbybXKa+Wz/AuC0KeKoPAkR0I0KvZsGJeYzvhotWM5oBhZhyyuolQ8bOjtzZe6Vg87hmqtqk3WDKxyHpSkax+irbtCGT8FqFSyE77lJB6uSw7tVoTSNOzYQBlHWI0d/R1DnLqPT/V5y6SaUblRLMKOjOks8zFbon3RrRPYXOittEJEGDwXfkxgmaG7YFKsQxSDVxgBc1nlTQFyeNZi46VU33afLinc0U51StaBAhRE90u0rQJmVGt+LvByaW/rzIhvRlhGCpKt/VX8rFeHQkeRyv+eHO4ZwpFDpsPa5PuiyXZFOX2iLqG6rFApfsFvTDRIUrtGrAK1Yf68AtIhg17uQqTNciDqiznJDeQrgOSAxUxiESnRZ6/y/OU8eH64TCj/Hpzm0QS04xPKC29JpabuHL1QTyBsNjBAENGvv5zGOaKjke2HDCiFSAVi3KjDepnlthz74+UDEeTFtihc8SVVsqqu5ebKz4v4ewkBHuNnsmW1ftI8Q+jGOPNmuwT0V5RY2c40zc2EtXDtiL9rPO3CWbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(366004)(376002)(39860400002)(316002)(6916009)(6486002)(8936002)(38100700002)(54906003)(122000001)(33656002)(478600001)(76116006)(66476007)(26005)(86362001)(36756003)(4326008)(66446008)(64756008)(66556008)(66946007)(2906002)(6512007)(8676002)(186003)(83380400001)(2616005)(53546011)(5660300002)(91956017)(6506007)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aZB1uNFSmM0J1ISYLZo2ZxhSH/PNVqS/SA6C99j1kfQBYMzCnRlxjHhcKQ37?=
 =?us-ascii?Q?ouc3OQsx0pLSbjHa/IVXJJuXkaYgjYHT3Mfbixdxi5Xo9AYaUDskUsuZP2Ls?=
 =?us-ascii?Q?rpZGai5eh0Ehj7jQwFN6C68TtkkcQsT8/tiunomMh28mr7aAEVY3qm1QEhUl?=
 =?us-ascii?Q?t4LjkSsdK1mxwPJ3pk1bLn15ZMr3HDmSW87+kUSl3BBrr2ln1FsHywMCaNHp?=
 =?us-ascii?Q?c58QWpaJQVJOZSfBC8dOOFTvPtBL2Q5CWL8xw+32SOQzZsEBUumQrc8Cdrro?=
 =?us-ascii?Q?+iQqL7JWvDI9huUP0ftNuFRqsfXfZwj1TGT9q3n52bH9a/bKwmrEvp/nIr7z?=
 =?us-ascii?Q?zTU+Nfd+MfNPbduGQR1oczI1jusQiazMFbZ/rfvQZ6Xnv8QfWjACyhGiJKH5?=
 =?us-ascii?Q?GSdIFqs6uoEsAevAFguvkBL/TLgb+6X2+t1arMdSFB3819G/qVDxW2udVUQZ?=
 =?us-ascii?Q?bwFusBPulEkkvCCGZDyeNNyctW3RE6BeJYChU1MulkWvyEtoGH4cLKKRt4YA?=
 =?us-ascii?Q?q8Me9JEucuS3X5GyEw/+qnX4hLriAOovRNE0XwWwxypha7A2jujgri2stSJ4?=
 =?us-ascii?Q?IWxO4pjoSxxK0xPY7FUEwZ+3rtSTWjfRZitQe1qnR0jj+ODsAQB0H0KKG2iw?=
 =?us-ascii?Q?bJVLz5mTdHWojbQOyqu2WLc7gyKWRrt6haCfCdK/RuquYzgokMv7wkI4RdPj?=
 =?us-ascii?Q?mQs2lRRyw5sLalgVxfzmykanF5ckWFsFXO6XAB2C9h91xgO3roND82xtaLhl?=
 =?us-ascii?Q?T+YHGFKANAhcHlZ1VVAS0mRu2JA3tgMbsokDVO6eaz9OeXbpoa5SfEsu26jB?=
 =?us-ascii?Q?BRE9P6O76ZNYNn8WVNLYOyhGYmSK3JyfuZDSstLkrAAbinWtCzI/S0M8IQbX?=
 =?us-ascii?Q?UC1le4y2wTVI/S4KiVtBMcwSx/masnXch9v5DbTejnVBvQ0ieTzqv6m8yfLW?=
 =?us-ascii?Q?y+oBV9Th1jjkMWPClegd/ULRJbYSZIA2rFVVAFMy3KA/YlOZisNYEkhRd+85?=
 =?us-ascii?Q?2EQ7Uh4tYmLu0htDTn2vjUMmZB+dJC62ZxA/3OSZqVsLRQvubvKlZNjMIPEC?=
 =?us-ascii?Q?5K4yxn9GRujbpI9lp5ThIg4S4YjrA1nP6IR/lC8l4b1NHqtfCszWGmgVDqtJ?=
 =?us-ascii?Q?36hytB03SmLvF6NqofpCZGnA/w6+VAHnysjPezM016MuWZzqGbn010ggBv3T?=
 =?us-ascii?Q?1/jrfGBZJorCCxDZiF3kuJdWwdSx4seod0m7LHSyPFcIiHK3gXXc/eXyDhm9?=
 =?us-ascii?Q?iPvUqflGxHJM+YcrSBaGCQ1AT1pYQV5DUQi//6jcF2FQCilatbYlvnibA5gU?=
 =?us-ascii?Q?Jp6QlJaMQKX7o2hGRX0UQXJi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C2D6080AD810A4B93F27B28EAC7C86E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb43947d-4817-4b4a-2a5f-08d93afd8b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 12:58:08.4599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxV5uMBOGoDxatzNlWQesCK93gH49GfEAcyRNjCGvuQ94Z51Uf7/F4FwlTmdDNToJcG3jNedBF7xpxvdtewLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5408
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10029 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290087
X-Proofpoint-GUID: 75Ux02YGuB3W3dDj-WDZnz_ekUFd2ngD
X-Proofpoint-ORIG-GUID: 75Ux02YGuB3W3dDj-WDZnz_ekUFd2ngD
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 28, 2021, at 6:06 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-06-28 at 16:23 -0400, Olga Kornievskaia wrote:
>> Hi folks,
>>=20
>> I have a general question of why the client doesn't throw away the
>> cached server's capabilities on server reboot. Say a client mounted a
>> server when the server didn't support security_labels, then the
>> server
>> was rebooted and support was enabled. Client re-establishes its
>> clientid/session, recovers state, but assumes all the old
>> capabilities
>> apply. A remount is required to clear old/find new capabilities. The
>> opposite is true that a capability could be removed (but I'm assuming
>> that's a less practical example).
>>=20
>> I'm curious what are the problems of clearing server capabilities and
>> rediscovering them on reboot? Is it because a local filesystem could
>> never have its attributes changed and thus a network file system
>> can't
>> either?
>>=20
>> Thank you.
>=20
> In my opinion, the client should aim for the absolute minimum overhead
> on a server reboot. The goal should be to recover state and get I/O
> started again as quickly as possible.

I 100% agree with the above. However...


> Detection of new features, etc
> can wait until the client needs to restart.

A server reboot can be part of a failover to a different server. I
think capability discovery needs to happen as part of server reboot
recovery, it can't be optimized away.


--
Chuck Lever



