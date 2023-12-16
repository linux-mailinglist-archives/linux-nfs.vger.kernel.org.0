Return-Path: <linux-nfs+bounces-675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D3815A7C
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 17:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F166283D40
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F030354;
	Sat, 16 Dec 2023 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dc5AqlRU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dKKVKKeY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231693034C;
	Sat, 16 Dec 2023 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGDY26T028175;
	Sat, 16 Dec 2023 16:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=IICvjmQdZD1wP2l3m2L82yUsLZDtqvQt/2KRbntGkhE=;
 b=dc5AqlRUm2Mr6XTemvalAIJuWkI31QzL4KX/RIj+DUxYIwgr1yvi540ra51280cfL4ih
 ibeghDy+8dqw4gz7g5SSc8Jjl06hWNrsNQnITkA/AllQ9zEW1lHpmoERRKoJ67JBPKFf
 k1KqkCIbOsWLFHCkbAbVqIkFByTSvG5bgwJ00OkI8VSby5JmyuQzMyek6r0eeP2mT1wQ
 wuqILZEbjpAiKt5OyeqyfH/oi88QPK2KXyGr8jD4uZKz/gcFEwPyhArMuHoLAaa8hQkn
 YLf+ZFI+ktckVFEa3wjTag9VSEpAs96ffI5UEs+OeRoJNgXgxXUQ5TX90cj4oeUWGec6 bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12tc0pqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 16:45:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGGTGTw021002;
	Sat, 16 Dec 2023 16:45:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b3m5an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 16:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmh2kr8qzhVzZfuoRgSjsAwk7yEBC1Ke/0871ZSJTMVACkQbvgogDwxMTlRbVyd+LhzEnjlgVmxtlWDfD7sGrGASlOBWi4ZOgjsr83ngob6FhbaQh3mMNUI2Y0ptPhZRp5Y918VRo/LACtARO9xc9LlxqE1buYZC0ISd7ZygfpEuIFWCLl/0CPp30a3f4/PWf8JBRb292w1Owlg31ag2D+NnlvzqcVdTh2wyGfJaOmF6TSMNWgcr+Jmw/UsyxocMJEOqBZwFje1yVpwm3RBPOXnYceUsHrmqzhgFgNGHp0UM0LM8y9Cz8eiybcJzxJH3BkQn5sGHNN9z0fU6WVp+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IICvjmQdZD1wP2l3m2L82yUsLZDtqvQt/2KRbntGkhE=;
 b=AjKCDpwB2f9SS9zcTVn8tEipXSTb5qKgbonaEqamuGte5MIEvUXbR3yBBZe/A8lOT/mtou+3z6B1xlhZTkrtoYNAd5YTng8RX2EGKrPnN6pi/7Qh+SDMUjT5xgtEqaKfs1vjTSwqVY7sGEJpfBCXBMV5KKqlmpbu/iDg4qf8dZHevU1OUwgjCcP+7F7gWgxwFtIjYo4R049ilMW8KVQQ8+UoHsud/7mqEcZHnxmduq1gBQZOh3fdFSHOPdOsXyKyHh0n7uSDclEdQdJwMx2WacZyvN0FFfk9BkpsTKu5j4z3aMjoydPu4dF3XCZM//uJJoSFtWWUeRC3gp2HyfhqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IICvjmQdZD1wP2l3m2L82yUsLZDtqvQt/2KRbntGkhE=;
 b=dKKVKKeY6O5H8ddfI7RZs06tkpAjZhG4/rQzo1a80FmZnlpttZjIpkGwfvSQmeGJBPHnxM6uuan1an2ajdgApdVhjPpBQtJt70OZ5VtwT4qGrWgwEpLiCC5pan3LNXUpWHtOcL9VZKvLkpNciQkWvD3FAEe+cJKCVxxqgBsOEJU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 16:45:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.034; Sat, 16 Dec 2023
 16:45:45 +0000
