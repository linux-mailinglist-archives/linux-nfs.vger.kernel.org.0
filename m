Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE15F64A803
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 20:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiLLTRN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 14:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLLTRM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 14:17:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC24F5BE
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 11:17:10 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGweS0004132;
        Mon, 12 Dec 2022 19:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jqtYBovOKRdPmPS34lPs8xoKqUgZLgG78vH9wjZ9vb4=;
 b=wxDDWNh8mfMlDi+qsLbHEIxvvUcOuW5QUX8JedcEGT7zkgz7Qd8J8x5RCVpl970GY38v
 tKA1JtSVZ72W4TOhGWZCUMRYeXkyCJmlWnB2jUtrgi5d4svUkAnGW4nCgg5NKFySUgFx
 e/n7K40fyEqpp0Hd74LSN5hyY1KISa1gm7ewVEnXppSmWyM6vqrhzzUsutQoTwp5/8F2
 rdqKMiiILw2GVdcBrSSucGhoUD/5PKrnu3mfDGxcjSjyG5bbhrsC+yyNBTdi11lpgpKq
 0n0H6sj4nw2D1w0Zx2V4fVl0Ge+OgY2owZpGEPt5ViOT9KQ+XnS3GOX3dBWzdonUiX4O ZA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcgw2bnxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:17:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCIrIMf033043;
        Mon, 12 Dec 2022 19:17:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjb1dgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:17:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtMhLhxeNpIhuSidADbktuVNWoYia9OX4P9YXiqO86/b2r68aDI+Gacsrj5WDOqrlUPbV40I4umKK9DqOG00stj2DRLDWr6/bDZUy8Jbrl+EzvBOVIBQgAkMsKXkcFXgXezG991+ujKO7ytiVa+b4AAE63axtP7o7v8Mo0HMJl8tgs2LkEyZOKmFJRyAmgtyLiY8H9RIIXkiqCLyr00tTie6K0cFCCPepTpYFSO2yp2fIwbOzu5wx/yINeJPX2u+G093hhTpR6tbFoE121AEM8JDBkm9dMnpdQu6rsQCfugYmgLHPLFgso7ysVsemHJzdGP+klqxaPMr2VpqoBgKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqtYBovOKRdPmPS34lPs8xoKqUgZLgG78vH9wjZ9vb4=;
 b=jzyfviergbbg+R1LjxENYMrocwa6gkPATtqX1rvz6qhwp6UAgU8+2GefgRTYo4vkVMaMxR1SUrxgWzU6xIt5bIucVtUhbk/x90KUbehRpSsYSIl09YGK/rIlwHcRH5r/zvi8j+QuD+HgO/qTYDjAcX8ZGC/HzWzwlgr2ClIA+JzU8qMjkVcjNKnnOckAJnA7pKTMRPunzivdavU7SVOzhoKbJrH4FZ0KHjsEiaO0AqoBZzo20jUenggVypujl4Fer1lp3smV31JMTF4bdcfoBxgb00VqfbspDqqtWdXqvcTEw7WAq+AMBw3542Vqxml/QjX8kXC6znTHZ0z6qDJaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqtYBovOKRdPmPS34lPs8xoKqUgZLgG78vH9wjZ9vb4=;
 b=wqHz+3TJ78tw3mYaZavU+6HqyXwVR3EQXTn5QDiKc6NClgDvjWijhuhR9rKrSD98ibN7GVgtPXCHmKuUBjz7hqCLi4cGoSC+J80/uJId3ySh7HSUGGLSD0mSLGscU/4NCmaXKdsI55x/Wp8P8kmH5z9s+yapfaH1O5+g/ClPp7U=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 19:17:01 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 19:17:01 +0000
