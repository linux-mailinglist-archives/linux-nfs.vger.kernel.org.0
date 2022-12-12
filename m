Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200DE64A856
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiLLUAI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 15:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiLLUAG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 15:00:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F09C17431
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 12:00:02 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwj6E013151;
        Mon, 12 Dec 2022 19:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ecVB6tiTUbOiEroS+HbT0jb4JdOh1bpSUpJeeUvgUqk=;
 b=ZUz/hs/U3V4VlYrFLyAJrDHv6SzYQ7RcIQ5/k+oHohq0Fr8jxXW7zr45dAcXe6J1RGwv
 EhhZ26dSTXlaNGPDT+80vwsvRc2MFjRYIrcluN41faIuWzqYWrYu+31UlPyGFXuRQTZ0
 ebYSz3NE/D7XTN2Q0E07XYLfEHj7DXa7WXIPJaoSfeYXfOOG+GsoqQNGz3LsK6FV7jCw
 hVvo+P8/155JJvGIi3kL4OdYgX2YNJpKwZ/HKaNM0YFUgqGikH/u0bf7D7H1l69OMsHz
 EUdblDqvmr3HAQ6ko/J1MydZfZbRbFPYadXhXb/vq0VA8Zv6BfARLY0OTiRW98L9243m BQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mch1a3t3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:59:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCIm2N9034718;
        Mon, 12 Dec 2022 19:59:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj4ja4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQeKlZKv1VWusshXdM9p8wnFYd9MqwcbM+UmzZ05CvmByvEEel+fbjW2BN7teWb8zNlQUCM6V1NV5G/xvIDKKSD3R5QJ0FXOe9PPjqvGTgT9UGEeqo1qaEODPPrLd7/ZKMKghtZb87G2/O6vm/tC0Ju2Jk2oTn/EdNe0wa7+Z/F+eIspBAETtmfbZd4m45Egk6sPHdR7ZJ9Dm/2ZM7pY9toRNQx75+bWvSDWrdvUT62q7oUswU284wLaatlggNmnrrDAt2u+q7iyzoJv9LV0gKl6hx5htis+mfg3alh/gL8nxYkDq/CUdZ8UotJUmkHsV8Fgg3q4NkfbIIOKlF67SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecVB6tiTUbOiEroS+HbT0jb4JdOh1bpSUpJeeUvgUqk=;
 b=I+pEpz6JxAfXmyH3odtWV9cKA+Fg4toCP2juYqXuQNqNZsDPJXRHb5wdVH/ICp8/LKB97EePAgWV/liY0ARiII2SdCmeQe8q5msHS0VB9tINh4VuxK4cnDsqHlQdnYfN4WThwo8ZXj2cd8tUaRZKswwjIrsrZ8ukU5uFPe+SVD6EFwaosmUHytsrBNuuiUt9PVT5jNRVLQG9LH+xbnlEJWaQeuPa0LpUzrFw55JKT+cjua1obx+7a5v2B1rK4juiGNTcFhbYKA9FQykgkf2y7lSmagrG5eYXVDfU1XI1DV5U27fkPYpNV/w/tHJH0IgC9G3vz1lhp/7ZFp22gfuBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecVB6tiTUbOiEroS+HbT0jb4JdOh1bpSUpJeeUvgUqk=;
 b=O3LbQgIX/Wp4PQwfHxdVUGdZgJJ8WPSCCPy11X8gaTkowbl5/KUrIOphdQn8pUVOqZ20PkCRX1OGyAHQJzipTLg4jVHXwY34F5Lun3qDLvivFR9Lqh7/dwz06AhbYxxcI73U83ER9Y06Xhr1aJ97AjO4W2MOeb8r065YoDSB6ZM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB6460.namprd10.prod.outlook.com (2603:10b6:510:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 19:59:54 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::193d:c337:4b9:3c77%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 19:59:54 +0000
Message-ID: <d8e08b16-bf99-2d0e-e666-982aa585aa5d@oracle.com>
Date:   Mon, 12 Dec 2022 11:59:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
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
 <a895cb89-f8f3-a2e1-1958-cf9379ecdcd5@oracle.com>
 <4CAE538E-9F0B-4B44-956E-C6498A37A83A@oracle.com>
 <aefea8e45e99ba948acf4c5744793b6ad674a66c.camel@kernel.org>
 <1EAC1016-CB25-4695-A035-5DA2AA5EF58A@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <1EAC1016-CB25-4695-A035-5DA2AA5EF58A@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 9009eba3-70bb-4376-2d6d-08dadc7b7007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+346rkkN976v+bHELO4HBVqo7i644leZqhVcq6AU4zBvFyTnCON1jaGta7fsPKH2UoIbkck3N01ZnXDXuggJbVySiH7TrtVWBPoMTiNPIH1VsAv+FSrpGhrMfAuOsz3r/8ri/g6mQbak6HLL62M1ttPu0OrPIZesThc0ITXW++5TjDC70aQHzthMIV+EH5SbQ6D0vmUQrxVMkPDbmS347T6HwmW6F0LUhb/NsbcfzYWR51bGRTitBOvOJ/joAJ7MFNtZvMY4DovxRWNYcPVDEPhE9eQUJX5rk5PkIudtzVl45P2H6bFzvcgaKQP6jUx8ciP4aoF6WeRXv+QKDXEl7V5OangjapPjixo8n6tmRIpcsutT5etdZvsdPyGvHwdXePfmGMID9krHwDSvJICiHtq/h7kVf32ISr/C2CYOAhUXKXqxx1X+hVA7onpxgr6I4598Rn/z6/x1Md6SQI6xl6Zhfy/1EE8XiQCW1PO/b2jwMiuhL3J/N9sffwhRYAqRK6xty2MLivK1pwyvzwvhIK2S7Yjsnjr6VsvDGN+1LJUfkG+4/8Y7zyi7qdQctkNZenDydN7XEJQRXIAwZI4n9RnJA8tB+z1NkqS5Wfh29D9Ir02eKQKQkpW9Jw8sn65mcQIS3Gt7sPeM5Ml3Q7ZTdznUdX+Pn3eenIHyfAGzjGa7+zWFFWSn/Q1zK1Qf8d+yUIr07yVbUQVA5FENSWm5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(8676002)(66946007)(66556008)(66476007)(316002)(4326008)(66899015)(30864003)(5660300002)(31686004)(4001150100001)(8936002)(38100700002)(54906003)(110136005)(2906002)(41300700001)(83380400001)(6486002)(2616005)(36756003)(53546011)(86362001)(31696002)(26005)(186003)(6666004)(9686003)(6512007)(6506007)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29oL3dZUWorbEN4b1licVF3YTF6ZGpyR1lDYlVma3hxOTRodXlURWwzTGtQ?=
 =?utf-8?B?T0RHWHZRSFQ4eVowc2hackhFQlUyWlc0RXNCT2t2RmZCcm9nMTlSendwazBB?=
 =?utf-8?B?WFNPYjg2M0ZxMi8velFPT2tYYjJ0OWVNeUNYVTZqSnZHaCtHVmtEaXlVdnJV?=
 =?utf-8?B?RnRBL0tUSnZtUUdXQmtLOWVUZDU0blowRWVXczd0OFBpd05vU2h0MWEzRXZU?=
 =?utf-8?B?MXRLSURxYk1sY3VrSUVpVXk1UmFlSWFHenFKZ1pXb2ZLbFBueHd3bnc1Z2Jx?=
 =?utf-8?B?alBxUHp3emU1WE40eHh2ZHp3NFV2RVVDb25BbnlLYWlVaElkQmJLRjlqMVZR?=
 =?utf-8?B?U1ZvWUttUUQyZHY5MlZYOEYzZ3VBRHp4ekdLVUtaT0FSek1vUHJKeXhrR09W?=
 =?utf-8?B?VTFqT1E2KzNhS000WWlXM1YwbFN0a3FUcmJFODVmODFOTVpWK0dFa1ZPTzhC?=
 =?utf-8?B?elhiMGJ0WUgyTGhWQzV0OUtBUC9mSmhCWXZsbHk4UWVPM1g1V1BlZmY3ZUt2?=
 =?utf-8?B?MXkzeEpZbng0dDN4Q0Roc2djYXNLdldBVzFEQmd5dzVOcDhrc1FqM3NQZFM2?=
 =?utf-8?B?SDNyRlh5aTByOTNyeENWekVIdENQV0k5VEkvbkNETmZDUWJkWVRDcjNBVzli?=
 =?utf-8?B?aWwxMk5rNFE5MGVtUHA4RUlQQzl1cnFiWWVsR0pqbngrVlFiZktPR2xyanJ3?=
 =?utf-8?B?Vko3d1F1cDVva2NLYU11TGowZWRxWU5ocnU0dk1RWklxTGdOR1JQL3pVRWZ4?=
 =?utf-8?B?cnEzWXJlTk9BSG0zWnRhNURPSUhzUmxuYlA0dDBibWQ4Zmp4UXJTMktQcXI2?=
 =?utf-8?B?RHc5OWlHMnVCVEN1RHhDS1Y4ZXZSa1NuVUNXTkNHcTdJdUZiNWY3RnUwT0Rq?=
 =?utf-8?B?YmpUbG51WWs5WDVjL0xMbk5laGNDMUF0VkhWV09FUElIdGJFWlVYSlo5cUkr?=
 =?utf-8?B?NzFwN2JqWDQ3NVl3R1ZaRExzMFNiV3FzK21HTTB1cXlWeENLdjAzNUhYdWJx?=
 =?utf-8?B?eWF2alFUR3VYYVBiMS82Z0ZqTFdNdmJ2OWlpTC9OOC9ZTDN5NUw5ZVdoZlh0?=
 =?utf-8?B?Q1Q1VG54a2doR2wyd1M1YytTZ2tQQ1lxOHg4QUFhU0hhN0J5ZWVpVXlPU2ti?=
 =?utf-8?B?ckFoRE1sQUQ3d09pdHU2c1ZiRktVM3FNM21PdXBxejMxaW1oeGtSd0pZSkg3?=
 =?utf-8?B?SStPMzRvR2VVVE9TdG94Q1lpYnk2bHE3cEYxVS9panhNZVBlS2dhVDlHVHpV?=
 =?utf-8?B?YWhUZGM2U21ReHpMNW9DdTBwcnlJY1hFV0tlOS9Bb3ptSEtiblpDVUxMS0pv?=
 =?utf-8?B?N2tuSWNidkJuV21NOUMrSVlTYTdvZC9rTDhHS285TVAycEE5bVk3T0ZrRjE3?=
 =?utf-8?B?ZWE4bUNvR043NnRDSytmanhDemFFN1QwaThxVWJOd2RZcTdrTzdlQlhiVHlX?=
 =?utf-8?B?dWNLV0R3V1hybWhUejJPUW55ZE1BRXNTUXQ5dldPNWhVb3V5bUNqK25seC9D?=
 =?utf-8?B?dFFWYmwwUlg5Q0RqYm5DN2s5U1h6Lzg1eHJSSjNVa0dLZUZwWThhSlpiVTEx?=
 =?utf-8?B?NG1QTXJFZXNhK1VwL29ydEhRbUczQWNSbE4xSTRqcXNEamplU3VyU1BWOVhI?=
 =?utf-8?B?aVFsWFNXMklHZ25JZ0JKdVBXV1liVDJ6MXVJejIxOVVlR3JxNnpjRWUzbDRZ?=
 =?utf-8?B?MDFUUHZvelE4ZVk1dHh1VnVLR0g2ZEJ1eW9XMW9TcjNRMlNibHY3ck1rWlJ5?=
 =?utf-8?B?ay80eUNBSGtxQk9CQ0RXVXNPb0IxSEtNZ056TFUxd3NnZWowSFBOYnJQU21y?=
 =?utf-8?B?bDJraUM2M2Z1N2lKYnoxVG5PUmx6d2FtRVloaTNRQzlQWktyZ0o4ZkFCdzhB?=
 =?utf-8?B?YkRGRnlMQ1hrVGpvS3Bpb1R6NEMwdTRWRTdMYXlMU2xveDNmR0JhNyswMmls?=
 =?utf-8?B?QlB1bFlxTHBGZG9CTjl1Q3VvNWpYdW14ZzNXUGNTRFRFN2R1V2RNdEFGSExr?=
 =?utf-8?B?SC9FZGhWbjZSQm1lbTJYd3JVWjgxRDNBUVRTejgraHpYSEFySlVLNnJYZjho?=
 =?utf-8?B?Q2M3NmhDTEJaTzlXLzcxZFBtSmErSmRXZkZaRFhJb3NrVkZIakNjOWFRSUp2?=
 =?utf-8?Q?my6aw7ER55te060h/uiFhedev?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9009eba3-70bb-4376-2d6d-08dadc7b7007
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 19:59:54.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WWFl72MHr/1yrxTZUmjQN6adAY6558aeBjKvN2Nf9m2Qq2vs0TZCXtKRWXAzrN+icZNazStBG2VbJIl4YUlig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120179
X-Proofpoint-GUID: gGGze-9jiDY2JGadz6t430acLUyO-cVO
X-Proofpoint-ORIG-GUID: gGGze-9jiDY2JGadz6t430acLUyO-cVO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 12/12/22 11:48 AM, Chuck Lever III wrote:
>
>> On Dec 12, 2022, at 2:46 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Mon, 2022-12-12 at 19:28 +0000, Chuck Lever III wrote:
>>>> On Dec 12, 2022, at 2:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>>
>>>> On 12/12/22 10:38 AM, Jeff Layton wrote:
>>>>> On Mon, 2022-12-12 at 18:16 +0000, Chuck Lever III wrote:
>>>>>>> On Dec 12, 2022, at 12:44 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>
>>>>>>> On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
>>>>>>>> On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wrote:
>>>>>>>>> On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
>>>>>>>>>> On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton wrote:
>>>>>>>>>>> On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>>>> On 12/12/22 4:22 AM, Jeff Layton wrote:
>>>>>>>>>>>>> On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
>>>>>>>>>>>>>> Problem caused by source's vfsmount being unmounted but remains
>>>>>>>>>>>>>> on the delayed unmount list. This happens when nfs42_ssc_open()
>>>>>>>>>>>>>> return errors.
>>>>>>>>>>>>>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
>>>>>>>>>>>>>> for the laundromat to unmount when idle time expires.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>>>>>>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>> fs/nfsd/nfs4proc.c | 23 +++++++----------------
>>>>>>>>>>>>>> 1 file changed, 7 insertions(+), 16 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>>>>>>> index 8beb2bc4c328..756e42cf0d01 100644
>>>>>>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>>>>>>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>>>>>>>> 	return status;
>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -static void
>>>>>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>>>>>> -{
>>>>>>>>>>>>>> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>>>>>>>>>>>>>> -	mntput(ss_mnt);
>>>>>>>>>>>>>> -}
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>> /*
>>>>>>>>>>>>>>   * Verify COPY destination stateid.
>>>>>>>>>>>>>>   *
>>>>>>>>>>>>>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>>>>>>>>>>>>> {
>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -static void
>>>>>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>>>>>> -{
>>>>>>>>>>>>>> -}
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>> static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>>>>>>>>>>> 				   struct nfs_fh *src_fh,
>>>>>>>>>>>>>> 				   nfs4_stateid *stateid)
>>>>>>>>>>>>>> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>>>>>>> 		struct file *filp;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>>>>>>>>>>>>> -				      &copy->stateid);
>>>>>>>>>>>>>> +					&copy->stateid);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> 		if (IS_ERR(filp)) {
>>>>>>>>>>>>>> 			switch (PTR_ERR(filp)) {
>>>>>>>>>>>>>> 			case -EBADF:
>>>>>>>>>>>>>> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>>>>>>>>>>> 			default:
>>>>>>>>>>>>>> 				nfserr = nfserr_offload_denied;
>>>>>>>>>>>>>> 			}
>>>>>>>>>>>>>> -			nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>>>>>> +			/* ss_mnt will be unmounted by the laundromat */
>>>>>>>>>>>>>> 			goto do_callback;
>>>>>>>>>>>>>> 		}
>>>>>>>>>>>>>> 		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>>>>>>>>>>>> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>>>>>>>>>>> 	if (async_copy)
>>>>>>>>>>>>>> 		cleanup_async_copy(async_copy);
>>>>>>>>>>>>>> 	status = nfserrno(-ENOMEM);
>>>>>>>>>>>>>> -	if (nfsd4_ssc_is_inter(copy))
>>>>>>>>>>>>>> -		nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>>>>>> +	/*
>>>>>>>>>>>>>> +	 * source's vfsmount of inter-copy will be unmounted
>>>>>>>>>>>>>> +	 * by the laundromat
>>>>>>>>>>>>>> +	 */
>>>>>>>>>>>>>> 	goto out;
>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>
>>>>>>>>>>>>> This looks reasonable at first glance, but I have some concerns with the
>>>>>>>>>>>>> refcounting around ss_mnt elsewhere in this code. nfsd4_ssc_setup_dul
>>>>>>>>>>>>> looks for an existing connection and bumps the ni->nsui_refcnt if it
>>>>>>>>>>>>> finds one.
>>>>>>>>>>>>>
>>>>>>>>>>>>> But then later, nfsd4_cleanup_inter_ssc has a couple of cases where it
>>>>>>>>>>>>> just does a bare mntput:
>>>>>>>>>>>>>
>>>>>>>>>>>>>         if (!nn) {
>>>>>>>>>>>>>                 mntput(ss_mnt);
>>>>>>>>>>>>>                 return;
>>>>>>>>>>>>>         }
>>>>>>>>>>>>> ...
>>>>>>>>>>>>>         if (!found) {
>>>>>>>>>>>>>                 mntput(ss_mnt);
>>>>>>>>>>>>>                 return;
>>>>>>>>>>>>>         }
>>>>>>>>>>>>>
>>>>>>>>>>>>> The first one looks bogus. Can net_generic return NULL? If so how, and
>>>>>>>>>>>>> why is it not a problem elsewhere in the kernel?
>>>>>>>>>>>> it looks like net_generic can not fail, no where else check for NULL
>>>>>>>>>>>> so I will remove this check.
>>>>>>>>>>>>
>>>>>>>>>>>>> For the second case, if the ni is no longer on the list, where did the
>>>>>>>>>>>>> extra ss_mnt reference come from? Maybe that should be a WARN_ON or
>>>>>>>>>>>>> BUG_ON?
>>>>>>>>>>>> if ni is not found on the list then it's a bug somewhere so I will add
>>>>>>>>>>>> a BUG_ON on this.
>>>>>>>>>>>>
>>>>>>>>>>> Probably better to just WARN_ON and let any references leak in that
>>>>>>>>>>> case. A BUG_ON implies a panic in some environments, and it's best to
>>>>>>>>>>> avoid that unless there really is no choice.
>>>>>>>>>> WARN_ON also causes machines to boot that have panic_on_warn enabled.
>>>>>>>>>> Why not just handle the error and keep going?  Why panic at all?
>>>>>>>>>>
>>>>>>>>> Who the hell sets panic_on_warn (outside of testing environments)?
>>>>>>>> All cloud providers and anyone else that wants to "kill the system that
>>>>>>>> had a problem and have it reboot fast" in order to keep things working
>>>>>>>> overall.
>>>>>>>>
>>>>>>> If that's the case, then this situation would probably be one where a
>>>>>>> cloud provider would want to crash it and come back. NFS grace periods
>>>>>>> can suck though.
>>>>>>>
>>>>>>>>> I'm
>>>>>>>>> suggesting a WARN_ON because not finding an entry at this point
>>>>>>>>> represents a bug that we'd want reported.
>>>>>>>> Your call, but we are generally discouraging adding new WARN_ON() for
>>>>>>>> anything that userspace could ever trigger.  And if userspace can't
>>>>>>>> trigger it, then it's a normal type of error that you need to handle
>>>>>>>> anyway, right?
>>>>>>>>
>>>>>>>> Anyway, your call, just letting you know.
>>>>>>>>
>>>>>>> Understood.
>>>>>>>
>>>>>>>>> The caller should hold a reference to the object that holds a vfsmount
>>>>>>>>> reference. It relies on that vfsmount to do a copy. If it's gone at this
>>>>>>>>> point where we're releasing that reference, then we're looking at a
>>>>>>>>> refcounting bug of some sort.
>>>>>>>> refcounting in the nfsd code, or outside of that?
>>>>>>>>
>>>>>>> It'd be in the nfsd code, but might affect the vfsmount refcount. Inter-
>>>>>>> server copy is quite the tenuous house of cards. ;)
>>>>>>>
>>>>>>>>> I would expect anyone who sets panic_on_warn to _desire_ a panic in this
>>>>>>>>> situation. After all, they asked for it. Presumably they want it to do
>>>>>>>>> some coredump analysis or something?
>>>>>>>>>
>>>>>>>>> It is debatable whether the stack trace at this point would be helpful
>>>>>>>>> though, so you might consider a pr_warn or something less log-spammy.
>>>>>>>> If you can recover from it, then yeah, pr_warn() is usually best.
>>>>>>>>
>>>>>>> It does look like Dai went with pr_warn on his v2 patch.
>>>>>>>
>>>>>>> We'd "recover" by leaking a vfsmount reference. The immediate crash
>>>>>>> would be avoided, but it might make for interesting "fun" later when you
>>>>>>> went to try and unmount the thing.
>>>>>> This is a red flag for me. If the leak prevents the system from
>>>>>> shutting down reliably, then we need to do something more than
>>>>>> a pr_warn(), I would think.
>>>>>>
>>>>> Sorry, I should correct myself.
>>>>>
>>>>> We wouldn't (necessarily) leak a vfsmount reference. If the entry was no
>>>>> longer on the list, then presumably it has already been cleaned up and
>>>>> the vfsmount reference put.
>>>> I think the issue here is not vfsmount reference count. The issue is that
>>>> we could not find a nfsd4_ssc_umount_item on the list that matches the
>>>> vfsmount ss_mnt. So the question is what should we do in this case?
>>>>
>>>> Prior to this patch, when we hit this scenario we just go ahead and
>>>> unmount the ss_mnt there since it won't be unmounted by the laundromat
>>>> (it's not on the delayed unmount list).
>>>>
>>>> With this patch, we don't even unmount the ss_mnt, we just do a pr_warn.
>>>>
>>>> I'd prefer to go back to the previous code to do the unmount and also
>>>> do a pr_warn.
>>>>
>>>>> It's still a bug though since we _should_ still have a reference to the
>>>>> nfsd4_ssc_umount_item at this point. So this is really just a potential
>>>>> use-after-free.
>>>> The ss_mnt still might have a reference on the nfsd4_ssc_umount_item
>>>> but we just can't find it on the list. Even though the possibility for
>>>> this to happen is from slim to none, we still have to check for it.
>>>>
>>>>> FWIW, the object handling here is somewhat weird as the copy operation
>>>>> holds a reference to the nfsd4_ssc_umount_item but passes around a
>>>>> pointer to the vfsmount
>>>>>
>>>>> I have to wonder if it'd be cleaner to have nfsd4_setup_inter_ssc pass
>>>>> back a pointer to the nfsd4_ssc_umount_item, so you could pass that to
>>>>> nfsd4_cleanup_inter_ssc and skip searching for it again at cleanup time.
>>>> Yes, I think returning a pointer to the nfsd4_ssc_umount_item approach
>>>> would be better.  We won't have to deal with the situation where we can't
>>>> find an item on the list (even though it almost never happen).
>>>>
>>>> Can we do this enhancement after fixing this use-after-free problem, in
>>>> a separate patch series?
>> ^^^
>> I think that'd be best.
>>
>>> Is there a reason not fix it correctly now?
>>>
>>> I'd rather not merge a fix that leaves the possibility of a leak.
>> We're going to need to backport this to earlier kernels and it'll need
>> to go in soon. I think it'd be to take a minimal fix for the reported
>> crash, and then Dai can have some time to do a larger cleanup.
> Backporting is important, of course.
>
> What I was hearing was that the simple fix couldn't be done without
> introducing a leak or UAF.

No, this is not true. This fix is independent of the enhancement
suggested by Jeff to deal with the way the vfsmount is passed around
to avoid the condition where the ni item is not found on the list.

-Dai

>
>
> --
> Chuck Lever
>
>
>
