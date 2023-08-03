Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93B776F046
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjHCRBx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjHCRBw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 13:01:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11562213F;
        Thu,  3 Aug 2023 10:01:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373CgMX8006649;
        Thu, 3 Aug 2023 17:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fRQNKzZKP6TCCEQfZj43GLta18c21S4/SxJ6l4FtMgk=;
 b=JVweYeim1oih+3E8vSragM19zXgZcRPLyVp4EufzjXhpoqJFhCRlxqIfwxT3SO05rJmI
 7/7C4apyhQ6KvMJxO/IrAOrClFNpHLpJMazyutIZ7uBCB3jdwBX+Z9dvXVWfEPmWMdgf
 ep/xDk3+qtQrXZo75a1tBWFzzIrAk1E7TyHyrmL/RjPeFnXO3Nrukrsgr9Q0Y4wTqWkE
 /kDv5plJrYAms/Z9rniUyH5fRAoZ8sjDv8arpgQtQWPKwt7EOqQERvcPWgUW6vwMLnj5
 bCbMun8E8Sr7+HvuO/FV+JzZfsKLqqJ1INADkJh8mFbanLkGr647xCgaLMT+LAbhPssF lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav236w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 17:01:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373FiJHm015691;
        Thu, 3 Aug 2023 17:01:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s79xkr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 17:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXerMQqH33Fk9I8iPQ0DUmbZkcYDYQ+rwAuQBSkUJypnZqm+jee47InfgKIER6V1Inp0613BAD94Jh5g1qzAg90yTDXoMVs3JkwY7i6wBMg4mTOMK+Fgw1Dt187HLBg4dqzXBRPkUCae6rcPi3dX148DLdcxM9BIfi4qLQSYFcBYePYNLDrmbWimogDN3Sqat+WdO3RNlU890zqajU27GHuJZp2iUDproPdvjabKgEwhg0dEAxaJsITWSBrsAhd67oc42L2k4pn7XLlpaPXSPritSMUtkB25stLN6mrdPzU2vOpBBG6LfsAKvSHGZz0rExJugbIuRh2pGMSBiJufZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRQNKzZKP6TCCEQfZj43GLta18c21S4/SxJ6l4FtMgk=;
 b=IgW0Ro6KCs4nMw0zFe3sPXNRdb8Q8+S5mLVQ4HLl3j0KKjajp8sjvR4Xiaqwiqc6Pl84Ku9QvMprMfACdHV7Bp8vo/E8AKiP3wKRykLv3vfiqs3kw6YcvtoOVXS+LqeIG/ocLK2PWycpmw24u/wsaVoolPwx2/aJ8rlEn0TWb//m7VGnNQ4cYEpN3Hk+kMGjeF64/L0CA8RlMl3ujojinlN+gkRgujY5ncoVZ3UlZMp+vnX1XW2ool0cY0FmKfgxytkJFrn3QQ4LVNGqET/2rQsTbe6ErjWDpExGYYbYaLvsTsBMSVDfPW/OS6F/RjL5AxzIUIbUYPBA+9hVmxX+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRQNKzZKP6TCCEQfZj43GLta18c21S4/SxJ6l4FtMgk=;
 b=l/VJS2Z3yB++Zfm1fMlhQp+4iOHAzMPBM0z+MktH5+jPWoYVT6J8p3IflIsjbyhyH6XYy2hExDfMwsir6UlNt3vUIh0wJa8ilZXcE9GSuIsCdEpq8C/gtP4P95WBY2gVxf9xAeFBOfqnKTxD0oufiuD2dirO+w+nJFMoVPQGDgw=