Message-ID: <a895cb89-f8f3-a2e1-1958-cf9379ecdcd5@oracle.com>
Date:   Mon, 12 Dec 2022 11:16:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        "hdthky0@gmail.com" <hdthky0@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
 <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
 <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
 <Y5czwRabTFiwah2b@kroah.com>
 <a47cc610af621e95ba359388e93d988f1ef5b17f.camel@kernel.org>
 <Y5dha1Hcgolctt0K@kroah.com>
 <7365935036c192bfc64cda41cb9ccb297e3eb86f.camel@kernel.org>
 <6D5F96AA-A8A7-4E19-A566-959F19A3CB0A@oracle.com>
 <6200943464679d51de50a05ab2ca1cc0c91d8685.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <6200943464679d51de50a05ab2ca1cc0c91d8685.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0074.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DM6PR10MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: bc66ead4-99d7-4210-fef4-08dadc75722c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxcVWzfd9+67lCsoqBoR9FvFZqCUUplXwpLbunyUnBY5O9SRMDUklHFuNEGpaigs0Kr7978DOglrsZutgSu2bIpl3kKCl/qYTugiKHkD9l/xtpWoYsI3jTSmI0KuOvSwB3cfAj7/Ie9aAd5ic0u5Wg9TnsG0er6Q6QkfHeSBnZbJeoZBHAUHMVGD+QZDS3LR81i2OB1Tkz9ebDWQCEbSAy1g5szmXreHkMicM+EXyJnojpfDQ+006vD4he3ZeFUWRpssmx4CRe7R0GXc9W4yRQ08MtDpaSk9S8s0O3YCyw16ntZsx/U5ETZLbkgOCF0DeacqUjggAAFx29c9UzgI9yLaBc3WJyzq3dLSDkd1FoQstjP4poXlVHDy7WXvtlAf2LtXEdR8pDh9WywgG6e6pRuOHI+AMZbveEIu3cxBG3r+q63oi1StV/AW31CmArgD3zc1p/bL/WGyIYS82peajKC0TfB1YgxI0kzwLr+06IxPlyPxyDzwp51Ep1qonW/cfa20Ip3BqRNoqNRYxxdURfbbMrUmbdRGg4URYFNrJ2uAO6URNjY25CoO5JNzMqTOuua77f87ZGUsOA7/h0VDD9AAePy/wauNG8Dk4JOQIhizfqpJ4ZUgxpsZMqVlEvxazX1jTqnrPYREUmjA/FaVjtHFBO9snsf2eozXClH9Eli0qY0g+24VLsIglknnNmdmspz1zsGztxj5OFzenkHZtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(36756003)(2616005)(110136005)(66946007)(66476007)(8676002)(4326008)(5660300002)(316002)(66556008)(66899015)(54906003)(2906002)(4001150100001)(86362001)(31696002)(38100700002)(41300700001)(8936002)(83380400001)(6666004)(31686004)(6486002)(478600001)(6512007)(9686003)(26005)(186003)(53546011)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHFZaGhDNmRYNExzUXlmTUV3V1ZZTmQ2R1k5ZzJsUWt4ZjRmb2k1cEUzWlEx?=
 =?utf-8?B?M0ZESlJVQlhoKzY2SmJraDNJOUFrRjRYMnFTbE8wbGFNeGZGSk9wK1N5RHEv?=
 =?utf-8?B?OGRqS1Z3RWo3R3JYOHF2cDh6a1dwT1ZKZDJuZGJyZXlJUWZxQjU4VlBtamVo?=
 =?utf-8?B?MG41Y0F3OHA3TzhiYWgvSCsyTFQzM2NXZW03UGppQXJub1pKaHBBamJYb1VV?=
 =?utf-8?B?NjM4aEEwMnlRcnFoR21hTGdQbDV0a05CZnpBekxGNWQ4QWZFMlp3cy8rbTdj?=
 =?utf-8?B?MWlBK05yayt1VVNUbUxXTEtUVXAzaXpzblFnTjlORDQwdTlYa3Q0ZFpGZzFt?=
 =?utf-8?B?NXRoVXdGQzBNNHZnZlpnSlkxM0xYdVFsa0VXSTFQU0huQndJQTFPREVQRFpS?=
 =?utf-8?B?Y1JJaUJ0cEc4OFNYTHNzVjhzakZBcTJSZGMwa0RRalRrM0tjU1NWeUUvbTBu?=
 =?utf-8?B?N09mZE10U3ZZL0JMQlprTVdEMEtscnV5Q3ljN2VSZTJOYUhsaDllakIxdlRR?=
 =?utf-8?B?T1FVMmF5eXo3S08veEhPa0xlcVE2MDVwbDFYUFIrMGl6RFRGSFFHTzl6R09N?=
 =?utf-8?B?NzM4Qk1ROE9KMlFsL0R3NDQwUm8xeUszelNtemlVK2ppQmNuM1NSclJObTkv?=
 =?utf-8?B?aEF2Smo3SjNMWUVJVDFkd0s0UzltVkJGUFNITzhiZm1SN3ZGZzl5d0JuajV3?=
 =?utf-8?B?OEgrc3FpWkN2d04vc1k2citTMmsvRVdvZndPWFZ5dE9MU3dTVlJ0Q2VjNVFR?=
 =?utf-8?B?Y2EyMDIwMGZzK0ZsUXNtT0VLdnhZRWtuN2dpZC9XTGljZGFwSG8wMjlOTTdr?=
 =?utf-8?B?RjJDbGhOaU5ZTGRvUllTSEw5OUNVNmdsRHZOUjZWZ2RJcHNoU0g4YWhOa21i?=
 =?utf-8?B?VWw1RkZvMjhSMFk1amxsL3NXa3ZId25WMmRVQytTc3cxMG53bE11cVdldUly?=
 =?utf-8?B?UFlzdG1HYUZGMkg4d1NGcXZ1SVVMdHhQUzlHKzgvR2srYnFZRzdXSXNUYzEv?=
 =?utf-8?B?bUgxUnZpdzJJQjRyTkthcGxsSmJ2cW5EdndVc3Q4VmVabndaTUtSazN2RFNB?=
 =?utf-8?B?cTRxSUw1SE4xcENZNFVWWGJxN2J3UTRzeEZNUHNFTEpuVDBrYU9FQ080bU5M?=
 =?utf-8?B?TE9KU2lwMDlYQk9xL0FGYXJPTmJhTkFQdHkwNDdUMmhWcVBTNEpnRGlwWUdW?=
 =?utf-8?B?T0lPWnIvVlRleFhUM25GaFNxT0lrM2txZlNmejZyTVBXM0N5OENadG85Nnlj?=
 =?utf-8?B?L081UEs5NnNlVC9DV0pxZzFrT3ZOb25Yc01leURPdTlHUUU3TUErOEpuZ0tC?=
 =?utf-8?B?NFFEc3VialNGbnlFdmQ0YUYzN2lZYmEydHlQRXlHdlorRGlwaE5RbVJTWkFu?=
 =?utf-8?B?K0VuTHBHVUR6WVFvandiMTE4VDIvc3NEOVlBWTg1cnQ4R1IvR0IrUnk2QkdC?=
 =?utf-8?B?dDlOYXJEUVdJanRZZDNDWXFOdk9VSTlEY3p2UXhtbHNvUkE4eVZiRDc0RWxZ?=
 =?utf-8?B?RmgvQkVORmdxNTFCMFozSHJaVG96RzBGemFxSjNiZUwxRUJUTlpVQWJidTRm?=
 =?utf-8?B?YzZPNi8rUjFCN3hSbFk1c0ZMR0dpVjVBblBETllueE1ncXJoNGNZMUd5dlkz?=
 =?utf-8?B?Z201NGgwaUNpYWVwRHoyRWpaS1VFTWFqZnA5Mmk5SC9Pc0IxbEd5aTZ4NDVI?=
 =?utf-8?B?anMvcXJBUlcrNGpTbWp5c3dPZEQ1bmpxNVhyRnJmcXgxOHlHZ1o3dGxOSjBn?=
 =?utf-8?B?Uk94cHlGRkxsbnlEM0ZPUDgzeTM3aHF4c3I3MThnL0Q4emZ2WVpvYmt1akNu?=
 =?utf-8?B?eE1JMU1abnFRckg0cnB6UTk0K1VYV2s5WkJLR01NZlFwcXZFaEI0ZFZISTVW?=
 =?utf-8?B?RDdqbHQ3dSt3NkJoYUxuK1JOYzNwNGpYd2k4d0wzZSthaXdWdFRkNzNWQnNa?=
 =?utf-8?B?aWp1ckdwZU5hTHlQSnZCSStZQ3JGT2lleDNjbXZoVFI4RHZ1Q08wS2NLUlUy?=
 =?utf-8?B?YXdKdHo3TE5hbUVlc0JLSDhjc0NaYzRrcERVZVVDajdKeUJva3JWSDdlVUcv?=
 =?utf-8?B?Q0IrOVR4QUxlbEt5Y0pqWmhTQTM1Rms5VTN5Njg4UmRlSTR3RDBYSTlCMUV6?=
 =?utf-8?Q?voj3c/p7svSFQe6FYAmVqM6Ns?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc66ead4-99d7-4210-fef4-08dadc75722c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 19:17:01.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5v11vTCd306j3JHwWBF/1d3fToeQBk1nnFkI6ZRhLNXpz2Lpsrv6ktceqouDGXM9/GU25RyYL5Y7qKKOVZvp8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120173