Date: Sat, 16 Dec 2023 11:45:42 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sunrpc: sizeof('\0') is 4, not 1
Message-ID: <ZX3UNrHBYoPaPRWd@tissot.1015granger.net>
References: <170270083607.12910.2219100479356858889@noble.neil.brown.name>
 <ikgsiev777wvypqueii5mcshrdeftme22stfvztonxbvcrf35l@tarta.nabijaczleweli.xyz>
 <170270600360.12910.7954602598238459243@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170270600360.12910.7954602598238459243@noble.neil.brown.name>
X-ClientProxiedBy: CH5P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acf3f29-50fa-4295-af21-08dbfe567316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DRrEH4DvtjaA+YaVy7udXthIzl5i4xqowJ2NFVqStEUBMyXEGSSskypmnp3ffvVm1wZy1Zvs15ilIf498x/r11/8MhcvcryAYVANJIdxwjh7XFvqbkYtR2QVxTi/WLD7/WG9pEuypdXC1ipPAvXyXXhi6LcT99e3FcOnMFHk0M1+9hy1dvZZHyom+9vrp0Ei7csUgi785btML6t41Ba2HizMhdqwBeml8xwfSHvDRXGwj33Ek+Kk7R2uFmXdMhIE7CCeJG2d8G7jDQq6pGOilrEZOelzchymph0RxBy30dvXKLr5i0Roj1636ppg3qWlgufTryxGe+15LNhs7uQBUhjgLWYgEy4La6+m5TyRLNFQHsJiK1g60D5R64Z3khzeBKjrYfI6/09zTxgFpLMhG46hUd5u8tVGrKar4AIglKZabpSl0sP/mmrNRspCaVnzcB4SVPhtBwAxJa1GxqxOgUUi4AheMguQIQz1fdPmzjnaHoxBrTHoZvruTQeh3y3SFispKqKhxO7wIMZotwp92Gh5NMHhjMjD91JgxC6UIDlqQKcHbLzognLLzY3BURYv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(66574015)(6666004)(6512007)(9686003)(6506007)(83380400001)(5660300002)(44832011)(7416002)(2906002)(41300700001)(478600001)(316002)(54906003)(4326008)(8676002)(8936002)(66946007)(66556008)(66476007)(6486002)(6916009)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZTBjTDNwQXZSSlFtT215QkVlL01JTHJMc0wxMVFObjdoS2UyVnUwUFR5UHFO?=
 =?utf-8?B?QlMycXJVZVI3eHZielVteEJuejV5Y0F6UzV3N1RBZ2FsajlsMEVYVkJHakw2?=
 =?utf-8?B?bVJ2cXEwQkI4U1VBRWJDeVpSNDlTTFM4b1BBODcwdDB3NHVSaDZPY1N5V25z?=
 =?utf-8?B?eW5RZzNCZFk2NlBkd0xQUnVVVERRN3F0d3RTYklUNXQzSXdFdmhFbzV4WWRN?=
 =?utf-8?B?dUg5eVlHekhwUUExaVlNRWJqUU0yRUlXZG9TcVAvRnAvM0lzVENNNXoxNDhi?=
 =?utf-8?B?cFFtditDN1c2cWk4UWNGNUJ6TEZSVnhlaE91MjNUQVhkRU9PUnErejFMTXBH?=
 =?utf-8?B?SEtnMzI4UEE5TFVTY1ZXeHU2OFdrc2RLZWpiN1dqNHNCKzlQN3B2NnFHM3FG?=
 =?utf-8?B?QTVCREVUZCs3dVRaOCtkSnlzQm5Ea3UxUEFtdk1oV1p1dk9mNzFQZktpV0hr?=
 =?utf-8?B?ZFZUbVU2UmMxeHBtdUpDNjYyOUxKejFkVUlqVlFZSUlIa1R0MExTL0pNVVNw?=
 =?utf-8?B?UTh5TmlDVW0rU29WMGsvaUFTTGJiTEUzd3VzbmVqdW5ydG0xSWJ3ZkhSY2ds?=
 =?utf-8?B?cEhCTWNnL1YzZEVla0RXanR4bmx2Q0pkUk82YjlwdC9KMk5Cd1ppMG1hSXJz?=
 =?utf-8?B?NDFCN3h3YlFoR1cwaHZPdmR4WmlyQURzUEdnWVE3aTNNRlN6S0cyR3cyOWZQ?=
 =?utf-8?B?ZlBXK1duZnBqWFNVdWR0T2pwZ2lzanNuNGRUdDE1aEs3dEM4NUM4UHArTmM2?=
 =?utf-8?B?R25veUllR09PWHFaVEI4dmxhdjZKNlhRMDkvZHpZdUF1MXgwcjVnSjZDa1ll?=
 =?utf-8?B?bDl2aDBqUFdXRHRDeXhhMnNONnFvUkZoUzg3NEhFYzJjbUhGQzVUQzZVMUhs?=
 =?utf-8?B?azZ3YW9hOGJLNzJrTHlsMnFGbFg3VmxiV1Bta3NqQnp6Z3VGMVBxcVV5UVhH?=
 =?utf-8?B?MURlTVJWK0pkb2FPLzR2di8wSXd5dEpHcXpURFo2WDNZVWJYR0VpVjgvQzFq?=
 =?utf-8?B?aE1UcTRBVk9KaHlpSXZ0RDRzRWQ0T2xzb29TV1NiNmFUdHQ2cXdoay9XY3Vz?=
 =?utf-8?B?TTBOQ0M3eHBIWGVCS2lYdE1pWFBqd1Jpa0FpVFF6VGJUTFVwYTlzWS9lZ05Z?=
 =?utf-8?B?bWxMcTNUaXhDamovb0g5aUNjRGkyRDg2b3UvUGhWM1pGcmF0Mnk1NVg2L2J6?=
 =?utf-8?B?MzVBRmthenc2SUpFK3RKRXoxTmw1c0Y5UGh6cXg3NHZndVFDZEczYklXUGh1?=
 =?utf-8?B?R29OWDN4TS9NeFNoR09aZDJZVmNvVnltM1A0SDFMa1NRV0VIODhUeXprSU96?=
 =?utf-8?B?eVRON2hneW5JRFU3YUgxcU15VDBjZkV1dFd5M093c1ZOY05HRW14Qzg0cHM0?=
 =?utf-8?B?b2ZiVjVEcGRzclBmaW5yOWNFZ1kydDlyNVhhZSswelA5U2ZZbkRIS2VDWEM4?=
 =?utf-8?B?bHpYcHpmc3d3MUtvczJ4N0RxdG13KzFnZFo0VnhrTFhnRnpJbGRjL3RHZTBF?=
 =?utf-8?B?UXhZSjQ4c1JFcEt3SmhPUDdTNXg4TjRTUXZib3pVNjVXZEJTQk5wZ2dsNWtW?=
 =?utf-8?B?TWFTL2FwNFVtT0RDWElkT0JZRFVEaGZkZ3k0QXZoT0QvaTN3Z1dKNHp2U3A0?=
 =?utf-8?B?MCtRVURHai9BdE1RdWxXVkJlcWZrMU5jdmZZT05rMlJBVkRIR0pQbmxCS0t6?=
 =?utf-8?B?MEVmMWFyRjArTzBGaTBRZ2pzcWFUYkVVT3pJN2JvYkcwb3h6YWhOVFR2Z0tK?=
 =?utf-8?B?Wmc3S3pod0x3bFcwUGxQRURlQkx6Q055TFNreWcyVWlNMkVyb2plT1RpdWp1?=
 =?utf-8?B?SHVGaUlqdklpZXRXWUJLblVBNjVRK056ZlRTdW1DWk5jOVY5dHcydEZOM0tN?=
 =?utf-8?B?TXdqUk8vSW83Wnc2S25DblVvV2tFRkVaa1VzSm92Zk91RnZZVDhQaDQvL0FX?=
 =?utf-8?B?SWF4NzNVcWMySFFTNUxtZ3Ewbi8yZ3pEbHRJVDhpRTc3Z2pUVmtOVWgwSTF6?=
 =?utf-8?B?YngvOWVuK25GbkFIZTZ4L04zWEhYM0Q4UTNoTWhhOEYrMEcwUkM0S0Z4bjZp?=
 =?utf-8?B?L3VCWWVxbzRENFhwU3cxcFFKbGFZQVNNL09od0J4UTFQODgyRjRGQVJUV3JP?=
 =?utf-8?B?c1ljb0dXVWR1OWs0a0k0WUg5bzluSzlPdWVWS0RjbzVOQlBaT2lrTkFONG12?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vfDfKqxP62DN1fyJsbBp/s/kJTFWslksh6LffSFOT23z7aCuiH9eWa51DRY6Rz4rvIc0tT4Pdwu1AFX5BNIL7GJVkqdYtg3fdt9KFo4cqPJjRY1dEiHZNEx38IAv9hLfN9Gv2uAtKKXo6JYCaId9tdD3+K9o8T0d8UnAKRhPPcGVLAAYut/u7c4l3F805OFU8bcUanYoP++OLEo3qEKKCpcUVn3jfdzqHf03kilTVTDKs0BOLLVMbBAbsKijY1IOM/iAWhJ6y1jCzQb3O3Dx4OXp4YE8/SwxDm3ntz1nnpjNEkRXrXEVzjJ1ufobcuw9C6qaaBSvIAclFSZjeiarXFWODAFGqWfmXdaQM8JzPCi1zxMhY71IVwRM32F96pqLriRm6rpk/IrcKakKF7AD0wOSM23Ym8QiUTMgt3k7eVnCyT5Q0UR6iAKSfhmhUwEmdA90VAnZQT6L/j2vfUrmExr45y99FmV0QyvoUvBYnn13pxtWEHfUBLntB54lhii08RYPgf1M9o9O6i0NZ1H1xu537Z8ZNny88hDKQk8a3tbeWVN1H7U0aCPXMw1ig8YqWhAyLn8onYKhVonx6LjkdqgzHAfA5TELl9jSRQyrG/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acf3f29-50fa-4295-af21-08dbfe567316
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 16:45:45.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5peMbU1GCqidlnlwBEpdWLHeL7oVrOXzI0Uon0pjxc8IKtMrJXd678M+cd5Sl/C4Fq2WaI6OlVvcCUOsVpqsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=925 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312160129
X-Proofpoint-ORIG-GUID: dAozHRWWJwOIIZ7BIQu9nI-HF-zZSeRn
X-Proofpoint-GUID: dAozHRWWJwOIIZ7BIQu9nI-HF-zZSeRn

