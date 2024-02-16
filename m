Return-Path: <linux-nfs+bounces-1995-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC788858512
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 19:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BF8282019
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACEB1350C7;
	Fri, 16 Feb 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FmVAaiI0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rMA+JnDm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD14133981
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107950; cv=fail; b=GI9evBjSdGxQPNCRGJup7m0G7FB2LHn1SeQUftsYFn3KeFRKySs2zP7zmj5CPYMVcRmsKy4mymDKQUdOsHjXQnrS/BDabUk7dJX2HxjXyRKvbpsksE6XxQ290Q2QZnfMdRNQ+kv/m5PnNtfSJIcHKbTaJYmUBymLEcY2vqGxi5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107950; c=relaxed/simple;
	bh=gfsPwjsr03RBAKCRP3qUborDxgK/aRWV9c31lPe6VVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fzr9oxrWEkSRxxD9Dlwze6dv+ycqEozpbAUpNBVa/R29M8pDf9+FUDztLMsWua82ubuXiDy3Eaz7iuiuvaNf5xDQYgnyhYHIpFxgdVRxRmjwqN6DRY65H2LeUHjiKPG+Tylg3knOukrmi7wi/yo4W0sULnf0DCNDmDMo8JY70po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FmVAaiI0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rMA+JnDm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCrnwX018079;
	Fri, 16 Feb 2024 18:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gfsPwjsr03RBAKCRP3qUborDxgK/aRWV9c31lPe6VVw=;
 b=FmVAaiI0aFyrZ5RQRMKZCkgVQTbrFeTNfrYNC7/thhPanNJx+3CxMIwcRsbXGLhrSKpm
 eeArRomgjaoiEIr7FvjV4RYFBnfREQtPidJcWC3xrM+RnlvpZ6kW81xc6qLmW8mqkDbs
 yeCb5mst/bQi2298ixqMZesMld1PFqK1zOqxsHbc48ImaMOdt5KSqgZH7q6IExf7+be3
 zP9KiKDTSv1lCiTy21outgJBfRo5cAz0bJgHCzgJCsMqQxkp26Cu2Z+V0W+3AnAxf/oc
 3NGI3Nue4UZrg6aQwTsAFhx5+TKxQcWc8BGd/wOAluXgS5mmx3n5zVvGoSUr4vG+MVRp Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301nu9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 18:25:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GI09am014984;
	Fri, 16 Feb 2024 18:25:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykc7pn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 18:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy2HfrXgFrQc3P6sH/RMrEatCJznWWCViLIt0uU2w6/LKeVRmMZjBp9QPdiCodJse18JEN1FZvyrysJFhdQN1X2lOszyQ/Ag2dcgE0gKuwVO4O9S/oDUBPYJ7waLhz6TbvnGpnVekSMrbdXphTjK80c6XNnzLq+b4VHCCrLjn+OCrJRknKCkTIFbB2TKiosRYJZhTpXx97TCgns41w/ARlGsqpCW3qtvYWhJbmQ0sJLvq6MBD5wNVxwGre2xHWLrzwiOQ0s/dQBXPY372FhWf704b0HWto0mCbCe/4lQyfuOpJBuM2OfWjuPqIOxktKgxvkMp9TPVdmsSMRRqdu/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfsPwjsr03RBAKCRP3qUborDxgK/aRWV9c31lPe6VVw=;
 b=lYmUL2d1xQYNr+ck/GOrPc3xbyf7Sl1cuzCiepYcT9/JR6b9uBNqKQ4W3xeGF/gRARvp/+q85vrfx9HE+l60ripFciU+2u9lL0a3GzGSophBg4QGZ75yOCQVPSFRJOCDaA6E76bYAqWd42M9i84nho+2Jv/s23ncMjoQd4hIQEyrY1VtkB5v+9fJi9k2O5RldTIiViCLpw2+HPbXoatVYugqOgIJF56ccXbfJFTpZA+53vt1zQwDUctS0WkfEYjIBSBAAKzWQHSAxpUHT7uvERdDssVEplu95Lwkdd2j6VbSGo2RsDkQNp8Sv/ODq8yYQTHKo/kHBy9KPbh3GBJmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfsPwjsr03RBAKCRP3qUborDxgK/aRWV9c31lPe6VVw=;
 b=rMA+JnDmdZ7uR6seZ67xZcYQUHPwnqvqBKEfc48RwUdiMhvvyhLEbCyotdBpGKjZO1C2fBXJPYgfHRsJmuGwZMjAkKrOsyWuQFPg0/SOWNrPIAsc3IhYCX31l7m0iTz8/WCBcAaEHhZaLlLsa57J+sjgV9XLVoo9aZd//U959J8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 18:25:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 18:25:37 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Topic: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Thread-Index: AQHaYHfSswkUzWMpZ0KuX+oqHXrlfbEM+KOAgABPawCAAABogIAAAaAA
