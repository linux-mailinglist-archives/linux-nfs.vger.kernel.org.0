Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB73688C28
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 01:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBCA5R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Feb 2023 19:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCA5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Feb 2023 19:57:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CAB6602B;
        Thu,  2 Feb 2023 16:57:15 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3130NbEA028381;
        Fri, 3 Feb 2023 00:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZogQmLhBh0A/k6eiNjkdOlvXJ2s1i9NYZqFTXJoIOE0=;
 b=MtbhxuLGBmBTRp9ns/bVGXovk6EG1arNlbmTBhYeu9JihffvgsDdr/qs4nMmQf015FlY
 2ZwTEt+UJeve/StXQmlQAyIDYIKXpKXqVy4uILOgfAH/LXRXvuc5hdEA/cwPB9TYnuC/
 6+FV2bsWE1l5gcs6J9zPiolRgFner37qFxJYUoLTBJybgrBthPf2PRKS+lsTIZ8KiodN
 Md6M0wKhs74RwOwj0ePg9/I/c5YcjwxVMcG+RiopfSQUbMb844tV8ak5Y26JZpBLo56L
 7QbHngTyQOZXnnSVRmqx/1vZDZUMaR6OxJEx+56STooi0QGHEgl02h03Tz807u3A6Lip ZA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfn9ymhdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 00:57:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312NPmRP005046;
        Fri, 3 Feb 2023 00:57:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5gyavx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 00:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuaPGTLn1ArCJTezqZXGndHa0B8+U7BkpzyaQSnBmrY7jeHLUOddU0kp0lBnCqMK3uLXlHtJ3itisMtBT3kkBIgGRd+KlsesndAP0a92p0xaYMFvGuN+R5Xi+jguPSvIbl7f/ENhEMR/Fkpwhlo+yWWsZrABXYIukFExg2wroZnBBB2Gu3dE4Y6M7i/fm5vz133Up3Q3Ye0KKy8s3cWyEsfElCGAr66h5bSD4WIiQ9R0oTMIfYJy6e55CwKgU1/JS6QeTwoG93Lqa1K0FIg5msl7QIxUNqwhCHTBBKq0OZdaVhIjH+b8gIp3zVzdYoHHClbUGwVlaCGl5Aa42Mp5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZogQmLhBh0A/k6eiNjkdOlvXJ2s1i9NYZqFTXJoIOE0=;
 b=cI+IoVXVCetog3J+UjSWIkF6PEiKwWFKjVbY94iNVbQQp/NJNdS2gkpII9G+5qaW1HSd5OX+3Qera+z96rJpqLX0uvqyn7M/773fu7razoaQ+gcT/4ddiP3cW+7uH9HdDAO9t/VSrhNsTQPvxE5YhhlxgXz5M4IPdJo2sF5IYLo2MdKHS0/Ko7g5Aa8X7Wb4W7S64PlflLBkQMnbVOCpRdUIRumCTDXdKzip6cmEMpVtTqCj5M2YGI4Vb2ykHgglmU5pb+u79FcCzLXV9aFN4L2DyOzSpT3pj4cRmVoPyysAtn4H5x2h29CUhxTxthj/tD7/iMDEubGsS1Tlc55cHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZogQmLhBh0A/k6eiNjkdOlvXJ2s1i9NYZqFTXJoIOE0=;
 b=B6cLqM9L/7tSTkemgx0WE3uRXkc7XFvnonaI0WwRXiatX8+rYTgaLd6npywj0ssoeJh+EAkD4Tnb4U3MygaraMKDBFkAYH9Wdq/1UVc7XN3x8XJM7XfsC6S2+QjEZfR/aYFGoDq5QWEDWnCEbIntCytyIY1QOYL+GqYvyvHGQpo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4203.namprd10.prod.outlook.com (2603:10b6:5:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Fri, 3 Feb
 2023 00:57:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6086.007; Fri, 3 Feb 2023
 00:57:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?5by15pm66Ku6?= <cc85nod@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: fix deny mode logic in nfs4_upgrade_open
Thread-Topic: [PATCH] NFSD: fix deny mode logic in nfs4_upgrade_open
Thread-Index: AQHZNtkQTUc54cGJ8kWHJe+mTHkMtq68DvmAgAAcTwCAADoJgIAAAdsA
Date:   Fri, 3 Feb 2023 00:57:08 +0000
Message-ID: <524D9714-12D3-4585-8296-C39AB7829F9E@oracle.com>
References: <20230202073611.13106-1-cc85nod@gmail.com>
 <CBAFB3E5-5737-47A7-8234-3A771E908C4F@oracle.com>
 <7b7edc8bacb863915d00673f9e03d38798341a69.camel@kernel.org>
 <CAAn9K_vykJofBJ6F8=7rmiJzXhESRcJ0DEnc+nDbwTHLX6BG0w@mail.gmail.com>
In-Reply-To: <CAAn9K_vykJofBJ6F8=7rmiJzXhESRcJ0DEnc+nDbwTHLX6BG0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4203:EE_
x-ms-office365-filtering-correlation-id: f09eb9aa-1e27-4bc4-9a90-08db0581934f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JOe6X2V1eB3wX12egf4vtotQ3+Us1GYiU3xi2qh1fQNFQl6VxHV6sfLwQLT0Tb2EQhgDiX8x2o+jz8I6QS6iyUJvn9PywiuY3O1GintSMXSMynGcPRsPL5TMD8iJXFaTRNcj1J4PuwMkW8tJy6EvQchkBdpd01QehYsRcTGrRZyDedcEfRoi4gsKKgNrQNCbfCB5tfiWBClQrmNP8q8/Zt18pRkwv5ni9WxtchJ7KoNz92pDjhmhaFJjdMxyxLKiJ+B3PFwktDXD+y4NtFO1UcgwsJewLK4rRph0lCk3WJIfKGsXVm0vq3eBAy+cchW2HvLPmFjWwZI72bzEvDF7hyTlAQP7MFBZsRfOIN9H4lQM0mimFIJ53JWcOnYn7HW9lampXEWxDC0mpU243HK5MNj+w9rDRMfjd/Iv8pZWwGibnjM2nXxRyfP4Ebzy8RcK8JTNqV6s6YPe6d9Q/VTSQABUCzHwTRdKeJA17o5DlvBkJ49HfuKuCnbeatoE68rQghYUtJu79LZ8zEtxDvjAu7tJS9xt7oqK+petz+JBjGZOPTGMFV8zzFcxhcxNs9P5JxUDoYaqmMJSMLrBsGmMRlmnNhrmnF/A3RZcIOXf7u+nQlWwxEE+NB+QBuhYvsE8tCxmh0N9uhMxY3E1+u9SdXHaCcXT1mHsW974MljRT+rxB3xheMwLCdXCiXH7rREN+9jnpeYIZbdLLrdCdV2IJsYW/CpLgwF4OGMfl7z+Jws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199018)(8936002)(83380400001)(5660300002)(91956017)(2906002)(53546011)(41300700001)(6506007)(6512007)(33656002)(66476007)(66946007)(2616005)(66446008)(38100700002)(6916009)(64756008)(66556008)(76116006)(4326008)(8676002)(316002)(186003)(86362001)(26005)(36756003)(54906003)(38070700005)(71200400001)(6486002)(478600001)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU5qSGJGS1JndkI3NlUxamlFVDk5clBFNHZkcDluOUJTM2Nrdi93VU1DYk5M?=
 =?utf-8?B?dUg4bTZBbFgyNTVxT3dpakYwUVFQS1VPb3FIMDIxYnp5STBnWmhiMVVCNW80?=
 =?utf-8?B?Q3BNaFhGd3M1di9Yblo4R05KaDB6aFJzOGVRWU5qSEp3UjM2TmU5QWF4TUZS?=
 =?utf-8?B?bXcwS0c4RWNJODMyUExlWEQzL05QWDFveWM4ZHBKemZScjFHYTd3dktOMzRF?=
 =?utf-8?B?TDNtQkt4ZW9ocVF5Q3pMTytJOEJCM2J2RWlVdmdqbVRrYlYvQjhTaGhZVWJ0?=
 =?utf-8?B?eEhjRWk5bVZsSzRLNng1S3FGRDYvdVVRSk1Nc0w0Y09mcVdqVGM5VWY1ZGZL?=
 =?utf-8?B?alNuMGpDR2tpMERwNjdSbTJ3NDF3RHBHQ2d2OUZSTGpDTVBhTzN6b01mRFpt?=
 =?utf-8?B?KzRWMkljaUQ1NTVVWVU5MTgxSEc5ZkJmTkRHZDZBbURhYzBxNURXRkptd01Z?=
 =?utf-8?B?ajNBWjlUcStUV1RQUzFwQUhtRERVanIwYUdVZWdBY212ZEVVWk5IbkxtQ1hE?=
 =?utf-8?B?SlJpLzUzU21zSGZhVjI3Q3FRaUxyMmsyRFh1U3crRGVLOCtqUEVWRnhVNWNq?=
 =?utf-8?B?R2M2c2pmZDFneDZ2K0thalcwb3dmMXRNdlpGY2VyMDlVZlE5aHFxa1NJQ0Zn?=
 =?utf-8?B?cVpwS1dndEpPQ2p2cFA2dzg0WFlBRHd3aDEyMzYrb0I0Q2VrOTIrZWlZcXkz?=
 =?utf-8?B?R0dDa1c1RmRZNlBJRWwvOGtoZ3Vpd1NoY3Avb3JoRnpUWFJrQUJ3TDE3U0ZY?=
 =?utf-8?B?MkRVcnpOMVBqZlVxUWtQWnJUNndFNFdNV0UwZ2VUeDNPcm9GVnF6YnFDMlVE?=
 =?utf-8?B?VzQxeGtSMmxuc2tFZnlFV2kxWnIxNGgwNFdYNXBGbURjNVpsMmY4TUlBWmhP?=
 =?utf-8?B?cmF4OVNZbzRhbHJ0ck1STnpYKzVwdG5BaVVpUDdNSmx5cE5OYVZ0a2pGaWlS?=
 =?utf-8?B?dEsxbm1qUCtkVldvNTZPSVEyU1RUTDJVem11T3RxL0NZRUlCbFhEMWhMc0tO?=
 =?utf-8?B?RjdzOW1zUlJOQ3ZjQlJCRDZJNkRVMnJrTUFNK29JWEtmNXJTZldQVmFNQkRq?=
 =?utf-8?B?U0lwdHpUMjhrdjY5OVkwT0dweHliUFgxUHBxTitJdXMwSGtrb2RxQTd2aFM0?=
 =?utf-8?B?eFh4Y2lYTmtLS1NwelRaOFZkUVMyamdVTnJNYkNoYVJuOFBYbFpjWDNGMDZB?=
 =?utf-8?B?TmN0NElzQkNFcmtTMW8rdmJxZ1NxVVV0dTZVQWNUWms2YjQ5ais0U3FRVHBo?=
 =?utf-8?B?d01zajFud2lJNDZCTmZscm1UbXpIQjJuTFIvTlpZb1AyNGRZU05idjFneEVG?=
 =?utf-8?B?Y2M3amVCSUlEbGlwQXZkMTZtR29Jd1pXeWlvc2tTRk96Z1hWeVhnUEE0ZWxM?=
 =?utf-8?B?T1B4MXdCN1cxMTU5VTg5S1NaWFcrM1dZSlFCMUovenE3VWU1cVp0alpHRWNT?=
 =?utf-8?B?dG80RkNzbUdwSXlBMXBuZVA5dUVTWU9ZL0ROZzBaeWJxd3psTThvWXlWQVBO?=
 =?utf-8?B?UzN1UXZQNklWTDdaVjlSMTdidXgrcnl2d0ViOC9iWmtpdHJ6OFV2b2tOS3Uw?=
 =?utf-8?B?eWFzUmNzL0gzU0VFRHk2UnFtcFZuRDlCVU15LzY3QTFad09NOXZSU2x2ekg3?=
 =?utf-8?B?dlhjRzIvekpoZGFrVkszeDdwRVhCTGtOQVNySk5xZlRCV2IvV0xWeVgvYXV3?=
 =?utf-8?B?bFdoRFN3bEtZazlibDhhTXRDM1VxZnFTVE0zamVEa29reVRTWWU5bEtzcXkx?=
 =?utf-8?B?TEcrMlBFRTZ4MDNDSnNpU20rUUdhYzVRalBwczh0VjUzNmVjM2dJOXovd0wr?=
 =?utf-8?B?dm53bU44RlpIY1hPTzNjZTlrQVIwMngzaXNRdFd3eW45Q1VEWXRhSUdTMWZY?=
 =?utf-8?B?dEtsWlMrS0d3cHEyem1wQTNSbE5tNjg3akk4U1phcGh5c0VwUGs3ZWF6M0hm?=
 =?utf-8?B?ZmJoZVVWNTZEbTVyN0llU090WjRaT2dtbVdtK3dVNlZra0Y3YURiajJMQlNH?=
 =?utf-8?B?MjRrbXJVaXl3ZnBzYjIySU5wOEpic3Zpck1BeUl0dVJsZnQwWUM2U1V3SVoy?=
 =?utf-8?B?R2g4SnBGQVdvcndHSnBBTWw5U3VGSTRaNTF4bGhwbEQvTzIyUlZSeEQwUTdm?=
 =?utf-8?B?eHBMZnVJdWhJWXZ5L1grYkZPeFQ1eXI2QitsMXd2dnRneWZRS3dFeXoydmNE?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAFCB3C260673949A67DAFA5DC15A49F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QkV8hmTwXnYuR3uAQ8QExNFhxGrhVS/yAWz83Fox3QxG1T/ADJs1erp/7MilVHPgWpNI+T0x0EybSZ+osErrHqjt21qa1aXsOz+BfR2Ol31pD2p44pbFSrtuSfEc4mGX829OfX9hQKiYmeJAhtSGnU9G86A8bOM0eLjOlJDytrHmputBo2kaWm6u2ZZhNQSTTjrSxJedkcYh6Q/ihouS7RGiNBiwUjDACXpwCvMySdMqp7pt2YawXsp8pieJA1eSKN1Kg6ZyC8SmXqpYy/XE4a7dNqgoDWCBUuLbelqasdrGNpFI9XDq+kl+NCgPGrlFyPXVGL2lWdDIuv5QslqxHr9PLHHmwsE0b0d7gq+LBdfuC0OpmEtpSRhwF92jy3RwhjZYKuNALEhxC7p3IbeuYaBq2vfMcUQ4AJQt65ogsNzKWFqS8E7lHDJ0+3ogLWmARj1TWvJyXXPqrZE8175+unsWjljEFvPrjml5kJapZRmv/PX2QQL7wNAqVZMxoAy3I94GgteVVlX2Wmwino+7jhQBeQeymJkKuZOd4bzDamasqVI+Gah4Gi9JDDghl2IvSyXR80LS9/QZjG9WuxTn1cwCTMPG7vVWoyoOPJ80a1caFdTOnnymCWMQ+bzuYLlAx8Xy3BBkp3BFCFE6jdwCS3R7cesYQdQLyY3xFU03gftqE3+taRzeBpEfkRJCRHvt4R+Kck+egI9Vd1dlmZIQCJGSjyX+m3Tbfky5VjxObnbqXW0KY32MXrtj/Q62c0nIkiB1RLcgbcffiNaPEuDhQA4dIMS9bmBprX7K2CrA/DRG8nCsXaLavH7nyllCinpr
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09eb9aa-1e27-4bc4-9a90-08db0581934f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 00:57:08.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YePEHegcVJVnF57tHcCkMcJukOh8Qu7GwjwUJ+fzjnaZFsxcoeup5TXqbmj0efyDWzbSwr1VDuRfWks/3GdN5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_16,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030006
X-Proofpoint-ORIG-GUID: 08u-mPCnkZulUxQNmYjvDCdcIoMupxB9
X-Proofpoint-GUID: 08u-mPCnkZulUxQNmYjvDCdcIoMupxB9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRmViIDIsIDIwMjMsIGF0IDc6NTAgUE0sIOW8teaZuuiruiA8Y2M4NW5vZEBnbWFp
bC5jb20+IHdyb3RlOg0KPiANCj4gU29ycnksIEkgdGhvdWdodCB0aGUgc2V0IGRlbnkgbW9kZSBv
cGVyYXRpb24gd2FzIHRoZSBlcnJvciBoYW5kbGluZyBvZiBuZnNlcnJfaW52YWwsIGFuZCBmaXhl
ZCBpdCB3aXRoIHRoZSBvbmUtbGluZXIgd3JvbmdseS4gVGhhbmtzIHlvdXIgZXhwbGFuYXRpb24u
DQoNCkRvIHlvdSBoYXBwZW4gdG8gaGF2ZSBhIHRlc3QgY2FzZSBmb3IgdGhpcyBpc3N1ZT8NCkdl
dHRpbmcgYSBUZXN0ZWQtYnk6IHdvdWxkIGJlIGdyZWF0Lg0KDQoNCj4gSmVmZiBMYXl0b24gPGps
YXl0b25Aa2VybmVsLm9yZz4g5pa8IDIwMjPlubQy5pyIM+aXpSDpgLHkupQg5LiK5Y2INToyMuWv
q+mBk++8mg0KPiBPbiBUaHUsIDIwMjMtMDItMDIgYXQgMTk6NDEgKzAwMDAsIENodWNrIExldmVy
IElJSSB3cm90ZToNCj4gPiANCj4gPiA+IE9uIEZlYiAyLCAyMDIzLCBhdCAyOjM2IEFNLCBQdW1w
a2luIDxjYzg1bm9kQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IElmIHRoZSB1cGdy
YWRpbmcgZGVueSBtb2RlIGlzIGludmFsaWQgb3IgY29uZmxpY3RzIHdpdGggb3RoZXIgY2xpZW50
LCB3ZQ0KPiA+ID4gc2hvdWxkIHRyeSB0byByZXNvbHZlIGl0LCBidXQgdGhlIGlmLWNvbmRpdGlv
biBtYWtlcyB0aG9zZSBlcnJvciBoYW5kbGluZw0KPiA+ID4gY2Fubm90IGJlIGV4ZWN1dGVkLg0K
PiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQdW1wa2luIDxjYzg1bm9kQGdtYWlsLmNvbT4N
Cj4gPiA+IC0tLQ0KPiA+ID4gZnMvbmZzZC9uZnM0c3RhdGUuYyB8IDIgKy0NCj4gPiA+IDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4g
PiA+IGluZGV4IDRlZjUyOTM3OS4uZWJkZmFmMGY5IDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZz
ZC9uZnM0c3RhdGUuYw0KPiA+ID4gKysrIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiA+ID4gQEAg
LTUyOTgsNyArNTI5OCw3IEBAIG5mczRfdXBncmFkZV9vcGVuKHN0cnVjdCBzdmNfcnFzdCAqcnFz
dHAsIHN0cnVjdCBuZnM0X2ZpbGUgKmZwLA0KPiA+ID4gICAgIC8qIHRlc3QgYW5kIHNldCBkZW55
IG1vZGUgKi8NCj4gPiA+ICAgICBzcGluX2xvY2soJmZwLT5maV9sb2NrKTsNCj4gPiA+ICAgICBz
dGF0dXMgPSBuZnM0X2ZpbGVfY2hlY2tfZGVueShmcCwgb3Blbi0+b3Bfc2hhcmVfZGVueSk7DQo+
ID4gPiAtICAgaWYgKHN0YXR1cyA9PSBuZnNfb2spIHsNCj4gPiA+ICsgICBpZiAoc3RhdHVzICE9
IG5mc19vaykgew0KPiA+ID4gICAgICAgICAgICAgaWYgKHN0YXR1cyAhPSBuZnNlcnJfc2hhcmVf
ZGVuaWVkKSB7DQo+ID4gDQo+ID4gaWYgc3RhdHVzID09IG5mc19vayB0aGVuIHN0YXR1cyB3aWxs
IGRlZmluaXRlbHkgbm90IGVxdWFsDQo+ID4gc2hhcmVfZGVuaWVkLiBTbyB0aGlzIGNoZWNrIGlz
IGEgYml0IG5vbnNlbnNpY2FsIGFzIGl0IHN0YW5kcy4NCj4gPiANCj4gPiBVc3VhbGx5IEkgcHJl
ZmVyICJzd2l0Y2ggKHN0YXR1cykiIGluIHNpdHVhdGlvbnMgbGlrZSB0aGlzDQo+ID4gYmVjYXVz
ZSB0aGF0IGF2b2lkcyB0aGlzIGtpbmQgb2YgaXNzdWUgYW5kIEkgZmluZCBpdCBlYXNpZXINCj4g
PiB0byByZWFkIHF1aWNrbHkuDQo+ID4gDQo+ID4gSmVmZiwgeW91IGFyZSB0aGUgb3JpZ2luYWwg
YXV0aG9yIG9mIHRoaXMgZnVuY3Rpb24sIGFuZA0KPiA+IERhaSwgeW91ciBjb21taXQgaXMgdGhl
IGxhc3Qgb25lIHRvIHRvdWNoIHRoaXMgYXJlYS4gQ2FuDQo+ID4geW91IGd1eXMgaGF2ZSBhIGxv
b2s/IFRoZSBvbmUtbGluZXIgbG9va3MgY29ycmVjdCwgYnV0IEkNCj4gPiBtaWdodCBiZSBtaXNz
aW5nIHNvbWV0aGluZy4NCj4gPiANCj4gDQo+IFllYWgsIHRoYXQgY29kZSBpcyBjbGVhcmx5IGJy
b2tlbiBhbmQgaXQgbG9va3MgbGlrZSBpdCB3YXMgZG9uZSBpbg0KPiAzZDY5NDI3MTUxODA2IChO
RlNEOiBhZGQgc3VwcG9ydCBmb3Igc2hhcmUgcmVzZXJ2YXRpb24gY29uZmxpY3QgdG8NCj4gY291
cnRlb3VzIHNlcnZlcikuDQo+IA0KPiBJIGRvbid0IGJlbGlldmUgdGhhdCBvbmUtbGluZXIgaXMg
Y29ycmVjdCB0aG91Z2guIElmIHRoZSByZXN1bHQgaXMNCj4gbmZzX29rLCB0aGVuIHdlIHdhbnQg
dG8gc2V0IHRoZSBkZW55IG1vZGUgaGVyZSBhbmQgdGhhdCB3b24ndCBoYXBwZW4uDQo+IA0KPiBT
b21ldGhpbmcgbGlrZSB0aGlzIG1heWJlPyAoY29tcGxldGVseSB1bnRlc3RlZCk6DQo+IA0KPiAt
LS0tLS0tLS0tLS0tLS04PC0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IGRpZmYgLS1naXQgYS9m
cy9uZnNkL25mczRzdGF0ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiBpbmRleCBjMzllNDM3
NDJkZDYuLmFmMjJkZmRjNmZjYyAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC9uZnM0c3RhdGUuYw0K
PiArKysgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+IEBAIC01MjgyLDE2ICs1MjgyLDE3IEBAIG5m
czRfdXBncmFkZV9vcGVuKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdCBuZnM0X2ZpbGUg
KmZwLA0KPiAgICAgICAgIC8qIHRlc3QgYW5kIHNldCBkZW55IG1vZGUgKi8NCj4gICAgICAgICBz
cGluX2xvY2soJmZwLT5maV9sb2NrKTsNCj4gICAgICAgICBzdGF0dXMgPSBuZnM0X2ZpbGVfY2hl
Y2tfZGVueShmcCwgb3Blbi0+b3Bfc2hhcmVfZGVueSk7DQo+IC0gICAgICAgaWYgKHN0YXR1cyA9
PSBuZnNfb2spIHsNCj4gLSAgICAgICAgICAgICAgIGlmIChzdGF0dXMgIT0gbmZzZXJyX3NoYXJl
X2RlbmllZCkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBzZXRfZGVueShvcGVuLT5vcF9z
aGFyZV9kZW55LCBzdHApOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBmcC0+Zmlfc2hhcmVf
ZGVueSB8PQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChvcGVuLT5vcF9zaGFy
ZV9kZW55ICYgTkZTNF9TSEFSRV9ERU5ZX0JPVEgpOw0KPiAtICAgICAgICAgICAgICAgfSBlbHNl
IHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKG5mczRfcmVzb2x2ZV9kZW55X2NvbmZs
aWN0c19sb2NrZWQoZnAsIGZhbHNlLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RwLCBvcGVuLT5vcF9zaGFyZV9kZW55LCBmYWxzZSkpDQo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gbmZzZXJyX2p1a2Vib3g7DQo+IC0gICAgICAg
ICAgICAgICB9DQo+ICsgICAgICAgc3dpdGNoIChzdGF0dXMpIHsNCj4gKyAgICAgICBjYXNlIG5m
c19vazoNCj4gKyAgICAgICAgICAgICAgIHNldF9kZW55KG9wZW4tPm9wX3NoYXJlX2RlbnksIHN0
cCk7DQo+ICsgICAgICAgICAgICAgICBmcC0+Zmlfc2hhcmVfZGVueSB8PQ0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAob3Blbi0+b3Bfc2hhcmVfZGVueSAmIE5GUzRfU0hBUkVfREVOWV9CT1RI
KTsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIGNhc2UgbmZzZXJyX3NoYXJl
X2RlbmllZDoNCj4gKyAgICAgICAgICAgICAgIGlmIChuZnM0X3Jlc29sdmVfZGVueV9jb25mbGlj
dHNfbG9ja2VkKGZwLCBmYWxzZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHAsIG9wZW4tPm9wX3NoYXJlX2RlbnksIGZhbHNlKSkNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgc3RhdHVzID0gbmZzZXJyX2p1a2Vib3g7DQo+ICsgICAgICAgICAgICAgICBicmVhazsNCj4g
ICAgICAgICB9DQo+ICAgICAgICAgc3Bpbl91bmxvY2soJmZwLT5maV9sb2NrKTsNCj4gDQo+IC0t
IA0KPiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KDQotLQ0KQ2h1Y2sgTGV2ZXIN
Cg0KDQoNCg==