X-Proofpoint-ORIG-GUID: g2mNlaG4sCfUChFzK5TtCrD5Ui2BSypz
X-Proofpoint-GUID: g2mNlaG4sCfUChFzK5TtCrD5Ui2BSypz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 12/12/22 10:38 AM, Jeff Layton wrote:
> On Mon, 2022-12-12 at 18:16 +0000, Chuck Lever III wrote:
>>> On Dec 12, 2022, at 12:44 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
>>>> On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wrote:
>>>>> On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
>>>>>> On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton wrote:
>>>>>>> On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wrote:
>>>>>>>> On 12/12/22 4:22 AM, Jeff Layton wrote:
>>>>>>>>> On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
>>>>>>>>>> Problem caused by source's vfsmount being unmounted but remains
>>>>>>>>>> on the delayed unmount list. This happens when nfs42_ssc_open()
>>>>>>>>>> return errors.
>>>>>>>>>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
>>>>>>>>>> for the laundromat to unmount when idle time expires.
>>>>>>>>>>
>>>>>>>>>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>>> ---
>>>>>>>>>>   fs/nfsd/nfs4proc.c | 23 +++++++----------------
>>>>>>>>>>   1 file changed, 7 insertions(+), 16 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>>> index 8beb2bc4c328..756e42cf0d01 100644
>>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>>>>   	return status;
>>>>>>>>>>   }
>>>>>>>>>>
>>>>>>>>>> -static void
>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>> -{
>>>>>>>>>> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>>>>>>>>>> -	mntput(ss_mnt);
>>>>>>>>>> -}
>>>>>>>>>> -
>>>>>>>>>>   /*
>>>>>>>>>>    * Verify COPY destination stateid.
>>>>>>>>>>    *
>>>>>>>>>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>>>>>>>>>   {
>>>>>>>>>>   }
>>>>>>>>>>
>>>>>>>>>> -static void
>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>> -{
>>>>>>>>>> -}
>>>>>>>>>> -
>>>>>>>>>>   static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>>>>>>>   				   struct nfs_fh *src_fh,
>>>>>>>>>>   				   nfs4_stateid *stateid)
>>>>>>>>>> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>>>   		struct file *filp;
>>>>>>>>>>
>>>>>>>>>>   		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>>>>>>>>> -				      &copy->stateid);
>>>>>>>>>> +					&copy->stateid);
>>>>>>>>>> +
>>>>>>>>>>   		if (IS_ERR(filp)) {
>>>>>>>>>>   			switch (PTR_ERR(filp)) {
>>>>>>>>>>   			case -EBADF:
>>>>>>>>>> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>>>   			default:
>>>>>>>>>>   				nfserr = nfserr_offload_denied;
>>>>>>>>>>   			}
>>>>>>>>>> -			nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>> +			/* ss_mnt will be unmounted by the laundromat */
>>>>>>>>>>   			goto do_callback;
>>>>>>>>>>   		}
>>>>>>>>>>   		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>>>>>>>> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>>>>>>>   	if (async_copy)
>>>>>>>>>>   		cleanup_async_copy(async_copy);
>>>>>>>>>>   	status = nfserrno(-ENOMEM);
>>>>>>>>>> -	if (nfsd4_ssc_is_inter(copy))
>>>>>>>>>> -		nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>> +	/*
>>>>>>>>>> +	 * source's vfsmount of inter-copy will be unmounted
>>>>>>>>>> +	 * by the laundromat
>>>>>>>>>> +	 */
>>>>>>>>>>   	goto out;
>>>>>>>>>>   }
>>>>>>>>>>
>>>>>>>>> This looks reasonable at first glance, but I have some concerns with the
>>>>>>>>> refcounting around ss_mnt elsewhere in this code. nfsd4_ssc_setup_dul
>>>>>>>>> looks for an existing connection and bumps the ni->nsui_refcnt if it
>>>>>>>>> finds one.
>>>>>>>>>
>>>>>>>>> But then later, nfsd4_cleanup_inter_ssc has a couple of cases where it
>>>>>>>>> just does a bare mntput:
>>>>>>>>>
>>>>>>>>>          if (!nn) {
>>>>>>>>>                  mntput(ss_mnt);
>>>>>>>>>                  return;
>>>>>>>>>          }
>>>>>>>>> ...
>>>>>>>>>          if (!found) {
>>>>>>>>>                  mntput(ss_mnt);
>>>>>>>>>                  return;
>>>>>>>>>          }
>>>>>>>>>
>>>>>>>>> The first one looks bogus. Can net_generic return NULL? If so how, and
>>>>>>>>> why is it not a problem elsewhere in the kernel?
>>>>>>>> it looks like net_generic can not fail, no where else check for NULL
>>>>>>>> so I will remove this check.
>>>>>>>>
>>>>>>>>> For the second case, if the ni is no longer on the list, where did the
>>>>>>>>> extra ss_mnt reference come from? Maybe that should be a WARN_ON or
>>>>>>>>> BUG_ON?
>>>>>>>> if ni is not found on the list then it's a bug somewhere so I will add
>>>>>>>> a BUG_ON on this.
>>>>>>>>
>>>>>>> Probably better to just WARN_ON and let any references leak in that
>>>>>>> case. A BUG_ON implies a panic in some environments, and it's best to
>>>>>>> avoid that unless there really is no choice.
>>>>>> WARN_ON also causes machines to boot that have panic_on_warn enabled.
>>>>>> Why not just handle the error and keep going?  Why panic at all?
>>>>>>
>>>>> Who the hell sets panic_on_warn (outside of testing environments)?
>>>> All cloud providers and anyone else that wants to "kill the system that
>>>> had a problem and have it reboot fast" in order to keep things working
>>>> overall.
>>>>
>>> If that's the case, then this situation would probably be one where a
>>> cloud provider would want to crash it and come back. NFS grace periods
>>> can suck though.
>>>
>>>>> I'm
>>>>> suggesting a WARN_ON because not finding an entry at this point
>>>>> represents a bug that we'd want reported.
>>>> Your call, but we are generally discouraging adding new WARN_ON() for
>>>> anything that userspace could ever trigger.  And if userspace can't
>>>> trigger it, then it's a normal type of error that you need to handle
>>>> anyway, right?
>>>>
>>>> Anyway, your call, just letting you know.
>>>>
>>> Understood.
>>>
>>>>> The caller should hold a reference to the object that holds a vfsmount
>>>>> reference. It relies on that vfsmount to do a copy. If it's gone at this
>>>>> point where we're releasing that reference, then we're looking at a
>>>>> refcounting bug of some sort.
>>>> refcounting in the nfsd code, or outside of that?
>>>>
>>> It'd be in the nfsd code, but might affect the vfsmount refcount. Inter-
>>> server copy is quite the tenuous house of cards. ;)
>>>
>>>>> I would expect anyone who sets panic_on_warn to _desire_ a panic in this
>>>>> situation. After all, they asked for it. Presumably they want it to do
>>>>> some coredump analysis or something?
>>>>>
>>>>> It is debatable whether the stack trace at this point would be helpful
>>>>> though, so you might consider a pr_warn or something less log-spammy.
>>>> If you can recover from it, then yeah, pr_warn() is usually best.
>>>>
>>> It does look like Dai went with pr_warn on his v2 patch.
>>>
>>> We'd "recover" by leaking a vfsmount reference. The immediate crash
>>> would be avoided, but it might make for interesting "fun" later when you
>>> went to try and unmount the thing.
>> This is a red flag for me. If the leak prevents the system from
>> shutting down reliably, then we need to do something more than
>> a pr_warn(), I would think.
>>
> Sorry, I should correct myself.
>
> We wouldn't (necessarily) leak a vfsmount reference. If the entry was no
> longer on the list, then presumably it has already been cleaned up and
> the vfsmount reference put.