Date: Fri, 16 Feb 2024 18:25:37 +0000
Message-ID: <756FABF8-FA78-4D16-A4B8-B47C4745868E@oracle.com>
References: <20240216012451.22725-1-trondmy@kernel.org>
 <20240216012451.22725-2-trondmy@kernel.org>
 <Zc9kQ1Autf6xdcii@tissot.1015granger.net>
 <ac1166ca466c343f18df45094c0130947bd21f5c.camel@hammerspace.com>
 <CFBE3BDF-E347-4273-8C7F-A57E0D353457@oracle.com>
In-Reply-To: <CFBE3BDF-E347-4273-8C7F-A57E0D353457@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5785:EE_
x-ms-office365-filtering-correlation-id: 3eadfaa6-291f-4137-03ef-08dc2f1cac2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5V3WymXTH0Mn1cQHvtGty/R9peL6prV7msdsXwmnpmeefIQlWlIRkGDCtFHxMrvh2jD0deA8yl4QUOBTVgADQnqPNGUt6o8rles7Uj0D9XAMeVC4SiKv6gA7CCKhrx3Ir2sZZCGqqa8Jdfv7Gp8H+CeZxLHEACd+Euxuud31JQL+9/dKqG6/RG7QJlcWbR7J5IwwrpaIMSq27HmGnA24uaRB481iIX0+F/vcruJb04Qlug09kMjHvJ8vd51XRihne8KKx01LDyx0pESVfuUj3ASVr+4h14eakuLefmVPEDkRaDspE8IPpnvnJD1gWX3IDguNMNuB2f+5DFN5Hap5Xcc6+49+MgjLWs+hOLvdhRXerjwrtHZaodOXD2nD0/8KZp7Wk5Fj6++WlHnebp5PzYtwNj990TlxxUAXJOR4iCw4W/4CiPqhxz9nCm4oNUitKzAgzYPJcM++MavbmjMP3dFBvYut7TOEBO1XqBeXE3sk+in2vNgpEbx7Dq1m/6U6ItHR18YoFS+efxF/GEPOYTeGZg3yf/Kw2Jxn/rY6GWaS5+SEBKiF9mzkWzpdeqOkE96MlBXijmogafS8RxrrLTdtzkpED/KF/PGyWFmPA2z2yaCR1Q2HcekNRm5CcxDZ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(6916009)(8936002)(8676002)(4326008)(5660300002)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(2906002)(83380400001)(38070700009)(26005)(122000001)(33656002)(36756003)(38100700002)(86362001)(71200400001)(316002)(41300700001)(6486002)(478600001)(6512007)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K2NtdXpIT1VZenl3eTEwUFhMb2c1TzZkMlJVaTVUMEE0N2hsby9QamJBcG1N?=
 =?utf-8?B?anhBTEJFZk1ISXJ3Z2xSNTRTZWU5QUwyV0kraS9sK1B2UWZYanQ4c0w3b01C?=
 =?utf-8?B?VVM0UzN5eWtQbllNdHdyY1hFUnJmMGdzSk9HWERha1RzbWxrSUNiTHF1M2hq?=
 =?utf-8?B?VHpBRXVnZ2thdEJuV2JYdGtDZXZ4RU52d0ZLQlZ4cE8xcmdTYldmckk3Zitr?=
 =?utf-8?B?Y3o1Zmt0QitRT1BXbVphaURHWlRnTUdBaGtJb0g0UWw1NitCd0Vkbk96WXk5?=
 =?utf-8?B?cUVEMUJ4cjduMytvN3BSRk5mSFpHN3hId01KRXl1Y2E4ZWpiemx3anIwNHda?=
 =?utf-8?B?RGV2YkdVZGNwL1JmdTkyTW9CS2tud1ZGUHFVdkhrbnZwS2hWRDlqZXFKZ2Qr?=
 =?utf-8?B?emJQdCsxSmhpVDVzN2N3UlcxZTVhZDhkS2pweTdrL1duZExWOFNNcDQ2emF6?=
 =?utf-8?B?NDFSQVBHZ1JkOCtJc01mQUxwL095eUVIL0NBdHF5TUx2ZlpkYUdYMDlKZGlx?=
 =?utf-8?B?RVhabTQ3dUxZc0huN3V4NEFKVjVXNG1HTkhFWGxiQlprYWt2M00xSUFvaEZX?=
 =?utf-8?B?YWp4Tzc1bWFMcUI5bDl0K2o5cE16SVZ4T2YveGY3WnJpaFc1OVpUZVg1RHAz?=
 =?utf-8?B?SVpMT1F1V2pJUDYrOXZ3TUJhaUR5NEdhZUZYeHY2OTlhS0Z1c2NDRWcyMmF6?=
 =?utf-8?B?U2dOMEtjdUJjTFpISWdSaG5adnFteWxPRHBuQkJWemo1emxESjZYcnpVRmd2?=
 =?utf-8?B?d3MwYitNcXMvam5kdmhwcld3Y3lRNkt1dEhzODVmVGd6SlRVNldXY0pQalZD?=
 =?utf-8?B?QjA3cGpGeVRhWGRyL1pGYjJzY0syUmFIRXhvVysyWlFWQjZRTi9vTXJDb210?=
 =?utf-8?B?S0Y5bkdidFN3aFVYOEc2T0F4dCt1NXpsRWRjUE9RN0xzam1MVExGeTl3bzNt?=
 =?utf-8?B?UDRtci9Tb05uQXkvcktMTU40aGkrKys3dCtVNmx4YitCem9NMkErbEVyTUJU?=
 =?utf-8?B?cnVQb0x0RXdwS3lmd2NoWTVpQ2ZIYUpZVFRRaUwzMGdIZ243U3BlWFYrZTE3?=
 =?utf-8?B?R1YwSXRyNkk1TWd4ck4vV25nTzJTMzdQNHFSRXRXUWJMZ2RuV2k5Ykwxa1lD?=
 =?utf-8?B?V3hwbk9rV0N4bWlZWFd4RmJPWEpwcVpOQzF4V1dGOUhYYnpYZWhsdGdkMGpa?=
 =?utf-8?B?eHlVZjNSTUYrY09adWRROHlsYlpaaFRVU2lpVEh5TXNCTFJ0eFRxZDdsZ1dI?=
 =?utf-8?B?SnJvQ1VZR0pBNEN2aFlkSCs4VWgrZHlwR05QOGdDVmplc280RHV1OGpLQTFG?=
 =?utf-8?B?ak10Z2paUEtYT2Q2Unh4L2d2c3VMTmhUcHlnRVIxSm1jbEVsNVl1UjVrWG5m?=
 =?utf-8?B?cWNxT2hBNkgzQ25xcWF1TC82K2xmZk9leloxOS9sUnVmRVNBMmNFeHNLRkNH?=
 =?utf-8?B?dlBWVkZoVVlpOFBRY2phUDVGNmo5QTgyRWFrZnhmSzRtV00rcEVEa3BjZk9q?=
 =?utf-8?B?bzIwd0g4cE5TK1llUGFvdzBwVmx4VWs0UEtWdndjWnNmRkZCcjBIZGU2eEls?=
 =?utf-8?B?dHZxa3NFN0JOZjl4OFljaXVjMjlqb2hmelBVSko4TE1RSU5pZW0reWpGVWRj?=
 =?utf-8?B?QXp5ODErakdhRk5jUTJsS3RIMjlJdUhwU0pyVWZCQ0dLRVcyUURZUVk0UE5G?=
 =?utf-8?B?SDlwRGE0R0xHby81Q0FXWDZ1QzF2ODlWakkwSUpuMGZRMk5ERXFUYW9pa3hy?=
 =?utf-8?B?YU1TTjc2NGtLV3BtbXJIUFZtK0s1LzZSTko1RGdWTVNZUDZ6Wm5jSk5uSlpL?=
 =?utf-8?B?T2owQmhBZFBHRUFaL1hsQzNQQllJdFdXUXNUejBFL29QV0FIbVk1b29GdkVO?=
 =?utf-8?B?LzV4TXZob1pGNFZKQ1RJcWJaTWRzblc1VERSMU5wNjVSQms5U1V0eDE0ZFBr?=
 =?utf-8?B?WXBYNHJNeXZiNjJndnZTOVdnZVcxUW9FU0VEcGsyOVkrVjJJVmZCWmpCWFRm?=
 =?utf-8?B?azZoRElnczNuRHJRV0hYL3E1V1FMdUovOTQwRGM0NjdFaUdOV29kNnVXOGl6?=
 =?utf-8?B?VEpQaHpqOG1hd2gzQ3ZFNnQ5dnQxcVdHZzJic0FLOEtqeW9GaFNhTmlueXJ1?=
 =?utf-8?B?aG15a2pNS2lCNytOL1R5TndqT3M3SVJwWWxlY05Cb1p5YWR2M1JvRnhxK0hz?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E19C2C8C8C42FF4EBE99C6CE73AB7FB9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DvFzA7QZ2xMNwvad1DHy6mi3jE8DPm/pZtq+sUmwp4VBItpgNyl7aRml1mscSQEVOJKSUhAx+qWCOn22us3n4sK8iVBIeRGCoJSSuYBijnPMy+O7ynOJ1umeeKBJ94qHcVHZn6XIceCq3NrBI4RFSo6e8fF2Y+80h+LD7+UfR7wwWaTicSWSlEZ9Yqv6WiTz120QOJCz8j5HByBui8Vtr4D5K4IGiXPpqqR6v/lF8STp53pkFFN5Uu3ZaBYx853+dpsinFFYDRHWFUl6gb7aHtL/pQTzzUjPc45x4tUi0bhFDzVXu31pkvU5FLzqY2sUwvqv8A8DVuDE/z3cTS9clYEGXz0x4kK6bsQCYuMIHz0wp1S7fPHwZzlc6A7ZJ2pcL/vMOkPiWRiHwETou54kZKatiI5VBU+z1GjCzCI4oRRT1R87aLIKR3ypPhEp+sISwNxI9iqJ9rMhhhGr6KylO1Vuou/HWux4Miu6mvgv5mByCbrRw0QtD796taqUis32Euo4QWul0C3IxAwy4oytSUOyDhsOzjN9sF3I57nUyRA2L/fezQ80f1ea9dnZKOLEW7E7vbSuoN+lU1dx2Dhxx0KRS1V7JpQ94RDbRjaS+t0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eadfaa6-291f-4137-03ef-08dc2f1cac2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 18:25:37.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9NCL0syOi2uA9p/qsCHDyljXqZS0eZC4s66DqIg5C7nsWkctZfAdRts1Qb5+0KXBoHXz7iS1B6VfOVJ7+1kPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_17,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160145
