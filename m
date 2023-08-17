Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3BB7801AB
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 01:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbjHQX3N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 19:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356095AbjHQX26 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 19:28:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09943595
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 16:28:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HN4AaZ019968;
        Thu, 17 Aug 2023 23:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nk+qPjfXNyk/cbT/J6W7mEzKmlPT3bboOm7uT1N0/g4=;
 b=O21ft9uAcstPvzmu1eIqda3UBulOv03XZid1H6mnG8YTGxENg6PSnPPOskglAS+V7QVc
 XfhpNl/cjcPGFZteQteB5U6qs28zppTSaSXiao8xkO1OuxlQDgq+Lt4IaG88Jz/E9MTK
 BoN5n5bQ+6qaTDa19xdNpVKArvI71QWXn5cJUtVnvBP9ssUEWwbVXACqtXD21X7Np3Rf
 MnnOkyUmzJm26r/clfp9HITkStKdQg/DxsyFsxIKWKwQFnFM2p9OjkLdmvO66j1vlsoO
 3GwQjSyCSB36AgUyXAjS3FffvHkPCWMW8Mnn38n9Ysik8cBiDQ/+gjUOCEkwimBBd4KM 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349jres-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 23:28:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HLQQiR039436;
        Thu, 17 Aug 2023 23:28:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey73fafc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 23:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbMY7F/W5HLkU05h5Io2nIFUBwhmwWBfBpTT2BCZcAmQUaz0rRJhVwHLYgv4wO06jJ2IGwsmtj/2IShd7J8oOLnkpFbuCp++YtlvSMLt+URiCbtnnqkiT45VYQqVuVh/M9f2tgUnu63WFHYE9cg0jQkQcm0eg4fTCEZl6BdcZVAy0pBFhlycTA7ETQ6gGF1X3yvNoM0U801TSIYYYxf06P5E/3vRdKKKQyAt0sEgpWYNSiHtdwJrThaWA2IAfULX2gEDJBYbZYwn/eojiUkJLCiw0yteHQ1QXBZiJyy4v2UnzD/e8/haxYC2gMF1T5Vtc35fRDJxyoPi2c+UQjBygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk+qPjfXNyk/cbT/J6W7mEzKmlPT3bboOm7uT1N0/g4=;
 b=g+ZgiZeMXiK/sYGK+2SEYzNTMwc0NLD+zmCH8bRa/bTZ2+9cPqx2uVAq+QQDTKR6+oaiDq8euh4lMWfy7GP6xuwMPqVHk0kM24evxbDFgZb0xAwNZ6/XHr/wSUikx4KLIPFYNYGBrF6WYEHJgzA2XuS2GqWcBj02vLpbkPu0zpfz7dqvoLsb5qRvBXpbX583WzSlU550GPAIC0Z0NNekH9ugylt8gRFCOX+nLePnjJadJDz1LddIwwG//faP8yEPEin6z7haLJzQdUKD+cAaRh90woQTn8AKwSfNQzzLeMqLxfnQtga4Djo5vte2JgvpU0CQjEBhH/llF74s7dzGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk+qPjfXNyk/cbT/J6W7mEzKmlPT3bboOm7uT1N0/g4=;
 b=o3RpUqrk2dyBhcJsE5fybnrR/23Gpheg9rAc2KgWDFO+RRl4jBzLdQFLP+WRQEB/gmViKHHYzkTvozweolu0Jr5qqc7M69ikB9tDF8roMskdAyp7OfMv/MgMTlt1V61mpd160eepiSlN1vZ3e1aG/A79LvAb6lqia2Arhq8rKWs=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by PH7PR10MB6082.namprd10.prod.outlook.com (2603:10b6:510:1fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 23:28:42 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 23:28:42 +0000
Message-ID: <90ea5539-0350-c137-30f6-cab87e47428c@oracle.com>
Date:   Thu, 17 Aug 2023 16:28:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: xfstests results over NFS
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Tom Talpey <tom@talpey.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
 <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
 <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
 <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
 <77977950a7d6a4539114fdd0d6db982143c4f9b1.camel@kernel.org>
 <0AEF7E06-E2F6-426D-B3DF-3D0ED8233082@oracle.com>
 <6af7807c75e3d6110bc80661a600038f5cfb0022.camel@kernel.org>
 <7b2746692aef1725cb000faabf4db2d115279423.camel@kernel.org>
 <25bc018a-00a7-1634-9535-9d01328264d3@oracle.com>
 <b535fccd-acd2-8fca-71ac-6aa17ee84708@oracle.com>
 <cd592a05c13226c5e1fb4f390eb2473ba20024ad.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <cd592a05c13226c5e1fb4f390eb2473ba20024ad.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|PH7PR10MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe819f7-b515-4c73-8996-08db9f79b1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ktvPOnSU18ShwWs0Z5FtvVLdMDwq4q2HJaGf2Q59r2UvBue6mILLg0DvOuxXFuVn7m4YBXE/80jj4ttj3eIOgDVZ1KCpFMpSO9sycSE8UHhG3J0HENfasYylQXO9zdP/vYcZa3OHybGqJDqYh89SysD/uz+v0kDEG8IHrzCZ/4CjLv9XrsKALmiLdYSEyjMb9o/CovMnDLUPKE3U1NTmSofoUif2kKa0uddwkBZ8HaNBoEx1XN7sbhGX6Bl+r7kTGf7eOyFvTXsekDAcFcuVpnrEgSUCUb/E9LN/u7TeU21XdgZnYi8iN/Zivoc48lW8oSoJyiU+jCyAng/6mwZ2hh19s5Dq4szMiaBvxwOSgIHBAVHoaEuD3p+mbTXtxm+jDTp2KkkmXANGpKRh48c9GLi2aMIS4EfwVoZeHj3Bbw8QJzi7tJCf9QGTibrcsFaZO0O++V13dPELecj4EsPa6JULJWQEB16jnKVIlnLqZIr1106e2ZXDLpX9+bKqn1/gGcJCFmIEYzzUVEeM3nBBy5htNZ2pB3lCcqj+aXw5C0st5gqSYLFAhdmFrnIle3hu15qbvQ80l2fGBI42YOV+ZpvXYD3tLRTiw6uEnuq8l0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(186009)(451199024)(1800799009)(36756003)(86362001)(31696002)(31686004)(5660300002)(3480700007)(8676002)(4326008)(8936002)(53546011)(2906002)(41300700001)(26005)(6666004)(6486002)(6506007)(2616005)(83380400001)(9686003)(6512007)(478600001)(110136005)(38100700002)(316002)(54906003)(66556008)(66476007)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWJydzFpY3F1bEJ1SVBuSCsxOUw5eTVWQ294bTBFUmdEVXgvc2swME85SFln?=
 =?utf-8?B?dDAyUTFVTHdxR0k3YTh0NzdOM0VLcmlMNmJwQ1BLYklEd0xEU0ZmZTJuVUpv?=
 =?utf-8?B?bTZpYWp3blV3OStqQzZ4SWVFb2FCTnBRNXdlWk03NUNnc2tqVzNCZ0s4d1pi?=
 =?utf-8?B?WWN5MzlwaURBd2YxZ25LOWZWditpZ3A1dGp5WHNQVnptOWQ3bFVOWDRzQ0pH?=
 =?utf-8?B?TzAxTVlwT0kydEZ1OEs1TWwvUGJXYmdYSlc3OHFJU1dQeng1Y3UvR2kvRnlC?=
 =?utf-8?B?SW8vbUxRV1NzOXdWVHIvc2RFT3phaXlwNUZ4bC9mUUZzaGFHaW9ZSXlVQkd2?=
 =?utf-8?B?YVYwNXdxNzlqMFZ6dllkWGR6aFV2NW12OXBXMXpJVG9Va2JDVlVNbzlIRGQ0?=
 =?utf-8?B?OHBTYUNNWHJXclo0aGJuSnBiaFVLeWtDcGRlTVpxV0diNFljalZkMDFFdWhj?=
 =?utf-8?B?QkxuT1R2ZVp0TFhnNG5FbXlzWVZXRnB3THB1Y2pYTEJteTF4azBQLzVUVVhq?=
 =?utf-8?B?MCtQOElRbVpQcXZKc3hwQW9GR29CVmdsU2tYZnNEUW01RXp6ZGhSN2xtNThY?=
 =?utf-8?B?ak42VHhlaG1qcyt2bUNwY25VQ2crdHN6VldFWGIyVVd6Rkh2SmRzUldtbUhZ?=
 =?utf-8?B?RDB6d3NUY203amFDWHpKQ3J1UzI3OEk5Q25IL3VoL2ZCWHdoVU9pT3pkYVhm?=
 =?utf-8?B?MnFPTDY5MlFuRlpabFRFVlpISVJraGc2RVhUbkpDWjZqRzhVZm1iNHJlYjZp?=
 =?utf-8?B?Y3JqWE5EbHJDR3F4R1JuazRkWDdYVCs3emhKMExqU0VORTNYUEZLdXVYVGxO?=
 =?utf-8?B?M1MvRzVCY2djdGpIMWVrMmNXUlJpTDNOU1Fxd1RVTlM2Nm5wUVo4YlRnRVhI?=
 =?utf-8?B?YWpRWlYyZklqOWQrQnk4QUpFTU90Ui9rcTVRb29ucVBuNkhYTUZPUFNyTG1O?=
 =?utf-8?B?Nm1TM2xTYnRmeWNtdVdqQXMwTEY4cUNxVWtVcnQvaVhJVmhBVlkxT0padVZW?=
 =?utf-8?B?aUFma1dzck1aV2d0b0JsUkdDYUhTUHoyZnBhT2pYTnpFbFp6ZlY3VXlYMDBS?=
 =?utf-8?B?ZlRmTisyajZNTU5DVWtzWXp5dzFSUkpZWGZTZUVyNlRYZGk1OWtvd3lUNmlW?=
 =?utf-8?B?ZjZyU1dtK1RzRDBML0dtRWU3YVFza1Z3Y2N5OHVvc3NZRUdmU084NWNlOE8r?=
 =?utf-8?B?SkNpY2FKMVZSeU9EWlpLcTdLNEhpYksybS9yME9ZZFZsNElnOXdvYnVtLzhN?=
 =?utf-8?B?L1J1OEowVXpoS0UvUlJROGRGWWtDbjlzaTBTT1lMT3V5MXI0dWxDL3N3TXdJ?=
 =?utf-8?B?V21wNi9pMEtNNHFZam05SHlCZGlldnBXRHdUR08yM1pyVHVIaFU3czcyRVhl?=
 =?utf-8?B?amdGMVNTU29zZDJoTGx1VXNMZ3M2K0M3ckdBamFlOERRZmZ4QllVb3RkcERS?=
 =?utf-8?B?QzU5azMvaFRXSnZuNkNTK2VpdFZJdHQyVUl0TW9pNmtxSWRRUUxBUkRJTFcx?=
 =?utf-8?B?amZDUE1Ka04xeUVydEVkYTdVWXpSbmkrRFZScHF5N2NCT2krbUl5alRIa25O?=
 =?utf-8?B?L2dVQzh2THl2MytOZEF0Ymduek9PeFYrZ2dzUk1MM1lIUEJVTUF0anNTS0FP?=
 =?utf-8?B?U2VoQnNOdVV5N2hrVkJPN0gvMGluYXYrVmNwUVFDU2VCdExYYURNZVdPUzRT?=
 =?utf-8?B?OGJlZmZXYjIzaTZpNjdWTzFpbjE5Vm9tczdwWGQzUkNkM01GYys4YytUSFY0?=
 =?utf-8?B?ck1ueW5aT2k5RURKVmRteXBndy92eDhxY05Wdi9DNnd6ZlJXNDZHWlovVVRt?=
 =?utf-8?B?Ry9BZWZtMVZ1ai9wR09jWjdBRTlTQWZJL0ZuYWdKWG1JYlp3MHJiRmNMWkFR?=
 =?utf-8?B?TjN2aFR0RVFCemlGU1NtNlYwOU81OXg3ZnphKzIzNkZmcjZrWGh6VXJWbktp?=
 =?utf-8?B?K2Yyb2N4VFB6UHVJd1k2Lyt5Z1ZvMlV0M2NLMTdrdzUxME84Ymp3b3Ftemt6?=
 =?utf-8?B?cEZIWmRpUW83bnJzcnpPTGJRbVkycmhQMlNrNnlsOEVzSGhTZUFJeFlpN1BK?=
 =?utf-8?B?NlYvS3QzQzJpd0FGdWJFU2VPN0RybWgvcUIxeHRzNGRDWmxUVE0rN2JJQnlw?=
 =?utf-8?Q?5e4QUaDAVIvvDAt6bpNYv+gy1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 43kxhxVe2L1psQtdAQNzyjdim1AF84FxOa1g+rCx0bBhzxV2uqdwlok/uejWnQKiWQIRfz9/Z5dDOC3JWRqwZP8jFjW20ECqOhT2f+HFVo+GQpLkYPPnsxRqqtNLfi0csf+R//QHAP4+E2VqqNjVETpS4f3k/xtQ4lbrk6DbxaNHrpwnuNGBYdnJwZaA089aWMfK0J42QZxS8j/EYbSqLQjjnvoydInx7V/mpSGgKvSh8KwdKrpt51YgMJx83xB8SmIhfgVp4EreVW/HMcBllyTuM1VCp2zLHB2shd3EQT7b9AXFHhie2D4hyUfHn0BjqZLPxAP5mc0LU4VczN08Ybnnui56PYYKyYRxojDJE0RrRT4CjHAccoc5e5NZJ0zwZcY4BnKKM7EU4CWBJ2gyCqzc6EMC7fDz8DkitqsLbwAXUPRfzr6xJtwNBIy94Ll7quk0wCM3J7YVvj+m2bdk4Qejg8RVhafPHUBJ4HMZmkvjxWLSU/NEGPTSkfHKLJXgb2hKM3UmvOX4RmvbUuhfHMmiOdXcxcf3VPQOqVpD+q0xdGn5AcZqrTgHbAH5iSsSMT0CP4AIWsv/Bb4+xMX93dBMgJjjItCqkqAwuT/gqCThtBCWW6gR3VWfLlPq5DxV/mHSlPrM84x6PjQ1oz5//v4zl4n9FFvDYiKE5scSJGy6NpH8utDCqsO1dj1eOeCcAo89WzTHeZ2Ia/cgHsoTqQzRrYCTPh1Nnn9GcQF50UWdf168YfOj8nmJIMl1XY/BG5IKnYxVMbJ1DRMFUzplTAgQQmWPqWX+MY5sSZCzhp6gDsspIno8lUYBWJV8KBIMeU82h2PBv24T69dTZvaqlbUjC3WeL6GBT1sp5+/bjmpJWn6ukgy7U1lA/ZIrnU7PhKbw7oLyIhnDcEb1jtf2Zw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe819f7-b515-4c73-8996-08db9f79b1b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 23:28:42.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFI+d7sV3rr/2LS0PY4VOC1lC8LoncR2oSwRpGQoC2ENzaJUzUzZNzgp9J0bty1KzBv8uMePAgsFV8ztdpRjKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_18,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170208
X-Proofpoint-GUID: NOpzuRaXDU4nYQpzvfcN8QepBTX6b5er
X-Proofpoint-ORIG-GUID: NOpzuRaXDU4nYQpzvfcN8QepBTX6b5er
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/17/23 4:08 PM, Jeff Layton wrote:
> On Thu, 2023-08-17 at 15:59 -0700, dai.ngo@oracle.com wrote:
>> On 8/17/23 3:23 PM, dai.ngo@oracle.com wrote:
>>> On 8/17/23 2:07 PM, Jeff Layton wrote:
>>>> On Thu, 2023-08-17 at 13:15 -0400, Jeff Layton wrote:
>>>>> On Thu, 2023-08-17 at 16:31 +0000, Chuck Lever III wrote:
>>>>>>> On Aug 17, 2023, at 12:27 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>
>>>>>>> On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
>>>>>>>> On Thu, Aug 17, 2023 at 10:22 AM Jeff Layton <jlayton@kernel.org>
>>>>>>>> wrote:
>>>>>>>>> On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
>>>>>>>>>>> On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org>
>>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> I finally got my kdevops
>>>>>>>>>>> (https://github.com/linux-kdevops/kdevops) test
>>>>>>>>>>> rig working well enough to get some publishable results. To
>>>>>>>>>>> run fstests,
>>>>>>>>>>> kdevops will spin up a server and (in this case) 2 clients to run
>>>>>>>>>>> xfstests' auto group. One client mounts with default options,
>>>>>>>>>>> and the
>>>>>>>>>>> other uses NFSv3.
>>>>>>>>>>>
>>>>>>>>>>> I tested 3 kernels:
>>>>>>>>>>>
>>>>>>>>>>> v6.4.0 (stock release)
>>>>>>>>>>> 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
>>>>>>>>>>> 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of
>>>>>>>>>>> yesterday morning)
>>>>>>>>>>>
>>>>>>>>>>> Here are the results summary of all 3:
>>>>>>>>>>>
>>>>>>>>>>> KERNEL:    6.4.0
>>>>>>>>>>> CPUS:      8
>>>>>>>>>>>
>>>>>>>>>>> nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/124
>>>>>>>>>>>     generic/193 generic/258 generic/294 generic/318 generic/319
>>>>>>>>>>>     generic/444 generic/528 generic/529
>>>>>>>>>>> nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>>>     generic/187 generic/193 generic/294 generic/318 generic/319
>>>>>>>>>>>     generic/357 generic/444 generic/486 generic/513 generic/528
>>>>>>>>>>>     generic/529 generic/578 generic/675 generic/688
>>>>>>>>>>> Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
>>>>>>>>>>>
>>>>>>>>>>> KERNEL:    6.5.0-rc6-g4853c74bd7ab
>>>>>>>>>>> CPUS:      8
>>>>>>>>>>>
>>>>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>>>>     generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>>>>> nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>>>     generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>>>>     generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>>>>     generic/675 generic/688
>>>>>>>>>>> Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
>>>>>>>>>>>
>>>>>>>>>>> KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
>>>>>>>>>>> CPUS:      8
>>>>>>>>>>>
>>>>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>>>>     generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>>>>> nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
>>>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>>>     generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>>>>     generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>>>>     generic/675 generic/683 generic/684 generic/688
>>>>>>>>>>> Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s
>>>>>>>> As long as we're sharing results ... here is what I'm seeing with a
>>>>>>>> 6.5-rc6 client & server:
>>>>>>>>
>>>>>>>> anna@gouda ~ % xfstestsdb xunit list --results --runid 1741
>>>>>>>> --color=none
>>>>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>>>>
>>>>>>>>> run | device               | xunit   | hostname | pass | fail |
>>>>>>>> skip |  time |
>>>>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>>>>
>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-3   | client   |  125 |    4 |
>>>>>>>> 464 | 447 s |
>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.0 | client   |  117 |   11 |
>>>>>>>> 465 | 478 s |
>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.1 | client   |  119 |   12 |
>>>>>>>> 462 | 404 s |
>>>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.2 | client   |  212 |   18 |
>>>>>>>> 363 | 564 s |
>>>>>>>> +------+----------------------+---------+----------+------+------+------+-------+
>>>>>>>>
>>>>>>>>
>>>>>>>> anna@gouda ~ % xfstestsdb show --failure 1741 --color=none
>>>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>>>     testcase | tcp-3   | tcp-4.0 | tcp-4.1 | tcp-4.2 |
>>>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>>> generic/053 | passed  | failure | failure | failure |
>>>>>>>>> generic/099 | passed  | failure | failure | failure |
>>>>>>>>> generic/105 | passed  | failure | failure | failure |
>>>>>>>>> generic/140 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/188 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/258 | failure | passed  | passed  | failure |
>>>>>>>>> generic/294 | failure | failure | failure | failure |
>>>>>>>>> generic/318 | passed  | failure | failure | failure |
>>>>>>>>> generic/319 | passed  | failure | failure | failure |
>>>>>>>>> generic/357 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/444 | failure | failure | failure | failure |
>>>>>>>>> generic/465 | passed  | failure | failure | failure |
>>>>>>>>> generic/513 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/529 | passed  | failure | failure | failure |
>>>>>>>>> generic/604 | passed  | passed  | failure | passed  |
>>>>>>>>> generic/675 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/688 | skipped | skipped | skipped | failure |
>>>>>>>>> generic/697 | passed  | failure | failure | failure |
>>>>>>>>>      nfs/002 | failure | failure | failure | failure |
>>>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>>
>>>>>>>>
>>>>>>>>>>> With NFSv4.2, v6.4.0 has 2 extra failures that the current
>>>>>>>>>>> mainline
>>>>>>>>>>> kernel doesn't:
>>>>>>>>>>>
>>>>>>>>>>>     generic/193 (some sort of setattr problem)
>>>>>>>>>>>     generic/528 (known problem with btime handling in client
>>>>>>>>>>> that has been fixed)
>>>>>>>>>>>
>>>>>>>>>>> While I haven't investigated, I'm assuming the 193 bug is also
>>>>>>>>>>> something
>>>>>>>>>>> that has been fixed in recent kernels. There are also 3 other
>>>>>>>>>>> NFSv3
>>>>>>>>>>> tests that started passing since v6.4.0. I haven't looked into
>>>>>>>>>>> those.
>>>>>>>>>>>
>>>>>>>>>>> With the linux-next kernel there are 2 new regressions:
>>>>>>>>>>>
>>>>>>>>>>>     generic/683
>>>>>>>>>>>     generic/684
>>>>>>>>>>>
>>>>>>>>>>> Both of these look like problems with setuid/setgid stripping,
>>>>>>>>>>> and still
>>>>>>>>>>> need to be investigated. I have more verbose result info on
>>>>>>>>>>> the test
>>>>>>>>>>> failures if anyone is interested.
>>>>>>>> Interesting that I'm not seeing the 683 & 684 failures. What type of
>>>>>>>> filesystem is your server exporting?
>>>>>>>>
>>>>>>> btrfs
>>>>>>>
>>>>>>> You are testing linux-next? I need to go back and confirm these
>>>>>>> results
>>>>>>> too.
>>>>>> IMO linux-next is quite important : we keep hitting bugs that
>>>>>> appear only after integration -- block and network changes in
>>>>>> other trees especially can impact the NFS drivers.
>>>>>>
>>>>> Indeed, I suspect this is probably something from the vfs tree (though
>>>>> we definitely need to confirm that). Today I'm testing:
>>>>>
>>>>>       6.5.0-rc6-next-20230817-g47762f086974
>>>>>
>>>> Nope, I was wrong. I ran a bisect and it landed here. I confirmed it by
>>>> turning off leases on the nfs server and the test started passing. I
>>>> probably won't have the cycles to chase this down further.
>>>>
>>>> The capture looks something like this:
>>>>
>>>> OPEN (get a write delegation
>>>> WRITE
>>>> CLOSE
>>>> SETATTR (mode 06666)
>>>>
>>>> ...then presumably a task on the client opens the file again, but the
>>>> setuid bits don't get stripped.
>>>>
>>>> I think either the client will need to strip these bits on a delegated
>>>> open, or we'll need to recall write delegations from the client when it
>>>> tries to do a SETATTR with a mode that could later end up needing to be
>>>> stripped on a subsequent open:
>>>>
>>>> 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b is the first bad commit
>>>> commit 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b
>>>> Author: Dai Ngo <dai.ngo@oracle.com>
>>>> Date:   Thu Jun 29 18:52:40 2023 -0700
>>>>
>>>>       NFSD: Enable write delegation support
>>> The SETATTR should cause the delegation to be recalled. However, I think
>>> there is an optimization on server that skips the recall if the SETATTR
>>> comes from the same client that has the delegation.
>> The optimization on the server was done by this commit:
>>
>> 28df3d1539de nfsd: clients don't need to break their own delegations
>>
>> Perhaps we should allow this optimization for read delegation only?
>>
>> Or should the NFS client be responsible for handling the SETATTR and
>> and local OPEN on the file that has write delegation granted?
>>
> I think that setuid/setgid files are really a special case.
>
> We already avoid giving out delegations on setuid/gid files. What we're
> not doing currently is revoking the write delegation if the holder tries
> to set a mode that involves a setuid/gid bit. If we add that, then that
> should close the hole, I think.

This approach seems reasonable, I'll work the patch to take care of this
condition.

Thanks Jeff,
-Dai

>
