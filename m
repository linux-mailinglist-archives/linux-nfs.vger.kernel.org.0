Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D761661EB3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 07:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjAIGew (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 01:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjAIGev (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 01:34:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F931181B;
        Sun,  8 Jan 2023 22:34:50 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3096JeE3003935;
        Mon, 9 Jan 2023 06:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=npIvenpSo5yrZkQQVxm2CmexaneUviTNKsCqAprBaFM=;
 b=wi6mqNDhQrepd/uz9P8DglwIry7bFF/TZdSNkl7I9pfR4JSKTTJm+1U0Zk+aS+ejCaIm
 kSySx/9Oz+wqH9m6raJfpHh6oKvNzUvVSgzjE6P7Su1x6WpA1Ilhe/guEplbVFL0RoJa
 b3GzoTqe3du2hjbFPCNIqfGpNUzQClELnbVdLZPogT0woxaC5ogsQNYZLUbXKV+2eCWf
 9eSopMotNAhricbcoxgJT/mA8+UKxSRoiP4Q+9s9miqWNwvxg8nunbvOt43CnOWRQg5K
 xlYk6h4Mi+6rGN7+9qUpD3Jsb7iPBWWxHgGp45MOGE8Pkds0gzsXGVPowy+Q22H+Gqkw +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0sc9xpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 06:34:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309525kh037965;
        Mon, 9 Jan 2023 06:34:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy69u5wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 06:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPYg9XtT9LZycZyZ2rbDgqKTdsBbvmqF1viC/7fbvWTyXop7IMODD2v8I1TOXuYsWT4pe6tSk+JMV9/Gr5l3KIO5Z0hSRJ6ssqvd+S8V547K5xXZ705VrB3y/GCX/IOMj8zvDE5yyWc4Je2jUSZred4LqLXOno/g6R+CKRE2XtVt6b9v/Ola7FerZHKtuwSyH3zfTlUeNdIuY3uDbfbW5Wr9MLGRgM4x1PVcWG9FzZGu6JyxozW+K0ox1tsPFvz02LrFmhlN2U8Ov9PsDrGiODtc5CEaEYmoL8QcR1ecSZHm5F7tuwMs92UvcT8mDq1G29CyCa7I/ekWjczH2FGFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npIvenpSo5yrZkQQVxm2CmexaneUviTNKsCqAprBaFM=;
 b=jZsRv8ToSTcAsHK6vm3jZGZNGoMz3PunecAjohw4A391b00I7zvZPRg/qS9SXjVwNLj+gu42NkrNmH+XHT6psKTZanfSBDvdrEvm5iLEYx1+MUrpnbvk3y1qU64ckArT0wESR9RwGqmEGYVzCB107cqrDJWBbQs7CzDcVze8xy54x3HUhVJL1d9GRoS2jZjpCJDnvly3Tr8CQGbf0ml7ugStjfrYiT9iSRVQvc1kyHvkNStfjkl258cOmoaXU6c4726qBzOCMcw5jcO0gfunchp/0z9nUfwIY8L02enRTyT4IA5uoXcrkbV7aMjx4mRJgP2+YibONHQFSsr0IvMpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npIvenpSo5yrZkQQVxm2CmexaneUviTNKsCqAprBaFM=;
 b=zClhA1eUmDdWpP9vdEn+6yEk3hvqCRpk1Dml7P6shsAcdjfGAIzBNvFpTjHDpv8NzzO2dI2jkbq5AL/1Gou0QgL+waeUF82aEzoh4cWwzogP91uE7USLvWFCxtUGXl4dZVCIwkaH9Y3t/CenHPhFrErOcsUQ86EC5qbpXZlh5nU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 06:34:44 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 06:34:44 +0000
Message-ID: <cd171f89-e1c1-d8d5-4bf5-ce22036baef4@oracle.com>
Date:   Sun, 8 Jan 2023 22:34:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: regression: nfs mount (even idle) eventually hangs server
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
 <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
 <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
 <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
 <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
 <36902a3dd6ee1a8656548ff5b5eadb88245e2799.camel@gmx.de>
 <e51b8b218f18abe00ec76eb911d5b5b5af02f79b.camel@gmx.de>
 <AF3DFAF9-CF19-40AE-8B8F-31D100E00F33@oracle.com>
 <a0abf7fef412dc0de0e42cbcd75ee5dec28cb544.camel@gmx.de>
 <cb5508d260288126212453486d6d45e84436b530.camel@gmx.de>
 <ae11915e-9253-4049-e9a6-31432679d27c@oracle.com>
 <b748cbd9db3a5ac06fe48235ed2a1d110261cafa.camel@gmx.de>
 <33eb3085-552b-6a9a-66d4-4b2397b310c8@oracle.com>
 <5a18fd0de4b1d0498905e786b31f9610be76cc13.camel@gmx.de>
From:   dai.ngo@oracle.com
In-Reply-To: <5a18fd0de4b1d0498905e786b31f9610be76cc13.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:806:6f::21) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BN0PR10MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee46db1-07e6-4b8c-b744-08daf20b982f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcgALMWM1p3900tjolrGg8vqIpT4GudsmlN0cV5MgXQ4cfPjFajlBU3ke3dEgCvgXEdWgg3mCRCR3FarO1WAarO5ST632sKBKxDSTOy269LAZazPlKyjGOSfLiooZ9O62+f9JmDIjG38K1w2U2qA/p6kzwtqSLYe7wwo/2+7Ss2eCFME+75Z5ego1jMxV5C/0usX8dtHu39dt/Y8zpOmUFLFYkIEpw9/STZHCbDiOdm9QlWTaABJOvoJeXIg8S05a5ZDG12PEP+JE8KSn6OQVu37VOJHaGiLKZJzAdXqP2+dp7flZVLX7RSe9fTAPaW8PRt9zPC0Acc+2nvSiYzk5NQdbEuaDDY5YhRBVuFvIcVWj9BMizK8iS2EYmV1qH/A1suOwgjvFx3NpTPEGOpmUeyCTdE32OrPkppHmRorll4q2VUf24JWH3rUGTY41d5ib/WbWxsLxJJr3FYialOx1qri7nHSKTJLIK92C25U5BBuM1emjWROxlaquYy4wDh9nnaK/gNuz2ar312QTIFH5fc6nwrBwZife+ku/TVoSALxZNV06Gfd+Tfz7qnRqWH7xMUVtsQ0ErHQW0Yi3d/TO+SYdIKH2vUX1+zT2CMIa0aElM3BbSxrTCA023k1x2XF2VMZrjo3pd5c1gRcAOipEpvMCiArXCxGHZDn//KGIWfq2cGuAoB0bTk1jd5IR5wH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(36756003)(31686004)(31696002)(86362001)(2906002)(9686003)(6512007)(26005)(38100700002)(4744005)(5660300002)(83380400001)(8936002)(41300700001)(8676002)(66556008)(66946007)(66476007)(4326008)(53546011)(6506007)(186003)(2616005)(54906003)(110136005)(6666004)(478600001)(6486002)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5NVFQ0cmZxcEI3K2x4TytUN3BTS29tTys1NWY2SEc3YS9WNXVOU3JqNkQv?=
 =?utf-8?B?cHJLWXV2ZnIvZXdGSno0S3B5Q051NHpkVDY5TzlSOERjMWNGNmk3WlB5MWdN?=
 =?utf-8?B?UFNXRjRHMmJqcXRaNE5MRU03V3Y5OVgzNlVKUGFhaGhpeFJXRCtub3F4Z1V5?=
 =?utf-8?B?WC9OaEtmMjRnWjBFaU9lRlFvbXhZdlFXZ2Z4Si9qV1RjNWh2YzFLdFlCcWFH?=
 =?utf-8?B?S1VtTTlMQjZiTUJXdjZpb2Z4Ymc5cmlpQ3Z4b2lEM3NQMkxaQWk5c3JxaTdo?=
 =?utf-8?B?aTJrcWErV1c4Z1NrTnYyb3pUeVY3MmFqV2tBRDAwQllWbTRyQXE3OUpUaDZI?=
 =?utf-8?B?U25RQjFVNkZZU0pONEdSdXFQT25VVHhzZHVUY1VwUXBuTHhhL1AvV3Q1VFJj?=
 =?utf-8?B?Y0EzOHBEVmowdzRXMFlNU1dNU0d6d3UvWkVjTDZqQ2d3OHJicTNURWR1UU5o?=
 =?utf-8?B?OVUwRTM1YUpkRnB0MFJ3dCtXMnhUZHBzOVJYQVErV0xscW9vTmx0OEsreXpH?=
 =?utf-8?B?S3VYN2ZqeW91dWttcDQ0QU1WV1kzeDJuckJkYW5mNVRFYTFicHpPV1RIOHZB?=
 =?utf-8?B?MHhvdEtZZE5seVlqOUpiNjMvL0J6QnZCNUErSmlqRkpGWndiZEZCNUoyYTh3?=
 =?utf-8?B?UGFPb2NZR0JFaFh2b05WUUY2cm1tQ2NwSmJzbDF4ZUNrbnRsZlhORTlmbm4z?=
 =?utf-8?B?a21kSkdTSENuaSs1SllDa0JMbHJLS00wVGFOOStzT2FrcmpSREZjSHc3TXVX?=
 =?utf-8?B?YStGMVlOL3hkSjJENFNjbTNoby9xbFBmYU1rZTR1QkJSOFRuTk1aQ0s3TU16?=
 =?utf-8?B?dXZFKzE3TWE1NEIrNmprTjNBVllVTDFSSlVPLzBwZll3WjZ2Ylc3YktwRmF0?=
 =?utf-8?B?blRDdVNiVUZTNWJYQ2xxSURVMlJkRFVpZFpDTG5hM0dtU3llYWlKU09Kek5N?=
 =?utf-8?B?YWhmY2NFN0psOVBjc05iMmNwd0VnMjA5Ym91UnNtbFExN1dYLzR4aFhaUlFh?=
 =?utf-8?B?ZmNrSTdpQkZ6OXlzQkh0ZURFcmZISVdNcU1mKzZNd2tYQURSRUQ4TnIxelhK?=
 =?utf-8?B?cmlDcUJ5NlF2TGdXT2pyNUY1L0RtclJDSWJkUnZ0bHB6K3NaM1FlekkvZVZP?=
 =?utf-8?B?YVBXSkQ5dThtOTVZbGVmREc5T2ZlRDJpNnI1ZnpxbmtOTS9HUFNwMXRsZHFY?=
 =?utf-8?B?cGlNVnhSSldTK2YybSthK21CUEhnd0xnNDNOL3FmUHprYW9pMXlLcEk3NjVL?=
 =?utf-8?B?ZTdRQ1Z1dWc3dlAyZVVwQkMxOE96Q1J1SVZ3SlRFSTZ5MlArcTdVTlZYWVZv?=
 =?utf-8?B?WGN6aGZIenJIVSt4S2h5VnZkRmJPalpnbjRCbVByUTJiNHcvQjNQUzNGY1k5?=
 =?utf-8?B?TmE5K0M3L0NTMEJSUGVyY2FSTWJYTlNLTmJNLzNMTy9BSllxc3o3M2orYitP?=
 =?utf-8?B?OUZsc1M5d091M2V5Skl3K1FMaVdtUDRYb1VsQVFjVDRYeXBHMGQyNFp6YVQ3?=
 =?utf-8?B?alRJRnJYcUdRenZYcGZVL3RPckVXUURLNjZYL3UxL1ljbkFMOVBIeklIV3Yr?=
 =?utf-8?B?alcwRzF2T3puZzhVSFVzaHJjalRWeDMyT1pOSWFBM0NDT1JQaXpRNFNWL3ZO?=
 =?utf-8?B?MEhXUjJFZnVhTXQzbFRIenFGWWt5dnF1NFQ2MllvYTQ0QmJEbVo1NEZzcERP?=
 =?utf-8?B?RHd3clQwaTJhNk5VMXphZ2x3aldRQXU5cXdIdnlVaFJVVTVTSzlsdFA3Y0VW?=
 =?utf-8?B?ZmFhWTJERnZtWi9rZkErb3I0aGtNaFVsOTZiYmpkNXVNSWovM3BGWG1vRUpW?=
 =?utf-8?B?ajk2MjRPTkZ2UE42ZHdXTGkxYXBqdEliOW9UT1pJUW1yQ3hXS0E4MnEya3hj?=
 =?utf-8?B?TGZhTDlNQ0VlL2pLc2hBZG95YnZTU2E5WC9BUHRQRmpEVk1zdm1SdUovVEV2?=
 =?utf-8?B?V2svSmFqNzdhbnQrTWhXZDhadTJEcUt1L09YMSt0TXFMQjEveTFnUTgrd3pu?=
 =?utf-8?B?OERkUmtpbDhycUxRcmJqVHZBa1JIaU1mcTVEMjB0V2FZYStsNkJuK3dQNlcx?=
 =?utf-8?B?b2Q5SVcxR0lGOGpHQm5PWldTSnA1OVVST3hRaDBJYTNvTnI1djZDUlY1b1ly?=
 =?utf-8?Q?5nOoDI4jkTPXlSB5zuSqdVn8U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8fjBZtdsOd+m/VxKqdabujphbLEUp71m4Dx8VfCjZoLZjTerH6JUneoSsjbv7/1tzTD2pj1No94ulzzY+qqGgnxhgpG9urnEvwwICr+VXoclbyjXuUz1f2YJbVQtqW/AWv17vSYo8+3C6KQN0EUM8pfCUGqSiY7xL6Nlm9oekfdnZxHDqOTLCC5zobR1Rh5fEjdpTE9DYffj7KozGNYVugQX+x9qzWmMhEytIyELc6MOjx5ZBOnhb8w3ypFkgRj70CH0E77h2/I1Jn7VwZVm3ZOoYoFC/9OkJth6MoEEnQmSGRyOYilFyph/5jD5JCDZcLhb+PNaMufmbMlprvD2nUnBzwHJ9oxezM36BqtaGG0IOLhTopsb06mtHOhDsOGQyBmSmzkk0tivGt1k6lcqKL1UfczRsRAP0/yYgANa5LnkqMOMeKweNTsq4ZM4fX+5bAaWWi4TA/cn2Wt6MFNE1KoYzF6BH2UixYgNuhLvq1gmuaZgMj9J08ROzZeRVuKkh3wOsQylhv37s4MOfwumCXn3nTl2Sb6MCPxJq2/GEzhfz0RlZjgknuA56gA7psAW4n6INKQvsF6ac+WR5JJg6YqA8mfD+DV7EjPysIOJqggBG6e1QxXSqM2Tk5phU0JJT5iqhr2gCRm0A19QJvhOEGCvTY8nRXfKW2r5To/UelKyo42Ae3Ug4l9wxbDLqg9sz2fipSMgtxVM1b2prSx/ECw1idGcjnU3ljI2E4wpde3nq4IqFy+qNBHQbbgbndr/Z+zPRs8GmrgZlky63fRwODd1YRnE30cFa70bysiF5HBxjXyGVCiHTXy9qhjMqAQI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee46db1-07e6-4b8c-b744-08daf20b982f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 06:34:44.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sz6GNJ/Ktm4nI+EHixYR01w4Qa5+/CXgCjzdsAr7oNGoAYJSZfFQ47toNbxhh4ia/gSENMAyqp1fDbhLWp5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_02,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090046
X-Proofpoint-GUID: RGQfXCMZfM0Mv8HUIck5d9v7itqZzEiK
X-Proofpoint-ORIG-GUID: RGQfXCMZfM0Mv8HUIck5d9v7itqZzEiK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/8/23 6:41 PM, Mike Galbraith wrote:
> On Sun, 2023-01-08 at 16:50 -0800, dai.ngo@oracle.com wrote:
>> Hi Mike,
> Greetings,
>
>> Could you give the v2 patch a try? I will send you the location
>> to upload the core, if it happens, in a private email.
> V2 cured it.  I also verified that virgin rc3 still does spew/brick.

Thank you much Mike!

-Dai

