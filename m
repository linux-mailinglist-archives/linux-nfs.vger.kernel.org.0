Return-Path: <linux-nfs+bounces-1277-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1883777A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4651B287B78
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304D495D1;
	Mon, 22 Jan 2024 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DPx9EPce";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D/uaYQpR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44A495C0
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964845; cv=fail; b=DteXCfB017+RyR33Dgo4gzN8wywWbJwPwV+i3pJpAo4qdHbEK49JFPNRpDQElEVfBmWoaeRRT2qhxKVkS+XXge+31wXSLOS8Y2s3gSzS3OvkP+RQwt1TMJCYPXvwKB7/TW2b2rGlbfJlCLoh/wCzBMm+vmcspYb3g0KN3i2C14Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964845; c=relaxed/simple;
	bh=4wsCYBjDoDcALAnhrVF/If3KfAb8smZnplBOFT2CH7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eaj2i0Etgxk2yx76JkL7d2MY1QS2OpT2VpoIWC5zew3WKKU06DYL+47TQLCR7grz0AK0udhQRzwRI/Nx+2GTV+oQ957UJT/xUsu0Im7H1Yv52ojlqXyAEGYWedEFq0RYvKW89BZZiFrvkr1r+eCV/28MDXeJT9W7VsZkYP32NZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DPx9EPce; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D/uaYQpR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMopla026498;
	Mon, 22 Jan 2024 23:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZXYPHbiVxMby6YJWQb2XRG4X6szTTGKA05V8ohyIWkY=;
 b=DPx9EPceIWHP2GNR8Euk+8T5tOhUZrYRu5ImLwAPJnCqcBzOzHBAfh4PnifLE6B3Pskt
 dbuY6lq7V4NG3NJxdLS16sM5Ze7mSkaRbCRo6ZrQdUP4FkojP2d/EUJZ8GWuWEkUO9KJ
 oIT5ZdRnPuZnGcoFvq12u3pKG8p1RHe5QQWP/B9G+mRMAS1+hDp2zwiOCVmFMQhS3mlg
 HKHsJbop2DY8vm6M3leJwq+4v0zwH7ZCW1kFRuXIQO7nkXZOQQo6LT2yoS6mVW8491Zw
 eFbwiTw73z2rp2582j7wpUms3NX5Q4tiTvpCycfjkd7n5OeEMx4FtUaCVE53jF55CsTR tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79vvwjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:07:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMe7Vl016325;
	Mon, 22 Jan 2024 23:07:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs321e8jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je1PzYgqg5AXv04/IdNqwfgSqoQ/s6XmzHg2GqRYIN5Kh7twci1HqSj+AH4T4Wx9aYot4fBgnf0X46teZdp35vll9SSgxdmPBn2Abd6a1905DEzAf1RI+rnjkwHh7Yw7UuYdTKZWGZDySmYC5OVSCBDkMeJhd0WYO5qlEAAPnCJK7vf9srTB8SlGr1oCjXeUEXjXJ3rHgnGVDq2xVLXGdoOjJdCwbmks1zNP6ku0VIl91596Z3fKpq/1UZPki9fuGDK7WaGidy1TT2RLayhxBl4m8fkzOeJRgEZ8EKWybJxRcv3X9r6IRiaEeAVNUA9+dye2KdpxX7x8LMizIrZVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXYPHbiVxMby6YJWQb2XRG4X6szTTGKA05V8ohyIWkY=;
 b=Lrd8xgR4sOjofzTbNO+WJK6e6Z5YThcRMz3u9q/Px6mybv8se4QRwwGFEP9kwFZ1MXjzv/HX75JeLJKbrHCuttYiK1KBKVCu1zvJJqExEXlwQ+PEqjZr7kGCleg5Me4aA6rptAMPvDZfK72DE5RoQOJ6rmO/BpZlq22jHH04odGUQtqGL0NXk61n872oGVlygI9vTRq1bEXDmlsPBYC4JM81F5oEy+kMs9UnfmhCPJ3z284WeP+t8AJd4ECh0YT96R8dMFX6hOxe9/sq4EHaJw7zRIWixF1zE+nreKjFFTpmOX9/vMbZ7a/Ipl3O2x9ToRDgzFZNFLikH2ra1WQx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXYPHbiVxMby6YJWQb2XRG4X6szTTGKA05V8ohyIWkY=;
 b=D/uaYQpRM3n8LDVedjmJEOC6Sx+8GHldjTLE8MwOENS5XRnB4Oy2sZjbDE4XlFG3M0xupEDrt+xHBtgJqyXw4ZA6kwQCSpHc1SFYK+efeni12neV7TDD0G1NWUA61PAZHb1M3leY3NTzUJfUYBX+CawZFnsikpN3CdXXlwgkMtM=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by MN6PR10MB7518.namprd10.prod.outlook.com (2603:10b6:208:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Mon, 22 Jan
 2024 23:07:19 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::ce3:f0f8:1003:30d5]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::ce3:f0f8:1003:30d5%3]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 23:07:19 +0000