X-Proofpoint-GUID: ev0Y8dIkB6UsTRegz_GWtcXiqdw1f1W3
X-Proofpoint-ORIG-GUID: ev0Y8dIkB6UsTRegz_GWtcXiqdw1f1W3

DQoNCj4gT24gRmViIDE2LCAyMDI0LCBhdCAxOjE54oCvUE0sIENodWNrIExldmVyIElJSSA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBGZWIgMTYsIDIw
MjQsIGF0IDE6MTjigK9QTSwgVHJvbmQgTXlrbGVidXN0IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNv
bT4gd3JvdGU6DQo+PiANCj4+IE9uIEZyaSwgMjAyNC0wMi0xNiBhdCAwODozMyAtMDUwMCwgQ2h1
Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4gT24gVGh1LCBGZWIgMTUsIDIwMjQgYXQgMDg6MjQ6NTBQTSAt
MDUwMCwgdHJvbmRteUBrZXJuZWwub3JnIHdyb3RlOg0KPj4+PiBGcm9tOiBUcm9uZCBNeWtsZWJ1
c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+Pj4+IA0KPj4+PiBDb21taXQg
YmI0ZDUzZDY2ZTRiIGJyb2tlIHRoZSBORlN2MyBwcmUvcG9zdCBvcCBhdHRyaWJ1dGVzDQo+Pj4+
IGJlaGF2aW91cg0KPj4+PiB3aGVuIGRvaW5nIGEgU0VUQVRUUiBycGMgY2FsbCBieSBzdHJpcHBp
bmcgb3V0IHRoZSBjYWxscyB0bw0KPj4+PiBmaF9maWxsX3ByZV9hdHRycygpIGFuZCBmaF9maWxs
X3Bvc3RfYXR0cnMoKS4NCj4+PiANCj4+PiBDYW4geW91IGdpdmUgbW9yZSBkZXRhaWwgYWJvdXQg
d2hhdCBicm9rZT8NCj4+IA0KPj4gV2l0aG91dCB0aGUgY2FsbHMgdG8gZmhfZmlsbF9wcmVfYXR0
cnMoKSBhbmQgZmhfZmlsbF9wb3N0X2F0dHJzKCksIHdlDQo+PiBkb24ndCBzdG9yZSBhbnkgcHJl
L3Bvc3Qgb3AgYXR0cmlidXRlcyBhbmQgd2UgY2FuJ3QgcmV0dXJuIGFueSBzdWNoDQo+PiBhdHRy
aWJ1dGVzIHRvIHRoZSBORlN2MyBjbGllbnQuDQo+IA0KPiBJIGdldCB0aGF0LiBXaHkgZG9lcyB0
aGF0IG1hdHRlcj8NCg0KT3IsIHRvIGJlIGEgbGl0dGxlIGxlc3MgdGVyc2UuLi4gY2xpZW50cyBy
ZWx5IG9uIHRoZSBwcmUvcG9zdA0Kb3AgYXR0cmlidXRlcyBhcm91bmQgYSBTRVRBVFRSLCBJIGd1
ZXNzLCBidXQgSSBkb24ndCBzZWUgd2h5Lg0KSSdtIG1pc3Npbmcgc29tZSBjb250ZXh0Lg0KDQoN
Cj4+Pj4gRml4ZXM6IGJiNGQ1M2Q2NmU0YiAoIk5GU0Q6IHVzZSAodW4pbG9ja19pbm9kZSBpbnN0
ZWFkIG9mDQo+Pj4+IGZoXyh1bilsb2NrIGZvciBmaWxlIG9wZXJhdGlvbnMiKQ0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20+DQo+Pj4+IC0tLQ0KPj4+PiBmcy9uZnNkL25mczRwcm9jLmMgfCA0ICsrKysNCj4+Pj4gZnMv
bmZzZC92ZnMuYyAgICAgIHwgOSArKysrKysrLS0NCj4+Pj4gMiBmaWxlcyBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2Zz
L25mc2QvbmZzNHByb2MuYyBiL2ZzL25mc2QvbmZzNHByb2MuYw0KPj4+PiBpbmRleCAxNDcxMmZh
MDhmNzYuLmU2ZDg2MjRlZmM4MyAxMDA2NDQNCj4+Pj4gLS0tIGEvZnMvbmZzZC9uZnM0cHJvYy5j
DQo+Pj4+ICsrKyBiL2ZzL25mc2QvbmZzNHByb2MuYw0KPj4+PiBAQCAtMTE0Myw2ICsxMTQzLDcg
QEAgbmZzZDRfc2V0YXR0cihzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4+Pj4gbmZz
ZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4+Pj4gIH07DQo+Pj4+ICBzdHJ1Y3QgaW5vZGUg
Kmlub2RlOw0KPj4+PiAgX19iZTMyIHN0YXR1cyA9IG5mc19vazsNCj4+Pj4gKyBib29sIHNhdmVf
bm9fd2NjOw0KPj4+PiAgaW50IGVycjsNCj4+Pj4gDQo+Pj4+ICBpZiAoc2V0YXR0ci0+c2FfaWF0
dHIuaWFfdmFsaWQgJiBBVFRSX1NJWkUpIHsNCj4+Pj4gQEAgLTExNjgsOCArMTE2OSwxMSBAQCBu
ZnNkNF9zZXRhdHRyKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdA0KPj4+PiBuZnNkNF9j
b21wb3VuZF9zdGF0ZSAqY3N0YXRlLA0KPj4+PiANCj4+Pj4gIGlmIChzdGF0dXMpDQo+Pj4+ICBn
b3RvIG91dDsNCj4+Pj4gKyBzYXZlX25vX3djYyA9IGNzdGF0ZS0+Y3VycmVudF9maC5maF9ub193
Y2M7DQo+Pj4+ICsgY3N0YXRlLT5jdXJyZW50X2ZoLmZoX25vX3djYyA9IHRydWU7DQo+Pj4+ICBz
dGF0dXMgPSBuZnNkX3NldGF0dHIocnFzdHAsICZjc3RhdGUtPmN1cnJlbnRfZmgsICZhdHRycywN
Cj4+Pj4gIDAsICh0aW1lNjRfdCkwKTsNCj4+Pj4gKyBjc3RhdGUtPmN1cnJlbnRfZmguZmhfbm9f
d2NjID0gc2F2ZV9ub193Y2M7DQo+Pj4+ICBpZiAoIXN0YXR1cykNCj4+Pj4gIHN0YXR1cyA9IG5m
c2Vycm5vKGF0dHJzLm5hX2xhYmVsZXJyKTsNCj4+Pj4gIGlmICghc3RhdHVzKQ0KPj4+PiBkaWZm
IC0tZ2l0IGEvZnMvbmZzZC92ZnMuYyBiL2ZzL25mc2QvdmZzLmMNCj4+Pj4gaW5kZXggNmU3ZTM3
MTkyNDYxLi41OGZhYjQ2MWJjMDAgMTAwNjQ0DQo+Pj4+IC0tLSBhL2ZzL25mc2QvdmZzLmMNCj4+
Pj4gKysrIGIvZnMvbmZzZC92ZnMuYw0KPj4+PiBAQCAtNDk3LDcgKzQ5Nyw3IEBAIG5mc2Rfc2V0
YXR0cihzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4+Pj4gc3ZjX2ZoICpmaHAsDQo+
Pj4+ICBpbnQgYWNjbW9kZSA9IE5GU0RfTUFZX1NBVFRSOw0KPj4+PiAgdW1vZGVfdCBmdHlwZSA9
IDA7DQo+Pj4+ICBfX2JlMzIgZXJyOw0KPj4+PiAtIGludCBob3N0X2VycjsNCj4+Pj4gKyBpbnQg
aG9zdF9lcnIgPSAwOw0KPj4+PiAgYm9vbCBnZXRfd3JpdGVfY291bnQ7DQo+Pj4+ICBib29sIHNp
emVfY2hhbmdlID0gKGlhcC0+aWFfdmFsaWQgJiBBVFRSX1NJWkUpOw0KPj4+PiAgaW50IHJldHJp
ZXM7DQo+Pj4+IEBAIC01NTUsNiArNTU1LDkgQEAgbmZzZF9zZXRhdHRyKHN0cnVjdCBzdmNfcnFz
dCAqcnFzdHAsIHN0cnVjdA0KPj4+PiBzdmNfZmggKmZocCwNCj4+Pj4gIH0NCj4+Pj4gDQo+Pj4+
ICBpbm9kZV9sb2NrKGlub2RlKTsNCj4+Pj4gKyBlcnIgPSBmaF9maWxsX3ByZV9hdHRycyhmaHAp
Ow0KPj4+PiArIGlmIChlcnIpDQo+Pj4+ICsgZ290byBvdXRfdW5sb2NrOw0KPj4+PiAgZm9yIChy
ZXRyaWVzID0gMTs7KSB7DQo+Pj4+ICBzdHJ1Y3QgaWF0dHIgYXR0cnM7DQo+Pj4+IA0KPj4+PiBA
QCAtNTgyLDEzICs1ODUsMTUgQEAgbmZzZF9zZXRhdHRyKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAs
IHN0cnVjdA0KPj4+PiBzdmNfZmggKmZocCwNCj4+Pj4gIGF0dHItPm5hX2FjbGVyciA9IHNldF9w
b3NpeF9hY2woJm5vcF9tbnRfaWRtYXAsDQo+Pj4+ICBkZW50cnksDQo+Pj4+IEFDTF9UWVBFX0RF
RkFVTFQsDQo+Pj4+ICBhdHRyLT5uYV9kcGFjbCk7DQo+Pj4+ICsgZmhfZmlsbF9wb3N0X2F0dHJz
KGZocCk7DQo+Pj4+ICtvdXRfdW5sb2NrOg0KPj4+PiAgaW5vZGVfdW5sb2NrKGlub2RlKTsNCj4+
Pj4gIGlmIChzaXplX2NoYW5nZSkNCj4+Pj4gIHB1dF93cml0ZV9hY2Nlc3MoaW5vZGUpOw0KPj4+
PiBvdXQ6DQo+Pj4+ICBpZiAoIWhvc3RfZXJyKQ0KPj4+PiAgaG9zdF9lcnIgPSBjb21taXRfbWV0
YWRhdGEoZmhwKTsNCj4+Pj4gLSByZXR1cm4gbmZzZXJybm8oaG9zdF9lcnIpOw0KPj4+PiArIHJl
dHVybiBlcnIgIT0gMCA/IGVyciA6IG5mc2Vycm5vKGhvc3RfZXJyKTsNCj4+Pj4gfQ0KPj4+PiAN
Cj4+Pj4gI2lmIGRlZmluZWQoQ09ORklHX05GU0RfVjQpDQo+Pj4+IC0tIA0KPj4+PiAyLjQzLjEN
Cj4+Pj4gDQo+Pj4+IA0KPj4+IA0KPj4gDQo+PiAtLSANCj4+IFRyb25kIE15a2xlYnVzdA0KPj4g
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KPj4gdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KPiANCj4gDQo+IC0tDQo+IENodWNrIExldmVyDQoNCg0KLS0N
CkNodWNrIExldmVyDQoNCg0K

