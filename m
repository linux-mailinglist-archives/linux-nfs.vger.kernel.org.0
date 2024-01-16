Return-Path: <linux-nfs+bounces-1130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492A82F074
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 15:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986981C234AD
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7C1BF20;
	Tue, 16 Jan 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bog5zK9f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nyecfhtd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51D1BF3B
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jan 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GD6R5M003886;
	Tue, 16 Jan 2024 14:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jKEDKsZdmOFmQt9UJHvB64md/z6OW8rPOsQ8GslldgY=;
 b=Bog5zK9fdyS+J63U0pkYbRnPKunhigoGTw5jXZMtXyI2eCA7jMt60YEG2irQUnv2kAjM
 am8fDRfqnVG88AuQ3+dRpl0UhanOw0PLyd+i397IRjZdIS46daneslNkpeoRIPoSWsCa
 Ijafj2GinQr68NQIKHCTBXVNC9M7+55CvHK33aWLi4wI7pY1kZMjs7zUZifA2ZKxaB1v
 it6/7sABAI0QODUWqH6dQ4qI2ItvjD1na2FddipNl7EDUr+JFVf6w2CEUjVIwgaLNDuz
 nxItOsam57MAWOI8ng0DrYTxuOXh3vn7eIgqKdBkZtzyEDHrZDklbcMOtv4AvU5N4fvN 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3gvqag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 14:19:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40GDgqux009483;
	Tue, 16 Jan 2024 14:19:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy82y8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 14:19:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6jaYMWUYM4oejguzRxxWrKf3ERacqBzsb/50P938iN50Xt9n5WzzL4KdHJbJ8STydj46dB6mz8iJdQ5eilIc/V+MKhPWVLNpc2zUwCoczkoOgFi/eokzHp90dbnAckYsjvevrqJ0XrgK/AaEew+vKOq4Ha3inPCDLOfpO4GLUXGXs2XeX9mWOqc5drnjMShpi/D51j+FiMzeM2GJunfoB1cPm7XJ9dUuK0HXy1j/4zyLgkL+35NhPcMv8wAxy3mSw8TvLP4+ELSrwkXWAWGHGEhVq8nOYE/63Sq25IxCgY/KqXXCapM/rq2y8nlUGe91dx5+91mjLju5HeIm0nqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKEDKsZdmOFmQt9UJHvB64md/z6OW8rPOsQ8GslldgY=;
 b=JjTHn6iHnyVPlgRGgXuzppn/5KcIIyF1V6TR+laTMuhfwQoBBy/dTyT3xG01Prydn6Wezeuoz1dE7xWVKDIm/VuXSFnoUwPh0i7j5bbQ+Z6tAks1Tos05HhamfWJPDoJwc3JjrrcpyjtZgm3/ZkeuFbcvpMgf+ZUZpXqYyTTM+R+JPfTQqj+TXmFwYlGfC/SSvlAquJx2LH2YQMz0HN7QufBsmTHJWblam5PjdIDsG1LqrpxCEbYBgCSWhcIiHjKshVhjFBN1B3PHj2H8Gd90MVzXsaR479rWrABDs/KlYRZ4hvbODzDaRod/Z3iR9qeufmlC+ZILcAgBmU/MYMvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKEDKsZdmOFmQt9UJHvB64md/z6OW8rPOsQ8GslldgY=;
 b=NyecfhtdiwAe+e2BGi9NpFHzkg37pdlU6FaKBg4S5or3EEyFl1S3C/dMMMzee956sS90l68Zw4J4+DJxiBjMLW2hxZuoEwrsKRJ8lOMZhRsCvjXQioLErlmm4L7Gop0FigF3SHxdwyE7vu0PiGaZ9PSb4A8U0fsN9Vzr4GUL/wU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7613.namprd10.prod.outlook.com (2603:10b6:303:23b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 14:19:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f%5]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 14:19:38 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Connor Smith <connor.smith@hitachivantara.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Possible discrepancy in CREATE_SESSION slot number accounting
