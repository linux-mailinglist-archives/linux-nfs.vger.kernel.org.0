Return-Path: <linux-nfs+bounces-786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D381D57C
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Dec 2023 19:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8DD282FAE
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Dec 2023 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6312B91;
	Sat, 23 Dec 2023 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EcBPvkqB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SpWXS4VD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A98125A9
	for <linux-nfs@vger.kernel.org>; Sat, 23 Dec 2023 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BNHvMMo004740;
	Sat, 23 Dec 2023 18:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=DwFdREpAQxbkgCEOnwDANfYnBBMQWetRUfuRmm+0+lE=;
 b=EcBPvkqBz7vaBAmpzf5E3hjdLj9+RXlXRQuRvhl3DX9yttyfOVdk9mKRuyY6iolUX5o3
 C9gGokPVw+dPIKTCeoYctYx0Sptl0KX/Vcl855iHm86RYzIevMwdG0qNxPg02RxtOZJY
 R5BkGWb1gqA1x/uLct8LSE0/soqV1si5Gn6d+GKYtzkzALwHZfqlwXOjieCM9l++FPcM
 h4p7O9aSgfHN73AwuH5tyRdyur7UZEAdgr9m/+BsKEG+NL8YziUsdE7Smuf4N++T7uP3
 GDCDvxO/VIJ0FsRO0K9W1H9OvuaKY/qb6hlBMgH/Lfm8L77WNjOlUZPpZ9xX60gWEbPS jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5qkd0sh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Dec 2023 18:07:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BNHpwOo037354;
	Sat, 23 Dec 2023 18:07:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0acwaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Dec 2023 18:07:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfOqeJhgYlJn6tIaO36ztqXLS/j6Bnh5r327vwRwJU+0oY1vHG8eOE5VxYjpXBbYYM4KMjIMK9LuQQOXFNdLQBX4wQbOAnKKfYwfeuhJ4dFvAgKW/TMJ9T87szf2333dDJtNMspTnenU6oOE7XlyzHGWwie7ZsNM+RakSGSWCpvtYPxEKf6G9bm+cfWoXRd9XPJiK/kFqlD8765ETOrW0RUA17bBalwO6ugRuq4w0QPHwqllDP08fJ25CNYBWCle1ypKRTFkuKjPgyDD+PxB95guFylIZPzw1reMgGw0orvmH9c2ArCdNuom0zA0Oea0dKmk42XP6YPcKpVijefCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwFdREpAQxbkgCEOnwDANfYnBBMQWetRUfuRmm+0+lE=;
 b=ivKRLl6y43DddXaR1ui+xr3+ZaWSlbqLPdpqM8ngPatx38J3DAZkfOcnPWi7mPILa16QyxTVTlS7PcUK4fpegp+jEzEv+WMPbqIdFH3+Q7aAI/3hO+P4xkxq9ad+ZbqXBnC96SGpDuFRf/c/H73b4pZrftEzaRmRtx/PvZ/W5lkLI2wpvFtq0St77fbUFPMsKXqZ0GIer8U331DBwoelluEYOX4iWrnTw3W+PSprOMgUNFY8pMb0bnqOVY/jH/oW8AWCWR35GA8GjGWaKuc9CGxq9jFSMp4u6fBbejaj/R2epInC+I55i6JxHK5EBeb32KcVPiiWZ5aMDmXuctCWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwFdREpAQxbkgCEOnwDANfYnBBMQWetRUfuRmm+0+lE=;
 b=SpWXS4VD+YOl5sNOadJ4LWOg0SrFpRPctqxirTezPMZW6zH8A5rh/RorlxEdaA4jI8eI/XeULPBS1UXndcFcv2Mwnowm+HckAgNEkswp58JVptTtj0wDcwf//YUwKiPRaHkjf3u2BLCXFoDLDaWBNOC6B6blDTnrGD5yVifYjdM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sat, 23 Dec
 2023 18:07:35 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7113.023; Sat, 23 Dec 2023
 18:07:35 +0000
