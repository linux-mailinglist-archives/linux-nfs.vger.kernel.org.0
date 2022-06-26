Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC85D55B41B
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jun 2022 23:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiFZU7i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jun 2022 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiFZU7h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jun 2022 16:59:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E03892;
        Sun, 26 Jun 2022 13:59:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25QBToMC025693;
        Sun, 26 Jun 2022 20:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rTyjim1iWktJHO+cpsgIjftRVRu8laWCGSAwnpHBIZ4=;
 b=WPiFTZZmOmitGQL+JfbwMI9pQYfGUYuXt1x8UmkYLm7X2IHqGclmbf++JwszfeuExtey
 cJwkd/EWRC7nNHwDBRotswkdDDQEb3+ulXIRFkv2hpvY2uR4NJLGmW6IOJUx3iMhn4X+
 y0aOEw9TSDE5m5V0v0ELdmxrgcp6Js3UK+z2idP8Wy4NpSZTEtoQbiolKBKG3FDMbh2E
 KEKNWdVz8icBWRMOkOYdRPK/ZioVH3WNx01qgKnZCCW0CP6nHkMlhlDvHoUlnEjmGNDX
 /vzoZ9U42Ck/aDrWItPeXPqtMxpZfJjbqX/vzjwkpnxveHRGvtdl3zCIDXtqTVPpBfjX ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwu1r2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 20:59:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25QKonQD001434;
        Sun, 26 Jun 2022 20:59:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt6t1jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 20:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGRh1U6hwfhSSHNlces+QAhqMnijMsDoECaARZ0LgoSZsujW0HMlfY3pFI1mmnm9tZlbi5VsgEwfHajKV4eyLjUI30KY1qW9uF9IbHAFQ5xU6IDbIdyELGVq+k01uZkQr3OKhSFBA8zHeyR6ETtYFmuIp0+K/BvlndqybTAZzhAdY5sDJ0hQ9kvFfKvFdtNquPFzBMaSDEeTykh0CnGCOPhhyLaCIEc4R1Fw/P3XPKGCkbRc5Mbs/lWGsHxnmviAEjsq9D/p+ysv5NLlb8id9x3loPnmlq5lAOsQroCasHOimxeSTxXZoF/+W8dSgOR9V38uW9ZnRwqq9P3rzFSNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTyjim1iWktJHO+cpsgIjftRVRu8laWCGSAwnpHBIZ4=;
 b=E6VELmc+W4eltcXzz3wCi5kT1D9357yrQlSjPERjLAYw0beb0ZxHh4pS5sTwXUOdnS0tQ3ItVbavdQmlXB1+xx1zoc8p2bhMh74ZUnv6nnSKnQ/qWDnYX8AfFwDKLiFCSaV9u7W+T5fIeEveql2y0irUQgk9rwPcnBDrmEjN4nUQP+c/FmNW+T2qaA7jm9qii1rq9V5IH+BAV6IstzHPsYvkICST6In05dj0z5uXIPZ6tWaHGV3Wu/Be1VelPxyMjZpqCDMFPZGJ95mrppWowY6Ob6YVJEUStIT6q23FLTlcmJuCMeuT83VEQIZzp42abo6TQraUr+MY8QDFWqLQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTyjim1iWktJHO+cpsgIjftRVRu8laWCGSAwnpHBIZ4=;
 b=dhUti7jLLN2WrLvriDZ/sChMIqwWvLZwUnIpsKBl6OI0+t6JF/6wJrdngCkn6VQqyAuV29EXRXWB3c2rbuESWqL+tWUkF5yfyRi26cLhcVcAm5Ii73qcy3arEOeHcq8Xahfg+qEqgHlV1ZwRuYaRcA+tnJuPVb4FMIidBTlSw2A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5643.namprd10.prod.outlook.com (2603:10b6:510:fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Sun, 26 Jun
 2022 20:59:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 20:59:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anthony Joseph Messina <amessina@messinet.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Zorro Lang <zlang@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [Bug report] fstests g/465 panic on NFS over XFS (linux
 v5.19-rc2+)
Thread-Topic: [Bug report] fstests g/465 panic on NFS over XFS (linux
 v5.19-rc2+)
Thread-Index: AQHYhG4JYbZcrG+l4kS/ExuikN1XJ61hk0WAgABykQCAADCHgA==
Date:   Sun, 26 Jun 2022 20:59:24 +0000
Message-ID: <5CFCCD64-FACC-4256-A0CB-0A69ECF868D3@oracle.com>
References: <20220620062114.ixfkp7sr6rjd4ush@zlang-mailbox>
 <20220626111539.svanuahguaeqsvve@zlang-mailbox>
 <12005337.O9o76ZdvQC@linux-ws1.messinet.com>
In-Reply-To: <12005337.O9o76ZdvQC@linux-ws1.messinet.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 790f4b84-1e1f-4698-1dff-08da57b6c00a
x-ms-traffictypediagnostic: PH0PR10MB5643:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfXe6wEaDFllO3w7l7BRzUam0g8zIEBbdPzJRCERslPWKrKJujT61WCr0s+l5Xs7meSBbg73kh5uRharAWNbuT47WUHNrCPOgt1xn/A+qg0Nj8r7ZXMx3HiL+VbRmFJEaqTDXh9+XWDwH6qQdc7YQz1iNK0QDPIDPNjUh0uQOhKS+wsfhlPBIIiSBUdRvzRCaj7ooAeDfpHGHdUsKoF/2JR7FMIAuiAFJyeUZlPi4h6jQtsstGjhh+gSl/TYETn+cREGy9KGrWq/mWwuepTPTKiaeEOWUCVKQ1rqzBPBB1ZkyeyjK1T9fZolAQqTBxYcKKx4vquiBRzI0RnJvC8PQs1v2pMSWdxFCrA57lEWjWvHzsJr7kgMkbzKm6ApjsVbwo6j+yZHrax0dhBYWrZ6R8zD8cYIn36DHnt23t98E1fNSgFozD+V5lF1Zaloce+YTbYX84dFqwZ3sbG+p3RahR2Pp/GY6SNz8VY1WjQthC7e1+wtvjuBIVGxLQoIV84z8OSVhoWeDOuW6l82M1Z8lG7gm8iPB0Ytubom3ZkgMm+u8EJSGDUF/GhfurqEj7WE3yxcs8HVuSA6DRszxWiGa/QSviKu6Odg6l1GI3xCjFrqEcXC2E1pkPCSfvnnwUXmoQ6lXW+GBn62fH7ShV6SYq+ayOHr8SGFOtxC8wwYJgZcJoJf4/I1ZSvL6kH+o0jE0Q7tp+RhfsTyRRzogyFvL0i/cobdLHoxdbL8S0aKRSM+AEbhH/PcyW4NrdqJdLtPULgFqkk2cuLb6K10LwRx2E8Bnuug0SqxO5saejQl+19Ep7AqxR3ryQ/6mDFP0z6ldxMhNt+QYRUALsqCVKobyHgV1fGpj+KqQBdvZRDLvmrBzMTX0lhsh87EolylpCv8/yPHqtl1hHVosTwaQQETjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(376002)(136003)(346002)(53546011)(26005)(41300700001)(38070700005)(36756003)(6506007)(966005)(6512007)(122000001)(2616005)(33656002)(478600001)(186003)(71200400001)(86362001)(66476007)(8676002)(66946007)(6916009)(6486002)(2906002)(54906003)(66446008)(91956017)(64756008)(4326008)(5660300002)(83380400001)(8936002)(66556008)(76116006)(316002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JwfHKT/TcNOSxj+AFWbA0dvTXdf6rAh0LwXlLTINcQplZPckuWTIGddeK8fl?=
 =?us-ascii?Q?n08ipaV0hkv5fk4OSteYSRIBplY8LUyRIdkHLHz0XAbvwZS8dYY6kd3mKKxB?=
 =?us-ascii?Q?LuCy2Ja5mU+ROB+dzf/D/O98v6Ddg+a28nty8pIyxqMDo1S80VVWx18hUMJI?=
 =?us-ascii?Q?keSbmpep6sBOqG/Q+pN6kOAMO8qMcny+IwNn8gr389Lg9GguU7BOhsJRfH6B?=
 =?us-ascii?Q?103ZHWnffcMwtufozsMg9HTaClKei9bQiSZw4d/7lyH3KHG6MtMVEzRW6xGq?=
 =?us-ascii?Q?SwoRmXZ3L1Nv4H2UbQQWL5zY7cVSZuLoRuc7j7UUiiy2zdyaMqAoGSQ1bpLN?=
 =?us-ascii?Q?ZDqyYVnfd4i5FlNSrFQTKqvDxf4pvqajeydc2AWNxWiCy0WsZu13Av5HW/dg?=
 =?us-ascii?Q?RBga1EEfIPNEhAkY+eGZF9pyX26pZPI2PfT4fIQCJg/Uq86KvdgnAhKdVjM+?=
 =?us-ascii?Q?6sNeoYBXz+wGO8w3Zmf3OuWtr8O4d4uJLTSUDk3ggP0BZ1Dn1LbI/Bazs1vP?=
 =?us-ascii?Q?fM4Wb+dpXorh6a6O5wwJ1cSnF6WE0QXDeZEcZm4bEhWfG886LTyrRSCWGOIt?=
 =?us-ascii?Q?t440kWVqKfQa/lgwFIgsEjrXJDWscJ34r8RsbtMvEar514Y251mCMP+BQOE/?=
 =?us-ascii?Q?hX30pZx/NONLW9NQXnX5Redu15gAixaCG5qJaRAMvjrX7ce2cjBUHjl6k1og?=
 =?us-ascii?Q?gVUreytOONA7xJndtc9L8smpXH0aB9e9bXAKePqxRJSolRmLZUtU3GFoampD?=
 =?us-ascii?Q?3z9ZXZpje0K7+KX8Em5Ry3aimZunz9zBnW+RN2IpGLpBUOP/ZazMorBinxa7?=
 =?us-ascii?Q?8Qnprdz+y7z2h8FOsNS8MEF3tg/ATrOSOdPE248qw3XpZDDZCnG3GhDXzYXf?=
 =?us-ascii?Q?26yuYD3yZ/BpQlMoX6qkAWNC6WNRZI7WAuQ1iui/PtpioTQQoAighRtGSYBd?=
 =?us-ascii?Q?v/9LEEt+4a0ARrMRh7cj+X8cI9oliC5mgJUm+L3uO9dfHVOiOxxwKf167Xi5?=
 =?us-ascii?Q?liKUc9u9XdrHAyl4G2sU28q7/lUeAl22ylDW8a0dazShXUcsd7yWz6h7Zp8L?=
 =?us-ascii?Q?WcfRzrAc3wCqhom4M9S2x03R/3WdWtf6wDnMntmEVoeaJrTTZLo6GxKwMMwx?=
 =?us-ascii?Q?rHaTgO17LOF3ZmUOxndqPw459bpTLL4cXmYATzcB6oBdWDWSgiE/TRy8KmZR?=
 =?us-ascii?Q?Am3AtK8TAA0RADzFh+nEGqjJiLa2FZOg4FDeTgb94Z9UNQVEjqs3mtP4kbw3?=
 =?us-ascii?Q?LOeJWWdD+FjgPGa8b2WQE6BlFce+gr2EpU0DYvv+uYCmR27UXDzIz2lSQJKx?=
 =?us-ascii?Q?BH5/rPvDoBjjKst3/xYtSIcNqPz0kHdWrxWC5VJ5wsgB/8nP79cKoN2RIawc?=
 =?us-ascii?Q?OBdWGih2IQRQexB9BBzKCKOJ9GCXljRT26GgmLzFmnD1VW5d9fAWHjtcC833?=
 =?us-ascii?Q?dJh3uG2a/M3V8F+1JLzJEUVgz461cRx/0nL4GxGNglLDQjAQQFlTmkyamxCR?=
 =?us-ascii?Q?ZMhyQiI6OfCwEI4IBZjYewkaAH6mNASfoNvtsvuSZb8PJbnIV9VpxHSbzAHQ?=
 =?us-ascii?Q?lNWHyTetwH825FtCESZBNmExqhRFCG8iGtQCCCqJJ0zww3gwuJV4Rcm53O/W?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A2366D0C4FC3246A8449FD2155494DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790f4b84-1e1f-4698-1dff-08da57b6c00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2022 20:59:24.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFIE4iIAqdU2vQ6FSPfrPMXndqTW7QjCo8yZzYHP67Wf62OKY0tCMAhph0S6So7PLLPzx6/4ASZ02vMwyT51XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5643
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-26_09:2022-06-24,2022-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206260082
X-Proofpoint-ORIG-GUID: C5LtnP5z59TwcjRSlGWxGPazby-ufGCG
X-Proofpoint-GUID: C5LtnP5z59TwcjRSlGWxGPazby-ufGCG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 26, 2022, at 2:05 PM, Anthony Joseph Messina <amessina@messinet.co=
m> wrote:
>=20
> On Sunday, June 26, 2022 6:15:39 AM CDT Zorro Lang wrote:
>> On Mon, Jun 20, 2022 at 02:21:14PM +0800, Zorro Lang wrote:
>>> Hi,
>>>=20
>>> I hit kernel panic and KASAN BUG [1] on NFS over XFS, I've left more
>>> details in bugzilla, refer to:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D216151
>>>=20
>>> The kernel commit HEAD is 05c6ca8512f2722f57743d653bb68cf2a273a55a, whi=
ch
>>> contains xfs-5.19-fixes-1.
>>>=20
>>> Not sure if it's NFS or XFS issue, so cc both mail list.
>>=20
>> It's still reproducible on my regression test of this week, on linux
>> 5.19.0-rc3+ (HEAD=3D92f20ff72066d8d7e2ffb655c2236259ac9d1c5d).
>>=20
>> And the feedback from Dave (XFS side) said it doesn't like a XFS issue:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D216151#c3
>>=20
>> Can NFS devel help to take a look?
>>=20
>> Thanks,
>> Zorro
>=20
> Not being a developer, I can't be sure it's directly related, but in the=
=20
> 5.18.x series (Fedora 36) kernels, I experience NFSD/XFS failures (with=20
> associated data loss) reported here:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2100859

I don't see READ_PLUS-related functions in any of those call traces,
and the OP in this email thread does not report filesystem corruption.

So IMHO RH 2100859 does not appear to be directly related to 216151.


--
Chuck Lever



