Return-Path: <linux-nfs+bounces-1689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294558459C7
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 15:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F391F2459A
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AAD5F46B;
	Thu,  1 Feb 2024 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oQ8Dv7W8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KzRK5hUA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CD5D489;
	Thu,  1 Feb 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796934; cv=fail; b=kRUAmufbU6/3/KzRdZTPADksELWFwMHtaczJ+Fm5aQyBgtqbwwx+Q6G7O3367/beFEY46hUchkrmOOsPnIMcDbAUmd2g5yQmSzB/lBE9ss62kxTMeIT+E16Gpildsr/qJHb6ncr041iis3rFqgnOnEk9n70p+y8F56hKq8Mp9tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796934; c=relaxed/simple;
	bh=qdd1EQ5rLMTNapMy+eBw2mqV12UAq6POPP3MUFyynzY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dXBJ7qBRKbSBhe/XODAOI8Krt21DvaGm827RV1v7w/mtTV0ayVAuVwjQNxHNBd1Bx4+Y/3xEPyk7GLXofVtlYNbeb7FSSjyAk7c5JSNbKzQDMVduiRbZwkukjf3xr9xMaFe3uo4/Dxb7jJTY6SguFMMfj53SPwxTFn+QJUllPGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oQ8Dv7W8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KzRK5hUA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411EF9DT011350;
	Thu, 1 Feb 2024 14:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eHuvsLxAcl1USY8CNPwaQQYmN66p73os7f8TjCHKOmA=;
 b=oQ8Dv7W8cNak9AKtsiILp8EEo5YXu0rwifoH2xSB/TAZVakaELJX+z4kVfyfHwSLhfN9
 yrnCfs2J4YF4fy+Pjy0HwJuS/B0I08uaDbEa5KsmJ/3CM91b6cfs7asTbdlky1YM3/WO
 Iubm1k806JNVIsNEX94CpzDKTbawR8b2Fz2ap+fSOuEvIfJ8RIWveAT5M3s2uKzlEQll
 gn2EjwuLnDj0Q6JGWHoD889s0E6XnTgQe7NE9Z/Hf+amW33+hwptu5fzKz5JD0sAQWI+
 rs/+8HKYJ7A9Jq7VgzOi8+Tpf4Ol3znOiAlEXOPjc0rQs8uWqd925SgIU4kdtK3G+LFT oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2mwy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 14:15:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 411EAchY036143;
	Thu, 1 Feb 2024 14:15:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9gx7h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 14:15:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBF51g7bF28BwtdR+Kz6Ual4SIrGwK5xj/jNs1pKYk3DvHy/82vYiwgn02/9QOC2XNUdMdsnoHKpAtktgwU8ucid1d1QvMi32OQBYdVfthhiajbiZhQ2nnDKQqvOvpWYKbeqjYx+nBNik2AsFTVqoeAW5IcwS/Pxs2ywnffPDCAPzjM28PF9PttM4f5VDiuFdllb0HECMwZUh0Jt8NUP5cTVNtr9Gd2PtQsv5ocjHULLlRWZSqZtIB2dWS1Lp3WlcZrNQnwZCN9Khc5ffpHX//3q87aMlnJX4vEBtg9QgF1kEujwXElHzHvMoOhBQthbMqVFJjzZj+PdpGuyrnakkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHuvsLxAcl1USY8CNPwaQQYmN66p73os7f8TjCHKOmA=;
 b=foE7wL0FMi8WvC8CXAmcKu5STj03eZNlXju9hKB8cN7LjEydKhZ2o28dKD8plmNNbcy7AiEPqOk3J6goaEpgxJfgRV8TpzikyvULtRK/uVWSJ0kk2aFhCg975nduODt4R66QLkwCOlbul3bB+AurDgpNqJfXrFbhLKpcPt2bi9UoacdPFFCfC9VO7aaWybz5kPjL6/3g1A4RjVki8leIJ1nhueiUzAvZJ2gqztW/ig1qZosbOpGerxV+Lpuq+2JIZIV73snyWW50xb/gaqGOp9Ov1gKrHrtOsZV5MLNKW07CvMHNAXEEHHUZ1RohSujgTWpTtSzZ5wwiC9lRdmfOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHuvsLxAcl1USY8CNPwaQQYmN66p73os7f8TjCHKOmA=;
 b=KzRK5hUAsJf7MtyN4KvCmTpjz9OSi2I78hP6x6X0yz3x4cbKg1FBpcYhAvgbGJRN/KbKSF5JaximbNMj0GA+QgGbgykR4LVvJAZ7uFURcakK1SyzmLMNXN3AmfcBbvzhsn87K+5Un0+FiWU9WsU0NyPq1fWcuU6ExF/i7lOfffc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7828.namprd10.prod.outlook.com (2603:10b6:a03:56c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 14:15:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 14:15:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: [GIT PULL] another fix for v6.8-rc
Thread-Topic: [GIT PULL] another fix for v6.8-rc
Thread-Index: AQHaVRkXRiXTg7pzk0uoZ4iQFzp+iA==
Date: Thu, 1 Feb 2024 14:15:22 +0000
Message-ID: <8F4AC301-0EAF-4767-9AD1-A21A37917650@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7828:EE_
x-ms-office365-filtering-correlation-id: 2107aa7e-c0f3-42c5-e120-08dc23303a71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ctLOeNgDreBTu/WDjZ4RHHoU+qfu1vRxSt9ootKxsu8WuFfeKqlRtVvVaOmJpz7yEptdwX+manXeW/Uv7AfXux2bbrDkGIaQux63MceZAgpjDIarWOHIvjCdYRzhzkneCLk6rfWqdsgUtEwMD3NGepqzu2e9VCRhLugw+WUzLcBOhC1vJKX6hA0pC0rqdzTEx3yQERh9PS4N5DTkl8Dkf1iXRxYv6bNvpm1nmu2riuOqxsyO5VwyCJDTPcoI9A6FaEiOyM8HiZfr962Y/iJylJOMkrEYdfpkv2TvujtrGEiRs4yNjttVOUA2JU6tK+QJFtSx3d9bcsfCUgaE4hp/RN5UvkFERAtdo3Sxr/Jnf1Vd4WQ0/MQoLKyDcbZG8oBEZ2thZptDNAdmYNBSEoqEvkRx6qHV1K8Bkqpauqi6eqFoY5lSWUk4hth+1Rl3Dq4a/0p+QBKl9IjMAB8k4KScgOcPpukeEQYaBBDdhSZZE2DT1ajn/+6x3+oQ9Pf1+5aqBqOiWYgEuh//IxL1YoBdZZRlj+ZK6NJ/iPYY9ELjEOEiMWKxjpusmBqNRxR9djo4ZKjbMehxTM8wGjmLeP6Hxln1vqVqmIkbsphD1zKIzHnmwh7I4eJ1b27nzbqL956GejLZTvaGTT6eBtRO2jppJQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4744005)(83380400001)(2906002)(38100700002)(2616005)(5660300002)(122000001)(26005)(966005)(64756008)(76116006)(66946007)(66556008)(66476007)(54906003)(6486002)(6916009)(4326008)(66446008)(8936002)(6506007)(316002)(8676002)(6512007)(478600001)(71200400001)(38070700009)(41300700001)(86362001)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yIlFFtClUifCLRFPyPTf/PKmiAKbrsijd9vpA67d1xJtxTSDgM1LEzIfqUab?=
 =?us-ascii?Q?2tMyggM0jT4YvXUneU0/VtcvQ1+LCZOyY3wsj9X52h0SroXa3QSn1FhB02An?=
 =?us-ascii?Q?z45DumbE3srLX/fX7a1MrzzBb5gWFBsQq8eEgSp4NMJcoERkoEMsys0trcn+?=
 =?us-ascii?Q?4FW+h8CPlqLafSw6rtffopi1qIng9F4JWz00IYn7fFlPMCVX3lyc3bs7ovPT?=
 =?us-ascii?Q?iI6YU0Z9V8ouzjITgCmx9j4eI/pGugdcT9zTaTKGPqpmPbmDO8rXXjJ1ONhG?=
 =?us-ascii?Q?H54OqCHSEduVv1z2/JShYSp3PKZlvZyZ32TKQ68m602eenQkhReQ92lQ2qt0?=
 =?us-ascii?Q?Wf1jSOShVxjgGYqkrdvD2m5Mqia7IQRQ2ZAPwPZEcY7dsnKruVKD/OFzuzTz?=
 =?us-ascii?Q?pK0lCxngKpEaF6NxBdO12SeK2JM0zPKmOqp01KoFtnJwgZHw+HfIsw+vOggv?=
 =?us-ascii?Q?Et/yqT/EFalEyOskS2CRClfyRxuhKL3ZmgGtAo1Fd6bLK2FCKAWBQw0e6cjf?=
 =?us-ascii?Q?zQJmVmZmQyKq01DxVU19AER29ew/0kdT/CbT8nHJ4e8Snd3xZF0ibRwEaAva?=
 =?us-ascii?Q?FutdX5wcM9QlCA7SICz0fCKWYLjiooDkh9WJMBVxxGuzZp7sl4zr+HAmWyi2?=
 =?us-ascii?Q?0p5OGOUzC8yUYl1PQzs0B1eJsDAmvuFWMlfkUQW/w3vmceMXcdUMiwX/FaRI?=
 =?us-ascii?Q?w1x0pHFkT2Y0wbQQ8m/xFKxZ9a4jmCFoipgn4MaB7J5NV6yw4OqbbwMrSigU?=
 =?us-ascii?Q?1/+CZ0mupaB5GcInG4JumMiom7mDxWzO9K5oHKKdpPJAlmsDsjUQu/tIOxUG?=
 =?us-ascii?Q?RQ5zUZ+TgaRz4tiKPka66Rd9+VH6IZ2mFcsyTg67AfKhObdGz5tEfN9sc+jL?=
 =?us-ascii?Q?VFSeQFI24tWk3k8UeUz0E6KQe+PcOZKp4XCjLKrY4sYDm2Ag1eLEg/UfUQ+i?=
 =?us-ascii?Q?Q6JVlRskw865TZ7e46o17Ho0cLDUrI+Pyr6unLgN0S7ht4DwT+tS0RzQ8vI3?=
 =?us-ascii?Q?Fbomdr4vld2lOYCmDvQXV+/N5NakC1xDFyqx5s6CqF/ki6KBolc9N8o5n79H?=
 =?us-ascii?Q?GAOtpXVM3nFDlw8jOCui5jlHZATfNMAgjpLSwHpwEQETPg0iR8UbPEApAar+?=
 =?us-ascii?Q?yG/vrluv96gvLtmMtX3YnoXOigDRK0rLn+e4Z2waTJXyXRizqs2b0Tcolfb1?=
 =?us-ascii?Q?weZ9mMukpn5MP4T0FzRn9MAUlF5QMxj9KhVfnX93WM6fmwmINWpx7uRyCM8n?=
 =?us-ascii?Q?LY1kirhucNPGOAmuTc1Cs0E8D8OHyb4LSEobGnHQLfEArTOZawFsIjeRtP3O?=
 =?us-ascii?Q?ehX6qOeN9R5+hYjBxpqUzhA16hzprJzqoOG89coHnYf4rLAyNDL78JGbEpQW?=
 =?us-ascii?Q?GfDSiUUTmP4hsEKhYMYlwqr0mXdWeTpxPiH6SCJ5aYzZT44c+z1Y+J1JYvcI?=
 =?us-ascii?Q?Kvx+/RrOCkrcMxZz+y5yp1HymMMHG3RlsLa7BZ6GwDEAeIQqmd8q21q200bg?=
 =?us-ascii?Q?eNMRlVyLsyZUaWLLkOfAMN5ZhWO00OroWnQcfMCph4lg1W20E3k38YbUkM8d?=
 =?us-ascii?Q?+Y0+4cxy1AvwPnIqDCLJsmU6uTONGv4bIMkTHa4wcRe6agsfyEL6zqiRJqww?=
 =?us-ascii?Q?gQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27CD638ADF99CB41B32F146C39A9E736@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W26zyQh4hqT7FGRSPEoP1qMjsqBTF+qQkHaFbDEoDlymhDXpfWS4f5/uyK9SUIHbu1C5yME56BHoKC72O7jlaWwboE9SLbA1xhcFEPZDv02BH797rBuRlmPcBH4F1+2S/snKnefua2uKlMebT5BaKFaOayFDQ4GSTdBrj6NwI1jbTTApsb5kIHY7RSD+hRVG7UCWOecl8OcEvnOiPw26B2DGkJSB9AiNVf2DzBblaBZTECKJyUx6PfrWc6FY2/ymEOuTT1WDNYPB5uRvhPvh84PkaHCrNdYWputgPDQ4XhEbOIWFOnwDsqPap6R2XqzkO0YYtLAApRYOzEL6wlZ0ypANN2hRx1ybJHDXkE8NJkFSEOPY+stLI0G24p+iWmpJNq567q7zDOMrBb0bBewQW+VAdmOzKt4xAfwM5r4s45lqdDlJPIAoXz/8P1fkdyh78414qh06fiCunWxiWmmJFWdCzSsUoymY64mh8HvWshx41d6grDha/Fkh5Zn3CnAWgC3fN2hOTLsQdErvxdm6KvCxz4H7V2pAoWtVt6AuNVQxLxktj5H3tIha9djl5xRDH+mRQOeB8pb45iZjpuA7As+kXF6Cr7lsPc/HLDO6ILw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2107aa7e-c0f3-42c5-e120-08dc23303a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 14:15:22.5316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWmI14l+YMJ5pVZHydLHnUwcpVCy5sHIYrlNCb4Hw+Wn0FVhom2GGAyJxnXVhqsg5LvpnLY+yXTxi5G45HPdgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=978 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402010113
X-Proofpoint-GUID: RtzF5-grrFGFubxF3Ex4fV9OhioKL8cc
X-Proofpoint-ORIG-GUID: RtzF5-grrFGFubxF3Ex4fV9OhioKL8cc

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3=
:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.8-2

for you to fetch changes up to ccbca118ef1a71d5faa012b9bb1ecd784e9e2b42:

  NFSv4.1: Assign the right value for initval and retries for rpc timeout (=
2024-01-29 13:39:48 -0500)

----------------------------------------------------------------
nfsd-6.8 fixes:
- Fix a recent backchannel timeout fix

----------------------------------------------------------------
Samasth Norway Ananda (1):
      NFSv4.1: Assign the right value for initval and retries for rpc timeo=
ut

 net/sunrpc/svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--
Chuck Lever



