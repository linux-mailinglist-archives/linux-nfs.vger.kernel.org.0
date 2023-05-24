Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE09E70FE9C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 May 2023 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjEXTie (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 May 2023 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEXTid (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 May 2023 15:38:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED35D12F
        for <linux-nfs@vger.kernel.org>; Wed, 24 May 2023 12:38:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OJAGvO028951;
        Wed, 24 May 2023 19:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/z61cDE4eLzZxmeDjjiIBq/RMSPDgr/I4ki0zUmPirE=;
 b=RL33Fs7S1NhQ9vI/mDElaCpugKpAXRjxTrlJPUZeVBCEJHlcB/pr0flVEpBqT08cRVUv
 Y4V/Hk5Vv7NYtgW9xZykxSUg1qFtUb52mZqDZEU9xA9wPmVVdWZY2VJystgP9WnvSQTU
 HOdzrT75zyE2TAslK0Puu+854hOJfBi8iU5nTtLoRqVfU+6/5MKdbcxprDsowQOng4Ry
 t7TaNy4Z2+Qe+vLJJn8rHjZTiN5XKZIo/d/T39R3hVjEaXRqfMSVnuPyR/Wjohhm6QiI
 8Ubjt73HkgWiTwy5tg9SoThQHiryyBVRV2m+YXOwsDG+RSoGoJqXYn4EJogJ+cFobLJL vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsrgar2hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 19:38:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OJaecn027104;
        Wed, 24 May 2023 19:38:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2fdqnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 19:38:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py3z4+O08d/+jUQiuPbpUhdx8kEzTuHKCgKzrt2i+9EDS1UKH0xN57rAz5aUmi4ANs8OuF8X67bx5Alk0p+18Y4nxKD3gq6GsrwswcD7ZczNJFDhd6s79FlIRxr7aw+fzH/UFLR+DPCi1G+qKT02cYFNo+2VzbJFEB5N7bk0yMsjEpFt1YMr878NwO/KJssIA/no4hYZtlrXXodU0mTtx+9E/lY0RmS2+wIygiIOetnt1Qx0P0hTw7+EkU4Eopfce4nXYYpgLgoDEwDz5oM23skeSO4Qt/K6xfvV+GjepvwzMQ4JJUjqAMFsRB/fzfiHQOlLGVQ+SynWB2dp3HIZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z61cDE4eLzZxmeDjjiIBq/RMSPDgr/I4ki0zUmPirE=;
 b=oeZ9AEq/yo5CANmxViS1z23BqDiPtBcNV9deo9HVdr+bQpqn9svHsIgsZhsrKsfy62O4uVR3kesOJJ+TBNBMoN6EGSoh2vLgkAiQhOm1wGx5KFAfk+0DurxGLX9evoqWZKsJDfVJV3H/KhWZwdCslPDCD7fg2w4zDZBXfOCppE6Yx5u1iyA2F9l4PsgHXx//HlfGiodcNpP762D4reBauTr7hIfLfZTNXnl0AaLrhErSVOov2b+T8rsMKJHmW0iUBVmCJZ0GQd7Da9yUGqGFfU+WfbpD/7rnH0EXalKZP6oUBkIWSkvZ0iG52R0ldnEG4nqdSYlneGuh1qR60Q2wlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/z61cDE4eLzZxmeDjjiIBq/RMSPDgr/I4ki0zUmPirE=;
 b=od8cTWq4b7EbUWOgsZgR/rsyoZ4sYTzor0NTDJvyQYKogbm/A8SA887VOF4QRlrz25+rjnwyyvyZvxGoqO2khb5d33wbYWAIOkoE9kY9Jvf46BHUwLfmqz7WO+YEnE5Md4z1u1jwjCcg3KQUyjJ1xWa0qaFILEqlz3LyL5x/B9s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7182.namprd10.prod.outlook.com (2603:10b6:208:403::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 19:38:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 19:38:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH v2 00/11] client-side RPC-with-TLS
Thread-Topic: [PATCH v2 00/11] client-side RPC-with-TLS
Thread-Index: AQHZjYMKOqYevVQONku4I0vk8QSUFq9p0WuAgAACEAA=
Date:   Wed, 24 May 2023 19:38:12 +0000
Message-ID: <7EF6A09F-E6A0-4D4C-BDDE-8D308C6E1342@oracle.com>
References: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
 <4dafe5e56ac269bad9fc45dfee2f2bdcada0876d.camel@kernel.org>
In-Reply-To: <4dafe5e56ac269bad9fc45dfee2f2bdcada0876d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7182:EE_
x-ms-office365-filtering-correlation-id: 42f40629-17f1-4fff-ab61-08db5c8e697f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: isURuWpcLCRwwQvJzTATMyU9fxFEW+bZebvpXjsZtmCFF+HGdr4TPxVjNI+JmpDouv3ftq2fGe280z7ZQZKbcjB+immk7OpWp6Qqkepe3d6UV66SHbFL8BsYLM/5x9Tpx8ce2WXipf0uqwZVp49Zp7xazbBI15IzqiRMDU/i/IIPudo1hoXyzNaSdsxYHha3fJF3DM8/jRbn/f/x6LGE+2s/EIo5vgnqGm/+sa7wOZ2DSi1TBZZLVfEB/AK2TdliFVxVqG5wfcOA2WTvSeHMHzNjy9eovzD+GlIinyIksHw+PrpgBWNtYxGRa7NLCTIW6GnLvDUkiuDTxLvBLDfCJt8/6+jlLEyVH6BEYPNViYBGs/zhyRKxuV5kq68SE3URpIIgtHRf5+5/lcN7zQHzRPsQjJPDSFUFxzHtkY/qRKZoYsmRhs2z7Ys2Y2zfsdxvO8o7qHMZcq6zBPeyF/KwxbOM8NVwJ1gx4v1cb+FAPWzqb58e9T04HkY1aTbpZFVTu3p7AkqEbsSt1d578xMoQmp0VOf7m6he1g0ZgKIMdKqAzdOka5VX9SH2lKYH5xB2U2Oju0TjJYP91G/MqkRQLfTVmDOVCulBx7CaeMvnme8F/wamQnDA1QgE+HacylHHC+Ar7IPUo21sy1kaet486j+CxjD8cQ0XC5sqRncWiYEyeJP6VncGTn2GylVL3IFI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(6506007)(6512007)(26005)(33656002)(53546011)(186003)(38100700002)(122000001)(2616005)(36756003)(83380400001)(2906002)(41300700001)(54906003)(71200400001)(316002)(966005)(6486002)(478600001)(91956017)(66556008)(66446008)(64756008)(66946007)(66476007)(6916009)(4326008)(76116006)(86362001)(38070700005)(8936002)(8676002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LZQbl2/a+TS8Pl4hBKG0VbhlidG9kZbzRaMgQngwJ3dDsUGMunGC4TiJgjmD?=
 =?us-ascii?Q?uBqZCzJS0cya9UDzgJLHpQjcU+Wf82dr9CjggaRPxdo1WDPjzrBoPyYXuebk?=
 =?us-ascii?Q?eLC7NCXyW4przj/ISpynV8LQPYO5xnqysGipLjcUeNKxVsv3wnZTQrrft4h1?=
 =?us-ascii?Q?uQNfbpGTSsjZmgH70f/bmjJmDbLU29WT+fvAYeAEtOGwn6sTbNVZGIKyT5t2?=
 =?us-ascii?Q?dScNdGBB4h4a7AiEu5HrWlIesnNWX2wr7RZ/ihcFspVL33eVpfBHAaN/N0me?=
 =?us-ascii?Q?f08TgBImStycby1vZUNtB1QH0Ksx1PZEhOavgT2ZgmYSWVIIrwO/t4hFMtZn?=
 =?us-ascii?Q?QSy1lYyHC7VX5HWZ3nCipQRC0fzd9NDfH5aGTkpko9lhbYLGuIorLM7MAfqD?=
 =?us-ascii?Q?KgwfAi6eROcJCaeJvZjevSVjeGwuR6xK5D6ECJ4uEVcGoQoBxr5ZzR+IKftF?=
 =?us-ascii?Q?EiWGtPu09yJPniNpTpgGohILS7/f94BSfL5hJj52ml1lgMIPt6N7ND8oHqrg?=
 =?us-ascii?Q?Y6ioFvxENluabItqU3DOMtoh/uGK+nOGzSn1mhYruEFe9+0KzkDteHqmqRdS?=
 =?us-ascii?Q?ezi++PvAN9q7q6WzKNyvI31iFX4Y94TGmVxtvlKj3OpqUvU4E8I+4kw6G4BS?=
 =?us-ascii?Q?2Rcs+iIY4sSH7fgDV41cnr8Vgg4sLVBRrHN0QE4npaN8axKI/UtiGrx6zTCa?=
 =?us-ascii?Q?JzKGR0DyapPxLhv5wEIfFwVhz38JKHo0025ZEDxnL77cEGn0wLeuTrb4bGBH?=
 =?us-ascii?Q?tqIJdSe2/J2MbchRmst9cGGgIaaAIL3xyYu70OlEwcmBlHpkK6CC/wsJKcRK?=
 =?us-ascii?Q?e1FrQeCv5iDzF7fLFDUhAKw2afvfv7pJh7/fYisHpDN1PRe5raPokTyUQ/Xs?=
 =?us-ascii?Q?4aJlLpAT3hol2CduV0V3ZObFw1sUeNMgSuXGBVsWejYKLP7ic1IO3Gtldb29?=
 =?us-ascii?Q?LNkV7ZdmP/Lkla3Otf52iYnKKbv/If8JoRLtCuM6TakLpbYFMOIvmUKeBTfJ?=
 =?us-ascii?Q?fL9Gzp7KwV0t4BirH7NXmzhpDdFQnIH4B9fqixLDgM8Qc7OyQv1HaGtqx5hT?=
 =?us-ascii?Q?IPPTI2t0JPJxfMMjLqwpwXbHu2ZaEBqIXZA25+2pHWIILLcMYJwNt0fAMRs7?=
 =?us-ascii?Q?EQJVzt8Yf5IA0dYSgGWJ6yBX//JSPa4BZUwz3SCtqCbj6r/lrPNoA5pQXSBi?=
 =?us-ascii?Q?sFpX9cVriW6+eGdpz1FeitPsI7MoYfqWycPkxpTTyA/tK2hUf775c+7QxmB1?=
 =?us-ascii?Q?WuScfjkUO8AD6t1dYyMvBU7pwpRRVcGZsWz0f8A112YLNifc52ZMSQlfiNoq?=
 =?us-ascii?Q?t1KpGLoA3+UvcgzEe15qaXPd71u8X8NaMdkOeEKWAie19VmaQDjxfIKifizv?=
 =?us-ascii?Q?O1O5ZGQD7mqsGd5Y82PuYcggxcC8O5jHws8HAbDkll9SLfG7GNazNmc/WJyV?=
 =?us-ascii?Q?6FeMGzeG4sYeeIotPo79O11F5xgxdSL5GAjDFwPyzIZ2GNkOLff5C7BbpmJs?=
 =?us-ascii?Q?Re6mBcGNimWuWMb/o5i6RGGrExsGw6L6VDFIb+ERRSj/B7lRl24LJpZlBI+c?=
 =?us-ascii?Q?Sc1biRvLzCyJEaMxkMR1CDyMGRzfKSsPLP6byeBRfoQKcSar9qFayAdYKMjx?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6CB791CB775F834FA8522F2642008802@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c47kp9nQn9ypiMJ95J3eFZi9TfzeUiQwFp1+5tLHQGkglbuSZQjIZgYdVG0tMkfzW4mus4C2nbeSvXqoKxRUD7ldh9g/UGg4QwKlNMPXdADxNN6RAh67dK0IqwoiT6znUKWLTH1BfKjwnZLwI5Nq1d/n9k3OlFR8aNkV9fEDVrg7HYlAjOkSy6EnV+FAAWn/tWA3/CtNF6LsmQyDv6ryPvvE21thpp6QHsZpKm6orzB4Xgh5awQ32JveBzLyZNRj6EODNS686DmT2H0Jug0w6Bz4neygwzDY+dmoZiUqtaZX5Wqg3FfopAniMn6oC3E1nEhZYcL/M1Pm4wxeJSGGlpbcVyNSbp50Dw3BPyIhOvwZXzYgDBR1+YnKK78mnjN3pvTmGc5gb7wgtW+SYPsZG/7SqY+BTigjmTLlN0PAVWad01/V81Qsyfs0G2O9P/mKe1Hh7Fl1xz+nnMimffAWFlpIOBeSqvwYOVkW6AFexa7aT0GpeBiFhfU9iPu2J3Snbf3eJc8+hNRgc9tlVxFZNdyMfMGTE2RLYaUtQlEC5Lms9eMMwCv2MgG4iY5r+lNwOstZB2ViYT4mJH4NzcMcXRdmEqAgwAnrO2zqsHy4uVGA0keqratq8k74PHAYE+XLmAJxlFO4Rc+H4AltjgGM70IhTfKi0xwWLFHE+22SWRTt6OQ6f6uzJBJ4bvjZSOlwBCJlW98yEGcftisoqZuInGNtor2By9zfsS3lrwPHbXbSK/DGTDB06LHWNXcEAThsX0FFxhKivS7N8spswJC3pWbCrpDck1CNj5jpbgYWmFklv/ShnwkE7adM8U1ihnGhDmnfpT7KkZ14QXlDBj5IvDdK2NzVGHleofNOWVJoPTrKTUL1tzYe29mgEPt9zNe8S8uoEoIflUzkIQ7sH0Gs7Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f40629-17f1-4fff-ab61-08db5c8e697f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 19:38:12.7928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Er8KQ9riEYmdsBggC6F6C7aPzpbtfC9g2K29AVMoNglZvJri1CzOkLIQ26bIpiN83CJaLyefFW2OKcLEd7Fq/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_14,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240164
X-Proofpoint-ORIG-GUID: 5Fq56NnktjJeOjjRLAS5YSOOM9Ay875S
X-Proofpoint-GUID: 5Fq56NnktjJeOjjRLAS5YSOOM9Ay875S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 24, 2023, at 3:30 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2023-05-23 at 10:29 -0400, Chuck Lever wrote:
>> Let's have a look at what is needed to support NFS in-transit
>> confidentiality in the Linux NFS client. These apply to net-next
>> but previously they've been tested at multiple NFS bake-a-thon
>> events.
>=20
> Why net-next? Aren't the necessary non-NFS/RPC bits now in mainline at
> this point? What's missing?

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
net/handshake?id=3Deefca7ec514262aef08d0ef261552f2f604bd851

That fix has been in net-next for 12 days and is still not merged.

This series does not apply cleanly unless that fix has also been
applied. I did not expect it to take so long to get that fix into
upstream.


>> This series is also available in the topic-rpc-with-tls-upcall
>> branch at
>>=20
>>  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>=20
>> Changes since RFC:
>> - Add an rpc_authops method to send TLS probes
>>=20
>> ---
>>=20
>> Chuck Lever (11):
>>      NFS: Improvements for fs_context-related tracepoints
>>      SUNRPC: Plumb an API for setting transport layer security
>>      SUNRPC: Trace the rpc_create_args
>>      SUNRPC: Add RPC client support for the RPC_AUTH_TLS auth flavor
>>      SUNRPC: Ignore data_ready callbacks during TLS handshakes
>>      SUNRPC: Capture CMSG metadata on client-side receive
>>      SUNRPC: Add a connect worker function for TLS
>>      SUNRPC: Add RPC-with-TLS support to xprtsock.c
>>      SUNRPC: Add RPC-with-TLS tracepoints
>>      NFS: Have struct nfs_client carry a TLS policy field
>>      NFS: Add an "xprtsec=3D" NFS mount option
>>=20
>>=20
>> fs/nfs/client.c                 |   7 +
>> fs/nfs/fs_context.c             |  55 +++++
>> fs/nfs/internal.h               |   2 +
>> fs/nfs/nfs3client.c             |   1 +
>> fs/nfs/nfs4client.c             |  18 +-
>> fs/nfs/super.c                  |  12 ++
>> include/linux/nfs_fs_sb.h       |   3 +-
>> include/linux/sunrpc/auth.h     |   2 +
>> include/linux/sunrpc/clnt.h     |   2 +
>> include/linux/sunrpc/xprt.h     |  17 ++
>> include/linux/sunrpc/xprtsock.h |   3 +
>> include/trace/events/sunrpc.h   |  96 ++++++++-
>> net/sunrpc/Makefile             |   2 +-
>> net/sunrpc/auth.c               |   2 +-
>> net/sunrpc/auth_tls.c           | 175 ++++++++++++++++
>> net/sunrpc/clnt.c               |   9 +-
>> net/sunrpc/xprtsock.c           | 343 +++++++++++++++++++++++++++++++-
>> 17 files changed, 727 insertions(+), 22 deletions(-)
>> create mode 100644 net/sunrpc/auth_tls.c
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