I think the issue here is not vfsmount reference count. The issue is that
we could not find a nfsd4_ssc_umount_item on the list that matches the
vfsmount ss_mnt. So the question is what should we do in this case?

Prior to this patch, when we hit this scenario we just go ahead and
unmount the ss_mnt there since it won't be unmounted by the laundromat
(it's not on the delayed unmount list).

With this patch, we don't even unmount the ss_mnt, we just do a pr_warn.

I'd prefer to go back to the previous code to do the unmount and also
do a pr_warn.

> It's still a bug though since we _should_ still have a reference to the
> nfsd4_ssc_umount_item at this point. So this is really just a potential
> use-after-free.

The ss_mnt still might have a reference on the nfsd4_ssc_umount_item
but we just can't find it on the list. Even though the possibility for
this to happen is from slim to none, we still have to check for it.

> FWIW, the object handling here is somewhat weird as the copy operation
> holds a reference to the nfsd4_ssc_umount_item but passes around a
> pointer to the vfsmount
>
> I have to wonder if it'd be cleaner to have nfsd4_setup_inter_ssc pass
> back a pointer to the nfsd4_ssc_umount_item, so you could pass that to
> nfsd4_cleanup_inter_ssc and skip searching for it again at cleanup time.

Yes, I think returning a pointer to the nfsd4_ssc_umount_item approach
would be better.  We won't have to deal with the situation where we can't
find an item on the list (even though it almost never happen).

Can we do this enhancement after fixing this use-after-free problem, in
a separate patch series?


-Dai

