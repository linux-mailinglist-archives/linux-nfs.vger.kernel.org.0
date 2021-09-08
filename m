Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52A9403E93
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Sep 2021 19:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352472AbhIHRsi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Sep 2021 13:48:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5546 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352081AbhIHRs3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Sep 2021 13:48:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188GxjYi028767;
        Wed, 8 Sep 2021 17:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RNTLYzd1Z9VErt+j+w0m17IB4M7zPF4GD9Z3y9gnnIQ=;
 b=XX8lN7oH9q9fimFRAQOokkYJHWtYsOsnrbXz6mdz1bpkuT9s5xELDbQikx0b1tpioWoX
 PPTH1yqQ69tGNV+InVPEnTXH9qbLae+2wo6veA/wcXty67Z44S9inYTaZD6ccaUe6nhh
 1AGdUIlPA0KWrbzKCotM0tUhfUEe5NJPL0ckrsDg3Py5kJ4agzlA9Zo+gIGfCh0YLf6W
 jJcAiFbzwbNyoEhUrXV0TBqNc/uLV289jM2nWSERtZRJ9Mz/AdbdC46/bMq6CneLq8nz
 zIacKAf57fXAtHCOFAbin/y+UvFiknkOqR2vZIk7MjWxgI/3EcN09Y5GvszmU3tkqY5j 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RNTLYzd1Z9VErt+j+w0m17IB4M7zPF4GD9Z3y9gnnIQ=;
 b=BWFkV4/Wsbfr/qYKIxIozlEdcP/L4JS+F520bKHH72bP5DtgY9tXiMqHzbjSdcL1AZHL
 fTFXBhu8mjyIOzjMtDFfKBuB3jeMgDbikdUh71mUuki9F7natOAF3ZAPducZinqyNmRw
 7baCR3NQQV12wgPfWev5CN3cYW/FWrMFaWcEq+uPgdpuYwEDzZfBtGgGgPc+lX2s8R0Q
 Wc8iYO4f7RYzMOub91yslZ9eUQThK3KMMalLE6r76yYM89DEJ2zqUSX2sQgYL4U3yCC5
 dbBGBK8O8IY9ZF93jrXyid+BzgnOp6D7aDgNdXk8CRoU0kQgobU1/ZuKz1AWVuTIx3r1 zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcs1bh2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 17:47:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188Hk6Sr147580;
        Wed, 8 Sep 2021 17:47:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3axcpmjxnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 17:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gugPTZ2eSC6+AqDKSLCbGR1cZ/0kwzfOmmikt4fCC0Ha/YGv/lvstRRwz2Boiu2gLrNjTKeX3R8SI9DCNLlIf75Y9sxgNEUf72wWUxhicdNkHwNJPQOdP/EjCO+8wXW00PKWsdm2BNP6wO1qoQFC7O6I9FE5aawToKg1Gr9PH12TQzVRx9oIfAza/9RxAu2P0Z2av4F70dsw9BXfBvQmW/sDac/D40xg4gS45CoA0hh5cvSp0u4u6FAqmRUEzX9LZcGmsCZ38WZ+hYcaZKwdRXhBruLCjVy1p0NLFpC80HaffJ0FNPM+Z3py4K6vh7aaUOfCM6qY0/wOwtBPonoLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RNTLYzd1Z9VErt+j+w0m17IB4M7zPF4GD9Z3y9gnnIQ=;
 b=YnBoWEorfkIyOUsWAd3cAX0bQBfe7GXLi1r3OW8ZKlpwFOOSLZmVJhZjElmrI6tOebCudGMkxJKpwaloz8tv8Crs3gbVZuCo3vpDT/Jfw22FwZeyDtbDJIHV/X0rOj6plv0AHDY6mEoE/J80WfcAX3fjpC+DlgL17u+GsUU+9fZJ/oeY3ZmXK1pz/4rNZGVS1CBzOxokcOSOyGQMjL64qz/EiAVeA9ui+1c8HY0eNbuj0XN9nMCsw27Q7a1BtJp59hkfJKrE3TqhW58tuT13g8KGLgx6LsUaIMmw3IBwj4Lr7tYpEHd1gCGot6cfA/lQN++V0F7g7kv/ge9nDAVwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNTLYzd1Z9VErt+j+w0m17IB4M7zPF4GD9Z3y9gnnIQ=;
 b=FRRyEsALid1l58ApiqJt0QIwqfz7umw2EBj8+CcXuR0VX+kUFTLSxJtAzHqkRtTbrkNpHXeLJTwO5c4HMl7XlRdWVflIuCiUATiaOFdhoE7gQw2e8MwUmf4/gl551w3G1kjCMAQkjiuL4YqyqxzdP2ovKNJsjojubz2cJ4I9E94=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3413.namprd10.prod.outlook.com (2603:10b6:a03:150::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 17:47:14 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 17:47:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] more nfsd changes for 5.15
