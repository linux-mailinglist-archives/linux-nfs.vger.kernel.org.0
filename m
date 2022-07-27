Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CC583378
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiG0TXq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiG0TXm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:23:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C63C8
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 12:23:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RIww6i018493;
        Wed, 27 Jul 2022 19:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YbC/4XZaUafVQ4cb+Hv2j5Hja+liWjoydhvzxPhFiEY=;
 b=uiPvkf0Lijqfn6trGYCjnlSWAhUkAwjKxgOyjNuG2uWjMwLyPUbByVjq00Aqfns82hpa
 5vZdYpsWTm/tVWpo8I0kKpveR3wTvh7K64ergIyPhj7lFBIBOAky3jBVQWwuwNXvwRqe
 LofomnZwRbZl88Sl3chzqDi4O9L1lms+YpGIRzMsC1x0SstgBoRu8ge1L1K1em7FaYQ9
 x+SIbKdUuHWEpKWK2/MdRFUP9dqxFu58/rRZ2JNO9ZRwrZu8dUg1GLBBewxPqGBBBC1e
 rP7Rwll1i6iwFDSXps2ZoCZOUOpQ0T4d5EVYc0D7gG8GaBeiJF6llvOxU04r237k1PBH pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsu105-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:23:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RHOqaf017154;
        Wed, 27 Jul 2022 19:23:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh652ejds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSmWiUdk2s8Tfp/77YyXt4wRbIPLuPDMKFO+Ynvz9G37sSVA7daGgUDs15Y+nFNyklF3Bg4CigVrdk+cCl1MgsUnXlirOr5pg/OnDCtAAFTk+q3MX0IF+/uplLVYVM2reYURmNJLXsGkZ20uLxlWaVIzil8gRL/lxwb2uFUXMXlXMB56hOuPqd9R+e7vPGoyC9Kzx2NQdYsPzCZheqdG+/2hxRbwn7cx9huNWcBUFH9Xd8MvnL5Ik/V0aWmaDFn4uu8BgcOUOp8FyfRVjCj819GHRO+moVYl6cSOppD65tqJ25tnss8aKsNK1QgaaBXtCtEK10Cnf49PJVwOrpteqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbC/4XZaUafVQ4cb+Hv2j5Hja+liWjoydhvzxPhFiEY=;
 b=iPePEHFFNwUpL/3gQbKHWuSvWhHIq6eZ/KdCqWZ9SrgdX+fv9KzvlR6J9GMYG42lto/CqGOok3FCOaBL9cIrJdNvT9aUFblDoUjVavKIAd6Sjbug/CxUkDxfOhbA02lzD8wHu1ncdO0URtJFcgvkdfbCn/5TWA+9gNAasixGDPyBHBZscHSr4J1cseoX6+tCvSYEyY0dGTn8bbdonNnh5jJa4vIGTe/yQBjsIhWL0TlPO92SIFtLKWVf5V23Yieb+0GCciYjwEbEUTo4zs8quZpCO6y8X/JzpKUpkhYVKbCn0WEpSebZAx+Z5KOtzS8Wpvtp2PfKgmTFceMkwBjlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbC/4XZaUafVQ4cb+Hv2j5Hja+liWjoydhvzxPhFiEY=;
 b=H1DgtQudhK5D0L2sIMROnmfw6qlHtuuN/HP72ztoIt8uvbiCrrFYp6GfMuxasrBdt6sFZ2vmeCHUfdGp+wWbnq2DtFWcc7JS8pF1mgKrZL2LoEgaIDBBYaRey4/+KuvDKuHpM3WWrlwsKuWzxfUqiX/2IxVNBMQOviHtkiVp5/0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CY4PR10MB1478.namprd10.prod.outlook.com (2603:10b6:903:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 19:23:31 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 19:23:31 +0000
Message-ID: <3fb8aeda-8845-746c-8c99-993830830778@oracle.com>
Date:   Wed, 27 Jul 2022 12:23:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v1 00/11] Put struct nfsd4_copy on a diet
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
 <CAN-5tyEgRvvFq51kdT-ROo-ew71JE610Da=Cqf_Ya4dgYxEmKg@mail.gmail.com>
 <CAN-5tyEjNjEbR7YC7MMiYgCNEL0MdjRW+CZM71uZG1iO+YHwRQ@mail.gmail.com>
 <4F2D66E7-2D88-4A29-9115-B6F6D292F195@oracle.com>
 <CAN-5tyGs-N2gJrfyXt8Un2hm4Mw-iJZ22dP433im8vjK9uZgYw@mail.gmail.com>
 <FAD3BEB0-BF61-431F-BA38-10350D8F8B9B@oracle.com>
 <CAN-5tyFEK91=aDb2_oweevS+t8t342i02L+1a-t4w_YZu0zr3g@mail.gmail.com>
 <CAN-5tyFQdb22wLpBJ7V_8=NefyRs5a-GGumojBuwj4HZsUu9Pg@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyFQdb22wLpBJ7V_8=NefyRs5a-GGumojBuwj4HZsUu9Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0401396e-5259-4c72-1a83-08da70057d93
