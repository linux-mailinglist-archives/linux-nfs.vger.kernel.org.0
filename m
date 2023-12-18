Return-Path: <linux-nfs+bounces-693-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF543817980
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9A12840C9
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BB15BFAC;
	Mon, 18 Dec 2023 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NG6yhYB8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bNeMdp+w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EC5D733
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHXVa6009509;
	Mon, 18 Dec 2023 18:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=suwk3gK7gOGkyP3wP3LhOAFldpAkb1e31kJKGSPfTLQ=;
 b=NG6yhYB8NFCXVBAsldZMXFRVgB+GbuNNIO1QdscPnJt86j7o6s3bVIyH3DoPJIxoA/4G
 6JUxmCr5sVsIPZANv2ofBiP/Eso124Opqri7JiDFzNgAphYzi79+WQV1CsrtFV3662ga
 lh3GpCckeIFS2W1JS6WdTHqvOmfaveMeo5UBEmxIYbIoOVx1FJHyAM2MXqotGz6bOoRI
 RbglFRUscnoy2DQ6WhC4enj8mLqrzSJCTAPIcX59j0YdcoOV+B42Ed77C7+hWVKqBJev
 iEkgZ/iCQCUREMNWVNBFoRr/Vnb5fZUPLIZIbWvNdgMTieCCa0cdv80aGXTsmX0BqB0U cA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v14evbvec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 18:17:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHkPid028981;
	Mon, 18 Dec 2023 18:17:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b5gx09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 18:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv04xQ2sRRBkDR8ScwigLnwAjlVsvzL6BfzgVR90bq6WS+Jn0H9T1m44owOdaQhbvJ5+VyZtpXCiFCvFMC8+pxetUGlnb/fOYLQYIx5OXjNWgJEnMFhJQYtsPw/I/gSOftQPJNBEGTQ5ekFDATCmGk2fKbFZd3aCrNGDrEEUktPJnYhLFtXXBxaw5An5dl/+oEIfxK4j4bSriJ1PcqT5YszJYK6k2c1edZW0/KWjnioXyzk5daj0TMUU0ZX8zPNtsggfJt2HMT48sUwAMzzqdVqV7nYWqALIKNigMoYzLS0aCSGd5L/nt7nXMo+TWVgHSFXI/0pzZi/kUSr8jcSOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suwk3gK7gOGkyP3wP3LhOAFldpAkb1e31kJKGSPfTLQ=;
 b=CS0BKteERzb9oCrccmVQK7shGcKsm7xPUJyAe+F7W4BRtABhWl6Y1Cy4xfMHKFWPjTDI9IAwOSJU6aatUoT2pAJPrv0vHnYzedAynEujG4mIWIs8ZdTx+fx/3AEuEG8kpetbwZlNl53727IcuXgagSdImTumsN3lwQfnMaX6yekPsN6AaVu44ZLriFa1xsvo1hBfHLQnZcPYrsoChr+IJvnJgpyfV6Fdz8/VVFGIJxXrBcnHoNX8zEC0IL2ByNSS8h7puaPizgjwPA8mlMJguA/VWioQWETiz6wE64w+z5PVy7eskJccrZD9tPJO1i8C2GmNMhxjWYpHWgFkClwSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suwk3gK7gOGkyP3wP3LhOAFldpAkb1e31kJKGSPfTLQ=;
 b=bNeMdp+wQCX42EZ7Son0axWlFDB0eD0oo/RD/yS4PjIwu7VOINXyvcGiGTWJuLkazJpv+KxqRrATmFijxGZYTyaeicxO8nTiOb9M1iS0afDOYOJTF6dlbC/uMIAi7FNXo+2AFJQG3iN7DWyUsJ+2gl10ZRAakLtPf8fqmeYxDt0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH3PR10MB6901.namprd10.prod.outlook.com (2603:10b6:610:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 18:17:53 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 18:17:53 +0000
Message-ID: <11b384fc-413b-45e8-8592-1f736de6a3de@oracle.com>
Date: Mon, 18 Dec 2023 10:17:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
 <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
 <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
 <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
 <aef15e6d-20c2-461d-816b-9b8bc07a9387@oracle.com>
 <ZXz7nxzlPfJ+06QI@tissot.1015granger.net>
 <1a988fe4-a64c-48c2-9c2c-add414294e07@oracle.com>
 <ZX0gOlqGbIES5RtB@tissot.1015granger.net>
 <88802128-3ae8-4f91-aeeb-69693b137981@oracle.com>
 <ZYBtEs7JfMCi0TCl@tissot.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <ZYBtEs7JfMCi0TCl@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:23a::11) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH3PR10MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: d6912622-1d17-4a5a-f96c-08dbfff5a6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uQQetIzdSHTG9ALKCq8h8SJwwN+85gCyZdpqmZpgm19aSocdffN+C4WyIj4ibUx+caFh7uy45erZIGZ+G83O2PoqGx2M8Aoe+YxON3o8D2E3Qd3ea0vzanmVCj9Z4e+7RFydorsG8BSI2FE7L9meyLroWwE2BOMRHgikd8m/6kD9Erle+j5XdQIHAe5bQyNhMHFIjIWgEEX3RbSz3XUBQJrRYWQrsc5rTwBKEooky1etuoYjFu0pg4FjqNPQ3GfjFx6hNXpfRN5K7G4ZUpkbWYWyI/PAlQ87AYppxyqfj3nlXsP2Ra0e22XS2AjT0JyDkI0DY5SuwVsJKfzdMvFdPgP9lWNnQt3T008Re4lrPDWjTKGmzpnlkOT4esDt4tBUnTM94056CKhXXnELT6WC950y+vcWl+56SamL0r+YDmleen8pTgO+W7o7Wu2uj52jmLCFDZdEBEEK1Tyenl3yaz+rKI3iWXxyR3IxzT9DtqwsCkIZ8yfATn5g5DB/aq7L90/g/jWg9WcwqAabRB2st0vAiUlxC+zBp9IvbsNoU6FuxR0kiygrCZekqh7dXhrHaIX2FW3GdFIP3TyZbmD+L9dmAQVoippm/AyxAmAip+Ak3w/3SVlWUFkoTV1tFmUa
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66899024)(66946007)(66476007)(66556008)(38100700002)(31696002)(36756003)(86362001)(83380400001)(53546011)(2616005)(9686003)(6512007)(6506007)(478600001)(37006003)(2906002)(8936002)(316002)(6666004)(8676002)(6862004)(6486002)(5660300002)(30864003)(26005)(41300700001)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWZaUkpHUkxOSHJhRlc0dkJHYUlBZGhhOWlaeEhtUXRlT29zbldZaUJweUx4?=
 =?utf-8?B?M3FtTzc0SFpqcmUwczFYSlFpOWIxM2pjMlQwa0ZkUmZZTWhISlk0NXJDaEhS?=
 =?utf-8?B?aG1MejJOMENhYlpoclRuUDZLdVlOc1BLcFdrOG5rMURZYWNEWjJKMVNKUDli?=
 =?utf-8?B?Y2piK2kwNURQd3RqOGZxZU85d2U4dU1XUnhJN0pFa2xkWkVSYmNwYnA3eUN6?=
 =?utf-8?B?T1FHekZQdGpxQ0hVUHhkS2prY3FWOGs1YXVVZ2FEV1ZnUjRRbVM0NDl1Y3Nv?=
 =?utf-8?B?S3lsMjZrZ3ZaYUJ1ZUFKbTVWNThSaUpJc3dJZVhTMDhXR2k3QW1VOVlaRFdD?=
 =?utf-8?B?M3Iza0J6dmFSSFhld2s3bU1HYi9TUjVoL1QwOWNXd2tHTkYxVTJjdGlDWEdV?=
 =?utf-8?B?ZWhzWVk0bGpPQjZObGd2T05KYnZjYW4wUzBUSG9DZlZKK1JLY1pBYUhQSWlJ?=
 =?utf-8?B?WFBXT0IxN3NNVnpKRnFVRmwvL3FPdHprYVVDcXhLNHUyTkEyWnpqV3JQZk9V?=
 =?utf-8?B?ZWc5QXRWSFo5a3lONFhTeE93SGFkVEh0K3dzL0RSNGx4ck5GbWxWbWgyUFdi?=
 =?utf-8?B?R1VvelBoSDJ4ZnpxYWxIeHF4R0lBajFQaFZDVkZKZ1hLWjJ5bWV2WTNTbS9W?=
 =?utf-8?B?c3NocFVrQzIvUWZ1QndXQmxGbTl4WVhReGs4VFRGOVl4WHpBdDcwUkZMbWMx?=
 =?utf-8?B?YmFtRTlwQzB3TUd2bTJ5dXlLS2tSQkhVWFlMNWxHdjJUZ1VjdzZzSmlleHZS?=
 =?utf-8?B?S1I5bUdYN3ZBcjI3M1A1QWdJd2Z0QmJBSkFEZUVQcVNKT0YxTVR2ZlN2ZE5O?=
 =?utf-8?B?TjJ0TFRoZ1lyNjNxRE15MEZnb0x3SU9sVTNlM3VadFVGSkgyKzNtWXluTjJS?=
 =?utf-8?B?d2FEblAwWEFFOThtZEV4aktRdVhkZytDME9ZcThzQVRZYmNHR2czUThxT1h3?=
 =?utf-8?B?SlBQTDNvSmJxakczTlA5Z1g1UEFnRlllYkszam1Ra3lIQkNYSHo4Z004VXph?=
 =?utf-8?B?ZDY4KzgzbDBaWWtrc1lrUWlKalk2RHMzZmR1ZjJhODR2b25RcEN4dFhDYXdR?=
 =?utf-8?B?SndNZUFmZ2lueWVDeTA1eHhFVnZXR1dud2Q0SllRdUtPaFJpOStLbzhialNy?=
 =?utf-8?B?Wit5VkdOeEZ0anhldWNqQnlhTnBEeVUybWR1c0ZvZi81SE1ZNzNnQU1za3Jt?=
 =?utf-8?B?VUljaXo3WUIxOXByTWs0RUcyNGNMdWx1MC8xcjNSczNjRFRGTC9hYWJDT3da?=
 =?utf-8?B?b2xuZVZzelZHMU5jVnVHd1dmaTgyOUpkMllLNDlXdjVnTFl6bDVNUi9nOFFi?=
 =?utf-8?B?Wjc1VVJaQ29pRzBOcXFsZEZXVlRiYTg3Z0lCUXVRRmNkbDZKcjlZcHd6ZnpS?=
 =?utf-8?B?VGJIY0xEekluUFVxRFZCcm1QTUp4NENqbXVIdmVBcVZpVEN6NkZHZi96SG9R?=
 =?utf-8?B?cDZTK3hjb3h3ZFo4OWVxNTVHOS9VaTdyNG1IR3NodU5RV0VZaDRTTG9UK1Zw?=
 =?utf-8?B?SUJHQ0NoTlJjY1Q1ZGM5eFJsdGEvc05OODlOTlhwbVc3VHhEVUM3RUo1Nkp1?=
 =?utf-8?B?eWtwa0w0T01oUFl5TWJmZEduZ2p1N2tKQzhoa2pJK1ZsVlJybWJSWGg4RUJr?=
 =?utf-8?B?NW5xeDEzWWsyRk40bEdhdVUySlFDZ3dzRGo1M1dtQ0FwUVNrbE11TURTY0Vi?=
 =?utf-8?B?dmNSc3FkT05DMlVQc2Z1MlRSZWExUjErQUVRWGt4Vk9UVVJVdmh5bkZEUEFB?=
 =?utf-8?B?ejNsSUttRnlmQWFicTlGdi9CWjFGRE1zR0txeFd0TXArMUlFTE9td0VSTXZy?=
 =?utf-8?B?RG1BMVp1a0o2YUplalhkdGdHZk0vZFd6OWdPTkdBUG05emtUQzlsNit4R0tJ?=
 =?utf-8?B?MVppWGVhdytEU2JLWGpuaW5kMy9ONmZ6amdNSTBFWncyNFdCeUFXTEJqUHZH?=
 =?utf-8?B?MHdGQjhYT2RJek9VMjF1L3ZCNFg5MGVLUlJGcll6K3krNjhqcDgrblNWVkZ2?=
 =?utf-8?B?SzZtR2tSOEVqM214Q2RRbzV1ZjNQRkw4L1NMeC9mWis3aTZUUm9DL2FjQ2JS?=
 =?utf-8?B?aEJ1YnBjK0pwSmZLUnA1SURhOTNzcGNQdnVzTkQyOGlFUEN3cStBcDVMakN4?=
 =?utf-8?Q?QoQPZUEnLk6nJrMRd6S8/e3P5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6+Ukbp5kMb+MGx1y2km0DmnzGJgoWpF0Yll+W+9BbTD3lJhbMta8U4NMTt7BM8xWDqeCxpP92wAKXV8Ln+aTur4PgAvAC4VaJhILRPOKDH7kZ9MvUWOnyxUk/co6/+Go0iGINN++AlsHJnB92O5NhK1wIIYTguU4E0unVog3n0gRQ33Mf15YW70fatVvmQ0aawTw1R1yGfZCdIRbyiicfW2WRM/BbqMD0BE0M6RtnUW3Ltp8TVZIkOl6ve/dqbelJa3Gwl9RhwFXQQjWYlPR4uFQbzyA33GPkcVa7TI9BMI7n2t5gxgfzK2XBITn++vpXCywazU85zgAPXYar5RjC5WEao+JZSN1S8m5TGW9cmQTWGLZ3/7y2qdnh9iMOnfDPizU7g7q4fEfjnahI1Ds83kqNgqF5KLAzcs+df3PDr7TuYK2rTXE59WMfm5+nXQldV2d3H4MDj1sUGCX41rNQMgr4O6OUphLM8ELXEcfXJ3bzlIvZXzAdIY8dxn//VE3W+5DDnN4cjvTJp4CEI4+/iw5Vz84bpXSRf9v/9Tbnhfzr2kNf4K5gwlgiwzrSQPLheIpJo/13FF8POn62Y5GsSBCZDXG2aUV+uocfkqQEJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6912622-1d17-4a5a-f96c-08dbfff5a6a4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 18:17:53.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7ICiaWfb2L+ZSpMhAQQy0VHzTnB/5H7KhX12+2Xb9NIu5xlB1sbLlUQ/MYvEMRn+IRLSViHWg7FcqkohOHpug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180135
