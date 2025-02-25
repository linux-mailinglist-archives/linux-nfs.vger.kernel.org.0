Return-Path: <linux-nfs+bounces-10335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF039A4422E
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 15:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3640189F1D5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A65B2686B3;
	Tue, 25 Feb 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLZ6/GTd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yx+A/wzG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5926A1C5
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492637; cv=fail; b=Etns/2R2JxtiyopWTy+tpvSPEAK9e6ZMhB1hTRcfmsmoyNBSQ62E9R+A5MsBLJhheUMRg6/etshuLql3efQG/qc5he7P774KRpBasS4GKGAoT3lOb6kmFaGFG6AFVsK96kNyXx4GVF0ixqws1xZPwRHaGmmMZVet5qFooTLJyDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492637; c=relaxed/simple;
	bh=tY6Md3eGxAItmWuQWVNWoF/+yOsSLaLED/4w8h73Rbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HyDGcd3OagcJtzfwqANXA+50nqqPgM0feTHMou7rYU6zjlSaSG2c8giIrvhWhaQOjTrpIm+sHSRFHhk/8HpYU27doE+2bDqE4aWhHkNejVQ4nTwlhnjiFywHqKz9yUcoZbohBVtIoVU8ov7GHbJlxBQDQyCrOP/dQ6oDdrhZaEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JLZ6/GTd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yx+A/wzG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PCfuHK022516;
	Tue, 25 Feb 2025 14:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0stlvbC/04Y7HJogkcXKFwIsO9mcRO7VFAz4dd1N9oE=; b=
	JLZ6/GTdffFk/N+0AweUF/H0BH2TWvYaPxQhEp/WulKqEvlTGV/TTQXjk479pTgB
	ZxbpkR/9DqGiCqWyAFAV084MM3Lkqnn0qeRNgU4zMmEbV0idMfxkg48Ij3ziNyDf
	rk0iiPj3HM8WjklZU/iyeNb7dIEt42Okx3bqdu8tt5OeGYKOocsEp8bf5wSTfMA4
	4MgqMAgySyvFlK1cU2mxMtiTXs6BdoTCV4iE6DqAvGOGAjsOtLlwLRwZj0eeVMZP
	FgUHg3tq4eNN0ePJfuw8x33VFCIIRBM94R9nApq/mlIAb7C1ryQlj6QKSeO4R0GB
	+Snaq3od5G2PaPdXbIOOlA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2dbdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 14:10:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PCh3F0012641;
	Tue, 25 Feb 2025 14:10:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51afyxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 14:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3KYTWd3L59pXXL+jNZwlNs9RMPLUba3MUEzSSO9GUa/crytZpqpK6GmvlT6mO9heCp0Ogn5pQCDgioxu+mE10Crss0FYRDiS/9Qd76hYc9WoYOVOq28804TLjkhiOYyiMoaDHEWMRw6jwMkYfinKFfEYb2fki4bGg9AByN3fqJPqIAepkrsLj+ZR8xRrpMAPqlymIEMVqOaTYFk7ZlC0sGtpLP1IIc29B/5smfOsav2MS/OcTW6m7CFDIQsH4zXX2dxSqrL1K9t9LIdfzUnpBk68PdTFbwpjIbv/Xy/dfQ/shx5LwLBUiCbCT01Nrabtc7R0hpQnS7J3RBP+x7Etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0stlvbC/04Y7HJogkcXKFwIsO9mcRO7VFAz4dd1N9oE=;
 b=OvYv+8Kjl7XUquhSHy4ZGpbgyoJAUCh3zDrk0HL3PXsTuF0YjY9aQWLoWtyBVu6cpE3NI3A9QTdOfSKIDEU/JJcyCtrEJ8gZQH8D2tRGVnNaVMRQtKzPefsNkAWeujrZYJf8oJM9RAAj/JBqzHM5ZZDGN8u5/kd2XhDYnKJVsyni4DnO9HZtGXJtv9xNgOceQ3h4lY5OwM2GnUYxM52h8cluOcM42HSA/0MVo41+V1Ywd38mF7F6sUVe2R33qGFkksOifjO0QSanWsfByFWfiAAx429ZADVlQheLviQ+cxbnZLorldK5vaqmIAO7/NpseJQaxntAI0y9m6wTFQvyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0stlvbC/04Y7HJogkcXKFwIsO9mcRO7VFAz4dd1N9oE=;
 b=Yx+A/wzGD2m05FZ7gQt+wxXXq36+uFT3vjnPFx0nwKncfG7Omc2/mLhTk1FdcAjs78kqYoj5RzzrSFAjqGXBlwe3UOk5hsr5ykzHD4WiP6qlmvHLBawzk5fWa1cNRtJP5sNNGiKBAEtIdkdjyCN8M00jGpJrUCnT2WpryZwqOMU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 14:10:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 14:10:00 +0000
