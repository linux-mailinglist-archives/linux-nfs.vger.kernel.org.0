Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57316A0268
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 06:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjBWFkq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 00:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWFkp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 00:40:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA343905
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 21:40:44 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N1ngBW017332;
        Thu, 23 Feb 2023 05:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XKKviFuZ6uy2WEPDDuTEMhKmCYG2ruEtolMWiKx+QSQ=;
 b=YSsdYh1jo1vZNjQ7CE8BtfTBKQ+/IiKh+BYqCdSpnGah7TwM3HDlua7fBckq0WGdbbZn
 6xLOUTun1sCQmqgLWco2NASnaPpgu0XkhvHvvj8RqfHpuZns3cXVb47uGgGVmTCZKaO3
 vdxtGd84a8+5vxzxt5Vyz9f4++A18KxGap5wuMytknRRNyas9taDKkVI0FYTBWY815VT
 cUG9Af3dsQVMJeWQ35LKkIvYOLcE2WSDkp1e+XZd82Gs/Tk7Ux1OI3L0JIl/8ymOVxRS
 bcngutf5AeJvD+03UD+s1K/qrqMQw+kpMPrckNTCcbRDpCXjfNEHbhySlc/5nl06xGnF Mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90sp1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 05:40:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31N4F9Jc027401;
        Thu, 23 Feb 2023 05:40:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn47shc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 05:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzpmJSRi8Tmh0JBQDQ8OW4P1W1Z7+0MltQXvzQRZ2V9wVkewgDXm90KooZH0HVeCx2gGsrDxsT7C9A7DL+U3eYtAQr/lZpa6LiuXP/EzbKlcm46AE54V2xgGG3D3KNb4HaYDVHgmYRtnhwQ7XZjGd45RhCKT6fdkkfIi7aXRTF39SUJJ8VgDrpGWXWHK6in6qXya7SHFesM7sLNARvsT6JUKVGkw/DeMOzxO3md/PvoxAdQC3lMW6+o+4kvqxaSuIHsNlA5c/D23o5S+Uj0ZjVxwnGvpyue/kAFu15NUdA45VZs4knOwULUW/zm3sx6hHKq6JcqRsMMOqYaS45o7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKKviFuZ6uy2WEPDDuTEMhKmCYG2ruEtolMWiKx+QSQ=;
 b=ZHdi8wGCUrMNwDTYv3eJZuNRnCCCiKkLfhbMBb5uS260USaRWNXsgoT7wtMsYWItCkGvVulMbPhs8bkOY2Id000fxel+AnNzg8CsX5AzG6YgOqd0wRicx/RGmfCcu8k6fKUD5nX05XUtVYNFd0XYLGRKw7DF0uZKjxL9pG8PWx6ecq4ulwCbzy89x2eMFDyXvHqvilVbHh2QgMV7gLTOxUMHhWcxl0obVOPyQPbZNVEvo1nCvkRvnjdWRB179sVW3At+gk0ogSQ4tlsvZGKzlEfwKa0KKMN0rsQCelzs49YiKM/BWdKr3WwLxbASeP4YtEsrgKDVDDpkyKgLqKhy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKKviFuZ6uy2WEPDDuTEMhKmCYG2ruEtolMWiKx+QSQ=;
 b=H7w/5Xze8fGJ2kVayugtdeXFEg5WB/WgzBoRMHstpfKb8I7SlIJQf6ympmmHMpa/pnCcr2knQ+lzjcQ6469vXiKJW7QV0I/HrGiygs+FGti9cUSbVDHMGoXwTE/LgJuy/ztFTHRthYBB/VcR/qBDsYcwgbicfI2TtQW+oCTkNhM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Thu, 23 Feb
 2023 05:40:36 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b%5]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 05:40:36 +0000
Message-ID: <3165b445-f4da-3dfd-7036-712b605865be@oracle.com>
Date:   Wed, 22 Feb 2023 21:40:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/1] SUNRPC: increase max timeout for rebind to handle
 NFS server restart
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
References: <1676016656-26195-1-git-send-email-dai.ngo@oracle.com>
 <d0673e79-fa19-3452-0fef-f2c06683037c@oracle.com>