X-Proofpoint-ORIG-GUID: sUF1Ol1zksHVUE2ftGV3hJJV4ugP3M9R
X-Proofpoint-GUID: sUF1Ol1zksHVUE2ftGV3hJJV4ugP3M9R


On 12/18/23 8:02 AM, Chuck Lever wrote:
> On Sat, Dec 16, 2023 at 02:44:59PM -0800, dai.ngo@oracle.com wrote:
>> On 12/15/23 7:57 PM, Chuck Lever wrote:
>>> On Fri, Dec 15, 2023 at 07:18:29PM -0800, dai.ngo@oracle.com wrote:
>>>> On 12/15/23 5:21 PM, Chuck Lever wrote:
>>>>> On Fri, Dec 15, 2023 at 01:55:20PM -0800, dai.ngo@oracle.com wrote:
>>>>>> Sorry Chuck, I didn't see this before sending v2.
>>>>>>
>>>>>> On 12/15/23 1:41 PM, Chuck Lever wrote:
>>>>>>> On Fri, Dec 15, 2023 at 12:40:07PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>> On 12/15/23 11:54 AM, Chuck Lever wrote:
>>>>>>>>> On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
>>>>>>>>>> @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>>>>>>>>>       			nfs4_cb_getattr(&dp->dl_cb_fattr);
>>>>>>>>>>       			spin_unlock(&ctx->flc_lock);
>>>>>>>>>> -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>>>>>>>>>> +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
>>>>>>>>>> +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
>>>>>>>>> I'm still thinking the timeout here should be the same (or slightly
>>>>>>>>> longer than) the RPC retransmit timeout, rather than adding a new
>>>>>>>>> NFSD_CB_GETATTR_TIMEOUT macro.
>>>>>>>> The NFSD_CB_GETATTR_TIMEOUT is used only when we can not submit a
>>>>>>>> work item to the workqueue so RPC is not involved here.
>>>>>>> In the "RPC was sent successfully" case, there is an implicit
>>>>>>> assumption here that wait_on_bit_timeout() won't time out before the
>>>>>>> actual RPC CB_GETATTR timeout.
>>>>>>>
>>>>>>> You've chosen timeout values that happen to work, but there's
>>>>>>> nothing in this patch that ties the two timeout values together or
>>>>>>> in any other way documents this implicit assumption.
>>>>>> The timeout value was chosen to be greater then RPC callback receive
>>>>>> timeout. I can add this to the commit message.
>>>>> nfsd needs to handle this case properly. A commit message will not
>>>>> be sufficient.
>>>>>
>>>>> The rpc_timeout setting that is used for callbacks is not always
>>>>> 9 seconds. It is adjusted based on the NFSv4 lease expiry up to a
>>>>> maximum of 360 seconds, if I'm reading the code correctly (see
>>>>> max_cb_time).
>>>>>
>>>>> It would be simple enough for a server admin to set a long lease
>>>>> expiry while individual CB_GETATTRs are still terminating with
>>>>> EIO after just 20 seconds because of this new timeout.
>> With courteous server, what is the benefit of allowing the admin to
>> extend the lease?
> The lease time is the time period during which the server
> /guarantees/ it will preserve the client's locks, even if there are
> conflicting open or lock requests from other clients.
>
> Once the client transitions to courtesy, those locks can be lost
> due to conflicting open and lock requests.
>
> Clients need to know the server's lease expiry so they know how
> often to renew their lease. That's the only way lease-based locking
> service can provide a lock guarantee.
>
>
>> I think this option should be removed, it's just
>> an administrative overhead and can cause more confusion.
> A server administrator might extend the lock guarantee by several
> minutes if her network is subject to frequent partitions -- that
> will result in long workload pauses, but it will /guarantee/ that
> locks won't be lost during short partitions.
>
> The only reason not to extend lease expiry is that it also
> lengthens the server's grace period. If the server is accessed
> only by NFSv4.1 clients, they can use RECLAIM_COMPLETE to avoid
> long waits after a server reboot... but with a mixed client
> cohort, a shorter grace period is usually preferred.
>
> We have the tunable now, so I don't see a lot of value in making
> an effort to deprecate and remove it until NFSD no longer supports
> NFSv3 and NFSv4.0.

