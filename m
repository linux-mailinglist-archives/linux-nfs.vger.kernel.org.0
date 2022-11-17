Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E514362E23F
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiKQQuR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 11:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiKQQuQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 11:50:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89CD2611
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 08:50:15 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHGmVCG015942;
        Thu, 17 Nov 2022 16:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Z70NuD0TbhYEqUUWunWkCTjpLc3FLjKGdXV9TAOzco0=;
 b=CF8ZxTdFkhPKX798bE0+UrrXMgIv6GbrEP+r9LPcRj5SOxUvqlrRB9cTRSxMCfjjCd/W
 iw8aBrP92gpq31B1LOe1DZ4wvquwUjn+Uhbz3pjsS4PtMsFPo2224raZHij+aYD/Jh66
 9vUstFUo/J2DgGjTev4O9RtjUQsPLKnWk3yfhE8u/3wXzygPJida6ICi9UDcfPx/4FD9
 40Fnn1uPjWSjz9oeY7fsLLTHmgLYmBedHEous6K8NUu+H52prPDLnI4vQKXRucafb7ty
 b0hEJhGPKGTm4ITJH6ovnbiX6fQbx4bQ/CGNX8wFHLkCNrAqeuT578QwMuQMDNQ+ZL4Y Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kwrt6r047-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 16:50:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHFspcA034366;
        Thu, 17 Nov 2022 16:50:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kw2ddss6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 16:50:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2cCB83UzCNLb97fve+H/0T+olp4MY7Jl/z5R99BOyJcrXfah++vkdXv7v/eqJkZ9F5oWum/NleARhqbITecY2plBi6nklm/XN3KZQQh7vZUp1GGno0iXjf+UWqAFf7CLduTIxFeR19zKJ80Sx/UIetQqi1EZXnKNzxsKkpPsprPUG3NN40iyWhrIEeoE6DYLwsAevDcZo8NrbA7o0joLGtbmflnkjsHy1zj7LiOOC27x6waVqCQkItbj1SGZjqVRiS2x99+qcF0Ph750qnr0IWSUoJMeSkoyl2Uk6WI3HSiceFaTn35HC4UwgY2B2SW26kP03Ud1rq6YjXqupNi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z70NuD0TbhYEqUUWunWkCTjpLc3FLjKGdXV9TAOzco0=;
 b=BtM6OTiW13Icxi8+QkNFQeM6vnOBLeUAC0VFHBMkGN/Fet0xDkd+Aju5YjhjG2/pJooVE/DZmEsGu3Rp9vbGQKv8tcMcK1vp4OTUPSYBd23/Gtc41G+h/fU+8lxGIplsKehc+XxiFU1Y6fQm6WUAzRO96GRvUmtLomLFy4/Fw6VW9p59bed7m8bajd6Z2WjIjrEcxfr5T8B2+h4OeIPqLS/Kn4LV9lhcRkdd3cNXI2naPWXqZfJeHpCHq0pMdUJoXlYJy8LaUNYeXJAh2xr5Pu+9OjQyQzgARSIgLN6U2jwYy0afLfVVuTrQ25eayVNd0ZdybLvAQkxjV9HFTUerrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z70NuD0TbhYEqUUWunWkCTjpLc3FLjKGdXV9TAOzco0=;
 b=DpqJOCgBc4yqtp7186yPhoYBtBBg+Lwb4kO5tBcJEUEEHeDpMJ1OA8aW/sWENy7yidy9vZ6/zdtqgXXLjlL33BDgd3feu0Hz5VvySeXwNPWhuNQfZhNL3W2SYUg9IxfeW4DP9eGnfvaADpafSSnAsbxfL8C05eBUTV0ZAM7u5s0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH8PR10MB6314.namprd10.prod.outlook.com (2603:10b6:510:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 16:50:07 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242%8]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 16:50:07 +0000
