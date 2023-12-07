Return-Path: <linux-nfs+bounces-454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDE580954E
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 23:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71399281DEA
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4B481AB;
	Thu,  7 Dec 2023 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Td8kh2mC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dlSpULda"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD12199E
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 14:27:49 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7KGqjP014205;
	Thu, 7 Dec 2023 22:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=/wCkPZ5HjSHWEswIGdZNyRKVhtvY10XirJsXUACn350=;
 b=Td8kh2mC/EvNstV2phV4UmmTKmT39icgmVZE6IUVYQGJHUpU44uPPuFoFUn2usnkFpR5
 +DVojl6tNiqwoinbsXDijxI6axkmWsXQnD4Ofkmy+eW9clNHc2N9rTQAapOgbBgTCW4s
 pDU8WtKtKbvN0x7bRUdhATYbwd/jprXhupsFPRFtCnsv0umpElOt+IB7285uaUD8Y+C0
 PlSCWDEtQ06vMmyEohSl3BI0RUwMj4G4qN+yJn9jWJtx9jVQketgyp7+P1Q5nv04mvn3
 4U+DgiBmlYkneeYdl6VrcTdqB+GT89XTt2KQLFMGKYdqOVtBacB3UjpEyN6ZqiiO+HHL Uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc1cutr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 22:27:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7KmgKM001341;
	Thu, 7 Dec 2023 22:27:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan84gsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 22:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW5PC1IATYH+3D7cmfQ/LZIlCT/RBVhiOZHyv0luyWQxhD+pcSdHW5QqiY39JAnSKCKW+O5FnaPBOewTZdBoDal28JDDNlKtPP8jSag+nQP+R8U02V4imfhwjQSeSYHp8fkrm8uo9YlB8t+XwO7hUhPIJP5fhbNJgIYIEI77QiqTtNlVQ/CTNRA2MN/h73mlwR/4gOzXlYNiA8JF4G69ERKKuyMNEikRg+/YjbZ+wf/ZdAUyDYk5QtDFsJoBMzt6EheboG1PBjp9Wd6o8g5LRA3kLt8fUfjH/460LJYwsSX8kYlnvsVfPTZH0xVGIQNhElbhs46LuIUjqFxZ+hwUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wCkPZ5HjSHWEswIGdZNyRKVhtvY10XirJsXUACn350=;
 b=jmpNg9s1akNiEwwZ9x0dXnMTIykkPb7rywY7hiWT/gG16MBzJ9LOtS+WDTUDH6nPJoL2NrFKRouKP+pxN4i0/9qOoQ6F+IOKPjvyHXZyR89oH9NdUt+ZU/teX8VW14fr/OletM6BLJbswniRwp5tpkePjemsuHWc6+7klE9yY3y54+/hPLWKiUe2GMXL01Q8BVLJCAjaju8ZnTB6QNVpFT+LP0eBVtAMi6iDHwGGzRul3rcYu4hevGktkwr6wkpBSVgZjWswigULzjqJjH0r8vzInafOxkgBKGYHIxv7a6QnIdWR2HwaYm5a/Z+LZbGYve+B8nwoSUiIyqNHRFn47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wCkPZ5HjSHWEswIGdZNyRKVhtvY10XirJsXUACn350=;
 b=dlSpULdaTei6Cxw66e4+y46Pmt2KGjW3h9echad1ucTeuiOZO5cfqejQH0ex3jnDln65TIbKUl3Dqmb4Lt+CmwNmGKE9I/ZMkN0WVMtEnLbeTCt2KiyAnM1nOAiTul/Vci0EH1IEG55V8Y2rD7bnToVYmfv50lM02dD8iSIesN4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7245.namprd10.prod.outlook.com (2603:10b6:8:fd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.27; Thu, 7 Dec 2023 22:27:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 22:27:41 +0000
Date: Thu, 7 Dec 2023 17:27:39 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/6] configure: check for rpc_gss_seccreate
Message-ID: <ZXJG2xyFUs9pzHlq@tissot.1015granger.net>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
 <20231206213332.55565-7-olga.kornievskaia@gmail.com>
 <ZXHaTIvFruYfycsm@tissot.1015granger.net>
 <CAN-5tyFr7-eRP_wjrv_zOmsVC6ft1f1c+fNovbOXr0CVrtzfRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-5tyFr7-eRP_wjrv_zOmsVC6ft1f1c+fNovbOXr0CVrtzfRw@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0401.namprd03.prod.outlook.com
 (2603:10b6:610:11b::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fff5a9-9af7-4293-f49a-08dbf773b9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2dHtICCEFr993BXvTw9mf7b0Q0z6s2gWgFJS+L6L+LO7LI4457qYYnCWJuLW4ZG4h7jPmSz1QbX3b+XPw85aKyJHKaKrbmUAPoKpbte0fS5AcLQ0jN9Pdef/i2LYcbzkcxFhCgNmLbeNroC9bmNvI6sjX9ZuuJTxQwtKy0qEbO/Jm3YjmMVYkK3ZNimecT5dLKQyoEJbkJW4r4sBM9K/7OweBzEQwQ3SL3CQgl9PtfOq0FKkBR3lm1MJBLYTKWxrL/geVshpCrQFudYAlOKW2aCbjyKVDGLcrW9xRZcNBBJvgaWT2odpWJqg2uDRlNh8FmdNPuoxtCNQ3DhsDrmQuWTWMAJLOo03/wpx/ZBy0EUIGTfLy5LwWPcoOx0PAF39A6wYQM30HzAiMz7WhhDP62vRRubbvThd8MUfAw92Jzw0FHKTYxzKsNffGWZsAKUyJatdMvHkaRkWS+mezzK5MtLXGw2s+CTIr+Q1RlBws0j73YsNDXoafSljTvovEElsstZaeDlQM9PRetLwvm5Wwkrw50h3OrsTrkjobk+gHLlXBIdT9+zxLAXFz6WeI1K/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6506007)(478600001)(38100700002)(9686003)(6512007)(26005)(83380400001)(53546011)(5660300002)(2906002)(8676002)(8936002)(86362001)(4326008)(41300700001)(44832011)(66946007)(66476007)(6916009)(316002)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1p4L3UzRUlaWnd0MElHcFRCaGVxazFFNEl3MWZRLzB2Ym5RbTFJT0pTRSt1?=
 =?utf-8?B?RU9UaGlPRzExdXRIb0w0OHNVRnAwOThzVWJod20veDBVb1RpVm5YbkhjL0Ns?=
 =?utf-8?B?cWVRS0xmYTRYend0SUF1R2hWQUZidncyOTdlUnNORCtsaUlwWXJadWg3RmRI?=
 =?utf-8?B?dUt6WVF4dERUa1AxNmpUNUZRaVpmdHlTamh2MmxzaTFtWGtub0hSV1NpZ1hy?=
 =?utf-8?B?aFk5TnFEVGxtTWYzMXQ5SzhiSkhVcFpjc2tES2ZPOE1EcDhxdlRicWNIeFR2?=
 =?utf-8?B?bXNubVc3ZVFrN0ViNlNoWEJ2K00rVkNlU0J0QWtCemxrKzZGZHE4ZngzZU5G?=
 =?utf-8?B?NEFzSmNkMGk4UzFFS1dZNzJZb1JnYUFMKzNZOHgzWlNzdlpRaXN0RElseVFW?=
 =?utf-8?B?Q0VraHdLVlBwV0xPbnJLdUFnbE1UdTBXcTFNVEo2dkU5MXRWQlV3VzFGV0Fq?=
 =?utf-8?B?REpyRlZCbWI4b3RTRUgzbytlM25WbTA2MkJLYlJrSGRORVBPL1NEcFMwZUlp?=
 =?utf-8?B?T0lpWkxjVVBaMngrelVCSDVuQjNPQUlCcWNJbDdxRGIzMDFkVEtCSzZ1Slk3?=
 =?utf-8?B?Qyt3WFJSTk5hdnNDNHorMmhHK2dibmVVTG1GVzI0UDBmV3dTL1FSVHRzSURC?=
 =?utf-8?B?K3VCbldhcjY1UWtBS08zaThaMFY0TFhOMm16V2cyMUdqTzRRc3gwamx2RzF2?=
 =?utf-8?B?SWR4eHNnUnVCTWpPeFQzRm5YNFZOWVhBcE9WUlI2bmdQbmdGK0FUaXQ5ZWhi?=
 =?utf-8?B?cHo3NWN6WVp5OXQzc1liMkZ1R0tCWDJBb2IzWkVSNTZOdnA0UHM4Wm9mK3d6?=
 =?utf-8?B?N3ZqTzlnOUxVUWxuVm5HTVNxMGhMZ3J3N1ZaNmVxM05tOFg5ekNOSDRCSGh5?=
 =?utf-8?B?dG03WHBSc3hDV1U3TGpzVGVrWFF5bUgwcWJRVmovR1IzWmFwNTNFdDkxTC9I?=
 =?utf-8?B?NE5Rb2FGMzhUcEhlVjY3TGZOOHY0SVZHa2padTJVdmNWMXpic2dKc2ZxR2wy?=
 =?utf-8?B?VWJhNjgwcTViQzc4M1BjMGlQOGZndi93V3lNaFBYd215aTA5UnRDQzdjZTcy?=
 =?utf-8?B?Z2FyV2FWL3pTU2lteXVOeXFMaFZmT3JIN1VMcFljbjk2RjYyTjVsbXhlbHpy?=
 =?utf-8?B?VHR1U3BIVVVYc3ZOL0o4Z1RSaERxQ2hkQkN5U3E0dG1iZ2pySGh3NWxiYlUz?=
 =?utf-8?B?SUZhUmxYU3hDbEp4bmVWWk5GTFdqN28wTUtwUGp0cGhuWWg1SFZ5bmhMNWd3?=
 =?utf-8?B?ejdmMHlBNTJ0cERCN1NrTTV2UzcyUUtyRThYWjRwaUd2aTQrZ090TDZsT2M4?=
 =?utf-8?B?eXlmN3N6VGVSS0RWMHhXWmIvdzBFejcwcjJVcEIwQ1NqYTFLS1BaR0xjSUVq?=
 =?utf-8?B?WkhmSEs5UEE0R0NadGQwRGdqZ00rcndFOEI1aXFnc1pHdG1EWmNTckU5WkxK?=
 =?utf-8?B?R09sYmdVTHpDOEs3VmJVRW14MGprS3pxWlRUR0IyRnBqWGhqclVjM0d2aXAr?=
 =?utf-8?B?Mm0wYzhCcnZuSVdWR3JncnBwNVhPQ296b3FTZ3psc2FQNWdjdUtNNVVydU5z?=
 =?utf-8?B?UU5LU3VCNnhkQnVINDVYdUcxWlZWVzllS2tVSWJKOG5LVVRRa3pPV2lMckpP?=
 =?utf-8?B?bk5BM2ZOYWVLTm9aTWlTaGhLdmhBTFRKKzdtTkZjaStPMm5WdlhFZEJJOFFi?=
 =?utf-8?B?Zmc4ZGFIeTExU285azZSZE1UbEpsazkzelZFRi9jcDF3V0V2M25SakJhbG1E?=
 =?utf-8?B?c2U4Vks0c0VMQ3djRGVzYnRKWEE5ZDk1dEhnSlpQZm9kUjlWWVZpK1Uzc0ZE?=
 =?utf-8?B?L0pxUlFuYjQzMnhuUlBzRHJvdmliMW1iZ0RybU9LbmF1WjU4eW43MU5qaUxW?=
 =?utf-8?B?alNzN1cxWnlDU2cwdHRseGYvOVMvUHBBRUYxQUk1QTRkbGtteXloNkVyQ1Na?=
 =?utf-8?B?bkJDUXRwWGpkQ2FrUTB5TlFrZjZVcU1KTTlNaTV0RXhVSmdaaU5wRWptaTlL?=
 =?utf-8?B?MzBpdUM3TkRUZzJ6WjgrQnA3UXVweHNvRFk2SGExekUxaGVEK3RRemwwZFlo?=
 =?utf-8?B?YzJxcXNhV1lpNnJpU0dwTXdTSUV2UkpjYlpNNUFwMnhWN0NHa0x0WGNndTNl?=
 =?utf-8?B?dU43aVdNUUgydUZOWi9HMGZFYTlQR0I0VUlhZ1h6V2ZRL3U4Z0NFVWwrVkJk?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	22UMMzCfSsRPbwmBGd7MEC/aCYsZcT5I8h591Mq6PLTQfdw1haYFQukXnKmGuolpnexzr2/8cRKcP2TwZy0LAd82NBjYK1ToNcAO/veSjyyizzW5G7YEWKx5fL6mvEVUVmKdAC7sUbwVWFPonm5QexgBNh7O+Rsnyijv437gwrB4Ww9Yw2ZkPZ6joFDU6XxBgsAsSduNaQJ7V2tGBFf7IKSiqm2UxzJe9Ej3COwQVnERxVcB+k2w5BiJvd3e1n/kIy7EivJkiF+KSsy9cgZgUOzgaqRV9ni6/JH7Olt2rezUcX2TQX0VzAVxHuvwb71ovlodsQ3Nb3v+gDN2lVikVgMZUJ3Ge5NrOTn5te2BXKTzTOUvk/2J6jmgeR0KmRhL268hg05AchPT1unx4RZUsOCM9khJpU1zFXHfzf9+lS4+gwMzvk5R+ucmXu1mXpyIx+MzfqeBanaA/hSP2NauUYkQQlDg94Ai+LlmzTh1VEDt0wjDxWw53O6xAghjQcSxoYOLJi+dOAqjW7nhoI4m4Y63EVr+SKrJtP9iLqIvN0jyIJCDpOvj3vJKDg7ta9pHnB+PlO8PqiW8TrdDqRzHTu9KbjLpkCSCh4CKAAxnfEtYXNY7XhKoiXAqbQkRz+EvCoYEvr6dxvJ6Ac1faID5vTPXra7DEkyiApEdKuRKun8ywxh5eh4vbDiLSp+z8fwRJBKidEpGUvpaY746zwQwioAYRHdNH2ytBzuyDihSp5e0v136Ko3VrMjtQvRXzyxwYfCgc8ubIXQkqAT3Q7W4Jfq/1nvSxtH2rqvbisIOs2ncx+6THAQKk02fo4rBUMSn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fff5a9-9af7-4293-f49a-08dbf773b9da
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:27:41.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOMMlxwGnjydq6MPRrQT/xIiCa7kyEcBgmqFipKkO2PM5+2XeUC2SRDqYyxhL/LfFRW3QDMKsH0dUH3xI/4HBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070189
X-Proofpoint-GUID: pvgUjkBRy902V3k08g07TYVKOwC9MAHW
X-Proofpoint-ORIG-GUID: pvgUjkBRy902V3k08g07TYVKOwC9MAHW

