Return-Path: <linux-nfs+bounces-10538-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44314A587DF
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Mar 2025 20:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD6E188D1B5
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Mar 2025 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B9214804;
	Sun,  9 Mar 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YfoXVIgo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qLqEPjGm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504EB1CF9B;
	Sun,  9 Mar 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549284; cv=fail; b=HcVqyPUXdsB+FsY0XvTqNOSnizsuommPf4+96DWcr5NsIPVozhDoKlSzfi0Da6e7XIXlRmtnOkYoZyudDlnW9Ouz303e/weJj4z9sIHD+pMMRlYbBMSzrUgtlsI0qSuCr79uaqr/ICM5grvrMOEeK0B80niGgVipsHxBC1vSeiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549284; c=relaxed/simple;
	bh=TD4fLgznx3u07ErjBIxLK8FmVmBzbkE4tmTuXtY9qhk=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=kvbEQYB6TaTCP1IRZ39mwlejuYIuAyq1XHBon3W4673s4zPPwel7roTTpaE5RD9JyJ4xaTGP8hxgZ85m2ZwI4xujHQ9hbjJ6AiHvxK5I03YwSRksWBkM0NU6rGj9jw1H2l7b4nNBm3tT8DO35T0mhf3ELYuvNgUnCCRWMWUDHJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YfoXVIgo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qLqEPjGm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529JBDNb024683;
	Sun, 9 Mar 2025 19:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=gWh+XXBPN9pCGLbkNz
	/lGr9KTWCXdJIrXqOtzBZa4cg=; b=YfoXVIgocQOvToGd/31AtGY+3tMGm+ACom
	P3TctBpasJ+LXA1ij8qE/UQbfx0yDb8oscNacp4ygrRWwlyYshW48uOBgpiamdB0
	U1vuZ1gtk3XxwtaVbewdqNXP0qPUyOm+6yJEnIw8sW1RMbTD5+zF8t4cObgCFIWT
	ozomCAXRcjifMFXxSzx7XXT6SiYltOJDvb68ivj7ly1uoUYgRCDR+LC96XhFzs2K
	hzq3YgEWs52hd/QAonnsiWgYMIiw8vjPjRnuUOSrk+W/gnjhw/8mZk9CnoTJBrnx
	GmlNiexUpAznXL7azXq7lF/7sRwZl+JWH8eyjDQOOfk/8DXHG4Rg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu1b50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Mar 2025 19:40:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 529Ht3Hk026295;
	Sun, 9 Mar 2025 19:40:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb6tw0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Mar 2025 19:40:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwLePTzXkWkfaJxJrwho7RPkY908YQuiS6hOta6+z/sC8MApJUwFOgW55ra8AY/8Uc58p2rrvBoJPgEi2yLkZsw9ekXDWT5IVHoXicmFwoU6nx/QHE438/4zk3EWXTYxuENubjT8Ww4QHTEifDKo87E5CqllaiR3zpdaenyhJ2JHa/LYRRpmCn4hIUCxJvb3avOHIMNxT/VInYdXWF/qhK6hHWXplMDutMpigtBDs9GaYS4EJOQo55qWP+wIai+RQLZyJ+TDvCSJcYfJHX30McJQf9S4YqmeS/w5SOQ2S6KhMDQ6M5e4vMUnyR7aVY1SpNtS9VLvpKEky4rwewR7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWh+XXBPN9pCGLbkNz/lGr9KTWCXdJIrXqOtzBZa4cg=;
 b=P1S95GjgjoOcrRC4PF2O5Fq5oUbwEaka/CFmRqO/Mdaw8fooxc4ROVA7QEos2ia189Jew6cU00iMsjvOjCiWN5FnPKGWkahbyonwgnAv97Cos+I4Ji5sGcmMYW+bPvDoXAl+OpOobUHwhDiIfVlUzq4qfhfULnSibXHRSW7NLu9mEb5lKJqV3Um/e60tT8GveznqeuEL+IjnD34kSnT39v7SXP6t+I4ovHBs7OyH7jXeEvGw3+VyR1jPCiBDV67O1/slKVcE7amiOPeLSEhVHEvlpLJ7dYEE0gBU3BJvx1fHEzf/FCUEWwy2oftbkuzCVzpdwgexXql3CnhLT+/xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWh+XXBPN9pCGLbkNz/lGr9KTWCXdJIrXqOtzBZa4cg=;
 b=qLqEPjGmrwFKd0+2rO8LjnJ1in06YgN6q27KtQ+FAjN93rLdQ8FC0PLNqrZHN5f8f8ehKfHvXMsKtFNCEiZkU0ahafW1/rTD/9AM6/cubNXSr3DyegpIsyz5gh6JU/0QtxKDHQZhL46ENGEEav0u1A76HQ8ehQhWsGrJUSgl5Sw=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SJ2PR10MB7736.namprd10.prod.outlook.com (2603:10b6:a03:574::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 19:40:39 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 19:40:38 +0000
Content-Type: multipart/mixed; boundary="------------ZbppucAv7peIkSZKm3b0FAgg"
Message-ID: <89b0c30b-9b7b-4507-ba1f-0493e88c6791@oracle.com>
Date: Sun, 9 Mar 2025 12:40:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NULL pointer dereference in frwr_unmap_sync()
To: Li Nan <linan666@huaweicloud.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, trondmy@hammerspace.com, sagi@grimberg.me,
        cel@kernel.org, "wanghai (M)" <wanghai38@huawei.com>,
        yanhaitao2@huawei.com, chengjike.cheng@huawei.com,
        dingming09@huawei.com
References: <e7c72dfc-ecbc-bd99-16f6-977afa642f18@huaweicloud.com>
 <314f60a8-4b0d-45f9-87f4-5a4757d34aea@oracle.com>
 <355c8355-a6bc-181f-73e7-1baf7749f984@huaweicloud.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <355c8355-a6bc-181f-73e7-1baf7749f984@huaweicloud.com>
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SJ2PR10MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: d3185a72-0316-4e4d-473e-08dd5f424508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE9WY0pZSjVzU2kyUHY0MjdCMndPU0IvdHJJT3JwbXd0eW81Y1ljTUgwcEhI?=
 =?utf-8?B?T1poOW4xYzFvckJGMDZDS3JhT2RDWEZyQ3p1ZlE2QVZJUEQ1ZFVXdWxIOS9K?=
 =?utf-8?B?WHA5R2pPMmc1MHlhRDFBSnFVdFkxd3FQMGhpV3JpQUw0N1k4c0luQk1MalEy?=
 =?utf-8?B?bG4yL0tUZjlrNXgxZ2JJaDF6SHU0T20xRmlKczRZSE8va0xPWXM1Q1pkRGxV?=
 =?utf-8?B?ZDVCblZWeFVqb3ZNQlUrYWU1NnJGbWpOMXNJM0h5SWRqd0tMcTVVbjA1TjN5?=
 =?utf-8?B?ZzdzRC80b1lsOWNpR2JtV3JsRzV6c1dDWUNweUVIT3Q3aXdrR0c2alZwamJn?=
 =?utf-8?B?TFlNblNNY2M3Ny9jNHZvL1l0a0RRbmIzc25qT2RXZXdyOWpCNnFpUlFqYURh?=
 =?utf-8?B?eWxiMDNENDZBd2V0NldnNEREUC9GSWtsZ1RIbS9idjZMV3ZUNk5PZFBaclZL?=
 =?utf-8?B?cTBLQTM3YWs5WTFZdTRpQzhmOGk4QWdRMkordER5b1NnZDVGTXJrckdQcDRw?=
 =?utf-8?B?dFh1bDd0ZlpQa3Exdnp3TFJiT3ErQ3RmMlU3UUFNcUVFb1Ira1h4L25ILzN0?=
 =?utf-8?B?dlpDRGZPMEQ5aHRQbkl1Q0NlYWE2a3pZK2Fsa29TTG1kS2xEaXBnMDFzdTQx?=
 =?utf-8?B?K2R1SnBBQXVpL3hxT3pFRkQ1aHVoOUxUbFFGS1RhM0NSaDFWOEJ0Z09za1JG?=
 =?utf-8?B?SHZUL0RQdVpJWjluNVlFNnl2R1NNcFNWd1FWazh5VkVHRENHTUxwbWRtS0tn?=
 =?utf-8?B?dk1PbWptdzlucjNtNFJWeDZQZy9XYlM3THgwNk9zWS9GWEV3aFUzcnNoS0F5?=
 =?utf-8?B?am5vYzB5NzJlY0ZiRmsvMmF3VXBQbmVEUGNRcTRQemxqU05CY0tidC9TN0FC?=
 =?utf-8?B?NTF3bWVWVW5CWkZSYkhCb2Z3bU9hc2lvcmNvNnBreFYyZU50ZERqODBXWitV?=
 =?utf-8?B?Q2Uwck1SdktLM2t5T0xBRlpBVk9DZWE5dmJSMkxzWXNDNWdQSHppMnlSNXow?=
 =?utf-8?B?ZXBqSzJ4eDBkWlI2ZGF5cS9UK1VtTnZvMndvekJGYk05SUpEYXlRcGVQZHhk?=
 =?utf-8?B?MG5BeUJ3ckNGMXYxSU5SRGNseHBudHl1V29Oc0ZZRFJJUEZBYVdjclBHaHNl?=
 =?utf-8?B?TGVoejhjZFhrZWpDOFgrTU1iV2ErWFN5MittR2xZV1VkdzUvMjlZRStUaTdC?=
 =?utf-8?B?MkZoRmhOc3FaUzVLcVRQRk1IaTJmOTVRaS8zazVTU0c2bGJLYS83MG16cGVF?=
 =?utf-8?B?VkxWV0huME1NRzd3WnFMenE5MHQ5dEtOdGFlVUJwdXdNYytSdjZZWi9LeHZj?=
 =?utf-8?B?VHk5dmk5ZnZrS1hmMjVxVVhheWluRHNHQWhwYjhDeFZMNWxYVXZZcktLMWdH?=
 =?utf-8?B?U3FzMjE4eEhXZmd4ektlRXJLdW5yUEhrK0s4dFR4RGdPUXA0amhmU1RkejE0?=
 =?utf-8?B?aHVJUnJENUpzU0NDTmR4U0twQVlBQkNsVUFENmJhT1pLOUNFWkF2Q2hXWG1I?=
 =?utf-8?B?SngzbGZVUVVDYkFka1o0eTRhOWxZbUtTb1ZIRFUyWVRZYndWWFJuc1hPVk1S?=
 =?utf-8?B?UnhicTJCNWdUMFZ6ZWZnNy84UGRZYWdYWUZVTXB2N2NXaGRtQVZhWXlqRVQv?=
 =?utf-8?B?UGZSeldUNDNTd2RqWXlJbEN3VGZqUncweXBjMzV1ZkVjeGZhU0dDM1NtYm9F?=
 =?utf-8?B?WnVNTFgwaUpKRlg1WmJGL1ljV3VGY1FRZ1BvNEc3R1dDcHlYMUtJVmFmQUd5?=
 =?utf-8?B?dFBleEtlVFppTVl0LzRyeTdlUUJtRVpMQ3NSQ1JuTkFVM25WRFJDZXFGeWk5?=
 =?utf-8?B?U216M0JOTGM2SjdFcitlcm5sR1NuVmN5K1NBbVZ2TjdwSzdhVlcvbWc5UTl2?=
 =?utf-8?Q?8Xe03bqYvlQ2Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHlTdkduSnVJRmJuckk0WXh1Y2hDcXloODBiTHVqWjJjQjlrSmR3TitqdG5T?=
 =?utf-8?B?Q1ZHVzN0OTNwZUszYnFiU3Z2bFA4Ty9Vd1dkNExMaU4rZ2NJTDVCNENkYTlr?=
 =?utf-8?B?c3lsVk9oUERQUGVFM29XeEZQeCtWeVdtbE1VMmowR1Y4ZFZCdk92QjlZTHpW?=
 =?utf-8?B?clVZTldGbjJ5d0FFc0RaNlF5MDNIMTZ5OXpISE5QUE5JWEZnV2pzTHdXZEZQ?=
 =?utf-8?B?SXl2azQxRERVUXlxM05icFMrMTRIY014aGs2Vjd5S2gzUW9HNVpPdXNLZkhr?=
 =?utf-8?B?WThzcktKL05OdWtZODh6Q1QrS2xoUGtkY2p6SExpYXlkbjJ4MGVwWGhIK3NM?=
 =?utf-8?B?d3RHZHJLc1lrQ1h6NjZLYjJkdXBIMU4zbkYwWld2WjVxMFdRUm1pVEhYZmsw?=
 =?utf-8?B?Yk5LcG5pQjdWamhUZm50cFNTdy8vVzJSbXBUTUhtUXZtZlhuNXpsTXdTVUw3?=
 =?utf-8?B?N2JvU0IwN3ZxUDB4U0hrbTRtTElCL0xXd2YrUEY2NjRJVXdDbUk3QjNrYkdk?=
 =?utf-8?B?MnpXNDRIL2I0S2YzajE3OHU2UVdqaDgxaHpZTzBtM3VBRWxiY2RPdC9BbENM?=
 =?utf-8?B?YmVQS1h0dVA3UGRYdFNLQXdiZmovSzJCMTlLQmZJU1M5U1U4S3dJTit5T0lQ?=
 =?utf-8?B?NkxYeS9oYXBYTENidzZ2VE1KRjVhS1FWaHJSMDd3UzV0WEJ4VzdqWGJodjhk?=
 =?utf-8?B?alZWeTVwOTdJSkdYN1dWRUlGZFZwZm5BQ24vNTcvSTZFQkRsRlY5c1ZRVytZ?=
 =?utf-8?B?bnZjRVU2SzZNakcxbGtmQkszMlRBOEU0a0loL3ZWWjhydjdYTDQzTUdaT1V0?=
 =?utf-8?B?Ylplb2MvUGczVFluNUhCSlNHdjlvdzN1RXRPUUdPN3g3a3gxOE0vTDcxa0Q5?=
 =?utf-8?B?TlBoOW1SV09Kc2EwV2ZhUkNsd1VkNlpZVjg1dDJDejBvdU1KUldvMHYveEd2?=
 =?utf-8?B?TkF3TW02VFkyUHdNMEJnNEJ5ZFo0QUxCZ2p5NytGbW9TODJNcHRFbHB0d2o4?=
 =?utf-8?B?VE9jdFFGbGNNSnJyb0JHSkozT1pmTnJDNThlMkFEZUxMVURmS0VMNFk1ODVG?=
 =?utf-8?B?cGRBK1U2aC9DOG9HZG54T09lcWMydTRySDRQR0xDRWt5SVU0ZHZtaW1uMkhr?=
 =?utf-8?B?NE5Qd3huRXJNOGVtSmpNN2FKNFdPdTh5RUNRWXM1TnVIYUY3OGl4WXFMZ2M1?=
 =?utf-8?B?Skx5R0N6bGJ4R0QzMzA1bmxqS0VwUXhwbE02Uk11WXo5aDJyc1E4UXNXYXBC?=
 =?utf-8?B?dWJKangwSXFMWnZHNkIvSGVXSDdvQjk3aGlyeXpXQStaemFScDkyODhSVmNi?=
 =?utf-8?B?UWdaTnc4MFZKbk55OHFxWDd4U0RhRlFqVVBIdE8zU25FdFRXNGlzOWdJLzM5?=
 =?utf-8?B?a3o1OHYwVmpXbnRncHVoY3l2cnNGbFMvcTAyV3FDN2c4alcyTTZ6bHM5d3Iz?=
 =?utf-8?B?dnVwSDZIc0k4K2hyM3BLNWtVQ2cvZHFqVG5QQ0dWWmpwNE4yOHNHM21lQjQ2?=
 =?utf-8?B?U3J3VlNQU2hSRm80ZHIwYTY3MkQxakwyN2E2RW1OL2hOQ2dyaFB6MERmb0lx?=
 =?utf-8?B?TnExRUN5K0NYSFQ3US93cFF4RFlHWHRwZk1pa080bDdLcncvNDd1VnJmMHFJ?=
 =?utf-8?B?TWhaWTJHNjVOSGZkclh4S3ZwbjlFbThIekZ2SFdpa2sweTNjb2lST0lKU1ZM?=
 =?utf-8?B?bHNNeWM2VDFpbUVLT3UxTFk1TGVDWENFUnZnemtZQkg5TGhOdFZialV6U0tz?=
 =?utf-8?B?V0E0OHR4cXNjRmZ6ck9FbnloYkF4QjdTL3E2eUxndVcwaFFNajVIYWwxUXhI?=
 =?utf-8?B?L0hVdFVsN2NiekhrenR3cE4rdFpVazBvdzh4R1d1cXBaTkRsdFp4dTdMNW1p?=
 =?utf-8?B?MDNtTHpvN3FwYkN6SThTQ0phSmJTUjNJZm95Y3ZRN1k5TXJTTmFjRGoxUjVz?=
 =?utf-8?B?cGM3cHl0aTY5bGYyWDlNcDZQaDFFYzJCeVBXZFE1Y2tpS0crMkJ4VjBkaldV?=
 =?utf-8?B?dGh6dk9jSjUxZmNpZkthQzJWVnZzSHpiTnMwclJuUEJyK0dKcEFINjRhY2pZ?=
 =?utf-8?B?UmZkSEVUeWFINWdvZ1BSSjJZS0tUN3dqWUFJT1Nkek1NQXZvKzRRQ2pPUVEz?=
 =?utf-8?Q?MK/MDEjYDz6egjJkSibqhZwjC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XRBedSrzt2byo+dKWRBQZrVHBXuroN0CNyfNiLWHBp2ka6XjrgSuLARxerImkcwD+tHGdWmHT1/lz46je7ImG419T73hKY2tO5U3Dx0xJFdzqHARm45OXyRQRJj4MPbcs8FEFml0xvUKB86AFyZKbq/pM7uwy/20EK6kBBbFJ9MIspO8GHX6FM4djk4QzWeTSyb5SgzskbrY8KMziVqPLTn9DPlOuTLVIFxhNRj7xobvRBTCZcpEpQFlSPsq/4n+KJ7cvrZPE1g2IZJkoMe4H4hV6rWClYqqZJ+hzLh3BFmLgjJx6RFW1AwhHzfNYRyd6CQxEVpFkuV5SlvD3oMl0QxrOWbLZlvnCdVfzFH1wqdTwkHtb6NiUkf6QhvmMZ6QvG8SN0ki9OkQvosyGB7FoXJldUASl0PnbKdDAT5t+ueUh1VUf/YJUVrQYlDmpD867Nf115lejNe4kqwpeCjsUt4AbHdYHPbtZQ/uQ2y2sC1qOsh64mvNsY0/OH76Vo4deRyJg0HAumERzIA92ZF0vR3Edv3lT6F3SVv/J5uk8M/6IwftrZ/jnK32m5vxG4i7g4OYMpD7qBfN8uwN5Y7Hu8zxXharVCv438QCDSZgoVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3185a72-0316-4e4d-473e-08dd5f424508
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 19:40:38.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W03vbYaD4aUz4sVEdEuBgDH6uEliu3jke3t9t+xa8rHsM3puN5eGQJbO87ybJog+fLgcN+NvUIEBVfnP7Qc/eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503090160
X-Proofpoint-ORIG-GUID: B_PaWjOGAL8xC_0HMLlPWBGaRtEJ2AoM
X-Proofpoint-GUID: B_PaWjOGAL8xC_0HMLlPWBGaRtEJ2AoM

--------------ZbppucAv7peIkSZKm3b0FAgg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nan,

Can you try the attached patch with 6.14-rc4?

This patch adds a spinlock to protect the rl_free_mrs and rl_registered list.
I have seen list corruption in our RDMA testing but the problem is hard to
reproduce so I have not submitted this patch to upstream.

Thanks,
-Dai

On 3/5/25 6:40 PM, Li Nan wrote:
>
>
> 在 2025/3/5 22:02, Chuck Lever 写道:
>> On 3/4/25 9:43 PM, Li Nan wrote:
>>> We found a following problem in kernel 5.10, and the same problem 
>>> should
>>> exist in mainline:
>>>
>>> During NFS mount using 'soft' option over RoCE network, we observed 
>>> kernel
>>> crash with below trace when network issues occur 
>>> (congestion/disconnect):
>>>    nfs: server 10.10.253.211 not responding, timed out
>>>    BUG: kernel NULL pointer dereference, address: 00000000000000a0
>>>    RIP: 0010:frwr_unmap_sync+0x77/0x200 [rpcrdma]
>>>    Call Trace:
>>>     ? __die_body.cold+0x8/0xd
>>>     ? no_context+0x155/0x230
>>>     ? __bad_area_nosemaphore+0x52/0x1a0
>>>     ? exc_page_fault+0x2dc/0x550
>>>     ? asm_exc_page_fault+0x1e/0x30
>>>     ? frwr_unmap_sync+0x77/0x200 [rpcrdma]
>>>     xprt_release+0x9e/0x1a0 [sunrpc]
>>>     rpc_release_resources_task+0xe/0x50 [sunrpc]
>>>     rpc_release_task+0x19/0xa0 [sunrpc]
>>>     rpc_async_schedule+0x29/0x40 [sunrpc]
>>>     process_one_work+0x1b2/0x350
>>>     worker_thread+0x49/0x310
>>>     ? rescuer_thread+0x380/0x380
>>>     kthread+0xfb/0x140
>>>
>>> Problem analysis:
>>> The crash happens in frwr_unmap_sync() when accessing 
>>> req->rl_registered
>>> list, caused by either NULL pointer or accessing freed MR resources.
>>> There's a race condition between:
>>> T1
>>> __ib_process_cq
>>>   wc->wr_cqe->done (frwr_wc_localinv)
>>>    rpcrdma_flush_disconnect
>>>     rpcrdma_force_disconnect
>>>      xprt_force_disconnect
>>>       xprt_autoclose
>>>        xprt_rdma_close
>>>         rpcrdma_xprt_disconnect
>>>          rpcrdma_reqs_reset
>>>           frwr_reset
>>>            rpcrdma_mr_pop(&req->rl_registered)
>>> T2
>>> rpc_async_schedule
>>>   rpc_release_task
>>>    rpc_release_resources_task
>>>     xprt_release
>>>      xprt_rdma_free
>>>       frwr_unmap_sync
>>>        rpcrdma_mr_pop(&req->rl_registered)
>>>                     This problem also exists in function 
>>> rpcrdma_mrs_destroy().
>>>
>>
>> Dai, is this the same as the system test problem you've been looking at?
>>
>
> Thank you for looking into it. Is there a patch that needs to be 
> tested? We
> are happy to help with the testing.
>
--------------ZbppucAv7peIkSZKm3b0FAgg
Content-Type: text/plain; charset=UTF-8;
 name="0001-xprtrdma-add-spinlock-in-rpcrdma_req-to-protect-rl_f.patch"
Content-Disposition: attachment;
 filename*0="0001-xprtrdma-add-spinlock-in-rpcrdma_req-to-protect-rl_f.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmZjhkNjY0Yzk2MDYxMzVkNTJmZDJkYzQ3NzhkZDc1YTU2YTNiMzhlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+CkRhdGU6IFRo
dSwgNCBBcHIgMjAyNCAxMToxMToyMSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIHhwcnRyZG1hOiBh
ZGQgc3BpbmxvY2sgaW4gcnBjcmRtYV9yZXEgdG8gcHJvdGVjdCBybF9mcmVlX21ycwogYW5kIHJs
X3JlZ2lzdGVyZWQgbGlzdAoKSW4gc29tZSByYXJlIGNvbmRpdGlvbnMsIHRoZSB0b3AgaGFsZiBh
bmQgdGhlIGJvdHRvbSBoYWxmIG9mIHRoZQp4cHJ0cmRtYSBtb2R1bGUgYWNjZXNzIHRoZSBzYW1l
IHJsX2ZyZWVfbXJzIGFuZCBybF9yZWdpc3RlcmVkCmxpc3Qgb2YgdGhlIHJlcXVlc3QuCgpPbmUg
b2YgdGhlIGNhc2VzIGlzIHdoZW4gcnBjcmRtYV9tYXJzaGFsX3JlcSBjYWxscyBmcndyX3Jlc2V0
IHdoaWxlCnRoZSBycGNyZG1hX3JlcGx5X2hhbmRsZXIgaXMgZXhlY3V0aW5nIG9uIHRoZSBzYW1l
IHJwY3JkbWFfcmVxLiBXaGVuCnRoaXMgaGFwcGVucyB0aGUgcmxfZnJlZV9tcnMgYW5kIHJsX3Jl
Z2lzdGVyZWQgYXJlIGNvcnJ1cHRlZC4KClRoaXMgcGF0Y2ggYWRkcyBhIHNwaW5sb2NrIGluIHJw
Y3JkbWFfcmVxIHRvIHByb3RlY3QgcmxfZnJlZV9tcnMgYW5kCnJsX3JlZ2lzdGVyZWQgbGlzdC4g
U2luY2UgdGhlIGNoYW5jZSB0aGF0IHRoZSB0b3AgYW5kIGJvdHRvbSBoYWxmIG9mCnRoZSB4cHJ0
cmRtYSBtb2R1bGUgZXhlY3V0aW5nIGF0IHRoZSBzYW1lIHRpbWUgb24gdGhlIHNhbWUgcmVxdWVz
dCBpcwpyYXJlLCBvbmx5IGluIGVycm9yIGNvbmRpdGlvbnMsIGl0J3MgZXhwZWN0ZWQgdGhhdCB0
aGUgY29udGVudGlvbiBvZgp0aGlzIGxvY2sgaXMgdmVyeSBsb3cuCgpTaWduZWQtb2ZmLWJ5OiBE
YWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+Ci0tLQogbmV0L3N1bnJwYy94cHJ0cmRtYS9mcndy
X29wcy5jICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLQogbmV0L3N1bnJwYy94cHJ0
cmRtYS9ycGNfcmRtYS5jICB8ICA5ICsrKysrKy0tLQogbmV0L3N1bnJwYy94cHJ0cmRtYS92ZXJi
cy5jICAgICB8ICA2ICsrKysrKwogbmV0L3N1bnJwYy94cHJ0cmRtYS94cHJ0X3JkbWEuaCB8ICA0
ICsrKy0KIDQgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3hwcnRyZG1hL2Zyd3Jfb3BzLmMgYi9uZXQvc3VucnBj
L3hwcnRyZG1hL2Zyd3Jfb3BzLmMKaW5kZXggZmZiZjk5ODk0OTcwLi5lNGUwZjU1MzJlOGMgMTAw
NjQ0Ci0tLSBhL25ldC9zdW5ycGMveHBydHJkbWEvZnJ3cl9vcHMuYworKysgYi9uZXQvc3VucnBj
L3hwcnRyZG1hL2Zyd3Jfb3BzLmMKQEAgLTg3LDkgKzg3LDExIEBAIHN0YXRpYyB2b2lkIGZyd3Jf
bXJfcHV0KHN0cnVjdCBycGNyZG1hX21yICptcikKIAlmcndyX21yX3VubWFwKG1yLT5tcl94cHJ0
LCBtcik7CiAKIAkvKiBUaGUgTVIgaXMgcmV0dXJuZWQgdG8gdGhlIHJlcSdzIE1SIGZyZWUgbGlz
dCBpbnN0ZWFkCi0JICogb2YgdG8gdGhlIHhwcnQncyBNUiBmcmVlIGxpc3QuIE5vIHNwaW5sb2Nr
IGlzIG5lZWRlZC4KKwkgKiBvZiB0byB0aGUgeHBydCdzIE1SIGZyZWUgbGlzdC4KIAkgKi8KKwlz
cGluX2xvY2soJm1yLT5tcl9yZXEtPnJsX21yX2xpc3RfbG9jayk7CiAJcnBjcmRtYV9tcl9wdXNo
KG1yLCAmbXItPm1yX3JlcS0+cmxfZnJlZV9tcnMpOworCXNwaW5fdW5sb2NrKCZtci0+bXJfcmVx
LT5ybF9tcl9saXN0X2xvY2spOwogfQogCiAvKiBmcndyX3Jlc2V0IC0gUGxhY2UgTVJzIGJhY2sg
b24gdGhlIGZyZWUgbGlzdApAQCAtMTA2LDggKzEwOCwxMyBAQCB2b2lkIGZyd3JfcmVzZXQoc3Ry
dWN0IHJwY3JkbWFfcmVxICpyZXEpCiB7CiAJc3RydWN0IHJwY3JkbWFfbXIgKm1yOwogCi0Jd2hp
bGUgKChtciA9IHJwY3JkbWFfbXJfcG9wKCZyZXEtPnJsX3JlZ2lzdGVyZWQpKSkKKwlzcGluX2xv
Y2soJnJlcS0+cmxfbXJfbGlzdF9sb2NrKTsKKwl3aGlsZSAoKG1yID0gcnBjcmRtYV9tcl9wb3Ao
JnJlcS0+cmxfcmVnaXN0ZXJlZCkpKSB7CisJCXNwaW5fdW5sb2NrKCZyZXEtPnJsX21yX2xpc3Rf
bG9jayk7CiAJCWZyd3JfbXJfcHV0KG1yKTsKKwkJc3Bpbl9sb2NrKCZyZXEtPnJsX21yX2xpc3Rf
bG9jayk7CisJfQorCXNwaW5fdW5sb2NrKCZyZXEtPnJsX21yX2xpc3RfbG9jayk7CiB9CiAKIC8q
KgpAQCAtMzkwLDYgKzM5Nyw3IEBAIGludCBmcndyX3NlbmQoc3RydWN0IHJwY3JkbWFfeHBydCAq
cl94cHJ0LCBzdHJ1Y3QgcnBjcmRtYV9yZXEgKnJlcSkKIAogCW51bV93cnMgPSAxOwogCXBvc3Rf
d3IgPSBzZW5kX3dyOworCXNwaW5fbG9jaygmcmVxLT5ybF9tcl9saXN0X2xvY2spOwogCWxpc3Rf
Zm9yX2VhY2hfZW50cnkobXIsICZyZXEtPnJsX3JlZ2lzdGVyZWQsIG1yX2xpc3QpIHsKIAkJdHJh
Y2VfeHBydHJkbWFfbXJfZmFzdHJlZyhtcik7CiAKQEAgLTQwMiw2ICs0MTAsNyBAQCBpbnQgZnJ3
cl9zZW5kKHN0cnVjdCBycGNyZG1hX3hwcnQgKnJfeHBydCwgc3RydWN0IHJwY3JkbWFfcmVxICpy
ZXEpCiAJCXBvc3Rfd3IgPSAmbXItPm1yX3JlZ3dyLndyOwogCQkrK251bV93cnM7CiAJfQorCXNw
aW5fdW5sb2NrKCZyZXEtPnJsX21yX2xpc3RfbG9jayk7CiAKIAlpZiAoKGtyZWZfcmVhZCgmcmVx
LT5ybF9rcmVmKSA+IDEpIHx8IG51bV93cnMgPiBlcC0+cmVfc2VuZF9jb3VudCkgewogCQlzZW5k
X3dyLT5zZW5kX2ZsYWdzIHw9IElCX1NFTkRfU0lHTkFMRUQ7CkBAIC00MjUsMTcgKzQzNCwyMyBA
QCBpbnQgZnJ3cl9zZW5kKHN0cnVjdCBycGNyZG1hX3hwcnQgKnJfeHBydCwgc3RydWN0IHJwY3Jk
bWFfcmVxICpyZXEpCiAgKiBAbXJzOiBsaXN0IG9mIE1ScyB0byBjaGVjawogICoKICAqLwotdm9p
ZCBmcndyX3JlbWludihzdHJ1Y3QgcnBjcmRtYV9yZXAgKnJlcCwgc3RydWN0IGxpc3RfaGVhZCAq
bXJzKQordm9pZCBmcndyX3JlbWludihzdHJ1Y3QgcnBjcmRtYV9yZXAgKnJlcCwgc3RydWN0IHJw
Y3JkbWFfcmVxICpyZXEpCiB7CiAJc3RydWN0IHJwY3JkbWFfbXIgKm1yOworCXN0cnVjdCBsaXN0
X2hlYWQgKm1ycyA9ICZyZXEtPnJsX3JlZ2lzdGVyZWQ7CiAKLQlsaXN0X2Zvcl9lYWNoX2VudHJ5
KG1yLCBtcnMsIG1yX2xpc3QpCisJc3Bpbl9sb2NrKCZyZXEtPnJsX21yX2xpc3RfbG9jayk7CisJ
bGlzdF9mb3JfZWFjaF9lbnRyeShtciwgbXJzLCBtcl9saXN0KSB7CiAJCWlmIChtci0+bXJfaGFu
ZGxlID09IHJlcC0+cnJfaW52X3JrZXkpIHsKIAkJCWxpc3RfZGVsX2luaXQoJm1yLT5tcl9saXN0
KTsKIAkJCXRyYWNlX3hwcnRyZG1hX21yX3JlbWludihtcik7CisJCQlzcGluX3VubG9jaygmcmVx
LT5ybF9tcl9saXN0X2xvY2spOwogCQkJZnJ3cl9tcl9wdXQobXIpOworCQkJc3Bpbl9sb2NrKCZy
ZXEtPnJsX21yX2xpc3RfbG9jayk7CiAJCQlicmVhazsJLyogb25seSBvbmUgaW52YWxpZGF0ZWQg
TVIgcGVyIFJQQyAqLwogCQl9CisJfQorCXNwaW5fdW5sb2NrKCZyZXEtPnJsX21yX2xpc3RfbG9j
ayk7CiB9CiAKIHN0YXRpYyB2b2lkIGZyd3JfbXJfZG9uZShzdHJ1Y3QgaWJfd2MgKndjLCBzdHJ1
Y3QgcnBjcmRtYV9tciAqbXIpCkBAIC01MDcsNiArNTIyLDcgQEAgdm9pZCBmcndyX3VubWFwX3N5
bmMoc3RydWN0IHJwY3JkbWFfeHBydCAqcl94cHJ0LCBzdHJ1Y3QgcnBjcmRtYV9yZXEgKnJlcSkK
IAkgKiBhIHNpbmdsZSBpYl9wb3N0X3NlbmQoKSBjYWxsLgogCSAqLwogCXByZXYgPSAmZmlyc3Q7
CisJc3Bpbl9sb2NrKCZyZXEtPnJsX21yX2xpc3RfbG9jayk7CiAJbXIgPSBycGNyZG1hX21yX3Bv
cCgmcmVxLT5ybF9yZWdpc3RlcmVkKTsKIAlkbyB7CiAJCXRyYWNlX3hwcnRyZG1hX21yX2xvY2Fs
aW52KG1yKTsKQEAgLTUyNiw2ICs1NDIsNyBAQCB2b2lkIGZyd3JfdW5tYXBfc3luYyhzdHJ1Y3Qg
cnBjcmRtYV94cHJ0ICpyX3hwcnQsIHN0cnVjdCBycGNyZG1hX3JlcSAqcmVxKQogCQkqcHJldiA9
IGxhc3Q7CiAJCXByZXYgPSAmbGFzdC0+bmV4dDsKIAl9IHdoaWxlICgobXIgPSBycGNyZG1hX21y
X3BvcCgmcmVxLT5ybF9yZWdpc3RlcmVkKSkpOworCXNwaW5fdW5sb2NrKCZyZXEtPnJsX21yX2xp
c3RfbG9jayk7CiAKIAltciA9IGNvbnRhaW5lcl9vZihsYXN0LCBzdHJ1Y3QgcnBjcmRtYV9tciwg
bXJfaW52d3IpOwogCkBAIC02MTAsNiArNjI3LDcgQEAgdm9pZCBmcndyX3VubWFwX2FzeW5jKHN0
cnVjdCBycGNyZG1hX3hwcnQgKnJfeHBydCwgc3RydWN0IHJwY3JkbWFfcmVxICpyZXEpCiAJICog
YSBzaW5nbGUgaWJfcG9zdF9zZW5kKCkgY2FsbC4KIAkgKi8KIAlwcmV2ID0gJmZpcnN0OworCXNw
aW5fbG9jaygmcmVxLT5ybF9tcl9saXN0X2xvY2spOwogCW1yID0gcnBjcmRtYV9tcl9wb3AoJnJl
cS0+cmxfcmVnaXN0ZXJlZCk7CiAJZG8gewogCQl0cmFjZV94cHJ0cmRtYV9tcl9sb2NhbGludiht
cik7CkBAIC02MjksNiArNjQ3LDcgQEAgdm9pZCBmcndyX3VubWFwX2FzeW5jKHN0cnVjdCBycGNy
ZG1hX3hwcnQgKnJfeHBydCwgc3RydWN0IHJwY3JkbWFfcmVxICpyZXEpCiAJCSpwcmV2ID0gbGFz
dDsKIAkJcHJldiA9ICZsYXN0LT5uZXh0OwogCX0gd2hpbGUgKChtciA9IHJwY3JkbWFfbXJfcG9w
KCZyZXEtPnJsX3JlZ2lzdGVyZWQpKSk7CisJc3Bpbl91bmxvY2soJnJlcS0+cmxfbXJfbGlzdF9s
b2NrKTsKIAogCS8qIFN0cm9uZyBzZW5kIHF1ZXVlIG9yZGVyaW5nIGd1YXJhbnRlZXMgdGhhdCB3
aGVuIHRoZQogCSAqIGxhc3QgV1IgaW4gdGhlIGNoYWluIGNvbXBsZXRlcywgYWxsIFdScyBpbiB0
aGUgY2hhaW4KZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydHJkbWEvcnBjX3JkbWEuYyBiL25l
dC9zdW5ycGMveHBydHJkbWEvcnBjX3JkbWEuYwppbmRleCAxOTBhNGRlMjM5YzguLjI5YjEwZjZl
YjhiMCAxMDA2NDQKLS0tIGEvbmV0L3N1bnJwYy94cHJ0cmRtYS9ycGNfcmRtYS5jCisrKyBiL25l
dC9zdW5ycGMveHBydHJkbWEvcnBjX3JkbWEuYwpAQCAtMjk4LDE1ICsyOTgsMTggQEAgc3RhdGlj
IHN0cnVjdCBycGNyZG1hX21yX3NlZyAqcnBjcmRtYV9tcl9wcmVwYXJlKHN0cnVjdCBycGNyZG1h
X3hwcnQgKnJfeHBydCwKIAkJCQkJCSBpbnQgbnNlZ3MsIGJvb2wgd3JpdGluZywKIAkJCQkJCSBz
dHJ1Y3QgcnBjcmRtYV9tciAqKm1yKQogeworCXNwaW5fbG9jaygmcmVxLT5ybF9tcl9saXN0X2xv
Y2spOwogCSptciA9IHJwY3JkbWFfbXJfcG9wKCZyZXEtPnJsX2ZyZWVfbXJzKTsKIAlpZiAoISpt
cikgewogCQkqbXIgPSBycGNyZG1hX21yX2dldChyX3hwcnQpOwotCQlpZiAoISptcikKKwkJaWYg
KCEqbXIpIHsKKwkJCXNwaW5fdW5sb2NrKCZyZXEtPnJsX21yX2xpc3RfbG9jayk7CiAJCQlnb3Rv
IG91dF9nZXRtcl9lcnI7CisJCX0KIAkJKCptciktPm1yX3JlcSA9IHJlcTsKIAl9Ci0KIAlycGNy
ZG1hX21yX3B1c2goKm1yLCAmcmVxLT5ybF9yZWdpc3RlcmVkKTsKKwlzcGluX3VubG9jaygmcmVx
LT5ybF9tcl9saXN0X2xvY2spOwogCXJldHVybiBmcndyX21hcChyX3hwcnQsIHNlZywgbnNlZ3Ms
IHdyaXRpbmcsIHJlcS0+cmxfc2xvdC5ycV94aWQsICptcik7CiAKIG91dF9nZXRtcl9lcnI6CkBA
IC0xNDg1LDcgKzE0ODgsNyBAQCB2b2lkIHJwY3JkbWFfcmVwbHlfaGFuZGxlcihzdHJ1Y3QgcnBj
cmRtYV9yZXAgKnJlcCkKIAl0cmFjZV94cHJ0cmRtYV9yZXBseShycXN0LT5ycV90YXNrLCByZXAs
IGNyZWRpdHMpOwogCiAJaWYgKHJlcC0+cnJfd2NfZmxhZ3MgJiBJQl9XQ19XSVRIX0lOVkFMSURB
VEUpCi0JCWZyd3JfcmVtaW52KHJlcCwgJnJlcS0+cmxfcmVnaXN0ZXJlZCk7CisJCWZyd3JfcmVt
aW52KHJlcCwgcmVxKTsKIAlpZiAoIWxpc3RfZW1wdHkoJnJlcS0+cmxfcmVnaXN0ZXJlZCkpCiAJ
CWZyd3JfdW5tYXBfYXN5bmMocl94cHJ0LCByZXEpOwogCQkvKiBMb2NhbEludiBjb21wbGV0aW9u
IHdpbGwgY29tcGxldGUgdGhlIFJQQyAqLwpkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0cmRt
YS92ZXJicy5jIGIvbmV0L3N1bnJwYy94cHJ0cmRtYS92ZXJicy5jCmluZGV4IDRmOGQ3ZWZhNDY5
Zi4uYTg2NjNmMTA0NzI5IDEwMDY0NAotLS0gYS9uZXQvc3VucnBjL3hwcnRyZG1hL3ZlcmJzLmMK
KysrIGIvbmV0L3N1bnJwYy94cHJ0cmRtYS92ZXJicy5jCkBAIC04MjUsNiArODI1LDggQEAgc3Ry
dWN0IHJwY3JkbWFfcmVxICpycGNyZG1hX3JlcV9jcmVhdGUoc3RydWN0IHJwY3JkbWFfeHBydCAq
cl94cHJ0LAogCiAJSU5JVF9MSVNUX0hFQUQoJnJlcS0+cmxfZnJlZV9tcnMpOwogCUlOSVRfTElT
VF9IRUFEKCZyZXEtPnJsX3JlZ2lzdGVyZWQpOworCisJc3Bpbl9sb2NrX2luaXQoJnJlcS0+cmxf
bXJfbGlzdF9sb2NrKTsKIAlzcGluX2xvY2soJmJ1ZmZlci0+cmJfbG9jayk7CiAJbGlzdF9hZGQo
JnJlcS0+cmxfYWxsLCAmYnVmZmVyLT5yYl9hbGxyZXFzKTsKIAlzcGluX3VubG9jaygmYnVmZmVy
LT5yYl9sb2NrKTsKQEAgLTEwODQsMTUgKzEwODYsMTkgQEAgdm9pZCBycGNyZG1hX3JlcV9kZXN0
cm95KHN0cnVjdCBycGNyZG1hX3JlcSAqcmVxKQogCiAJbGlzdF9kZWwoJnJlcS0+cmxfYWxsKTsK
IAorCXNwaW5fbG9jaygmcmVxLT5ybF9tcl9saXN0X2xvY2spOwogCXdoaWxlICgobXIgPSBycGNy
ZG1hX21yX3BvcCgmcmVxLT5ybF9mcmVlX21ycykpKSB7CiAJCXN0cnVjdCBycGNyZG1hX2J1ZmZl
ciAqYnVmID0gJm1yLT5tcl94cHJ0LT5yeF9idWY7CiAKKwkJc3Bpbl91bmxvY2soJnJlcS0+cmxf
bXJfbGlzdF9sb2NrKTsKIAkJc3Bpbl9sb2NrKCZidWYtPnJiX2xvY2spOwogCQlsaXN0X2RlbCgm
bXItPm1yX2FsbCk7CiAJCXNwaW5fdW5sb2NrKCZidWYtPnJiX2xvY2spOwogCiAJCWZyd3JfbXJf
cmVsZWFzZShtcik7CisJCXNwaW5fbG9jaygmcmVxLT5ybF9tcl9saXN0X2xvY2spOwogCX0KKwlz
cGluX3VubG9jaygmcmVxLT5ybF9tcl9saXN0X2xvY2spOwogCiAJcnBjcmRtYV9yZWdidWZfZnJl
ZShyZXEtPnJsX3JlY3ZidWYpOwogCXJwY3JkbWFfcmVnYnVmX2ZyZWUocmVxLT5ybF9zZW5kYnVm
KTsKZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydHJkbWEveHBydF9yZG1hLmggYi9uZXQvc3Vu
cnBjL3hwcnRyZG1hL3hwcnRfcmRtYS5oCmluZGV4IGRhNDA5NDUwZGZjMC4uMTJkYjAyNTBjOWNl
IDEwMDY0NAotLS0gYS9uZXQvc3VucnBjL3hwcnRyZG1hL3hwcnRfcmRtYS5oCisrKyBiL25ldC9z
dW5ycGMveHBydHJkbWEveHBydF9yZG1hLmgKQEAgLTMyNyw2ICszMjcsOCBAQCBzdHJ1Y3QgcnBj
cmRtYV9yZXEgewogCXN0cnVjdCBsaXN0X2hlYWQJcmxfYWxsOwogCXN0cnVjdCBrcmVmCQlybF9r
cmVmOwogCisJLyogcmxfbXJfbGlzdF9sb2NrcyB1c2VkIGZvciBybF9mcmVlX21ycyBhbmQgcmxf
cmVnaXN0ZXJlZCBsaXN0ICovCisJc3BpbmxvY2tfdAkJcmxfbXJfbGlzdF9sb2NrOwogCXN0cnVj
dCBsaXN0X2hlYWQJcmxfZnJlZV9tcnM7CiAJc3RydWN0IGxpc3RfaGVhZAlybF9yZWdpc3RlcmVk
OwogCXN0cnVjdCBycGNyZG1hX21yX3NlZwlybF9zZWdtZW50c1tSUENSRE1BX01BWF9TRUdTXTsK
QEAgLTUzOSw3ICs1NDEsNyBAQCBzdHJ1Y3QgcnBjcmRtYV9tcl9zZWcgKmZyd3JfbWFwKHN0cnVj
dCBycGNyZG1hX3hwcnQgKnJfeHBydCwKIAkJCQlpbnQgbnNlZ3MsIGJvb2wgd3JpdGluZywgX19i
ZTMyIHhpZCwKIAkJCQlzdHJ1Y3QgcnBjcmRtYV9tciAqbXIpOwogaW50IGZyd3Jfc2VuZChzdHJ1
Y3QgcnBjcmRtYV94cHJ0ICpyX3hwcnQsIHN0cnVjdCBycGNyZG1hX3JlcSAqcmVxKTsKLXZvaWQg
ZnJ3cl9yZW1pbnYoc3RydWN0IHJwY3JkbWFfcmVwICpyZXAsIHN0cnVjdCBsaXN0X2hlYWQgKm1y
cyk7Cit2b2lkIGZyd3JfcmVtaW52KHN0cnVjdCBycGNyZG1hX3JlcCAqcmVwLCBzdHJ1Y3QgcnBj
cmRtYV9yZXEgKnJlcSk7CiB2b2lkIGZyd3JfdW5tYXBfc3luYyhzdHJ1Y3QgcnBjcmRtYV94cHJ0
ICpyX3hwcnQsIHN0cnVjdCBycGNyZG1hX3JlcSAqcmVxKTsKIHZvaWQgZnJ3cl91bm1hcF9hc3lu
YyhzdHJ1Y3QgcnBjcmRtYV94cHJ0ICpyX3hwcnQsIHN0cnVjdCBycGNyZG1hX3JlcSAqcmVxKTsK
IGludCBmcndyX3dwX2NyZWF0ZShzdHJ1Y3QgcnBjcmRtYV94cHJ0ICpyX3hwcnQpOwotLSAKMi40
My4wCgo=

--------------ZbppucAv7peIkSZKm3b0FAgg--