Thread-Topic: [GIT PULL] more nfsd changes for 5.15
Thread-Index: AQHXpNmPSNp1dsPnyUOuZcevOQ2OXw==
Date:   Wed, 8 Sep 2021 17:47:14 +0000
Message-ID: <01D391FF-7022-487D-9659-D36AA4947CC0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1271034f-03db-4ff5-1567-08d972f0b1a3
x-ms-traffictypediagnostic: BYAPR10MB3413:
x-microsoft-antispam-prvs: <BYAPR10MB3413426DC56B9CC5077BA50C93D49@BYAPR10MB3413.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: byOT/081NaXcpnPa8OAGBn5ik71cQSc8GxmXYl8OXAFFXbLCt/Xze41qoMHHafc4H1mpKD6cUe6kgJtnqRx6g7tUouGhQaqN0bE6PKDNUdWdRrOwlZy+P/j2ConWJVJDuSJSRXcUJ4GpJXSePx9GpLOFDat3eziKV/RJ8ioUwjxjgjPKChLKf2KWeNQPkRwnNC0ZWxX+4JoUmZep2SQsDH8jTKbGF8tVROJPyvjBPb4/zFYR4WreIfnVldaAJ4hC0Hvm3IY3RfSGdjZbeljqBxQQIvR3CZWvGHkc0vQUEdty+Rt3P8aISARuxwwBVRwsoq/e+b+wEfoHdIJe/itewN1hPFQ1Vvy8V4TkrChtM5fLhk/qidU4g8xwh4los7uy/cYxzBMhtLeCdrUEfNoD3l1tjIg3Fm2dDZ3rSMHUGBJRpsgNIU6zI1/DiwcZFQ20w9dJbgRRA4ixYrPj4xKnXgF92FHt4XBRPrd4JM+OVS0qWcpVo3M2ALFZESeSKstyyCd5HVBScZrpIFT1yk8PPPnFb/gaDxJw0fvOEG1/DhkLmOxDy3SvwvWzV/ZzlbzcXw8aPlE6AnltBsDvyoGo7HHVO4KDaQJSjQI3PjwfgFtXB5WAqKERb9XV7fnEl2/R6+3tuCQaWHia30lBA7yrq+ZZKMhvnhCe8a2c/Eb8sVsfaWaQ1DKvhD9nPJ5Qsl5c7HoxVl81VCf/77ostRDj6H4FRnriu4JT6rQwOQjBBELtNzR2Qb2UjmRAEOxWHZ/u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(6512007)(6486002)(33656002)(8936002)(6506007)(2906002)(8676002)(186003)(66476007)(2616005)(478600001)(36756003)(54906003)(316002)(4326008)(122000001)(38100700002)(91956017)(83380400001)(38070700005)(76116006)(66556008)(66946007)(26005)(64756008)(86362001)(71200400001)(66446008)(6916009)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3f8pcDcY9JY+4gC2mKDCvP5uy+LzZub9NSmNqPCXS81rnaf/BsrkkT32kArK?=
 =?us-ascii?Q?Ixq3u4fN2k4vIPqH3XmuN71pHWB+8l0+iq4sW/y8IwnLF3E9hnSsCofA3bCE?=
 =?us-ascii?Q?zVUY2E3Lr0ZcmD6wOuO8YYiRqz2OJF2Yg7P3p4JEMT37BxL/Eg0LMswjEE0e?=
 =?us-ascii?Q?GFo2uAbESvqX9D4kG0fBya+xfIJGfpi4husTYXzHnHCFukGOgVs9QwDwEx/T?=
 =?us-ascii?Q?YXY5FpgsDgw5NzxwizHKgVCa+7CI+r8kZDb10wRh+ZXEcwA6l6/jiFGyqlXW?=
 =?us-ascii?Q?qJabTJPG5vcKEmHrqp+Dvh6USQzjMdQPuyOtC5g2qPXoByJ/h7ehPjBLJ+gf?=
 =?us-ascii?Q?wfo1mAkPbwSynovq2U7g96KMOc9V6dXHNVShFqV8VoWb9k8t56xr3imxd1XC?=
 =?us-ascii?Q?RxdWPzH6GQ9KLpn+0S6mqX8TBXGzxb9ap2Ai5PE06zZBBGdm3cf4MXN/azFD?=
 =?us-ascii?Q?nd5guYjoWpUdsOBQ5FJCJQKPWm7NfyV0DV4RLmdnhXFOVykCsfiyOQ/gAEQV?=
 =?us-ascii?Q?h/GcTj2tykc+NZRBu67TIdsBzklkWk4oLwjAQml64RwsIki0CtGSCBpQf0kp?=
 =?us-ascii?Q?ZDD+KXD1pyvPFen3I2LFnxlmbvu1g91SRvJsWY4WzClf4j9WAhH9JRP2O8iP?=
 =?us-ascii?Q?26ykRdjw/v69zLgz+MqJsj4nRVXTl3XVYpartPeSxIdi7i3/6bEbAhfIqU+f?=
 =?us-ascii?Q?4AEDAQR/D/xC54WQMc+V5ms2+lR9SvIAPqTWgrW0O1J2+CxZJxNfIAjtgeaE?=
 =?us-ascii?Q?GDvtrRPnpfkGcEO2m/bX4lLFv36LVJrvdadnEjSRW86s133HbpVQXXvfqzN0?=
 =?us-ascii?Q?tn5Gw36A8MWoGKE22mx+xDR5B2K5G/oTAFHk59FtugbQNamVbmCjl26yuF4U?=
 =?us-ascii?Q?cu8u9AtbXJf7xJItbmdsN8gUSdELJVYeXMVnNgRM9O/+QwvqZlfudQ1iJVUT?=
 =?us-ascii?Q?MFmEsmuKX8DqUZdamsiMr/BBdXnd9fNB+99/RaWHOIBXIsCj7A2pnhZ/A1Ak?=
 =?us-ascii?Q?/xjFOjfuT9U/c39C/yvY/vOclx1vWW1YghJKwhAwCrdnS2xxsGceZmmicuFV?=
 =?us-ascii?Q?9GSsZZ1TiYIVOPEuu5P6PbAo+Hj9yawj88TXyG/M9dUiXMbwPssqMF5JWR7A?=
 =?us-ascii?Q?vNRxEsvD4xxL1fMnvvgj19Jeq+o8ikSUvU9aJUKXh8SxgVh49thGeqnISj1A?=
 =?us-ascii?Q?dDP2sbMX/VI6g8oQpCGtJ4bfaZ+vZs5Nd+itKnpXQ41FnbzaQs4OjXZwlHP+?=
 =?us-ascii?Q?LFeLz5+QtiocbMturCbtnPlJSZqhT6ntEqPkHIh3zNm9+mdAC5aP/BmYL+8Q?=
 =?us-ascii?Q?RZ+eZPM7lSSWrd2G6bhOI2MF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52DFA773F807F74C819DF78F63ED40A8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1271034f-03db-4ff5-1567-08d972f0b1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 17:47:14.6294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5PwipZHIf8Uck2GPvtjFDAKBpss/Qhbp9iDDQofqdpSd49AOQbedVTKrq3B88pukiKYxruYKJYbM3dUSbKpfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3413
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=908
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080111
X-Proofpoint-ORIG-GUID: 5jJIGVcJs37wUrve_TIoSaMb-xemAL5c
X-Proofpoint-GUID: 5jJIGVcJs37wUrve_TIoSaMb-xemAL5c
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

- NFS server regression in kernel 5.13 (tested w/ 5.13.9)

This PR includes a fix for this regression.


---- cut here ----


The following changes since commit 0bcc7ca40bd823193224e9f38bafbd8325aaf566=
:

  nfsd: fix crash on LOCKT on reexported NFSv3 (2021-08-26 15:32:29 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
5-1

for you to fetch changes up to 0c217d5066c84f67cd672cf03ec8f682e5d013c2:

  SUNRPC: improve error response to over-size gss credential (2021-09-03 13=
:38:11 -0400)

----------------------------------------------------------------
Critical bug fixes:
- Restore performance on memory-starved servers

----------------------------------------------------------------
NeilBrown (2):
      SUNRPC: don't pause on incomplete allocation
      SUNRPC: improve error response to over-size gss credential

 net/sunrpc/auth_gss/svcauth_gss.c |  2 ++
 net/sunrpc/cache.c                |  2 +-
 net/sunrpc/svc_xprt.c             | 13 +++++++------
 3 files changed, 10 insertions(+), 7 deletions(-)

--
Chuck Lever



