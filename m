Return-Path: <linux-nfs+bounces-1800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD02F84A78A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 22:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146061F2AC69
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 21:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A318F85C6B;
	Mon,  5 Feb 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N4oN/O83";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OpgtU2Fi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF985951
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162830; cv=fail; b=hn3bIslTNA/ii8osSTyrab3jtdsUHYCJzQc9kGvfgK+sYJkGhudU/uAiRP4rT8wb/z49mAA3UToAelIEucICXyu8x5p9oVMdBtBd9C2EP+CSDDf18l5loB2J+VpBL02PqZqA6VsIzMuOYXlEX/OfRLQm/c/Kpx9cj8Hd9EzBbvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162830; c=relaxed/simple;
	bh=/DxDHCzxWzKkWKO/6nphlNmuzPoyh9UqvMPoH0T0orM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i4bH1N7x6zr1f0cn9gjNJwONYs2WOKHTfVLXy1ZyI682LjKUhZJG11vspNlUmT7kPfcBIhuxNIKSdyI4KGsxOQYxr+2mH5rp9VFId+7JHikJ4RFQHbHSHz9gwyX7QdCUmysuHJ/1jx9tV5/9YA6PWKe121SP+K2jlaZ/d+zvNu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N4oN/O83; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OpgtU2Fi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415J3s5c028576;
	Mon, 5 Feb 2024 19:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/DxDHCzxWzKkWKO/6nphlNmuzPoyh9UqvMPoH0T0orM=;
 b=N4oN/O83gHDxFJtd8fM+01IfsY4optD6OT5OsXtrGU2hyfo4wtRr7xQC7pgZIX/MNvAw
 ByC6KizXweoFjOC28VvHfqusj3zFEbCQrJTzuy94kA/n1tyOtaRjWqgk8sU5I8bKqtde
 FYReuDgujXHulWWuE4Er7gb6fi4K/NKHHknoXfiuMH0D4uo8pbj9PJ0h1KCxDMp1aPhs
 mAGfQ8VuGHN1eSyf4AOl258pgaTpWZhprZBchUt24U+a7/SeunT+K2etvb4wE1ENgwJY
 fOcnKf4sFmu8kO2PmHeJl06Ib9BJ3iMEJEThaHMsvGm8X2iORNFssgy8osu36rBNBw/e +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3ucwu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 19:53:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415Jja5U019741;
	Mon, 5 Feb 2024 19:53:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxcgyk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 19:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZpr3Wu39fbRpABMzKaeW+ma9LfMu0VLfCr3jHIjHgcsFiFbwQ/hCjz6MNCx47Rn9W68z8Xnr8CBOUErmCNwZ/Zuqyid4mDY0vokiWEFG57Im6YWWUdFt4o0sjtZPYPaRlSpKPyIMTKjL7yhoOYfD4JPx8CVhYDGsPlvqU7TfjhU4MCvaNxtScWOc6oh9sZeE9yq9IdZOav+9SJpKCoJwDjezSk+huzkz7nrzE0rD0kTQRCk9f5a1pVwhY4DhezyTgo9O7fBx+V31rQwCS3KAfcNo/WHr2gV7VzC5foFcr0TOeyvJ5AhY4n+bTlnLE38eb8Smknoh8xrBLLQtMO1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DxDHCzxWzKkWKO/6nphlNmuzPoyh9UqvMPoH0T0orM=;
 b=N7Ty4IQd0pzDKHcA775At8czJK/szUDN+SZge6dwLjnl4/qbM8a6GRrptklnoAXCTWQbDEodNASL9UsSecpbQR1sSEoNJBkQQAEeRHaPq4HCb6ubx0FYZ/rEbK1Zw/Lr0KVxwlPhP4UjVCRQamNrUQGiOGH33zmTxS8l9kIqaCU42DeNCOKht1G+LIoVXdLrpiB0UBpQw6uz/9yjzml/4V3Fi+JcZCoWoeALG42+4OjGdtmZUzcXSV5ZwIS3tC7AtY1KfyT79DqTBVsNVnDQFoASrb+DORTCVP/SyUUBHYSPqRBYTI1K/s1M6dyEE/sGDKiKc/z//6aVm1lvUMpQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DxDHCzxWzKkWKO/6nphlNmuzPoyh9UqvMPoH0T0orM=;
 b=OpgtU2Fi0RvKK9iK8u8tyNYO0vzgevKINdNVOtjyuCS1veI0MSsGowdwIcggloIdiKystXWP26XXHnLYePpTH8gRVWGGgJqa+W+bYwItbJvYD67hRzNccyZLeA7+3tEMhhr25pJFFPJJ79zoqNCL4GydU/b1TDhtq/GCeM4zStY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB6959.namprd10.prod.outlook.com (2603:10b6:510:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 19:53:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 19:53:41 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
CC: "martin.l.wege@gmail.com" <martin.l.wege@gmail.com>,
        "cedric.blancher@gmail.com" <cedric.blancher@gmail.com>,
        Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
Thread-Topic: NFSv4 referrals - custom (non-2049) port numbers in
 fs_locations?
Thread-Index: 
 AQHaDKK/5xxTBJcRKkGtisdr07fPibBlifCAgA2y6wCABUQbgIAAbzOAgAA1BgCAeNxKAIAKcPKAgAAR+oCAADxSgA==
Date: Mon, 5 Feb 2024 19:53:41 +0000
Message-ID: <DA6AB3E6-F720-4679-A36B-01BEB39720BB@oracle.com>
References: 
 <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
 <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
 <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com>
 <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
 <8FCF1BB3-ECC1-4EBF-B4B4-BE6F94B3D4F5@oracle.com>
 <CANH4o6P2S1mOXAbQb9d4OgtkvUTVPwdyb8M0nn71rygURGSkxQ@mail.gmail.com>
 <93DA527F-E5D7-49A4-89E6-811CE045DDD3@oracle.com>
 <c28a3c78daa1845b8a852d910e0ea6c6bf4d63b4.camel@hammerspace.com>
In-Reply-To: <c28a3c78daa1845b8a852d910e0ea6c6bf4d63b4.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB6959:EE_
x-ms-office365-filtering-correlation-id: f02bbdcc-a878-4b84-6005-08dc26842756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dHjFjVfvLjXve/5npquCnH8dnHD4BfB5jN9Kl8zmhxSMtgPuXMvBuNkdHa7BqBBakxPsDL/v58Xc1MIFsZ8qK75mkSt+VmNhUIQSOGnoaQksIX6cDMRr+nmb+mJ5r7bQn6jBNU8zBG0ZSFJ3rCfhNbhhsm74XkQwbUXv6OLpTrPyQknmhpPJoEEKpBYnQ4QAx0TrLLRANziZOKbiwAJ44W0jmz284IlEWruJYAZst5rFy2RXSwbjslYn25UkbXdZNZ19kTufcrNQuV1b4hnLZRoO6JP9qn9Vc3BPf3MQmsO13U/c5Dn5m8MPncOCefMB7xllYTj5du+KN9vtdXu4oQu2sjU7nwet54wlhg/NtGF0A6VK9MZ0hw5875JOzdaKypUj7Eyp2ds+WCzf26g1Wlx9hUDNRAesXTxwFNEFkWTuCnbkYVXC0tSBtNDmgfPg1BwgdwUrwqTDb1FXYIOO/Z7eUOYsBrnFTCPdlQFSYZhocYIc4EouV3w5tTjjtZls2/rrnfJ2Q8qtSvRQv3BeokN/5XVsv6hwaP2WbuK2n/RZbcZ/sZtXbX8El7x1iiC3W8ml1u6DLoaUf/FfGqF/xso0n4LLqD1xJt7kyUEq9OpeisY1k+QSkpffYhK/a06mlmwE8UzEsf6D+FrAmcfqCA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(41300700001)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006)(36756003)(54906003)(6916009)(316002)(5660300002)(2906002)(4326008)(8676002)(8936002)(38100700002)(122000001)(33656002)(71200400001)(6506007)(6512007)(53546011)(478600001)(966005)(6486002)(26005)(2616005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UzNOTlJ1ZHR6Tk9GRFVwN2c4L3lQTXhIREVieTVPbkRpQkNqWVhGZzVsVEto?=
 =?utf-8?B?eXppZHQ3bS9vczkwOW9hano2cHBpbWNvbXJuWkhrMU9RRGZKQVF6WUloUGY3?=
 =?utf-8?B?OGZSbDJSMy8wd0xiWXIrRnlOL1k1MWhlcmU4OS9aMURJME5BWVN1endMT0k5?=
 =?utf-8?B?ZHdTdXNLWkxEbWUrVE10M1o5YmcxWDdtY29qSCs5SllTTWhXVW1HalY5Q2VL?=
 =?utf-8?B?RmNHdzNYeEdlRHNnckwzR2RPRWR0WnB2VnFVQjdYbWh2STVBdFFzWklNS2xz?=
 =?utf-8?B?VzNMbkRPSWU4KzB5VWZEQ2FrTm1NNkpvdU1McHJ2ZzdGVlp1TXJaWEkzRlEv?=
 =?utf-8?B?SVFYV0JpQlV2ZkFCenlaK0FDbi9pUElGTlp4OHFHVWhFOWhHL2JlTFRBMFhP?=
 =?utf-8?B?YVJwdTRGeUx2ZjhocGZQTzRGbjNJRE9iS2x0a0JWUWV3QlR4VTVVNkowOE1n?=
 =?utf-8?B?U05teGhTWVNSNGhscGMzb25nYzZDYnh4RG8xaUI4Zzg5NEpIZ1pUQ0NSTC90?=
 =?utf-8?B?cWc3clRmK21JYmluNUxZR1gvRlFZRGc5N1RkanhTS2ZWRDdFS0pkMDlUeG40?=
 =?utf-8?B?UmoydmxzZ2JKVVNsYVk3eW1UZzJpK1VnLzkzQnY1YjNOVGNzQitXQ21JYUdU?=
 =?utf-8?B?aDU5Mm5ORFNtZ0VSeThVYnhON2FxQXNxRHBJY2NTcEszV0F1TllkQnJIV1Vr?=
 =?utf-8?B?RmUzakwwMjNoVjZJdmFFcmxqVnRtblJWbzJJVkwycjJTVURUWG13dnV2czJO?=
 =?utf-8?B?TGhjVnF4bTJuZkdScEJiMDBHRjU3cGJGN3VyVE9CWmJteXFXaWxrdDRyUW10?=
 =?utf-8?B?TDhrL3I2V2M2OEx1eWc0WkVjOTBqU0I4RXRDMUVlNEdXU3ZHNVA4d1RvZEhP?=
 =?utf-8?B?QVpkM2RXNk1sOHBORU1GZ0tiTGRVV3NIeWdSaXhtS05LdVRtdzRhUGhJVzVw?=
 =?utf-8?B?dXE1Z1JPM2U0MjA0ZkwyRnFPNXdZK1Nxc3o4aGNXZWdnOHVTdVZRZGZsdk56?=
 =?utf-8?B?bkI3aDZRTzM1ZEc3alIyV3lNY2plcUdwOU5lNXdOb01OeEMrRzNydjRzZTBP?=
 =?utf-8?B?RGtjSHFuVGp0UVpha09JN2podXFwUXdxaEllM1RUK3pWYlVhV0UrRkhCaXFK?=
 =?utf-8?B?a2lLTzZ1RHFwN1N4dk9taWZUVWxCcTk4eklTQkRYcGhoRWhINS94TXNSV0ZZ?=
 =?utf-8?B?cllwaGVYZVVTeDNDb0J1R0VYTk9kV28yM2FXZ2pyVnQ1ZTJ5MXFsS01nVDJX?=
 =?utf-8?B?UUk3N2c4REgwUmFCVklpajFpTkQyZTZmY1ZyamhhekdmMEJhUE9SQTBUZFpk?=
 =?utf-8?B?M3ZKanRvQW1OcGFuWHlSblo0anBlYmVDWk5CTkFHd25IWXlOd2RLUU9VOFNL?=
 =?utf-8?B?VDhKNTR1WXFUWXFmMG1xVDFRVVV1cjNxUVhoNXFHcU9GWWc4SWJ4aEdtWFZU?=
 =?utf-8?B?eXlzYzJVTFR0cEhsWUtGTTZPOFA4Lzd5SnZSMUs4cktJcnQwZ0ZRSXJtZVNs?=
 =?utf-8?B?VjhZVncwTk9TZGd4NnlhdWZDdGpid0tVNTIyaWVKWHlST0NUeldTRU9Hc0hv?=
 =?utf-8?B?bVVSMzYzZXJSU05sRDhIWm1FRUlMS3UrdlRGbWtMN0hOeDI0TjZFOUFVUWpO?=
 =?utf-8?B?aUtYL3kwV2VlUHE5UDFBd0Vhb0I0aUFsU3RPRmJxVWRLQjh2SWhUblhCMzNQ?=
 =?utf-8?B?MmJiZWt2M1E4aGw1YVE1SlUwR3IrY1BGLzhhd0dwMFJmOFE2eDdUNWpXQ2pB?=
 =?utf-8?B?OFdlcGJLNE5LVHM0NktEL3MzM3VGMmNISTFZT01MZkljSnlWc3pPVFhTTTFE?=
 =?utf-8?B?S0laWUc0NHBIdnVoQ2FmRTJ0dTJuaFVaMDlrQ1hERS9zc3lSZE1FeTE4dzdt?=
 =?utf-8?B?SGdsQ3NTODkvTEFFbjZzQ3ZBTERjNVRnUWlXWWZtQlE3VFhTTFExSmdWbVht?=
 =?utf-8?B?cFY3MlcwNFpveGg2NXZsTHNqVnhvZENScmRGYjdJYmlpWkwzYTV0OWdyTEJm?=
 =?utf-8?B?VG9sRXZ5T0JTVDlCSXhNa2NaZS9jM1MvSHIreGh0ZktCcjdzNTNIUWtxYlZo?=
 =?utf-8?B?QW05UmFTeG55TkZRSWVsa1BhdTlENjZIMW5TMkh3Q1JxeTFySXVBUitVMHpY?=
 =?utf-8?B?TS9LWnRvdklKd1BSNGoxako2c3lYSE5iK1dVL0lYWTVCRTJVVHlSVkJSMExL?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C07DDF05F08407469927D2E9A78EE47C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6hmslKtkCoYWwGTOMZ824zJEmna2l5ZKal0k1KiWcydp3+BhpDoFfHoovEcJvFNVdfb9A+Uze+EqmN+n5TWXs55RUrpBwLrCvUo12iMq0xfk47UEo2P7txrW3qRs3KnoTQCk8HRafv9WItjI01KVFQByB+WQw6aDMG/t7HdByy4l8kw7+guS4eBK5VonuBFPpcvpAvdW6ZHEUqc+QQf4vn5G55mM11mORn7BX3VTGhabFLmso6Ph4Tsb/z96zl4tGILpSz0vFv0L7/Ya+rwhMeWUYKqVyKENi6wA/1L1c+14n0/ZQuPm0Fvq4YrEkbZ9Vx9FLPKdErbLLTlA++PVaaXl3iEP9aSq+a4HPf3qeiQKPz12ClmphedtSHthyqlFykGwOB7U3YAONcyC9SwuYB3lJ/Dc6L+FEIFZMLtm3f66VXHfqqH0eGI6vuDfqGb/HN4TMT6QZ+WnQpU+KmmcOH7pu6BkuRFd1byZ80fOVXZWY6bwgLNrWRS8PY9uIB8P0s31XPAU3dZ8QUaJNIZh+SwXr+9kYSVhSL0ddGFxwbJYNjWrZkOiWEKtUtV4coxUrJWjGfrABKfifuzc4r1PRr7Q2+iUIJsYkW55Vjiqf4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02bbdcc-a878-4b84-6005-08dc26842756
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 19:53:41.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRPE1NEOtFuP6/q+0Z0aNDn/NQCa6cGrltIScKNsko2biWpbD1Qc45/62AuqssVK/RUEbGpwrCleVg8zZ/yqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050148
X-Proofpoint-ORIG-GUID: _cDITfQP1Frr_aCcrd5ugPmI5PgWPrDT
X-Proofpoint-GUID: _cDITfQP1Frr_aCcrd5ugPmI5PgWPrDT

DQoNCj4gT24gRmViIDUsIDIwMjQsIGF0IDExOjE34oCvQU0sIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDI0LTAyLTA1IGF0
IDE1OjEzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+IA0KPj4gQSBETlMg
bGFiZWwgaXMganVzdCBhIGhvc3RuYW1lIChmdWxseS1xdWFsaWZpZWQgb3Igbm90KS4gSXQNCj4+
IG5ldmVyIGluY2x1ZGVzIGEgcG9ydCBudW1iZXIuDQo+PiANCj4+IEFjY29yZGluZyB0byBSRkMg
ODg4MSwgZnNfbG9jYXRpb240J3Mgc2VydmVyIGZpZWxkIGNhbiBjb250YWluOg0KPj4gDQo+PiAg
LSBBIEROUyBsYWJlbCAobm8gcG9ydCBudW1iZXI7IDIwNDkgaXMgYXNzdW1lZCkNCj4+IA0KPj4g
IC0gQW4gSVAgcHJlc2VudGF0aW9uIGFkZHJlc3MgKG5vIHBvcnQgbnVtYmVyOyAyMDQ5IGlzIGFz
c3VtZWQpDQo+PiANCj4+ICAtIGEgdW5pdmVyc2FsIGFkZHJlc3MNCj4+IA0KPj4gQSB1bml2ZXJz
YWwgYWRkcmVzcyBpcyBhbiBJUCBhZGRyZXNzIHBsdXMgYSBwb3J0IG51bWJlci4gVGhlcmVmb3Jl
DQo+PiBhIHVuaXZlcnNhbCBhZGRyZXNzIGlzIHRoZSBvbmx5IHdheSBhbiBhbHRlcm5hdGUgcG9y
dCBjYW4gYmUNCj4+IGNvbW11bmljYXRlZCBpbiBhbiBORlN2NCByZWZlcnJhbC4NCj4gDQo+IFRo
YXQncyBub3Qgc3RyaWN0bHkgdHJ1ZS4gUkZDODg4MSBoYXMgbGl0dGxlIHRvIHNheSBhYm91dCBo
b3cgeW91IGFyZQ0KPiB0byBnbyBhYm91dCB1c2luZyB0aGUgRE5TIGhvc3RuYW1lIHByb3ZpZGVk
IGJ5IGZzX2xvY2F0aW9uczQuIFRoZXJlIGlzDQo+IGp1c3Qgc29tZSBub24tbm9ybWF0aXZlIGFu
ZCB2YWd1ZSBsYW5ndWFnZSBhYm91dCB1c2luZyBETlMgdG8gbG9vayB1cA0KPiB0aGUgYWRkcmVz
c2VzLg0KPiANCj4gVGhlIHVzZSBvZiBETlMgc2VydmljZSByZWNvcmRzIGRvIGFsbG93IHlvdSB0
byBsb29rIHVwIHRoZSBmdWxsIElQDQo+IGFkZHJlc3MgYW5kIHBvcnQgbnVtYmVyIChpLmUuIHRo
ZSBlcXVpdmFsZW50IG9mIGEgdW5pdmVyc2FsIGFkZHJlc3MpDQo+IGdpdmVuIGEgZnVsbHkgcXVh
bGlmaWVkIGhvc3RuYW1lIGFuZCBhIHNlcnZpY2UuIFdoaWxlIHdlIGRvIG5vdCB1c2UgdGhlDQo+
IGhvc3RuYW1lIHRoYXQgd2F5IGluIHRoZSBMaW51eCBORlMgY2xpZW50IHRvZGF5LCBJIHNlZSBu
b3RoaW5nIGluIHRoZQ0KPiBzcGVjIHRoYXQgd291bGQgYXBwZWFyIHRvIGRpc2FsbG93IGl0IGF0
IHNvbWUgZnV0dXJlIHRpbWUuDQoNCldlIGFic29sdXRlbHkgY291bGQgZG8gdGhhdC4gQnV0IGZp
cnN0IGEgc2VydmljZSBuYW1lIHdvdWxkIG5lZWQgdG8gYmUNCnJlc2VydmVkLCB5ZXM/DQoNCmh0
dHBzOi8vd3d3LmlhbmEub3JnL2Fzc2lnbm1lbnRzL3NlcnZpY2UtbmFtZXMtcG9ydC1udW1iZXJz
L3NlcnZpY2UtbmFtZXMtcG9ydC1udW1iZXJzLnhodG1sP3NlYXJjaD1kbnMNCg0KDQotLQ0KQ2h1
Y2sgTGV2ZXINCg0KDQo=

