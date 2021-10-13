Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78042C35E
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhJMOf7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:35:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28510 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237966AbhJMOf5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 10:35:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DETr7G009989;
        Wed, 13 Oct 2021 14:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zGJawsCypZCkOrtoKdDj/pkFHzHKdeiN1LdOlnRE5e0=;
 b=bpm4H7538tnLWR3h/3BqdPeAYakQGadOt62YpogXorTNSoykZesSIanwJJ9Om9tJC24U
 b8unDxdC54Emzv9sQt4SKTZypNi0MKpajCdajc2d9cPY5F9i13UUREDfkvS5i8dcH3+/
 A+07PU8liHasAC8gZfCPMWRFMvH8hdnlmuQEfDXFXRgV4JzDOMOaNlAeRPuLadr6m7SW
 Aw/bSNo4Nt7W7njyKONPfLe+JlP+/djQCXwu9giRFH7ALCe3xeTfuSUH6Vz6w+Vt2yfk
 Ju3TDG3XPKaaF9Urn4gf9SSmGfzNQCNjlKtMMnh5/g32C8NxtkabOPebOPxfFYz4l4QF VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbucftt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 14:33:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19DEVQLP112557;
        Wed, 13 Oct 2021 14:33:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bkyvc60m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 14:33:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONSw6tY0NixrfTveo0Eb02TzWVZIcTWIloDpViPtlyhdxHPOymJ2REBXS77eZSgYbgUlHmfCrT5LGXvuKhEV8AvvVwjbvb3rhPwd3ZbdN0TZNt4xj616tsfvcA2CJxF7cjTpH98CXdOcEW6GPMjDTuQScIcXNfz8MeIEG6wh4rfhJt6RTnErqlDP1ZJ4Uj3BoRBq9avQAZWrvHKa7IktUgxA3aQnjiGECBDPhaE+sC4PcwHKEDGvRTVGv85OmggY0GmY381BdtVfBKY/muw2UHdVRyZLtRdlKRVOkBnsW9haIIqpCkcRISWOQHfjXEpIqix8EHKOmqBhkSEjadz3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGJawsCypZCkOrtoKdDj/pkFHzHKdeiN1LdOlnRE5e0=;
 b=G3XArRjNeG3AZswhqjP+07HVkiRjco6ppY/44upHQqT+iqd7+YF8i2CpfjG2DSORK5wQrfYfdqRHnhLVRO7bnwNemungXT0qKLMEJOCDvr7NkMoPkvlV8H081lydvDSxhvYw0ICKXPNBPJwhI3HdS+jkcxEjc/Vd7itTepPn14XHO8EaMPUCNsgGZw6sDI6skWTN7f1eN2BnPPb/9zqNwdIWoybOvO0QO795ut8BXeNz1DDfZa4z4Ocvljii2rBNmHSCkcvdht584jib9XvKYvItsiY2W3smTD7Da08NLRRBwz/YC8+8RD3RmPfHLS81gisx8ejY3vwAVmgJX0xWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGJawsCypZCkOrtoKdDj/pkFHzHKdeiN1LdOlnRE5e0=;
 b=ZlwIm3PBfuPeitf4cpBJnTylSsIt3DNZWpwwhUK5cq4C0DcKd9YndPCOaSu3qmSB2hTv+Ecywat52+CFZx/ktsu7v9jA9ZaevEKZikB1zPB4fAsZqIbM68KqUEGVVpnWM4WE8VchHx40ppHq5RgjwzAvWs2diZh+YLPKlK7VSdE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2488.namprd10.prod.outlook.com (2603:10b6:a02:b9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 14:33:46 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.030; Wed, 13 Oct 2021
 14:33:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] Update synopsis of .pc_decode callback
Thread-Topic: [PATCH v1 0/2] Update synopsis of .pc_decode callback
Thread-Index: AQHXv4HYsWpyotoulUemOtAsA+X1z6vQ/vyAgAAAp4A=
Date:   Wed, 13 Oct 2021 14:33:46 +0000
Message-ID: <4F65A128-3DCC-4E8A-A7EE-5143152095C5@oracle.com>
References: <163405415790.4278.17099842754425799312.stgit@bazille.1015granger.net>
 <20211013143125.GA6260@fieldses.org>