Thank you for the explanation.

>
>
>>>> To handle case where server admin sets longer lease, we can set
>>>> callback timeout to be (nfsd4_lease)/10 + 5) and add a comment
>>>> in the code to indicate the dependency to max_cb_time.
>>> Which was my initial suggestion, but now I think the only proper fix
>>> is to replace the wait_on_bit() entirely.
>>>
>>>
>>>>> Actually, a bit wait in an nfsd thread should be a no-no. Even a
>>>>> wait of tens of milliseconds is bad. Enough nfsd threads go into a
>>>>> wait like this and that's a denial-of-service. That's why NFSv4
>>>>> callbacks are handled on a work queue and not in an nfsd thread.
>>>> That sounds reasonable. However I see in the current code there
>>>> are multiple places the nfsd thread sleeps/waits for certain events:
>>>> nfsd_file_do_acquire, nfsd41_cb_get_slot, nfsd4_cld_tracking_init,
>>>> wait_for_concurrent_writes, etc.
>>> Yep, each of those needs to be replaced if there is a danger of the
>>> wait becoming indefinite. We found another one recently with the
>>> pNFS block layout type waiting for a lease breaker. So an nfsd
>>> thread does wait on occasion, but it's almost never the right thing
>>> to do.
>>>
>>> Let's not add another one, especially one that can be manipulated by
>>> (bad) client behavior.
>> I'm not clear how the wait for CB_GETATTR can be manipulated by a bad
>> client, can you elaborate?
> Currently, a callback is handed off to a background worker and the
> nfsd thread is permitted to look for other work.
>
> If instead nfsd threads waited for callbacks, then a client with an
> unresponsive callback service would pin those nfsd threads for the
> length of the server's callback timeout.
>
> If the client's forechannel workload is actively acquiring
> delegations and then sending conflicting GETATTRs, it will keep such
> a server's nfsd threads stuck waiting for CB_GETATTR replies.

