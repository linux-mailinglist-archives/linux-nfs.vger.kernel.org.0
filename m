Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853077F012E
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjKRQmM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 11:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRQmL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 11:42:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD3C1
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 08:42:07 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIGYUbV018702;
        Sat, 18 Nov 2023 16:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SsVCHgT+eo5Afy6xHg8NjaYvoXt1DAiIBt40XrJhe68=;
 b=K+ho7/d1kdCEKEXld9ZX6tM6Z7yXfWuQVwEhVZ8zuDhL/4VWYm2CHTeOFNt4ia6PFnD9
 l8SYk5X+k/UMijnrFRA+tUaIjJYIJeWS1e78AC53TgVeAD4gg1eRlwAwECcj0FBbOqrX
 9PJg5/Br0IFxM1ETazCIAHMiqFOaYgYb1IGPf9ab+/qwBqSe8GvQVQ1w5NvHUg5vgkJx
 b4eKabGs3M14dClhyvgI0ks1rxBLi/ql4u02nDjid+iEzNjUG9tXUSSI8gqHKWp23D5j
 wTsCCjrTIaWF+ti139Qyji9wYGmlc2NZm7lyfGtlUyuvpEMmvDQHGc1bFJODpQz+MoYf eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpegj69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 16:42:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AICRfhp022624;
        Sat, 18 Nov 2023 16:42:02 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq3bwyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 16:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je5QWyqBVL6tsPtx19xcxQqC2pjADQzcgybhfMR2/XM+NwJHCWuGbui9PDS1AiMU8CLHzPzjQLN9S5db4cBVUYbyzEtpeEpcdGdG2XvaDnPUNSu7K0DsW/u1NqmQhuu9/SuRjEAwNDRekJSppvhcooRMz+c3ySEAy7efljryPubaEAWy/4W07s45zL4rg69sjQLMLnnfjsJ0RYk+rVuMUjGH8/w6Tan3oL+SpRPdV7BDPd10qhp4ZKv8JqeMhMoVqlIw/4Zu291da6+2WmkPAovA/BVQpCmLl7ZZQmYj1fPlRhl+fc1zENYqqaMSGNZn2dAFW8Yv6HpzvY1nMHpyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsVCHgT+eo5Afy6xHg8NjaYvoXt1DAiIBt40XrJhe68=;
 b=CWy9Bh0L5xrZzX3DuqwHZRa6Fo/GczDSKpLoY7NucGTEpqf32jHj9yGOjj483ftqgEPScNWFOLoyfY27fEUpWYTS/Te8uab5uZgypxrtlkDKdkWyVhSUR+nf67kdFglgmLxP4LsbgyJ0JzQveUghcpze8Y2ANVkqJdZw8+S7EjTWWrD9GyLYVhF/7GhZGGe6Mt0jfAKdUTnWZidNmb+JcFgpcrMR8hkc0xzBikMjbCmjzGpIlklPCs/qgDEpjN7DXun6ExoHkgy1/kpbNJhP49Zg/NuR3lG0l6fnMx/trb2mDYksHYQxsJvasXJKUrGm9uG6zNflOJolfKuzm/buIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsVCHgT+eo5Afy6xHg8NjaYvoXt1DAiIBt40XrJhe68=;
 b=r/Dc0WNZRn3mYAuJiADnjyc0FX041S6ozQ21fS8lOKRktR+UN31ZvFARpiT9aFlhTsp7R7oPfF/0vEpPkyAXsSPmYA0yj1xU91/PfYFs0yUzfwjHS6PMGHoFWQauH27c+X0VFUxBxDRe0XqTxhUuvf8hV9zHyHSCy6r8FC8spqw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6188.namprd10.prod.outlook.com (2603:10b6:208:3bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 16:42:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.026; Sat, 18 Nov 2023
 16:41:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Cedric Blancher <cedric.blancher@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSnEPMpWeNwF5UG1EZJYD3+ecbB/omOAgACniYA=
Date:   Sat, 18 Nov 2023 16:41:59 +0000
Message-ID: <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
In-Reply-To: <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6188:EE_
x-ms-office365-filtering-correlation-id: 819e43e0-0df0-4c68-ed74-08dbe85548f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6b6xvDad77CSNqmq52BWgAz+6Zt2rB/JDoNJY38UhOmN+9/dLzeFF/+6YrrvRFeq76qbAfiQhHTqG5jyk4kWFHi9z0fO3fNMPqsdySsGmcf4KDa0+UQRy9f5Q6gqlCe2z9KK7YUZ4pNB/C7zX8vmGjmeVuE6p2t+xe2T6wzWq6sP8byYTQwYJ9oUkuJGDZ5ocIGgllbeas/Cer9rafx/kvprKMY39LYZyu6bdsz/vP6++phUw2hsj9NaYEb1M8uW6+hOA/4+HEaeVJmB99HM/sF9569qPw4xsbxEqkjbiVS5sW/KYcTwJnxSLaE8wyNEOoJoBbz5wHwSBYVYUeXEXGgBR1bWs7DUPwtQ9T4Ai2gxfRdAXIB1rPPPFsMTpy3bygXiJDA0HiOls1635geQwrkJDezRLl6QL1DG21pd9dpmhTmna8MtWS6MJjz2pmGSJJ5OyXAr/EN/emMolDc0Xqn0EnE0aktT838xTdu5oqEVoZt18Ri1nX8bsgl9VWVQ1tdqDhp3/O5WK+j+eXSlZoWfP0PbuYtPmB9BbEdBmSPMKJ+aLN9zb6maoda7crtpIAB+48N2c/+zrPXcT4KUBZ+oDXqHLip04alToKd/6YtyhF19k0ZyFgtKQQZbvkfyQ9o3vyDIQ1Tn9Jl1xkqtFc4HksscfZHAM1TspARCxVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(122000001)(38100700002)(478600001)(38070700009)(966005)(6486002)(71200400001)(41300700001)(8936002)(8676002)(4326008)(2906002)(64756008)(15650500001)(66446008)(66476007)(66946007)(316002)(76116006)(5660300002)(66556008)(91956017)(110136005)(26005)(83380400001)(6512007)(53546011)(6506007)(2616005)(86362001)(33656002)(43043002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUdVYlB4VFBmcDhtTW0wUW5POWxYc2FmYWo2L0w4UGRIY0Z4anZleDRXc3hV?=
 =?utf-8?B?US82d285NzNseGZNQ0NrVmlGc1pEYjZadXVTeUM2T1g2MGt6NXdPc3VRVnlR?=
 =?utf-8?B?K0FCSFpzYTQyTnRRMi9lQnpESGl1RGdEMVNFdGpQa0NsODBVeW9MRHplOVAx?=
 =?utf-8?B?TmtncEtxVlF4YlZGZ3BPS0JBN1gzTVVGT3BBSmpmVzdKY0gvT3VZU0gzYUZ2?=
 =?utf-8?B?TXVyV0ZPZ1VCNXJVdkhUYjlzZi90cmluOGhPSmlRTllBRDNlOHVBa3pzbUpq?=
 =?utf-8?B?OGJVcFY4SVQrQUpmVWtVTFB5bFRNWXYxcFE4MENEUjN2R3ZmQStOT3ZqUTh2?=
 =?utf-8?B?bndqTUhXSkRRRmdGZFo0Q1pTaEo4YUFkYkRQYlo1SzNMcGpNNnJ0YUtCL0cy?=
 =?utf-8?B?bzdPTU1GQzdDVHZjaVZ4WVNybFhORFFQTXVXOGNvSTFvSk5ZWkxiVjg4R0Va?=
 =?utf-8?B?Sk9McGROMGNLckFhVjRwSXp0QVZkb2VQSHh1VFVNbERkcXV3K2ExRVJtUVFG?=
 =?utf-8?B?SkM2UTlFelBwVExVek54TlhvS0hubWgwQ0h4UEhLU3R4RDM4anExM1diVlZR?=
 =?utf-8?B?S2tETDhjeVEyZTdKMWZwcEU0UHlaanVpTVcyYWdSWGZDRWZvdzZ4Ni9pME9K?=
 =?utf-8?B?SGFYMTdNR3BNeVNvYTZ0SmR4YzkrUFFwQnRoYTA0OFAvQWRGcUNSVndBTG5q?=
 =?utf-8?B?Rm1pQkdzUTFQODdEWU5JdUdYV2hCYWVISlRvU1l5cTJSaW8vRC9qbmFFRGdo?=
 =?utf-8?B?SXNUc3pqUEREelhLVGI4eGpwUThpZzR0c0lXalk4UUlTVWk2TXdaVkEyMlBT?=
 =?utf-8?B?SlFocUhVeUlBYThWSEZzZmJSWE9yU1VQM1Z3Y2ZsM1QzTWgrVWNhM2QwWm5B?=
 =?utf-8?B?OTlWQ0ZPcmQ3YWhsLzM5SHA1WEVNTjlhbUV4Rk0vSnlJY0pJQzVkcUVEWFpw?=
 =?utf-8?B?aW1PaVhpb2cvTHdsaWlmWlBuOHdKd3dQTzVhK3hMQnhYYlJWS1FGTWZZcU95?=
 =?utf-8?B?eGNRcG12dm1lQ1prQ25hcEtjOUpIdlhXN0EraUVSNUw1UUkya1BrY09zeDZr?=
 =?utf-8?B?VWM1NmZ2ZmR2R09lb2VhZnF3Q0JQYWFic1Fac3VxdjNrSWVlbnhaYTJpYjZz?=
 =?utf-8?B?N3N0bzVBN2pQVDI1bVFCVVJiN2pLRld4ejl6am5sbjg5WUt0WGhGYzZOSlFa?=
 =?utf-8?B?K1BPSHF2NmowSmFmU29PQzFrenpTVEZiODFwS1VyYnRFNEttTEVhUklhVnpR?=
 =?utf-8?B?aGJ5T09NVXpsWWFMUlhZSkVNdmdIRGExSUlsK3JYeUsyNUdtVndQblR6SDZi?=
 =?utf-8?B?L2RBcGp2aGQvY0x0L0tLeVhqcWQwOXMwbTRmRlhlNmtiNldsZGFrSWs4Tnds?=
 =?utf-8?B?b2l3dU1GbzRsRDRDT3dKendmRUpRSXkzbGZWcUU2dGxrWGNKYWRyZE4yRDhD?=
 =?utf-8?B?UWtNdGhNTVJqMkpieFlTdEs1M1MwOVgyb3ErckhpWElIeWM2YnF2aVBWSmdK?=
 =?utf-8?B?K0NCbzNiMWM2L01HaURFNWRpSWNGdFhYS0MrcXdFZnBjbHFKOGVrUHFsdlFv?=
 =?utf-8?B?S2NEOXZvSDFPMEJldlF0WGxlU2ZzbDVQb05WUitpSjlPZTlsMEtyNC9ENUJr?=
 =?utf-8?B?SSsrVk0yV0EvUkZaZ1BrbDBZblBxMEMyeXRrc0ova2IzYk9WTElEcFBaRXp6?=
 =?utf-8?B?RWRtWHQyNERnK2JXYnMxS2xtVzlCNDR4dlFFR2VXMXR1ZjJ3ejBBSStwWFlm?=
 =?utf-8?B?eHdIb0hpVjVlcmEwNTNsVVdEWk5veml2bUVwWkFxbHlOMG4rVkZPbEJzbDY3?=
 =?utf-8?B?WUJtV1ZDY3pJUVBORUN0SVZZNlZNQWVRdU5ZeFpySG9iTXByUDY0U1FqU0Z2?=
 =?utf-8?B?V3hRSnhmQ05BTEpOendlYzNQT0dzMlozS0hoTmN6T0NrVE1OS1dLaTluZ3gx?=
 =?utf-8?B?NWhMYmVVd1dFR2FTWmJWVWpwKzBiY1dVQURjWUFMd0c5RWZYc1orMjdUQTgv?=
 =?utf-8?B?VXo1S1h4WlpwYkI1bVpURWJTR2REREFvQjNzNjQ1ekZiMC83M0xzRlZQT2hq?=
 =?utf-8?B?YzJJcmFwR0Y0OTlkWVN3bkc5NXF5M3JGME5mS3RyR2pKWFVrYVRpTXhQckVP?=
 =?utf-8?B?YzREaUF6aU9nUEZDSVo1TGZzRStyZTZKaW1US09UWk12WDUyV3ljWHVXbXVw?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <073BB2C78EE1854A8E88F06CE5DB3E1E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QgVeoN17sD/zQNDNfP6nEk3gxfHCJOPsu/XWq9gMeSBBqg90E63Mcl/m+fHzZs9hmJSynIfyOopKv4CGChqib1znHJmomMsQn+J6Y7JOnfX+Fes59gNvACsF4UolOafHaS634vntvFv+Uz77hDyfSI1rfd4tdSUQIz+VeN8x8SJfdpQWd/8rh4Kmgyyum9+xJxqR3u4x9qJoIpA/w6p4YRRC4n3hzv2Q6dNv+1yRH0+rtYsfy38MKP58sxmMsMq+8zXiLcCi5kygFCF0NlKept+UA2oeB/TlIU6K2nnskigAbNSa/EW4zF/pyMeQtb+REk5emv1JnYI1Y+FsW6tIXrd7jBHx2R8NXucGRGMnoEIs95iOi97cWPpu+L83n+UYWxoz0yB7ZAbgM/3W7aUb54af8uZ/aFGT3jUzdN0AHg4FoD5/V77mdMcjsFK8K8y9xQEECfYS747R+96Bp67f/s8pe0/fHd5oAnLEPxil4mueNNeigvi/IN3mRMZQ72Oi78lrlcz40EYNM+b584ZYDwt4QARHYvxLZm79o7gDG4RAl74E74DE/hX53lBXZcf41oMmkLtVlfSIPtPiT4Us6bLrrl12P7TwLatAFHF2pd9Dd9aplaj7lQkdZBfWvqBUmzsosYfyIQOlj8b09v+i4XnmvwjWRl3b1Bthya8v5zMlJxwCnOsBumkxgW5B45yEpLen5JkAZ4ELAf5OuFxT0FnmURc1Kd/hTEQXT3h0RFcO3f6jmy7L62DtDOU21/iOQhxUIyn2sumZ8fGQJhWapDTWr5dIcQJ0HVpMDCjIOzMvs/na083WQkpJ/y2plBa5GlEKEhCWNH7njHhtw1hczw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819e43e0-0df0-4c68-ed74-08dbe85548f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 16:41:59.6248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipAlcoS8pEW8xQ9FNeAg9Z1sG1y+B8O3/7xre/pTJMZSldoLPjhAVVIdWl4G5I0Idxxepx3fknNgpG8hFrcV6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311180127
X-Proofpoint-GUID: KGHDi3kVL9foZPb0_RstYbORdmtZonP0
X-Proofpoint-ORIG-GUID: KGHDi3kVL9foZPb0_RstYbORdmtZonP0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE4LCAyMDIzLCBhdCAxOjQy4oCvQU0sIENlZHJpYyBCbGFuY2hlciA8Y2Vk
cmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIDE3IE5vdiAyMDIz
IGF0IDA4OjQyLCBDZWRyaWMgQmxhbmNoZXIgPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdy
b3RlOg0KPj4gDQo+PiBIb3cgb3ducyBidWd6aWxsYS5saW51eC1uZnMub3JnPw0KPiANCj4gQXBv
bG9naWVzIGZvciB0aGUgdHlwZSwgaXQgc2hvdWxkIGJlICJ3aG8iLCBub3QgImhvdyIuDQo+IA0K
PiBCdXQgdGhlIHByb2JsZW0gcmVtYWlucywgSSBzdGlsbCBkaWQgbm90IGdldCBhbiBhY2NvdW50
IGNyZWF0aW9uIHRva2VuDQo+IHZpYSBlbWFpbCBmb3IgKkFOWSogb2YgbXkgZW1haWwgYWRkcmVz
c2VzLiBJdCBhcHBlYXJzIGFjY291bnQgY3JlYXRpb24NCj4gaXMgYnJva2VuLg0KDQpUcm9uZCBv
d25zIGl0LiBCdXQgaGUncyBhbHJlYWR5IHNob3dlZCBtZSB0aGUgU01UUCBsb2cgZnJvbQ0KU3Vu
ZGF5IG5pZ2h0OiBhIHRva2VuIHdhcyBzZW50IG91dC4gSGF2ZSB5b3UgY2hlY2tlZCB5b3VyDQpz
cGFtIGZvbGRlcnM/DQoNCg0KDQo+PiAtLS0tLS0tLS0tIEZvcndhcmRlZCBtZXNzYWdlIC0tLS0t
LS0tLQ0KPj4gRnJvbTogPGJ1Z3ppbGxhLWRhZW1vbkBrZXJuZWwub3JnPg0KPj4gRGF0ZTogRnJp
LCAxNyBOb3YgMjAyMyBhdCAwODo0MQ0KPj4gU3ViamVjdDogW0J1ZyAyMTgxMzhdIE5GU3Y0IHJl
ZmVycmFscyAtIG5vIHdheSB0byBkZWZpbmUgY3VzdG9tDQo+PiAobm9uLTIwNDkpIHBvcnQgbnVt
YmVycyBmb3IgcmVmZXJyYWxzDQo+PiBUbzogPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+DQo+
PiANCj4+IA0KPj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0y
MTgxMzgNCj4+IA0KPj4gLS0tIENvbW1lbnQgIzIgZnJvbSBDZWRyaWMgQmxhbmNoZXIgKGNlZHJp
Yy5ibGFuY2hlckBnbWFpbC5jb20pIC0tLQ0KPj4gSSBjYW5ub3QgYWNjZXNzIGJ1Z3ppbGxhLmxp
bnV4LW5mcy5vcmcsIGl0IGl0IGRvZXMgbm90IHNlbmQgYSAiYWNjb3VudA0KPj4gdmVyaWZpY2F0
aW9uIHRva2VuIGVtYWlsIiB0byBtZS4NCj4+IA0KPj4gLS0NCj4+IFlvdSBtYXkgcmVwbHkgdG8g
dGhpcyBlbWFpbCB0byBhZGQgYSBjb21tZW50Lg0KPj4gDQo+PiBZb3UgYXJlIHJlY2VpdmluZyB0
aGlzIG1haWwgYmVjYXVzZToNCj4+IFlvdSBhcmUgb24gdGhlIENDIGxpc3QgZm9yIHRoZSBidWcu
DQo+PiBZb3UgcmVwb3J0ZWQgdGhlIGJ1Zy4NCj4+IA0KPj4gDQo+PiAtLQ0KPj4gQ2VkcmljIEJs
YW5jaGVyIDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29tPg0KPj4gW2h0dHBzOi8vcGx1cy5nb29n
bGUuY29tL3UvMC8rQ2VkcmljQmxhbmNoZXIvXQ0KPj4gSW5zdGl0dXRlIFBhc3RldXINCj4gDQo+
IA0KPiANCj4gLS0gDQo+IENlZHJpYyBCbGFuY2hlciA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNv
bT4NCj4gW2h0dHBzOi8vcGx1cy5nb29nbGUuY29tL3UvMC8rQ2VkcmljQmxhbmNoZXIvXQ0KPiBJ
bnN0aXR1dGUgUGFzdGV1cg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
