Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1D7874F5
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 18:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbjHXQMx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 12:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242279AbjHXQMi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 12:12:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3065319A1
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 09:12:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OATPFu008156;
        Thu, 24 Aug 2023 16:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ch30rISxZ8koPQHDKjVc755Fpwf1P+wRpSY2pI635ys=;
 b=gtGoHr4sfWZlXTixAXKhK85mbHfGHTsOxOBLKgOBdkizHa2Fsj/Zvc7+066u4i8aM5iI
 YHLFgyM442GIQpffFlSpzju1Nm+amKVmPOeZU5+7wpgN/k2WJSR+EwJhuHMeIqzqexsQ
 a1XoPHgiUGGesXfk6UZOSgIb1gXFp3mRuLbQIhUOOC9HC1rlXma0ewZ67XxtFm2ndDpB
 f42bVzGp9qMVwsrSMJbBHAYKCLId1u3QA10VlbrNGxN+Tr4svxMyco2FCKMfTkUksWXL
 zvCmEqJN3+2kJGZp0pMdjRqBuKB8SKe8XqKB2BE7k+VvtqEog/gpPU/H2F4lNsEO5sPa 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv4k4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 16:12:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OGAmSi035697;
        Thu, 24 Aug 2023 16:12:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ypnjag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 16:12:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeezIjsxHLolSoteZjC15sECurbCePaqT5rJrU8nLm/OlO3ytON7JDY5EvDG1ZQiOqfjBk361D6lW7mt047Q+luwjA8dPKSGyEyOLc6jSN9qLiHaBdKjpaESEYB8PrW5hvN7kYec8ucpWbL7e5sTD94659hfFYxsFVqR2iNEjS4J23GacFu7gbDfCHbIFCBHjW66QyLKCLirz3HNDB2PmijLNTMWZ6zKAK2EOb5Zo/os2gtXKA3UysNJlmPXPG2wEOVDzK5DPeQcOOn/RVes+4PApd/Vbs/x4SvI3lvH0r2cT0d3ULaGPNnKHPhZbYDcVgIkcEs9Oe7Rv+1ZeuOPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch30rISxZ8koPQHDKjVc755Fpwf1P+wRpSY2pI635ys=;
 b=MVPRWVG8SKnyepyt34MBJJDra5uQVgT73WWXDgU+ZalekZUVF6uSawgZj/bLJccPOiI6uQSxjGwsfyji41Ip41kcEAZnKZzCxCaSTjvX8eyP58fGqEV6q2MtCXdf+KfHDgk0x2Ew2tmscTBUuAlsZRHRlgj0PK0ENDA8tUXPkjpSwwc5BMXYhxfnlACIJbXQ9tiVYL6GOHeuHZdcbv9OR2iiSDyYOt3jYoKzr/WRDzrKtvmWpnPorIz9dGNMBhF7dUJmfdQJWBqoo2nDCm20Uy3J+1efYCdjyz5NGBLjhU5VdYgc8GkBzYeDaKBNhX3PF3luEM1WTlGe6zir41LzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch30rISxZ8koPQHDKjVc755Fpwf1P+wRpSY2pI635ys=;
 b=IydmNpjU5An8Zw3lC+MZsZzR3DIVE3cxWq+tgpWa3rRVyNv2Xa+nySHdW4gaHSZ9hZpbiixTeCRSSBqFSaaFMkXKqr040aIpkmEZ3IwmULXJFvfozMnR3Bo3eU4ai2Pkfw1C3rVB30nfuKIanXpOg8jeM3f0w3PvPC3eH+RiKQY=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO6PR10MB5556.namprd10.prod.outlook.com (2603:10b6:303:143::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 16:12:25 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:12:25 +0000
Message-ID: <067a68e1-cd7a-55c5-619b-d64266b5ada9@oracle.com>
Date:   Thu, 24 Aug 2023 09:12:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
 <c02190c39f123a16aeae70fd65a68fba4aa70b6f.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <c02190c39f123a16aeae70fd65a68fba4aa70b6f.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::10) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CO6PR10MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdb0b7a-ae97-4a57-2a12-08dba4bce7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+jGEgaJv7MQFN3DxKEwAKbCAiv2VGi4zE4FiIANq1XlwZjnjwKaqckRZ5AtNYd4Hncy6kFyAoHSBiyHr05U6ahoC78pig40+zFz/suM0msphI/HfsAXTbTYbm1JI0z8l4GoDfOOLY02fjo2EFmROD3XcTTO7gGmRghTbqzNsrFMtjQylo7FxwlcjtdQvXyN+9KWtY/DGYZVNgXzNQRgvjGkPGIrjHPl4jxWsftIZBOhtd4UReJRDzZTaebcvOsE3VosfhiFVZ+cqLRC3WSK/zH4fMosd14m6Lqqc4Yf7z2d1fxsvpbssyK4jUBRk/bnOVl16P/hfSeRYFfUa3Ym7QT0PB0OHQrSrdKj5BY5llGDGHqtgmP+AgKHdvciMxFQX/g/ME2YFM0UI3Y8pSp7mqX5vHRAHZatKpXRFAY1TPo6O4D1PepGBg9zQi3fSM8zRd7K7g5cFA+LBwhD7nyieFQJrSuQ2cS+zyTBZM0aCAWB89a41w0iL4qSqAvzsNIuW+dGRhws/NGwm9kgvP1rNIjCQo1DdfNZXozCwvXa7yvWWpaoe2hyDqrMF7TVoLfpCt5wBd/8CKbBdMB5fTXbFGlNKTo0aQH3/vKDCzS949zXjasIncE1Ms1XU3AAy3Q2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(478600001)(86362001)(36756003)(6486002)(6506007)(66476007)(66556008)(316002)(66946007)(110136005)(53546011)(6666004)(31686004)(41300700001)(6512007)(9686003)(38100700002)(8676002)(31696002)(4326008)(8936002)(5660300002)(26005)(2616005)(83380400001)(15650500001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHkwMnA1OGFPZ2laTTJxY09Dc2M5c0ZheUFkSUt5WGRXZlcwYXU4MXg0eTQ0?=
 =?utf-8?B?K0oxdWR0eUI4YndiQVo0ZFZLQVhQTzk1M1NVK3FJWDlFVERDeWV0M1Q3SytD?=
 =?utf-8?B?R281MjF3SzRnQzdHd1FWTm9hSkFueHE5V2NpZ1ZKcjc3bW4zckZ4QXd1aS9q?=
 =?utf-8?B?c3ppYWhSVHIwNnl0amtHSit1OHozVWpUYisvS1pqa0VJYUk1NDROdzlRZzJu?=
 =?utf-8?B?WTkxbmw3SEtreFpvTkRyc2dBRzBzVTFDam1Hd1VZdVduMFF5SXRFdkRZWUU2?=
 =?utf-8?B?NUliNUszcnlQeXBTSkM2aEpvSU04bEVvL0w5QzFvd2puYmlLcWdxNG1EU0tE?=
 =?utf-8?B?aUVmOE1Ca2FTd1lxU0JmRU5jYTVidWNrWkxpaEE0dzRIRDNpT3RmeTY4WVVv?=
 =?utf-8?B?YTNPYjNuQVYxb0xzZUpIdTR3REwyL0gxbXJoSXZRVnFjTnpNLzJabnBjUGgz?=
 =?utf-8?B?YURWWTAxUWIxUHk2VVdzZThacTF6SFBOMFN2UW12dVRBb3Y1TGZybGtYTlBp?=
 =?utf-8?B?bVFIUjdZTEIwejFUelZSTWozVDRhbkwrZFp6c2s3YW52YnMyTDgvdlJRT05H?=
 =?utf-8?B?RDloL20rOUVhVEJqcjRHR1Q1am1WYS90blVrTnNUZHFlZStYOGFiTTMzRm93?=
 =?utf-8?B?bFRZSTVXRmdPUVdIMFFvTHpyR2w0R2c4SlJORHV2aWZEVjdCcTR4L0V0R1ll?=
 =?utf-8?B?aStnS3RJSnl0dU9jZmpjcVhQbTRBSlVrSC9pdkM1ZDlGZEdXRGZjRVdPaVJv?=
 =?utf-8?B?NjdFb0NtL1c2ZHJpS2VFMlYrTThyVkl1azVRT2V0bmRTN1JFUHNCalJQTVJx?=
 =?utf-8?B?RUNVQUU2T2RMVU9vZ3M4SThkU2wya2JVSWROVGJIK01sUFloRWNzN2g0Z0tt?=
 =?utf-8?B?WVdwbVM1WjBJcFc5b3pheFZuVnZGYkVGRkhxeUp4WXREUVpxTW1KTElDTFN3?=
 =?utf-8?B?eXZTZlBjVW55V3lzbFdXdVdtaGJyVy9NSFhFajZEQXhJeEZubFY4VFA3d2Rp?=
 =?utf-8?B?bUpwNWtML2ZCTWFycHJITGhNL0E1MlhoVFBlQnhlejBaTmVENWtqTUdMaFoz?=
 =?utf-8?B?N3MvQnZUcTByOXp1SmIwYklmcXpCWFMxUkdFSXJ0cjFpbm01YjBYaVdqTDhF?=
 =?utf-8?B?MXJiMTdjemY4WVlqU1JjSmZSYzh4NFh5ODZPVDE5ZzdDZFdaT21Cak1lTVVs?=
 =?utf-8?B?Q3BpUi8waUZJc2dHcXdiR2V0UFJWNDdmRFRzZkNWb0RPbmFYZ1Q5RDhmS3p1?=
 =?utf-8?B?OW5TTmw5NkJDV0JyTys3NURsL0JlZ2NPejU0NVdHTC9xR1gzU2dva3RRVFRi?=
 =?utf-8?B?ZjRhM1J6THVQQkp6eHRta2lnMUp0UkFhaTRDVksvdStoelEyZlU5RDlFU2VV?=
 =?utf-8?B?bk5xaVRqMVZWK2QzeEN0MmNIaWNHRkhubHFxNXFOa05iOWJkQThxdjYzeUo5?=
 =?utf-8?B?L0k0Q1h1clY1RWlIUEhBK3ljd1JQb05YTjRhTGVaanVac1hoRW8zbjhtUFBB?=
 =?utf-8?B?NGtjY0NLZWZKTTFsWmpEcXpVck95bHNuMDU3ZEFSTkpSVDVNV0hsM0VYaDkv?=
 =?utf-8?B?OUhDcVdLZ1dlTGlnTXNPWHhDU2xyQjZ1Mkp6RnhiaGFxS25TVWVmWVRqcHUv?=
 =?utf-8?B?Q3JON3NabHl6QVZQQ0NUOEdiTkRUcEhtMHFGYlFaOGJ1RDZhdGhiZm9PeEsr?=
 =?utf-8?B?d1pCOG1KeUE4YXBQWi9pK0VNLzJpMERaV3dHc0xyV1JlbVI5ejl3cUlnM3BJ?=
 =?utf-8?B?WmtXaVl6Y3o0bUp2dGt4M0lwaHJtMjdVWFJDNjM3SEp2SXo0ZGFsalpMeEo0?=
 =?utf-8?B?YmlaWG5kaFF0djdQUVBwSmlkR2JYSmtldE8wWFF2ai9NQjRRL0VFTGlITi9T?=
 =?utf-8?B?WlpxOW1LaWVWOGt0ajlWRDVzN1FDWW9FSDNhNVJvd05jL2pBU2xqR3p4c2JB?=
 =?utf-8?B?a0F0aDF2bThqeXZhSmM1NHd6Q2k1Q0Y3STA1UVZhci85d2x1c1l1cXA3OHZP?=
 =?utf-8?B?RGZlWnBORVI2Q3FmcnQ4bkZpcFhTMVByOUFLSndWMGFVSEg2WXY4SmYxUFky?=
 =?utf-8?B?THhZajhWZys5dnFBMGNWZUNXK1h4UlU0NTc4dmxsbUJTN0hzdUwweW5qVkt6?=
 =?utf-8?Q?kcJrjAjGgSyHCfaFbA05JCWiU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CP7fxl+cupfFeFQJgQ6oEqW+xnGrIwKDDrxuXk1XzK+FA9AjkvlwLdLWrNXd9xqkpEmtro6JDow4wKATm9f4pYGruXPheJEs5sNMSdQSN2gNFt7BUcpQhZpmPd1eOA8TIU8WNkNszU6KHlBZFUz77SnfDy8PRy/+wZxk8k8hdyrQBCGW//QlciyXnhpATpIYnkPfRta0mcXgqGUR8679vWD1zRvxHdN3Jr5wxCjIwew/1cGVJKo/pctXaIo/skwIg5XON+kQbVI3K8Quox8slrugcM55chCIbO8SgdIwtXX/OER5RCaenaDJIqC/vyerhfMEuSm01BSalAupoNSP4yoM6kNMtY+iLmOYf/UZBoc5wd7MtCb+37kOYrDjyLsXdeBdOfnN40WciEKKn9DTHiEZhTP5tlk0bGybz9+CHSaWmd+gzdAsI7CrtmYiQOo0kH/UcWomsB4qY2mYX3Oa5oFqZ8UhyeYVwHwTiy2GY0HSBSLYFG9oPQGu3l/OcD8tpSeCWX01FJ7PW8BmEljNcMd0uVIDosycBh9XsNSy94R0/jY/a6P7AeTv/fnhe1pdgUNBM4tJv18HOMWw/w7LOMrNIAaCOMIyMMFUy6rFZCzfIn/GL/5adNf4rRytUwQZ111yUS+bw14RzxV9zrNOXim0833HWOJMIe+bpjvB48R6VRJNsxWcgeRoly9qau2QG27CLbZaIwHeaYXLpCXscKW5b/d6N6WbbkCgt37aV1GMe8RRDG9JLf21AmPe51l0/GkJDp4q6lsYyDKkt5Hp3l3SwfgrMKmg55iy2f/hy5iprxvnioAUfpbiU5CW44WEiKaUZpsYgT8Ah8COwkdDTA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdb0b7a-ae97-4a57-2a12-08dba4bce7ad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:12:25.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vivzDR5+pXD3oaCxgM0WjGakM91fhT20DfzEogoJ4UY8NO6zw6HC/En9tDap28X6+lD4NS7mwt2TmIktB3eiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240136
X-Proofpoint-GUID: ECwUZDUdirxK1agudylHJ6_CbneDHZAm
X-Proofpoint-ORIG-GUID: ECwUZDUdirxK1agudylHJ6_CbneDHZAm
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/24/23 9:01 AM, Trond Myklebust wrote:
> On Thu, 2023-08-24 at 08:53 -0700, Dai Ngo wrote:
>> The Linux NFS server strips the SUID and SGID from the file mode
>> on ALLOCATE op. The GETATTR op in the ALLOCATE compound needs to
>> request the file mode from the server to update its file mode in
>> case the SUID/SGUI bit were stripped.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfs/nfs42proc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>> index 63802d195556..d3d050171822 100644
>> --- a/fs/nfs/nfs42proc.c
>> +++ b/fs/nfs/nfs42proc.c
>> @@ -70,7 +70,7 @@ static int _nfs42_proc_fallocate(struct rpc_message
>> *msg, struct file *filep,
>>          }
>>   
>>          nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask,
>> inode,
>> -                        NFS_INO_INVALID_BLOCKS);
>> +                       NFS_INO_INVALID_BLOCKS |
>> NFS_INO_INVALID_MODE);
>>   
>>          res.falloc_fattr = nfs_alloc_fattr();
>>          if (!res.falloc_fattr)
> Actually... Wait... Why isn't the existing code sufficient?
>
>          status = nfs4_call_sync(server->client, server, msg,
>                                  &args.seq_args, &res.seq_res, 0);
>          if (status == 0) {
>                  if (nfs_should_remove_suid(inode)) {
>                          spin_lock(&inode->i_lock);
>                          nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
>                          spin_unlock(&inode->i_lock);
>                  }
>                  status = nfs_post_op_update_inode_force_wcc(inode,
>                                                              res.falloc_fattr);
>          }
>
> We explicitly check for SUID bits, and invalidate the mode if they are
> set.

nfs_set_cache_invalid checks for delegation and clears the NFS_INO_INVALID_MODE.

-Dai

>
