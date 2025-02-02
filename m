Return-Path: <linux-nfs+bounces-9829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E4FA24EE8
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2025 17:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307471634C5
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2025 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950917C91;
	Sun,  2 Feb 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U6SzdgnA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ei6QbJhc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75982184F
	for <linux-nfs@vger.kernel.org>; Sun,  2 Feb 2025 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738513163; cv=fail; b=A7IFKhaKDtfOLowpM6MPNCDlPbkjMv/W8qYlQTN+AFgFScNcInYUnpcQClIslfUja00md7jHT4ICtHRMcdDXLRdznVUbt2hfqQbPxtY9EKDSnTv+32hmOqBlh1j+BU7VbDF/+Rz1S5izENljwcej//uapEKrrfmxDb4tcTNjUSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738513163; c=relaxed/simple;
	bh=CG8KImv4Ht13b/2w3193KgujXlMyx4Dr9FGolMYsAN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PhRpfTz1Oj8sI/ZD7Iyoyt34bap5pA4Jdq1EKOEo+O+F0OcdVNCpPjjozFQCOw01zUA56w6PyXC5TOLazWgmf+gY0bUREoYgJPulmTOeLd5xQBFUqxUPwdQODHkUaxpAVAnc9YpqBmlSErUQGSUcs3EHuRpDdRI5kmGDNcnydA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U6SzdgnA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ei6QbJhc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 512Cww9h010836;
	Sun, 2 Feb 2025 16:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HxyFn96uIXgkoFa2l7VpZoqDOxvJMAoPha+r4cd4nNg=; b=
	U6SzdgnA5ZFfGCZNJkU/RPoAqp6KqK3O10/V1BCEoSyz/GXRPIn0U+VHgrjM1BwG
	ZuOSi35ghJZuOcJq047HNr3+rUMtipQvV3Q75YVbZt1C+p/qYFo92iYueXDQ+qMD
	xmWmtyhfzZUi79aftEBe/x96ueC6liyK6M/vpQAU1U10z+xKD+QXXiCqB25CubNn
	ACYOj3jIZkhRb6GikRZL9gHtaLWQIWx2kv9IpPpvxssWJpzLeAHxgJvQBC30vZnR
	6yHKbm/TKEbLMtXfCDbWq2rSYujI0WG8V6lLs/LsxvVzgLEyCHyfxsLLXWTMfWl3
	v8SnyEjxBLu90jseShkj4Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hj7v14ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Feb 2025 16:18:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 512CA2Q2004883;
	Sun, 2 Feb 2025 16:18:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fkud4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Feb 2025 16:18:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEM5z+pZzicAVRbWEYcsuP6+vdkqss2GoJHfGgTV9RDMgNCQneJpzG3XUb885WTHh5PwRbIuPQVUIrW6l1galMv0qoXRIBbrYGTDCI1TArtMyJGacjrr7dnvLSiggZ8pQl3NVple/M0mILniASsQXAerIWE+ypqMRucNZ7FNFMi/kPjILoj+NJR3B9eaga9IowW8rBUetyHOjjDNpXeUsZLz2PXqmj+0Ci/lNtVLqC3+TRkpRurJ6Speelm+7gsV6lDDbcjgoqog0ovmJa0iogzYeLu83SKDcZQ0TtSiTxX2oayyphOJ8RnzrThVjUmsoelCFBXkqkP7wxfo35z63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxyFn96uIXgkoFa2l7VpZoqDOxvJMAoPha+r4cd4nNg=;
 b=pTyBpX7rKG3fvGAzdehORYN4gGAkx6cPHm8E8IX7c/WieZ8nMSxMcyPeXnkQOU6JDuUQdBro2CgaHON0V7kaIqIPnRAEt1v/Ox8hW0+3nwfxgixV/TkC+xT9n6GJM99i3VAZIsubonzWDGHBjxoI5sCd02dNcH2Z2fGjgisXCq1nKKazUcwixnX7dnM9ijcsvFzXeUHZ7TY+or6/biciUc6D5SHhBq3hPjAn2UkGeWK47pUpzho3W+1eI2Og1Sji6hy0mAiwSXQPKP7BxZq71GzhZmXLMQwHiDd+s3X/d15iz3yZCdb3vhb9tfYlaDIJW0uNoYYuDcxiE93IuC6dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxyFn96uIXgkoFa2l7VpZoqDOxvJMAoPha+r4cd4nNg=;
 b=ei6QbJhcNpHNEkeAbH4GwL5XR7pLfUU99kcyBPRG+k/TSmLI+AN5T7kyhkXtLSJoP0lvVWho7KYQemabxKeA32p7zhxDdVsH30N+qAW/jliIqCKAHhnXb8XbReTiRRvLhmOOpVTOqToaZD1k3JJaNrwAMFO4oo4i35Qw6x8FFks=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7790.namprd10.prod.outlook.com (2603:10b6:806:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sun, 2 Feb
 2025 16:18:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.021; Sun, 2 Feb 2025
 16:18:52 +0000
Message-ID: <196a87b2-94ce-46bc-b6a0-c9c65f4ab34c@oracle.com>
Date: Sun, 2 Feb 2025 11:18:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: `rcu: INFO: rcu_sched self-detected stall on CPU` and spinning
 kworker `rpciod`
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "it+linux-nfs@molgen.mpg.de" <it+linux-nfs@molgen.mpg.de>
References: <76a841e5-4e3d-4942-9a4b-24f87d6b79a5@molgen.mpg.de>
 <ZqVjVEV5IF_vz4Eq@eldamar.lan>
 <47222A7B-6B89-4260-AA16-EA7E7EAFBD68@oracle.com>
 <ZqjaX_uJqsJiCpam@eldamar.lan>
 <7ccb2a39-bb32-47f8-8366-b4d09895593f@molgen.mpg.de>
 <ZsBhuwLnejLo6iip@eldamar.lan>
 <6BEEE588-B7B0-40C0-BE91-4919A71ED052@oracle.com>
 <Z5z3hBaZtUM0BQ1H@eldamar.lan> <Z590k-vpFiGl0OOZ@eldamar.lan>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z590k-vpFiGl0OOZ@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0392.namprd03.prod.outlook.com
 (2603:10b6:610:11b::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f806814-91f9-440b-920a-08dd43a54863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1NId1JWcmQ1dnhnUko4Yk1uTGY5M1hadFdGT2d2bmtOYXZYdG9RbzY0cG83?=
 =?utf-8?B?R0p3SUlwSVc2U3ZnQ2RDZGNta2MvZkF2ajhaN1JtUE5OaHZTeTMwOVdBRktp?=
 =?utf-8?B?dUpQVXN1NUVOdHdleHh5ano3eG0rcHJMbzF1R1psOXd5c3RTVFZTbUI0a3FX?=
 =?utf-8?B?cnJuZERVVkVLbkNWeXo0cDBERm1hc2JBV2M2RHZpekxHcVZnVDJLTjJZTlhx?=
 =?utf-8?B?blZkbEdDcmR0djRGcmp4ZlRvYmswZTFBendLTzZnd1ZTM1hzb01vdEVoWkZz?=
 =?utf-8?B?VlBvQW1XZklKRk5acWRJZURLOS9aaU92cld4MS9iQzBEUVdYMUFCcFpRcUlF?=
 =?utf-8?B?WkdqbnArZGtCTDJrRWN6cjUxZTN4dkVGSmZNVE8rYlZOZzVRUDhLUmIzRm1F?=
 =?utf-8?B?M2EwVERWUXpHeVcza3FET2NwRi9vRjd3NE90Y2k0b2tOYnMwYW83NDNZR0VX?=
 =?utf-8?B?RkhCV1lsaDVtSDBHSkU5Z3dHa3c3VmcyM0RvNDRoVUxrMHBvVE1Qa0VLMUZG?=
 =?utf-8?B?RW1VL016MUZJQXExTzU0cHkzZVVJdnNBRjF3dkozSGs0Tk1uSjFiZWIxbjdq?=
 =?utf-8?B?aGx1OVFEM0lQd0I1MUlnL2VieDVTeHRTZEd5akNHQWJWQ3FhVEZDTThzU1Jk?=
 =?utf-8?B?ZG5UdDJsMFZxNVFiWitUSHgvd0NvK2o1cWRMaUVwUlFybkFudUFKMkJ6UWtH?=
 =?utf-8?B?OEdwN05scWwzUm1IMFF0L0RtQ2lldHdRUzk4dmRRLzRVVzVZQ2hLejRqRk1G?=
 =?utf-8?B?cUg1dXdqNTkybkJscWVYcGUwVGxudTdpU0ZiZ3FjeUFEbU9PeUVDaDZ1dkph?=
 =?utf-8?B?YTBDNzVaM1dsODBwWVB1NHN1UTBCQ3FrOG9XN2JJenFSanpya3EzODQrVi9j?=
 =?utf-8?B?WGx3ODd5RFk5ZzdWb1J1eUFJNHgraWU0NmJSZ2ZqbnZzR1c5VVRQRTlwMmxY?=
 =?utf-8?B?cXJDdWdZcnVObDZvdzVKVjNSdU00TFZubkZGb1hHVlhpQlZtZGE0MlJpdlAy?=
 =?utf-8?B?c1lvdWVkRlVwbVlSUWpsVDlKM0VQZ3kweFFtQkVkN3BvbEdiR3VmZGlKTVRB?=
 =?utf-8?B?bURMSHl6eWhTTEhTbzZ4UUxaVUVRNzRSenZLSHJsL1pqcDRhOS9xdWhxSVFh?=
 =?utf-8?B?MmhOcVI3WkUwK2hTZzRxN2swZmZPTGhnYmN2ZFQxVVdFSUU4RTM3RTBPSk9q?=
 =?utf-8?B?dEhUQXVFaWJiTzloSytrUzIwQitSV3dWTkF3UGhVWlRmSHo3YW41ZUdkRnU4?=
 =?utf-8?B?cEt6MjRSUFZrOFEyS2FkMGdKM2txdGE1NGVKemY4NTJQb0EwY1NZY0xkblJL?=
 =?utf-8?B?TlUzZHRqSy9hdEJVRUVzNU03ekh3Y2gxekZIWEZ6d0xuVjAxRTh5MzcxVTlD?=
 =?utf-8?B?emFOWlNqSXBKbjdsV2djTVlkUFpwOGVBQzlPVXJMd3ZDYURTNzJjaFdMRG04?=
 =?utf-8?B?T1lQYWs0RnZxMEttNzZXVDFrN3dzYmVPSFNXeWorY05BS3lPUy9uQnZGVnY1?=
 =?utf-8?B?VVdwd3QxWjhHVmZ6R1FvUnZ5Y2ZZZmRzSkNITDRBa1I1UnVLZ3ozS3ZJSEpS?=
 =?utf-8?B?eWcxMVN6RW96MVRka3hoeGNGTHNIK0FweWxNdVpwcEhIQlR4S3Mwd3plTEVv?=
 =?utf-8?B?am5KVEpDMDlMblZQVGREUThEaG56SGJ1MGxQQVp0Y3pyTjVnQzBKYTJpR1Ex?=
 =?utf-8?B?N2lxTWczRW5zOWp2QkxTRkg4ZWFUbGVYZm55M0l3WDluMlJCRms3MmlMSld3?=
 =?utf-8?B?RnRCMCtRbXdkT1dxTEtYeHdWN2h3RUNjSTE3UDNYaHQ5WGlyWmdDUmdGQzFD?=
 =?utf-8?B?R0NaWnNsMDFCZzMzL296SEhzS1p1MUV5dlIxQXcrVy9UaTU3UG0yMGxJTHdS?=
 =?utf-8?Q?dQRZv0l1CZOSZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXRIbXNYZEovN1JEb1FtdWZYcjdjQmRKMW5NL0pRbHJZajJEVFpCZzRkaGxa?=
 =?utf-8?B?VElTZFRNZDJjWjBMNUpDSlRwOVhDV3ZMK24wTEE3M3NVZVhyeXpaQzZvdEZk?=
 =?utf-8?B?bU4ySURrMjhMRTFqWTNqWUdUY3VZbG5KelR4eGFhUzlEeENlTkpoRlBLNmdt?=
 =?utf-8?B?TFRFOEM0ZjM2dkhES0NtREU3VEdOUGhqZkVoYU1iMkZvbkZMTzBISFVqdDFS?=
 =?utf-8?B?V2N5UVdIeGpBWkhMTmF4Zi9HNklMZTY2ME5pK3ZvbU0raDA1V0R0UmN4eC9x?=
 =?utf-8?B?ME1zdEVFNmlNU2J0RTQyY0FwOFIzelYvNWRCOTN3dE5MbXk1Ni85dWtYbEpt?=
 =?utf-8?B?RzlZZTlLWmFOTVRpVzBiLzN2NGtvWUxkOVJSYUdVRTluWXppWVpaZUJLci9T?=
 =?utf-8?B?eW54eldEdDE1OTRzVG9ValJOcDljOXg4OHpFSCswNFE5UkM3YUlkZTl0Wmlo?=
 =?utf-8?B?Zlp1eUVvOXNpaG5DVHZENzVRNkNOQ1AzS0lLb2ROL2Z1eHFJRWdJSmNvOVE4?=
 =?utf-8?B?RG1mbTY1MUhPMlNHcXl5M2dLaDNwMHJmekJ3VlhZQXZLNDBVUGFaUmJZVW4w?=
 =?utf-8?B?RlBZMDZNU28vZVpvdkVGVldPZEJneDgvMlgyaDIrRTEvZTVtREd4dzdsUG9z?=
 =?utf-8?B?bHJXSzNhaDhLd0lPT0I3WmN5akxiSE1oN3dSQ1FZK2xDNnFlTTBnSGh2YitT?=
 =?utf-8?B?b1ppREhhbGhBYlNBZ0FYeFNkcWZaajBRQlBGYmVXSmJPMGplVTdpWStBNlhN?=
 =?utf-8?B?NXM0RWZ6WW4xQURONWRhTm5lR2czNENGcXdiM0ppTzhpTml4aEZ2OWdDUmxD?=
 =?utf-8?B?WGhoclFjbHBhbkhQZjRMWktPVW5TVVNpZzJ6QW9naUF0Mmh4QkR1VUxtZ3Z1?=
 =?utf-8?B?NDdpRUVBaGx3T2Y2M2NEQnJFN25lTXVIaFpCektJb0k3VVlVbjMwbjRqeTk4?=
 =?utf-8?B?VVFUNWRrVlJHWTZnQjU2YmYrNFMyUXN3bGp0T1ExY2FnMUE5czl2aElEb05Q?=
 =?utf-8?B?ZmZHQWl0K1FaaWE0b2ZQS25OR1g1SFFCdG5CZXNqalBkV2xzbzRGTDA2Q25i?=
 =?utf-8?B?Q2QzbWhPUUZxZ3NYN2x3YUpMbU56NlplNFlvc2huK29XeG9nRXdtekQzeXRt?=
 =?utf-8?B?U05IM2RaYk1xTG9XQ2tveFdibDVCdjVVTE1ucTNOOXM4UkVqN2NjTEpNblNm?=
 =?utf-8?B?SW1KNk5ERCsvc290TXNveUFYem9hc2tqNStDSFhzN3k0ZGplcUxXYSt6dkt1?=
 =?utf-8?B?TjdxUDRuSU1tV2x1NjlqMEhOalpZVE8vVEJRQ2NHRWxwL0ZUNVdGYmhWUUdW?=
 =?utf-8?B?ZTRwcE5mb0VYbEJ3WHpTY2ZjYTRXaTZOUzFFK0ZiOHR3d1hWYkFTRnBtODV6?=
 =?utf-8?B?OHpBUElJelA2VzJ3b3RDSTJWcHZKdGZEdEdaNCtHSHExQXorb3VBa2FXM0hU?=
 =?utf-8?B?YThtSWlHN2xCQmUwSTMzRDZaTCt2NHJMb3dwZ0JhcWFRMFRZQnVoL1Nxck9U?=
 =?utf-8?B?ZVJsNERlRkZzTzZsaGlxcXB1YWZtV2JtNFgrSU1mYVVBeHJHRFNhVkZodHg1?=
 =?utf-8?B?UGdvTG9hT29NOGpBRk9iWFc3Rk91MlBlZmZIbmlsN1NQR0NzZEN4R2VFU1dX?=
 =?utf-8?B?dGFGZWQrb3JENElKZUhRZm1qbjd6TWtVZ01SeERqVVAzb1VHc2xqRS9ZOXpF?=
 =?utf-8?B?Wi9CczZreHZJbmlKbE5iemFKSVdrRkhFOWNXcGtiYi9JM3JMZmNZc2FvWDRF?=
 =?utf-8?B?V0F6M2p1UTBGZXIwMlpEalZuNER1aFZCYWovTWt5eitCWmgvVVVYcjd2M3p5?=
 =?utf-8?B?OHMzZ2FIWFRXblBqWmxGRjNHTE5ENGR0NVVsTy9HVGh3aVhXUnRhTGw3NjA0?=
 =?utf-8?B?YzlWVEtkN0hWL2dzTG5FNW1CMlM0ZmRzKzRUa2NnV3pHeGNWZndhZVBNMmFY?=
 =?utf-8?B?TFBwSDlTVmdiMkd6WmoxanNINnhMSnhmTlRZNThuVHQzdktUQmNKOGxEWHRG?=
 =?utf-8?B?bjlrajE4L1dWVWNYY1h2djBNL2NxdlV6THNwVVNxSGN0L2tmWitrZUliYUtw?=
 =?utf-8?B?SkRSWkszTWtTeE1mVktMYnhZQlh0UVcvZVRlV1RXbW95bnkzVGNIU3BNOHAx?=
 =?utf-8?Q?LlKF8FSEg1hAI3SnU/bH242vy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QrLf1pYrubul8wsAoQFvm4z4p6sT+wNOA0osOfbXzXdRVLPKeYo618ffX6ZTK0GFVkeBOuKow59n3WQtkT9DxYE7ZRhlNWtGy2E8i6/Jp+mobRd1F8kWqMdWUL5AXnzIVOZ0qo3stvGTF+OIPi5UTmDI5Mv69hZLgtSqWqSiby2diq1W8L1x2YxwKMxn3vm6+FDm092DXVQvJNAid3b2WLrIZVqyVcFgzOCk45fjlD8SaeNz2Go3DypTs7rxJtt7eaSGNvEppOKrzX5x/jNNW6ETR/cfSaAOOos8SOt7QxTCp2mjEJaerLCr0aBcvla7mnUrMVgWmgpAWGaPjw7DkISOMjni82FV0n8TKpKObvZGbxJ3N2Inj0OcxWb3obC2Xwz57hLqr47+0gzy0/oc2zITgu1m7klSObTGckfCCgpGtuF+DCtKNltmDsLLfSnABZckzC4iBB06934Bwey+CIvc4kvITXW8u+oWky90n4kRNMfmtaJ2TAhiL+vK8lqJmkTQEAa1/DBsHd3mXgL6AcZx7lC1FUA4Jw/hUK6+KY2tDXVArp9IGBoHHyNr3W/Ey8RPAuCNIB5x2J8d2oQe2FQv+eeSLnXZ3y4cfwgVF70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f806814-91f9-440b-920a-08dd43a54863
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2025 16:18:52.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w48wdRuCGljgnz1ZCko1jgDAY/b/lrAHE+b4Ydf7QhY100ih2xCiWsdWQl5omSZZSppZQVrWVxgoSGf0t4VsOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-02_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502020143
X-Proofpoint-ORIG-GUID: 1Od9RqnQiulZhkb_qZhXZLgTPzuaKWmy
X-Proofpoint-GUID: 1Od9RqnQiulZhkb_qZhXZLgTPzuaKWmy

On 2/2/25 8:35 AM, Salvatore Bonaccorso wrote:
> Hi Chuck,
>=20
> On Fri, Jan 31, 2025 at 05:17:08PM +0100, Salvatore Bonaccorso wrote:
>> Hi Chuck,
>>
>> On Sat, Aug 17, 2024 at 02:52:38PM +0000, Chuck Lever III wrote:
>>>
>>>
>>>> On Aug 17, 2024, at 4:39=E2=80=AFAM, Salvatore Bonaccorso <carnil@debi=
an.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, Jul 30, 2024 at 02:52:47PM +0200, Paul Menzel wrote:
>>>>> Dear Salvatore, dear Chuck,
>>>>>
>>>>>
>>>>> Thank you for your messages.
>>>>>
>>>>>
>>>>> Am 30.07.24 um 14:19 schrieb Salvatore Bonaccorso:
>>>>>
>>>>>> On Sat, Jul 27, 2024 at 09:19:24PM +0000, Chuck Lever III wrote:
>>>>>>>
>>>>>>>> On Jul 27, 2024, at 5:15=E2=80=AFPM, Salvatore Bonaccorso <carnil@=
debian.org> wrote:
>>>>>
>>>>>>>> On Wed, Jul 17, 2024 at 07:33:24AM +0200, Paul Menzel wrote:
>>>>>
>>>>>>>>> Using Linux 5.15.160 on a Dell PowerEdge T440/021KCD, BIOS 2.11.2
>>>>>>>>> 04/22/2021, a mount from another server hung. Linux logs:
>>>>>>>>>
>>>>>>>>> ```
>>>>>>>>> $ dmesg -T
>>>>>>>>> [Wed Jul  3 16:39:34 2024] Linux version 5.15.160.mx64.476(root@t=
heinternet.molgen.mpg.de) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.41) #1=
 SMP Wed Jun 5 12:24:15 CEST 2024
>>>>>>>>> [Wed Jul  3 16:39:34 2024] Command line: root=3DLABEL=3Droot ro c=
rashkernel=3D64G-:256M console=3DttyS0,115200n8 console=3Dtty0 init=3D/bin/=
systemd audit=3D0 random.trust_cpu=3Don systemd.unified_cgroup_hierarchy
>>>>>>>>> [=E2=80=A6]
>>>>>>>>> [Wed Jul  3 16:39:34 2024] DMI: Dell Inc. PowerEdge T440/021KCD, =
BIOS 2.11.2 04/22/2021
>>>>>>>>> [=E2=80=A6]
>>>>>>>>> [Tue Jul 16 06:00:10 2024] md: md3: data-check interrupted.
>>>>>>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized rep=
ly: calldir 0x1 xpt_bc_xprt 00000000ee580afa xid 6890a3d2
>>>>>>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized rep=
ly: calldir 0x1 xpt_bc_xprt 00000000d4d84570 xid 3ca4017a
>>>>>
>>>>> [=E2=80=A6]
>>>>>
>>>>>>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized rep=
ly: calldir 0x1 xpt_bc_xprt 0000000028481e8f xid b682b676
>>>>>>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized rep=
ly: calldir 0x1 xpt_bc_xprt 00000000c384ff38 xid b5d5dbf5
>>>>>>>>> [Tue Jul 16 11:36:40 2024] rcu: INFO: rcu_sched self-detected sta=
ll on CPU
>>>>>>>>> [Tue Jul 16 11:36:40 2024] rcu:  13-....: (20997 ticks this GP) i=
dle=3D54f/1/0x4000000000000000 softirq=3D31904928/31904928 fqs=3D4433
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  (t=3D21017 jiffies g=3D194958993 q=3D=
5715)
>>>>>>>>> [Tue Jul 16 11:36:40 2024] Task dump for CPU 13:
>>>>>>>>> [Tue Jul 16 11:36:40 2024] task:kworker/u34:2   state:R  running =
task stack:    0 pid:30413 ppid:     2 flags:0x00004008
>>>>>>>>> [Tue Jul 16 11:36:40 2024] Workqueue: rpciod rpc_async_schedule [=
sunrpc]
>>>>>>>>> [Tue Jul 16 11:36:40 2024] Call Trace:
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  <IRQ>
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  sched_show_task.cold+0xc2/0xda
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? trigger_load_balance+0x6d/0x300
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? scheduler_tick+0xda/0x260
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  update_process_times+0xa1/0xe0
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  tick_sched_timer+0x8e/0xa0
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? tick_sched_do_timer+0x90/0x90
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  __hrtimer_run_queues+0x139/0x2a0
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  hrtimer_interrupt+0xf4/0x210
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  __sysvec_apic_timer_interrupt+0x5f/0x=
e0
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  sysvec_apic_timer_interrupt+0x69/0x90
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  </IRQ>
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  <TASK>
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  asm_sysvec_apic_timer_interrupt+0x16/=
0x20
>>>>>>>>> [Tue Jul 16 11:36:40 2024] RIP: 0010:read_tsc+0x3/0x20
>>>>>>>>> [Tue Jul 16 11:36:40 2024] Code: cc cc cc cc cc cc cc 8b 05 56 ab=
 72 01 c3 cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00=
 00 00 00 0f 01 f9 <66> 90 48 c1 e2 20 48 09 d0 c3 cc cc cc cc 66 66 2e 0f =
1f 84 00 00
>>>>>>>>> [Tue Jul 16 11:36:40 2024] RSP: 0018:ffffc900087cfe00 EFLAGS: 000=
00246
>>>>>>>>> [Tue Jul 16 11:36:40 2024] RAX: 00000000226dc8b8 RBX: 000000003f3=
c079e RCX: 000000000000100d
>>>>>>>>> [Tue Jul 16 11:36:40 2024] RDX: 00000000004535c4 RSI: 00000000000=
00046 RDI: ffffffff82435600
>>>>>>>>> [Tue Jul 16 11:36:40 2024] RBP: 0003ed08d3641da3 R08: ffffffffa01=
2c770 R09: ffffffffa012c788
>>>>>>>>> [Tue Jul 16 11:36:40 2024] R10: 0000000000000003 R11: 00000000000=
00283 R12: 0000000000000000
>>>>>>>>> [Tue Jul 16 11:36:40 2024] R13: 0000000000000001 R14: ffff8890931=
1c000 R15: ffff88909311c005
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ktime_get+0x38/0xa0
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? rpc_sleep_on_priority+0x70/0x70 [su=
nrpc]
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rpc_exit_task+0x9a/0x100 [sunrpc]
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  __rpc_execute+0x6e/0x410 [sunrpc]
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  process_one_work+0x1d7/0x3a0
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  worker_thread+0x4a/0x3c0
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? process_one_work+0x3a0/0x3a0
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  kthread+0x115/0x140
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? set_kthread_struct+0x50/0x50
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ret_from_fork+0x1f/0x30
>>>>>>>>> [Tue Jul 16 11:36:40 2024]  </TASK>
>>>>>>>>> [Tue Jul 16 11:37:19 2024] rcu: INFO: rcu_sched self-detected sta=
ll on CPU
>>>>>>>>> [Tue Jul 16 11:37:19 2024] rcu:  7-....: (21000 ticks this GP) id=
le=3D5b1/1/0x4000000000000000 softirq=3D29984492/29984492 fqs=3D5159
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  (t=3D21017 jiffies g=3D194959001 q=3D=
2008)
>>>>>>>>> [Tue Jul 16 11:37:19 2024] Task dump for CPU 7:
>>>>>>>>> [Tue Jul 16 11:37:19 2024] task:kworker/u34:2   state:R  running =
task stack:    0 pid:30413 ppid:     2 flags:0x00004008
>>>>>>>>> [Tue Jul 16 11:37:19 2024] Workqueue: rpciod rpc_async_schedule [=
sunrpc]
>>>>>>>>> [Tue Jul 16 11:37:19 2024] Call Trace:
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  <IRQ>
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  sched_show_task.cold+0xc2/0xda
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? trigger_load_balance+0x6d/0x300
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? scheduler_tick+0xda/0x260
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  update_process_times+0xa1/0xe0
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  tick_sched_timer+0x8e/0xa0
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? tick_sched_do_timer+0x90/0x90
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  __hrtimer_run_queues+0x139/0x2a0
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  hrtimer_interrupt+0xf4/0x210
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  __sysvec_apic_timer_interrupt+0x5f/0x=
e0
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  sysvec_apic_timer_interrupt+0x69/0x90
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  </IRQ>
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  <TASK>
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  asm_sysvec_apic_timer_interrupt+0x16/=
0x20
>>>>>>>>> [Tue Jul 16 11:37:19 2024] RIP: 0010:_raw_spin_lock+0x10/0x20
>>>>>>>>> [Tue Jul 16 11:37:19 2024] Code: b8 00 02 00 00 f0 0f c1 07 a9 ff=
 01 00 00 75 05 c3 cc cc cc cc e9 f0 05 59 ff 0f 1f 44 00 00 31 c0 ba 01 00=
 00 00 f0 0f b1 17 <75> 05 c3 cc cc cc cc 89 c6 e9 62 02 59 ff 66 90 0f 1f =
44 00 00 fa
>>>>>>>>> [Tue Jul 16 11:37:19 2024] RSP: 0018:ffffc900087cfe30 EFLAGS: 000=
00246
>>>>>>>>> [Tue Jul 16 11:37:19 2024] RAX: 0000000000000000 RBX: ffff8899713=
1a500 RCX: 0000000000000001
>>>>>>>>> [Tue Jul 16 11:37:19 2024] RDX: 0000000000000001 RSI: ffff8899713=
1a500 RDI: ffffffffa012c700
>>>>>>>>> [Tue Jul 16 11:37:19 2024] RBP: ffffffffa012c700 R08: ffffffffa01=
2c770 R09: ffffffffa012c788
>>>>>>>>> [Tue Jul 16 11:37:19 2024] R10: 0000000000000003 R11: 00000000000=
00283 R12: ffff88997131a530
>>>>>>>>> [Tue Jul 16 11:37:19 2024] R13: 0000000000000001 R14: ffff8890931=
1c000 R15: ffff88909311c005
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  __rpc_execute+0x95/0x410 [sunrpc]
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  process_one_work+0x1d7/0x3a0
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  worker_thread+0x4a/0x3c0
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? process_one_work+0x3a0/0x3a0
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  kthread+0x115/0x140
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? set_kthread_struct+0x50/0x50
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ret_from_fork+0x1f/0x30
>>>>>>>>> [Tue Jul 16 11:37:19 2024]  </TASK>
>>>>>>>>> [Tue Jul 16 11:37:57 2024] rcu: INFO: rcu_sched self-detected sta=
ll on CPU
>>>>>>>>> [=E2=80=A6]
>>>>>>>>> ```
>>>>>>>>
>>>>>>>> FWIW, on one NFS server occurence we are seeing something very clo=
se
>>>>>>>> to the above but in the 5.10.y case for the Debian kernel after
>>>>>>>> updating to 5.10.218-1 to 5.10.221-1, so kernel after which had th=
e
>>>>>>>> big NFS related stack backported.
>>>>>>>>
>>>>>>>> One backtrace we were able to catch was
>>>>>>>>
>>>>>>>> [...]
>>>>>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecogniz=
ed reply: calldir 0x1 xpt_bc_xprt 000000003d26f7ec xid b172e1c6
>>>>>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecogniz=
ed reply: calldir 0x1 xpt_bc_xprt 0000000017f1552a xid a90d7751
>>>>>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecogniz=
ed reply: calldir 0x1 xpt_bc_xprt 000000006337c521 xid 8e5e58bd
>>>>>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecogniz=
ed reply: calldir 0x1 xpt_bc_xprt 00000000cbf89319 xid c2da3c73
>>>>>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecogniz=
ed reply: calldir 0x1 xpt_bc_xprt 00000000e2588a21 xid a01bfec6
>>>>>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecogniz=
ed reply: calldir 0x1 xpt_bc_xprt 000000005fda63ca xid c2eeeaa6
>>>>>>>> [...]
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: rcu: INFO: rcu_sched self-detect=
ed stall on CPU
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: rcu:         15-....: (5250 tick=
s this GP) idle=3D74e/1/0x4000000000000000 softirq=3D3160997/3161006 fqs=3D=
2233
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:         (t=3D5255 jiffies g=3D83=
81377 q=3D106333)
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: NMI backtrace for cpu 15
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: CPU: 15 PID: 3725556 Comm: kwork=
er/u42:4 Not tainted 5.10.0-31-amd64 #1 Debian 5.10.221-1
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Hardware name: DALCO AG S2600WFT=
/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Workqueue: rpciod rpc_async_sche=
dule [sunrpc]
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Call Trace:
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  <IRQ>
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  dump_stack+0x6b/0x83
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  nmi_cpu_backtrace.cold+0x32/0x6=
9
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ? lapic_can_unplug_cpu+0x80/0x8=
0
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  nmi_trigger_cpumask_backtrace+0=
xdf/0xf0
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rcu_sched_clock_irq.cold+0x202/=
0x3d9
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ? trigger_load_balance+0x5a/0x2=
20
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  update_process_times+0x8c/0xc0
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_handle+0x22/0x60
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_timer+0x65/0x80
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ? tick_sched_do_timer+0x90/0x90
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  __hrtimer_run_queues+0x127/0x28=
0
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  __sysvec_apic_timer_interrupt+0=
x5c/0xe0
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  asm_call_irq_on_stack+0xf/0x20
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  </IRQ>
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  sysvec_apic_timer_interrupt+0x7=
2/0x80
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  asm_sysvec_apic_timer_interrupt=
+0x12/0x20
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RIP: 0010:mod_delayed_work_on+0x=
5d/0x90
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe ff ff=
 89 c3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2 4c 89 ee e8 f9 fc=
 ff ff 48 8b 3c 24 57 9d <0f> 1f 44 >
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RSP: 0018:ffffb5efe356fd90 EFLAG=
S: 00000246
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RAX: 0000000000000000 RBX: 00000=
00000000000 RCX: 000000003820000f
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RDX: 0000000038000000 RSI: 00000=
00000000046 RDI: 0000000000000246
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RBP: 0000000000002000 R08: fffff=
fffc0884430 R09: ffffffffc0884448
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: R10: 0000000000000003 R11: 00000=
00000000003 R12: ffffffffc0884428
>>>>>>>> Jul 27 15:25:15 nfsserver kernel: R13: ffff8c89d0f6b800 R14: 00000=
000000001f4 R15: 0000000000000000
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  __rpc_sleep_on_priority_timeout=
+0x111/0x120 [sunrpc]
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_exit_task+0x5a/0x140 [sunrp=
c]
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ? __rpc_do_wake_up_task_on_wq+0=
x1e0/0x1e0 [sunrpc]
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrp=
c]
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [s=
unrpc]
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  process_one_work+0x1b3/0x350
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  worker_thread+0x53/0x3e0
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ? process_one_work+0x350/0x350
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  kthread+0x118/0x140
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ret_from_fork+0x1f/0x30
>>>>>>>> [...]
>>>>>>>>
>>>>>>>> Is there anything which could help debug this issue?
>>>>>>>
>>>>>>> The backtrace suggests an issue in the RPC client code; the
>>>>>>> server's NFSv4.1 backchannel would use that to send callbacks.
>>>>>>>
>>>>>>> Since 5.10.218 and 5.10.221 are only about a thousand commits
>>>>>>> apart, a bisect should be quick and narrow down the issue to
>>>>>>> one or two commits.
>>>>>>
>>>>>> Yes indeed. Unfortunately was yet unable to reproduce the issue in
>>>>>> more syntentic way on test environment, and the affected server in
>>>>>> particular is a production system.
>>>>>>
>>>>>> Paul, is your case in some way reproducible in a testing environment
>>>>>> so that a bisection might be give enough hints on the problem?
>>>>> We hit this issue once more on the same server with Linux 5.15.160, a=
nd had
>>>>> to hard reboot it.
>>>>>
>>>>> Unfortunately we did not have time yet to set up a test system to fin=
d a
>>>>> reproducer. In our cases a lot of compute servers seem to have access=
ed the
>>>>> NFS server. A lot of the many processes were `zstd` on a first glance=
.
>>>>
>>>> So we neither, due to the nature of the server (production system) and
>>>> unability to reproduce the issue under some more controlled way and on
>>>> test environment.
>>>>
>>>> In our case users seems to cause workloads involving use of wandb.
>>>>
>>>> What we tried is to boot the recent kernel from 5.10.y series avaiable
>>>> (5.10.223-1). Then the issue showed up still. Since we disabled
>>>> fs.leases-enable the situation seems to be more stable). While this
>>>> is/might not be the solution, does that gives some additional hits?
>>>
>>> The problem is backchannel-related, and disabling delegation
>>> will reduce the number of backchannel operations. Your finding
>>> comports with our current theory, but I can't think of how it
>>> narrows the field of suspects.
>>>
>>> Is the server running short on memory, perhaps? One backchannel
>>> operation that was added in v5.10.220 is CB_RECALL_ANY, which
>>> is triggered on memory exhaustion. But that should be a fairly
>>> harmless addition unless there is a bug in there somewhere.
>>>
>>> If your NFS server does not have any NFS mounts, then we could
>>> provide instructions for enabling client-side tracing to watch
>>> the details of callback traffic.
>>
>> The NFS server acts as well as NFS client, so tracing more
>> back-channel related will I guess just load the tracing more.
>>
>> But we got "lucky" and we were able to trigger the issue twice in last
>> days, once NFSv4 delegations were enabled again and some users started
>> to cause more load on the specific server as well.
>>
>> I did issue=20
>>
>> 	rpcdebug -m rpc -c
>>
>> before rebooting/resetting the server  which is
>>
>> Jan 30 05:27:05 nfsserver kernel: 26407 2281   -512 3d1fdb92        0   =
     0 79bc1aa5 nfs4_cbv1 CB_RECALL_ANY a:rpc_exit_task [sunrpc] q:delayq
