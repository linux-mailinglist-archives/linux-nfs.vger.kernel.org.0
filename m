Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326C16D0EE9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjC3Tdl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 15:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjC3Tdk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 15:33:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00AACDDC
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 12:33:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UHNus4002173;
        Thu, 30 Mar 2023 19:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YyvQO3Z0guL/M9bnlHdm4HTdh2M8ImSv1DVkYxFXacI=;
 b=tknOpnfVxjR+X+4uP40AVSTN73TIJT81ucO3aK9D8YbJqWjGdhgF2LeQKQKHyWSVZqNa
 ef1V9+wtAjJcrHgedReFF4S3Fo6VPk5g5L/qHKt2eeLaqbS26CrqlfuTvrgw2Ynsts54
 y6e2B9kAnqyBybsiTsUM1otzAm3RafHT+93CS+qvG3sXzWeuYGoO02cFgkVHTBJqEcV1
 qHOGEnm/umcsPPnBCstPDK+NoxhZm38jiYaIOwwW5mNVFl0lNiXbVcgHvBmViTkaVhK2
 cKdKMvYyxe5OF6/NnWelgabDLKx0MbfnPVx7dkj5dRj1lzaUjaCqgijiHGUlhUc+eHGo FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpmpbq56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 19:33:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UJ0NTx010896;
        Thu, 30 Mar 2023 19:33:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdgfp4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 19:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmiAwpFnK8Xqd0ejlnfJS8Vaqrrr6u3OiQvSF2MvLpIhNywZjSAiPqbIsKDjK5bjejXehkOs0UYWuXiCoSEYFcpgwxBqfgJFfnJR2jWXV5yV2zJ3XDjjwzJeUWctLbJir969LqNh/vqxL6de4IsjmY+yY1Vkhzwb4X4F+EyqRavif/E07V7iP2M87THOTU2qmq8UFI+2wC7k19216jSaqFn+SrDhlVy98ea9IrtmWtuwp8IFh/UOfey58eK+mW/3/SZXYit8Z6itk5CcEbIBpnDXJyBg0LUOTf3mWoZhS4JBqg8GPiLPZlh7BTO58XAER2lTGnyr2eBhnwpzsB6nNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyvQO3Z0guL/M9bnlHdm4HTdh2M8ImSv1DVkYxFXacI=;
 b=PJ3Oea5uHLMUBnKfssbadapVtbdXz5e4fCTXy0N7RP7gEdC0L4aKRgDGlzaAp0gv3uRwjP/+GdZHszuVpH+6Jitbr6DjYSKvoce0rgRwuotZ9lCeAElyu89RfJdytYkfpkHZI93/6KkEDSPj6D86adIDM56jlCHIvdhDreQ0nRBhQckOwcce+BJpONbCtQ3YKrOs8Sa3BMd4dquqTK6nBRZcep7R29pTWFT1us1VYjJgDgAaskxuPqOZ7Ywa5pYIwMtmERWvfdSWdoJtKQnIaeMdghPEGVN6AoJCo+LFCcu6PtsCge0H4ch426ow4PwjKXV2F389wpnsZtIqHkR8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyvQO3Z0guL/M9bnlHdm4HTdh2M8ImSv1DVkYxFXacI=;
 b=ZLeKOLAOkXfrdxGzTeoVHEPrGdKm61XhcXAaApO4mp/fcG3vdQUcy3MPf0A9mJrpiQWAnCjP+JAWvlxEZNRGRbdfMLP8q6fJKxIJswllSsJuLyHFzd0YoKXHVBekx0iBxWjfUwt1UhErY4wIgfg86i/9gGqjogJSCjBnauhuV6A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4434.namprd10.prod.outlook.com (2603:10b6:303:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:33:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 19:33:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Zhi Li <yieli@redhat.com>
Subject: Re: [PATCH] sunrpc: only free unix grouplist after RCU settles
Thread-Topic: [PATCH] sunrpc: only free unix grouplist after RCU settles
Thread-Index: AQHZYzThgQcpowfBWk2wTdI98B7Wjq8TpTyAgAAFDQCAAAxNgA==
Date:   Thu, 30 Mar 2023 19:33:27 +0000
Message-ID: <D3F3D553-C252-47FB-9D41-9C9A254557DB@oracle.com>
References: <20230330182427.19013-1-jlayton@kernel.org>
 <49AC9CF4-71A8-48D7-BF21-41FFFEFBE4C8@oracle.com>
 <12c783873abcd0f9c631e2f367cc1dd97949e0fb.camel@kernel.org>
In-Reply-To: <12c783873abcd0f9c631e2f367cc1dd97949e0fb.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4434:EE_
x-ms-office365-filtering-correlation-id: 5cfa1c99-29d9-4bdb-3a64-08db3155a2b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mu3dBDcODJVcps+B55YI1t6VGGGeshEPZrsERRCQkLiJDSPZA8dKmr/Tk7kHS0teL6fArlxqOkpb08mWXWhCCMZ9F75/h/BgrBidvi+ao0yGgwDSrp7+8+outr8cY9gw0hhYijUocBQ1w0Jmn/50TBIJuA0fVQuqB3TxAHfSQS379TfgvPQcoll/fqVxB+Uz5ju1+XmkGpj3P7KWKBJ10Y9wCDng6GHUeU73w9bTLreKiCd7GMawxAlWCAE9JAE8mLi0VGQ0VX9PQHnG4pag08xEoRJP+uRmolomMTdSGTB98kW44oAHV/yac1UNkrhtPdwOReQUrI/TmS2yOANNymsIf53b3Og3YUubtg09glv1OSBJVS//X0orsU3nvsiMbrdc9I/UVfYNkoPbPDlDJ2Y7bFxnOdU6rr6N23EhruKs6KrUVuNDARufbhTMWmDWdnnfa4dulFeQDMV6PtREFHQKKOEOKsK/7UpOPxprRS9dT4oeEnHlGqghPMySQjaSUwZSwBR9S1qpJDCJf/rSCWfKdQ81ADfDT9n/753eOC5XrlNe+Nstt9NlqtveyILLpNLpxNS4xpiDOryBsHn2/pO6e7Qm7EHSUeBPP5SeyurBv2EF9qWDMLGHJoX9JtS7SbJjQ5Ks48idpWsLEdqrtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(38070700005)(2906002)(38100700002)(8936002)(41300700001)(5660300002)(36756003)(86362001)(33656002)(122000001)(71200400001)(966005)(478600001)(54906003)(186003)(6486002)(6506007)(6512007)(53546011)(26005)(2616005)(76116006)(91956017)(66946007)(66476007)(83380400001)(64756008)(66446008)(8676002)(4326008)(66556008)(6916009)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Uqu1FBD9CYPZfgTy+ZmdH2f97dvBYISR7+qq6zeVMbBs4nhNKWYcSBWAZWt?=
 =?us-ascii?Q?EVqmUNNT9KjuHrGjsfPvOrcwnzgFVw4ZGzjirN3Uh49jiuwILpYTrhyB+lnv?=
 =?us-ascii?Q?4TqJXxEBaf8qgAKCujTmPTNPh3pRkSEoAKoLbwjkiJxPlPTXeeApXX+Gz/fv?=
 =?us-ascii?Q?VDNwXea5k/UaoGfBIRy90+h5dReSyetkzy2y76Hr3oRGcKnORRnFcS5ORF60?=
 =?us-ascii?Q?qBwn8ZeMfwS9+yf25cZYrL+hvROr9GBLEjf0dhsuTnJL+mysm4bshYRDrMpM?=
 =?us-ascii?Q?ikuT+Cn1EaHWP31NxP85SsxDyZmDVnz5sSyagkq+9KLmFhayRSyJGWlhH+0p?=
 =?us-ascii?Q?DxchGOsoTFl2K3uKBF1c7irkngihP+vaB+E3yF755seq6bY4ByAfA+qTGjsM?=
 =?us-ascii?Q?GUAgkXMQyMyt8x8HdDZGjpSgAcD4RgtYDPWYUt1VbN14pAPP+MSETGSbrfbV?=
 =?us-ascii?Q?z8RYsNl9DJAkXB83E5iOf5MZUFRY/bsI2WGG8KpKp4DF124mpO0cR5guJCiZ?=
 =?us-ascii?Q?+ImpfLScJ8nRgvLK1TKv7dTBFKh3TNkipo2PxDJKr241DX5ryL3fVLG01fgq?=
 =?us-ascii?Q?1t0z4so6m9+iGAshPJ7aEEaij0TVq4foZfDmvokoHASKFr/YrMkcJ8Wke2rD?=
 =?us-ascii?Q?aiETJiR1vxVhqb6hEAumrQxZ/9I/fKomrN8bjnWVr75P/KjWz2I28AYgbfO9?=
 =?us-ascii?Q?xx1kafQpEaKNHGJc/T/Lj2Zs5duPVL9gnSBM81ynC98JjViCYqq1e9C239Y0?=
 =?us-ascii?Q?b2JgeEeDhYlXQnoEKmyjVl9Hs/uxzqo/jyQJQghtPl/jeIYOzr8VwbkLKXsf?=
 =?us-ascii?Q?6QRr/9a9fQ3yigodz81Z0kkyUBimiO4Tl03C2dFB+8CxMPFYKwVvj1+YMI7O?=
 =?us-ascii?Q?EI9wJTJeh4VinklSx17KHTLYvlGivJuTTR1SXROTO7iZcdr7QjiAquBdjppQ?=
 =?us-ascii?Q?zv68LsDdZSV+jj2kQTsNwgmz1wUfprb/1X5cgWfilhqgejaogDNUZYxOp/Nb?=
 =?us-ascii?Q?TS3r4RvyxWhJJNZzMr0CUxo69/JzS9g6eNIzT1S6wCwsc+jh59/Y3adqtwRD?=
 =?us-ascii?Q?bwmRLgyJc98ar3j5OhVZdRgFV8SB3WOGiTLFiAGXMf8Ppd0tNSl5rGGaB5y8?=
 =?us-ascii?Q?/DojUXQbf63mF7MK112sVsJ8WkgrWo3FLfkD/bDzr5agjduD+ZEDJoRcyUZI?=
 =?us-ascii?Q?3kUnXrT9Mlki5ieD3rLa+aC9xuLfvATqimThIQoAcsCJP6E6Gz2UTEnRcpWS?=
 =?us-ascii?Q?VU9mV7OR5WPoszhRGmYrWCWitVkv5dCShR+TyGjxIyennM9OVMycnWbOjphz?=
 =?us-ascii?Q?5mFLnwcEJ6AHZlSJZU9IG4swfJaFLi37XMCROo837cRVcP+vPXD+yPPtUGjP?=
 =?us-ascii?Q?KP6OUAqC7fhrS4ZbHjUJb3/u3dLV//vPiB18zVh+K1x4DG2XbB+ZZJFsf85N?=
 =?us-ascii?Q?YRU7UO56OkGSdFVkC30TvoKk7XMqhzCYHFKhyt0qMRnPvn/cMyEzpwA4lwXL?=
 =?us-ascii?Q?iq5RYvd3nTxY0/4GMalPWOZyEGXj/hIVBvtR1cHRh0MGGF/rdjozf5IDaVWm?=
 =?us-ascii?Q?3jnRhIMwNYifPQ+rLlwP1fabBJemhDNk3milkIC3Yg+/Zt00w7E/iYmMdn2v?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87309C714A07BB48A2D642F4AD0530D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6AhnVA8eGpMJ0n0W8IjZcCC/VZ3qYGvwvEOGJsb2gMTDCpSqBMNjXw1fP11fz7JoMXKc1PAGGNamXzTa0YTL7+4XMPty2iAxcr79v/aFaNUOIbrNo05qWjIYwI8h0iU7sJNRZIz7rd68ZGbC03BnY/lJQq224oztq+q6qpJ3OtyNFYRlQk2dC/6RkedywFkZ1bpVRciKeI/+idEc13fNr0VEYGKM7j/zfAa8+5pQL2jhgsEITpDyaLhwh2RWtSdlnFwLEv1irFxXbirYDN/k7kxlWcn0jy1grmEq6ufYZ0BCzTCvTLfTwCewKNERZxkFTzfCuOBJe9drjr7fTByaTiE12IaJ5g0iRQtwjtjjhzCRz52R8egFsog+ZI7eX3qcumPsFCEy9kflBQI4ybbL2rMF60TdcCfs3UuHK9Oc8CrtKntizHK0xZBZL8P0m/vhsW2f359W1/4S/BDJCGdxB8lEjbFZ75S0AIKofCWLbbmiIy7jElJq/1zc2/MCJUBkpD2cpTl/xkHbQ6VBOHF5oOt5KRLEExo/SGkiTdObjzCvUiddssjuYm0L/NyYhYP8usq1H3yaY2DEwMp49lm/Qqy3N4h9PzLcTmAMbPDrmlvxFQKkXCNRY2f8GOXXFFOyRXVzXSZjki95AG0wIderdVblbQQ4NZANRdXMz7iLdU9OPXvY5giyUJcUXRed3Lrh17OW3N3+SCQBWTRC/IUx1rOC9UUmvrV32Poss9a8wx/nkxuj/riD2T1IYMKBiiYHRDgwz1lMS1EsAQd23Rcx5JFLoIv5LMsNZUXE6CLs8xA3KI3D6JUfPk9UtwbYvbkv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfa1c99-29d9-4bdb-3a64-08db3155a2b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 19:33:27.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7aAxJAnsWlM4wd6C8Z+NBKxR6EqWPU2smS4UD1OlDyneE4hE0bAOZWEkO9MgcldZBpv61tZqsrR0D8vJlWNnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_12,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300154
X-Proofpoint-GUID: q1a0_JfgsRIMvnvBUAn_db8tLT83b7LX
X-Proofpoint-ORIG-GUID: q1a0_JfgsRIMvnvBUAn_db8tLT83b7LX
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 30, 2023, at 2:49 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2023-03-30 at 18:31 +0000, Chuck Lever III wrote:
>> Hi Jeff-
>>=20
>>> On Mar 30, 2023, at 2:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> While the unix_gid object is rcu-freed, the group_info list that it
>>> contains is not. Ensure that we only put the group list reference once
>>> we are really freeing the unix_gid object.
>>>=20
>>> Reported-by: Zhi Li <yieli@redhat.com>
>>=20
>> Should we also add
>>=20
>> Fixes: fd5d2f78261b ("SUNRPC: Make server side AUTH_UNIX use lockless lo=
okups") ?
>>=20
>>=20
>=20
> Sure. That does look like when that particular bug crept in.
>=20
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2183056
>>=20
>> This bug isn't publicly accessible, fwiw.
>>=20
>=20
> Thanks. It should be now.

OK, applied to nfsd-fixes!


>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> net/sunrpc/svcauth_unix.c | 17 +++++++++++++----
>>> 1 file changed, 13 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
>>> index 50e2eb579194..4485088ce27b 100644
>>> --- a/net/sunrpc/svcauth_unix.c
>>> +++ b/net/sunrpc/svcauth_unix.c
>>> @@ -416,14 +416,23 @@ static int unix_gid_hash(kuid_t uid)
>>> 	return hash_long(from_kuid(&init_user_ns, uid), GID_HASHBITS);
>>> }
>>>=20
>>> -static void unix_gid_put(struct kref *kref)
>>> +static void unix_gid_free(struct rcu_head *rcu)
>>> {
>>> -	struct cache_head *item =3D container_of(kref, struct cache_head, ref=
);
>>> -	struct unix_gid *ug =3D container_of(item, struct unix_gid, h);
>>> +	struct unix_gid *ug =3D container_of(rcu, struct unix_gid, rcu);
>>> +	struct cache_head *item =3D &ug->h;
>>> +
>>> 	if (test_bit(CACHE_VALID, &item->flags) &&
>>> 	    !test_bit(CACHE_NEGATIVE, &item->flags))
>>> 		put_group_info(ug->gi);
>>> -	kfree_rcu(ug, rcu);
>>> +	kfree(ug);
>>> +}
>>> +
>>> +static void unix_gid_put(struct kref *kref)
>>> +{
>>> +	struct cache_head *item =3D container_of(kref, struct cache_head, ref=
);
>>> +	struct unix_gid *ug =3D container_of(item, struct unix_gid, h);
>>> +
>>> +	call_rcu(&ug->rcu, unix_gid_free);
>>> }
>>>=20
>>> static int unix_gid_match(struct cache_head *corig, struct cache_head *=
cnew)
>>> --=20
>>> 2.39.2
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