In-Reply-To: <d0673e79-fa19-3452-0fef-f2c06683037c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0070.namprd12.prod.outlook.com
 (2603:10b6:802:20::41) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ef91af-21f9-4c8a-64b0-08db15607cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlOv+RWo7uQWFzw52ZEmHmGPenNQmzpSCNleLPsqpx7OVLimeb2RuR2Z3QiQcxuHIj2mvWafdk5lwcYrR5ywjaglgciAg3mOZPTXj7/s4LXU9s7ssKeCFJhrEYWCGc1xBqeoPWA/5288OZ43hKCnmyiqjPltgZWldN4I6KBEkYXNCwC1rPyUZpvHsvefAGaRYObbYylNgaOQVvHnEtJ6wf0AAOINMuWS4oUSCKOxKUrjMCFqM3jjL0/4FYaLaV3TK1HDC4Ph508oQYgh/Iwb6GANkTmdjyeaLqQe40ULeO9NKgLorJzmzVIAYpWWnK6Ql7wAUpE+L56oXBcAfr5yT1xVPHPXboaVTAwELCSFhAHe5yYxLmftlTYjAii6tNb1u/9Ec9gcYdF/c1BNUQLogqo3SbOYEQM6uxQeKtPcZgo2ou/B7JVveBWjNsWrJe2yTxzWLb64wERzTeuO9PRz3ujxXYODdoU0kbl6DnmERlegfZrRPj6XQrv+7zs1GpWGAKq7dqYIuLh5J6CLGwoNZR8ox/vlzfukHyenip/TC5Z0oUkyElUL9arT1ZEXHh9liGpfhFHh7X5woVAYptAjMNLMLz6oaac05+cpjWzmuru6g1qk3hLsx9juRR2bIZr5XoNAvC6Wzo0R2LB9R2avxWg9DQKewvZF3AZq3PYK3B3bF+g2VGs5DZ3fDaqzz6KxTjoOkBpIVf2DSf5ZryhA8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199018)(38100700002)(31686004)(36756003)(86362001)(26005)(6506007)(53546011)(6512007)(31696002)(186003)(83380400001)(9686003)(2616005)(478600001)(5660300002)(8936002)(316002)(6486002)(4326008)(6666004)(6916009)(41300700001)(8676002)(2906002)(66476007)(66556008)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5hWUN0M1BOZ1lyVWYxbkE0VVNOS0VyTVpZY2JPTG5TeUpSNE1YRkJjMW9l?=
 =?utf-8?B?L1NKSjdqTStrMGRtUEFWcVVlN0gvREh4ZkUrT08rNEc4dERodUFFVWx1SFd6?=
 =?utf-8?B?QWgzK2lQRk81REViR2JTMWsrZm9qWk1mZ1AzMkhQcUs1cjlyRTlINTVvbzRv?=
 =?utf-8?B?aWJIcVF0SUo3cE11U0pIc2p3c2huNndXNU9vWEVaQTloTlhlcU5EOWZzR1M5?=
 =?utf-8?B?c3RzbXh6WDJnZ2pXOEVsaG5ON2VDRkdDdnZ2NzhLOVlYZ2I5TGdQM1NMem5x?=
 =?utf-8?B?Z0FaWS9yM2R2ZTZiZEdxSVM1c1BFODFKU1crUzhlcnA2RnJURUFud1RhTUJH?=
 =?utf-8?B?VFRmYWJWUDMwUWp6NXFyR3lDaXJLWE5lbDl3anJxQ3pGOWtmV0tPUFZXTTdz?=
 =?utf-8?B?MTQzWVZUaFRncXZVNUE1T1hwZU1kdHVSaE5uZnNmTDlRMUNXSHdCazJNOWs0?=
 =?utf-8?B?bUNnSDRsZjkzeGZ1MjM5YTlOcXdVZlQvMDFxZHh4d2c1T04xRzlLblFvZ2Np?=
 =?utf-8?B?Zm91Y09YZDVUT1Y5VlBEc0hBTjZhUWJscVRxZHFSd2p2blV5QzZhbEJJb3VC?=
 =?utf-8?B?MUJnZGZPOVh3THpzSzF6aVVaSi9xTDNEbFdJU0VTMStQT2RBbEZxSTNYemhy?=
 =?utf-8?B?WlgrZG1VdUExRjFDTDFMRlJaSUQrcEJJMDdvRmVZMVI1YUt0R0NNV0l2RDU2?=
 =?utf-8?B?SEgwcmtrSVZUN1JJUVVGNmw1TUJWcytBb2NtcnlWalhMeEhMOWd6TlU2dkhZ?=
 =?utf-8?B?MTZ1d2JueE0reU9WSHVhQkhhS0RtUVlHQXliZWNyQzN1MzNKQTJBQ1NwRzBX?=
 =?utf-8?B?bE5QUXl0d21PNU1RNC9RRy9IOFBhN0RndUttUFhodlJQMFZBV3JsNFJGUkc2?=
 =?utf-8?B?eHJpdkQ1UXhoaXZTSUQ5c2FCNFNRT0NPMlFYQ3Y4MkR5WHJpWXlMR1RSRzI3?=
 =?utf-8?B?cm1OUHpkblg3cE5OL01EQ3FjMytqck0vYWM1RDVldkFFQkp4YWNLTHlJWDVo?=
 =?utf-8?B?RlBhNVRHSkVQOFE0Vlloa3UyZmlIUldSYVp6cDdBQ0JpQnhHTTQxZjlmZUtD?=
 =?utf-8?B?YTFKTnFFWmUwdk16b0c0Vm5ITXBKUG5BcXJtYmhKNzlVUnBaN2ovK0JhRVph?=
 =?utf-8?B?ZzRnak9aS0I3Wmx5bGVzUkdCMmlaaTNvRVhSRHE3QVI0aDNaTUMzbGtmaHdv?=
 =?utf-8?B?ckJmUkJzMW9uU0xvSzlCUEtIQkxteXNCanptTU5TZVBzWUpFaTQxK2FOL3ln?=
 =?utf-8?B?NE4xYWpUYUNkRVAyZVJOUjN0S09kbGlnOW1HRUhNZyszZklEWXVuekZla2Rm?=
 =?utf-8?B?ZUprb2pjcHBLSVdSTllJS080MW94OTQ3dm90ajBVbTNhNVVNaVd1TWFUK0l1?=
 =?utf-8?B?SURmaEU0RTQzOHQ0NkFhYVVBSzFuMkZsNXdwYkczeWw4azd2RlRPNHNxTUt5?=
 =?utf-8?B?aDU5ZU9zRlBzWEwvb25YOUo5aXExT0lqNml6YTh1ZmhkaHNldWtQMWViY0ww?=
 =?utf-8?B?MUFPMm1XR2V1WnJuZFhSSXFyY3BjNHp1dWxKZk9XUVMyV2YrTVA0alFPaHVT?=
 =?utf-8?B?aEx5RG53ZHl2K2pZZUNWRmJLaHBPOFArakIxTUprOVl3cTRrTzRVZ2hVOElJ?=
 =?utf-8?B?cWJjbHJsdHgwTUI3aml2bVg1SXQxWkRKUGlqR0ZrZjU4U3BaQWpxajVTaSsv?=
 =?utf-8?B?QkFFVWVtL043QnY2eXJZWWhqSk9vOHFvWWZnb2RKMUVqNHJhVmxQU0xrSWxa?=
 =?utf-8?B?bDI3NmFhTHJ3Z3ZmVTg4c2ZTSUpORnNYSmFCMlVNTDhHeDBGc2l3Z0VhbUlE?=
 =?utf-8?B?UStEV2xuNjQ1eUMrRkNYdGIyQW1UcWRyeENnRERydHgwcUhVVGZWd3FreDJX?=
 =?utf-8?B?QWR5djdlcnhZK0xubGZZVlArL0pwZ0NsWTV0NitHR2JjdTBGeVh6cEI0c09p?=
 =?utf-8?B?bUJROEpRUW9BdExZT29UWDloeVJRaXJkMWNqa0JEaUFYRks2Mi9aYmgxZ2Jw?=
 =?utf-8?B?RlZBNnFjSVRhcm9jN0RWM05FdUVwbHdJelVIUVRidnkwTHZ2VCtqMDJhYUh3?=
 =?utf-8?B?WjdmblV4ZkFTTE1TMDRNcVlkM04xT2FOemV6WGt1Vk5pVTk2eC9DSkJVOUp2?=
 =?utf-8?Q?JhamBrg2SSnHv3pbxUwln2yn2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RhGlR/jx2XL3IjAc6g6SidFhpX/OZrzEugqUg9IQpQl5faLAAimtnEtlIWYRzwzNTra5nn/mZlENmBsoBDYGssR/YNIJP7pyxiAEDasQ9bcVH4nNrhWZtdCUFkgM1k8dTqDTMhQfkust8XSUBlKdw+5f4mqVV+oUHYnL9kON6K5ZR1ATW3Jgu9G97PFFaqxZvFZUuV535qauDgnRWbSvTwkzVoGM7+ZZrEAyZVbWaTIUlWzPBZ5uzN9o7ZufncnYwZyyadblbQStUIGFdm4Py66185I5XiQdXEjk2cbMDoSAtnDLN+tSHCx5Ytf3reWzc8bLXvOFiXx1TOeN1yYzGTx3paEeV77S+Ozur9ZZ57I4RaitCYDrmCZ4CNDCUIAGIAUKta8cGkNW8zU8+7r+RcSwHIrCu+8rnyn671vnZhKpFCwh+prcXZ6frUQtQxWYzIUuHjJVga5klaCbN8M9CoEDHdun9wm7ka7S2olC63rOv2W0SLwlVq6zb/qmZUe44aUmiJYD+tomwa7YVHBUAdCY9qGiIarN0kbkoesNPQJRHXuK8x7oTVh4MAW/E5Wi2vzIlivmeJN6qV/k7nLABJg3p2ytnvH4Pz6Hrn7R3hdij811VJLYZZ5saz7qFOCdnaNjz6Jlr/MWoTeMsbe9pUc0NxH9kFpQyOFSwf4LXHDXvzoKUp6GVIDEmoUYAuamF+U8oUsi/yYkX2W8QyCM2qTxVJn9c5orJgXoTID8/g3QqBvViBfUiaS7TRuRSv+zyN+tEC8/kKCe2T5tSNRfhl5mjJSNKMMorLodQrkvU+DlFltoBrZyDGBhHqydc0EMvIhH+tUWjAP/OLL2Cbp2Ww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ef91af-21f9-4c8a-64b0-08db15607cf9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 05:40:36.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9XbgaoG6eAFGcbkPr8GXL8QBhQjc3njL6tfvpeF+TkipqUUmY3X8IlSNQP8MiAZr48bB9h3l+S4bUwYYTnEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_02,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230049
