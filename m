Return-Path: <linux-nfs+bounces-18071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CA8D38D0C
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 08:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2571030060F6
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F07329E6F;
	Sat, 17 Jan 2026 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ewwePj+P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eQtaAVm6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A5328B6A
	for <linux-nfs@vger.kernel.org>; Sat, 17 Jan 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768633508; cv=fail; b=YF544nnIQkrposZhYJFCyUVliB/rfCTso4r1Qxoq2JOleLEvno7QdCPvDRxzW3ztKHCIOQVU0jYBrMDmdzfpKN5dwrTveXxvNnndZ0iU7NZXy6neJgzgPH1ZkTpW8/cE93PNRnNN0eU2EfELeOFj4+tW0d5UDfMn1dOuxoJFffs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768633508; c=relaxed/simple;
	bh=fwxlSDt541cDvqM/1dkWcNuMtdceqADJgpUO9cTuK04=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E8yG2K0PQen4Q74UiNbZgzj11z8JHkU8AzqZPyuR0rteL9Na07tDkCsKaA/sOpKIxZe5arz5cCCQrb3xKxIL3dJz2ZMHiSjpZ4ZGXl/YORppTaXpSgsR9cl03OgWWBLJCoM11iGTHdhmnpC1Rx2snWrYPZyX+puV52oX92KNsx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ewwePj+P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eQtaAVm6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60H70xnt337878;
	Sat, 17 Jan 2026 07:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=R+AcTQauXcygwWiM4lFuuPN0ULDavNLHZriAu0Y5o14=; b=
	ewwePj+PNq/IdBmXOmnyGcoTuXccskRtsI4DJdR6wfUv6G0izLvVv3Ga4YbZP0+c
	NVKqh1ifaSC1WeHJAwxUVCirZuW0lIvQYt3GgMD3LMf9Bvh/dAvvQV9FtvW2zw/a
	SbPi8RdTcTPxf5BqmrwtT4uaJuDfFRF5+u6jt57cKt5w4OsIr7XPViDEDLQ+1Q2A
	Cn6DesYyQDSIrelkxKNXD71IAhhBlRDBSUUjV+S6As4w8iE0qIjsN61wtgiuPzzf
	/rK6mN2iS+Td3RSj3LaFr6D6AbvQSWMUl2mls/h4c4A3aXWRKnvVKrPg55qzugGV
	piNK0CeRa6jDo+aSPkHJMg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypr3bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 07:05:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60H5JPfM032201;
	Sat, 17 Jan 2026 07:05:00 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0va6m3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 07:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjo1hrNPz993RW2Msszoh5dU69OXwVxbqadqW3LiL7V2VtuVR2ZHbQTy0fgDAqVPXTU60MzhH1sMlpgguxv6GvlgkrWhvEi0authp2q1x6W4gNsYEgZ3iUl27NrPnw58B4Yn7zVTvGd6nCVoHRVi7PeeV+giKlBHw6TCHWJH075ZiKpCVKngPt0T61Y7SfDhem+6sjopSK88AZyEAJYAklg8cxcs59W3G/SLMbMgw2F9SCjdpNVTYIQLDSeREZckYkW6zOC8aLPX6mXNx6L3T5ZCERDiaOnd37ATV0LKEzFneNEtgr5UzB8FOWkwqO986t8hmQaaYmeMI5mpVbWK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+AcTQauXcygwWiM4lFuuPN0ULDavNLHZriAu0Y5o14=;
 b=OnVtbQL5LzrT2/Qfs9F7k0UZq6OCBKFWTWkEVsHhb3T6pMunPNkSaPDHmzTe7U6tVGCPgTrtOCevTXyJOQ4WmBZXvbx391/gyThwQl3gnAGCU/uYyjqDgqrGtw7762Q0r6i5OR9fjXfZ/GZjfKJLI3w8QnlxUVQcfvshyLwIc9MoEfWUlcTp6Qzbq6OhW7LjBnOOSBqDqBHc14eNeH9u2XKx8bMHVGPNgo1A9nLGA71mVMUe6iyn8Fzq1dMu4Klqg2ejzsirYsfrke6M0ESY6j2+OnGJS3kGid+UC1LhNIRFtt51mVvwH6ZAgJIfW1LnRde+ilu5U4i9+TePjzLeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+AcTQauXcygwWiM4lFuuPN0ULDavNLHZriAu0Y5o14=;
 b=eQtaAVm6NOZQOA12sqVem/XmYA3fXm85X6zFoSaJEddxKbJJE6tc1EUoNs4GCG2UPthniYcUBT70kAcdGc2WD1xJk1DJ0AmS8fSFfhBlkWu+U2cTbn+/5lQgID0NuRsL7Bffx20B3DZ66Ar22/s6GM2HzJnch1dGnQZss8UW7Zo=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM3PPF40B0653BC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Sat, 17 Jan
 2026 07:04:57 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9520.003; Sat, 17 Jan 2026
 07:04:57 +0000
