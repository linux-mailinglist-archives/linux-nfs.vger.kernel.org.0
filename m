Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8147F013C
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 17:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKRQwh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 11:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRQwg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 11:52:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDDC4;
        Sat, 18 Nov 2023 08:52:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIGYUbn018702;
        Sat, 18 Nov 2023 16:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=29FrTlsjqtaBafEwM1M4zubQ+3kN2ypvv3zyNMEW2Os=;
 b=0IXAVjHVQ27cj3ehopkof/P1FqnvUwhXEP0l7X/Sz8nUAUMats4XndkPlKz+po8XA50H
 DtUOQsXVQVANChc2XzMwCZO6lZ0P/hlOFj2MMiVcIn7tsbs2roEP6wVTzXDZHBFcrxR7
 l/ge3WkcPvMXB6p2jrYARzhecnrf8SLK1tJEop7bt8uJVaCOmNf7fDnuAlxBECGHSujX
 zEox6N/GX8NTcy5rjfsE+tGo2lP1SzsjJEQfZBnsJByXfCLWejP64cr5fQW9v3apa0Di
 c810XbmpqbcWJTIaY9cjMTyHP4ygYjFa0uD5Cg26m75vCeV2T0JnDNkg1S6Q7SWjXihn Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpegjc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 16:52:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIGHJTv031227;
        Sat, 18 Nov 2023 16:52:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq3m6b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 16:52:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=av5Mjw07A6+tRV9f2a/Fy5bFZeCrFrwxlbGiZWVb2ePBAV657gkySz39HGyvZbsPpxiFG+VypHowSBuRgOnG47l/YKhwtd8VAl47VQnpHmuvGk+4O9E2ZMQwDVvUHRoO9hcFdbmdIgNacTmPiA35FlUyRK1kFMAQgE5X2V2MML3lAmjOvKRDJ7Kw8SV1sG/XbTEqz/D+CG8x8imXdW7cPFp/sVL+Xg2GCjC7AsfbsI3sfp0dox3wB201IN2K1lPs+wBBURxJd2ndSVZUnckJkNAL6dcLbOsxVGKGTqKobEZjtv+cXujVjLSWf1rtpEK6GwIt+7inB8L2bWbmXo96kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29FrTlsjqtaBafEwM1M4zubQ+3kN2ypvv3zyNMEW2Os=;
 b=E5LFmOY3MNhy16styc2nevW3bN+X+QShrIbZPRPtUrQmDxQbE7Zb1ZI2Wfm4mYG4JYqHZaSXIUQtJnVVO+F60CdHhEQPb1JqPEUPcAG52TAI3U5em8Qi/NJwrUAxrLoUUtXXvhYnO4HsJ77qFYe5k2IBsHsq6hfpp7l9st4hVB1xC5Ipn0Epdfe6afsbBUarmDgLuJUMAAlpOfNqlL4GDtcBnF1DZkzPdDBeT7Rq8Y1m/gJLrtNDdufxIgB96hz15wTFlG91N+Uvl8/Gwbw8ASPYvKFxUrRlc6YNoO6gJz+fpOEkMgtGUPI4zfsbsTG0t9pZdu2wzVSCOLs1j8iWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29FrTlsjqtaBafEwM1M4zubQ+3kN2ypvv3zyNMEW2Os=;
 b=jhblqMgjyH7hqRZaj+J0y9UJxPH6l887AI2SKACqtF2R4kA05J5+vWZXwCtAfXaVzBRwuWz605qPcq1RsvSBdEzQgu4uughgU7ywt6uKt6kL/q64vHATgLAKxpEeAquFZhKGr/X4SzFhVr7hHcUdFN2pJd6RhpKkdLJf168dMbs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7161.namprd10.prod.outlook.com (2603:10b6:610:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 16:52:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.026; Sat, 18 Nov 2023
 16:52:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] first set of nfsd fixes for v6.7-rc (take 2)
