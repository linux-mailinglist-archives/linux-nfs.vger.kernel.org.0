Return-Path: <linux-nfs+bounces-35-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FEA7F5419
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 00:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F57B20C7B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AE2200D5;
	Wed, 22 Nov 2023 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cXPYKA/1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AysV7QtU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67C8A4
	for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 15:03:59 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMI26oN001495;
	Wed, 22 Nov 2023 23:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=/nT3oa7KaG4/BJlGHlXshaWm0MFObJuwPtMlsIkmaT8=;
 b=cXPYKA/1G48UOGdefdKE9TN/aGOl5kq++iP4Fl2MuXltPo6PYyB6oRTUqB17tRbFpkNM
 TMOp35fji5mLamKbmLuTC70Mty455N9BzIlF/nZ61fE7RVNlx1b4HXhxz1oAXFDbL7tx
 1ewsfVNjZRnFjZ9DTmMnSnIvDGMzSJe4gjonPuBgTzW3QMsKeTE7oRX82Hhbkef2RWPp
 /fXsXwozaeTWm7ko5tVS36BfDk9xrZvuw0MYrm8CWH0wj8mI3MvVzzaV4bv42Pvtu6ty
 +9XcMAvZ7iFILmHdnVFEeVzuoN7iGCFCYNlTxUrymx4GKfYlvs+ioq67V4kFVrH3ahMp jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvughd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 23:03:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMLRWax023837;
	Wed, 22 Nov 2023 23:03:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq9ejnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 23:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk3DY16VxXwD87CeT/RI10XYRrIFZZ/y/HwesORoZVgZeP1JxVOZtD0Cz/0GCT3clqQAOyzkays6OHPt1oBl/91aTGKMUkXhSNVvJVHLhY7fy9SAWwXGPeqswPOtRpX/3OosOHJ42ZBDMX5tzVx4isfhABfQEx0Ve43XvXHrXYj188GxPfacoBi+HayMLfiwqoLQY39I1a4OnSsQ+zzUZxPZGVYTVzXfP7VNpoixbcfWt0CHt0JstiHdb6l8zcurGAjjEAytRKqHZ5LzSbz9RgkCC1FsT0r1Z2ndhzP/T9qkMqUHWkbqi4nbHdTP/JBbrp3dIUomX0KtDtZU+b2CTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nT3oa7KaG4/BJlGHlXshaWm0MFObJuwPtMlsIkmaT8=;
 b=Ee1quLcqEYltwGf3WiXe8eBDX//XbUcSfnj8YvWaP5UFPVCB5R5F4MHwryWyQbotWfyfj57oJeXtylrJDR/XtHieUUpomNvO7KCWZK3QP9NYA02LvB+9MhRFUumleU+QrFsrLLT7lfsI57atQYvd6PjbhXNUFFwZRAVJ+MLR1zg1grL7EJq19+vjMoWI5KrlEDL6EZEqfz5swjlEQpxbB9UB42bBhSt35F+/AZ6g804I163WVP5AmEcgQiWzyQnLWWK9tlNCelywpy0JQny4TVE9AAOR/nqbVnpAZr6TWClJtf7W7cfq0e55AekAVADR61vbP4+AKKxpQCg5l8Mchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nT3oa7KaG4/BJlGHlXshaWm0MFObJuwPtMlsIkmaT8=;
 b=AysV7QtUlNf8Q7YWhuLFR4ftzpXX5wAt+24kKHWYxg7fmNuJLcHj6cZHgv2f2kFLZodPwvkp2Lvdx4OrFlQIVAjrJdM59BVjWar+MvbjxYfvg8p3XRB13i1wd/l/9hbAHbfFQ6/lL85dVIGa5X0tRTysc1hbfCaxXl2GlH7eElE=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 23:03:55 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::6488:c4f8:43d0:97c9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::6488:c4f8:43d0:97c9%4]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 23:03:55 +0000
