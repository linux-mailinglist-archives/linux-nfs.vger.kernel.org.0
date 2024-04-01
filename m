Return-Path: <linux-nfs+bounces-2578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1697F893B96
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 15:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2341F22077
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BCF3FB1E;
	Mon,  1 Apr 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Detgx3ek";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OsvbLMFZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06983F8F4
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979283; cv=fail; b=YfqsCFLbFaiLNOqbpDk0gLC79RNWKU6ldfcTUSA5CDVinIO7jgKmAVJIrn14pmUIypv/6L6DLb+ihsgPqUOB6+dkr7MeYIoqV0KXMZTmHkOxvSXQpIzSOMoSomGag0LRHEtCaEAMA18wOQ++gtV6Q+fGyjHWvz8nfaN5+bWYjcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979283; c=relaxed/simple;
	bh=dfNbt11/jTY7q4QKY4IhnBvighDISorOH9gHDc/os6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BINbqoSBOwhu7InN9RZ9oxg7Zbhq0PQMhBpnTgOqHDsBGqq5v0sJSzq0y0dtBCvsP2tGf1ala5oDEUamL2liT8TilmgeeR8UKevrcGsaZYQQGLeIw5nw9MxiZtyoFcTkGDYgVATVOnwYYeKsS84kWDAOJfmk0n3LhICb6zH4nIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Detgx3ek; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OsvbLMFZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4318j0Yl006795;
	Mon, 1 Apr 2024 13:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dfNbt11/jTY7q4QKY4IhnBvighDISorOH9gHDc/os6I=;
 b=Detgx3ek76R38GMPiy0NOaIVuT/v8VZsqsN8XYwkNNZ9fbsh/xfs6XFRwrfB8VRyHG4d
 e1Yq4TWRny0xAgBpGQ+MCRBEMrRV38fnY8RE3b+QC314fOj6wz4+22iUoefcrHL7CZD5
 kkyzC30BKMkZvyMcMY5xbXlGYw9WMic08YhMM91M7uo+Rvbx2T9UQjbhOLb1TwnwpofB
 qWRld7Fl7eAy28DVniX60A6Xiy9JGbySLIj6TNXdrfJQ+SrNw2JJ97us/gDiTSCZSpMs
 fryl3vlVYTkR9UuZTLN1BQ8hrRfUf9lDrEQfoJl1kJki7desUZn1TPait0lkF7vKUYTO ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69ncje2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 13:47:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431DRpKU021466;
	Mon, 1 Apr 2024 13:47:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x6965mnws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 13:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPpTMTqNbhnMNcxAQsXSydduWEktDBLV7Dv1Rrw+Gj03rLLh13OC+x5QY3zyO6sJNasLXqF80xI3TJsohyEC8shd9s71G579nNDez60mkK+WBDPmpw3iSRGUzuPP2QTy8kyRRlMLsZSsqLJPsSpRgwlrVUQ/2AcyTwB5BxLe3r2VgOMBVwssYfxuHHMunokyQR25YMOng7PgtvKSgq2msJUdXEjMYAexhdViS9fpss1zI1uvRMmNwwBARQgaOGw0FGB1ZKK5zZyP196KM8cmIyN01ONbce6SRMEnEWQRxUbuLMKHaFkKqHCmmaLZfDUnsNDFCqsRxb4oJaYlmiKKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfNbt11/jTY7q4QKY4IhnBvighDISorOH9gHDc/os6I=;
 b=UiDe0MM1txvGuy6ZdutONS7zj3vrmLw6PMbFAEjprx9I5fLvjySrQq0I0BzoUEmM+W7+xApcs3p+n2xc3+3+1QjMqHwZTklj33i+ntCw+IrhSnblkjasDdPwJpr4B5KmsGrJTwE07TGKwHipDmP8ookFrll+SDjYmJLskn4i64U7Eam570gNY7VBbpEl7QrbZKtRxmUPpoioxwzmWjV8Ka+XE58BYTkSr9Xue12fAOk+xryQsQlLaPWzg991Xk70nMiBpNba7NlXykfhfP6BSWf1pfke5EqQm+zQovKwwnQV5XIOAjH/rKntT4eofPAuB8aJO6i4YSuzXncEm7ZfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfNbt11/jTY7q4QKY4IhnBvighDISorOH9gHDc/os6I=;
 b=OsvbLMFZkn7asa09ni+mBO2fLOWqEytmsm5lQmsVBmbFgmmsXQOBArIeeRB4riveEuPPEXOLJ0pSq1xGol/xvaqUvd+P40UvUMPCQA3qcnkt+eSaHYbzFjR27B6CPuiEvZdQtHYOkOX+iS5je3Fjkt+Te+kdjuypER4GhtCMxw4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5787.namprd10.prod.outlook.com (2603:10b6:a03:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:47:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 13:47:52 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Wang Yugui <wangyugui@e16-tech.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: one more patch(nfsd: fix potential race in nfs4_find_file) for
 6.1.83+ ?
Thread-Topic: one more patch(nfsd: fix potential race in nfs4_find_file) for
 6.1.83+ ?
Thread-Index: AQHahCSMpb2O1QvAJkOhp17NVyrINrFTbgwA
Date: Mon, 1 Apr 2024 13:47:52 +0000
Message-ID: <E9D90677-6F0A-44BF-A7CC-771CEC8B41DE@oracle.com>
References: <20240401190527.7D1D.409509F4@e16-tech.com>
In-Reply-To: <20240401190527.7D1D.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5787:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9cP2SRnMPeSymqYV+7MrxOLgK0i1wRs7m30wQyLX9Ov6pKERfgJ8uJfFmVM0Qs5h4+trj4//mLJuBUk6JGncrH1FhExy0B2f690d/uBjIJUu8KkIQQypVlJmqJhTHEXvcRSb+w+hzWM0FyNx9UwWJTJoUEUJ7I4G+tjVQWyP7RviUyLUTy9RkX4cPEcFK89r2iWTlMlz577sW4KbMGqzo+rCiNGh+OmM5fVpTyBiZXazUx5LnjD2z4BcaoWlKLbgez2ZIfTR8fvyy12i3K722T5s1LBTH++USY0DuVgitH3f3AFB7u1PN4o9z5SogCwhTXdI/DqgqcBrHj96MuPGTBDOMDMvvjbErvCn7djAWiI0BySPlpaDfr0bNhaKI7BY8jNyeXe+vUJp864qQzUqroI4FoG7Yee6EUl+ql/CKiVF2ufJpjZWiwc+EWuMxdgJ/ZxaF8Yl2pE+1rSTolratsWdPCUFZBhOzLHKJ4Ea7uyUevH/mnUvckgqqt8qQCId7fe6oDzRR5jCDFQRljxhUqS9aTRxBCAM4sddJ0laSINH8rNSIj5pJIhaGL7Z/aO9Ik/OX8ZogWvy9RstWCx3+444qTDqVHT11/nCHGNT+FYQ57FM2o6ZhaHODMUCn+wV8n9XSBtfAu7zjOjuo+LlLZGxj2i+MxDD+rGkeODOMJE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dmhNVEh6VHJoTU9uVGlnZ0lRUjBONDBFL0ErZENWUlVLZFViR21EOEN5VU5L?=
 =?utf-8?B?VVp3dDBXaDI5Lzk2WDdORFV0Zzdhdkp6Uk1sd25YQXI4djhZQWRhcDkxbkt4?=
 =?utf-8?B?NnhvSE93YzBIeEkwTWRMaTZ3MnhzeENXMk44b2c5RTN2ZjVjR1hjOXh6cG5a?=
 =?utf-8?B?MzYySnBzd0dqdW5rcEJrOWlZUjFDdnc0aWUva3JnVkFMc2ZSRlVuUm41WjhO?=
 =?utf-8?B?R1RacE5pcUpsRnlOQm5OcVc1ZHMweHJFd0tVcGtyUmNEZGhhMDhEdGcxclZZ?=
 =?utf-8?B?NmpaSHNyNkdoTFJnK1FQYmQxeG5kd09waDdYVWNpMlhPb2R1U3Nuci8yRCt1?=
 =?utf-8?B?NElKam5uTXo4a2VMcUt5R0pydVdFbFVMenFiaDc3aERieHBmRFNiU1dOdzQ4?=
 =?utf-8?B?eVNNYWZmUm1MN2hrY3IvSzB2emFMVEpVemJGOVRQKzBGVzE5TklSSFZjemtv?=
 =?utf-8?B?OU95ZG5INWl4THRWT3E1eWk4T2MwNTM2ekl1U1hmdFJicDk3WEtNNlovVk0y?=
 =?utf-8?B?TFNFd0g4SnQ4WHZ3cjVIS1BvZEhUSExLMWpNK1RtT3lSMjVLeTh4M28yYUVz?=
 =?utf-8?B?aHBVM1E5UldUMGtUbmxlRzZNU21ZTzNoSFRodGhhcm9hNU11ZTNtQjdHeFFv?=
 =?utf-8?B?Rm5PVXcySHpIdmVRRmNjdzM4UHJnWVNDTnhFdDZOT2k5N2tyTElzeHlRcjRm?=
 =?utf-8?B?OEhLL2dUdHNCVit6QjArTmJaZ2g4aGtYb0FzM3FjM1JOaDdZVitZaUxqdEtI?=
 =?utf-8?B?Q1FaVXBFVXlYSmNoMnlnZ3NCVERoRSt0clM1dVlsNWhqQnZyU2JIaDJnRUNy?=
 =?utf-8?B?WWRWT21XdUdJbFY2cFkzQ0tQMkRNeHZQRDhoRWFGR3hKaDhDdkFrMUZYaTQ2?=
 =?utf-8?B?MXhaY3dhaXN3Q0JFSGU1aC9ycDRxSDJ4ZnpTVHp6aXdzVE5ZNlN5Q25ZU2Z5?=
 =?utf-8?B?QWNFbTBpNGtDejB4b1JwZDFpbFFYNm9naGVnU003cFM0dFhYL0hsd3N2ZnBt?=
 =?utf-8?B?UGU0UkFzTS9jUXhXNnlZNVlLZHJJUWFwRnZtV0pHTUYzZUNXUFVEY3NmaW1s?=
 =?utf-8?B?T2VscXRsSitqSEZjOTB3a2FNcVlkeEVhZUw1bW0rOHlUUE1XVUdnVmZIQmJn?=
 =?utf-8?B?MmNIUHpBU3paSG42Y09IbnVidk9kWGtsRVl2ZnRCdytSamd5L1lBUEhiUm1I?=
 =?utf-8?B?Zi8zWFVyK2VjMnQ2czJnTnRFUmppTjVGNlVnOGdkTm1kcFFtZ2xEallQeGRx?=
 =?utf-8?B?Ym5RZ0RXMHorVlc2SVNBRXZ2MlV2UVFMdENoNVNUdzlYL0pZOHFlUjdGdU12?=
 =?utf-8?B?bmp6ME50Vy9xanJ4dkEwWk9GNmZjdW9kdzhrazFTR05QVXo5S2o2cHlGU1VL?=
 =?utf-8?B?T2VyaEUvbXpiRzB3Q0IrcFFiTmZCZTdjVXd5UytKdUx4UmkzcDdMQ1ZySnhp?=
 =?utf-8?B?S0pHdEdVeEwvcTRmbHdRSjFxNnVSWEthcllQK3M1ekFTTCtvTzZLZmRkcFpL?=
 =?utf-8?B?YzF5L2FITERIbTd5Z0FOQUV5aUl2di9ycjVaOTR4ZWJ4cmJNQjFpZHVPeVN0?=
 =?utf-8?B?a25sS1NWUUZXQUdlOWFUcWlqZFcwQngzZW5uSTd2enlTVUlSMytMbDBoNU4y?=
 =?utf-8?B?dlFNeXB0enF2ODNvVm9rOGlIaFhmS3FmUzZFQW8vaXFoK0lrWUlPamIveUhk?=
 =?utf-8?B?WStVNjJUN3FJemZDeDZPMW5RcXh6RUgxL3VXNnZ2SXd3bVROMjk1SmlGZXBs?=
 =?utf-8?B?SG9BR1RIUE5wRGhFbTluMU16YmxyVHB0eGVWZ1Q4eWloUTg1ZTlvbU5YSTQw?=
 =?utf-8?B?SklXYXBzdys4UVBTR0o5ZER6Mzg5UytNS1FLQVhtcmswc0FMcUVZODNaQzdt?=
 =?utf-8?B?dVUrcStXZG81MUxHTUlZbThhSTg4eWRvSll3NHdYWUNtNEdMVUZveHVyZ2RT?=
 =?utf-8?B?YnJsZE81aDZEaVdheFBQVjVRbU9zWFhRYjAxY1NEdy83VFR1RWN0MFZCT2Qx?=
 =?utf-8?B?UURtbTFXYzY0ZjJJSFNOcUc1Qjd1dGRDU1FGMy9yUUd0TzNOVEc3OHo5dHdp?=
 =?utf-8?B?QlpiazFNamtQK2J3RW85UHUxaS9nUGlGNmJMNXRzQ3luNmU0eGdRbWt3bzBz?=
 =?utf-8?B?amczandnZnh2ZU96WHVCWE96YUNtQks3RzIvZmFuRWlLQWZCMkpvdEhkWjR5?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E39E183E1A66CC4F8C3D8B0D032C0E39@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	83aC3XgA+vrFG0GdaTtnaa9wnIeFba6gr35uT+agA8H/pyMz+eKXu+XZkwkBfYqSSirGT7oBC0DPdCYV2j9Gh2umyJPAtPOac+KkharBQmRTX2PMefkjJ9Z/6KMB4ySGjrpGUuaZ0LYkf+J/qpKAA3alKyQV8daQXsWkiAeMr/06mnsKDAcubBatyi2k5SSzlFUqE8zwudDTqehOSDkyKprs/HjL/lLt9h2cSOec62wv/+xhMZ8J4PZqadnuBW123HXrE134nRqk2sZvDUGPc9FZrN5x1s5Q0o7+0FnlDj9DQgtzQE6hXhQxlAje1KhF2OzZ3jPTM8fyTdWHykU6Bux4WXF0fiSaCd8r3uAritcFfIcqdWBJ3ikMbXqQfngPgSJff6ewZI2NXUbh6f5lx8pzrRo9869pba2USLXq2/ifVxK1l4Tc8AuBZV2SusTF1mHAzfPJkPUwCgH9h6Tix6c3dfxHfvhkAHZImE1G+9JUm3mrAaP6EzMv9+HGDZXH5AKhLOP/FBg2SZr5FLKexT9WdA4ufeA/ovbqx5ZLbvKQliKKcx3f2l4fLP/sa4rXVTVlyTIxpMFkwCcveTZRfu0IPVAe7JsZoZYVYgmgTC8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870dabfe-92ed-48ee-0e3a-08dc5252539e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 13:47:52.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPjxrnLvxteCFzjTWCcl+2I3pHCXsUeVbqAMYX8+9XLIIDYXrDP0eLVm9IarFQnyV5RCU51b/NLdxqEKpgKySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010098
X-Proofpoint-GUID: AQKKpE6wRoKF0k2_BmKBxq5ccC3ozvXP
X-Proofpoint-ORIG-GUID: AQKKpE6wRoKF0k2_BmKBxq5ccC3ozvXP

DQoNCj4gT24gQXByIDEsIDIwMjQsIGF0IDc6MDXigK9BTSwgV2FuZyBZdWd1aSA8d2FuZ3l1Z3Vp
QGUxNi10ZWNoLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IFdlIGhhZCAxMyBuZnNkIHBh
dGNoZXMgaW4gNi4xLjgzLCBkbyB3ZSBuZWVkIG9uZSBtb3JlIHBhdGNoKCoxKT8NCj4gDQo+ICox
Og0KPiBiZDZhYWY3ODFkYWUgOkplZmYgTGF5dG9uOiBuZnNkOiBmaXggcG90ZW50aWFsIHJhY2Ug
aW4gbmZzNF9maW5kX2ZpbGUNCg0KVGhpcyBvbmUgd2VudCBpbiBhZnRlciB2Ni4yICh3aGVyZSBJ
IGRyZXcgYSBsaW5lIGluDQp0aGUgc2FuZCkgYW5kIGxvb2tlZCBtb3JlIGxpa2UgYSBjbGVhbi11
cCB0aGFuIGEgYnVnIGZpeC4NCg0KSXMgdGhlIGtlcm5lbCBtaXNiZWhhdmluZz8gV2h5IGRvIHlv
dSBiZWxpZXZlIHRoaXMgb25lDQpuZWVkcyB0byBiZSBiYWNrcG9ydGVkPw0KDQoNCi0tDQpDaHVj
ayBMZXZlcg0KDQoNCg==

