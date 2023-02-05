Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244FF68B10D
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Feb 2023 18:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBERGn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Feb 2023 12:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBERGm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Feb 2023 12:06:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3923199E8
        for <linux-nfs@vger.kernel.org>; Sun,  5 Feb 2023 09:06:41 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 315FlH3p015731;
        Sun, 5 Feb 2023 17:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OK27HEtcUJfkci6g7IzRh8/G0Vzhv4n6NtsqXkRF8X4=;
 b=mI1pXLWCpOUFjZOqPINf3Zb7+tsamwRZXB7RuzV0qAG6XhTHTEExdI40mZ/fsvFlegQI
 MHYCaDPq/zyVbV0w1vGTl/Zjj9mpO9qGdls0JvrfkQyDR3fBVCNko0fvr7pU2Zj36Kqo
 CW403vRwn/kZLKBu3vDCThmSd4nUGFn6iuYITJ9fq/s7FlwYioYQr0VbsswxsjaLNZfP
 H5qSlt8HOaD56UyaPzjzXRqEoyh3omfl92eX5nvFi0AnGhqk8ZGNLgGYDVhDg33URcQU
 S2cCHsiLPvQ2sUrbZ2wpiFjbPquGCsa2oW7419sOrU1AyYw5NvyyFBcB4jopQcKCjLdY nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9n9hrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Feb 2023 17:06:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 315FdBOB002369;
        Sun, 5 Feb 2023 17:06:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdta6ww8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Feb 2023 17:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er5SDdU2P5R7k0YMNFTJohub18uXhWK1CGDgkcXV7jnJih+4uFRqvro+DwSgzeb4kI6fEw42p1oZURtdZahEZbYBWdTCLF4+vmRo/rIxWDhdy8kd1fNRhvoA5MD2bTE/GUjjM7/gmUZeahX5LHagmPAahky0ZwB/Vpf7AnqDAc9MoLubCk0ZyTTO+zMQWgmMK9OjIYxiEXmPRLZeaUMra5arA6RYi6PB8nk7wC3B52DmHebxyj+8BnjNbYZhJKnwaRSQJAalvqLOyF7usG849lvsna0c2NIkzmtIkQvHcbv+Boyt1r778e4FUOvAbxrvukrQawmpJzb2xWKS85/vXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK27HEtcUJfkci6g7IzRh8/G0Vzhv4n6NtsqXkRF8X4=;
 b=XbXySSbxDXGD8Y49J3JFi9C3Em26v6UPp+75uMsk1566yg7V1o0QdqUOFAYqJsORVMph7xuKmTnhqERVMos79lht1DBxxJ6HyIRVToE8KbCLPLS8C1ZMzVXrpRLZrJ0geNeI39Bwf3pwzLvBDrg4sB+kKKceIkTPYHrMsUhkidzWIicErZUGPMa3P3UfhzgU2adMgnA4SZ+Yyhs2x9gWqsCYR9FnXe614rRg/OaxeYrZY2oANfXXDHjMUS3TdqBxpHLLnG2yfHUTzCT0/AdFL0TEAfdumSjEua+ntn2jIQZwZyj00LAPFX/zxG7oLKI3OFS1Wl0BzKr7koBch5iP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK27HEtcUJfkci6g7IzRh8/G0Vzhv4n6NtsqXkRF8X4=;
 b=Mlh8HHpelH8pCxmiM391w2NOOUoaE1KB1q8oJhlqEsxI1FjyPP0h4msG338BONUn+hb6VGdtEU/xcYbS8KEyGoGKDmY/tNAIrjqW3NobKvmzFctGDoG/mM+CnfVGZEt1iCdogM9+Gkq8UKE/utOwlUtOjtAJVLNhEKgbwOEDztU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.12; Sun, 5 Feb
 2023 17:06:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%4]) with mapi id 15.20.6086.014; Sun, 5 Feb 2023
 17:06:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        =?utf-8?B?5by15pm66Ku6?= <cc85nod@gmail.com>
Subject: Re: [PATCH] nfsd: fix courtesy client with deny mode handling in
 nfs4_upgrade_open
Thread-Topic: [PATCH] nfsd: fix courtesy client with deny mode handling in
 nfs4_upgrade_open