X-Proofpoint-ORIG-GUID: 9c2pD85GIphfhhjSkXy5DrbgUAqDM5et
X-Proofpoint-GUID: 9c2pD85GIphfhhjSkXy5DrbgUAqDM5et
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,

Just a reminder that this patch is still waiting for a review.

Thanks,
-Dai

On 2/17/23 10:22 AM, dai.ngo@oracle.com wrote:
> Hi Trond,
>
> Could you please let me know your opinion on this patch?
>
> Thanks,
> -Dai
>
> On 2/10/23 12:10 AM, Dai Ngo wrote:
>> Occasionally NLM lock and unlock request fail with EIO and ENOLCK
>> respectively. This usually happens when the NFS server is restarted
>> while NLM lock test is running.
>>
>> Currently there is a 9 seconds limit for retrying the bind operation.
>> If the server is under load the port mapper might take more than 9
>> seconds to become ready after the NFS server restarted.
>>
>> This patch increases the timeout for rebind from 9 to 30 seconds
>> allowing a bit more time for the port mapper to become ready.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   include/linux/sunrpc/clnt.h  | 3 +++
>>   include/linux/sunrpc/sched.h | 4 ++--
>>   net/sunrpc/clnt.c            | 2 +-
>>   net/sunrpc/sched.c           | 3 ++-
>>   4 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
>> index 770ef2cb5775..7f2dee56c121 100644
>> --- a/include/linux/sunrpc/clnt.h
>> +++ b/include/linux/sunrpc/clnt.h
>> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>>   #define RPC_CLNT_CREATE_REUSEPORT    (1UL << 11)
>>   #define RPC_CLNT_CREATE_CONNECTED    (1UL << 12)
>>   +#define    RPC_CLNT_REBIND_DELAY        3
>> +#define    RPC_CLNT_REBIND_MAX_TIMEOUT    30
>> +
>>   struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>>   struct rpc_clnt    *rpc_bind_new_program(struct rpc_clnt *,
>>                   const struct rpc_program *, u32);
>> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
>> index b8ca3ecaf8d7..e9dc142f10bb 100644
>> --- a/include/linux/sunrpc/sched.h
>> +++ b/include/linux/sunrpc/sched.h
>> @@ -90,8 +90,8 @@ struct rpc_task {
>>   #endif
>>       unsigned char        tk_priority : 2,/* Task priority */
>>                   tk_garb_retry : 2,
>> -                tk_cred_retry : 2,
>> -                tk_rebind_retry : 2;
>> +                tk_cred_retry : 2;
>> +    unsigned char        tk_rebind_retry;
>>   };
>>     typedef void            (*rpc_action)(struct rpc_task *);
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index 0b0b9f1eed46..6c89a1fa40bf 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>>           if (task->tk_rebind_retry == 0)
>>               break;
>>           task->tk_rebind_retry--;
>> -        rpc_delay(task, 3*HZ);
>> +        rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>>           goto retry_timeout;
>>       case -ENOBUFS:
>>           rpc_delay(task, HZ >> 2);
>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> index be587a308e05..5c18a35752aa 100644
>> --- a/net/sunrpc/sched.c
>> +++ b/net/sunrpc/sched.c
>> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task *task)
>>       /* Initialize retry counters */
>>       task->tk_garb_retry = 2;
>>       task->tk_cred_retry = 2;
>> -    task->tk_rebind_retry = 2;
>> +    task->tk_rebind_retry = RPC_CLNT_REBIND_MAX_TIMEOUT /
>> +                    RPC_CLNT_REBIND_DELAY;
>>         /* starting timestamp */
>>       task->tk_start = ktime_get();