Message-ID: <08c33c91-abda-42de-8771-e61d48b50cc7@oracle.com>
Date: Fri, 16 Jan 2026 23:04:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in nfsd4_block_get_device_info_scsi in nfsd-testing branch
From: Dai Ngo <dai.ngo@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
 <a1442149-fdc2-4f66-b73a-499a2e192960@app.fastmail.com>
 <108fb719-8654-42b8-9e37-275726f4b5d8@oracle.com>
Content-Language: en-US
In-Reply-To: <108fb719-8654-42b8-9e37-275726f4b5d8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM3PPF40B0653BC:EE_
X-MS-Office365-Filtering-Correlation-Id: 741f0c4e-cb54-4912-4da7-08de5596b8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1VwTUlPc3dHVWdqUGprOXJQakdSa1k1MUxnSzVjQm93dk45RWZTNjRsenNB?=
 =?utf-8?B?OTlWSVpOWk02TnNZZ211OHA5eWVFd3h5L3J5M2ZuRXNDKzVrTkVRejlTUkd4?=
 =?utf-8?B?Q3dIdllvcmdSTnJwTFlLcmZra0lVamNCeDBIbHJScnRtVi9rL29hQzN4TCt1?=
 =?utf-8?B?NVl5ajBrZWJLdm5QcVVOa1ZKMC8zeE5MaERiNzEyOFFMZlFrOTg1bmpYK0FX?=
 =?utf-8?B?UTd6bk5hZEpROEprTHUzR1IzNjNVUktIdU1WNGM3NHBvMVAxZENtTUxabHhp?=
 =?utf-8?B?NW1KYjdtM3Z1Z3FNM3BMVFlQRU9IcXRjb0NHMTJBTlNYcTRaNmlFaUpidCs5?=
 =?utf-8?B?TkNXWFp3R2duakZxRWlRZEVRaEprUktPMFZQRlJnZDgzSlIzZFFQSVMyNGpK?=
 =?utf-8?B?QkQxWDZoUW5uWjFldUxUSm5kY0lXR0hHdDB6bldyY0hzRkt0TkNORzNreWUw?=
 =?utf-8?B?OGJib0xRcVk3dVdpc2J6bldtZ2FMSExZdmpwampoSUtSKzl0bElqekthdmVW?=
 =?utf-8?B?cnkveXlxbmFGVllzZ0FZb2JLR2d3a1B3ZXp4V2poTUt5bGU5Yzl4TFBUUDdu?=
 =?utf-8?B?WFp5UmR2U2xhN0psN2hRMmpNNEZmdmxRK2pQTk1BbHB6RGt5cSs2WkkrSkgr?=
 =?utf-8?B?M3FsdDYwU2ZzYzhWRnk4NGJzbXk4cXR3ZHM3eHMwNzNHb1FwU0tSc0Izek1j?=
 =?utf-8?B?ZUkvMmlURWdzUkZQV3orS0pxWjBmZGlNcUlHUTUrckVQUnpGei9PWmZKVkla?=
 =?utf-8?B?ZDNFN1QzN0R3Y1RUWmNFTUdWcFptUGxWQW9iVEdMeTErbnVrb1N6SUtmeGZ0?=
 =?utf-8?B?T3BYblFOOVEvWTNZOEpZRjJtM1VwUWdsL2JEM05lMFhhOE1ySSt2Qyt6NlY4?=
 =?utf-8?B?UTg2OHQ0NmJJd3BuWFZkMVhLRE9sMU5Yd3VzdlB1OWh1VVpwNHc0SXphbDds?=
 =?utf-8?B?Q2lhNXNpMUdCRUpReW9hNHcwVU81bE0rUGYrcGN4RVJPdjEyajVBc2VaZC9u?=
 =?utf-8?B?akM0M1dhdFNncXVNMEJ5YmprYU1Eb2QzZHZwamI0RGFINkNNb09ad2xnY285?=
 =?utf-8?B?elorNTV0UU80ZE53RTU4cXM0V3oya0JaYlBpaUJIK2dhT21hbjNJWk96cUNZ?=
 =?utf-8?B?YXJaZ1l5UzNxckpYTWN3Z0hIL0I5ak5relpxMlBmaEJTMU8zZkJ4MWFuelZx?=
 =?utf-8?B?WXdYQkIwU1pLQm9iVUFOWVdkUy81OUhUdCtPN2NkTE1hcXkzbFA4YjBVQWtL?=
 =?utf-8?B?dElmVXRUQzRtd25QVzJrWnduY0dpNFVHZWpZL1VQVFhaVzlkaDVkYnBsbVhL?=
 =?utf-8?B?M2pwci9KckQ4eWF0ek9IMDFFSkJKOE1lNUhkSit0OG5HcEVkUStGRmEzU1JI?=
 =?utf-8?B?ek9rNGc1cTNCZDZLdHhYTFh4Ny92V3hXNkxtaDdmcXltbFpDc3J4ZGk1bk9m?=
 =?utf-8?B?Y1Vza3dUMm1PMTF5YUx4ZlBGOUtrNXJteDFaSStTd0ZHMTAzcHA4QWNlQ2p0?=
 =?utf-8?B?VWhZUVpCdUc0STNMVzlua1ZVZTJXOUFVTVg2NEU2eGxoT2RSR1hoSjA1RGd2?=
 =?utf-8?B?aFQwNS9aY0o5alMyYnpWWlQ4Y3d2NjkrbEVBSm83bHVtdnpmMzZjNGtIcFI5?=
 =?utf-8?B?RkYyRUNIbjNIMEVvY0RSZHhQRGgvZnFjK2hSWFpEWW1XSis5Q2pLcHBlVENT?=
 =?utf-8?B?clRyc25BSWYrbTU1c1RBdmZtUFNMMXJFaVZZbVh6a0dPM3J5ZitRKzgvRXJa?=
 =?utf-8?B?SmdPbHI5YmhzUXV2WDZyRFFzUXhIekw4TFQ4NlBUcmZPV0Z6ekFDY1BaWW5R?=
 =?utf-8?B?b3ZJVTRoUG5VU1VkR2h0U2tqQkFSdHV4NUprUGxXbW83eWtZNngxNHFwWjFC?=
 =?utf-8?B?dVdvcVREcEdJMW83a2FId3U3Z3N6VUpUMFhNbis3RnhrZjg2T0d1eGQ5c0pl?=
 =?utf-8?B?bVRyS0VFUnRPT2NndytoU2hUV2NDL1NobFArcHA3ZmFXT1NtR3BGVTRrcmgv?=
 =?utf-8?B?dlhhSmRKUFJaRkhIeDBEeU5SRVV6dURXSUNlaXVUVHZzb0QzVjdNQ1dkSngr?=
 =?utf-8?B?dm1QNlV0N2NsVE1qZ3hXQi9HNU5NQlI3eXI0dW1RKzl5V21JK3hubG9uWFR5?=
 =?utf-8?Q?ZMME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NitzS0IxdGpQR2ZwV3FVaXlKOGRSeHlSbG1uVC9jNDRERU10Ry9Pa0dVUUda?=
 =?utf-8?B?NmFKbUNCYVhwRW1DWHpvaXhibG1vRUM0bTBDT1F1SlhMeFA2dCt2anYrVlF6?=
 =?utf-8?B?ZDVjT012ZzlqZXo1S0dDZ0lWNFBHcHFVUUlIMHhKN2dWUEtDbGxDcEJ4djhs?=
 =?utf-8?B?QVdmZ2x3T2hBLytqaDFsQW45NXZydnNZYzgraVdPUXRRcWpZeEVudGRFY0Q4?=
 =?utf-8?B?NzMzVGJsZ0RQRUV3angvTk9kQlI3ZGY1NDMyaUpENVVTTk0rTmdPdStXdGZ5?=
 =?utf-8?B?RFg2cUFLL2RYb1VHQ1Rncmh3bTQ1OEcxbUQ4azhvRXN0aUtVbnlXcVMyaVRx?=
 =?utf-8?B?dWZyQks5bVdpVTNCSkgxKzBhc2tXcmdkcFNlbUNUZHU1U2hhbGVQanYwR2hU?=
 =?utf-8?B?bDVINnMwWGRhS2lITWUrbzVPSmJYS3JmcEdNbUdCMEM4WVRmTVRNOEV5U0I5?=
 =?utf-8?B?bWR2ZFlVUklVWXgwWVVKUFQyZjBqOVdHSnBaSzBkZ3JtRnFJWnpsNmtNbHIv?=
 =?utf-8?B?WE45eVNRVHJnVDNzUE1pYkZlZjJhTXZKL1VJditHRnF3QnZJWUxseGMvS0V6?=
 =?utf-8?B?cEhVTkI0QkJHZzlFL2xiVFM0MzZWb0J3WUhVcmtHMjV4ZGNKVkpyT1BCUjFE?=
 =?utf-8?B?TWJ1M1dzU25QM0xOMDc2WEZ6cFRUSGxaUkttWG5tM1V0b0o2REF0QzVoOTFJ?=
 =?utf-8?B?RnRXN2xmVzc1SHppb1gyeUdBUmZhNUJERldJanhRenJHKzk5ck1nSm5pTTN6?=
 =?utf-8?B?SURPdVVHY0hWOGZkYmpiN0FvMUl3WEQzV3AwTmZjZFlpNW5wLzBNczJ0OWl2?=
 =?utf-8?B?UGZkS2F5UlZxbGVkY2VncmtIL2JBQ1NlMVdMR01BUTQ1VlNVWDY2WlVWdkxm?=
 =?utf-8?B?NjNhU1VzVFd6MXJvM2dXQTJ5YVBORkc4YWk5TThiaG9oVGZXdndnazFUT3k3?=
 =?utf-8?B?U0FnNytBbHkvbUlVM2dUaEQ4RGoxZW5COC9vbXg0TWVnOEFXaDBybEY4RW5G?=
 =?utf-8?B?cUptVXFVMGF4MU5GS1FlMkFydWF6WGtFUDlFZDlIcEVZay9sZjZ3THBnQ3d3?=
 =?utf-8?B?WHMrbXpNTnBpdFZ4ZCtMZFJ1enhGcXhaSGdFT1dVUHllMm1Cb1VWSzFsemNE?=
 =?utf-8?B?dFYwUlRMa1pJQkxmY1gzVTQ1Z1c4VmtIQUJ1ZWZmeCsxRVplMThRcmZKaVNp?=
 =?utf-8?B?T1lZOUlYQStrRDhCbElDaEluR0R5ZGIyeHZRYW5NUmFsd1F1eVJhc21ocVZk?=
 =?utf-8?B?QXFuOWp2b09aajlzMk45ZCtUb2hCaWE3NG1PK2hlcjYrUXhiMDFSVGRTbjJI?=
 =?utf-8?B?QytPQ3NENVVuSGwxd1hkTFR1VHY2NFY5Tzc0SzBHWUFSNlNkNXdZTUdRUjFE?=
 =?utf-8?B?clVBU0VtUFBPOVJORmZFTEs4VTNiWVYzUjlIaWQ5WC9JY3lmaCs4dzlpYVRM?=
 =?utf-8?B?TUh3cFNkTStydDBZVVI4bXZGOHkvSXJyUWNEVkVtL2FveGtFNjhEcVNzeUtC?=
 =?utf-8?B?T04rV3FSZUtWL0Uzdi9Cam5YcjBQSE5uWmFSSlFCMlRFaDB2U0xGeDFPblM2?=
 =?utf-8?B?czlyYTFpOUxPdEZKc1JINTIzMUpVRDMyMWoya3djK0pEMDJHOENUUHo5UHNm?=
 =?utf-8?B?OUdHSHAydjNMYUw4cmpyQ0JSQkxVT1BOUHFvVFhsUHFnc3RTUlJ2Y3B6S0s0?=
 =?utf-8?B?UnlGL0paTVlOd1d0alZhMHozcDhQdnRBeVFuT0prQ1plMlRidjM4SHRNKytY?=
 =?utf-8?B?RXB5TlNyZzEvY1NhZVY0c3dibGE3TmdCVWlWVldQWnBjd0ZxZldjYXI1Tkhs?=
 =?utf-8?B?b2tuNHdrMUw2ZW5zL3VGTEZxN2ZaOTVlNHkzVXdpdFFLbWRtYnJIZGtqK0hE?=
 =?utf-8?B?VDR4eG5NN2w0aStKR3pGbWE5Qlo2K1NNWVE0WXQ2a1l2dHhLZnhOWkZwSysv?=
 =?utf-8?B?RklDbHZocmp6QWs1ZGdSYVZ5amlNWU54L0drbWdrYVFiN3BlWWpUVEh5WGZs?=
 =?utf-8?B?dHM5T0dYNFgrbnBRYVU4ekJYck1YM2VreElzQzM0M0N2aG1DcHIvNDB2ZEhE?=
 =?utf-8?B?RjkyZFRrclJWVk9CSGtaeGlLNEhzMkN6R2d4YUR2QkZMTGREaG9vTUozYmlw?=
 =?utf-8?B?TGFIMDNDRmpOQzAzM2RVa0FFRitsTHJQSEh0RHgwR3g2WnZ0anVUdWZpM3c2?=
 =?utf-8?B?V3VJTHQ4ajl2TlpyZjl6Rm1RekNORzhNUG9qZEZySzBGaGpGWnVoTVQyM2lT?=
 =?utf-8?B?MmhCU2dmWXVkcHdWbDJpQmFsamJLOUZ3TUNWWFRMM1ZWeTdxSzloQWw3WmhD?=
 =?utf-8?B?dkZNQ25kbDU1VGZnQlNGaUNaaXhRa0NwOEFVcThxTEhVZVk2dXhCQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oWNdseF7J7mcfDIoqbbsb6J4/ClPBkjRhSutA4rEC3I93DnLpXmqNkLFr+uJMcU3BNnhZv7yfx14g1mMjkdd4yG2LbATum48m7F0OVdPzLk0MT+VKVH2YJd0zdn/0WgdTu6rX+vLJbqslOwgH6vRbOqDpTnFwf1WbQLAhsU9cENHNWWGaX9Y2+KVo6aNdKWvGdN0h5NWLHF98BeFw4jmWRplg03v8ut9bzTPLgqB4MuCKeO7VOgo519ZTmV7jrlfIkl3db1opLsXPC4f41tR7WcfoERI5g0Zt31dNG/XlwYxofBzaQ3tGtv6ryLFTxSY/VJeN8id0CQWGy6jAk3EgQMK9g6sEiA40ESovUH2CX3C3UHboeD5Eoc+xGDMEgiuqYvhh5PDMiA3YzY/VflgJ10tyghZ47QHuxUNs3Yn4egJJP4cBmMJkPq704IUjCNgO0G0zP8f0CkYxhDsU+4Reu5/sbcUamdlHk6yTizuUREnB6SexK/rg6dGUHlT2VKWFleLzmnlbOl1sKonoGg1exoCl2mbvt4dUNh+HLLi8faRJqTDV/zp7FD9j1JO905C2NXW7SmmnhXrBIqjcOE/13OlJxtDLCE3Y6xllWE8O7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741f0c4e-cb54-4912-4da7-08de5596b8c9
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 07:04:57.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDuLiyopXRcSxPOhmPv/F91X1enBWi367IMjE0qfKPMS7QBo8vtBSlWWfxs07Eaj20V8HZyRXh/RYo1LLj2v3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF40B0653BC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_09,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601170056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDA1NSBTYWx0ZWRfXz1olfF7qiXtj
 9zLv+qT7dRpu+O4xwtmKgjwXRuQcNrWTTYp6RwOo03vJZwZw4JGgZWsnZFcA6wrcltmZAKf3z7A
 XrJ1svwdzdlK/Xnxoc0nRkGGHYF+31i5X94VEDq/UUgOG6ciYKW5ggq4bgc0f4QywhW/UoUCbS8
 0xI782ARGaEqKnHV9SfKwi3CDc7zEMW7+/tR4jBOLf9SXGgL9ZG2Zgv91NE8pLsHkaGXKQSQbPC
 s+FlBQo38e8lHJpCOPqTDSzYAYXrpAJdM3FGe8ngC/xXDBqryGqqB2NPUaRW2ejMQAjw9acPy3G
 wHSfVRU79pxDNnYNNaisR1yXhwAwTjpzvDUDGqQcc8OzuBrQp4/tmGFjHZ03Cx8eHrKxioLN1U5
 O/yWUeTYqJS1cSPYEZnKRsee1SFTum6tmuKb1S1/Arytb7LXHV52+R8WdI099N5tehyd8QC9NFV
 wfUIpzNsxKcBKVxK+kRE5qi20cK9WXTHhWbmSMRI=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696b349d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=spnfHENZsuSXY9qvjIIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13654