If the GETATTR and the delegation owner come from the same client then
we just reply to the GETATTR without sending CB_GETATTR.

>
> And since those nfsd threads are shared by all clients, all of the
> server's clients would see long delays because there would be no
> available nfsd threads to pick up new work.
>
>
>>>>> Is there some way the operation that triggered the CB_GETATTR can be
>>>>> deferred properly and picked up by another nfsd thread when the
>>>>> CB_GETATTR completes?
>>>> We can send the CB_GETATTR as an async RPC and return NFS4ERR_DELAY
>>>> to the conflict client. When the reply of the CB_GETATTR arrives,
>>>> nfsd4_cb_getattr_done can mark the delegation to indicate the
>>>> corresponding file's attributes were updated so when the conflict
>>>> client retries the GETATTR we can return the updated attributes.
>>>>
>>>> We still have to have a way to detect that the client never, or
>>>> take too long, to reply to the CB_GETATTR so that we can break
>>>> the lease.
>>> As long as the RPC is SOFT, the RPC client is supposed to guarantee
>>> that the upper layer gets a completion of some kind. If it's HARD
>>> then it should fully interruptible by a signal or shutdown.
>> This is only true if the workqueue worker runs and executes the work
>> item successfully. If the work item is stuck at the workqueue then RPC
>> is not involved. NFSD must handle the case where the work item is
>> never executed for any reasons.
> The queue_work() API guarantees that the work item will be
> dispatched. A lot of kernel subsystems would be in a world of pain
> if that guarantee was broken somehow.
>
> So I don't agree that NFSD needs to do anything special here when
> queue_work() returns true.
>
> The only reason I can think of that queue_work() might return false
> is if NFSD hands it a work item that is already queued. That would
> be a bug in NFSD.

