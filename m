Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642A57A2568
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 20:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjIOSOl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 14:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjIOSOe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 14:14:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0051FCC
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 11:14:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FHOBKl021747;
        Fri, 15 Sep 2023 18:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=k1cOEksn48a5E4Wq9UpYV+diaZDG5O8Q6x1R3bn7I0A=;
 b=iugqIvhOwt0Y3d3BK9+eJ02O1Xw1p75wD1BkVc2EGocciHyK0d7MTKaaWHj3DHZK2NbN
 yL0/gBRA0QjeFR863o1D4tHbeMMkg0wR2PAxIFJ/CgERBkolKpf0zQrUTQZCWMlIlu3d
 7hu1nfnn9W3yy1XWxqOJkqbuck9sfrsMC7PZNPBgVjPAbtu9PYEDRlHmT236t2iHnSQG
 opDGzCpoqAn4Y9qnhltXXpC13D7mpsiYvOsm3+9NKcg0XLBm47fywDavcpYYLqILzPuQ
 ZQ7dXt78uMVXUfMVXFzm0wS3IukC3jejmpKi4Ebefytv/9zzKqvmsUXaE891BV2/4C83 kA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kr8v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 18:14:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FHxkiU008893;
        Fri, 15 Sep 2023 18:14:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5anx0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 18:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K76zs90y314Sia0VaKfnZ3yGxNZiYhqWpt3hAo6VaISCOFk6cnYXjUiDxrkz6UPufZWFBf9vzIFeTtFefqibVlIGCG+edJRsk+f6FxPjvOH0E1fsKP4huVc+37EpC6QcA1/8y10STLYiNLLgNoIzaD1aJlfkSXuYftTvno7Ns8mBFG3wsM174VZHFTNKZ/hMSvoQF2gV5ivbhTzd+IEn4newOAPStl9DWtSDFZLrgyXJPXtBGZMQK1V61FB7iezBhWXRbVFxzWcpE/9Kw7tmEPYAaCrjPJwPDt1HAD/Z7wKCUZ/Ejq7VHnQYAebgQWdS9kIWThdC8TrxPSZ1jSsunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1cOEksn48a5E4Wq9UpYV+diaZDG5O8Q6x1R3bn7I0A=;
 b=n4SGxsk+QQKIjfGs0OYrQrgICAaO/Aj+jhJvZ0W/ytek7lAo75S2cjrM0PlYi+Ug+V74njbuJAMuiOKnRUYsZsWCATkLrdnBqmFgSQF2wdxPD8YO0DfYCa2z2T1XMSs2wlTZ6LXQWn4TgcOJA8R2KuRkfwODLAQzDttakeV5jfmqzILZVRH+CkCSVTQPcGOoNz1POv1+v0oQJFTH2toGYiYY7LI2c0MF62wTxJvpvBXeYTdcEKkGhsmQMBhI+lMk2IMSaWzaUvBerPle8exxJksRsnl5CW81SP3c4wd/LefCjvPgcmxBtJopuDe/8dcjEX5w1nV/RKvoHloe+/5oFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1cOEksn48a5E4Wq9UpYV+diaZDG5O8Q6x1R3bn7I0A=;
 b=tBgNUeL3EyEIc+I4Dp683RNrNMYtE2hCl9rekKgmWuQCUdpDcetKrjL31t6esj9fWS7l74l81yYXTueylDtTWySIGqXzZ9pFFlsTEGNUHQ0BgXw9M1FgyTUQilcxhe/bb1XELjEE5gys73fZpoP8HA8R8P6a3HOTRjPfwXqSuPI=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 18:14:21 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::1ae9:73e8:fe48:3fcf]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::1ae9:73e8:fe48:3fcf%6]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 18:14:21 +0000
Message-ID: <c454cf31-aca3-4bc0-9591-a0b588006485@oracle.com>
Date:   Fri, 15 Sep 2023 19:14:15 +0100
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] Stop using deprecated thread.setDaemon
Content-Language: en-GB
To:     Alexander Zeijlon <alexander.zeijlon@cendio.se>,
        bfields@fieldses.org
References: <20230913104636.2554987-1-alexander.zeijlon@cendio.se>
 <55645fe5-a81f-487a-9694-785b6a1187d1@oracle.com>
 <95c31a30-1fc8-6dfa-c16a-c68062900fd9@cendio.se>