Message-ID: <bebce613-9b88-44fc-9035-fb5b832a1918@oracle.com>
Date: Tue, 25 Feb 2025 09:09:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]Is a Kernel Timeout Recovery Mechanism Needed for
 Prolonged User-Space Downcall Unresponsiveness?
To: Li Lingfeng <lilingfeng3@huawei.com>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Yu Kuai <yukuai1@huaweicloud.com>, Hou Tao <houtao1@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>,
        Li Lingfeng <lilingfeng@huaweicloud.com>,
        "zhangjian (CG)" <zhangjian496@huawei.com>
References: <c44533cc-f625-4eda-b47b-c6f6dd01c991@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c44533cc-f625-4eda-b47b-c6f6dd01c991@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:610:38::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 61758c96-a71f-4347-fcee-08dd55a6176d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODZoRFBEQmdjSFJBdytMTldIYm9DdVR2TDAvcDhwMUx4K05VWStTOFZ5UDZV?=
 =?utf-8?B?UXNUZXZtODZ4NnBic0hXdE9LQ1k0dm5HRm00ZUJVTUgxb3hsd0JrUGNvWU5S?=
 =?utf-8?B?aTNkY1dkMDRTREZoWEU0SW55RFB3b2JJaDc5Vjl2Z2NOYW8xbHdwUlphenVq?=
 =?utf-8?B?T0cvWVhGOEwrN2QwK1FUR3A3QVZNbmk0c0l1ZmNrcERFWUNnbzNGeWZWck1S?=
 =?utf-8?B?RHB2WTJPWjdlNi9jWEJIUWp5eldtR1Q1Y1o2WW4rZ2pURUR6RUNSdFp6OGRs?=
 =?utf-8?B?RzdpcEtYNkt5OEpVbWlxOUZPTVR6TmJrWHh2elZBU0lTaDBwWmdWOUpaaFRP?=
 =?utf-8?B?S1RaWUNQSGJKTjNLeGJRVkZLcjF2OTNpUDFBdEtKbS9jcjNVa1NjdWQ3cVBM?=
 =?utf-8?B?ZGJUSjhnaVhlNEJDVGsrUEpmbE5qdzVvRnFNenQyS3BRckhUd3JERkR1MktM?=
 =?utf-8?B?dk5NNjlnUXpwUE5oMTZEUTJCanliV0xrb0Y0YWVRMTRFbkFGaysvQUFudU02?=
 =?utf-8?B?RUtTUUFaZW85azFnUENzMGU0Q1Jxa1RqczhmT2I2bStpSjRJTE5oeHdHTS9x?=
 =?utf-8?B?bG5Cc21VRW1NdXJadmJwZVZYcVNVZzY4MjZSRnllVlVMNHE1Z1gvR2FldzBk?=
 =?utf-8?B?QWJ2MWRndFFHNUhIZnNkOHRrdDJCTU9seTZhZHJPb3pjNXg4OUErZWhpM3kz?=
 =?utf-8?B?MEU1RjJNNGNBeExMR1JvZmhIcUZ3OXBZMzR4RjY3K2ozK1RoaW5USkV0a0Ju?=
 =?utf-8?B?SVlLekhGZlBIcjZNdVFvVUYrb1lwYldDRHRiazM4a2tYV3VjTlV6c01VVUI5?=
 =?utf-8?B?eStaZW5HYlkvNlNPbzJrWkhVRGhiTWpLSnZJVUM5bDNJRTZLVHFjNUJuTnNu?=
 =?utf-8?B?MnZ1NW1wdjFNaFZLanpBOHgrYjN5WUc4aDh6MDJpd3hYVHYreC9haEJOK0Yx?=
 =?utf-8?B?TUpnaURaazVBalljb0k1YzhRZnRIcm1QM05MN0ZlM09MK2UwcGtpdVNYcC9o?=
 =?utf-8?B?bWwvVkQyVDU3TXBLZDhGcTRHUUwzQ2JSb0poSGlCdkJuZTQyeVZSQnQyK3BM?=
 =?utf-8?B?b0NsZUkzMjhWRWh5MC9KRTRUbHFWTTJLcFVLT2M2THo3WmxEUXJUTlpsQXFY?=
 =?utf-8?B?d1c1ZDB4MGZWcWNjV1lyek5ZbWxpaklVbXZnWWV4K1czaWhZNlNXUEtBSVhZ?=
 =?utf-8?B?NzlpTzdKQllWTE91V096ck5mWUFPcDdnQlhxNHIydFk2VDd1eHlzRy96bGg2?=
 =?utf-8?B?dk9JakhDckxOOTQ1ZlV2VHE3SXlraVRyY3hPOERaRjhoMitnNE5uVTdGakRn?=
 =?utf-8?B?Q3BPUVcxT2VrWW1QK0xQaU80TS8vWnh3TFZ5alJsUVpMcU1oZnp1QUlQY3Fq?=
 =?utf-8?B?d3RmMjBzMDlwM2ZsRTkzcFdNamR2dCttVngrQTd6dHFRaWlzUVpTZWp2Q0dp?=
 =?utf-8?B?aTg4dnJnbDEzL1VzZGo2WXdCSEI3dWozUWhGNU15azBQdTFNRi9OUVlPblNX?=
 =?utf-8?B?SEE2Y0MxYi9SUzJicmp5aE1OOVg3THZ1Q1psZEZBSjFlVXAyalJUL3dkVTBY?=
 =?utf-8?B?dGM2cFZQa2w3UElDcU05d3hHNnMrODBSUnErUWxtNWlVZWNQeGNncFdMR3h6?=
 =?utf-8?B?dXVlUUkyTjVXL3AyOU1IRll2NnhXSFNIdG5oaUNJa2p4M0srMEVYVjJQZExQ?=
 =?utf-8?B?VUxIL29FbVJLQmpSSlFrQzZrL2YrcVdRUVl4L0xCTlRidWtwaElsRnovZkJP?=
 =?utf-8?B?NE1nYlNnNmltM3pFaE5BeVFhYVdWL1ZHc2M0Vyt2RGIxRnNSWlRSTWJGeG42?=
 =?utf-8?B?YUNnekw4K3ptY0Q1NUJGQWFCeXN4VWp3TUdJM1lCMTZ0RTBTS3ZhZzMrcGZz?=
 =?utf-8?Q?ec3mgODiQl76L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2ZMd0pKWmZaZk5vbjNHZU1RcnU4TDNLRHFBWFFGZXF0K09mVXFMK0cydUpo?=
 =?utf-8?B?cS85VEJiK0lILzdqY3Y1QnhtUlJvWXdmMjk0T1llQzUxWTMzWVNJclBqOHgv?=
 =?utf-8?B?VlJMSmZvY1EzRXNieENXQ1QzdFQxRGFCM2JzTUVVNW1rT1daQ0ZDemhMOWMx?=
 =?utf-8?B?dlRBQ0luWTVWdU1OSjVQS1hOUFkxc1doVnV4eWEvSytYemhBVWRQL1J2cnhB?=
 =?utf-8?B?M1FuYjNLRmlCTE4xaHQrWnI0WmlpcHB2UFRGVys0WGhHdTB2NlVGNi9rVDda?=
 =?utf-8?B?T3JjSXJiejU2Sk9ib3NCdmp6VlhUWEExMy9ydjR6NXpXTHd2c1JJdEN3TVpZ?=
 =?utf-8?B?L1Y1czRwd25MZ01hMjNOdDdtT1Z0TGFYNlNjbmlhSGhaZlNuTmpCSGJhK0Jy?=
 =?utf-8?B?TnVaeDY1Y2t6bUUveDhxaEhYMlhibVdhZEEySEh0REhDYmlsZ2lwRjJFSVd2?=
 =?utf-8?B?L2NTTGpDRUhGSFgvZHQxY0M3Znp5T3B3RGV2ZVpuakN4TURBcUROQVFwUml4?=
 =?utf-8?B?ZkFvcEdGRGUyeWs2SjlDTHJDbDBlRTNGTGh1Z0VRZnNtd1ZUOVhlMFZ3aUxw?=
 =?utf-8?B?L0JiWTdHUDNKSTVEaEtnSDZvUzdseFJjaDJIVnlYcXNJTlowUGsxS2taL2tD?=
 =?utf-8?B?Q3pPbDNtNUlLWE5ucnhtNVQvV0FFN0dwenNvcDhaaGZXaGF3WjhhUzV3V3RU?=
 =?utf-8?B?V3NkV1M5K09GWWNXVVA1Y1BXeFplZGpISjQ4dUkydkdCY1lBR2ZRVGUyWGJq?=
 =?utf-8?B?VHc3aGR6a09IWTNlck84M2poL014N3pHY1RkZzA5Y2Y4UXp5d25weWN0ZC92?=
 =?utf-8?B?Y2twaW96b0gvRDJITDREVFNvbElXc0hXNnU1aktPNWtyQVluUEt3enJNaWJm?=
 =?utf-8?B?RkgxUGtramtjZDRCRnZCWC9UZnhCMFAzY243T1FQbUlvOVZIN3EvaXV0WG9U?=
 =?utf-8?B?amZuN1pVQmMzdm0yMElyTWd4WmRycnM1NmJreFBkUzZlSnlNMm8zMUFHbU5I?=
 =?utf-8?B?RDQ0cmZYVnBhL1lRSHlUbVZKSHZnNUpXQXRGSDVBNGw1RzF0UmM4VG9uYUZX?=
 =?utf-8?B?bDdzaGpvQkNwUmc3SVp0QnFJMEhwZFliVTZjbHVMU25pVyswRk1CUkltMXEy?=
 =?utf-8?B?YTRqbEtGVlpCckQ4bWYxcnhoTm1DOGpDM3J0a3Z0SHJVS0dHRW9yVUVNaFFt?=
 =?utf-8?B?cXlvZkZVTGdQbTF2Yk1nNlhEYjBXVjZEbUJMZCt1TzdsNTNzR2tlYUZVZzl6?=
 =?utf-8?B?QmxOeHZtQnp1bGEwNHhMMDJiQlk4cjFPaU1QSERTeGNtYysvYkpFN0VYb0pa?=
 =?utf-8?B?RmhYY2lDbXNEL2dvN1dhODFQWVdwU3pocjdQUXJOZXJOdUdmazhEQ0g3NmEy?=
 =?utf-8?B?dFUrZHUyZ0dmc3V2S1NWYjFhb2NTdURsc2tqWmxCblVZNDYrdXk5MzY1V3Rk?=
 =?utf-8?B?SWRxTXJQOVdmWlkxcExLZktKcGNSVjlDc0VFanZKdmgvMTAwZ1RQOWxHWW82?=
 =?utf-8?B?RXcvQWl1OXpBbFRXQ0NIcWpWWGJUc2E3ZHFlUkxGVktTQ2hSYlllcnE5RXlW?=
 =?utf-8?B?d05uSFFzYnNodVAxcTFOSTJnZGVMU0xrOUVocGIrZVZDa0E0dTlCTy9HUnYy?=
 =?utf-8?B?akl0ek1tRXphcDQ5dkJJT2VBcklpOHdPUWZ2L0x6OUk1aFp0L2xpY0JGaGZT?=
 =?utf-8?B?cDUrZFhYUGE3TUlOMW8xNFV1eHBmMkhPN3VoWm90N2h3N1NaZmlLazdMMjE2?=
 =?utf-8?B?MnFoa2prQ2taQ3BQRG00YzJ5cGc5aGVOS2JydmU5ZWJRZkxvdTQzMjk4dERF?=
 =?utf-8?B?QU0zZ2Y1NGxOc0c4QU9ac2hnY3JQdlRoTFBSUklhNDZnYlQvSUhHN3dSY1lZ?=
 =?utf-8?B?QmFHNDdMTzBtVURLYjdzUmNVTERsM2V4UXAxb2YxRmVYY2V2Wjlwa1R4QXZG?=
 =?utf-8?B?MHFXNDNCc1pNQU1sbmdjNUoyVEJQbHRiNzVScFJscFhUZGh6UE5heXVZM3dY?=
 =?utf-8?B?Q0pURGpYV0tDbnl6WUZIcEZMTHpaMnhiOW40eXcvVWl2Ymd4UTQwbGk1enFL?=
 =?utf-8?B?VVl3dTVxcnRjRlhsTm1sK09jQ2xIdzR2UjhTVWRPQWZXb09NRXZFd1ExaWlj?=
 =?utf-8?Q?tgFGu96CZHeeq2teT7xJUnd4z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TnuLDIw01X5KAMfr7HN5fvMG6McaCLFI+GBqvtBs7S4j243+gLPqzdKo71G9/41bwaxgONv2Q1zDNtJQI46inZ30khPDcKB4+Ye7mgJt4TOIpHyfW/NJMZYzSvHTHaSfhHSTftvidmOS/wxZfiXsmx3GvCsHBy3WJONWj79S7jY3XrbhMSjTByZHoUWyiL/seuKZ3WRXdR0Owq+xmlS67w02qHIW1kCpEaCxqPjnfs9jqbfPTmHqme8n6P/ecziRwCTud0tsTnUmofiHuJvXuss43CNHSIVUhJhBg/MGdFOKO68yAOxBvHwpJPD9gHCoADZqLHcwri8Qg+k5G3Psc+dQ/12tzAfeC89TS+EaHhU3d6tE5OmujpufLvrdonKHOoZQ6w3H+9QF5OupiI+v+hTgHrrbB5VdoXPjB+ntOEXhw4Lo06wIrkrMOxkIk227WKzTXotB7yiRVKkyAv9uX5BeM30LSsjZKmZtj1ipyiuXWrBJJmhObtuzT/h+/qEv34chL3JJ5MX1gFKEJVays1L+t3nXko74CZ81m1pcMcsfLyuzIX8jVmSooI6W+Wo55Z0KsO3iUuKOzNv27W3Bg7gLFGmoHp64lmu1RykTgUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61758c96-a71f-4347-fcee-08dd55a6176d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 14:10:00.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY9IokJsM6dbZI9kwtSjtzr7RPt7OwGps3b1GBDZl+kUyzKL+yGH+i8LdrLerPpK3vnYa7lFjSRRwl6zTYcvFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250096