Jeff, when __break_lease is called with 'want_write' then FL_UNLOCK_PENDING
is checked to prevent lm_break being called again. When __break_lease is
called with '!want_write' then lease_breaking is called to prevent lm_break
being called again. This would work for NFSD if it supports read delegation
only. With write delegation, shouldn't __break_lease() always use
lease_breaking to prevent __being called again? The scenario is read request
conflicts with write delegation then another write request conflicts with
the same write delegation.

>
>>> Either way, if NFSD can manage to reliably detect when the CB RPC
>>> has not even been scheduled, then that gives us a fully dependable
>>> guarantee.
>> Once the async CB RPC was passed to the RPC layer via rpc_run_task,
>> I can't see any sure way to know when the RPC task will be picked up
>> and run. Until the RPC task is run, the RPC time out mechanism is not
>> in play. To handle this condition, I think a timeout mechanism is
>> needed at the NFSD layer, any other options?
> The only reason you think a timeout is needed is because you want
> the nfsd thread to wait for the reply. That's just not how NFSD
> handles NFSv4 callbacks.
>
> The current architecture is that NFSD queues the callback and then
> replies NFS4ERR_DELAY. That nfsd thread is then free to pick up
> other work, including handling the client's retry.
>
> It doesn't matter how long it takes for the callback work item to go
> from the work queue down to the RPC layer, as long as a subsequent
> server shutdown does not hang. Either the client will reply to the
> callback, or the server will see that there was no response and
> revoke the delegation.
>
> (Note that we have nfsd_wait_for_delegreturn() now: it does wait
> uninterruptibly in an nfsd thread context, but only for 30
> milliseconds. The point of this is to give a well-behaved client
> a chance to respond without returning NFS4ERR_DELAY -- if the
> client doesn't respond, then it falls back to the architecture
> outlined above.)

