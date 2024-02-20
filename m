Return-Path: <linux-nfs+bounces-2032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C4585BF43
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 16:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9741F23651
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AB773162;
	Tue, 20 Feb 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d7zanExW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OJlYiUvZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB067E91;
	Tue, 20 Feb 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441195; cv=fail; b=giX+zPdnojxZFgAwPeGMJ0v/o4HnVgRIHN4W/H2RFvVDPlmkjPckwyu9UVet1K1FnrBWr1NE1Yn3c92q2PE5bmpI7zMhRZSN1ynMfScfr30Bg1RfJbgNeu1UeLigSaY/YwENTIL9J8BjozNEaAx/3X1rEVEdBO4pDGCuLYc6fiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441195; c=relaxed/simple;
	bh=c/EZ0XYRuXn6V5S4NvG4hOAX5PSc3Ej5luI7ubY8mu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uLUDeNHJusk58wUCIjxV0YOQOi8ZdgAFn6jjsZ6TgxmA4o7T25ixCq4M+YYQl9c92IhrRxunG/Rs9YeNxWxyV5wDwK1lGNH3kAXQTp17kugoaozKNbhfaU8sNx9Zex0va5zLFjZmusiz4wEvpMxTkXkZL7kThasX+yxU8CkZgTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d7zanExW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OJlYiUvZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEe6rv002043;
	Tue, 20 Feb 2024 14:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=c/EZ0XYRuXn6V5S4NvG4hOAX5PSc3Ej5luI7ubY8mu4=;
 b=d7zanExWn8lPY1hFvnlo9nT1PaG1l95976xVV2l5D4bxMpN6pXrvWkFWTL/KloZcrfC8
 0iQdWQfM5T3slL0/1bJbDXBVEfmrNUzy2331VxpMnWPfzx7MNnhVSCDAPCnVFpOMxbmH
 etUqntiAOyX/FSg/IBrs8IRS1/j5WOUIziNfb04OSRfYnMYsNL0pdQUa4AtyQrJYk+WJ
 S/SXhElA7RVlEA+cSpjjBxZiA62XWR5T9IxUSJbZx9aELXFaGbOSa+QY83n5mFzwd5RJ
 cS4BlZqpdNluizbcmCja+n36P2LmScIWrGQla7Qnk6Cb1PpZ5rpdNQop948WrFTIJx4O xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd26yxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 14:59:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KE1FiB013069;
	Tue, 20 Feb 2024 14:59:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87bhqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 14:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRXc7/JgCsEASW1mXDX6ic7oahH2OHtJWHmdMZMj652CcWEs8CYsVoN5xwepaMywuTkkvQwLmAjVlVOHqk/oKMwbC7kQrPvaVENsqyiUnQLmlzm57HNJA4uUgxLaH/EzmW0NPAZ+Jz0HeDfmzOLUArUzpJHQPem/T4UjurfuJkyXtdTt18Y+F882CNO8k3dC5t8KUNQTw6MFXHVmJGUzq7q+OZX3o8e2j+79ivzdQGVKw70Sz9lmninLwQXVn2c2ycp1pmNBT8VSVD4aS4fW2O1B+gUY4UgcLmJc/wHNQ+xnnD0yxudn/fL4N0YDSD72s49RY+M8d7Z3BLXTrj9krQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/EZ0XYRuXn6V5S4NvG4hOAX5PSc3Ej5luI7ubY8mu4=;
 b=EwPN4zrk3B/gwDjGcP8dAzjMimlEwhqaXZGVc1C8hbzwFntMsqhp3wV+8/zAswGRHG0NpVYM9IKMKHCVQaWgmhP+mtiD1j7/6CbnmBvZIZNiysrEN/wlPEaTAS8DDZQknjg8C4mSeqygdyqldtoF4oGSbHckv/lb9fhPVoCrqyJPhg3/4XfPz2JgSWf718a/jWIOdftOzt520HHRCFRBS6lKA3tJI78zqc4gppUzHO23dnZQ9qNTkEa0dPuRa7nCnZ0vP6Ls+T6Pj7X8t2yfmooTPxajrwjzHe7tlkuCaRf6l89x4Tm5LNJVxmnP01tE+GbKhKsNrK9QfBrTF/ouiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/EZ0XYRuXn6V5S4NvG4hOAX5PSc3Ej5luI7ubY8mu4=;
 b=OJlYiUvZjVpKwXZy9moVr04WSsuYuhrEK5ekfj2XKA8TcWjyj/nRMBE1KPcjrMqnAWB8e9gd3+zgZJaafBzaSi6iujNMstRSAJBRw1ZrUbhEr5Sh9TC/S33OGXRNCcEkea0Fx8ThCQD6fkC5Euohp1DE25XTvwE1Gtn/V8W24V4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4588.namprd10.prod.outlook.com (2603:10b6:806:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 14:59:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 14:59:40 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: linux-stable <stable@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [GIT PULL] NFSD fixes for v6.1.y
Thread-Topic: [GIT PULL] NFSD fixes for v6.1.y
Thread-Index: AQHaZAw2jNNorY6duUyNX7GfusX73bETUjeAgAAAgAA=
Date: Tue, 20 Feb 2024 14:59:40 +0000
Message-ID: <4F521AD4-665D-45E2-925A-10E276F29F7E@oracle.com>
References: <ZdS8TXWl3QKf0qdk@manet.1015granger.net>
 <2024022007-atypical-postnasal-37d3@gregkh>
In-Reply-To: <2024022007-atypical-postnasal-37d3@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4588:EE_
x-ms-office365-filtering-correlation-id: cdfffa1a-eb2d-4d1c-efe2-08dc322490c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 V45rE6Dfxhh/uwOXmN75d5Pt0oEi59V+aBi+UlV8qMUACnvczBFuFk4XqdfeSM5/HGStNdgo2JmTrh35wlLi2kQj1MdEuFFTNzjfOHq1MBn7c4V3IdGOdVTHp4ci0iOAoKdODiDiEkHQm7DNSAm9VRpqlSs3U1aTLVLKfXHYhPy5lr4jak+wUvWMqP9IZExZ5ipYznCzK3F2WvSGqgAb5Yu1e2/a2p4hYOi7XFZqSz8NW2hdcd8scLia0fxAqweELLRksk3wBI2VC+dHHWElOE/N71qsThZ/LjYTJUBKb78w82zEwflwjq0Jrj9v2AMxtYatWcb9G2odbEaCgWwwg2GIBhi6bRfQIhGitHbAdt2Vsx8XVm6HGZ2R3Wax1UB1vddHRyqUaqomGPZekUCz4H6BDb56DrzlU+CQfsB7z/jKnXTMdJ4MdPSCYAjru3DamFDqJTKKcK+1jnnE1/5HhnS4fuFt3lJPQyE2dV9q87980LzE3GYKFNuYApMME1Ac3123OS5B0Gm/QdAvjaIPGjnPzu/7pr9DMTCHXmnHTWANPQSEAKuh5qJ2vCq9sSJ/42WFv9lG9UkYxXn+GqXx+V3ZbMxkbZiDtyJN49iSkEg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cUFmRzRROWxPZTlNSlg2YzRjVUswQ3lJUnFDNnpGL25CQXJLY0hseENRR0Fj?=
 =?utf-8?B?QXBTTzUvLzVkenozejBqeE0rSXlRa0hLUElRbGxSemo4NnRYVlRjVllVbVpw?=
 =?utf-8?B?U0NGcUpWU0RKZVo0RklYNHZDVklzK1R4OEV5bUdtclNIQ0hseFB2VnhXV0wy?=
 =?utf-8?B?R1BsSEV5eXhIOWxYZnZ6Y01seFFKRjVPWWQvQU1VdWFucVh4cG8zTkVld1NQ?=
 =?utf-8?B?S2ZLNlFjRFBRV3FnR01pcnVDeVVMcFdOUFprUWZuaG9YTkZkOUpqRkovbGdq?=
 =?utf-8?B?SEFZY1Z5ZU9mZTV1dFlsZ0VsZXJBajdka0VBRWEyU1c3d2V1TnY0SjlXMi9C?=
 =?utf-8?B?a2ZoMEhEZ3JHWC9mTHprcjZSaXBuWWg5OVdBMm9Wc3BHUGFhUDZqOXBCTHRy?=
 =?utf-8?B?WnJUTDlIT0dSVytGdUtVc01ROVBFVDd4ck85RDR4NkY5Z3pUMkcwdWVCUlZ0?=
 =?utf-8?B?NXJvVUJJTWgyVjBxK2VXaUV1MzBnQVdBSWFNZ1RpOUx0L1pGQ2hDaUhFU2M5?=
 =?utf-8?B?RGNXbEs0alQzbFcwZjIremRiOXF3ZmlibUlHOWZnYzhDQjdLOUYvV2RQQTl1?=
 =?utf-8?B?MDJwSkUyQzFRQmZIM29OOEJpbVJqSlI5ODdiT2FLZDFPdzRLUS9weHhqQVlR?=
 =?utf-8?B?YmhCTXdSVlN0KzNxNGJmL21Ka3ptdWpkWkhhYmYwcHdhTldkUFNweW16N3p2?=
 =?utf-8?B?MS91OGlEYzVGNW85VGpnSUx1bEEwVjhUc0NkL3hIMGxKOWM3R1c4Z29Ia1Jv?=
 =?utf-8?B?c050Ri9TYlVUSmR2R2lKY2s1MTc3bDRQeEpEbjZaemhvTTlkUk1sYVk5a3J4?=
 =?utf-8?B?eGhPZklCZWZPMUQ4YmhYVFpmMXRibCtYNCtBYU9IY01pdUlKVVg4c1RlNGNZ?=
 =?utf-8?B?WmNkVWNzRjhkSnhPT1J2M1dxUStTWllxaVFsNEYxWkdya2VpMEs1ZGJvNTVR?=
 =?utf-8?B?RE8wYnFLbDBteVlzcXBHb2dYd29tVnpUUFlYbE42UE5nOHVhYmVmMjBHZEdR?=
 =?utf-8?B?ajdaYmNjMEU2amNoWENMTEJESWlzNHNLeDVZZm1reTFxRTFVSHJHYVVqazFG?=
 =?utf-8?B?WXVneGVIM1NUWnNMTUZOMzZwWWg5NldxZEIxK2hpTTdtSitZSFlhdFNqbXQy?=
 =?utf-8?B?c25LOG1zbzl2SGUycjh4QW5xNGZxTzl4UW12emRaVmkzZEtzaVlGeFlTSTFP?=
 =?utf-8?B?eGhUL1ZtNVdOOWdBUnFsODZNK1FzMlRMcGRkZXZETGpudHN1bTlmNTZDSmNN?=
 =?utf-8?B?YU1SZ3ozZlVaTnhmd2RGRkNra0tVSWVxSHdrNUhuU0g1VHoya2JnSER6bGRT?=
 =?utf-8?B?bW5uOUhDK2ZZZCtjNWFXaHVqamxlbmpLcitWU20xeVA2OW9kRFlZaDFiVi82?=
 =?utf-8?B?RlJ1aklJMjQvYXgxWEh1S3dWanc4TFBCUzZmWkswWFFrekl1MDFlZzdwWFhz?=
 =?utf-8?B?UlhUL0JhTGRRMG9ldDArZWQ5Y0dTR2NpT1BreHNQdEtZTmN3cEpxTXVhZEQy?=
 =?utf-8?B?c2EvV2IwRGpuSkJtZFNoZjVUM0didzM5NkpoSk56aXh2djZyRTB4NTFkWVJY?=
 =?utf-8?B?ak4zT3RSSnJRaTNHeWhzV0t4R0s1cWZ1N2krZm1TSTMzcm95TXJZc1VJYk1W?=
 =?utf-8?B?elBpMm93WmhMc0pVSnhWZ1dHdmsrNEF0eXY4T09ITGtZem14eE5JUTkyWnQ2?=
 =?utf-8?B?N0c0bEw4T1A4anAycm9hNmFoNjNEL0ZlVk5tbkp5L3RWNmRpYVkzYkVvZ2p1?=
 =?utf-8?B?YysrbEQzMnFHNENaTVlXRVZHRTMrSW9keFBOengrRWt5NXV2Z1VvUEhmeDRW?=
 =?utf-8?B?ZWpweWtxZzNLcWlkdlozb3ZtQ004TEYvNDF3aUozTjdyUjhiWWZUSC9US2tn?=
 =?utf-8?B?blRPc1BCTTVUNXFUd09PcXRyMi93U0JlWXl3S0QzVnh2ZHlEbWtWa0lWWFlk?=
 =?utf-8?B?aUY2UzNSTzFwYzVrUGxyV2k2ZFJabjVXWFg1L1F0UWVKakQyVWt5dzNnWXE3?=
 =?utf-8?B?eGxuNFRHQ2owc2FncWxjOTNFU2JNQXc0MkRXeVJCN2w3ODFHNXd3ejRiTU93?=
 =?utf-8?B?QXFnVzVCWlhWZXBBZ0V5TUxsT0tWSTI0bWw2bkFVNlU5RENHak9Ka2RQRHFr?=
 =?utf-8?B?cUN0eFEzTE93WUszMHFSa2JvQ0F5TkhHV0RGWGpBSEttTXNoaE1oWFlNMHZ6?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C58594D6A406E4084CE91A2364CA314@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+MvQppThlxPaIX39peGlrXCLIs9+U4ku3UuhePTCYJ297HBuJWmKcYvkHggVLfFn86iBLwggYuyzTYzFN/r0SnFr7EoYBleaHWvlrSCR8ylaOkF2zC+ujNiq5xTw5VxmBmF+aH846ylmoqpw/rbS20xNlaiTV9ImvKacnIjOqSq16z0ANpYF1fVsiYcmHBn8ZuLgyCPqI4mDK4N6/FtuH9mY0LiN8OISr041ykNND6W9JsvDgX1MXwpNnt8S6MP/GpXcrknimWxhOeZM/MFIR5thvbLlmiKWmymaawkacp2L5JXXafVGuzkGbamv8sAodgIUbAXU9DUs5O4zuzR0cE1oWaM7u0lj+yk9mZqvdm+qea2l4OR3YvANRRuILchknnwFyTZx25ypzgh8xBtmF6ge8in9Um4AjPiig9+hgDUQjrDX1tHL1RwxTzOCD8RGDkKcqRiYb2JQBxUPG5dkyYifKLCCRJIFIolEbTOS47ZOipE/XGmN1HNJTojqr0YPHAuYSj+JLYVG5JLYI35B3vQNGvyIcOM/qNPGbfYMiLsVk2pjC4x+p8Nz0j+96R07cCYSkfbdQdBVbLJYgPQRa1YhvzJvjhfiH0Ixwzygrrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfffa1a-eb2d-4d1c-efe2-08dc322490c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 14:59:40.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYyaMVn/J8nW6jOQyKGhImOHfGE4ovAp1wr3gqYY2JBYbDU8acfiSqJFp76b2UhIE9dmL6biNOBQiHV/XrmE5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200107
X-Proofpoint-GUID: WlIbvlgqdEijn6XQJj_uhrnL9bUZhe_W
X-Proofpoint-ORIG-GUID: WlIbvlgqdEijn6XQJj_uhrnL9bUZhe_W

DQoNCj4gT24gRmViIDIwLCAyMDI0LCBhdCA5OjU34oCvQU0sIEdyZWcgS0ggPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgRmViIDIwLCAyMDI0IGF0IDA5
OjUwOjUzQU0gLTA1MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gVGhlIGZvbGxvd2luZyBjaGFu
Z2VzIHNpbmNlIGNvbW1pdCA4YjQxMThmYWJkNmViNzVmZWQxOTQ4M2IwNGRhYjNhMDM2ODg2NDg5
Og0KPj4gDQo+PiAgTGludXggNi4xLjc4ICgyMDI0LTAyLTE2IDE5OjA2OjMyICswMTAwKQ0KPj4g
DQo+PiBhcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCj4+IA0KPj4gIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NlbC9saW51eC5n
aXQgbmZzZC02LjEueQ0KPj4gDQo+PiBmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZDQz
MmQxMDA2YjYwYmQ2YjVjMzg5NzQ3MjdiZGNlNzhmNDQ5ZWVlYToNCj4+IA0KPj4gIG5mc2Q6IGRv
bid0IHRha2UgZmlfbG9jayBpbiBuZnNkX2JyZWFrX2RlbGVnX2NiKCkgKDIwMjQtMDItMTYgMTM6
NTg6MjkgLTA1MDApDQo+PiANCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IE5laWxCcm93biAoMik6DQo+PiAgICAg
IG5mc2Q6IGZpeCBSRUxFQVNFX0xPQ0tPV05FUg0KPj4gICAgICBuZnNkOiBkb24ndCB0YWtlIGZp
X2xvY2sgaW4gbmZzZF9icmVha19kZWxlZ19jYigpDQo+IA0KPiBBIHB1bGwgcmVxdWVzdCBmb3Ig
anVzdCAyIHBhdGNoZXM/ICBPaywgSSdsbCBnbyBkaWcgdGhlbSBvdXQgb2YgaGVyZSwNCj4gYnV0
IG5leHQgdGltZSwgYSBtYm94IG9yIGp1c3Qgc2VuZGluZyB0aGVtIGFzIHBhdGNoZXMgd29ya3Mg
dG9vLCBubyBuZWVkDQo+IHRvIGdvIHRocm91Z2ggdGhlIHRyb3VibGUgb2YgdGhpcy4NCg0KVW5k
ZXJzdG9vZC4gVGhlc2Ugd2VyZSBhbHJlYWR5IGluIHRoZSByZXBvIGZvciBvdXIgdGVzdCBpbmZy
YXN0cnVjdHVyZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

