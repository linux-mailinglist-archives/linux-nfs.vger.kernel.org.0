Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FC476D973
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 23:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjHBV0y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 17:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjHBV0x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 17:26:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8682E75;
        Wed,  2 Aug 2023 14:26:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HInQm030227;
        Wed, 2 Aug 2023 21:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8QzvDaqMU0srWim5jtVvH1vlku7PypvSxxYzoHlJ8XY=;
 b=fPCKaxZDPhLifQy+JYY+8xp2iWCK6mzB1ZYYSfUPguwlwy3M9/I70IvEUqVuApeNXl98
 GNGKEPUHEeZnhW46TP1dT02Fh0hdbhlvE9axzI43pxOB2hEY9EjcRRb2vb+RnXsyvH+j
 XUz2DCVfJTK8oVZQjTpi0IZuSJTlicBVYBCwISpc9gsOI4fF0vxCl3OWuhlULrgfJCla
 wNUPgF5vYpFQf5hj4NPW/KFS4M71H/kUe9ix6iFbwkwpp1psVYGSLodgMm6JixoK+ubk
 H/9fj+bDRtp24DiDl5FOjEzJ7TGzsVZ8sGM8eyq3capqsZqz5hOZyXEqkY9pdyOeUHR5 uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcu08de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 21:26:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372KOL3w006902;
        Wed, 2 Aug 2023 21:26:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78gskp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 21:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWKbltzVQFaw4gNZIZYThRFcPTT1WDAcy5QKbE4UVScBOgXfzdXvSv5I5GSiP3wva7lAgYHGdooL8qjm5rKjvfHKA1u8hGPIGforITswSlrIaMD+d5gehY9/voKi3RqtVWoL0j9y73PFb+AwfwC72S4eaxhx0Mu3+HsyRpRDYATjFRIg1puoOmBGwfBujix7+s4nEgR7Tdv+K4DKJAfSRLvEQuED5w3tzaxHpZOyx87cWbi53x0ycVmiOu5Bu52PoJrPqX2orQVw8rOs5TcRjb6lukGqA0ib6ECUZMeuw/czjwMe253xCbArhPsX5fIbe6QRNa3BjwwtHmKy96nKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QzvDaqMU0srWim5jtVvH1vlku7PypvSxxYzoHlJ8XY=;
 b=FLoPxdvQiB+rCBzyas6KBj7AOsMMDGRixwMF9JxTGmf1iF841mQBf17gkLqOmipqhmcfJMOAaw7UnGy0lc3wNnBAMnU9Cov3z1tUgfFXCvzGWrOhLKoW1hLz0M/p9ihyPLCG2EsVCifw8Ns2wJ3Cidk5wv1MG0MqKtKrfwuVyyJ7QivfX7Pj8MkydhoAraCsa/zX0JNkMP+l6dqMJxPE+jkD75IQVgQDpUZyQpDcVaehRctjLwfrHZnSenhnq3MqkgvCR84CoMXj0k+XG5Y2L10fSpBagP7qt70if6x+65aqdQvj4XcMwNLxoZVdhVrMipgEkUl7chjGf7v6FdV36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QzvDaqMU0srWim5jtVvH1vlku7PypvSxxYzoHlJ8XY=;
 b=U6Nmgk+l/vIGPHn3TOyQndbWlwQDLOuk/tzhvfjoTq8cLe9M93auyjnos0qMryLNgLBQ8zO2NUNosuKDwCXUyUFNEaj9fSG3CrkBCoCv+eHeItJ9l9yP2sEjo9yjJo/tagncbitkvxLHqI419iULHcA2dUVOopftM5lQU+B9xXs=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by CO1PR10MB4641.namprd10.prod.outlook.com (2603:10b6:303:6d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 21:26:36 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 21:26:36 +0000
Message-ID: <6f00d5c7-b129-fde2-1465-56a69e1a0cad@oracle.com>
Date:   Wed, 2 Aug 2023 14:26:20 -0700
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
 <5c36c77f49c880ed00eb50edef3cf0bc7b75c87c.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <5c36c77f49c880ed00eb50edef3cf0bc7b75c87c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:5:bc::28) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|CO1PR10MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a3dc71-3cfc-494d-069a-08db939f2696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQBWuHnbJIudgG4+GbvC0/892xaXQh7dA4lLW3kaWBWx+qEQIxLy/qIFoyNaVhGuZYHDIK4iy103cAauPSC/JxEQ1EuxCd2H2/vAt5UD35TmpCV2t3WlESOWDCFHK58nWZcNLi8su5RQ9YbsKEvXCI+dPtUsoKj/WYVdzbO1jDbbldfXCicDd+EwLJgttYRn6+IKTg3nFubASgVj6zFPNbXe5OVdddXCNc1coFHePrRHBUzR/Y7EeV+eBjr1p/nNj14SoaAmGqThXjYaUrcdR/TubiPLQd6eFMjs9+HUvaxWtlo9yZqMQhyBBnZlvaexgfhE1aygP9oqWjNwQKWzChSQKqiQrDjRw1zZhFMmAwVgMBpSXu5rEjaB9NL++jG+ekxoamK8K4A2qHN46ipCwdcjVZWh13IJ89evRRYDwWVhOKZS5leDwURfp+D5kA9MwqFEJ4KPJdwU8SVrnUBrMTAgOqbRipUeNmRYUgyOfJYC5LFU+Rx6p5QjsKBihViGuEPw9dRayzbzhsK7zqLWjVOrqBG5YoztSnxfc/TuweEOk5TDyD8LRLatkkKw27qz0cRnSQLkDRIZTY5pTXyCIVC45iaR+dKf+V6XsA74rg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(478600001)(86362001)(31696002)(966005)(9686003)(36756003)(6512007)(6666004)(6486002)(316002)(8676002)(8936002)(41300700001)(5660300002)(31686004)(4326008)(66556008)(66476007)(83380400001)(54906003)(110136005)(2906002)(38100700002)(66946007)(26005)(6506007)(2616005)(186003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFgzZWFvb0pYU1JsaUNmREhxS3hpQ1FzY2Zmb3pWZWduaGJnNXY4alJXeDRr?=
 =?utf-8?B?WGxqR2M1RnFhd250bVcyaXUrS1VnY3dPNVJLV25GMVpqZzJPM0JTUTFpWEZU?=
 =?utf-8?B?SHBsVHhLaFkySmo5dHRSZ0dHT2tGUEJZMU1ydnpyTlBPUi9kemhzbWMwVUR6?=
 =?utf-8?B?N3hoRmR3TlhJZjBQK00vandNMjc3THdJbndCM0UxLzFLTkxMZituaWMrRHBD?=
 =?utf-8?B?SG1CUzd3bjhZR1kxemxPYWhNVVc0OE8xOWdwN25RREIrWEU3NWM1b1JVN1dS?=
 =?utf-8?B?R3N3VytOcjlZWkVsckpDVi9UeE1KVjlJcEs1a2RzMVRlYW5uZEpseDJJUDJC?=
 =?utf-8?B?RzRYdGRmVmY1TW9yTmdRSnllN2JvOHBpTTdRUkJYT0lmNmVtbWRDV3VyY1Np?=
 =?utf-8?B?VjNIeXVMdmJVQVZPaWRFRzA0eG5KM2FIRmxNSDU5WkFSdTZvUXBmRHE4Um1W?=
 =?utf-8?B?OG5UM2FrMHo2OXQwT0I0OHo2R3FHbVhIVTVTNnQzMU50MEdVc2hkS3Y4ZUNl?=
 =?utf-8?B?cmd1OGM3ekZENWFyQ0tMNEtjdzFRWEQxNXdkeTNlTjRRcE12MTl1Ym1XeEk1?=
 =?utf-8?B?S2Y4WVBnbjVyMGNBby91cjllVW5Ub3NkcDUxRk1yalFLUEYvSkpBc3VKNDA0?=
 =?utf-8?B?ZmY0MkYwaHhCZGMxNzV2VkFkWXNUNTMvRWVOUVUrN2s2Rm5jYldRQ1lia2RV?=
 =?utf-8?B?V0tJckVYdWhJakFDY2JKbVU5amtMWUJ2UDhHdzVmSnViTUkrRktUb2ViNCto?=
 =?utf-8?B?WXgxeEZvdURYTUxDYWR4cjZ2N3FRbTdPc29lY0d6RjBiUGtSV1AvQWFWczB0?=
 =?utf-8?B?MkdjSzlzdGZWT0FPWDVvcjY3SlAxbnlpSFhyUENhRWxMaUc0MFdibzd2ek8z?=
 =?utf-8?B?R2Q5Q3JaU3RpeHdpZXp4cEprS0s3VTNtVmxBY2ZZY1BRY0dWcUdqaExIU3FM?=
 =?utf-8?B?NXBCQmJnL1k0d09ndHNocWNyci9jNytLVUNsSnMzaDcrRFgxSlhsNzlmKzdZ?=
 =?utf-8?B?MUNHaVFacm1OV1FXV0JpdmYySlZVUkdLVGV4d1B3SEpxVEpGK1QwTkJieFQy?=
 =?utf-8?B?MmZtN2dsSGFrdFBhVzRlVGYyZXFRL3VEc0JVZ2NDTmdXQTVxTVFOQktnRCtH?=
 =?utf-8?B?YVBXN3RjR3Qzbk9MODZRbDhFMWEvb3NoRWRGdHgrc3luWnlEdWlGcml3WGhI?=
 =?utf-8?B?a1hJcDBQRnQrZkpKRXVweXZkdkxQYXVPTXNxQ0w3MEpuRXVWOGlrbE1uZmgr?=
 =?utf-8?B?emdtSjVqRE9qdXoySmdXV3ZiYUtHUXI0SUt3dDJtMi9qbDNPU0JzMjZSVlMz?=
 =?utf-8?B?bzh2MUhoVnZQbXAwU3lUU0tVb2tqaGhMNW9RNFplVzZKR253bjhWVFpBV1R3?=
 =?utf-8?B?WnFuQ0lVQVMra01pM2RtSGdzVzFBTExxbXplT3VBajJSVjFnak9EcDNueGZi?=
 =?utf-8?B?RUVrVVlWalNZTUppVFFPSTlZeUdaeW5zUGxwcE9TOHk0Smludk5INkJneHp2?=
 =?utf-8?B?TEdIblR4SWZJSEppNzJJQUVjZVB1N1YxUDJnemFIWUJkMnByTHlGcGJZYSt5?=
 =?utf-8?B?ZnJ4K21vSEMySy9Hdm5paE9pa1FHa1J0MTJFZFNKT05SVlpoVWUrU2ZsVEZs?=
 =?utf-8?B?UjhiRWlVMlF2NnUxRi9OK0N0RktXMFpFUktYVitaTHhqTm1IT296bUdkUnFN?=
 =?utf-8?B?TGJFSlUxQjlBdi9tYnVPVnFlWGFObFF0YVNoYUdvV21OZVJOZjFDMHZNV3NT?=
 =?utf-8?B?a3c2YTVVdjQ4WUU4NUNVRjdxMHByYWVFc29ZdmJGTENvQ2FtT3dCbm03cFNN?=
 =?utf-8?B?bDcvREJsRzlPdGJpaHhLUmRXQlhJZWtDR1pEaDRYVnFUSEZwcHR2SWFERzZT?=
 =?utf-8?B?aW5xUVBOQWtnNkw4V2ZrL1BZTE5JOWN4NTI0dXNCdGRxanNSSlFKdTN5ZEts?=
 =?utf-8?B?bDNadHlmOGZaeG1NL3FZbVExVE1VOUtZNDNwREJyMitEK0RSNjNGZGxHT2Iy?=
 =?utf-8?B?Vk5vQWtWMWMvQllQMzlDSGFOY1NpZnVBL0pjOTlId1V2RTdnVHFINk5VaE52?=
 =?utf-8?B?M0pWaDRkRS96VWs1bVlHNWhIaFRDOHJ5U3B1VWo1eHhsQUtEWjlDOFlpSzE5?=
 =?utf-8?Q?LNW+OkvpL7YS2Y4Y+ZE1mqfx7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RCFi7VAyiV4Yc6scnIaUkAP1K3vpRviy4cI7ccmpQuE6iIGUO7xGWuNucpTqSo6DY3pscGr3KBCY6rJzsp09K52FNEU78MEt9vr+s9vtlQMKoePXnJZy+2xIBANa9mNNmqQQOn3zPqzLMFbcXXiH9QTAUzTtdMvyxJTP99SU7E5ndhIgrH9KpV8RUO2PL/qb35YX9PlwMeVyYZl/m5SHhHFZmORzyNYTyIwKxQAtTlYFLoZVLFhehqgA5SMnmTrHUaa4Eh0TE716ra7zCY/AQ+6HHoXT1Di3UJx/rDWdb4yJvhwON+wT1luOHOkTAk8i3Oix12RdeVzB6+ma/YBHsuF0AGvpjhMujI3zAFs2/rXxFOiuKsB6bFFY7bZQi799RssvUeKWbaP90LRDUzye/Xrj1mENmZsKCwwrZw6bXwXfIX4JsdJUi4auTjzSaojfK86asteZXza7p7aXcPz386Tf2rt5c7Gk8RB8obvNisnBxBbgrUvkOXIUOH3H8pMPKlH6IUuqv4vScQqb8TrPAfzQGOiQElWVry6kF5OpELo2E8nUn4bwOUCWML069F2bnXZBHvz6++FGVuSXanwnEUf5I+4T1hh6E/byVfRg6PFlSikP3Is+liX27PlLifbDfEk1o8JoZsrf3LtyqfDdl9TYxCrLNGT4prYm3eyg96PdaNYQ3FgHO4g61aOeDNSSU76cXY1GmY3RBdFdZZOtvw5S6APY4UcAE77qYu9dJ9MjlcvaUn1TiQc2wwXkdoqnul7kL86+7yZop9eNMPe4oKUkBUqdKx+1UgJe5Tm669evnwkrmwOIphwTabEu5DA0TukeEngP8yQ2ErLR9BU2N3fvyNbChJCjTXvrBoz8icnPsJuyzeE+1mLgGPggyT0d
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a3dc71-3cfc-494d-069a-08db939f2696
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 21:26:36.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NWkjypSfZ5zBKvRX1Um+6+64HxYQ8CHgKRf1yWYqJ/vl55u6xB16VNOiLVZ85a20EbiU10yZeOnBc0zTGtmUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020189
X-Proofpoint-GUID: Ml7hBc59jZYEoV-FM6cUnPr85nf7OcNf
X-Proofpoint-ORIG-GUID: Ml7hBc59jZYEoV-FM6cUnPr85nf7OcNf
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/2/23 2:13 PM, Jeff Layton wrote:
> On Wed, 2023-08-02 at 20:57 +0000, Chuck Lever III wrote:
>>> On Aug 2, 2023, at 4:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Wed, 2023-08-02 at 13:15 -0700, dai.ngo@oracle.com wrote:
>>>> On 8/2/23 11:15 AM, Jeff Layton wrote:
>>>>> On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
>>>>>> On 8/1/23 6:33 AM, Jeff Layton wrote:
>>>>>>> I noticed that xfstests generic/001 was failing against linux-next nfsd.
>>>>>>>
>>>>>>> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
>>>>>>> would hand out a write delegation. The client would then try to use that
>>>>>>> write delegation as the source stateid in a COPY
>>>>>> not sure why the client opens the source file of a COPY operation with
>>>>>> OPEN4_SHARE_ACCESS_WRITE?
>>>>>>
>>>>> It doesn't. The original open is to write the data for the file being
>>>>> copied. It then opens the file again for READ, but since it has a write
>>>>> delegation, it doesn't need to talk to the server at all -- it can just
>>>>> use that stateid for later operations.
>>>>>
>>>>>>>    or CLONE operation, and
>>>>>>> the server would respond with NFS4ERR_STALE.
>>>>>> If the server does not allow client to use write delegation for the
>>>>>> READ, should the correct error return be NFS4ERR_OPENMODE?
>>>>>>
>>>>> The server must allow the client to use a write delegation for read
>>>>> operations. It's required by the spec, AFAIU.
>>>>>
>>>>> The error in this case was just bogus. The vfs copy routine would return
>>>>> -EBADF since the file didn't have FMODE_READ, and the nfs server would
>>>>> translate that into NFS4ERR_STALE.
>>>>>
>>>>> Probably there is a better v4 error code that we could translate EBADF
>>>>> to, but with this patch it shouldn't be a problem any longer.
>>>>>
>>>>>>> The problem is that the struct file associated with the delegation does
>>>>>>> not necessarily have read permissions. It's handing out a write
>>>>>>> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
>>>>>>>
>>>>>>>    "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>>>>>>>     own, all opens."
>>>>>>>
>>>>>>> Given that the client didn't request any read permissions, and that nfsd
>>>>>>> didn't check for any, it seems wrong to give out a write delegation.
>>>>>>>
>>>>>>> Only hand out a write delegation if we have a O_RDWR descriptor
>>>>>>> available. If it fails to find an appropriate write descriptor, go
>>>>>>> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
>>>>>>> requested.
>>>>>>>
>>>>>>> This fixes xfstest generic/001.
>>>>>>>
>>>>>>> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>> - Rework the logic when finding struct file for the delegation. The
>>>>>>>     earlier patch might still have attached a O_WRONLY file to the deleg
>>>>>>>     in some cases, and could still have handed out a write delegation on
>>>>>>>     an O_WRONLY OPEN request in some cases.
>>>>>>> ---
>>>>>>>    fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
>>>>>>>    1 file changed, 18 insertions(+), 11 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>> index ef7118ebee00..e79d82fd05e7 100644
>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>> @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>>>>     struct nfs4_file *fp = stp->st_stid.sc_file;
>>>>>>>     struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
>>>>>>>     struct nfs4_delegation *dp;
>>>>>>> - struct nfsd_file *nf;
>>>>>>> + struct nfsd_file *nf = NULL;
>>>>>>>     struct file_lock *fl;
>>>>>>>     u32 dl_type;
>>>>>>>
>>>>>>> @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>>>>     if (fp->fi_had_conflict)
>>>>>>>     return ERR_PTR(-EAGAIN);
>>>>>>>
>>>>>>> - if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>>>> - nf = find_writeable_file(fp);
>>>>>>> + /*
>>>>>>> + * Try for a write delegation first. We need an O_RDWR file
>>>>>>> + * since a write delegation allows the client to perform any open
>>>>>>> + * from its cache.
>>>>>>> + */
>>>>>>> + if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>>>>>>> + nf = nfsd_file_get(fp->fi_fds[O_RDWR]);
>>>>>>>     dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>>>> - } else {
>>>>>> Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write delegation?
>>>>>> It does not seem right.
>>>>>>
>>>>>> -Dai
>>>>>>
>>>>> Why? Per RFC 8881:
>>>>>
>>>>> "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>>>>> own, all opens."
>>>>>
>>>>> All opens. That includes read opens.
>>>>>
>>>>> An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to which the
>>>>> user has no read permissions. Therefore, we can't grant a write
>>>>> delegation since can't guarantee that the user is allowed to do that.
>>>> If the server grants the write delegation on an OPEN with
>>>> OPEN4_SHARE_ACCESS_WRITE on the file with WR-only access mode then
>>>> why can't the server checks and denies the subsequent READ?
>>>>
>>>> Per RFC 8881, section 9.1.2:
>>>>
>>>>      For delegation stateids, the access mode is based on the type of
>>>>      delegation.
>>>>
>>>>      When a READ, WRITE, or SETATTR (that specifies the size attribute)
>>>>      operation is done, the operation is subject to checking against the
>>>>      access mode to verify that the operation is appropriate given the
>>>>      stateid with which the operation is associated.
>>>>
>>>>      In the case of WRITE-type operations (i.e., WRITEs and SETATTRs that
>>>>      set size), the server MUST verify that the access mode allows writing
>>>>      and MUST return an NFS4ERR_OPENMODE error if it does not. In the case
>>>>      of READ, the server may perform the corresponding check on the access
>>>>      mode, or it may choose to allow READ on OPENs for OPEN4_SHARE_ACCESS_WRITE,
>>>>      to accommodate clients whose WRITE implementation may unavoidably do
>>>>      reads (e.g., due to buffer cache constraints). However, even if READs
>>>>      are allowed in these circumstances, the server MUST still check for
>>>>      locks that conflict with the READ (e.g., another OPEN specified
>>>>      OPEN4_SHARE_DENY_READ or OPEN4_SHARE_DENY_BOTH). Note that a server
>>>>      that does enforce the access mode check on READs need not explicitly
>>>>      check for conflicting share reservations since the existence of OPEN
>>>>      for OPEN4_SHARE_ACCESS_READ guarantees that no conflicting share
>>>>      reservation can exist.
>>>>
>>>> FWIW, The Solaris server grants write delegation on OPEN with
>>>> OPEN4_SHARE_ACCESS_WRITE on file with access mode either RW or
>>>> WR-only. Maybe this is a bug? or the spec is not clear?
>>>>
>>> I don't think that's necessarily a bug.
>>>
>>> It's not that the spec demands that we only hand out delegations on BOTH
>>> opens.  This is more of a quirk of the Linux implementation. Linux'
>>> write delegations require an open O_RDWR file descriptor because we may
>>> be called upon to do a read on its behalf.
>>>
>>> Technically, we could probably just have it check for
>>> OPEN4_SHARE_ACCESS_WRITE, but in the case where READ isn't also set,
>>> then you're unlikely to get a delegation. Either the O_RDWR descriptor
>>> will be NULL, or there are other, conflicting opens already present.
>>>
>>> Solaris may have a completely different design that doesn't require
>>> this. I haven't looked at its code to know.
>> I'm comfortable for now with not handing out write delegations for
>> SHARE_ACCESS_WRITE opens. I prefer that to permission checking on
>> every READ operation.
>>
>> If we find that it's a significant performance issue, we can revisit.
>>
>>
> Yeah. The thing to remember here is that delegations are optional. We
> can always say no.
>
> One thing we could consider to allow this is trying to open O_RDWR
> first, and then only fall back to doing an O_WRONLY open if that fails.
> I'm not sure how that would work out in practice though.
>
> One thing that'd be interesting to know with Solaris (and maybe OnTap)
> is whether they will give you a write delegation for an O_WRONLY open
> when you don't have any read permissions on the file.

Yes, the Solaris server does hand out the write delegation for a
O_WRONLY open on a file with write only permission for the owner.

-Dai

>
> If they do, then is the client expected to do permissions enforcement
> for the cached open and reject local openers for read? I guess I ought
> to be looking at the Linux client code for this...
>
>>>> It'd would be interesting to know how ONTAP server behaves in
>>>> this scenario.
>>>>
>>> Indeed. Most likely it behaves more like Solaris does, but it'd nice to
>>> know.
>>>
>>>>>
>>>>>>> + }
>>>>>>> +
>>>>>>> + /*
>>>>>>> + * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
>>>>>>> + * file for some reason, then try for a read deleg instead.
>>>>>>> + */
>>>>>>> + if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>>>>>>>     nf = find_readable_file(fp);
>>>>>>>     dl_type = NFS4_OPEN_DELEGATE_READ;
>>>>>>>     }
>>>>>>> - if (!nf) {
>>>>>>> - /*
>>>>>>> - * We probably could attempt another open and get a read
>>>>>>> - * delegation, but for now, don't bother until the
>>>>>>> - * client actually sends us one.
>>>>>>> - */
>>>>>>> +
>>>>>>> + if (!nf)
>>>>>>>     return ERR_PTR(-EAGAIN);
>>>>>>> - }
>>>>>>> +
>>>>>>>     spin_lock(&state_lock);
>>>>>>>     spin_lock(&fp->fi_lock);
>>>>>>>     if (nfs4_delegation_exists(clp, fp))
>>>>>>>
>>>>>>> ---
>>>>>>> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
>>>>>>> change-id: 20230731-wdeleg-bbdb6b25a3c6
>>>>>>>
>>>>>>> Best regards,
>>> -- 
>>> Jeff Layton <jlayton@kernel.org>
>> --
>> Chuck Lever
>>
>>
