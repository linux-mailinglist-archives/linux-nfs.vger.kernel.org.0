Return-Path: <linux-nfs+bounces-1461-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8CF83DB29
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 14:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632B41F24C9C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F81B81D;
	Fri, 26 Jan 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NfIdTR0H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Isl3YNGj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347921B810
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706276971; cv=fail; b=nlAriFkprcoaSz3df3KKsxGLVmx2wBs6SxTxHPwoHMNPof/MujgQIx07XErSJNgEyKCTGV5Z6zUgUEhI//Dt8Flb3hTTuiz4UqQ9xY+l9gDzxj80D8nZTvez1XY0UySgnAS/vivLZV/ufyjVHSd14CtkOwQTTB2ZpVRKegqs9zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706276971; c=relaxed/simple;
	bh=wkmqQiJZfUDy4G32LZuN47QESU5uXtqSVFi07ntqEzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D33uFsS9yRcY9PEjoVxNj7aH/ddE1K46rIxIP6au3BkaVllMqDmDyqQT63hZfPq5/H0xKhT5jccDmI/zo8ee6QJLtRH1LieEDfTJGq1j1M6ZRiY/jUPap5vhHo47rlctnlYOWoEfrRk2iuobNlvHhGTypaG4OXwmuYYXm+gUgmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NfIdTR0H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Isl3YNGj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QD5is1016856;
	Fri, 26 Jan 2024 13:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=wkmqQiJZfUDy4G32LZuN47QESU5uXtqSVFi07ntqEzk=;
 b=NfIdTR0HASwBZAf17//SqrRqDNqiRL/kxANzCIcbp9Dhtv24zsprIV6YtmYe/v6ui1OS
 DZIvf1v8YVA+DLKuDZl6G0/HeU4us26A4Xyiko5tpboeqcOLUkAUQXmUfe0a+C5DtcLj
 isy44VAJJd3rrSWxMuuXfsxcB0fKag9tUe8bngfeS2x0HpMyDqQLFekutvNOQIOPu55S
 9qUekCSa/yqwyYQTZjDRHR5S/6J1OpYWiKQAkzm8UUiPDsN1b3CRq3jDEkF2p4cponDR
 NrIelrvwsP2PAlnrKhDcWK0W/UsamxsQFOZZHi9TZtCIWdkRgCWt2eIFNHS/zI5kYfPH qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7acab0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 13:49:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QCkghv011688;
	Fri, 26 Jan 2024 13:49:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs327dhc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 13:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN7V/yAQrlDCVmMUzhFfV76xpQhEV7aIHy05o2+H7lkO5KhMWekqAGmv9cIyDdqWft9YTwbdBisPE5v2/QDVTcqy4rKCD8/0ubJmQECo+tH25fNFyjbjpSB96JnLlglped0Dyzpysx+c31IcMk6tmdrQu4q9dDwDm9aVFhto5JGUnsZJLTYNujDyN0EOZ2SZZKrHw+2Cim5A0RCidcJZEPaMWBo81HHAIzb0+HkLIeXBu6V/5vdC2tVYNmA8IkQ4AinriguwPEjnyhnU3XCVSosR5gXj3x/JL0OQtbPp6qkSRGfnAGoAdeHWsORfDcXhusSMvVlGpyXZx+Xz07wRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkmqQiJZfUDy4G32LZuN47QESU5uXtqSVFi07ntqEzk=;
 b=Z/4slFZu/dbh2j9Fg7fIoRC/jl0tbYUCmKdaegmYvukAD2KgILvG4UwACsLrE52tIWstEOEP/c+V1WX9NNj5rTPXRAGPofvcCi33SGUyEevnOYoQa4O71nt07scEg5bYEFyV/UmQ30Py8qvENl0N6grSzteBWoexT3Iyj2XrMIpVoAx1AKSfnldSKyoKDueIrzNVxyvO5AqRk91dQ+1OA8fVIjZNcof6OwRihHcvsHaxlSmYs30U3WjjcT2xRhZ3qYWQlF0Sl4xZ7W0vKIMReS3nwcYuAP1G0tH9yF84AFR5SbCMsrJJG7hOhwx1SHV/33DAY6C8tVloTxA3yP30xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkmqQiJZfUDy4G32LZuN47QESU5uXtqSVFi07ntqEzk=;
 b=Isl3YNGjQF2EZNCoYL7L9W56IbkvhWBLWbUktgGOTUJYFhrGbvUanOEEKvYQYXFBNamumuSlYlxkMRXwWntmXNMqhJVduI6Hs0RpJpF4LAc159aNWyXTNsldYqGEzLIfBqNL2LDzjti+sBHIGGb9DWUmSE36dFF6VIY0nRNJfos=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7827.namprd10.prod.outlook.com (2603:10b6:a03:568::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 13:49:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 13:49:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-team@fb.com"
	<kernel-team@fb.com>
Subject: Re: [PATCH v2 05/13] sunrpc: add a struct rpc_stats arg to
 rpc_create_args
Thread-Topic: [PATCH v2 05/13] sunrpc: add a struct rpc_stats arg to
 rpc_create_args
Thread-Index: AQHaT8g9lEOMQ1zTVE23wmKMfARd+7DrAYIAgAAQ9gCAAQraAA==
Date: Fri, 26 Jan 2024 13:49:22 +0000
Message-ID: <BD9E256B-784C-433B-B63F-240E8F76A5E9@oracle.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <4cc2a7aca55ff56ac3ced32aafa861f57f59db02.1706212208.git.josef@toxicpanda.com>
 <ZbLKRC1GkiKUkK+L@tissot.1015granger.net>
 <20240125215406.GA1602047@perftesting>
In-Reply-To: <20240125215406.GA1602047@perftesting>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7827:EE_
x-ms-office365-filtering-correlation-id: 7cea9a66-5467-4246-acb5-08dc1e759a27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pUyf9eUSQfeLY1ujXMm2GVGWQZV78mFp5PLP4z7c/FyksrvcLwlSfTZpohecOtxABS1I1OSUUXUrAVA6DszdGio/2FXWa/JQBdFA93K52KKqPpMdujNaxhZ/3NogC6FFs9nitTlDaC58qUZ2GztnTPtIBJBmAUgKnumLSStB3hrC8L1FEVOlCKz/ic0K/ZV4u+bjNmBoxJYvokwkE1Z+H0kSYx9+rCtprFnRzkcuxhevk4MuEDmRYgUO1fzVk8ogb+mi6d5CwKfrSS7Of6d4HHbvxVb0dC7TDlg9rKOQxvesJB44IdtvDAMC5zxfXztxiPU95igjwQKS5cwuDw0P0j3ZOxotNU/7edI2SaObgxr3SU9EJVGKYWQX5SjM2bXe7dfxvLiUwJtqVspg4yE1jk1EPSNWm56OLD1sWaKByWvSGs7c9cpAcohfFRMDSQr00+XKVnyGaY0vJmTGMxFFtrRDfxdugnI9X1oJyKUekhAIugd9gE/DeL6ic0h74Ny/giJjPPT6LpdSL6OiREQagpB0BhCnwC2OtEL08OB7eckZWLGO7bcnv3OdaqcqKg2f0Pbn44o1SOZYWTKISccai2so5KvZMkDT4DLOFYPiVDQtRTASO4fOcSU4vavYOzYIrSG25ih8Z2t6y360zrDIZw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2906002)(66476007)(36756003)(86362001)(83380400001)(38070700009)(38100700002)(53546011)(478600001)(71200400001)(2616005)(6506007)(26005)(6512007)(122000001)(6486002)(8936002)(66946007)(66446008)(54906003)(33656002)(4326008)(64756008)(8676002)(6916009)(316002)(66556008)(76116006)(41300700001)(91956017)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cDNRdTFzb1lHUDlMVVpPcTN5TWZPeEFtTkRYU2VuVE5nYitjeDd0cGV4L0cw?=
 =?utf-8?B?Vmc1WGkySEtvUEJTeklvbW9wKzVjNUN2WUp2SjdyZGRWazFZYWtLeERSMEJ4?=
 =?utf-8?B?NXlsVjFwU1EwUGhzMlp5VEUvMG94RkU3M1JveWhIU3JnV3JjVzBOai9YS1BP?=
 =?utf-8?B?VG9hcnJkazJFWG8rY2hpZ0h3ekwvbjZVRzY2RmlYaUlJZkJkNTlHamN6aVYz?=
 =?utf-8?B?aUx5cEF1SEVFVExxQnJXQjIwVE1PcWdCYjE4anVzZ09IOTJSNTliT1R0Nm1M?=
 =?utf-8?B?a0puTGxMUW1iOW44UXBML1Y0YUZId0ZyQW9yNlVtM1d3Qkswejh2OWJCc3Vx?=
 =?utf-8?B?c0hMbFg3a1hyUVN6TkNDMUtQY2xrUEVTQzhnSVVtbU5Ha21HTVRxK0M1T2I2?=
 =?utf-8?B?NEVKOWZlY1QzSmZqOVhMSC9JRzhBR0JnOEUwdlBCUTJ6MFdHODk5ZVRKV2xi?=
 =?utf-8?B?a2c3K2crM1YyeGoyK2lFSkRtS1BaWmVvM1VCY3I4eVpxT2NveTVQOUdWZkpH?=
 =?utf-8?B?RGIwRCtZNFFjeDcrbUN2dUYrMytuT1Zmd1pENk1qK0VFQlF4OGJZREhRZnQ5?=
 =?utf-8?B?L0kxaTI5YmVuUGtKbktjRUwwbXdpc3lpb0VNTC9BRThCS1pPcUJYMDNoVENr?=
 =?utf-8?B?dEhHRmVJTE9GL0VMWmQzWWE1QTc3cGhDWVgwbmlLc1A0Q3JVQ0krdlA3eG8z?=
 =?utf-8?B?STJPZEF5UnpFQm9UanJkL0pqOUczVFdCMXlHQWVRSDVEdW9jaFF3elJXKytV?=
 =?utf-8?B?Smh0QWVXQWdkSURnbzF4NlJVQXViNGY1MStSVVdmZHJQUG9CV25CSFNteVI1?=
 =?utf-8?B?cUpZMzRESktJL2pJWm1SVk5UV1EwTklBVGVKK3VVU1ZVaEhRb2xSYUF1OVVD?=
 =?utf-8?B?MkNkTnpoKzdnK1UwVFRncVZkTEZOWG4rai9FaUJSeFVQZmswQW1tL1NsZ2Zn?=
 =?utf-8?B?Vjg3SjBOOFQ3LzVuWnlOQ1lGZnQzMzViaHBoamJ5cUhWVTB2dUkvVC92QjB3?=
 =?utf-8?B?bWgrVCtWWTdYdnBSaGwrVjREbG8xL2ZOV0RKbmpWQytkUW1UTTVBUWVjWUhN?=
 =?utf-8?B?dXBadGZ4ZGs1ZVZUZU50dUVDY0NGNkthcmRPeWNCalBZbnNYV3p4TTJ4Sjg2?=
 =?utf-8?B?cnlxT25WUC9FeFNIcktzL1o0all2TzVhenJiM08raEg2bVNkajNvN1UvdU93?=
 =?utf-8?B?M1ZHV2FnMWhzVU9lT3pDcVJ5VlltSGpCL2YyZC9CY3JLNTFWZUVFamVSNmc1?=
 =?utf-8?B?NVd6bVVidEZhRGJIaHdUcm4rOEZxNXVQSjZvOFpqNlNSZXVxRTdTbU4xVVpC?=
 =?utf-8?B?bko5NWtwYVUyZTdjODhZeWRuREJ3UWJId2dXSWlNUUJJMHF5RkxobEd4WS9I?=
 =?utf-8?B?VW5lN0VSekZkQ3M4YldRREQ5R21JMXRocTVEeVpwTEhHQTFNQ3h0empETlpM?=
 =?utf-8?B?aUhFZlNQRFBqTDRrWktwSzZvYmwvNm5nS25NRnVXYmZyUU1vVEticzhYYkJF?=
 =?utf-8?B?blNrV082UVZaRHZ6WWlzYm9YZUc5NzdZLzBHM3RMTXR6S0NCaHVmU3ZLdGdp?=
 =?utf-8?B?NFZWaUFKWWM1NHJsMXN4ZXo5UTIyWnlKdzlWZTBtTDlDNUlQM084YmdQNWNq?=
 =?utf-8?B?c2EzNHNSWjltYlFMc2ZIcXVSWHEwYmtreG1ncEYxRzdIa01jRHNuTlYxeGUz?=
 =?utf-8?B?SWRldmljZDBQQVhHN3pLTkdaZWV6MStxUHdkUDdSbkVuUlhVRTFPOGhqeno3?=
 =?utf-8?B?SVRTVm1xTVkxcEpVTzZFVDdCNThZN1JYcmVCYmNLSmVRWmJhWFRpNk1HZVZP?=
 =?utf-8?B?SEFXT2JrTm0wUkxvTjJSWGlZNDdKMWo1RE9GK05nRzdjZEFDOVBkaW5ibnFw?=
 =?utf-8?B?M3RoSVJzTUgvUGUxQkNwYXdFMlVYcUxlbWJ5R3RwYW4yYkxHeGNKOHMyTFF0?=
 =?utf-8?B?V0NCeGdlVktRMVM1NVloN0c1QVRJK2l2dGVFRkJERDZGVklubEZUWi9zOHJV?=
 =?utf-8?B?SmdsRGZ6SURWV0FhOG1xQzg1ZTRiWWkvN1ZnckJvN2NmdkZpQVpRWU9QdzVB?=
 =?utf-8?B?RVpIRlBlekRaN056WDYzaFhTM3FueTdaRkNkNUZlMStNWG5GUVVIMUJrZkhs?=
 =?utf-8?B?K21HeGdiK1Q5WVlvK3Q4TnAxMmd2ZXgrVW93RU80M2g2WjVNOEFPS0VlT0tv?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D87203D798AFE4BA0789A2DD21A131F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2f0v43tHOQ2/guI56k1HTs5HoH40W1CCV0aH3RZiVrOT2BtgVKwpwrCSj0JgjuwTsPIE83E4MK+xAGVz0J0q3Wd+czXkPP+GhMfmRRDkhSgv3Gq5rsMacaBZmmFTS08soDF2xdEh5lLvr4vgQyi15XAxCB2zHO3BgYRUzOlfQgzesnUbbIID30dBFfyZyP3OWuacSjA8lOHqlSWeuKxEgn/5bkqVU2oYijHl8qdlBjgS/ZwMRQWBUP0gtZm8BwBiE4HYLRyAs/e4CiHQvrNNBGY3Idt+DnuZppYew24l79z8GD4cOgHSOuLVdg90QA5SwP24Mokltm/MLl9sJK75fUI44ekA6a5rjTj04LGeQFdZ/EPji7iD9ruRFPcS4ZqSzbE/9swljen/BnimFuaGvfGfCSb6chrnvww2n2yUmokg1pZGYQNUGxqodonuOcTxGiQTGeiROM1WhXIJiSucpxtP4+J6/UZUV4wdfyrbSDGG5Vo93MsKXTga5wfzxXstC/LlWUxuRS00kd8MBT9fpq6+Gwf6pVwsvf6aetWJCkg0J0RuUwynhSe9GqK7gHi4gqtQ3iqPa4hdFmL2RnyO6jIYizj0W+LfUAU7e9pRMYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cea9a66-5467-4246-acb5-08dc1e759a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 13:49:22.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2cvCLP7LqAI14P/LtJrbBbja9ftRmhrMyWTsN8cOdc//08+xdgKpxYBQ3yEFWYX4A7d177aaPX34+LZCTTSJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260101
