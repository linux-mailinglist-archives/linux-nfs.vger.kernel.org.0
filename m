Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC3D6E562A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 03:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDRBFM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 21:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDRBFL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 21:05:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FB740C8
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 18:05:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLSxOQ020221;
        Tue, 18 Apr 2023 01:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=myVNaQQtKtBxOir9OWPQGxBLpY3/O3RZK88cHx5Nxbs=;
 b=pbSl7vjb4qsir5za4mh/4aM4NPMSMsnNMTGUSw3krWthTQp46zAcsUjPBfoiNLnuwTMF
 3Q34Fp7pMdfTm9INe1eTNfcxqgg2CtPLfQCA1Yx3UgcUTg5CkYf1UHlyAcxrsoVje8xr
 GBnx2eq4cgShuacJ4+POMUTk0VokG5Od5tmK5AnLrLTfVEblxc6StsnoJmGMGm86m3Sw
 VJYSAbDapnhIh2HFApY+lQAEAkMUZ22lPBHNEWIMg/x4iivVrPuHyHOiWPZ1hOcf3E5z
 rv9fQSm5fQVOVAxJKKXqmt+p68lMBnuikOQlUUxAyGdMkHSwpdtsuZRNWLeiU+mFNTun vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykycvh6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 01:05:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33I0Ur4p032063;
        Tue, 18 Apr 2023 01:05:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcavgxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 01:05:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzmUza6yHelOxFRCfKuVpESBcx+S/u7S0eDTOLvWpYAVcp8Oj35WoWwugnHkBxCm2U3IkDKj4NHcszcI6omgf449hHr70ZvNTBmn+UO/jiX1xkltsP1kK5uRYWp+J/pLIJZE5lfcncTXdp0x0wx9JbpFak4LXbpNtSlcWpH7QxzT1zx52wxe/CfCZwfaNISjESEbq2iiUttsL2PL8fcUmqkHVDcLO559d0HiJO2ZPD9LLFa3huNiRELHHl8gmAdJDqWchcKcIU3cEZ5Suazd6AnCkBf80Ywu7sGsb6B2y1owAABXr9TY4NYzR5lJM6XSYrQs/Ej1y9iTCmLV/yBWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myVNaQQtKtBxOir9OWPQGxBLpY3/O3RZK88cHx5Nxbs=;
 b=IOfHTfzOBDOWWI4FkzbnSrXq7Xi4FAppmU2zG+ta5ZBb7S7yfwDunvwKyxbdNMxq1jvqx0XEmnt6ow7wamuvGYRK30OJ6aS5uDQrUl/9VOw3syoqjcBpFXutMOHL8//y3dCESF6tph683OYoa9kG69wfEVt/Zgw5IKEpNEpQupCX4PQhl/Hsj+lcm9fLBWEEtaBlF5sQ4cH/vZv6wdzBTNSWnJhKRtFnhdxW6UBl5CFRf42MaXx4ajB1niXV/vU2Qt1mdDndu6RfMZDwC+rxr3QYBkI2SYgMJT9KS0+IeicBxwj885tJy3v6OurwH3R9loe474OxvJFPo8w3JsSWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myVNaQQtKtBxOir9OWPQGxBLpY3/O3RZK88cHx5Nxbs=;
 b=CQZdSoJF6ZMzJCr602OcK8fq2U2wkmEl9dAm2ddBAemeMIhc0KeeutZLTgPtoCJR9gEmFTH2W5WMBw1xLgQtgf2vrsesXowpZ4llLwvgtCh4jWqNWIxrzVqzC2wMIhGAwMjWbn6pVQG70nSCxa9wb/IwRIxn2y9+iRRTbr379o0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA2PR10MB4476.namprd10.prod.outlook.com (2603:10b6:806:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 01:04:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 01:04:59 +0000
Message-ID: <ce2dbad5-cbbf-4173-0eb2-5113227837b5@oracle.com>
Date:   Mon, 17 Apr 2023 18:04:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
 <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
 <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
 <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
 <19bf7b21-fc68-5281-e587-b7d290899456@oracle.com>
 <d0a5cf8b8c8dbdbf83658b9456afb798af5d7941.camel@hammerspace.com>
 <00fe5d5a-43b8-0f0e-2afe-ae68367f822d@oracle.com>
 <d16f1877626966d854db8c5f82cc37e5b665c5af.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <d16f1877626966d854db8c5f82cc37e5b665c5af.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:5:120::41) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA2PR10MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 453802a7-c7fe-4944-2d62-08db3fa8ee5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGogSg+QxNBWrbOoNOQzHP+4XFst9uN3hLrnOSNgUNt9hhFbPTBhWUl3QtgZ27Z4J/55wTUjelvrSeUm93nHzcgi+VDonCGF8eX0Xuvl4uWP+fjGa8XJiAGSo0RT9NEcrKH8t6TnvvMrZlbdjnt5LCmZlWJ+9MSWJAfHlv+boWiM13hdVG7ZCZS8ZcnrqK7TagKkCimAvkxMQ78UXb5cWbzxTHHjMAfnFLXN2lx2ikwlYc4dH6rK3KjM4Z2vV0X7gtN3zWYTqV2++zVigB2YcuGU8pWNbpbZTF91Dl47ZPPdrMhfAF2Zse9cpKfI/d8kwgZKxwiVRDGgt8uZh5tAALH0OXeqDUK2UJcf0EklFNdAXqAx3fcUSpFduL4D33Sgy2Z4nPjxQejt4b7/KbeXje9OISFRvcgnTIQLL5sXDJkiPPM6wYHs5+mUjzOHJYJdya4aJVcxcQCFIYt8dSCaBKHe5ACHkV3MM0RdkcLNveeNv65nFN9vFKfBgr9aGT3484eadSyP9khH4SGKh+8vIlaavvUVXhxym1o0IKR9PqpCVR+uPCkRTi3YJ7oT4awbaGzcTPKfCP7kerzSuFblLJlgmrLI5eCtduxRkap4/aFzfGdYXpL+zEKJaN4JgPyS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(5660300002)(86362001)(2616005)(6512007)(31696002)(83380400001)(186003)(9686003)(53546011)(26005)(6506007)(38100700002)(8676002)(8936002)(478600001)(54906003)(110136005)(6486002)(6666004)(316002)(41300700001)(36756003)(66476007)(66556008)(4326008)(66946007)(31686004)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2VDdWt4SWlTQVdkcVJudFZ5Y0JuWUNUMGdsQW83bDVhSHdIOEtqaEJPMDZZ?=
 =?utf-8?B?NURDUHYvUFJZbVhNWnIrclpYQnhaZGZhNHkwK1BQS0lEZmF2M0lmb2FUWDBU?=
 =?utf-8?B?Yyt3am9pQzJvN3hkNUk4dlZ1OGdrNHFtVVJaT3BURFZ5Q3I1TjFlTDI5bmJE?=
 =?utf-8?B?dlNUUVRIalJsWXQ4ekw3QTJGc0oyd3A3K3JRV2lObzQvWXhHSHUySUVxRUFh?=
 =?utf-8?B?Y3VIMjl0RWk3ZFE1a1hrbjVrcmNCdFFtVzBiTGhkZFhzSHB0M0d6ZWI4R1RI?=
 =?utf-8?B?TjJDNVNVeXNRVE50cHVIK1FxUmZZSmVOM2VXRTNaK1VJVXFPc2U2WUI0ajYw?=
 =?utf-8?B?YWFvaFl3U3NBTDJoUzllaytJd0VtaGxFOHkxMUhFYzhjcTZTY0dLbzJ0N1VM?=
 =?utf-8?B?c24xSzg2L2F3bi9HNHNkbGlXQks3alRBbGNLK1N3V1llNGVsZEJVRUhqWXFj?=
 =?utf-8?B?YWpKaFZ3UGFKOEZielA0aDRaTDA0YmJEWEl4ZFZyeE9FSFR0WXhsM2xBOTlR?=
 =?utf-8?B?YmZJSEF3cXMvQ1d1bXZ0RkpsVG40dUMvQjNEY0hDZUZZaHRyK0dPbEg3WWw5?=
 =?utf-8?B?WWZpdUZMcTNISUwwa1NlZElvdzFwTU14a2tmeUdGaVBUakh5aHplQ0RmcFZX?=
 =?utf-8?B?N01uTDZNOXZaWktPMFlVSG1vRG8vNjF5akFXa05zSjJoelRINVkzMW5IbVM3?=
 =?utf-8?B?YmduejBlZVNYWFI3Z1hvUnpjc3pyMXFnMC83Y3dKYnZvZWZKNHVCT2p3cWN0?=
 =?utf-8?B?VUhaREVOekgyalk3MXpobEE1S1ZjOXVRUmJLSXFwNUczeDBHNE04dzZIcFBM?=
 =?utf-8?B?QzFHUW1pa3dqOUY3aElWcVpRaXJtRE44eGpOeXE1Z2VpOUhUTzZRODBFd2NE?=
 =?utf-8?B?Q2EvNUNjNmZFMDVFaURMeFc4TlRibXd4bU5vM29oVjNzYm04OTBBRVphRXZJ?=
 =?utf-8?B?SFArc2Q3dzlYL3VHZXhjTlluVkR0Y3JNRXJlVUZSdjZZdGhibWoyUTJ0My82?=
 =?utf-8?B?czY2R3NIeDkyUldtQ2NITnpndURNU0h6UzdySmxEeHVDRzNJb0pLSkRucDA4?=
 =?utf-8?B?VVBSeXorUzFZVEZseEpKTzhzMGl0WitJNmxQNzFNNXBOWnArbGpVUTNFdVA0?=
 =?utf-8?B?UWZ4YnAwWTYwelRxSUVXSlJwNWpZRUtuTnpZcStZRmt4U25PQVFwVS95TXBO?=
 =?utf-8?B?dGlIVEdpY21kcE4zaEdaeDN0TVRrc2ZVYXZsQ3FSZUM2SllIM2VGYWpwd1Fn?=
 =?utf-8?B?YktsUjN3ZHlxSEkxM1dnZ1NJU1FBNGVza3lQcE1mYlNaRmdEcEtNWXRjYWta?=
 =?utf-8?B?c2lRZCtoSExIUVBjMXplTS91R1ZRNWJ5QXpPMHcrcDNNNENaTHdoa2tLNVlv?=
 =?utf-8?B?eWF0dGoraG1zUmt5bnV1WWFNU2VHWDVGU3lQcFdvTFNQNW5RWGlBcFZxa0Fn?=
 =?utf-8?B?YXNZbHJiYXViMWJZM3daV3pmTWhUVmM5WFJNR2p4bExiVDdOWllvTjRXbVJP?=
 =?utf-8?B?eFpGYWUwZUVoVE9SOTFkUHZzMlUxTlVqMCtjSkh6d3VlTkgxMUFPZ0VoT2pC?=
 =?utf-8?B?K0szd3ZsS2J3QnkxeDB4SFVPdHdKWEFZNVJDdy8wN3k1dFN0VmF3MXovZ1lB?=
 =?utf-8?B?L1Z6VHhqOGRSQ1E4M3o1YW9aNmhBbUZRWXlLclBHMURES1JLQlgzaTVia0JU?=
 =?utf-8?B?Ym9leUxwTFlrUS80SVJwSDhndENLSjRrUElMNlV6dXdIMHNpR243M2J0UTRI?=
 =?utf-8?B?aER0RGRuRmhYQVpkSDJPT29XekRaUkZPRkhYMkpkRnBHeGtYM0NyNURkMFQr?=
 =?utf-8?B?SmR2SmZwMmtxSTlhRjRJNjA1ZXV3MGJwT21ZTjZKdXVXaEI0R3lQL1kvTkZz?=
 =?utf-8?B?aXk5ZmV0KzNORk1GMjBOSm5jSk43cVliSGErZHpIUnVRMTFqbUdhaHFMbC8z?=
 =?utf-8?B?QjJJMFpOQlpCS2RXSzY4bjBaMGpiR2MzbDR1a2g0c0djQXR5a3VrQzJ4dUJT?=
 =?utf-8?B?MUZpaDhkVUtBVVVHc3BuakZJU2NYdkpTSUFnd01PbUhxT1BhSnNleklUSWtl?=
 =?utf-8?B?OWxYK1hyajl0aVJCWndsSVB0ZkYwYXVsekNoQTVxRVNNTzQyNXkxSzBvajJI?=
 =?utf-8?Q?Z3oONSMplvnTH7Sv//9UtwdHu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vLila6xUVShTJcKtVU4rmQ3t4RNWunCIYNzRX9KwL0Bk+i4Uqoy4Wrw4jn3mz1nM4hDmxpxhBworAICTzNIMXn+04uwSkMPbGmHy5PSBraxznKtLpAhxuhf5vuQzoPPO1O/vQGrUUzS5izxcMHvwfEbg4UEMSJhlcO0jAh+gdNXGxY8oUPex5r8jaljObRfnnYkr5mxdE2czyQimpMKQqHnPWZWzeetLSU5VuMsSdOEnq8iN8D4yswpcYvY7IGmhXX/eAto6KrnOrY5iu8y/fyZlEDgJP8QLD5Dor0w0kX5ar1oyQ+rMNwKhyEKlgulwe8k3EGlxhrsuOqZoT5wwIWF6ShOR3QNG3ubaqofihSGDzFQM0+L+uumVb9zer9USCWAwCd99ixM7IIAce4W+L/53pS7j+lxNDN3QN1UDZjcF1hjGDYwc9jIIxoolKD5NWsvU2PXef6dF0iWSFD1oI2iFE2/mSV0nuca3ZRfgqO8E8fdich35x7fyusBVI81MhpfRrot9Q9q9GR2siaLla0RYSq98QYHPCGDf/PxhPGUDxTnybiSZEvztx65mpzM9KiieqkVKTBLNFEq/KFToGCp6I/vXlNCIsAq2nBU/8R6kZncgCAfBphz9DooFdSn//iAGcf+5gfc35AVtwHWZbGak1/dCZX0pK6KFvkJ22QTt0lAfSexv9SBUITP0tMxyN9cC68mfJMjB79z70Se32go9R3J/cHbhUAasurBl6scybB2ljRqf6YnDzl8cj5x4uUkW/eLtmF51088XEuUxUlhc7Y3U4KubapmKx5llHtSvVzfuH1mtqEwJH8vJiYKH0YcT4raDA/YrJ1AaRie9rQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453802a7-c7fe-4944-2d62-08db3fa8ee5d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 01:04:59.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lG0QnN8yfH9UMy1YMRVIRbYEzlM7H+oKu9Kt97S95pX3GmHFaX+y95BrZ9PWEEjHfyanaa3Ca2vhUOF3PmwQmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180008