X-Proofpoint-ORIG-GUID: AyoXrKcRKmydXa9d16uc5k8Bt5AsfVFF
X-Proofpoint-GUID: AyoXrKcRKmydXa9d16uc5k8Bt5AsfVFF

On 2/25/25 3:51 AM, Li Lingfeng wrote:
> Hi.
> Recently, during fault injection testing, we found an issue where nfsd
> process cannot exit when /proc/fs/nfsd/threads is written to 0, causing
> other processes to be unable to acquire nfsd_mutex, leading to a hungtask.
> This is the stack trace of the nfsd process:
> PID: 107326  TASK: ffff8881013a4040  CPU: 1   COMMAND: "nfsd"
>  #0 [ffffc900077077d8] __schedule at ffffffff9c6434b6
>  #1 [ffffc900077078d8] schedule at ffffffff9c643e28
>  #2 [ffffc90007707900] schedule_timeout at ffffffff9c64bf16
>  #3 [ffffc90007707a68] wait_for_common at ffffffff9c645346
>  #4 [ffffc90007707b38] nfsd4_cld_create at ffffffff9b80626a
>  #5 [ffffc90007707c40] nfsd4_open_confirm at ffffffff9b7f41d9
>  #6 [ffffc90007707ce0] nfsd4_proc_compound at ffffffff9b7c872a
>  #7 [ffffc90007707d80] nfsd_dispatch at ffffffff9b79f20d
>  #8 [ffffc90007707dc8] svc_process_common at ffffffff9c4ad9fb
>  #9 [ffffc90007707ea0] svc_process at ffffffff9c4adf15
> #10 [ffffc90007707ed8] nfsd at ffffffff9b79ba18
> #11 [ffffc90007707f10] kthread at ffffffff9af908c4
> #12 [ffffc90007707f50] ret_from_fork at ffffffff9ae048df
> 
> This is because the nfsdcld process exited abnormally, causing the nfsd
> process to wait indefinitely for a downcall response after initiating an
> upcall.
> Here is the log of nfsdcld:
> Jan  4 02:22:29 localhost nfsdcld[696]: cld_message_size invalid upcall
> version 0
> Jan  4 02:22:29 localhost systemd[1]: nfsdcld.service: Main process
> exited, code=exited, status=1/FAILURE
> Jan  4 02:22:29 localhost systemd[1]: nfsdcld.service: Failed with
> result 'exit-code'.
> 
> Memory fault injection caused the kernel to report cld_msg in v1 format,
> and nfsdcld parsed it incorrectly, leading to an abnormal exit.