X-Proofpoint-GUID: iz5nZs2rra1loMj4OpwrMx9UcwZyj2sa
X-Proofpoint-ORIG-GUID: iz5nZs2rra1loMj4OpwrMx9UcwZyj2sa

DQoNCj4gT24gSmFuIDI1LCAyMDI0LCBhdCA0OjU04oCvUE0sIEpvc2VmIEJhY2lrIDxqb3NlZkB0
b3hpY3BhbmRhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEphbiAyNSwgMjAyNCBhdCAwMzo1
MzoyNFBNIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+IE9uIFRodSwgSmFuIDI1LCAyMDI0
IGF0IDAyOjUzOjE1UE0gLTA1MDAsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPj4+IFdlIHdhbnQgdG8g
YmUgYWJsZSB0byBoYXZlIG91ciBycGMgc3RhdHMgaGFuZGxlZCBpbiBhIHBlciBuZXR3b3JrDQo+
Pj4gbmFtZXNwYWNlIG1hbm5lciwgc28gYWRkIGFuIG9wdGlvbiB0byBycGNfY3JlYXRlX2FyZ3Mg
dG8gc3BlY2lmeSBhDQo+Pj4gZGlmZmVyZW50IHJwY19zdGF0cyBzdHJ1Y3QgaW5zdGVhZCBvZiB1
c2luZyB0aGUgb25lIG9uIHRoZSBycGNfcHJvZ3JhbS4NCj4+PiANCj4+PiBTaWduZWQtb2ZmLWJ5
OiBKb3NlZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+DQo+Pj4gLS0tDQo+Pj4gZnMvbmZz
L2NsaWVudC5jICAgICAgICAgICAgIHwgMiArLQ0KPj4+IGluY2x1ZGUvbGludXgvc3VucnBjL2Ns
bnQuaCB8IDEgKw0KPj4+IG5ldC9zdW5ycGMvY2xudC5jICAgICAgICAgICB8IDIgKy0NCj4+PiAz
IGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+IA0KPj4g
SSBrbm93IGl0IGlzbid0IG9idmlvdXMgdG8gYW4gb3V0c2lkZSBvYnNlcnZlciwgYnV0IHRoZQ0K
Pj4gbWFpbnRhaW5lcnNoaXAgb2YgdGhlIE5GUyBzZXJ2ZXIgYW5kIGNsaWVudCBhcmUgc2VwYXJh
dGUuDQo+PiANCj4+IE5GUyBjbGllbnQgcGF0Y2hlcyBnbyBUbzogVHJvbmQgYW5kIEFubmEsIENj
OiBsaW51eC1uZnMNCj4+IA0KPj4gTkZTIHNlcnZlciBwYXRjaGVzIGdvIFRvOiBKZWZmIGFuZCBD
aHVjaywgQ2M6IGxpbnV4LW5mcw0KPj4gDQo+PiBhbmQgeW91IGNhbiBDYzogc2VydmVyIHBhdGNo
ZXMgb24gdGhlIHJldmlld2VycyBsaXN0ZWQgaW4NCj4+IE1BSU5UQUlORVJTIHRvbyBpZiB5b3Ug
bGlrZS4NCj4gDQo+IFNvdW5kcyBnb29kLCBzaG91bGQgSSBzcGxpdCB0aGUgc2VyaWVzIHVwIGNv
bXBsZXRlbHk/ICBJIHRoaW5rIHRoZSBuZnNkIGFuZCBuZnMNCj4gc3VucnBjIHJlbGF0ZWQgY2hh
bmdlcyBhcmUgdW5pcXVlIHRvIGVpdGhlciBzdGFjaw0KDQpUaGF0J3Mgd2hhdCBpdCBsb29rcyBs
aWtlIHRvIG1lIHRvby4NCg0KDQo+IHNvIEkgY2FuIHNwbGl0IGl0IG91dCBpbnRvIHR3byBkaWZm
ZXJlbnQgc2VyaWVzIGlmIHRoYXQgd291bGQgaGVscC4NCg0KTGV0J3MgZG8gdGhhdCBmb3IgdjMu
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