In-Reply-To: <20211013143125.GA6260@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5db464c8-cead-493a-aab2-08d98e567714
x-ms-traffictypediagnostic: BYAPR10MB2488:
x-microsoft-antispam-prvs: <BYAPR10MB2488B3AC5A565357368A4A3B93B79@BYAPR10MB2488.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8McYuRVO7VewYSFmik0U8+AU5XY0xZ55sCo8eVIkitfOMw0CdnNQ1BvRPSMJXFb/5xYhEisnyVsunmderP979TkbX2PeLzyeRZzYGxc2WlggDjTVv4arXCQcJnGQ8FGjWrqRkiKbocwrk6QR22UX4y7aVpHZODjQoXmQTTS51H2CR/K6ewxEpzwzHO2IdX1yz8QHcAH4XKoD9YACQYU+EYmfeFQ5VEQ8C0+8kMjQFXbSpP6W9nvqvyMytQ8d7ix4duUCLav+Poc24uE5n9qnVMRQ4GHDWvHE3I6igw3ZqcHiK0DhkuKnUSQ4/krEQG9qxvV0hEUxvrjtTsXJnPPkIwgJlUifPKFP1Zby+rqvlKlZ57z4wO2dHMIC6tHwBJFge6vJqM6n4VZwrtiGlDSnBOYlcPxAj8t2KetgS8OjwQCnxkBrMNwF7Npa7yVDr34DGwMFWvaqeTsNaCRejuv3UW/UDUKCUqDwNIpFkDpyPeI+bJ39PgChCebwP2Ac7wfxOlrUUuanj/3n62dWnodo35TAGuBlQLsYSOZqg2TeM8cHA9HUM92JQAjnxGHmF7LVt3uKPPy1hwi74Av5Bn6N8clbKay+BRA1gPSJhFkvhj4Iia3o0l3beyU67n98bCWDP10VyL76sP0IvpxJjnhCPjtBnAwRd5A8UbpfqJqp1pWiJl3JSsllpAYXpWjzDFr6mS5hvjmyWtGL7RaELvbrYkmWnyr95mWJb01cYcQ0nznwvsN7tc45fLug0jSeCa6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(2616005)(6506007)(53546011)(33656002)(6486002)(508600001)(8936002)(6916009)(186003)(36756003)(5660300002)(316002)(54906003)(86362001)(4326008)(66476007)(71200400001)(66556008)(6512007)(64756008)(66446008)(8676002)(83380400001)(66946007)(91956017)(76116006)(38070700005)(2906002)(38100700002)(122000001)(142923001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WKL+t4IcXiI42LnfbXMCS0mX/kVQTYggJJRCZfEWIUQJ88s/O6d1YI0FCp/n?=
 =?us-ascii?Q?LIqJC40DxUjz9SHFZj5IezSdXptCIrd4S5SvxeUCfSFwVdEZa3qzPDVlpVr6?=
 =?us-ascii?Q?HuKxsssxIuTb75S1FC0gK8g5esrcJowG3LCBc2tZcy0uGXLLdrXFKC5I/dAW?=
 =?us-ascii?Q?sqFb+5sokVgCGCuWh/KBJxdRHVp4Qh7xSsuMDgJVPk8nxJOZbNCLrRa/VzTi?=
 =?us-ascii?Q?AfWEbJzbJdabAFTzzDw5TSl19fywpot6NBEmYDO6CBngIuC7rdyf7VI4XjkE?=
 =?us-ascii?Q?YF1yfdFtRl40xato/CGRaxCMJivobcNWw2X7XXAwVBDyI/1LLcwq8rOPubuj?=
 =?us-ascii?Q?ox5kNAWsyo6g0IXEXTYA4cpZ7psEzbJwT7r7zIlptHUKZLEACqFaWTA7ic4+?=
 =?us-ascii?Q?t49wVuOmf8BVFoIQLA7ie8xMX7XjYz+o+DjqJoIuKRKsVBVYzLcZgrIGf0m7?=
 =?us-ascii?Q?n+B28fu1KY2RILnq3//kLECH0E5xpsZYVOjXzdq9D/byflkyyiacqE87GFCu?=
 =?us-ascii?Q?IXdyUjGvMqVSK1lk6H9oHyxgcJNg5Qz2vMNZaDrpAt2SDrzeNegKDKPnmf/H?=
 =?us-ascii?Q?KXijG1lDOGGdPm4n/Ba8xZNfiTOMtpri8YEwf394LMq2zRxjmPz4OD0MlPuT?=
 =?us-ascii?Q?44jEntnIA56MUkE0tTNuKYUchjTq/1ssK1EupLBCJKC3RUgSwRxU9yi3NYj1?=
 =?us-ascii?Q?50HXuol5Ho8Yr05yQ8I2rvTwfMvSOVfo6WYPb1YvYNR7laXSm7Uzi1i5agZG?=
 =?us-ascii?Q?lAlYvgVAIYqMHmqyIqp6/6pFmUcV2Ewwk0gKd8lDYc5yBzXc4n3HEzVcFmS5?=
 =?us-ascii?Q?Fm2CMF+LFOB7ICDHn1aPkF6IjvEi0sCMpWpVvMbjBKJFqPHi+yk0kMHfJggS?=
 =?us-ascii?Q?t2CrvPT7JgJeStgHbPheOHSHrN5EAZ1Oe9D+doLsjHBQ1G6Wo5iZxDFzhG6m?=
 =?us-ascii?Q?S8DvK3LmSa2bWpMkUgm+bROnzS2P8G1vKxA9S81lK0yTSgDgeT41a+2ZEKGk?=
 =?us-ascii?Q?nNwN4NXtu2l3MYy71v9dtDn4tOQCQOckAjyRSJ0q0q9Ez0PwEbIf3FpOtdKi?=
 =?us-ascii?Q?Jz89tmDsJDfg8NTH1uOlSzdk2OSGJJbhwOe7rM1ksfr69Y53+afJvpCYXhCG?=
 =?us-ascii?Q?pi1yb23B2oiyDTSdt0IqF0lpKjacQH6LzRyqNRz2z999NOwTJJQoWBcAazj7?=
 =?us-ascii?Q?0CBCOexvQ83puCfD8c3vwpKIgecK2NWM4PG1n4f7S0Djxbh54OhfdUHucVCa?=
 =?us-ascii?Q?k9l9DDUbQzI8BzL8tQYohZ2Hbj2gvAJbZ2qWe35oizUAulaDW83aCjo2HFW9?=
 =?us-ascii?Q?/38Kq1RkTdE0h0rIoBl5Iqpb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51F2A2227CEE1F4EBB92EE9C136742C0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db464c8-cead-493a-aab2-08d98e567714
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 14:33:46.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22y+U86nAUNa/+wKYN9zEPGTMqQkrcu+VmyRaILTTwgMpUFaDrM/7UGJLOapHG02mqW7Hzp0wMFUMm2OToLRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130098
X-Proofpoint-ORIG-GUID: zIK5FBmxtuG6xzAK4Wzw15P6wNk0WvOJ
X-Proofpoint-GUID: zIK5FBmxtuG6xzAK4Wzw15P6wNk0WvOJ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 13, 2021, at 10:31 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> On Tue, Oct 12, 2021 at 11:57:15AM -0400, Chuck Lever wrote:
>> As we discussed many moons ago, here are clean-up patches that
>> modernize the .pc_decode callback's synopsis, based on the
>> recent XDR overhaul work.
>=20
> Looks sensible to me.
>=20
> Applying pending some testing.

Thanks, Bruce.

I have similar patches for .pc_encode. Do you want to test those
at the same time?


> --b.
>=20
>>=20
>> ---
>>=20
>> Chuck Lever (2):
>>      SUNRPC: Replace the "__be32 *p" parameter to .pc_decode
>>      SUNRPC: Change return value type of .pc_decode
>>=20
>>=20
>> fs/lockd/svc.c             |   3 +-
>> fs/lockd/xdr.c             | 123 +++++++++++++---------------
>> fs/lockd/xdr4.c            | 124 ++++++++++++++--------------
>> fs/nfsd/nfs2acl.c          |  36 ++++----
>> fs/nfsd/nfs3acl.c          |  26 +++---
>> fs/nfsd/nfs3xdr.c          | 163 +++++++++++++++++--------------------
>> fs/nfsd/nfs4xdr.c          |  28 +++----
>> fs/nfsd/nfsd.h             |   3 +-
>> fs/nfsd/nfssvc.c           |  11 ++-
>> fs/nfsd/nfsxdr.c           |  92 ++++++++++-----------
>> fs/nfsd/xdr.h              |  21 ++---
>> fs/nfsd/xdr3.h             |  31 +++----
>> fs/nfsd/xdr4.h             |   2 +-
>> include/linux/lockd/xdr.h  |  19 +++--
>> include/linux/lockd/xdr4.h |  19 ++---
>> include/linux/sunrpc/svc.h |   3 +-
>> 16 files changed, 334 insertions(+), 370 deletions(-)
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



