Return-Path: <linux-nfs+bounces-20968-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPsQKtol5mmgsgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20968-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 15:10:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B9A42B4AE
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 15:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB745302D512
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6936039FCBA;
	Mon, 20 Apr 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fHBcXfP2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010015.outbound.protection.outlook.com [52.103.73.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D939FCAD;
	Mon, 20 Apr 2026 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690181; cv=fail; b=bv5XGKhtUXGqNy1czgHRijldsyOiQOmyr+Z+rYi6WTL8ZGzRSllO0+Hh9/7PhHh+AgKwc8vb5RhPxV+wy5264H7MFHb7FaUlYTUU1v25kSyKOZMvPCOB2sGXweG9TNwddSwrGeRdTxQGh5LisFQAqJmGZ6QOGlaaanrX/Agy+Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690181; c=relaxed/simple;
	bh=ACMIo7Y5cF+AcUp25y7MArAMI6NJdXtogZZvTF/tD5U=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=d6JBNWhhiJJIqvOIKl8G3KSmv7WBVByHNpGX0s2ayhfUjDtDL5MHDVnc6GNWUjMqjwHfz6znKCWZxJE69EvXMlFH3im4KlqNidOkzfEQLpH9Ns36+Arirr7oz4g1Y8SGKUaSP0EbWmWpB2iRZeZwV8/qGy6TGzbxqjh3oIt+R6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fHBcXfP2; arc=fail smtp.client-ip=52.103.73.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wi3IOjR6jhLWu5DPMuRII9XkW8RVO3oVVVA02NDTZIA71XysCPKpTdZyAdxivvhjAfzTfEEZJ8Nd9ttqHlfhi7/hhmS6yqkirKvGNqVZPb6tRcHLa++TUsoejtQsGvnEX8+4ndhAz/itmVSru+P9PoVHR8bZGMEvXDRY21Nwccu9KXYZ7o+GjsqfMumAmnCDgcQYvODDWQhWUBsUJ5xkY4043zLpED5vr7bDlmZ4bxVlWGKDx+pa7LT1zpw3PMXaxoRwkmc1G/wAXMx2wb9jT0JVGKI20iehvfZqA+t7FC/iCSsPjmLd9azaccjEleWhVqRQEETVYQmIOEhZkY9jYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCT6QGLNS6K5q/VGgii3hwM1u6yNcOfGufJBfPonbKM=;
 b=eeHJRP6/m3XB57b69SyOdGIb82FiQRYgZG7mm4u6CjsVnqThmTrAIdzkUKCyE5dPhyEvV8/TK2+nZvZc1lxacAmDuQ/BtJ70vhx6ig8CC2wCl5GNE50vYCgudv7FWYQGsDHB4svGdoefN5LLDVex+Nbj2WCL+iqK2+VQU/7WiygB1MKk2K0uEkmVU7X1oPONxKnALdWyLLmcLABOga2KYer6e1r9IXVnhQV0rHv49Sr07skZ3mmf2xdQUkdl+AaNoWMQw7pvcB0Piqlc8DchnoCT0ZT7Y0/9dc/FGvsxQiSfJNstQQwyNqJcQGLUJvaApGVs9uIWx/cmRc7h4ua+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCT6QGLNS6K5q/VGgii3hwM1u6yNcOfGufJBfPonbKM=;
 b=fHBcXfP24hT8+yJ8E9t8VTNv4231AbXHSFyspNmmT9E6Rmqflne4JE55piNi2P6hGFmJubMvqeCiZj1c37A4MeBrEhym7wzBSmhMz83nJfJ8KU7GrqIyBuvTw/YM5Z9Or32fi6pidvQSxPGj4AO51nr0Xye8wlKwC6Z/xRxrtKluqSMWLKp77sjqSTVUZX6RP0NdtBaozzl2jnpYg2mVF+9XD9hYCrgkAbej1fvuWTCtAc8kx3uWNK32eBRcYvBFeOQ0U+iai1IrQ0qI3rMSOTLG1wuh8fwjyz80dVXnTsAHYcg7wgP+Is0ol4f96U44OIcd5TakyD8slO1PIYGa8Q==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by MEWPR01MB9011.ausprd01.prod.outlook.com (2603:10c6:220:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 13:02:55 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 13:02:55 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Mon, 20 Apr 2026 21:01:47 +0800
Subject: [PATCH] pnfs/flexfiles: reject zero version_count in GETDEVICEINFO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78811DDDAA116611B5CA56EBAF2F2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIALoj5mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMD3bTMitRiXcs0S0ODJPMk0+SUVCWg2oKiVLAEUGl0bG0tAEMtNER
 XAAAA
X-Change-ID: 20260420-fixes-9f910b7b5cde
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Weston Andros Adamson <dros@primarydata.com>, 
 Tao Peng <bergwolf@primarydata.com>, Tom Haynes <loghyr@primarydata.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=ACMIo7Y5cF+AcUp25y7MArAMI6NJdXtogZZvTF/tD5U=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzGfKu5jElJgn1W77GlWy6rLu1wcvOHUPa6vd+PGQb
 321WvcRjrqOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmMgdY4Y/3Ave9u+9Gyjx
 8P++yTfFD23sEAmd8fr8ws/1lc/11823y2Vk2GNRkvN2/UnpGYd0W36cvBgeutaXNajXKvf/0n1
 8AX82MwAAf19PnA==
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260420-fixes-v1-1-f564e4eda9e4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|MEWPR01MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 190c03da-ec1d-45ac-7901-08de9edd2127
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|24121999003|22091999003|41001999006|12121999013|19110799012|8022599003|8060799015|15080799012|5062599005|23021999003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzkwNmpZWk8vMWlVSmpmTTJLdHpUVHhLR29KYWZUajdOZW9WZExLa1VSUDZZ?=
 =?utf-8?B?ZERJZktyamlQRFdKM1R6RS9vVkxBT3R1SnVpc3h6NmEwOXJzWWYrcEo0MU1H?=
 =?utf-8?B?dkExbzNIMEhNcXBLbWVRZWw3RnN6bHJzSHBHUzhsaEdCdkt0d1JkSUhPdFF2?=
 =?utf-8?B?cERNUE5PazRVaEZzMFVyeG1aclZDS2ZKZ3MzclhkTjhSV21ibmxSSGtKdUtp?=
 =?utf-8?B?Qkc5S3FzamxRL3crV1BBUXJnUkNNSGJKd2lyM3h0VGxuSmhKMkhhVzZDZTF2?=
 =?utf-8?B?WU93YUxYcGNUWXUwaG1Qa1JDb1F4VXpWNkQvSlIvRmhvSlA4bzd1b0ROUGwv?=
 =?utf-8?B?Z21oZzhaS0M0VThQRkoxRkdxN2NhVmZGODlCWGFnczFGSWdTa1MvTkRieEk0?=
 =?utf-8?B?dzhBakZMbHRnYWtrOThMQnUwMS9QUHhTeU1jVkZGU1U0Q1dVS0ZaZ2YxMGpW?=
 =?utf-8?B?aGN5N0xXcTVmODIrSTN1L0ZIcGM5VkhObElnSnhLSjN0WkdVVXdwY2lEK0o2?=
 =?utf-8?B?bzhGMWtGQXYrTTMwdk5BU2ROODhabFFEaGdSU0w1Mkhnd0JTdWRqYkZ4czRu?=
 =?utf-8?B?YjZNOVZqeGVXNEpJRDg4d2ZqVjArVVUvOWE4WjZ1TnBIQnk1SW10UktqN2tW?=
 =?utf-8?B?T0hidmp2dGZLQjNoZkZ5b0M2anhNMUxuMnplMFFQMGRqbzhnMzRYVm53cmo2?=
 =?utf-8?B?WjUxTlpLQVorOStvd3l5WHZ4ekhHcEdYcDZMWW4wZExJMnZ0SUc1c1EyZm14?=
 =?utf-8?B?SkhleXBiSEJWMk5HOFVnU2lRVzJjVnNHeTB3UFFGejdOdTQwek94MzJKWitp?=
 =?utf-8?B?KzVxbFRMbWdBNzVjTVdIUGpWS3c3UjJUNGFjY2ZCRHd4MGZJYlB4T3p4QmhB?=
 =?utf-8?B?aDJ2b2RYYTJtdEZLaVZNeTFxQWJLUkNCNE13aGlCNG10Y2pSK3lyMVJYRFFj?=
 =?utf-8?B?TGVsSXNHd1RXeGNjaGZxMlhoa3dEc1hhNWw0T3NKbmNBcGdtVGlVZzNHVity?=
 =?utf-8?B?M2o2OGFsVzUxckNYZjhnUjNudE9CVERzdWU2MGZJem1FRnZOMk15R3NBZFBo?=
 =?utf-8?B?RXRNQmxrQSt6Zk5MVEo1V1U0QUtNRXR4ODFTeXF2VjhFckxGM0o4TFZVZC9w?=
 =?utf-8?B?cnVNd1FaR0R5eVRsMTNyVXlFdVdZdGUzMiszOTlHRDVBWlpOeWFneGJRQlRJ?=
 =?utf-8?B?L3h5YTJaRnF2ZFh2a0FPMFkxU1ZRdXBWNFdlTjRiV3hkOHo2YVFTOGNVTWRr?=
 =?utf-8?B?eSt6SlBPOUI4SGFuREpHM3gySFZCWExjL2RDTTRjWjhoMFdYZHpnd3ltUVVZ?=
 =?utf-8?B?Rm05LzFqUW1oWW05YTV3bkFCaUNRWkdsenBoblJxK3Z2bnRJb0FYRjF1eG5m?=
 =?utf-8?B?TWRtbHlLUGw0UENEVnoxOHZDZ3dwUDJNZkxZRjlvdlBpbW5yeUc0RUhtNjN4?=
 =?utf-8?B?bloveXdWYkRUR1VFYjlNZGcvdlJSSXhPc2FIcDBBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm1MWU5McWdUL3ZMWHovSkJIRzZoSWlZMjkyYm5PejNObHRPK0J2L1lpOFAv?=
 =?utf-8?B?eHUwa2RkTlJzM1dzemF1OWszT1RYQmkxbk5DQWtCMmRlL08wMUU4L0h5MkZF?=
 =?utf-8?B?MllPc1laS0trUXJIVW95UEpxR2RxSkZ1a0wxdWFFT01NMTRHbVR2N2FwUlpr?=
 =?utf-8?B?QlVSaTFEZ3R2NEhQaTg2QmtLWnM0S1dudzR0ZVBWRERpU2l4dnRwY3prdTVu?=
 =?utf-8?B?UEcyTWY4Q1Y3MnF0U2hwUUhsWnlObDU0YU1nQmpQKzl3TFI3YlRXQUJ0Z1Z3?=
 =?utf-8?B?aForcEIzQ1gzUmtWZXlWVk1HbmtCeGI1TEJEcmRkS0NoK1N6SVREYzlFR3po?=
 =?utf-8?B?Wng5a09oYTJkQm8rdHhwZ3ZsV0c3eFpoRncxL1F5SUpndUdtejRrTUxpNjh6?=
 =?utf-8?B?cm5RbFFyYjZoUWlMVDBjL3gxUXdFdGlnbmQvb1JUY2xKSUFKeERZeWY1RHVv?=
 =?utf-8?B?djJRS2hYSjJrdDJrYThjUUpXV1E5SlNGWUxLeHdVS1M2N3FlZkZjU3dSNzNt?=
 =?utf-8?B?NW1QWTNnZUE1d3pDTTlYcXZBM1R4NUprQUdDcStSWHppTmMyaTZ4eUNhWmoy?=
 =?utf-8?B?eUFPWFZEdmF3dzNEZysrdmdjZFoyOWU3NVRrWnpTbHZFaDJ5Z0xlc2FXWDRk?=
 =?utf-8?B?NkhNamJuUzRjNmpSSVd2S1dsZFNhV2hSMnBadlFmS1VGc0FadU82K2JxdW4y?=
 =?utf-8?B?RURGNzJlbWtEZTh2U0dWalk2RmxOb2tZT2h2VndvM2h3cVdaQ1F0VGIzNXhh?=
 =?utf-8?B?ckJqVGpqeGxxOFNjTG0wa2N3WkYzNTlCRElOc3NDUStLa2VYbGU5TkpJZzJD?=
 =?utf-8?B?dFpLOFVSZnVOQXdTaTE1VmE0T1dKeWNGMnFzem9PY21PYnRjR1lFa1NpKzlT?=
 =?utf-8?B?Y2tGbk0rVDNXbnZZR0RmYy80VCtDd282Vmx3cEpBaHpuT2FtTlllVy8rNDZU?=
 =?utf-8?B?aUxnMERNTi9oN0JrSGNKTTBTZGNPR1VxaGl1R1FuUGZRTndqdGdjaHFuVFZF?=
 =?utf-8?B?Ym5QL0h3R2Z5dTh2OW11dzF2VStNS2VSdWU2WEZURWIwaE03U3IySkFBclBR?=
 =?utf-8?B?eWJLYVlFTWRiSENiMFA5UE1BYW92ZlpFcnUweTZUVHRVelMycld5dnYwKzBs?=
 =?utf-8?B?S2s5bGxFVlhkaWw1UjdrckpIYkZBck9GZ1dJNEhFVlhYOThhQkoxYmdKVGF4?=
 =?utf-8?B?bTB6REhyZkNYT085QXBEK1BydlVwRFl0QVRHMzl0TkQ2ZnEwQVIwQnpMaWFM?=
 =?utf-8?B?akxkN1J5Wmd6YmJMamNYR2FmaVNGcEgrdDlRVFFYSUV2TlkyYS9kTmpNVTZH?=
 =?utf-8?B?YS9QeXBlZWRzVkRhVzVvR3Z4NGJGbzkvaFlEN1dLd3BEVmp2SllSNEdManRD?=
 =?utf-8?B?SmpuaFhzREhBY3lad1hvSWFEQ1JaUE94MWVjSmZzSUJVbkdUenJnSm85ZnRp?=
 =?utf-8?B?OTVnSFZhQVpMNjE1UzFmc29lUUVEaUNnUHVjSG50V1lJd1JPR0pueGJBNEpP?=
 =?utf-8?B?V0RyMDEwTTdWK0RveU9pa2NGLzZpbUdFdllMNTFEQVU1ZWRHSXBsQVNuNEM3?=
 =?utf-8?B?cWh4OC95MG12NHRMbzN3TjZSYm5TTmZ6WmpVMWh0eTJJYysvYnQ0N0ZpVVlm?=
 =?utf-8?B?dFBGV0ljM1ZZOHlab3RMSHdCQWdhREkrL3llbVo3ZmV1QWZXeDJoaFRLeE5V?=
 =?utf-8?B?cW5rc3R2Q093ZjJodkJGRjEzR0YvRmw4S0pEZnM1aTFLV3hkZStVUWFSV2dQ?=
 =?utf-8?B?SWtra0dkL0pUcnlpWDIrUW0weVY3QTRmczdxK1VjN3dzTWdJUGJUWUNvOGd1?=
 =?utf-8?B?QzhjU2tJRE9SYkpLbWRwR3djb0FSWGdWbGdsdE9EVjRMUU92ZHVqWkFDOHIx?=
 =?utf-8?Q?lOFLTTje3AyZz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190c03da-ec1d-45ac-7901-08de9edd2127
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:02:54.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWPR01MB9011
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-20968-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[outlook.com]
X-Rspamd-Queue-Id: 18B9A42B4AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfs4_ff_alloc_deviceid_node() parses the flexfiles device address from
a GETDEVICEINFO response and passes version_count to kzalloc_objs()
without validating it is non-zero. A zero count makes kzalloc_objs()
return ZERO_SIZE_PTR, which passes the NULL check.

This leads to a NULL pointer dereference when
nfs4_ff_layout_ds_version() later accesses ds_versions[0] through the
ZERO_SIZE_PTR.

Fix by rejecting version_count == 0 before the allocation.

Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c40395ae0814..d5aa6bf3ecbc 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -99,6 +99,11 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	version_count = be32_to_cpup(p);
 	dprintk("%s: version count %d\n", __func__, version_count);
 
+	if (version_count == 0) {
+		ret = -EINVAL;
+		goto out_err_drain_dsaddrs;
+	}
+
 	ds_versions = kzalloc_objs(struct nfs4_ff_ds_version, version_count,
 				   gfp_flags);
 	if (!ds_versions)

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260420-fixes-9f910b7b5cde

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