Thread-Topic: [GIT PULL] first set of nfsd fixes for v6.7-rc (take 2)
Thread-Index: AQHaGj+XjKkfhBgJO0SEF943M13VOA==
Date:   Sat, 18 Nov 2023 16:52:18 +0000
Message-ID: <75D9A22E-436D-4358-8F3E-B857EE83C07A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7161:EE_
x-ms-office365-filtering-correlation-id: 151f7a08-3da0-477a-d113-08dbe856ba14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fxMVmT+ZRmRmixJHgU+Wo9TD+F+RvibWyVE7k5IDOCynXAcbnKrEPq0vN6+rl45otStM3HgRwO+6hStlZnLnZq4v9BbP9VF52bQ5yMQ2vKhgrOnHb1hkrrvcq3JXvDOfwa37rwXoE6cWeR0l/5J1At6UnYm9tOSmcY+1h89apj1Ir5gbvpsFILSiPTnccC55yChluHz+2Il+cy6fLnp+DWx5C5Kw1tNrC//dKb0c3dPi+Ruq/WFjyLGnCu2lt4cGzBSset1HBEfxBKjF1pPKh5tX/FUaterpoxEh5Yi2bz7wRpy6mP8qWYv2NOgTsGEb/fTwKx9ObjsN3JQ9VCdU+GFSylK2M8lXopCMi90AgHCXuafvJYmFt4QAkr8yaWSL6QpKP37yVB1kgHpyWkAqlgYRIkZEk4XiAsZOPKWB2zy7KEmSMIH8fNldoY/1hakgL1Say2EhcW+KWoDfhRS4igu7zID1WSanSvy4Fb9AOXZh/ZwrJxS8A6S1Y6/R3CdDIcDEXal/R6k6xN090jB0F2yHd9y1k2/EULKlySsMk50EybGPRJs1dh3/1TTJpNPckX0VrJAtOrTizmxg9Dlt7CNttKhDUwFAq1ATBzo5MSg1QPlPz6LzaAFSXWgJep8LjBVBID6bWtKhcsgJErzCDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4001150100001)(5660300002)(2906002)(8676002)(4326008)(8936002)(41300700001)(316002)(64756008)(6916009)(54906003)(66946007)(91956017)(66476007)(66556008)(66446008)(76116006)(86362001)(478600001)(38070700009)(26005)(966005)(6486002)(71200400001)(36756003)(6512007)(6506007)(2616005)(122000001)(83380400001)(33656002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?otZ20zi7Q31D3rhlhDsMswuPYRVN20dQwko4kDrTckqLTJgCB3rp1sMWMevJ?=
 =?us-ascii?Q?rH7RwHiUGf7CgbTfw6CR6H4kVFAmMLpuhX07hx9bUhQ4ePPJEIgdqqrdKpLN?=
 =?us-ascii?Q?2YpGEV62Ld8rwa6NS0Eid+obUCg6gCjV8VPlbshaLY/sjomhuppBIn28XcRc?=
 =?us-ascii?Q?tzewNmu68K6NUEqje5sVi8IdaHCDtyyWhc00SeBvVUjIZEQpnuUF3OlVIuQw?=
 =?us-ascii?Q?3Qvx2tcDZeD9bJ1tRarQt4PbhIWQh1jbdBJno/kmihg2JXIiIq/YcQu+jNtj?=
 =?us-ascii?Q?xETXaHlcy1Ci5ZF+Zu33TNe3fM0BIFmAdD87JOq6b45HGBJJq9v8WU3xCY5s?=
 =?us-ascii?Q?y6jcbtnyxTrpn7gfqrJ6YNpTUM4Wr632CKnUlmfbRoltAH9tT6HOic/fj03A?=
 =?us-ascii?Q?F/9RZ+WvNur3O0uUAZy/UYjmXDH3uQ3eawh2Hhvf9nINTytsOz0vJCyAFkZS?=
 =?us-ascii?Q?yXlNIMZSKJbNF1T6w6RKGapqgn/Vlqsu2iXKQdXlOCJaTsTn8pG1Y/AdSCRH?=
 =?us-ascii?Q?OdjkpTem6bpyEcuZNJUwToVD9jGhp+uQnkWtkVEsnFruPdz0z8z3MrdTMhxR?=
 =?us-ascii?Q?vPefnXwVEuBhkCJEXqQAgOvkEx1R2k7mlrAglBUpWGAsfldWxMoGxnMn0QhK?=
 =?us-ascii?Q?xqEqmtzqpXXIv/zP7ZwrkOFnIy/g/JdNeaLRNRpzXWffPb509MxGdl8EYzSF?=
 =?us-ascii?Q?kl6yVgqjWuzQHHdxtnNzPQA/Olrx4/FqnINkl4bYC0ozAdI6Kqb9NqzM+Kgs?=
 =?us-ascii?Q?PwIQYNKewqJ9S22YLRsh/CYy7vnyZqtn0KorDYy7DGgWBBc7vx+4tCGKjvUm?=
 =?us-ascii?Q?yt5cIfTRXHC8AehGD8SoGAmiePnh3vBvLzdC6GkXvj7h95JL4scbfR602Q1B?=
 =?us-ascii?Q?Dz+1bmqilL11+2GBvHqsn1Va1NqezSXhbikznhvn/E/GFS/w+w6grC1zD3VL?=
 =?us-ascii?Q?qDuVZyXCUL8F0dzoNAw8ocjFKBwM2aoXPo9J+CaA28iNETMATXGoI+QJMgc/?=
 =?us-ascii?Q?ajEU4ht6425tRi2UtahycgI9YtR+ibLQF05cPWhBytTGrTpd7dWdqe036Fdm?=
 =?us-ascii?Q?BKqPabPdhsfViBpAfVs/cwykVXJ5t91qp2/YM3rMuTGpMWyDrA3tlRmM/gjF?=
 =?us-ascii?Q?TC1jCYsGY8eGYT/50JeOQ6fu4LsKoh6ABeBwPNCA0MLXC+/M+gDsGDwwEAjp?=
 =?us-ascii?Q?6i6ZRLe6caVykxwRZ8bkjCPlW5GDkfdegGhw6/91r5HXv9M9tCpMCQ+dwksZ?=
 =?us-ascii?Q?Tjofazc2ZFx+Zi+UAQPDZostawCKHuGPARohv6EZD92YPQDgeAGZhwjVcZg4?=
 =?us-ascii?Q?/xu9iQihHbu/1pbOj7h6MQDjqfodMa5b5HFRFMp9m+Rf4r/qW5CKbab0M4hZ?=
 =?us-ascii?Q?CC95mRZ+bD+zrTBapBla1A464CVlWVCifVVvBcA+muv0eDS09iAAL9OTkPPh?=
 =?us-ascii?Q?79MPOwQrkZlIa+Ra3NvD6pr5aDmGl20VBwD2cSFGCNjv/1W9wi8pf2TQ7wqF?=
 =?us-ascii?Q?1ALC8I7ijEcP50vO8J/IURk9Vo4oLOh69EAoaEbiebilIoOqvSroExNry9nl?=
 =?us-ascii?Q?r7NQrIzmJGlhiaXJ5Q2lBw7waQQP/K2Hq1yii1ZqPqCVdtPHS6eUQ//Dg1Pb?=
 =?us-ascii?Q?wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC73FA8FA4BAD84A9D59C4DCEF2EDE00@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1cISX2pWidZpidmlAd+PEQ5mME10Dr8j7uUx+5mexiLkxakYqJOABQMP/6fzAqZNcIa3NOr7RNEnFJoY6wBQUr0dCTTAO6SeJ4jrfCo6K6lK8CJjZO/w5FgjY2ccy7yFwO2Fz3rNeAJOdlojs7226oNZ66qLckvsUHsZIryWTHJmsEN1zT9S0n3R39W2eNNdNbsv8HUMEr2kRvqNKh78Kgfwtgfe63vcmoN5LsUO4TjJiZ9G8b7X5kU+knFQrLcxwzR+T+7TExUbhCsEcXNVlDXnhOaogyyI/mfQ+GdZwkIztY6W8wu8T8eiEo97pi7kdpvd/0aImqEqzxlZPorYTUQpwkwTILfRyOz4/ZQjfYCxY5n1TjkL6fFrFXXHdZeZQ64bA6Ri7PfiKnyLJnIljHVputfknvA5QBecVX0SMKlC3e/M9Taf7Mr1ECrnp/apnhI+IRNcuMvtRmOFsLRY0j85FvOkPf0M4UZnQvseRgGA1RsX1NgqEyCE/pdOnGmU1sJsi2u6VfOf/8MhuoehpJwQvQOP3jC+6Iw5ygCviXZwrCt5o837QRf5PD8k2vqN+Q84Jp0F40Gij4wBhQW61kXb+RNYkz7qZZuk6+5/WyWGB1Y6PyVB2W6KPGaikdQNM51DMFSLDMCDaZUGG7inNzx7D9Q9gTYc/Yf0C81zhXfhjPXy/SymCfu1B3WZbaey8t3BCrGNXQ7AkprCSrMhAA2MoAgDhQWsBTwnm5oYN+iD51W2cQ/EJ7amlZreeLtXh3zcj8VPayeBTwkW1u8OvUUSv7NizZYJnLVS2B6eDSuDFVfadisIcn/822V4vK18hioUfKl+bdI0RzmBBk7bmQ3aaB29R/elzi2apV0opIk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151f7a08-3da0-477a-d113-08dbe856ba14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 16:52:18.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRx/jIJ68XnGz/m1Tr1jBjcGu/NFWAw4Gd2MrQWaN1aUk6u0VTeLM/8/oo6BbmOrXN2GHOraQzxJG2O7vL5Fnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=917 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311180128