X-Proofpoint-GUID: zfCoyJsr-OHvFytGiUx1e0tLSJ_Q3ctx
X-Proofpoint-ORIG-GUID: zfCoyJsr-OHvFytGiUx1e0tLSJ_Q3ctx
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/17/23 5:23 PM, Trond Myklebust wrote:
> On Mon, 2023-04-17 at 16:14 -0700, dai.ngo@oracle.com wrote:
>> On 4/17/23 2:53 PM, Trond Myklebust wrote:
>>> On Mon, 2023-04-17 at 14:51 -0700, dai.ngo@oracle.com wrote:
>>>> On 4/17/23 2:48 PM, Trond Myklebust wrote:
>>>>> On Mon, 2023-04-17 at 21:41 +0000, Chuck Lever III wrote:
>>>>>>> On Apr 17, 2023, at 4:49 PM, Trond Myklebust
>>>>>>> <trondmy@hammerspace.com> wrote:
>>>>>>>
>>>>>>> On Fri, 2023-04-07 at 20:30 -0700, Dai Ngo wrote:
>>>>>>>> Currently call_bind_status places a hard limit of 9
>>>>>>>> seconds
>>>>>>>> for
>>>>>>>> retries
>>>>>>>> on EACCES error. This limit was done to prevent the RPC
>>>>>>>> request
>>>>>>>> from
>>>>>>>> being retried forever if the remote server has problem
>>>>>>>> and
>>>>>>>> never
>>>>>>>> comes
>>>>>>>> up
>>>>>>>>
>>>>>>>> However this 9 seconds timeout is too short, comparing to
>>>>>>>> other
>>>>>>>> RPC
>>>>>>>> timeouts which are generally in minutes. This causes
>>>>>>>> intermittent
>>>>>>>> failure
>>>>>>>> with EIO on the client side when there are lots of NLM
>>>>>>>> activity
>>>>>>>> and
>>>>>>>> the
>>>>>>>> NFS server is restarted.
>>>>>>>>
>>>>>>>> Instead of removing the max timeout for retry and relying
>>>>>>>> on
>>>>>>>> the
>>>>>>>> RPC
>>>>>>>> timeout mechanism to handle the retry, which can lead to
>>>>>>>> the
>>>>>>>> RPC
>>>>>>>> being
>>>>>>>> retried forever if the remote NLM service fails to come
>>>>>>>> up.
>>>>>>>> This
>>>>>>>> patch
>>>>>>>> simply increases the max timeout of call_bind_status from
>>>>>>>> 9
>>>>>>>> to 90
>>>>>>>> seconds
>>>>>>>> which should allow enough time for NLM to register after
>>>>>>>> a
>>>>>>>> restart,
>>>>>>>> and
>>>>>>>> not retrying forever if there is real problem with the
>>>>>>>> remote
>>>>>>>> system.
>>>>>>>>
>>>>>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM
>>>>>>>> unlock
>>>>>>>> requests")
>>>>>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>>>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> ---
>>>>>>>>     include/linux/sunrpc/clnt.h  | 3 +++
>>>>>>>>     include/linux/sunrpc/sched.h | 4 ++--
>>>>>>>>     net/sunrpc/clnt.c            | 2 +-
>>>>>>>>     net/sunrpc/sched.c           | 3 ++-
>>>>>>>>     4 files changed, 8 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/include/linux/sunrpc/clnt.h
>>>>>>>> b/include/linux/sunrpc/clnt.h
>>>>>>>> index 770ef2cb5775..81afc5ea2665 100644
>>>>>>>> --- a/include/linux/sunrpc/clnt.h
>>>>>>>> +++ b/include/linux/sunrpc/clnt.h
>>>>>>>> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>>>>>>>>     #define RPC_CLNT_CREATE_REUSEPORT      (1UL << 11)
>>>>>>>>     #define RPC_CLNT_CREATE_CONNECTED      (1UL << 12)
>>>>>>>>     
>>>>>>>> +#define        RPC_CLNT_REBIND_DELAY           3
>>>>>>>> +#define        RPC_CLNT_REBIND_MAX_TIMEOUT     90
>>>>>>>> +
>>>>>>>>     struct rpc_clnt *rpc_create(struct rpc_create_args
>>>>>>>> *args);
>>>>>>>>     struct rpc_clnt        *rpc_bind_new_program(struct
>>>>>>>> rpc_clnt *,
>>>>>>>>                                    const struct
>>>>>>>> rpc_program *,
>>>>>>>> u32);
>>>>>>>> diff --git a/include/linux/sunrpc/sched.h
>>>>>>>> b/include/linux/sunrpc/sched.h
>>>>>>>> index b8ca3ecaf8d7..e9dc142f10bb 100644
>>>>>>>> --- a/include/linux/sunrpc/sched.h
>>>>>>>> +++ b/include/linux/sunrpc/sched.h
>>>>>>>> @@ -90,8 +90,8 @@ struct rpc_task {
>>>>>>>>     #endif
>>>>>>>>            unsigned char           tk_priority : 2,/* Task
>>>>>>>> priority
>>>>>>>> */
>>>>>>>>                                    tk_garb_retry : 2,
>>>>>>>> -                               tk_cred_retry : 2,
>>>>>>>> -                               tk_rebind_retry : 2;
>>>>>>>> +                               tk_cred_retry : 2;
>>>>>>>> +       unsigned char           tk_rebind_retry;
>>>>>>>>     };
>>>>>>>>     
>>>>>>>>     typedef void                   (*rpc_action)(struct
>>>>>>>> rpc_task *);
>>>>>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>>>>>> index fd7e1c630493..222578af6b01 100644
>>>>>>>> --- a/net/sunrpc/clnt.c
>>>>>>>> +++ b/net/sunrpc/clnt.c
>>>>>>>> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task
>>>>>>>> *task)
>>>>>>>>                    if (task->tk_rebind_retry == 0)
>>>>>>>>                            break;
>>>>>>>>                    task->tk_rebind_retry--;
>>>>>>>> -               rpc_delay(task, 3*HZ);
>>>>>>>> +               rpc_delay(task, RPC_CLNT_REBIND_DELAY *
>>>>>>>> HZ);
>>>>>>>>                    goto retry_timeout;
>>>>>>>>            case -ENOBUFS:
>>>>>>>>                    rpc_delay(task, HZ >> 2);
>>>>>>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>>>>>>> index be587a308e05..5c18a35752aa 100644
>>>>>>>> --- a/net/sunrpc/sched.c
>>>>>>>> +++ b/net/sunrpc/sched.c
>>>>>>>> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct
>>>>>>>> rpc_task
>>>>>>>> *task)
>>>>>>>>            /* Initialize retry counters */
>>>>>>>>            task->tk_garb_retry = 2;
>>>>>>>>            task->tk_cred_retry = 2;
>>>>>>>> -       task->tk_rebind_retry = 2;
>>>>>>>> +       task->tk_rebind_retry =
>>>>>>>> RPC_CLNT_REBIND_MAX_TIMEOUT /
>>>>>>>> +
>>>>>>>> RPC_CLNT_REBIND_DELAY;
>>>>>>> Why not just implement an exponential back off? If the
>>>>>>> server
>>>>>>> is
>>>>>>> slow
>>>>>>> to come up, then pounding the rpcbind service every 3
>>>>>>> seconds
>>>>>>> isn't
>>>>>>> going to help.
>>>>>> Exponential backoff has the disadvantage that once we've
>>>>>> gotten
>>>>>> to the longer retry times, it's easy for a client to wait
>>>>>> quite
>>>>>> some time before it notices the rebind service is available.
>>>>>>
>>>>>> But I have to wonder if retrying every 3 seconds is useful if
>>>>>> the request is going over TCP.
>>>>>>
>>>>> The problem isn't reliability: this is handling a case where we
>>>>> _are_
>>>>> getting a reply from the server, just not one we wanted. EACCES
>>>>> here
>>>>> means that the rpcbind server didn't return a valid entry for
>>>>> the
>>>>> service we requested, presumably because the service hasn't
>>>>> been
>>>>> registered yet.
>>>> That's correct.
>>>>
>>>>> So yes, an exponential back off is appropriate here.
>>>> I think Chuck's point is still valid. It makes the client a
>>>> little
>>>> more
>>>> responsive; does not have to wait that long, and the overhead of
>>>> a
>>>> RPC
>>>> request every 3 seconds is not that significant.
>>> It is when you do it 30 times before giving up.
>> This is true for a dead NFS server, we save 25 RPC calls in a period
>> of ~90 seconds.
>>
>> In the case of a head failover and the NFS service on the takeover
>> head can take up to 15 seconds to restart to pick up the new exports
>> from the fail head, then the client can potentially wait up to ~20
>> seconds, after the NFS server is ready, to resume normal operation.
>> IMHO, it's a 'long' time and I'd prioritize speed over saving some
>> overhead.
>>
> task->tk_rebind_retry is _only_ changed if the rpcbind server is up and
> running, and returns an empty reply because the service we're looking
> up isn't registered.
> task->tk_rebind_retry isn't changed on any request timeout. It isn't
> changed on any connection failure. It isn't changed by any other code
> path in the RPC client.
>
> So none of this applies to the case of a dead server.

Sorry if I'm not clear. What I meant by a dead server is a dead NFS
server and not rpcbind service. So in this case we get EACCES from
rpcbind and we retry.

>
> It applies to the case of a live server, where rpcbind is running and
> accessible to the client and where, for some reason or another, it is
> taking an exceptionally long time to register the service we are
> looking up the port for (either NLM or NFSv3).

Yes, this is the problem that I'm facing.

>
> So where are you seeing this process take 90 seconds? Why do we need to
> wait for that long before we can finally conclude that the particular
> service in question is not going to come back up?

90 secs wait is for when the NFS server never come up and we keep getting
EACCES from rpcbind for this whole time.

-Dai

