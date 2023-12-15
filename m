Return-Path: <linux-nfs+bounces-643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732A18150CB
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 21:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FD4285B64
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4443563A2;
	Fri, 15 Dec 2023 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MHJZNd66";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wfJtx32q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E165C911
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFI47kV023093;
	Fri, 15 Dec 2023 20:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lDKkKpMSTeeo8vrYPR+zL7Eii1gt39uyaVU3+GcPzjM=;
 b=MHJZNd66B4cJCwcXnaBPyZPVl7ddmcxgFvvVstfzDHRtfCeUnSIf2Ovxzln7sMlgu3nX
 WzaWJvNj/Wcm/VFBoca9UjDPMpy1z++4/ALOXna1Cn946sG35gUrYSVLHiUU4+MySIRe
 PZG8lPtXPeaJhVkGx68bI6BgbuwNCo7kB+qVDpBKXrPVLU6x+holrkvqNY2W8qeCcRpU
 hoSO7w+3Jc24arOjazbkkl04B6B5grn+4tC6hNRzp01rFPAvB0IjFWMPKCIKOhjaE46r
 TcE1dYqV77s20Gfpb/JA8T7OMQmA0T066qw230MxPR07/o07qpY4cN0Lhhq6QcnMoE3O jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3var1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 20:00:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFIK3Wa016638;
	Fri, 15 Dec 2023 20:00:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepchj1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 20:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFgxI5QUfEh1aDLuNqKjgJ89+fq89Ht4a0T/1K7DZ7wqVsF3R8IxjsdvizfHlZ+LOTLAonhtYpDqLqvs2oyLQa2XHfD2qpzrPEoVTdrqyBxVLIh7KWSRmPsbM1l/+QMmGjX4tm7idQKGxsK/lB8zJi+xUZ8i2hYDpLlG/GYZgyU8CBBFcDBXfyQeGeekTQ30opbzCF12WQZcFb/z0/+E3cr6DE3LvJQMI8EbjPCKOJ1/wXMe18PiLcu5sfusGnTBJ5hwh5OISZe7TY1/0MYsBTnRAgvCV3559tqj0xMVMnfEedlXGGzU7811kJexwRa24fiPfbyc26kENLcfPPufAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDKkKpMSTeeo8vrYPR+zL7Eii1gt39uyaVU3+GcPzjM=;
 b=mb3Zx3pAvXVG46znz4iWR79DILu7k97t6K1atSIDoWqLOP06uFW9Up/1BagP600nfnOmkR6RUmrY2ewC1YLSAqmqedgFUvyHD0z72/k4q3lPYP/RS4VBk4hvfFQsnaQelcLUHbX3/y++1iugNtYQjNdgefORvjA3DLTGBks03AZ8CdGXUYj8p9QDdHYnSYDqvuSYwFPAV2uMJ64maTVXPnwqFkLRkxJZXrG+M1AgQiWdudEJ12MEArMJJKysqemVmci9XslnsmtQ1HPEW7ZFS+6QMqp40mHQdy7vJpHqmtV1taAHpCi2nUzCGMAeq0cQPhwAsfcYRpOg88Ox/4ms6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDKkKpMSTeeo8vrYPR+zL7Eii1gt39uyaVU3+GcPzjM=;
 b=wfJtx32q8KXZYnHB+XGrHiX1Kih2l4BFFL+pVLvqzinhnXzu6cvScxJ1/pNT/Y0rmelYvsrA51oMvPDuT8Ns/NE7RcbhfyvcqGu7zgxnSxQ3B8UbvCa1FjDBM+6nlrVn10fRK3/3XxCTQKNPscUS7a7dve5pBoTHHqH9le5WR5k=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BLAPR10MB5284.namprd10.prod.outlook.com (2603:10b6:208:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 20:00:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 20:00:40 +0000
Message-ID: <dc7a582f-3898-4f92-9fcf-bf76373f657d@oracle.com>
Date: Fri, 15 Dec 2023 12:00:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: restore delegation's sc_count if nfsd4_run_cb
 fails
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org, linux-nfs@stwm.de
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-3-git-send-email-dai.ngo@oracle.com>
 <5b07e47d33925128400559f6c5eef694a9984279.camel@kernel.org>
Content-Language: en-US
From: dai.ngo@oracle.com
In-Reply-To: <5b07e47d33925128400559f6c5eef694a9984279.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:335::9) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BLAPR10MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f6e986-dec8-4260-10eb-08dbfda8837c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yRiA4X/dj9SpOpWZ+oG9LES+qRf0EYL5mkx0m6CMLZWMAVzVdAutvisZJ1hgz869O3u+ukiwFm18zoH9sKZ1E5Gv3VouqzEqV9nWcnT2usSEBobO36MEVyAMpO4MqdsLEHFd8uUHou1tHhWiTyMP88wRgPg5XHfmOudue4/Z0N2JX1VrnqXJlRKPOCuOr1fqBp5uEg1451u52jhAjSywVbYXZokJAi1Jgk3aG3ms63cRThPG4SLprHoTkrhnINMBlekiMXmI8W7mlspksxblcKvTMw8GQGxOSt0oM/v6iWPof0RewZrO/f6lD8kxVIEaA+3qqOKalxMepsl6q+irpXyv3AH/zVZzNtyLzj1iabQi+6NRhLmfQABO4B2NezsD064Cppoo927sda2NaRIsAhBYaJ/kWcbV7jBU9pE+MUv58tmih+tWUVm+1WErsHSB55VQy1nbePJ+VoFhEQyliK4Zz0zPlXp1+D0WWa7mdWDXRwNETv3llBucu9u/V97J/dGLan6mNbDADQupaG0ncYex8LErbTrEwtMPGm/yOMsSrWvffScxDcfz45XPRIe2bPYn+RZHYxY09YsjugBgTG9RQakgYdU2GgjjuC+EC6tFEQ/0ZJetgBuwkxicgHeH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(5660300002)(2616005)(66946007)(66556008)(66476007)(31686004)(478600001)(6486002)(38100700002)(4001150100001)(8936002)(8676002)(4326008)(31696002)(86362001)(6506007)(6666004)(41300700001)(6512007)(9686003)(83380400001)(316002)(26005)(53546011)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZktwbWlvUnVWanJ1QVRJYzhWSVhSWnBTTldTMVNnVkZ6dktIRkNzMThFSkpD?=
 =?utf-8?B?YmU2cTdCcjhWcVRwMXlSM0IyWjdsV2RwTXcvL1grWU4xR001Qy9iQi9UeUlu?=
 =?utf-8?B?M3FqOFlqSE9vQnU2SE1obzlON2hHcmlJcHF5ZzdRYjk2bzV2czJLN29KQVN3?=
 =?utf-8?B?U21peDB6S1hHTlh2RFV1Z2NtVXVic1c1UnRaYmN4RUgyMG5XcTJlMCs5ank0?=
 =?utf-8?B?VXplZDRkRi9pcEtqbFlpbjBtZGNWZXZWaEJJSm5pQnp6anRRc21CaGRpc2cv?=
 =?utf-8?B?YjJSdU5vRStUWDNISE9WQWhHVDBZMUtWY1lGTzIwemVRSkxmbEYxandQY2JR?=
 =?utf-8?B?UWhPaUlTaU9BeitRaWYrQktiQ1h4V3VpNDlZMkhzVVRaaEEwTzNKNUhaREha?=
 =?utf-8?B?VFk2SE5GNkQvdGMwTC9lN04rK2VxTndQY2lad0Q4dzcvbG5va3dEcUxzN01W?=
 =?utf-8?B?M1VFekI4cTdyQTMxVStRZXNLZkQzY1pyU1BveGRzMUo4VUh0UVBmZDJQcXJQ?=
 =?utf-8?B?K21mTXVOeiswWW0zL05oK25HVzdWN2g3bk1RREFJT2Z2MUVOenBZUnordGRU?=
 =?utf-8?B?RldZZkdXd3p6Y2pFZVZYVEgrcVE2ZklyRU9lUGZBTVkzdUVjUWwxMFNya0Ra?=
 =?utf-8?B?dHk3YS9iMjZiZ3pNQnJydHhUZ05sSnFla0lpSmttaytnNDM4WFlMSFNzN1R5?=
 =?utf-8?B?RTIxM0RtM0hEa3cvVHdYeE5Va3FITTFQbkhoSXZiVVcrQmVCQ25iZmZDUjNW?=
 =?utf-8?B?VllDYnlzRHFBeEFvUEdGYVdaMXlZYlhvcUFpRmVVWk1ZM1RWeVFvMTJCdVpt?=
 =?utf-8?B?enFhdStvdHY5TUpDUlhEREJ3aVJCTlBIazBKZnMraE1INUdQZzJxT3JBUS90?=
 =?utf-8?B?UWZEV2RJdjcvWUJkRkVXR2VWQWdXY1J5SG9qZ1BSSEtwenZ6cUdwcGJqOGE4?=
 =?utf-8?B?UFRDMyttLzRaQitDVmlQZEZnTUxSajRqNlYrckx5UHBLNkJHMy9QWjdpV05Q?=
 =?utf-8?B?VHdYVkxjMGQ3bkV6c3FoSnYzQUdNellYNktRRVR3MHBCWE5aZHVIYkdOcXAz?=
 =?utf-8?B?dTczcTBrQWIyb1I0d29TVHl2cmRMRDh5NkdhSmcrTGlyb0Q4MkRMR2Q0OW9h?=
 =?utf-8?B?eStOQ0ZRRUFNS01nRVk2eW8vcW1nb1FZU3J2bHZiYXYxWFIxNk5RenZKSGgz?=
 =?utf-8?B?YlFtU05pU2UyVnl2K0Jaczk1bDdYVlFBcTZNbUFpZmQ1TERDVU81b0kxdFlp?=
 =?utf-8?B?dHlDTXZPOSt3VllrV1FlQ2g4MEt3dlhuQWxOQVdiQVBFamVJYzB1amFrVFNx?=
 =?utf-8?B?TlhnQjNtMUVHOGRRUTBJdVlpaFBpTEdnS0xINnZzQVlrcGlSVzFqVlFkVXRI?=
 =?utf-8?B?NDVZOTc1WnVUQ3NuTGZmZXd6RDhDUXBIVG9IdUNBNTQzcDlvRkJUZmlCallI?=
 =?utf-8?B?NDI5dDBPcWNlSkpEN2VLd2hBNW9SVXJnZEg0NEM4QTl6YnROUzBaNkIvU0w1?=
 =?utf-8?B?a2ZQdnlQQTRzZE5NZXBSUjY0WWM0WWs1RkZ4MmlsaTdXaWZpR3ZXMnAxeU9C?=
 =?utf-8?B?dEtuYU5XZ2txd1hQdmxDN1NkQXRkcGQxSFZydWRDZmdzbzZ4S0ZCajJKUFM2?=
 =?utf-8?B?QkRJeGFpMG1PMlFwU0I3OVY3UisvR1dTZUIvQytaQmdsWlBvSll1dnJXblh5?=
 =?utf-8?B?RGVmK2xFZk9xT0NkYmEvaFlWRWcvR1krdTFMRyt1NHNkV3NpaW5DbHpRTVNo?=
 =?utf-8?B?NWJ3cXk2V2U1cmlEVzZXM0dyVWpCSThwdCtEazB3Q2picC9INDRDUkhqNld0?=
 =?utf-8?B?QndDdnlGdzBkY05yUGRRTTJSV3puQUdtMjRaU2ZmMkZaZXZ5Q3lkcDEwVlFy?=
 =?utf-8?B?LzZCOUVTVS93WndFRVJtdmR6L3BsaGxhb1NReXpUNmwxdHBhbXVIaDFOOThx?=
 =?utf-8?B?bEUrY3BBaHBHYUttTFo0Sm94QUY2QjJhcXpBRXZyNCt3M3pwb3k2LzVob3BO?=
 =?utf-8?B?OFVwUXFoMEplV3BLOGs2WDllY3dNRnY2MVdIdUdiMXZvSWZGV0lsb3ZQVTdz?=
 =?utf-8?B?eFpKdkhuK1hKc05yaXhSZlVpbWVkeWhMVUlVM0RBNGtXYjl2cDhRTVFhUFU5?=
 =?utf-8?Q?5LHETNOpMGF7hRr9OIjs7R+kQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	26SJWldngzsmQEQAp4ldFXvLF/ATvNz2drXn8vfzgh7n17k6xtFgAOQpSARMWddb0ZJ2AIBerJwY+XKB166zQj50ZP2UNxIJd+pcow0w5TQmqAKi2EWhoWuizHJEs4HBoAKLuUfiA+DNMhDR/PcwcHk0NuWdIQkdBRLisI7L3tEASMN45uI491D2nphGZTKq/bXzZv/khEcY14x4c4iLrS51LOu++hYKJbbj9D55kNWCNR5rZO9f40DLEf5isIcz3UjGmU80PCN1VEySjW6SAodiV4PeCeFynzCQwjmreFjJj94B0i2Qhe+UCIttEeJmSgUELfigpFlYNYEng1bKJ8Vzzq4f4ZZQrCHwFcOvNIpYc2v+dJY90FmFtUbhWjn0xeMub0AVIRVJwa4zYeATglxcOGrtn1Ikt4JomQg8QIPynN/5NSrdc6lX6g2G7c/dAuFAxs+WSeNmq6LrSCO5Ehym8Z756OP6Rn9cLkFMVeQ/DF/Ijoe5hX6di2nE1M+LtPDqhMXvqqGXtSXlXP0/ZKVgdqsmSqes9VRNjpB7MYXavIIkVRNBolEd4HnT6HzHNz6mEKzPZ1aDSSYzuCM1BWGw035mfxSH+Mvs2JFh0RQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f6e986-dec8-4260-10eb-08dbfda8837c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 20:00:40.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjPczybXlwEcQsPpGHMvTbSVkf7It2Q/3lZ1+sAafvd8xE75LQDlZ9ile8N7MST4R/mDaIcJIIA3W5KEOH3iBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150139
