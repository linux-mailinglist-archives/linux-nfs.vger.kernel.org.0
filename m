Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8990862E249
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 17:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiKQQxX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 11:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbiKQQxW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 11:53:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD1325D2
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 08:53:21 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHGFSBh011633;
        Thu, 17 Nov 2022 16:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9nGNWmgYulzlBWdN9UowLV3svA8xQuxAW1XiQTtW5vw=;
 b=YnHt1i5buT+uIn196Jmvtvp+djZ9nA5jadQi52YliVeSUqqrTsJokUzw/IWR8QsTBnnR
 /LV/iXaKgEyMdHvbIdJUgJnN/wgePbL3nSDi75aT3Y5Lm39mxUqzA65dMgm2uwa8tptq
 QdQb/1uB7YDcmP2JHHk8jmaV9yUGH9zPuTBPNHDFeJBBU/mTN5oXNZmQcBswcnVYB7D3
 NVUk1iPTGL6qPpNdRtjWORpV8zLpJfVGQT0aniwEWU3G6iSOH67ZqeSRFAQbMAiFl5o/
 zORyKordBOHomBM4vP20eu2/7u6k9I2kQH+CMBCA34WOT2gLs/JrDfyRGwnZWM4aqfDe Ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3he1a4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 16:53:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHFoB0s010938;
        Thu, 17 Nov 2022 16:53:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3ka6g02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 16:53:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoXiyrhoTXvFlFu54Nb/xLpOkc5DDPIptJ6sJVMUUoYxETt9W590YYrIjvloun+GcyyNLRzALk+uRfCRNHVI2lmJCzOs19j3BZOQQ3dfmUQjj/RD5m77Wfc78H9BJWeNksoj1ofN9FOHwbx2tMPdjsew9XkEr/ZVGNnEg4VMRJCT/coDDrNjg7HCrm9yxZaFXEvjwyKTS9Bl69dCRGoVq9Siu+4zCbMT/FVjeLIYFvQpwwlclWkuFEefkYJNV3UDHNFmLYhYZKPwNHT4ViHVVjSH+7KxPRz0r3akPTXR1tSUzAGJHgBIEaQjsxf33Rce8hm7GwzHaIyjsp4S9lj69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nGNWmgYulzlBWdN9UowLV3svA8xQuxAW1XiQTtW5vw=;
 b=OfpRJcwaLoMX81gkUTTHfrp2/vCQKxlZfVUSVcWTE7SuGmihHFSmjGHK8Y0raMxdX4LMwsVjKw7ytPUAjE8zrNwY4mvFN68mKnA932TX+Gc+nXAaKWrBOJYvNRcRu2Wtc2wZk6lfrvoHzRACe8K8P9WP9AXRzDiuKVC0xwnR+qSPCz7577E3Zf33NzZh9LBFpmSF3HYuheByLhNMu796koTF9V8xl1dYAmB226FlIMx1phmF9IVclIiZXw7OqrQ98Iz3V9GkpmPzyOb6kd24PNqZ2OBlwQcd6LLQeUl26cZBjfnnP6Lk+hn8mdQO/6LlMPsmFMc4GhfEBCv3fgw6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nGNWmgYulzlBWdN9UowLV3svA8xQuxAW1XiQTtW5vw=;
 b=I1F+GbQo4n6M4MLSWAq2aSnvNPOymNNUuE9cn2c/67xSG5PlSrpcTlqlnePwrfQt+PKTNW++A/EiafAb1Y8/3Lad7jkJRjjPskDV0F8K1uZ3TGQ9G7kuH8wxOOzTEVH8ZP/OJmPM1ynxl7NAZ/TLeDApA5FmGcboA2JLEHuHa2c=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS0PR10MB6150.namprd10.prod.outlook.com (2603:10b6:8:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 17 Nov
 2022 16:53:13 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242%8]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 16:53:12 +0000
