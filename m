Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201267EAA4
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 17:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjA0QSJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 11:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjA0QRq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 11:17:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFE27C70E
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 08:17:33 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RET7ZW000301;
        Fri, 27 Jan 2023 16:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CnriSshZ4rN7QIcd3njlpCvp89+i+7xGSCpTOqXZcKQ=;
 b=mb4qj7hOm16EO+kOU3JVy+DHk5AShFQZ4mNigmPLxfHCoga4T4BqyifzAF1z13j+hZra
 JYPrEF3/yJcAM3V+Cfrz26pdg28VqE3QB2ZJemXRrDB8reJ1wSY0l57AMg3O2G3r3pGN
 970ykfYVNu8aXr7Yv4ht4QIreBkt6tDRDGr3Ip0dw2xICiYJgrTidIDliqetyWZyfNPs
 52vMy5eElvUjhRFUivcqFZ3laTQ5f/Tyj/iNhf/uAV8b3zumZNMDsKTAsPj+T4ROyZm3
 wznruapYxnJl0BFCyvnidVCPmQkgT4shiUylIQRnnt8doJNtMPFcnz5baMSbPGvMxrF0 Vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n157u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 16:17:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30RFTYJR006179;
        Fri, 27 Jan 2023 16:17:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gg8nhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 16:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjjSYBlTh+JNIClEpQlQ2Hmku6aMcTI6Czwvmv/mEo+s0VJSwVUufketQefvQm5gxp7HPBTDmwIY/70GP5tknQxVd3yPDnrwdWrbJXE2SJn2UH7nKATIxSUElZZO3okQVJt4OLvKDbwJLm1VDcVOXfZiNrInmNnobksLAn/9NZO2FnGMgzkkReaXK8BSoNseTKLje1l0s/9ado2ZAalerWPHAHZm7yhVZo8UPrHx/i2sfilA/kmCx+HeFCMTcurI8YOUWvKVtZA9ymFkNp+7dG0jvGRqMH5w4u3zGVv8eA7bMxNCYlaoBVVeFs2NhznSoS9+dJNIS3rZGf9r5/H+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnriSshZ4rN7QIcd3njlpCvp89+i+7xGSCpTOqXZcKQ=;
 b=IGPZT0nXpCPcdTLls52/1YoZoA+T1Kn+ynz2uj1A1dP7XWdIIT2qk5GJuX30PZ8Efrt8qZLsWc2+uLX1+Ku0zRbBq3OCLF6eYIUGY2NkFdmOLr+kugNShK990Nt+Hz5AZnkYWshtev1OlDnwAGSvYTcqqlFO9/WYu8w8j412zYY6L8Dt+QGlV6KjAHI1NThLI/UHLXrbkjSA5FxNEqhJ55C83YuvyZf3DezEXDw683NrU+pKaTXNjershNRX25L1PDDHu9cUeX2zyzU/vG1bcb25ELHMP98RdQ0GLlQXeih9jL3bP5vNpx8x0V7cdsCCZY4sQBRXEykMXc3VBBckdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnriSshZ4rN7QIcd3njlpCvp89+i+7xGSCpTOqXZcKQ=;
 b=vo0nFhq57efSuAsIhfRQUKi+yIjCxb+sScV02952DYUhTdKFLOe7IlKdewMjDGTxWkakcrD5b1Kkplxq6nJDA3fTKM8GgZPUHyeLnu4D1MdtBwUBcvsCm5LVycx/JBBM9JBhvj63EQuko5utilMn1RlFITikVY2sPwi2vGCyGHg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4207.namprd10.prod.outlook.com (2603:10b6:208:198::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 16:17:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.013; Fri, 27 Jan 2023
 16:17:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Subject: Re: [PATCH] nfsd: don't hand out delegation on setuid files being
 opened for write
Thread-Topic: [PATCH] nfsd: don't hand out delegation on setuid files being
 opened for write
Thread-Index: AQHZMkg9QowbIAXTEkyy+4RjwAMvNa6yYYqAgAAChoCAAAE/gIAACpKAgAABPAA=
Date:   Fri, 27 Jan 2023 16:17:25 +0000
Message-ID: <63A8B84E-EEBC-4AC8-AADA-DD05B59D2C30@oracle.com>
References: <20230127120933.7056-1-jlayton@kernel.org>
 <D439961A-3E64-425F-8385-E5179325576C@oracle.com>
 <869327c01b6cc76d02b0dbc1c0e3a1170fd04dd4.camel@kernel.org>
 <78E46DCB-AAAD-4996-98B2-B85087226DFE@oracle.com>
 <7e932c18eb0c6a1e34382fa220a9ff95f3beec4f.camel@kernel.org>
In-Reply-To: <7e932c18eb0c6a1e34382fa220a9ff95f3beec4f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4207:EE_
x-ms-office365-filtering-correlation-id: dfce2cf0-206d-473c-d78b-08db0081fa41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOzrs0FkbYWkH5uCCsMxodhBNgWWcZvzKlEGgV/ebjOPeCh1voAbtyNFEwLqypST6QY8bVm5djSSPF6J/EolovwSdSW4p9KaGyySC63GOdLb4XPb2VI2nwEys0BGmbSmG+fPEZFAdvd1EjebHo+nfF7fyF7j1iDezmEhlZ/Q/iMyoJ5Dv7EWtUS8rqrvAJfFRMUlBPv6Z++4dibOCKOXlqVBCgCFMZI/Kxg9kcPiO7F+J+0EP9E1wyus8tezzBT27ykVoRUORRnL98nAPnkV3zfQR4jyEo974gpb/qbeZQPEPQaOQjvlZ41kfZwmOjo6GpJerk46b7dfubhw0JEZDasc/LUKkKgN8SHE8qaIRkZ7KiwMV8aHsfcgTcOQk7EQExInFmF8D/eEIfBM2vBphJQqR3BP8r4WFAqv75OFIywNPrh/DnPP0sYDSMdp4bX6MHuZYN9A/cjBn1KwWxMXG27PpIkYY90VBTACZd1+KcTGPhP9ysWGVdh41HAoMLf2RXPXJK08noXIlkXXN07S7OfCDSIgyG6AXGHjnRXg1D8syf37ZIdhzuygJ3XHsniLxm4THl7E5aiWCrxEg6wtmBYMapsTGepCLa324/rHYD3c1qR5WVvDz09nUbSv1AbKaSxO+Fn3JbSmvp8ZDEh8zV2Xhtp3QUNu6giX+1JnQM8yeH0VV+ukFwJogfYV1EgNCPzt9D4OLbguFrFrX3U6P2bKuDXI1oOEKH382peMpBw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199018)(26005)(186003)(8936002)(38070700005)(53546011)(6512007)(6506007)(54906003)(5660300002)(2906002)(36756003)(33656002)(86362001)(71200400001)(478600001)(6486002)(316002)(8676002)(6916009)(66556008)(66946007)(66476007)(4326008)(64756008)(66446008)(83380400001)(41300700001)(122000001)(76116006)(91956017)(2616005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9oSHbjBto849kSoOCCbIYdK7xw/7gsuUCQ3aYiXZI48aT4HsC6UkL//1+uuo?=
 =?us-ascii?Q?OHYh+z80Mo2Z+8uvbU43xWfNWfM8WCtsY6EVy1TTGh6g/TVbwkPTROptJF0L?=
 =?us-ascii?Q?np5GAaFdEe+lgIXBFs/6x6qsOGmoXq+X/A4Mr9yqt2o7lRLB1QP9/J3ARg/V?=
 =?us-ascii?Q?omE/+82941gbzGbwWK9nW7BTSKax0kMxITxQs7IV8TYjPJI1jFPngIB9XWpC?=
 =?us-ascii?Q?t1H0tv9pxnrsyiMy4B0Lu0i+Kb6MpQmQe699Nb7/e6IWEmt1f/WVpE8LHjrd?=
 =?us-ascii?Q?Oaz9MtBxStFzw724mITUiosqasuSEjAG9+9DDs7hZJP+plIHMhtbfmgROALD?=
 =?us-ascii?Q?VXs8aiAJe+PjmknXgbJHNbhznm5boH1EFoFepA7E5VTURRyYkl8vs7gAyHnt?=
 =?us-ascii?Q?ExIZ77In3DA30QWxR/cNayf7NAaGiwqbHjFx57i+oPqIKOjokoc9jLtAvijd?=
 =?us-ascii?Q?Pe8f1geVFVoQ1r63hPB4YXzLpKTO/AK4qVpCOd186RnkCmoKVdaSnxqS1gjt?=
 =?us-ascii?Q?ydEUTx61yf9QZ4GuyUzScKAhYuRUlTMUjBrRuv02tKDfZCFQgHrwv/qAvGHy?=
 =?us-ascii?Q?7Lp4iT/W7MKq+mBLj/yZ24RGEamEELwGk9+fMHSYqC9ZUGMcryxTvd9u2mHr?=
 =?us-ascii?Q?SdMhx+jpKJYSWg3kX7Ll9mMhwTKKcdhQ/UFQnwDYPWcvNbli+9BQCpgodnoR?=
 =?us-ascii?Q?s8r6bEAPewWQOduDcSZeiOBtCTVB1H5ZgzDyPKf7Vfnm/pHsgPf2YmUKEefu?=
 =?us-ascii?Q?WbjslgnUYXdre98M6vpg7ZSSra7kGs9poCyFiuvGr3oImCTLlSPdagYaEW3B?=
 =?us-ascii?Q?g67dAy+RJyZVbKv0mCgjDF1YeSEqZYBvt5vqb6MN/Ax9l+tZDlAqd2p+9oZb?=
 =?us-ascii?Q?YGMwYWWdqD2lksjw3sZQ+UDP/xSu6lYcLLCLHWBN2AB4M/AmA7klAtvIXm4p?=
 =?us-ascii?Q?Id7xX0/BSAlA2fTEvFbd7S5RXH4Tu3m7+iPzyD7GA6Ag4s8Ph+dc/a2rb+r5?=
 =?us-ascii?Q?7hiOHyP46FdsdHJe3yP8DnAv5MH60zwrC0/PqGTaxJFVQydc7LJ6NU2xEjmS?=
 =?us-ascii?Q?sj7gJHvTdGVwgaLsAhsHCALRNd06kyVI40cRupnB3+CuykALSjKPvAYZcWBt?=
 =?us-ascii?Q?kWLNVbVV9BcoKke5yF5grCn9zZFCKct+Vjq4AccgBv37W13JD9KQQSwfQt2O?=
 =?us-ascii?Q?CvR9CZM0thWQr1tBWqxwIYH+CeRqrpzivjNXtNJv06tDnweBP4ZL/nATTQcJ?=
 =?us-ascii?Q?un0nMf8fu3Bgh9RTaf96PMqhHKC2iM24PcCuXKCJtSYa0n587VAajTP6s0d+?=
 =?us-ascii?Q?Qki5Ql3CEnDFRd5GJAGTC6IIB1NjD2p+sXdqcrzJohBtN3jAQZcY1fTP1it0?=
 =?us-ascii?Q?XwbJMQR0iILWEjbcn+srTY5T7wyzdkeIG2SCJokZRkRAh39MXjgaPRcaBBgF?=
 =?us-ascii?Q?KzoYLcJgchJdP8S7uHoXjbgXJmJjxLAXywUboBxEaIjnTwQHa3VI4LZbsreS?=
 =?us-ascii?Q?F4i5Pios1Hw5sD0OX/Y8k7LanvB7QL4vCtypgaMuraMSkZDskryamzA9aMII?=
 =?us-ascii?Q?J++PL236qpFlVCxh7eefvUyytj0rW9JcFIlPwt56aAL6cC0oBdoULTioE3tn?=
 =?us-ascii?Q?Ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4CEB32BC7303F46B8C02BF4ECBE5087@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8CwyG8phTj942KeUP8/HTAZ+K9BRRGNPYg+0NALV3CxKMd82PCp9OfWZWUEg0ZJzNo6Af86yWMgVoqImE46k+Z+SF8vZvzzcDpT6PhzJk1AhJ+Pqxcb1sYiZME4xwgnGmVKCxH5qS9Gk31H7AyTxihhOYpC8k0pv7tsl3n7Wxa0GzCfl7hugJU0IouBZDcKYEtA5YdNXbJkLdcmpVl37bcWLvi/VEKKaBTN1i39zfOnudwbhbQ6lU7CeLMpGb1wce+0obVkGmrQZ3qI0uMFADYT88rU+l9+gieEvjfuZjy2QNkVmM2Upbii04/TIpScliBdpz/NhIzWhrr7DVH6K6UNEwxMlNaotfWt8zvs0RcTHaC0ERadm2zpTcS0Z1BCv2tK91qQjipaLIxKhJu/xBvgxZS4pGekAez8nRFCoVXPxsX7jQEV6iNMInz6akFvzA8BKVlkzr/L9fdofdOyyqkEHzHuAvaFEhk5MIDutc18Pn/dMBcvFS7ALD65xQCraEZAhGaDX/LUaMFMEsnTXEd8cXoxdGK+3VyOxY0SI7PkiasHq4pa6gS/KyaoCZNqbI4CSraWm4bODv8bteS/LiuTHJ55uM3b9Cp6mw85rT4Z0pgJeJTWnw10J6K4lQQ0twMbpzvltXiiN9x3RAnTdah/ur8QtwVdDz4CW+67DItOQS7+utIP9+2KgDjl6VXSa3RiXr5l1U/fjUugLLdNr50BHQX58vtcDy73o6NyQCi81TFtqPDxiqMlFbfgC/a56Os7Ann/QbXLJ4WUCp0B8pltfjSMUYp58bKYwLklSLTxoH2VoBy3swQEtnS7/vkft
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfce2cf0-206d-473c-d78b-08db0081fa41
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 16:17:25.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWRzqngqNzZMj60QRk9KFCkKcA+GEZZq2G18xXZ11xv7eSPgvDpJJFiPhWcu7Vcp7H7XB+TWpeCm8CO2f8g7Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270151
X-Proofpoint-GUID: hQEm8VJ6rkFtfL3Aws2a-TWmmfv3D9iX
X-Proofpoint-ORIG-GUID: hQEm8VJ6rkFtfL3Aws2a-TWmmfv3D9iX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2023, at 11:12 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-01-27 at 15:35 +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 27, 2023, at 10:30 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Fri, 2023-01-27 at 15:21 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Jan 27, 2023, at 7:09 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>=20
>>>>> We had a bug report that xfstest generic/355 was failing on NFSv4.0.
>>>>> This test sets various combinations of setuid/setgid modes and tests
>>>>> whether DIO writes will cause them to be stripped.
>>>>>=20
>>>>> What I found was that the server did properly strip those bits, but
>>>>> the client didn't notice because it held a delegation that was not
>>>>> recalled. The recall didn't occur because the client itself was the
>>>>> one generating the activity and we avoid recalls in that case.
>>>>>=20
>>>>> Clearing setuid bits is an "implicit" activity. The client didn't
>>>>> specifically request that we do that, so we need the server to issue =
a
>>>>> CB_RECALL, or avoid the situation entirely by not issuing a delegatio=
n.
>>>>>=20
>>>>> The easiest fix here is to simply not give out a delegation if the fi=
le
>>>>> is being opened for write, and the mode has the setuid and/or setgid =
bit
>>>>> set. Note that there is a potential race between the mode and lease
>>>>> being set, so we test for this condition both before and after settin=
g
>>>>> the lease.
>>>>>=20
>>>>> This patch fixes generic/355, generic/683 and generic/684 for me.
>>>>=20
>>>> generic/355 2s ...  1s
>>>>=20
>>>=20
>>> I should note that 355 only fails with vers=3D4.0. On 4.1+ the client
>>> specifies that it doesn't want a delegation (as this test is doing DIO)=
.
>>=20
>> I used a NFSv4.0 mount for the test.
>>=20
>>=20
>>>> That's good.
>>>>=20
>>>> generic/683 2s ... [not run] xfs_io falloc  failed (old kernel/wrong f=
s?)
>>>> generic/684 2s ... [not run] xfs_io fpunch  failed (old kernel/wrong f=
s?)
>>>>=20
>>>> What am I doing wrong?
>>>>=20
>>>>=20
>>>=20
>>> Not sure here. This test requires v4.2, but the client and server shoul=
d
>>> negotiate that. You might need to run the test by hand and see what it
>>> outputs. i.e.:
>>>=20
>>>   $ sudo ./tests/generic/683
>>=20
>> Then, these two failed only for NFSv4.2 and are not run for other
>> minor versions. For some reason I thought this was an NFSv4.0-only
>> bug.
>>=20
>=20
> Ok, that's expected. I should have been more clear. 355 only fails on
> v4.0 only, but 683 and 684 require v4.2 to run and fail.

I'll add that clarification to the patch description.


> The cause of all 3 failures are the same though, and this patch should
> fix it.

Since this regression has been around for a bit, I plan to apply
the fix to nfsd-next. Anyone who wants it backported to stable can
apply it and test it -- I'm going to leave off a Cc: stable or Fixes:.


>>>>> Reported-by: Boyang Xue <bxue@redhat.com>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>> fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++++++++
>>>>> 1 file changed, 27 insertions(+)
>>>>>=20
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index e61b878a4b45..ace02fd0d590 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -5421,6 +5421,23 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *o=
pen, struct nfs4_file *fp,
>>>>> 	return 0;
>>>>> }
>>>>>=20
>>>>> +/*
>>>>> + * We avoid breaking delegations held by a client due to its own act=
ivity, but
>>>>> + * clearing setuid/setgid bits on a write is an implicit activity an=
d the client
>>>>> + * may not notice and continue using the old mode. Avoid giving out =
a delegation
>>>>> + * on setuid/setgid files when the client is requesting an open for =
write.
>>>>> + */
>>>>> +static int
>>>>> +nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file =
*nf)
>>>>> +{
>>>>> +	struct inode *inode =3D file_inode(nf->nf_file);
>>>>> +
>>>>> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_WRITE) &&
>>>>> +	    (inode->i_mode & (S_ISUID|S_ISGID)))
>>>>> +		return -EAGAIN;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> static struct nfs4_delegation *
>>>>> nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *=
stp,
>>>>> 		    struct svc_fh *parent)
>>>>> @@ -5454,6 +5471,8 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp,
>>>>> 	spin_lock(&fp->fi_lock);
>>>>> 	if (nfs4_delegation_exists(clp, fp))
>>>>> 		status =3D -EAGAIN;
>>>>> +	else if (nfsd4_verify_setuid_write(open, nf))
>>>>> +		status =3D -EAGAIN;
>>>>> 	else if (!fp->fi_deleg_file) {
>>>>> 		fp->fi_deleg_file =3D nf;
>>>>> 		/* increment early to prevent fi_deleg_file from being
>>>>> @@ -5494,6 +5513,14 @@ nfs4_set_delegation(struct nfsd4_open *open, s=
truct nfs4_ol_stateid *stp,
>>>>> 	if (status)
>>>>> 		goto out_unlock;
>>>>>=20
>>>>> +	/*
>>>>> +	 * Now that the deleg is set, check again to ensure that nothing
>>>>> +	 * raced in and changed the mode while we weren't lookng.
>>>>> +	 */
>>>>> +	status =3D nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
>>>>> +	if (status)
>>>>> +		goto out_unlock;
>>>>> +
>>>>> 	spin_lock(&state_lock);
>>>>> 	spin_lock(&fp->fi_lock);
>>>>> 	if (fp->fi_had_conflict)
>>>>> --=20
>>>>> 2.39.1
>>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



