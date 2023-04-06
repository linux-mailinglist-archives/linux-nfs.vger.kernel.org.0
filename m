Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6C6DA43A
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 22:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbjDFU7W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 16:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbjDFU7D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 16:59:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766DDAD18
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 13:58:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336Etf82013953;
        Thu, 6 Apr 2023 20:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aZ+87DbJvnQE3hI1cBUEme8XBYz4VNEHy+Kle9tX9PU=;
 b=OJ4HY0nga+Y5IhM6lJ35VBb5gnS5R/uYr9K927eHG9rvrp+42Znar8DHxdQE5dJIE9Ep
 1THzrAmL6pwVxdX7SLDL6x+TGmAtPHPXWXIOQcBJr+u1KRhhIdQxH98QePi/UtmAE22A
 aKvDCoz5cpOY9ErUwYHgzsbhwloEeKT15J98ApIXeKVUxBxvC2aEtfscd681BfgM/HX6
 wLnVbSNlsO1XIek9Li33OYD7BG4vqfHoCLE/MMXJEkYr+8FO7MxeZjolSV7XkhJefuPn
 uTyIoRdl0ES8zzLjdshuYkfKuq14lubD6xBPgI6uRP/f/lozarp6aNeyKa97AgDP2cyk Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd43wtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 20:58:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336KteMQ036583;
        Thu, 6 Apr 2023 20:58:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3mu0fp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 20:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5KwBHN7hhl1egRhE6uUZOfLR0AIgtXgoKSCCxauAaHhBl09KcEJGuzt59cQonjD1ineHNj+9mixIRxGQfKDJUcHT45sPDL0hllZE9mZJysTJTq/gmTZaW8RuclKIoa38zYt0QvgJRszs4tFWpgWnnFQwFRZWHyIzoun6zSwwGvA3g0j+sI4sP5gGYzpeYf+CLQzUEKHCqIL/JwrlbMtTPvAgwguSxKGM3wCUrnDN8AuiWUdXDePeVhTlJQ1hTH+aWDw635kp8MWwNpyrhevGjMNrUnj1QACURHhJr/GSfqS/ax74t9MZN2ChJvlf53qYXHz4+yLXq2lCL/a76oHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ+87DbJvnQE3hI1cBUEme8XBYz4VNEHy+Kle9tX9PU=;
 b=eXLVESDRHJfNBlV0jm4xP7lisgdFrmb8a1tvJrrP1FfT2fp+iP36qE1IjBCEJ+RTjqcRpWtwGM9saAXgh2y1g1aFLYDrXHOQ/IM3qFYNm1XE6gfWCa/GAomdrlfwC6/GRsXwXH0idbuu+TF5jY+kcECGg0381h+udxXdmHae9rw4KhL86Ry7BJeR0mHkjRja1Z/ZkufL7dEdO5EvNGx0wu2Slbp3QcQLcWUdClhPqN0nyvPTli2+siZ2R6fSncYJBZhTL/nkSxhf8rmSi8yDuDWTdGVhwvRpJidxOzQ0W0/4R0nFBL59yoDkyNXb7XhQZ1A07sE7uXtTbVZezXSimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ+87DbJvnQE3hI1cBUEme8XBYz4VNEHy+Kle9tX9PU=;
 b=sTPHfq46eEifYsmad2sZfuIa9XnZhr/O6ba+3ULvMaVtMeyCrmP6vxcg+AR9MSyHM99YfMZ0EYk/BaBNPgD/nzUKBd9786sqrMnDGvfC7MMDVjdX2pE8+sViXXf2a2uClSdFGMf80g/WPbcKIR10Avy/G/nqaSJK7xcG0gD54+8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SN7PR10MB6569.namprd10.prod.outlook.com (2603:10b6:806:2a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 20:58:20 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%5]) with mapi id 15.20.6254.037; Thu, 6 Apr 2023
 20:58:20 +0000