Message-ID: <7ee9c36b-b3d8-bb84-36bb-393eaa2369f2@oracle.com>
Date:   Thu, 17 Nov 2022 08:53:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/4] add support for CB_RECALL_ANY and the delegation
 reaper
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
 <8517F18C-9207-4DE4-A217-2A0EA4C4484C@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <8517F18C-9207-4DE4-A217-2A0EA4C4484C@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0174.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::29) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS0PR10MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f89376-02aa-48c0-167d-08dac8bc36bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WJalEJYEv2pB6OwsGjGK2zQRjPqtYXGAuJPWvYv3Gf3pLvQtR/WrM7J7400X2Wr55vCBtRgbGfwo8C69V5jhSezQ3CwgH6Hj4xBFZ8XQAEkKaeiSnyyXoSNBRGgBEH9By6oWue9WaZP7tdBC+3/wxiv5qdFRBZP6R2NnwPXaB6q+nu1nhgK2Q/onQLbd5IhNtm2ev5AeOFxG2Z660oeqcURnz83n4aO669aZGgBSUK1I3m5JTzj/RIEeTxvxOwb+TQHwyWaRy3nrD9iqzknsgThMGNKelXh3aFo5MvwaMbec4lVDGOPIS2a8WGnlVHIfK4EX84bOasreypkQWqRLlTfAS/7H6Tq3B7q8gCpg5FVivv6dOLZG6KhVi8vUi0EhHW9Gp/Pnoh9TsC86fByVZMFt2hLrgf/OgKXI9DA33Ew8nijzkOVqKpVBsK+Ej75KkfidR26KXWuoynv3oEur8gbomXy26KuIIF39FSrI9HIFgrHEwF6aZJ+gaoryanmmDmq3Ar9s/vgaVT+hqqvpOZQyp+yD0pSwJ4jNUy17FtODbvNOfbpyyTN37fxASGswKEPVyyHzGccFYfdUfIBDgI6WcmmpjNy5eVBLelr3JHEjR1RBfGmup+9PinEZKzor8Xo2Apub0X6EXWnUM2NsYdzxpTKvPnrBKE+MivQP9XHF3yRNZyM1qxhyHftZXnO6de8jOXc+g6b3bfJY3YbVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(54906003)(6486002)(38100700002)(478600001)(66556008)(5660300002)(31696002)(6506007)(26005)(186003)(53546011)(36756003)(8936002)(6666004)(2616005)(41300700001)(86362001)(66476007)(9686003)(2906002)(8676002)(4326008)(31686004)(6862004)(316002)(66946007)(6512007)(83380400001)(37006003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFjRGZXeERJRXk0NmNyWDB0eTJsK0hObmcvUEhPN0w4bXJad1lOcmxYcmxi?=
 =?utf-8?B?ZnBQQnBkNDk1T0FuSTBXWDlncmp4OHVaRnpWMTFwNzFjUXE4ODVDYU5KYWFO?=
 =?utf-8?B?ZTZPclJPRUFCL1ZQd1h1YkN1UHNZMUE3Q1JLdHorTHZlcDBXRHV6R3h0RDBR?=
 =?utf-8?B?WEZOcng2c1lhYmVGdHI5K3ZoUWlsY3BmMmZzQktLaUdaNkxidmxpbk9zMWRI?=
 =?utf-8?B?WHZQdTlBOHgzNS9aY0JFcjZMOU5JdVVaWlJKcGM2TFJkVmx1MEx3MVhGNDFy?=
 =?utf-8?B?Mks1dnNXR01oSjY1WUdSRzU0eUdZU0JvWU53dDB0Slhkcnpwb1BDT0VkTjhB?=
 =?utf-8?B?UC9RZ01wRmFkQ1FiZHU1aFpmalVyRTJON3ErODIrU1d4akpMUWJPeEJmNGJn?=
 =?utf-8?B?TWZNbmo3NUV2SW55SElrZHlBV3dPV3lqTFZtQmFwaUVmQlhObmY5bWJadVYv?=
 =?utf-8?B?SjNGOWgzY1VMMzNBd3o2SXlpQnpYR2FBc2lCVTk2Vk8vUjdKanF5KzEwMTF2?=
 =?utf-8?B?Yi9lbm5HYkxhd1F5UnJEUVpQUnlaTk1tSExJMXBzR2pBUSszT1NmUzJhM2Uv?=
 =?utf-8?B?RFNIckYwV0tySXNuTE9JL2JZdmFncVJKV2V6V1B5Q0l0VlJBZXdVU0ZLVytu?=
 =?utf-8?B?RGJKQ3JqN1hNSUVzWVBBL0FKVENGWGV3L1hMMTl5ZGI1UzIraWNVWlpENHd3?=
 =?utf-8?B?eTRnV1lGQWhKSjBNcWtLZ3h4RzVkN3hrcGthTHlXUVBjb3MyQ2tSR3VrWDBj?=
 =?utf-8?B?aWVKdlBWVWVaY0F5aURFemt4a01aZ3Ayd1A0d3c3VGNsOERiTkxzaFpEaGVR?=
 =?utf-8?B?elpCV3lzT1JYNFM2T3Uya0xMRC92L0VUN3lnQmhXNmtpTUpQby82blAxQ04w?=
 =?utf-8?B?c25kcnZrWS95cXdCQUtDeklic1FvYmkxVDhzMFpjWVdIdmV5b3grMktIM3A5?=
 =?utf-8?B?TjZIY09MMnY4NXpoYTBFck9uWVpJc0V5TjNId2pnRTV1VGp5Q1ZXM0R2b3Z4?=
 =?utf-8?B?WHBYRitrUlg4SGdwbEtYdEUwVXhDSWpsVS9JeW5PcTlOR054MTZ4dklTZksr?=
 =?utf-8?B?dWoxMXpsd2ZrVmVicm00NnYvNDBCWVpRTlFDeFAvcVdPeHVLc2VZdDlnNjI4?=
 =?utf-8?B?ZjE0L3Q0V3Y3SkJNdC8xakhwb1ZySDNkaEtUblZrK1JLTjVLVExFMVdTaFBX?=
 =?utf-8?B?NmpuL2d5Mmh2NFpKMTdWenZnZW5JRC9SZFZyc2I4clJIeWZLUzhteUZjelU3?=
 =?utf-8?B?b0JHTWlkcWxJU3JycHZmdDdtREZhTVZjd09RRU40VUxOcExNeWtJTFBpeVB1?=
 =?utf-8?B?Uk1xWDVKeHh6RDVrS0NqVjZtWURrcWhDRk9BdGJOc0R0bWllUVpOaUdKdldB?=
 =?utf-8?B?aTkwdGZlVmFjTlp4cUNocXBDTGFGRnRiYnF3cFd6aGV3WHZ3N3V5ZWNWNzda?=
 =?utf-8?B?Tzh1Yml0ZUlUYWk1VEk4bFh3RjlKZmt0dlV5T3F1Y1NYMUU2dUlMSDlrRUd5?=
 =?utf-8?B?dnBGaVhjdDZyTjNuV0NSZ2t4MUVrdUtvR0xhaUVPUzVsYndtRVIwNytMcmZB?=
 =?utf-8?B?ZEVDSWkzZnZIcGJSaDJtOVB4Y2t1eXRDRStWanc2Q3QvUWZmeE1yZERzR081?=
 =?utf-8?B?ZkNRNGNxL1dFaXVQYVhlMzVNTUcyTjlWdEJ1WmFGUHJQMUVFUkg1TTJ5MmRo?=
 =?utf-8?B?bUZQc0JxYW5zSTNRU2NHdkpJUEUySDJJTlU5R1J5ODl4YXM0KzdGOU1CSEJO?=
 =?utf-8?B?bm9IRVJzVnhzd1dxb1NNRkRCYjhWZFpBbGhiVkZtQ0o0MW15TDFIZ1VRMlZZ?=
 =?utf-8?B?SGlmRjZnTXBKUzBWRWwwOHBRTWQ0QU9nK3k3U1ZWSE1IUk1oOGc3cjNEM2ZM?=
 =?utf-8?B?ODBWdi9CVEZORUZZM1lLQWt1YnovTitrMDMvUlE4aTFDYktHdE9LT2M5bWh5?=
 =?utf-8?B?dFozbkpGcDRrZGZyTXJvSElwdVJ0a3RJV052cUNqbmZlaXRBV0V1d2xaTWwy?=
 =?utf-8?B?VmdIMjRIWWVnL2NPbkNPakgvVklPMDl2YitrTmJnTWxpdW02N3hEMkNIVzBx?=
 =?utf-8?B?Vy9QNWhOV2Z4ZC9MMExpaTRZY05DL1NYbGpONmVXOXpseWlGamV4aDJGYVJC?=
 =?utf-8?Q?giUTBMP1uvQkLh8Pg/3eCykgK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fSn4IxPy/K5Iz3hf9qG4kf8l9GhC6qtRTJVmX1ovKx+EBqbZeLQmGxQXiKzQ9ghPraB1dtIT8LnmTxDDqQTc5khWNWA++PdUrPgN8y2wZdxOFPp79lHs5ku+0dzyvF9VpF4JD7y4qML4EbaeQlofKPqW8b+dHEVNFDjF1PwTjXMm/j93LbPvCgpj5AyCMDX50nXCmVRNo1kvC/lH8DUNoMnJJCRohc+MntednfdCSnouK7RcUG4OyfPn25l3xQky9wsOx0JLb4idpifLrr0ILMQcvQXTGf+Xeu1Ny9esAtgkxEzaR+HE7spBHD6ShEfwYVi3mePI/wE1lA7xkhrl0L3xePTPiUadwRmwY2b52iLspzG0sIMq+On9HSk1OO9xNGG3Xn1w0v3G5BUSDCgfdC3FK1MuN6FgiAtiV1MMInzLf7ra3lfuCo3OttYAXBL2WIE9JzBbs8vyOJ5//r4bafVOME7HyIcQhZFfj5Qt2yNRT7B0p2f5YOFK7CwGQsp/oz0BMC0E6IeVyETkPQ3h7uxzZk1vF/RAmcjwRG7Aj87/EKTungNOvdBIMjtB2CbKFAdAqNDW3k8bZzbjjKoSpbwuh15AozDp/50M87HXNTOoM69aFu6HYVfnvzIh6F54/cxc/wv31m3dm6RQLNLjgLP3OB9Cr+humk/qpKz3mEF2/LG3J3MGBQjrD7Z3TX+wgugMOO/+1g9jCaYy9B5KdKHNUCMdL00V8c+7UU6w1zZyqV00mnlrLgKwi+R/Bd4MxEAfkmE4rYaSDWCEP/o78BALJSgfcVGIgiVm17dWTv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f89376-02aa-48c0-167d-08dac8bc36bb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 16:53:12.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrvtAh68wXsCJIVBXcr6XxsxCy4nFuU2O3+zX7EnJtZrYDfHiRn6je63qZ0S81ux0eNFGExuFzkMP5g4Kyzhpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170125
X-Proofpoint-ORIG-GUID: VIf6ERSn8Sp-6QLluzIu-5RrLOqRCNyh
X-Proofpoint-GUID: VIf6ERSn8Sp-6QLluzIu-5RrLOqRCNyh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/17/22 6:44 AM, Chuck Lever III wrote:
>
>> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> This patch series adds:
>>
>>     . refactor courtesy_client_reaper to a generic low memory
>>       shrinker.
>>
>>     . XDR encode and decode function for CB_RECALL_ANY op.
>>
>>     . the delegation reaper that sends the advisory CB_RECALL_ANY
>>       to the clients to release unused delegations.
>>       There is only one nfsd4_callback added for each nfs4_cleint.
>>       Access to it must be serialized via the client flag
>>       NFSD4_CLIENT_CB_RECALL_ANY.
>>
>>     . Add CB_RECALL_ANY tracepoints.
>>
>> v2:
>>     . modify deleg_reaper to check and send CB_RECALL_ANY to client
>>       only once per 5 secs.
>> v3:
>>     . modify nfsd4_cb_recall_any_release to use nn->client_lock to
>>       protect cl_recall_any_busy and call put_client_renew_locked
>>       to decrement cl_rpc_users.
>>
>> v4:
>>     . move changes in nfs4state.c from patch (1/2) to patch(2/2).
>>     . use xdr_stream_encode_u32 and xdr_stream_encode_uint32_array
>>       to encode CB_RECALL_ANY arguments.
>>     . add struct nfsd4_cb_recall_any with embedded nfs4_callback
>>       and params for CB_RECALL_ANY op.
>>     . replace cl_recall_any_busy boolean with client flag
>>       NFSD4_CLIENT_CB_RECALL_ANY
>>     . add tracepoints for CB_RECALL_ANY
>>
>> v5:
>>     . refactor courtesy_client_reaper to a generic low memory
>>       shrinker
>>     . merge courtesy client shrinker and delegtion shrinker into
>>       one.
>>     . reposition nfsd_cb_recall_any and nfsd_cb_recall_any_done
>>       in nfsd/trace.h
>>     . use __get_sockaddr to display server IP address in
>>       tracepoints.
>>     . modify encode_cb_recallany4args to replace sizeof with
>>       ARRAY_SIZE.
> Hi-
>
> I'm going to apply this version of the series with some minor
> changes. I'll reply to the individual patches where we can
> discuss those.

Thank you Chuck!

-Dai

>
>
>> ---
>>
>> Dai Ngo (4):
>>      NFSD: refactoring courtesy_client_reaper to a generic low memory shrinker
>>      NFSD: add support for sending CB_RECALL_ANY
>>      NFSD: add delegation shrinker to react to low memory condition
>>      NFSD: add CB_RECALL_ANY tracepoints
>>
>> fs/nfsd/nfs4callback.c |  62 +++++++++++++++++++++++
>> fs/nfsd/nfs4state.c    | 116 +++++++++++++++++++++++++++++++++++++++-----
>> fs/nfsd/state.h        |   9 ++++
>> fs/nfsd/trace.h        |  49 +++++++++++++++++++
>> fs/nfsd/xdr4.h         |   5 ++
>> fs/nfsd/xdr4cb.h       |   6 +++
>> 6 files changed, 234 insertions(+), 13 deletions(-)
> --
> Chuck Lever
>
>
>