>>
>> and the first RPC related soft lookup slapt in the log/journal I was
>> able to gather is:
>>
>> Jan 29 22:34:05 nfsserver kernel: watchdog: BUG: soft lockup - CPU#11 st=
uck for 23s! [kworker/u42:3:705574]
>> Jan 29 22:34:05 nfsserver kernel: Modules linked in: binfmt_misc rpcsec_=
gss_krb5 nfsv4 dns_resolver nfs fscache bonding quota_v2 quota_tree ipmi_ss=
if intel_rapl_msr intel_rapl_common skx_edac skx_edac_common nfit libnvdimm=
 x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass gha=
sh_clmulni_intel aesni_intel libaes crypto_simd cryptd ast glue_helper drm_=
vram_helper drm_ttm_helper rapl acpi_ipmi ttm iTCO_wdt intel_cstate ipmi_si=
 intel_pmc_bxt drm_kms_helper mei_me iTCO_vendor_support ipmi_devintf cec i=
oatdma intel_uncore pcspkr evdev joydev sg i2c_algo_bit watchdog mei dca ip=
mi_msghandler acpi_power_meter acpi_pad button fuse drm configfs nfsd auth_=
rpcgss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbc=
ache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath linear=
 md_mod dm_mod hid_generic usbhid hid sd_mod t10_pi crc_t10dif crct10dif_ge=