Thread-Index: AQHZN/vzN9JTANqrsUSg42Efwd8M+a6/RK8AgAFTvoA=
Date:   Sun, 5 Feb 2023 17:06:33 +0000
Message-ID: <EBA16208-62DB-47C7-82FB-766A95605C0E@oracle.com>
References: <20230203181834.58634-1-jlayton@kernel.org>
 <458a70c7-f5ba-4aea-158e-19f5a44d7a62@oracle.com>
In-Reply-To: <458a70c7-f5ba-4aea-158e-19f5a44d7a62@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6243:EE_
x-ms-office365-filtering-correlation-id: 5b3986e2-899e-416c-106c-08db079b5569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QL3FcxhoXWzYW6YzLOUQcDDfZPFkSm1GXk3XK13RHhicKKxiQXQfrpJXoeQPzfufI1/wyMWeOwJztLDD1woraKZJ/NNr2JKeSA5/Hiue/E2FU3qXMU5hy7qj7uwxpje9D+TKIVMI5NR/i15fusmeclTt3MUpWTbVo/MYfu+uTQrdcgZUZSBfgbZHetoLZ3sfLpUpvvVYyHMeh4IVp9BWuNNv9ulDIBhKrt7VnZJoUtIPXTFIz95iPfbhDVLciK4sQtNO5W1whDRxuHYLrNrdVgJ2a9dsw6NZDFshIvszYCK5sfNCesyLl53xnUG9v8OLZmFt91zirUXLnhRcsKVxYjOc7XQDdyPVnEQRQW66Jx4/MXghNpizcZDFSdhaAJBusASvxy6a22h25q9nF6Vq9rNjHuq92zKOQw4ItyVuXw3SNLyT2WAXavoVLbcR6zsA8UZbFNeYX4Z2X0uh+3Mmt1+qhXEqHIDbuTDl3BLhapjl4IpEDB/glC/iSv7M1QNmCvXzYFOn4O4WDn3gSj7axn5DQ2ze+3b/Qt099GlS1cRkJrc9twZik/w22xdLRhk68KfTygjui7RoIHJV/kzOZlckIAZfeLw8/pC6h7mWShkA/0ga1XHLLbxiFusnP08OaUiOQ52DQiZJFw4pQ57AvJSEwtAobHCtY9WSYCWUprLHdOXjevOnJemHVLMFlgh4dACqWrqEslBqH45gp6ytjjtIc5mARi3mZDUIjcRDWpk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199018)(5660300002)(8936002)(8676002)(76116006)(66446008)(91956017)(4326008)(64756008)(66946007)(66476007)(66556008)(110136005)(36756003)(54906003)(71200400001)(316002)(83380400001)(33656002)(2616005)(41300700001)(478600001)(86362001)(6486002)(26005)(53546011)(186003)(6506007)(6512007)(122000001)(2906002)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWx4T3Nib3RZOU0zTEFlZnhTZFgzK0hZRXlURGhiS2FqbjVYUFJWdlFJRG9K?=
 =?utf-8?B?U2YwR25JcDJjOFlZbDZGQ0c2djNIcHk2SDNwSGhNMTA0MWVFd01NMW42Zjlr?=
 =?utf-8?B?T0tOaU1BV080Z1JKK2Z2VFVMUE9NeXdVWjZnWnR5SzNuMW9DQnd4SHpneDNv?=
 =?utf-8?B?eVQ0ekprZWN2b2hqdHVhVjBFRFNLWHMxV055YWg5RytLTnZORUxiS09sdFNT?=
 =?utf-8?B?ZlBoSnR5Ui9ZVlEwT0xBVmdCaDB4YURrRnJsT1FCUitRNEVwT3ZGNlJ3eHJ2?=
 =?utf-8?B?L3dKT2w1S2xIUDJPQVp5TEYxMTVva3p0YWRyUDBwUC9Wc3NQV0pPZ0k1YTda?=
 =?utf-8?B?OG5ySS9WTDlBVWExd0c2SGhmNzVNVkVsMzVzdnlGdWd5bUgxVU1rRGZEUFRO?=
 =?utf-8?B?dDJDN3l1RkQ0REF2NUtKUm44Q25JYXBLeGJjM21LTHVpUFl2Rmt1YlQvTkxr?=
 =?utf-8?B?TEEyZ0hNQlBCUjVaTWR0MHNaYUFtOW9jSDBxelJWQUg1SW43bUJBTHM1TWpS?=
 =?utf-8?B?OGZQWWIydEtLcGZlVDgyajNrdDJOMXM4UXdHNm1WUGVTbkhxdjRjV21EamZy?=
 =?utf-8?B?TG9yVWZ2aU0rTGxGYVErTGFtd3NOZ3hCRkRZNWY1djNSNzIyeUl0N1FWSWdN?=
 =?utf-8?B?UklNMU9xd0JONklweDdCQXl6RDVTaHVQTjNZQWoyS2h0aE5KWGFaKzZCM1pC?=
 =?utf-8?B?QXVySXc0bUdpYllhRGpuQTRpaFZNbkZsdEpmR0xDbDlSdkJGSU9hWndyNU9U?=
 =?utf-8?B?bnlnUGY4eFhIcCsxMlhCOTlteitjdkc4ck5oYjdwbWxuU3RNa0t1Q0xKK0JN?=
 =?utf-8?B?NkJrT0pPanhhbmN5dHE4VGVRaDVIbVY4L3dBRW4wWXFlZVV6bVQrSEI3ejlB?=
 =?utf-8?B?bi9SbEZNeGRheURBUml5TC9jdFRHVGxFeHBOanZXbEVHK2E2QzV0WStPNkRR?=
 =?utf-8?B?ZFJpQkZQODYwc1JPcGUyOHVZdXovYzRva08yTHdUeVBSRjFlV3BwNUNtRktL?=
 =?utf-8?B?U0FjY0RmckRYRVFVS0dncXJieDkzdm9BemFhaUV5MlN4bjJYdHZnUDNwOFVl?=
 =?utf-8?B?UGxtREwyRVk4SXJhSWtLT1hEOFZHVUUvL21KUmFLZ0ZvSnJuOVRpTXpITVB1?=
 =?utf-8?B?M3lDMWRQQVRrRDd6VmlBMVVpRTlEQWRCbFNScVI3dUp4Z1NzRkEzSW1FRWcr?=
 =?utf-8?B?N3J1eU1WTjA0eWtUZThjZjVsOFpTdEpxZkZraXNMU01aVUVmOHVBQmt6YjlC?=
 =?utf-8?B?clFUcElBYXNTUlB2d0IxMFIzVVhtMHg2ZVU1T2dEWXRBUnNVS3lVVzlmMzdP?=
 =?utf-8?B?UXRVSC9UOHpISHVlTEdOR0E2UzZ0Z2dEQk10Slp3ejdjY3JwbDhzQnFsUy9W?=
 =?utf-8?B?V05uVlVFMkdOTkZqbm1kbWJPQ3FqOHd4QnhYTVpVK3hvSTZpbWpDK3lnTzRM?=
 =?utf-8?B?d3R4b3JyaTZSV0lhaU9La3l4Q0ZRempWUlNROHg1emc5OXEzV1dlMDN1STVO?=
 =?utf-8?B?ZDV2dGFKY1JNaFlIWnJLYVNCMkZrZFQyNndjQlIzYmF6ajhSLzlKMjZLdERq?=
 =?utf-8?B?T1E5QzUxZEJHOGtsbjRHbzFVVGlGNDh1NVdXZkk5bTZXcm9kUU40TGFKdmN1?=
 =?utf-8?B?TzJvaTBmelpUSGluQTNBZ20wU0lhZGhteGphTUcxS0xIdTYrd0x4WS9TNURN?=
 =?utf-8?B?a3kra1VybFI3YS9aVFZsWUJ1NzJBQjVWMXpBTEsxMERJWnZIRXFZMkdPeEE2?=
 =?utf-8?B?WkhPRm9nMEpYVzd1Z2FCYW5td1J0WGRWN28xYTBrOVpKem1oTHRrOHlRODEv?=
 =?utf-8?B?ZC9zUFNHeGg3d1FYdm5YU0NCbkFHa0ZWODcvL2dPWXF5eUM5SU9paGNQZk4w?=
 =?utf-8?B?S3RJdmI4eVh4UW1Telc2elYzdzJkYUxXYlUwbEFEMjdsVFJ4VTdXL01ORTJ1?=
 =?utf-8?B?R0Vmd0tUb0Vabk9MSzFFU1EzMnViRVFuTHBLVEFyWGVMeDBUSEVqYWJHVk5J?=
 =?utf-8?B?YnNNSVNMMFZXQkhueUZkbU80MmVpVkswSXBYMTVQVlRCS0VDeWRTbG9zRnY1?=
 =?utf-8?B?NmhrelFiRVNRYzBjaFBhZWRJU2pDKzY2ZXBGUjFwdHdLUjJvL2FTaFV2MU9B?=
 =?utf-8?B?QUtwYXpjUXdkb0JabUEvTFc5M3N0RE4zSGNkZW04SlZHMS90bko1elozUmhG?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C378BD2D1746654DB05898FB43F97D51@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V8jHgjXpewvIZLT1ZIaQ5qR9foK2iX650DRUpLDHe1XvPUNaBxyMbtXZM3YB55fyWkfqOoXZ7nQgt+otf/rXLnn+exh5aZUs4vhcNSMgK+A43MX4hRnAfV/0FxQKecanemU5UDbI4HUY4ycLxJv2meJwCdSIFRSjnE+4nXhGHcHW7vKZ88AMcB+dk89PsPGPznp9d932HbOadyeQyDgOScYv7C+hv4bRjulfatVxgWmZMTh7H1uD1b/PwgJOjh9O5DBD+hUy2GFnInJLbKlbQeSPMwKfkPFCc80+2tUlVQMbB8RUvqNVHGwgqnJHIxQjGf41QYzh/vD9zJb58q09qvylTRjajE/YtnpkUA24dqm87qP9vh95DrbtzeTgmZ8i3OA/yavnVLbvc8FPl/+BQg+zUH/48HLJEt99kRP8EFvCe3g+ng8lBISCDaxwiDR2B0lzSpyx6/MuqMsRsr1k/ZFp95Eqo6FgXb7DedW6Ejkz34dBUCPyrm/R2oRLuuhf8puR328KLeHaNtsOEYAVaB4ZHwN52xCIGXj5sGNNuCbaOWwE2EW3DSv0G7ym0B35ZJ1rE2lf8DATIYLqN6Xp0qS+LW35a0L4Hj5NmuD7n5Vsgi7z1PtkE2yB2iW2zZpLLQpFt+BXVR2fEs0uCnyO+LVxB+UlIHEHGODukhrICdGXMhaT7TRoUsOaSqjVTazQPUuYrYxyz+1F8uEIbIGedynvtBEyynR2F+zxbk2sNuC1RKh6dsZRSlogWoeuFgMxDDk+qOEdXNCtTGXbSdqKiCHXN5CojpkKvSxmyAWK8AY2U9iJs0jXxgxB/x9R4SSW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3986e2-899e-416c-106c-08db079b5569
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2023 17:06:33.7175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xm6jnVDmxgtTi6JKpUTeXbwxhWCmYRUefH6f8br1O1z+DKau0eT6oBiExZV5wzlz8fkZwBuV3KnysAhH0w5bog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-05_04,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302050148
X-Proofpoint-ORIG-GUID: sSm1X_Y0GkQk-7EoMhstA0hRiLJxOh2j
X-Proofpoint-GUID: sSm1X_Y0GkQk-7EoMhstA0hRiLJxOh2j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRmViIDQsIDIwMjMsIGF0IDM6NTAgUE0sIERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xl
LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gT24gMi8zLzIzIDEwOjE4IEFNLCBKZWZmIExheXRvbiB3
cm90ZToNCj4+IFRoZSBuZXN0ZWQgaWYgc3RhdGVtZW50cyBoZXJlIG1ha2Ugbm8gc2Vuc2UsIGFz
IHlvdSBjYW4gbmV2ZXIgcmVhY2gNCj4+ICJlbHNlIiBicmFuY2ggaW4gdGhlIG5lc3RlZCBzdGF0
ZW1lbnQuIEZpeCB0aGUgZXJyb3IgaGFuZGxpbmcgZm9yDQo+PiB3aGVuIHRoZXJlIGlzIGEgY291
cnRlc3kgY2xpZW50IHRoYXQgaG9sZHMgYSBjb25mbGljdGluZyBkZW55IG1vZGUuDQo+PiANCj4+
IEZpeGVzOiAzZDY5NDI3MTUxODA2IChORlNEOiBhZGQgc3VwcG9ydCBmb3Igc2hhcmUgcmVzZXJ2
YXRpb24gY29uZmxpY3QgdG8gY291cnRlb3VzIHNlcnZlcikNCj4+IFJlcG9ydGVkLWJ5OiDlvLXm
mbroq7ogPGNjODVub2RAZ21haWwuY29tPg0KPj4gQ2M6IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xl
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+
DQo+PiAtLS0NCj4+ICBmcy9uZnNkL25mczRzdGF0ZS5jIHwgMjEgKysrKysrKysrKystLS0tLS0t
LS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygt
KQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZz
NHN0YXRlLmMNCj4+IGluZGV4IGMzOWU0Mzc0MmRkNi4uYWYyMmRmZGM2ZmNjIDEwMDY0NA0KPj4g
LS0tIGEvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4gKysrIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0K
Pj4gQEAgLTUyODIsMTYgKzUyODIsMTcgQEAgbmZzNF91cGdyYWRlX29wZW4oc3RydWN0IHN2Y19y
cXN0ICpycXN0cCwgc3RydWN0IG5mczRfZmlsZSAqZnAsDQo+PiAgCS8qIHRlc3QgYW5kIHNldCBk
ZW55IG1vZGUgKi8NCj4+ICAJc3Bpbl9sb2NrKCZmcC0+ZmlfbG9jayk7DQo+PiAgCXN0YXR1cyA9
IG5mczRfZmlsZV9jaGVja19kZW55KGZwLCBvcGVuLT5vcF9zaGFyZV9kZW55KTsNCj4+IC0JaWYg
KHN0YXR1cyA9PSBuZnNfb2spIHsNCj4+IC0JCWlmIChzdGF0dXMgIT0gbmZzZXJyX3NoYXJlX2Rl
bmllZCkgew0KPj4gLQkJCXNldF9kZW55KG9wZW4tPm9wX3NoYXJlX2RlbnksIHN0cCk7DQo+PiAt
CQkJZnAtPmZpX3NoYXJlX2RlbnkgfD0NCj4+IC0JCQkJKG9wZW4tPm9wX3NoYXJlX2RlbnkgJiBO
RlM0X1NIQVJFX0RFTllfQk9USCk7DQo+PiAtCQl9IGVsc2Ugew0KPj4gLQkJCWlmIChuZnM0X3Jl
c29sdmVfZGVueV9jb25mbGljdHNfbG9ja2VkKGZwLCBmYWxzZSwNCj4+IC0JCQkJCXN0cCwgb3Bl
bi0+b3Bfc2hhcmVfZGVueSwgZmFsc2UpKQ0KPj4gLQkJCQlzdGF0dXMgPSBuZnNlcnJfanVrZWJv
eDsNCj4+IC0JCX0NCj4+ICsJc3dpdGNoIChzdGF0dXMpIHsNCj4+ICsJY2FzZSBuZnNfb2s6DQo+
PiArCQlzZXRfZGVueShvcGVuLT5vcF9zaGFyZV9kZW55LCBzdHApOw0KPj4gKwkJZnAtPmZpX3No
YXJlX2RlbnkgfD0NCj4+ICsJCQkob3Blbi0+b3Bfc2hhcmVfZGVueSAmIE5GUzRfU0hBUkVfREVO
WV9CT1RIKTsNCj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIG5mc2Vycl9zaGFyZV9kZW5pZWQ6DQo+
PiArCQlpZiAobmZzNF9yZXNvbHZlX2RlbnlfY29uZmxpY3RzX2xvY2tlZChmcCwgZmFsc2UsDQo+
PiArCQkJCXN0cCwgb3Blbi0+b3Bfc2hhcmVfZGVueSwgZmFsc2UpKQ0KPj4gKwkJCXN0YXR1cyA9
IG5mc2Vycl9qdWtlYm94Ow0KPj4gKwkJYnJlYWs7DQo+PiAgCX0NCj4+ICAJc3Bpbl91bmxvY2so
JmZwLT5maV9sb2NrKTsNCj4gDQo+IFJldmlld2VkLWJ5OiBEYWkgTmdvIDxkYWkubmdvQG9yYWNs
ZS5jb20+DQoNClRoYW5rcyEgQXBwbGllZCB0byBuZnNkLW5leHQuDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg0K