Message-ID: <324d4e4e-4685-4341-a7b7-c73de473c57e@oracle.com>
Date: Mon, 22 Jan 2024 15:07:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 1/1] NFSv4.1: Assign retries to
 timeout.to_retries instead of timeout.to_initval
Content-Language: en-US
To: Benjamin Coddington <bcodding@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <20240122172353.2859254-1-samasth.norway.ananda@oracle.com>
 <995F0BB9-C709-4C3A-92F3-5EB9710A47F5@redhat.com>
 <bdd760d9-9900-43ef-8000-0e9ce0aa8b3e@oracle.com>
 <8B835117-498D-484E-B1DE-912FBBBCC74E@redhat.com>
 <Za7x2aYNRqc3nIbl@tissot.1015granger.net>
 <8DCCEB9D-5504-4DD4-A042-61C99D22A462@redhat.com>
From: samasth.norway.ananda@oracle.com
In-Reply-To: <8DCCEB9D-5504-4DD4-A042-61C99D22A462@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3817:EE_|MN6PR10MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b30d2d-3a4f-4cf4-f406-08dc1b9ee222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	voSspmT0ZC/f0Vrn/aLWXBVyHoAjeN1r5YqZ/oWvYpwVNgXvTF22pUkqaf4hK9JcEN/HoSN+56I5ExmNVQ0PSqd8MUXyIroklERG0lE6vMjLN/4p4p21JMJsDDoAvqOvllJlscYV3GKRegI00VRfwj7cdA5ZAZMFIlEsQQnBlEW6zaK37zooZOsDpWLTegTklduH8dqvGZw/sxGpuPg2vTzt5GdhsA4sZxBkYYrj3R/humQjJ6Sqs60DflhRNn0pJ3DDGoh9y4tbH/O6xcBX2TkQcv0IZh7BLyLoRc5+mDiHdF7PlxTp403DEryXWOzQFFNPV1T5KF59V55PUpK63TmDl+f7XlIkAycFHTF+sYnQlaJtmJ+Kv2xCq0rq6fb/6B26Lq1quVEMR1BAa4cAlJYcyCExFolu+VD/lg3qz1N/y7BmrMfurCLcMVHvPu9/vkP9ppG6QV6Wq0Qq2Eb4U1WoZOvQ/shmu1/APe41IZ6ZmYWyyjs3UofnDkCDleF6LR6pXpVbta56ITCZL/qeHmPtLAuObGAOrjW+2j0wbX7/zhTB51fhG+w9u3O966KccJocJoQDvwAtg6+RwBCtXrL+YY4pcHeBByV+TUUZCZsyrEu2Q5QhaDWJvNKiIdN4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3817.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(8676002)(53546011)(6666004)(9686003)(6506007)(6512007)(6486002)(66946007)(66556008)(110136005)(478600001)(66476007)(2616005)(26005)(83380400001)(41300700001)(8936002)(2906002)(4326008)(5660300002)(316002)(86362001)(31696002)(31686004)(36756003)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUduQUdSOHk4cUJzMmVjcTU3ZlZUTloxakp1VWVMUFVON1p5cFVoVVBOZUZo?=
 =?utf-8?B?VFYxSU80Tld4a3ZGQWN4TDg2VDFUVlo2N3Z2cTB3ejVYTHc0aVh2Mk1MSWRs?=
 =?utf-8?B?UkozZGlWVncxRHlHRjNBU1dPWFBaekpKNlltRVlJaFdCRTFzUXFLd3FrcjEy?=
 =?utf-8?B?bzVtVUt5N1FKT2V0TXA4R0YwK3Rhc3BrVXVxR0Q1MFJhczdRL29KTStTOXZV?=
 =?utf-8?B?N3VGcXk2aXFkVFFjMkdpY3puVStoUDlZazVoYStaY2dNa0NYbXk1VGhqMzRJ?=
 =?utf-8?B?L1l0N1VSTHV1S05KOFJ3QlNjNXZrSVg4NXBxdjV5NExQTnFZeGJLZHR5c0sz?=
 =?utf-8?B?NjZKRTR3NFJ5L1hEQk1ndkg0UEJiQlYrZWZqck5qZVRpZWg3V3R0eklHdDhC?=
 =?utf-8?B?WEFjWnNIYm5pSGIrYk03YWJSNjN0ZEhOeFBKaHF0MjVNc0NZd1FZTnZqNGdt?=
 =?utf-8?B?eWRJUXduR204ZlcwRFRualY4dkVxMVVPdERLZlhWWGJSeDZYS3MzVTdRTFhC?=
 =?utf-8?B?MXBKWHhjTkhYK3M1NzhTWjJJaDBOMDltMWtPa1lrTFc0R3psdFBVNXVFNWVU?=
 =?utf-8?B?Sll3d2VlYlJVbjc5NXRrRDI2UXRTeUFva0xaVklQb2o1VVRkZzliS2xXY2Ju?=
 =?utf-8?B?OG9kZWcra0krYjVDZzQwMVF5alJsbmpVbjJCdXFMcDBCeElKOWRBTkxqL1Zq?=
 =?utf-8?B?RWcyNldpS0F1TXozaXp2SWN4R3BpeG14elJqU0x4RnFDelpVK1FsUHhoTUNW?=
 =?utf-8?B?TjhxejlTYlRGajlQM1IvZktxR2g1WllBc3pLWUdya2c3ajFCZlVtS0NlVVNy?=
 =?utf-8?B?MElMZFhCUTVhd2xZNy9ZUFFVU3ZWSk9tRXdCbFNoazUxbXhOV2p4TkdqZ292?=
 =?utf-8?B?NWpEaWhhS3Mwajhid0pmVkZiTS8reFk3dUpPc1N0YlFZOUgrZ2hOS0ZUUkRL?=
 =?utf-8?B?dUluQ2pOWVNUdkt3eWoxT3RrRXBLNkF5eDRlQ2JXTzdnNVFFK0pSUGxzQjUy?=
 =?utf-8?B?VlFUZWk4Q2ZEUXJlUHliRk1PM1J5SGdEZWdSaUFPSVRIQmVZQUdOSHFZOVpz?=
 =?utf-8?B?Q2tDclo5NUNUd2l0aHRORnVoTm9xTVI1UnNVRW1uSnFuYVV6Q3BjNVg2MXFk?=
 =?utf-8?B?SXFzWXhPZWUyUFI4ckNxTnlwQWlUSTNXSXZ1eUtVZ0tIOU5BYU9TY1dEcmFI?=
 =?utf-8?B?dGZJM1BCVDVmTURoNldNeER3bnB6b0Z0V01VWXN3Y29QVVdzQXdvenFNOVAz?=
 =?utf-8?B?Z3ZiUEluSm42dWdzRUZCMTRiVjZqR0JVUFA3YS9JTktIRTBvaTRJNzVOZmpO?=
 =?utf-8?B?ZkY3WUM4US9NK2Q2Y3VqTGpXU1hIL3k2R2Mvb1hwQjRob2R1aHducjNxT2M5?=
 =?utf-8?B?aStQZUxodzFCK2pGREhTeW5GN2pXRFRYcGpFNmxtNHRCNEJBRUwzaVBLRVVO?=
 =?utf-8?B?OHZGdE8yd1R5VGxWRVBlZkRmZUVJWHdZbnV6c0ZzRTIzL25JbVJzRUpjVTMv?=
 =?utf-8?B?Um1UazFzU05LTWg1UWJMV2pUZXQrLzlaUFNTaXJabisyWTBvVTNYRWUyRDNG?=
 =?utf-8?B?SllkRzRmQU8vb2ZCVlNpdE5KN2N6UFlycjVPRjRPOW80b0JjZ2REL1ZPUTQw?=
 =?utf-8?B?N3JrRTZ6QW9LYXpqM0FSbC9zcEk3Y0huOHJLc1lrbWlraDQ0enVkNk1NNTlm?=
 =?utf-8?B?SmJIc1IzQjZ0UGlseHZ1U3pkSUoyaCtLWUg3M3ovbXdXOCt1RlR5bXNwdnpF?=
 =?utf-8?B?a2V5SWU2YlRnMVk2ZUlnbGhhaG51QlMxSlIwMWJ0WGRtSzdBTi8rc3I3UkRR?=
 =?utf-8?B?NUFDVTAyMGs1cWFBcEhkZTdYL2hyREFlM3h1QjJNR25hZVliUzFsN3IzQklE?=
 =?utf-8?B?VFJESmFLdXNMekNVSk01dkdDWisvbDVIejM3cTh3Q3huNFoweDBNQTZsSUVl?=
 =?utf-8?B?Z0hoY09adi96WHNzbVlHTFlmbW9xbEpycWJEVkxKZFIwdDgwcG1NM1lNUjRI?=
 =?utf-8?B?RzJFSW52ZE91WmxIazREZnpwaHZpaGR6c2RqTWxkVUdZQ3ovYWM2MTZualJp?=
 =?utf-8?B?TE1qZWhhTHpGcHpjaHQyYlUxQ1JuNnR0UWpmTDJxSDNySEQvR094cjB4Nk5G?=
 =?utf-8?B?bVpGcUs2a2kvV3ArT1hMQ2lwNFhxMHJrOGlxeEhJSmszaFJDMW9MWnNZdDVw?=
 =?utf-8?Q?NdGQaJFCVXKON1FKnFPxrmA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nz0TkJPJ3pW6XqpVvvjwutnYL7OmCSBYhdsNC7nIO0saBLSeuqZ/fAGKRDlhk10h2CouGKN0YFcz7xjcG/A79wjHMXcvG9PCVvMjz5Dq+cgfKfrtpcFtR+zg3C8o9CKdzMYI8OpVDN0fCPm/GJZaLoU6MbRtJw8iUSn7AV8qEpEK8Vf4ud//53UF/LNd1Lnj5c1VjAs00LX6xhJtwtmEr7CoicLL+tHidC0ETNzusmMX37N/3//amayiCVpn0dMeJTeUPhKWaf0ORAmC3tABlHtlA+oymi5LiFxH/+AdjtnjAxgTWTjTLdn5RpSWG8yqkDVk/LHOqlj7N8VeZoieGaT3hHMVf4cCpPpTUnaj7Zrn0/5K81HYaeoZRMKUG6JnVqgY+rhQVrCMyvJUZP7mxTB8YLVIYSj+2+IDW3C0ag5vQt3e4AS6zRLvVXlnXGMtK8rnDV5T1t6S4AYGSwfCb1qmec7jbc6nZBwB0fr32nkhLLvhyBywyJS6+iKxrfMZlzU/8VX1Y5XBlP2m3rg5UumpaSpavGVtKsXNKMGsZo59eT8sCi6tU1Kz5e2RHXf+catMBhiIakIAOrqHPfVZhV22TObVofT+0KnaVZF5b0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b30d2d-3a4f-4cf4-f406-08dc1b9ee222
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 23:07:19.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8NCEGK1XTcdaIThH7RQzThc2A1DYiVrRDQdls13HaCs3Ls1ssLDGLLXltI5PLa+S3YAONtiWU/TYhxQ1zusD098/p/EorKLM8XNtjgDe5tGHGJ2ac41zq2apR5GC0b1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220165
X-Proofpoint-GUID: HiMUbTCSgbmznv9Lcu4sBIyvhwPUu4X-
X-Proofpoint-ORIG-GUID: HiMUbTCSgbmznv9Lcu4sBIyvhwPUu4X-