Received: from CH2PR10MB4264.namprd10.prod.outlook.com (2603:10b6:610:aa::24)
 by IA1PR10MB6712.namprd10.prod.outlook.com (2603:10b6:208:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 17:01:29 +0000
Received: from CH2PR10MB4264.namprd10.prod.outlook.com
 ([fe80::80a:f91c:c1e3:8fcc]) by CH2PR10MB4264.namprd10.prod.outlook.com
 ([fe80::80a:f91c:c1e3:8fcc%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 17:01:29 +0000
Message-ID: <45a64f2e-d095-c931-d0c7-23f50e791901@oracle.com>
Date:   Thu, 3 Aug 2023 10:01:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
 <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
 <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
 <0a256174-44ea-d653-7643-b39f5081d8a5@oracle.com>
 <d70f4dd0fc77566f15f5178424bcf901ed21fbad.camel@kernel.org>
 <26761CA2-923C-43FC-BDC6-14012115EAA0@oracle.com>
 <6801380f-75cb-49b2-4e89-49821193fe32@oracle.com>
 <5296d1a2-e410-c5bd-a8ca-66b8b42f158e@oracle.com>
 <56557df3aaf3a847a6019e2b27c9721b22145bd1.camel@kernel.org>
 <3dad0420-11b5-6e6a-a1ae-72970fbfdb34@oracle.com>
 <86e3ac8e288f9cf0fedb275a17296ac0bbe245f1.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <86e3ac8e288f9cf0fedb275a17296ac0bbe245f1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To CH2PR10MB4264.namprd10.prod.outlook.com
 (2603:10b6:610:aa::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4264:EE_|IA1PR10MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: c828deac-6972-4612-9e16-08db944347f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlzDp6uVSvqOR686F+1WM/b+84ylHw95Q30ZDyzTzZyd2fP2IPZ1c0ajmBLQVn4eb3+LH1YgdcSI1akCVEW/K77uiSUY1r8m1OcDRXSCS0e/udb806glJTLDUAIVcF4gjHdeXXk5o+rWScGJTJl6Wg04Yz7Jpo7T2txjjepGdSRVFNE34qSuf0rpc+mDXpWltn2YTOZUDaVAXQ6bFTVHcCT1WO0iO8dZxH1A5/RaqlZnFKo4YKnxV7loErZx4IrHOKPg1Km5yLY1SiCNgGqbYq3F0RATwDfv7LUaD1PH5Y3IdpRNjwlXqDvRDoheTnGMoxlbcItuOMGOx0fV3bVPVtuoCZEhhL6irh7exQBK8myUGAvupR+Z/I4Gq6gvh3CNK3oyb6ft+Bn4NXSKWVIe98ccrfNT39+1UevMfKRzEdU1crpFtB4wJ2ChCSL9By0bpFjaWMFec28sLl+WFB7mN7f8mKRCNedOOb161y9Q5KlZC0Zkkief7+DOaqpmr+qxgy3GDE4ayQQj+oNYRSgm6rO+rORprnvGqpuzZ5sGm9yyNBAGlQVDCapXdZUSo9pzspEW3Gejzcl64WtQ8faiki5xiBjuogGxHlEN4YLYz+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4264.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(2616005)(53546011)(83380400001)(6506007)(41300700001)(26005)(186003)(8676002)(8936002)(66556008)(30864003)(2906002)(4326008)(66946007)(5660300002)(316002)(66476007)(6666004)(6486002)(966005)(6512007)(9686003)(478600001)(54906003)(110136005)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtHT0o5VDFmd0N0Myt3dWdyVE5yeEthYU1DbjhueVV2RzRRRlAvdU0ycWUw?=
 =?utf-8?B?TlQycHYzdFJOVnc5THoyemRHVUg3OWhRVUFmWTZXTWJ6SVZDZlE0OWNqbEdx?=
 =?utf-8?B?OWRUSTBObjhqWU5RZG5MVDlGZXN0RDM4cXFPb3RSdkczazJQYWtxOUtVdmpt?=
 =?utf-8?B?R25yM2lzZjJxTjZKeGVCcVFwNzY3UFp2RFRuNlY4dnZidjdDL0hzbW1SNXRi?=
 =?utf-8?B?M1JqMXBnN2k4ZVpZRTNhR3RGd20xVStWTVNINGdlMmYxR053dU1wMjBRSjhn?=
 =?utf-8?B?ZmlnMWpaeWw4YWdvUTk1WTNBQmo2YllUSitUY2JHTDFFN2g5b1pPaFVianJC?=
 =?utf-8?B?Szg0WUgzQU5lam54KzJrZDVER0tnR3lNMThDUi9PUHcyMm9STWRDaDl3bk9D?=
 =?utf-8?B?bk9DNlFTKy94OWt2MzMrS3MyY1ZhNllBOVBFUVdEVGN0TDMwZTdqUzhUZ1Zm?=
 =?utf-8?B?cFZmcWlmdFR6ZzlpRS9LSDJQcWxqTnMyNkFDY1hNeE5YWHlOT1E3SDlITHha?=
 =?utf-8?B?a0E2cW5BSXhia2ZzdEhhenJ2QzVNYnFxVytwVkh6ZzNxN3JGRk1ZS3o3dUZ5?=
 =?utf-8?B?Tlo4Zk1XbEdDZXBYNURsVXF3cnZRMUhQRHV2SU9oYXlNaXNBcTcxa3dOT3dS?=
 =?utf-8?B?VElkSUJPdXg0VDE2eHNlWjl5SG4zWGcrTDZMcW04Wnc3QmhzWUY5TmhBRlZo?=
 =?utf-8?B?bXJZUFVxSEFCUmRBbTN3MWhmai9SenQwbFM2ajBDUWRacFFFaU8xcTBTbW4w?=
 =?utf-8?B?QzZ3Mk53U25uQkUxMVNSN1BhNnhDdHNrL3YvMlVpYVphOVU0MHlkV1VQbCt0?=
 =?utf-8?B?RWRmWEs2NnhWV242QjZCWk1MWHAvTi9mcE9WVFJxejlrcFNMMzJlOURIUUt5?=
 =?utf-8?B?ZkIvd3J2SzJqTlhRd3FuSkJETXdJSTFSU3J1WnRDcEhWSFBUZ3IzUkxXbExz?=
 =?utf-8?B?cTA0V0lVZkxBNWFadFJuWEdMb01ia2NaeHR2QndVck5uNjU2R1JFclZ0WjdW?=
 =?utf-8?B?b3kreW4wMEVxVmZvMXFCWnkyWUFtU1MvcFZmSWhiYzVBTmtkc1VPWnBvbjdL?=
 =?utf-8?B?WXVrNUVrNmxzSGhXZjJVMkxRRW9EclhUd01KWG1hVk1FV2kxVjM5eVlJdy8r?=
 =?utf-8?B?c1U5MlRrTmUrRytYMng3MHdLUVVaUWFXQ0dXQTk3cjhZa3ZhcFdBYVV1WTQz?=
 =?utf-8?B?UUlDLzZvS1ZocFNDcGR0K3ptUm5PZmhwa2V3cWRMTWhpOU5zOVpNdlZFZ3M4?=
 =?utf-8?B?ZkFxb1BZZXQ0Y3czSThTKzUycWR4c0NHcFpZVCtFMU1Sa3hnZnEwbmFHblR1?=
 =?utf-8?B?czBXNzF6U21ybTFTWE90bi9RRmpwaFNVWVZXcytTUi9wek5jL2kzWU5OYUsr?=
 =?utf-8?B?ckF1UmNCRnZnaGd5L2FSLzM4QjZPdHQ1K21xbWlNTVViZ1ZYTzl1OFgvYUtm?=
 =?utf-8?B?Q3ljSE51VXdxSVRzWkFLMlcrZVVwcFoybU4vaVFxVXRVOG5yU3JvUFVpV2Uv?=
 =?utf-8?B?NTZDL3NzVzdmblVJRVNyL3lIZHJZZHBnVzNxeThLRGJralJmMnBjSFhTVlhW?=
 =?utf-8?B?b1dyRHErS0ZxK0pxb3E5M0NZVEJSc1l3cldMTUZSSDZMUkw1aGxwczd5eUdO?=
 =?utf-8?B?eUdJL2dOc2N6SStFTC9rZnROblBxZ01IKzJZdXFIVHZVYVdDSGh4UzkzSUow?=
 =?utf-8?B?TUIrZkpNck1ycG1ZU3pteDZNcDRnS3VZcmtEKzgvTlo0T01MZjBLeHBOWWEv?=
 =?utf-8?B?bE1sSzZMUTdYMERPVDVFcHRLWm9MdittcExmN0M1K2xVd1dnZEN3eGNuSzlh?=
 =?utf-8?B?MjdmZ1pWc25BVjI1MHVtRnBvT2haRS9VSEJQaDlEeGZzQmlQV09NTjlrdUtC?=
 =?utf-8?B?NGtBUGtQZlRXc0xhdzRqVGJCb3E1dTJrMlcvRUxYM2hyMkZLVWcwd3MxOUh0?=
 =?utf-8?B?RnBWTFBFL0Z0Wm52eWUwQjA0SkZReXhxWm5aWWFlcExtdnV4cmpybWJKT0NM?=
 =?utf-8?B?TUlCdXAzUjFsY3ovSDJ5SFZvR090THc2TEtKbVBzb2wvVkR2L0x0K29yK0ZL?=
 =?utf-8?B?NmRreGszWFVlZUloNGtzZS9IejNNZ2tZSHJsR3FCc1pLVm9FcUZnYUIyOGdR?=
 =?utf-8?Q?bQYJ1A5ObhrlyX20khPoWKTGe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dcTezdOTbP7cHhqq9zSsFza6K0fLbxHH8p2hyvLbWySbn0DDY0wi31K2zi1O8G3fAN4WtyQG9nAlGzxL6hp1H8WzkRtnyIeKtHVZ0KR906gUH/p5bRpz5rHMEkP+F5b2gowv9P8gI67EYh+4Wwk+B9Do63BfPlD0xq0z7McRFT4+fM/HNDbVrTgOPaSiYld+QLFDyrDVw/7BZND40dJ/W9VLiJrxjbjPPSukWFTssn8qi+p2/iYkdMyUEGFh6obwIsYAO+TaobDcBlq+Y2Rx+shul0AVRLYD207foOZplR2934UqwK/udJsr9Ps0EkfyFQyfs87PH8x0ZAxZ6iRuoYfcvbc+3eskInbiYzy33dx3h+7j3Io1ioIz20qH/dqIkQgP7HYqCBT0zrNNUdvqBGue2wTtmh5VyxlKf79FWJ5zsrTnOgN0inPjHiSK5bB+yDJ9AC96v8pIfUlOHApPIYOvXFyePud9DddiGAXJDOCe33Pp/v6WvjUMuGvODIignZJYVr5sIARuSjmzRfDZgU/Rwc6gvhhq06a2zLaWyosO1KV33XbOgOwdVB5/Y+JI6DnRPLXQdfF3+uq+V3M1LW9rTqDpqn5WC4HwteK3GKTsh2LrAZNz2ixlvgykirBQT+4dDnlOJiUGlEFcXnWrX10oKUGsnuweSamoFZIQgkpZaw/lk9JfakQ941Yg/thgURZhTymDfhFfb0zQ8XlRTSmqLDDQqVSJ/RuxjNbu/2zxwV4BnyMPZoxZrrJ9g0o/LwanlenK+NOgQdPZlP6X3Ua3sgl9celLJpOliE2O6agRl8uJm+EzsyPsjaoo1cGgoZBvAS6METJy9rXkEeMthN4RMohy0u9d+0NDylL+mB/JXrWlYso4vd1op5DDFACG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c828deac-6972-4612-9e16-08db944347f3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4264.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 17:01:29.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CQjE/G7EcAPmDIly9ftC50efHFsh14deYAGs4v4gyCwSkRFacNHqqH2icYXOUh5UOMpCvWbR60VzOB9Qs52ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_18,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030152
X-Proofpoint-ORIG-GUID: UDEVVYjlIRFkXgpG8iD06TQLDBZCFGHN
X-Proofpoint-GUID: UDEVVYjlIRFkXgpG8iD06TQLDBZCFGHN
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/3/23 4:27 AM, Jeff Layton wrote:
> On Wed, 2023-08-02 at 16:38 -0700, dai.ngo@oracle.com wrote:
>>   
>>
>>
>>   
>>
>>   
>>
>> On 8/2/23 2:52 PM, Jeff Layton wrote:
>>   
>>
>>   
>>
>>>   
>>>
>>> On Wed, 2023-08-02 at 14:32 -0700, dai.ngo@oracle.com wrote:
>>>   
>>>
>>>>   
>>>>
>>>> On 8/2/23 2:22 PM, dai.ngo@oracle.com wrote:
>>>>   
>>>>
>>>>>   
>>>>>
>>>>> On 8/2/23 1:57 PM, Chuck Lever III wrote:
>>>>>   
>>>>>
>>>>>>    
>>>>>>
>>>>>>>   
>>>>>>>
>>>>>>> On Aug 2, 2023, at 4:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>>
>>>>>>> On Wed, 2023-08-02 at 13:15 -0700, dai.ngo@oracle.com wrote:
>>>>>>>   
>>>>>>>
>>>>>>>>   
>>>>>>>>
>>>>>>>> On 8/2/23 11:15 AM, Jeff Layton wrote:
>>>>>>>>   
>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>> On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>> On 8/1/23 6:33 AM, Jeff Layton wrote:
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>>>   
>>>>>>>>>>>
>>>>>>>>>>> I noticed that xfstests generic/001 was failing against
>>>>>>>>>>> linux-next nfsd.
>>>>>>>>>>>
>>>>>>>>>>> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and
>>>>>>>>>>> the server
>>>>>>>>>>> would hand out a write delegation. The client would then try to
>>>>>>>>>>> use that
>>>>>>>>>>> write delegation as the source stateid in a COPY
>>>>>>>>>>>   
>>>>>>>>>>>
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>> not sure why the client opens the source file of a COPY operation
>>>>>>>>>> with
>>>>>>>>>> OPEN4_SHARE_ACCESS_WRITE?
>>>>>>>>>>
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>> It doesn't. The original open is to write the data for the file being
>>>>>>>>> copied. It then opens the file again for READ, but since it has a
>>>>>>>>> write
>>>>>>>>> delegation, it doesn't need to talk to the server at all -- it can
>>>>>>>>> just
>>>>>>>>> use that stateid for later operations.
>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>>>   
>>>>>>>>>>>
>>>>>>>>>>>     or CLONE operation, and
>>>>>>>>>>> the server would respond with NFS4ERR_STALE.
>>>>>>>>>>>   
>>>>>>>>>>>
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>> If the server does not allow client to use write delegation for the
>>>>>>>>>> READ, should the correct error return be NFS4ERR_OPENMODE?
>>>>>>>>>>
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>> The server must allow the client to use a write delegation for read
>>>>>>>>> operations. It's required by the spec, AFAIU.
>>>>>>>>>
>>>>>>>>> The error in this case was just bogus. The vfs copy routine would
>>>>>>>>> return
>>>>>>>>> -EBADF since the file didn't have FMODE_READ, and the nfs server
>>>>>>>>> would
>>>>>>>>> translate that into NFS4ERR_STALE.
>>>>>>>>>
>>>>>>>>> Probably there is a better v4 error code that we could translate
>>>>>>>>> EBADF
>>>>>>>>> to, but with this patch it shouldn't be a problem any longer.
>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>>>   
>>>>>>>>>>>
>>>>>>>>>>> The problem is that the struct file associated with the
>>>>>>>>>>> delegation does
>>>>>>>>>>> not necessarily have read permissions. It's handing out a write
>>>>>>>>>>> delegation on what is effectively an O_WRONLY open. RFC 8881
>>>>>>>>>>> states:
>>>>>>>>>>>
>>>>>>>>>>>     "An OPEN_DELEGATE_WRITE delegation allows the client to
>>>>>>>>>>> handle, on its
>>>>>>>>>>>      own, all opens."
>>>>>>>>>>>
>>>>>>>>>>> Given that the client didn't request any read permissions, and
>>>>>>>>>>> that nfsd
>>>>>>>>>>> didn't check for any, it seems wrong to give out a write
>>>>>>>>>>> delegation.
>>>>>>>>>>>
>>>>>>>>>>> Only hand out a write delegation if we have a O_RDWR descriptor
>>>>>>>>>>> available. If it fails to find an appropriate write descriptor, go
>>>>>>>>>>> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
>>>>>>>>>>> requested.
>>>>>>>>>>>
>>>>>>>>>>> This fixes xfstest generic/001.
>>>>>>>>>>>
>>>>>>>>>>> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
>>>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>>>> ---
>>>>>>>>>>> Changes in v2:
>>>>>>>>>>> - Rework the logic when finding struct file for the delegation. The
>>>>>>>>>>>      earlier patch might still have attached a O_WRONLY file to
>>>>>>>>>>> the deleg
>>>>>>>>>>>      in some cases, and could still have handed out a write
>>>>>>>>>>> delegation on
>>>>>>>>>>>      an O_WRONLY OPEN request in some cases.
>>>>>>>>>>> ---
>>>>>>>>>>>     fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
>>>>>>>>>>>     1 file changed, 18 insertions(+), 11 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>>>>>> index ef7118ebee00..e79d82fd05e7 100644
>>>>>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>>>>>> @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open
>>>>>>>>>>> *open, struct nfs4_ol_stateid *stp,
>>>>>>>>>>>      struct nfs4_file *fp = stp->st_stid.sc_file;
>>>>>>>>>>>      struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
>>>>>>>>>>>      struct nfs4_delegation *dp;
>>>>>>>>>>> - struct nfsd_file *nf;
>>>>>>>>>>> + struct nfsd_file *nf = NULL;
>>>>>>>>>>>      struct file_lock *fl;
>>>>>>>>>>>      u32 dl_type;
>>>>>>>>>>>
>>>>>>>>>>> @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open
>>>>>>>>>>> *open, struct nfs4_ol_stateid *stp,
>>>>>>>>>>>      if (fp->fi_had_conflict)
>>>>>>>>>>>      return ERR_PTR(-EAGAIN);
>>>>>>>>>>>
>>>>>>>>>>> - if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>>>>>>>> - nf = find_writeable_file(fp);
>>>>>>>>>>> + /*
>>>>>>>>>>> + * Try for a write delegation first. We need an O_RDWR file
>>>>>>>>>>> + * since a write delegation allows the client to perform any open
>>>>>>>>>>> + * from its cache.
>>>>>>>>>>> + */
>>>>>>>>>>> + if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>>>>>>>>>> NFS4_SHARE_ACCESS_BOTH) {
>>>>>>>>>>> + nf = nfsd_file_get(fp->fi_fds[O_RDWR]);
>>>>>>>>>>>      dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>>>>>>>> - } else {
>>>>>>>>>>>   
>>>>>>>>>>>
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>> Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write
>>>>>>>>>> delegation?
>>>>>>>>>> It does not seem right.
>>>>>>>>>>
>>>>>>>>>> -Dai
>>>>>>>>>>
>>>>>>>>>>   
>>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>> Why? Per RFC 8881:
>>>>>>>>>
>>>>>>>>> "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on
>>>>>>>>> its
>>>>>>>>> own, all opens."
>>>>>>>>>
>>>>>>>>> All opens. That includes read opens.
>>>>>>>>>
>>>>>>>>> An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to which the
>>>>>>>>> user has no read permissions. Therefore, we can't grant a write
>>>>>>>>> delegation since can't guarantee that the user is allowed to do that.
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>   
>>>>>>>>
>>>>>>>> If the server grants the write delegation on an OPEN with
>>>>>>>> OPEN4_SHARE_ACCESS_WRITE on the file with WR-only access mode then
>>>>>>>> why can't the server checks and denies the subsequent READ?
>>>>>>>>
>>>>>>>> Per RFC 8881, section 9.1.2:
>>>>>>>>
>>>>>>>>       For delegation stateids, the access mode is based on the type of
>>>>>>>>       delegation.
>>>>>>>>
>>>>>>>>       When a READ, WRITE, or SETATTR (that specifies the size
>>>>>>>> attribute)
>>>>>>>>       operation is done, the operation is subject to checking
>>>>>>>> against the
>>>>>>>>       access mode to verify that the operation is appropriate given the
>>>>>>>>       stateid with which the operation is associated.
>>>>>>>>
>>>>>>>>       In the case of WRITE-type operations (i.e., WRITEs and
>>>>>>>> SETATTRs that
>>>>>>>>       set size), the server MUST verify that the access mode allows
>>>>>>>> writing
>>>>>>>>       and MUST return an NFS4ERR_OPENMODE error if it does not. In
>>>>>>>> the case
>>>>>>>>       of READ, the server may perform the corresponding check on the
>>>>>>>> access
>>>>>>>>       mode, or it may choose to allow READ on OPENs for
>>>>>>>> OPEN4_SHARE_ACCESS_WRITE,
>>>>>>>>       to accommodate clients whose WRITE implementation may
>>>>>>>> unavoidably do
>>>>>>>>       reads (e.g., due to buffer cache constraints). However, even
>>>>>>>> if READs
>>>>>>>>       are allowed in these circumstances, the server MUST still
>>>>>>>> check for
>>>>>>>>       locks that conflict with the READ (e.g., another OPEN specified
>>>>>>>>       OPEN4_SHARE_DENY_READ or OPEN4_SHARE_DENY_BOTH). Note that a
>>>>>>>> server
>>>>>>>>       that does enforce the access mode check on READs need not
>>>>>>>> explicitly
>>>>>>>>       check for conflicting share reservations since the existence
>>>>>>>> of OPEN
>>>>>>>>       for OPEN4_SHARE_ACCESS_READ guarantees that no conflicting share
>>>>>>>>       reservation can exist.
>>>>>>>>
>>>>>>>> FWIW, The Solaris server grants write delegation on OPEN with
>>>>>>>> OPEN4_SHARE_ACCESS_WRITE on file with access mode either RW or
>>>>>>>> WR-only. Maybe this is a bug? or the spec is not clear?
>>>>>>>>
>>>>>>>>   
>>>>>>>>
>>>>>>>   
>>>>>>>
>>>>>>> I don't think that's necessarily a bug.
>>>>>>>
>>>>>>> It's not that the spec demands that we only hand out delegations on
>>>>>>> BOTH
>>>>>>> opens.  This is more of a quirk of the Linux implementation. Linux'
>>>>>>> write delegations require an open O_RDWR file descriptor because we may
>>>>>>> be called upon to do a read on its behalf.
>>>>>>>
>>>>>>> Technically, we could probably just have it check for
>>>>>>> OPEN4_SHARE_ACCESS_WRITE, but in the case where READ isn't also set,
>>>>>>> then you're unlikely to get a delegation. Either the O_RDWR descriptor
>>>>>>> will be NULL, or there are other, conflicting opens already present.
>>>>>>>
>>>>>>> Solaris may have a completely different design that doesn't require
>>>>>>> this. I haven't looked at its code to know.
>>>>>>>   
>>>>>>>
>>>>>>   
>>>>>>
>>>>>> I'm comfortable for now with not handing out write delegations for
>>>>>> SHARE_ACCESS_WRITE opens. I prefer that to permission checking on
>>>>>> every READ operation.
>>>>>>   
>>>>>>
>>>>>   
>>>>>
>>>>> I'm fine with just handling out write delegation for SHARE_ACCESS_BOTH
>>>>> only.
>>>>>
>>>>> Just a concern about not checking for access at the time of READ
>>>>> operation.
>>>>>   
>>>>>
>>>>   
>>>>
>>>> or not checking file permission at the time WRITE.
>>>>   
>>>>
>>>>>   
>>>>>
>>>>> If the file was opened with SHARE_ACCESS_WRITE (no write delegation
>>>>> granted)
>>>>> and the file access mode was changed to read-only, is it a correct
>>>>> behavior
>>>>> for the server to allow the READ to go through?
>>>>>   
>>>>>
>>>>   
>>>>
>>>> I meant for the WRITE to go through.
>>>>   
>>>>
>>>   
>>>
>>> Yes:
>>>
>>> POSIX permissions enforcement is done at open time, not when doing
>>> actual reads and writes. If you open a file on (e.g.) xfs and start
>>> streaming writes to it, then you don't expect that you will lose the
>>> ability to write to that fd if the permissions change.
>>>
>>> In the old v2/3 days of stateless NFS, we had to check permissions on
>>> every READ or WRITE operation, but we generally did an open on every RPC
>>> too, so it just worked out that we checked permissions on each
>>> operation.
>>>
>>> With v4 we can better approximate POSIX semantics by just associating a
>>> stateid with an open file to allow the client to keep writing in this
>>> case.
>>>   
>>>
>>   
>>
>> Thanks Jeff,
> Don't thank me yet. I went back and looked at the code, and it looks
> like we still do check permissions on every READ/WRITE (see
> nfs4_check_file).
>
> I'm unclear on whether that's required, but it's probably safest to
> always check permissions like we are. That does mean that if the mode of
> the file changes after we open it we could end up being unable to read
> or write to it (much like with v2/3), but at this point most people are
> used to that sort of behavior on NFS, so I don't worry about it too
> much.

It might not conform to Posix permissions enforcement but I like what
the server is doing right now, correctness of permissions enforcement
and consistent behavior of v2/3/4.

-Dai

