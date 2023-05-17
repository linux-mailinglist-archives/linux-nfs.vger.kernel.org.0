Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E94E705F11
	for <lists+linux-nfs@lfdr.de>; Wed, 17 May 2023 07:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjEQFFR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 May 2023 01:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEQFFQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 May 2023 01:05:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E92136;
        Tue, 16 May 2023 22:05:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxW9H007572;
        Wed, 17 May 2023 05:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MZ+tWJ/ZkCYYAvfMNx2V7BmYzQQE1soW+dyu3XwKV7o=;
 b=nyzVFEaCYaYl88sabJ4YCEV0vBPfoXLCmSjBk4JADLgAAkkFJs7d8skbPh7wMVC37qG+
 WZhgtamh1etfR+f6KLY5c1hBJuo5TkHNyQ/KNcibL56cbFfK8YF6w2PxjXxXud23Ruym
 sS6zwNuup0e+M7Is/ZWQ0Wb3L4O9giURQbsJY/sNxDBqjvxSB3CiM8WXq/DSpDlm/7ZD
 l1/btZ5bxePJtb9xSNmYn1ZpxxZNdEv5Kh179OGsv8sAv6Gr6//WtM72vogcFBgwsiDr
 6o3Ug6Zz6KjbXqKYTDdWzCLHjSzKOyAYoGT47an3ZhkMPNKew7bpVuYN/Vv2QCcKBUOn xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33uvhn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 05:05:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H2L3rV025014;
        Wed, 17 May 2023 05:05:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104xkgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 05:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK1UVkqffJueuVVjO9c3XhH5/fNhi30qu99Nz0t+ndR9eajtn3u9LlzN6lW7ikN7BuZVOw4G91VBwjQv0o2c+nCLDS/Wh6GMneapkOCHaE96FuQq80kEKEoZLbnvW9S2GNuWPSSt/Xw6uEUvgIFyVsG3yTxO/OBo4gO4RuKIu1737DtWrNtDrY5U4fdKAobXlISG85zOOSRiGJQFYSX45897i8Xr9lHJQ7BZGPlH3bTDZAWotEbOfM2UMhP90f6ayFmQiCkHC3rebl2ZJbXcmfxozoV4ibNKRJb5zTlxfdDmQfLFdalr9fYv3eSAgWh0OqOmpJeRDtzZOB6IkffEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ+tWJ/ZkCYYAvfMNx2V7BmYzQQE1soW+dyu3XwKV7o=;
 b=H+d2ffpG3kuC08VkQX2zsbpIsmjlIG8vwwYzmF/1jt2yiacnTrtmRP3a/YGZjdk9YGDL8MDa+4HT7TQkAXE8jPSqVkryqzEMSgko5XGpgafDL25yT4Tw80NPPaPuOVNuSeoVKEeVV4+kBbxb7MQaBZr//4z/V7Hy48gu9oJQsyO2yPvssnVMYDV8rWsx3ZLVUlre4JSDfHdD3UC5UzLafioYLQpS684R/dwBylf03xFVCN2rlC4mGlwplVSvL06VECV0ev8Fb9pYk7DqlxqCvhyQ+VNQh4yP3BReS0W+jdNZebpwYmNp4ezjda4X4p/bWTPzmME23or8kPe68sKQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ+tWJ/ZkCYYAvfMNx2V7BmYzQQE1soW+dyu3XwKV7o=;
 b=suyqEThGDynPW5NyM2UUe+u1cmC9URcRmhBD3NXhqt0hDc1LisuzxSbqhyNCOtkujfr0lg9VaPrdklRGcoZTGvdKemNxKKJ7CFWSjJOujX3f+vXTYgN4fVO6sBZptSLU+kEGg2SJdD+KTINt/4qvn+nVV8RRLP6mT7hwrgJfk7c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4568.namprd10.prod.outlook.com (2603:10b6:510:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 05:05:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 05:05:07 +0000
Message-ID: <c4b7915a-0bb7-178e-0258-fe24ee3359df@oracle.com>
Date:   Wed, 17 May 2023 13:04:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3] generic/728: Add a test for xattr ctime updates
Content-Language: en-US
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        fstests@vger.kernel.org, zlang@redhat.com
References: <20230516141407.201674-1-anna@kernel.org>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230516141407.201674-1-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a27d05-29c1-45e6-0dcb-08db5694488d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYg4RWASaHHc8a2ubH88ycf4HWRhEJ1nSZmKjoWw75mKuxXss3OFw6WdUttfCjUYhWq7N5uqZ8t2XM3je8YLcpGApN4mqDMD7B6x8YASmNBLTo9bp9gOysvmbqrDe9rrMIM4MuGKp8ACBp8GMNi3zmJkRZwvpIxL0ymaaQN+srrxgdPher3Cl8hUH5dmxB3qx1HQ9T5ZTsiNcUpiIYiJXL2ddjiewou1GAxLDgN6GXIGkHDwTxhnar0ZJ0iMGwISUoHZS4eupJkEXFYoc0NHGMSSHCO58xsm5FUeMI0DkCKUY2L0YiEsJRqME2hvT2G31AAfXDkXUa8vfVNYKZ1PjMeEqXRnL3CjWcGx0oN5C/yeD9o7YN18Xd9GQaJ7JctRqQDDQ8dc7N+Jo1omo+p4XH+Eecv4e0peaQHyx1911cBcdWFTlcuq0b9WhIddm9tsf/+osuJN1f9j6o/42Ci9Z3o+bGaEaO8oNqfyAmORiaQYzwfSM8/OQOwEhTDjx76r80tCx1WFKLJ+Q8Es9gl/ykwf2PRCtq4WpUBy50LrQ1G6X+Px/Q2ikz1Dn/dNsVDlwKjtM1i7dFOaLoi5Kk8Z4LX8w89pznvUGI+AlRTv4DnLIxjTMN/hTOgNapjPOwv5gVhuC8ZW1AjoU5v9ex/23XUhbIZgQhu/vQsIfkHNPpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(31686004)(66476007)(66556008)(66946007)(478600001)(316002)(31696002)(36756003)(86362001)(83380400001)(53546011)(6506007)(6512007)(2616005)(186003)(26005)(6486002)(4744005)(44832011)(8936002)(5660300002)(6666004)(8676002)(2906002)(38100700002)(41300700001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lwbHNibTFBNWJMK3RlT29LNWp3cWtjSFhGelIyRlhjVlBuc2dmZTE4Ukdv?=
 =?utf-8?B?eEd0cWZZL2JmL0RZTFJ1RUlVaVJwbXVVTUlUL3V2Vkl2bUltOE8xT1M3OTRJ?=
 =?utf-8?B?LzBGZFkrbll6T2RjYUU0cEtWVGJ4U2o5LzU5UldlWEQrNzUyT3lneHFTQUVo?=
 =?utf-8?B?V1Q4endYWVlHYVppd0NtSi8rTGUzb1RrTzlrcm1GcTc3Z1REOC9Udkp0WWFZ?=
 =?utf-8?B?bDZCWmEwRXlQeVBQeWJDVnlCV2x0T09TeERIK3RBaGlRUWdZUXdqTHhTUk9R?=
 =?utf-8?B?WldtT0k0MlJSWUNmY1NCMVo0WGR3Nm93TUFRZjZKWm5TWDdTUjZUQlNSUVBT?=
 =?utf-8?B?c1VMangrczFYSDdIV1V5WlhiK091d0dqb1IvM3ZkY21LZnQwNUVadEQyRHRk?=
 =?utf-8?B?K1MyNllzSW0rYVFBZ3grZVZJbGhuMmxuRDJ5Q3hCMDdwL1JoWU94YXA4ZldD?=
 =?utf-8?B?YWwyRDFraVNBYnJwZU16eFpFVmdMcm5TVXE1OStVSFZpRStPai8rN2duT21S?=
 =?utf-8?B?Mk1mZlNNQytuMzRId1NpV09SNjY4K21ZalJlUGl3U1NzejNGc0J4Tit6Z1h1?=
 =?utf-8?B?VXh1bml1SVJXR1RxN2V5bVhIeWM5TTU0ak1LV3k1Rm4xTEE0R2VCcTRLTnYy?=
 =?utf-8?B?TDZ1N1prTTh2N3V4anJHRUVIZmlyNmtLeTZwN3JXODRwY29XRmhxa2lkVWxO?=
 =?utf-8?B?UDNGZnU1Nlg0cUgzM3o1QzV2WC9YckcyYVRGN2VVTVJtRzBtblFvZS9RNEd6?=
 =?utf-8?B?ZzRNelU0ZnpLUFVZbGNLWXV4RFNHaGJRaUpGU1ZVZ0ZnMlpzbmFFQ3RWT0dZ?=
 =?utf-8?B?R0xRYnIwak5vQ2poakVrUG1iYUZEbzBrWkIwNHVLUnVVZkExTHhjUW03SHZP?=
 =?utf-8?B?YUFYNmNOT21rT3JPSGxXL21nNXowOTVFbjNRZW9GYXI3YnVPdEFtRTdjSEox?=
 =?utf-8?B?M05rNlprY3R0MEo3emxOYm4vWXNjS2RBVWxDNStoL1QvQWMya2FxQXZ2b3o2?=
 =?utf-8?B?VDJNSU9VeEFtZDJGa3JteHV1WXN1WnFMc2h1ZWl0c3pmM1Z2QlZ3MDBDZ3hq?=
 =?utf-8?B?ZFhUazVmRVNHTHNoR3JSQmZqaGt0R0krMmsxelBxZTlPMTdwU3kyWkdtdk9O?=
 =?utf-8?B?ZURxVEkxUGxVdndVVVpEaCt3UVFSS3dKd1Q1T251SWJtRkJQMzd6RFBHeXhO?=
 =?utf-8?B?WWVrZksrTEVyVGVoMmp0Y1RnKy9DZFAzQ3d2OXliajRTaHE4RFUwUm1jb3Fh?=
 =?utf-8?B?ZDJYT0J6Lzk1em5VVEs3UlU5WXVYTkFVbm82Lzk3QlRHOXFDRDdsNzdjcks5?=
 =?utf-8?B?aTQrMGhYRTZYVzh0dC9mTndaS2tEbFZVNThRblpPMzJKMUFhNXdadUV1NUVU?=
 =?utf-8?B?M0h1R2tCREFxeTBlYlNOeTQvM3I4YkFmcVVkS2hHeG8zNi95S0hJbjFzU3Yv?=
 =?utf-8?B?T2NFM0hTR3ZnZnEzeVhQV09kc3BDNllSNkVldDhvaEN1YWl1UUlFL0ZwaHVy?=
 =?utf-8?B?SWFvYnlud0tCWlcxRHE0a093TENoMFNORDA2ZUhyMkFWMHN3Nkp4djhWWmdV?=
 =?utf-8?B?UjkwR3dxTGVsbDVnc0dNNU5PM1NaRUZpSE56b01Id1pNUTBseXZPelBKRHdR?=
 =?utf-8?B?dGxDUG1HdFVSdDNLbmtTblJKTUFKdkF1dDZyUjFoUHN1MXZ4YjVtN1Jhdk9Y?=
 =?utf-8?B?ZGd6aUxzM3hFc3JQV2NwUUo3dFZGRlhkSFZpbE9uTjUvUmkrNkpmdHRWaXdH?=
 =?utf-8?B?a3pPYlM0cmlTbDk4ZDFwcGZjNU15MXlZRFhCR0xaNFJ1bExvZGdsMXNZQTZT?=
 =?utf-8?B?TGlYYkZSYnFmVUVZOWIrZ0N4dm05QTA2aTJDUysyRTlkUVpJU0RJN1JROFlI?=
 =?utf-8?B?Q2ZQTzhrY25ORjFYMFl1TjRqSEdPaUN2a3JYb2lnaDRRRE5JR3l4YUd6NC9u?=
 =?utf-8?B?WHFQQkpMa2szYjhQcHVzNzIrcSs1YUQ5WFpNOFRiUFVxbHduTlhCcEtsTnho?=
 =?utf-8?B?WFMyekp5M0c3aXBtTUtZbDdOMlVRZGJNSGtFR0g3NXFqZENIZGRxZVJsMnNE?=
 =?utf-8?B?NGgzbm1EQUVXNk90WWlBSkx3bDEyQm9WUE1iTjllV1hSSE5ZQzVCYXJweW1I?=
 =?utf-8?Q?ySDnaQx1uLSOSrsdZV6YHsZqk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pu9xPns9G6era7memjOhCRfPT88pMuXO0LYZJFuoJu9Qw+djsypMzw80D5LBxL4Ov/Fk1dZqclmo48TKio/I/cil1I/f3Y5On8YdfCWduEVh3lUvpZtGoRDSe9SL0Z02gDPO0Lg6QhW9WxFVhqp3kkJTDqT8qzy1pkY9bVmaCsfT+XkFCWDxWHp5lS4rTjJ2gTZ6o26SjUeqTB0DrHsgyJUa6cUxj8ALJtu0VaEmC1z+90EJhJg5H70Jh0TDF1gu5LuazrqPNzh5RosNrSVvwS+OGXy7SzotjNRKnQX9Go9ngQYr+Dy78rkrbvBCLDdXktfB36fjwVpV0PAg8Vp8/Es+86zsgSmyEhZHJhGChl3UFHPSU2vQQDWSrVD4jdSp8hLULBbJAezSAYIpMm7nH2IKZ/QlMPm7Sej/hkeebg/U+CBQ+YWN1iD6N1LCOTbZVmAnLBbKwPd4Ar/g8UzqWqTUt+fewJtfW3Y+gNbl/EhbLCgsYLR8swqpx2NWBDKMOoog86FgtQW9ITXhXHfP31VmaryE6txCWbSMXwumR9IMFyNssPDFmJHlGgAAP7udyRNmDbgCwvXYdM9IyjWjg7PZRJmJXBuda4H8tVtI0lT9rtSAdNeg6VLJytWWQ9GA7H7QWxIBYyos6e6WHwwhDG1YUjJ99kScoZeKH5pl6wKdQS8Qt4eiwGKMsd//nz7xY4yP1H9CMjgAp2/n2FJHwLd+sdBzMCkAze4LvFFXJgEO4QxFY+eR5LB0HWugzLUKQbxNydbePx3yYJGg94LcmVdOfDQEvllhjXjoB09JGTSgyhyAbSxz60hIP73LM0mF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a27d05-29c1-45e6-0dcb-08db5694488d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 05:05:07.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l/tW9wWNzs6XUBrd/AUFx+oZwDZEAwxghkkZ0ucNz1aKHt5a/M08kKUk1Gglb2R6wqcgZJhZWbgNWV+g+nNIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170042
X-Proofpoint-GUID: 8v1lq5Yg5Yab-dwKNIp3UggiXEur2Ou5
X-Proofpoint-ORIG-GUID: 8v1lq5Yg5Yab-dwKNIp3UggiXEur2Ou5
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16/5/23 22:14, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> The NFS client wasn't updating ctime after a setxattr request. This is a
> test written while fixing the bug.

You can include the '_fixed_by_kernel_commit' field for hints
on unfixed kernels. With this and Darrick's suggestions, you
can add my RB.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>