Message-ID: <d18ee0e1-c52d-48af-acc0-366bd27764c1@oracle.com>
Date: Wed, 22 Nov 2023 23:03:51 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: TCP_KEEPALIVE for Linux NFS client?
Content-Language: en-GB
To: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0Uc7zHasg2damr4nhRZZF7xBbFc0ghdjop87+5vHa8bBHg@mail.gmail.com>
 <CAN-5tyFBZibge52iZtjnz5j6S2GrTXTWdzaDxLVQcr+G8HegvQ@mail.gmail.com>
 <CALXu0UfiCrcDciLX5A1tvG0DiPwAXPg=GikPakKW16UhZ4X-Nw@mail.gmail.com>
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <CALXu0UfiCrcDciLX5A1tvG0DiPwAXPg=GikPakKW16UhZ4X-Nw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------38XFxOeanqVgyny2S00jvxS0"
X-ClientProxiedBy: LO2P123CA0028.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::16)
 To BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CY5PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: c13c59e5-29f6-4c58-7c86-08dbebaf4d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6GNg1cY8Nm3LobEDmAFE9azg5eiNPUEmYHEDzkwF3oygPeGWugu6LY/uHXbQLy+YjVJMF8I9bQ9iJhsHQo4zkXLCk+zX1OEXTrq1gawZSNNDQVvIzSErXxSoEsUO2NFGHvcduqoLUDEY+MBozdlsYe/5/f1yzAzP94ArP5+N4DXSJQJ6HIYXL3nRB+QmpBGAprhHJPqV7jNyiIgRsraYlgS+mSfaTEiQZBIzZ+iX43sNnnw8IR3lwRlra1VqUk3I3C/m80nwJnlp8U70u9fYRvVVstweZGcW8zUOeLXkGo/TaVcQBb6z+4tLzx8+F7QTl7KWPgXoIYNODvVW0nYvPrIV1zhE6TGgzMIJ18b8T0cFcr5U0+ilZFn9bDxbAa3P5LI0OIfqyrG+G1dutc3fNxZsc9Ny9gSnYXq4hkOQkS6T9hFJ+ysaqHvFZPQ4G0n64R1AV+BSE5ykC9I3iu4IJHy3caDgQUMl6GOjbCJDiaGWFKRAxhZ6jL9lmMyfZH7CfN9Ei2Vnu6RSwnEjSnmZbZK9OQF01iAwvf8K0IxubUAF0fXsOeazNOrIC3IDcQBbsTGWNXLKVLCCzu2GZ8TQDr4U4oAWkUFag99pEHsO0GF1Zu3PyJqy7yIOWbg07rPrl0aXLG6OXQwkUezTvv2qFw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(66946007)(110136005)(316002)(6512007)(21480400003)(2616005)(6506007)(36916002)(6486002)(36756003)(107886003)(53546011)(33964004)(38100700002)(31696002)(83380400001)(86362001)(6666004)(26005)(966005)(478600001)(44832011)(235185007)(5660300002)(2906002)(31686004)(4326008)(8676002)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWZPenBDbWFrTFVrZGo2eVVOZmowTGZ3bkdhUXhQWEtuTzhySUdRZGMzWkRY?=
 =?utf-8?B?WEtPeE14Zk9YWXg5ZmU5YTFaQzJhbXU1Szd5bzR1UjErdEJhRmpHNHhUZS90?=
 =?utf-8?B?aXJ5KzFVSGcrc0tWS1BSOUFva1AwUTFKNkNUY3RENjE2Nnl5UE1xM1k2MWFJ?=
 =?utf-8?B?TGhjQU9YczdKdXdWb29wYWpYYnlvbmFYdks3Wk9mTUwrdHE2UFFMVUoyK3Vk?=
 =?utf-8?B?N1lyUXZINlhQckNVbFNleS81V3libEpPNXZKanlBOXhYeTVFdXZDblFodDhi?=
 =?utf-8?B?aVlZZHNpWGZoaHNFMTlCRTg4OUNBRnhZNzdna0lwNWg3eWo3cGRSSmYyMGZ5?=
 =?utf-8?B?Si9jc21KWUR5M2loUWNTR2hxV1NUeXFnWHdSRFB4U1pzb1JKL21jNWxUWGZU?=
 =?utf-8?B?aHZvcERQZS9NNUdGUUlPZmd6bjRHU2xTb2Nac2tZcEh0UG5ySlh6ckpEdmcr?=
 =?utf-8?B?VnY3Vkg1VkJ2RzdpZ1BBSjgzYlRyemxWYmxVRjdQWEdBVGs0WWwvbjBSd3Nu?=
 =?utf-8?B?Um9wSGIwcklBUkEzNmplWU4wb3NXVmJSbDhGMEMwNFpycjlnRGtOQit4UEV3?=
 =?utf-8?B?OEVId0JiOFRmRE5yd0RGenhYM3A0ZXp6c0ZrUXZpMnB5MGtlMDAwTStFRjkz?=
 =?utf-8?B?WU9NbmpRUjkxMTFTVmRoanhiVzRRYWRpTm4zdndOSmpJZEJYd3lVZ1NPaDEx?=
 =?utf-8?B?VkRqa3gwdE0rVXZ5N3JYZ3RjdGVESXNqbExzUWExbXRCNmhscFpWRDRsWnpD?=
 =?utf-8?B?eXgxUThXZWZHVEpZS3cvbDEyUm85dDAybCtCZ3lXbUxidE03Y3o4a2lYSW5M?=
 =?utf-8?B?Wm5PdE0wWGZLbjQwUXFBYUxQMlRGQXlUaTZzNkhJZjBvRjE4ZGhpSnBERnNr?=
 =?utf-8?B?QjcvUjVIYkdOK1Mzck9takNvdWF0RkQxc2lZZTltTHhUeVdMbHp3ZXFZV0Y2?=
 =?utf-8?B?c05ES1BHZ3g0T0hTckMxOW5IeURraFRNS1lCWXlZcmdSQjVLeWNZSXlmdmJq?=
 =?utf-8?B?Z2RPZ1hKM21PWUZ6RUJabmhOR0h3QW1zc1VJeFZJVGd2bERYZ2trNHhXaDBo?=
 =?utf-8?B?SDlLS3JTczFpbWFLeVBaZkNXZ0hReXgzQ0Vua0JaMDgwREpKcXUvbzdQa2JT?=
 =?utf-8?B?NktnMHFwZTZRTzc5S3JxZEF4QWZRNWlYM2lGK2U2QXRrblc1eGlFWlh5N0d3?=
 =?utf-8?B?TFU2N3V3OERMd1dIcDlETytpUmxlaWNQZXNGcXplRU9ZTVBwZzJlUzdlOTBV?=
 =?utf-8?B?OWh0R3BJaGpuakwreGlwdjFraDRXcUpVUVhqSzN2OXRxRC9sVXVlN2NmK2tZ?=
 =?utf-8?B?U01NWEVIdEJkaVdaRzdhQkR5V1NtMjE4eEJBZHVFTjl4WjVzMVFUZk5zSUJW?=
 =?utf-8?B?d1ZBMm53SGcvdUx3WnJJaktnOWtFRUtYRGRudEJMS2V4UUhyWWM2azVTNU9G?=
 =?utf-8?B?cmJZY1pBUEx6cDRQWEJpUDRJbEUwYkRQcDJNNFdlQjMzSnNsQWpiV1Y5VnAw?=
 =?utf-8?B?ekZXRjJQWENwZ0tCSGk5aUVPZVVReHEvQnM1a3lobVZra2M4MkVna3BLbWVo?=
 =?utf-8?B?T1h5NUZFazhBT0NqM2p5NjlUalNLMzFjVzFEejR6RkJYT0QyS093SW9nQ2dC?=
 =?utf-8?B?dWJZcVJXZEw1dnl0bjN0TzNpWGR2WVRIdHREemFTbm8wTWZpVHV3ZXRrYkwz?=
 =?utf-8?B?YzRQbnpVTGxBY0llaTRJYURGSjByUE9KSmxJYnJqakxIZkdxS1ViSTBCaVZ0?=
 =?utf-8?B?cUQzL2VPK3pDeWNmZGJpV01UanRWMHpNa2I1K0EwRGtRcURWOTNWTzBLWUo2?=
 =?utf-8?B?c0c4U1lDRnk2bGthc2RRQ2M5Ynhid0FBQUxWay9MQmxsVStuTnNXQWxJWnVC?=
 =?utf-8?B?Wnk1dWs0dUFlNC9kTnJiMHlBZDNWVnlPNTZrYXhTdlFtd2pUVllreTNmSWpo?=
 =?utf-8?B?K29IUlowaXBJeWwwY0Fad1NTR0ovcUlVeVM4bWkzT01iTWZmVDlVOWlaUFpl?=
 =?utf-8?B?U0ZvSTdNanpoQitWNy9VOFdvZ1Y2SVl0UVlnbGJkYUdWa0F6bTJ0M2JsYjg5?=
 =?utf-8?B?UlB6Z2U2dHFKeFhqYXlBYlhXcWd3ZXVnZ1pQTW9WaGxXQ0JmOXRiQTZqazZH?=
 =?utf-8?B?ajJJVFhHZVAyNVdIcmpoYUVkbEUxYTlTOTZwOEliVGhHeHFncjErcW42QjZn?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sDZvSHjmrxVWUthPaGVHnuYqBXT85u1bjyhoxzdZRPy6Vx1L8C9+E5Cc47X5yGz+qKQDN6+iTK8ZslqcaDs6pTMa31DawlCdk31GBDFPtBKGM4u6TA7oDB119KmpgbhxsotRGRFBS9zxiknvoFXt2DAJeAfCePq5NFsLQZ5OIRZW7AAuHUxcJtXlZg/4w8S2mQ0Xmra3IgAVZ/0TqXilJSWcFmJlrQr+I7ZDL4nUDmpIhq/zZX/CJhUYJmhL9zAGVBlX9vNrRyQ9PWqDR/pQhKPv0whN8oYN1kndBqjVimxzzVbhQwA2G4tw4V0J/op6vv1wgekdBU2dLd5mXDIkjImufiIxqRniLvR6LlYWjnUpVZao4Ob2kR7YlM2+uKF4sFMH8lkKEAoizREt/2SjAuARX9OUVQ03oW4I+DactToveOWeCY2ODju82aomhf7KWMNVqTkSlILYB+XxZOncTRK1c6AUnREbJENkjbbFNKgSkZIT0R+V73uZnl3Eh9xqj4H+oBR3QAmEo0zP+pk5PuJml8TPP/J8AjzyI3/WjirHrpCE4I1BMLsjAqFbjFIB5kQV4IExpyzkVXFbFR2PS9cEBOSmGCMFsdsa7CcqSl+JGFACjl8vyF4jP5HBBokdrnLHctCONH2EypTvbtt+9B1sPVZAaJ01P/WNtSVuH5f3TxKIzc3BJNjmXLGj4IsTfalDKElcVLDdBxr834cu9jYZbxtLi4+Tiopgc9pYUfb1P0GBW5fevuPmFNJs8xfSXrTf0Z9Zo5EF/9v7Ta+PDBbJfwbRQVBbDSZZn/9CyM4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13c59e5-29f6-4c58-7c86-08dbebaf4d24
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 23:03:55.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTvGIh+zwySIAC282cfYUJ4R6F9a0cP2+M3Og51jQTXXuk62RgHZ6+YTAwjLh0leHlLL6AWoP68xvxfwbPKetA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_18,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220169
X-Proofpoint-GUID: pmo7GijpjAhPeuTeYiZByJqOE24e7pEA
X-Proofpoint-ORIG-GUID: pmo7GijpjAhPeuTeYiZByJqOE24e7pEA