Message-ID: <b50336cf-09a3-60a9-0100-0a25adf4ee55@oracle.com>
Date:   Thu, 6 Apr 2023 13:58:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
 <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
 <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
 <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
 <64c4e5c4e61962fd828bcbef79db1df6466a875d.camel@kernel.org>
 <f6c0553c49efd9e2f643240aacdea8dd1f728443.camel@kernel.org>
 <07d8f93d-c8f3-5ede-66a3-219eea0fdfe6@oracle.com>
 <F925BB7E-4E1C-48CD-A0C0-A058058E55BD@oracle.com>
 <c659b24274539086c3adad8af4c7d30cf87ee83a.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <c659b24274539086c3adad8af4c7d30cf87ee83a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:806:122::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SN7PR10MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 210d3d91-c517-4d1a-8a25-08db36e1a6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGfxwv2JwgE3NsW1KY+WojaWQbk6HeVnYzq1HbYIj8NHWQhkwo3WjFZ0kKLnMnGqEqzv/3mF9RNIV6Zw1FW8JBvHNbSCnFB6MnpuVT0XRDYemOS0T+Kr41j74LYBDktMv8n3Qut4YtLhVlxBIMd6dFEFZFh1q/b0VKzo3O/dWxMHfkGLNhV2rnTl3F6y10zS+P4QJu3XFALAVBu7aWthuqI804P/PsaIu5D092JOxs3l6H/hzQlUq2ZjOLTalB0vo74P9ExezdB5neteJi+Ta8gpeCjEvL/X1/dmieOHM5UJaSBIoUFYmlDwOktY5wCrNYIpYSzNBlGvgxW/KKe+LD/Ksa8lSe/7xZh50B1i3HNZSFI70ZnVSfiEXc3PVL3XrPU93GXOmST5HDuXiffiC5VCy+/8u+SyvSzVBSpiW5ycCxn2vjpob5Vq9jiivyR9XKjLWxsl/WqJ42tlLhccg1OMa+lH7Eyj8TdWKGssRA10xPf1SFqwoEPxEzFdaKlHixrFOKrZdUBZqgqrc8DT71dQJ9zRGhc9vNBLuTMM+TizGzpOGAc7LycrAYZLhz+Cx9y4xq7YDbYFLzXOCJGxLbkX2T8yCM8bVm9Vo38bBOGtadn+/tDZ1l/XIce1DX+9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(2906002)(478600001)(186003)(6512007)(2616005)(53546011)(6506007)(36756003)(9686003)(26005)(6666004)(6486002)(83380400001)(38100700002)(110136005)(86362001)(5660300002)(316002)(31696002)(41300700001)(4326008)(8936002)(31686004)(66556008)(66476007)(8676002)(66946007)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS91WTZ2ZzZKbEZEU0cxbm9SMVErWkwxd3JENzhvSE4ya2R2R3d5bGJOY2Jv?=
 =?utf-8?B?Tms3UEwxNmJKSUduK2t5MzJreEE3YTZiYW1YTEs2RTAyYU8xL2s2NWExZm5q?=
 =?utf-8?B?YkNSV3ZJYWVnU3ZTSW9TYXpMKzFSN2laV2gwMHZmRXQ0WEVDMk84eFNldVJ3?=
 =?utf-8?B?K2VhNTc1cDA2eTdmRi83dkQ5VmdwQTQyaXM2c2RxRzdCL0Q2UmxtUEpOM29s?=
 =?utf-8?B?dk5xZDRxcGZ0TWhJNjB6enFkOFdibzE2RFpyMndRbjFqeXIzcTAyU3d4SW1P?=
 =?utf-8?B?b294Ylc5bVlVYTZWU2JiTDloU0RnTjBJdlRYM0ZHUW9nVUU4RHVpRzhSd2xk?=
 =?utf-8?B?clNYNGpML2tzd01KVlZVTlVHNTBRV0cxMzBWcko5ZUN0SnBsd001MFUxaGJq?=
 =?utf-8?B?d0o4WVBJd2REQVVQMFl4UzB0RHFWZGRXRTJGSTJrMkYxbTNGUGl1UHY5TFRj?=
 =?utf-8?B?WC9LOGJnalE5S3NUNkNVSXdrZ0VITzNZdTFmdmxkdzR4M0pPMklwM0taRmVn?=
 =?utf-8?B?TGFEcVZaUFFydSsvVHZ0UDdyYk1OS0ZVenR5aDBFTDlqVHNsOUZIbjJGbHpv?=
 =?utf-8?B?a1BkaXkrUHRlSUsweUozZTJycmdxUU5UK3dFVy9VVXB5Vy90STJ1d2lzYzNo?=
 =?utf-8?B?bTJLQWpWZTVhRjdnditveSsyMjc5YU81eUVxSHVsQXlSL0NTaDBkVGJjT2hi?=
 =?utf-8?B?enNJNTdCMmhQdE9HYmdOZFByMmVKZTlaS0x4YTBkcHF5UXpPbW9vMGhnZkFG?=
 =?utf-8?B?cWRLRUpFQVY4djRtaVc3VzBlL0pNZXJGdTBYL050KzM3S1UzMjk5OFV2dXpr?=
 =?utf-8?B?eHA0a2g5Z1FEZCtzTmM2ZXdZakpkMXN2bkVwYlpHYnlEdFdaNGRhbUpKME5l?=
 =?utf-8?B?SjlJYXp3Vm1pKzluNExsdXJwVW1WdDFqbEtycm1tV2NtS2NyVHp2Y2x2MXI5?=
 =?utf-8?B?cVlaR0dja2JXUEVqNjlOdFkyWEkyaWZRMGczNlNobTZBZ2NEeEpJMjdsQ0Rh?=
 =?utf-8?B?ZGlaY3hVSDVwb2pUcUQ1TmpVMFMwQWJib254bDlocGMwTzgvKytSSUZGTmR2?=
 =?utf-8?B?RDVkdmdCVHdTN1ltNTBxMWpOSS8wRmp2aGFXYUpTQWQxVCtEd3h3b0FUajdV?=
 =?utf-8?B?YUVKaWFOVWNsNUJUeC9XWlVzQ05vU3c5VnFSdktQQVdpcUVrKytycmJiWXZv?=
 =?utf-8?B?ZlU2NTRIdVBWRXkrUmdNVWZnTElIV09uM1Z1UmNwTFRSdGNDdTlhUmlzRHNT?=
 =?utf-8?B?Y3BhNHNCbXRObENkZ3ByRWNySzNKQnZZL2VGMHpRNXlFeTV1Qk1lWkRvaG1N?=
 =?utf-8?B?VjgzSXFEMzc3OXFnaFZxSXd3Z1hMdzFFQ1NuZ01Da3Z2WENHRFhqTjFKYzZv?=
 =?utf-8?B?cTVMM1k3aTFvdU5WeUpJTnpoTXFmbnRBK3pkRWZYMFhkc3VIb0VoSStsVVEv?=
 =?utf-8?B?UitxQlpNM1o0b0dZUXRWUUhKYlBPYWVKSThNdm5mMzhFRkFjT3dCUkswY2xr?=
 =?utf-8?B?RXduSkxCR2VRUFdkV0FZcjBsK1Z1VXhPMHFlbCtkN2x6VEkxYkJib2VUbjlv?=
 =?utf-8?B?aklva2Z4S2RrQVk1cEdLQ2t6Vm95Qyt6eTNIcjZocjZFS2ErckZwcTJZVWl0?=
 =?utf-8?B?aUJoeXI4Zk5CclZjdWg1UnJPSVFsTi90ZHYrdGs3eTdaS0QyRHFKSGxyVkQ0?=
 =?utf-8?B?b2U1aktFNTRpVGxhRWpXc1dsQmd1QnpPOFluKzRoeC9QVko5UTNuby9aNm92?=
 =?utf-8?B?MUlUWXpQNWdvNEhVejFKNFFhWStOSk5sRHF2MDdVU3ZldUwzWEVxbEFKWi9K?=
 =?utf-8?B?RWsydllDeE4rQVRLcERZUHNGeDFkekJtZGwyNjFyT2JUek1SVytYUlh3S3lt?=
 =?utf-8?B?d1k5ZU9jbmxjaG96Rk16OTI3aDExOGNwSG92ejhJRlk3TEVyaStkTHpmck1K?=
 =?utf-8?B?ZG1GVWRNTG5jUjZsdHlxcXZXbk10VUh1R21Pb1Fod0JPVEFXb0tqaDVYaGFU?=
 =?utf-8?B?bE5uRUF1dU8xUlZGY0ZEZlBzcUNlUldETUhaL3lxelZZWHdCQzVPczFTV1NY?=
 =?utf-8?B?NTFiS0ptUGZSVEFkL1Z0M0NhZmVYUitsUHpFcjA1enNNc21ORUgvVkJOVGJk?=
 =?utf-8?Q?DNoEVWS2xP4hwUq0gqPNV1ZfO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b7pE3yeID4EJT3ThxjUJQfD38kBikwUE/yh9c/yoccK5Rx9J9fwngNFRghu3VLJVG3Qptq1mQUpcssBzK+LPvqfBvIBSqqdudUgkrWGsii7t6YizYv9iSvzXSTRbjMMlwkwjmXEz3OTxVcD6E2NMN+OU0xR483EsB7FugDc7blK87WvRbKivQKHR32rbAWWZcL9XFCqz7Sco/xXuyOZtbChezeZrHjvdxLpc2ectOk4Krcu70c+7nMQp55AjZxapQSXvQ2xbYtjYDJmvuCMv19W8yWddh1/T0UAzX81U9U8tPoBeFNFHyi4dpgL41GRjDyux4sDyA/WqNBp5oIYCgSjUUWK9+PGrnRzkkbNEpcm95gkUbiuft6bCHv7keZQSkMu+V8H8R7QolvAd/yCsl2Opg+hVexxEgtdETQyg2aA0sa35Ik30NdEOcj2T2X1QfYh9D7F7GcgOlbDeYmFX4g1Gf7cZxunzk4pKqpau/E0kIkYQ8Rea0QeaxhIq77Mb0aTXuw/ZhnLKZEoctk3LoL8dLmnbuLJgeGyfkc/1fawALpXRSVpGdjeV6ot8l66Eh6p8/WetJgWxhfPje6V7EGq6hFE97BmMHdTgGRFOsznG1NsAYFKJS+yhMI+2WrrQqhAkxK3I7ZwOJO0kWnggFWVIzhOCoZH18Potqpj/Qx3jQEjM9T00OwlVkyXwsv3FdPtN/GlcCoj55m097fpuFJwrfaIaJKtJ9SOz7ziNtcbuV5rcZLFbia6HSTqBVJKV1koBmigiSxv7gkXn8DG3vTRkKg+FrnuPNK5DpeiWtZRe/CivLoLLYohNGJwVB5tKZBbd6QiINgJtzgTzoh72Ig==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210d3d91-c517-4d1a-8a25-08db36e1a6df
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 20:58:19.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoVBo/VerAimRbwOKnFhwMsYaqRrNkpIOEwJfrpk7Y76Ps/MmFUIvh15gJ9oIgkKmv56Kp1LeVwwWf/a4W//Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060186
X-Proofpoint-ORIG-GUID: ehKrqJ7-cXteZNo2TQl1-Yf03EAGNe-K
X-Proofpoint-GUID: ehKrqJ7-cXteZNo2TQl1-Yf03EAGNe-K
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/6/23 12:59 PM, Jeff Layton wrote:
> On Thu, 2023-04-06 at 19:43 +0000, Chuck Lever III wrote:
>>> On Apr 6, 2023, at 3:36 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>> Hi Jeff,
>>>
>>> Thank you for taking a look at the patch.
>>>
>>> On 4/6/23 11:10 AM, Jeff Layton wrote:
>>>> On Thu, 2023-04-06 at 13:33 -0400, Jeff Layton wrote:
>>>>> On Tue, 2023-03-14 at 09:19 -0700, dai.ngo@oracle.com wrote:
>>>>>> On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
>>>>>>> On 3/8/23 10:50 AM, Chuck Lever III wrote:
>>>>>>>>> On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>>>
>>>>>>>>> Currently call_bind_status places a hard limit of 3 to the number of
>>>>>>>>> retries on EACCES error. This limit was done to accommodate the
>>>>>>>>> behavior
>>>>>>>>> of a buggy server that keeps returning garbage when the NLM daemon is
>>>>>>>>> killed on the NFS server. However this change causes problem for other
>>>>>>>>> servers that take a little longer than 9 seconds for the port mapper to
>>>>>>>>>
>>>>>>>>>
>>>> Actually, the EACCES error means that the host doesn't have the port
>>>> registered.
>>> Yes, our SQA team runs stress lock test and restart the NFS server.
>>> Sometimes the NFS server starts up and register to the port mapper in
>>> time and there is no problem but occasionally it's late coming up causing
>>> this EACCES error.
>>>
>>>>   That could happen if (e.g.) the host had a NFSv3 mount up
>>>> with an NLM connection and then crashed and rebooted and didn't remount
>>>> it.
>>> can you please explain this scenario I don't quite follow it. If the v3
>>> client crashed and did not remount the export then how can the client try
>>> to access/lock anything on the server? I must have missing something here.
>>>
>>>>   
> Suppose you have a client with an admin that mounts a NFSv3 mount "by
> hand" (and doesn't set up statd to run at boot time). Client requests an
> NLM lock and then reboots.
>
> When it comes up, there's no notification to the server that the client
> rebooted. Later, the lock becomes free and the server tries to grant it
> to the client. It talks to rpcbind but lockd is never started and the
> server keeps querying the client's rpcbind forever.
>
> Maybe more likely situation: the client crashes and loses its DHCP
> address when it comes back up, and the old addr gets reassigned to
> another host that has rpcbind running but no NFS.
>
> Either way, it'd keep trying to call the client back indefinitely that
> way.

