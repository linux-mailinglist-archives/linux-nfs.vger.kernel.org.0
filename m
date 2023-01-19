Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6356730FF
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 06:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjASFKD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 00:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjASFJQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 00:09:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983CE3AAA
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 21:05:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmk4w006399;
        Thu, 19 Jan 2023 05:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dMw3gshxEwTu8u3hqeUH3bVoU318E1zmh0UEfxWXha8=;
 b=Tcmm9e/JsohC1YmOwFHLbC6FAuDUz+slrY/6W4XtK8mvkiAmV2HsMpfRdn31lVBRcRfG
 wwapTUA3CAGEpIwupVSG1a8DJ4uho48KGLssotQLC/LqabaFfpLkxjegUq0e1P++a18i
 gF3fpPhmBpXOGj5xJZXxm3NtBJb3FFIKapO6GSerf9SZwZmlxcGFSjmvd+V7WF1pG679
 E7vE0XJ4ItEsGXISy2iEgjRuDkqf6rQta9E5HqPUjaJ5T7+noj2qH/f05OlJSig0bDME
 mV0N3IeYKQP93LfHtga5AtNZhVSoLlNPJMEeIP2ChXe1R35hKg2xdkEIvbbVCT++CDDX OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt98d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 05:05:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30J3UT2c028461;
        Thu, 19 Jan 2023 05:05:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qug535m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 05:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laP4eW+na1wPLpdXMuHQorFDuaC2RpzfeJn9ZF7jONrnjwlQiC+HiGa8/MklrZ86/CBJPd7n8kOIH90td+bU2u1cWoQ45WXD2if9fCwLhdc6wA59t3LXFx20CHVJq0FSFtqmwaMi2xAhYjkff3u0Xg+9kaVMrgnXNyJuHFTHpdCB0mpBIgAKbK1HomB1XP2V9/LXLgRjoiL2pwi8xb61RaXPqmtI8r36K3LHH46av1/MbgrOLBFwoAkt+RCKl6ywxfuItsvRlxr51uc0r1FWMPtS/bczokiSxtckHmWQJnPPkvo9AHniSE3e7LixsmVV2JaMF64J1hUU6pDBjoJ7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMw3gshxEwTu8u3hqeUH3bVoU318E1zmh0UEfxWXha8=;
 b=CQUOomlxIfmzZh4U1xir9ibYhXDJYo8V4AVuDgT7tO1ktCqdvOVDMqA6PrO4jQ0aZuwWTyQdZt7k11fuKeZpiF+LRrDZGkk7uqHi6MIcVBOxPEL1MlWUYwu8OrbPiJk3ZrbGiTbVAqmz+LM12NgZpCCv/dn1mon6TFAKjmUaqnL9JO+8SdjYzO9R7DfVwvfjz2PM5smCeBP1/jPMc+nV64hNUFMZhjdVGWUsBwBWG0VRfFOZrD5C0teAVRYHaDqkDt4bfXtJcjC+siNmQEBAKCq42e1GUXZKDkvrxZjYJCHI5hEZdptJEj2b5Q82GinntkCHRlaEIHXn/J0JCCLcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMw3gshxEwTu8u3hqeUH3bVoU318E1zmh0UEfxWXha8=;
 b=QH62voNnXR07vpKbzstflM31p3hkb9auFUZnzr26PrRa0woqJkKGRObREPSPD0M9F9HvhzVwIHvw7B5MbYBAWKnltoAxm+GKgpvzktNBHGYhTvPHzdn8gpzfPT48poYkWKcAqok76GDcas9ubzA+8lM7Q6mnpJVo1ZqE0Zsxq1s=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Thu, 19 Jan
 2023 05:05:35 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 05:05:35 +0000
