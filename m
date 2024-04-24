Return-Path: <linux-nfs+bounces-2982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC08B0B29
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0D01F21DF5
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7664D15DBA3;
	Wed, 24 Apr 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJTLNai4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HXc1J9r+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018F15CD7C;
	Wed, 24 Apr 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965648; cv=fail; b=PugHpjS+TtyqDg4pSDD/sXOUwNd4Q8uwbcUYFkMet+ytshBeSiQosQ43+ohMPg6tg+VXYht8dQYMTkQoLUL6sy6MbqXBjNZp4PMoXbLm1doYEBvCZlegIsGGkqyYoYBG27NhWnodiQgmYzv7XW34EjxdMzrH7laFsitwSfVWSuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965648; c=relaxed/simple;
	bh=sGgsPgzg2VpjFX/5GLOBvkh8oaeUa0YgzNl3u+ELMM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hQ9ERgMixWcmFREmGqFb9iyzR3jal+UldpjE1d4GZo5GzOfESyeIoIDmZpGenSyQBjvNWv+k9NEkzGN2O8403mk4MdepqMvNlQ/TGEMd6w5/2+QSCjkO43ey6FllHuhO8TjdIMg4YODBnSgnkMvaArnAA6TgMDGdd7zrAvt1EcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bJTLNai4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HXc1J9r+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43O9wvS0020578;
	Wed, 24 Apr 2024 13:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=sGgsPgzg2VpjFX/5GLOBvkh8oaeUa0YgzNl3u+ELMM0=;
 b=bJTLNai4yOGxMUBnvxLCiDRthlGRxxLFkx8vgwRmP/j7VJ7NS9T9rl9p31BD5Mx/NkUP
 rDhdIc4ZU7edpKV4TpnFeVp/DdHJWSVEKIDZL9yPl2mEE22y2XbxAsPanPi+7FdfdM+t
 ZAllXFgz26yQBlMEoP3ju/APF51R4adRtSlqQaWOPC4nKA8kyEDMbakKZoskI4v+7wdR
 Q5dxZ4VYLfQE7l60jAn6TlfjpfLI5UtlHEtwm3lHzk8KaFs+9nqeRX9lNtVgFugkuj+3
 5zSIlXc9+2FXABRpWBrKDe0o0XxexVsjleWSDx+jWjGo4f8viFMtW6B0qRWIUp1A33PL YA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2gqmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 13:33:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OD8Z1k030968;
	Wed, 24 Apr 2024 13:33:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm458u5x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 13:33:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv17wq+Lvj5wJrt5a7+HLb4eSLTYrwTOIQxA2lscpJTxlCJHNiyBhq/U18znotsamdrf1+5layEcdpv5uAdZC95Wsu6XcS5tF0zzgI2cdYiAQv8mb9a2QPDQai6f6UBCyAoz0Z1dKHre+/9S+ua6HQX9l6Y4kcEYqh/ESzYsTm22GKt9Q1aBPNTZAnHlNG6SuOwujIX3/7wXbbx0fK/qwmjmIBrLj3vRUki3Md1agadVR98TZkVUC8YVOq4jwMbVSpOUjK9lOeLHQB7sfSlqUg4Aq7ofyuCtC+iCXvJqglG1MLrVH088lwQDW6lEWke0XMkAyldsisLHQe81q2L/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGgsPgzg2VpjFX/5GLOBvkh8oaeUa0YgzNl3u+ELMM0=;
 b=OpM/tqu9Izf7wNPUhTGyMACDOxe6tzeFQq6wb8/T/UANyFJjLE+GFhxjGmriOqHGhzmZeAl2UwUcdM0hv80wD0R9BkcC0NE8pfaUJ8+/BYoxxTnE+2xcDDFj2lrOaJK06NUhujvHZkpBPnCRb/Pd69pfe2kPxCAusxqgZTb9f5vAPwxqoWMq61FDkZV7+gmlgEs48Qb1mKB65V5j5g7P5C/Tc9ajSXh8PJkP0GylO+2I7hNZf+bN2qEBLgqWZNTJ5/mF9tMXxeK++IK/5oq13Okn4jn7439hCgrsQ6u68jpZdXLjvxKQkqB7iu7P6sizzSBueO+er98R6SGWE3OzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGgsPgzg2VpjFX/5GLOBvkh8oaeUa0YgzNl3u+ELMM0=;
 b=HXc1J9r+ng+aFtz20ICiZSvQpX+zUan6G/xxXeT2S1Io7X06twycJzBkS7EoW9AQOQNVCPwflJVWdoUYuiBQOEg6+o1trnTISqfz32qBRCkf+scG3uxkFHQ64o6wv/VG7l3+fCTZ0XxDMyQEXUkYcyGWu6sLJBNccMK/cJRFnQs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6330.namprd10.prod.outlook.com (2603:10b6:806:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 13:33:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 13:33:41 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Neil Brown
	<neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Topic: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Thread-Index: AQHaleHzc3oveYbGkkq3WWVD/cih7bF12zkAgABlswCAAStOgA==
Date: Wed, 24 Apr 2024 13:33:41 +0000
Message-ID: <1235583F-8299-435B-A8C3-41DEB917D6CA@oracle.com>
References: <b363e394-7549-4b9e-b71b-d97cd13f9607@alliedtelesis.co.nz>
 <0d2c2123-e782-4712-8876-c9b65d2c9a65@alliedtelesis.co.nz>
 <06de0002-c3c6-4f13-9618-066cb9658240@alliedtelesis.co.nz>
In-Reply-To: <06de0002-c3c6-4f13-9618-066cb9658240@alliedtelesis.co.nz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6330:EE_
x-ms-office365-filtering-correlation-id: 991fef0c-03ac-4747-f796-08dc6463281b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K0VEUzQydXZXaW5yY0EyMHdaRGZHS2hwK3BHUUYvUXlJWGJQT2FqTzdOb29W?=
 =?utf-8?B?T0pJcUFyRzlwcEtLci9MWXZTSFprRlVFSU5EY2tqM0QzOU84WjBYdWpzWVFX?=
 =?utf-8?B?bkFrMWp0cEZjSVgrbVVVazJHTFo0ZEFROVhBV01GZHhJUHBYSHhGcnNIa1pU?=
 =?utf-8?B?NkhlNGgxN3V3OWlwLzIraExRa0lJNTFONDlla1hkZ3dyVjdTb1JnWlhLRFA4?=
 =?utf-8?B?R3dUd3pORDBUbXg0VUcyRHVuS0U1ZnBtQTNVbGp3cEdwRm55SFJYaWp3Q2hv?=
 =?utf-8?B?SndrSkVjSTBWMDJOVlA2MXNpT3ZHeDJ3NmdMdTFXMHlHQnV3Nzc1Z2NMdWNh?=
 =?utf-8?B?cG5JSlJ3WXU2SmNNTmxmNHRiUlI2SWplVEt5ZzYxdDV6RHplRjhBOUQ1SkFw?=
 =?utf-8?B?cGhBTVg5THYwQXVsTVYzU3pUeVB6VG5SOUFzVWlGRnZzZDVqY2hSMzNlQjlx?=
 =?utf-8?B?TGR5aFhOL0Nob0tGTHhqTExDNlhFcENwckFDa2UyODc3OEhVRmk3dlhEOEFN?=
 =?utf-8?B?aTZVMTRqTFdERlhXeTB5N0U5Y2M3czlZanRrQ3VUenkySFJBWHdqMHUxMFQ4?=
 =?utf-8?B?cmhMT01mVDBVTXh2Qld2b2h2aERnVEZRMWJSamE3NlFzTnFVRzV1OVdLZUNM?=
 =?utf-8?B?K0xROG1kd1ZJamRwTmhBZk51YU9vOWtXN00zSzJ6bDg5ZkxSVEx3bThKeHU3?=
 =?utf-8?B?bWpKVm91Ulg1ZlpnbEdXa3R5YzdjYVpUVFJOV1NhVi9pSVlrT2FRSGdFbVJw?=
 =?utf-8?B?T1RxZGlONWhoR2M5ZzN2MDBXdExDN1ZLT2xRblo0b2dPZjZFSkFlRWtkY2tP?=
 =?utf-8?B?dkJMNmxFTVR2b29wK0xCbUUzT0dkSG8ya1loSE1zZnpNdjhKWE5sQVlhdkph?=
 =?utf-8?B?TWNYNXU5ZFhSdUZMbFJYSDA0VWpxVUIyaDZIVWFEYUV2bnJ0UG9xTCtpbncr?=
 =?utf-8?B?NEg4NFhKR0t5NzVHVDhlSnpneUJlRzBUQ2M5WWxHcThzNHJaQTZlbHgrU2Vn?=
 =?utf-8?B?T2tGSTNVVVJYb3Y0VmNTYWpEVk1FOGhlc1Q3eDVoWDlQMEVmQnB2Zk0yNU5q?=
 =?utf-8?B?Yk9xRURrNy9hdDlwb3lYNW9MSUg0bTZsRkNlMGhDZ0lkTVRMUjVSMGZxcDRL?=
 =?utf-8?B?MTVZVDB0NTRKUzZlWjhEaTltZjI0RVpwbWlTWGtrSkcvaFZ0UmV3R1hacDZ3?=
 =?utf-8?B?alJTQ09Gc3lhL0UwaXRTNFA3ejVRUE51akhkeHVNaXpTcXNjS2VMcHRjeGJa?=
 =?utf-8?B?RXdZMS96K2s5QXBCbDhZeHo3b2EwL25SNk5LUEw3Z01OUjVPVUR0cHhraGJq?=
 =?utf-8?B?cnh1TzNrTGdsVElRT3RGRXNSYktucFRNcWhDaGFtT1JQTTJBZXVwd3l2UWxK?=
 =?utf-8?B?RkhkSldUd2VHbHh2QWNHRFUyV21vRTREbVczRWdIeTh2QndFcTBpdlBYMVhJ?=
 =?utf-8?B?NjROa2wybTYxVkpoWFZUU3U3MDh3TnFOdTRrT0UvYVppdGxzUUptQzV1aWxW?=
 =?utf-8?B?MElpaENKaGdmVWRYTSszMnkwVW9ySUZVZHZ3eS90VlloOXBpbmM4OHArQzNT?=
 =?utf-8?B?cXc3OXBENGRxcXp6SFEyQVBha1J1dVR5bGEvdW45K3pmb04vQm15b3MzbGQz?=
 =?utf-8?B?VXVCaVpreGdyOHBlakVDaTdvV3NYWWh1akZVZXZvVjJWbWlQZE83bWhjL21G?=
 =?utf-8?B?VHlGa211YTcrUExoT3dudkhIOGRkVU5JZkpQTVlsV0hUVGxZSlV5Q1hBOUdu?=
 =?utf-8?B?UDliUlBWVTN0aUdrWFcrT3ZHK2NvQkJQVmZkbDFJT2ZXREg1eFl4SENxeTVC?=
 =?utf-8?B?bit4SnRLb2NKRC9SMzdtUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NERnRUlUR2M2akZEZEZzOU5ob0tqc2NUeHVXMTVPQVRvVkU5Z0tnRTVwaFF5?=
 =?utf-8?B?RWxRcFhJWDk5eE5rUmEwaHBDTkgxNEN0WUxsdHhnUjBKVjJUYU5UOXcyOEVP?=
 =?utf-8?B?djZ0bjJIeFE5eW45ME1KbzQxVlJkb01teXdIQlRjYVFvaGRnc2ZaNEFiWEsx?=
 =?utf-8?B?Y2pSdVhobHJKTjlCd3EvTy9lbzRxaHNyQmZpTElFNWxxdlhSbjVBYWxSNlcx?=
 =?utf-8?B?azdQOWdmdlpXb3ZSaFZCVmRIQ2JKL3dNOG8wNkxMRkphK2lWbnV3WUc5SC9P?=
 =?utf-8?B?VFRQanFwMG1hNG0zNk1LT3picHl4L1NuS09WTWNoVnc0M1ViQUxsYWRQNm1R?=
 =?utf-8?B?WFdqUk9YZ1RKZ2cvTUhQRmVwZnNrSi9aeHFkSEJNMlJmTDhVR1d5aGVVUGh1?=
 =?utf-8?B?YVYzYlNRQU5OdXVMWUlIaEdmZnFVSHFxdXpQTUhWZEZuQXFqT3J2YU0wSS9m?=
 =?utf-8?B?QUNUUnAyMGppckdYa2czYjl1Z0pHeEJvRW9QaHBGYTdyb1dPeUNZd2NXMmdW?=
 =?utf-8?B?TTlLL3FjTmQrU053ZkhTYWRDVE1UdWpFWHZvUDdCKzVDUnZUS2QxWFdrZUFO?=
 =?utf-8?B?SXFTdlNxdnR2SXV1b1pxaExidk1HL2VuREFTbEUyUHlraytJM3RVQVlTVVkw?=
 =?utf-8?B?RGZuQUZjeFdxMWZ2WEVITUVncFhZdlBKQ0JCczhxak5kaFJhSkMwTjlZWTYr?=
 =?utf-8?B?QndWK2hDWUZDdExlSGYwN3lMSkpxUkFFbm1vc1NSelI4bGYyV09mNFlmYVhl?=
 =?utf-8?B?NnJhdUlJbDVuRndJSEU3RDdwdGxGeHA1Ti91ekRaOEdibWZ6Z0NPZzdrbVlw?=
 =?utf-8?B?UGdmRUJvazJlVHo4VGk5S2VSMGtKTkFORXN6Qk1IU1pVaHU0eFdyNHIxNGdK?=
 =?utf-8?B?ZDFOTlBTZDMwczJIUTVJeEZNZTBBbFB6V2prM2VEMTU0Z3lFMFAyWFlqZzc5?=
 =?utf-8?B?RDBFYTBXdWlwRm9NR2E3WXdQQUhjbm44SnorRlBhUVk0VW4xdERYZ29vd0pN?=
 =?utf-8?B?QXdsQkNHM3IwYUZSK01iSTBsV09hb3ZFTHcrSExzWFVGMGtsaitXQUZSUnNp?=
 =?utf-8?B?SE5aM1g4Qm9XZUpCVi9jT01CMmVrNkNheVRKaU43bEdybEJWTjRuWGh4Skxt?=
 =?utf-8?B?RzEwRXRuYmd2NkhDNVVRamFGY01aenBXc2dpQ3ZJTGcwKysyOVgwSll0eDVK?=
 =?utf-8?B?L0RMMGJpYzVDcXo3NXJCOGNnY2ZBRDJyTzhLR21vRCtuVE1VM0RKU3J3RmM0?=
 =?utf-8?B?UnlHa09jVjk3NXNPM245WmNuTVBrMUhEZmdhR0F6SXFtc0RZa1NKVE5NZTNR?=
 =?utf-8?B?SWwyNWJHdnVBOFB0SHpaaXpnb3NWQzZQV0lHckQyT3llL0czeFBaN2VXL2VS?=
 =?utf-8?B?SlUzbjh4QnhYeEF1T0ZpWGloR1VpdVdsaUovMFViYytleW9rQlJXMVl1RHdB?=
 =?utf-8?B?Q3FBYk05ZGc1RHJWWXpZeTE4K2FSTDJITGxjdWgrRUZhRkFraE12WG53MWRu?=
 =?utf-8?B?VzhBMnBPQXdrRURRUGF6VlF0eFVzcmF3ZnBhYnFwYWlGNUFLQ1graEdKLyta?=
 =?utf-8?B?cjgrdUJHVGczOC9meVBsWE0vRStMTGhKL3JzR2ZyU0s2WEpKWlptWGdLUGVm?=
 =?utf-8?B?RFM5aGVmeXhWNlM1N0RHbFltcFphSnkySTY2SnpFMmhQc3IrQUdyUURrNUpl?=
 =?utf-8?B?eHFVSmxZb2VBTi9aM1FpdHp2RUIveVJBWm4yVHAzZnpjbmlNUzdFaDRXRVFU?=
 =?utf-8?B?eWdTQ1NGUG82UWZROXdmUkJzNXV3OUJmUmtZTmQzaHdYS0dNbmZSdUFVeWlt?=
 =?utf-8?B?dUFUUnZBQWgzOHhsNHkyQmhBb2tDcVMzT0cwQXU1MUN3KzZnZzBacmttVi9F?=
 =?utf-8?B?YXdUNU9iL1BVTG9MUUlWN3VWRDV1RVZMYjNSWGRnRitpWjZ4alp4SVNORDhE?=
 =?utf-8?B?Vzc4SHZBRnpkRTNySWliZDZKenU0M3FXN3l1YmtQNExONHNwVGs3eG1UUUVE?=
 =?utf-8?B?QU9rSkp4aUV5NXVXcXRjbGZPUlNsbTlwVEg5aGRiQlo2ZUlJQzBVaiswdmRz?=
 =?utf-8?B?SlF5RDc2RVhyQ3JEbHYzWW9FWmp4d0hvNGVyNHJjSjV0SFhmRHJLQi80ZzdS?=
 =?utf-8?B?aFN3bG5sS1FSYUZ5SjFmVExXb1UvYXc3dmw2R0pqa0JIWnhacmgybUN0TkJL?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15637B22AEB2BA4D8FDFB46F19FC6E50@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	A0UUrTivyV1hLNCXWwVyeYZeN5+mLbDezpNwAU3Ut9X+j8BJ1b0I7OLPchAdPHorMRqsvR+MBtyRz3gxIRvxCAQq+I39byPokD9NPU1Yo/Zdix7QOaXUZt7YWdQ71UHXYCe4pcjiSZlPKgxqoTmvRpZ/GZAzcJaYC3uwkp6pbcYXFxX5+rx5rowqPbVBoU7QGBuTeNIGdXqjdvMLzSO4u2e7oCKC7J+OoH110nRqg0ian9TdK4HU+sq4rIsL+ORPqSRhTyULFfBSXlw9QMXgdY3XIhTc8UzikpN40m5GvUA+tcc0UooeGMhrmjpYRK8hfvbRlStVHrSDt4mJP5ddGLJeFKpqExS5mQDX+lu0mEvAIXgDI2B5a/tQq68+z723F8HuD8TNRmWm9XwMVerm8ehLe60/L1VkxySlrdf1qFH+W/Xd+UKgHOBMrtrISyn0+zaStODtXXGtMGxFEsBjTWnXiZQfSuZg0v++uG5VzW74E93/cRgUObs/6iXr59ta8MYsn5qQsQJL4gYL6NvYSImG0y0DU+ydgOaG7kGyN7pkir2gkC4DzABIpt0jD2h+11P6R2NTnzhaiF5texFmAAsBDTt09xD9+yn0ZP30E7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991fef0c-03ac-4747-f796-08dc6463281b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:33:41.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRp4G17oBdR6hvTr/XI9e+5HcLlMpvVYRoRVgi+dB90CrC5Cv4nLirPQL1qjd/OE2M/WHyjxsHrBn6p0IDQZFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240046
X-Proofpoint-GUID: Q488VO-VuCHJ_2Wo6buk3Tl1o6zqQlOX
X-Proofpoint-ORIG-GUID: Q488VO-VuCHJ_2Wo6buk3Tl1o6zqQlOX

DQoNCj4gT24gQXByIDI0LCAyMDI0LCBhdCAzOjQy4oCvQU0sIENocmlzIFBhY2toYW0gPENocmlz
LlBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+IA0KPiANCj4gT24gMjQvMDQv
MjQgMTM6MzgsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiANCj4+IE9uIDI0LzA0LzI0IDEyOjU0
LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+IEhpIEplZmYsIENodWNrLCBHcmVnLA0KPj4+IA0K
Pj4+IEFmdGVyIHVwZGF0aW5nIG9uZSBvZiBvdXIgYnVpbGRzIGFsb25nIHRoZSA1LjE1LnkgTFRT
IGJyYW5jaCBvdXIgDQo+Pj4gdGVzdGluZyBjYXVnaHQgYSBuZXcga2VybmVsIGJ1Zy4gT3V0cHV0
IGJlbG93Lg0KPj4+IA0KPj4+IEkgaGF2ZW4ndCBkdWcgaW50byBpdCB5ZXQgYnV0IHdvbmRlcmVk
IGlmIGl0IHJhbmcgYW55IGJlbGxzLg0KPj4gDQo+PiBBIGJpdCBtb3JlIGluZm8uIFRoaXMgaXMg
aGFwcGVuaW5nIGF0ICJyZWJvb3QiIGZvciB1cy4gT3VyIGVtYmVkZGVkIA0KPj4gZGV2aWNlcyB1
c2UgYSBiaXQgb2YgYSBoYWNrZWQgdXAgcmVib290IHByb2Nlc3Mgc28gdGhhdCB0aGV5IGNvbWUg
YmFjayANCj4+IGZhc3RlciBpbiB0aGUgY2FzZSBvZiBhIGZhaWx1cmUuDQo+PiANCj4+IEl0IGRv
ZXNuJ3QgaGFwcGVuIHdpdGggYSBwcm9wZXIgYHN5c3RlbWN0bCByZWJvb3RgIG9yIHdpdGggYSBT
WVNSUStCDQo+PiANCj4+IEkgY2FuIHRyaWdnZXIgaXQgd2l0aCBga2lsbGFsbCAtOSBuZnNkYCB3
aGljaCBJJ20gbm90IHN1cmUgaXMgYSANCj4+IGNvbXBsZXRlbHkgbGVnaXQgdGhpbmcgdG8gZG8g
dG8ga2VybmVsIHRocmVhZHMgYnV0IGl0J3MgcHJvYmFibHkgY2xvc2UgDQo+PiB0byB3aGF0IG91
ciBjdXN0b21pemVkIHJlYm9vdCBkb2VzLg0KPiANCj4gSSd2ZSBiaXNlY3RlZCBiZXR3ZWVuIHY1
LjE1LjE1MyBhbmQgdjUuMTUuMTU1IGFuZCBpZGVudGlmaWVkIGNvbW1pdCANCj4gZGVjNmI4YmNh
YzczICgibmZzZDogU2ltcGxpZnkgY29kZSBhcm91bmQgc3ZjX2V4aXRfdGhyZWFkKCkgY2FsbCBp
biANCj4gbmZzZCgpIikgYXMgdGhlIGZpcnN0IGJhZCBjb21taXQuIEJhc2VkIG9uIHRoZSBjb250
ZXh0IHRoYXQgc2VlbXMgdG8gDQo+IGxpbmUgdXAgd2l0aCBteSByZXByb2R1Y3Rpb24uIEknbSB3
b25kZXJpbmcgaWYgcGVyaGFwcyBzb21ldGhpbmcgZ290IA0KPiBtaXNzZWQgb3V0IG9mIHRoZSBz
dGFibGUgdHJhY2s/IFVuZm9ydHVuYXRlbHkgSSdtIG5vdCBhYmxlIHRvIHJ1biBhIG1vcmUgDQo+
IHJlY2VudCBrZXJuZWwgd2l0aCBhbGwgb2YgdGhlIG5mcyByZWxhdGVkIHNldHVwIHRoYXQgaXMg
YmVpbmcgdXNlZCBvbiAgDQo+IHRoZSBzeXN0ZW0gaW4gcXVlc3Rpb24uDQoNClRoYW5rcyBmb3Ig
YmlzZWN0aW5nLCB0aGF0IHdvdWxkIGhhdmUgYmVlbiBteSBmaXJzdCBzdWdnZXN0aW9uLg0KDQpU
aGUgYmFja3BvcnQgaW5jbHVkZWQgYWxsIG9mIHRoZSBORlNEIHBhdGNoZXMgdXAgdG8gdjYuMiwg
YnV0DQp0aGVyZSBtaWdodCBiZSBhIG1pc3Npbmcgc2VydmVyLXNpZGUgU3VuUlBDIHBhdGNoLiBJ
J2xsIHRyeSB0bw0KaGF2ZSBhIGxvb2sgc29vbiwgYnV0IHRoaXMgd2VlayBpcyBhbiBORlMgcGx1
Zy1mZXN0LiBOZWlsLA0KbWF5YmUgeW91IGNhbiBoYXZlIGEgbG9vayB0b28/DQoNCg0KPj4+IFRo
YW5rcywNCj4+PiBDaHJpcw0KPj4+IA0KPj4+IFsgICA5MS42MDUxMDldIC0tLS0tLS0tLS0tLVsg
Y3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPj4+IFsgICA5MS42MDUxMjJdIGtlcm5lbCBCVUcgYXQg
bmV0L3N1bnJwYy9zdmMuYzo1NzAhDQo+Pj4gWyAgIDkxLjYwNTEyOV0gSW50ZXJuYWwgZXJyb3I6
IE9vcHMgLSBCVUc6IDAwMDAwMDAwZjIwMDA4MDAgWyMxXSANCj4+PiBQUkVFTVBUIFNNUA0KPj4+
IFsgICA5MS42MTA2NDNdIE1vZHVsZXMgbGlua2VkIGluOiBtdmNwc3MoTykgcGxhdGZvcm1fZHJp
dmVyKE8pIA0KPj4+IGlwaWZ3ZChPKSB4dF9sMnRwIHh0X2hhc2hsaW1pdCB4dF9jb25udHJhY2sg
eHRfYWRkcnR5cGUgeHRfTE9HIA0KPj4+IHh0X0NIRUNLU1VNIHdwNTEyIHZ4bGFuIHZldGggdHdv
ZmlzaF9nZW5lcmljIHR3b2Zpc2hfY29tbW9uIHNyOTgwMCANCj4+PiBzbXNjOTV4eCBzbXNjNzV4
eCBzbXNjIHNtM19nZW5lcmljIHNoYTUxMl9hcm02NCBzaGEzX2dlbmVyaWMgDQo+Pj4gc2VycGVu
dF9nZW5lcmljIHJ0bDgxNTAgcnBjc2VjX2dzc19rcmI1IHJtZDE2MCBwb2x5MTMwNV9nZW5lcmlj
IHBsdXNiIA0KPj4+IHBlZ2FzdXMgb3B0ZWVfcm5nIG5iZCBtaWNyb2NoaXAgbWQ0IG1kX21vZCBt
Y3M3ODMwIGxydyBsaWJwb2x5MTMwNSANCj4+PiBsYW43OHh4IGwydHBfaXA2IGwydHBfaXAgbDJ0
cF9ldGggbDJ0cF9uZXRsaW5rIGwydHBfY29yZSB1ZHBfdHVubmVsIA0KPj4+IGlwdF9SRUpFQ1Qg
bmZfcmVqZWN0X2lwdjQgaXA2dGFibGVfbmF0IGlwNnRhYmxlX21hbmdsZSANCj4+PiBpcDZ0YWJs
ZV9maWx0ZXIgaXA2dF9pcHY2aGVhZGVyIGlwNnRfUkVKRUNUIGlwNl91ZHBfdHVubmVsIGlwNl90
YWJsZXMgDQo+Pj4gZG05NjAxIGRtX3plcm8gZG1fbWlycm9yIGRtX3JlZ2lvbl9oYXNoIGRtX2xv
ZyBkbV9tb2QgZGlhZyB0aXBjIGN1c2UgDQo+Pj4gY3RzIGNwdWZyZXFfcG93ZXJzYXZlIGNwdWZy
ZXFfY29uc2VydmF0aXZlIGNoYWNoYV9nZW5lcmljIA0KPj4+IGNoYWNoYTIwcG9seTEzMDUgY2hh
Y2hhX25lb24gbGliY2hhY2hhIGNhc3Q2X2dlbmVyaWMgY2FzdDVfZ2VuZXJpYyANCj4+PiBjYXN0
X2NvbW1vbiBjYW1lbGxpYV9nZW5lcmljIGJsb3dmaXNoX2dlbmVyaWMgYmxvd2Zpc2hfY29tbW9u
IA0KPj4+IGF1dGhfcnBjZ3NzIG9pZF9yZWdpc3RyeSBhdDI1IGFybV9zbWNjY190cm5nIGFlc19u
ZW9uX2JsayANCj4+PiBpZHByb21fbXRkKE8pIGlkcHJvbV9pMmMoTykgZXBpM19ib2FyZGluZm9f
aTJjKE8pIHgyNTAoTykgDQo+Pj4gcHN1c2xvdF9lcGkzX3JlZ2lzdGVyKE8pIHBzdXNsb3RfZ3Bp
b19ncm91cChPKQ0KPj4+IFsgICA5MS42MTA4MDldICBwc3VzbG90KE8pDQo+Pj4gWyAgIDkxLjYx
MTgyMl0gd2F0Y2hkb2c6IHdhdGNoZG9nMTogd2F0Y2hkb2cgZGlkIG5vdCBzdG9wIQ0KPj4+IFsg
ICA5MS42OTcwNjVdICBncGlvcGluc19ib2FyZGluZm8oTykgaWRwcm9tKE8pIGVwaTNfYm9hcmRp
bmZvKE8pIA0KPj4+IGJvYXJkaW5mbyhPKSBpMmNfZ3BpbyBpMmNfYWxnb19iaXQgaTJjX212NjR4
eHggcGx1Z2dhYmxlKE8pIA0KPj4+IGxlZF9lbmFibGUoTykgb21hcF9ybmcgcm5nX2NvcmUgYXRs
X3Jlc2V0KE8pIHNic2FfZ3dkdCB1aW9fcGRydl9nZW5pcnENCj4+PiBbICAgOTEuNjk3MDk2XSBD
UFU6IDIgUElEOiAxNzcwIENvbW06IG5mc2QgS2R1bXA6IGxvYWRlZCBUYWludGVkOiANCj4+PiBH
ICAgICAgICAgICBPICAgICAgNS4xNS4xNTUgIzENCj4+PiBbICAgOTEuNjk3MTAzXSBIYXJkd2Fy
ZSBuYW1lOiBBbGxpZWQgVGVsZXNpcyB4MjUwLTI4WFRtIChEVCkNCj4+PiBbICAgOTEuNjk3MTA3
XSBwc3RhdGU6IDgwMDAwMDA1IChOemN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyAN
Cj4+PiBCVFlQRT0tLSkNCj4+PiBbICAgOTEuNjk3MTEyXSBwYyA6IHN2Y19kZXN0cm95KzB4ODQv
MHhhYw0KPj4+IFsgICA5MS43MDEyMDJdIHdhdGNoZG9nOiB3YXRjaGRvZzA6IHdhdGNoZG9nIGRp
ZCBub3Qgc3RvcCENCj4+PiBbICAgOTEuNzAyMjE1XSBsciA6IHN2Y19kZXN0cm95KzB4MmMvMHhh
Yw0KPj4+IFsgICA5MS43MDIyMjBdIHNwIDogZmZmZjgwMDAwYmIzYmRlMA0KPj4+IFsgICA5MS43
MDIyMjNdIHgyOTogZmZmZjgwMDAwYmIzYmRlMCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDAgeDI3OiAN
Cj4+PiAwMDAwMDAwMDAwMDAwMDAwDQo+Pj4gWyAgIDkxLjc0NjA5NV0geDI2OiAwMDAwMDAwMDAw
MDAwMDAwIHgyNTogZmZmZjAwMDAwZGJmYWE0MCB4MjQ6IA0KPj4+IGZmZmYwMDAwMTZjMTQwMDAN
Cj4+PiBbICAgOTEuNzQ2MTAxXSB4MjM6IGZmZmY4MDAwMDgzOTVjMDAgeDIyOiBmZmZmMDAwMDBl
ZTlmMjg0IHgyMTogDQo+Pj4gZmZmZjAwMDAwZWVhOWUxMA0KPj4+IFsgICA5MS43NDYxMDhdIHgy
MDogZmZmZjAwMDAwZWVhOWUwMCB4MTk6IGZmZmYwMDAwMGVlYTllMTQgeDE4OiANCj4+PiBmZmZm
ODAwMDA4ZTk5MDAwDQo+Pj4gWyAgIDkxLjc2OTUyNl0geDE3OiAwMDAwMDAwMDAwMDAwMDA2IHgx
NjogMDAwMDAwMDAwMDAwMDAwMCB4MTU6IA0KPj4+IDAwMDAwMDAwMDAwMDAwMDENCj4+PiBbICAg
OTEuNzc2NzgyXSB4MTQ6IDAwMDAwMDAwZmZmZmZmZmQgeDEzOiBmZmZmZmMwMDAwMDAwMDAwIHgx
MjogDQo+Pj4gZmZmZjgwMDA3NmJjMjAwMA0KPj4+IFsgICA5MS43ODQwMzFdIHgxMTogZmZmZjAw
MDA3ZmJhNWMxMCB4MTA6IGZmZmY4MDAwNzZiYzIwMDAgeDkgOiANCj4+PiBmZmZmODAwMDA5MjIw
N2MwDQo+Pj4gWyAgIDkxLjc4NDAzOF0geDggOiBmZmZmZmMwMDAwNTVlYjA4IHg3IDogZmZmZjAw
MDAwZWY2YzRjMCB4NiA6IA0KPj4+IGZmZmZmYzAwMDFmODcyYzgNCj4+PiBbICAgOTEuNzk1ODIz
XSB4NSA6IDAwMDAwMDAwMDAwMDAxMDAgeDQgOiBmZmZmMDAwMDdmYmFlZGE4IHgzIDogDQo+Pj4g
MDAwMDAwMDAwMDAwMDAwMA0KPj4+IFsgICA5MS44MDE2ODRdIHgyIDogMDAwMDAwMDAwMDAwMDAw
MCB4MSA6IGZmZmYwMDAwMGQ4ZjgwMTggeDAgOiANCj4+PiBmZmZmMDAwMDBlZWE5ZTMwDQo+Pj4g
WyAgIDkxLjgwNzU0NV0gQ2FsbCB0cmFjZToNCj4+PiBbICAgOTEuODEwMDg4XSAgc3ZjX2Rlc3Ry
b3krMHg4NC8weGFjDQo+Pj4gWyAgIDkxLjgxMzU4Nl0gIHN2Y19leGl0X3RocmVhZCsweDEwOC8w
eDE1Yw0KPj4+IFsgICA5MS44MTY5OThdICBuZnNkKzB4MTc4LzB4MWEwDQo+Pj4gWyAgIDkxLjgx
ODY3M10gIGt0aHJlYWQrMHgxNTAvMHgxNjANCj4+PiBbICAgOTEuODIwNjEwXSAgcmV0X2Zyb21f
Zm9yaysweDEwLzB4MjANCj4+PiBbICAgOTEuODIwNjIwXSBDb2RlOiBhOTQxNTNmMyBhOGMyN2Jm
ZCBkNTAzMjNiZiBkNjVmMDNjMCAoZDQyMTAwMDApDQo+Pj4gWyAgIDkxLjgyMDYyOV0gU01QOiBz
dG9wcGluZyBzZWNvbmRhcnkgQ1BVcw0KPj4+IFsgICA5MS44MzA0MzNdIFN0YXJ0aW5nIGNyYXNo
ZHVtcCBrZXJuZWwuLi4NCj4+PiBbICAgOTEuODMzMDY0XSBCeWUhDQoNCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