X-Proofpoint-ORIG-GUID: TqyMB_Nhb4KCdJOOb3D3_-qFs6tqmf9O
X-Proofpoint-GUID: TqyMB_Nhb4KCdJOOb3D3_-qFs6tqmf9O


On 1/16/26 1:55 PM, Dai Ngo wrote:
>
> On 1/16/26 12:00 PM, Chuck Lever wrote:
>>
>> On Fri, Jan 16, 2026, at 12:15 PM, Dai Ngo wrote:
>>> After the entry in the xarray was marked with XA_MARK_0, xa_insert
>>> will not update the entry when nfsd4_block_get_device_info_scsi is
>>> called again leaving the entry with XA_MARK_0.

I tested the following fix and it works fine:

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 60304bca1bb6..18de3e858106 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -343,14 +343,18 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
         }

         /*
-        * Add the device if it does not already exist in the xarray. This
+        * Add the device if it does not already exist in the xarray. If an
+        * entry already exists for the device, then clear its XA_MARK_0. This
          * logic prevents adding more entries to cl_dev_fences than there
          * are exported devices on the server. XA_MARK_0 tracks whether the
          * device has been fenced.
          */
         ret = xa_insert(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
                         XA_ZERO_ENTRY, GFP_KERNEL);
-       if (ret < 0 && ret != -EBUSY)
+       if (ret == -EBUSY)
+               xa_clear_mark(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
+                               XA_MARK_0);
+       else if (ret < 0)
                 goto out_free_dev;

         ret = ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);

-Dai

>>>
>>> When the server needs to fence the client again, since the entry
>>> still has XA_MARK_0, it skips the fence operation.
>> The mark is cleared only when a pr_unregister is done.
>
> The nfsd server never issues pr_unregister. It uses fence to stop
> client from accessing the device.
>
>>   I didn't think
>> that an additional GETDEVICEINFO should clear an existing registration.
>
> When the client detects I/O error, due to SCSI reservation conflict,
> it retries the I/O to the MDS. On new I/O, the client sends LAYOUTGET
> then GETDEVICEINFO and send I/O to the DS again. This is why the nfsd
> server needs to clear the mark on the xarray entry on GETDEVICEINFO
> in case it needs to fence the client again.
>
> -Dai
>
>>
>> So, did I misunderstand the API contract?
>>
>>
>