--------------38XFxOeanqVgyny2S00jvxS0
Content-Type: multipart/mixed; boundary="------------ZaIkoylRWQWxOtZbaQywB30w";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>
Message-ID: <d18ee0e1-c52d-48af-acc0-366bd27764c1@oracle.com>
Subject: Re: TCP_KEEPALIVE for Linux NFS client?
References: <CALXu0Uc7zHasg2damr4nhRZZF7xBbFc0ghdjop87+5vHa8bBHg@mail.gmail.com>
 <CAN-5tyFBZibge52iZtjnz5j6S2GrTXTWdzaDxLVQcr+G8HegvQ@mail.gmail.com>
 <CALXu0UfiCrcDciLX5A1tvG0DiPwAXPg=GikPakKW16UhZ4X-Nw@mail.gmail.com>
In-Reply-To: <CALXu0UfiCrcDciLX5A1tvG0DiPwAXPg=GikPakKW16UhZ4X-Nw@mail.gmail.com>

--------------ZaIkoylRWQWxOtZbaQywB30w
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aGkgQ2VkLA0KDQpPbiAyMi8xMS8yMDIzIDEwOjQ4IHBtLCBDZWRyaWMgQmxhbmNoZXIgd3Jv
dGU6DQo+IE9uIE1vbiwgMjAgTm92IDIwMjMgYXQgMDM6NTcsIE9sZ2EgS29ybmlldnNrYWlh
IDxhZ2xvQHVtaWNoLmVkdT4gd3JvdGU6DQo+Pg0KPj4gSGkgQ2VkLA0KPj4NCj4+IFdoeSBk
byB5b3UgdGhpbmsgaXQgZG9lc24ndCB1c2UgaXQ/IEhhdmUgeW91IGxvb2tlZCBhdCBhIG5l
dHdvcmsgdHJhY2UNCj4+IG9mIGFuIGlkbGUgY29ubmVjdGlvbj8gSSBzZWVtIHRvIHJlY2Fs
bCBzZWVpbmcga2VlcC1hbGl2ZSBiZWluZyB1c2VkLg0KPiANCj4gV2VsbCwgSSBkb24ndCBz
ZWUgYSBzZXRzb2Nrb3B0KFRDUF9LRUVQQUxJVkUpIGluIHRoZSBsaWJ0aXJwYyBjb2RlPw0K
DQpXZSBoYXZlIHRoaXMsIGluIHRoZSBrZXJuZWwgUlBDIGNvZGU6DQoNCglodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL25ldC9zdW5ycGMveHBydHNv
Y2suYyNMMjI1Nw0KDQp3aGljaCBtaWdodCBiZSBpdC4NCg0KY2hlZXJzLA0KY2FsdW0uDQoN
Cj4gDQo+IENlZA0KPiANCj4+DQo+PiBPbiBGcmksIE5vdiAxNywgMjAyMyBhdCA4OjAy4oCv
UE0gQ2VkcmljIEJsYW5jaGVyDQo+PiA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3Jv
dGU6DQo+Pj4NCj4+PiBHb29kIG1vcm5pbmchDQo+Pj4NCj4+PiBXaHkgZG9lcyB0aGUgTGlu
dXggTkZTIGNsaWVudCBub3QgdXNlIFRDUF9LRUVQQUxJVkUgZm9yIGl0cyBUQ1ANCj4+PiBj
b25uZWN0aW9ucz8gV2hhdCBhcmUgdGhlIHBybyBhbmQgY29ucyBvZiB1c2luZyB0aGF0IGZv
ciBORlMgVENQDQo+Pj4gY29ubmVjdGlvbnM/DQo+Pj4NCj4+PiBDZWQNCj4+PiAtLQ0KPj4+
IENlZHJpYyBCbGFuY2hlciA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4NCj4+PiBbaHR0
cHM6Ly9wbHVzLmdvb2dsZS5jb20vdS8wLytDZWRyaWNCbGFuY2hlci9dDQo+Pj4gSW5zdGl0
dXRlIFBhc3RldXINCj4gDQo+IA0KPiANCg0KLS0gDQpDYWx1bSBNYWNrYXkNCkxpbnV4IEtl
cm5lbCBFbmdpbmVlcmluZw0KT3JhY2xlIExpbnV4IGFuZCBWaXJ0dWFsaXNhdGlvbg0KDQo=


