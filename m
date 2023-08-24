Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17846787829
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 20:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbjHXSnW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjHXSm5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 14:42:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628F170F
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 11:42:55 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OHjn5Y011783;
        Thu, 24 Aug 2023 18:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=M6wdUsxr1tV9vY7hCbwdduQGgaj3YTvvTUAMeN9e8sg=;
 b=fCuXF5qQsLfffBgLC7W4EwyJxZBI4wWl6VtSi/fhEzUPWRZD9u3OtGW1qElwAjMcgVnQ
 n9KQ3Z44/H5Y5kv2mocI7QC/lRxlWIZW2q43CEpcLqLhdR8MTDpERbwsDNGbHNC2bhLN
 H3AzGWwVF61o0ByRDTZLEHteMv7Sn5TEvPFLh5sSCN/K1KwkcQk/tWt990q36wqSgIHW
 wgrOZ/y3iKVY70ljf0bJDPRSuv1PyxymUlDYavqEIYd7ZVHMKpvYBD4Rhyssh9yMZo6g
 vR1xqy4DsFcbbP+f8mZ2+AICg0OA5VduKDBFW7v+8zGB5vq1ycgRR5bh+q28WjnawMXz XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu4xys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 18:42:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OIVbQH035800;
        Thu, 24 Aug 2023 18:42:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ypu25y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 18:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arz7MHcgVyhT29Fhz0e+9ZJkhzDwFyfIBqgD3ZLwSVvl205Bb7rRAo5icuHq6k2TWxq6JqfGmO7bbUKdylhRFDbRE4TBJzOV4xPy2L33xhM+wOikBBB0BFJwodArO6ROByu4cyhy778fT3ow6lqDMSgK6TNL1X+XzG7UCTeHlvHCPzCp1bpIomXgTUlllc42ILSSiNAJMO+VCbbnZo4pbOftB0ytk04uTJkuf0JJVANr04JoXN2GMFhIs1dce30aKjmkgj7WdEBoKxLfL9gHACl/R+nuCThLkPp42uXBaZD/V6omEsNzxFcIoCPdS1T0rP6srmwq7Uqs1Q1la8t3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6wdUsxr1tV9vY7hCbwdduQGgaj3YTvvTUAMeN9e8sg=;
 b=nH7JEZ2owr/dKN9+OeiUoF7k2w9bQ2mWJn+tPqGbas6YrVdQhKVZJps4r4tbqEilvpubyh2XKdxq55Qi4eiOPepGmEp2vxo0eaQ94MUrXD/yer+FmXUrUZ6EkBpvdnB6YtFtnjuEvdReDvhH4zuIvUvXFsszNpJOQ+QNjjtUS5oOnIMDdYF711xtUmdfKoANZB8Bd1SIjCEK7Px0iEV3UKfePy3NLQhXLHH7isK1wL1sItbHRyQEWY0hjocnOF4aSCm9Qo48wc5hsdu7/n2NdMeKjhIe4QbPm0z4RwHsHhw7enj/033QH63GI0jYdV/mJ7TZIQrWCgPC93b/cCLY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6wdUsxr1tV9vY7hCbwdduQGgaj3YTvvTUAMeN9e8sg=;
 b=ybTlVuX3zydLj3n+lci/IlMrplz4vojJgyLBLZjYWxM0dQ58ucLSqKEYEbSeCjjPH4e1W0O+Ctm/5SSqOQPdrRrP0R829ToetPqsWH8Y+kY38afR+rwoBbJiKi5NP4yyy5OpgYB9z89Nm1Wxjo+NRtvbA6vJHcQ34S/TLhxoQAw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA1PR10MB6242.namprd10.prod.outlook.com (2603:10b6:208:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 18:42:46 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 18:42:46 +0000
Message-ID: <5b0bc635-40bb-2c3e-28dd-b9a71814a7bb@oracle.com>
Date:   Thu, 24 Aug 2023 11:42:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
 <c02190c39f123a16aeae70fd65a68fba4aa70b6f.camel@hammerspace.com>
 <067a68e1-cd7a-55c5-619b-d64266b5ada9@oracle.com>
 <af94f54e27b14e3129691d78ae1f439b33fb7733.camel@hammerspace.com>
 <24ae5b14-0fe3-15e8-37e8-e8aed0cdefa9@oracle.com>
In-Reply-To: <24ae5b14-0fe3-15e8-37e8-e8aed0cdefa9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0135.namprd11.prod.outlook.com
 (2603:10b6:806:131::20) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA1PR10MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: b482dfe6-f482-43ab-ef0f-08dba4d1e89f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+b5lRzk1AHBNSnKnAoMA+XJHQeYqpYZa4PDSckxjH3oxkW13/iO8czYP286OsFBod5EQeRE0zD7zMqGKeBfHPz9ytxqQxElWb/JiQMTUahB/nRmvjjYndlt65xyhFs3T81SNZahP0rYjuElnYHunTRmkjSyHE8QcL/O0/pJGZPE8fdDuY6YMB6Fk4gJ/9CA31YNc98aFju91BTrK6+gbhaUM/CJbPtJUO+e61V/hSVCRECNfBmF3flwxzF+MxxqsOOmornc+IHj//mek/e3iR6FZ45OFzhw/93HffOJ7d5rf5FGWdLMwz3IdXQXxxaAIGCRIQbtYqt8oWCvuBMMNbWK9omH15pnnI8MTMYYwSTEPEACes7vjuvIl7ph2KRnhbiwd+4IIkQ7ufwQR0lsOLjYOcuoiYNUz5LDYdidAX4cVUNA00i/klopN5QP6pUJ+zyvxxQ141RROSsiwgIhm6y1DE+rxhXD//y9dyg3bkDRDUconQ9M7SG8YpXFHJPt47sizLrMBzwduVwvGp0ufx6imE9OTudwfOoyYrGPJ+oG0xlm0p5B7+WBhuIqcoXZ5wgQViKk6lDxGjn6E0SO2DejsWJkqHqtCbcSXO5psslrbGgc3E+y4FJpbDCqN5IF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(1800799009)(186009)(451199024)(2616005)(4326008)(8676002)(8936002)(83380400001)(15650500001)(5660300002)(36756003)(26005)(6666004)(38100700002)(66946007)(66556008)(66476007)(316002)(110136005)(478600001)(31686004)(41300700001)(2906002)(9686003)(6512007)(6486002)(53546011)(31696002)(86362001)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDUzbTlTOUQvU1R1RDNZWjFoaFJuN2hkendKMXNUL3UzbUFTUnBZczRtKys2?=
 =?utf-8?B?MWpmS3hsNjdoQ3FaUndxN2Y5VUZJWUdTb0tvWDhYYnJJU2Jxa1Y5OWZQS3VL?=
 =?utf-8?B?WW9EbjErbnQwU2RhZGJVQUI0bnBBUDN2T0RVdmxYZytWUnVFcDlCVVFjNE4w?=
 =?utf-8?B?N091cFVzcnd4SEFqcnROc0hGUVVaWjFnb0VPQ09xUXIwUjdmVDgrTGhkQTZM?=
 =?utf-8?B?bXI2UlJCNUdmUHFhOXJpd3lFNHc4WE5HSEk3R3NPbldlRlo5c3Y0RlRqZ3BD?=
 =?utf-8?B?Vmt4Wm9ZYkVjb3h4bGl5cVdSZlI3NHUwZExqdncvZEVZTG11bzYybEtxOXI4?=
 =?utf-8?B?TDJvcVZZLzltT0FLdVhUOXVnVytyY3RuV2FaK3hIZmtRd0J1Sk5uNE1zYWEz?=
 =?utf-8?B?Qys0bDI0Snp0NkRtZExCU2RKYjBHSjZPR2hlUUxsT1NlaklhNUdDd25TeGZi?=
 =?utf-8?B?bjJ2ajhyYmRCSUlJRURNNjV1c3U3S3kyRy9oM2I2OTBDcTZDOXRvUEQ2eWFo?=
 =?utf-8?B?NEdUL3JXMjZlMExVS3dLalBPSUtXeDY3VVBlUElYWVlKZUp5UTVhWXFYOXlL?=
 =?utf-8?B?WEdCdHk1Mk0yemlTYWo3Ulhqd3dlN2ZvVkd4ekZNTUhCaUlSNEdqNGVMWm91?=
 =?utf-8?B?dEVKeHpNTDlOY0RHdmNtZFRUZ2tKaWtHSzFzSnVBTXA4RWw3cUFYUzl5WUZN?=
 =?utf-8?B?VDVGMTM1Q3pSaDExNEE0Z094ZTM1TnNMMWxsQ0hFZ3lDS1pjUENDTXZzODV5?=
 =?utf-8?B?bW9XVGhueG14U3lEN3dmUWtkVnJtckxnSFY4TFJLNEtmWFRIMTZhb0M4OFF1?=
 =?utf-8?B?U0ZNS0tVMlZ4T2FGZjRWUEwvZU5zUUgrY3lSRzA3VGxGSmdmUnpBT2l1OTNY?=
 =?utf-8?B?MHl2QUROYStVM1JreVhSUGQ0bmdDZEhpUVpvQXNIbk1Hc1pMRDFIdTRLZDBh?=
 =?utf-8?B?NGxTTldFMDhPSkpNRjVIQmQxd0ErS25QQ0l4L2RuQmxubUE1Qm9USlRkSllJ?=
 =?utf-8?B?K2NjV3dTd3dZK2VKWUp4N3pOOCt2cjlXU2h1MGZ6MDlndkF5V2pWM1FVSlFP?=
 =?utf-8?B?SkZERWNJQXZNRUdFVzIxY3RTVDU5MWRPMmJaRVZteGJQdm9jM0NybElVNndv?=
 =?utf-8?B?ZlZ2ZVFUcnhRUWxXL1FoTjJsMjY0d1hEdHpuSE1TWWhTb0JuL0ZwbDVDd0V1?=
 =?utf-8?B?K0xOTUovUUpNOUZCSTEvRkpsaTJiNERrT2xzeW5ONTlDTXFsMFFLTHdka2xO?=
 =?utf-8?B?U3h2Q3FxaSsrTUtEdzZOUHdWbk10OEo4VVNqSzFPS2hFMVRHT0d2RHdzODhM?=
 =?utf-8?B?d2N3Y1JuMXZNMXJwbW1pblRrMG42WFJESmx3aU0zeHdCZldFSFZFM2VSWXVw?=
 =?utf-8?B?RjQ1QlNLWndOcDUxRnVSR0JrdHVZNmhza0l2YVV4RlV2VE8vUHBENGRHTTNZ?=
 =?utf-8?B?TzZicUFKSVEwQk9sRkF2VXI5amxRRjd0b0RBTks1N3c3aXk0bXBYajFYNGhi?=
 =?utf-8?B?cjFWNC9ZV2g1cGFZU1JIVDlTdy9yS1A2NmU4T0xXSTA0bElUcWM5ckRzQ1B5?=
 =?utf-8?B?aGMxSVNoalp3c0RoVFNqUEVEbExwQ2RwMitYamZZRlVIdTNpSXBqeE5NTWs5?=
 =?utf-8?B?YjRqeTZaTmFEc3R0VDdMdDMzZXo0Mmw2TUxsby85ZXhGUGlPODVrVXRxdnpj?=
 =?utf-8?B?VTVKOTJOYnpDQ2IrczlpQVVqeHVjamZZUDdtUG1jN3BuYjAvOFkvV0ExaWc2?=
 =?utf-8?B?dVJoankwU1VXRElwWU5zUytJRmsxRlZZSjBYRW5VeVJPdloxM2xiQm1QRFJH?=
 =?utf-8?B?UzAyRjYzQUF5WG5aUUVxbXArYnZnb1Ryczg5ekxYTFdCejNXUUZqZVBsUnFJ?=
 =?utf-8?B?SlM5ejVCN2hWWXRRdFFCRzIrVkJtRWtzKzVINERBTlBqMHpUSXlwUnNtZnZx?=
 =?utf-8?B?YmVUNnJWTS8yVVlpSEpWaGJYTUtORndRVmhIeXo5Rmw4VXFPbkhmdWFKNENy?=
 =?utf-8?B?aGhTc0h3YzRNMGFITm83SHJSN1paaXUwWFFDTkxnYW1Nb1BPT2dPQ3hCeWtG?=
 =?utf-8?B?UURXZkFsYk53TngwZ0R6QXdORUZsS0J5L0l2bDUvbzFENGFKdkZ2TFdpMFQv?=
 =?utf-8?Q?FoPEfeWPZCS2sViOlFqplsApY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4EGWSjAvAifBjpjC9KKiGLhU3O8Y4FFsb/X+NkU/PDiI4GNj+QKAgDH6TDzv7V0gZ+Tt8jwid4OiikHu886GdBtulzLxzkNOdzkkcShq2QMx94qtIG09+8dIa72ISwSSKqhOYeS6zPu8XwtZ8g3OU6uQVjL5O0qgaKJmHyqpV4IOnrID1Zvw+lwp8Wa8bAujsDI8e8eVYmPGOam8hh+q+lvPVoCldPiuR5Sna90jw8//GYoRG5JP22gY4cWeXmwYYFpdr9P8uBhi03dVby0ZePgd7R9b8dNX5mz79jcCjKzTGxE9E8To3iQZcf6QueUdhnX6kI+2aeOr45pTE1A6+yq0hY5dtBGoB7MWKMrb6A7IWNn9uuE1biYofzo6smKiCoekgDiyUFTfvrskfaf1fY5zEBpQQCbl/i/NCrpVgsB2yJ1D3ox7O5WTXT/mpWNVmt5m7MhGQQsDyDjbGfCL38tJ+RWhkz1zPc1DvRAYmMkYE3wYQL4LVjNnoKP8goDQnwOMu+gB5v7Xi+EKPI7FMsmPCieroCYoepfucwO8MAv00qPk0h/DQp/2pmGIj9PEmSr8IMAtFGL6um8jzlydOSwSyLBpfh8CZ5tZjQAfNzDlWmVTkWHHchmY3q8uguMhq1Giyd4sbx/5R6WSCg6TTktZX2FDq4um9I6xIsHXg2/D7+fCmUw4loawKJZZHGj0ROdyKPHplz8r070Paw0aO7MuN/Mx9sLSErcA6DJPHHbYnbqdOPW0pSWIjHra4wC32UZw42MZ3sLEi+U7q6h+J5o5U74JoGatZq9X4Tw4SQIZzoIkaLUuzxIhsNJkETZ1JIDYCsBPAhbiwgBcmcpnEA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b482dfe6-f482-43ab-ef0f-08dba4d1e89f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:42:46.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgGnAOno52F2uOPtsbNhX6eFXoMPz2vwT0Jj50NUXWdB1NN1VJQHqfbdPoo6t5q4ogqr2t5F/KQW8THun8oy/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_15,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240160
X-Proofpoint-GUID: oLk68XHUAE8vs2LFX7VkzuUXn6JM31qL
X-Proofpoint-ORIG-GUID: oLk68XHUAE8vs2LFX7VkzuUXn6JM31qL
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/24/23 9:38 AM, dai.ngo@oracle.com wrote:
>
> On 8/24/23 9:34 AM, Trond Myklebust wrote:
>> On Thu, 2023-08-24 at 09:12 -0700, dai.ngo@oracle.com wrote:
>>> On 8/24/23 9:01 AM, Trond Myklebust wrote:
>>>> On Thu, 2023-08-24 at 08:53 -0700, Dai Ngo wrote:
>>>>> The Linux NFS server strips the SUID and SGID from the file mode
>>>>> on ALLOCATE op. The GETATTR op in the ALLOCATE compound needs to
>>>>> request the file mode from the server to update its file mode in
>>>>> case the SUID/SGUI bit were stripped.
>>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>    fs/nfs/nfs42proc.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>>>> index 63802d195556..d3d050171822 100644
>>>>> --- a/fs/nfs/nfs42proc.c
>>>>> +++ b/fs/nfs/nfs42proc.c
>>>>> @@ -70,7 +70,7 @@ static int _nfs42_proc_fallocate(struct
>>>>> rpc_message
>>>>> *msg, struct file *filep,
>>>>>           }
>>>>>              nfs4_bitmask_set(bitmask, server-
>>>>>> cache_consistency_bitmask,
>>>>> inode,
>>>>> -                        NFS_INO_INVALID_BLOCKS);
>>>>> +                       NFS_INO_INVALID_BLOCKS |
>>>>> NFS_INO_INVALID_MODE);
>>>>>              res.falloc_fattr = nfs_alloc_fattr();
>>>>>           if (!res.falloc_fattr)
>>>> Actually... Wait... Why isn't the existing code sufficient?
>>>>
>>>>           status = nfs4_call_sync(server->client, server, msg,
>>>>                                   &args.seq_args, &res.seq_res, 0);
>>>>           if (status == 0) {
>>>>                   if (nfs_should_remove_suid(inode)) {
>>>>                           spin_lock(&inode->i_lock);
>>>>                           nfs_set_cache_invalid(inode,
>>>> NFS_INO_INVALID_MODE);
>>>> spin_unlock(&inode->i_lock);
>>>>                   }
>>>>                   status = nfs_post_op_update_inode_force_wcc(inode,
>>>> res.falloc_fattr);
>>>>           }
>>>>
>>>> We explicitly check for SUID bits, and invalidate the mode if they
>>>> are
>>>> set.
>>> nfs_set_cache_invalid checks for delegation and clears the
>>> NFS_INO_INVALID_MODE.
>>>
>> Oh. That just means we need to add NFS_INO_REVAL_FORCED, so let's
>> rather do that.
>
> ok, I'll create a new patch and test it.

