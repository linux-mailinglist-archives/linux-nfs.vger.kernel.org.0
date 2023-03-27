Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427DE6CAA90
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Mar 2023 18:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC0Q23 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Mar 2023 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjC0Q22 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Mar 2023 12:28:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967EE1BFA
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 09:28:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RGOcCR013801;
        Mon, 27 Mar 2023 16:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Yx1bSFgqROA1pAb3FW8HKzfafTk4w3gZtmXPZ9m3Sxs=;
 b=rMHDUUgUa0aGngxx9JMDUV+YQGeFsc4pFD096HrIbGjbGEW5nnWUC8HMHAtlZYqX7QL4
 dXQpa19hqsharqPVhz4o4oLM7ZtlxK1OyB1SvjJjL/sVRUkztJOXPyet6kbC3XOh5moe
 47YrniepAopvBodhb0kIGI3be73gQV91k2f0g+TXKNcVTxQNsffCKjRmb2+mCpDs1/wC
 f1o4zBSBeN5LNpp4xEFlQVvNpwnLOJhL8s1jkHvprQYI+UUXGAF4CCuSPQneZaEtMlG2
 oJDBDs1SR/YrIFd3iec3orMZMc4SgAvqflWY+O+Er42y8zjzWQ+1329Nbq9Emif2YzvI Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkemvr17f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 16:28:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RFDiTs032993;
        Mon, 27 Mar 2023 16:28:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdcwg8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 16:27:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8vAiV86cR3yV7ApMGApXhc4RO45fPGUVahwqSN88MSIJny4zR71yRX5Atl43c0fIYte5pZ7rmOiTMZcfPSSfUbO9xbONgvnehUf+7VydNW5nWSNdFmJpfKRAB3hNvw3V77IST3H7oAKTwNqZE5xu0OtjZiKEz4GhbtQfBMyePF/W6QGGLvQet8Wox3MZQkkjeLeqCEK6bfHdz+m1qB5WMp/PZMHUs1jEVKzcrlMP0Qug2gprUMQ43/hNG5Tk9XqKyN/EIgT/hKpp52jsPf5655amZi87dj7zItSFSUt83obZDPs7P5V/myuULpaiDcATFAGS9LNj3JSRgBQ3nbhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx1bSFgqROA1pAb3FW8HKzfafTk4w3gZtmXPZ9m3Sxs=;
 b=TN1ZEvuzZ6B0PytuwBeNDAkWIOcu8j8qcMjwY6qKy3ea9hH7l0kvayZrMhwVQ8oLFw/v6iS5PwqEkw0yLhILoieqkgupuFtrIjOFUBv701mBNJ307Pe0C73sutY7P0BExH5AphgBZB60TIRxoBBBTA0ycLU88+7YvULRYKPQwMZI50EdOcbbLf4ZrJCky8ZB+eWflUHmV0Mt/y0xjFScuA7R0RupD04kEiH+sULttM86L9Hvl0ozEkYJngZbUVByltUUJ7C6L2zQXsSyyNbXgpou5EqfYabXtPGeGj26bC2ZE0/WuWd/+Te8b8G4rUkB6N/5bjzEMbgSmoMcHBxWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx1bSFgqROA1pAb3FW8HKzfafTk4w3gZtmXPZ9m3Sxs=;
 b=yqLBIgLihGYu28JukbLRgqVEMcvLa8zTuXRbGoYv2C+V+STnM8gYFWGeMOYYRr9mjj++ijDRgM+41xhaql0Cocy3ScLDC5pGtfMINkcNZdQY9DJ7JPiIWY8eQy1z/RkWzEU4bKT//3/RDnVSLDdh8/EUlZiLMQH8nb5hyt2tl2Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6759.namprd10.prod.outlook.com (2603:10b6:208:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 16:27:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6222.032; Mon, 27 Mar 2023
 16:27:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund@ragnatech.se>
CC:     Chuck Lever <cel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFS & NFSD: Update GSS dependencies
Thread-Topic: [PATCH RFC] NFS & NFSD: Update GSS dependencies
Thread-Index: AQHZUczowCdKHKXRG0uubITTu/eUh68O424AgAALHoA=
Date:   Mon, 27 Mar 2023 16:27:51 +0000
Message-ID: <2CC1BD86-2611-4052-B08D-DF255763A098@oracle.com>
References: <167828670993.16253.6476667874038066881.stgit@bazille.1015granger.net>
 <ZCG6tIoz0VN6d+oy@sleipner.dyn.berto.se>