From:   Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <95c31a30-1fc8-6dfa-c16a-c68062900fd9@cendio.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IM1Gl0506RoYhJWD6DwRXXtJ"
X-ClientProxiedBy: AM8P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::32) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|DM6PR10MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a84794e-1f8d-4dc7-ae05-08dbb6179568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fajJch+HjDzQ2K9Ja7rmELbnB6nebFoeQqQjTfcwxClLWPIazafSpAPjim2c0A50M4lL3Xx4hwFOyQb6Jqvn2OeKXUtWDSfR/iV4xR6YFtM8lG117r+83U/2zCzoM1e6yrAcmiOPCK8xsNfewGvNy+5XWES8D6xXZAtx6/qxeHIac1wBsArt9R3W9aIz1uezky4d0Uhu9DzO6KNARE+Ui5UBLrPKHTXGCRaBTL4GoYF917xPG2lv64Mgdc+vFHcXcYkEqhU8E6hGBkEYDoytkvOQ/vvDQFs94BVGMQUZ9jkkcPTWoF35XGvX5h1KOC0bUAqpl9yxT83xhocT+oGi8zbhVyNjkYT/N6EqOtV4T2q9OTuf/5Pu+R1UfPnpzjaA3kVQgzSdebVB4tpBYL1s2pw770Z39M6CSbgaBwPsG/YPI1xNTL8J8T3NobjE1VC7OCpvju4UTNcL0AGIhwKeu96hC0YTs+uFtcmTE3qMGzZ3NftRVKg2LEY988/sSdFhb73yrtj9pm6V2WBRHL0Cqggq30OoynyUA4VRe8iA4s6Dtvi93wlPBYScUeyDnLd9MV+95zYU9Vru76g2kpFGEk6YIu1sfyLSxCwUBKGL7p4GbJjAnmqOpimD1X4Yz0YDjtzWB8eTCIgv8QMwS6eGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(186009)(451199024)(1800799009)(478600001)(2906002)(41300700001)(235185007)(33964004)(6506007)(83380400001)(316002)(44832011)(5660300002)(6666004)(66946007)(4326008)(66476007)(66556008)(31686004)(8936002)(8676002)(36916002)(53546011)(6486002)(6512007)(31696002)(26005)(21480400003)(2616005)(38100700002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnNqWk1LVkc2Z2dWZDhWV3JBTnNtTDU3ZXBJMHFjaUQxQnVhQjIwT3ZsZGVx?=
 =?utf-8?B?QUNhYmVuSGVuSzRRSFgwRi82Z09TSW9LcitxL3pQbjBpZXdkSkVYRndqVWVo?=
 =?utf-8?B?WFJ0MHplcnJuYjJaaWlYRXQwMWg1Z0tHSnVJSHRETExTN3M5ZjE4M1NBUzZK?=
 =?utf-8?B?VXNST0FXUUJrTkR4RGQ4b3g0cStQN0lBOHVJL3dMWWYzSVc4TlNBVGlRRDJS?=
 =?utf-8?B?ZzBFbnFwSHdmZTJTQlM3T0hOVHhRcGg1aDVuT2ZDWEo4UnViSzdBUXBoMEJF?=
 =?utf-8?B?d05YYUZ0VCtEUXZrNkw0RUxwbGFPZkUzMmU3NUxkeE5Ed3doSXhaOWp6NTF1?=
 =?utf-8?B?blVhZXZvM096MUxhbmtacEN3ZERJRldKN3EzMHNNNWVTQkNIVUc2aFcvUFN2?=
 =?utf-8?B?L3o0S29BR2VjM1BWR1ZOM09la3pPRjY5QmpWa296d0cwZFVDZEs4YTV1V3lY?=
 =?utf-8?B?Q1pQMUFuN3FyckNXdnVJQXBjYW10TlVDWElzQ0VMQ3hhM1hmWSs0SVVrenIw?=
 =?utf-8?B?cUZxVHZLWVlVWDBoTzgxc0plTktvYzNvUjNqN3IrQTRLTWZWcUdjN0dON3p2?=
 =?utf-8?B?TnNTcEVFdlFKamU5TlhPWWN0Z3lOOWFtNHQ2SUpYbWplYm11QUdSNEtoT2Zv?=
 =?utf-8?B?UUN5c1B5anlSRG9MWm44RFg4UHg5NEVkMk1JRFdCMXdpOUZsTWhjZHR3eEUv?=
 =?utf-8?B?NUtyQS92SzRZeUVmV010V3o3SC9abFk5akFYTzVPTGFPUlo4QVpjL1d0ZENK?=
 =?utf-8?B?R2FMVE5LTVNLQVZYRUZSVk9YQXN6NGJOUy9XbVA3L2hxdElYQzdDa0k5aFpV?=
 =?utf-8?B?Z3pja0dMa0k5Z1l2eFQwUi9ZUUJteXZibEhha2lwamRrOG9zMGhvMkFvMkNZ?=
 =?utf-8?B?RG5HUGNnYmgvNjRUc0tMckl2K3ArL3pZcSszcWl2TDZxSUViUW85RnFTZHVr?=
 =?utf-8?B?NGFtNVBQODVRQVd2TE9aWFhXNHEwcHkwNXcxUjZlVUJyMVMvOUd2VU80UUxP?=
 =?utf-8?B?RGk0QUN3TlZYUFAyOHpHajFJdEVsRzN1VjZyYlRGYXZNeU1NTVIxZUlDeVBP?=
 =?utf-8?B?Y0hsQ2w2N0o2NnBFbi93dnJUODMzQlRkdEFjSGFKUktjVHQwRVFmdHlFTHc1?=
 =?utf-8?B?UXhoZDA2RGVZbFVwMGF6anNaWmxGMkowYXpIdS9RS3RNTWc2aTdwcmdHSWxI?=
 =?utf-8?B?cFFOeFdGUEJaVzhQMmlpMXRiVmttaWdsNmoxbDYzYitwUTdKdmlkeFBFa0NR?=
 =?utf-8?B?TUVtMkFPYzI5VzVEdlhhT1JDMURaVVpsOEJJV29KMHZUWHpnWldqa1QyN1dK?=
 =?utf-8?B?TlkyV2xuT0pOa3F3aThSTFJkZitjRzNtTWNiRi9ZMzgvOFlXSm5Zd2IzL25V?=
 =?utf-8?B?MytwcDVUQ1JaVEZHdVI2QlJxYU1pb2ZyNFNqN2hxVE41UVdpSlB5RzlxclhQ?=
 =?utf-8?B?VHN6R1cyZFA3TUVxSWtLbDZwdjljcG1XcGRRL3piQlVxNGpqLzhxSUd0TVRY?=
 =?utf-8?B?VDhHWWJBVFNNOEQ4UjgxQitsZitQQWRNTFk4NlBBSzJGOWdMY2p4SFNTclN5?=
 =?utf-8?B?a0gwKzhtYkh4Ny9DRWtHMXdDM0Y3WVY1WmR0MGZtVFZKWXVlTElDYy9VN0FD?=
 =?utf-8?B?NXhXNnI2VVdWRE01MXc2RWpkU0RlS2VMeFgyalYvcGtVTkl3dTZNKzluMlgr?=
 =?utf-8?B?WjBONnNtL0w5dmg3Qzc0VXhINWJEME5yNTB6c0d4SE4yYU1TMG50QmJjMEZU?=
 =?utf-8?B?VHh4WDUxbzdqTUo1UWJsSTI1TkxoYVFGNmRqSlVndVE5c1VBc01ZTmZwaS9B?=
 =?utf-8?B?b21RY01uRnBYeDRscTJ4NnJROFZxYjlHMjBZSjI3VDI4dmpwajQrVWRKelNW?=
 =?utf-8?B?MDg5NkMzR2p6aW1qeUpwNGhyNWMrTVB5UFkrMmxVTGhtbkZFVnY4ZWJLamZH?=
 =?utf-8?B?azY1UUpsUnhva28wNW1ZL1ErdVROc1NUd0J6dnhZOGkrMEg3eGVIaVhKSWp0?=
 =?utf-8?B?U2tZbEJvdFVHbHhheEpyNWZwSGlsZjJFR085SmVoZy9iTTc3VnJZTk1CYVVM?=
 =?utf-8?B?QnFlcUduTnMwTDdoVWZ1bGZRVFFkYXM1MVIwMFBCVWVhMW9xODZGVm5GcWFn?=
 =?utf-8?B?a05GTlZVNGxmc2o0cXFrMGs5WW1BRmIzWFZlZjJaLzZyc1ZnRE1OaWlsZjdP?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k4l/PcyBBeRoCt9BmLk4nv0111md/9YgH14c/uBS/CSrwOfUYlZaWxxL+1Ccj2pOMwCorjwe5Ayfab+L++5pVrRx/EyybQdhWqxSzUjCc8qmesoxmUzxXM+DJgqZinh8Ib8IJJN62FCqTilnZ41734I0GOcKDXcCGzREXFfKpRp8HKXrBnc8PfmNFOQQ/3TLaI+R2ReOy13+Y1OfYgLADqVSAMp/oMfiPx1G1RDbqJbm6d9uxLMaaEJsWygmaMoSLqc8gPZu9SQdqblq1wUcxCFCLS0bs+FwQfk/dlI2nc4INWJitpXl16Tjmh64D13WL2q68NkJ4DTUauiXk+4gqGi6FqwN2x/wcyvUoh+XL48hN74e4BBKret3REsGXzv2HLA6m0HtYQnSu4dqR05J2hHZfBx8VTPoZzAWxIxzyAmDKxPhOFdcF2mxuh9mn/b2qVvnrqKhYaV17KjUAwmVBq3C4cCetvjZMIKN/5HnI8aPZFIzaKSo9B2OUd0/4iKd44Gn4a1W1o7Q3QN9ihC3qJZLjQpN1qFL3JeCS7UY0KgHR0WOAi114cTi6SRTXTMqwHHCz9QAzyflnrZRaZ5ew/s4oXp2GF7J4qT7WtDYJE9g8Hzzv5eVOuqacMm9wGyY+nYGjUU+d/u06nlbTCEMoECkOVfMaAauu76K1UtOAfLk93F1PjryDaplNxQF16TxmZ4TsNWZ2O41JWhTH+r8r0+rAPKq6aAcxHTAKYb+4cha3yur6cgfEEPYkIU5W2zApO6AKOQDEfmi0HoJc4fzxgezHWkmviVtZBXCkCAPi+pW6BdOV4gU3B9JbGObzske
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a84794e-1f8d-4dc7-ae05-08dbb6179568
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:14:21.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGKDoYJS7WYRuYsVDEwNXPgv8fOcJvzxY3AqeVHED1zmSzOl+9BoJopn+vWF4Aio1IXYk1gZqqxSTPxU2HrRgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_14,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150164
X-Proofpoint-GUID: 2ztK2dh0SXX12gmJI653kdy6TeWXMZfV
X-Proofpoint-ORIG-GUID: 2ztK2dh0SXX12gmJI653kdy6TeWXMZfV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------IM1Gl0506RoYhJWD6DwRXXtJ
Content-Type: multipart/mixed; boundary="------------D60e7pQeFRgOBJpk5JwBVXBr";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Alexander Zeijlon <alexander.zeijlon@cendio.se>, bfields@fieldses.org
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Message-ID: <c454cf31-aca3-4bc0-9591-a0b588006485@oracle.com>
Subject: Re: [PATCH] Stop using deprecated thread.setDaemon
References: <20230913104636.2554987-1-alexander.zeijlon@cendio.se>
 <55645fe5-a81f-487a-9694-785b6a1187d1@oracle.com>
 <95c31a30-1fc8-6dfa-c16a-c68062900fd9@cendio.se>
In-Reply-To: <95c31a30-1fc8-6dfa-c16a-c68062900fd9@cendio.se>

--------------D60e7pQeFRgOBJpk5JwBVXBr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUvMDkvMjAyMyAxMjozNiBwbSwgQWxleGFuZGVyIFplaWpsb24gd3JvdGU6DQo+IEhp
IGFnYWluLA0KPiANCj4gSSd2ZSBmaXhlZCBhIGNvdXBsZSBtb3JlIGRlcHJlY2F0aW9uIHdh
cm5pbmdzLiBTZWUgYXR0YWNoZWQgcGF0Y2guDQo+IA0KPiBCUiwNCj4gQWxleA0KDQp0aGFu
a3MgYWdhaW4gQWxleC4NCg0KY2hlZXJzLA0KY2FsdW0uDQoNCg0KPiANCj4gT24gOS8xMy8y
MyAxODozMiwgQ2FsdW0gTWFja2F5IHdyb3RlOg0KPj4gT24gMTMvMDkvMjAyMyAxMTo0NiBh
bSwgQWxleGFuZGVyIFplaWpsb24gd3JvdGU6DQo+Pj4gVGhlIHRocmVhZC5zZXREYWVtb24g
bWV0aG9kIGlzIGRlcHJlY2F0ZWQgc2luY2UgUHl0aG9uIHZlcnNpb24gMy4xMCwgdGhlDQo+
Pj4gZGFlbW9uIHByb3BlcnR5IHNob3VsZCBub3cgYmUgc2V0IGRpcmVjdGx5Lg0KPj4NCj4+
IFRoYW5rcyBBbGV4YW5kZXIsIEknbGwgYWRkIHRoaXMgdG8gbXkgbGlzdC4NCj4+DQo+PiBj
aGVlcnMsDQo+PiBjYWx1bS4NCj4+DQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5k
ZXIgWmVpamxvbiA8YWxleGFuZGVyLnplaWpsb25AY2VuZGlvLnNlPg0KPj4+IC0tLQ0KPj4+
IMKgIG5mczQuMC9uZnM0bGliLnB5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMiArLQ0KPj4+IMKgIG5mczQuMC9zZXJ2ZXJ0ZXN0cy9zdF9kZWxlZ2F0aW9uLnB5
IHwgNCArKy0tDQo+Pj4gwqAgbmZzNC4xL25mczRzdGF0ZS5wecKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPj4+IMKgIHJwYy9ycGMucHnCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKystLQ0KPj4+IMKg
IDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL25mczQuMC9uZnM0bGliLnB5IGIvbmZzNC4wL25mczRsaWIu
cHkNCj4+PiBpbmRleCA5YjA3NGYwLi45YTcyZWM5IDEwMDY0NA0KPj4+IC0tLSBhL25mczQu
MC9uZnM0bGliLnB5DQo+Pj4gKysrIGIvbmZzNC4wL25mczRsaWIucHkNCj4+PiBAQCAtMjk3
LDcgKzI5Nyw3IEBAIGNsYXNzIE5GUzRDbGllbnQocnBjLlJQQ0NsaWVudCk6DQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgICMgU3RhcnQgdXAgY2FsbGJhY2sgc2VydmVyIGFzc29jaWF0ZWQg
d2l0aCB0aGlzIGNsaWVudA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmNiX3NlcnZl
ciA9IENCU2VydmVyKHNlbGYpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYudGhyZWFk
ID0gdGhyZWFkaW5nLlRocmVhZCh0YXJnZXQ9c2VsZi5jYl9zZXJ2ZXIucnVuLCANCj4+PiBu
YW1lPW5hbWUpDQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHNlbGYudGhyZWFkLnNldERhZW1vbihU
cnVlKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLnRocmVhZC5kYWVtb24gPSBUcnVlDQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYudGhyZWFkLnN0YXJ0KCkNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgIyBFc3RhYmxpc2ggY2FsbGJhY2sgY29udHJvbCBzb2NrZXQNCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5jYl9jb250cm9sID0gc29ja2V0LnNvY2tldChzb2Nr
ZXQuQUZfSU5FVCwgDQo+Pj4gc29ja2V0LlNPQ0tfU1RSRUFNKQ0KPj4+IGRpZmYgLS1naXQg
YS9uZnM0LjAvc2VydmVydGVzdHMvc3RfZGVsZWdhdGlvbi5weSBiL25mczQuMC8gDQo+Pj4g
c2VydmVydGVzdHMvc3RfZGVsZWdhdGlvbi5weQ0KPj4+IGluZGV4IGJhNDljZjkuLmJjYzc2
OGEgMTAwNjQ0DQo+Pj4gLS0tIGEvbmZzNC4wL3NlcnZlcnRlc3RzL3N0X2RlbGVnYXRpb24u
cHkNCj4+PiArKysgYi9uZnM0LjAvc2VydmVydGVzdHMvc3RfZGVsZWdhdGlvbi5weQ0KPj4+
IEBAIC00MCw3ICs0MCw3IEBAIGRlZiBfcmVjYWxsKGMsIHRoaXNvcCwgY2JpZCk6DQo+Pj4g
wqDCoMKgwqDCoCBpZiByZXMgaXMgbm90IE5vbmUgYW5kIHJlcy5zdGF0dXMgIT0gTkZTNF9P
SzoNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdF9lcnJvciA9IF9oYW5kbGVfZXJyb3IoYywg
cmVzLCBvcHMpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHQgPSB0aHJlYWRpbmcuVGhyZWFk
KHRhcmdldD10X2Vycm9yLnJ1bikNCj4+PiAtwqDCoMKgwqDCoMKgwqAgdC5zZXREYWVtb24o
MSkNCj4+PiArwqDCoMKgwqDCoMKgwqAgdC5kYWVtb24gPSBUcnVlDQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHQuc3RhcnQoKQ0KPj4+IMKgwqDCoMKgwqAgcmV0dXJuIHJlcw0KPj4+IMKg
IEBAIC00MDksNyArNDA5LDcgQEAgZGVmIHRlc3RDaGFuZ2VEZWxlZyh0LCBlbnYsIGZ1bmN0
PV9yZWNhbGwpOg0KPj4+IMKgwqDCoMKgwqAgbmV3X3NlcnZlciA9IENCU2VydmVyKGMpDQo+
Pj4gwqDCoMKgwqDCoCBuZXdfc2VydmVyLnNldF9jYl9yZWNhbGwoYy5jYmlkLCBmdW5jdCwg
TkZTNF9PSyk7DQo+Pj4gwqDCoMKgwqDCoCBjYl90aHJlYWQgPSB0aHJlYWRpbmcuVGhyZWFk
KHRhcmdldD1uZXdfc2VydmVyLnJ1bikNCj4+PiAtwqDCoMKgIGNiX3RocmVhZC5zZXREYWVt
b24oMSkNCj4+PiArwqDCoMKgIGNiX3RocmVhZC5kYWVtb24gPSBUcnVlDQo+Pj4gwqDCoMKg
wqDCoCBjYl90aHJlYWQuc3RhcnQoKQ0KPj4+IMKgwqDCoMKgwqAgYy5jYl9zZXJ2ZXIgPSBu
ZXdfc2VydmVyDQo+Pj4gwqDCoMKgwqDCoCBlbnYuc2xlZXAoMykNCj4+PiBkaWZmIC0tZ2l0
IGEvbmZzNC4xL25mczRzdGF0ZS5weSBiL25mczQuMS9uZnM0c3RhdGUucHkNCj4+PiBpbmRl
eCBlNTdiOTBhLi42YjRjYzgxIDEwMDY0NA0KPj4+IC0tLSBhL25mczQuMS9uZnM0c3RhdGUu
cHkNCj4+PiArKysgYi9uZnM0LjEvbmZzNHN0YXRlLnB5DQo+Pj4gQEAgLTMwOCw3ICszMDgs
NyBAQCBjbGFzcyBEZWxlZ1N0YXRlKEZpbGVTdGF0ZVR5cGVkKToNCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGUuc3RhdHVzID0gQ0JfSU5JVA0KPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdCA9IHRocmVhZGluZy5UaHJlYWQodGFy
Z2V0PWUuaW5pdGlhdGVfcmVjYWxsLA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJn
cz0oZGlzcGF0Y2hlciwpKQ0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dC5zZXREYWVtb24oVHJ1ZSkNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHQuZGFlbW9uID0gVHJ1ZQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdC5zdGFydCgpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgICMgV2UgbmVlZCB0byByZWxl
YXNlIHRoZSBsb2NrIHNvIHRoYXQgZGVsZWdhdGlvbnMgY2FuIGJlIA0KPj4+IHJlY2FsbGVk
LA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAjIHdoaWNoIGNhbiBpbnZvbHZlIG9wZXJhdGlv
bnMgbGlrZSBXUklURSwgTE9DSywgT1BFTiwgZXRjLA0KPj4+IGRpZmYgLS1naXQgYS9ycGMv
cnBjLnB5IGIvcnBjL3JwYy5weQ0KPj4+IGluZGV4IDFmZTI4NWEuLjM2MjFjOGUgMTAwNjQ0
DQo+Pj4gLS0tIGEvcnBjL3JwYy5weQ0KPj4+ICsrKyBiL3JwYy9ycGMucHkNCj4+PiBAQCAt
NTk4LDcgKzU5OCw3IEBAIGNsYXNzIENvbm5lY3Rpb25IYW5kbGVyKG9iamVjdCk6DQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9nX3AubG9nKDUsICJSZWNlaXZlZCByZWNv
cmQgZnJvbSAlaSIgJSBmZCkNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2df
cC5sb2coMiwgcmVwcihyKSkNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0ID0g
dGhyZWFkaW5nLlRocmVhZCh0YXJnZXQ9c2VsZi5fZXZlbnRfcnBjX3JlY29yZCwgDQo+Pj4g
YXJncz0ociwgcykpDQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdC5zZXREYWVtb24o
VHJ1ZSkNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0LmRhZW1vbiA9IFRydWUNCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0LnN0YXJ0KCkNCj4+PiDCoCDCoMKgwqDC
oMKgIGRlZiBfZXZlbnRfcnBjX3JlY29yZChzZWxmLCByZWNvcmQsIHBpcGUpOg0KPj4+IEBA
IC05MzUsNyArOTM1LDcgQEAgY2xhc3MgQ2xpZW50KENvbm5lY3Rpb25IYW5kbGVyKToNCj4+
PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgIyBTdGFydCBwb2xsaW5nDQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHQgPSB0aHJlYWRpbmcuVGhyZWFkKHRhcmdldD1zZWxmLnN0YXJ0LCBuYW1l
PSJQb2xsaW5nVGhyZWFkIikNCj4+PiAtwqDCoMKgwqDCoMKgwqAgdC5zZXREYWVtb24oVHJ1
ZSkNCj4+PiArwqDCoMKgwqDCoMKgwqAgdC5kYWVtb24gPSBUcnVlDQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHQuc3RhcnQoKQ0KPj4+IMKgIMKgwqDCoMKgwqAgZGVmIHNlbmRfY2FsbChz
ZWxmLCBwaXBlLCBwcm9jZWR1cmUsIGRhdGE9YicnLCBjcmVkaW5mbz1Ob25lLA0KPj4NCg0K
LS0gDQpDYWx1bSBNYWNrYXkNCkxpbnV4IEtlcm5lbCBFbmdpbmVlcmluZw0KT3JhY2xlIExp
bnV4IGFuZCBWaXJ0dWFsaXNhdGlvbg0KDQoNCg==

--------------D60e7pQeFRgOBJpk5JwBVXBr--

--------------IM1Gl0506RoYhJWD6DwRXXtJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmUEnvcFAwAAAAAACgkQhSPvAG3BU+K8
PA//cKrqTWw5yTZ2C+LZb09bIMV4Km/OQ0BJZ9KcGLr31Kx2AK6Tp/flOuM8RjHlKsf23kTcngfi
yTAJ+MhLWkLY61U1MUj+NQrXOZHXc0W8v/fB+H9ZyydNetmzw0NlBjuKx9e1sLMcrla4V82V6Ly+
1H8MYEIVFkuTsdk2H7pY+LvDp7fUNfZa5yQ3JEP2KaM1h+0+Lr6J2uj///Grko9foRuHgQiCceds
tKdddpy7uK/7L+rDUq7wLxG340THLOjRSlwC89aSevEq7lGKmthAiBJSYrzmD1CVsFM6/+Oql63B
kz2X1vgolir/lzqera06vxLhLVx2sGPpEpd3dhWABbLuqou+fRrF0pwzg7B96Wu3Qez0r3Bn2F/H
c+SibgAGPNwxk7ALP2SmKiyeQX/j19J5eMoiOR5EzOl+bhFBmhiUFJKBdE2KQKgoY+pFixsRax5/
sAj+TzxpOWqG45q3yYLesgSRW6BM9XNK5poWB3qyqJeQ7jXbD4B7OllYcT5VMkcoiNe97/VBYX+I
9+/Zk9W2cX24wkrD6736TFITJJCRllMj03Wd6B82Qxt20ViErGm1lHH9dEnlufjkuasBBXqitvTR
QajuQ29weluqhNEofqUYgkGIE+e1qJzjeV/aPF+447tF8oU5WNlY/CV0CjYk8SVgEohU02/g1Bdd
X/E=
=qKYF
-----END PGP SIGNATURE-----

--------------IM1Gl0506RoYhJWD6DwRXXtJ--
