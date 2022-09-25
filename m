Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CE55E9190
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Sep 2022 09:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiIYHyN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Sep 2022 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIYHyM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Sep 2022 03:54:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5785139134
        for <linux-nfs@vger.kernel.org>; Sun, 25 Sep 2022 00:54:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P2CFgu030381;
        Sun, 25 Sep 2022 07:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fWN2tgeXFtHUF/fheeTP7baEg/MrUPrkmW4c/AXXgww=;
 b=XeTxfl2AqRj1T9/juI6Dg101AInbKkx7Fk5oaegT2CUiY4RBHrmwDNQtwQEHh51dpq9E
 D0B0RdY06cRkLWGxKL/+/4u5vXzYe6grNYu2oAsTWScaE4uiTBFuQrHATrMJOtd1afRf
 GKBNoJyLkbSgTkwQaOP6ORtroDEiLMEj13V4T3SLf3rGRrz2C22RA7Ndb65yKCKGjWkP
 JaObQstWArhTD87ijOTA6NT0UWV8YX05eYI8KbtqCq3PH5OLr1PYDQHteV0+yCTKzij6
 qb3Ws4J1B2eCVJLOnFuG1NeMXJXRvglNnOwYwo4DLgf7C6jI/6RYYYdjExspuQAeXcQC LA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssub9f0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 07:54:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28P0LN48021069;
        Sun, 25 Sep 2022 07:53:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jsrb1w0qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 07:53:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpKDaPYIoTHR/lDvp3q48bNRyCWVL6hzqoKqBM0RudGfqr2v+s3F7snix0HHcgB0y00W5Ya4jfW9bTm0TM16KSmTR/Fljwcxpz98gissW+yTufWuG4cFGMHSzghjq6J3MZoleviabEUavBBLG7vMyhbGTw/PgonESYQht7b8jJujoqae6jOV0XIbtX0Dkstuj8xW0VufkqrhY3OZg4LLTn7N1H0TZt6SUk8hBuMpxmX4UAR9CWL78vDX3w9O8ioErZsxhqvbbO9m3oSWDir2N/Apv+Z3vVSPIuHu3893ko5JV1VltkC56hJOHWZZXbQ9wehsUtDqWis9ATAwC9YXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWN2tgeXFtHUF/fheeTP7baEg/MrUPrkmW4c/AXXgww=;
 b=Wb4Sr2HJvnaMb69b4uCQsThGFqQf4MFEZ8UkNSIwj+Zp9vknNT3DdeBHI4eviQTCtH1tV3x02iLCcQUlq/LP4jP0VR4ccHC5aC62gO/SB7ZZn9H4M4DguqCmWErLQYCUsDKYaLUTlVqEq1Yc/l5tD4Z+w6K0fRYgCxv75xs22Kzq5NfKRgAtihHQDRNWIFBgGaf1+YJFapLqPK7J6w29FouE912MybQEQZ0jV//irg6zArrMWTNAyAVwal/y/4mMzXrU0PYbnps88zUPQdVoWYyf8CMYSor7geUFKMA2m6aAIf8TH2t0VqUBU0HChivboM9mu1AxIaT3ZaRN49TeMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWN2tgeXFtHUF/fheeTP7baEg/MrUPrkmW4c/AXXgww=;
 b=DszgxzvChLsWKoZE6iAHEFA8JWt1EbvnT1QoiDQl7lgPpHxJFHndj/GzNz0sEuSpn9AAewlQMqmbO0tErT2OsRxx9W2s9xHMhOwT92uAP96r0PlfAwpdhpAVXxGudDP9SUHIj+IqU2GQMee2f/rADPnbcdHvEvFf5tC0oNHpfFM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW4PR10MB5679.namprd10.prod.outlook.com (2603:10b6:303:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 07:53:57 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::7327:e320:c5d:41c3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::7327:e320:c5d:41c3%4]) with mapi id 15.20.5654.024; Sun, 25 Sep 2022
 07:53:57 +0000