The wait in nfsd4_deleg_getattr_conflict can be modified to do
the same as nfsd_wait_for_delegreturn which is wait for only 30ms
to work with well-behaved clients.

>
>
>>>> Also, the intention of the wait_on_bit is to avoid sending the
>>>> conflict client the NFS4ERR_DELAY if everything works properly
>>>> which is the normal case.
>>>>
>>>> So I think this can be done but it would make the code a bit
>>>> complicate and we loose the optimization of avoiding the
>>>> NFS4ERR_DELAY.
>>> I'm not excited about handling this via DELAY either. There's a
>>> good chance there is another way to deal with this sanely.
>>>
>>> I'm inclined to revert CB_GETATTR support until it is demonstrated
>>> to be working reliably. The current mechanism has already shown to
>>> be prone to a hard hang that blocks server shutdown, and it's not
>>> even in the wild yet.
>> If I understand the problem correctly, this hard hang issue is due to
>> the work item being stuck at the workqueue which the current code does
>> not take into account.
> The hard hang was because of an uninterruptible wait_on_bit().

In my debug I simulate the condition where workqueue is stuck when
nfs4_cb_getattr is called and this causes the reboot to hang. But
I'm not sure this is the cause in the problem that was reported.
Note that the WARN_ON_ONCE came from nfsd_break_one_deleg. I will
verify that if the work item for nfsd_break_one_deleg is stuck will
the server reboot hang.


>   What
> we don't know is why the callback was lost.
>
> - It could be that queue_work() returned false because of a bug.
>    Note that there is a WARN_ON_ONCE() that fires in this case: if
>    it fired several days before the hang, then we won't see any
>    log messages for more recent misqueued work items.

The WARN_ON_ONCE came from nfsd_break_one_deleg which is a delegation
recall and not from nfs4_cb_getattr. I suspect this is because of a
possible bug in __break_lease as question for Jeff above.

>
> - It could be that nfsd4_run_cb_work() marked the backchannel down
>    but somehow did not wake up any in-flight callback requests.
>
> Let's get more details about what's going on.
>
>
>>> I can add patches to nfsd-fixes to revert CB_GETATTR and let that
>>> sit for a few days while we decide how to move forward.
>> The simplest solution for this particular problem is to use wait with
>> timeout.
> The hard hang was due to an uninterruptible wait, which has now been
> reverted.
>
> Going forward, if there's no wait, there can be no timeout. The
> only approach is to handle errors properly when dispatching a
> callback.

not even wait for 30ms for well behave client, same as nfsd_wait_for_delegreturn?

-Dai