Got it Jeff, thank you for the explanation. This is when NLM requests
are originated from the NFS server.

>
>>>>>>>>> become ready when the NFS server is restarted.
>>>>>>>>>
>>>>>>>>> This patch removes this hard coded limit and let the RPC handles
>>>>>>>>> the retry according to whether the export is soft or hard mounted.
>>>>>>>>>
>>>>>>>>> To avoid the hang with buggy server, the client can use soft mount for
>>>>>>>>> the export.
>>>>>>>>>
>>>>>>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
>>>>>>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>>>>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> Helen is the royal queen of ^C  ;-)
>>>>>>>>
>>>>>>>> Did you try ^C on a mount while it waits for a rebind?
>>>>>>> She uses a test script that restarts the NFS server while NLM lock test
>>>>>>> is running. The failure is random, sometimes it fails and sometimes it
>>>>>>> passes depending on when the LOCK/UNLOCK requests come in so I think
>>>>>>> it's hard to time it to do the ^C, but I will ask.
>>>>>> We did the test with ^C and here is what we found.
>>>>>>
>>>>>> For synchronous RPC task the signal was delivered to the RPC task and
>>>>>> the task exit with -ERESTARTSYS from __rpc_execute as expected.
>>>>>>
>>>>>> For asynchronous RPC task the process that invokes the RPC task to send
>>>>>> the request detected the signal in rpc_wait_for_completion_task and exits
>>>>>> with -ERESTARTSYS. However the async RPC was allowed to continue to run
>>>>>> to completion. So if the async RPC task was retrying an operation and
>>>>>> the NFS server was down, it will retry forever if this is a hard mount
>>>>>> or until the NFS server comes back up.
>>>>>>
>>>>>> The question for the list is should we propagate the signal to the async
>>>>>> task via rpc_signal_task to stop its execution or just leave it alone as is.
>>>>>>
>>>>>>
>>>>> That is a good question.
>>> Maybe we should defer the propagation of the signal for later. Chuck has
>>> some concern since this can change the existing behavior of async task
>>> for other v4 operations.
>>>
> Fair enough.
>
>>>>> I like the patch overall, as it gets rid of a special one-off retry
>>>>> counter, but I too share some concerns about retrying indefinitely when
>>>>> an server goes missing.
>>>>>
>>>>> Propagating a signal seems like the right thing to do. Looks like
>>>>> rpcb_getport_done would also need to grow a check for RPC_SIGNALLED ?
>>>>>
>>>>> It sounds pretty straightforward otherwise.
>>>> Erm, except that some of these xprts are in the context of the server.
>>>>
>>>> For instance: server-side lockd sometimes has to send messages to the
>>>> clients (e.g. GRANTED callbacks). Suppose we're trying to send a message
>>>> to the client, but it has crashed and rebooted...or maybe the client's
>>>> address got handed to another host that isn't doing NFS at all so the
>>>> NLM service will never come back.
>>>>
>>>> This will mean that those RPCs will retry forever now in this situation.
>>>> I'm not sure that's what we want. Maybe we need some way to distinguish
>>>> between "user-driven" RPCs and those that aren't?
>>>>
>>>> As a simpler workaround, would it work to just increase the number of
>>>> retries here? There's nothing magical about 3 tries. ISTM that having it
>>>> retry enough times to cover at least a minute or two would be
>>>> acceptable.
>>> I'm happy with the simple workaround by just increasing the number of
>>> retries. This would fix the immediate problem that we're facing without
>>> potential of breaking things in other areas. If you agree then I will
>>> prepare the simpler patch for this.
>> A longer retry period is a short-term solution. I can get behind
>> that as long as the patch description makes clear some of the
>> concerns that have been brought up in this email thread.
>>
> Sounds good to me too -- 9s is an very short amount of time, IMO. We
> generally wait on the order of minutes for RPC timeouts and this seems
> like a similar situation.

I'll prepare the patch to increase the time out.

Thanks,
-Dai

