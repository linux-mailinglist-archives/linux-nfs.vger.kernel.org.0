Return-Path: <linux-nfs+bounces-2447-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52838887398
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 20:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764661C21CBE
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058DB77628;
	Fri, 22 Mar 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fhG+1Rx8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O/pienL4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8B7762F
	for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134521; cv=fail; b=sGbi/t75BuwTBsTH0sD3DZLFjAjRlW6PSg1IeW1MUKaAXs3LDygEwL8CCO1wyiugFT6tBqDzvzvPMzK1vBjHBhEn7gGxfedq5lJP9JRX9OFTYYo1plaIUEko+Flw2Ujd5yshAlOl3iRUkyeiBXCFErm0Cw0B2117x1KsBQN/S+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134521; c=relaxed/simple;
	bh=r8ORwphwNTt7TCDhC0KReLwPHNv5pnrKVyo9rTtEyQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pkIhHAu711xZSnXD4Wm7pQ379RlbPczMtzxKIO6qw+PjuYA8wXnq4Op3V2qzuWw5Db6eINcc3fvcWzClnSLQXwEr68x6kPvU9AnyOE03iSKKQk+91QobuDvnJmIiSwm/7XsbAl5/Qf+A/B3HpB0f5za4W5UyYb+w865Cshr3CfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fhG+1Rx8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O/pienL4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MDK0QP020569;
	Fri, 22 Mar 2024 19:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=r8ORwphwNTt7TCDhC0KReLwPHNv5pnrKVyo9rTtEyQg=;
 b=fhG+1Rx8mDYrhRO1dBeCwwE1BeIP8Tqaietj/uupyJiimMhqq0GD1Zz8Vns0HL/sDrm8
 fC+pf9OpFrZ2VY1eN0y/sGWR3OyuKIUO58BxERDFEhploWdWvEyD3CS/4NPHSYjNIqx2
 BBaqsOPNhbhubk02xSM+k0uCi+Edu/4PG/TBTliBRnNfzroCy10HV1gISXhhp0HvSMhM
 Jk8KlhnhTgG9e04eBOj5BL15cgiK5zfOCf8bebHg38PUaNAANsHkCUpbOZo7GQSoQaCl
 a6CBLWYDJQTmxoaPe5+m+4NUvDrKhrO7vbupKCQxsybeEL3sf96LqawFuf1Ckv31rdPx QA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvphshk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 19:06:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42MIhrS0004075;
	Fri, 22 Mar 2024 19:06:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvmdjvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 19:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiHRuRRPCeTGdJR0oZ/nMRLhuy18nRLxXvl0d7kvNcgWdhNwgf2UD7r4ffaOzA7ABg2jy38Y4zsjy5jZJ3S1GAF46n9H1sdViiNf+v3/aF65AubCCb5SNs0qy7hWW+GpSQyrRvMJRCK3kTpVTpoTlN/1gzFvJ+y9FqRSxgfX3IF4vLcaSEGsS5BVUo7fKGa2SDTtxaQ7DHrUHQGZEhMAh0gPAujp7r97B5kr8cwRRJldY1aKMPA9zgs5Lve2OsZFxyfMOGZLLL4G9k9A8x9saidI24qDW/TugCKY8QCkWEav2ymOdVEJkKuU10VOMRv9SP7Z4ShUlZ6g9ATscfDN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8ORwphwNTt7TCDhC0KReLwPHNv5pnrKVyo9rTtEyQg=;
 b=h4uPgeJXV9yLL7hCOUZ/0pCrLynotw8FigpDUqSzlh7ZlcDtByYq/UVtZFP5ERwNJf6mqhxIuBsJdplvk93lgwF6D4vOLmwL/nvaZ27FT2uIEAZPNc15OV5tuj+iCWKb3LT/vKlK2FVKkafETLjbXj9p2A8oAyHlMAb/ZLVS7BIv/cN8hBRYcZhL7DjBSbJPhNlUmF38gamdvoCvWnaWcMSVbap3RvNvuF5Zaqhjqhgy9YHiNG8YQlahz/wfEz8RpK2DJtUMLS6TBSoYaXqXeIUIml4Hl2p/Ps2bK2nEuBTZTCCDasuY1POn637PeXIuZNEzvXvcNc+JUkcNRFHTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8ORwphwNTt7TCDhC0KReLwPHNv5pnrKVyo9rTtEyQg=;
 b=O/pienL4rVEvzZeetwXG0LUkiLUKoZzhjG7R1Hyd5GezwJcR6TENMV7zccPeLvretdMEYfid6Kp/1xGHvIMHCX1rFS4dNYJHKVCNjE2VV2s+aYT40O5kyRBK5QnMsdnHxBgJICjR7vyKKEHx9txpGn0CXF2QzJmW2ACmoq5JDOc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5980.namprd10.prod.outlook.com (2603:10b6:a03:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 19:06:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 19:06:27 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RPCSEC_GSS_KRB5_ENCTYPES backported to some older long-term
 kernels, but not 6.1?
Thread-Topic: RPCSEC_GSS_KRB5_ENCTYPES backported to some older long-term
 kernels, but not 6.1?
Thread-Index: AQHae1kWpMGS0wQavE2n5+NCWRnGFrFCMgIAgAFU2wCAAJp4AA==
Date: Fri, 22 Mar 2024 19:06:27 +0000
Message-ID: <BFD2D512-3B22-4586-BEB5-FBB7CB47E13C@oracle.com>
References: <ff131330-9f1c-493c-bfe2-8732a2730bf9@esat.kuleuven.be>
 <F2ED9EC7-3A5E-41B2-B225-FBF28C99132A@oracle.com>
 <1be78aa6-f8b6-45c5-a800-7af07ad532ef@esat.kuleuven.be>
In-Reply-To: <1be78aa6-f8b6-45c5-a800-7af07ad532ef@esat.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5980:EE_
x-ms-office365-filtering-correlation-id: 22944d4e-b3e1-432b-acd2-08dc4aa32d00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rEd0plB3mYQHtuabjqEjcK6l/RqXtP3vu4WnawqM3ez0U84A6AmSrcgnTjupLowHJISJixy7hv10f69VmutklPGhJdkFHqmTn9shG4xcv9ebbYKwfuO+2vokARybpR5qt0IeX8mmTGh+Kiz555/5w944Fkh7z9GLywh23Mirf+B7G7zn9H2iU1YIClmJPco1jkIJOTXRtgB/V2VayBjAaMQKRSlCwNNOLEskwMrZKYqS2/5H+cYgULrwJEczZqY1u/4ZzF/UWJ7zUo788EDzYsEVYvAJ0tbwIOsKWyQKJLH8Xb/fkc8f0a6CsSoPjQaWD7+90cwlomtLCmYlkVbJ0RUwZ0pcEXa7TE0prZMKBur9spVPp29ZNpXyT1SQB8533p5Eoqef7WOiKLfKXrCO5OI3PxjVRR/kLgsMmCOOPlPNfxSGLaQPTYRjqIsX/jMXqaa+GH04ARCtoPWqzyYFHp22kXvdLT+3wbOqdqOFXLRg8rYWU4JuXZwUKbmGvj/puVopgoOOVeIxJwjxCcdsLuedGlRR4u7+vhQ4Ynb1nr33xWDjOlqCBSVuRL6wzFLVdvbf/nazw4mmD4cJ2pZMaMG4BJCQ6+c6qnO4W6/E5ucnaww40w6yULqbWwXtaeHDergo4GEQ6W6oEc5NmTGfQoCxYOwLHhnrlmmfjlTo2e8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NHRJdEdrdW9heE9BeSthZ2dyanVxVXRZS2ZjRUhOU3ROZmluUnFwV0x1dlVa?=
 =?utf-8?B?UWRJL2hWYTRwYWo2b2xsTU8zNEtBNWdWeEJteUxGV3FkbzA1U1hwNGdkSnBx?=
 =?utf-8?B?aU9tcWkwZUR2M3JHVU9adTdZMTl0bWdkdnJmb05od3dJUEF2cDdnbllkeCt5?=
 =?utf-8?B?eWk5QmwwM003SEFCSWlBZkFWRmNsNWM0OHRIanRnWjNtOUY2bEpVbVNxMEdp?=
 =?utf-8?B?c1FwcnIveUFjUUxnbEdqTWZCQnVaTGpVelV2VUc2d1QxS054dSsyUUwzb21V?=
 =?utf-8?B?c1E2N2RsbWt4VVZMZ2YvVFVnb2tPRUNJUXVvUExhTkhwbWE5dlJBWjZhRWU1?=
 =?utf-8?B?L1FZc1dCcENqK1haUDdhcmErWFI2OHpncXI1dU5xYWo5YkNwbHhxcXp1NCs3?=
 =?utf-8?B?aTFrR2NQcXRjL3dlYTN4UDZBbkJqS0szY1pJUTlxUXhaczI5dFVwUE9LWXNR?=
 =?utf-8?B?d0Y2NEYvaHVHbit0eWRVRERhbWhndE5aek9KZHBqS290cWhwZkg4bzJvanZT?=
 =?utf-8?B?dWppMHQvUHJNUXVrSkdLdGZOYXczUzhmSll3Y1lSZno4REdET29Ia1dUamln?=
 =?utf-8?B?SWZjZ05xcU5xZUdCQWdNMXhRVzNpYUdMNzRNWC9sUk4vcTM0SnJwaGt1aHBR?=
 =?utf-8?B?SGpLRHRRYys1WjN0RklUOGcvVUplVjhYTGVRdXYzWi83YjZjRW1NVm1rNjFP?=
 =?utf-8?B?c3JJTmhoZ0Z6QTFxdjZDdGR4cmNQRC91QnhMRFRzNVhXVngzNWlHeFhPZTZI?=
 =?utf-8?B?Y2hDY0JydnhDUkF5Uys0NmZUSlVHUUlDaXJJN1VNMnFtT3VRWEQ0Q2dyTlVS?=
 =?utf-8?B?T2FOQW04TkhQd3JralU3VHlzNFNVbXpKdE5LNWJJaEJSZkZ2MWdnTmVWdFBL?=
 =?utf-8?B?ckN6MllsRDlXMkRBQjJockVYZm9SN0pHOHpyZGcxcmtFYnRTamNqVnE5d0pL?=
 =?utf-8?B?L09oRDh3dmp3ZXlwWFlqbWVKUjRWZlVFUWFmak1XeXpZRDMzTzd5WWpwZ2Vv?=
 =?utf-8?B?cWZjUHFzNmVKaVFJdmdkN2tyRTFRNStIYk5KVWNOMlpNOENpNHlaNnMyT3lt?=
 =?utf-8?B?bFhHMGJqcXlHRnVRYUFDYS81c2dPYWxSRE8wd09ORDduc1lnNGRxdmorVVVx?=
 =?utf-8?B?d210YXRUdGowUC9oWWQrRklFSmdWMEVQdjN3d0FHTmFMbllWeERaSEh2anJR?=
 =?utf-8?B?TDErU1JxQjdQOERIcFordHJORWVUMnUwTDkxS2E2ZVVjYWJURW1aNkd6Slpn?=
 =?utf-8?B?aE1STGw4bEo0L3paRjJTZE1HK0VUeTRZTVAwMTlCRS9HeUtITGpPcmJTN3h2?=
 =?utf-8?B?OFk0YjczMS9lbzB5N1BpMWVaVTFCTVlrK0E4WW5RK1JLalBGUlNtUWh2b1Fu?=
 =?utf-8?B?Ty9JcldhYW96MFhVUkdPWXN5ZmhtNVRDazJ1UVdONjl2S3RsNGxsRXVBR0VY?=
 =?utf-8?B?cTJFQVFyeDI4ZmZFYTJYQ21CMjlPZzA2a0YzeXJUQzBPRmI5UHAvUE5Nb0Ji?=
 =?utf-8?B?UW5MdDRTSGY2azl3WG80dStVbHArTzl2V1ZnQWs1OTZtRzJPNkhtd2tvTS9W?=
 =?utf-8?B?em9zU0xmVm5XRWVkN3krMHBCZzJRNE02dzlKMisxWG5JMldWWlhJRERSb1ZI?=
 =?utf-8?B?S28yamUvUU9jZ3VwU2Q0VVF6NGUyYlVjVllXTm12WUJLajVnU013NUYrYWgy?=
 =?utf-8?B?WmZ3RWZBSWhLVXBCVUlDaEdkbWVXWjlKUUsvazR6QzlOY3I2cXBXNW5FRG5r?=
 =?utf-8?B?UFJhVVBFb0JLN040MGx6MUExSnlXRFE3ZkZRN3lyTjhGRTJxMmZPcEZyejQ4?=
 =?utf-8?B?RzBTUXVSVlYyM3ZmMVh4bE1rTmV1K0JkMzdwVnA1QzVNL1IyQndxWE9CUHF2?=
 =?utf-8?B?Q1NZMWp2Y0w3bGoybW5oRnB5cXJDN051Wnd1NW1rWFpaWEY3cis1U1JxS0JF?=
 =?utf-8?B?aFBlK3Rxc2JoaVZhVHI2cjh6VHF2Y0RHK3BYNENxRURtbWpoSDhGREZNeCtu?=
 =?utf-8?B?Z1BERXpvSXpyVy9adG5Kb0VuT1Q5a3FQRHdsUmplV3ptaXJFU0FhdThRcmVu?=
 =?utf-8?B?bFJrdzdRSG5uRTQxQlp4ZVdxUjJ3YmZSOWN5M0dNYm5HR0RSakxDVkRzU1RW?=
 =?utf-8?B?b2lHSkFoUjhjbzluOGxtN0kveUM1UFNXamliZzM3T3Z6c1VKSFhqbmpvUk1j?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F10AF806C905C4BB82DCA9AE21142B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KHDycrQArLOFX7+rzRSJ6G9ZxQa7ItIZCM/UktIB7ufrED0LDBjiTIn1cOLCxvzIRYQ1XK/7Um/y5XiDvbzeSCWqbq0LmmnagGWybSBC45VWBLCOe5QLiRUBde0vvcSyNqcdsTz3DryNJYiSGNrIrXDbukUqcWoPEg3WqS0VKXcyGk61HpO82V8RmumnxdeFbZIhC18FpbHAk8+asfGWXSgz95+7k7AWQyV443Qm4Qyfi4HiDTeAbuEJhdlhEoMN8bDgw114G3uhPqNDSamNeX57Gw4JmBYonb2YDUjT197Cg0ZvQU6/li0QVrKZAKDnRrFDRjksZ9M8CnJQsKDw4QMskLxe44Y0HCHLucW7P0dKbnBOz3DCuwoefTRrXhOGhMWFFcLFdQTsgSd4GEDXPLpIzfTdMgA4hXwfhYdXDPoVzkPK0CaymdVLMNh/7DgyJcgJKuvXU18uzKQFRHUiefmzNkrT24gFGO4Yn8J6l8fD9/0t65CmsCir3Cg/xnFcuJcuz4Pgz0LacM93HQg8uKEJsOrG/EVLuGaN0+duZkoJPB5ovsGdVAD5r29x3Ndw+sYBiHIpAWY84S8MnTWP26pOD62DD/WddCXPiqPzxyY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22944d4e-b3e1-432b-acd2-08dc4aa32d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 19:06:27.4816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQsxaB9+N20van7Ny5qvYX0/B8kmE8YGyuQGuCaU9VkM+XDKG3cQko7kQhriLYJ65IUoLFaBEu9WizREGFAB2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_11,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=854 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220138
X-Proofpoint-GUID: JEd_SIUdpWsJ5ZzC2AJi4pc-XLLbSyci
X-Proofpoint-ORIG-GUID: JEd_SIUdpWsJ5ZzC2AJi4pc-XLLbSyci

DQoNCj4gT24gTWFyIDIyLCAyMDI0LCBhdCA1OjUz4oCvQU0sIFJpayBUaGV5cyA8UmlrLlRoZXlz
QGVzYXQua3VsZXV2ZW4uYmU+IHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBPbiAzLzIxLzI0IDE0
OjMzLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+IA0KPj4+IExvb2tpbmcgYXQgdGhlIG5ldC9z
dW5ycGMvS2NvbmZpZyBmaWxlLCB0aGVzZSBlbnRyaWVzIGRvbid0IGV4aXN0IHlldCBpbiB0aGUg
Ni4xIHNlcmllcywgYnV0IGFjY29yZGluZyB0b2h0dHBzOi8vd3d3Lmtlcm5lbGNvbmZpZy5pby9j
b25maWdfcnBjc2VjX2dzc19rcmI1X2VuY3R5cGVzX2Flc19zaGEyP3E9Jmtlcm5lbHZlcnNpb249
NC4xOS4zMTAmYXJjaD14ODYgIHRoZXkgZG8gZXhpc3QgaW4gc29tZSBvbGRlciBsb25nLXRlcm0g
a2VybmVscz8NCj4+PiANCj4+PiBMb29raW5nIGF0IENPTkZJR19SUENTRUNfR1NTX0tSQjVfRU5D
VFlQRVNfQUVTX1NIQTIsIGl0IHNlZW1zIGl0IGV4aXN0cyBmb3IgNC4xOS4zMTAsIDUuNC4yNzIs
IDUuMTUuMTUyLCBidXQgbm90IGZvciA1LjEwLjIxMyBvciA2LjEuODIuDQo+Pj4gDQo+Pj4gSSBh
c3N1bWUgaXQgd2FzIGJhY2twb3J0ZWQgdG8gc29tZSBvbGRlciBrZXJuZWxzLCBidXQgbm90IDYu
MT8gV291bGQgaXQgYmUgcG9zc2libGUgdG8gYmFja3BvcnQgdGhlc2UgY29uZmlnIGl0ZW1zIHRv
IHRoZSA2LjEgc2VyaWVzPw0KPj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBBRVNfU0hBMiB3b3Vs
ZCBoYXZlIGJlZW4gYmFja3BvcnRlZCB0bw0KPj4gdGhvc2UgZWFybGllciBrZXJuZWxzIGluIHRo
ZSBmaXJzdCBwbGFjZS4gSSdsbCBoYXZlIHRvIGxvb2sNCj4+IGludG8gaXQuDQo+IA0KPiBUaGFu
a3MuDQoNCkkgZG9uJ3Qgc2VlIHRob3NlIG5ldyBlbmN0eXBlcyBpbiBteSBjb3BpZXMgb2YgNi4x
LjgyLCA1LjE1LjE1MiwNCm9yIDUuMTAuMjEzLCBub3IgZG8gSSBzZWUgdGhvc2UgY29tbWl0cyBp
biB0aGUgaGlzdG9yeSBvZiA1LjQueS4NCg0KQ2FuIHlvdSBjaGVjayBhZ2Fpbj8NCg0KLS0NCkNo
dWNrIExldmVyDQoNCg0K