--------------ZaIkoylRWQWxOtZbaQywB30w--

--------------38XFxOeanqVgyny2S00jvxS0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmVeiNcFAwAAAAAACgkQhSPvAG3BU+Ik
bQ/9G2v00EfSTF31pHijvukU2JAWL7USuZw26gbcnYkbIwIyztjWf2ngIoGu9fRjQF7pJAjaNhTs
vwkupBmIjCXS9jiaRC9JibGrdhqWzW3dhGJjpzgxOsTfxURMPf50vIA1i4EFaxz2hij3V/qq2ewH
YxsCpA2wQC0JANIepVkAoPIOO46YDkqlqm0BGNrGkt4l50FCACy2rEjBPMfPjuw6gjJUeJYEi630
2nLRvAwpk6XOP8Dtsrh3VtomDmbDywVIIoC2k0xHKcAu5GzKBOgrbnhtP+Ua2PjGkJhq2akkpiiy
N9YCuUsg7IeQxpZMY4zzwSDjXqEgaNV0HMq0uFsK6LMI0Ry2W4e91X+kYjqXRScwZkv4Yc/eHhdj
F7BcikJ9AV4IbkjmQ9bybVNdiaV/SYAMvETaVH1jNgNMThMM8IQZ3KA5CViPneBdNFPkw8QscnJb
rCWx3ZwyfrcNmpGn85hj9XY04G8cwOmP+uMMGDoT+uchjMrb3MT9ImAY7sLi1UUW/98+Lqn7u4jY
813/t8oDG2p+zYqA8vnjm8oRwQs+v3AcCj1C4t2k7saemUBqzXYdNHhBLnBh4b2pLiX0PM6L3WTa
1ImhkVQx+0C+HzLYrmbxIPr/vLFFZ3AHi9tQZGhboySxSwLXmIiokdIqYyZYOt5bWK2Au8n5v8ku
64I=
=xvoC
-----END PGP SIGNATURE-----

--------------38XFxOeanqVgyny2S00jvxS0--