This is the new patch:

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 63802d195556..ea1991e393e2 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -81,7 +81,7 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
  	if (status == 0) {
  		if (nfs_should_remove_suid(inode)) {
  			spin_lock(&inode->i_lock);
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+			nfs_set_cache_invalid(inode, NFS_INO_REVAL_FORCED);
  			spin_unlock(&inode->i_lock);
  		}
  		status = nfs_post_op_update_inode_force_wcc(inode,
-- 
2.9.5

looks like this patch causes more tests to fail:

[root@nfsvmd08 xfstests-dev]# diff -u /root/xfstests-dev/tests/generic/683.out /root/xfstests-dev/results//generic/683.out.bad
--- /root/xfstests-dev/tests/generic/683.out	2023-08-17 23:59:09.621604998 -0600
+++ /root/xfstests-dev/results//generic/683.out.bad	2023-08-24 12:32:49.980272051 -0600
@@ -1,19 +1,19 @@
  QA output created by 683
  Test 1 - qa_user, non-exec file falloc
  6666 -rwSrwSrw- TEST_DIR/683/a
-666 -rw-rw-rw- TEST_DIR/683/a
+6666 -rwSrwSrw- TEST_DIR/683/a
  
  Test 2 - qa_user, group-exec file falloc
  6676 -rwSrwsrw- TEST_DIR/683/a
-676 -rw-rwxrw- TEST_DIR/683/a
+6676 -rwSrwsrw- TEST_DIR/683/a
  
  Test 3 - qa_user, user-exec file falloc
  6766 -rwsrwSrw- TEST_DIR/683/a
-766 -rwxrw-rw- TEST_DIR/683/a
+6766 -rwsrwSrw- TEST_DIR/683/a
  
  Test 4 - qa_user, all-exec file falloc
  6777 -rwsrwsrwx TEST_DIR/683/a
-777 -rwxrwxrwx TEST_DIR/683/a
+6777 -rwsrwsrwx TEST_DIR/683/a
  
  Test 5 - root, non-exec file falloc
  6666 -rwSrwSrw- TEST_DIR/683/a
@@ -33,9 +33,9 @@
  
  Test 9 - qa_user, group-exec file falloc, only sgid
  2676 -rw-rwsrw- TEST_DIR/683/a
-676 -rw-rwxrw- TEST_DIR/683/a
+2676 -rw-rwsrw- TEST_DIR/683/a
  
  Test 10 - qa_user, all-exec file falloc, only sgid
  2777 -rwxrwsrwx TEST_DIR/683/a
-777 -rwxrwxrwx TEST_DIR/683/a
+2777 -rwxrwsrwx TEST_DIR/683/a
  
[root@nfsvmd08 xfstests-dev]#

I'll have to dig deeper to find out why unless you already
knew what the problem is.

-Dai

>
> -Dai
>
>>
