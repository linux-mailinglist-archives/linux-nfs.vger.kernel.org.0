Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FCF787592
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbjHXQjI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 12:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbjHXQim (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 12:38:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AB81700
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 09:38:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OAKa0c027199;
        Thu, 24 Aug 2023 16:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Er6n/xDWndFWLQWuIhgbGrphDSrJ6xkIOC0Kc9Vrsus=;
 b=Rjpy5u6SqAWDiriKM/956eM2lY/yZz/q1rziSUcKQ1m9JYDnl3APq8jYTW6h3bFSK2lk
 Iu27j6Cmn7YOm1DGQM5mCtkMEAtTVxcR7rxSJfUn4/1LTkI7Nf2tYgDW5i8Zs3XdAqeA
 hjBsx4LQ1XVMn/hNALuHDKZnlOA4na/ym7ALrl8Qql4SMz2oJR4nUgQnwAfHx1/MEGB3
 12nBrZ9wrCoNMxVi/FpY9B9B4eKXBIj1jW/RyIF7QGpoa8Io0FjVA79xy0jErHbZuS1p
 YeAbOQxnEhgHBDmMmUvpeF2ORUjgNkBkwqTwrfuPBywvuSQpgxGeqEZjP8jGRGQ383ys 9g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yxmgqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 16:38:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OGQ2ip000948;
        Thu, 24 Aug 2023 16:38:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ytppqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 16:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9duJb76IWKbw01/iTr3hbXklt0D6iscUKmzEITkNU6bqGmapkqR3UVI7p6S/pBQCx1mObNpnwHtrMfKpbp2yTT5rJtfg/mcAS7XU1x9lWVboc5+kGU7v4AUQF3FeGVsBJoKIi9mrVIL6Cepo572gJVuyn8Q8pNH7I1hs9CjmZHtOg4N1DhoHg6Ulh3h+Kq4zK+groiRx3Xf5T3s7xjF6ILvronNDO/qjtgzzjIYoR8J88iWYPFtDjCEczWqNDeUNQBkA+1EhRrM0HaIUbzuBIDS1eko65nDtwrdkFP32t67+E2wUU6kXjTic7+Ro96W5mglHj6GZcpx8aFYZq+HBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er6n/xDWndFWLQWuIhgbGrphDSrJ6xkIOC0Kc9Vrsus=;
 b=MetcI7RbT/dYy9GxxaYdd/87XNDxjrSxwtSvCGJDDuD7+/TpoPUZh7Y87gzT87uNTcQQgQzx1F6pHcmT3F1tJlW/MyGJJYAEA2ASrhfWqNahWW7BdWvKH2Qm4UisuV26LDde5yp0qyQdKOf4AnX8IBXIgIeP+hOFXXWERJhroNKhLgQgUL91eK2zZvp4JBzktob7964l26FCSvmD4WqsYGy+RwTJQ7EZDERLK6DAr8h9pR3wddRAQRhj91N7Kgv+rJ47RYPbrboC6jjV8DSeZTjqDC+XIS+Dlsi5ht4wojEgNG//tKQgFowDYkSP1bsRFzsBmMlrrxUcZClg4qpN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er6n/xDWndFWLQWuIhgbGrphDSrJ6xkIOC0Kc9Vrsus=;
 b=k6SovOcdUHNnig6PvTgFarvS9y/9VjY4phQQpNjfQ2RKI7X1ODSin2BRMkMUzGeELL9OCIexLmEZKO/0e+W7cUa/egVccB8PkAki9heOX/hK5lBTnlwhyq2A6kwYYl+Avp23SZDony8iYFOqd1gvwVWWzQHwjvBkuT446w+5ISU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:38:31 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:38:30 +0000
Message-ID: <24ae5b14-0fe3-15e8-37e8-e8aed0cdefa9@oracle.com>
Date:   Thu, 24 Aug 2023 09:38:25 -0700
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
 <067a68e1-cd7a-55c5-619b-d64266b5ada9@oracle.com>
 <af94f54e27b14e3129691d78ae1f439b33fb7733.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <af94f54e27b14e3129691d78ae1f439b33fb7733.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:5:120::21) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS7PR10MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f03697-d5be-4fee-aa3e-08dba4c08cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Neclpnjc805KK+39xsesD7r3C5mlZk/lPD6fCM6rKzXTfhdn8RrTHcb7OAFf46Lm7Szls/uXy70Ko9yvZ5K1DC98NrooAYLab36OCcvywSAkahaqMH2PKNKFWJMJM+IN6Z7DlVvIUKq0QbNZFERv7965gwxKOGNRSYx73EpiFYd7a8/4eMUbXr38Nb9IPFdghihV22HTg+owvNK/5DOowDnt+yryQdECLxmE7FsxjFsM7IEL3+naGS8oOt/1eRtuwqlLZ3RDtR6ngutEh52P7JEgS/UBjls1sw+QOjagYmbO2euhm1gAaVEcchJXnKrvq7NHv1QwLDTlyJysELmw3dXAY1CEOkcFnzltwXp4WCbOU86ZCag/Q/uatQScLmqXP9dAIzdwAPc5wu8lKSBHpyX43gqAhj04u7d1hI27RJOBSYqGUV7yS5JU5AB/ezKiPXGFgX0gXdOk441rnDPiBGPgj2aSf0sgX4G4gwP5fDZ9FTDeZXEd2CtFd1rKIgAkgfakzRsm7RnfyH9mj7mMW1APRlKZCUTaDuSae4pPnNTfW/EiAWD8nj8qgEv/75tu9A+BuWIxfPdY48T+9Ij42fpP/6z3FJP9QSHL+5OE92BXNmuGaLM/TazaPBG0c7YE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(6506007)(66556008)(66946007)(66476007)(316002)(478600001)(110136005)(26005)(38100700002)(6666004)(41300700001)(86362001)(31696002)(9686003)(6486002)(6512007)(2906002)(53546011)(31686004)(8936002)(8676002)(4326008)(2616005)(5660300002)(83380400001)(15650500001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2FYUHRCNWh6d3h0UkVrSTg0TU9DR1lKeGxsWFBGaWFTSm9JeDgyTEUyU2dY?=
 =?utf-8?B?dklsa3lqMG9qdWl1RWtKTkY2VEI1K1kvdERVNlpmc0E4U2FBMXZEM1paQnBX?=
 =?utf-8?B?ZC91TjhNU2drb0VrTERNaVV2bnNPU25DYUt5Tnl5VmpJeHF1cmZjMFV1VGJ2?=
 =?utf-8?B?cER4TnVPY0dMeTU0T3NQVFJZaTU1QUdjVktSejlSbTBrNXNvRnIydEZnSHRs?=
 =?utf-8?B?VHdRc2dDalBTSTUyaDNzZUNTWEFvSnFuekRBM3RLNHRVT3RsWUNGMktmd0Ri?=
 =?utf-8?B?bjJFbmRvVkMrQTlPV0FpemFpb216UUV3ckZ0MWRaNVVHQkczeC81cGJJdnlv?=
 =?utf-8?B?OW82ekF4Z1RqdmFuSVExN3F0MUZybldwNktMY3Q0S3FKQ2NybFFLcVVaQTg2?=
 =?utf-8?B?OTdJY1o5NnFzbkwwZ2ZIUHk2d0dGNVZUUERHYUY1NUJjK1RMUEI3QkovbWxQ?=
 =?utf-8?B?LzhqVVYrUXY0SGdVa3dzRklCaGV3RDdDcDJtc3h6dmQ2N2lISU10U3hQYzNK?=
 =?utf-8?B?S3ZtNWF0azNEZkNCenJ3NkhxOHVuOEo3b2VjaFBYY21ySnpPMzlzQWNmdi9F?=
 =?utf-8?B?RDZXN2Rod2pWZE52Z1g4WGJyY2lJdDcrVVdhemZ4SG9EY0kzOHV5RXZNei9h?=
 =?utf-8?B?b0Z2OVpXMVM0RmtNT2UrQmtCMGRmWkFZZ0s3dDhpbFg3bm5nMEROM3FGa2RB?=
 =?utf-8?B?ZzE4UzBTWGgrdkJrS3hDem0yM00xUVlqZ2VycTl0L2wwRmhnWXU2YXJ1WUVX?=
 =?utf-8?B?MWxUZmNPWFdUQUp6VDNNNlRyMUorY0JoQzRNcjJlVFVsVmVnN1ZFNGpQdFRS?=
 =?utf-8?B?QlltQ3Z5WWYyVXZtblBYYk9wR205b2ZVV3dKSk91UlIwYlQzN3hlZHpGMWlE?=
 =?utf-8?B?a3B1VkFVdG1mLzcyRzVXZTNhOHZDSnBKRWM0aTkwMkJpSUFIRjFIckFWUzJ5?=
 =?utf-8?B?Z1dWWlBQOVloS3paQ0R1eFV0ajVtcmhEb1ZGVUh6dWFFSUh6RXlvZU4rZzlY?=
 =?utf-8?B?UlEzdWJBVXQ4OWQ0QnlaVFpsYVdHN1VuTW1jQi9sY0hCWlFzQ0hNbjBtV3F6?=
 =?utf-8?B?WVBjSVhSZDNFUW5vTEJFaDBkOFp6YktMT1B0SWFjYWkxTm9KU0dHaUZkOVNh?=
 =?utf-8?B?aGp3TUN4TU1uRkRuWFZyb3RLc2lJSGJKV2lSZUpDQVlBV3pmSlJreGxqY0lt?=
 =?utf-8?B?aGtLdUQzdmVuN1lmdVIvZ0EvWjUxbDBQYStpQWV0Nm1JZVBwL01uUkFaZWJJ?=
 =?utf-8?B?K3RSWno5WDNNdXJLcnprU0hDbmYvMjZteHE1TTBxYUZ2WEZ3eXlNeXozZ2pU?=
 =?utf-8?B?SGdsWU83OGdNSDl2U2ZJSVZtcm12emNUVnNIUHdDaHNHbVFTRGl5UUtueWxG?=
 =?utf-8?B?MXhabDRqY1gyMzlMVC9pQmluZkZGQjNGVHhmMzZ6cDFaa1p0ME9ZU2JQVzh6?=
 =?utf-8?B?ZUErb1JjdXhLK0p1UkN4YUQ3SkRPOUJDNTVva2l4Wm9PazE5OE1CdmgvTzgv?=
 =?utf-8?B?SEZYSlh1enJYSlJGVklZRjByV3VvNDBhbXBIRkFSNXNXbFE4UEVzL2FhbXRF?=
 =?utf-8?B?Y1E2ei9mNmZTRXRzQURDeXNndURFNG1OUlpudHYxemhjbWVWR1NBcEl3TTAw?=
 =?utf-8?B?amdhckwxL2Zuei84OVFjQVh1U1dybWl1MjYyakFFRmlVRUtCNVB6cG9JR1kv?=
 =?utf-8?B?STVBejNTcmlaS2xxTTZoeUcweUVpb083QUdsbzRNTHJsdThUVFg0OVJDaFRr?=
 =?utf-8?B?bXp3TkR1dHB5UEFsWFNGczhybTdXeWNDQVNiSEhjZ2t0VXMxTmhVdFFSZys1?=
 =?utf-8?B?TFNuVVZFVUxZRjRZWmNydkVkbW9FQ3c0UmVsSzlQc0hLQUczL0tyRHZqRlRx?=
 =?utf-8?B?dVU0dU9QWkdUWHVWL2t3VzhURDhHN2lSaHpkZzJKaXB4MWV2bmF0V0lVTFl2?=
 =?utf-8?B?MmVDVE5rU1BlQUJuWGtMT2ZBc0VvRmFjK0hCU2N0dXNZRTN1cXVtZGo5YlhQ?=
 =?utf-8?B?b2djVWxFRmdqME02cnFSSHpVZksxaEhtTzM5a292TnU1cUthSDlaZTlNbVJL?=
 =?utf-8?B?WmgzRDhBdkQ3OGlPM1liK1kvTzZteWg0RUFUVVFSSDd0K3JrdVUvS0FjVzZ3?=
 =?utf-8?Q?cw35dVTbwb6pXGWQh2+XBluib?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c7TGgnjPFwDijD/KX2SkuJ1xT1bZM0PUMsU3wAEdVtSrRUOJNHN9qSTqeVwxX+34/TyuVmzhr3L5UJY2XP6/M3dwOVmufI+HgK7EK2BukQstZRrZHMm1A9SVYozwVChSFOsvP7Y+BTHVatZQL4VYS8/pmrATZcKq1g7Zc1DCWnStMCb79S39K6HnF6U1X9yfGc7wAb1Vj1m2r9T7APbo0exFK+HiLx8/d5gZ8oS0WfyciLMN98AJFtmrQD1Y47+Gi57Jquu4LFd4/CUdi5POsTfqaJmwKX8eGBE7ewADV826xl5fO9w+700Qp+w9o3Zaq71zKN5rVqF1RKb2X8x58/kQj87nNWv7nZ+5/wxyhiQYDSa91pN557DJeMCzjjb6WxfP7CbzFfH+do8lYSyVa12EUe9rr6JJVdnYioP8FTXc+e8ATyBYdieLs1l3XqcFNeX/7Mye+oEPvC/CD5FduXk3pLEoI0O/QEStVehXus6wo3ade+eNt64sUnI5BPVjhA8scolz6qcCwbwEe5E/GdUbfAQJJna0SIwB7+hXAkSKaASgex6vzJ3cIRvfkmEXdxbkrf9KjR58Bya0/KglQMBvKKKnSAc29G9iYNq//nOYGcGvGPyNfgiUZzBfsHgie/nLCjMugKhSZuxuyBmEAJkZiDWIAmDialF8dkrwc+K8TI85hbWxfYEwj+gi4bwFRu6JOL0jYAPhHPaoqZzH3skgLEf1rhIR6sUiCuECwYdgSeO6xh9GtvaoivLq8aWYa+k3KNf/SHmaq0y53shBwa8CUZwjH6t3BPgTqGHdzhoyGb4usvuKrqx1rCFUQlk9QT/A8dObSX2mtqT8nejvSA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f03697-d5be-4fee-aa3e-08dba4c08cbd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:38:30.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4o5OypNnZeJJPgVvOkj0gKr1ziCVrtkjOALtVyre5Nqhc/1hENGmP7Wvhfb6CdB18e6HY5oYZfm9flDM+QJbGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240141
X-Proofpoint-GUID: Sk8uZRgyYOUnOpwS-ZX290TnlmmHVFuy
X-Proofpoint-ORIG-GUID: Sk8uZRgyYOUnOpwS-ZX290TnlmmHVFuy
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/24/23 9:34 AM, Trond Myklebust wrote:
> On Thu, 2023-08-24 at 09:12 -0700, dai.ngo@oracle.com wrote:
>> On 8/24/23 9:01 AM, Trond Myklebust wrote:
>>> On Thu, 2023-08-24 at 08:53 -0700, Dai Ngo wrote:
>>>> The Linux NFS server strips the SUID and SGID from the file mode
>>>> on ALLOCATE op. The GETATTR op in the ALLOCATE compound needs to
>>>> request the file mode from the server to update its file mode in
>>>> case the SUID/SGUI bit were stripped.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfs/nfs42proc.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>>> index 63802d195556..d3d050171822 100644
>>>> --- a/fs/nfs/nfs42proc.c
>>>> +++ b/fs/nfs/nfs42proc.c
>>>> @@ -70,7 +70,7 @@ static int _nfs42_proc_fallocate(struct
>>>> rpc_message
>>>> *msg, struct file *filep,
>>>>           }
>>>>    
>>>>           nfs4_bitmask_set(bitmask, server-
>>>>> cache_consistency_bitmask,
>>>> inode,
>>>> -                        NFS_INO_INVALID_BLOCKS);
>>>> +                       NFS_INO_INVALID_BLOCKS |
>>>> NFS_INO_INVALID_MODE);
>>>>    
>>>>           res.falloc_fattr = nfs_alloc_fattr();
>>>>           if (!res.falloc_fattr)
>>> Actually... Wait... Why isn't the existing code sufficient?
>>>
>>>           status = nfs4_call_sync(server->client, server, msg,
>>>                                   &args.seq_args, &res.seq_res, 0);
>>>           if (status == 0) {
>>>                   if (nfs_should_remove_suid(inode)) {
>>>                           spin_lock(&inode->i_lock);
>>>                           nfs_set_cache_invalid(inode,
>>> NFS_INO_INVALID_MODE);
>>>                           spin_unlock(&inode->i_lock);
>>>                   }
>>>                   status = nfs_post_op_update_inode_force_wcc(inode,
>>>                                                              
>>> res.falloc_fattr);
>>>           }
>>>
>>> We explicitly check for SUID bits, and invalidate the mode if they
>>> are
>>> set.
>> nfs_set_cache_invalid checks for delegation and clears the
>> NFS_INO_INVALID_MODE.
>>
> Oh. That just means we need to add NFS_INO_REVAL_FORCED, so let's
> rather do that.

ok, I'll create a new patch and test it.

-Dai

>
