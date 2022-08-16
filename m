Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B982E5957F7
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 12:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiHPKUx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiHPKUS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 06:20:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61319C1C1;
        Tue, 16 Aug 2022 01:29:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G8GD82012230;
        Tue, 16 Aug 2022 08:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=EPgMyVO9J27P5gbkHwRbAYKEhZYZ0ID57nsY7JAZeqQ=;
 b=BHJxjDpx/ybP0+3THftvNRSw44NNcACIQfAjhxfE1Ulf29kW7mRAjPZmSyAl6gdoiDOu
 WQnMc642Fh8sFtoxeQjEzZX+/n5I2Vt+eI3wrWawKHgUxeApXiqHHC0P1hTsj+B5p6ox
 L526FJRiHp7N/Ff5wNm4GBkxp1D3kMZOokXAu3041rlEQRz8rNqMfo2sGAk23JU1ZfrW
 z1B+VHG67x7EJWoFjkp1L0l125SrcHTWoWW3USM0mwSmQfRyH2tLPJm/x27KiAZg60K6
 l7y2fiVTxEAqqUxEsEJQ74qlpb8qW9prSRjAnd0CrFidzmWjCIiWccMUrZWbq8g/m0Tt ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx4gt52v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 08:28:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27G5cxVJ023186;
        Tue, 16 Aug 2022 08:28:36 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d27np2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 08:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft3aGGMiwdS2K0R73OC9GGweXAg9vjIVUwJ3LmRBojYQbJAuAlW9z4gM8bDKSgLNHg3btc6KKssurcN43DjeKkGXcRol/ciidAgwkJVUXtNzlmocGa2v5xspce+9Z8S+MUWmbIyIEWHF5Z1dqSB8vLHvforkRJTOmnP0o/LDznZxK6AYKcdxS9191E+WXcWJ8NAEwYACQyLK38n7CRqc1gAVnTf+22IGppaJuCuYF3mKRV8HRI+o4StrIkPi7lC96N3o98h62VTecauzo+UsCaFE5oBnpvShS3obMQYZVuoVSzX1UsSRCAF0pYCLN3gu7CZ25Of/FticYPxlqcflfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPgMyVO9J27P5gbkHwRbAYKEhZYZ0ID57nsY7JAZeqQ=;
 b=elaXHKDbSJis6F3jl0HoRiScRe8I2wcziEHozJp3uTNIoGr+pkAY0vZAu8cSziKEoYjzIrOnIxPS0tPiaOmV9IgcYN4b5W3Ra19sgKLUjoi0u5moOI3yHY44ddAO/ZvwGFmIT7O+SgZXRhhxyJ5ev0sor3vQdNO3QoIS0+VjV0iJioToqlUSPYH3mdgr5sATxoIAgUroCw3tKVbc8StTJjfjduj753d+WvE3l5B6RRBgBhyYb2ovWFSnwsm10CVOoeq1HBLlxPfHhSDCJ4mn2CCwtO19aN33JwTIYqL0EbrVlcpOf4K350pAE8V/JtP/7Qgh9EzmM5/dOwYDRWgrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPgMyVO9J27P5gbkHwRbAYKEhZYZ0ID57nsY7JAZeqQ=;
 b=kTdzf8gjcttJac8QY8/6m1Jiflg7K/rvI2uYoPXul0dZkbcIGX36iXuwdTV6SxVdv3wIEebJojLUzQMtqv8L47fd4Xtq9wNYqz/F4XCUU+59Mat+SPPFXLe17a6TWaJZQ0HaCftREy5P15TNQxzeT29i4YIs223S0l8pUFQ0nCY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3047.namprd10.prod.outlook.com
 (2603:10b6:a03:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 08:28:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 08:28:34 +0000
Date:   Tue, 16 Aug 2022 11:28:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        neilb@suse.de
Subject: Re: [PATCH] NFS: Fix missing unlock in nfs_unlink()
Message-ID: <20220816082813.GR3438@kadam>
References: <20220812011440.3602849-1-sunke32@huawei.com>
 <5e947976-0808-1d32-e170-d85ef73972e7@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e947976-0808-1d32-e170-d85ef73972e7@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e90ba8-9772-415c-5b2e-08da7f614eeb
X-MS-TrafficTypeDiagnostic: BYAPR10MB3047:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9Sm3iYjJgTIdEt2iN3m1Uqc1Xh65vpTAFOykaLUhm1hEnWncdedVltrvuzNLOWbek5RCR4vUKX5MLSUuRfLI1AWGBp+w0IQgqPGjqyWBL9rtJuHEPtkg20g3h2DlXoQeWuS7PokmFWZDUvyXhRd1bg5127eEcjnRm3nBhXrmyxe98vXZH8JnsbmCJebzICHxSH7pKugKJH7Sa6sm7cNMXmYhqvc/yNlxBCDFpykTx7aPYUqsVqo6RF5fOVcriYTUpHlZKBUyEKMCNwSBsPXwIXtV3hjLcvkBd7T/bnbMiPV3MfEwMcytcw2GCbpBnekDgaXcEktOhodUi8BNbplzPTw3BxR58JPvebmTTbOQicUL2gkqra5CmGbA2x2WfhoeV6cnbFqSDI0TqqBBkZfHKEsTKhuMQtpLSvnNA35rZyXaiIuiKXACPRQ8mXgt8tp2nbv0Bp/aqsFr/tJrPnY/RUOmusiSLuaswxWF7CcXCeg14+SGviUgM7oGq/YNuZnoSSM0mVCT9mRUnXlhUqDUtWL4yMKDNh5jTseF80ag0mRRGhCB45gF5xGBzJw8OduG6LPUd8/qqDXV5kcxBIKgujsoAWbW8rjlmFaB1SEqOj65Iva5xiQ/qAe0jtVwldlX3ezHOFB2HLcPOAqNRJuQnzLX0tWsmJNhbygeyyBc0VfpfA2pmrdS8JZuY9ZNGdqoB6TPtC21dUAmsboKowoevywxgn4z7D8VD6ULqNE+FLCnNN7awmDzmgyCOWb9pAEg9BDPgeiYQIe8i0ZoWJO+XGygA1vLp2TlbmMER/1RBNFqtiGcVewsEdD66Vp2bRm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(136003)(376002)(366004)(346002)(39860400002)(66946007)(6916009)(8676002)(8936002)(9686003)(52116002)(66556008)(4326008)(4744005)(26005)(66476007)(33656002)(2906002)(44832011)(5660300002)(41300700001)(6506007)(6666004)(6512007)(86362001)(1076003)(478600001)(83380400001)(6486002)(38100700002)(38350700002)(186003)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjRhL2hQdUhhbFVPaUFMSkdqSkhHTHNuM29wc04yZHVsVlFaK2M5bjNFTjhy?=
 =?utf-8?B?ZFk4aS81b0hjNlZ6NFF1cjYxNTlLNk1lNGJwZEI5V1AwNkFVQTREZkFGc2Vj?=
 =?utf-8?B?U3hSNVJRd29pdGRjZ2tkV2NHNS9kMUp4dU53cWJybTkzUTFqc0ZsRzFpQ0dm?=
 =?utf-8?B?Ukx2QjhFNVR0THR1dEwwc3BLaXVRKzFzTEFjekRMekd0UjBBL0dONnhIOUI1?=
 =?utf-8?B?MFNGUldCSGYzZTRFeDYvU1I1R3RvOHd2TDF2Q2c4NDIrSndIZ0x4ck9LT0t2?=
 =?utf-8?B?YmFUVnFhc1M4RUlyYTRDQXkxbkRhaFdnYnVOVEI2S2lsL2EzN0VwbmdEaXFP?=
 =?utf-8?B?M3E0MzlRekQyVDNwMlZHR3NtMU9HaXhId0psMDFKUno0aFEyTnY0cWJHdkIy?=
 =?utf-8?B?dys2ZTZpOW9UeFhwQ1kwa1djY0pMZUhyWkJyWmJkOGlseFFnLzQ5Wm9hMWti?=
 =?utf-8?B?am92Q2V1UWlERjloa2tBc1Uza1RxMFhNUUUzNk1sc0JYdFY2TEFkbVlTWkpZ?=
 =?utf-8?B?eTE3djBLSHB0SWJtSW1LRi9lakxNamRRMzQ2K2Rpak05RFVldDB5cElzOHRm?=
 =?utf-8?B?RjBKZDkyWThuNWVZbXI3WnNFU2tseUwyMkJWaVIxdXZHTmZDc0tFbVc2TUhZ?=
 =?utf-8?B?bWVQbmU5cjFlaGFpSWdyV3BZQ0FpdlIwU25URkpDcXZlMFBTaWU1RjQ5SGoz?=
 =?utf-8?B?VUliQVZHN0lQMVJ1T253Ymo3bURMTTNHOGpQRUlaa0F0QmpkK1p3QUNLRCt2?=
 =?utf-8?B?OFJlQTVIRDBXU21rdXdkWi9EK2M1bUJ4ekNDS25OVnAwTHprc29yS2ZBRWRt?=
 =?utf-8?B?a01KYXdDbDZnR0JtdGR2akppaGZQSS9JbjNkRVJoTS96OXk2UGtRQkpqTnph?=
 =?utf-8?B?d083V0FYYXlxNG5rRGRabmV3T3AraVdsR1I2UGNZZ2NUem44bldmOTFFaUZl?=
 =?utf-8?B?MGhKOTVNNjVzV3lrbjhVV2tuNWd3V1NUc0RHZ09wTDBiY0lnd2E0SW0yaWxZ?=
 =?utf-8?B?ZDVyRjJUS0thNmxsNlVkWDQvZk9kRGtKRjR2TWtPTkJyZUJrWEd0Y3lpTUlH?=
 =?utf-8?B?VEVCejhPc0YxcUFkM3dEUTh3aDZuejBLMkNsRnVQZ1FzUVB5V2xrcUxXaFFr?=
 =?utf-8?B?QUdNa0JxbnduMldzN3hRYjF0a2Ruek9MQzNwNEtPbWEwZ25Qd3dneXdUb29p?=
 =?utf-8?B?QzlkdFlHOXJSRVpCakdCeGNxM3ZtcG9VWDZuV1ZpZzNNd3hZekt5aHlVK2Nl?=
 =?utf-8?B?WnBGZThLajhqTXJMVDc2V1RVY2tsUmE2dmhOTFByaDA5dlFPU2syL3lHSmlH?=
 =?utf-8?B?YS9TTUpxZWtoSngrLzZUaXVyeE9KY0tkRi9sZDF3ejIrTHpsVlB3Vk9ud3pU?=
 =?utf-8?B?SXV3WWFLTWxxU3lwa0hXeVZCYnRCN2dBVUd4UFlwUjhlSFc4VzVhR082NXBi?=
 =?utf-8?B?N3U3ek83NWQ4azE2UmhqNW0vK3hpT2kzdmo4d0tuV3JDTk1RSk9nMjVTYkZP?=
 =?utf-8?B?MjlpM2duMzJkUXVBZDJiTlBIdnNGVXFzNlhPOFFKd25sdWJtZmcybnRJSWJh?=
 =?utf-8?B?SjNXV0lZMHhDTVFEcnVwTzFpakZSQjVFY0dxcXo1Nit5L0FjK0lTSE4ySHd2?=
 =?utf-8?B?cDFid1g5TFhBMHovZUR2SmFCWXVUaFlKQ2NBcXFkcHlSNTQ1ZnlMc01VREZ3?=
 =?utf-8?B?NFZjdjZUdzBCNEVRNnlxSW5vREZTMXR2WThVRUdKZkNNVUs0eSthczg1UGZV?=
 =?utf-8?B?SXgzYmZmVW5YaXRWaUlkV1VFWUh5S3RnZDNuVXBFc20zN3c1Z2NOYmpiV2FI?=
 =?utf-8?B?VUtRUnFuanhlYk54SGs3OFhVaWowYk1qdUx0alBjUFQzYzVkeExKeXN2M08x?=
 =?utf-8?B?b0VjeEl0WUlDMFdrL1dZMTd5ZkhxWG1kU3MrUXIzbjNQMVQ5Wkh6bkJ6blRy?=
 =?utf-8?B?elM1OE9FMGJpSXU5WjVvTlgza09DbXliWW9iRDVieTQ1d0UrSDRyWXNmMWNX?=
 =?utf-8?B?SWlCdHlSbGdlYjB1QWlzNWZYeGRlbHdiMk5GZU9zdWQySkdFTzZJWVNIaHFz?=
 =?utf-8?B?Q0NVaExOZDUxT01WK0dpT3VlOTQ5aDhJRDZjZFVYSURLS2tnRHJZVjdDdFVK?=
 =?utf-8?B?WE9jQVMyanRZbUY0NHllYlZJU01UR1ZpSkptR3Y5QmIxUElCc0dPaTZ3VVZT?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y1pGa2R6eEpHcTJCNWtnS3ByRmlZVTB6Q01TUGVzVWN0RExGbWV0bnB4V2tW?=
 =?utf-8?B?OXFkZG5VcERDM0pPSjVCNkpkUWhCRFFtMGNaWXNFa2o2dDN1SDAxZGxCcmw2?=
 =?utf-8?B?SWtsVUpHQWZPT3M0VTZQbHk5TWZiMk9INnBReVAvZVhGRmJPNFY4aWZmd1JU?=
 =?utf-8?B?TXNvaDZneldYS0xsbWpJYTk5Qjg3K3lHS0JyaG5Xa1R2L0VrRGt0MGUrQ2E1?=
 =?utf-8?B?aEhLYmJNekxBcXpkd1JYdUxpODdzTWV5RkZtbFNEcWkxTEZ6VHlqMVRSanFB?=
 =?utf-8?B?VXFGem9YRVlPejgvOXUzOWFycHdzQmRuUDhyT2lYdHpnbWZhNzA5T3kwZThF?=
 =?utf-8?B?SW96eWJqdms0Z09XU0RLQkVad2lQTTB0U2doR29zaC9iSVVSczRHQ3VieWZr?=
 =?utf-8?B?ZDBkRElyejNkTmMvLzZNNWtJb2FUUWVkQkE3MDc3cDFXT0VTb0cvc0JBQ0tT?=
 =?utf-8?B?OVRValdHOUFUY0FWZUZwSWF3ODB0d2cveTlYTitrY1VhYnF0bWFSOFN0cDN5?=
 =?utf-8?B?eGxTUWc2TVVoQVdMK1FMZlJWaytNWUR2clk2V2tpb0lyanMwNEJ3cjNOaVVN?=
 =?utf-8?B?YUNsZUxSYWFuWjc5YTFBZGt6VXR1dWEyTVdLaGxqbDM2K2x0dUZzK2JnRUhu?=
 =?utf-8?B?cXJ2ZnZWR2NWcFpEbHBNRnJjVWs4eDZmMnY4QnAxeFNHMjloQXQ3d1pPWXI1?=
 =?utf-8?B?SFlSdnR5akRURnY4RTJEK0lLV0lIWi9WWjR0UEJvNVR3SXFtb3F5Z3k3dTVu?=
 =?utf-8?B?NjJrdzJPeEtJUlFqNDd5K2xQL2RjUDJnQXVRVEQ0alk5STdRTE96VEZqRGdW?=
 =?utf-8?B?TTNNMUdJN0RGWUFTZUkzNEw1ZGFqOFQyZm9qUGxGRFhJaWtPaEJiUGVnZ2t4?=
 =?utf-8?B?V2NMdkhuTlpxZm5mYUR6ZTY1cE9RTWNsR3dzK0RkZWdrczRVMWV3SDlScTQz?=
 =?utf-8?B?am94dDYweWtPaFIydTc3d1p6ekZxOUlValFZQmhReWxlTkRXQitldkRtTExY?=
 =?utf-8?B?TmJzVW44d09waHVkajRrVjJEbm5hOTJQekw0b2NEcXA1N2d6UG1KSVhoYjRm?=
 =?utf-8?B?ZXJmT3plclJ1bDEzMk9XWmRLaEdrcEp2MkF6UmlLbEVhL0ZPU0QrMG5Gb2Fu?=
 =?utf-8?B?OEw4b0pqeUdJeXNMYzBmYklRdFM0YVNDREZNay9ucUxZVmhtZHltOExoaUxn?=
 =?utf-8?B?N210djZPUURNRDNRYWhLRGJIamNmS2RvdVJkU0lXK2lkZjI0aWQvMTNaL1NW?=
 =?utf-8?B?S0RWUE1XallXZzM2dEJweEI1cUFyRnNuaXN5Q2tnUmE1b1R5aHA1RS85VWRX?=
 =?utf-8?B?MzNaVGYrUUdvamR1S2wvVU5DQ1oxQUE0aHBoOTd2L01HMncveXI3WGl4RlZs?=
 =?utf-8?B?RlBWTVRUMHRZbnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e90ba8-9772-415c-5b2e-08da7f614eeb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 08:28:34.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1IpBuD/N4kS9Rta49hN6WpNHiTITOTLbCeLF8LrrHUa4J/tLqqfsAy7x9AEulNV1FrwetEjgs4ycKbANZGL1Sj4M2mNFm2U8tW/T9lhKyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_06,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=845
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160033
X-Proofpoint-GUID: 2ND3NSxAQjbkn3sGy6c7jilaQ0A9_uXl
X-Proofpoint-ORIG-GUID: 2ND3NSxAQjbkn3sGy6c7jilaQ0A9_uXl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 16, 2022 at 09:06:06AM +0800, Sun Ke wrote:
> friendly ping...
> 
> 在 2022/8/12 9:14, Sun Ke 写道:
> > Add the missing unlock before goto.


The patch is correct, but please wait at least two weeks before sending
reminders.  Longer than two weeks if the merge window is open.

regards,
dan carpenter