X-Proofpoint-GUID: Do3c2u11FhNR6ha2_3LrRqAQZmFG-Om7
X-Proofpoint-ORIG-GUID: Do3c2u11FhNR6ha2_3LrRqAQZmFG-Om7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

Following Jeff's regression report yesterday, I squashed a
one-line fix into "NFSD: Fix "start of NFS reply" pointer
passed to nfsd_cache_update()". Jeff has tested and approved
the fix.

The nfsd-6.7-1 tag now points to the refreshed patches.


--- cut here ---

The following changes since commit 3fd2ca5be07f6a43211591a45b43df9e7b6eba00=
:

  svcrdma: Fix tracepoint printk format (2023-10-16 12:44:40 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.7-1

for you to fetch changes up to bf51c52a1f3c238d72c64e14d5e7702d3a245b82:

  NFSD: Fix checksum mismatches in the duplicate reply cache (2023-11-17 15=
:13:01 -0500)

----------------------------------------------------------------
nfsd-6.7 fixes:
- Fix several long-standing bugs in the duplicate reply cache
- Fix a memory leak

----------------------------------------------------------------
Chuck Lever (3):
      NFSD: Update nfsd_cache_append() to use xdr_stream
      NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update()
      NFSD: Fix checksum mismatches in the duplicate reply cache

Mahmoud Adam (1):
      nfsd: fix file memleak on client_opens_release

 fs/nfsd/cache.h     |  4 ++--
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfscache.c  | 85 +++++++++++++++++++++++++++++++++++++++++++++++++=
+-----------------------------------
 fs/nfsd/nfssvc.c    | 14 ++++++++++++--
 4 files changed, 65 insertions(+), 40 deletions(-)

--
Chuck Lever