Thread-Topic: Possible discrepancy in CREATE_SESSION slot number accounting
Thread-Index: AdpIgOxAPAgULydbT7evjuyQgxyM6gABhbOA
Date: Tue, 16 Jan 2024 14:19:38 +0000
Message-ID: <B23AEE8C-2C4C-4DD0-904C-7BCD927CC4E0@oracle.com>
References: 
 <DM8PR08MB72883F3D2AF2A0638CD41356E8732@DM8PR08MB7288.namprd08.prod.outlook.com>
In-Reply-To: 
 <DM8PR08MB72883F3D2AF2A0638CD41356E8732@DM8PR08MB7288.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW6PR10MB7613:EE_
x-ms-office365-filtering-correlation-id: 323a669d-b2cc-4e9f-8c4f-08dc169e2c1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RD0d2cbJr4L0G8YRnLyY0zvvKNX9BaLiweU1PZz+ABz8C/E1V+mCvzP8KvvDS6rzcb5WmqaXiLxdRoeVzh0077o4Am0ShTMfAoGWC+SriyrDwzv/RQs4NAD8qwv4MqMqFMzjNqSOYhpanqdxBRY9hXSwm6jgCcEyz6Ny6m29gs6+airJRrcsMeeLoA7z9XCo93cP9Gl/u6RH2zCj8ufUZt+n0knuN1YXYAtvLPOCntJcuGXXVNEUzMGzVyt6QRn1LtvuMKmdEeqjSSyj6Ck0Goh4s3MhVTq7DA9e+5xq0/yFQBbgAwl3iqumMpDUhn9YdZwqooiw1sspPsE8xtmLrBJOSqoy3B4JWSgtYt6tu18bmJff4fMz40TgxkXZNFedMm2Y06ZyxCTBOaIf4CzgDuiaNigICOKvizUNbQfnpZQWhMU2uriWwi3M8UswqWDn16F+t1v1yFLECEXb2nXgunlMOtoti6bQckPlhxfY59hud4V3HjzDu8GVeRvRpcJPxEcr77oY0YLFc9LcrB2IoI2foh8r6fhlb3IMmt4D7+mtAEPRI7ccztV/O7oiIJTvhbVrgGsYyymOaJMlx/oYLNQORJNdSAlVFo8di3WIgamzd3XKP74b8+w8tPbVCVInUMF8+1eNHc59q3aRtO0Dzw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38070700009)(2616005)(26005)(2906002)(5660300002)(6506007)(53546011)(6512007)(76116006)(71200400001)(66476007)(64756008)(8676002)(4326008)(91956017)(66556008)(8936002)(66446008)(66946007)(316002)(6916009)(15650500001)(83380400001)(122000001)(38100700002)(966005)(6486002)(478600001)(33656002)(41300700001)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ditwQkZ1MmZaL3BTZjFxY0ZCeGFnTlBYOURrcG0wdUFkN1gzaDZ2ZXVIZWZm?=
 =?utf-8?B?KzErOWhHdnFlYjExd1ZpYkxTcElHRWc2VWVYcTkzT1Qxc1E0cWZCVXo2bE5H?=
 =?utf-8?B?bVZ4QzZvUlRWNW10anVwdjFncHU4a21lUVpGZmorZ2oyM0JqZ2J2UEJkVmxS?=
 =?utf-8?B?UStXaFIwWnluWUFBTWNLVUJBTmR0VHRuemdjRGJDYyt1eTFzc3ljL2ttbXgr?=
 =?utf-8?B?N2RRaFdnWXNDWmlOeFF1NndXWTRUbTJXR2gyTFkxcGZCLzkxRFdET3U2VWsr?=
 =?utf-8?B?Y0loMUJvZlJFcUFPclpBOTNyYU4vZUlYWUsyOVg1dVJzQityUVBMU3MzMTdT?=
 =?utf-8?B?dmlESldKekV5NmMrZThsOTFjYjFuYnhNN1p2MXcwdTZ4U1lKeGtQQnlPUjZB?=
 =?utf-8?B?ZVRTYkdEb0VxVDg4dE10b1dJK3VuYmlxQm15NnhZOUl5bUtOY25jUFVDTy9U?=
 =?utf-8?B?ckhmOFU4TXQ4TUswM1VHdkhSQlRZQ1N1TlNwbWJDVHU1QW1GUnBPM2FvSGNh?=
 =?utf-8?B?V2lsTTZUcUZpZEtKOWx0M2lIcHlld3kzdjFGRVFGV01RcUY0ZzN0VFp1Vm1B?=
 =?utf-8?B?R2xBM3lMR21kaUxGS1laNmZxOEY5dlRiNzFOajZpUUVnMzMvWjlsZzhmejhG?=
 =?utf-8?B?UmI3OGQrRm82MG45TXYwejZRV1V2ZW9pZE5NTjhySHBZWWlobkd2TUI1aGx5?=
 =?utf-8?B?NnVzK25qb2JWeUtoWllsUW9OUEdkdXdXY3pTbmRudjMxUEZsN1pxVUlEMjFG?=
 =?utf-8?B?aTBYcDQ3S0dBTjZqa093b2dGalhkWk1hcVVxQVhCTlBDWnFJL296M3NsZHRZ?=
 =?utf-8?B?RHZld0p4eG5TZ0hPSmlidk5SVnJGZlRjVnBOdnZQZlhWbG4xZVFRMVVFbkZr?=
 =?utf-8?B?NDRVSGZFWVM5TDk5NjY3QjNPRmZJU0crZ0pFK1ZuYkpsMGVNWUthdFBGbHhz?=
 =?utf-8?B?cStTYXQ5SDhPTDk0b0hwbk5raTgwaWhwZnFUdDRYYkFlUlJMRkZNRXpqaU93?=
 =?utf-8?B?OVNLSWVTV3FkdkJqa3ZraTRkQmZWOWhTMTh2Ty9TOENoVXQrQmhIS3BQWWNz?=
 =?utf-8?B?b1dCQkU4K0l0dXkvQ0p6WkMwSFh2MmlDMGFoMDFaLzBjR1RjVkJtLy9TU0N2?=
 =?utf-8?B?NWJjMS9lbVROTnhzU2xweVR0ZUoyWkdMVURYYXRpN0JWRVJjV1RnWENDb0E4?=
 =?utf-8?B?VU1zeHFDRlEzb1ZLVWU5TmdlS0hBWmo2WFhOSitidmg2eFhZTkxMSUZKS0Zz?=
 =?utf-8?B?UFl0K2xYcFlxT0VObCtLS0RwcmxOMy84MHlDbFZBZU4yaFNla0JrK0o0cmto?=
 =?utf-8?B?V2RCSDh4Z1dWOHdNU0dlbFAyK0ozS0JmWHR6eWQ3YUZhVmJsL1ZrcGtoMjFl?=
 =?utf-8?B?SzVoZGxzRENEV1A4QXkxeEFqdzJ1bEdLWmpicm9uZzFHQ0MrZmtaK0ZHTjUy?=
 =?utf-8?B?dC9obkZYT2l1MEc3aGZMcmtyckFtSVFldXBRcTRpODBJcUxTY0k0RFdMQVAv?=
 =?utf-8?B?MzJHV09oalk4YllOZ3p6V2ZrN3NqY2REclMyQ3pTejhmbzV0WWZRdGo1TUdl?=
 =?utf-8?B?UFZoQ3FpSzlrK1ljQjFSQkhXeUVUNDcrQXFWSzZjbGRFWStXaUhYNjVSUURw?=
 =?utf-8?B?eFpNWFhVY1U4U2l5LzZxU2ZRc1lBQXhsY25SV1RueFhNZG1lWFNqQ3czTDRy?=
 =?utf-8?B?bGx0amtIOGxacVVyQnZUMXdZbUU2Yk02NmZ2SWNyK3E0ejd4aFc1amlFSWlB?=
 =?utf-8?B?QkE4ajhmeWNUSGdGZW5XSHRlYmRJL2JKK05SMFZSeStRaGxxMUpWbWtpTWJD?=
 =?utf-8?B?eWloZVFrM1l3WU96SHlIb3k3blFhVC8rQnk1M2tqS3NmOXE5ZXdzR1MrU3Fz?=
 =?utf-8?B?eDJkMXNlaDNpOURsS0JLSmI4alloRGs1cjJtYjJMUXJ5MkZwUndybitsYTZJ?=
 =?utf-8?B?aS9wdXRoZU5LSmxZWERHMUlIMW9pNXFscWpDdnhqdzBERVBOMkdScUQ1VXRY?=
 =?utf-8?B?RXRmY2lYMEhpVytaelI3S2dIVFF0MDBjazZtTHV6MFdrNUlIUmJpaEQrLzNa?=
 =?utf-8?B?NzRuYk9RaWQ4VTltNkVWMm1YUU1PZ3lCUktFMm5GL0R4blMwZ2pseHlRcTNM?=
 =?utf-8?B?N3ZCM1lqUHhSVEVkQWRSVG0wNmNKT2dnQnFNSExEblMwSUtzL1hPWHVMZVd2?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E5524EC11753D499FABB315A6D22EF3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hTJ2EyllBpB5P0+m27b917+0/ESbdhMELy+Zv2XM+YqqtLZRjSYX2eBzOC6Q9Hy4eMraZP7oUqPDLhqiiVz3DoNQYkGQJa5g2+aMzjV10ktlUa+AWm98ju+OcYx3z6fIrZ0LLhNFYFWqt6mDq7UF0HlBp4ic039e5Pl/18hJWByaVoAXOE5tMG3ZJ0v4AMhdPsfZO1xV/Vw/pouIGa/90wn/Udsb0egzqzW1yEA1SQjQUXS8mhh0aJUNElpgcZls34OzObepQEzVd7XaIhetVoi32QdES5USNcn8dESZqGLfR6lma8pHFGKItpTSMUg/m/okvWMtEgF+L81hG7gK9nWypCfKYW4p+tlYxpvDBMKn2Sr2uDRQBMdU/aWYwf3PhMWkGZi/2gOzj/0RxvtafFPFNjAm7mWKoLIGEhlADZVH7R8aSCIxuoyEle7vDxwAHdBlYCJSkvOz6p+vMAT0LuPUh1Wg1uASldBFTjj0Mk9kk1GraIzcZCJykagYHBGnn7wZjCvVGgtX/OFqkFs7C3v/5DkncTiL2F1LTLcBj0UdqwmQRQ6bGhLLGWDFy4WjD8doOHQX0Kt8firxbuk4wxhPxD+JENXs2ysgEYsLd8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323a669d-b2cc-4e9f-8c4f-08dc169e2c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 14:19:38.0184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5a6W6mFntLkyyIVjhYdR4sAYLY9ESWlZU0Oa+4pYj+URD4vzN0IbnUEEIROzCWpnU4Fo8duC156C+nwYhlf4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_08,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160113
