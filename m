Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7526387EF3
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 19:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbhERRvE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 13:51:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47854 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245418AbhERRvE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 13:51:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IHi0bt001342;
        Tue, 18 May 2021 17:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3ZCyV3vXMbOiiYPzs8FIt/X5Gv0Ozpqa3kPrG7fvZpY=;
 b=nY9TUWJ0k7XqtJmhSrm+REMSUiJCmVqUZEv2yryxv8uWc0rirYDhknIf+gpVMuTGwAsp
 bokaDusQOBjZPa9+ShD1B2HkbbCWnsreMKaiFoSfp69eqkQ0exKz2/uuFQ7VTloN+sJR
 kzUiAG4vzlRiUMnvAcV3nrlI8IN6m03nFVF8V75WveQ97SxNpRnd2qte0E9QZwQ4opld
 Ecv3XoueewtcIgj4/3aYiU2YI3vECWx6gn7b+jdJJPiOrDvMYD2mQql2ckYXnNuuLV2D
 iszkpn61LwIq7v+dG2ZUKxMQV5zV9svadkeDOO0Q1UdD7nSop4PhXwBo9mbiU0ysJ7S6 XA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kh0h8ry5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 17:49:43 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14IHnguu002089;
        Tue, 18 May 2021 17:49:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 38meefedrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 17:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axACOGEXNuzUcK9owySqPUqDujfla1IXmSkVCjSvWEhdZ8aaGLmKPQ4EQX91cFLjo6nPukTaZR/WCmABqzwrJVqkf3hQU11SvZRBXdmEQmtvdpFhQ6jld6aGpizCtXqWiGoPkMYPXK/jucpRqlkA3CBhQaJft+UnC50fD2FOKYRASJuQ0WcJ79ZGHbq0ZSBfVOtZhm9evQnowdPmy4IjMI9A9pNgH8ydUCKHiDTm99durzyzaF/Oh/fEv05z5wRfIhh8fzsWr43LtwXl4j5uweA4+qnbuHhHiS7CPa6h2D8lmFmSdF9tEeGJpcGY2MNaXs04QEDWJVdnUGsDN0fcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZCyV3vXMbOiiYPzs8FIt/X5Gv0Ozpqa3kPrG7fvZpY=;
 b=eYZ2mcd4/KuKN5EsYGAzEinv8j3s2FrJ3DjDLkA41KoG08CL51WKL2ANkpRT+zXX/s4dbAZM8K6nWaepVP3IJ1IqK06u+ofGghDoxunNdZyaWwV5ASyp8rsFc9kZE3DAi3v8/5iAoVUYrGLlRXXFoMyNKhHg+SzEjN/Je3DHYfelvMluzMczPQDDvvAO4DVsdEuim6AHp49EGoXsqEIAgL1qAf+27C/sGzhNE45kRfonk7X0VctTN62dDa3Y8fozGIAidvuBhd4nqKo3MLWT99qOBHYjLvndSwzEqbom8OrQG1dRjQoHsMxbwIlLOqkOXKwTTcpKwVBL1L2+iNLIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZCyV3vXMbOiiYPzs8FIt/X5Gv0Ozpqa3kPrG7fvZpY=;
 b=WDZNy8SY1RwWARvhajbiym+pIFfWrhr8TbyR1JBW3WeQq+ctZY8s2xshm9xEg7kbsxpOYQgHoZfKkBwHJfhVTfMQIhopwY4EWYH9l9UTiTQCWAJB0OAZoSVCTFfahxHyQmqU5NYDFBb0Aks/WpBVBV7BWvMKnH0N5zTkAmt8u7c=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3032.namprd10.prod.outlook.com (2603:10b6:a03:82::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 17:49:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4129.033; Tue, 18 May 2021
 17:49:40 +0000
Subject: Re: [PATCH v5 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     olga.kornievskaia@gmail.com, linux-nfs@vger.kernel.org,
        trondmy@hammerspace.com, chuck.lever@oracle.com
References: <20210517224330.9201-1-dai.ngo@oracle.com>
 <20210517224330.9201-2-dai.ngo@oracle.com>
 <20210518170456.GA25205@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <ce8435e8-51e9-158f-d038-1d92d1438bd2@oracle.com>
Date:   Tue, 18 May 2021 10:49:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210518170456.GA25205@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:a03:60::31) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-230-11.vpn.oracle.com (72.219.112.78) by BYAPR07CA0054.namprd07.prod.outlook.com (2603:10b6:a03:60::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 17:49:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32840eb3-e99f-47ad-e433-08d91a254f99
X-MS-TrafficTypeDiagnostic: BYAPR10MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB303281A8EED5473D7D36A4FA872C9@BYAPR10MB3032.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRbsMgus5/EPOc/bExP/JgPFaDDwtcyuRakDEJa+VWV/TL+Vn60sAfcbBXuXT7nIQszSWrvMZpw31bPsaesdzt5bF+qul3fppvffTPrjFRTKX4QfM8LK65jdAJDj2uzjt+/hl6U8iEkpreuql3a6vZSEF6O2SRjTjmXxR0s8rxdb/kZ9lFGeYUc2Vr98+9YePcxF3aNfpUqYgHBYj1PrM1wNu4FYLz3Dpd+P3eXRfPcuRcLMs7E8xTR/VwkebauhQyol1bnk7YP3/ymKzMncTLIyr5jRMXNsfqP4/UJLAy7/mKCj78+PQpNW/cCNaWtDbYKL613XWun6VQMdPE8HTJ8HQXFGzVt6+zEBLTGexsyMZjcsS5tGlbQLaoBJZygxyxbWGJpOM66+xkRahF19OjFd2ZwiZdR0WnTLUscCExK4llXK6XZ5q9MhUqjul+qEWv+m1gDanp7r1/JS1huBadB3/I9z9ObqU3wZrgyp1mIFpkc6mQFs4RhuxmEpfdGnvLrXzIDCtteWDBlE3f8XPPzep6xnbCAU4wmhKlf5ziUZt65tPeaeRD3rRhdRLrA+JfLb3yXh12OCv4pqJRW6vfotC9YZLA3AQJCemZchB5w5CvRfTpgcJicOCEaEiSPrNJl9ZK+139leVelrbDbo5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(376002)(346002)(31686004)(6916009)(478600001)(107886003)(66946007)(66556008)(8676002)(8936002)(36756003)(26005)(4326008)(66476007)(31696002)(7696005)(5660300002)(6486002)(956004)(38100700002)(2616005)(16526019)(2906002)(9686003)(86362001)(83380400001)(186003)(316002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ekJlWkdDdHNTdDV3LzUzSCthUzB6WEF6azM3cU9ILzhocW10K3B5RWlUQy94?=
 =?utf-8?B?b2hMcUhZQ0twN0k3NmZYNUVReUxNckQ4UVpESHowREhRU2lWNHlxenVOVjRl?=
 =?utf-8?B?MGcxaldvOUJUTUlGb3JsbXpCdHJHZkkwR3JrQ2ZFY2NSanpYYjZvUHNrSDNS?=
 =?utf-8?B?QWhDb0xKVlltOWJXVURNYUtiWnkvV0lma0Y5T0d3ZkVZbWN5RjQ0UGh5SFBu?=
 =?utf-8?B?MU5YL3BwZUl3WmNNQzk5dFBjOXcxNlcwVWhiRVVpb0NOWERQNWI3Tk8xZkZW?=
 =?utf-8?B?elJnT1NUTXdqWDI3K25VNjBvaE0vL05FbTlzYUlPQi8wUUgydFNIUEFxc04y?=
 =?utf-8?B?dFdUNG9HZ0M4ZGZxaXBrbkc4QUdnM2k3bEhpY094aDNVNXl5UDJrejNaYk9Y?=
 =?utf-8?B?STY4K1U0QkxOdjhNbUx3L1NDTFg3eFJQTnBlV3dSZkYyTy9rRjVTNHVvWVp1?=
 =?utf-8?B?OEZlN2lRb0hBQTFJekJCRDUvZ25vU3JNWFRWYWpJblVaQlZZeVF6dE1OeFVR?=
 =?utf-8?B?dTliSFg4ZEpOL0tOV0VQNXdnU2RRZ3ZPVS9YQ0hsaktScFU4VDRsdktsZnNI?=
 =?utf-8?B?TlNxK0M0cmpnQTBnKy9xQU55UkdMK3F0d3JpRlN5aStKNHRDbEFMTDIvWXFP?=
 =?utf-8?B?OHVmam82bUxUYnNVQTByemhmOVNpZXlLZkFhOHhFNUM5TG5sdXBLclFHZlZq?=
 =?utf-8?B?bDlGOGxUajZLVy9sWjlONDFGK2FpZFk0ZjZyeTBvRTM4R2FVZ3JhRVZYMUll?=
 =?utf-8?B?QzJEMUtWWFB0Ly96aUpjRlZkRXV3TGVWR3Bncmxucy9aV1NrNzhYZlBaYWZh?=
 =?utf-8?B?ajRSb3dTa0JNRmRQbFk4cHg3QTlSQTRJVWxEaWplZndPTkN1WW12RUpVQ1Y1?=
 =?utf-8?B?ZTZHWUdxazJvTTdGdUxZUkg1VzNIaHZyUm1SSDVOWU9tc1ZMRVhrVVF3WXQz?=
 =?utf-8?B?MTkxeUZLbGdQUHYxM25hS3ZrZ1BzeWJtQU9JTEVJT25aN0xDRi9xaXhZOExs?=
 =?utf-8?B?VVBsTVFkcFN0K3NZUWoyY3JTMW9iUkdrVmE2Z3NqYTEvbXNBQ3IvdlJ6QUZM?=
 =?utf-8?B?VUlMVmxpMWFpM1lCanZmT1Q1VHo3M0xMYVc4dEhzQUF2aHlvUEwxMndCKzVv?=
 =?utf-8?B?WEFYM2tVelZ0RlNtQURFUjRyODc0cXZqYTJ5ZU9GVzREcjY2YWhxK0Y2VFhT?=
 =?utf-8?B?N2xtSklvY3BuTTdhMm9tdSszeG91a3RjL3h3ZEdLaEc0a0RwcTBOUkU4NG9o?=
 =?utf-8?B?a0hyajkvM3doQzV4SXdjQkRSenR1TThmbVUzRE14ODc1bWNvcFJ5ZXBYdjlV?=
 =?utf-8?B?SFcrdittd2JvT0hhSU9hTjhlT29ISktxVXdsY0FJQjFFUDRTeU9TNUpCcTNp?=
 =?utf-8?B?S0wrdVA3RStPL3FFak8yWlMralorN0lCZlF2WXFWTlloTXd5d3FhREtNbUtp?=
 =?utf-8?B?NGQrOGJQRnJ0SHNna3NrY0oxSDB1TlJjNFhPTytjZGF6RzNOMmtUSk4rME05?=
 =?utf-8?B?RlhrR0M5Wmh2RC82aDNaSnQ5Y0p1ZHdoT05vMTVWUFNXNDZaK2loTHpBQm5V?=
 =?utf-8?B?RisxSWZtc0JiSlppWFFVZlErb25GdHFmN1pyUzdjUkxVMmhnR3c0NVVzalRn?=
 =?utf-8?B?TWZaRXBscG56SlZUWHh3emduZmdqZkkzdFZTMGdRUjR1bUd0WlM0V1ZzbjNl?=
 =?utf-8?B?TnVFWXFOdmFRR2FiOXduTUJiZkhJL3o1UzMxdUJaSEtqMTN2RkhxQXFGdjUy?=
 =?utf-8?Q?HZnSvYc5ybWXIwX//mBB5g3Z7ECgbGAaJ/joEna?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32840eb3-e99f-47ad-e433-08d91a254f99
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 17:49:40.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfK4hwZGkI6P5GCcFS3eaEtQsuE4qlu3PB2Jw6dBNiwlRiNBgE+QHJNFeyBTSrcWaD1ROED8QkXl07UPqH6TZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3032
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105180123
X-Proofpoint-GUID: bqDi9tl53pP5heFHWt7ZF7MknHgQIY2n
X-Proofpoint-ORIG-GUID: bqDi9tl53pP5heFHWt7ZF7MknHgQIY2n
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 5/18/21 10:04 AM, J. Bruce Fields wrote:
> On Mon, May 17, 2021 at 06:43:29PM -0400, Dai Ngo wrote:
>> +struct nfsd4_ssc_umount;
>>   
>>   enum {
>>   	/* cache misses due only to checksum comparison failures */
>> @@ -176,6 +177,10 @@ struct nfsd_net {
>>   	unsigned int             longest_chain_cachesize;
>>   
>>   	struct shrinker		nfsd_reply_cache_shrinker;
>> +
>> +	spinlock_t              nfsd_ssc_lock;
>> +	struct nfsd4_ssc_umount	*nfsd_ssc_umount;
> ...
>
>> +void nfsd4_ssc_init_umount_work(struct nfsd_net *nn)
>> +{
>> +	nn->nfsd_ssc_umount = kzalloc(sizeof(struct nfsd4_ssc_umount),
>> +					GFP_KERNEL);
>> +	if (!nn->nfsd_ssc_umount)
>> +		return;
> Is there any reason this needs to be allocated dynamically?  Let's just
> embed it in nfsd_net.
>
> Actually, I'm not convinced the separate structure definition's really
> that helpful:
>
>> +struct nfsd4_ssc_umount {
>> +	struct list_head nsu_list;
>> +	unsigned long nsu_expire;
>> +	wait_queue_head_t nsu_waitq;
>> +};
> How about just:
>
> 	struct nfsd_net {
> 	...
> 	/* tracking server-to-server copy mounts: */
> 	spinlock_t		nfsd_ssc_lock;
> 	struct list_head	nfsd_ssc_mount_list;
> 	unsigned long		nfsd_ssc_mount_expire;
> 	wait_queeu_head_t	nfsd_ssc_mount_waitq;
>
> or something along those lines?

I will move nfsd4_ssc_umount into nfsd_net.

-Dai

>
> --b.