X-Proofpoint-ORIG-GUID: nX1WFiVDpP5tidcWJIOl37vpbGVMgQq3
X-Proofpoint-GUID: nX1WFiVDpP5tidcWJIOl37vpbGVMgQq3


On 12/15/23 11:42 AM, Jeff Layton wrote:
> On Fri, 2023-12-15 at 11:15 -0800, Dai Ngo wrote:
>> Under some load conditions the callback work request can not be queued
>> and nfsd4_run_cb returns 0 to caller. When this happens, the sc_count
>> of the delegation state was left with an extra reference count preventing
>> the state to be freed later.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 40415929e2ae..175f3e9f5822 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2947,8 +2947,14 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>>   
>>   	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>>   		return;
>> +
>>   	refcount_inc(&dp->dl_stid.sc_count);
>> -	nfsd4_run_cb(&ncf->ncf_getattr);
>> +	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
>> +		refcount_dec(&dp->dl_stid.sc_count);
>> +		clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
>> +		wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
>> +		WARN_ON_ONCE(1);
>> +	}
>>   }
>>   
>>   static struct nfs4_client *create_client(struct xdr_netobj name,
>> @@ -4967,7 +4973,10 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>>   	 * we know it's safe to take a reference.
>>   	 */
>>   	refcount_inc(&dp->dl_stid.sc_count);
>> -	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
>> +	if (!nfsd4_run_cb(&dp->dl_recall)) {
>> +		refcount_dec(&dp->dl_stid.sc_count);
>> +		WARN_ON_ONCE(1);
>> +	}
>>   }
>>   
>>   /* Called from break_lease() with flc_lock held. */
>> @@ -8543,12 +8552,12 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>   				return 0;
>>   			}
>>   break_lease:
>> -			spin_unlock(&ctx->flc_lock);
>>   			nfsd_stats_wdeleg_getattr_inc();
>> -
>>   			dp = fl->fl_owner;
>>   			ncf = &dp->dl_cb_fattr;
>>   			nfs4_cb_getattr(&dp->dl_cb_fattr);
>> +			spin_unlock(&ctx->flc_lock);
>> +
> The other hunks in this patch make sense, but what's going on here with
> moving the lock down? Do we really need to hold the spinlock there? If
> so, I would have expected to see an explanation in the changelog.

We need to hold the flc_lock to prevent the lease to be removed which
allows the delegation state to be released. We need to do this since
we just do the refcount_dec if nfsd4_run_cb fails, instead of doing
nfs4_put_stid to free the state if this is the last refcount.

This is done to match the logic in nfsd_break_deleg_cb which has an useful
comment in nfsd_break_one_deleg.

-Dai

>
>>   			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>>   			if (ncf->ncf_cb_status) {
>>   				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));