On 1/22/24 3:03 PM, Benjamin Coddington wrote:
> On 22 Jan 2024, at 17:53, Chuck Lever wrote:
> 
>> On Mon, Jan 22, 2024 at 05:46:56PM -0500, Benjamin Coddington wrote:
>>> On 22 Jan 2024, at 17:44, samasth.norway.ananda@oracle.com wrote:
>>>
>>>> On 1/22/24 2:41 PM, Benjamin Coddington wrote:
>>>>> On 22 Jan 2024, at 12:23, Samasth Norway Ananda wrote:
>>>>>
>>>>>> In the else block we are assigning the req->rq_xprt->timeout->to_retries
>>>>>> value to timeout.to_initval, whereas it should have been assigned to
>>>>>> timeout.to_retries instead.
>>>>>>
>>>>>> Fixes: 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
>>>>>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
>>>>>> ---
>>>>>> Hi,
>>>>>>
>>>>>> I came across the patch 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc
>>>>>> timeouts for backchannel") which assigns value to same variable in the
>>>>>> else block.  Can I please get your input on the patch?
>>>>>
>>>>> Oh yes, this a good fix.  Usually the maintainers won't pick up a patch
>>>>> that's only sent to the list, rather the patch should be addressed to them
>>>>> directly and copied to the list.  Can you re-send this patch to:
>>>>>
>>>>> Trond Myklebust <trond.myklebust@hammerspace.com>,Anna Schumaker <anna@kernel.org>
>>>>>
>>>>> and copy linux-nfs@vger.kernel.org?  You can also add my:
>>>>>
>>>>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>>>>
>>>> Sure, I will do that. Thanks for the review.
>>>
>>> Can you also fixup the block above the hunk you posted?  Its backwards there too!
>>
>> It's backwards in a different way.
> 
> Its an artifact of my text editing..
> 
>> And should you set to_maxval in both places as well?
> 
> IIRC it does not need to be set there.

Ah okay. So it should be like this right?

if (rqstp->bc_to_initval > 0) {
	timeout.to_initval = rqstp->bc_to_initval;
         timeout.to_retries = rqstp->bc_to_retries;
}
else {
         timeout.to_initval = req->rq_xprt->timeout->to_initval;
         timeout.to_retries = req->rq_xprt->timeout->to_retries;
}


Thanks,
Samasth.
> 
> Ben
> 