Message-ID: <88c4d89f-1ced-0b1a-a767-6602bd7202f3@oracle.com>
Date:   Sun, 25 Sep 2022 00:53:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2] NFSD: fix use-after-free on source server when doing
 inter-server copy
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
References: <1659405154-21910-1-git-send-email-dai.ngo@oracle.com>
 <442cabb565154a3fe8a1f45192d8c52a24c54e54.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <442cabb565154a3fe8a1f45192d8c52a24c54e54.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW4PR10MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c7661d-28ba-43fc-c0c6-08da9ecb196d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v17oPEqNh+Cf22Xbz+iGi1iIFS6Hb165X1WRgcN8oQdS3LEeqHkg6LVFS8v44ZNJD6HBEbGJECx2iUTVPzsL841wsZCw/rrV7FJpIb6WEgt5Se1YmI0auPKnE8SVWzzRTQIvPex6Ad5qXyzLgWKu1YYeyyPwLNeHUtYnBOlS8u12BbiDP33BkIkFGgeGwwB4TMyzyDFU10mDM38srj54c0uEOCJa5SP/+NzjhduyAyiAxTvVs4iYXSsrBVUItRKBh+rmr4SgVC8p3aVr7JsqpUk4N7SyUgqCfw3S/ILxiItp1zhef8SvhOVrOb6H8ye2218k88oodgBNVly2vnFqHWr/IFhKiNZRsMRIhtTso/PPC2tGFK4daolZWBfmCHHCO9cMneuw1MXA+IGmI+GNMLQsX1L0c3ihyXqLhhzTroRztCLC4BYVARvtjlEVJGmDbZEnfjQHbvDA5UexuZUyy8jQGpfEvYzEI2cAlcr74p+A+k9nauk7l7ETunPtgqwDR/1WQ2SO1wbNZcjwueoAOD4bstpmwYQrz347o5k2q577sDwOms1Vlqqh0VjHubMRv+ggqk0lNocXe0sekA+8FYH/XgIaaKySfXp6HvX5tgKVjY/k8OrlrYL9AWaq6iINT1yPyqViJ3VaPOVhlWNNgNb7AUZnHQ5GBAAKfVDGWyl4weFrdvMEEM1HsVWMIz1ZZp2uWgz2RIU7CaExMIemUvexb7yc4vMSXUq0zIZhqScPEnAWk6dY2SU5QxlBcVN+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(5660300002)(8936002)(53546011)(31696002)(26005)(6512007)(86362001)(9686003)(478600001)(6486002)(6506007)(41300700001)(316002)(8676002)(66946007)(66556008)(66476007)(4326008)(83380400001)(36756003)(186003)(2616005)(31686004)(2906002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZsbEtlNkUySTBYZDJ5ZW9IdEZlNFBWQ2gwcE01N1UxY012OVQwbTRoY2RC?=
 =?utf-8?B?N21kRGZkL3I2ZysvSlM4d3Ura1UyRGlLRWZ4am9TcXU4aEpNN1lyWmtWMTIv?=
 =?utf-8?B?RjdLaHlRMGN3M0VmenRYMmJuZzd1MGZBTHprZE96RG1pYTJMQTN2dTFIaGk2?=
 =?utf-8?B?b2hHRTl2SWtVb3hzUWIwV2FvQm1kdzA5V0Z3QVhOdlZhQXZzVXdtTHZDOEl0?=
 =?utf-8?B?cHhub3JKa2Y3bHFhejdndituYkZsUmZnWXI0RFNKVHR4T3pDam9XcjdEcS85?=
 =?utf-8?B?Ry8xa0FVQ2UxNXZXQWdLWTVhUC81S0pFRjBVUCtrV3pKTkExRTA0NkRaV2R2?=
 =?utf-8?B?V1dFVzZRc0RRN3g2dnVyV2JtQi9GM01lMTRuY2VGNkxsZU5qV2xpc1RkbWhF?=
 =?utf-8?B?dGR1UnQreWpFUXFabUx4cEpBTTFZYXN2NXlOQ3J3L05lYXNSck9UUnhzUGxD?=
 =?utf-8?B?WDU3aTh1VjMvWFU2cHhzYXlucEh6TnV6N0RkNVVBY0FZeVRUdjNSSXhIdmJj?=
 =?utf-8?B?dERHSVJWUmZOaWtaNnhXOFVWREF2NzhEdE5oeDdqcjNHTlY5eVBrU3U5b1Rk?=
 =?utf-8?B?bVl2SG0wdEc0YlI0M0RYall5cTRJS3d6OXp4ZktLWk4vcnVKYjBkWGRSN3dm?=
 =?utf-8?B?S2hFN2dmSGp3clVUUEpQZUxvMTUrdWRQMW8wZVFEc1ViRGlHSkZ3d0lvTUIy?=
 =?utf-8?B?czJON2lqZlBnalpOUWpyU0JQcEExUDdMcVBBakMvTlZnM3RWSUVLWnR0M01h?=
 =?utf-8?B?WDNjSEZGa1RSM0NHSTJ3TUlDb1dnclVCclB6SHA4anRSWkx5T0FNcms4YkFJ?=
 =?utf-8?B?WWlNSlFibnVvLzZtRWpjZjBOcXJBVXhEV3pXMGZ1bXREMmdDcUpjQlFMOFhk?=
 =?utf-8?B?aDBFTEFRR1luV3pmWXNna1RXaVlZSG5VZ0VWN200a29xUzZOQk81MVorNllG?=
 =?utf-8?B?bkd4WlRIZ1F2VEtlUjVXUTNXeWE2TXRNVDAybks4bEdka0kyWHl2aTE2MzdC?=
 =?utf-8?B?dVFCaUJYRVp0UmVVa0ZKSTVtanJtV0RXYzBCbkxxTzBTaUQ5VE5Md0RLSEQ4?=
 =?utf-8?B?NkQ0RzVVNklDY0JrVjV1U0J5WUdYSzJ1QzFDdkZ0d0xrMi9CMENPeEFKakt0?=
 =?utf-8?B?RVFEU21nNDhBMnJFaXJZdGlHcURtdzBpYS9tclRYWW8rdHEybU8wamsxRnAz?=
 =?utf-8?B?Ty9WdGhOTDROYThybW94VXVLRjYzM3ZZNXF1S2sxOGJSNzJ3aS96WWJWSkd3?=
 =?utf-8?B?SU9BUDNXWkN3eU5jWkZjQ0hoVGlXWjZWMnd1V2xpNG5Hc1F4RENjRVVpaTRK?=
 =?utf-8?B?K25MckN3RkRVWDdaU1o1QmxZa1c5T1Jwemt3OG02bnovZE45VDhMSDk5Zkh0?=
 =?utf-8?B?QW9JeEx5WUlkdHlNdmhrL3hOcHBTZ04wTEVWbjkvOG1yV0RrM2dodXNFMXRa?=
 =?utf-8?B?akpyVmREUStaeitSbzJwUXhnUkFxV1o2K1dCaHRWc29JOFJYbTdNT1ludXVI?=
 =?utf-8?B?TEhkMzRuaHQ1QUhhazVpZ0FhVGRLcWZ5eElWc2QrbkM2dGNmbEg1N0k2MThW?=
 =?utf-8?B?VDlUa0MrTXlHekVENndtNEhnb2xPZGY1RmdlRlZFTzYydFRHdVRzUHc1cmVq?=
 =?utf-8?B?ZjcvNmdLN0Y4WEZ6eGV5dmJQMGRPeWI5NU9CSHRyR3pWVnpNSzVJUFJ2cnZ1?=
 =?utf-8?B?aG5CODR5Y2svQjk5eGZ2dGxHU2c4WHZPY3BNNm5ycWxGb0dCWTRWb3VHVzJl?=
 =?utf-8?B?Ny9hODltVnVmNDU0aGJSMEYwUzZva2V1Sk9PaGIzZkU0S3JMZ25uN2Jmem9W?=
 =?utf-8?B?WUZ0RGVtU0E2NklJRjRaWWxBdlRVakRCZ2REa3dhc1hHT3c4OFlSQUdzU1Ni?=
 =?utf-8?B?blNQOE5VRWtIVktaK25yVlljZFROZU1uaXh0cjF0QkhoN1paZVZwQ3FvTkdp?=
 =?utf-8?B?L3piMGRzaGNqdWlhbEUvM1RneUkzRWsyWXB3VExoWnVXRXUxQ1R5Q2lvcGtl?=
 =?utf-8?B?bnF0NEk3bkx0YTM0UG5mNlpReitvUDZjQTYvUUhMTmN4cDFtL0g3NGFRYXBt?=
 =?utf-8?B?cEdLeDMvVTZzaWNVc0FORGlvUFNXTW1rS3lROGVCeGU5eUJ2M1d4dlJYWmlT?=
 =?utf-8?Q?jAcHmKKmw5o7B5p6UDcXN5P5n?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c7661d-28ba-43fc-c0c6-08da9ecb196d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 07:53:56.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyZTtLJ76BL/owOcf8yDsSkw2QeTyTQ+2bblZJ51fc+9N1zV2op+zT7LqHMjz3Xk/E380InuijWolmdBaejzEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209250057
X-Proofpoint-GUID: -8veFip2R9w29tshOPBi0MppS9jRxQnO
X-Proofpoint-ORIG-GUID: -8veFip2R9w29tshOPBi0MppS9jRxQnO
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 9/23/22 9:28 AM, Jeff Layton wrote:
> On Mon, 2022-08-01 at 18:52 -0700, Dai Ngo wrote:
>> Use-after-free occurred when the laundromat tried to free expired
>> cpntf_state entry on the s2s_cp_stateids list after inter-server
>> copy completed. The sc_cp_list that the expired copy state was
>> inserted on was already freed.
>>
>> When COPY completes, the Linux client normally sends LOCKU(lock_state x),
>> FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
>> The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
>> from the s2s_cp_stateids list before freeing the lock state's stid.
>>
>> However, sometimes the CLOSE was sent before the FREE_STATEID request.
>> When this happens, the nfsd4_close_open_stateid call from nfsd4_close
>> frees all lock states on its st_locks list without cleaning up the copy
>> state on the sc_cp_list list. When the time the FREE_STATEID arrives the
>> server returns BAD_STATEID since the lock state was freed. This causes
>> the use-after-free error to occur when the laundromat tries to free
>> the expired cpntf_state.
>>
>> This patch adds a call to nfs4_free_cpntf_statelist in
>> nfsd4_close_open_stateid to clean up the copy state before calling
>> free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 9409a0dc1b76..b99c545f93e4 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1049,6 +1049,9 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_stateid(struct nfs4_client *clp)
>>   
>>   static void nfs4_free_deleg(struct nfs4_stid *stid)
>>   {
>> +	struct nfs4_ol_stateid *stp = openlockstateid(stid);
>> +
>> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
> You're casting a delegation stateid to an openlockstateid, and then
> getting stid back from that. How about this instead, and drop the
> openlockstateid weirdness?
>
>        WARN_ON(!list_empty(&stid->sc_cp_list));

Not sure what I was thinking, I'll fix it.

Thanks,
-Dai

>
>>   	kmem_cache_free(deleg_slab, stid);
>>   	atomic_long_dec(&num_delegations);
>>   }
>> @@ -1463,6 +1466,7 @@ static void nfs4_free_ol_stateid(struct nfs4_stid *stid)
>>   	release_all_access(stp);
>>   	if (stp->st_stateowner)
>>   		nfs4_put_stateowner(stp->st_stateowner);
>> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
>>   	kmem_cache_free(stateid_slab, stid);
>>   }
>>   
>> @@ -6608,6 +6612,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>   	struct nfs4_client *clp = s->st_stid.sc_client;
>>   	bool unhashed;
>>   	LIST_HEAD(reaplist);
>> +	struct nfs4_ol_stateid *stp;
>>   
>>   	spin_lock(&clp->cl_lock);
>>   	unhashed = unhash_open_stateid(s, &reaplist);
>> @@ -6616,6 +6621,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>   		if (unhashed)
>>   			put_ol_stateid_locked(s, &reaplist);
>>   		spin_unlock(&clp->cl_lock);
>> +		list_for_each_entry(stp, &reaplist, st_locks)
>> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>>   		free_ol_stateid_reaplist(&reaplist);
>>   	} else {
>>   		spin_unlock(&clp->cl_lock);