On Thu, Dec 07, 2023 at 05:21:50PM -0500, Olga Kornievskaia wrote:
> On Thu, Dec 7, 2023 at 9:44 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > On Wed, Dec 06, 2023 at 04:33:32PM -0500, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > If we have rpc_gss_sccreate in tirpc library define
> > > HAVE_TIRPC_GSS_SECCREATE, which would allow us to handle bad_integrity
> > > errors.
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  aclocal/libtirpc.m4 | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
> > > index bddae022..ef48a2ae 100644
> > > --- a/aclocal/libtirpc.m4
> > > +++ b/aclocal/libtirpc.m4
> > > @@ -26,6 +26,11 @@ AC_DEFUN([AC_LIBTIRPC], [
> > >                                      [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
> > >                           [${LIBS}])])
> > >
> > > +     AS_IF([test -n "${LIBTIRPC}"],
> > > +           [AC_CHECK_LIB([tirpc], [rpc_gss_seccreate],
> > > +                         [AC_DEFINE([HAVE_TIRPC_GSS_SECCREATE], [1],
> > > +                                    [Define to 1 if your tirpc library provides rpc_gss_seccreate])],,
> > > +                         [${LIBS}])])
> > >    AC_SUBST([AM_CPPFLAGS])
> > >    AC_SUBST(LIBTIRPC)
> >
> > It would be better for distributors if this checked that the local
> > version of libtirpc has the rpc_gss_seccreate fix that you sent.
> > The PKG_CHECK_MODULES macro should work for that, once you know the
> > version number of libtirpc that will have that fix.
> >
> > Also, this patch should come either before "gssd: switch to using
> > rpc_gss_seccreate()" or this change should be squashed into that
> > patch, IMO.
> 
> I can certainly re-arrange the order (if Steve wants me to re-send an
> ordered list).  I attempted to address your comment to  check for
> existence of the function or fallback to the old way.

A comment that I made when I thought no changes to rpc_gss_seccreate(3t)
would be needed.... But you found and fixed a bug there.


> I'm not sure I'm
> capable of producing something that depends on distro versioning (or
> am I supposed to be)?

I think this series truly needs to check the libtirpc version.
Otherwise the build will complete successfully, gssd will use
rpc_gss_seccreate(), but it will be broken.

Grep for PKG_CHECK_MODULES in the other files in aclocal/ and you
should find a pattern to use.


> I think this goes back to me hoping that a
> distro would create matching set of libtirpc and nfs-utils rpms...

IME distros don't work that way.


-- 
Chuck Lever