On Sat, Dec 16, 2023 at 04:53:23PM +1100, NeilBrown wrote:
> On Sat, 16 Dec 2023, Ahelenia Ziemiańska wrote:
> > On Sat, Dec 16, 2023 at 03:27:16PM +1100, NeilBrown wrote:
> > > On Sat, 16 Dec 2023, Ahelenia Ziemiańska wrote:
> > > > To make it self-documenting, the referenced commit added the space
> > > > for the null terminator as sizeof('\0'). The message elaborates on
> > > > why only one byte is needed, so this is clearly a mistake.
> > > > Spell it as 1 /* NUL */ instead.
> > > > 
> > > > Fixes: commit 1e360a60b24a ("SUNRPC: Address  buffer overrun in
> > > >  rpc_uaddr2sockaddr()")
> > > It isn't clear to me that "Fixes" is appropriate as that patch isn't
> > > harmful, just confused and sub-optimal.
> > I definitely agree, I don't like Fixes here at all,
> > but I don't really see another trailer in the documentation
> > or in the log that could be used for this.
> > 
> 
> Make up a new Trailer? 
> 
> I would probably just write
> 
>  To make it self-documenting,
>    commit 1e360a60b24a ("SUNRPC: Address  buffer overrun in rpc_uaddr2sockaddr()")
>  added the space for the null terminator as sizeof('\0') which is 4.  The commit
>  elaborates on  why only one byte is needed, so this is clearly a mistake.
>  Spell it as 1 /* NUL */ instead.

Agreed; if Fixes: is overkill, simply spell out the commit that
introduced the issue in the patch description as Neil does here.


-- 
Chuck Lever

