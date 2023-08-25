Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068DD788D37
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 18:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjHYQal (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbjHYQae (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 12:30:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311EF212A;
        Fri, 25 Aug 2023 09:30:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PGKRWZ014812;
        Fri, 25 Aug 2023 16:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cPOKrnymQCejKSxdqlDWiqvpl1zQ/c3Oh7uOzRAEXbA=;
 b=fyOvgGJdQtN80X3WKgzVMZaV5sFISNIY0r00Q7TmeW0m3IoDoDOycN0HcvP6Y2WpiRt1
 zV4mXSJe6lh1eu2E2bYRlUkoOMo6GIrMnjNw3yYh4Dor/aph0CtyxGitzXS9DLhLXuGI
 eTu+hCaPLLV7dapFr31Ec0PXxcS1ZpBNWDjMAWMpFBvEDWiftSwdg5YbKUfgiq3Tb46X
 GRO1LtxA3glatcYhep8ORhF2npOvWWTNKLi3eZX3m1+JMugy1KeiLlp7y4/oIt282d/O
 rPe4za6LdGfjK1gHgZOs5ZmbaqApQHSTV2Ci+dxvvXfGRysZisQKFrjy7J7piAinU2wX wQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv6uk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:29:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PF4aND002362;
        Fri, 25 Aug 2023 16:29:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yyap36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:29:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTyHcQ0IxJ09KDXreRb8WRIRJx83ot78GyYR2VVJl1J+Cghw1op0X1lxIWr3khOQNuVHy5wol8moI31rqz45XIjjMYUjRSPq9AmfdMOJ1VrRH2ypuxmVaqcfVxWmUtRKNbSHj9MAVjagwQSLf10Kigm2Qgd2R+FIybbaQZB7mSKhPq/kXPKxLcWhQADCIkLhZpZFMs+uHsjiBJcBXM7LugIdFuctAlS37LwGbSeZMf9y63dmFRAXPzYgyw7VESK9InNW+fhR9yUp4u334O1DGZZkKdHFPTQJjs6ygtuEnYXWisw0NLREXyhO1csTCjDyuf71qgabkb06HJTU2vj37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPOKrnymQCejKSxdqlDWiqvpl1zQ/c3Oh7uOzRAEXbA=;
 b=MpEHrgDokFQLck+sBASoaWg+PV0Ocec2ZZaVKx60iDTltf7vj2Ys+0wMcZOh0gCf7b8l9ciXnIOmD+0qrB5FfNdENGtRCSr6KM6icFD3zvqxnA2uL/KN+CiF2cx/0ixzZMygVG5+qQpZvA56OuP3W5RXTjLvyy+wqDn2MZBHHSTOM9PMxnWxbVF8Zq+t97Oin8wmxKU6Edzu8141OMRUYECkSzAPKHnUZ4xDqMDNtTxcxZCgzJmKL/5m4SogV7e98u2oxqpwhrbjGHFmp3X86hjSdEXGLISuLa33mCqBG+1sW0oWp0xtI//5gHFjnSJnZcOxZw1PUSr7o5xAxwZC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPOKrnymQCejKSxdqlDWiqvpl1zQ/c3Oh7uOzRAEXbA=;
 b=Vz8aQfRQv/qRaG5qallOYQqpnKdFeTlwWI0WTernhaZi8o8eiucl5CjrmHu34s48g3pU5QZyoRSGW0775q0vhbTL//aBJLuLSSXr0FSoRMK2YVEOdBn6nVBwGgr/Mbt6BF05cQ/tPtg9q/T9eitEpPwhISHBsY/gnRKVWlvOcp0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA2PR10MB4713.namprd10.prod.outlook.com (2603:10b6:806:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 16:29:44 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 16:29:44 +0000
Message-ID: <a7ada1ec-deb8-d25d-ea5f-3835ad763392@oracle.com>
Date:   Fri, 25 Aug 2023 21:59:28 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Sherry Yang <sherry.yang@oracle.com>,
        LTP List <ltp@lists.linux.it>,
        Darren Kenny <darren.kenny@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20230824141447.155846739@linuxfoundation.org>
 <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
 <2023082512-amusement-luncheon-8d8d@gregkh>
 <CA+G9fYvVGxm0xOYp4LHepRJqccwmK7Zeg--2AhVk5T+T28Kk6A@mail.gmail.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CA+G9fYvVGxm0xOYp4LHepRJqccwmK7Zeg--2AhVk5T+T28Kk6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:404:14::29) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA2PR10MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dcc7dd-e7e5-466d-bc81-08dba5887d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Okr88/bxugtJFNoeJ9O202NsfLkKrdjf5KtIe+Molj0X21D/3AoLJxgnL4hJW88LCNlvj4HWiLQX4piPpeWbXCtZahEz7C7D6gMBjHUZVdDVtS9eOwcGSN2h8/pzTzjviGBBF8CN+XdbcZEGisHafM96k6GULpS7ZvovPn/0CUKzZ1WsQ/0a/ME80kR/1GD19ToMmjRF32AE1+CP/gTOzm5Bu4gDnsRrC/2vXms+tNglNJvltVCUaL8ZKEy8S+V8fy4ZcDbim5QQ9h7cerla+7SuCkKht2VKSiCJbGtfugc5TsBjY/auU0WwKh3lDsVtZtqXKrx4eo7+w6hWXPUa+mbb/ZCggfmigiALd5/aYdX793iNA0hmqIyZ8+gDTpc6YhGZe7oTT7xmQlW79sbcqsNF+uC4+jbtRpzxpJeJCKLiquQMwUmId3p38bkNMp4oAOQQolp3p39Pb/fk/IZd/dGidzwASOup+dM4wtKbzzIzf6HwT58sgraM32oGBAhMRrH7607bycsJCvl/++FRR+GtqyUIfqTas6blBECvmQLPVh0TjXQfS2UFxvk2E36LDZDtswOwlyvH0OgPzB+PCTpcJAinA7EUB5ydcbrfLThntPFkpBRJj60oM0MhiPvkUfBG7Xgn6uGS+ZBedNea/y6mwbzqVffi5eO0DO185d2e8RbB7ONOllbJg0Zgs09m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(5660300002)(8936002)(31686004)(8676002)(4326008)(316002)(2616005)(107886003)(26005)(41300700001)(66476007)(2906002)(54906003)(66946007)(66556008)(966005)(7416002)(478600001)(6666004)(6486002)(6506007)(53546011)(6512007)(36756003)(83380400001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHYzaHh1Mk15WVZweDlTYmxNbHN5emN0bW8vaVpqK29QRXJ5K1cvRWNCQVh1?=
 =?utf-8?B?bXlmbWVBd2JwMkRRQ3hhV055U2hRTnlPVEE5Q3I0SGsrRWRNM0NHVjRQNEdL?=
 =?utf-8?B?Z2ZVUjI2N1AyaWN6QlhrOXllL0wzd3JlakNKWFFVZEgzNzBTcksvY2I1Uzht?=
 =?utf-8?B?SjJZUTJJTG9JblNxR21lZ1VWNXFhNlQ1TUxZVm9tRWR4bmsxNUJIZkY5MTE4?=
 =?utf-8?B?NkxHa05Id0dESHpQRmc4TndMMDMwNlp5RS9wT0hGYTExZmx3a25jelRwNHB4?=
 =?utf-8?B?aS9mQ2sxMlNlNHNWdERuemx3R2FDc0dpNndNeUF1bHZEL2JCcHFBTjFJTlRz?=
 =?utf-8?B?L0tlSkdXZVJKY05RSTc0ZGVpNDNncis3K09EV3NjTGxmU21QcjcyREtlV0ts?=
 =?utf-8?B?WU9DMFA4MGZza0tnUTlPcUJPcU8wQjBGTDZNOW5JbDRyWGE4Z3podjd0WGRa?=
 =?utf-8?B?MXA5MWR3U3NsWFc2S0dHZW54Lzh0ekhZZTRhYU9FRlQ3TTRPZzd6N3NSWWs5?=
 =?utf-8?B?elVHd1F6Mmd5cDc3cHdCb1plTXozd2J1bEFsOG1JTXVINFdWQThLdm1tNFF5?=
 =?utf-8?B?RHdLT3ZBODJqWVoyS1pHSExaWVlOM1JmT0lBcjVoVWJwanNlandmQm1XbUk4?=
 =?utf-8?B?YXlSUlpBaFBMcmVsWnNFY0t1dzlPWXRreHBrbTVJbDFXVDhDb1pXS3YxNTJp?=
 =?utf-8?B?Y3BlYnF1MjlBUHBPbjd3eFMzS2ZTN3pZN0N0YUZDbDkxTjI1RVNaL1RBaGg5?=
 =?utf-8?B?dHRENXdTYVpFcE02NjBWZFJpR3NEeUhTazJnL3VTOTM5RmNmVGw1S1dSTVJq?=
 =?utf-8?B?UDlyaVc4K0R6aGFoNWI5VnZicnVNTEorYmlqT09FZDBVM1lUQVlleDVpeG5S?=
 =?utf-8?B?SmY1NTBWRktwMG1KZ3h3TE9sOVFFbGVnSDg1TnYxZ3hkelVOMldOVk11U2dE?=
 =?utf-8?B?NFBUa0gzK3R5Nzk4UFNBTFBxeVo5MFRlYW5UTlZjMloySHBhVHZ3MnkxQUt2?=
 =?utf-8?B?WGsrTXFhcUlKL1ZYYnh2UEQxYkFvSzlZMW9YQ2M2Y3E3U254cklLYUszUi9t?=
 =?utf-8?B?YXZHWE9DN2hZSFJxcERTOVNEYnJEbldRbHNNNTNCazBkYVpubU1TWXhBRnNS?=
 =?utf-8?B?V2Y4ZWlYNHhtaW5qSjBvVlZ1RTd4dUlENGpzVnBLZ1VadUtFT2ZwTHJkYkZS?=
 =?utf-8?B?QVloSTJOWVZtaVJTeUUwSi9qbkZEQzAvWkxsejhWUUFwSnBJcjdzei9YVFJ0?=
 =?utf-8?B?ZjgwOG5zTFVOQzB2Rlp5UW1vYXVTK3lxNm9mUnBjK3JJSllQM3E4Zkdicjdz?=
 =?utf-8?B?cEpENVFGVlArT0d4SXRaWEYxQ3djOEttSENKMlVLRkhPZnk1aFNHU2JKUDcy?=
 =?utf-8?B?dHFnRFpiR1FyR2lkWHViWTFsb3FGdlZzdEhPemJnYmg0SGFDWjMwQUVDMWFu?=
 =?utf-8?B?TDh1aFJsaVFQRVduWkpXcWI5Y3JFV0lMaUk4c0F0U0JTUW1mc0pmRVdxVkdw?=
 =?utf-8?B?dEo0Y0dZbU9yTTBvWGtzbE1aWnFFQWsrM2J2a0pITk1nVm5YZVFNcmxsaEd1?=
 =?utf-8?B?RE5jeEpGYzYrQmh5S014V005eU5VbGMyOHBmbGtPRDVLdjdPa3ZTUWVraDhW?=
 =?utf-8?B?RkNZQzVzL3cvbzlPajJWS3h4L2pTUDB2TSswQk9aRGZIQUxHUVEzSFFPTEI4?=
 =?utf-8?B?SFAzdlpyUVA2T3ZNcXpFcWgxalkzWVhlRkZFek5KVktZVmt6UDh6TzAxY0l4?=
 =?utf-8?B?OThuUW1tY1pmWGRjVVdZejFQYmIxeVpTWHRNRzh2Z0ttMytiaWJxL25yM0Nt?=
 =?utf-8?B?bEQxcSszUlhidVBQempOYXA1UzBjWHIxUTlIdlJCV0FKWG1oQlBodG5Cdi9Q?=
 =?utf-8?B?d0pOWUxZMDV5emg1TVV6bHp1clhnUElqZU1MbUoxT1pXNERjUXFNUWhEalFn?=
 =?utf-8?B?SjhOU01KKzl0NnJoRTBXcGFRTVZHUm1OZm5kQTFYUTJyTEs1SWlJc3ZxVUlQ?=
 =?utf-8?B?TUx3V0NEOW01OG91ZFN6UmZlYnppS0FmbUl6M1Bja2ovNHVwS0V6bC9WdmVr?=
 =?utf-8?B?emtjUUFic1Y0VWF6RThkWEc0R3prQVlFWmYweVVtdmoxZndTZjRtZnNmMmhm?=
 =?utf-8?B?VkhsbjE4MUZrTXMxeGduTFJSWXl2K0RlSmhLUlYzNS9KeDFyL1gzUHl6bXZ5?=
 =?utf-8?Q?wtOgBpYa493vjxQNWQ3vsEI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MUdlM21TRWU0OFd3OG1JdzYxMk9yUXBiVnlvTkZ4QUU1NFp2Mnh5UE9HSVBm?=
 =?utf-8?B?N2NJUmZIaGkwSGNkVGRQK2E1VWpMcFp0WUpzejZwdlNVelAyYmdOa0N6OVRz?=
 =?utf-8?B?L1h2cFdnWTFOZzNxSjR6bW5LRFVSVjM4a2V2dEorYVBUOVVtbTI2QjNmcVBy?=
 =?utf-8?B?T25qdU9YZU41aTg5NHJTZGNNeVpHVXIzb1ErSmM4NmlTZ0IzTDZJZUM5dllw?=
 =?utf-8?B?K3Z4ejhRNkp2N29TMHBWY25WVE5hKzhkcWtMZU1CTElIeGhudkJtRGNQTVlN?=
 =?utf-8?B?THg2cHlRV0ttYnRFWTUrbjlPOGMxK0NxVkI0d3pyTVhSMkVSbXBqdk14aWN4?=
 =?utf-8?B?TDFBSWk5c2xuVm9xYVh1REtFbHh3ZThkQnlqR0lPdWZiTGplUFo3Zi9qeDl2?=
 =?utf-8?B?NktxNzkyWDRxaEE2ZmJFODBMeUdrWndESHFqanVJSVJOVlpNeGZuQlFwVC9B?=
 =?utf-8?B?U1pDcTdtTmtRN0lYU1NlWGFUMnlDMFBHNGpEN3JrTGkrZ25xNXgrU2NzQTQz?=
 =?utf-8?B?ellVSEk3aU1OZVhiY3BPK2c1MVZGUVdJWjA0YStJdFNrL2pkRUJBckQrc3d3?=
 =?utf-8?B?MXVDanFtMThZT0RxYzVDUXFOcTBGSzNTUVhkNVdLY0xHRkpRak9CT2dnQTVV?=
 =?utf-8?B?aHZnVXYxQnl1Zmk0b1ZOL1ZnWCt2VGl3MFpJeTFuYTFQdys0Q3JtMkhWU2s2?=
 =?utf-8?B?ZFA1L1VoeGI5UzNjSWxicnBxOTJ6Q2pTS0EwbFRlWGR3NU83bnZMU1EzaW5E?=
 =?utf-8?B?dGg0YkQ5L2MwZGVScnh4eEdIMlNMYjU1YVNSbmR5dFBrN0JIWlZTRU5oN0ZY?=
 =?utf-8?B?SW52MlNNS3ZDaFFrZmFueGVHNUlwRjhLbGJTa3UxVHlxdDc1QlJiWjZITkIz?=
 =?utf-8?B?Y2xlL01DVzloT1JlMGgyVHB6bU1Sck5vK0dmK28xUEFwY3NZcHlMbEdzOENw?=
 =?utf-8?B?WUh1MzZlLzVkYjB4ZDc3Q0pGU1dJd0JhbVc1MTI0RzFDZnhodmhwSnlrK3Y5?=
 =?utf-8?B?K0wwSUhlbGZDeXAxaVV4QmJWbmJCNFZxa3BVV2dHTG43c1lrdkhTMWltRTJG?=
 =?utf-8?B?RmphYjVtNDV6RGcyMGcxckFKbHhCR0k2VXMwSXAyajFEQ3NlU05KQU1PcmdH?=
 =?utf-8?B?QmNta3F1V2V5bllscDQ5bzR4aDBWQ3NxRFNaV3Uwb3ppckFvUTQ0T2RBSmhY?=
 =?utf-8?B?L0hJZ1JONXZKNlJHdld1VUFIemFyZ1ZPaTQ5cHh0T2J0bU1IVThDeWdjOWo4?=
 =?utf-8?B?Y2dNenRZU1h6dVZab3ZIR3ozekg5TUZpWFp6TjI3TmNvNXdXclYyb1JjbC9Y?=
 =?utf-8?B?Z01saTFHOXV4WHdQNUFJdUxJNTIwRFo0N3p0MzZuVkVMWVd3QlVISHl4ZXB2?=
 =?utf-8?B?QnNJejY2aFhWaUxoeDdLeVUwaHExZ251ckg3SUNyalF4Q1M4aHVETmxXZ0or?=
 =?utf-8?B?a3hkeTl4cDlNT2R1bzlZR213clFQSm5YMlpQNnpOSzV2REpyNGVFME1zZXlx?=
 =?utf-8?B?N3Uvd0puVG4wNDJVWkRjSWxhSWZ5Q240aTUzRS92eTBpL2Y1Vm9iRlJQWld1?=
 =?utf-8?B?TDJWdWk0ZGJlaHA0Z0duTVhZczdJaDVyMlN4enNLK1ZndVAzMG1XU1B0SjhJ?=
 =?utf-8?B?OUFZRU8rWk43ZWRxcXM0QmZxWCtiNW5KYXFzdEVLL09PMDZaUHBLbnMvNXI1?=
 =?utf-8?Q?ulSChloVHoLv1GXyBmSj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dcc7dd-e7e5-466d-bc81-08dba5887d1e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 16:29:44.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqs9XKpfIkssqTkxzWJVsxcPc2Fav1dwfEsNIUQFaLRU8ytQMVJThy9GZc9HttnFmLbyhQyafs9AGnXE4oKqLHHWKFqepivnNDhfauMQ4psGwdj9dbRkfE4CzEc6tX0G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_14,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250147
X-Proofpoint-GUID: YEuUnHTcZ-wZGhpFJVSRfmcMwlSk0Lwo
X-Proofpoint-ORIG-GUID: YEuUnHTcZ-wZGhpFJVSRfmcMwlSk0Lwo
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi

On 25/08/23 2:18 pm, Naresh Kamboju wrote:
> On Fri, 25 Aug 2023 at 13:57, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Fri, Aug 25, 2023 at 12:35:46PM +0530, Naresh Kamboju wrote:
>>> + linux-nfs and more
>>>
>>> On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> This is the start of the stable review cycle for the 6.1.48 release.
>>>> There are 15 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
>>>> or in the git tree and branch at:
>>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>>> and the diffstat can be found below.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>>
>>> Following test regression found on stable-rc 6.1.
>>> Rpi4 is using NFS mount rootfs and running LTP syscalls testing.
>>> chown02 tests creating testfile2 on NFS mounted and validating
>>> the functionality and found that it was a failure.
>>>
>>> This is already been reported by others on lore and fix patch merged
>>> into stable-rc linux-6.4.y [1] and [2].
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> Odd, it's not a regression in this -rc cycle, so it was missed in the
>> previous ones somehow?
>>
>>> Test log:
>>> --------
>>> chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
>>> chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
>>> chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
>>>
>>> fchown02.c:57: TPASS: fchown(3, 0, 0) passed
>>> fchown02.c:57: TPASS: fchown(4, 0, 0) passed
>>> fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
>>> expected 0102700
>>>
>>>
>>> ## Build
>>> * kernel: 6.1.48-rc1
>>> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
>>> * git branch: linux-6.1.y
>>> * git commit: c079d0dd788ad4fe887ee6349fe89d23d72f7696
>>> * git describe: v6.1.47-16-gc079d0dd788a
>>> * test details:
>>> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.47-16-gc079d0dd788a
>>>
>>> ## Test Regressions (compared to v6.1.46)
>>> * bcm2711-rpi-4-b, ltp-syscalls
>>>    - chown02
>>>    - fchown02
>>>
>>> * bcm2711-rpi-4-b-64k_page_size, ltp-syscalls
>>>    - chown02
>>>    - fchown02
>>>
>>> * bcm2711-rpi-4-b-clang, ltp-syscalls
>>>    - chown02
>>>    - fchown02
>>>
>>>
>>>
>>>
>>> Do we need the following patch into stable-rc linux-6.1.y ?
>>>
>>> I see from mailing thread discussion, says that
>>>
>>> the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6.1.y.
>>
>> What "above commit"?
> 
> Sorry, s/above/below/
> I copied that from another email thread as it is.
> 
>>
>> And what commit should be backported?
> 
> 
>    nfsd: use vfs setgid helper
>      commit 2d8ae8c417db284f598dffb178cc01e7db0f1821 upstream.
> 

I have tried backporting this on 6.1.y and 5.15.y.

Here are the backports. (note: I would like to have them reviewed)

6.1.y: 
https://lore.kernel.org/all/20230825161603.371792-1-harshit.m.mogalapalli@oracle.com/

5.15.y: 
https://lore.kernel.org/all/20230825161901.371818-1-harshit.m.mogalapalli@oracle.com/


Thanks,
Harshit
> Please refer this link,
>   - https://lore.kernel.org/linux-nfs/20230502-agenda-regeln-04d2573bd0fd@brauner/
> 
> 
>>
>> confused,
>>
>> greg k-h
