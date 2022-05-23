Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7145314D4
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 18:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiEWPmF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 11:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiEWPmA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 11:42:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC990265F
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 08:41:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NEnUox030654;
        Mon, 23 May 2022 15:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1nVSshlqo9nP5Z79ToZO4H/W3BT6rWsV4gwGO6TyqgY=;
 b=Uak3nCmEhufStKcklGv2ArFuIjrxFGX3wgLORNy5eD3a0ZSeaaVo1rPsSYbjejYzzg+Y
 G4ZWxfICbpFdZmHHW8qdvki6enbU3lS1GoBr+1FFHrajamtcEqJ6hanyWps2oB57lTZS
 2Z+vvugNR7ZiS3fC0breRX7zHnQwzGvr89TGlvtu0BlkoAIhWLhGAXeeNOiwHXeeAJgE
 1NZVEYGj5H1PUP6OXFbOrRuqDytaZzKODjKb9Mt08T++HRwun2TPIFD72OXinfV0ClQ5
 elhjYFPhOBz1wsWbU0A5dsWYefsq2H8mZUZauQDFwZBb1up+Shht72yb/68R8w4P4H2Q 8A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pp03tkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 15:41:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NFfpFe029068;
        Mon, 23 May 2022 15:41:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph7x22f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 15:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYi37J66RFsStnSXkw2QN7/W7qoH2aLx9nLlZAFjd9PY8XA/CpJctXEeRRQiREj5aNEBfagYWtJ4O7jWGvsE4lomFbr0krkxAM1pAlcAJ+SpToFsuRVDDzXT4or7uH98zY7aJ+21lTc6QQnlm0u0wVRg3jFNbBp8FS4mm4PI4iKxH+SnjFLGmW6a/5w0BbwXU24XpdpeT4JlOGQBHTBGoI0ZUj4x0IkFjJnFopiYP3tPP6UZZhtjZQlXzo/0lTgtK2PpgfKM61HYEflX/0uJT59Q1TOH2xmWkUQLXE+N9EotvseHGOU+LJyvRvsABSO8Ev51TiiuCjIUpVTIOB7pEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nVSshlqo9nP5Z79ToZO4H/W3BT6rWsV4gwGO6TyqgY=;
 b=CemH5lHP8xCnWCamHltpQy8mqCAxSYlTZtQpgN2zIKo+HTl6macDNiu6s5KtkinTUk0HG/sFcjwJgkdfYFSVJLvhYBu2ew6pBvYl9jN1w4OyHtjM0YhQyxD9fJZm2hWBvfPu7F3poPY0j2D6d+QS1AE3o5SDWTs7vfdoD/4tBbL1ubzbhmK2Fs2AcxjzSsWKLk1ZlGF/fSI7acva7h1161In/AlnYjUZDAL8k1CuzVV+sXxlf9ZfxEZub0+q2LXg4WNCaylIFOgqK4HDSK0gF5QpDrjlGWMtXKIG4Mllq10xmSgTIKspZcxnBeJVjLmT0wRztNZQSc90lNp5LtkfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nVSshlqo9nP5Z79ToZO4H/W3BT6rWsV4gwGO6TyqgY=;
 b=kAtW0i3WppMBat/aMrWwTey+2RJ1RFm9zpKIZiVcNMtDiad6ktInDNRaLsCJqfYNhlbxGzY0PFNYZX+sIgi6JLQ28S47Vz36OtSATsMOgueiUfI0a8FBaE9KSZzLJymxhJr2XKQhG6I23jDJcxNsPXM2pG/bzd88/BddTrIoL2A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2115.namprd10.prod.outlook.com (2603:10b6:405:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Mon, 23 May
 2022 15:41:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 15:41:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Topic: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Thread-Index: AQHYbfIMzaj7dJY/skSZB97V0kxLh60seYcAgAAWLQCAAAdIAIAABFwA
Date:   Mon, 23 May 2022 15:41:51 +0000
Message-ID: <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
 <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
 <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
 <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
In-Reply-To: <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64defedc-8eb3-4ac2-0850-08da3cd2c165
x-ms-traffictypediagnostic: BN6PR1001MB2115:EE_
x-microsoft-antispam-prvs: <BN6PR1001MB2115EE24862E430087154B2B93D49@BN6PR1001MB2115.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bpSVCPgURalcF70y2CUgpkKsbGhwjn5A/jp1sMZ8AcU14tREZuV5o81Wcb/vYOOYBz23gqTI6UbTAa30IYtmMDgf1hIthREZoZ6BlLQQ9L9WW/NRoA1OLrKgiil19BiBq6EuIsKi75VNl6I1d7OK/eYnTo0iYI6Pv5WBpEK6axd5pRf5OIqb9v89xlWUoazd1sIkv78MCliLDxrwjaTVkTv4++IVSrBH+TNqeMK9AvhGU7ehdTKVWY9/tLHvimQ+29AhifhCqVK4ItGYq1BTyfpDSwlMsxGVEfNtRdvd1OpAHZ6drXC6TRG9x5ZrZTehvkX+3Qzc+c35FX63TzO7l6A9EKDNGcjjh4Q5Y50BtV6U55bnpmVqpk4MBeCknISw/tOtn5fKFhKBnQzRQ0uRX8rcKhFT/OfW3BSs7C/Yy0reUAS1M7C2GLip6aAd6mexmgNqVVqLCsBlCCTNwrT8MsgDWkNn5tMKQ7pFdSniq5A1iciU7BSVFMa9HurFSdmiZ1CfEnXVP/UFkAklPFvz9amsEqVJcX1LeGtvlMd3GOXbVEW4fSd2E+ZtWodh9MFjrbMOq9Tz62pDrHxek7T1gVChGdNQPo3ObISnGfm9/oGnYPEbCebKWgwOWnY3vDxCxOIa1R22M4oyyG8kVWG2var0p0YUdhLqvgJgzlSMf8o+gcVUuIqQ0C53nXRbL1FaFP1ivm6ldU+ucw0/wNbqZTiNUafFiuTCcavmi6N2MtjPr2KR1UCYOsdU0twjLS1kr3xcBQv3WKZqzHC0T5JBZPVmYLrocm4CIsbfiAzMsiS0YxwnUqoLacp+5IyrNpDtub+TYU7lEGvpV1xBJV7MEFkT4ZacfqbDIqCPZM63jjgEK4/PBz54CiMEEU/Ij2K0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(38070700005)(2906002)(83380400001)(36756003)(2616005)(186003)(6512007)(53546011)(6506007)(122000001)(5660300002)(4326008)(86362001)(38100700002)(6486002)(316002)(8676002)(71200400001)(66446008)(66476007)(66946007)(966005)(6916009)(8936002)(76116006)(508600001)(33656002)(64756008)(66556008)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z6H0aicMpbWWq2Z0UO0IFQ6RZzSYA3/0Cl5GDnmKwcDgcQhGCCodg9fCnfYh?=
 =?us-ascii?Q?J6nKjVfAQw/9tQSXJAhleG+ZrTMoxKDD146SeckSxGnlpvPSuQq1JGMf+xMv?=
 =?us-ascii?Q?nYSTEq8aQQhDMUZ1lr1wB8XjsZCLZDJRhXWUnbQWNcty9W7xDXYxFuO15SYL?=
 =?us-ascii?Q?4eFX74fu3Ic28wc73yJhBjZbOFnX5nwzMBWgd0PpcJ2h3KP2wF9j6NtI313Z?=
 =?us-ascii?Q?K1EMvVoHBb5tOq2m3abEBfwjpRBgyTK4tlTuN4xezW6R6CAnD6W4sTRQ/azh?=
 =?us-ascii?Q?7JrJJqVQ62tydEXTxNt5bLRHmJcSa63Vg8eZk9e1rt+vANjYrJe95xX0NZAW?=
 =?us-ascii?Q?esUz8XWQYJ1/cPH3whdvDga+XqlkDXUgXI5gLGVfVQNb57k31jH7BMPZv00n?=
 =?us-ascii?Q?u1dU8aEsE8y3kpVyD7BkecGXrmivmoNQ3psgf449gE78GgaAKZYNOtaXhdY4?=
 =?us-ascii?Q?lOR2ddiGh0ZFRQpgDK0mplWymJ3GifMLonANT3S7aULk+FvfpC3+ZDbqGTTm?=
 =?us-ascii?Q?4cIzmG1Fq60893oq7U9oOJvBEtk0Et+qKtUySWJLls0ZFu89NgU+iWqYEl8j?=
 =?us-ascii?Q?jgQj2CBTE7ca9pziQOAOZf467vnnGfy1jQgOv0rxSG8FTbuO2EzInLP33vv9?=
 =?us-ascii?Q?VQ3rIi+ut+cVvTNJw0rKiiKSWEksIvHQmCy0mDywJPSwmLMrgl3nH9fEoS2f?=
 =?us-ascii?Q?KILad5DPNKvrnNn/SET1s3jJzJPjMI9o/JVD3dozD3H5vH89cg9HRekknk/b?=
 =?us-ascii?Q?1GBgA6olG8I8GI6ekoUevliMlWrRiDqo1Xu01D5ZCnrGuAXfCgmP4dGdVgQR?=
 =?us-ascii?Q?Aj9jkp2Z9Qzgk74KtbQdXWpa0RdxmdEdcHVsZSAeXl+Fsh3mfe1VxY69MO/K?=
 =?us-ascii?Q?xbQhRtvzcuBKHOJbMWXfYaAsKvynBocrVteSrpJrHbsiTI8tBhcYdHMBnyoO?=
 =?us-ascii?Q?hETGX7fxN0AdxQ+6hEEaPJ3wXBciGN2T4ZausD3bRIons46R7c2W0q1x4O7y?=
 =?us-ascii?Q?iEQ0S0ZxI45wQFLMbXv8EMxCmUbZtghLR7QLawzad+cbL26bsyqjKiSIJiXr?=
 =?us-ascii?Q?bZS/ngGgDIei5ptUVKN2BMcuuJQH1T/qzbZf6CkeBse4J8Kemw8ieXN9UV47?=
 =?us-ascii?Q?UYm4Jcr7SK3A/K9l3ZtrN/u19KqG6clpZbLow8A7F7fuU8AsWlPyTjWmhQVh?=
 =?us-ascii?Q?H3qMRkJ+Mi7LYZK2NeyeYfwmjHpTOvIoHzzJmoQSXy88XHJq0glS3EYT978q?=
 =?us-ascii?Q?VelMmEcYK4CPoHcgcvGXO7UOOO2o7nywBYiLnvBT3mK/zsmqYm8jMIFT+pRm?=
 =?us-ascii?Q?MUsNmCgFYI4BkorNFeCf0k/zm1Sbv/q9M1S0kB/hvcHOJpxJnVWJoe+3Xm1K?=
 =?us-ascii?Q?TTWR2xtqXnjkpt8o4YBj2BzbipWErt79LMWRQ4XNdp2GZ2h4WsnUq72ftcbh?=
 =?us-ascii?Q?YH/CMplaowSCuhNIktG306fVBuQwg02vIbm6D614nuxsXGpn9ccdsB0AdwIw?=
 =?us-ascii?Q?lWCtFSVA0G69wNR84xrAkUBKyDw/PIuNITRQasl28imKRrqDFGh6UqsyBeWh?=
 =?us-ascii?Q?OT+p0xiRtlQgvPY1NPNisRh7962fMBYpiLQOW3YSHBiK15DHYzPN7KrmiqXt?=
 =?us-ascii?Q?p5IdsUYLSxEjrzJREB48FgyeiOfHKnM50egf4g/7rz+NvMkb9D0nc5MMaitO?=
 =?us-ascii?Q?u11DyLB8mKPtpHPd+vdBPM347RSVicX54WQTYXVYUTbxD9cj3taOiUs7L5xN?=
 =?us-ascii?Q?V061+hLlXRjSj1w4RvxLusxWKmxZxmk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <485166EBBF8A544683F493546D28761F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64defedc-8eb3-4ac2-0850-08da3cd2c165
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 15:41:51.1456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lVvSjziXk18VrmygSU/OsUYwy9JbPcqQXgdODQerbbXmaGqaCjlgPMmvM5VMGy6qFC+ZpruuyJnjXu7O4k+8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2115
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_06:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230088
X-Proofpoint-ORIG-GUID: -_9ZgxPwaSXHkKMYy5Q6aQMI_24A1nEz
X-Proofpoint-GUID: -_9ZgxPwaSXHkKMYy5Q6aQMI_24A1nEz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 23, 2022, at 11:26 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-05-23 at 15:00 +0000, Chuck Lever III wrote:
>>=20
>>> On May 23, 2022, at 9:40 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Sun, 2022-05-22 at 11:38 -0400, Chuck Lever wrote:
>>>> nfsd4_release_lockowner() holds clp->cl_lock when it calls
>>>> check_for_locks(). However, check_for_locks() calls nfsd_file_get()
>>>> / nfsd_file_put() to access the backing inode's flc_posix list, and
>>>> nfsd_file_put() can sleep if the inode was recently removed.
>>>>=20
>>>=20
>>> It might be good to add a might_sleep() to nfsd_file_put?
>>=20
>> I intend to include the patch you reviewed last week that
>> adds the might_sleep(), as part of this series.
>>=20
>>=20
>>>> Let's instead rely on the stateowner's reference count to gate
>>>> whether the release is permitted. This should be a reliable
>>>> indication of locks-in-use since file lock operations and
>>>> ->lm_get_owner take appropriate references, which are released
>>>> appropriately when file locks are removed.
>>>>=20
>>>> Reported-by: Dai Ngo <dai.ngo@oracle.com>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>> fs/nfsd/nfs4state.c |    9 +++------
>>>> 1 file changed, 3 insertions(+), 6 deletions(-)
>>>>=20
>>>> This might be a naive approach, but let's start with it.
>>>>=20
>>>> This passes light testing, but it's not clear how much our existing
>>>> fleet of tests exercises this area. I've locally built a couple of
>>>> pynfs tests (one is based on the one Dai posted last week) and they
>>>> pass too.
>>>>=20
>>>> I don't believe that FREE_STATEID needs the same simplification.
>>>>=20
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index a280256cbb03..b77894e668a4 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -7559,12 +7559,9 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>>>>=20
>>>> 		/* see if there are still any locks associated with it */
>>>> 		lo =3D lockowner(sop);
>>>> -		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
>>>> -			if (check_for_locks(stp->st_stid.sc_file, lo)) {
>>>> -				status =3D nfserr_locks_held;
>>>> -				spin_unlock(&clp->cl_lock);
>>>> -				return status;
>>>> -			}
>>>> +		if (atomic_read(&sop->so_count) > 1) {
>>>> +			spin_unlock(&clp->cl_lock);
>>>> +			return nfserr_locks_held;
>>>> 		}
>>>>=20
>>>> 		nfs4_get_stateowner(sop);
>>>>=20
>>>>=20
>>>=20
>>> lm_get_owner is called from locks_copy_conflock, so if someone else
>>> happens to be doing a LOCKT or F_GETLK call at the same time that
>>> RELEASE_LOCKOWNER gets called, then this may end up returning an error
>>> inappropriately.
>>=20
>> IMO releasing the lockowner while it's being used for _anything_
>> seems risky and surprising. If RELEASE_LOCKOWNER succeeds while
>> the client is still using the lockowner for any reason, a
>> subsequent error will occur if the client tries to use it again.
>> Heck, I can see the server failing in mid-COMPOUND with this kind
>> of race. Better I think to just leave the lockowner in place if
>> there's any ambiguity.
>>=20
>=20
> The problem here is not the client itself calling RELEASE_LOCKOWNER
> while it's still in use, but rather a different client altogether
> calling LOCKT (or a local process does a F_GETLK) on an inode where a
> lock is held by a client. The LOCKT gets a reference to it (for the
> conflock), while the client that has the lockowner releases the lock and
> then the lockowner while the refcount is still high.
>=20
> The race window for this is probably quite small, but I think it's
> theoretically possible. The point is that an elevated refcount on the
> lockowner doesn't necessarily mean that locks are actually being held by
> it.

Sure, I get that the lockowner's reference count is not 100%
reliable. The question is whether it's good enough.

We are looking for a mechanism that can simply count the number
of locks held by a lockowner. It sounds like you believe that
lm_get_owner / put_owner might not be a reliable way to do
that.


>> The spec language does not say RELEASE_LOCKOWNER must not return
>> LOCKS_HELD for other reasons, and it does say that there is no
>> choice of using another NFSERR value (RFC 7530 Section 13.2).
>>=20
>=20
> What recourse does the client have if this happens? It released all of
> its locks and tried to release the lockowner, but the server says "locks
> held". Should it just give up at that point? RELEASE_LOCKOWNER is a sort
> of a courtesy by the client, I suppose...

RELEASE_LOCKOWNER is a courtesy for the server. Most clients
ignore the return code IIUC.

So the hazard caused by this race would be a small resource
leak on the server that would go away once the client's lease
was purged.


>>> My guess is that that would be pretty hard to hit the
>>> timing right, but not impossible.
>>>=20
>>> What we may want to do is have the kernel do this check and only if it
>>> comes back >1 do the actual check for locks. That won't fix the origina=
l
>>> problem though.
>>>=20
>>> In other places in nfsd, we've plumbed in a dispose_list head and
>>> deferred the sleeping functions until the spinlock can be dropped. I
>>> haven't looked closely at whether that's possible here, but it may be a
>>> more reliable approach.
>>=20
>> That was proposed by Dai last week.
>>=20
>> https://lore.kernel.org/linux-nfs/1653079929-18283-1-git-send-email-dai.=
ngo@oracle.com/T/#u
>>=20
>> Trond pointed out that if two separate clients were releasing a
>> lockowner on the same inode, there is nothing that protects the
>> dispose_list, and it would get corrupted.
>>=20
>> https://lore.kernel.org/linux-nfs/31E87CEF-C83D-4FA8-A774-F2C389011FCE@o=
racle.com/T/#mf1fc1ae0503815c0a36ae75a95086c3eff892614
>>=20
>=20
> Yeah, that doesn't look like what's needed.
>=20
> What I was going to suggest is a nfsd_file_put variant that takes a
> list_head. If the refcount goes to zero and the thing ends up being
> unhashed, then you put it on the dispose list rather than doing the
> blocking operations, and then clean it up later.

Trond doesn't like that approach; see the e-mail thread.


> That said, nfsd_file_put has grown significantly in complexity over the
> years, so maybe that's not simple to do now.
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