Message-ID: <1374aef8-4342-9404-8352-9661bde74a70@oracle.com>
Date:   Thu, 17 Nov 2022 08:50:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v5 4/4] NFSD: add CB_RECALL_ANY tracepoints
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
 <1668656688-22507-5-git-send-email-dai.ngo@oracle.com>
 <D3D8A1E2-942A-4A5C-B938-160AD8DB25E8@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <D3D8A1E2-942A-4A5C-B938-160AD8DB25E8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH8PR10MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: abaf7870-4833-464f-3d90-08dac8bbc821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1+qLP84QN+RpAVvQMMHjAKs4LNnHX1v9NbxelcVjiVRwnFXNHPVoCwcms6ebl8f8Fr3VtsW/d+vjGeKN8gjdiqrMRsi3n0QSTsGlW0nrqvf400spIr3ytduES/uGZ3FpK1CoXqriZMYc/veRrZQqEmsXGjMZk+nb+iucGJYY+ftu61kpfi9/sSuwnjcHIrLUe2fzpjrwGDunX9PDJQ9RY+d0AShXLJ813KYVKA6G3+d4U8GS5/hlxNQuYfUAjbpgFKkKa/VaF6Rb6PMlGKgnM4YjXmuCEWpfHO23JzvreSiQQhtp5BKrAC//1Qp2Psl5ahlSB2yVsv89umHiEii8rJSNzWPsBLE1tTpI5WRc+Pb65FvIA+mjg35rVeKLzGaf38UFXAEgDsAr/O14kAChqWzdygqJIYCzUmE40hlzx1iO6pdiy+r3tYVWchXz+oZoIa9rSLSD96yTV5z2GtLTLaWTX16sH3fTpuN9nL0CPTh6cec/hbY/awz8HL/8LUvy0mmtTntUyOhj03u0rTciszFPCRi0c/ds+MuGJLjYURp3ulBmaKmGqMyfigaZ6thEUdarqdbyOdNpOzb/8t1G3HyPj+QWP9UEqzmmEam5fTD9MPG0iR6eE4SBQDpT+9Uy6ok9Ofu+N4TLjIsd1cdFInVZYEkumsLvkT94NNadlVpiQZd9Q9HTjyDwGX65IC0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(8676002)(66476007)(66556008)(66946007)(38100700002)(2906002)(36756003)(5660300002)(41300700001)(2616005)(4326008)(186003)(6862004)(478600001)(8936002)(6486002)(26005)(31686004)(31696002)(86362001)(54906003)(37006003)(316002)(53546011)(6506007)(6512007)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnI5N2wxZzdBMkJYYjBlTHIvaEVzTU5KKzhCcmdOQVhQS1hoc094SUFaUElq?=
 =?utf-8?B?Rk0za0FQUjBTVmhnRVVZQ002WStyaGdrZ3JnWTEvT3N0YU9lY3EyZmtDbkoy?=
 =?utf-8?B?UmJhYVR6bmRvR3QrS3pOaU94SnBkNEFsQzJDbFNCQXBXdFRFaHBWMjdEbWJl?=
 =?utf-8?B?UTJOWWpoR2dzZXpDRFVVSVllTitjbjZyeU1KL0taK1RJUWUxNGs0OHN0c0Nu?=
 =?utf-8?B?MEpxQlMrUmdIdHQxS0JUOGhLbTd1WGNveHVLZnBEVVRhSS9ZRHl6MWxaTEdl?=
 =?utf-8?B?aWptQ1lFUXJCWTMzK3hUOFBQWmNyVk10RmJHMHloYWxoWnV4d0JoYzhoLzI1?=
 =?utf-8?B?UVZRK0xDWStZcFVIZ09RUFdsWWtSL3FYTXpudnBJZ1J3MVBFbFYvVEJoKzdS?=
 =?utf-8?B?eDNDSmRBNFkxYXNkeG1iYU1uR3hUL0kycFJILzk2dG9rZnZDaGdZdHREcEN6?=
 =?utf-8?B?R2VRYXFuQm1saVRuQWZBUGdvM28xYnFMRS9qK3A2bXZpQlc3U0J1Tk05Vk9W?=
 =?utf-8?B?ZTMvZldLYTRKY3dwek1tcVpVMG1IcjFjWnhzM0Rsc09WODNnbDZ4VUZwWS90?=
 =?utf-8?B?QkI0alBXK1VSaklVRU5sSnFZRWpKSktaeFZ6bTFDejBJY0xnYkx5VzVjSVNR?=
 =?utf-8?B?MUp2TDM0aFdiZER0ZmxteXh3SFMra3k3bG9LcWhBekFkUC9aY2F3QXloSlli?=
 =?utf-8?B?bStHcURBYWdhYm1oWGdUT2lPbmVqbHBkZ1R5N21BUE1uK3UyM0kvcjhtczJR?=
 =?utf-8?B?ZFAzRHVGZnEyclhKZ3dxSWVLQ3FIVFQ3QzRhclkyYkNXMGcyYnpOOVNWS1Rw?=
 =?utf-8?B?KzNWd1pTL3ZZYmdLYnlmVFpYUGZwYXNHbHRZd3RGQm9vU0ZOZ1NBaWNDTVBO?=
 =?utf-8?B?NERzSnNidm02N1BtbFNqczFpYjFwdUZyU2g2ZkRnOVhZdTV2VkwvS1pqMnBX?=
 =?utf-8?B?NDFoOStXUTY3MzREYzFDdXVFS2pHTUdGeUsvZ2xDc0RUbnRMUzBWL0VONEI2?=
 =?utf-8?B?aC9Vd2pUOVNYZndPRGlqUklnSkJVOWhWb0J4Y2lZdm1SSFBmbjNSdFBTdE5D?=
 =?utf-8?B?ckw4MHQ0YUZpeGZiLzhaN1JlYW1WcnpXbDd4d2paUldjZ2R1TVIyQng2azh5?=
 =?utf-8?B?WmJGcVAyZkJTOHQ5VFhMWC9WNWpNZ1VCbXVudXFVOG1sRGxtdXBTRWF0cWpp?=
 =?utf-8?B?OUhrRXpGc2JxUlRtYWNCQVNCKzNoOXg0aUROZ3g2STJnbjNON3ZtYVpJY2xU?=
 =?utf-8?B?UjhqWTEwREJrb3l1UWI5U2h5RG9Xa2Z4MXVoUVRSY2RHcU93eFV5aEdNYmgx?=
 =?utf-8?B?RmVuUlc4cm1uTDVOb05jaVBwOTg1WE9RS3ZpUnlGdXhnTGtqVVFjenZhK1B6?=
 =?utf-8?B?NkU1dXRwb0MxdE1mWFBvZU5IbVdhTXRHdlBFcDFpM0FOQ0xWVlVuMTBYRVc3?=
 =?utf-8?B?d2FJaE00OGNHeFFXaGl3N21LeXZ6Ymo0SXAwUWJjSWJib2tPV3VPVVpUZzRF?=
 =?utf-8?B?VWoxQUpoYW8zM1c0MUpzR1lOSWhRMlhjcldCWXBNcTRNeDZ5V2dhSkFmNVpJ?=
 =?utf-8?B?RmlHaytrZTZqVGE4eGU1Z3ZLamt5a0tISzBtaWExZ2Y4Tkg3aXBKWi9NcXpa?=
 =?utf-8?B?V0FrL3k0MlByYko4dloxcUFwM1kxZEplSzUrL1VHT2ZvTGpaY2JQLzBpTGFu?=
 =?utf-8?B?Q1FnOW5YenhnWFNqQkpuZmlmSUxwekdzVVR3d3FuSGxiSldFUS9rcnhHYnpl?=
 =?utf-8?B?RFlveTJmMG1mSjUyYTBEdnhpRDB5Tk1yNEY2YWN5ZXhaNmI5bkFtZUtNZTYr?=
 =?utf-8?B?bDEyQldFM1lrbzUwK0pydGlXZmg4NE5xT1hxaktqTlE0OXFHVnpzSnhlMDMr?=
 =?utf-8?B?NkxlSWk0NVA0Y0lrQnI2OWdmS3h6a1FFMXAxcUZoZ2hOL1lzbTE3ZTl1Zy8w?=
 =?utf-8?B?WXJmK2I2bnVtT2RQZGlFYTNZV1d3UmF6b3ZOTGtjWkoxUk5PVFpXSlhyQTNx?=
 =?utf-8?B?MzdxZzdTaTFuQjlMWnNabGx0TTUzQWw3eGM1dHpZTjV2SnZMQmRtR2wzbXJR?=
 =?utf-8?B?N254bzh3djVPaDZsak1OQ2dhWFA0aXhRLytjZ3FnNmI0Q3QxMFJpanlNRmJz?=
 =?utf-8?Q?nIVDbSF7s95qH7IHjYDJp1FCS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: If7EPyk7uJ4S8ShdIfpnoIY8wSl3groJWmX1vXoys6ODhhpVq1OHSJvip2SY7zmQZr8kG4K2XXGhaGRWD+MelyDcX3dou6tk8dwFCAizvoEpYvXO7GDReeM28S2aav8uQL6CtjI8H4RkqrOd7SVJbE10u2FLKov/OEUc3SlOKWOs1JIRwK6Ej8dfSbnEwbIUibScdfO1CW91Voh8WFDNeU5sVwA9uVFhwdOawjZK+5CWJFcHu05HN8VEUngsMcjTkDD9cSvlxG49SS+XW7NvepVy3FeCylB/updlqkl2k6g/T4EQzb1rPd2UwC7sjICcjsXeHluw7rG15X2vJJKtZy03KaZ/3P1B3247b1n0dMbyuGNhRqY4kt7GO98tCM26vgFvFxBDAPAia2FVt3vf+BHMWT2wFKTOXAl7FbQ+9IMLfhAjCWG/JRkGTFsYQJf6WBrtsPdpSPhlYQ7Vm+zAgA+HW2tZp+MzdUqBFlfaPhf2R5dZmG9RwB9ELcjVSzpvhNB2avdJ5oupwFsPy4CfplFn+u4RaKjQ8X5ooq4ZNBLCULMXWIZXopgGnu3k14MEanOM3t2zTh4SgLqyEoGs8iMJcGmZIEnohSem+v85uMWyTxMIEZgczPc6/jT2erlH2SYZDylNUXouGLOrMw8UaiznsY1SeVXsZM6J2/kAPKrmOEjRSbXGC46b+WoTLZ5d3xwwMCBiBBPEMJwVnsVNU69uQwh1/IaKbjVRE5izLvEyuC3KKoggYcRCN8+za3aL11FGPWceV4NB9k6NF9H2CXkP0aExYDI9t2lFb+gqc6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abaf7870-4833-464f-3d90-08dac8bbc821
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 16:50:07.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdPgIkoRWYZXv6eaYb5atJaxCOkGu7/zigyRh3LSGSSroO+HxBDLLJkM7IcYsu4QeHvavAVSAXEJLrwAvVjtwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170124
X-Proofpoint-ORIG-GUID: r7a3Sn2WOBHTzjIW9p7qo71l0kxDYxa7
X-Proofpoint-GUID: r7a3Sn2WOBHTzjIW9p7qo71l0kxDYxa7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/17/22 6:45 AM, Chuck Lever III wrote:
>
>> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Add tracepoints to trace start and end of CB_RECALL_ANY operation.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |  2 ++
>> fs/nfsd/trace.h     | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 51 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 13f326ae928c..935d669e2526 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2859,6 +2859,7 @@ static int
>> nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>> 				struct rpc_task *task)
>> {
>> +	trace_nfsd_cb_recall_any_done(cb, task);
>> 	switch (task->tk_status) {
>> 	case -NFS4ERR_DELAY:
>> 		rpc_delay(task, 2 * HZ);
>> @@ -6209,6 +6210,7 @@ deleg_reaper(struct nfsd_net *nn)
>> 		clp->cl_ra->ra_keep = 0;
>> 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>> 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>> +		trace_nfsd_cb_recall_any(clp->cl_ra);
>> 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
>> 	}
>> }
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 06a96e955bd0..bee951c335f1 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -9,9 +9,11 @@
>> #define _NFSD_TRACE_H
>>
>> #include <linux/tracepoint.h>
>> +#include <linux/sunrpc/xprt.h>
>>
>> #include "export.h"
>> #include "nfsfh.h"
>> +#include "xdr4.h"
>>
>> #define NFSD_TRACE_PROC_RES_FIELDS \
>> 		__field(unsigned int, netns_ino) \
>> @@ -1471,6 +1473,53 @@ TRACE_EVENT(nfsd_cb_offload,
>> 		__entry->fh_hash, __entry->count, __entry->status)
>> );
>>
>> +TRACE_EVENT(nfsd_cb_recall_any,
>> +	TP_PROTO(
>> +		const struct nfsd4_cb_recall_any *ra
>> +	),
>> +	TP_ARGS(ra),
>> +	TP_STRUCT__entry(
>> +		__field(u32, cl_boot)
>> +		__field(u32, cl_id)
>> +		__field(u32, ra_keep)
>> +		__field(u32, ra_bmval)
>> +		__sockaddr(addr, sizeof(struct sockaddr_storage))
>> +	),
>> +	TP_fast_assign(
>> +		__entry->cl_boot = ra->ra_cb.cb_clp->cl_clientid.cl_boot;
>> +		__entry->cl_id = ra->ra_cb.cb_clp->cl_clientid.cl_id;
>> +		__entry->ra_keep = ra->ra_keep;
>> +		__entry->ra_bmval = ra->ra_bmval[0];
>> +		__assign_sockaddr(addr, &ra->ra_cb.cb_clp->cl_addr,
>> +				  sizeof(struct sockaddr_storage))
>> +	),
>> +	TP_printk("Client %08x:%08x addr=%pISpc ra_keep=%d ra_bmval=0x%x",
>> +		__entry->cl_boot, __entry->cl_id,
>> +		__get_sockaddr(addr), __entry->ra_keep, __entry->ra_bmval
> This needs a "show_recall_any_bitmap" to convert to human-readable
> symbols.

Yes, it makes sense.

Thanks,
-Dai

>
>
>> +	)
>> +);
>> +
>> +TRACE_EVENT(nfsd_cb_recall_any_done,
>> +	TP_PROTO(
>> +		const struct nfsd4_callback *cb,
>> +		const struct rpc_task *task
>> +	),
>> +	TP_ARGS(cb, task),
>> +	TP_STRUCT__entry(
>> +		__field(u32, cl_boot)
>> +		__field(u32, cl_id)
>> +		__field(int, status)
>> +	),
>> +	TP_fast_assign(
>> +		__entry->status = task->tk_status;
>> +		__entry->cl_boot = cb->cb_clp->cl_clientid.cl_boot;
>> +		__entry->cl_id = cb->cb_clp->cl_clientid.cl_id;
>> +	),
>> +	TP_printk("client %08x:%08x status=%d",
>> +		__entry->cl_boot, __entry->cl_id, __entry->status
>> +	)
>> +);
>> +
>> DECLARE_EVENT_CLASS(nfsd_cb_done_class,
>> 	TP_PROTO(
>> 		const stateid_t *stp,
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