X-MS-TrafficTypeDiagnostic: CY4PR10MB1478:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guuAYoxBbbkf9cFxQP9jYU8+V6XYN+4lOGvsxSJSlNsJj64neQy00V3wtDVU+TBSRKaGmSwSUFQilf6A0WpCyrbbwmu6Ejkkhm+Lz86DFsIcc52C/Sl7vFNEdZ7Y3qeLovqWwTGLpRrnLDnOGVfiIYTaze5T4sMcLI0rmGMePbaqovSG5lm1lE9p2JpMkECk1fRH/XFC4TeaJiel/qreXN4t3ZKcN6ZJnAfMuobF0zIRAuWsynVfeeD1U7Njs+ruGhNRfJgaK+g80d1aaNSlMj1+c19UuY9zkBicnaNSYMJoepysf/ghM2HcyyEuI94TMUsOIYaVtS8DrcBxh+UE2YaD+PcpFG3TTzkhurixVgbF0zd7rNDyYWAdoD/5CRLb4XPwKoPn3Q46Mg3+pYHK/oyitv19G+n34JDfUAd6kouQb/H2W6EYMyl7tnVZJtnlvSQugSk08wEMUAbfRzZToNk8wCi4GOL4hvI4dS3b+gHUhKNnrDb6auPaJSo6ep+jYgjCH7wgDvpu0WddcHGpz+OUtD6zQoPrQSc/6mymwVmdK8zfpesDAEdn7LFnExVdlGBtBJ++0uJC+MpmlXiKxpuyGl9ahR38Kwn/0zgKj48ZZHYnLosC0lVAdrMxG+Haa4qROze4KGZw9WmpexDzsiTTuOBKKpjCj+vgtAoDJeCztXfPjCGoHlfp6nQHWdbHfTxGIzRKIMwulfe5Kj+8+wiuX2kVemDTCgQxZ9jFi+wv3kmgQ0l1/P/wetfsa83wbn8QDjIlms/bDPHpsWjCVzy591hfUpbk9S/OExBJ+X8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(396003)(366004)(346002)(83380400001)(31696002)(2906002)(86362001)(45080400002)(66946007)(38100700002)(31686004)(26005)(110136005)(8676002)(66476007)(6666004)(36756003)(66556008)(41300700001)(6512007)(8936002)(5660300002)(6506007)(316002)(478600001)(9686003)(30864003)(186003)(6486002)(53546011)(4326008)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNMVzNNdHpWQUppK00yWXZJVW1RMjNPbktudmRZMmlmUnprRzJMZVlNYXRv?=
 =?utf-8?B?aVVkaERkeWU2U2FmN2pJcUFaRVNBOWxpUWVEZ25GTWtESFBMRmxDREMzTEVQ?=
 =?utf-8?B?eUF5enpyNUpaVUFDamVkNjVrYzFpK1B6ckVTUms1TEZQVW5rSk91SlhiSkk4?=
 =?utf-8?B?TldPVHZqRFpmcHduK1gxV1c0V3FOQlB1QXlON2h5RTM3djYybFlGbGJaT1lP?=
 =?utf-8?B?RjhTYWFldmtLa3RtMlZXeTU5c3BiZktOY2h5NmZhamptOUp6VDlWYXZNK1FG?=
 =?utf-8?B?MkRIN0I4QlJHOTI4TUZFcDNrK1VDZzdsY2oycGtIazNRTjdqT0QzODVuQWNk?=
 =?utf-8?B?cFJ2aFJsTG9DdnE0M2t3cThETDArNFNSM0t0cXpSWU0vbFJ6eFFTdUdjalBI?=
 =?utf-8?B?NmRUa21NY0VtTEY5R29lZ0FqS1hyOHVrU3gxV0VMS2N0eHZScGV4dWVjRi8v?=
 =?utf-8?B?elIvbS9BWHdDbEFkV2pVdFl5QnUrZEN6MHlHamE4aFVEaERmMEgvUkFNY1hS?=
 =?utf-8?B?aS9rUEJhMlRjTHlLeXY5VXVDYXR5UVFJaEFSeUd0TTI4djJsVTBwZFNrUGFN?=
 =?utf-8?B?ODBlV085NnVwWnRzVzQwczhPT2F5czF2dXdjUWcwTnRjb0tud2NpL3k4SEVs?=
 =?utf-8?B?WEs2dTU1M2YxYzUxSENaRitlaHlXK0Q3aHNhU2xiQWF1c1RGUm9PMkc4ZjFM?=
 =?utf-8?B?Y2NSWFhFWS9tUVRSblRnVHdYRnpkZ0w1TEp5alhOWjZKNEtmRkZDSlh6dC82?=
 =?utf-8?B?aisrQnZWRGhqM1EzaHNsSVJIOFVtNXhZV20vNTBUWHlmQWovbTZJd0RzMDVh?=
 =?utf-8?B?K2NUcm9NbjUzZk94Tlh1dUdKV0VyZ2JTQ1NtZjRoR3YxTml1aUhkUDZDbWY4?=
 =?utf-8?B?RkFGQ3RnQkJvdDFjMzIrNXMyVHk3V3poWjZEcGMweEkwVksralNKZXU3Q0E4?=
 =?utf-8?B?K3loQ3djMDVRei84UUxLUzZGd09NVnFjOXRPQUJ2ZGNWVDRuZHN6cTlLY0RQ?=
 =?utf-8?B?cmpDeU56Qm84UUZUaVhKdDdTaXN0ek1DWDhTNS9SaDNSVG40RGRlUTFsaGgv?=
 =?utf-8?B?SWZzYTFEbGJ4YW1DRzRDTDQ1SVhjSHFOdSsyaHlRNG5PUVFDYXNNQlBVMlQ1?=
 =?utf-8?B?YVlvYVRXc1pDWFE5OFN4eC9OZHB4Y2xETC80RFN2RVZnZEhqYk05NGRCc2Jo?=
 =?utf-8?B?S1lFeVpBaWdtcFdhUFFnN0J6ZkZwL1hwdWxDTnRkYjIrTG5QSHkzWHhReWxi?=
 =?utf-8?B?YTc4My9WNFc5ck1iMXRuTXdYOE9mcGZzVjVEUndZak1iODB5QVpkZm9NbmpR?=
 =?utf-8?B?aU9PV1FRZHZMNGROR0xFNkgxbkxFVzMrRHVNODhZSWx1RENrV3NYUHFGVEdl?=
 =?utf-8?B?L0ZpT3kwRkhneXFmYWtUV2dmQ0VlUE81SzYzODh0d3BHMUc1bkN6VUI3d1dW?=
 =?utf-8?B?bUZJZVMzOHZJV1BSV1JEaXJxbFJKU0hTYklnck5FZEJpUzZBRlBXbnVaR2tj?=
 =?utf-8?B?ZFZ1S2YxUEovbXdZWnBjb0EwUVZJVUlRbk1WamhWZmlzVEo3WEJwYS9VdVpP?=
 =?utf-8?B?QTcyWXZOUGE3VGU4cHBiWWE4dEZmanAzMEdKdklJNmNoYmRZKzFLS2srZjFT?=
 =?utf-8?B?RWZHY2RTVkgzQ1VuYTQxYUZPMTFRRU9ybVErOFJlaUVia0Q2ZWpKNldRSUgx?=
 =?utf-8?B?aktRaW81N25EdlQrTkhSMjAwS044cEJqWDByTGZSenpyTW1iZXdzSlpHMEZz?=
 =?utf-8?B?RVZxamdHNTJhd1haV2lkaERYT1h3WnNydndKRmxOcGpOaUVqZ2tyS3hFcGRz?=
 =?utf-8?B?L01OZERSbm8wT0UrYmVvdEEwK29TSzB0VkZQUkJNNmsramFqWTJQOHJUTVBv?=
 =?utf-8?B?RHhsUGNjamN3OWNBS1lXZ2NtUGRZSjY5ZzZpS0lYdXYvQTJzUytIMUFQQ0pk?=
 =?utf-8?B?b3NLUmlrVlg2Z2JWNjNMNkFKc3ZNNUsyUThLYkZlRVRFWVNHU1U0alVhOVFZ?=
 =?utf-8?B?NVo4UElLcHFyTERsUGZyV2d5ZG1DMzVaY2lCUG0zYktraVMrTVVEVm14ODdB?=
 =?utf-8?B?SlkxTTlrUFc4Tis4bkNKbmg3UG5JVVNYaG1UdlFPL2tTUXdnUnhpZWNsVG43?=
 =?utf-8?Q?vOQM94QynGOzPoL6NRXapS9uP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0401396e-5259-4c72-1a83-08da70057d93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 19:23:31.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/JQhG2KIIFlFWa1pjRbOh9twpa1LnU+wGkZMRYVqD/4j6TnSv+Rs0EXZ2wYjdnVFgKp5vnrqW713IFd/PFjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270082