Without commenting on the timeout question, IMO this failure mode is
problematic as well...


> // Expected Scenario
> nfsd4_client_tracking_init
>  nn->client_tracking_ops = &nfsd4_cld_tracking_ops; // Initialize to v1
>  nfsd4_cld_tracking_init
>   nfsd4_cld_get_version
>    cld_pipe_upcall // Request version information from user space
>    nn->client_tracking_ops = &nfsd4_cld_tracking_ops_v2; // Initialize to v2
> 
> // Actual Scenario
> nfsd4_client_tracking_init
>  nn->client_tracking_ops = &nfsd4_cld_tracking_ops; // Initialize to v1
>  nfsd4_cld_tracking_init
>   nfsd4_cld_get_version
>    alloc_cld_upcall // A failure is returned due to memory fault
>                     // injection, and the upcall is skipped.
>   nfsd4_cld_grace_start
>    alloc_cld_upcall // A failure is returned due to memory fault
>                     // injection, and the upcall is skipped.
>  nn->client_tracking_ops = &nfsd4_cld_tracking_ops_v0 // Initialize to v1
> 
> *I was wondering if the kernel might benefit from having a timeout mechanism
> in place to gracefully handle situations where nfsdcld is unable to send a
> downcall for certain reasons, ensuring that the nfsd process can exit
> properly.*
> 
> 
> Link: https://lore.kernel.org/all/3e26c767-f347-4dbe-ae04-
> aabe8e87af12@huawei.com/
> 
> 


-- 
Chuck Lever

