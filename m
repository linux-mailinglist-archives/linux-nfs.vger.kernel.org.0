Return-Path: <linux-nfs+bounces-103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6555D7FA76B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 18:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883BD1C20A4E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1539364DF;
	Mon, 27 Nov 2023 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gn4Oyv2L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jXLhaMsx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1249037
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 09:00:08 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARFKSRD027711;
	Mon, 27 Nov 2023 17:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yInL/n1B67NHDuan2zVTeHYOh5MjJPvOzumHXLTpOEY=;
 b=gn4Oyv2Lioq8Hx6DDb6geDqIOS8ZeeqMJz9X1+kaiwQABNFnV/c0B1sN8mZopSeHf9jP
 4u8V49V7PAhfMbo1o0d2NlKvl9AXCz+rcHH0+Bp7yagJyFjvVE64Xb4HZHYjMWTqypjq
 3OPHi+J9wS1lG+j71PjoW6F3oHRFZwBd82iQMzN26a1+Bp3+KaR/+CO63UTBPB1+wOFu
 R7j3TIksMDZYySdhSZ/IjVqZ40lbiwjeKrX490j5TYqmNsJ6auxDE7PmhsBw9++S6Ggu
 IQdx/5qocT654fdsPemEKEJHtYkGu2sv8uuNsMvvXQfm59Ackr1JmUyqQcOAOTnbqGeB 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk9fukdky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 16:59:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARFXobA026961;
	Mon, 27 Nov 2023 16:59:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cbsxh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 16:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F04XEhj9HfARMlEtIURc7eAQW1igXpj+33fBvlZ9spZAFD36vCX0V0yDodjf7KM0bG+MldiWxgqP41DDn7rL9YvoQaLD2TUdsVsLKUTYM7y38xm8gIoRN2W0TjQuNNhmkasSG+roM9eTkWkPHGRE7N3E7CXgIoG4gOC7t5dsZi1Mb1bFL/ZuOSN7bI/8Z+fWaYpUL8SeUia89xgoYIrJuud7LXw8MjHSAcPE7yj4UDcL8Y9sGyfj93M/dqQX7lwOFG/rch9ZWEd/hS+0dttf72sveqtzObCEnFdcFuOQ7bzZFF6JBG29qybCfsahvioz5ckWx1L7H1jKttl7YkmwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yInL/n1B67NHDuan2zVTeHYOh5MjJPvOzumHXLTpOEY=;
 b=F4UbN2CPYypLAkL0sUbaCSNURA7jC+vkK7kaDYqEVt8YPvmRGwmAbEC/v/esy9QWUAJPGUZ2MtKJB72R2/musW1xNL4Mdm6FaaoXyUR1eefbWMh1rarLMs845uII3dvrGFdQvVQQxEZMQQmUY+oXLFHO01qTA45sj4n/XCy1ehWgsK8Sz6IfgRjrTNNXfbqQa6xTJr+BcXt+nompO2El5pRS+n8dtje7SroqfsvB1SLV+1bmoRDdEc6lzYs8Qda3svRmCGQ8G+EhVgyEug1v1OqlA2U7XPZpz3sJsGJeRuy9OwdtpVHX+1KldVGP0MU5+H4hkP41AheiKQUNOXMluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yInL/n1B67NHDuan2zVTeHYOh5MjJPvOzumHXLTpOEY=;
 b=jXLhaMsxcN2YEuSKxJw7QI7cHdxeVpIt0lau7nYYHNBm5FjcjAnlDE0blefViiHuK3whiN26Dwsddo6uHodAG8JP/xFLVX83PkhKr4+LX803LDo8EH0I6gdZHcB+PLaowFH7C+q44am3b1i8qt6HsAXL4oPJ4KnD2LngP3hjw6s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5845.namprd10.prod.outlook.com (2603:10b6:510:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 16:59:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 16:59:45 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Tao Lyu <tao.lyu@epfl.ch>, Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Thread-Topic: Question about O_APPEND | O_DIRECT
Thread-Index: 
 AQHaHjflhODFfyeMXUSkxSGiPt/2HLCLuRkAgAKTcNCAABbagIAAA+kAgAABWICAAAEegA==
Date: Mon, 27 Nov 2023 16:59:45 +0000
Message-ID: <52559C84-A251-4CAD-8BDF-B1B2EA4DA390@oracle.com>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch> <ZWTFn0/FtJ5WuQGc@infradead.org>
 <7E2914D2-B9AB-4280-9A44-875DA8B58328@oracle.com>
 <ZWTKBzx2Wkw6Mbxd@infradead.org>
In-Reply-To: <ZWTKBzx2Wkw6Mbxd@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5845:EE_
x-ms-office365-filtering-correlation-id: 93640c06-0417-466b-26e1-08dbef6a4239
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Pn0mCnvx27JwkR7ukecgx7vGXAhN4k+JJk1JWNke2NnEaDjRWpVgTl5XG6tm217Ql4RjOJ9p2NykH1tOMo95HgEaXRZExdrIU2Vy6N8LcZ93jHOIXmAzZd75LrepJ5ER32gn7/ZMtAbRz057afnj7IaUm9Fz5FzdbnNeYtKwn6Z3y/FQ1qIKIcOu1YF7rF1NpAYKk1rnQ2atAymicARwzKVbRDzSJxM0Qaj854d23Pp3Cp+7RyIfGrLT0oNRryHPz50Nsd+eoImdcDvf/VHhaDTVZsPin/ZzR2WMnVFu8GlqEP+yOTuf+zqIeYwD4l6H3L3uG3D2wQF9MOwZGJEXdrBFkir74BsejyqfYxUeGewD3iFgcdVGNgR5DEmHWksgemlrhph4Az2vWhojRCYkzNqnG64GUVYmJnCBnUHAzisr5NkHCtXuWPWEtHa08JDV7Q0+m3lRWdsxUTgF0rZsG80uZutVKqoRLlSCNOuZJNuvvzdAjlWe5/yHwb50e6fNiuaq8k9JqBLAifqTtO8iXz9e2PBu8MoBvRZjrT+xyyMc9GP/WiyOCvwPyyYRZzjMdFI48j7PgBFH/f2TY+wNP1oDsLOYH2mJqD+jrnWq3H7vj/jtta6F5nyRv4gBWznD6kg/Vk1JBmNyNMlztu2B4g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(122000001)(41300700001)(38100700002)(2906002)(5660300002)(6512007)(478600001)(6486002)(38070700009)(2616005)(71200400001)(86362001)(36756003)(33656002)(53546011)(6506007)(4326008)(83380400001)(8936002)(8676002)(6916009)(316002)(91956017)(76116006)(66946007)(66446008)(66476007)(54906003)(64756008)(66556008)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SkZ1SHBZY2l6Sm92b2hFUnFCVXd4ZytCZzBCaHRDdVZ2VGNMdXFUN21FejZU?=
 =?utf-8?B?TVdQM3F0cHg5YkJHMWhTaGExeFgzNXg2N3VmcWZTR3FzMlpyMDFNUXF6THpH?=
 =?utf-8?B?Ui9mWm5nYTBHWWRYSkRDSU5jK2txYTh3U1o4NllnUnJ1Wk1FcXMyMThROFc3?=
 =?utf-8?B?QXU2YXFmak9DMXdNVjFKWDhVMGwwdm82VWhnRGk1VkFUTW42Tks0YXR5Ykhr?=
 =?utf-8?B?ZnQ2OVcrSjI4bE9NSElScnFheEdBRStsV0NFSUFWbEx4RWh1RE5sWk5FU052?=
 =?utf-8?B?WnpoK3lSdE1ZVWpvaWNzNFV1Wm5RWS9QNjFLZ1NickF5bFgraTVwMmIyK1Nm?=
 =?utf-8?B?ZCs2b3hkUTNhUytCQ3E2Sm9zUzZscmhmM05mYXhURzJBR3cwWUMyQ0IzY01T?=
 =?utf-8?B?QmxqMW9WTGw0SUFJRHdwSTNIQUdjY2xvK3B3NGVrSUtYanpmd2xFYmFWa1Jl?=
 =?utf-8?B?YnlwTytoV05xbElHY3VGSnRxV0gvYWpGdm5wZUxMdDJFS1ZYUTg4TlZpUEJi?=
 =?utf-8?B?MG5ZSUZEUldhdFZ5SmhiNmFDcC95T1Q0bWNkemdiRWxkQVRTTHgxREVWSkwz?=
 =?utf-8?B?b0owQ0RLb3dTdGJaMEhycldoOW9XdDdTN0U1UGppSzAydy8zeTdhYTRWaHI2?=
 =?utf-8?B?VlBiNXNzbnZHSTBFM00rem1qNWFkTko0TXN1cDBwWE8wVkpTaVVXYXRmNm8v?=
 =?utf-8?B?UktpeXZyZTA1SlZaYzN4bmwvVTNrMU94UHdzMnc3NVFKeDNmcXZFMCswYVJW?=
 =?utf-8?B?RVRwWmR1S29wT2gyK2RSNGlrOEsrUmdOM0hZL2thcWU3R0JyS2R5YTluZFFh?=
 =?utf-8?B?Q3lEblJUcGgzMlpGdDV2SGlZSVlZOGNIa2RWcThlVnJjdlE4MVlYWEtrQlR1?=
 =?utf-8?B?N24rclpIdHlVcWlEdnd0aXYrK0tBMUltWnVQcjQvVFJjVy8ybEZ6MCthZHlh?=
 =?utf-8?B?cmlUbWdOeU9CRGZLYTZ5R3E4NVYzaUk5bFdHWm1UK0xyYkdDWkVWUDNjMTRT?=
 =?utf-8?B?MmhJVUlwckxuTTh6WEUrTTBjdGZNb3lwVnU0NkMwalNFdEtQUDl5RHdyUlJF?=
 =?utf-8?B?TVIyaHhINUswNU9FRGZnRlY4bTIrTGpKY0RVeW5PaWFnUkNOeThuSktzbXpF?=
 =?utf-8?B?eXVGaEVSaVh2a1laaUs4N0lZUE9uZFhyYVVGRW5hdjV3YUc0VWJaV0FaUjBN?=
 =?utf-8?B?Z0pJZTl2NGJ6enpQRUs3MjFobFpyN0RPN3oxQi9rZjlpV0c5c0oxRDljYXBX?=
 =?utf-8?B?NnZ6QnNITVV6Vy83RW9ETVM5MFhyMlJsaDh1WGliamRqQ1RCbHlWV2kwTjZS?=
 =?utf-8?B?TEZ2YURIWklYZWc3REdZQVlnR3dYMStwNEpjMnVMenR1UEdhR2hPazhBSmhL?=
 =?utf-8?B?cEpmT2xNOUs3WWtBdDlCUTJuWGhZcmNqd29NUzJNRFE0ZUxjdm5Ha1ZWOW1H?=
 =?utf-8?B?MFFtSlYrN1FrV3BMam94N0tKUkhSWStyeXhISm0yWVNyeXp5MzJtbzhqVjYw?=
 =?utf-8?B?WW5jUkFpcENqMm9icUVIYVNOZTJwVWduZkk0b0NEYm5PZS84dExIZm43bVVh?=
 =?utf-8?B?akwrajEvN3U4OHprbmh1d3pMOVB4a28zdGYrVnZrckRpVlVQZTArd0MrYWlP?=
 =?utf-8?B?eVVWMG5UOWRteEpDVzBlUk1ybTV5OFQ5TzRZTjI1ZjVxTkNUMmg5eWtsaHYw?=
 =?utf-8?B?TzBrUUFzNjhLaloxNUtyT0thS0gweEI0a1F6bUQwRVR4SWRaRFd5cTJwRXhH?=
 =?utf-8?B?VldqcEU4UUpObmRUOVYwSTg1Skx4WUhnTkxrRjJxQVp5MWRKREs3K2ZpOERW?=
 =?utf-8?B?RVpWL3RCcXFhZDZGUmcyZjZFRGtEV2gxQW1vbU5vRnlhNjN2R3VoTzJpQlBL?=
 =?utf-8?B?TnpTcEVYN3l0Zm1ZWHdWaW1ZektlVE4yWWJ3NEFmTUZJcFNSWE5mNHhmMm9B?=
 =?utf-8?B?S2tlWHE0Y1FON0dMYXQwczRpWnljdkZuanVOTFAwYVY3R1pXb0twK0NDekVP?=
 =?utf-8?B?clRXMnkxN0swYU9xY3pvZkVWOGJpdkRjL0hWdjUzSjFDWWs3VHVMekpZaVhQ?=
 =?utf-8?B?WkFXMlk1dVFGRjFwK0cybmlnVXo2bkpxaGE3bDkvNXIxbU0vVTV0dmFOTlhD?=
 =?utf-8?B?aVQwbk5yOWJQaG8rK3RCRStQa3E3aHpqRUNRcm1TMzVvY3QzaWVRemZoci9E?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E153CEFD85300A48B57B6731BD852873@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	km33Qx+Kj2JwpSEAXiKIxgDoEd9jtD7tSzaJaP8ki2RVTxF/Dwd0vrV2Gb8iL85dlCb6vIRakAs94oy0mdtBBpO/YRSXBqEbsHLuui3xS4d1XZqZ7eePCjNb9SUzSzDeXJ6eyZmp0CBd37T4/QQAf00fGrL1OHZc89ikGYa16YSKQfUHQ9vXVamJoutrGalqAukPZdLCMmMqDmev0tZ0j8xmryegGI6rqoVyTU2HWkw6LAnuVVbW4KQmWocVG9qJ91ERMqI6sOL4+4PKHq8DOa+S1yDHba5CrAhVD2VqucNSrLYfA/+/o4tBUvOCueiQdGHx6szQk8yFLqNkBn2AGzziNVuxsMisX1YaofeUu6htYi5am8H83gsnngIftwD3+LKLaFeQPeFLFaHYU8ZuGwc+ILWH/XIDaQfvRvqBdVxq0kCq14RzdZqJX3XFDwPWH/84+UTtdb0jxpzunvLzOLxyYXIYm2dAjU87BNeTnYKj/IAuwDrlrlJO/X7vDp2ACZeE4v4Df4nMXInzpTKDFl8oki4thSCUbRzoErosIscLYRBBh6fRa4MCbNL4OalPW/DuAPPqkOl6+Z+NRv2mFbAPGoJHdbw02Xsnnl7/5cEyLeoZP7FJEZWUJkb/d3ZdCWpsyFfFDJ4IBHll+a/MomirWyDbz41K3+//MpSkNCXkDdsJUXNWSm7Ll60Npiqne7vqXzWVb6zvoJoS9bEXgov6uIqKVP+HM/Z29v5KVoNBzF2RvdkUkiejp+HawvRaDTaWsD84DLS4F52kzUnY+KRraeJ9Q028qCebBnOKYrnd0pvefgKh9QLrFBFsjP50q4i9Bc95JMmbHoAj1fYMzYNaXmiq0Vx5lR/6J5G4vns=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93640c06-0417-466b-26e1-08dbef6a4239
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 16:59:45.9623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEfJFdtN+We0zx3dgRIf/YOpv+WFFpit0vULO2UxEV6Wn336FkACFkBOoKeawefZPj5JygEHJcLAG11W6LKS9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=626 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270118
X-Proofpoint-ORIG-GUID: PaSpGouMGe2bYXPYrBEpcUS9uf-Qlsjz
X-Proofpoint-GUID: PaSpGouMGe2bYXPYrBEpcUS9uf-Qlsjz

DQoNCj4gT24gTm92IDI3LCAyMDIzLCBhdCAxMTo1NeKAr0FNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBOb3YgMjcsIDIwMjMgYXQg
MDQ6NTA6NTZQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+IEJ0dywgSSB0aGlu
ayBhbiBBUFBFTkQgb3BlcmF0aW9uIGluIE5GUyB3b3VsZCBiZSBhIHZlcnkgZ29vZCBpZGVhLCBh
bmQNCj4+PiBJJ2QgbG92ZSB0byB3b3JrIHdpdGggaW50ZXJlc3RlZCBwYXJ0aWVzIGluIHRoZSBJ
RVRGIG9uIGl0Lg0KPj4gDQo+PiBZb3UgY2FuIHdyaXRlIGFuZCBzdWJtaXQgYSBwZXJzb25hbCBk
cmFmdCB0aGF0IGRlc2NyaWJlcyBpdDsgaXQNCj4+IHdvdWxkbid0IG5lZWQgdG8gYmUgbW9yZSB0
aGFuIGEgZmV3IHBhZ2VzLiBUaGUgaGFyZCBwYXJ0IG9mIHRoYXQNCj4+IHdvdWxkIGJlIGFjY3Vt
dWxhdGluZyB1c2UgY2FzZSBkZXNjcmlwdGlvbnMuDQo+PiANCj4+IEkgdGhpbmsgeW91IGNvdWxk
IGNyZWF0ZSBhIHByb29mIG9mIGNvbmNlcHQgYnkgaW5jbHVkaW5nIGEgVkVSSUZZDQo+PiBvcGVy
YXRpb24gaW4gZnJvbnQgb2YgdGhlIFdSSVRFIHRvIGVuc3VyZSB0aGUgV1JJVEUgb2NjdXJzIG9u
bHkNCj4+IGlmIHRoZSBvZmZzZXQgYXJndW1lbnQgaW4gdGhlIFdSSVRFIGFncmVlcyB3aXRoIHRo
ZSBmaWxlJ3Mgc2l6ZQ0KPj4gb24gdGhlIHNlcnZlci4gSWYgdGhlIFZFUklGWSBmYWlscywgdGhl
IGNsaWVudCBncmFicyB0aGUgdXBkYXRlZA0KPj4gZmlsZSBzaXplIGFuZCB0cmllcyBhZ2Fpbi4N
Cj4gDQo+IFRoYXQgc2VlbXMgbGlrZSBleGFjdGx5IHRoZSB3cm9uZyBpZGVhIGFyb3VuZC4gIFRo
ZSBpZGVhIGJlaGluZCBhcHBlbmQNCj4gYmFzZWQgbW9kZWxzIGZvciB3cml0ZSBvdXQgb2YgcGxh
Y2Ugc3RvcmFnZSBpcyB0aGF0IHlvdSBkbyBub3QgY2FyZQ0KPiB3aGVyZSBpdCBpcyB3cml0dGVu
IC0geW91IGxlYXZlIGl0IHRvIHRoZSBzZXJ2ZXIgb3Igc3RvcmFnZSBkZXZpY2UgdG8NCj4gcGxh
Y2UgaXQgYXQgdGhlIGN1cnJlbnQgYXBwZW5kIHBvaW50LiAgWW91IGp1c3QgbmVlZCB0byBrbm93
IHdoZXJlIGl0DQo+IGdvdCBwbGFjZWQgYWZ0ZXIgdGhlIGZhY3QgZm9yIHNvbWUgb2YgdGhlbSAo
bm90IGZvciBzaW1wbHkgbG9ncywNCj4gdGhvdWdoKS4NCg0KSSBzYWlkICJwcm9vZiBvZiBjb25j
ZXB0IiAtLSBvYnZpb3VzbHkgeW91IGRvbid0IHdhbnQgdGhpcyBraW5kIG9mDQpyYWN5IGFycmFu
Z2VtZW50IGFzIGEgbG9uZy10ZXJtIHNvbHV0aW9uLCB5b3UganVzdCB3YW50IHNvbWV0aGluZw0K
dGhhdCB3b3JrcyB3aXRoIGN1cnJlbnQgc2VydmVyIGltcGxlbWVudGF0aW9ucyBmb3IgZXhwZXJp
bWVudGF0aW9uLg0KDQpBbmQsIGlmIHRoZSBhYm92ZSBXUklURSBzdWNjZWVkcywgdGhlIGNsaWVu
dCB3b3VsZCBrbm93IGV4YWN0bHkNCndoZXJlIHRoZSBzZXJ2ZXIgcGxhY2VkIHRoZSBwYXlsb2Fk
IGluIHRoZSBmaWxlLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