neric xhci_pci ahci xhci_hcd libahci i40e libata
>> Jan 29 22:34:05 nfsserver kernel:  crct10dif_pclmul arcmsr crct10dif_com=
mon ptp crc32_pclmul usbcore crc32c_intel scsi_mod pps_core i2c_i801 lpc_ic=
h i2c_smbus wmi usb_common
>> Jan 29 22:34:05 nfsserver kernel: CPU: 11 PID: 705574 Comm: kworker/u42:=
3 Not tainted 5.10.0-33-amd64 #1 Debian 5.10.226-1
>> Jan 29 22:34:05 nfsserver kernel: Hardware name: DALCO AG S2600WFT/S2600=
WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>> Jan 29 22:34:05 nfsserver kernel: Workqueue: rpciod rpc_async_schedule [=
sunrpc]
>> Jan 29 22:34:05 nfsserver kernel: RIP: 0010:ktime_get+0x7b/0xa0
>> Jan 29 22:34:05 nfsserver kernel: Code: d1 e9 48 f7 d1 48 89 c2 48 85 c1=
 8b 05 ae 2c a5 02 8b 0d ac 2c a5 02 48 0f 45 d5 8b 35 7e 2c a5 02 41 39 f4=
 75 9e 48 0f af c2 <48> 01 f8 48 d3 e8 48 01 d8 5b 5d 41 5c c3 cc cc cc cc =