Message-ID: <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
Date:   Wed, 18 Jan 2023 21:05:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, aglo@umich.edu
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20230117193831.75201-3-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BY5PR10MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cba64a-cc34-4391-579e-08daf9dacc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtKwgWGZoWMbHYQWOOV3uNotF6TRbhalScHP6L8g9Q+LFV5WAbHrhGjb1sgvQhmGmblSWShEdotMdlHasZ2sF1ne2BtweZT7h7wzPi+koK/q8KQC7kn3jYcLGquFNDApg4J494HvAvaRg9lOfCx/HneknnuoaVUNuPoHCXtC++XDB3hchIB4IGwN+zV+bi/dwmiYizriQVF9kfslg+I0WcCKgMfrvgs5uIAas51kwrmG7GFwS/5njg6iyNSfknjYjiITnE7IQ5qimj/kqiZ9Lvz/9bYE3rNtV63eT9cyj6F7tzzrhAlX2isFrjoC45O2g9EUkUyJcO0atNEH/TS8F259kjV9fshEf66y4ZbTEji4BDYGTklZ9/GBMY7LZjef0PRxrqXtJTrTeTa9K7JL74QCXKwp//X92ZBq+5MCeOEAWLZY0YsO6znkKkcq3q+2WjlMYCtJzD8CpmySjvqlEq1rYUrXe/3kZzJKSmgrckF9cUT2uZ3B2S6cf2o25mfW9kIj+/SfM/0/A7hzsKuwX2GWgOvwt1n0u2c1DErBg7OiwkhbHqn6doRI4HDE5ln5j3bYvFaW3ZMj/QMr2hXBEVxd/r2zy4jV+VPRfhuHYXOtrJtP+2qgeOsu+H/7/sPW2pYjn3tEZLcqt0KMR1QruPIlPH6D0eqqaJEIpCa1m3VWDVxxryne5a4EZgv83N/k8jzyEbmjOPkQeUL7nNXEoQG+z2t9NfNTGhPDw6d356Jou/cpVgSk2/BmybRywCnK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199015)(31686004)(8936002)(316002)(5660300002)(86362001)(6486002)(36756003)(478600001)(53546011)(6506007)(31696002)(2906002)(2616005)(83380400001)(38100700002)(66556008)(66946007)(4326008)(8676002)(66476007)(186003)(6512007)(26005)(9686003)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STN4R2N6eVQ5YzNhZVozd1BrZjlvYWNoeXBkaTZQVXN3dm5GOGJTcks2T204?=
 =?utf-8?B?enV6TE5GQkc1TGxUelBIajFhbkR0eEMrQllKQnhtOWxVc3lZZFVaVTM5OUN5?=
 =?utf-8?B?VGFUdUQwUTRyWTN1ZGFTZ3NvUHlSVmR5cWlyQlhpUzZ4Y1NGVGFnd2hvdHp6?=
 =?utf-8?B?WGkwQWJ1SzhEYkRpbjRYTnhqTjJvbFB4dHNhelNIYlVCOXlzYlJoanNWb0hD?=
 =?utf-8?B?NkM3eEVFdU5wcW9nSDFYMVRBYkFvOUhKTFQ5d3FuNWNjdWxmVmNndXVZNkp5?=
 =?utf-8?B?YVFVWW5uazcxdUNqSitPRDBTZzI1WWNnSUl1NUNtL1JSVVo5SW5BcXRkUS90?=
 =?utf-8?B?aVN4cUl4ZHhhTDFxMDRTS1JsSlN3MzRVQ2s1b1FNME16dHF1RHNoYVBhaW5F?=
 =?utf-8?B?ZU9FLzg2RFd4Y0l5Tk1pNWRqNm9HWmRqSDhDRjEwMVRZQmpvSzJ1QnZiV3pv?=
 =?utf-8?B?YlRrZHY5NjBXT1hhNnBHRnNCaG1DZTIyVlVaRlhkK1B6aStRTnZNZVJnZ1NG?=
 =?utf-8?B?R0ROblk0aTVuczROTFhJWHZXQVVraWlsN0wza04zemNsOVVkZlpNbDlKRnBD?=
 =?utf-8?B?djcwcmxQQjdpM3h4bW5MOVR1SlVuUHJGTjdtRWI0eURKUzJCOVZXRGpMNnFy?=
 =?utf-8?B?bHJvTXdQeGtObHJuMVNyLzI4eEV0SW5ISUFzc0lheW90SmtGN0prWjZZU1VZ?=
 =?utf-8?B?Skx5dnQwYXhKRTZidDd2ZVdlWWVJSEkycStueTR0ZTd3c2ZEcjRFajgvei9m?=
 =?utf-8?B?Y3M1QUNjSnNqRC9QS3dBMkZDbE5Gb3ZlUUxPTDQ5bzRIWjZ6S1Z4L04yZnM5?=
 =?utf-8?B?QjZDVDBoZnh1eTcwZERFM2VHUmcxQkhNQ0s5SkU2MDZWUFR2WmdkZzNSTnNm?=
 =?utf-8?B?eGNVRlVYYWVjRFNNSXhKdWdxN1h3djhTSXpVZXRoL2dXSFRBTjlucGVTdW9m?=
 =?utf-8?B?b0w1Vmt2NWczdkdaalI1UmdrUEJVTy9RdnpuR3ZNZkVDSzEwdDg2TWlCTmJi?=
 =?utf-8?B?YlFWcFBTVWhGT1FGRkFnck54eE02V0VwT1RrdDN3TmtRS0o0T0lBa05CcVlK?=
 =?utf-8?B?YnF5SUFFNzEvOURxODJ5N0UzM1FTNE1IWFNkVVorNDhWeno3SGZCVlZEdjFQ?=
 =?utf-8?B?RzROVUVCSE9XT0NNUGNGWVVsKzhUUW92YlRGNURtUEhBZTMzT2lLTUZobnIx?=
 =?utf-8?B?K3ljTlBSTk42NkdlUXBGc3ZjRWNHKzVVU3JtYzhwYy9WVVp1Zjhsb1BVeU5S?=
 =?utf-8?B?ajdOZ29WaDdLYzdIcXF0U2M1WXllZUsvek9LL0ZaTEROY0Y5VTFYQ1R3SmM2?=
 =?utf-8?B?eGt1cEtFOC9ReUhOMmMydjNqZ3l0cmVnbWN4WnBFTFlQMmQ2NnBtQVhtQkxU?=
 =?utf-8?B?MWVmYmNTZEkwYmJlc2Z5N09FVVhMdnZGYzM3R2ovTEozTUZ4L2xMZURkUkFz?=
 =?utf-8?B?SVFsOWp2OWNIWFNVRHl6VHNvYmx0TmtFNVhXUkpmTjhhS0c1c2E5OWQ3RCtO?=
 =?utf-8?B?by9FMU5rUFdUdHVIKzU0bm5rQUdxRmpoOW5QWnNuYlErMmgzVUNxVTlBY0VC?=
 =?utf-8?B?akFiRnhITU91SEZnOTByN2w5WmRIN2NsMXdZeEpGY2lpeGFJc2lFOGxiZDg1?=
 =?utf-8?B?OGNEbkYwT3lEZ2NvQVlzQUxneGZVVkxpdXlvQ250akt5NTlyN21YNFhWUjNJ?=
 =?utf-8?B?UWZXNzB4ZGVhT3VZM2d1ekNnVUFIM3BhMFZVdXkvTC9hRkJJZitTdnBYR0VP?=
 =?utf-8?B?MHVpb1UyZmE2ajhoU084V0dKOGxpNjh2UmxkdEc3Y01XQmpYaThoMExsWTdQ?=
 =?utf-8?B?TklTQ0E0WjlBTXk3V3ZTaDBhNm9tZ2ZPcVJMRHg1Z25xUmVSbGVFMW54Ullp?=
 =?utf-8?B?NGFtWG1aMTA3SDRxZHhzenFqNi9iRy9ZSFpMV1hEeTg4NmJqMXFLSmZJT0dT?=
 =?utf-8?B?QWY2ZU94aDYzN0V6VGI0OUpkKzB5MTYrN0hORTNpYXdKMXg1dXJubkhkQlMv?=
 =?utf-8?B?bVQ2STlpQ0plWnZ5Z3ZGM2cxOHdWSUtvSy9zV3NSbnV0VndiVWJYTUVvZjls?=
 =?utf-8?B?dW0wZy9oS25sRWZkNXhaUkNMTHhjQVJBTWpZdi9WSllqSXZjUDJCVlkvYnFZ?=
 =?utf-8?Q?SDIKK/+aZdh94dhUFhX64c+v5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ej+VwudOVK2KtJLsijTNKqhWzCnvt6sPvyz1M5jSn4JZrxTDL9HW832oakVHof/PrMnUI8PQOgtyfpPFfojTeWXpsGvpHpOobo7jv4QxawPj5f3yx7Z0iMAPIPXt1GKl4OfuzGJ9WzSM7go6calUq3vYg9I4VCDLiPumh4PbJMB3R0RtDAY/xjuCpRDYRiOrOaOAy4CMhQceFXD5RkGINNln2OxwZJDQm7S0UgHpCP29y/EpRi++zHCZM9gt/CqiwDoJ1dUwoYdDiiMcAmge3ZVNYRe1LkHtcEjHrFygZCihe4EK97+oBa63D9XZ0CHWikL3B4MbmO6v4dN0b/MrwL4w/+Athq8HFoRqnZuYDHlQClUksvn3dbwXABfC0hK9f63xjkG51Mzs7EbYnlaiMSuR5wvIX1n0Q7OLWyrunUOVwLiXnRDtDKDqnQ7ivhCfHoPkcSWe/Ib03YW97AtsSLsQyGridNgGar0P6Hh8VZSijVGuzzEsDN9mZ2xJ4ZtdRASfj6mY67uaR7p4GJj8rYAWIz+OBI2MBV43mvMFN9qSHWZYaYsp+ec9L48/F5GbmWCcK3Fu0BQK8FbzTj6OKx92kbiGp0sJThaopdkoMH4sxroz6AFGS5oVEgDazAqNeJ3GyzeCWTek6KSjUD+gEcG4gpADGu3midBZSQl0bsh++xIDNuuDS3A75FjuPGnA+D4kqzPPkgD9HEHRuLxWNFITyuw5P17gG+RPwrhsAUblfOrn0CoA1Q3/pwAF3dfIZ3y/YWkt6Ct2sHVbN4qyR/XbDqqFqT5eFx7R31in0pUeMvNJhLJNY/L1pGeT7aFS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cba64a-cc34-4391-579e-08daf9dacc1e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:05:35.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+BBgOB1LWuQ+QCfZL+aJ4wIuIwvyhsSLj5Zle5rEO5tqrimhpjKDbTYpQSydE9S2yfPYtL/qNhHpPnqwRGvMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190037
