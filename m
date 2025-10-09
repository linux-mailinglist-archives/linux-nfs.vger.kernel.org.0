Return-Path: <linux-nfs+bounces-15107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB3BBCABD1
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 21:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EF1C4E9F5F
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88F025BF18;
	Thu,  9 Oct 2025 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="sqesLDmg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021131.outbound.protection.outlook.com [40.93.194.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258EF25A359
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760039956; cv=fail; b=NRueZKzRn4eti3HlT+v92lZ5sWFfz7WHnIeMEB8yr2azmFccP9Tkte1Wu2jmK+dBmEtfrt1XvmkeI4QGKyoCLk8Dqzhjf5F4UgGUBezK3jL1J0w7wOOMCGaoK1yJzW/f2e0wdc+amKxX+wx9mIoRQl49gknpzIw089lI1P1VXRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760039956; c=relaxed/simple;
	bh=ncddB0JWDiT90Gm/sDQAvun5aHCPDLUVl9wJPLrXpMI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cg+GbL8h0Ahb5u/g5xvVKpGiw1KXXdDPiaU6tVPpxbFCGKtW9VbOY9ebNNSZJk7Y+Ymgl/yUH9y1iBbhoQK7KN9QX3iYaqamBTaFhNCI9DmKp7PlQfWn8st62k+NUCWSC6uU06umAexur333sksAMzAx2vcXHXr7F//I70i7IZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=sqesLDmg; arc=fail smtp.client-ip=40.93.194.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eN+QjQFBu0kak0ePBA6xhObHqmoau0pM7tSJXj1j3Wpm5oH/pMDfzeDg1THuRrDNrH6QR+NJzHtbg0V9EaMyIuiENDwi44KNF0KGX0LdgtvfqnDy9uETXE9x7TV/b8xpmskRonVYikPhf0Jxzrn1mBlaheAsvbskz/UM8fVtvwn+2AX32xs9K/vzaAmk/6invqysoqu3DvZm4QKvrFbrbSDCrtdIRZ7dNJZHN2ithAdFanWcP5sC4v5GKsqnfdG0ArFCN0PRHIWknap7hgQhRDdsrvb8S0lxukhLo6lpMskK4JHMErLgm6ljmpQxYX1PtsoPg3/rqxlAfZe+rnAaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncddB0JWDiT90Gm/sDQAvun5aHCPDLUVl9wJPLrXpMI=;
 b=i01MlOuBkFzUQuALb1JZ9J7A4y8rs9oQYUotY1awVv8NEkUl96Z4Q0xHvwNsnNsB2Bs4wn5jhv61qNqfOJJrapVgovmD6RDp13CjxEbPQrENQpaEQfWkskiDXgQ3ze+sFa9PU1XuR52uxzo2dg2lBySudEfpC3uB5ttWJeC42EcdoJgpoe6rf+l3ao26UT8eU6S/keCXLnMOoVjJm1wC8sKTWsvmQXFesrXW3tLUI9qc1HYlF9Hzt0qoG6t7OQn/JPpwS0u8BPbUshWS93U8y9fDRSZXok3oTBssH4mPleNyo9CZU/3s1SxTwct57nTpLGToRbviosmIip2uZUPWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncddB0JWDiT90Gm/sDQAvun5aHCPDLUVl9wJPLrXpMI=;
 b=sqesLDmgFSXsTLZFYapFBF9avGxR0PF669Zd4KnDsISz+HUZkM4ExnvNTe4X2KfomUC84M4DyfuwCEJVEo19ZFgVhSqKqb9zJlpaQ1nhRbR3gBTzUMSJOYsBfmqUMcBCCM0AC5KpAy/i0XSdBrFbgdxCuZSrR7WBuFBmj7h+kRdCUmkQC8JOtyfmBsisvagmfjkZ9OTqhFqaUdfxsknHTZVl5k4GDFaFOqL0prmXxLBFuBlh8+J9rg/0kgNYiQO5rxg/7584rTwUmCsbt8feBFbmk/S5ASa72KRvIhO9mqei8TXCTMzfJQd7G4MFY7Tc8MagdLPLykOjIB8+bRqcDA==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by IA3PR14MB7679.namprd14.prod.outlook.com (2603:10b6:208:517::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 19:59:12 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 19:59:12 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: can gssproxy be used for both cron jobs and normal users?
Thread-Topic: can gssproxy be used for both cron jobs and normal users?
Thread-Index: AQHcOVcuVRc+x9w0kEePODIRGy9E/w==
Date: Thu, 9 Oct 2025 19:59:12 +0000
Message-ID: <7861648c-f001-4dce-aa40-9c1f1c253f77@cs.rutgers.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|IA3PR14MB7679:EE_
x-ms-office365-filtering-correlation-id: 9e2aa88c-cb3f-46f3-7f29-08de076e5155
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFZ1cTdyYUtFYUhaRGZpTi9IL09NN0d4TG5PTno4cEl5bzBmbGNwTnRDQTRS?=
 =?utf-8?B?eGE3WG1Vbkhab3Z5dnorNmpaREw3eXpJT2thRGlpVXV1bHUzc0NSZUJQMkt4?=
 =?utf-8?B?UGc0U0ZTaFBVS3VYYzJWdG10QnFCbTBNd0pRcnNacXU4RUJjYmZpSmdoYUMz?=
 =?utf-8?B?bXlIbDlKdzM1UWx0UGJyMWw1RUVyNTFEOVRlWUtkNTh1MnNSdHF3SXdFUEJV?=
 =?utf-8?B?Ny9pS1g2MktSRVZyTFlrUVNxUHFuUmtNOGtsb2lBcjlmbW1tUE5BRGk2TnUw?=
 =?utf-8?B?WGtERndYTERaNmhtait5QlRwL3pZcDlUL095ckdzdEFObGFyN0N2ckwzMm5v?=
 =?utf-8?B?bXVmQ2g0TEtLVVdndU1mMUErTURaaElFSHlZMVp4WWRBRTI3NGZaSFlzVjVS?=
 =?utf-8?B?cVh1NTJNOEFKSFNtaHNxWE5rT3FkQkszRnNDaDNOR0dwRTNwdmlSQ05DYTRB?=
 =?utf-8?B?d1JSVlRhbWhJSC9Salp3dlVhMG9EKzZLM1ZRVFJ0MUxDTkRWSUtBakVLTlBP?=
 =?utf-8?B?eDUxMTNnVzdtb1FYc3lkcUVObVliUzdMRi8wV3hyMFJLNDJPenV3NU16SmF6?=
 =?utf-8?B?TEFxVDAzZkpoMEsyaTNENWxuVUV6bHhMSXpqMG5NSDBNTmNpa1RXbC9vWTNU?=
 =?utf-8?B?MXNQcnY5S0RBREdzenlCcGZPMGR3R2FSODNjS3paVlFtOG9YV0EyU0ZzRzRX?=
 =?utf-8?B?UTljNTUxOWtVQUt0Qm5nWlVvbHNzdEZVb21qQ2dVL09Ud1pzOVl3WjVvN1h4?=
 =?utf-8?B?QkoySUQzdVB1UURDeUh5ODlRM3V5bUY0c0puemhiMFNRaE5KZ0Nha3pGOWho?=
 =?utf-8?B?S043WjNKR3BUOHFCeFQ2NTNreVByYlZEd2N2c05LVGdLbnQxeEs0aGpWZUt0?=
 =?utf-8?B?UjRCOEpRMVE1YWRZOTJwM2ZFRk9QNkRHUTlVSU1MTkd5U04vdzh3a1FEbFBQ?=
 =?utf-8?B?L2RiS2hRWGU2K0lhUi9WUjh6M1BiYmMwbVI3bUtGRkNHM3NJSVBreDNoNjI5?=
 =?utf-8?B?aFJMTkJiRnJidGU3OWpCekM1clJoU25FT3FtdEU1YVRjWnc2akdRSGhKNVpr?=
 =?utf-8?B?c0VOYnp1a0RFVmpOK2llbFpBNWJoNUJnWDZIT1Rnek1qQlZXczFpOTdORnBZ?=
 =?utf-8?B?UWNpUG1zNXNkRGsrZVZTZE5GZDBKMk9OdjR3V0hPL0NJQ0F1YmVvRVhSek16?=
 =?utf-8?B?bUJ1ZnJnblRPRHpnRHVXNnIwQU1Haks4NS9lM0pMMkFYRFVVMW5maFZxT2VB?=
 =?utf-8?B?cEgvUWVjZ0FobFlGWHpoNmRxd0ZsVmljbmhsVjFGaTYyNG95YURBMk96a1J0?=
 =?utf-8?B?Mk9teFg5S3FPSGljbXg3b1N1bHZYQ2hLa3JkL1NqY3hRUUhjZVVOOUpUbG1W?=
 =?utf-8?B?UVRsOTZTejlvQnpUOTR0SkNxOG1ueTJMZzViLzJsWmpncmVMT2pGcnRhNTlu?=
 =?utf-8?B?eUpmMjQyNzEvRVNRRDZMZ0pjc1kxTnpXcTR3STZsVFpNeDN1cWg0L1hobDVV?=
 =?utf-8?B?UDlPTVlsbENJRFM5bFgyVktQVmpLWHdjZy91Mm50N2lPQkd5eUZlNWpYbGdV?=
 =?utf-8?B?Y3p0QlBnTGNQUWlVcGlFMnZaVStCZlVCalgyL1BtQmlydlFOWU1EOXNWck1B?=
 =?utf-8?B?MXRGcHRIdytuVkVFZExBcmZUV09ZK0xaMG9YV3psdFFqbjRaVGt1cTNPb1hy?=
 =?utf-8?B?azhIR2EzeVlqeXhUYWNYQkMycmFtS1l6aVp3Nm9VRjZCQ0U2QkUxNTRDK2xN?=
 =?utf-8?B?WXVjTTJXZ3lvVlhCckRDUWUrc3pVVVFUdVVnU2gvYjJFWUZRdTZ6RWhOcmRu?=
 =?utf-8?B?aVNISVVmOTl2NUF3Z0paTEtSTkF3bmdaenBHaldVU2o0ZjFQc09WcHJkVW5Q?=
 =?utf-8?B?OEE2TmpFa2JITnBPclZhUEV3elhHMy94K0tBRlFDWUtnN0FCcTVkMDBlN2VH?=
 =?utf-8?B?a0luMzZVYTJBZHNQN2NoYUtubDU2aUpTc3Q1cDBKNHBmWXRSRm5wUXlmdmgx?=
 =?utf-8?B?T3FXb3YzWFRRUmxlcmFDTWdpeWJQRmFOZS9XRzNpalJ4aWpaS1VBNDNyd2VH?=
 =?utf-8?Q?bhBGiD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmYvM3ViU0RSTmU3VlBCZGNpRzR3bUdWc0hnYldrcFJkNzRSN0E4OWRYL29o?=
 =?utf-8?B?M0tYRDRuSUZucVZSK3lBMWtVZldRaXJacERHQXRKVkJGS1EwZWo2Tk5jU0Zk?=
 =?utf-8?B?RVFzTTdlWHJlWlJlSVlZb2poSG93UVJ0V1FsSTFvbVNWUUlnclFoUWdqaldn?=
 =?utf-8?B?THpYbEo5N0pZVitNcVRkV2hNZ3VVNFRYOFFyeTFTck83enMrUUluclhPdGMr?=
 =?utf-8?B?TzA1cHBMV25MMHpSbVdqR1VLRVkwVlNUbW14NTFSSDlNRWFhTGl4WUFXeXNW?=
 =?utf-8?B?aEJVK3JvTTlieGxoMkJTRDd5cGVycFBZT1dvMWJ0aFNRNG9OUnBBaGVtSUJY?=
 =?utf-8?B?K2tRNjJMZE82bHFyNlJQY1hMMkhaWkUwNmtQaXEzMGppQXF4SHJUbmc4NHFQ?=
 =?utf-8?B?NmZKUGc0UXo0b1gwcHhuWG0zYWNQUG9paU1GQWs0S0JLMW94OHFvOHZzbzJE?=
 =?utf-8?B?MWw3UXhnTTJkdE1mbEZNaEp2VVk5RVJuUmgwTEYzNlhvcFQrWGx1NWoyTFhQ?=
 =?utf-8?B?aEsvb2J4SzcrT0I2UHBUbDZsbVE4M2p2UndXZXRNeVNURjdmSm50cGVURlVE?=
 =?utf-8?B?aXlaeWdVQ1hVb080UW5zOEpvN216SjlURGN6WkRyY0E1RktxM05LL1Ezb1h0?=
 =?utf-8?B?SUJPMGh0UjZ5VEVWTmVkTnBEbGtnWk4vc2xldnB5dEdoZVNGdExXa3pBTDVY?=
 =?utf-8?B?MlFvV2N4MnpyMlU2NjFGbi9TcVA3bWdxdzIxTURTSWlpL2s4RlczMHVLWHg0?=
 =?utf-8?B?TnAvb1ZRTVZGUEQraGYvVCszaXl1TGM1bkRseXY3cEtrQlhsSUxxaFRSbXVG?=
 =?utf-8?B?MWFXdTl4Mk14T1VUek9IVWkrWmFUWmFiYmp6N0tqY050VVN0dEZqdDhtSG50?=
 =?utf-8?B?ZW5nR3JpaTg5aS9nMXMwVmVzVmdyWTJWaDJGMVhkdXIxbXdSWlZzbjFtd2Zt?=
 =?utf-8?B?UlVVY0hKZk1QTldZVGI1d0w0Z2pMR0ZacEhaN1ZxRTR6eUZJUFlhMWR0Vkpq?=
 =?utf-8?B?UjlULzN3SElOVUZMQSs5aW93bSsrQmxFZ0twZlpIUEpzWXFIUk9BU1BZWEVx?=
 =?utf-8?B?ZWdqMUJDR2RSWmY1bE9jdWRkeVpSMHdWaUZZNHFQbzRIT0pMRy9jVU1oV0M1?=
 =?utf-8?B?dkUzaFZ0QVN0OUtlQm9LZ1dkY0xiVUIxd3YrSlc5QWlkaTFWa0IzRTM0NnFU?=
 =?utf-8?B?aUlMamJiYjczNERzNXFYTFh4OWhFTVBvMXM2SmloNUljLzNBb2Jkbk9JR0xF?=
 =?utf-8?B?aUl6ZWpkV3ExdlowV0pWZEJBclNoc2djQkVFUUtGUW4xdE1QRGhmWXJpSHlC?=
 =?utf-8?B?U0d0NDZSSFExSER6QXJqd2NGWUp6NDRoOWRad3FML1hFYmdvdTdBWURxNjY2?=
 =?utf-8?B?dmRBbkUyaWNPb3FORndwMTZyTUx2d2dvN0plQkd2bFFCck8zS0ZLcmdMa1Rl?=
 =?utf-8?B?NkFZZDZXUG9kMmwwb2lOOUdhVU1vOStYZFNFdkJNRXJXc1NaanJXSm9WeGJn?=
 =?utf-8?B?bCtqN2JWTWdrdWJSLy94K3JKeTcwZjlBL2VMZ3JBUzByRGdpRUpGY2dzaEVU?=
 =?utf-8?B?TlRMbTE5NnlpOEE3SWFpa2dPR2NValNHTnAxQVJJd01YNHYzM0tZMXFUNGps?=
 =?utf-8?B?RHE4SFNISVhSdUw2eUNtbkF2dXcwK2dJaEw4aDd1UitwNUwwbW95TUhYcUsw?=
 =?utf-8?B?VlFWaTY3MHBZU05xTkJ1cjExYk1FdVJvNG9UZDRqeVd1ajY1ZjAycExneEpB?=
 =?utf-8?B?TXJ0L2dNUy9QYXNNV1JiSk1tYkF3VGtRUGhsWWx5T1V2NnRqYkZRNE11Wjcv?=
 =?utf-8?B?c2plYWl1a1FqbEYzYVM0aXFCb3MxYjVBWEg4OCtMMHJnc0tOUlcxbExrMzEr?=
 =?utf-8?B?TlpvU2poWE12dlJDVVlWZ2FEb0YzVk1LN0VNczI3VWs4Y3A2REtkMk9YYW40?=
 =?utf-8?B?WWVCbDFtRVJqNFRRTllzNVkxbnVPNUo5TTJnZGRNeEhEd0llejFHb3hBSGRW?=
 =?utf-8?B?WXZZaExOSlNGZW1MMHF1QjNvTCtDOE4zbFFJTW5lYWl1Uk9yamwvRjg2RnZE?=
 =?utf-8?B?Z0l5czNnS1ZQaDFwQmprM2s5MkFjdWVMZ1BwUmJNeUtvNGZaaEVvMytHZEFu?=
 =?utf-8?B?YzN5eEpSTERIS25PcVBpYmExVUFIcmdITGNRZUpqeXEveVgybEhzUzBYMVRh?=
 =?utf-8?Q?C4OLmKh3T5DlIOLzXE19wAU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1889489E684D4E4DB82E4C8AAB68EA14@namprd14.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2aa88c-cb3f-46f3-7f29-08de076e5155
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 19:59:12.5303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6h1mcHv6qySzYSVcnsUXPyZJ0v1TuvWa9KICxcMLIs4d3DqVvtQjh3orecGJDFxLxC0GWgLcpWEZESciurK9xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR14MB7679

PiBJIGp1c3QgZGlkIHNvbWUgdGVzdGluZy4gV2l0aCBjb25zdHJhaW5lZCBkZWxlZ2F0aW9uIEkg
Y2FuIG1ha2UgY3Jvbg0KPiBqb2JzIHdvcmsuIEhvd2V2ZXIgd2hlbiBJIGRvLCBub3JtYWwgdXNl
cnMgY2FuIG5vIGxvbmdlciB1c2VORlMuIEl0DQo+IGFwcGVhcnMgdGhhdCB3aGVuIHJwYy5nc3Nk
IGhhcyBHU1NfVVNFX1BST1hZIHNldCwgaXQgYWx3YXlzIHVzZXMgdGhlDQo+IHByb3h5LiBTbyBu
b3JtYWwgS2VyYmVyb3MgdGlja2V0cyBmcm9tIGxvZ2luIG9yIHNzaCBkb24ndCB3b3JrLiBJIGxv
b2tlZA0KPiBhdCB0aGUgc291cmNlIGZvciBnc3Nwcm94eS4gSXQgYXBwZWFycyB0aGF0IHdoZW4g
aW1wZXJzb25hdGlvbiBpcyB0dXJuZWQNCj4gb24sIGl0IGFsd2F5cyB0cmllcyB0byBpbXBlcnNv
bmF0ZS4mbmJzcDtJdCBkb2Vzbid0IGNoZWNrIGlmIHRoZXJlJ3MgYQ0KPiBUR1QgdGhhdCB3b3Vs
ZCBhbGxvdyBpdCB0byBnZXQgYSBub3JtYWwgc2VydmljZSB0aWNrZXQuDQoNClRoZSBhbnN3ZXIg
c2VlbXMgdG8gYmUgdGhhdA0KDQpHU1NQUk9YWV9CRUhBVklPUj1MT0NBTF9GSVJTVA0KDQptdXN0
IGJlIHNldC4gVGhlIGRlZmF1bHQgZWZmZWN0aXZlbHkgdXNlcyBvbmx5IGdzc3Byb3h5LCBzbyB1
c2VycyB3aG8gDQpjb3VsZCBhY2Nlc3MgTkZTIHVzaW5nIGEgbm9ybWFsIFRHVCBmYWlsIGlmIGlt
cGVyc29uYXRpb24gaXNuJ3Qgc2V0IGZvciANCnRoZW0uIEhvd2V2ZXIgTE9DQUxfRklSU1QgY2F1
c2VzIGl0IHRvIHRyeSBub3JtYWwgY3JlZGVudGlhaXMgYmVmb3JlIA0KdXNpbmcgZ3NzcHJveHku
DQoNCg0K