f3 90 eb 84
>> Jan 29 22:34:05 nfsserver kernel: RSP: 0018:ffffa1aca9227e00 EFLAGS: 000=
00202
>> Jan 29 22:34:05 nfsserver kernel: RAX: 0000371a545e1910 RBX: 000005fce82=
a4372 RCX: 0000000000000018
>> Jan 29 22:34:05 nfsserver kernel: RDX: 000000000078efbe RSI: 00000000003=
1f238 RDI: 00385c1353c92824
>> Jan 29 22:34:05 nfsserver kernel: RBP: 0000000000000000 R08: ffffffffc08=
1f410 R09: ffffffffc081f410
>> Jan 29 22:34:05 nfsserver kernel: R10: 0000000000000003 R11: 00000000000=
00003 R12: 000000000031f238
>> Jan 29 22:34:05 nfsserver kernel: R13: ffff8ed42bf34830 R14: 00000000000=
00001 R15: 0000000000000000
>> Jan 29 22:34:05 nfsserver kernel: FS:  0000000000000000(0000) GS:ffff8ee=
94f880000(0000) knlGS:0000000000000000
>> Jan 29 22:34:05 nfsserver kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
>> Jan 29 22:34:05 nfsserver kernel: CR2: 00007ffddf306080 CR3: 00000017c42=
0a002 CR4: 00000000007706e0
>> Jan 29 22:34:05 nfsserver kernel: DR0: 0000000000000000 DR1: 00000000000=
00000 DR2: 0000000000000000
>> Jan 29 22:34:05 nfsserver kernel: DR3: 0000000000000000 DR6: 00000000fff=
e0ff0 DR7: 0000000000000400
>> Jan 29 22:34:05 nfsserver kernel: PKRU: 55555554
>> Jan 29 22:34:05 nfsserver kernel: Call Trace:
>> Jan 29 22:34:05 nfsserver kernel:  <IRQ>
>> Jan 29 22:34:05 nfsserver kernel:  ? watchdog_timer_fn+0x1bb/0x210
>> Jan 29 22:34:05 nfsserver kernel:  ? lockup_detector_update_enable+0x50/=
0x50
>> Jan 29 22:34:05 nfsserver kernel:  ? __hrtimer_run_queues+0x127/0x280
>> Jan 29 22:34:05 nfsserver kernel:  ? hrtimer_interrupt+0x110/0x2c0
>> Jan 29 22:34:05 nfsserver kernel:  ? __sysvec_apic_timer_interrupt+0x5c/=
0xe0
>> Jan 29 22:34:05 nfsserver kernel:  ? asm_call_irq_on_stack+0xf/0x20
>> Jan 29 22:34:05 nfsserver kernel:  </IRQ>
>> Jan 29 22:34:05 nfsserver kernel:  ? sysvec_apic_timer_interrupt+0x72/0x=
80
>> Jan 29 22:34:05 nfsserver kernel:  ? asm_sysvec_apic_timer_interrupt+0x1=
2/0x20
>> Jan 29 22:34:05 nfsserver kernel:  ? ktime_get+0x7b/0xa0
>> Jan 29 22:34:05 nfsserver kernel:  rpc_exit_task+0x96/0x140 [sunrpc]
>> Jan 29 22:34:05 nfsserver kernel:  ? __rpc_do_wake_up_task_on_wq+0x1e0/0=
x1e0 [sunrpc]
>> Jan 29 22:34:05 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
>> Jan 29 22:34:05 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [sunrpc]
>> Jan 29 22:34:05 nfsserver kernel:  process_one_work+0x1b3/0x350
>> Jan 29 22:34:05 nfsserver kernel:  worker_thread+0x53/0x3e0
>> Jan 29 22:34:05 nfsserver kernel:  ? process_one_work+0x350/0x350
>> Jan 29 22:34:05 nfsserver kernel:  kthread+0x118/0x140
>> Jan 29 22:34:05 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>> Jan 29 22:34:05 nfsserver kernel:  ret_from_fork+0x1f/0x30
>>
>> I can try to pick on top of the kernel the change Chuck mentioned to
>> me offlist, which is the posting of
>> https://lore.kernel.org/linux-nfs/1738271066-6727-1-git-send-email-dai.n=
go@oracle.com/,
>> and in fact this could be interesting. If the users keep doing the
>> same kind of load, this might help understanding more the issue.
>>
>> As we suspect that the issue is more frequently triggered after the
>> switch of 5.10.118 -> 5.10.221, this enforces more the above, which
>> says it fixes 66af25799940 ("NFSD: add courteous server support for
>> thread with only delegation"), which is in 5.19-rc1, but got
>> backported to 5.15.154 and 5.10.220 as well.
>=20
> Unfortunately not. The system ran slightly more stable with that patch on=
, and
> there was a nfsd hang inbeween here, within a series of=20
>=20
> [...]
> Feb 02 03:22:40 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5d31fb84
> Feb 02 03:22:40 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 9ec25b24
> Feb 02 03:23:09 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 9fc25b24
> Feb 02 03:23:12 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5e31fb84
> Feb 02 03:23:24 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid a0c25b24
> Feb 02 03:23:24 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5f31fb84
> Feb 02 03:23:31 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid 756103e9
> Feb 02 03:23:31 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid ef4f583e
> Feb 02 03:23:33 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 000000008f30d648 xid 1ec77a2e
> Feb 02 03:23:35 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid d0b95b44
> Feb 02 03:27:43 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 7d31fb84
> Feb 02 03:27:44 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid bec25b24
> Feb 02 03:27:44 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid e0be7eef
> Feb 02 03:28:07 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid bfc25b24
> Feb 02 03:28:09 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid e1be7eef
> Feb 02 03:31:41 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid f96ccce2
> Feb 02 03:31:44 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 06ba5b44
> Feb 02 03:31:49 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 9531fb84
> Feb 02 03:31:51 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid f7be7eef
> Feb 02 03:31:52 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid 2550583e
> Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid d5c25b24
> Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid ab6103e9
> Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 000000004111342b xid 9da4f045
> Feb 02 03:32:32 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid d8c25b24
> Feb 02 03:32:32 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid fabe7eef
> Feb 02 04:18:12 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid a1c35b24
> Feb 02 04:18:12 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 000000009715512e xid 29a849e3
> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid 786203e9
> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid f150583e
> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid c66dcce2
> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 000000008f30d648 xid 21c87a2e
> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 0000000053af79cb xid 49da29a2
> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 6132fb84
> Feb 02 04:49:18 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 2ebb5b44
> Feb 02 04:49:21 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid 226ecce2
> Feb 02 04:49:22 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid fdc35b24
> Feb 02 04:49:22 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid 1fc07eef
> Feb 02 05:01:25 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 25c45b24
> Feb 02 05:09:27 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 51c45b24
> [...]
> Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1590 blocked for more t=
han 120 seconds.
> Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E     5.10.=
0-34-amd64 #1 Debian 5.10.228-1~test1
> Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_ti=
meout_secs" disables this message.
> Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D stack:    =
0 pid: 1590 ppid:     2 flags:0x00004000
> Feb 02 05:34:46 nfsserver kernel: Call Trace:
> Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
> Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
> Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
> Feb 02 05:34:46 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
> Feb 02 05:34:46 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> Feb 02 05:34:46 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 [e=
xt4]
> Feb 02 05:34:46 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> Feb 02 05:34:46 nfsserver kernel:  do_iter_write+0x80/0x1c0
> Feb 02 05:34:46 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [sunr=
pc]
> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> Feb 02 05:34:46 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ? kthread+0x118/0x140
> Feb 02 05:34:46 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> Feb 02 05:34:46 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
> Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1599 blocked for more t=
han 120 seconds.
> Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E     5.10.=
0-34-amd64 #1 Debian 5.10.228-1~test1
> Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_ti=
meout_secs" disables this message.
> Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D stack:    =
0 pid: 1599 ppid:     2 flags:0x00004000
> Feb 02 05:34:46 nfsserver kernel: Call Trace:
> Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
> Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
> Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
> Feb 02 05:34:46 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
> Feb 02 05:34:46 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> Feb 02 05:34:46 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 [e=
xt4]
> Feb 02 05:34:46 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> Feb 02 05:34:46 nfsserver kernel:  do_iter_write+0x80/0x1c0
> Feb 02 05:34:46 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [sunr=
pc]
> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> Feb 02 05:34:46 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> Feb 02 05:34:46 nfsserver kernel:  ? kthread+0x118/0x140
> Feb 02 05:34:46 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> Feb 02 05:34:46 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
> Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1601 blocked for more t=
han 121 seconds.
> Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E     5.10.=
0-34-amd64 #1 Debian 5.10.228-1~test1
> Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_ti=
meout_secs" disables this message.
> Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D stack:    =
0 pid: 1601 ppid:     2 flags:0x00004000
> Feb 02 05:34:46 nfsserver kernel: Call Trace:
> Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
> Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
> Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
> Feb 02 05:34:47 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
> Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 [e=
xt4]
> Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
> Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [sunr=
pc]
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
> Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
> Feb 02 05:34:47 nfsserver kernel: INFO: task nfsd:1604 blocked for more t=
han 121 seconds.
> Feb 02 05:34:47 nfsserver kernel:       Tainted: G            E     5.10.=
0-34-amd64 #1 Debian 5.10.228-1~test1
> Feb 02 05:34:47 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_ti=
meout_secs" disables this message.
> Feb 02 05:34:47 nfsserver kernel: task:nfsd            state:D stack:    =
0 pid: 1604 ppid:     2 flags:0x00004000
> Feb 02 05:34:47 nfsserver kernel: Call Trace:
> Feb 02 05:34:47 nfsserver kernel:  __schedule+0x282/0x870
> Feb 02 05:34:47 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
> Feb 02 05:34:47 nfsserver kernel:  schedule+0x46/0xb0
> Feb 02 05:34:47 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
> Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 [e=
xt4]
> Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
> Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [sunr=
pc]
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
> Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
> Feb 02 05:34:47 nfsserver kernel: INFO: task nfsd:1610 blocked for more t=
han 121 seconds.
> Feb 02 05:34:47 nfsserver kernel:       Tainted: G            E     5.10.=
0-34-amd64 #1 Debian 5.10.228-1~test1
> Feb 02 05:34:47 nfsserver kernel: "echo 0 > /proc/sys/kernel/hung_task_ti=
meout_secs" disables this message.
> Feb 02 05:34:47 nfsserver kernel: task:nfsd            state:D stack:    =
0 pid: 1610 ppid:     2 flags:0x00004000
> Feb 02 05:34:47 nfsserver kernel: Call Trace:
> Feb 02 05:34:47 nfsserver kernel:  __schedule+0x282/0x870
> Feb 02 05:34:47 nfsserver kernel:  schedule+0x46/0xb0
> Feb 02 05:34:47 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
> Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ext4_buffered_write_iter+0x33/0x160 [e=
xt4]
> Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
> Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
> Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0 [sunr=
pc]
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
> Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
> Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
> Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30

This is a totally different failure mode: it's hanging in the
ext4 write path. One of your nfsd threads is stuck in D state
waiting to get a rw semaphor.

Question is, who is holding that rw_sem and why?


> This happend a couple of times again and "recovered", but got finally stu=
ck
> again with:
>=20
> Feb 02 10:55:25 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 1639fb84
> Feb 02 10:55:26 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 000000004111342b xid 24acf045
> Feb 02 10:55:27 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 89c15b44
> Feb 02 10:55:28 nfsserver kernel: receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid 8c74cce2
> Feb 02 10:55:50 nfsserver kernel: rcu: INFO: rcu_sched self-detected stal=
l on CPU
> Feb 02 10:55:50 nfsserver kernel: rcu:         14-....: (5249 ticks this =
GP) idle=3Dc4e/1/0x4000000000000000 softirq=3D3120573/3120573 fqs=3D2624=20
> Feb 02 10:55:50 nfsserver kernel:         (t=3D5250 jiffies g=3D4585625 q=
=3D145785)
> Feb 02 10:55:50 nfsserver kernel: NMI backtrace for cpu 14
> Feb 02 10:55:50 nfsserver kernel: CPU: 14 PID: 614435 Comm: kworker/u42:2=
 Tainted: G            E     5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
> Feb 02 10:55:50 nfsserver kernel: Hardware name: DALCO AG S2600WFT/S2600W=
FT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> Feb 02 10:55:50 nfsserver kernel: Workqueue: rpciod rpc_async_schedule [s=
unrpc]
> Feb 02 10:55:50 nfsserver kernel: Call Trace:
> Feb 02 10:55:50 nfsserver kernel:  <IRQ>
> Feb 02 10:55:50 nfsserver kernel:  dump_stack+0x6b/0x83
> Feb 02 10:55:50 nfsserver kernel:  nmi_cpu_backtrace.cold+0x32/0x69
> Feb 02 10:55:50 nfsserver kernel:  ? lapic_can_unplug_cpu+0x80/0x80
> Feb 02 10:55:50 nfsserver kernel:  nmi_trigger_cpumask_backtrace+0xdb/0xf=
0
> Feb 02 10:55:50 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
> Feb 02 10:55:50 nfsserver kernel:  rcu_sched_clock_irq.cold+0x202/0x3d9
> Feb 02 10:55:50 nfsserver kernel:  ? timekeeping_advance+0x370/0x5c0
> Feb 02 10:55:50 nfsserver kernel:  update_process_times+0x8c/0xc0
> Feb 02 10:55:50 nfsserver kernel:  tick_sched_handle+0x22/0x60
> Feb 02 10:55:50 nfsserver kernel:  tick_sched_timer+0x65/0x80
> Feb 02 10:55:50 nfsserver kernel:  ? tick_sched_do_timer+0x90/0x90
> Feb 02 10:55:50 nfsserver kernel:  __hrtimer_run_queues+0x127/0x280
> Feb 02 10:55:50 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
> Feb 02 10:55:50 nfsserver kernel:  __sysvec_apic_timer_interrupt+0x5c/0xe=
0
> Feb 02 10:55:50 nfsserver kernel:  asm_call_irq_on_stack+0xf/0x20
> Feb 02 10:55:50 nfsserver kernel:  </IRQ>
> Feb 02 10:55:50 nfsserver kernel:  sysvec_apic_timer_interrupt+0x72/0x80
> Feb 02 10:55:50 nfsserver kernel:  asm_sysvec_apic_timer_interrupt+0x12/0=
x20
> Feb 02 10:55:50 nfsserver kernel: RIP: 0010:mod_delayed_work_on+0x5d/0x90
> Feb 02 10:55:50 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe ff ff 89 c3 =
83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2 4c 89 ee e8 f9 fc ff ff =
48 8b 3c 24 57 9d <0f> 1f 44 00 00 85 db 0f 95 c0 48 8b 4c 24 08 65 48 2b 0=
c 25 28 00
> Feb 02 10:55:50 nfsserver kernel: RSP: 0018:ffffaaff25d57d90 EFLAGS: 0000=
0246
> Feb 02 10:55:50 nfsserver kernel: RAX: 0000000000000000 RBX: 000000000000=
0000 RCX: 000000003e60000e
> Feb 02 10:55:50 nfsserver kernel: RDX: 000000003e400000 RSI: 000000000000=
0046 RDI: 0000000000000246
> Feb 02 10:55:50 nfsserver kernel: RBP: 0000000000002000 R08: ffffffffc08f=
6430 R09: ffffffffc08f6448
> Feb 02 10:55:50 nfsserver kernel: R10: 0000000000000003 R11: 000000000000=
0003 R12: ffffffffc08f6428
> Feb 02 10:55:50 nfsserver kernel: R13: ffff8e4083a4b400 R14: 000000000000=
01f4 R15: 0000000000000000
> Feb 02 10:55:50 nfsserver kernel:  __rpc_sleep_on_priority_timeout+0x111/=
0x120 [sunrpc]
> Feb 02 10:55:50 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
> Feb 02 10:55:50 nfsserver kernel:  rpc_exit_task+0x5a/0x140 [sunrpc]
> Feb 02 10:55:50 nfsserver kernel:  ? __rpc_do_wake_up_task_on_wq+0x1e0/0x=
1e0 [sunrpc]
> Feb 02 10:55:50 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
> Feb 02 10:55:50 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [sunrpc]
> Feb 02 10:55:50 nfsserver kernel:  process_one_work+0x1b3/0x350
> Feb 02 10:55:50 nfsserver kernel:  worker_thread+0x53/0x3e0
> Feb 02 10:55:50 nfsserver kernel:  ? process_one_work+0x350/0x350
> Feb 02 10:55:50 nfsserver kernel:  kthread+0x118/0x140
> Feb 02 10:55:50 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> Feb 02 10:55:50 nfsserver kernel:  ret_from_fork+0x1f/0x30
>=20
> Before rebooting the system, rpcdebug -m rpc -c  was issued again, with t=
he
> following logged entry:
>=20
> Feb 02 11:01:52 nfsserver kernel: -pid- flgs status -client- --rqstp- -ti=
meout ---ops--
> Feb 02 11:01:52 nfsserver kernel: 42135 2281      0 8ff8d038        0    =
  500  1a6bcc0 nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc] q:none

This is also different: the CB_RECALL_ANY is waiting to start, it's not
retransmitting.


> The system is now again back booted with fs.leases-enable=3D0 to keep it =
more
> "stable".

Understood, but I don't yet see how this new scenario is related to
NFSv4 delegation. We can speculate, but here's nothing standing out in
the collected data.


--=20
Chuck Lever

