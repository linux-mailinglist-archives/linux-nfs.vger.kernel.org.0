Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD586F4940
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjEBRme (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEBRmd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 13:42:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9898EC3;
        Tue,  2 May 2023 10:42:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342GNm0u022076;
        Tue, 2 May 2023 17:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YMGmiv+5aAmu15iqjI9FsrfCi5GzMx0JR4o+xVwSFEk=;
 b=peOyCYMKMHFdMMyrlnBiPXqCGpAL6LHft5ROW8RhJk9yEvp+I9kxzRX4rkf4D2orZ6wU
 ivE1pBIoteRj1NAHtVX3VCZuUSulZmz56mpVfJUNFVoobE3EkSIquE8gwHbs8NehI5Ck
 GNvNuYtq0PK56tL8VMs1XmjX+HNRWu2RNk0wJoGdB4EQBxG7Ymf23RiHG1nvd7yUViye
 XlBi2wANZ1kLmkyO0prc26/XaVmXmnXDvtVZ9YLmBkPKDXyH4T4RYN1kuIaHLKhoGWvM
 aMSBCpu2K9GLktqZNWX4NKR6PFeFv8GvO5gEE7a275FqXcMfvwmQTHGcHpAUHJFbCvsG Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8tuu5d2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 17:42:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342HWCcE027434;
        Tue, 2 May 2023 17:42:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spcb8pa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 17:42:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yri/6a3GsvckGlXro1gdxfJ6f4pTk9TB0XKdKGR4xDtDzFs4S3HNKsFvQLRkWHK0IzznnuyKcPwpX2sK99/EVQst/wk3Q9nUEDHs81rYaRTVLtwjj6iKIFcnbPIWVp8ui90FVzEETgMFNdDr6aawVv1uU6x9x8xvUusxNT//vH6ncPFsjYyESD00A8Aj4XvTQXBXFDH30QRmZIuxzhCDrynj/8zep3lV97BORzEw7L/QCm3/ZS2Glq5RgRWBavvKCrUk9ARhv8sQz2ajLxRAtteF2w2lWmB6VHTYTXLiOivfpEiSwzRSjIv4ZiLE3NLRkWLm+TspJWWckSsCOhPwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMGmiv+5aAmu15iqjI9FsrfCi5GzMx0JR4o+xVwSFEk=;
 b=Ew593gE/DlaCw+wjHgt9MgETqIJ+oi9cqBEJ607hcgJdKbKgDzsdKA4sAw9VEStI0PE2o19ukWCdM+rFU/WpNw82vAI3C+9Bzo5fnNHuw6FNbobX86neqye6nu9AvGKc3zbPDuXauzzj111TfrgoI8iOs0wjd3ktiJk5guKsX2U6p+qCk2owYGCETeBTb5Ggvpa8xM6w+mIOg2xD/G9It55x/8Xb8fLMxpOEjwtnOnugZCqo8pvqE4ViXzf++OvtI3kcNXVJLNn9mO8q60R9XKcS5PSsdW6htOzOaR0tWRi6pg32GD8euA9P6rvNq7eLbmNRc/2OPhAVxfAHtqs/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMGmiv+5aAmu15iqjI9FsrfCi5GzMx0JR4o+xVwSFEk=;
 b=ZH+4A/YHPFXzPNMmdAoLlqUnkEFR6P+hHiMoBYQMu6ie0fIi9e7i37OaJmfc1tPTR+3H13Z18gUPa6M0t3LkpqTDFDa6UpSGNxDJr6TaxvKwN/NKkGMHfx2uCIb8r3yUxY1bAe82q0C3mHVgXC6Z+6X31gskTa9j3W7/c8x+Gp8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.29; Tue, 2 May
 2023 17:42:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 17:42:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Rix <trix@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: define exports_proc_ops with CONFIG_PROC_FS
Thread-Topic: [PATCH] nfsd: define exports_proc_ops with CONFIG_PROC_FS
Thread-Index: AQHZfRkj6ukyqlF6r0qptWo8Jmx3bq9HQKcA
Date:   Tue, 2 May 2023 17:42:22 +0000
Message-ID: <98D5E8AE-358D-4E94-ABA0-5BA5928C3D73@oracle.com>
References: <20230502171121.2929222-1-trix@redhat.com>
In-Reply-To: <20230502171121.2929222-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5830:EE_
x-ms-office365-filtering-correlation-id: 69479f94-efd1-4fda-85af-08db4b349603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vatlwYdpMgbc9QZLbUfXxahRjG/zhlAVz9nxrI1yUdQyuXJOgBeYSgXPmFBO+TNOf5OtxZCaqIq8t7DVFfkC+0p6609Qpag6YlLYTNAf6bZ5DhhMXXP7hvIuuku/tROsVEzhd+z9YbQ7EyyCxS6+SJYRBJyzN45boa2bI+dm3e57bq08TBwOrgvKNdvF8/55bOoSAO/+GQRkrliyzdcpP38J+p9fBbMWnoIiB8h4bcnhfy9lbWvHgIXjyUwvqjztWE6zB5u0+xhmlk85U14H+yRMqupTN58ZpYXJ/Q5qj+CNwi7nSq76jFqGOPw0mwLj2/PKojAhR0IUj7pZniuZtm0E9STzqlB76nhQCLgfm8mS9jeOT38QCZ5GzVasUDHtN8r6lKI1VDclVzcP2s2ijKA46VXl0IjFXviqfU3CaEXY7p9HSJtQj75jz4gCdYCkpcqJR0C/BHGMz8a6V0IldsupC58ni3T5xd30IjHXqCUDrpUaxDO9J53xsZKVYnJtM0AGlVpj6bQbQfT3G4HjaYIiFCrRhatDFF66Jw24rsS16w1U8h6L9l0+tJRB1QkorgzoJNbJ4xuY2q+N8QvF3GP2BiVXlcAeWuZNxlCQrxL7hByDRRrH53WhKEDzhKyznE4AJVqvvxWKjUmLAqe+aA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(76116006)(2616005)(478600001)(83380400001)(186003)(4326008)(54906003)(91956017)(66446008)(64756008)(66476007)(66556008)(6916009)(66946007)(53546011)(71200400001)(6486002)(26005)(6512007)(6506007)(316002)(8676002)(8936002)(5660300002)(41300700001)(38100700002)(2906002)(122000001)(38070700005)(86362001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWh4TjdXcW15RFpvNnd2U1dvQ2QzSjhaZnZQdExjL3EzbEt1MWhvUC9lbjFt?=
 =?utf-8?B?bWlIeFZtcXZWeEJGMWlsRTllN2pFS0gwK2oxSTRZbWdRdkpaM2dsUGVTTFJ2?=
 =?utf-8?B?VlVMNHBZc2RlZ2JGaU11RzhnZXRKWklBeFpORHE3cnpYYS96Q2FIbHdzM3gw?=
 =?utf-8?B?MmFhM3dkQmVhSTVUT0E0OFoyUWhGcllkNEZyZmZXSU52ZnBCT2lrNU5sZVl5?=
 =?utf-8?B?VmtMamVEVFEzcmlYOXNCWE5UWWZlV0NtVnBPd09YdGE4L3ppNkdFdDYxT0sw?=
 =?utf-8?B?NndPM3hjSFozRU42dzBsQXFIK0x6cWZxemNJQjhjdEhpekwwd1BMZjJFZWdR?=
 =?utf-8?B?QW1mR1cvNU14cFhaclhkUmVOUzBNQmVQUythTzJocmkyT08xWnRheUJpWXBH?=
 =?utf-8?B?SEx2ZWd5RllXTDIyYzVxdHh4WDR6cGp1bERQUFg5OC9Jc3p3NUZGS2RtaEho?=
 =?utf-8?B?RjRraldzRjZ3RlplakhjR2JLQVR5Vk9YeEwvc2E4SnlGdStzSVhmTnBPbVNJ?=
 =?utf-8?B?Znk4MDh4dG9lZkpMQk9Cbkw0NkFpTlNjWDY0SmplYWgwSGkrdGRwMFQrSzJU?=
 =?utf-8?B?VzQ0L2R1R3pUSG9WZWp4dFRzV0lNdlhRa2FqOGRrd1gvaUtjZ0M5UEJZNGZN?=
 =?utf-8?B?WVlPYzNmeDRYQ1JNOGRRbEplcmR4L3RHdkRnVElKMnNrSU1zS0gxeWFFQ24x?=
 =?utf-8?B?b2huN2IvOHZON0ZQS1JDbkgwVjR6b2VvZ09JRytmWlhCR2YyVnZNcVpDc3Zv?=
 =?utf-8?B?eGlMNVJkYXZ0UzE2Y2tmUjcvbFlUbGJuWUFaTFZOYmtvSnk0VkJ1K05kMmdr?=
 =?utf-8?B?Ukpyc2RTZ3VtSjd5Mk8wdXZsV1MzTkxDM0FlVmpIekVtR09YVE5BRmh3TUY1?=
 =?utf-8?B?SFJ0ZWtmZ3doL214Y2NxODJ0cWthSGM5dXRqR2FGblpnMWNzcDF1a3RKWkRt?=
 =?utf-8?B?b2NLRGFjMVdrS1c2OGpoOUlUcFpndEpDUGtpWWJzRGFqY1J0STVMRmNqZm5N?=
 =?utf-8?B?MjBmZFBJejhYVlNwcVlORzZKZ3MyaHVQU3MvR0szRTYvOFRMVW9rUWptU1VE?=
 =?utf-8?B?Q2lkVnJSU1ZRS0xCZk9yZmJZQjR0SUxWT29yb3FEL3lxQU92T0djeGVmVXky?=
 =?utf-8?B?cU9rNlFJUG5SbzFadjYyUVBwbDh1dm8zSzlzUE5jbktId2RuSGhvOGRWaE5R?=
 =?utf-8?B?Mk1BbnBibHNTYjh2QkdNMW5ZVGZxblNnOVhaM1hsOHkzeDU5MW14bW9FVWJx?=
 =?utf-8?B?cUxJWlp5cXFHc2NtOHlPMkY2VmIweXhQbUlaSXNaZ2xjZTNrYStGUnJKWU9m?=
 =?utf-8?B?QVJMVUNVUWtWSk03bFV2N2hKQnc5MDJ2ZEpwSVVjWmp4S1VqYVhma2lsOUlm?=
 =?utf-8?B?NURiWXh4SS91aDUrM083QUJmdU9Ba2xIb0lqejFIS2I2d2lRa3hVNURaZFlN?=
 =?utf-8?B?NFhQNWFpUENIa3FrM2cxQWttYjR3TUxWRENkc3Y3UG9SWFBXZ1FzZFMzckJO?=
 =?utf-8?B?YysyRzlia2tMaDlLZXJSbExWMTdXNW1UeGVWRS9NLzAvZlk5cVJTMnQvN0Zx?=
 =?utf-8?B?RmpSaVVhMUFXWDRxUlhJeCs2bWRYT1RWeUx2czl6VmVjRFVPR3VIak9XdWR6?=
 =?utf-8?B?cDhlR3FyMFo1TXQ5S1c4U05JYnJtMGNUQ3F3dzdpMFpaTmFmUzZoL0V5R2Jp?=
 =?utf-8?B?NUc4aUhoa1dicGNDbCtXZ0l1VXN2VkttUXNKSjJ4RVpTWDVVeVJlWHZKUnc3?=
 =?utf-8?B?aXVKaWNQZ1ljSlVGaW1ycWtrck9sUDM1bFJpdFBHQXYzbmFmU0k0RWRKSEYz?=
 =?utf-8?B?WFFpekxySVdpSS9QMEs0Z0hqU296NHFtWWV5Rm5JWWg2a2hreGphdWsvZ25v?=
 =?utf-8?B?d21HWEZWazVKU1dzSUs4K3RWMkZBMmVzTUpUNjNuWDJEU1NCZ1R6QWFDWGU2?=
 =?utf-8?B?aUZkOUZuajM1Rm5HLzI1N0VOUnU4clgwajYxSmxvVlBtS2V6d3hZSHV2Qjlx?=
 =?utf-8?B?Z3BnNnBmVjBWdm51blhVSzFGbk5ZZDFnK1BtcUM1cGYxVHNzNHJPenJ6VEFu?=
 =?utf-8?B?ZFE1dTQ0MHR5R1ZNRER5Wlh0Q3NtbEY2bUtnbkxSVnB0eGZSV0E3a3ZydVd3?=
 =?utf-8?B?MGIwN3pJZ3RRWDEzSHJjWnpjY3lZNStQaWxFcEtKYVYraE5Za1Z3U1hXcDNn?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA2FCCF60DE6484DAEFF59AD73A7E05C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SAW7vKrRKFAGiQviir+1VlVKcfIp0+s2129+f8fNNyTbn4i55vDDbLE2uiSjGEo+GNtUvPqTesuZWsDXigi/gLRv+J4qFgydLrMGKWNQPs2Cv7ThFIUeLlQ9YG6qNKODiqCSWZf1i4RN6sI5ZfFrdjRo7rU8LFBSg7niIAMowKFeEdg66jVQNp7xZtbc+RhaAn+oCN+91KZ18/SNOPfODEeigG7jyez9baqoCLEL1DI9j8nfNnHkUwDFlPzNnBfEp5rIecX1vkdrNC2YACCMo10nLb6UghOZPxeOkVV/J8h30RK2oMZnDaSnsRvPSMDb5QDODt4MDdQbLLWWB3AHoLJzxkUY8Fvd738MhlyzEOLcvy4vEuNq+tM7SWQE7wY9ggBV+RP1VAta4kTxY3gJPoxDIIcSB0MlqRjKwPHBJHMMi1IkErzg5Vbglnx9MlYRfmgcQ87/iqBoYA39cC4sCZNHZveGn4YBzGRyX1MjXFvP7CtQZ0eWro1S+2urGoLt70QXYCc6+7tv7b+iAIEbixNr4xV8xUl1uCX0PK2CCJUYx0tEKnW0IaTV+xxkw1XBX+R0wuMua41QBCL7WtJXPlFHERVrFWrl5bLHsVbxbPaqCXeCfJEgoZjYLqQmduPZLa6TDjRVVmpW9N4yHwxd9+/IDE5DcovsQOo5htMOYMY/iJoK+I15dWcyEiJo3Q+0t1NH5y58QlLY2f73p1UFut5T9fDt9poXT2rNqubtFYn/IDG/2NTlY0VMY+6G22s6UffircfREuTZwkSVaGlZuiE1QqPS8UE2HqeJC02MjX0k8Qf9N+ut+Tvz9lmxvNNb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69479f94-efd1-4fda-85af-08db4b349603
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 17:42:22.9880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4rZT6pbYMBPGD+RdzOJ8dmNxPEN0CQeLYJKn5EevRIuwcJ3KWbp5pJBgB5rF405zH3Tgt3xWFVuhRLEL//Wmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_10,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020152
X-Proofpoint-GUID: 97SwhbNnPlwLPXiF-tvryllEeV6ZXFYE
X-Proofpoint-ORIG-GUID: 97SwhbNnPlwLPXiF-tvryllEeV6ZXFYE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWF5IDIsIDIwMjMsIGF0IDE6MTEgUE0sIFRvbSBSaXggPHRyaXhAcmVkaGF0LmNv
bT4gd3JvdGU6DQo+IA0KPiBnY2Mgd2l0aCBXPTEgYW5kICEgQ09ORklHX1BST0NfRlMNCj4gZnMv
bmZzZC9uZnNjdGwuYzoxNjE6MzA6IGVycm9yOiDigJhleHBvcnRzX3Byb2Nfb3Bz4oCZDQo+ICBk
ZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtY29uc3QtdmFyaWFibGU9XQ0KPiAg
MTYxIHwgc3RhdGljIGNvbnN0IHN0cnVjdCBwcm9jX29wcyBleHBvcnRzX3Byb2Nfb3BzID0gew0K
PiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+DQo+
IA0KPiBUaGUgb25seSB1c2Ugb2YgZXhwb3J0c19wcm9jX29wcyBpcyB3aGVuIENPTkZJR19QUk9D
X0ZTDQo+IGlzIGRlZmluZWQsIHNvIGl0cyBkZWZpbml0aW9uIHNob3VsZCBiZSBsaWtld2lzZSBj
b25kaXRpb25hbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNv
bT4NCg0KUHJvdmlzaW9uYWxseSBhcHBsaWVkIHRvIG5mc2QtZml4ZXMuIFRoYW5rcyENCg0KDQo+
IC0tLQ0KPiBmcy9uZnNkL25mc2N0bC5jIHwgMjUgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0K
PiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnNjdGwuYyBiL2ZzL25mc2QvbmZzY3RsLmMNCj4gaW5k
ZXggN2I4ZjE3ZWU1MjI0Li5jMTU5ODE3ZDEyODIgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mc2QvbmZz
Y3RsLmMNCj4gKysrIGIvZnMvbmZzZC9uZnNjdGwuYw0KPiBAQCAtMTUzLDE4ICsxNTMsNiBAQCBz
dGF0aWMgaW50IGV4cG9ydHNfbmV0X29wZW4oc3RydWN0IG5ldCAqbmV0LCBzdHJ1Y3QgZmlsZSAq
ZmlsZSkNCj4gcmV0dXJuIDA7DQo+IH0NCj4gDQo+IC1zdGF0aWMgaW50IGV4cG9ydHNfcHJvY19v
cGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KPiAtew0KPiAtIHJl
dHVybiBleHBvcnRzX25ldF9vcGVuKGN1cnJlbnQtPm5zcHJveHktPm5ldF9ucywgZmlsZSk7DQo+
IC19DQo+IC0NCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgcHJvY19vcHMgZXhwb3J0c19wcm9jX29w
cyA9IHsNCj4gLSAucHJvY19vcGVuID0gZXhwb3J0c19wcm9jX29wZW4sDQo+IC0gLnByb2NfcmVh
ZCA9IHNlcV9yZWFkLA0KPiAtIC5wcm9jX2xzZWVrID0gc2VxX2xzZWVrLA0KPiAtIC5wcm9jX3Jl
bGVhc2UgPSBzZXFfcmVsZWFzZSwNCj4gLX07DQo+IC0NCj4gc3RhdGljIGludCBleHBvcnRzX25m
c2Rfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkNCj4gew0KPiBy
ZXR1cm4gZXhwb3J0c19uZXRfb3Blbihpbm9kZS0+aV9zYi0+c19mc19pbmZvLCBmaWxlKTsNCj4g
QEAgLTE0NTgsNiArMTQ0NiwxOSBAQCBzdGF0aWMgc3RydWN0IGZpbGVfc3lzdGVtX3R5cGUgbmZz
ZF9mc190eXBlID0gew0KPiBNT0RVTEVfQUxJQVNfRlMoIm5mc2QiKTsNCj4gDQo+ICNpZmRlZiBD
T05GSUdfUFJPQ19GUw0KPiArDQo+ICtzdGF0aWMgaW50IGV4cG9ydHNfcHJvY19vcGVuKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KPiArew0KPiArIHJldHVybiBleHBv
cnRzX25ldF9vcGVuKGN1cnJlbnQtPm5zcHJveHktPm5ldF9ucywgZmlsZSk7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcHJvY19vcHMgZXhwb3J0c19wcm9jX29wcyA9IHsNCj4g
KyAucHJvY19vcGVuID0gZXhwb3J0c19wcm9jX29wZW4sDQo+ICsgLnByb2NfcmVhZCA9IHNlcV9y
ZWFkLA0KPiArIC5wcm9jX2xzZWVrID0gc2VxX2xzZWVrLA0KPiArIC5wcm9jX3JlbGVhc2UgPSBz
ZXFfcmVsZWFzZSwNCj4gK307DQo+ICsNCj4gc3RhdGljIGludCBjcmVhdGVfcHJvY19leHBvcnRz
X2VudHJ5KHZvaWQpDQo+IHsNCj4gc3RydWN0IHByb2NfZGlyX2VudHJ5ICplbnRyeTsNCj4gLS0g
DQo+IDIuMjcuMA0KPiANCg0KLS0NCkNodWNrIExldmVyDQoNCg0K
