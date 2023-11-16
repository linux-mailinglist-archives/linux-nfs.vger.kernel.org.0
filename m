Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250267EE690
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 19:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjKPSSx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 13:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjKPSSw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 13:18:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2127D49
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 10:18:48 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGHhn7A025562;
        Thu, 16 Nov 2023 18:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8Bnt1FISrl8nggOshUisuaKLf3U3cuvyO9eVrpq1MaQ=;
 b=zFutLIBgu1etusutBXDtCjXA3dMtqwQKlYZGsXbuM1xcyINQJxZbgV/5I146a45wa06c
 uZScwiD2/NpHcpT4bTzNZmEnDJXWT5iAn08BF484hnixqF+j9DjVrTvzr57FNijxDf4H
 NDM9QbvfGJyWJC0OkBEJih45pz6/E+PSZvvkK7y71hh6TUClwkX11zhzwPXR5ZHm7ESQ
 PSGLivJiY9w5VjzaL2HwjzZDq5q8EVpwTGsUWtZe1/Rjv8jgrMOyGxL2Q3Ikkf7EpS0Q
 qG4seqC5WWYCaI5XYKH60EIy5YVsdwma0UHk4mJjxjoGiS2WNSddIrqfq066YWFj+09O rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2na3s03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 18:18:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGHxTmv031687;
        Thu, 16 Nov 2023 18:18:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxh59v7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 18:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Otdqs0IaesAJU2k628nWzGcOVlmJZt+p9lGrs7qhczhqQG2lS+a97+7cDa7zX9JT3ae2fBvIF/bCVtEeIfoWk8rUVlD8QTgB7IQhTTqyDoGfplfsZXd4K9f2HriCIhB4xPlr3qi/0bV4cj0B1neHXV3nFyx9P2ijpW1ZrRrPKiXoJxUBiYCICa33ttknPiNZI9U4asG+/TnmfMWuETYfs4/Ka6U2Xcd/4XEJWNAUVe+t27zvSjQOIp/jBDY7hFm69qVcZABBY2J26Ky0aFqJ4L4E0JGGFSsXa4c+l55WEK35MZAJBAe4CdY87t8rFYQohab57O0/SPTZkhTeJhlqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Bnt1FISrl8nggOshUisuaKLf3U3cuvyO9eVrpq1MaQ=;
 b=lFKiIdPz1sidxVScVp4jjXUObgLUy00Rl99giJGpL2hSC1hu+E8jmgKpXJkQigOfSFSVnQD705uDWLSK7IqHAzQ0caEcj+ujqDFx47A1WgQ+fDbb8tsnKOXyp4jUekTUgmdmHsQQkyvIBB70kkouCIoOcjzZQZEK9EJxPzju12th6s0TR6vBn+MzYstqTDuUAs2OQhwprdKPG74p2qZaG50B6ACVql0XlBIiH35+Cn9+8TZ5DppaOmtu5n/Xz5YOZixg5Hk56sZ5GXSKCh6Blrv8uXzUq7R/B1fsVpVV4K9PvN2yenE2S/fb1mQ5HT01grKLszEkDhgayETpXNP3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Bnt1FISrl8nggOshUisuaKLf3U3cuvyO9eVrpq1MaQ=;
 b=Tb7/0ejkh0Zs3/wfXALc0bTidDV1LeSFM4zytxHNSnDCzycv/zLfriK+cU1NSx/jRwvEIUdiNEyje59/2RHtCx4iz787KuA9nFRjlPoZmq7FzjgsW2LTKJNZUH5vk2y7rwR6auURHV8l3yw5OApfGokBEkQn8jlcvMrkCNS+264=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7929.namprd10.prod.outlook.com (2603:10b6:610:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 18:18:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 18:18:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Blocklayoutdriver deadlock with knfsd
Thread-Topic: Blocklayoutdriver deadlock with knfsd
Thread-Index: AQHaGK/y+v0vH8OMck2iR9NTIbWm67B9QT2A
Date:   Thu, 16 Nov 2023 18:18:43 +0000
Message-ID: <787DAC8F-5294-4876-9725-096D639B3D9C@oracle.com>
References: <1CC82EC5-6120-4EE4-A7F0-019CF7BC762C@redhat.com>
In-Reply-To: <1CC82EC5-6120-4EE4-A7F0-019CF7BC762C@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7929:EE_
x-ms-office365-filtering-correlation-id: 9a34afbc-9388-4976-a5ea-08dbe6d0777a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJlj95zqVlinw0AK5h2TQOhLP0BGd9ro2IWG/WSu/mydasCgn+caF0BfCrAmH9jkj0qbQ7FbDluJrYwzqA7xa3yMCpFTcCv7EmzV/B9i5Sb99ssjYT/XtMdnURX862rcUwKXiOUT64smajXZ1lmPGIjLK5eFigO9qV+ws8OhPpUV7A71xEqDCWxJvvYhwj4+fDchPrfOPs59fZAzM2nGsWFK6ZSmipCS4AhoWCPz5MeRifjNOwoZPZcQC+G78wkbAnQ9orMtS38DsarObrYZsQtCBdgHFyjNAShUv21A715ToOL0YC9iyGdq4FldaFAFjTRgOHvhsmfJmeBXkkrWdY7Fgpk/BQE+zS7V+iRmGz4F89+3BliiUM8nlDhTQ0Jg/+3iZHurmu+mV4+LH9WRUio8qFVSL/MFsj0kgqso5gl8YU2zyczM929tC+o5hGw2sBIzaW1d1tm0P49lDXjsDjcPEiQJhVmS1KJM3sZp+HuOryv7vwsO76m3Ud+5+8NXibsmK8q/bV83bPSX0OVWXm00sFqAkeRmy7s6jbTrvqseYgsVAB0MzPReg9vLGVxQs33QGekIURagthM9e4E2z6q4pJUrl+GW8eBJE8WlnpFN/7saddP3WzSsxRrQO6cJHdrhxtIqF8bdlxOBf83xOKu3gZJZT9+3gGDGn+rX/eM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(71200400001)(478600001)(4744005)(38070700009)(6512007)(53546011)(2906002)(6506007)(6916009)(316002)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(5660300002)(76116006)(6486002)(966005)(66899024)(41300700001)(38100700002)(36756003)(3480700007)(26005)(122000001)(2616005)(33656002)(8936002)(4326008)(8676002)(83380400001)(17423001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3hlS0x1K3l1MTNkL2Rod1dleHVJTlpvNUFMNjdUelZ5Y0lvdzd1eTNrakhl?=
 =?utf-8?B?aHhZQzhGSUJOZnowRU1MQUlBdG1VMzhEOXlCN0RPQWhIM3ZSY2ZDK0ZhM1px?=
 =?utf-8?B?MHY2eUV2NVFKQ3MzbTlzelBMQlJXMjFHanMyekxMcnlhV3JGUVNtcmpjelRh?=
 =?utf-8?B?bG5ZWS8yT01lUUF0S0JOd2FwTGhZUVMraTN4aTBVUmJYLys2UmMrTFdLUFBh?=
 =?utf-8?B?cGtYZ1VnRlpWb2poV2FZS28rZUE4ak1hMXB1NWpJbG1ZU08yVVY5WFJzRXM3?=
 =?utf-8?B?TW9pZnBqcDVQTy9CNENHZkZUU0tWWUhIbWYzWnNOQWt3TDFweHpVZ1dhcEow?=
 =?utf-8?B?OXZyc3l6Wng3d0FvN2NrZENaRXd0NmpUSVV2VDM5T21mSXdINkFhZ3dsNzBv?=
 =?utf-8?B?WTNMMEZiUjZJS2pjNzRpbUkrcmMxTHlZcDJlbGhTU212QXBaMjhETjc5NU9l?=
 =?utf-8?B?VjQ3RVpxNG41dXh0Yko4b0VGd3RQcUlaV2NFNnN3bzBPWHZvd3JCQk91VFBI?=
 =?utf-8?B?TjZIQnI3VFYxemNGRDlXUWhKNDE3VlJ2VjVpejQyOU5QM3FaUkx0RnZQbllL?=
 =?utf-8?B?S3JGSXZNbW9lWkRkVjJIaFQ1WWhJb2cwRGZxaElEUGtvWWhEbmlBWXhRcmx3?=
 =?utf-8?B?V205czZoc3dnUXUvL3F6WlJ2aGRUM2Z6ZFRpbEgrM0JvMmphM2V0RjFyeFVW?=
 =?utf-8?B?RGJQa2VoaG8wK1NyTG9mQnFQcklzbW9saVpiUnZNT1JGeGJ5SlUzakV0ZWNF?=
 =?utf-8?B?QmZrOXlEbElyb2FaVCtyUHh6K2phdVVUcnJEOGNIdDI1VWpLRnczYnBMV0VK?=
 =?utf-8?B?Z1hTdk11anVLbFZ6b1o4OTNzbEhHdE5KS2dYUHNCZDNaWnVQY0hCQzU1R2JW?=
 =?utf-8?B?SXdPRnJ3L3I4L2JMdDdDRVFMd2ljd0Y4SmtTcDZmN29pclZ0SFo3NlRUMloz?=
 =?utf-8?B?MU55L2UvWUdKM1V1Z05RdjdHMHprci9DU0ZaeDFPMDVNVDdUazI3eGlvazFa?=
 =?utf-8?B?eWdDM2pZREJvNk1BbHp1MWFPajdCNndvWU9DTVUxd2FVU0toclhZQVhzM1cv?=
 =?utf-8?B?dFhpZGRJbGgzT3Y1dFZ3QTdXRjhHVXBrNjdOK0o2M2JFNkp5czJuZDVTNmIx?=
 =?utf-8?B?WVFUcTdlMTlJTHUrZ0ZUaUtGSExrVWNYUlQwUy9QckJZd3FZeHJmWStwTXBL?=
 =?utf-8?B?U0xNamdycTB4RERmd2pBMGZodnAyR0tTZ2FsUEN2c2NKbytYYjFiMmF6MzVp?=
 =?utf-8?B?MFE4OEMxODYzWjVXUmRUb3FaL2pNOE5VK3pqMzRYU3dLZkxaYm0vZ1IvZGF5?=
 =?utf-8?B?TERxUG5JR3djc1ZhY0tzbVlCb1dLTUNRaW9sY3ZqYjNBbXdaSHozSkRWQ1Vu?=
 =?utf-8?B?ckoxNmF3Y1dXTm9mQVkwY3h5Y1NZNnF6RUlSbzF3bnlaeEJab3l2STJhVzND?=
 =?utf-8?B?QzcwT29tMFVZQnowanpSaSs5TkZVOVpYRFI5RWdqY2xDbmFKTkNsY1l3RjRI?=
 =?utf-8?B?ZVMyZTRtUWwrdUxXUDhSYSs0ZzdGRjB0aTlkbjBua2k0QnNKeVZydU03d2N1?=
 =?utf-8?B?RXFXRTBTRm1ST0g5R2xEYTRpNG1VZk9yV3lGaUNYWTF5TlQ5TncyaDJwVkd1?=
 =?utf-8?B?QzU0NHJob2ExaWVFQU50ZysyTHA0RXIwVFMvWC93UG1ZeTZEc1k4Q3IzWVY3?=
 =?utf-8?B?N0hSSkRLWnBsNTUxUmtuTjZ1YlFiL0VyQVBaWk1XM3BoRG41aGlFZm9abyt2?=
 =?utf-8?B?WU9TQ1dqTURiQ1doYStVN0g4M2VnTm84d2NiclpiM05HRGlvbGFJWFE5eXZJ?=
 =?utf-8?B?NGlDc2Zmb2hiaGtBL3JkUVNyN0JZNTdPTWxvSlQrblRKSzhMdlAzazFGQzFL?=
 =?utf-8?B?UDZFemw4d283eWgrMGFQOXJrMHlLeFcyZDhNTDh6cjFOYW45LzV4QU9CNjBm?=
 =?utf-8?B?cGVYcXptMmhqRGN1L3NRQ3d5eTZQYmtzRGZsT1pJd1dNREI3eHp1cTBwUnBh?=
 =?utf-8?B?dCtnVnNjVlhkbzVnUklHT1FvSGtlU2hGOC81YURSQmdpdDF3NndTbHZHT2lL?=
 =?utf-8?B?YytCKzRHRmtjZDZpUVlEUU11NlU1cGZwbWxyOG5DcTlKbTVHV0VkUW1yNXA4?=
 =?utf-8?B?Mk1EZjhQT2JqMk9uQ2ZhN0QwVE8yQk5vbU4zcXdXbXlHdytwVnRjMlh3Szd2?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F79C5209AAE6D04B8DA010D0F59C1CBD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eL/jBmXExS+pdYAyj+0XDF7iDYcrcrAWzw8gbaswdLwWpjYZ1wLLhW36O4UjzhGO9p578r5nr9xaQrtHtB6m4h0jyTtU5OcgTpSiFDfvU5iPKx0p2oWx+CuDL21MJTgrc5ml4F3Od+EPv5CCPJ4brOLhfwxwJcijlDNgrQJWWPKvo6AAmpvjLXqprZGLV9/VaTFXBgmJSvI28q0KzKKrsbVvzOFPbN2+HAyZkGvDwyr3Chj0jQGbpSD8YdameS9gnAfTRAmydwlO62Tf7Zk6z2kzTy4KfqqPS3NoEAwmI/dAfuX6hjzQNlVWgCR2wVcdIakQXrnE47Vc7J6c0cQXYVOApXXI/qhpwXInWqdOS1aqT9aZHH3kLAEX668uULy0sOiwN2q9AA0fXHXTn69fZhY59N3NR1aIh2VZpHpp7ZiqLiIZWU2GXtUdFbZPddOSstcMquu2IDtgO6PZK46v7qcmPUPJO80NYTnDTHpxo7DIH4YI6OyPv0CNJon6Pu2dwkqgGJIKLv9d0QA4GKIpvssF5MMdEV79bIhKkR0iTpJ98LZFljHohV0GstkDfvhGZetmY+jOtH5skeRZSTpX22c7m1xBXQsacehSAYvp2bo8qucGLehCFsdKJSVcVzrhBoO24l1Ur7J+gO2bUxKgfs4+fO8DsNfVvgyyfBwzVlzWJNjnEZe77fqyQsiXFuyuaHBwuu/7UV+nSPy8ppCC4eZ10HBJY2KdMhu/fV5weajiu5NkF9sX1sAlKDe2POcnQdXyFYZXW9jdur8niiX5mxXLoZ6G+YxT3jDfsqUpUD0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a34afbc-9388-4976-a5ea-08dbe6d0777a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 18:18:43.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOZZSGC0emMK0NhwLuTOsNNutP7YZXTSJil9WYM050U5A8OVK4ShPEUuv/SN+6lUIl9XYUgXf+BIHubcOhqIoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_19,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160144
X-Proofpoint-GUID: LanPlSuUdaidu36qQyxg1I3tS25qhHAk
X-Proofpoint-ORIG-GUID: LanPlSuUdaidu36qQyxg1I3tS25qhHAk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE2LCAyMDIzLCBhdCAxMjoxMeKAr1BNLCBCZW5qYW1pbiBDb2RkaW5ndG9u
IDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IEkgcmFuIGludG8gdGhpcyBvbGQg
cHJvYmxlbSBhZ2FpbiByZWNlbnRseSwgbGFzdCBkaXNjdXNzZWQgaGVyZToNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtbmZzL0Y3MzhEQjMxLUI1MjctNDA0OC05NEE3LURCRjAwNTMz
RjhDMUByZWRoYXQuY29tLyN0DQo+IA0KPiBQcm9ibGVtIGlzIHRoYXQgY2xpZW50cyBjYW4gZWFz
aWx5IGlzc3VlIGVub3VnaCBXUklURXMgdGhhdCBlbmQgdXAgaW4NCj4gDQo+IF9fYnJlYWtfbGVh
c2UNCj4geGZzX2JyZWFrX2xlYXNlZF9sYXlvdXRzDQo+IC4uLg0KPiBuZnNkX3Zmc193cml0ZQ0K
PiAuLi4NCj4gc3ZjX3Byb2Nlc3MNCj4gc3ZjX3JlY3YNCj4gbmZzZA0KPiANCj4gLi4gc28gdGhh
dCBhbGwgdGhlIGtuZnNkcyBhcmUgdGhlcmUsIGFuZCBub3RoaW5nIGNhbiBwcm9jZXNzIHRoZQ0K
PiBMQVlPVVRSRVRVUk4uDQo+IA0KPiBJJ20gcHJldHR5IHN1cmUgd2UgY2FuIG1ha2UgdGhlIGxp
bnV4IGNsaWVudCBhIGJpdCBzbWFydGVyIGFib3V0IGl0IChJIHNhdw0KPiBvbmUgTEFZT1VUR0VU
IGFuZCBvbmUgY29uZmxpY3RpbmcgV1JJVEUgaW4gdGhlIHNhbWUgVENQIHNlZ21lbnQsIGluIHRo
YXQNCj4gb3JkZXIpLg0KPiANCj4gQnV0IHdoYXQgY2FuIGtuZnNkIGRvIHRvIGRlZmVuZCBpdHNl
bGY/DQoNCklmIG5mc2QgdGhyZWFkcyBhcmUgd2FpdGluZyBpbmRlZmluaXRlbHksIHRoYXQncyBh
IHBvdGVudGlhbCBEb1MNCnZlY3Rvci4gSWRlYWxseSB0aGUgdGhyZWFkIHNob3VsZCBwcmVzZXJ2
ZSB0aGUgd2FpdGluZyByZXF1ZXN0DQpzb21laG93IChvciByZXR1cm4gTkZTNEVSUl9ERUxBWSwg
bWF5YmU/KS4gQXQgc29tZSBsYXRlciBwb2ludA0Kd2hlbiB0aGUgbGVhc2UgY29uZmxpY3QgaXMg
cmVzb2x2ZWQsIHRoZSByZXF1ZXN0cyBjYW4gYmUgcmVwcm9jZXNzZWQuDQoNClRoYXQncyBteSBu
YWl2ZSA4MDAsMDAwIGZ0IHZpZXcuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K