X-Proofpoint-GUID: _suaDVJFYUUrRrzyJ9-RRBxbGNoIdDsk
X-Proofpoint-ORIG-GUID: _suaDVJFYUUrRrzyJ9-RRBxbGNoIdDsk
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/17/23 11:38 AM, Jeff Layton wrote:
> There are two different flavors of the nfsd4_copy struct. One is
> embedded in the compound and is used directly in synchronous copies. The
> other is dynamically allocated, refcounted and tracked in the client
> struture. For the embedded one, the cleanup just involves releasing any
> nfsd_files held on its behalf. For the async one, the cleanup is a bit
> more involved, and we need to dequeue it from lists, unhash it, etc.
>
> There is at least one potential refcount leak in this code now. If the
> kthread_create call fails, then both the src and dst nfsd_files in the
> original nfsd4_copy object are leaked.
>
> The cleanup in this codepath is also sort of weird. In the async copy
> case, we'll have up to four nfsd_file references (src and dst for both
> flavors of copy structure). They are both put at the end of
> nfsd4_do_async_copy, even though the ones held on behalf of the embedded
> one outlive that structure.
>
> Change it so that we always clean up the nfsd_file refs held by the
> embedded copy structure before nfsd4_copy returns. Rework
> cleanup_async_copy to handle both inter and intra copies. Eliminate
> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 37a9cc8ae7ae..62b9d6c1b18b 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
>   	long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>   
>   	nfs42_ssc_close(filp);
> -	nfsd_file_put(dst);

