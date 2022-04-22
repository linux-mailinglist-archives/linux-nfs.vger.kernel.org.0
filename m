Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3517150BB21
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Apr 2022 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449229AbiDVPGO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Apr 2022 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449236AbiDVPGI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Apr 2022 11:06:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE365D1BC
        for <linux-nfs@vger.kernel.org>; Fri, 22 Apr 2022 08:03:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MEU5Ft009567;
        Fri, 22 Apr 2022 15:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vQdsfUd7vPrmmDRiiBWfOU5K3yuSFTz/t65j6Fb6hXk=;
 b=Tp1Y5Le3oJ4mtBSOMOnOqqPazIWDm/w8yTnqST803rO9nj4rCNoOmRwpFg2kOfQPKpTh
 9ICyiqo3C6Jag4d5OQONbE1CNA21OLgQv10DLFVLD3GR6XsfaQAJ/azUGgCrlvoEjwq3
 FwIPUSioa9sJeOaC8+Nmh7OylGramqiHdOewDwH4vTHW0mCgKsBGBeJmo2bt4IRMRJjp
 I/SVmEr+75oo+La3OoOQSZ0r2rrl6vi5v4UAzA1tGP6wIRaHe++FV3WVQv5/XczNAwGK
 yGfCrYtBkHo89AvoWP/hZeD42zu51kIYzWRSZJjIY2zAvj7vOE6NHN5xSH4kulEdohKA /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtq0yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 15:03:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MEswB8008651;
        Fri, 22 Apr 2022 15:03:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8b23x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 15:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+5599sjD/v64HHI4z8SXbesBvnQro5L0mbhDKgKZG+ejSRh+raZwTq5F83AKrE/ng2vir1kGof4ouAeKEqme9OZ/lD8jRVlU7j8iBDho+U/2FXxNIX3noJ42toPxhatBxav1Gt8UV3Fva4toQntCFR19tm+5XKR8AyH85/5wENI8lBx2rHdkoVR4Sg6+O+vJgTVDus7ngyR7KXhaUnKMoAi2g9pvsjj8LpXXCjMpDQBSza54EeP65dyMMzbUYP4/GOXdlyq3rb5vDWswHZMUj2PFcYV7FVMZw24Bd3PHIrVJxPVsFQNxIjQi/BxSXgGa38w7cQXWze1gH/629g6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQdsfUd7vPrmmDRiiBWfOU5K3yuSFTz/t65j6Fb6hXk=;
 b=aonpcv2Z83KyNnvtWML2XgTmo5I2ZCPxlsEAOyZvpZR6kwKtmy2DIWAcm66uLQaN8XE2t0IuY6Wn155kZC4qYybN2uZ5qsxrPO/6g67DAKuXhmA8165sF3LlJLOf9NNB4GQRwztDjVNnw6yM47MC7iqWBok1iDx8CbP/JxLvCA9zT1ia2xWnfJKh6a5/wkObz4ClT/7MEFCcl/DK+WE3DNnWd/C4fj4uKej2W7gCCQXN8ktc0/UTpSNiJbxpoKQBRfo2yf/rf/DJU5zd1TF2dMEs4tnabXBhLOVp+joU+L8topljGm1CbxAhkMaJBbGOnGrS/8pumQJYcDqbXhEUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQdsfUd7vPrmmDRiiBWfOU5K3yuSFTz/t65j6Fb6hXk=;
 b=fytMVAKbmy5G33cpw85qkMv8JITwVmMhI3BzgLWrwehbHxfqZHKBeImeB5sEMAFb6rtXV9CMHEWQhoenxXIWI6NmBTFVWwYDGXwlqrf44Q5MO1pHO5DsBJoHkV0QdH7oyI/avENnU/SGOoYZ5+GLn6WOVF/W4/t0qW+ZeXEXmUM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3431.namprd10.prod.outlook.com (2603:10b6:a03:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 15:02:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:02:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "crispyduck@outlook.at" <crispyduck@outlook.at>
CC:     Rick Macklem <rmacklem@uoguelph.ca>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi 
Thread-Topic: Problems with NFS4.1 on ESXi 
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIAA+egAgAACnqOAAAaegA==
Date:   Fri, 22 Apr 2022 15:02:59 +0000
Message-ID: <66E7CD16-A994-4CF0-B1B7-68C66EBF4833@oracle.com>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <A22B7B39-1FEA-4FFF-84D4-0FCBE42B590B@oracle.com>
 <AM9P191MB16653ED845751B0600F58DB08EF79@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB16653ED845751B0600F58DB08EF79@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c68dacf-f42c-486b-bb56-08da247130d5
x-ms-traffictypediagnostic: BYAPR10MB3431:EE_
x-microsoft-antispam-prvs: <BYAPR10MB343192BC30FE8AFBF39F735993F79@BYAPR10MB3431.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NpguyLbQVQ/4Trx0D+vjyOiU6XPerabPR2UKvamzDFpXfT2bYtXj1GkZvDKIeNdxi6ez7tbHjfM4V9t5/aEMfyABQfjWVtOq/K+4OEy3rVkMghLGSvFcpxoHQ5Li5pZL0ps1NKwQT9g+OL6mPj9AGglZUbiQ2J9AqKKJsM/0VyyOHj1KBg8PBTwwLv4XoL4sO6n4A3Urh6vVW3rCicHoTSrbid8rtcyyo24HMv8CQ1CW8JyHzfDFEmzgrO8ye8U56vZX1y7VWFVOyiDBTVFENZa6jPYL1/FdQ3kqiLGnzBikIItfn6n8TFEJtvDy/dYLm5QGI/RcKr9Vezm0UrJw7xLJo7G+E7Tuny1DEXMTAQtVCti8oy5+jsDXYoEdyUizhEQ1ONZ5CdqtkYS5HoGs8OrtJc3MNqqv21OdO8MEeW19/GRiaj4Vxn99VoTjwFwmDitd9jzFak68MOjHZmeFepIu0Rpjnhv69xb5zXj76tglCfIUDCZ8b9h8Ofp4vzOuVN9Dc0/Yy6WW7SFb9Y9SpcO6xZWV37/H4kuIBR8si1bOkbwjGvScE+dD3GrHNaB0R3BZlG4ptYNaqmHrX7cy6anwJsp+l2LqcsUhYNG33SYuaXG/+m5Lhjw7ap7IA6V6cJAOP2u1jxblwfpYRqhuTO5fWHipvC7FdSeoaLIsRSIezKrdafZAHpvoHk3s0P+s/Wk6shnCihaELjBweOc2QcjSdWa6e1tRBEwbzHgXeC2rReWeyxR4qSNYgIEkKOgW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(54906003)(76116006)(66476007)(91956017)(26005)(66946007)(66574015)(122000001)(38100700002)(316002)(4326008)(8676002)(64756008)(66556008)(66446008)(4743002)(36756003)(6916009)(45080400002)(71200400001)(33656002)(508600001)(6486002)(186003)(6512007)(86362001)(5660300002)(53546011)(2616005)(6506007)(83380400001)(8936002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkZwTGtCbUZRRmhLVWcxVFBOUlVlR3FyMnR2c2pkdzJtVjczKzBIOVlZNGpR?=
 =?utf-8?B?OWFzNi9mdjkxclpoWDJ4TE9PbHRHRmdidWoza2o5T3NyeVZNNXBrMUFXL0pS?=
 =?utf-8?B?ZDhiMkxqcWhNSnhwdm5TbjFEMUNkNkx4WE1XMmpoNUtzczl3cWVPUU9qOTR2?=
 =?utf-8?B?dUZqdXU4R2s1Y2tBRVlkMjNXM3ZyYkZmRnJmNDdSbUpIaXJyeHpRS0cxTEcx?=
 =?utf-8?B?QXBlbk5jeHlqV003M2FuQ0ZKbjdDNmFlVzNEbmJJTXhtdGZKVnZGSVMvd3Bw?=
 =?utf-8?B?cndWc2w2QUJCMDNoM2FIRlFENjlXeTdxZVFaSC9oRGRaNEhwclJOcW54VDU5?=
 =?utf-8?B?d21GUEN6TmZUUlFwWHVmUVNXTzBReU5JYWdlMnFCLzFqaGZJa1A2MWEzZnAz?=
 =?utf-8?B?YzFWdTZUcTBWRTVkSnVONkpjZk0rQlo0YlgrV3pLSWMrelF3L3ZQU0dOYTFh?=
 =?utf-8?B?VzBKOFdDa0NRZ1dyWmowNXR5Q29vUENlZFVGcWNLSk9jVXFRT0VKV3lqcnVu?=
 =?utf-8?B?c292amgzNkhicXJCdE9PY3lJV0N3ZTNGcjcvTDFYVnlJQ3N3cjNJQWZZSUcv?=
 =?utf-8?B?V2lnd2VPUGtPL1dtNUVSRUlOMThIeXQ3RDU3c25XelhUeGlJUlB2M1ZTU3Nu?=
 =?utf-8?B?bVNuZmxDaCtUOU1YWW9OSEdUZkhQeG96aisrcnBLSkk1RGxYMlRVL1VvMGRU?=
 =?utf-8?B?MFNJQVJGUEdQcXhtMG8rUisxREliZnhnbExaSnlFbzVacmNhSUt0MkFObVpm?=
 =?utf-8?B?MktFdklZMCtoVjJyVzB5eHQ0Qm05Rk9PcGYyelNuNGtNM0NtWC9UTWlXeEx3?=
 =?utf-8?B?RFdQcGRQd3p4ZXN6UTA2cEpIKzIyMTJsSGd4aCtBeW9nSGhGeFZhU0EvdWVB?=
 =?utf-8?B?c0JOZXdBL2JqUWw3aVNYNkVBNXdyUFl6Tm1oOFcvNEkrTmVJY2paaVBWd21q?=
 =?utf-8?B?ZFpGa295OHJPcTkwT3NUWVJIeW0rQWxxQmFwZG9sYzVwUHBCb1NLZ3UvL3VD?=
 =?utf-8?B?TUFuQlNpUDlRSGtqWWNYeG05NkVMUWVTYlRsTlk1L3FjaWlpVmVUMSt2SHFC?=
 =?utf-8?B?STJxekR0NU1yZmgvS2M5QUhZbUNUd09DM1c5V1Zpa25PdXllZnZ0UEQyWUo0?=
 =?utf-8?B?TUd1TVUxQjdpenVON1ZVdFdhR3BYUnF1cWh4aDVtTjZvRDBRYWN4R21oR2RG?=
 =?utf-8?B?aTBrc1UzWjRSUFNBZkRZWUZob2VWUG5BeVlpODZqTmMzY3YyOVltN3Z1b3pX?=
 =?utf-8?B?bkI2ekRmSERNcHBGVngxSyt5ZG1jcGZmVFVZblI2USs2Y0ljK1hUVlpFemtJ?=
 =?utf-8?B?dVdCd3FJMjhhdVhTREhCWjlZdnltWWZQcjIvSGRSZkNtM3BSWjgreENpOVkw?=
 =?utf-8?B?MGM3Z0VzbnNPSll5YmgzSlMycWxWMkd5T1BYSWFVbnhFOCtEWGNyYmh2S01D?=
 =?utf-8?B?YzhqaEVja2oxZSthWkI3QktMYWIvL1JDTk9QbitrN0F4VTlCMFhhRnZDMU1T?=
 =?utf-8?B?MWJ3SVRhSEVDK3VvMjkvYU9qalZ1ejhGajlteWZLSXhXN3ZqR1ZlMnNibmZG?=
 =?utf-8?B?VkpKUzhQMVdzUEpZaGRHa0FiWHBMeDgrbHJLTU1hTW5KZ1d3R1hVWUZOZlIy?=
 =?utf-8?B?OWRFZ1Q4d0J1WmZYZVhyazVGc0FrVWdqaFJ0aTg0UW5objJRZm9wRTI1c1k3?=
 =?utf-8?B?YWUvbUdGY0NiamFYcmZlYm9yUzFhcnRQbkZJYldPaTJKYnVxOU5ycnhJRUlr?=
 =?utf-8?B?UGg3VmdqdzkzVGVkalBrVndjYUo0ZjFTTFVScXhCeHRpSUlGS0FxUDNOUSs4?=
 =?utf-8?B?a1E1eGpMRXpvOEFoaER5Wm9JYmg2OFhMLzBWK0kva001cVcyZzkycXJvMUxp?=
 =?utf-8?B?QjJ2Wk9yTDFxV3B6KzdYTmRBWVE1Z2h1a0pabGFMT1hmZ2dUdlBCaUVBcXY0?=
 =?utf-8?B?OE1WVzYwdnpoUUova2t4bHAwTzBPZjNHazFtNzM5ZVNTeE9BZnNGeVpzekd6?=
 =?utf-8?B?YXJNQnBzT0ZYWEVqOXdiNFJoTjIvNlUyQ1U2K3BmSU9pTnIybzRTOE1aYUxy?=
 =?utf-8?B?ZmdLTVZFQ0xtTkNZUmw5SjdIL092S3pmeHQ5d0V0T0lGUWZpdXF4b3p5a2Rl?=
 =?utf-8?B?cjFSaHJPRWlyVmZGMjcrYXIvYzRITC9QMk1NUWg3dDVVNUFpZjU2OGRVQkZx?=
 =?utf-8?B?Y0k1Z3hHajVJQ3VxWjF5eGhDdzJSVEx1NVhWMkp1WmVpWWJVclZvZ2xTWmF1?=
 =?utf-8?B?VEdBYlM4NUx3K3FNUklLaXhnczJGU0EzSE5Ec1FYVXlWaVFKRWF5NVgyWGRK?=
 =?utf-8?B?QjVBZHkzMmZrSjQ1TU8xbzNlQXk3QW00RkpXNjVnVTlXSXl2bTl5N2pGSWpk?=
 =?utf-8?Q?S4z+x2nWPP7Q8PVw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B866D97A477FC742B126098958B82CC1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c68dacf-f42c-486b-bb56-08da247130d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 15:02:59.4939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFY1p51xwF+oWhMKxzrsCRWG4LGyzZz04aKirhxvqH/PkDZnlClBmC0I7zlt+awpOPLuV0b6BEg+dAFqgqss2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3431
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_04:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=856 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220066
X-Proofpoint-ORIG-GUID: FMdt3om3O7huUsNWc7yeIMnG8x9xNr0i
X-Proofpoint-GUID: FMdt3om3O7huUsNWc7yeIMnG8x9xNr0i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gQXByIDIyLCAyMDIyLCBhdCAxMDo1OSBBTSwgY3Jpc3B5ZHVja0BvdXRsb29rLmF0
IHdyb3RlOg0KPiANCj4gSSB3aWxsIHRyeSB0byBtYWtlIGFsbCB0aGUgcmVxdWVzdGVkIHRyYWNl
cywgTkZTMywgTkZTNC4xIGFuZCBpZiBhIFZNIGlzIG9rYXkgSSB3aWxsIGFsc28gc2V0IHVwIGEg
RnJlZUJTRCBORlMgc2VydmVyLg0KDQpTb21lb25lIG1lbnRpb25lZCBORlN2NC4wIGlzIGEgIndv
cmtpbmciIGNhc2UsIHNvIHRoYXQgd291bGQgYmUgaW50ZXJlc3RpbmcgdG8gc2VlIHRvby4NCg0K
DQo+IE5vdCBzdXJlIGlmIEkgY2FuIGRvIGl0IG9uIHdlZWtlbmQsIGJ1dCBNb25kYXkgc2hvdWxk
IHdvcmsuDQo+IA0KPiBJIGNhbiBub3QgdG8gMTAwJSBzYXkgdGhhdCB0aGVyZSBhcmUgbm8gc3Vj
aCBlcnJvcnMgb24gRnJlZUJTRCwgYXMgSSBkb24ndCBoYXZlIHRoZSBvbGQgc2VydmVycyBydW5u
aW5nIGFueW1vcmUsIGJ1dCBJIGhhZCB0aGlzIHJ1bm5pbmcgbm93IGZvciB5ZWFycyBhbmQgZGlk
IG5vdCBzZWUgYW55IGlzc3VlcyAoYmVzaWRlIHRoZSB1c3VhbCBFU1hpL2Jyb3dzZXIgb25lcykg
d2hlbiBpbXBvcnRpbmcvZXhwb3J0aW5nIFZNcy4NCj4gDQo+IEl0IGlzIGFsc28gbm90IEVTWGkg
Ny4yIHNwZWNpZmljLCBhcyBJIHJlY2VpdmUgc2ltaWxhciBlcnJvciBvbiBFU1hpIDYuNy4NCj4g
DQo+IFdoYXQgSSBmb3Jnb3QgdG8gbWVudGlvbiBpcyB0aGF0IGl0IHNvbWV0aW1lcywgd29ya2Vk
LCwgbWF5YmUgMSBvdXQgb2YgMzAgdHJ5J3MuIGJ1dCBubyBjbHVlIHdoYXQgaXMgZGlmZmVyZW50
IGFuZCB3aHkuIA0KPiBJIHdpbGwgdHJ5IHRvIHRyYWNlIGFsc28gb25lIG9mIHRoaXMgY2FzZXMu
DQo+IA0KPiBJIGFtIGFmcmFpZCB0aGF0IFZNd2FyZSB3aWxsIG5vdCBzdXBwb3J0IGhlcmUuIFRo
ZXkgc2ltcGx5IHRlbGwgdGhhdCBhIExpbnV4IFNlcnZlciBpcyBub3Qgc3VwcG9ydGVkLiDwn5mB
DQo+IElmIEkgY291bGQgSSB3b3VsZCBhYm9kZSBFU1hpLCBidXQgSSBhbSBzb21laG93IGZvcmNl
ZCB0byBhbHNvIHVzZSBpdCBiZXNpZGUgb3RoZXIgaHlwZXJ2aXNvcnMuDQo+IA0KPiBJIHRob3Vn
aHQgTkZTNC4xIHNob3VsZCBiZSBORlM0LjEsIGluZGVwZW5kZW50IG9mIHRoZSB2ZW5kb3IuDQoN
ClRoZW9yZXRpY2FsbHkgdGhhdCBpcyBjb3JyZWN0LiBUaGUgaW1wbGVtZW50YXRpb25zIG9mIHRo
YXQgc3RhbmRhcmQNCmNhbiB2YXJ5IGFuZCBoYXZlIGJ1Z3MuDQoNCg0KPiBPbiB0aGUgb3RoZXIg
aGFuZCB0aGlzIHNldHVwIHVzaW5nIE5GUyBzZXJ2ZXIgYXMgZGF0YXN0b3JlIGlzIHJlYWxseSBn
cmVhdC4gTkZTMywgd29ya3MgYWxzbyB3aXRob3V0IGFueSBpc3N1ZXMsIGJ1dCBORlM0LjEgc2Vz
c2lvbiB0cnVua2luZyBtYWtlcyB0aGlzIGFsc28gdXNlYWJsZSBvbiBob3N0cyBjb25uZWN0ZWQg
d2l0aCBzZXZlcmFsIDFHIE5JQ3MuDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg0K