In-Reply-To: <ZCG6tIoz0VN6d+oy@sleipner.dyn.berto.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6759:EE_
x-ms-office365-filtering-correlation-id: 597f92a5-35ba-4d34-7e40-08db2ee035fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZju2uUzLCLWMC2o7crHXLB4MS/lcDvL3NSXdrDVzzYQBKIxyLRe5QPakZIiXBYv9P/xa+vGEkyrhwQuBW0coGA5JU1QrQnu9eIykfinDOEXl53458OGsqc6jHSZwwwlpmhQxYnXvSHEgAAgUJ7Zt4KR0/93XZ1QEEfEh54iYTrXa4TIfx8JLFFe9J5pAUBBZuJJ3FwiqzPzaGNC+5shidG5/fqXTHVM/9SwCk7tn9CvZ5vRBFwX9PR8Vnb3ZrPksMiiGjhe38VyQTr1iXaAQNo5QPoRiRDzUfh8QwH7N1mNWI5IUJRa6qQ5B0TKTD6AM8mXIx6DABQUwa8hSrhD0/V+sY2Ksnffh4rB++I07ihVGx19ulSqliZYx7BIIIkOrwvLTmL3iZPqVSX/8f6QTbwOjtKSWXb/eLrZ3fFLMQC7PnHEflf9iGHav56tbupEm6+qpMFmTXrO5yAp0NQr9IXsdXmtnFOA2qeEhzbENwqvJOColHDk0u3qiVC5Oq/vFsm3cGVL8ofSzujMIrlBusV1w1bUv2x621btl0RPOadYjygguchlTpahEaUd3MePEFv/9BWcNmenLdhrULTtet2PfGddgD/DJX04LmpREUZGvivGLZEWfUAQG8yznHHx3RhYrfK/kE7q7lmdqwktuaRVwKQcLBVRI+yHZQg46X9Harl8vkxvvivpzwFy6C/i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(316002)(54906003)(478600001)(8936002)(5660300002)(122000001)(38070700005)(36756003)(86362001)(66446008)(2906002)(38100700002)(15650500001)(4326008)(64756008)(8676002)(91956017)(6916009)(33656002)(66556008)(76116006)(66476007)(66946007)(41300700001)(186003)(26005)(6506007)(53546011)(6512007)(2616005)(83380400001)(66574015)(71200400001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVVHMzNKU1l3ZTZkV3BZTXhCU200b2Y5eStMSjl5OTFoT3AxY1JrNy9qZzRC?=
 =?utf-8?B?b1czeklKWmZuaWFLR01GN3NXNFdRamRrY001azV3ZlRMTUJ0OUwrVnUydzNr?=
 =?utf-8?B?a3RkSWlzVzJXam4zaTREZkF1eWZTMGc1ZGYvemF6em5oT01seml0RUpBN3Va?=
 =?utf-8?B?dHBMUVVNaWNOOTF5NmFHZTNxUmFRK1BMVU8wQkJ2cDl3RFhFenUvNEgyQWVj?=
 =?utf-8?B?SEx4a2M0UzdLM3pjSWNGVHRxQjA4dW5aU2NWTUh2VTE5Z3ZTaXVsT2xSdjRy?=
 =?utf-8?B?dnJOQ2ppbE8vTGMxUlBabEtLaG9Gb2haSktTUXE3d2tBSzlvOVVpdlFUZyth?=
 =?utf-8?B?aW9XQzd4Yi9EbVY3NExURitXSzVVRXNXZEU3TCs5dzdZdkxxRFRuRVdaaWYz?=
 =?utf-8?B?a2RnbXpSVEVjdWUwMGxmYzVkbHdNUll0MHJmT3RhZWZZUzVray9aMFQwNnpP?=
 =?utf-8?B?QXczSzAxSGgyL3dMWUxuRTlTUkJZTFdvc3JaSkd6SWkxK0ZXRWNEUmkzc1RU?=
 =?utf-8?B?VDVFR1ZwRTQvbFAzWWQrUmt0SDBLbERNYlo0ZCtZR2NCYnA3eTNVdGRNWStW?=
 =?utf-8?B?NkllZ2xGMEhhakI2R0hRenZpSEVFOGZMcmFwdWk4bk1VOExYVW5XU1lHUCtq?=
 =?utf-8?B?ZGZjaTVVbzFLc2o4RWo3QzBmQmNVc2xqK3hheU4weG5YSUFZWUo0Wlo4TWJx?=
 =?utf-8?B?bUhEa01hekdHQTRucUQ4RkpiY1RkYTFNYXZaUi9WcHZ0bkFaT3N3cmxKSzF4?=
 =?utf-8?B?NjFKSHI3dmN4NUpBVmNEUC8wNjBXM2F4eFRRZFVuWEw0b041TllYQlRnV2Rl?=
 =?utf-8?B?b0lmdTJPSnZGQjhwcW03c3k1Um4zVXVpc2RoOHBXa1BhWVZhekM5VGhqZ2Nm?=
 =?utf-8?B?SHhQT3JDVVVIV281TmJpVG9WdkhlRmpodXZkYkNISTg1RlFXUWlxWWFDajVH?=
 =?utf-8?B?alBnY2ppaU82emNzUlI5azJ2aHRldTA5MzVMNDRSWXVTblFJZFAycVNTNnJ0?=
 =?utf-8?B?T0tSVm9iTTVpdkovSldqL1c0akgvVyswclZScDk1d3kramZKeUR1U3FZV3dt?=
 =?utf-8?B?VkNNRis1bjhEaE5ydTlZdnpBZWNTZTgwb3ZXVFBCaGpzT2pVNkRISXIrTm1Z?=
 =?utf-8?B?WXgxRTFrelJwNk5aZ21KdytOaGpwc3lCaTlyZ3NBTkhjVzZaK2pnUUY5TFVz?=
 =?utf-8?B?ZEo4RlpIbVdjcWsyUnpGaXRjcVlJejREZWhWSVlXV0E1eHRSWHgzUEM2dEFo?=
 =?utf-8?B?L0g2QkFnYkJjY0UvdVhod3FQUE1XRThqdU1MWjY0WE1jUTJoc2lvSDI2RnVM?=
 =?utf-8?B?TW1WQk5ObFVoSUlhU0h3ODF0RjNkYXQ3TXZBWDc0SDVISDFFbko4dGducnlW?=
 =?utf-8?B?dVVlQVpMdHFiNm90U09Uclc4dERDeHFIK0Z4eDdzSWdHOGEzbWowZjVoQ0Vv?=
 =?utf-8?B?YmtDQkRlTkhYZW83aUt2QktvblJIblNmcG9iUDlodFdzTGM4MlI4T3B0Wkcv?=
 =?utf-8?B?ZHFZSlQxUHd0L0p5cGlMdjdGdjJrZnc0a29sNE0wWGM4Ui9WNEJEV1UraUN6?=
 =?utf-8?B?UzBJVFI3d1BCRGE1Y256MnMxTm51cklITkdkTEplMlA4Y0p4Z0lCS1MyYnV3?=
 =?utf-8?B?VDRseDgrbGMxblpMYTlnS2s5ckVNRGdyenRUYXJ3aHRiV0JoZ2ZmOTBuSVdM?=
 =?utf-8?B?WGt4SWtNOVpPc1VDdGl4QmNVcGRhTEFWWWU0T2xuODlkS0Y1K1FNVldNZzhP?=
 =?utf-8?B?Q3l3Rm5rWVF0YlR3TzhwQjNqZHVoOUJFY0hVcWMzazBoVlRTMWhEUlpzMFpP?=
 =?utf-8?B?YmxrRzNMakVSL3UxTEhVRkJJTmlzQU4rdGpETmplMDIxZWhxamgvTHVyWldQ?=
 =?utf-8?B?dUhVNWl0cVEvUnA4Z3p0MGJTcEo0WDJNNURlRVNhenZJSHQ5dnBLR0Y0YmtM?=
 =?utf-8?B?dUtwS3NQSkpvd2NFb2sybzI1b0IwRjgvU0RvZnViVTMvcUlxR2dOUGlKUHND?=
 =?utf-8?B?alovSWxjbTFTVUFzNlhldnNWZm5LSE5RR05TQUFjWU5PVUhiS09Fd2ZFNGR3?=
 =?utf-8?B?WWR1TjZVbHRwWkJySW56bWlzU2hoYTlybDN1UkxVSXhJUC9LcFZiU0I1S1Mr?=
 =?utf-8?B?Y3ZubVFEY3luMFhOTmNtRHBRTmRxKzNvMTZCTzRpOVEvQjFndEtTNHZPQkVu?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC372F97E2F09848BFC9C961CC9DAB94@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fuPZFG9dgik+wTUWsDxm6vexnHmqi1yWS0cYucoZaAIzbwuBYocmzKtT66bjss1DBfFxrusGnIR4YX53513OQnCxQL0aVHVlrWctUaUsAsIVjngAfcw/00MmFybbgM+fLSk5Pf/gnGDx9jwYUciri5dWfTA8df4zYMbipXxPK/Z9O/PNMmBaDQ1YWjRBWTeDa216GZWqen0d1ukKqwMvYeS9ZG1HS96wLaGN0ETLDSWZFEN32sk4bdKsudN7AdzZzBJEJndLBDJZubQSjnHpZ1hOJp5RW/dSUBs+fE1yH4pFEx9gOLma9Wv8gjD8vx6LykbW0hGn2A14rdE7gO3i8oYk+gQB/+zll4c6pFH7Lv6aWtubpfIg3DUcHGV+LZKcn4zx7Zvs9KLU7j5t0giCoC3D25+8krvvcuoh2pqJLDhL07RYboFwQaQvVpxtWaJO36RL2IgJOUZEYO1XBu0OA9udNd/qkB9XDwlUQmqdHDYel0z/ELQP0VXLNSr26SEGxXsX0FwjE1oXngtMXZJ0GDqqjjey1nLSoJcAEVqQrHLmuEPYgH80bpG5fSWumAglMRd4Bb9VOmKk6YmTcwsEvJq/mjFqv2TF1784BQDNzjXEWW5KOGnv9ja3fUZ/6ouKeAbOTDqC3CnOI+rf4gOWYqLHS3kKo25hiqfkCbB7f3lUOdFpAyyrc/mmI/FKDeXDqtsWy8+M3NXj7A9kL3n88SrfcrTW6u/lkMdJ1zDruZUqYiXI3mSZHpvduGs38ZP0wAoDd1EIkrgsMcU8hjLddoZcg5KWbRZznAbknwWuhhU0Yar3UQogyD8i9NENPgQVgmWjsfrxM6TWlUr02/LMKMFnfOHNvzqpgR8oNCx33+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597f92a5-35ba-4d34-7e40-08db2ee035fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 16:27:51.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZjmIOAJVMo994OoYozmGpQ+fJznswjvXP1aJ1TYbZH1KgvKso/hNQ2zFMELPhFeMZkeQ9c+kg5JjOSaqssdSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270133
X-Proofpoint-ORIG-GUID: 91cScjyQgtlR5cfBvxiYk5CfZXiKXLCx
X-Proofpoint-GUID: 91cScjyQgtlR5cfBvxiYk5CfZXiKXLCx
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDI3LCAyMDIzLCBhdCAxMTo0OCBBTSwgTmlrbGFzIFPDtmRlcmx1bmQgPG5p
a2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPiB3cm90ZToNCj4gDQo+IEhpIENodWNrLA0KPiAN
Cj4gVGhpcyBjb21taXRzIHNlZW1zIHRvIGhhdmUgYmVlbiBwaWNrZWQgdXAgYWxyZWFkeSwgYnV0
IEZXSVcgaXQgcHJvZHVjZXMgDQo+IHR3byBuZXcgd2FybmluZ3Mgd2l0aCBzaG1vYmlsZV9kZWZj
b25maWcuDQo+IA0KPiBXQVJOSU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVzIGRldGVjdGVk
IGZvciBSUENTRUNfR1NTX0tSQjUNCj4gIERlcGVuZHMgb24gW25dOiBORVRXT1JLX0ZJTEVTWVNU
RU1TIFs9eV0gJiYgU1VOUlBDIFs9eV0gJiYgQ1JZUFRPIFs9bl0NCj4gIFNlbGVjdGVkIGJ5IFt5
XToNCj4gIC0gTkZTX1Y0IFs9eV0gJiYgTkVUV09SS19GSUxFU1lTVEVNUyBbPXldICYmIE5GU19G
UyBbPXldDQo+IA0KPiBXQVJOSU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVzIGRldGVjdGVk
IGZvciBSUENTRUNfR1NTX0tSQjUNCj4gIERlcGVuZHMgb24gW25dOiBORVRXT1JLX0ZJTEVTWVNU
RU1TIFs9eV0gJiYgU1VOUlBDIFs9eV0gJiYgQ1JZUFRPIFs9bl0NCj4gIFNlbGVjdGVkIGJ5IFt5
XToNCj4gIC0gTkZTX1Y0IFs9eV0gJiYgTkVUV09SS19GSUxFU1lTVEVNUyBbPXldICYmIE5GU19G
UyBbPXldDQoNCkkgcmVjZWl2ZWQgYSBib3Qgd2FybmluZyBhYm91dCB0aGlzIGEgZmV3IGRheXMg
YWdvLCBidXQgaXQgZGlkIG5vdA0KYXBwZWFyIHRoYXQgaXQgd2FzIGEgcHJpb3JpdHkuDQoNClRo
ZSBlYXNpZXN0IHRoaW5nIHRvIGRvIHdvdWxkIGJlIHRvIHJldmVydCBpdCwgYnV0IEknbSBub3Qg
Y2xlYXINCm9uIHdoYXQgdGhlIGltcGFjdCBvZiB0aGlzIG5ldyBpc3N1ZSBpcy4NCg0KDQo+IE9u
IDIwMjMtMDMtMDggMDk6NDU6MDkgLTA1MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gRnJvbTog
Q2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+PiANCj4+IEdlZXJ0IHJlcG9y
dHMgdGhhdDoNCj4+PiBPbiB2Ni4yLCAibWFrZSBBUkNIPW02OGsgZGVmY29uZmlnIiBnaXZlcyB5
b3UNCj4+PiBDT05GSUdfUlBDU0VDX0dTU19LUkI1PW0NCj4+PiBPbiB2Ni4zLCBpdCBiZWNhbWUg
YnVpbHRpbiwgZHVlIHRvIGRyb3BwaW5nIHRoZSBkZXBlbmRlbmNpZXMgb24NCj4+PiB0aGUgaW5k
aXZpZHVhbCBjcnlwdG8gbW9kdWxlcy4NCj4+PiANCj4+PiAkIGdyZXAgLUUgIkNSWVBUT18oTUQ1
fERFU3xDQkN8Q1RTfEVDQnxITUFDfFNIQTF8QUVTKSIgLmNvbmZpZw0KPj4+IENPTkZJR19DUllQ
VE9fQUVTPXkNCj4+PiBDT05GSUdfQ1JZUFRPX0FFU19UST1tDQo+Pj4gQ09ORklHX0NSWVBUT19E
RVM9bQ0KPj4+IENPTkZJR19DUllQVE9fQ0JDPW0NCj4+PiBDT05GSUdfQ1JZUFRPX0NUUz1tDQo+
Pj4gQ09ORklHX0NSWVBUT19FQ0I9bQ0KPj4+IENPTkZJR19DUllQVE9fSE1BQz1tDQo+Pj4gQ09O
RklHX0NSWVBUT19NRDU9bQ0KPj4+IENPTkZJR19DUllQVE9fU0hBMT1tDQo+PiANCj4+IFRoaXMg
YmVoYXZpb3IgaXMgdHJpZ2dlcmVkIGJ5IHRoZSAiZGVmYXVsdCB5IiBpbiB0aGUgZGVmaW5pdGlv
biBvZg0KPj4gUlBDU0VDX0dTUy4NCj4+IA0KPj4gVGhlICJkZWZhdWx0IHkiIHdhcyBhZGRlZCBp
biAyMDEwIGJ5IGNvbW1pdCBkZjQ4NmEyNTkwMGYgKCJORlM6IEZpeA0KPj4gdGhlIHNlbGVjdGlv
biBvZiBzZWN1cml0eSBmbGF2b3VycyBpbiBLY29uZmlnIikuIEhvd2V2ZXIsDQo+PiBzdmNfZ3Nz
X3ByaW5jaXBhbCB3YXMgcmVtb3ZlZCBpbiAyMDEyIGJ5IGNvbW1pdCAwM2E0ZTFmNmRkZjINCj4+
ICgibmZzZDQ6IG1vdmUgcHJpbmNpcGFsIG5hbWUgaW50byBzdmNfY3JlZCIpLCBzbyB0aGUgMjAx
MCBmaXggaXMNCj4+IG5vIGxvbmdlciBuZWNlc3NhcnkuIFdlIGNhbiBzYWZlbHkgY2hhbmdlIHRo
ZSBORlNfVjQgYW5kIE5GU0RfVjQNCj4+IGRlcGVuZGVuY2llcyBiYWNrIHRvIFJQQ1NFQ19HU1Nf
S1JCNSB0byBnZXQgdGhlIG5pY2VyIHY2LjINCj4+IGJlaGF2aW9yIGJhY2suDQo+PiANCj4+IFNl
bGVjdGluZyBLUkI1IHN5bWJvbGljYWxseSByZXByZXNlbnRzIHRoZSB0cnVlIHJlcXVpcmVtZW50
IGhlcmU6DQo+PiB0aGF0IGFsbCBzcGVjLWNvbXBsaWFudCBORlN2NCBpbXBsZW1lbnRhdGlvbnMg
bXVzdCBoYXZlIEtlcmJlcm9zDQo+PiBhdmFpbGFibGUgdG8gdXNlLg0KPj4gDQo+PiBSZXBvcnRl
ZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4+IFNpZ25l
ZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4gLS0tDQo+
PiBmcy9uZnMvS2NvbmZpZyAgfCAgICAyICstDQo+PiBmcy9uZnNkL0tjb25maWcgfCAgICAyICst
DQo+PiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+
IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9LY29uZmlnIGIvZnMvbmZzL0tjb25maWcNCj4+IGlu
ZGV4IDE0YTcyMjI0YjY1Ny4uNDUwZDZjM2JjMDVlIDEwMDY0NA0KPj4gLS0tIGEvZnMvbmZzL0tj
b25maWcNCj4+ICsrKyBiL2ZzL25mcy9LY29uZmlnDQo+PiBAQCAtNzUsNyArNzUsNyBAQCBjb25m
aWcgTkZTX1YzX0FDTA0KPj4gY29uZmlnIE5GU19WNA0KPj4gCXRyaXN0YXRlICJORlMgY2xpZW50
IHN1cHBvcnQgZm9yIE5GUyB2ZXJzaW9uIDQiDQo+PiAJZGVwZW5kcyBvbiBORlNfRlMNCj4+IC0J
c2VsZWN0IFNVTlJQQ19HU1MNCj4+ICsJc2VsZWN0IFJQQ1NFQ19HU1NfS1JCNQ0KPj4gCXNlbGVj
dCBLRVlTDQo+PiAJaGVscA0KPj4gCSAgVGhpcyBvcHRpb24gZW5hYmxlcyBzdXBwb3J0IGZvciB2
ZXJzaW9uIDQgb2YgdGhlIE5GUyBwcm90b2NvbA0KPj4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvS2Nv
bmZpZyBiL2ZzL25mc2QvS2NvbmZpZw0KPj4gaW5kZXggN2M0NDFmMmJkNDQ0Li40M2I4OGVhZjA2
NzMgMTAwNjQ0DQo+PiAtLS0gYS9mcy9uZnNkL0tjb25maWcNCj4+ICsrKyBiL2ZzL25mc2QvS2Nv
bmZpZw0KPj4gQEAgLTczLDcgKzczLDcgQEAgY29uZmlnIE5GU0RfVjQNCj4+IAlib29sICJORlMg
c2VydmVyIHN1cHBvcnQgZm9yIE5GUyB2ZXJzaW9uIDQiDQo+PiAJZGVwZW5kcyBvbiBORlNEICYm
IFBST0NfRlMNCj4+IAlzZWxlY3QgRlNfUE9TSVhfQUNMDQo+PiAtCXNlbGVjdCBTVU5SUENfR1NT
DQo+PiArCXNlbGVjdCBSUENTRUNfR1NTX0tSQjUNCj4+IAlzZWxlY3QgQ1JZUFRPDQo+PiAJc2Vs
ZWN0IENSWVBUT19NRDUNCj4+IAlzZWxlY3QgQ1JZUFRPX1NIQTI1Ng0KPj4gDQo+PiANCj4gDQo+
IC0tIA0KPiBLaW5kIFJlZ2FyZHMsDQo+IE5pa2xhcyBTw7ZkZXJsdW5kDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==