X-Proofpoint-GUID: G9jORCxRhlqYRzZJW3MrUCqQcu03YGjn
X-Proofpoint-ORIG-GUID: G9jORCxRhlqYRzZJW3MrUCqQcu03YGjn

DQoNCj4gT24gSmFuIDE2LCAyMDI0LCBhdCA4OjUy4oCvQU0sIENvbm5vciBTbWl0aCA8Y29ubm9y
LnNtaXRoQGhpdGFjaGl2YW50YXJhLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IEkgbm90
aWNlZCB3aGF0IEkgdGhpbmsgbWlnaHQgYmUgYSBkaXNjcmVwYW5jeSBpbiB0aGUgd2F5IExpbnV4
IG5mcyBhbmQgbmZzZCBtYW5hZ2UgQ1JFQVRFX1NFU1NJT04gcmVwbHkgY2FjaGUgc2VxdWVuY2Ug
SURzLg0KPiANCj4gSW4gZnMvbmZzL25mczRwcm9jLmMgKF9uZnM0X3Byb2NfY3JlYXRlX3Nlc3Np
b24pLCB0aGUgc2VxaWQgbG9va3MgdG8gYmUgaW5jcmVtZW50ZWQgc28gbG9uZyBhcyB0aGUgc3Rh
dHVzIGlzIG5vdCBvbmUgb2YgTkZTNEVSUl9TVEFMRV9DTElFTlRJRCwgTkZTNEVSUl9ERUxBWSwg
b3IgYW4gUlBDIHRpbWVvdXQuIFRoaXMgaXMgbW9zdGx5IGR1ZSB0bzoNCj4gDQo+IGNvbW1pdCBi
NTE5ZDQwOGVhMzIwNDBiMWM3ZTEwYjE1NWEzZWU5YTM2NjYwOTQ3DQo+IEF1dGhvcjogVHJvbmQg
TXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAcHJpbWFyeWRhdGEuY29tPg0KPiBEYXRlOiAgIFN1
biBTZXAgMTEgMTQ6NTA6MDEgMjAxNiAtMDQwMA0KPiANCj4gICAgTkZTdjQuMTogRml4IHRoZSBD
UkVBVEVfU0VTU0lPTiBzbG90IG51bWJlciBhY2NvdW50aW5nDQo+IA0KPiAgICBFbnN1cmUgdGhh
dCB3ZSBjb25mb3JtIHRvIHRoZSBhbGdvcml0aG0gZGVzY3JpYmVkIGluIFJGQzU2NjEsIHNlY3Rp
b24NCj4gICAgMTguMzYuNCBmb3Igd2hlbiB0byBidW1wIHRoZSBzZXF1ZW5jZSBpZC4gSW4gZXNz
ZW5jZSB3ZSBkbyBpdCBmb3IgYWxsDQo+ICAgIGNhc2VzIGV4Y2VwdCB3aGVuIHRoZSBSUEMgY2Fs
bCB0aW1lZCBvdXQsIG9yIGluIGNhc2Ugb2YgdGhlIHNlcnZlciByZXR1cm5pbmcNCj4gICAgTkZT
NEVSUl9ERUxBWSBvciBORlM0RVJSX1NUQUxFX0NMSUVOVElELg0KPiANCj4gKE5vdGUgdGhhdCB0
aGUgY29tbWVudCAvKiBJbmNyZW1lbnQgdGhlIGNsaWVudGlkIHNsb3Qgc2VxdWVuY2UgaWQgKi8g
bm90IGJlaW5nIG1vdmVkIGluIHRoZSBhYm92ZSBjb21taXQgaGFzLCBJIHRoaW5rLCBsZWZ0IGl0
IGluIHRoZSB3cm9uZyBwbGFjZS4pDQo+IA0KPiBNZWFud2hpbGUsIGluIGZzL25mc2QvbmZzNHN0
YXRlLmMgKG5mc2Q0X2NyZWF0ZV9zZXNzaW9uKSwgdGhlIHNlcWlkIGxvb2tzIHRvIGJlIGluY3Jl
bWVudGVkIG9ubHkgd2hlbiB0aGUgc2Vzc2lvbiBoYXMgYmVlbiBzdWNjZXNzZnVsbHkgY3JlYXRl
ZCBhbmQgdGhlIHN0YXR1cyB3aWxsIGJlIE5GUzRfT0suIFRoaXMgaXMgbW9zdGx5IGR1ZSB0bzog
DQo+IA0KPiBjb21taXQgODZjM2UxNmNjN2FhY2U0ZDExNDM5NTI4MTNiNmNjMmE4MGM1MTI5NQ0K
PiBBdXRob3I6IEouIEJydWNlIEZpZWxkcyA8YmZpZWxkc0ByZWRoYXQuY29tPg0KPiBEYXRlOiAg
IFNhdCBPY3QgMiAxNzowNDowMCAyMDEwIC0wNDAwDQo+IA0KPiAgICBuZnNkNDogY29uZmlybSBv
bmx5IG9uIHN1Y2Nlc2Z1bCBjcmVhdGVfc2Vzc2lvbg0KPiANCj4gICAgRm9sbG93aW5nIHJmYyA1
NjYxLCBzZWN0aW9uIDE4LjM2LjQ6ICJJZiB0aGUgc2Vzc2lvbiBpcyBub3Qgc3VjY2Vzc2Z1bGx5
DQo+ICAgIGNyZWF0ZWQsIHRoZW4gbm8gY2hhbmdlcyBhcmUgbWFkZSB0byBhbnkgY2xpZW50IHJl
Y29yZHMgb24gdGhlIHNlcnZlci4iDQo+ICAgIFdlIHNob3VsZG4ndCBiZSBjb25maXJtaW5nIG9y
IGluY3JlbWVudGluZyB0aGUgc2VxdWVuY2UgaWQgaW4gdGhpcyBjYXNlLg0KPiANCj4gTXkgcmVh
ZGluZyBvZiBSRkM4ODgxIDE4LjM2LjQgc3VnZ2VzdHMgdGhhdCB0aGUgZm9ybWVyIGlzIGNvcnJl
Y3QgLSBhZnRlciB0aGUgc2VxdWVuY2UgSUQgaGFzIGJlZW4gcHJvY2Vzc2VkIGluIHBoYXNlIDIu
Li4NCj4gDQo+PiBbLi4uXSB0aGUgQ1JFQVRFX1NFU1NJT04gcHJvY2Vzc2luZyBnb2VzIHRvIHRo
ZSBuZXh0IHBoYXNlLiBBIHN1YnNlcXVlbnQgbmV3IENSRUFURV9TRVNTSU9OIGNhbGwgb3ZlciB0
aGUgc2FtZSBjbGllbnQgSUQgTVVTVCB1c2UgYSBjc2Ffc2VxdWVuY2VpZCB0aGF0IGlzIG9uZSBn
cmVhdGVyIHRoYW4gdGhlIHNlcXVlbmNlIElEIGluIHRoZSBzbG90Lg0KPiANCj4gQ2xpZW50IElE
IGNvbmZpcm1hdGlvbiBpcyBpbiBwaGFzZSAzLCBmb3IgZXhhbXBsZSwgYW5kIHJldHVybnMgTkZT
NEVSUl9DTElEX0lOVVNFLiBTaW5jZSB0aGlzIGlzIGFmdGVyIHBoYXNlIDIsIHRoZSBzZXF1ZW5j
ZSBJRCBzaG91bGQgYmUgaW5jcmVtZW50ZWQgb24gdGhhdCBlcnJvciBjb2RlLiBNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQgYSAiY2xpZW50IHJlY29yZCIgcmVmZXJzIHNwZWNpZmljYWxseSB0byB0
aGUgNS10dXBsZSBkZXNjcmliZWQgaW4gMTguMzUuNCwgd2hpY2ggZG9lcyBub3QgaW5jbHVkZSB0
aGUgQ1JFQVRFX1NFU1NJT04gcmVwbHkgY2FjaGUsIHNvIGFsdGhvdWdoIEkgdGhpbmsgdGhlIGxh
dHRlciBjb21taXQgd2FzIHJpZ2h0IHRvIG1vdmUgdGhlIGNvbmZpcm1hdGlvbiBvZiB0aGUgY2xp
ZW50IHJlY29yZCwgSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBpbmNyZW1lbnRpbmcgb2YgdGhlIHNl
cXVlbmNlIElELg0KPiANCj4gQXBvbG9naWVzIGlmIEknbSBtaXN0YWtlbiBhYm91dCBzb21ldGhp
bmcgaGVyZSwgYnV0IEkgd2FzIGNvbmZ1c2VkIGJ5IHdoYXQgbG9va2VkIHRvIG1lIGxpa2UgYSBk
aWZmZXJlbmNlIGluICdzbG90IG51bWJlciBhY2NvdW50aW5nJy4NCg0KSGVsbG8gQ29ubm9yIC0N
Cg0KT24gZmlyc3QgYmx1c2gsIHlvdXIgaW50ZXJwcmV0YXRpb24gb2YgUzE4LjM2LjQgbG9va3Mg
Y29ycmVjdA0KdG8gbWUuIFdlIG5lZWQgdG8gc3R1ZHkgdGhpcyBmdXJ0aGVyIGFuZCBhbHNvIGxv
b2sgaW50byBob3cNCnB5bmZzIHRyZWF0cyBDUkVBVEVfU0VTU0lPTiByZXRyYW5zbWl0cy4gUGxl
YXNlIGZpbGUgYSBidWcNCnJlcG9ydCBoZXJlOg0KDQogIGh0dHBzOi8vYnVnemlsbGEua2VybmVs
Lm9yZy8NCg0KdW5kZXIgRmlsZSBTeXN0ZW1zIC8gTkZTDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==