Message-ID: <620255dc-f16b-400f-bc53-cb7298d1d0e9@oracle.com>
Date: Sat, 23 Dec 2023 10:07:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: drop st_mutex and rp_mutex before calling
 move_to_close_lru()
Content-Language: en-US
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Olga Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <170320926037.11005.9834662167645370066@noble.neil.brown.name>
 <170321113026.11005.17173312563294650530@noble.neil.brown.name>
 <eab63c76-6425-40c9-a078-ab6c4bdf10f8@oracle.com>
 <170328606817.11005.12343520715219354379@noble.neil.brown.name>
From: dai.ngo@oracle.com
In-Reply-To: <170328606817.11005.12343520715219354379@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BY5PR10MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d51486-14e4-4b15-77c3-08dc03e20a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bpdUbLX5zNTyP1fgRUQXoaY0/xbhSmRTmreyx3xQ9Ig3Ab4AVGRxvEh4IsyPHpOHYzSRdA/bMU+UGfqmScYCnOCf3cExPH484kJTqCk/wr1xHA2bPGLw/17h9Udkf2hrfRge4iLpInIBwW8mBTARvUYejpb1Ws++GkdCYCdJEGc5vYNxUmVLoRhYKWSLhXzXp2N2WqNZKl7wpImewyJyZcyttIfrt7a4DtGrEEmuHZhSgs2ca7P/Nh4irzoenq1aMBttrW2pcUqs2CuP4Y3A9yaYuG9xI31+SC83Rcrhp9VNrLIR5jYP9C0vQrsZv6AT35s77XSQLGbMTMUbC5DUYIbQS+7vC8TBPsUtvoCju1Oq42+ae9yMvIfxZiiqq7DAjWEmFWHayqfRLuSbYKQ/aLiq8xZNfZy5XRh7R/zaMFT9dik2alW3mXNREh73QEFmbym4rGicqZEcZwxHVpt6LRvOy8J+Dyc+W1girtGmiTrTKmtIOmCSamHe6BhIlWbIKEsSrieGAOaQHNta/Kbs0VZ8YAsghOUaBOiAEYOZRzcq/Y0xI8tSOqlJGKggAlstU+Jz/rsquQ9A/wB1l6TeSf37zzCnh3LgbEGxbSw6YAk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(6506007)(26005)(2616005)(9686003)(6666004)(6512007)(53546011)(36756003)(86362001)(31696002)(38100700002)(5660300002)(4326008)(8936002)(8676002)(66556008)(83380400001)(66476007)(54906003)(66946007)(6916009)(966005)(41300700001)(2906002)(6486002)(316002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmF5SDNiT3FpamtKbXovL0paMHhPdGQzQ2pqNWc2MkQ5bDRGSkZjQVNIL0dN?=
 =?utf-8?B?Q0V5YWhmVTZrRlMwSjRvNkdPRC9tbk8xV01OalVBMStKT3dWcW94ZTJIT0sw?=
 =?utf-8?B?Z1ZXeWVZK2JURHl2RENXb3hHRlh0dlJNcU5mOEd2SGtBV3VoWWIwU3J6Njcx?=
 =?utf-8?B?YndGN0puYnFEeGhPWjhZV3llOG1QQkRoRUtZN3cwSjcvSHdvdkROaVVhSHJ5?=
 =?utf-8?B?RDdna2dPM1pxNkNhSDJuMUxvalg4N21kcTY4NlRQcE9PRVhWS0Z1S2lYWTVK?=
 =?utf-8?B?amwzRXhCZXh4bTNEaGlWTlI5NzJUc1gxdWVwUzZsUUFYSEd2OVBaK3dBaitY?=
 =?utf-8?B?MzJKaC80Wm5OMENnU1ZqYnFZMmNJbG9Zcy9KTG8ybEhPVlpPYVBMMEdwOEt6?=
 =?utf-8?B?VUV2WkVxUkw2aHRjUXJGTVczYnFoMVdMMEVMNEdSWjRTUG9GVUdPaEtZTGIr?=
 =?utf-8?B?YmxoTVdSUEFHempoU0liNGRrZ1N3WVhWK3p3NUdiMWpMd0psOFgwOGJQYkdU?=
 =?utf-8?B?VHk1aWhzK1NKZG0wbnNKcmJqWHNFdzdCZ3F4Zk9MREk5Tk5QNzk0Yys4cEI4?=
 =?utf-8?B?cTJneGM2YVVKU3FwNExwTDVJNWNSdVdMZW50eWpNRndTcmtDVTRqNEhjWHVS?=
 =?utf-8?B?ak9iK3lacFJMWmRObVJMTEg5VUtNdlBYK2srSEpjYXloanplcE8zMVNZcjhU?=
 =?utf-8?B?V2RHRXVlckdLRFR0NUpUbCtKeUVTekNOWlo1RC9VUlpEbVlMRmFpZHorNnNC?=
 =?utf-8?B?Si9aZWlDVXljNWZpYVZJTVR5b2FBUFlZS04zZm5LTHg0TU1JVGJuRUV4RHlZ?=
 =?utf-8?B?R0IvV3RHYkNmTXhNcWMvTXlwREVRQWU1ZWt5aTA1bEJaaVVmTGh3TWR3RGpu?=
 =?utf-8?B?dnA4dTRFVHJtRWx0RjdkM0RoRmE0OWUrcHlicDR0WXZXV1RHbDMzb09BZXRN?=
 =?utf-8?B?R1VnTmQxd1pac05FcUEwclV3eFJLaUJxWVRZUnZWY2NVb2RIaStxNTd5UXhs?=
 =?utf-8?B?WTNETlduRldMdVNyYTE3K1g1OTVlb3h0N283TmdrbitaRFdKUEluK1JVVHlq?=
 =?utf-8?B?bWZOa1QxSGdUcnl5cmtoSnZmL1FGdDlERU9mRDV3N0MrSTkzUEJxVnZBeHFH?=
 =?utf-8?B?V2l3V0FHS2YvczA5ZHJMMnR0SXZOMFhtTHFDSVVuSEFlMWc3TVp5SkFON1BQ?=
 =?utf-8?B?N3Iwa0RkdWRoWitjSWNYcFpVYlRRVGp0OVRRSDVFZXh6U3Y2YzVwNExDZlJk?=
 =?utf-8?B?ZTFFZ2dzaldiNXI2N0ZCdzRwVHZGOWRhMWl6MjdxNkxNOHV4dUZldzA2cGtv?=
 =?utf-8?B?MFhHMGUvaGFVMUNvQWFmNmVVYWlZYytvdzVSSWlUMEw5SkJSK2dPcUs5QU9Q?=
 =?utf-8?B?ajYyL0xnWGo2UFpIZ3pwcXJ1Y1FOYnc0bGZ5akFBMlZvK0gwUGFIWHluZTVj?=
 =?utf-8?B?bjBJcVlSVnY5U2RwMFJUS2tPWUFwNGRDUEhUdThvd0doNTVMKzBmZk4reTlU?=
 =?utf-8?B?WDEwYk5UemIyR1c2MVZVUmlFT212d1ZqZCtpTk1UVy9iZmg2VEJ5T1JxNXZW?=
 =?utf-8?B?SE90RVlpck9CRkFubmxyOHRJQzdpQnJ4UTJiQzUzdFU4YmtzbWZockZyZVhL?=
 =?utf-8?B?VUlIV2d0SWNZeUtlK3pSSHBDZWZFWEpqRjBQNENZbm82aUwzWnNhQzVHdUxH?=
 =?utf-8?B?VHdsTGVPb200VnRHTnpKdEVDdFl0SmtDUHJNQm8wVTlGSFNmMnRCWENTdlZW?=
 =?utf-8?B?MGVLbTVyT0hMVWJ5ZVJFdUwxZ2NrMks2aDcyWmJmaVZoQWtGMzNxT0Rzc0NJ?=
 =?utf-8?B?d3lWK3RyTUFvMUlGZjlXZ2xGLzZwa0RoTUhrVnZCOFJZaGc4c3NNY1VyclJZ?=
 =?utf-8?B?MUI1YXNtUlhFcDVPVU5RVExDM2Jrc2YxZ3ArRkZIMlBNTG41WFowb1V0WDE5?=
 =?utf-8?B?R0hiZGJkdVZDcGxScFMzMTFFdHFqcHEyUGV1Kzl6dHRuak9QcThXRFY5bWJj?=
 =?utf-8?B?dlVSODBGMmJ1TUVZTndoV2JmRi8weGFTalNaTEZkOXNOa0U5S2lEM2Fha0Jy?=
 =?utf-8?B?cHJZdzdVcWVTc0ZQaW43dkhYckJ5Tjl4Z1gzR2I0NDRMUXNJSWNzMFR0MmtV?=
 =?utf-8?Q?obGOt6sfpk253dwxG+CfUB/8o?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yORx0vqJUXmztoiqLWOCHwNdzZme8gC6us/xe+ez709R4BK3ioNpg6IRjyPiYIUkHdgwt+igucni8MoIW6r8xmntu1UlRox8N0TprJsVYDZDBFxgB4C5BK6iKnCnJN9Mcta3t2wiRMCUP634Gsv6J37V2nMpFeVlq9lruP+TDrL8isQgRBY97xukekmdzDo6+RHRTH7jrdskrYV2+6r4DvE+4nqsKvstXQcoP1gn0XhD1pktYZAZ6BJKkZPCwYNkI3Z3kKfvm7UkEsTfhl8EU/0P38oCuSmcbeP9btyHQQFxyxtOPy6HVnSoP2OeRRljTWCa2ohjJE7fqdoZvrHyZ1Z/WUlAEyw7E3yQP7TaTvRoEOtZw6VIK5iqjzgPvDCsvNKeIHKNdGo28pevFhcO2MOgt4Y1WYTPYZq7wsWnIVMv3VQra2wuGXGTZKVE/N3fYQPgcRKAdhFK4WNC6Jk+8ez6Fy+4UGYxF1qfVswbK/u/IzDMZwFXhaCFswHzjl0xbaZ86AzBmB0EN+qHtzQS93h81W2qOsbXYSKt9GGdY55eQzgKkcznKIkWFmV5XtxanrGIeHyk63VIFTVI/T4Tj42qCZl14d/OK39/qsHePLQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d51486-14e4-4b15-77c3-08dc03e20a5c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 18:07:35.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db3FASX8QUXz6I3HaQ5Z4xDM5f7BFj2JF1oBA7XrA1gYqI7lRRGxf8wMMbCtqKMJdVCx7JTiiJtF8XoxPfxVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-23_08,2023-12-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312230143
X-Proofpoint-GUID: IJc213dkptzxPk5JuvvAgIUvSwAYp4bv
X-Proofpoint-ORIG-GUID: IJc213dkptzxPk5JuvvAgIUvSwAYp4bv


On 12/22/23 3:01 PM, NeilBrown wrote:
> On Sat, 23 Dec 2023, dai.ngo@oracle.com wrote:
>> On 12/21/23 6:12 PM, NeilBrown wrote:
>>> move_to_close_lru() is currently called with ->st_mutex and .rp_mutex held.
>>> This can lead to a deadlock as move_to_close_lru() waits for sc_count to
>>> drop to 2, and some threads holding a reference might be waiting for either
>>> mutex.  These references will never be dropped so sc_count will never
>>> reach 2.
>> Yes, I think there is potential deadlock here since both nfs4_preprocess_seqid_op
>> and nfsd4_find_and_lock_existing_open can increment the sc_count but then
>> have to wait for the st_mutex which being held by move_to_close_lru.
>>
>>> There can be no harm in dropping ->st_mutex to before
>>> move_to_close_lru() because the only place that takes the mutex is
>>> nfsd4_lock_ol_stateid(), and it quickly aborts if sc_type is
>>> NFS4_CLOSED_STID, which it will be before move_to_close_lru() is called.
>>>
>>> Similarly dropping .rp_mutex is safe after the state is closed and so
>>> no longer usable.  Another way to look at this is that nothing
>>> significant happens between when nfsd4_close() now calls
>>> nfsd4_cstate_clear_replay(), and where nfsd4_proc_compound calls
>>> nfsd4_cstate_clear_replay() a little later.
>>>
>>> See also
>>>    https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
>>> where this problem was raised but not successfully resolved.
>>>
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>>
>>> Sorry - I posted v1 a little hastily.  I need to drop rp_mutex as well
>>> to avoid the deadlock.  This also is safe.
>>>
>>>    fs/nfsd/nfs4state.c | 12 ++++++++----
>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 40415929e2ae..453714fbcd66 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -7055,7 +7055,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
>>>    	return status;
>>>    }
>>>    
>>> -static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>> +static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>>    {
>>>    	struct nfs4_client *clp = s->st_stid.sc_client;
>>>    	bool unhashed;
>>> @@ -7072,11 +7072,11 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>>    		list_for_each_entry(stp, &reaplist, st_locks)
>>>    			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>>>    		free_ol_stateid_reaplist(&reaplist);
>>> +		return false;
>>>    	} else {
>>>    		spin_unlock(&clp->cl_lock);
>>>    		free_ol_stateid_reaplist(&reaplist);
>>> -		if (unhashed)
>>> -			move_to_close_lru(s, clp->net);
>>> +		return unhashed;
>>>    	}
>>>    }
>>>    
>>> @@ -7092,6 +7092,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	struct nfs4_ol_stateid *stp;
>>>    	struct net *net = SVC_NET(rqstp);
>>>    	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>> +	bool need_move_to_close_list;
>>>    
>>>    	dprintk("NFSD: nfsd4_close on file %pd\n",
>>>    			cstate->current_fh.fh_dentry);
>>> @@ -7114,8 +7115,11 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>    	 */
>>>    	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
>>>    
>>> -	nfsd4_close_open_stateid(stp);
>>> +	need_move_to_close_list = nfsd4_close_open_stateid(stp);
>>>    	mutex_unlock(&stp->st_mutex);
>>> +	nfsd4_cstate_clear_replay(cstate);
>> should nfsd4_cstate_clear_replay be called only if need_move_to_close_list
>> is true?
> It certain could be done like that.
>
>     if (need_move_to_close_list) {
>           nfsd4_cstate_clear_replay(cstate);
>           move_to_close_lru(stp, net);
>     }
>
> It would make almost no behavioural difference as
> need_to_move_close_list is never true for v4.1 and later and almost
> always true for v4.0, and nfsd4_cstate_clear_replay() does nothing for
> v4.1 and later.
> The only time behaviour would interrestingly different is when
> nfsd4_close_open_stateid() found the state was already unlocked.  Then
> need_move_to_close_list would be false, but nfsd4_cstate_clear_replay()
> wouldn't be a no-op.
>
> I thought the code was a little simpler the way I wrote it.  We don't
> need the need_move_to_close_list guard on nfsd4_cstate_clear_replay(),
> so I left it unguarded.
> But I'm happy to change it if you can give a good reason - or even if
> you just think it is clearer the other way.

My thinking is that if move_to_close_lru is not called then why bother
to do nfsd4_cstate_clear_replay. It's just easier to understand and
safer (against future changes) than having to go through all possible
scenarios to make sure it's safe to call nfsd4_cstate_clear_replay
regardless.

-Dai

>
> Thanks,
> NeilBrown
>
>> -Dai
>>
>>> +	if (need_move_to_close_list)
>>> +		move_to_close_lru(stp, net);
>>>    
>>>    	/* v4.1+ suggests that we send a special stateid in here, since the
>>>    	 * clients should just ignore this anyway. Since this is not useful