I think we still need this, in addition to release_copy_files called
from cleanup_async_copy. For async inter-copy, there are 2 reference
count added to the destination file, one from nfsd4_setup_inter_ssc
and the other one from dup_copy_fields. The above nfsd_file_put is for
the count added by dup_copy_fields.

>   	fput(filp);
>   
>   	spin_lock(&nn->nfsd_ssc_lock);
> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
>   				 &copy->nf_dst);
>   }
>   
> -static void
> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
> -{
> -	nfsd_file_put(src);
> -	nfsd_file_put(dst);
> -}
> -
>   static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
>   {
>   	struct nfsd4_cb_offload *cbo =
> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
>   	dst->ss_nsui = src->ss_nsui;
>   }
>   
> +static void release_copy_files(struct nfsd4_copy *copy)
> +{
> +	if (copy->nf_src)
> +		nfsd_file_put(copy->nf_src);
> +	if (copy->nf_dst)
> +		nfsd_file_put(copy->nf_dst);
> +}
> +
>   static void cleanup_async_copy(struct nfsd4_copy *copy)
>   {
>   	nfs4_free_copy_state(copy);
> -	nfsd_file_put(copy->nf_dst);
> -	if (!nfsd4_ssc_is_inter(copy))
> -		nfsd_file_put(copy->nf_src);
> +	release_copy_files(copy);
>   	spin_lock(&copy->cp_clp->async_lock);
>   	list_del(&copy->copies);
>   	spin_unlock(&copy->cp_clp->async_lock);
> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
>   	} else {
>   		nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>   				       copy->nf_dst->nf_file, false);
> -		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>   	}
>   
>   do_callback:
> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	} else {
>   		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>   				       copy->nf_dst->nf_file, true);
> -		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>   	}
>   out:
> +	release_copy_files(copy);
>   	return status;
>   out_err:

This is unrelated to the reference count issue.

Here if this is an inter-copy then we need to decrement the reference
count of the nfsd4_ssc_umount_item so that the vfsmount can be unmounted
later.
  
-Dai

>   	if (async_copy)