X-Proofpoint-ORIG-GUID: QTc7gqz-hBthCeH2mC2QgJ-lRktNWum3
X-Proofpoint-GUID: QTc7gqz-hBthCeH2mC2QgJ-lRktNWum3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 7/27/22 11:48 AM, Olga Kornievskaia wrote:
> On Wed, Jul 27, 2022 at 2:21 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>> On Wed, Jul 27, 2022 at 2:04 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>
>>>
>>>> On Jul 27, 2022, at 1:52 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>
>>>> After applying Dai's patch I got further... I hit the next panic
>>>> (below)... before that it ran into a failure for "inter01" failed with
>>>> ECOMM. On hte trace, after the COPY is places the server returns
>>>> ESTALE in CB_OFFLOAD, then close is failed with BAD_SESSION (just
>>>> basically something really wrong happened on the server)... After
>>>> failing a new more tests in the similar fashion.. On cleanup the oops
>>>> happens.
>>> What test should I run to reproduce this?
>> I'm running "./nfstest_ssc". It ran thru all with "inter15" being
>> last, then started "cleanup" and that's what panic-ed the server.
>>
>> It's been a while since I tested ssc... so i'll undo all the patched
>> and re-run the tests to make sure that before code worked.
> It looks like the code got broken before this patch set. The ESTALE in
> CB_OFFLOAD leading to ECOM error happens without your patches. And
> then the kernel panic. I'll do my best to git bisect where the problem
> occurred first.

I think this this is what lead to the list_del corruption problem:

Jul 27 12:14:23 nfsvmd07 kernel: ==================================================================
Jul 27 12:14:23 nfsvmd07 kernel: BUG: KASAN: use-after-free in __list_del_entry_valid+0x16e/0x180
Jul 27 12:14:23 nfsvmd07 kernel: Read of size 8 at addr ffff8881189c8230 by task kworker/u2:1/23
Jul 27 12:14:23 nfsvmd07 kernel:
Jul 27 12:14:23 nfsvmd07 kernel: CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 5.19.0-rc7+ #1
Jul 27 12:14:23 nfsvmd07 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Jul 27 12:14:23 nfsvmd07 kernel: Workqueue: nfsd4 laundromat_main [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: Call Trace:
Jul 27 12:14:23 nfsvmd07 kernel: <TASK>
Jul 27 12:14:23 nfsvmd07 kernel: dump_stack_lvl+0x57/0x7d
Jul 27 12:14:23 nfsvmd07 kernel: print_report.cold+0xf8/0x654
Jul 27 12:14:23 nfsvmd07 kernel: ? __list_del_entry_valid+0x16e/0x180
Jul 27 12:14:23 nfsvmd07 kernel: kasan_report+0x8a/0x190
Jul 27 12:14:23 nfsvmd07 kernel: ? pm_suspend.cold+0x4e2/0x4e2
Jul 27 12:14:23 nfsvmd07 kernel: ? __list_del_entry_valid+0x16e/0x180
Jul 27 12:14:23 nfsvmd07 kernel: __list_del_entry_valid+0x16e/0x180
Jul 27 12:14:23 nfsvmd07 kernel: __list_del_entry+0xa/0xb0 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: _free_cpntf_state_locked+0x75/0x170 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: laundromat_main.cold+0x23/0x28 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: ? release_lock_stateid+0x70/0x70 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: ? rcu_read_lock_sched_held+0x81/0xb0
Jul 27 12:14:23 nfsvmd07 kernel: ? rcu_read_lock_bh_held+0x90/0x90
Jul 27 12:14:23 nfsvmd07 kernel: process_one_work+0x7cc/0x1350
Jul 27 12:14:23 nfsvmd07 kernel: ? lockdep_hardirqs_on_prepare+0x410/0x410
Jul 27 12:14:23 nfsvmd07 kernel: ? queue_delayed_work_on+0x90/0x90
Jul 27 12:14:23 nfsvmd07 kernel: ? rwlock_bug.part.0+0x90/0x90
Jul 27 12:14:23 nfsvmd07 kernel: worker_thread+0x55d/0xe80
Jul 27 12:14:23 nfsvmd07 kernel: ? process_one_work+0x1350/0x1350
Jul 27 12:14:23 nfsvmd07 kernel: kthread+0x29e/0x340
Jul 27 12:14:23 nfsvmd07 kernel: ? kthread_complete_and_exit+0x20/0x20
Jul 27 12:14:23 nfsvmd07 kernel: ret_from_fork+0x1f/0x30
Jul 27 12:14:23 nfsvmd07 kernel: </TASK>
Jul 27 12:14:23 nfsvmd07 kernel:
Jul 27 12:14:23 nfsvmd07 kernel: Allocated by task 4051:
Jul 27 12:14:23 nfsvmd07 kernel: kasan_save_stack+0x1e/0x40
Jul 27 12:14:23 nfsvmd07 kernel: __kasan_slab_alloc+0x64/0x80
Jul 27 12:14:23 nfsvmd07 kernel: kmem_cache_alloc+0xeb/0x2c0
Jul 27 12:14:23 nfsvmd07 kernel: nfs4_alloc_stid+0x29/0x430 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: nfsd4_lock+0x1e9e/0x3cb0 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: nfsd4_proc_compound+0xd75/0x26c0 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: nfsd_dispatch+0x4e8/0xc00 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: svc_process_common+0xb51/0x1af0 [sunrpc]
Jul 27 12:14:23 nfsvmd07 kernel: svc_process+0x361/0x4f0 [sunrpc]
Jul 27 12:14:23 nfsvmd07 kernel: nfsd+0x2d6/0x570 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: kthread+0x29e/0x340
Jul 27 12:14:23 nfsvmd07 kernel: ret_from_fork+0x1f/0x30
Jul 27 12:14:23 nfsvmd07 kernel:
Jul 27 12:14:23 nfsvmd07 kernel: Freed by task 4051:
Jul 27 12:14:23 nfsvmd07 kernel: kasan_save_stack+0x1e/0x40
Jul 27 12:14:23 nfsvmd07 kernel: kasan_set_track+0x21/0x30
Jul 27 12:14:23 nfsvmd07 kernel: kasan_set_free_info+0x20/0x30
Jul 27 12:14:23 nfsvmd07 kernel: __kasan_slab_free+0xf0/0x160
Jul 27 12:14:23 nfsvmd07 kernel: kmem_cache_free.part.0+0x7f/0x1c0
Jul 27 12:14:23 nfsvmd07 kernel: free_ol_stateid_reaplist+0x12b/0x200 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: nfsd4_close+0x58e/0xe10 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: nfsd4_proc_compound+0xd75/0x26c0 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: nfsd_dispatch+0x4e8/0xc00 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: svc_process_common+0xb51/0x1af0 [sunrpc]
Jul 27 12:14:23 nfsvmd07 kernel: svc_process+0x361/0x4f0 [sunrpc]
Jul 27 12:14:23 nfsvmd07 kernel: nfsd+0x2d6/0x570 [nfsd]
Jul 27 12:14:23 nfsvmd07 kernel: kthread+0x29e/0x340
Jul 27 12:14:23 nfsvmd07 kernel: ret_from_fork+0x1f/0x30
Jul 27 12:14:23 nfsvmd07 kernel:
Jul 27 12:14:23 nfsvmd07 kernel: The buggy address belongs to the object at ffff8881189c8228#012 which belongs to the cache nfsd4_stateids of size 360
Jul 27 12:14:23 nfsvmd07 kernel: The buggy address is located 8 bytes inside of#012 360-byte region [ffff8881189c8228, ffff8881189c8390)
Jul 27 12:14:23 nfsvmd07 kernel:
Jul 27 12:14:23 nfsvmd07 kernel: The buggy address belongs to the physical page:
Jul 27 12:14:23 nfsvmd07 kernel: page:000000009faa88de refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1189c8
Jul 27 12:14:23 nfsvmd07 kernel: flags: 0x8000000000000200(slab|zone=2)
Jul 27 12:14:23 nfsvmd07 kernel: raw: 8000000000000200 ffff8881008a0950 ffffea000399e380 ffff888108fd9d00
Jul 27 12:14:23 nfsvmd07 kernel: raw: 0000000000000000 ffff8881189c8080 0000000100000009
Jul 27 12:14:23 nfsvmd07 kernel: page dumped because: kasan: bad access detected
Jul 27 12:14:23 nfsvmd07 kernel:
Jul 27 12:14:23 nfsvmd07 kernel: Memory state around the buggy address:
Jul 27 12:14:23 nfsvmd07 kernel: ffff8881189c8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 27 12:14:23 nfsvmd07 kernel: ffff8881189c8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
Jul 27 12:14:23 nfsvmd07 kernel: >ffff8881189c8200: fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb
Jul 27 12:14:23 nfsvmd07 kernel:                                     ^
Jul 27 12:14:23 nfsvmd07 kernel: ffff8881189c8280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 27 12:14:23 nfsvmd07 kernel: ffff8881189c8300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Jul 27 12:14:23 nfsvmd07 kernel: ==================================================================

I think nfs4_free_ol_stateid needs to also removing the
nfs4_cpntf_state from the s2s_cp_stateids list, still
validating.

-Dai

>
>>>> [  842.455939] list_del corruption. prev->next should be
>>>> ffff9aaa8b5f0c78, but was ffff9aaab2713508. (prev=ffff9aaab2713510)
>>>> [  842.460118] ------------[ cut here ]------------
>>>> [  842.461599] kernel BUG at lib/list_debug.c:53!
>>>> [  842.462962] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>>>> [  842.464587] CPU: 1 PID: 500 Comm: kworker/u256:28 Not tainted 5.18.0 #70
>>>> [  842.466656] Hardware name: VMware, Inc. VMware Virtual
>>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>>> [  842.470309] Workqueue: nfsd4 laundromat_main [nfsd]
>>>> [  842.471898] RIP: 0010:__list_del_entry_valid.cold.3+0x37/0x4a
>>>> [  842.473792] Code: e8 02 d8 fe ff 0f 0b 48 c7 c7 c0 bb b6 b0 e8 f4
>>>> d7 fe ff 0f 0b 48 89 d1 48 89 f2 48 89 fe 48 c7 c7 70 bb b6 b0 e8 dd
>>>> d7 fe ff <0f> 0b 48 89 fe 48 c7 c7 38 bb b6 b0 e8 cc d7 fe ff 0f 0b 48
>>>> 89 ee
>>>> [  842.479607] RSP: 0018:ffffa996c0ca7de8 EFLAGS: 00010246
>>>> [  842.481828] RAX: 000000000000006d RBX: ffff9aaa8b5f0c60 RCX: 0000000000000002
>>>> [  842.484769] RDX: 0000000000000000 RSI: ffffffffb0b64d55 RDI: 00000000ffffffff
>>>> [  842.487252] RBP: ffff9aaab9b62000 R08: 0000000000000000 R09: c0000000ffff7fff
>>>> [  842.489939] R10: 0000000000000001 R11: ffffa996c0ca7c00 R12: ffffa996c0ca7e50
>>>> [  842.492215] R13: ffff9aaab9b621b0 R14: fffffffffffffd12 R15: ffff9aaab9b62198
>>>> [  842.494406] FS:  0000000000000000(0000) GS:ffff9aaafbe40000(0000)
>>>> knlGS:0000000000000000
>>>> [  842.496939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  842.498759] CR2: 000055a8b4e96010 CR3: 0000000003a18001 CR4: 00000000001706e0
>>>> [  842.500957] Call Trace:
>>>> [  842.501740]  <TASK>
>>>> [  842.502479]  _free_cpntf_state_locked+0x36/0x90 [nfsd]
>>>> [  842.504157]  laundromat_main+0x59e/0x8b0 [nfsd]
>>>> [  842.505594]  ? finish_task_switch+0xbd/0x2a0
>>>> [  842.507247]  process_one_work+0x1c8/0x390
>>>> [  842.508538]  worker_thread+0x30/0x360
>>>> [  842.509670]  ? process_one_work+0x390/0x390
>>>> [  842.510957]  kthread+0xe8/0x110
>>>> [  842.511938]  ? kthread_complete_and_exit+0x20/0x20
>>>> [  842.513422]  ret_from_fork+0x22/0x30
>>>> [  842.514533]  </TASK>
>>>> [  842.515219] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
>>>> iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
>>>> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
>>>> nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
>>>> vmw_vsock_vmci_transport vsock intel_rapl_msr snd_seq_midi
>>>> snd_seq_midi_event intel_rapl_common crct10dif_pclmul crc32_pclmul
>>>> vmw_balloon ghash_clmulni_intel pcspkr joydev btusb uvcvideo btrtl
>>>> btbcm btintel videobuf2_vmalloc videobuf2_memops snd_ens1371
>>>> videobuf2_v4l2 snd_ac97_codec ac97_bus videobuf2_common snd_seq
>>>> videodev snd_pcm bluetooth rfkill mc snd_timer snd_rawmidi
>>>> ecdh_generic snd_seq_device ecc snd soundcore vmw_vmci i2c_piix4
>>>> auth_rpcgss sunrpc ip_tables xfs libcrc32c sr_mod cdrom sg ata_generic
>>>> nvme nvme_core t10_pi crc32c_intel crc64_rocksoft serio_raw crc64
>>>> vmwgfx vmxnet3 drm_ttm_helper ata_piix ttm drm_kms_helper syscopyarea
>>>> sysfillrect sysimgblt fb_sys_fops ahci libahci drm libata
>>>> [  842.541753] ---[ end trace 0000000000000000 ]---
>>>> [  842.543403] RIP: 0010:__list_del_entry_valid.cold.3+0x37/0x4a
>>>> [  842.545170] Code: e8 02 d8 fe ff 0f 0b 48 c7 c7 c0 bb b6 b0 e8 f4
>>>> d7 fe ff 0f 0b 48 89 d1 48 89 f2 48 89 fe 48 c7 c7 70 bb b6 b0 e8 dd
>>>> d7 fe ff <0f> 0b 48 89 fe 48 c7 c7 38 bb b6 b0 e8 cc d7 fe ff 0f 0b 48
>>>> 89 ee
>>>> [  842.551346] RSP: 0018:ffffa996c0ca7de8 EFLAGS: 00010246
>>>> [  842.552999] RAX: 000000000000006d RBX: ffff9aaa8b5f0c60 RCX: 0000000000000002
>>>> [  842.555151] RDX: 0000000000000000 RSI: ffffffffb0b64d55 RDI: 00000000ffffffff
>>>> [  842.557503] RBP: ffff9aaab9b62000 R08: 0000000000000000 R09: c0000000ffff7fff
>>>> [  842.559694] R10: 0000000000000001 R11: ffffa996c0ca7c00 R12: ffffa996c0ca7e50
>>>> [  842.561956] R13: ffff9aaab9b621b0 R14: fffffffffffffd12 R15: ffff9aaab9b62198
>>>> [  842.564300] FS:  0000000000000000(0000) GS:ffff9aaafbe40000(0000)
>>>> knlGS:0000000000000000
>>>> [  842.567357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  842.569273] CR2: 000055a8b4e96010 CR3: 0000000003a18001 CR4: 00000000001706e0
>>>> [  842.571598] Kernel panic - not syncing: Fatal exception
>>>> [  842.573674] Kernel Offset: 0x2e800000 from 0xffffffff81000000
>>>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>>> [ 1101.134589] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>>
>>>> On Wed, Jul 27, 2022 at 1:15 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>>
>>>>>
>>>>>> On Jul 27, 2022, at 12:18 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>>>
>>>>>> Hi Chuck,
>>>>> Sorry for the delay, I was traveling.
>>>>>
>>>>>> To make it compile I did:
>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>> index 7196bcafdd86..f6deffc921d0 100644
>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>> @@ -1536,7 +1536,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>>>>        if (status)
>>>>>>                goto out;
>>>>>>
>>>>>> -       status = nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
>>>>>> +       status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
>>>>>>        if (status)
>>>>>>                goto out;
>>>>> Yes, same bug was reported by the day-0 kbot. v1 was kind of an RFC,
>>>>> as I hadn't fully tested it. Sorry for mislabeling it.
>>>>>
>>>>> I will post a v2 of this series with this fixed and with Dai's
>>>>> fix for nfsd4_decode_copy(). Stand by.
>>>>>
>>>>>
>>>>>> But when I tried to run the nfstest_ssc. The first test (intra01) made
>>>>>> the server oops:
>>>>>>
>>>>>> [ 9569.551100] CPU: 0 PID: 2861 Comm: nfsd Not tainted 5.19.0-rc6+ #73
>>>>>> [ 9569.552385] Hardware name: VMware, Inc. VMware Virtual
>>>>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>>>>> [ 9569.555043] RIP: 0010:nfsd4_copy+0x28b/0x4e0 [nfsd]
>>>>>> [ 9569.556662] Code: 24 38 49 89 94 24 10 01 00 00 49 8b 56 08 48 8d
>>>>>> 79 08 49 89 94 24 18 01 00 00 49 8b 56 10 48 83 e7 f8 49 89 94 24 20
>>>>>> 01 00 00 <48> 8b 06 48 89 01 48 8b 86 04 04 00 00 48 89 81 04 04 00 00
>>>>>> 48 29
>>>>>> [ 9569.561792] RSP: 0018:ffffb092c0c97dd0 EFLAGS: 00010282
>>>>>> [ 9569.563112] RAX: ffff99b5465c2460 RBX: ffff99b5a68828e0 RCX: ffff99b5853b6000
>>>>>> [ 9569.565196] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff99b5853b6008
>>>>>> [ 9569.567140] RBP: ffffb092c0c97e10 R08: ffffffffc0bf3c24 R09: 0000000000000228
>>>>>> [ 9569.568929] R10: ffff99b54b0e9268 R11: ffff99b564326998 R12: ffff99b5543dfc00
>>>>>> [ 9569.570477] R13: ffff99b5a6882950 R14: ffff99b5a68829f0 R15: ffff99b546edc000
>>>>>> [ 9569.572052] FS:  0000000000000000(0000) GS:ffff99b5bbe00000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> [ 9569.573926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [ 9569.575281] CR2: 0000000000000000 CR3: 0000000076c36002 CR4: 00000000001706f0
>>>>>> [ 9569.577586] Call Trace:
>>>>>> [ 9569.578220]  <TASK>
>>>>>> [ 9569.578770]  ? nfsd4_proc_compound+0x3d2/0x730 [nfsd]
>>>>>> [ 9569.579945]  nfsd4_proc_compound+0x3d2/0x730 [nfsd]
>>>>>> [ 9569.581055]  nfsd_dispatch+0x146/0x270 [nfsd]
>>>>>> [ 9569.581987]  svc_process_common+0x365/0x5c0 [sunrpc]
>>>>>> [ 9569.583122]  ? nfsd_svc+0x350/0x350 [nfsd]
>>>>>> [ 9569.583986]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
>>>>>> [ 9569.585129]  svc_process+0xb7/0xf0 [sunrpc]
>>>>>> [ 9569.586169]  nfsd+0xd5/0x190 [nfsd]
>>>>>> [ 9569.587170]  kthread+0xe8/0x110
>>>>>> [ 9569.587898]  ? kthread_complete_and_exit+0x20/0x20
>>>>>> [ 9569.588934]  ret_from_fork+0x22/0x30
>>>>>> [ 9569.589759]  </TASK>
>>>>>> [ 9569.590224] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
>>>>>> iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
>>>>>> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
>>>>>> nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
>>>>>> vmw_vsock_vmci_transport vsock snd_seq_midi snd_seq_midi_event
>>>>>> intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul
>>>>>> vmw_balloon ghash_clmulni_intel joydev pcspkr btusb btrtl btbcm
>>>>>> btintel snd_ens1371 uvcvideo snd_ac97_codec videobuf2_vmalloc ac97_bus
>>>>>> videobuf2_memops videobuf2_v4l2 videobuf2_common snd_seq snd_pcm
>>>>>> videodev bluetooth mc rfkill ecdh_generic ecc snd_timer snd_rawmidi
>>>>>> snd_seq_device snd vmw_vmci soundcore i2c_piix4 auth_rpcgss sunrpc
>>>>>> ip_tables xfs libcrc32c sr_mod cdrom sg ata_generic crc32c_intel
>>>>>> ata_piix nvme ahci libahci nvme_core t10_pi crc64_rocksoft serio_raw
>>>>>> crc64 vmwgfx drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect
>>>>>> sysimgblt fb_sys_fops vmxnet3 drm libata
>>>>>> [ 9569.610612] CR2: 0000000000000000
>>>>>> [ 9569.611375] ---[ end trace 0000000000000000 ]---
>>>>>> [ 9569.612424] RIP: 0010:nfsd4_copy+0x28b/0x4e0 [nfsd]
>>>>>> [ 9569.613472] Code: 24 38 49 89 94 24 10 01 00 00 49 8b 56 08 48 8d
>>>>>> 79 08 49 89 94 24 18 01 00 00 49 8b 56 10 48 83 e7 f8 49 89 94 24 20
>>>>>> 01 00 00 <48> 8b 06 48 89 01 48 8b 86 04 04 00 00 48 89 81 04 04 00 00
>>>>>> 48 29
>>>>>> [ 9569.617410] RSP: 0018:ffffb092c0c97dd0 EFLAGS: 00010282
>>>>>> [ 9569.618487] RAX: ffff99b5465c2460 RBX: ffff99b5a68828e0 RCX: ffff99b5853b6000
>>>>>> [ 9569.620097] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff99b5853b6008
>>>>>> [ 9569.621710] RBP: ffffb092c0c97e10 R08: ffffffffc0bf3c24 R09: 0000000000000228
>>>>>> [ 9569.623398] R10: ffff99b54b0e9268 R11: ffff99b564326998 R12: ffff99b5543dfc00
>>>>>> [ 9569.625019] R13: ffff99b5a6882950 R14: ffff99b5a68829f0 R15: ffff99b546edc000
>>>>>> [ 9569.627456] FS:  0000000000000000(0000) GS:ffff99b5bbe00000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> [ 9569.629249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [ 9569.630433] CR2: 0000000000000000 CR3: 0000000076c36002 CR4: 00000000001706f0
>>>>>> [ 9569.632043] Kernel panic - not syncing: Fatal exception
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Tue, Jul 26, 2022 at 3:45 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>>>> Chuck,
>>>>>>>
>>>>>>> Are there pre-reqs for this series? I had tried to apply the patches
>>>>>>> on top of 5-19-rc6 but I get the following compile error:
>>>>>>>
>>>>>>> fs/nfsd/nfs4proc.c: In function ‘nfsd4_setup_inter_ssc’:
>>>>>>> fs/nfsd/nfs4proc.c:1539:34: error: passing argument 1 of
>>>>>>> ‘nfsd4_interssc_connect’ from incompatible pointer type
>>>>>>> [-Werror=incompatible-pointer-types]
>>>>>>> status = nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
>>>>>>>                                  ^~~~~~~~~~~~~
>>>>>>> fs/nfsd/nfs4proc.c:1414:43: note: expected ‘struct nl4_server *’ but
>>>>>>> argument is of type ‘struct nl4_server **’
>>>>>>> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>>>>>                        ~~~~~~~~~~~~~~~~~~~^~~
>>>>>>> cc1: some warnings being treated as errors
>>>>>>> make[2]: *** [scripts/Makefile.build:249: fs/nfsd/nfs4proc.o] Error 1
>>>>>>> make[1]: *** [scripts/Makefile.build:466: fs/nfsd] Error 2
>>>>>>> make: *** [Makefile:1843: fs] Error 2
>>>>>>>
>>>>>>> On Fri, Jul 22, 2022 at 4:36 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>>> While testing NFSD for-next, I noticed svc_generic_init_request()
>>>>>>>> was an unexpected hot spot on NFSv4 workloads. Drilling into the
>>>>>>>> perf report, it shows that the hot path in there is:
>>>>>>>>
>>>>>>>> 1208         memset(rqstp->rq_argp, 0, procp->pc_argsize);
>>>>>>>> 1209         memset(rqstp->rq_resp, 0, procp->pc_ressize);
>>>>>>>>
>>>>>>>> For an NFSv4 COMPOUND,
>>>>>>>>
>>>>>>>>        procp->pc_argsize = sizeof(nfsd4_compoundargs),
>>>>>>>>
>>>>>>>> struct nfsd4_compoundargs on my system is more than 17KB! This is
>>>>>>>> due to the size of the iops field:
>>>>>>>>
>>>>>>>>        struct nfsd4_op                 iops[8];
>>>>>>>>
>>>>>>>> Each struct nfsd4_op contains a union of the arguments for each
>>>>>>>> NFSv4 operation. Each argument is typically less than 128 bytes
>>>>>>>> except that struct nfsd4_copy and struct nfsd4_copy_notify are both
>>>>>>>> larger than 2KB each.
>>>>>>>>
>>>>>>>> I'm not yet totally convinced this series never orphans memory, but
>>>>>>>> it does reduce the size of nfsd4_compoundargs to just over 4KB. This
>>>>>>>> is still due to struct nfsd4_copy being almost 500 bytes. I don't
>>>>>>>> see more low-hanging fruit there, though.
>>>>>>>>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Chuck Lever (11):
>>>>>>>>      NFSD: Shrink size of struct nfsd4_copy_notify
>>>>>>>>      NFSD: Shrink size of struct nfsd4_copy
>>>>>>>>      NFSD: Reorder the fields in struct nfsd4_op
>>>>>>>>      NFSD: Make nfs4_put_copy() static
>>>>>>>>      NFSD: Make boolean fields in struct nfsd4_copy into atomic bit flags
>>>>>>>>      NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
>>>>>>>>      NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
>>>>>>>>      NFSD: Refactor nfsd4_do_copy()
>>>>>>>>      NFSD: Remove kmalloc from nfsd4_do_async_copy()
>>>>>>>>      NFSD: Add nfsd4_send_cb_offload()
>>>>>>>>      NFSD: Move copy offload callback arguments into a separate structure
>>>>>>>>
>>>>>>>>
>>>>>>>> fs/nfsd/nfs4callback.c |  37 +++++----
>>>>>>>> fs/nfsd/nfs4proc.c     | 165 +++++++++++++++++++++--------------------
>>>>>>>> fs/nfsd/nfs4xdr.c      |  30 +++++---
>>>>>>>> fs/nfsd/state.h        |   1 -
>>>>>>>> fs/nfsd/xdr4.h         |  54 ++++++++++----
>>>>>>>> 5 files changed, 163 insertions(+), 124 deletions(-)
>>>>>>>>
>>>>>>>> --
>>>>>>>> Chuck Lever
>>>>>>>>
>>>>> --
>>>>> Chuck Lever
>>>>>
>>>>>
>>>>>
>>> --
>>> Chuck Lever
>>>
>>>
>>>
